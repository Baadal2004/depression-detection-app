import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadPcodScreen extends StatefulWidget {
  const UploadPcodScreen({super.key,required this.userId});
  final int userId;

  @override
  State<UploadPcodScreen> createState() => _UploadPcodScreenState();
}

class _UploadPcodScreenState extends State<UploadPcodScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final symptomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 248, 155, 194), Color.fromARGB(255, 245, 242, 243),
             Color.fromARGB(255, 245, 242, 243),
          //  Color.fromARGB(255, 245, 240, 243),
           Color.fromARGB(255, 240, 140, 182),],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Title
                const Text(
                  "Upload Your PCOD Scanning Report",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 95, 24, 109),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 25),

                // Illustration
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage("assets/images/documents.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child:SizedBox(
                    height: 190,
                  width:190,

                  ) ,
                ),

                const SizedBox(height: 20),

                // Description Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Upload your PCOD scanning report to get instant AI-based predictions. Your data is secure and used only for health analysis.",
                    textAlign: TextAlign.center,
                    style: TextStyle(  color: Color.fromARGB(255, 95, 24, 109), height: 1.4),
                  ),
                ),

                const SizedBox(height: 20),

                // Dotted Upload Box
                DottedBorder(
                  dashPattern: const [8, 4],
                  color: const Color(0xFFEB4A7B),
                  strokeWidth: 1.4,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.03),
                    ),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 50,
                          color: Color(0xFFEB4A7B),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tap to Upload Report (PDF / Image)",
                          style: TextStyle(  color: Color.fromARGB(255, 95, 24, 109), fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Info Tile 1
                // _infoTile(Icons.file_present, "Max 10MB"),
                // const SizedBox(height: 12),

                // // Info Tile 2
                // _infoTile(Icons.image, "PDF, JPG, PNG"),
                // const SizedBox(height: 12),

                // // Info Tile 3
                // _infoTile(Icons.lock_outline, "Encrypted & Secure"),

                // const SizedBox(height: 25),

                // // Optional Health Card
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: Colors.white.withOpacity(0.07),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         "Add Health Details (Optional)",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.w600,
                //           fontSize: 15,
                //         ),
                //       ),
                //       const SizedBox(height: 16),

                //       _inputField("Height (cm)", heightController),
                //       const SizedBox(height: 12),

                //       _inputField("Weight (kg)", weightController),
                //       const SizedBox(height: 12),

                //       _inputField(
                //         "Describe Symptoms",
                //         symptomController,
                //         maxLines: 3,
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 30),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEB4A7B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "📜 Upload My Report",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _infoTile(IconData icon, String text) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.06),
  //       borderRadius: BorderRadius.circular(40),
  //     ),
  //     child: Row(
  //       children: [
  //         Icon(icon, size: 18, color: Colors.white70),
  //         const SizedBox(width: 10),
  //         Text(
  //           text,
  //           style: const TextStyle(color: Colors.white70, fontSize: 14),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _inputField(
  //   String hint,
  //   TextEditingController controller, {
  //   int maxLines = 1,
  // }) {
  //   return TextField(
  //     controller: controller,
  //     maxLines: maxLines,
  //     style: const TextStyle(color: Colors.white),
  //     decoration: InputDecoration(
  //       hintText: hint,
  //       hintStyle: TextStyle(color: Colors.white54),
  //       filled: true,
  //       fillColor: Colors.white.withOpacity(0.05),
  //       contentPadding: const EdgeInsets.symmetric(
  //         horizontal: 16,
  //         vertical: 14,
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(14),
  //         borderSide: BorderSide.none,
  //       ),
  //     ),
  //   );
  // }
}
