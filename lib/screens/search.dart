import 'package:flutter/material.dart';


class SearchPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'label': 'TAMIL', 'image': 'assets/images/tamil.png'},
    {'label': 'INTERNATIONAL', 'image': 'assets/images/international.png'},
    {'label': 'POP', 'image': 'assets/images/pop.png'},
    {'label': 'HIP-HOP', 'image': 'assets/images/hip.png'},
    {'label': 'DANCE', 'image': 'assets/images/dance.png'},
    {'label': 'COUNTRY', 'image': 'assets/images/country.png'},
    {'label': 'INDIE', 'image': 'assets/images/indie.png'},
    {'label': 'JAZZ', 'image': 'assets/images/jazz.png'},
    {'label': 'DISCO', 'image': 'assets/images/disco.png'},
    {'label': 'ROCK', 'image': 'assets/images/rock.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      
      appBar: AppBar(
        // backgroundColor: Colors.black,
        // elevation: 0,
        
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
         
          iconSize: 28, // Change the color of the back button here
          onPressed: () {
            Navigator.pop(context); // This will take you back to the previous page
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Searchclick()),
                // );
              },
              child: Center(
                child: Container(
                  height: 40, // Adjust the height of the search bar container
                  width: MediaQuery.of(context).size.width * 0.85, // Adjust width accordingly
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TextField(
                    // readOnly: true, // Make it clickable but non-editable
                    decoration: InputDecoration(
                      hintText: "Artists, Songs, or Podcasts",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                        size: 24, // Adjust the icon size
                      ),
                      filled: true,
                      fillColor: Colors.grey[800],
                      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Searchclick()),
                      // );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: 8.0,right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Grid of categories
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.8, // Adjust to match the image's aspect ratio
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a different page for each category
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            categoryName: category['label']!,
                            categoryImage: category['image']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: screenHeight * 0.15,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              category['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Center(
                            child: Text(
                              category['label']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String categoryName;
  final String categoryImage;

  CategoryPage({required this.categoryName, required this.categoryImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 198, 192, 192),
        title: Text(
          '$categoryName PAGE',
          style: TextStyle(color: const Color.fromARGB(255, 7, 4, 4)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              categoryImage,
              height: 200, // Adjust size as needed
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to the $categoryName Page!',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            // You can add more content specific to the category here.
          ],
        ),
      ),
    );
  }
}


