import 'package:file_picker/file_picker.dart';
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
  TextEditingController audioURIController = TextEditingController();
  AudioUriType audioUriType = AudioUriType.file;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Song song = Song(
        title: songName,
        artist: artistName,
        album: albumName,
        albumArtUri: albumArtURI,
        audioUri: audioURIController.text,
        audioUriType: audioUriType,
      );
      widget.onFormSubmitted(song);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    audioURIController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            textInputAction: TextInputAction.next,
            onSaved: (value) => albumArtURI = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an album art URI';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: 150,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: "Audio URI Type",
              ),
              value: audioUriType,
              items: const [
                DropdownMenuItem(
                  value: AudioUriType.file,
                  child: Row(
                    children: [
                      Icon(Icons.folder),
                      SizedBox(width: 15),
                      Text('File'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: AudioUriType.network,
                  child: Row(
                    children: [
                      Icon(Icons.wifi),
                      SizedBox(width: 15),
                      Text('Network'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  audioUriType = value!;
                });
              },
              onSaved: (newValue) => audioUriType = newValue!,
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: audioUriType == AudioUriType.file
                        ? 'Audio File Path'
                        : 'Audio URL',
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => _submitForm(),
                  controller: audioURIController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an audio URI';
                    }
                    return null;
                  },
                ),
              ),
              if (audioUriType != AudioUriType.network)
                IconButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.audio,
                      allowMultiple: false,
                    );
                    if (result != null) {
                      setState(() {
                        audioURIController.text = result.files.single.path!;
                      });
                    }
                  },
                  icon: const Icon(Icons.folder_open),
                ),
            ],
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
