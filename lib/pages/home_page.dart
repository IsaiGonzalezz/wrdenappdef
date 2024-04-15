import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:warden_techsecure/pages/central_pages.dart';
import 'package:warden_techsecure/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Inicializar Firebase
  late Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization =
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for that email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.green.shade300, Colors.blue.shade300],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'War',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'den',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 44.0,
                ),
                Text(
                  "Login Safe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 44.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ClipOval(
                  child: SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: Image.asset(
                      "assets/wardenLogo.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 44.0,
                ),
                Container(
                  padding: EdgeInsets.all(10), // Ajusta el padding aquí
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.white), // Esto añade el borde
                    borderRadius:
                        BorderRadius.circular(10), // Esto redondea los bordes
                  ),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 26.0),
                Container(
                  padding: EdgeInsets.all(10), // Ajusta el padding aquí
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.white), // Esto añade el borde
                    borderRadius:
                        BorderRadius.circular(10), // Esto redondea los bordes
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: 12.0),
                SizedBox(height: 60.0),
                Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: Color.fromARGB(255, 1, 215, 97),
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () async {
                      User? user = await loginUsingEmailPassword(
                      
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                      print(user);
                      if (user != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => CentralPage(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Ingresar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Crear una cuenta",
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 255, 33),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<User?> registerUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        print("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Registro',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Warden",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text( 
                "Sign up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ClipOval(
                child: SizedBox(
                  height: 150.0,
                  width: 150.0,
                  
                ),
              ),
              SizedBox(height: 44.0),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 26.0),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 88.0),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Color.fromARGB(255, 3, 255, 83),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () async {
                    User? user = await registerUsingEmailPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context,
                    );
                    print(user);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => CentralPage(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              
            ],
          ),
        ),
      ),
    );
  }
}
