IBDEI0DH ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13467,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,13467,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,13468,0)
 ;;=F18.959^^58^702^15
 ;;^UTILITY(U,$J,358.3,13468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13468,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,13468,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,13468,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,13469,0)
 ;;=F18.99^^58^702^22
 ;;^UTILITY(U,$J,358.3,13469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13469,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13469,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,13469,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,13470,0)
 ;;=F18.20^^58^702^25
 ;;^UTILITY(U,$J,358.3,13470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13470,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,13470,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,13470,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,13471,0)
 ;;=Z00.6^^58^703^1
 ;;^UTILITY(U,$J,358.3,13471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13471,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,13471,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,13471,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,13472,0)
 ;;=F45.22^^58^704^1
 ;;^UTILITY(U,$J,358.3,13472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13472,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,13472,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,13472,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,13473,0)
 ;;=F45.8^^58^704^16
 ;;^UTILITY(U,$J,358.3,13473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13473,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,13473,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,13473,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,13474,0)
 ;;=F45.0^^58^704^14
 ;;^UTILITY(U,$J,358.3,13474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13474,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,13474,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,13474,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,13475,0)
 ;;=F45.9^^58^704^15
 ;;^UTILITY(U,$J,358.3,13475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13475,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13475,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,13475,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,13476,0)
 ;;=F45.1^^58^704^13
 ;;^UTILITY(U,$J,358.3,13476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13476,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,13476,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,13476,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,13477,0)
 ;;=F44.4^^58^704^2
 ;;^UTILITY(U,$J,358.3,13477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13477,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,13477,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,13477,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,13478,0)
 ;;=F44.6^^58^704^3
 ;;^UTILITY(U,$J,358.3,13478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13478,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,13478,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,13478,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,13479,0)
 ;;=F44.5^^58^704^4
 ;;^UTILITY(U,$J,358.3,13479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13479,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,13479,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,13479,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,13480,0)
 ;;=F44.7^^58^704^5
 ;;^UTILITY(U,$J,358.3,13480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13480,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,13480,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,13480,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,13481,0)
 ;;=F68.10^^58^704^10
 ;;^UTILITY(U,$J,358.3,13481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13481,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,13481,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,13481,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,13482,0)
 ;;=F54.^^58^704^12
 ;;^UTILITY(U,$J,358.3,13482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13482,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,13482,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,13482,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,13483,0)
 ;;=F44.6^^58^704^6
 ;;^UTILITY(U,$J,358.3,13483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13483,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,13483,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,13483,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,13484,0)
 ;;=F44.4^^58^704^7
 ;;^UTILITY(U,$J,358.3,13484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13484,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,13484,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,13484,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,13485,0)
 ;;=F44.4^^58^704^8
 ;;^UTILITY(U,$J,358.3,13485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13485,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
 ;;^UTILITY(U,$J,358.3,13485,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,13485,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,13486,0)
 ;;=F44.4^^58^704^9
 ;;^UTILITY(U,$J,358.3,13486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13486,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,13486,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,13486,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,13487,0)
 ;;=F45.21^^58^704^11
 ;;^UTILITY(U,$J,358.3,13487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13487,1,3,0)
 ;;=3^Illness Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,13487,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,13487,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,13488,0)
 ;;=F91.2^^58^705^1
 ;;^UTILITY(U,$J,358.3,13488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13488,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,13488,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,13488,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,13489,0)
 ;;=F91.1^^58^705^2
 ;;^UTILITY(U,$J,358.3,13489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13489,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,13489,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,13489,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,13490,0)
 ;;=F91.9^^58^705^3
 ;;^UTILITY(U,$J,358.3,13490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13490,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,13490,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,13490,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,13491,0)
 ;;=F63.81^^58^705^6
 ;;^UTILITY(U,$J,358.3,13491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13491,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,13491,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,13491,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,13492,0)
 ;;=F63.2^^58^705^7
 ;;^UTILITY(U,$J,358.3,13492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13492,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,13492,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,13492,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,13493,0)
 ;;=F91.3^^58^705^8
 ;;^UTILITY(U,$J,358.3,13493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13493,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,13493,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,13493,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,13494,0)
 ;;=F63.1^^58^705^9
 ;;^UTILITY(U,$J,358.3,13494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13494,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,13494,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,13494,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,13495,0)
 ;;=F91.8^^58^705^4
 ;;^UTILITY(U,$J,358.3,13495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13495,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
