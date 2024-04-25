import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';
import 'package:project_v/widgets/Layout/footer.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.4),
        elevation: 4,
        toolbarHeight: 80,
        centerTitle: true,
        title: Image.asset(
          AppConstants.logoImagePath,
          width: 40,
          height: 40,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Text(
            "About Us",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                // Background image container
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/AboutUsBG.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                // SingleChildScrollView widget on top of the background
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: Colors.white, // Add white color for the border
                            width: 2, // Set the width of the border
                          ),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Valdopeña Optical Shop",
                                style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 15), // Adjust the height as needed
                            // Add the image below the text
                            Center(
                              child: Image.asset(
                                "assets/images/Valdo_LOGO.png",
                                width: 190, // Set the width as needed
                                height: 189, // Set the height as needed
                              ),
                            ),
                            SizedBox(height: 15), // Add some space between the image and text
                            // Center the text below the image
                            Center(
                              child: Text(
                                "Welcome to Valdopeña Optical Shop, your trusted destination for premium eyewear solutions. At Valdopeña, we blend expertise with a passion for vision care to provide a personalized and seamless optical experience.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ), // Adjust the font size
                                textAlign: TextAlign.center, // Center the text horizontally
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.0), // space between the image and the new container
                      // Our Community
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.white, // Add white color for the border
                              width: 2, // Set the width of the border
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Our Community",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Our Community Contents
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.white, // Add white color for the border
                              width: 2, // Set the width of the border
                            ),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "At the heart of Valdopeña Optical Shop is a commitment to enhancing your vision and style. With a focus on quality, precision, and innovation, we bring you a curated collection of optical lenses that not only correct your vision but also reflect your unique personality.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 40.0), // space between the image and the new container
                      // Expert Craftsmanship
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.black, // Add white color for the border
                              width: 2, // Set the width of the border
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Expert Craftsmanship",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Expert Craftsmanship Contents
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.black, // Add white color for the border
                              width: 2, // Set the width of the border
                            ),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Backed by a team of skilled opticians and optical specialists, Valdopeña ensures that every lens meets the highest standards of craftsmanship. Our dedication to precision and detail guarantees eyewear that not only looks great but also optimizes your visual clarity.",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0), // space between the image and the new container
                      // Visit Us Today
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.white, // Add white color for the border
                              width: 2, // Set the width of the border
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Visit Us Today!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Visit Us Today Contents
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.white, // Add white color for the border
                              width: 2, // Set the width of the border
                            ),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Embark on a journey to clearer vision and stylish eyewear. Visit Valdopeña Optical Shop and experience the perfect fusion of expertise, innovation, and personalized service. Your vision is our focus, and we are here to redefine the way you see the world."
                                      "\n\nContact Info: +63-950 441 0844"
                                      "\n\nSysco Building, 770 Rizal Avenue Street, "
                                      "\nSta. Cruz 1001 Manila, Philippines",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buildFooter(
            [false, false, false, false, true],
            context,
          ),
        ],
      ),
      // Call the method using the instance
    );
  }
}
