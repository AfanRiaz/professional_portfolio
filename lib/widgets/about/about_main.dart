import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:theming_app/provider/container_provider.dart';
import 'package:theming_app/widgets/components/reusable_container.dart';
import 'package:theming_app/widgets/components/reusable_my_info.dart';

import '../../apis/url_opening.dart';
import '../../themes/custom_themes/text_gradient.dart';

class AboutMain extends StatefulWidget {
  const AboutMain({super.key});

  @override
  State<AboutMain> createState() => _AboutMainState();
}

class _AboutMainState extends State<AboutMain> {
  @override
  Widget build(BuildContext context) {
    final List<StatsModel> statsData = [
      StatsModel(
        icon: Icon(
          Icons.business_center,
          size: 20,
        ),
        number: "1+",
        title: "Year Experience",
      ),

      const StatsModel(
        icon: FaIcon(
          FontAwesomeIcons.diagramProject,
          size: 20,
        ),
        number: "3+",
        title: "Projects Delivered",
      ),

      const StatsModel(
        icon: FaIcon(
          FontAwesomeIcons.brain,
          size: 20,
        ),
        number: "5+",
        title: "Daily AI Tools",
      ),

      const StatsModel(
        icon: FaIcon(
          FontAwesomeIcons.code,
          size: 20,
        ),
        number: "10+",
        title: "Technologies Used",
      ),
    ];

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.07,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          /// ABOUT ME
          Text(
            "About me",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: const Color.fromARGB(255, 79, 89, 145),
              fontWeight: FontWeight.normal,
            ),
          ),

          /// HEADING
          AfanGradientText(
            text: "Passionate about building great products",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 40,
              fontWeight: FontWeight.normal,
              letterSpacing: 0
            ),
          ),

          const SizedBox(height: 10),

          /// DESCRIPTION
          Text(
            "Web and Mobile app developer based in Rawalpindi, Pakistan",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: const Color.fromARGB(255, 79, 89, 145),
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),

          const SizedBox(height: 20),

          /// STATISTICS GRID
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount =
              constraints.maxWidth >= 750 ? 4 : 2;
              final childAspectRatio =
              constraints.maxWidth >= 750
                  ? 1.0
                  : 0.9;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: statsData.length,

                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: childAspectRatio
                ),

                itemBuilder: (context, index) {
                  final stat = statsData[index];

                  return ChangeNotifierProvider(
                    create: (_) => ContainerProvider(),

                    child: ReusableContainer(
                      numberFontSize: 26, text: stat.title, icon: stat.icon, number: stat.number,
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: size.height * 0.1,),
          LayoutBuilder(builder: (context, constraints){
            if(constraints.maxWidth >= 750){
              return rowWidget();
            }
            else{
              return columnWidget();
            }
          })
        ],
      ),
    );
  }
  
  Widget rowWidget(){
    final List<StatsModel> techStackData = [
      const StatsModel(
        icon: Icon(
          Icons.phone_android_outlined,
          size: 20,
        ),
        number: "Flutter Development",
        title: "Cross-platform apps from Figma to production.",
      ),

      const StatsModel(
        icon: Icon(
          Icons.language,
          size: 20,
        ),
        number: "Web Development",
        title: "Flutter web apps",
      ),

      const StatsModel(
        icon: FaIcon(
          FontAwesomeIcons.figma,
          size: 20,
        ),
        number: "UI/UX Design",
        title: "Pixel-perfect Figma prototyping.",
      ),

      const StatsModel(
        icon: Icon(
          Icons.storage_outlined,
          size: 20,
        ),
        number: "API Integration",
        title: "REST APIs, Google Maps & push notifications.",
      ),

      const StatsModel(
        icon: FaIcon(
          FontAwesomeIcons.brain,
          size: 20,
        ),
        number: "AI-Augmented Dev",
        title: "Claude, ChatGPT & Cursor for faster, smarter delivery.",
      ),

      const StatsModel(
        icon: Icon(
          Icons.terminal,
          size: 20,
        ),
        number: "Prompt Engineering",
        title: "Precise, production-ready output from LLMs across any stack.",
      ),
    ];

    final List<InfoStats> infoStats = [
      InfoStats(
          icon: Icon(
            Icons.location_on_sharp,
            size: 20,
          ),
          title: "LOCATION",
          content: Text("Rawalpindi, Pakistan",style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),)
      ),
      InfoStats(
          icon: Icon(
            Icons.email_outlined,
            size: 20,
          ),
          title: "EMAIL",
          content: TextButton(
    style: TextButton.styleFrom(
      backgroundColor: Colors.transparent,
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    alignment: Alignment.centerLeft,
    ),
    onPressed: () {
    final urlOpening = UrlOpening();
    urlOpening.emailUrl();
    },
    child: Text(
    "cadetafan202@gmail.com",
    softWrap: true,
    overflow: TextOverflow.visible,
    style: Theme.of(context).textTheme.titleSmall!.copyWith(
    fontSize: 12,
    ),
    ),
    ),
      ),
      InfoStats(
          icon: Icon(
            Icons.phone,
            size: 20,
          ),
          title: "PHONE",
          content: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
            ),
            onPressed: () {
              final urlOpening = UrlOpening();
              urlOpening.emailUrl();
            },
            child: Text(
              "+92-3415035548",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
      ),
      InfoStats(
          icon: Icon(
            Icons.check_circle,
            size: 20,
          ),
          title: "STATUS",
          content: Text("Open for Opportunities",style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Colors.green
          ),)
      ),
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                child: Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      height: 1.8,
                      letterSpacing: 0.3,
                    ),
                    children: [
                      // Paragraph 1
                      TextSpan(
                        text: "Passionate Mobile & Web Developer ",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      TextSpan(
                        text:
                        "building modern digital experiences with clean code, thoughtful design, and ",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        ),
                      ),

                      TextSpan(
                        text: "AI-powered workflows.",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      TextSpan(
                          text:
                          " I specialize in transforming ideas and complex UI/UX designs into responsive, polished, and maintainable applications.",
                          style: Theme.of(context).textTheme.bodyMedium
                      ),

                      // Space between paragraphs
                      const TextSpan(text: "\n\n"),

                      // Paragraph 2
                      TextSpan(
                        text:
                        "From pixel-perfect interfaces and smooth animations to ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Color.fromARGB(255, 82, 94, 145),
                        ),
                      ),

                      TextSpan(
                        text: "REST APIs",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      TextSpan(
                        text: " and scalable application architecture, I focus on building products that ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Color.fromARGB(255, 82, 94, 145),
                        ),
                      ),

                      TextSpan(
                        text: "look great and work even better.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      // Space between paragraphs
                      const TextSpan(text: "\n\n"),

                      // Paragraph 3
                      TextSpan(
                        text:
                        "By combining strong development skills with the ",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Color.fromARGB(255, 82, 94, 145),
                        ),
                      ),

                      TextSpan(
                        text: "daily use of AI tools",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      TextSpan(
                        text: " like ChatGPT, Claude, Gemini, and Grok, I work faster, solve problems smarter,"
                            " and continuously improve the quality of every project I build.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Color.fromARGB(255, 82, 94, 145),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = (constraints.maxWidth - 20) / 2;

                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,

                      children: infoStats.map((stat) {
                        return SizedBox(
                          width: width,
                          height: 100,

                          child: ChangeNotifierProvider(
                            create: (_) => ContainerProvider(),
                            child: ReusableMyInfo(
                                icon: stat.icon,
                                heading: stat.title,
                                content: stat.content)
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = (constraints.maxWidth - 20) / 2;

              return Wrap(
                spacing: 20,
                runSpacing: 20,

                children: techStackData.map((stat) {
                  return SizedBox(
                    width: width,

                    child: ChangeNotifierProvider(
                      create: (_) => ContainerProvider(),
                      child: ReusableContainer(
                        numberFontSize: 16,
                        text: stat.title,
                        icon: stat.icon,
                        number: stat.number,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        )
      ],
    );
  }
  Widget columnWidget(){
    return Column(
      children: [

      ],
    );
  }
}

class StatsModel {
  final Widget icon;
  final String number;
  final String title;

  const StatsModel({
    required this.icon,
    required this.number,
    required this.title,
  });
}

class InfoStats {
  final Widget icon;
  final String title;
  final Widget content;

  const InfoStats({
    required this.icon,
    required this.title,
    required this.content,
  });
}

