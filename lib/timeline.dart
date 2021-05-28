import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Timeline {
  final Widget content;
  final Icon? icon;
  final TimelineLine? beforeDot;
  final TimelineLine? afterDot;

  Timeline({required this.content, this.icon, this.beforeDot, this.afterDot});
}

class TimelineLine extends StatelessWidget {
  final bool isDash;
  final Color color;
  final Axis axis;
  final double size;
  final double thickness;
  static const dashSize = 5.0;

  const TimelineLine({
    Key? key,
    this.isDash = false,
    this.color = Colors.black,
    this.axis = Axis.vertical,
    this.size = 50,
    this.thickness = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.vertical) {
      if (!isDash) {
        return Container(
          width: thickness,
          height: size,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: color),
            ),
          ),
        );
      } else {
        return Container(
          width: thickness,
          height: size,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              size ~/ (dashSize * 2),
              (index) => SizedBox(
                width: thickness,
                height: dashSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              ),
            ),
          ),
        );
      }
    } else {
      if (!isDash) {
        return Container(
          height: thickness,
          width: size,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: color),
            ),
          ),
        );
      } else {
        return Container(
          height: thickness,
          width: size,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              size ~/ (dashSize * 2),
              (index) => SizedBox(
                height: thickness,
                width: dashSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}

class VerticalTimelines extends StatelessWidget {
  final List<Timeline> timelines;
  final BoxDecoration? dotDecoration;
  final Color lineColor;
  final double lineSize;

  const VerticalTimelines(
      {Key? key,
      required this.timelines,
      this.dotDecoration,
      this.lineColor = Colors.black,
      this.lineSize = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: timelines.length,
      itemBuilder: (context, index) {
        var t = timelines[index];
        var lineBeforeColor = index == 0 ? Colors.transparent : lineColor;
        var lineAfterColor =
            index >= timelines.length - 1 ? Colors.transparent : lineColor;
        return Container(
            child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                t.beforeDot ??
                    TimelineLine(color: lineBeforeColor, size: lineSize),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ).copyWith(
                    backgroundBlendMode: dotDecoration?.backgroundBlendMode,
                    border: dotDecoration?.border,
                    borderRadius: dotDecoration?.borderRadius,
                    boxShadow: dotDecoration?.boxShadow,
                    color: dotDecoration?.color,
                    gradient: dotDecoration?.gradient,
                    image: dotDecoration?.image,
                    shape: dotDecoration?.shape,
                  ),
                  padding: EdgeInsets.all(5),
                  child: timelines[index].icon,
                ),
                t.afterDot ??
                    TimelineLine(color: lineAfterColor, size: lineSize),
              ],
            ),
            Expanded(child: timelines[index].content),
          ],
        ));
      },
    );
  }
}

class HorizonTimelines extends StatelessWidget {
  final List<Timeline> timelines;
  final BoxDecoration? dotDecoration;
  final Color lineColor;
  final double lineSize;

  const HorizonTimelines({
    Key? key,
    required this.timelines,
    this.dotDecoration,
    this.lineColor = Colors.black,
    this.lineSize = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: timelines.length,
      itemBuilder: (context, index) {
        var t = timelines[index];
        var lineBeforeColor = index == 0 ? Colors.transparent : lineColor;
        var lineAfterColor =
            index >= timelines.length - 1 ? Colors.transparent : lineColor;
        // return Container(width: 10, height: 10, color: Colors.amberAccent,);
        return Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                t.beforeDot ??
                    TimelineLine(
                      color: lineBeforeColor,
                      size: lineSize,
                      axis: Axis.horizontal,
                    ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ).copyWith(
                    backgroundBlendMode: dotDecoration?.backgroundBlendMode,
                    border: dotDecoration?.border,
                    borderRadius: dotDecoration?.borderRadius,
                    boxShadow: dotDecoration?.boxShadow,
                    color: dotDecoration?.color,
                    gradient: dotDecoration?.gradient,
                    image: dotDecoration?.image,
                    shape: dotDecoration?.shape,
                  ),
                  padding: EdgeInsets.all(5),
                  child: timelines[index].icon,
                ),
                t.afterDot ??
                    TimelineLine(
                      color: lineAfterColor,
                      size: lineSize,
                      axis: Axis.horizontal,
                    ),
              ],
            ));
      },
    );
  }
}


class SampleTimeline extends StatelessWidget {
  _content(String? text) {
    return Card(child: Container(height: 100, child: ListTile(title: Text(text ?? ""))));
  }

  _icon(IconData icon) {
    return Icon(icon, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sample1")),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              child: HorizonTimelines(
                dotDecoration: BoxDecoration(color: Colors.black),
                timelines: [
                  Timeline(content: _content("01"), icon: _icon(Icons.check)),
                  Timeline(content: _content("02"), icon: _icon(Icons.local_shipping)),
                  Timeline(content: _content("03"), icon: _icon(Icons.anchor), afterDot: TimelineLine(color: Colors.green, isDash: true, axis: Axis.horizontal,)),
                  Timeline(content: _content("04"), icon: _icon(Icons.home_filled), beforeDot: TimelineLine(color: Colors.grey, isDash: true, axis: Axis.horizontal,)),
                ],
              ),
            ),
            Divider(),
            VerticalTimelines(
              dotDecoration: BoxDecoration(color: Colors.black),
              timelines: [
                Timeline(content: _content("01"), icon: _icon(Icons.check)),
                Timeline(content: _content("02"), icon: _icon(Icons.local_shipping)),
                Timeline(content: _content("03"), icon: _icon(Icons.anchor), afterDot: TimelineLine(color: Colors.grey, isDash: true,)),
                Timeline(content: _content("04"), icon: _icon(Icons.home_filled), beforeDot: TimelineLine(color: Colors.grey, isDash: true,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
