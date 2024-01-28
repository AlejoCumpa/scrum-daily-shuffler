import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrum_handler/model/team_member.dart';
import 'package:scrum_handler/provider/team_provider.dart';
import 'package:scrum_handler/widgets/team_member.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final TeamProvider _teamProvider;
  final List<TeamMember> _connectedMembers = [];
  final List<TeamMember> _notConnectedMembers = [];

  String _language = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _teamProvider = TeamProvider();
    _restartMeeting();
  }

  void _changeLanguage() {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }
    final repeats = Random().nextInt(20);
    Stream.periodic(const Duration(milliseconds: 200), (v) => v)
        .take(repeats)
        .listen(
      (count) {
        if (_language == 'en') {
          _language = 'es';
        } else {
          _language = 'en';
        }
        if (count == repeats) {
          _isLoading = false;
        }
        if (mounted) {
          setState(() {});
        }
      },
      onDone: () {
        _isLoading = false;
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  void _restartMeeting() {
    _language = '';
    _connectedMembers.clear();
    _notConnectedMembers.clear();

    _notConnectedMembers.addAll(_teamProvider.myTeam);
    if (mounted) {
      setState(() {});
    }
  }

  void _shuffleConnected() {
    final repeats = Random().nextInt(20);
    Stream.periodic(const Duration(milliseconds: 200), (v) => v)
        .take(repeats)
        .listen(
      (count) {
        _connectedMembers.shuffle();
        if (mounted) {
          setState(() {});
        }
      },
    );

    if (mounted) {
      setState(() {});
    }
  }

  Widget _languageImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!_isLoading)
          Text(
            _language == 'en'
                ? 'The daily is going to be in English'
                : 'La daily será en español',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(
          width: 16.0,
        ),
        SizedBox(
          height: 60.0,
          child: Image.asset(
            _language == 'en' ? 'assets/images/en.png' : 'assets/images/es.png',
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTeamMembers(bool connected) {
    var result = <Widget>[];
    final members = connected ? _connectedMembers : _notConnectedMembers;

    for (final member in members) {
      result.add(
        TeamMemberName(
          callback: !connected
              ? () {
                  _connectedMembers.add(member);
                  _notConnectedMembers.remove(member);
                  if (mounted) {
                    setState(() {});
                  }
                }
              : null,
          key: ObjectKey(member.name.toLowerCase()),
          teamMember: member,
          teamProvider: _teamProvider,
        ),
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text(
            ' Daily Scrum - Best Team',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _shuffleConnected,
              icon: const Icon(
                Icons.shuffle,
                color: Colors.white,
              ),
            ),
            IconButton(
                onPressed: _changeLanguage,
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                )),
            IconButton(
              onPressed: _restartMeeting,
              icon: const Icon(
                Icons.restart_alt,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                if (_language.isNotEmpty) _languageImage(),
                const SectionTitle(text: 'Asistentes'),
                ..._buildTeamMembers(true),
                const SectionTitle(text: 'No Conectados'),
                ..._buildTeamMembers(false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 30.0),
      ),
    );
  }
}
