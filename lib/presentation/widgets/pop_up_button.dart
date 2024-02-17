import 'package:best_quotes/presentation/widgets/devloper.dart';
import 'package:flutter/material.dart';

class PopUpButton extends StatelessWidget {
  const PopUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text('Shere'),
            onTap: () {},
          ),
          PopupMenuItem(
            child: Text('Copy Link'),
            onTap: () {},
          ),
          PopupMenuItem(
            child: Text('Menu'),
            onTap: () {},
          ),
          PopupMenuItem(
            child: Text('Settings'),
            onTap: () {},
          ),
          PopupMenuItem(
            child: Text('Developer Information'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeveloperInfo(),
                  ));
            },
          ),
        ];
      },
    );
  }
}
