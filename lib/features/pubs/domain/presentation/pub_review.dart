import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/ui_config.dart';
import '../../../../core/database/beer_type.dart';
import '../../../../core/database/providers/review_provider.dart';
import '../../../../core/database/pub_review_with_beers.dart';
import '../entities/beer_entry.dart';
import '../entities/pub.dart';
import 'beer_entry_card.dart';

class PubReview extends ConsumerStatefulWidget {
  final Pub pub;
  final PubReviewWithBeers? review;

  const PubReview({super.key, required this.pub, this.review});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PubReviewState();
}

class _PubReviewState extends ConsumerState<PubReview> {
  bool get isEditing => widget.review != null;
  final _today = DateTime.now();
  late DateTime _selectedDate;
  late List<BeerEntry> _beersWithNotes;
  late double _rating;

  @override
  void initState() {
    super.initState();
    _initializeReview();
  }

  @override
  void dispose() {
    for (var entry in _beersWithNotes) {
      entry.notesController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? UIPubReviewConfig.appBarEditingText
              : UIPubReviewConfig.appBarNewReviewText,
        ),
        actions: [IconButton(onPressed: _save, icon: const Icon(Icons.save))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIPubReviewConfig.reviewsHorizontalPadding,
            vertical: UIPubReviewConfig.reviewsVerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: _selectDate,
                    label: Text(DateFormat.yMMMd().format(_selectedDate)),
                    icon: const Icon(Icons.calendar_today),
                  ),
                ],
              ),
              const Text(
                UIPubReviewConfig.addBeersText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: UIPubReviewConfig.addBeersFontSize,
                ),
              ),
              const SizedBox(height: UIPubReviewConfig.sizedBoxheight),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => BeerEntryCard(
                  beerEntry: _beersWithNotes[index],
                  onTypeChanged: (type) => _onTypeChanged(index, type),
                  onRemove: () => _onRemove(index),
                ),
                itemCount: _beersWithNotes.length,
              ),

              const SizedBox(height: UIPubReviewConfig.sizedBoxheight),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _beersWithNotes.add(BeerEntry(beerType: BeerType.lager));
                  });
                },
                label: const Text(UIPubReviewConfig.addNewBeerText),
                icon: const Icon(Icons.add),
              ),
              const SizedBox(height: UIPubReviewConfig.sizedBoxheight),
              const Text(
                UIPubReviewConfig.ratingTextField,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: UIPubReviewConfig.addBeersFontSize,
                ),
              ),
              RatingBar.builder(
                initialRating: _rating,
                minRating: UIPubReviewConfig.ratingMinValue,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: UIPubReviewConfig.ratingMaxValue.toInt(),
                itemBuilder: (context, _) => Icon(Icons.star),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initializeReview() {
    if (isEditing) {
      _selectedDate = widget.review!.review.visitDate;
      _rating = widget.review!.review.rating;
      _beersWithNotes = widget.review!.beers
          .map((beer) => BeerEntry(beerType: beer.beerType, notes: beer.notes))
          .toList();
    } else {
      _selectedDate = _today;
      _rating = UIPubReviewConfig.ratingMaxValue;
      _beersWithNotes = [BeerEntry(beerType: BeerType.lager)];
    }
  }

  void _onTypeChanged(int index, BeerType? type) {
    if (type != null) {
      setState(() {
        final oldBeer = _beersWithNotes[index];
        _beersWithNotes[index] = oldBeer.copyWith(beerType: type);
        oldBeer.notesController.dispose();
      });
    }
  }

  void _onRemove(int index) {
    setState(() {
      _beersWithNotes[index].notesController.dispose();
      _beersWithNotes.removeAt(index);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? datePicker = await showDatePicker(
      context: context,
      firstDate: UIPubReviewConfig.firstDate,
      lastDate: _today,
      initialDate: _selectedDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (datePicker != null && datePicker != _selectedDate) {
      setState(() => _selectedDate = datePicker);
    }
  }

  Future<void> _save() async {
    final repository = await ref.read(reviewRepositoryProvider.future);

    await repository.saveReview(
      isEditing: isEditing,
      pubId: widget.pub.id!,
      reviewId: widget.review?.review.id,
      visitDate: _selectedDate,
      rating: _rating,
      beers: _beersWithNotes,
    );

    ref.invalidate(pubReviewsProvider(widget.pub.id!));
    ref.invalidate(beerTypeCountProvider);

    if (mounted) {
      context.pop();
    }
  }
}
