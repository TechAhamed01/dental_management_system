import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/custom_button.dart';


class Confirmation extends StatelessWidget {

  const Confirmation({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor:
          AppColors.background,



      body: SafeArea(


        child: Center(


          child: Padding(


            padding:
                const EdgeInsets.all(24),



            child: Column(


              mainAxisAlignment:
                  MainAxisAlignment.center,



              children: [



                Container(

                  height:90,

                  width:90,


                  decoration:BoxDecoration(

                    color:
                    Colors.green.shade100,

                    shape:
                    BoxShape.circle,

                  ),


                  child:
                  const Icon(

                    Icons.check,

                    size:60,

                    color:Colors.green,

                  ),

                ),




                const SizedBox(height:30),




                const Text(

                  "Thank You, Doctor!",


                  style:TextStyle(

                    fontSize:24,

                    fontWeight:
                    FontWeight.bold,

                    color:
                    AppColors.heading,

                  ),

                ),




                const SizedBox(height:15),




                const Text(

                  "Your account is under review.\nWe will notify you once verification is completed.",


                  textAlign:
                  TextAlign.center,


                  style:TextStyle(

                    color:Colors.grey,

                    fontSize:15,

                  ),

                ),




                const SizedBox(height:40),




                CustomButton(

                  text:"Back to Sign In",


                  onPressed:(){


                    Navigator.popUntil(

                      context,

                      (route)=>route.isFirst,

                    );


                  },


                )




              ],


            ),


          ),


        ),

      ),

    );


  }

}