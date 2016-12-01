IBDEI0UM ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40235,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40235,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,40235,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,40236,0)
 ;;=F18.20^^114^1698^25
 ;;^UTILITY(U,$J,358.3,40236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40236,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,40236,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,40236,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,40237,0)
 ;;=Z00.6^^114^1699^1
 ;;^UTILITY(U,$J,358.3,40237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40237,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,40237,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,40237,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,40238,0)
 ;;=F45.22^^114^1700^1
 ;;^UTILITY(U,$J,358.3,40238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40238,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,40238,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,40238,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,40239,0)
 ;;=F45.8^^114^1700^16
 ;;^UTILITY(U,$J,358.3,40239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40239,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,40239,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,40239,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,40240,0)
 ;;=F45.0^^114^1700^14
 ;;^UTILITY(U,$J,358.3,40240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40240,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,40240,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,40240,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,40241,0)
 ;;=F45.9^^114^1700^15
 ;;^UTILITY(U,$J,358.3,40241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40241,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40241,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,40241,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,40242,0)
 ;;=F45.1^^114^1700^13
 ;;^UTILITY(U,$J,358.3,40242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40242,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,40242,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,40242,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,40243,0)
 ;;=F44.4^^114^1700^2
 ;;^UTILITY(U,$J,358.3,40243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40243,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,40243,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,40243,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,40244,0)
 ;;=F44.6^^114^1700^3
 ;;^UTILITY(U,$J,358.3,40244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40244,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,40244,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,40244,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,40245,0)
 ;;=F44.5^^114^1700^4
 ;;^UTILITY(U,$J,358.3,40245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40245,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,40245,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,40245,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,40246,0)
 ;;=F44.7^^114^1700^5
 ;;^UTILITY(U,$J,358.3,40246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40246,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,40246,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,40246,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,40247,0)
 ;;=F68.10^^114^1700^10
 ;;^UTILITY(U,$J,358.3,40247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40247,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,40247,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,40247,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,40248,0)
 ;;=F54.^^114^1700^12
 ;;^UTILITY(U,$J,358.3,40248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40248,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,40248,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,40248,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,40249,0)
 ;;=F44.6^^114^1700^6
 ;;^UTILITY(U,$J,358.3,40249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40249,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,40249,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,40249,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,40250,0)
 ;;=F44.4^^114^1700^7
 ;;^UTILITY(U,$J,358.3,40250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40250,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,40250,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,40250,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,40251,0)
 ;;=F44.4^^114^1700^8
 ;;^UTILITY(U,$J,358.3,40251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40251,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
 ;;^UTILITY(U,$J,358.3,40251,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,40251,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,40252,0)
 ;;=F44.4^^114^1700^9
 ;;^UTILITY(U,$J,358.3,40252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40252,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,40252,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,40252,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,40253,0)
 ;;=F45.21^^114^1700^11
 ;;^UTILITY(U,$J,358.3,40253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40253,1,3,0)
 ;;=3^Illness Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,40253,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,40253,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,40254,0)
 ;;=F91.2^^114^1701^1
 ;;^UTILITY(U,$J,358.3,40254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40254,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,40254,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,40254,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,40255,0)
 ;;=F91.1^^114^1701^2
 ;;^UTILITY(U,$J,358.3,40255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40255,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,40255,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,40255,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,40256,0)
 ;;=F91.9^^114^1701^3
 ;;^UTILITY(U,$J,358.3,40256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40256,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,40256,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,40256,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,40257,0)
 ;;=F63.81^^114^1701^6
 ;;^UTILITY(U,$J,358.3,40257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40257,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,40257,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,40257,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,40258,0)
 ;;=F63.2^^114^1701^7
 ;;^UTILITY(U,$J,358.3,40258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40258,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,40258,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,40258,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,40259,0)
 ;;=F91.3^^114^1701^8
 ;;^UTILITY(U,$J,358.3,40259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40259,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,40259,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,40259,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,40260,0)
 ;;=F63.1^^114^1701^9
 ;;^UTILITY(U,$J,358.3,40260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40260,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,40260,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,40260,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,40261,0)
 ;;=F91.8^^114^1701^4
 ;;^UTILITY(U,$J,358.3,40261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40261,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,40261,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,40261,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,40262,0)
 ;;=F91.9^^114^1701^5
 ;;^UTILITY(U,$J,358.3,40262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40262,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,40262,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,40262,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,40263,0)
 ;;=F98.0^^114^1702^6
 ;;^UTILITY(U,$J,358.3,40263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40263,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,40263,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,40263,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,40264,0)
 ;;=F98.1^^114^1702^5
 ;;^UTILITY(U,$J,358.3,40264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40264,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,40264,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,40264,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,40265,0)
 ;;=N39.498^^114^1702^3
 ;;^UTILITY(U,$J,358.3,40265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40265,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,40265,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,40265,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,40266,0)
 ;;=R15.9^^114^1702^1
 ;;^UTILITY(U,$J,358.3,40266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40266,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,40266,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,40266,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,40267,0)
 ;;=R32.^^114^1702^4
 ;;^UTILITY(U,$J,358.3,40267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40267,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,40267,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,40267,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,40268,0)
 ;;=R15.9^^114^1702^2
 ;;^UTILITY(U,$J,358.3,40268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40268,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,40268,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,40268,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,40269,0)
 ;;=F63.0^^114^1703^1
 ;;^UTILITY(U,$J,358.3,40269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40269,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,40269,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,40269,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,40270,0)
 ;;=F99.^^114^1704^1
 ;;^UTILITY(U,$J,358.3,40270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40270,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
