import 'package:geolocator/geolocator.dart';
import 'package:huracan/blocs/location_bloc/location_event.dart';
import 'package:huracan/blocs/location_bloc/location_state.dart';
import 'package:bloc/bloc.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  @override
  LocationState get initialState => LocationEmpty();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is FetchLocation) {
      yield LocationLoading();
      try {
        final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
        final lastKnownPosition = await geolocator.getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
        final position = lastKnownPosition ?? await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        final place = await geolocator.placemarkFromPosition(position);
        LocationState state = place.isNotEmpty
            ? LocationLoaded(position: position, place: place[0].locality + ", "+ place[0].country, isoCountryCode: place[0].isoCountryCode)
            : LocationError();
        yield state;
      } catch (error) {
        yield LocationError();
      }
    }
  }
}
