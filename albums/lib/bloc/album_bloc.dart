import 'package:albums/bloc/event_state.dart';
import 'package:albums/network/albums_model.dart';
import 'package:albums/network/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumBloc extends Bloc<FetchDataEvent, AlbumState> {
  AlbumBloc(super.initialState){
    on<FetchAlbumsEvent>((event, emit) async {
      emit(LoadingState());
      /*List<AlbumsModel> userCredential = await ApiService().fetchAlbums("");
      emit(SignInSuccessState(userCredential.user?.displayName, userCredential.user?.email));
   */
    });
  }



}