import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/services/api_service.dart';

part 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  HomeBlocCubit() : super(HomeBlocInitialState());

  void fetching_data() async {
    emit(HomeBlocInitialState());

    // if(movieResponse==null){

    // }else{
    try {
      ApiServices apiServices = ApiServices();
      MovieResponse movieResponse = await apiServices.getMovieList();
      emit(HomeBlocLoadedState(movieResponse.data!));
    } catch (e) {
      emit(HomeBlocErrorState("Error Unknown"));
    }
    // }
  }
}
