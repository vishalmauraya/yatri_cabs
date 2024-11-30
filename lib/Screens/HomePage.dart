import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CustomCards.dart';
import 'package:intl/intl.dart';
import 'SliderAdds.dart';
import 'package:yatri_cabs/main.dart';
import 'package:badges/badges.dart' as badges;


class HomeScreen extends ConsumerWidget {

  @override
  bool isValidDate(DateTime date1, DateTime date2) {
    return date2.isAfter(date1) || date2.isAtSameMomentAs(date1);
  }
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Access Providers
    final tripMode = ref.watch(tripModeProvider);
    final tripType = ref.watch(tripTypeProvider);
    final airtripType=ref.watch(airtripTypeProvider);
    final showRoundTripDetails = ref.watch(roundTripDetailsProvider);
    final notificationCount = ref.watch(notificationCountProvider);



    //DateTime Formate
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(now);

    final fromDate = ref.watch(fromDateProvider);
    final toDate = ref.watch(toDateProvider);

    // Date format method
    String formatDate(DateTime? date) {
      return date == null
          ? "DD-MM-YYYY"
          : "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
    }


    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth*0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/companyLogo.png"),
                      Stack(
                        children: [
                          buildBadgeIcon(3, 'assets/images/NotificationIcon.png'),


                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Tagline Section
              Padding(
                padding:  EdgeInsets.only(left:screenWidth*0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "India's Leading",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.022,
                              color: Colors.white)),
                    ),
                    Text(
                      " Inter-City",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.022,
                              color: const Color(0xff38b000))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left:screenWidth*0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "One Way",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.022,
                              color: Colors.green)),
                    ),
                    Text(
                      " Cab Service Provider",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.022,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),

              // Advertisement Banner
              AdSlider(),

              SizedBox(height: screenHeight * 0.03),

              // Trip Type Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTripButton(
                      context,
                      ref,
                      "Outstation Trip",
                      tripMode,
                      SvgPicture.asset(
                        "assets/VectorIcon/Location.svg",
                      )
                  ),
                  _buildTripButton(
                      context,
                      ref,
                      "Local Trip",
                      tripMode,
                      SvgPicture.asset(
                        "assets/VectorIcon/local.svg",
                      )),
                  _buildTripButton(
                      context,
                      ref,
                      "Airport Transfer",
                      tripMode,
                      SvgPicture.asset(
                        "assets/VectorIcon/airTrio.svg",
                      )),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),

              // Outstation Trip
              if(tripMode=="Outstation Trip")Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTypeButton(context, ref, "One-way", tripType,false),
                  _buildTypeButton(context, ref, "Round Trip", tripType,true),
                ],
              ),
              // Input Fields Section
              if (tripMode=="Outstation Trip" && showRoundTripDetails)
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.02),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildInputField(
                            pickupCityProvider,
                            Key("CardRoundTrip_City"),
                            "assets/Icon_images/CrossIcon.png",
                            true,
                            context,
                            TextInputType.text,
                            ref,
                            "Type City Name",
                            "Pickup City",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onewayLocation.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),false,false),
                        _buildInputField(
                          pickupCityProvider,
                            Key("CardRoundTrip_CityDestination"),
                            "assets/Icon_images/plus.png",
                            true,
                            context,
                            TextInputType.text,
                            ref,
                            "Type City Name",
                            "Destination",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onewayDrop.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),false,false),
                        _buildInputField(
                          pickupTimeProvider,
                            Key("CardRoundTrip_Time"),
                            "assets/Icon_images/CrossIcon.png",
                            false,
                            context,
                            TextInputType.datetime,
                            ref,
                            "HH:MM",
                            "Time",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/ReverseTime.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),false,true),
                        Padding(
                          padding:  EdgeInsets.only(top: screenHeight*0.01,bottom: screenHeight*0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // From Date
                              Column(
                                children: [
                                  Text(
                                    "From Date",
                                    style: GoogleFonts.roboto(textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () async {
                                      DateTime? selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: fromDate ?? DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                       if (selectedDate != null) {
                                       // Check if fromDate is not null before comparison
                                           if (toDate != null && selectedDate.isAfter(toDate!)) {
                                        // Show error if To Date is smaller than From Date
                                           ScaffoldMessenger.of(context).showSnackBar(
                                           SnackBar(
                                           content: Text("To Date cannot be earlier than From Date"),
                                            backgroundColor: Colors.red,
                                           ),
                                            );
                                           } else {
                                            ref.read(toDateProvider.notifier).state = selectedDate;
                                          }
                                        }
                                    },
                                    child: Text(
                                        formatDate(fromDate),
                                        style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 16, color: Colors.black),)
                                    ),
                                  ),
                                ],
                              ),

                              // Calendar Icon
                              CircleAvatar(
                                  backgroundColor: Colors.green.shade100,
                                  radius: 25,
                                  child: Image.asset("assets/Icon_images/roundCal.png")
                              ),

                              // To Date
                              Column(
                                children: [
                                  Text(
                                    "To Date",
                                    style: GoogleFonts.roboto(textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () async {
                                      DateTime? selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: toDate ?? DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                      if (selectedDate != null) {
                                      // Check if fromDate is not null before comparison
                                        if (fromDate != null && selectedDate.isBefore(fromDate!)) {
                                      // Show error if To Date is smaller than From Date
                                        ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("To Date cannot be earlier than From Date"),
                                          backgroundColor: Colors.red,
                                         ),
                                      );
                                        } else {
                                        ref.read(toDateProvider.notifier).state = selectedDate;
                                                                                }
                                      }

                                    },
                                    child: Text(
                                        formatDate(toDate),
                                        style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 16, color: Colors.black),)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.all(screenWidth*0.01),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:screenWidth*0.1,vertical: screenHeight*0.01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff38b000)
                            ),

                            child: TextButton(onPressed: (){}, child: Text("Explore Cabs",
                              style: GoogleFonts.poppins(textStyle:
                              TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth*0.040)
                              ),)
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              if(tripMode=="Outstation Trip" && !showRoundTripDetails)
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.02),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildInputField(
                          pickupCityProvider,
                            Key("CardOneWayTrip_City"),
                            "assets/Icon_images/CrossIcon.png",
                            true,
                            context,
                            TextInputType.text,
                            ref,
                            "Type City Name",
                            "Pick-up City",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onewayLocation.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),false,false),
                        _buildInputField(
                            pickupCityProvider,
                            Key("CardOneWayTrip_CityDestiantion"),
                            "assets/Icon_images/CrossIcon.png",
                            true,
                            context,
                            TextInputType.text,
                            ref,
                            "Type City Name",
                            "Destination",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onewayDrop.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),false,false),
                        _buildInputField(
                            pickupTimeProvider,
                            Key("CardOneWayTrip_Date"),
                            "assets/Icon_images/CrossIcon.png",
                            false,
                            context,
                            TextInputType.datetime,
                            ref,
                            "DD-MM-YYYY",
                            "Pick-up Date",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onwayCalander.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),true,false),
                        _buildInputField(
                             pickupTimeProvider,
                            Key("CardOneWayTrip_Time"),
                            "assets/Icon_images/CrossIcon.png",
                            false,
                            context,
                            TextInputType.datetime,
                            ref,
                            "HH:MM",
                            "Time",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onewayTime.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),false,true),
                        Padding(
                          padding: EdgeInsets.only(top:screenWidth*0.01),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:screenWidth*0.1,vertical: screenHeight*0.01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff38b000)
                            ),

                            child: TextButton(onPressed: (){}, child: Text("Explore Cabs",
                              style: GoogleFonts.poppins(textStyle:
                              TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth*0.040)
                              ),)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              //Local Trip
              if(tripMode=="Local Trip")Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.02),
                    child: Container(
                      padding:EdgeInsets.all(screenWidth*0.04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildInputField(
                               pickupCityProvider,
                              Key("CardLocalTrip_City"),
                              "assets/Icon_images/CrossIcon.png",
                              true,
                              context,
                              TextInputType.text,
                              ref,
                              "Type City Name",
                              "Pickup City",
                              pickupDateProvider,
                              Image.asset("assets/Icon_images/onewayLocation.png",
                                width: screenWidth * 0.1, height: screenHeight *
                                    0.05,),false,false),
                          _buildInputField(
                            pickupTimeProvider,
                              Key("CardLocalTrip_Date"),
                              "assets/Icon_images/plus.png",
                              true,
                              context,
                              TextInputType.datetime,
                              ref,
                              formatted,
                              "Pickup Date",
                              pickupDateProvider,
                              Image.asset("assets/Icon_images/calendericon.png",
                                width: screenWidth * 0.1, height: screenHeight *
                                    0.05,),true,false),

                          _buildInputField(
                            pickupTimeProvider,
                              Key("CardLocalTrip_Time"),
                              "assets/Icon_images/CrossIcon.png",
                              false,
                              context,
                              TextInputType.datetime,
                              ref,
                              "HH:MM",
                              "Time",
                              pickupDateProvider,
                              Image.asset("assets/Icon_images/ReverseTime.png",
                                width: screenWidth * 0.1, height: screenHeight *
                                    0.05,),false,true),

                          Padding(
                            padding:  EdgeInsets.only(bottom:screenWidth*0.01),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal:screenWidth*0.1,vertical: screenHeight*0.01),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xff38b000)
                              ),

                              child: TextButton(onPressed: (){}, child: Text("Explore Cabs",
                                style: GoogleFonts.poppins(textStyle:
                                TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth*0.040)
                                ),)
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //Airport Transfer
              if(tripMode=="Airport Transfer")Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTypeButtonair(context, ref, "To The Airport", airtripType,false),
                  _buildTypeButtonair(context, ref, "From The Airport", airtripType,true),
                ],
              ),
              // Input Fields Section
              if (tripMode=="Airport Transfer" && airtripType=="To The Airport")
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.02),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildInputFieldAir(
                            Key("CardToTheAirport_City"),
                            "assets/Icon_images/CrossIcon.png",
                            true,
                            context,
                            TextInputType.text,
                            ref,
                            "Type City Name",
                            "Pickup City",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onewayLocation.png",width: screenWidth * 0.1, height: screenHeight * 0.05,)
                            ,false,false),
                        _buildInputFieldAir(
                            Key("CardToTheAirport_Date"),

                            "assets/Icon_images/CrossIcon.png",
                            false,
                            context,
                            TextInputType.text,
                            ref,
                            "DD-MM-YYYY",
                            "Pickup Date",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/calendericon.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),true,false),

                        _buildInputFieldAir(
                            Key("CardToTheAirport_Time"),
                            "assets/Icon_images/CrossIcon.png",
                            false,
                            context,
                            TextInputType.datetime,
                            ref,
                            "HH:MM",
                            "Time",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onewayTime.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),false,true),

                        Padding(
                          padding: EdgeInsets.only(top:screenWidth*0.01),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:screenWidth*0.1,vertical: screenHeight*0.01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff38b000)
                            ),

                            child: TextButton(onPressed: (){}, child: Text("Explore Cabs",
                              style: GoogleFonts.poppins(textStyle:
                              TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth*0.040)
                              ),)
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              if(tripMode=="Airport Transfer" && airtripType=="From The Airport")
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenHeight * 0.02),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildInputFieldAir(
                          Key("CardFromAirport_City"),
                            "assets/Icon_images/CrossIcon.png",
                            true,
                            context,
                            TextInputType.text,
                            ref,
                            "Type City Name",
                            "Pickup Airport",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onewayLocation.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),false,false),
                        _buildInputFieldAir(
                            Key("CardFromAirport_Date"),
                            "assets/Icon_images/CrossIcon.png",
                            false,
                            context,
                            TextInputType.text,
                            ref,
                            "DD-MM-YYYY",
                            "Pickup Date",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/calendericon.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),true,false),

                        _buildInputFieldAir(
                            Key("CardFromAirport_Time"),
                            "assets/Icon_images/CrossIcon.png",
                            false,
                            context,
                            TextInputType.datetime,
                            ref,
                            "HH:MM",
                            "Time",
                            pickupDateProvider,
                            Image.asset("assets/Icon_images/onewayTime.png",
                              width: screenWidth * 0.1, height: screenHeight *
                                  0.05,),false,true),

                        Padding(
                          padding:  EdgeInsets.only(top:screenWidth*0.01),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal:screenWidth*0.1,vertical: screenHeight*0.01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff38b000)
                            ),

                            child: TextButton(onPressed: (){}, child: Text("Explore Cabs",
                              style: GoogleFonts.poppins(textStyle:
                              TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth*0.040)
                              ),)
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),

              // Footer Advertisement
              Image.asset("assets/images/serviceAdds.png",),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),

    );
  }

// Reuse the helper methods for Trip/Type buttons and Input Fields (as previously written).

  Widget _buildTypeButton(
      BuildContext context, WidgetRef ref, String title, String selectedType, bool isRoundTrip) {
    return GestureDetector(
      onTap: () {
        ref.read(tripTypeProvider.notifier).state = title;
        if (isRoundTrip) {
          ref.read(roundTripDetailsProvider.notifier).state = true;
        } else {
          ref.read(roundTripDetailsProvider.notifier).state = false;
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.1),
        decoration: BoxDecoration(
          color: selectedType == title ? const Color(0xff38b000) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff38b000), width: 2),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: selectedType == title ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  Widget _buildTypeButtonair(
      BuildContext context, WidgetRef ref, String title, String selectedType, bool isRoundTrip) {
    return GestureDetector(
      onTap: () {
        ref.read(airtripTypeProvider.notifier).state = title;
        if (isRoundTrip) {
          ref.read(toTheAirportProvider.notifier).state = true;
        } else {
          ref.read(toTheAirportProvider.notifier).state = false;
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.08),
        decoration: BoxDecoration(
          color: selectedType == title ?const Color(0xff38b000) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff38b000), width: 2),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: selectedType == title ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildTripButton(BuildContext context, WidgetRef ref, String title, String selectedMode, SvgPicture icon) {
    return GestureDetector(
      onTap: () {
        if (ref.read(tripModeProvider) != title) {
          // Update only if a different trip mode is selected
          ref.read(tripModeProvider.notifier).state = title;
          // Reset round trip details or other mode-specific states
          ref.read(tripTypeProvider.notifier).state = "One-way";
          ref.read(airtripTypeProvider.notifier).state="To The Airport";
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: selectedMode == title ? const Color(0xff38b000) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Center(
              child: ColorFiltered(
                colorFilter: selectedMode == title
                    ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                    : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                child: icon,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: selectedMode == title ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.023,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




  Widget _buildInputField(StateProvider<String?> provider,Key id,String img,bool crossicon,BuildContext context, TextInputType keyboardType, WidgetRef ref, String hint, String placeholder, StateProvider textprovider, Image icon,bool Date_bool,bool Time_bool,) {
    final TextEditingController textController = TextEditingController();
    void handleCrossPress() {
      textController.clear();
      ref.read(provider.notifier).state = null;
    }
    return Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.025,
            right: MediaQuery.of(context).size.width * 0.025,
            bottom: MediaQuery.of(context).size.height* 0.01),
        child: CustomCard(
          provider: provider,
          textController: textController,

          key: id,
          img: img,
          iconcross: crossicon,
          title: placeholder,
          hint: hint,
          leadingIcon: icon,
          keyboard: keyboardType,
          onCrossPressed: handleCrossPress,
          isDateInput: Date_bool,
          isTimeInput: Time_bool,

        ));
  }
  Widget _buildInputFieldAir(
     Key key,
     String img,
     bool crossicon,
     BuildContext context,
     TextInputType keyboardType,
     WidgetRef ref,
   String hint,
     String placeholder,
     StateProvider<String?> provider,
     Image icon,
     bool Date_bool,
     bool Time_bool,
  ) {
    // Create a TextEditingController for this input field
    final textController = TextEditingController(
      text: ref.read(provider), // Initialize with the current provider's state
    );

    void handleCrossPress() {
      textController.clear(); // Clear the text in the input field
      ref
          .read(provider.notifier)
          .state = null; // Reset the state in the provider
    }

    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery
            .of(context)
            .size
            .width * 0.025,
        right: MediaQuery
            .of(context)
            .size
            .width * 0.025,
        bottom: MediaQuery
            .of(context)
            .size
            .height * 0.01,
      ),
      child: CustomCard(
        provider: provider,
        textController: textController,
        key: key,
        img: img,
        iconcross: crossicon,
        title: placeholder,
        onCrossPressed: handleCrossPress,
        // Attach the clear function
        hint: hint,
        leadingIcon: icon,
        keyboard: keyboardType,
        isDateInput: Date_bool,
        isTimeInput: Time_bool,

        // Pass the controller to CustomCard
      ),
    );
  }

  Widget buildBadgeIcon(int notificationCount, String imagePath) {
    return badges.Badge(
      position: badges.BadgePosition.center(),
      badgeStyle: const badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: Colors.red, // Customize badge color
      ),
      showBadge: notificationCount > 0, // Only show badge if notificationCount > 0
      badgeContent: const SizedBox(), // No text or content in the badge
      child: Image.asset(
        imagePath,

      ),
    );
  }


}