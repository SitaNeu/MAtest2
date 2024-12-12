import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Banking App',
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false, // Disable the debug banner
      home: SplashScreen(), // Set SplashScreen as the initial screen
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the LoginScreen after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat.yMMMMd().format(DateTime.now()); // Format the current date

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 22, 8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.jpg', height: 100), // Ensure you have this image in your assets folder
            SizedBox(height: 20),
            Text(
              'Welcome to Scotia Mobile Banking',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Today is $todayDate',
              style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 219, 214, 214)),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.red,
       leading: IconButton(
          icon: Image.asset('assets/logoo.jpg', height: 40), // Bank logo on the top left corner
          onPressed: () {
            // You can add functionality for the logo button here if needed
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to validate login here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        leading: IconButton(
          icon: Image.asset('assets/logoo.jpg', height: 200), // Bank logo on the top left corner
          onPressed: () {
            // You can add functionality for the logo button here if needed
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu), // Hamburger menu (Drawer) icon on the top right corner
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the Drawer when clicked
            },
          ),
        ],
      ),
      drawer: Drawer( // Drawer (Hamburger Menu)
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                children: [
                  Image.asset('assets/logoo.jpg', height: 100), // Ensure you have this image in your assets folder
                  SizedBox(height: 10),
                  Text(
                    'Scotia Mobile Banking',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('View Accounts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountListScreen()),
                );
              },
            ),
            // You can add more options here in the menu
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountListScreen()),
                );
              },
              child: Text('View Accounts'),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountListScreen extends StatelessWidget {
  final Map<String, dynamic> accounts = {
    "chequing": {
      "accountNumber": "001234567890",
      "balance": 1250.75,
      "currency": "USD"
    },
    "savings": {
      "accountNumber": "009876543210",
      "balance": 4890.5,
      "currency": "USD"
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accounts List')),
      body: ListView.builder(
        itemCount: accounts.keys.length,
        itemBuilder: (context, index) {
          String accountType = accounts.keys.elementAt(index);
          return Card(
            child: ListTile(
              title: Text(accountType[0].toUpperCase() + accountType.substring(1) + ' Account'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountDetailsScreen(accountType: accountType),
                    ),
                  );
                },
                child: Text('View Details'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AccountDetailsScreen extends StatelessWidget {
  final String accountType;
  AccountDetailsScreen({required this.accountType});

  final Map<String, dynamic> accounts = {
    "chequing": {
      "accountNumber": "001234567890",
      "balance": 1250.75,
      "currency": "USD"
    },
    "savings": {
      "accountNumber": "009876543210",
      "balance": 4890.5,
      "currency": "USD"
    }
  };

  @override
  Widget build(BuildContext context) {
    final account = accounts[accountType] ?? {};
    double balance = account['balance'] ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/logoo.jpg', height: 40),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Text('$accountType Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying account balance below the navigation bar
            Center(
              child: Text(
                'Account Balance: \$${balance.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            // Buttons displayed in one line
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle deposit
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 211, 71, 71)),
                  child: Text('Deposit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle e-transfer
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 247, 50, 73)),
                  child: Text('E-Transfer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailsScreen(accountType: accountType),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('View Transactions'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionDetailsScreen extends StatelessWidget {
  final String accountType;
  TransactionDetailsScreen({required this.accountType});

  final Map<String, List<Map<String, dynamic>>> transactions = {
    "chequing": [
      {"date": "2024-08-01", "description": "Grocery Store", "amount": -45.67},
      {"date": "2024-08-02", "description": "Salary", "amount": 1500.00},
      {"date": "2024-08-03", "description": "Coffee Shop", "amount": -3.25},
      {"date": "2024-08-04", "description": "Electricity Bill", "amount": -120.00},
      {"date": "2024-08-05", "description": "Transfer to Savings", "amount": -300.00},
      {"date": "2024-08-06", "description": "Restaurant", "amount": -75.50},
      {"date": "2024-08-07", "description": "Gas Station", "amount": -40.00},
      {"date": "2024-08-08", "description": "Internet Bill", "amount": -60.00},
      {"date": "2024-08-09", "description": "Movie Tickets", "amount": -25.00},
      {"date": "2024-08-10", "description": "Gym Membership", "amount": -50.00},
    ],
     "savings": [
      {"date": "2024-08-01", "description": "Interest Earned", "amount": 5.25},
      {"date": "2024-08-02", "description": "Transfer from Chequing", "amount": 300},
      {"date": "2024-08-03", "description": "Deposit", "amount": 100},
      {"date": "2024-08-04", "description": "Transfer from Chequing", "amount": 200},
      {"date": "2024-08-05", "description": "Interest Earned", "amount": 4.75},
      {"date": "2024-08-06", "description": "Deposit", "amount": 150},
      {"date": "2024-08-07", "description": "Transfer from Chequing", "amount": 250},
      {"date": "2024-08-08", "description": "Interest Earned", "amount": 3.5},
      {"date": "2024-08-09", "description": "Deposit", "amount": 200},
      {"date": "2024-08-10", "description": "Transfer from Chequing", "amount": 400}
    ]
  };



  @override
  Widget build(BuildContext context) {
    final accountTransactions = transactions[accountType] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$accountType Account Transactions'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: accountTransactions.length,
        itemBuilder: (context, index) {
          var transaction = accountTransactions[index];
          return ListTile(
            title: Text(transaction['description']),
            subtitle: Text('Date: ${transaction['date']}'),
            trailing: Text('\$${transaction['amount']}'),
          );
        },
      ),
    );
  }
}
