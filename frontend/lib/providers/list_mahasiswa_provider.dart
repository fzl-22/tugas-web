import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugas_web/models/mahasiswa.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListMahasiswaNotifier extends StateNotifier<List<Mahasiswa>> {
  ListMahasiswaNotifier() : super([]);

  void addItem(Mahasiswa newMahasiswa) {
    state = [newMahasiswa, ...state];
  }

  void fetchData() async {
    final url = Uri.http('192.168.1.8', '/server/rest_api_read.php');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final originalList = List<Map<String, dynamic>>.from(jsonData);

        List<Mahasiswa> convertedList = originalList.map((map) {
          return Mahasiswa(
            nim: map['NIM'],
            name: map['NAMA'],
            address: map['ALAMAT'],
            noTelepon: map['NO_TELEPON'],
            fakultas: map['FAKULTAS'],
            prodi: map['PRODI'],
            gender: map['JENIS_KELAMIN'],
          );
        }).toList();
        // print(convertedList);
        state = convertedList;
        // state = List<Map<String, dynamic>>.from(jsonData);
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void deleteData(Mahasiswa deletedMahasiswa) async {
    final url = Uri.http('192.168.1.8', '/server/rest_api_delete.php?id=${deletedMahasiswa.nim}');
    
    // try{
    //   final response = await http.delete(url);

    //   if(response.statusCode == 200){
    //     state = [...state.where((mahasiswa) => mahasiswa != deletedMahasiswa)];
    //   }else{
    //     print('Failed to delete record');
    //   }
    // }catch(e){
    //   print(e);
    // }

    http.delete(url).then((response) {
      if (response.statusCode == 200) {
        // Successful deletion
        print('Record deleted successfully');
        state = [...state.where((mahasiswa) => mahasiswa != deletedMahasiswa)];
      } else {
        // Error in deletion
        print('Failed to delete record');
      }
    }).catchError((error) {
      // Error in HTTP request
      print('Error: $error');
    });
  }
}

final listMahasiswaProvider =
    StateNotifierProvider<ListMahasiswaNotifier, List<Mahasiswa>>(
  (ref) => ListMahasiswaNotifier(),
);
