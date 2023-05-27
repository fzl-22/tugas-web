// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tugas_web/models/mahasiswa.dart';
// import 'package:tugas_web/models/model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:tugas_web/providers/list_mahasiswa_provider.dart';

// class EditData extends ConsumerStatefulWidget {
//   final Mahasiswa mahasiswa;

//   const EditData({super.key, required this.mahasiswa});

//   @override
//   ConsumerState<EditData> createState() => _EditDataState();
// }

// class _EditDataState extends ConsumerState<EditData> {
//   final _formKey = GlobalKey<FormState>();
//   // String _nimValue = widget.mahasiswa.nim;
//   late final TextEditingController _nimController = TextEditingController(text: widget.mahasiswa.nim);
//   late final TextEditingController _nameController = TextEditingController(text: widget.mahasiswa.name);
//   late final TextEditingController _addressController = TextEditingController(text: widget.mahasiswa.address);
//   late final TextEditingController _noTelponController = TextEditingController(text: widget.mahasiswa.noTelepon);
//   late final TextEditingController _fakultasController = TextEditingController(text: widget.mahasiswa.fakultas);
//   late final TextEditingController _prodiController = TextEditingController(text: widget.mahasiswa.prodi);
//   late final TextEditingController _genderController = TextEditingController(text: widget.mahasiswa.gender);
  
//   // String _enteredNim = '';
//   // String _enteredName = '';
//   // String _enteredAddress = '';
//   // String _enteredNoTelepon = '';
//   // Fakultas _enteredFakultas = Fakultas.ftib;
//   // String _enteredProdi = '';
//   // String _enteredGender = '';

//   void _saveMahasiswa(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       final uri = Uri.http("192.168.1.8", "/server/rest_api_insert.php");
//       try {
//         final response = await http.put(
//           uri,
//           headers: {
//             'Content-Type': 'application/json',
//           },
//           body: json.encode({
//             "NIM": _enteredNim,
//             "NAMA": _enteredName,
//             "ALAMAT": _enteredAddress,
//             "NO_TELEPON": _enteredNoTelepon,
//             "HOBBY": "HOBBY1, HOBBY2",
//             "PRODI": _enteredProdi,
//             "FAKULTAS": _enteredFakultas.name.toUpperCase(),
//             "JENIS_KELAMIN": _enteredGender,
//           }),
//         );
//         print(response.body);
//       } catch (e) {
//         print(e);
//       }

//       ref.watch(listMahasiswaProvider.notifier).addItem(
//             Mahasiswa(
//               nim: _enteredNim,
//               name: _enteredName,
//               address: _enteredAddress,
//               noTelepon: _enteredNoTelepon,
//               fakultas: _enteredFakultas.name.toUpperCase(),
//               prodi: _enteredProdi,
//               gender: _enteredGender,
//             ),
//           );

//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Container(
//         padding: const EdgeInsets.only(left: 10, top: 30),
//         child: Text(
//           "Tambah Mahasiswa Baru",
//           style: TextStyle(
//               color: Theme.of(context).colorScheme.onPrimaryContainer,
//               fontWeight: FontWeight.w600,
//               fontSize: 32),
//         ),
//       ),
//       content: Container(
//         padding: const EdgeInsets.all(8.0),
//         height: 640,
//         width: 960,
//         child: Form(
//           key: _formKey,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'NIM:',
//                       ),
//                       enableSuggestions: false,
//                       validator: (value) {
//                         var checkVal = double.tryParse(value!);
//                         if (value == '' || value.isEmpty) {
//                           return 'Please enter your NIM';
//                         }
//                         if (checkVal == null) {
//                           return 'Please enter a valid number';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _enteredNim = value!;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Nama:',
//                       ),
//                       enableSuggestions: false,
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty ||
//                             value.trim().isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _enteredName = value!;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                           labelText: "Alamat:",
//                           hintText:
//                               "Nama Jalan, Kelurahan/Desa, Kecamatan, Kota/Kabupaten, Provinsi, Kode Pos"),
//                       enableSuggestions: false,
//                       keyboardType: TextInputType.multiline,
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty ||
//                             value.trim().isEmpty) {
//                           return 'Please enter your address';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _enteredAddress = value!;
//                       },
//                       minLines: 1,
//                       maxLines: 1,
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'No. Telepon:',
//                         hintText: '6281234567890',
//                       ),
//                       enableSuggestions: false,
//                       validator: (value) {
//                         var checkVal = double.tryParse(value!);
//                         if (value == "" || value.isEmpty) {
//                           return 'Please enter your phone number';
//                         }
//                         if (checkVal == null) {
//                           return 'Please enter a valid number';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _enteredNoTelepon = value!;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Program Studi:',
//                       ),
//                       enableSuggestions: false,
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty ||
//                             value.trim().isEmpty) {
//                           return 'Masukkan program studi';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _enteredProdi = value!;
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Fakultas:',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(
//                           width: 16,
//                         ),
//                         Expanded(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 24,
//                                 child: Row(
//                                   children: [
//                                     Radio<Fakultas>(
//                                       value: Fakultas.ftib,
//                                       groupValue: _enteredFakultas,
//                                       onChanged: (Fakultas? value) {
//                                         setState(() {
//                                           _enteredFakultas = value!;
//                                         });
//                                       },
//                                     ),
//                                     const SizedBox(width: 4),
//                                     const Text('FTIB'),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 18,
//                               ),
//                               SizedBox(
//                                 height: 24,
//                                 child: Row(
//                                   children: [
//                                     Radio<Fakultas>(
//                                       value: Fakultas.fteic,
//                                       groupValue: _enteredFakultas,
//                                       onChanged: (Fakultas? value) {
//                                         setState(() {
//                                           _enteredFakultas = value!;
//                                         });
//                                       },
//                                     ),
//                                     const SizedBox(width: 4),
//                                     const Text('FTEIC'),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Jenis Kelamin (L/P):',
//                       ),
//                       enableSuggestions: false,
//                       validator: (value) {
//                         List<String> validAnswer = ['L', 'P'];
//                         if (value == null || value.isEmpty) {
//                           return 'Masukkan jenis kelamin';
//                         }
//                         if (!validAnswer.contains(value)) {
//                           return 'Masukkan jenis kelamin yang valid';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _enteredGender = value!;
//                       },
//                     ),
//                     const SizedBox(height: 36),
//                     Row(
//                       children: [
//                         const Spacer(),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.all(16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(24),
//                             ),
//                           ),
//                           child: const Text(
//                             'Cancel',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () {
//                             _saveMahasiswa(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Theme.of(context)
//                                 .colorScheme
//                                 .secondaryContainer,
//                             padding: const EdgeInsets.all(16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(24),
//                             ),
//                           ),
//                           child: const Text(
//                             'Add Data',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(
//                   top: 40,
//                   bottom: 40,
//                   left: 40,
//                   right: 40,
//                 ),
//                 width: 400,
//                 child: Image.asset(
//                   'assets/images/amico.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
