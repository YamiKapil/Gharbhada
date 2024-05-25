import 'package:flutter/material.dart';
import 'package:gharbhada/features/auth/services/notification_service.dart';
import 'package:gharbhada/models/notification_model.dart';
import 'package:gharbhada/widgets/loader.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel>? notificaitonList;
  final NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    fetchNotificaiton();
  }

  fetchNotificaiton() async {
    notificaitonList =
        await notificationServices.fetchNotification(context: context);
    print('Fetched properties: $notificaitonList');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaiton Screen'),
      ),
      body: notificaitonList == null
          ? Loader()
          : notificaitonList!.length == 0
              ? Center(
                  child: Text('Opps!, no notification found'),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20);
                  },
                  itemCount: notificaitonList!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(notificaitonList?[index].message ?? ''),
                      subtitle: Text(
                          "${notificaitonList?[index].name ?? ''}, ${notificaitonList?[index].location ?? ''} "),
                    );
                  },
                ),
    );
  }
}
