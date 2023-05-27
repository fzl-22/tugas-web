import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugas_web/providers/list_mahasiswa_provider.dart';
import 'package:tugas_web/models/mahasiswa.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  void _editDataMahasiswa(Mahasiswa editedMahasiswa) async {

  }

  @override
  Widget build(BuildContext context) {
    ref.watch(listMahasiswaProvider.notifier).fetchData();
    final listMahasiswa =  ref.watch(listMahasiswaProvider);
    return Center(
      child: ListView.builder(
        itemCount: listMahasiswa.length,
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 10,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listMahasiswa[index].name!,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  Text(listMahasiswa[index].nim!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                ],
              ),
              leading: Container(
                height: 24,
                width: 24,
                color: Colors.black,
              ),
              trailing: SizedBox(
                width: 120,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon:const Icon(
                        Icons.edit,
                        size: 32,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.watch(listMahasiswaProvider.notifier).deleteData(listMahasiswa[index]);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
