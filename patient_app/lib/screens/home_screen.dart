import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import '../controllers/auth_controller.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {

    final controller = Provider.of<AuthController>(context);
    final patient = controller.currentPatient;


    return Scaffold(

      backgroundColor: const Color(0xffF7F9FC),


      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xff2455F4),

        unselectedItemColor: Colors.grey,

        backgroundColor: Colors.white,

        elevation: 8,


        onTap: (value){

          setState(() {
            _selectedIndex = value;
          });

        },


        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Appointments",
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: "Reports",
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: "Treatments",
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),

        ],

      ),



      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),


          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,


            children: [



              // ================= HEADER =================


              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,


                children: [



                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,


                    children: [


                      Text(

                        "Hello, ${patient?.fullName ?? "Patient"} 👋",

                        style: const TextStyle(

                          fontSize: 32,

                          fontWeight: FontWeight.bold,

                          color: Color(0xff1C274C),

                        ),

                      ),



                      const SizedBox(height: 8),



                      const Text(

                        "Here's your dental care update",

                        style: TextStyle(

                          fontSize: 18,

                          color: Colors.grey,

                        ),

                      ),


                    ],

                  ),





                  // FIXED NOTIFICATION + LOGOUT


                  Row(

                    children: [



                      _headerIconButton(

                        icon: Icons.notifications_none,

                        iconColor: const Color(0xff1C274C),

                        badge: "3",

                        onTap: (){

                          // Notification action

                        },

                      ),




                      const SizedBox(width: 12),




                      _headerIconButton(

                        icon: Icons.logout_rounded,

                        iconColor: Colors.red,


                        onTap: () async {


                          await controller.logout();



                          if(!context.mounted) return;



                          Navigator.pushReplacement(

                            context,

                            MaterialPageRoute(

                              builder: (_) => const LoginScreen(),

                            ),

                          );


                        },

                      ),



                    ],

                  ),



                ],

              ),



              const SizedBox(height: 28),



              // ================= DASHBOARD CARDS =================


              Row(

                children: [


                  Expanded(

                    child: _dashboardCard(

                      icon: Icons.calendar_today_outlined,

                      iconColor: Colors.deepPurple,

                      value: "2",

                      title: "Upcoming\nAppointments",

                    ),

                  ),



                  const SizedBox(width:16),



                  Expanded(

                    child: _dashboardCard(

                      icon: Icons.description_outlined,

                      iconColor: Colors.blue,

                      value: "3",

                      title: "Reports\nAvailable",

                    ),

                  ),


                ],

              ),



              const SizedBox(height:16),



              Row(

                children: [


                  Expanded(

                    child: _dashboardCard(

                      icon: Icons.health_and_safety_outlined,

                      iconColor: Colors.green,

                      value: "1",

                      title: "Active\nTreatments",

                    ),

                  ),



                  const SizedBox(width:16),



                  Expanded(

                    child: _dashboardCard(

                      icon: Icons.notifications_none,

                      iconColor: Colors.orange,

                      value: "2",

                      title: "Unread\nMessages",

                    ),

                  ),


                ],

              ),



              const SizedBox(height:30),



              const Text(

                "Upcoming Appointment",

                style: TextStyle(

                  fontSize:22,

                  fontWeight:FontWeight.bold,

                  color:Color(0xff1C274C),

                ),

              ),



              const SizedBox(height:18),



              Container(

                width:double.infinity,

                padding:const EdgeInsets.all(20),


                decoration:BoxDecoration(

                  color:Colors.white,

                  borderRadius:BorderRadius.circular(22),


                  boxShadow:[

                    BoxShadow(

                      color:Colors.black.withOpacity(.05),

                      blurRadius:18,

                      offset:const Offset(0,6),

                    )

                  ]

                ),



                child: Column(

                  children:[


                    Row(

                      children:[


                        Container(

                          width:68,

                          height:78,


                          decoration:BoxDecoration(

                            color:const Color(0xff2455F4),

                            borderRadius:BorderRadius.circular(18),

                          ),


                          child:const Column(

                            mainAxisAlignment:MainAxisAlignment.center,


                            children:[


                              Text(

                                "18",

                                style:TextStyle(

                                  color:Colors.white,

                                  fontSize:28,

                                  fontWeight:FontWeight.bold,

                                ),

                              ),


                              Text(

                                "JUL",

                                style:TextStyle(

                                  color:Colors.white70,

                                  fontWeight:FontWeight.w600,

                                ),

                              ),


                            ],

                          ),

                        ),



                        const SizedBox(width:18),



                        const Expanded(

                          child:Column(

                            crossAxisAlignment:CrossAxisAlignment.start,


                            children:[


                              Text(

                                "Dr. Sarah Johnson",

                                style:TextStyle(

                                  fontSize:18,

                                  fontWeight:FontWeight.bold,

                                  color:Color(0xff1C274C),

                                ),

                              ),



                              SizedBox(height:8),



                              Text(

                                "Routine Checkup",

                                style:TextStyle(

                                  color:Colors.grey,

                                ),

                              ),



                              SizedBox(height:10),



                              Row(

                                children:[

                                  Icon(

                                    Icons.access_time,

                                    size:18,

                                    color:Colors.blue,

                                  ),

                                  SizedBox(width:6),

                                  Text("10:00 AM"),

                                ],

                              ),


                              SizedBox(height:8),


                              Row(

                                children:[

                                  Icon(

                                    Icons.location_on,

                                    size:18,

                                    color:Colors.red,

                                  ),


                                  SizedBox(width:6),


                                  Text("DentalCare Clinic"),

                                ],

                              )

                            ],

                          ),

                        )

                      ],

                    ),



                    const SizedBox(height:22),



                    SizedBox(

                      width:double.infinity,

                      height:52,


                      child:ElevatedButton(

                        style:ElevatedButton.styleFrom(

                          backgroundColor:const Color(0xff2455F4),

                          shape:RoundedRectangleBorder(

                            borderRadius:BorderRadius.circular(14),

                          ),

                        ),


                        onPressed:(){},


                        child:const Text(

                          "View Appointment",

                          style:TextStyle(

                            color:Colors.white,

                            fontWeight:FontWeight.bold,

                          ),

                        ),

                      ),

                    )

                  ],

                ),

              ),
                            const SizedBox(height:30),


              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize:22,
                  fontWeight:FontWeight.bold,
                  color:Color(0xff1C274C),
                ),
              ),


              const SizedBox(height:18),



              GridView.count(

                crossAxisCount:2,

                shrinkWrap:true,

                physics:const NeverScrollableScrollPhysics(),

                crossAxisSpacing:16,

                mainAxisSpacing:16,

                childAspectRatio:1.08,


                children:[


                  _quickActionCard(

                    icon:Icons.calendar_month,

                    iconColor:const Color(0xff2455F4),

                    title:"Book\nAppointment",

                    subtitle:"Schedule your next visit",

                    onTap:(){},

                  ),




                  _quickActionCard(

                    icon:Icons.description_outlined,

                    iconColor:Colors.green,

                    title:"Medical\nReports",

                    subtitle:"View prescriptions",

                    onTap:(){},

                  ),




                  _quickActionCard(

                    icon:Icons.local_hospital_outlined,

                    iconColor:Colors.deepPurple,

                    title:"Find\nClinic",

                    subtitle:"Nearby dental clinics",

                    onTap:(){},

                  ),




                  _quickActionCard(

                    icon:Icons.emergency_outlined,

                    iconColor:Colors.red,

                    title:"Emergency\nSupport",

                    subtitle:"Contact immediately",

                    onTap:(){},

                  ),


                ],

              ),




              const SizedBox(height:30),




              const Text(

                "Oral Health Tip",

                style:TextStyle(

                  fontSize:22,

                  fontWeight:FontWeight.bold,

                  color:Color(0xff1C274C),

                ),

              ),




              const SizedBox(height:18),




              Container(

                width:double.infinity,

                padding:const EdgeInsets.all(22),


                decoration:BoxDecoration(

                  color:Colors.white,

                  borderRadius:BorderRadius.circular(22),


                  boxShadow:[

                    BoxShadow(

                      color:Colors.black.withOpacity(.05),

                      blurRadius:18,

                    )

                  ]

                ),




                child:Row(

                  children:[



                    Container(

                      height:90,

                      width:90,


                      decoration:BoxDecoration(

                        color:const Color(0xffEAF2FF),

                        borderRadius:BorderRadius.circular(20),

                      ),



                      child:const Icon(

                        Icons.health_and_safety,

                        size:48,

                        color:Color(0xff2455F4),

                      ),

                    ),




                    const SizedBox(width:18),




                    const Expanded(

                      child:Column(

                        crossAxisAlignment:CrossAxisAlignment.start,


                        children:[



                          Text(

                            "Brush Twice Daily",

                            style:TextStyle(

                              fontSize:18,

                              fontWeight:FontWeight.bold,

                              color:Color(0xff1C274C),

                            ),

                          ),




                          SizedBox(height:10),




                          Text(

                            "Brushing your teeth for two minutes twice a day helps prevent cavities and gum disease.",

                            style:TextStyle(

                              color:Colors.grey,

                              height:1.5,

                            ),

                          ),



                        ],

                      ),

                    )


                  ],

                ),

              ),




              const SizedBox(height:30),


            ],

          ),

        ),

      ),

    );

  }






// ================= Dashboard Card =================


Widget _dashboardCard({

  required IconData icon,

  required Color iconColor,

  required String value,

  required String title,

}) {


  return Container(

    padding:const EdgeInsets.all(18),


    decoration:BoxDecoration(

      color:Colors.white,

      borderRadius:BorderRadius.circular(20),


      boxShadow:[

        BoxShadow(

          color:Colors.black.withOpacity(.05),

          blurRadius:15,

          offset:const Offset(0,5),

        )

      ]

    ),



    child:Column(

      crossAxisAlignment:CrossAxisAlignment.start,


      children:[



        Container(

          padding:const EdgeInsets.all(12),


          decoration:BoxDecoration(

            color:iconColor.withOpacity(.12),

            shape:BoxShape.circle,

          ),


          child:Icon(

            icon,

            color:iconColor,

            size:28,

          ),

        ),




        const SizedBox(height:20),



        Text(

          value,

          style:const TextStyle(

            fontSize:28,

            fontWeight:FontWeight.bold,

            color:Color(0xff1C274C),

          ),

        ),




        const SizedBox(height:8),




        Text(

          title,

          style:const TextStyle(

            color:Colors.grey,

          ),

        ),


      ],

    ),

  );

}






// ================= Quick Action Card =================


Widget _quickActionCard({

  required IconData icon,

  required Color iconColor,

  required String title,

  required String subtitle,

  required VoidCallback onTap,

}) {


  return InkWell(

    borderRadius:BorderRadius.circular(20),

    onTap:onTap,


    child:Container(

      padding:const EdgeInsets.all(18),



      decoration:BoxDecoration(

        color:Colors.white,

        borderRadius:BorderRadius.circular(20),


        boxShadow:[

          BoxShadow(

            color:Colors.black.withOpacity(.05),

            blurRadius:15,

            offset:const Offset(0,5),

          )

        ]

      ),




      child:Column(

        crossAxisAlignment:CrossAxisAlignment.start,


        children:[



          Container(

            padding:const EdgeInsets.all(12),


            decoration:BoxDecoration(

              color:iconColor.withOpacity(.12),

              borderRadius:BorderRadius.circular(14),

            ),



            child:Icon(

              icon,

              color:iconColor,

              size:28,

            ),

          ),




          const Spacer(),




          Text(

            title,

            style:const TextStyle(

              fontSize:17,

              fontWeight:FontWeight.bold,

              color:Color(0xff1C274C),

            ),

          ),




          const SizedBox(height:6),




          Text(

            subtitle,

            style:const TextStyle(

              color:Colors.grey,

              fontSize:13,

            ),

          ),



        ],

      ),

    ),

  );

}






// ================= Header Icon Button =================


Widget _headerIconButton({

  required IconData icon,

  required Color iconColor,

  VoidCallback? onTap,

  String? badge,

}) {


  return Stack(

    clipBehavior:Clip.none,


    children:[



      InkWell(

        borderRadius:BorderRadius.circular(14),

        onTap:onTap,



        child:Container(

          height:52,

          width:52,


          decoration:BoxDecoration(

            color:Colors.white,

            borderRadius:BorderRadius.circular(14),


            boxShadow:[

              BoxShadow(

                color:Colors.black.withOpacity(.06),

                blurRadius:12,

                offset:const Offset(0,4),

              )

            ]

          ),



          child:Icon(

            icon,

            size:27,

            color:iconColor,

          ),

        ),

      ),





      if(badge != null)



      Positioned(

        right:-3,

        top:-3,


        child:Container(

          height:20,

          width:20,


          decoration:const BoxDecoration(

            color:Colors.red,

            shape:BoxShape.circle,

          ),



          child:Center(

            child:Text(

              badge,


              style:const TextStyle(

                color:Colors.white,

                fontSize:11,

                fontWeight:FontWeight.bold,

              ),

            ),

          ),

        ),

      )



    ],

  );

}

}