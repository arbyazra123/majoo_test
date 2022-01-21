import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              height: 50,
              child: TextButton(
                onPressed: () {
                  context.read<AuthBlocCubit>().logout();
                },
                child: Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
