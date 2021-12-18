import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'autocomplete_model.dart';
import 'autocomplete_repo.dart';

class AutoSearch extends SearchDelegate<Prediction> {
  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, const Prediction(predictionPoints: [], predictionLocationsPlace: [], predictionLocationsDescription: []));
        } else {
          query = '';
          showSuggestions(context);
        }
      },
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, const Prediction(predictionPoints: [], predictionLocationsPlace: [], predictionLocationsDescription: [])),
    );


  @override
  Widget buildResults(BuildContext context) => Container(
    child: FutureBuilder<Prediction?>(
      future: AutocompleteRepository().getPredictions(query: query),
      builder: (context, snapshot) {
        return buildPredictionsSuccess(snapshot.data);
      },

    ),
  );

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.white,
        child: FutureBuilder<Prediction?>(
          future: AutocompleteRepository().getPredictions(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoPredictions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data!.predictionPoints.isEmpty) {
                  return buildNoPredictions();
                } else {
                  return buildPredictionsSuccess(snapshot.data);
                }
            }
          },

        ),
      );


  Widget buildNoPredictions() => const Center(
    child: Text(
      'No suggestions!',
      style: TextStyle(fontSize: 28, color: Colors.white),
    ),
  );

  Widget buildPredictionsSuccess(Prediction? predictions) => ListView.builder(
    itemCount: 5,
    itemBuilder: (context, index) {
      late LatLng predictionPoint = predictions!.predictionPoints[index];
      late String? predictionPlace = predictions!.predictionLocationsPlace[index];
      late String? predictionDescription = predictions!.predictionLocationsDescription[index];

      return ListTile(
        onTap: () {
          query = predictionPlace;
          close(context, Prediction(predictionPoints: [predictionPoint], predictionLocationsPlace: [predictionPlace], predictionLocationsDescription: [predictionDescription]));
        },
        leading: const Icon(Icons.location_city),
        title: Text(predictionPlace),
        subtitle: Text(predictionDescription),

      );
    },
  );
}
