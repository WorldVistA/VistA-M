IBDEI0KS ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26298,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,26298,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,26299,0)
 ;;=F44.4^^69^1092^9
 ;;^UTILITY(U,$J,358.3,26299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26299,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,26299,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,26299,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,26300,0)
 ;;=F45.21^^69^1092^11
 ;;^UTILITY(U,$J,358.3,26300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26300,1,3,0)
 ;;=3^Illness Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,26300,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,26300,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,26301,0)
 ;;=F91.2^^69^1093^1
 ;;^UTILITY(U,$J,358.3,26301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26301,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,26301,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,26301,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,26302,0)
 ;;=F91.1^^69^1093^2
 ;;^UTILITY(U,$J,358.3,26302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26302,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,26302,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,26302,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,26303,0)
 ;;=F91.9^^69^1093^3
 ;;^UTILITY(U,$J,358.3,26303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26303,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,26303,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,26303,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,26304,0)
 ;;=F63.81^^69^1093^6
 ;;^UTILITY(U,$J,358.3,26304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26304,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,26304,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,26304,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,26305,0)
 ;;=F63.2^^69^1093^7
 ;;^UTILITY(U,$J,358.3,26305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26305,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,26305,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,26305,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,26306,0)
 ;;=F91.3^^69^1093^8
 ;;^UTILITY(U,$J,358.3,26306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26306,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,26306,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,26306,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,26307,0)
 ;;=F63.1^^69^1093^9
 ;;^UTILITY(U,$J,358.3,26307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26307,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,26307,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,26307,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,26308,0)
 ;;=F91.8^^69^1093^4
 ;;^UTILITY(U,$J,358.3,26308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26308,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,26308,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,26308,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,26309,0)
 ;;=F91.9^^69^1093^5
 ;;^UTILITY(U,$J,358.3,26309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26309,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26309,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,26309,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,26310,0)
 ;;=F98.0^^69^1094^6
 ;;^UTILITY(U,$J,358.3,26310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26310,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,26310,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,26310,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,26311,0)
 ;;=F98.1^^69^1094^5
 ;;^UTILITY(U,$J,358.3,26311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26311,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,26311,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,26311,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,26312,0)
 ;;=N39.498^^69^1094^3
 ;;^UTILITY(U,$J,358.3,26312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26312,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,26312,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,26312,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,26313,0)
 ;;=R15.9^^69^1094^1
 ;;^UTILITY(U,$J,358.3,26313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26313,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,26313,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,26313,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,26314,0)
 ;;=R32.^^69^1094^4
 ;;^UTILITY(U,$J,358.3,26314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26314,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,26314,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,26314,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,26315,0)
 ;;=R15.9^^69^1094^2
 ;;^UTILITY(U,$J,358.3,26315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26315,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,26315,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,26315,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,26316,0)
 ;;=F63.0^^69^1095^1
 ;;^UTILITY(U,$J,358.3,26316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26316,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,26316,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,26316,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,26317,0)
 ;;=F99.^^69^1096^1
 ;;^UTILITY(U,$J,358.3,26317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26317,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,26317,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,26317,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,26318,0)
 ;;=F06.8^^69^1096^3
 ;;^UTILITY(U,$J,358.3,26318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26318,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,26318,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,26318,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,26319,0)
 ;;=F09.^^69^1096^4
 ;;^UTILITY(U,$J,358.3,26319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26319,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,26319,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,26319,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,26320,0)
 ;;=F99.^^69^1096^2
 ;;^UTILITY(U,$J,358.3,26320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26320,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26320,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,26320,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,26321,0)
 ;;=F84.0^^69^1097^7
 ;;^UTILITY(U,$J,358.3,26321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26321,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,26321,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,26321,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,26322,0)
 ;;=F80.9^^69^1097^10
 ;;^UTILITY(U,$J,358.3,26322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26322,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26322,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,26322,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,26323,0)
 ;;=F82.^^69^1097^11
 ;;^UTILITY(U,$J,358.3,26323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26323,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,26323,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,26323,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,26324,0)
 ;;=F88.^^69^1097^12
 ;;^UTILITY(U,$J,358.3,26324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26324,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,26324,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,26324,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,26325,0)
 ;;=F80.2^^69^1097^18
 ;;^UTILITY(U,$J,358.3,26325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26325,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,26325,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,26325,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,26326,0)
 ;;=F81.2^^69^1097^19
 ;;^UTILITY(U,$J,358.3,26326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26326,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,26326,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,26326,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,26327,0)
 ;;=F81.0^^69^1097^20
 ;;^UTILITY(U,$J,358.3,26327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26327,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,26327,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,26327,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,26328,0)
 ;;=F81.81^^69^1097^21
 ;;^UTILITY(U,$J,358.3,26328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26328,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,26328,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,26328,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,26329,0)
 ;;=F88.^^69^1097^22
 ;;^UTILITY(U,$J,358.3,26329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26329,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,26329,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,26329,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,26330,0)
 ;;=F89.^^69^1097^23
 ;;^UTILITY(U,$J,358.3,26330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26330,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26330,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,26330,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,26331,0)
 ;;=F95.1^^69^1097^24
 ;;^UTILITY(U,$J,358.3,26331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26331,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,26331,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,26331,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,26332,0)
 ;;=F95.0^^69^1097^26
 ;;^UTILITY(U,$J,358.3,26332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26332,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,26332,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,26332,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,26333,0)
 ;;=F80.89^^69^1097^27
 ;;^UTILITY(U,$J,358.3,26333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26333,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,26333,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,26333,2)
 ;;=^5003677
