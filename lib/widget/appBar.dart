import 'package:flutter/material.dart';
import 'package:oscapp/models/fetch_dataprovider.dart';
import 'package:oscapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String login;
  final VoidCallback onMenuPressed;
  final bool isDrawerVisible;

  const CustomAppBar({
    super.key,
    required this.login,
    required this.onMenuPressed,
    required this.isDrawerVisible,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final notificationProvider =
        Provider.of<FetchDataProvider>(context); // Access the provider

    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = screenHeight / 10;

    return AppBar(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey[50],
      leading: Container(),
      flexibleSpace: Container(
        padding: EdgeInsets.only(top: appBarHeight * 0.58, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: onMenuPressed,
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  isDarkMode
                                      ? const Color(0xFF36C18B)
                                      : const Color(0xFF36C18B),
                                  isDarkMode
                                      ? const Color(0xFF36C18B)
                                      : const Color(0xFF36C18B),
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 32,
                              child: Text(
                                'Hello, $login',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF121212),
                                ),
                              ),
                            ),
                            const Text(
                              "Manage your Power",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      size: 22,
                    ),
                    color: isDarkMode ? Colors.white : Colors.grey[600],
                    onPressed: () async {
                      await notificationProvider
                          .fetchNotifications(); // Fetch notifications from API
                      showDialog(
                        context: context,
                        builder: (context) {
                          final notifications =
                              notificationProvider.notifications;
                          return AlertDialog(
                            title: const Text("Notifications"),
                            content: notifications.isNotEmpty
                                ? SizedBox(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: notifications.length,
                                      itemBuilder: (context, index) {
                                        final notification =
                                            notifications[index];
                                        return ListTile(
                                          title: Text(notification['titre']),
                                          subtitle:
                                              Text(notification['subject']),
                                        );
                                      },
                                    ),
                                  )
                                : const Text("Aucune notification disponible."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("Fermer"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    final screenHeight = WidgetsBinding.instance.window.physicalSize.height;
    final appBarHeight = screenHeight / 32;
    return Size.fromHeight(appBarHeight);
  }
}
