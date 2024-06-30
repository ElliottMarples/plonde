import 'package:flutter/material.dart';
import 'package:plonde/models/song.dart';

class NewSongForm extends StatefulWidget {
  const NewSongForm({super.key, required this.onFormSubmitted});

  final void Function(Song song) onFormSubmitted;

  @override
  State<NewSongForm> createState() => _NewSongFormState();
}

class _NewSongFormState extends State<NewSongForm> {
  final _formKey = GlobalKey<FormState>();

  String songName = '';
  String artistName = '';
  String albumName = '';
  String albumArtURI = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Song song = Song(
          title: songName,
          artist: artistName,
          album: albumName,
          albumArtUri: albumArtURI);
      widget.onFormSubmitted(song);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Song Name'),
            textInputAction: TextInputAction.next,
            onSaved: (value) => songName = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a song name';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Artist Name'),
            textInputAction: TextInputAction.next,
            onSaved: (value) => artistName = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an artist name';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Album Name'),
            textInputAction: TextInputAction.next,
            onSaved: (value) => albumName = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an album name';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Album Art URI'),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (value) => _submitForm(),
            onSaved: (value) => albumArtURI = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an album art URI';
              }
              return null;
            },
          ),
          const SizedBox(height: 75),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
