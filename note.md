# IN THIS CODE WE FIRST HAD THE FOLLOWING ERRORS

<p>
 First i had a problem with the geolocator i had firt to provide:
</p>

```graddle
   android{
        compileSdkVersion: 31
    }

    defaulConfig{
        minSdkVersion: 23
    }
```

## Notes: ALWAYS READ THE INSTALLATION PROCESS OF OUR DEPENDENCIES

### Use flutterfire config in cmd or powershell

## FLUTTER FIRESTORE EXAMPLE

```dart
    final CollectionReference usersRef =
    FirebaseFirestore.instance.collection("users");
    class _TimelineState extends State<Timeline> {
// Varibles
  Logger logger = Logger(printer: PrettyPrinter());

  @override
  void initState() {
    super.initState();
    getUsersById();
  }
 // First method without promises
  getUsers() {
    usersRef.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        logger.v(doc.data());
        logger.i(doc.id);
        logger.i(doc.exists);
      }
    });
  }
    //Seccond method with promises
  getUsersById() async {
    const String userId = "k0dteUh8RHycOCk0kyHu";
    DocumentSnapshot doc = await usersRef.doc(userId).get();
    if (doc.exists) {
      logger.v(doc.data());
      logger.i(doc.id);
      logger.i(doc.exists);
    }
  }
}


//GET DATA WITH FUTUREBUILDER
body: FutureBuilder<QuerySnapshot>(
        future: usersRef.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Text> children =
              snapshot.data!.docs.map((doc) => Text(doc["username"])).toList();
          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              return children[index];
            },
          );
        },
      ),


      //Streambuilder to get an realtime database aciton
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Text> children =
              snapshot.data!.docs.map((doc) => Text(doc["username"])).toList();
          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              return children[index];
            },
          );
        },
      ),
```
