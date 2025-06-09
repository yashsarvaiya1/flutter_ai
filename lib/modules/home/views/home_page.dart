import 'package:api_demo/core/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "A P I s",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Flexible(
                child: GridView.builder(
                  itemCount: AppRoutes.pages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 100,
                  ),
                  itemBuilder: (_, item) {
                    final pageItem = AppRoutes.pages[item];
                    final page = pageItem.name;
                    return GestureDetector(
                      onTap: () {
                        if (page == "/home") {
                          Get.snackbar("message", "You are on Home Page");
                        } else {
                          Get.toNamed(page);
                        }
                      },
                      child: Container(
                        height: 300,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            page.replaceAll('/', ""),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
