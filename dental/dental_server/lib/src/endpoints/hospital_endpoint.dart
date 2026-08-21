import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';

class HospitalEndpoint extends Endpoint {
  Future<Hospital> createHospital(
    Session session,
    String name,
    String address,
    String phone,
    String email,
  ) async {
    AuthUtils.requireRole(session, ['admin']);
    final hospital = Hospital(
      name: name,
      address: address,
      phone: phone,
      email: email,
      isActive: true,
      createdAt: DateTime.now(),
    );
    return await Hospital.db.insertRow(session, hospital);
  }

  Future<Hospital?> getHospital(Session session, int id) async {
    final authUser = AuthUtils.requireRole(session, ['admin', 'receptionist']);
    if (authUser.role == 'receptionist' && authUser.hospitalId != id) {
      throw Exception('Forbidden. You do not have access to this hospital.');
    }
    return await Hospital.db.findById(session, id);
  }

  Future<List<Hospital>> listActiveHospitals(Session session) async {
    return await Hospital.db.find(
      session,
      where: (t) => t.isActive.equals(true),
    );
  }

  Future<Hospital> updateHospital(Session session, Hospital hospital) async {
    AuthUtils.requireRole(session, ['admin']);
    return await Hospital.db.updateRow(session, hospital);
  }
}
