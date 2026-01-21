import 'package:flutter/material.dart';
import 'package:tugas1_11pplg2/Pages/login_page.dart';
import 'Components/custom_input.dart';
import 'Components/user_data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final txtNamaController = TextEditingController();
  final txtUsernameController = TextEditingController();
  final txtPasswordController = TextEditingController();
  String jenisKelamin = "Laki-laki";
  DateTime? tanggalLahir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Halaman Register")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CustomInput(
              label: "Nama",
              controller: txtNamaController,
              isNumber: false,
            ),
            CustomInput(
              label: "Email / Username",
              controller: txtUsernameController,
              isNumber: false,
            ),
            CustomInput(
              label: "Password",
              controller: txtPasswordController,
              isPassword: true,
              isNumber: false,
            ),

            DropdownButtonFormField<String>(
              value: jenisKelamin,
              items: ["Laki-laki", "Perempuan"].map((String val) {
                return DropdownMenuItem<String>(value: val, child: Text(val));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  jenisKelamin = val!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Jenis Kelamin",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: DateTime.now(),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    tanggalLahir = pickedDate;
                  });
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Tanggal Lahir",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  tanggalLahir == null
                      ? "Pilih tanggal"
                      : "${tanggalLahir!.day}/${tanggalLahir!.month}/${tanggalLahir!.year}",
                ),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simpan ke user_data.dart
                UserData.simpan(
                  namaBaru: txtNamaController.text,
                  usernameBaru: txtUsernameController.text,
                  passwordBaru: txtPasswordController.text,
                  jenisKelaminBaru: jenisKelamin,
                  tglLahirBaru: tanggalLahir,
                );

                // pindah activity
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );

                // MessageBox
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Informasi"),
                    content: Text("Data berhasil disimpan!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );

                // Debug print
                print("Data berhasil disimpan");
              },
              child: const Text("Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}
