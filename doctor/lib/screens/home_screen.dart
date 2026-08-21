import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dental_client/dental_client.dart' as dc;

import '../controllers/login_controller.dart';
import 'doctor_login.dart';
import '../features/appointments/screens/dentist_appointments_screen.dart';
import '../features/appointments/providers/dentist_appointments_provider.dart';

class HomeScreen extends StatefulWidget {
  final dc.Dentist? dentist;

  const HomeScreen({
    super.key,
    this.dentist,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DentistAppointmentsProvider>().fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {

    final controller =
        Provider.of<LoginController>(context);

    final currentDentist =
        widget.dentist ?? controller.currentDentist;

    return Scaffold(

      backgroundColor: const Color(0xffF6F8FC),

      appBar: AppBar(

        backgroundColor: Colors.transparent,

        elevation: 0,

        leading: IconButton(

          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),

          onPressed: () {},

        ),

        actions: [

          IconButton(

            onPressed: () {},

            icon: const Icon(

              Icons.notifications_none,

              color: Colors.black,

              size: 28,

            ),

          ),

          PopupMenuButton(

            icon: const CircleAvatar(

              backgroundColor: Color(0xff4A90E2),

              child: Icon(
                Icons.person,
                color: Colors.white,
              ),

            ),

            itemBuilder: (context) => [

              PopupMenuItem(

                child: const Text("Logout"),

                onTap: () {

                  controller.logout();

                  Navigator.pushReplacement(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          const DoctorLogin(),

                    ),

                  );

                },

              )

            ],

          ),

          const SizedBox(width: 10),

        ],

      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(

                "Hello, Dr. ${currentDentist?.fullName ?? "Doctor"} 👋",

                style: const TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 28,

                ),

              ),

              const SizedBox(height: 8),

              const Text(

                "Have a nice day.",

                style: TextStyle(

                  color: Colors.grey,

                  fontSize: 16,

                ),

              ),

              const SizedBox(height: 30),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Consumer<DentistAppointmentsProvider>(
                        builder: (context, provider, child) => _dashboardCard(
                          title: "Today's\nPatients",
                          value: provider.todaysAppointments.length.toString(),
                          icon: Icons.people_alt_outlined,
                          iconColor: const Color(0xff4F7DF3),
                          iconBackground: const Color(0xffEAF2FF),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DentistAppointmentsScreen(),
                            ),
                          );
                        },
                        child: _dashboardCard(
                          title: "Appointments",
                          value: "View",
                          icon: Icons.calendar_today_outlined,
                          iconColor: Colors.green,
                          iconBackground: const Color(0xffEAFBF1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Consumer<DentistAppointmentsProvider>(
                        builder: (context, provider, child) {
                          int pendingCount = provider.appointments.where((a) => a.status.name == 'pending').length;
                          return _dashboardCard(
                            title: "Pending",
                            value: pendingCount.toString(),
                            icon: Icons.schedule,
                            iconColor: Colors.orange,
                            iconBackground: const Color(0xffFFF4E5),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),

const SizedBox(height: 35),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: const [
    Text(
      "Today's Appointments",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      "View All",
      style: TextStyle(
        color: Color(0xff4F7DF3),
        fontWeight: FontWeight.w600,
      ),
    ),
  ],
),

const SizedBox(height: 20),

Consumer<DentistAppointmentsProvider>(
  builder: (context, provider, child) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.todaysAppointments.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text('No appointments today.', style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    
    return Column(
      children: provider.todaysAppointments.map((apt) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: _buildAppointmentCard(
            patient: apt.patient?.fullName ?? "Unknown",
            treatment: apt.reason,
            time: apt.startTime,
            status: apt.status.name.toUpperCase(),
            statusColor: apt.status.name == 'accepted' ? Colors.green : Colors.orange,
          ),
        );
      }).toList(),
    );
  }
),

const SizedBox(height: 30),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff4F7DF3),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Patients",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Appointments",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
  Widget _dashboardCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: iconBackground,
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard({
    required String patient,
    required String treatment,
    required String time,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xffEAF2FF),
            child: Icon(
              Icons.person,
              color: Color(0xff4F7DF3),
            ),
          ),
          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  treatment,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}