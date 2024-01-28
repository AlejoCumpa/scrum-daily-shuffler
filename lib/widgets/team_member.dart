import 'package:flutter/material.dart';
import 'package:scrum_handler/model/team_member.dart';
import 'package:scrum_handler/provider/team_provider.dart';

class TeamMemberName extends StatefulWidget {
  const TeamMemberName({
    super.key,
    this.callback,
    required this.teamMember,
    required this.teamProvider,
  });

  final VoidCallback? callback;
  final TeamMember teamMember;
  final TeamProvider teamProvider;

  @override
  State<TeamMemberName> createState() => _TeamMemberNameState();
}

class _TeamMemberNameState extends State<TeamMemberName>
    with TickerProviderStateMixin {
  late AnimationController _animation;
  late Animation<double> _fadeOut;
  late Animation<double> _translate;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 400,
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(_animation);
    _translate = Tween<double>(begin: 0.0, end: -100.0).animate(_animation);

    _animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          widget.callback?.call();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animation.forward();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -100 * _animation.value),
            child: FadeTransition(
              opacity: _fadeOut,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.teamMember.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
