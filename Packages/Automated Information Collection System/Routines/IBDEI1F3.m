IBDEI1F3 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22678,1,2,0)
 ;;=2^Critical Care,1st Hr
 ;;^UTILITY(U,$J,358.3,22678,1,3,0)
 ;;=3^99291
 ;;^UTILITY(U,$J,358.3,22679,0)
 ;;=99292^^104^1156^2^^^^1
 ;;^UTILITY(U,$J,358.3,22679,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22679,1,2,0)
 ;;=2^Critical Care,Ea Addl 30 Min
 ;;^UTILITY(U,$J,358.3,22679,1,3,0)
 ;;=3^99292
 ;;^UTILITY(U,$J,358.3,22680,0)
 ;;=99366^^104^1157^1^^^^1
 ;;^UTILITY(U,$J,358.3,22680,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22680,1,2,0)
 ;;=2^IDT Conf w/ Pt/Family,Physician 30+ min
 ;;^UTILITY(U,$J,358.3,22680,1,3,0)
 ;;=3^99366
 ;;^UTILITY(U,$J,358.3,22681,0)
 ;;=99367^^104^1157^2^^^^1
 ;;^UTILITY(U,$J,358.3,22681,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22681,1,2,0)
 ;;=2^IDT Conf w/o Pt/Family,Physician 30+ min
 ;;^UTILITY(U,$J,358.3,22681,1,3,0)
 ;;=3^99367
 ;;^UTILITY(U,$J,358.3,22682,0)
 ;;=99368^^104^1157^3^^^^1
 ;;^UTILITY(U,$J,358.3,22682,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22682,1,2,0)
 ;;=2^IDT Conf w/o Pt/Family,Nonphys 30+ min
 ;;^UTILITY(U,$J,358.3,22682,1,3,0)
 ;;=3^99368
 ;;^UTILITY(U,$J,358.3,22683,0)
 ;;=S0221^^104^1157^5^^^^1
 ;;^UTILITY(U,$J,358.3,22683,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22683,1,2,0)
 ;;=2^Med Conf by Phys w/ IDT and PT;60 min
 ;;^UTILITY(U,$J,358.3,22683,1,3,0)
 ;;=3^S0221
 ;;^UTILITY(U,$J,358.3,22684,0)
 ;;=S0220^^104^1157^4^^^^1
 ;;^UTILITY(U,$J,358.3,22684,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22684,1,2,0)
 ;;=2^Med Conf by Phys w/ IDT and PT;30 min
 ;;^UTILITY(U,$J,358.3,22684,1,3,0)
 ;;=3^S0220
 ;;^UTILITY(U,$J,358.3,22685,0)
 ;;=99357^^104^1158^2^^^^1
 ;;^UTILITY(U,$J,358.3,22685,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22685,1,2,0)
 ;;=2^Prolonged Inpt/Obs Service,Ea Addl 30 Min
 ;;^UTILITY(U,$J,358.3,22685,1,3,0)
 ;;=3^99357
 ;;^UTILITY(U,$J,358.3,22686,0)
 ;;=99356^^104^1158^1^^^^1
 ;;^UTILITY(U,$J,358.3,22686,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22686,1,2,0)
 ;;=2^Prolonged Inpt/Obs Service,1st Hr
 ;;^UTILITY(U,$J,358.3,22686,1,3,0)
 ;;=3^99356
 ;;^UTILITY(U,$J,358.3,22687,0)
 ;;=49082^^104^1159^2^^^^1
 ;;^UTILITY(U,$J,358.3,22687,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22687,1,2,0)
 ;;=2^Abdominal Paracentesis w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,22687,1,3,0)
 ;;=3^49082
 ;;^UTILITY(U,$J,358.3,22688,0)
 ;;=49083^^104^1159^1^^^^1
 ;;^UTILITY(U,$J,358.3,22688,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22688,1,2,0)
 ;;=2^Abdominal Paracentesis w/ Image Guidance
 ;;^UTILITY(U,$J,358.3,22688,1,3,0)
 ;;=3^49083
 ;;^UTILITY(U,$J,358.3,22689,0)
 ;;=32554^^104^1159^13^^^^1
 ;;^UTILITY(U,$J,358.3,22689,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22689,1,2,0)
 ;;=2^Thoracentesis w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,22689,1,3,0)
 ;;=3^32554
 ;;^UTILITY(U,$J,358.3,22690,0)
 ;;=32555^^104^1159^12^^^^1
 ;;^UTILITY(U,$J,358.3,22690,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22690,1,2,0)
 ;;=2^Thoracentesis w/ Image Guidance
 ;;^UTILITY(U,$J,358.3,22690,1,3,0)
 ;;=3^32555
 ;;^UTILITY(U,$J,358.3,22691,0)
 ;;=20610^^104^1159^4^^^^1
 ;;^UTILITY(U,$J,358.3,22691,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22691,1,2,0)
 ;;=2^Arthrocentesis,Major Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,22691,1,3,0)
 ;;=3^20610
 ;;^UTILITY(U,$J,358.3,22692,0)
 ;;=20611^^104^1159^3^^^^1
 ;;^UTILITY(U,$J,358.3,22692,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22692,1,2,0)
 ;;=2^Arthrocentesis,Major Jt w/ US Guidance
