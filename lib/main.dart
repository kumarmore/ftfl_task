import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifelineCart App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const LifelineCardScreen(),
    );
  }
}

class LifelineCardScreen extends StatefulWidget {
  const LifelineCardScreen({Key? key}) : super(key: key);

  @override
  State<LifelineCardScreen> createState() => _LifelineCardScreenState();
}

class _LifelineCardScreenState extends State<LifelineCardScreen> {
  bool _isLoading = false;

  // API activation function
  Future<void> activateLifelineCard() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Replace with your actual API endpoint
      final response = await http.post(
        Uri.parse('https://your-api-endpoint.com/activate-card'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_AUTH_TOKEN',
        },
        body: jsonEncode({
          'cardId': 'lifeline-card-id',
          'activationType': 'lifetime',
          'amount': 3499,
        }),
      );

      if (response.statusCode == 200) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Card activated successfully!')),
        );
      } else {
        // Error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to activate card. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Card & Wallets',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LifelineCard (Already in a rounded box)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E50),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 40,
                      left: 24,
                      child: Row(
                        children: [
                          const Text(
                            'LifelineCart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 60),
                          Text(
                            'Purchase Power Card',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 24,
                      child: Icon(
                        Icons.credit_card,
                        color: Colors.white.withOpacity(0.7),
                        size: 30,
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 80,
                      child: Icon(
                        Icons.contactless,
                        color: Colors.white.withOpacity(0.7),
                        size: 30,
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      right: 24,
                      child: const Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Positioned(
                      right: 24,
                      bottom: 20,
                      left: 24,
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.red.withOpacity(0.0),
                              Colors.green.withOpacity(0.0),
                            ],
                          ),
                        ),
                        child: CustomPaint(
                          painter: HeartbeatPainter(),
                          child: const SizedBox(
                            width: double.infinity,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Card Status
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Card Status: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Inactive',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Guide',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Activate Card Section to Business Funds (Wrapped in a rounded box)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Activate Card Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Activate your LifelineCard',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '₹ 3499/- ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text('Life Time'),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '₹ 9999/Year',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Offer Ends Soon!',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.blue, width: 1),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.check,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              'assets/cartoon_person.png', // Replace with your actual image
                              width: 150,
                              height: 150,
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Activate Now Button
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : activateLifelineCard,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E1E50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : const Text('Activate Now'),
                      ),
                    ),

                    // Our Features
                    const SizedBox(height: 24),
                    const Text(
                      'Our Features',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Limits
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Udhar Limit: ₹ 74425',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'CP EMI Limit: ₹ 74425',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Feature Icons
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeatureItem(Icons.money, 'Udhar'),
                        _buildFeatureItem(Icons.credit_card, 'CP EMI'),
                        _buildFeatureItem(Icons.business_center, 'Business Funds'),
                      ],
                    ),
                  ],
                ),
              ),
// Wallet Section
              const SizedBox(height: 32),
              const Text(
                'Wallet',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),

              // Wallet Items
              _buildWalletItem(
                'Lifeline Card Wallet',
                'Upcoming EMI/Udhar',
                '4356',
                '4356',
                Colors.blue[700]!,
                ['Withdraw', 'Transfer', 'More'],
              ),
              const SizedBox(height: 16),
              _buildWalletItem(
                'Lifeline Coin',
                'Lifeline Magic Coin',
                '4356',
                '600',
                Colors.blue[600]!,
                ['More'],
                showDateRange: true,
              ),
              const SizedBox(height: 16),
              _buildWalletItem(
                'Cashback Coin',
                'Add Credit Coin',
                '4356',
                '',
                Colors.blue[500]!,
                ['More'],
                isLastItem: true,
                showDateRange: true,
                redSubtitle: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey[700], size: 40),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletItem(
      String title,
      String subtitle,
      String balance1,
      String balance2,
      Color color,
      List<String> actions, {
        bool isLastItem = false,
        bool showDateRange = false,
        bool redSubtitle = false,
      }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: redSubtitle ? Colors.red : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    balance1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (balance2.isNotEmpty)
                    Text(
                      balance2,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showDateRange)
                Text(
                  '11th Sep 2023 To 11 Oct 2023',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                )
              else
                const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int i = 0; i < actions.length; i++) ...[
                    if (i > 0) const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        actions[i],
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom painter for heartbeat line
class HeartbeatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Starting point
    path.moveTo(0, size.height / 2);

    // First segment (flat)
    path.lineTo(size.width * 0.2, size.height / 2);

    // Heartbeat peak
    path.lineTo(size.width * 0.3, size.height * 0.1);
    path.lineTo(size.width * 0.4, size.height * 0.9);
    path.lineTo(size.width * 0.5, size.height * 0.5);

    // Flat segment
    path.lineTo(size.width * 0.6, size.height / 2);

    // Second heartbeat
    path.lineTo(size.width * 0.7, size.height * 0.2);
    path.lineTo(size.width * 0.8, size.height * 0.8);
    path.lineTo(size.width * 0.9, size.height * 0.3);

    // End
    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}