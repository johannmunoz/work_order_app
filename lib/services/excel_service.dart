import 'dart:io';

import 'package:excel/excel.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:work_order_app/models/job.dart';
import 'package:path/path.dart';
import 'package:work_order_app/utils/date_helpers.dart';

@lazySingleton
class ExcelService {
  Future<void> createFileWithJobs(List<Job> jobs) async {
    try {
      var excel = Excel.createExcel();
      final sheetName = await excel.getDefaultSheet();
      final sheetObj = excel.sheets[sheetName];

      sheetObj.insertRowIterables([
        'Address',
        'Date',
        'Hours',
        'Hours Rate',
        'Value',
      ], 0);

      jobs.asMap().forEach((index, job) {
        sheetObj.insertRowIterables([
          job.address,
          getFormattedDate(job.date),
          job.hours,
          job.hourRate,
          job.hours * job.hourRate
        ], index + 1);
      });

      final total = jobs.fold<double>(
          0, (sum, next) => sum + (next.hours * next.hourRate));

      sheetObj.updateCell(
          CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: jobs.length + 2),
          'Total');
      sheetObj.updateCell(
          CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: jobs.length + 2),
          total);

      final docEncoded = await excel.encode();
      final path = await _localPath;
      final filename =
          'report-${getFormattedDateFilename(DateTime.now())}.xlsx';
      final excelFile = File(join(path, filename));
      excelFile.createSync(recursive: true);
      excelFile.writeAsBytesSync(docEncoded);

      print('File saved to: ${excelFile.path}');
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }
}
