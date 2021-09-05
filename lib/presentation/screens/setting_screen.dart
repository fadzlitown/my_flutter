import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practices/logic/setting_cubit.dart';
import 'package:flutter_practices/logic/setting_state.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade700,
          title: Text('Setting'),
        ),
        body: BlocListener<SettingCubit, SettingState>(
            listener: (context, state) {
          final notificationSnackBar = SnackBar(
            duration: Duration(milliseconds: 700),
            content: Text(
              'App ' +
                  state.appNotification.toString().toUpperCase() +
                  ', Email ' +
                  state.emailNotification.toString().toUpperCase(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
        }, child: BlocBuilder<SettingCubit, SettingState>(
                builder: (builderContext, state) {
          return Container(
            child: Column(
              children: [
                SwitchListTile(
                  value: state.appNotification,
                  onChanged: (newVal) {
                    builderContext
                        .read<SettingCubit>()
                        .toggleAppNotification(newVal);
                  },
                  title: Text('App Notification'),
                ),
                SwitchListTile(
                  value: state.emailNotification,
                  onChanged: (newVal) {
                    builderContext
                        .read<SettingCubit>()
                        .toggleEmailNotification(newVal);
                  },
                  title: Text('Email Notification'),
                )
              ],
            ),
          );
        })));
  }
}
