import 'package:d_info/d_info.dart';
import 'package:intl/intl.dart';

import '../../config/api.dart';
import '../../config/app_request.dart';
import '../model/history.dart';

class SourceHistory {
  static Future<Map> analysis(String idUser) async {
    String url = '${api.history}/analysis.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'today': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    });

    if (responseBody == null) {
      return {
        'today': 0.0,
        'yesterday': 0.0,
        'week': [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        'month': {
          'income': 0.0,
          'outcome': 0.0,
        }
      };
    }

    return responseBody;
  }

  static Future<bool> add(String idUser, String date, String type,
      String details, String total) async {
    String url = '${api.history}/add.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
      'type': type,
      'details': details,
      'total': total,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil tambah history');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.dialogError(
            'History dengan tanggal tersebut sudah pernah dibuat');
      } else {
        DInfo.dialogError('Gagal tambah history');
      }
      DInfo.closeDialog();
    }
    return responseBody['success'];
  }

  static Future<List<History>> incomeOutcome(String idUser, String type) async {
    String url = '${api.history}/income_outcome.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'type': type,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }

    return [];
  }

  static Future<List<History>> incomeOutcomeSearch(
      String idUser, String type, String date) async {
    String url = '${api.history}/income_outcome_search.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'type': type,
      'date': date,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }

    return [];
  }

  static Future<History?> whereDate(String idUser, String date) async {
    String url = '${api.history}/where_date.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
    });

    if (responseBody == null) return null;

    if (responseBody['success']) {
      var e = responseBody['data'];
      return History.fromJson(e);
    }

    return null;
  }

  static Future<bool> update(String id_history, String idUser, String date,
      String type, String details, String total) async {
    String url = '${api.history}/update.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_history': id_history,
      'id_user': idUser,
      'date': date,
      'type': type,
      'details': details,
      'total': total,
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess('Berhasil update history');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.dialogError('Tanggal history ada yang sama');
      } else {
        DInfo.dialogError('Gagal update history');
      }
      DInfo.closeDialog();
    }
    return responseBody['success'];
  }

  static Future<bool> delete(String idHistory) async {
    String url = '${api.history}/delete.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_history': idHistory,
    });

    if (responseBody == null) return false;

    return responseBody['success'];
  }

  static Future<List<History>> history(String idUser) async {
    String url = '${api.history}/history.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }

    return [];
  }

  static Future<List<History>> historySearch(String idUser, String date) async {
    String url = '${api.history}/history_search.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }

    return [];
  }
}
