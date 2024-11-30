import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod Provider for selected date state
final selectedDateProvider = StateProvider.family<DateTime?, String>((ref, key) => null);

/// Riverpod Provider for selected time state
final selectedTimeProvider = StateProvider.family<TimeOfDay?, String>((ref, key) => null);

class CustomCard extends ConsumerWidget {
  final String title;
  final String hint;
  final Widget leadingIcon;
  final VoidCallback onCrossPressed;
  final TextInputType keyboard;
  final bool iconcross;
  final String img;
  final bool isDateInput;
  final bool isTimeInput;
  final Key key;
  final TextEditingController textController;
  final StateProvider<String?> provider;

  const CustomCard({
    required this.provider,
    required this.textController,
    required this.key, // Mark key as required
    required this.img,
    required this.iconcross,
    required this.keyboard,
    required this.title,
    required this.hint,
    required this.leadingIcon,
    required this.onCrossPressed,
    required this.isDateInput,
    required this.isTimeInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final selectedDate = ref.watch(selectedDateProvider(key.toString()));
    final selectedTime = ref.watch(selectedTimeProvider(key.toString()));

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: const Color(0xFFD5F2C8), // Light green background
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.005, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Leading Icon
            leadingIcon,
            SizedBox(width: screenWidth * 0.02),

            // Title and Input Field
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF38b000), // Green text
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: isDateInput
                        ? () async {
                      // Open Date Picker if isDateInput is true
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        ref.read(selectedDateProvider(key.toString()).notifier).state = pickedDate;
                      }
                    }
                        : isTimeInput
                        ? () async {
                      // Open Time Picker if isTimeInput is true
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        ref.read(selectedTimeProvider(key.toString()).notifier).state = pickedTime;
                      }
                    }
                        : null, // Do nothing if not date/time input
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        // Update provider state when text changes
                        ref.read(provider.notifier).state = value;
                      },
                      decoration: InputDecoration(
                        hintText: isDateInput
                            ? (selectedDate == null
                            ? hint
                            : "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                            : isTimeInput
                            ? (selectedTime == null
                            ? hint
                            : "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}")
                            : hint, // Regular text input
                        hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: keyboard,
                      enabled: !(isDateInput || isTimeInput), // Disable keyboard if date or time input
                    ),
                  ),
                ],
              ),
            ),

            // Cross Icon
            if (iconcross)
              GestureDetector(
                onTap: onCrossPressed,
                child: TextButton(
                  onPressed: onCrossPressed,
                  child: Image.asset(img),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
