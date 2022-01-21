import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/connectivity/connectivity_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/ui/detail_movie/detail_movie_page.dart';
import 'package:majootestcase/ui/extra/custom_drawer.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
  final List<Data>? data;

  const HomeBlocLoadedScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        return Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Majoo Test",
              style: TextStyle(color: Colors.black),
            ),
          ),
          floatingActionButton: (state is OnDisconnected)
              ? FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: () =>
                      context.read<HomeBlocCubit>().fetching_data(),
                )
              : null,
          body: ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return movieItemWidget(data![index], context);
            },
          ),
        );
      },
    );
  }

  Widget movieItemWidget(Data data, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMoviePage(movie: data),
            ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.network(data.i!.imageUrl!),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(data.l!, textDirection: TextDirection.ltr),
            )
          ],
        ),
      ),
    );
  }
}
