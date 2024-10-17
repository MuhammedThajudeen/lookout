// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextField(
                
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  hintText: 'Search here..',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight:
                          Radius.circular(20.0), // No curve on bottom right
                    ),
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
