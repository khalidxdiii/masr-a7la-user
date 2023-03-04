import 'package:flutter/material.dart';

class AhdafScreen extends StatelessWidget {
  const AhdafScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // alignment: Alignment.bottomRight,
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.only(topLeft: Radius.circular(90)),
            color: Colors.teal,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image.asset(
                          "images/logo.gif",
                          height: 130,
                          width: 130,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "images/M.E.T Logo.gif",
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        topRight: Radius.circular(90)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          // ignore: prefer_const_constructors
                          Text(
                            'اهداف المبادرة',
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.right,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      ' التخفيف عن كاهل المواطنين بالتجمعات الاكثر احتياجا فى الريف والمناطق العشوائية فى الخضر.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      textAlign: TextAlign.right,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' التنمية الشاملة للتجمعات الريفية الاكثر احتياجا بهدف القضاء على الفقر متمدد الابعاد لتوفير حياة كريمة مستدامة للمواطنين على مستوى الجمهورية.',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' الارتقاء بالمستوى الاجتماعى والاقتصادى والبيئى للاسر المستهدفة.',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' توفير فرص عمل لتدعين استقلالية المواطنين وتحفيزهم للنهوض بمستوى المعيشة لأسرهم وتجمعاتهم المحلية.',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' اشعار المجتمع المحلى بفارق ايجابى فى مستوى معيشتهم.',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' تنظيم صفوف المجتكع المدنى وتير الثقة فى كافة مؤسسات الدولة.',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'الاستثمار فى تنمية الانسان المصرى.',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' سد الفجوات التنموية بين المراكز والقرى وتوابعها.',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      ' احياء قيم المسؤولية المشتركة بين كافة الجهات الشريكة لتوحيد التنموية فى المراكز والقرى وتوابعها.',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
