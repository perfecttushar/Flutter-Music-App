import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/theme/themeprovider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //
              //
              const SizedBox(height: 80),
              //
              //
              Center(
                child: Image.asset(
                  'assets/image/logo.png',
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "BeatBurst",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              //
              //
              const SizedBox(height: 60),
              //
              //
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  child: ListTile(
                    iconColor: Theme.of(context).colorScheme.inversePrimary,
                    title: Text(
                      "Home",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    leading: const Icon(Icons.home_rounded),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),

              //
              const SizedBox(height: 20),
              //

              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  child: ListTile(
                    iconColor: Theme.of(context).colorScheme.inversePrimary,
                    title: Text(
                      "Dark Mode",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    leading: const Icon(Icons.brightness_4_rounded),
                    trailing: Transform.scale(
                      alignment: Alignment.centerRight,
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value:
                            Provider.of<ThemeProvider>(context, listen: false)
                                .isDarkMode,
                        onChanged: (value) =>
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme(),
                      ),
                    ),
                  ),
                ),
              ),

              //
              //
              const SizedBox(height: 300),
              //
              //
              Center(
                child: Text(
                  "© Crafted By Tushar Suryavanshi",
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
