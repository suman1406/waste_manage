import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin/admin_login.dart';
import 'contributor/contributor_login.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFF2A2929)),
          child: Stack(
            children: [
              Positioned(
                left: screenWidth * 0.29,
                top: screenHeight * 0.29,
                child: Container(
                  width: screenWidth * 0.473,
                  height: screenHeight * 0.423,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.106,
                        child: Transform(
                          transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.79),
                          child: Container(
                            width: screenWidth * 0.333,
                            height: screenWidth * 0.333,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF89C5F1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ContributorScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.124,
                        top: screenHeight * 0.093,
                        child: SizedBox(
                          width: screenWidth * 0.239,
                          height: screenHeight * 0.032,
                          child: Text(
                            'Contributor',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.040,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.319,
                        child: Transform(
                          transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.79),
                          child: Container(
                            width: screenWidth * 0.333,
                            height: screenWidth * 0.333,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF71EE66),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AdminScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.170,
                        top: screenHeight * 0.308,
                        child: SizedBox(
                          width: screenWidth * 0.144,
                          height: screenHeight * 0.032,
                          child: Text(
                            'Admin',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.040,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.17,
                top: screenHeight * 0.123,
                child: SizedBox(
                  width: screenWidth * 0.914,
                  height: screenHeight * 0.086,
                  child: Text(
                    'Waste Management',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: screenWidth * 0.07,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.34,
                top: screenHeight * 0.24,
                child: SizedBox(
                  width: screenWidth * 0.914,
                  height: screenHeight * 0.086,
                  child: Text(
                    'Sign in as',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: screenWidth * 0.07,
                    ),
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
