IBDEI18L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20682,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20682,1,2,0)
 ;;=2^G0437
 ;;^UTILITY(U,$J,358.3,20682,1,3,0)
 ;;=3^Tob/Smoking Cess Counsel Asymp Pt > 10min
 ;;^UTILITY(U,$J,358.3,20683,0)
 ;;=96101^^98^975^14^^^^1
 ;;^UTILITY(U,$J,358.3,20683,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20683,1,2,0)
 ;;=2^96101
 ;;^UTILITY(U,$J,358.3,20683,1,3,0)
 ;;=3^Psych Test by Psychologist,per hr
 ;;^UTILITY(U,$J,358.3,20684,0)
 ;;=90899^^98^975^25^^^^1
 ;;^UTILITY(U,$J,358.3,20684,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20684,1,2,0)
 ;;=2^90899
 ;;^UTILITY(U,$J,358.3,20684,1,3,0)
 ;;=3^Unlisted Psychiatric Service
 ;;^UTILITY(U,$J,358.3,20685,0)
 ;;=96150^^98^976^1^^^^1
 ;;^UTILITY(U,$J,358.3,20685,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20685,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,20685,1,3,0)
 ;;=3^Behavior Assess,Initial,ea 15min
 ;;^UTILITY(U,$J,358.3,20686,0)
 ;;=96151^^98^976^2^^^^1
 ;;^UTILITY(U,$J,358.3,20686,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20686,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,20686,1,3,0)
 ;;=3^Behavior Reassess,ea 15min
 ;;^UTILITY(U,$J,358.3,20687,0)
 ;;=96152^^98^976^3^^^^1
 ;;^UTILITY(U,$J,358.3,20687,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20687,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,20687,1,3,0)
 ;;=3^Behavior Intervent,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,20688,0)
 ;;=96153^^98^976^4^^^^1
 ;;^UTILITY(U,$J,358.3,20688,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20688,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,20688,1,3,0)
 ;;=3^Behavior Intervent,Grp,ea 15min
 ;;^UTILITY(U,$J,358.3,20689,0)
 ;;=96154^^98^976^5^^^^1
 ;;^UTILITY(U,$J,358.3,20689,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20689,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,20689,1,3,0)
 ;;=3^Behavior Intervent,Fam w/Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,20690,0)
 ;;=96155^^98^976^6^^^^1
 ;;^UTILITY(U,$J,358.3,20690,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20690,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,20690,1,3,0)
 ;;=3^Behavior Intervent,Fam w/o Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,20691,0)
 ;;=99368^^98^977^2^^^^1
 ;;^UTILITY(U,$J,358.3,20691,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20691,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,20691,1,3,0)
 ;;=3^Non-phys Team Conf w/o Pt &/or Family 30+ min
 ;;^UTILITY(U,$J,358.3,20692,0)
 ;;=99366^^98^977^1^^^^1
 ;;^UTILITY(U,$J,358.3,20692,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20692,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,20692,1,3,0)
 ;;=3^Non-phys Team Conf w/ Pt &/or Family 30+ min
 ;;^UTILITY(U,$J,358.3,20693,0)
 ;;=90785^^98^978^1^^^^1
 ;;^UTILITY(U,$J,358.3,20693,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20693,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,20693,1,3,0)
 ;;=3^Interactive Complexity
 ;;^UTILITY(U,$J,358.3,20694,0)
 ;;=H0001^^98^979^1^^^^1
 ;;^UTILITY(U,$J,358.3,20694,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20694,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,20694,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,20695,0)
 ;;=H0002^^98^979^10^^^^1
 ;;^UTILITY(U,$J,358.3,20695,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20695,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,20695,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,20696,0)
 ;;=H0003^^98^979^6^^^^1
 ;;^UTILITY(U,$J,358.3,20696,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20696,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,20696,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,20697,0)
 ;;=H0004^^98^979^7^^^^1
 ;;^UTILITY(U,$J,358.3,20697,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20697,1,2,0)
 ;;=2^H0004
