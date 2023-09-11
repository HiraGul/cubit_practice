import 'package:cubit_practice/UserCubit/user_cubit.dart';
import 'package:cubit_practice/cubit/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Loaded')));
          }
          if (state is UserLoading) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Loading')));
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserNoInternet) {
            return Center(child: Text('No Internet'));
          }
          if (state is UserException) {
            return Center(child: Text(state.error));
          }
          if (state is UserLoaded) {
            return UserDataController.userModelClass!.data.isEmpty
                ? const Text("Empty")
                : ListView.builder(
                    itemCount: UserDataController.userModelClass!.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Text(UserDataController
                            .userModelClass!.data[index].firstName),
                      );
                    });
          }
          return Container();
        },
      ),
    );
  }
}
