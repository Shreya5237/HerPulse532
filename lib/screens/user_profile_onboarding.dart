import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class UserProfileOnboarding extends StatefulWidget {
  @override
  _UserProfileOnboardingState createState() => _UserProfileOnboardingState();
}

class _UserProfileOnboardingState extends State<UserProfileOnboarding> {
  final PageController _controller = PageController();
  int _page = 0;

  // User Data
  String nickname = '';
  DateTime? dob;
  String phase = 'Menstrual';
  double stress = 5;
  double height = 160;
  double weight = 60;
  bool regularPeriods = true;
  final List<String> allConditions = [
    'None', 'PCOS', 'Thyroid', 'Endometriosis', 'Diabetes', 'Hypertension', 'Asthma', 'Other'
  ];
  final List<String> selectedConditions = [];
  String customCondition = '';
  bool onBirthControl = false;
  String birthControlType = 'Pill';
  String goal = '';

  List<Widget> get _questions => [
        _buildWelcome(),
        _buildName(),
        _buildDOB(),
        _buildPhase(),
        _buildStress(),
        _buildHeightWeight(),
        _buildPeriodsRegular(),
        _buildConditions(),
        _buildBirthControl(),
        _buildGoal(),
        _buildComplete(),
      ];

  void _next() {
    if (_page < _questions.length - 1) {
      _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF2D0A50),
        elevation: 0,
        title: Text('HerPulse Setup', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildProgress(),
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: _controller,
              itemCount: _questions.length,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (_, __) => AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _questions[_page],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFF8A3FFC),
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: Text(_page < _questions.length - 1 ? 'Next' : 'Finish', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    final total = _questions.length;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: (_page + 1) / total,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Color(0xFFFF5CA8)),
            ),
          ),
          Text('${_page + 1}/$total', style: TextStyle(color: Color(0xFF2D0A50), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _questionContainer(Widget child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: child,
      );

  Widget _buildWelcome() => _questionContainer(
        Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.favorite, size: 64, color: Color(0xFFFF5CA8)),
          SizedBox(height: 16),
          Text('Hey there!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2D0A50))),
          SizedBox(height: 8),
          Text('Im HerPulse 🤖, lets set you up for a healthier journey!', textAlign: TextAlign.center),
        ]),
      );

  Widget _buildName() => _questionContainer(
        Column(children: [
          Text('What should I call you?', style: TextStyle(fontSize: 22, color: Color(0xFF2D0A50))),
          SizedBox(height: 16),
          TextField(
            onChanged: (v) => nickname = v,
            decoration: InputDecoration(
              hintText: 'Your nickname',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ]),
      );

  Widget _buildDOB() => _questionContainer(
        Column(children: [
          Text('When did you arrive on Earth?', style: TextStyle(fontSize: 22, color: Color(0xFF2D0A50))),
          SizedBox(height: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFF8A3FFC)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (d != null) setState(() => dob = d);
            },
            child: Text(dob == null ? 'Select your DOB' : dob!.toShortDateString(), style: TextStyle(color: Color(0xFF2D0A50))),
          ),
        ]),
      );

  Widget _buildPhase() => _questionContainer(
        Column(children: [
          Text('Which life stage are you in?', style: TextStyle(fontSize: 22, color: Color(0xFF2D0A50))),
          SizedBox(height: 16),
          Wrap(spacing: 12, children: ['Puberty', 'Menstrual', 'Pregnancy', 'Postpartum'].map((p) {
            return ChoiceChip(
              label: Text(p),
              selectedColor: Color(0xFF8A3FFC),
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(color: phase == p ? Colors.white : Color(0xFF2D0A50)),
              selected: phase == p,
              onSelected: (_) => setState(() => phase = p),
            );
          }).toList()),
        ]),
      );

  Widget _buildStress() => _questionContainer(
        Column(children: [
          Text('On a scale of 0-10, how stressed are you today?', style: TextStyle(fontSize: 20, color: Color(0xFF2D0A50))),
          Slider(
            min: 0,
            max: 10,
            divisions: 10,
            label: stress.round().toString(),
            activeColor: Color(0xFFFF5CA8),
            inactiveColor: Colors.grey[300],
            value: stress,
            onChanged: (v) => setState(() => stress = v),
          ),
        ]),
      );

  Widget _buildHeightWeight() => _questionContainer(
        Column(children: [
          Text('Tell me your height & weight', style: TextStyle(fontSize: 20, color: Color(0xFF2D0A50))),
          SizedBox(height: 16),
          Row(children: [
            Expanded(child: Column(children: [Text('${height.round()} cm'), Slider(min:100,max:220,value:height,activeColor:Color(0xFF8A3FFC),onChanged:(v)=>setState(()=>height=v))])),
            SizedBox(width:16),
            Expanded(child: Column(children: [Text('${weight.round()} kg'), Slider(min:40,max:150,value:weight,activeColor:Color(0xFF8A3FFC),onChanged:(v)=>setState(()=>weight=v))])),
          ]),
        ]),
      );

  Widget _buildPeriodsRegular() => _questionContainer(
        Column(children: [
          Text('Are your periods regular?', style: TextStyle(fontSize:20, color: Color(0xFF2D0A50))),
          SizedBox(height:16),
          Wrap(spacing:12, children:[
            ChoiceChip(label:Text('Yes'), selectedColor:Color(0xFF8A3FFC),selected:regularPeriods,onSelected:(_)=>setState(()=>regularPeriods=true)),
            ChoiceChip(label:Text('No'), selectedColor:Color(0xFF8A3FFC),selected:!regularPeriods,onSelected:(_)=>setState(()=>regularPeriods=false)),
          ]),
        ]),
      );

  Widget _buildConditions() => _questionContainer(
        Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('Any known health conditions?', style:TextStyle(fontSize:20, color: Color(0xFF2D0A50))),
          SizedBox(height:16),
          Wrap(spacing:8,children: allConditions.map((c) {
            final selected = selectedConditions.contains(c);
            return FilterChip(
              label: Text(c),
              selectedColor: Color(0xFF8A3FFC),
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(color: selected?Colors.white:Color(0xFF2D0A50)),
              selected: selected,
              onSelected: (val) => setState(() {
                if(val) selectedConditions.add(c); else selectedConditions.remove(c);
                if(c=='None'&&val) selectedConditions.clear();
              }),
            );
          }).toList()),
          if(selectedConditions.contains('Other')) SizedBox(height:16),
          if(selectedConditions.contains('Other')) TextField(
            onChanged:(v)=>customCondition=v,
            decoration:InputDecoration(
              hintText:'Type your condition',
              border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
            ),
          ),
        ]),
      );

  Widget _buildBirthControl() => _questionContainer(
        Column(children:[
          Text('On birth control?', style:TextStyle(fontSize:20, color: Color(0xFF2D0A50))),
          SizedBox(height:16),
          Wrap(spacing:12,children:[
            ChoiceChip(label:Text('Yes'),selectedColor:Color(0xFF8A3FFC),selected:onBirthControl,onSelected:(_)=>setState(()=>onBirthControl=true)),
            ChoiceChip(label:Text('No'),selectedColor:Color(0xFF8A3FFC),selected:!onBirthControl,onSelected:(_)=>setState(()=>onBirthControl=false)),
          ]),
          if(onBirthControl) Padding(
            padding:const EdgeInsets.only(top:16),
            child: DropdownButtonFormField<String>(
              value: birthControlType,
              items: ['Pill','IUD','Injection','Implant'].map((t) => DropdownMenuItem(value:t, child:Text(t))).toList(),
              onChanged:(v)=>setState(()=>birthControlType=v!),
              decoration:InputDecoration(
                labelText:'Type',
                border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
              ),
            ),
          ),
        ]),
      );

  Widget _buildGoal() => _questionContainer(
        Column(children:[
          Text('What’s your main health goal?', style:TextStyle(fontSize:20, color: Color(0xFF2D0A50))),
          SizedBox(height:16),
          TextField(
            onChanged:(v)=>goal=v,
            decoration:InputDecoration(
              hintText:'E.g. Reduce stress, balance hormones',
              border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)),
            ),
          ),
        ]),
      );

  Widget _buildComplete() {
    final name = nickname.isNotEmpty ? nickname : 'Friend';
    return _questionContainer(
      Column(mainAxisSize:MainAxisSize.min,children:[
        Text('All set, $name!', style:TextStyle(fontSize:24,fontWeight:FontWeight.bold, color: Color(0xFF2D0A50))),
        SizedBox(height:16),
        Text('Connecting your wearable now...'),
        SizedBox(height:24),
        ElevatedButton(
          onPressed:()=>Navigator.pushReplacementNamed(context,'/home'),
          style:ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Color(0xFF8A3FFC),
            padding:EdgeInsets.symmetric(horizontal:40,vertical:16),
            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(24))
          ),
          child:Text('Let’s Go!', style:TextStyle(fontSize:16)),
        ),
      ]),
    );
  }
}

extension DateHelpers on DateTime {
  String toShortDateString() => "\${day}/\${month}/\${year}";
}