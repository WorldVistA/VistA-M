IBDEI0NQ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10680,1,3,0)
 ;;=3^Avoidant/Restrictive Food Intake Disorder
 ;;^UTILITY(U,$J,358.3,10680,1,4,0)
 ;;=4^F50.89
 ;;^UTILITY(U,$J,358.3,10680,2)
 ;;=^5138449
 ;;^UTILITY(U,$J,358.3,10681,0)
 ;;=F50.81^^42^475^4
 ;;^UTILITY(U,$J,358.3,10681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10681,1,3,0)
 ;;=3^Binge-Eating Disorder
 ;;^UTILITY(U,$J,358.3,10681,1,4,0)
 ;;=4^F50.81
 ;;^UTILITY(U,$J,358.3,10681,2)
 ;;=^8123226
 ;;^UTILITY(U,$J,358.3,10682,0)
 ;;=F50.89^^42^475^6
 ;;^UTILITY(U,$J,358.3,10682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10682,1,3,0)
 ;;=3^Feeding/Eating Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,10682,1,4,0)
 ;;=4^F50.89
 ;;^UTILITY(U,$J,358.3,10682,2)
 ;;=^5138449
 ;;^UTILITY(U,$J,358.3,10683,0)
 ;;=F50.89^^42^475^8
 ;;^UTILITY(U,$J,358.3,10683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10683,1,3,0)
 ;;=3^Pica in Adults
 ;;^UTILITY(U,$J,358.3,10683,1,4,0)
 ;;=4^F50.89
 ;;^UTILITY(U,$J,358.3,10683,2)
 ;;=^5138449
 ;;^UTILITY(U,$J,358.3,10684,0)
 ;;=Z55.9^^42^476^3
 ;;^UTILITY(U,$J,358.3,10684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10684,1,3,0)
 ;;=3^Literacy & Educ Problems,Unspec
 ;;^UTILITY(U,$J,358.3,10684,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,10684,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,10685,0)
 ;;=Z56.82^^42^476^5
 ;;^UTILITY(U,$J,358.3,10685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10685,1,3,0)
 ;;=3^Problems Related to Current Military Deployment Status
 ;;^UTILITY(U,$J,358.3,10685,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,10685,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,10686,0)
 ;;=Z55.0^^42^476^2
 ;;^UTILITY(U,$J,358.3,10686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10686,1,3,0)
 ;;=3^Illiteracy & Low-Level Literacy
 ;;^UTILITY(U,$J,358.3,10686,1,4,0)
 ;;=4^Z55.0
 ;;^UTILITY(U,$J,358.3,10686,2)
 ;;=^5063100
 ;;^UTILITY(U,$J,358.3,10687,0)
 ;;=Z55.8^^42^476^6
 ;;^UTILITY(U,$J,358.3,10687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10687,1,3,0)
 ;;=3^Problems Related to Education & Literacy,Other
 ;;^UTILITY(U,$J,358.3,10687,1,4,0)
 ;;=4^Z55.8
 ;;^UTILITY(U,$J,358.3,10687,2)
 ;;=^5063105
 ;;^UTILITY(U,$J,358.3,10688,0)
 ;;=Z56.0^^42^476^7
 ;;^UTILITY(U,$J,358.3,10688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10688,1,3,0)
 ;;=3^Unemployment,Unspec
 ;;^UTILITY(U,$J,358.3,10688,1,4,0)
 ;;=4^Z56.0
 ;;^UTILITY(U,$J,358.3,10688,2)
 ;;=^5063107
 ;;^UTILITY(U,$J,358.3,10689,0)
 ;;=Z56.4^^42^476^1
 ;;^UTILITY(U,$J,358.3,10689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10689,1,3,0)
 ;;=3^Discord w/ Boss & Workmates
 ;;^UTILITY(U,$J,358.3,10689,1,4,0)
 ;;=4^Z56.4
 ;;^UTILITY(U,$J,358.3,10689,2)
 ;;=^5063111
 ;;^UTILITY(U,$J,358.3,10690,0)
 ;;=Z56.6^^42^476^4
 ;;^UTILITY(U,$J,358.3,10690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10690,1,3,0)
 ;;=3^Physical/Mental Strain Related to Work,Other
 ;;^UTILITY(U,$J,358.3,10690,1,4,0)
 ;;=4^Z56.6
 ;;^UTILITY(U,$J,358.3,10690,2)
 ;;=^5063113
 ;;^UTILITY(U,$J,358.3,10691,0)
 ;;=F64.1^^42^477^1
 ;;^UTILITY(U,$J,358.3,10691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10691,1,3,0)
 ;;=3^Gender Dysphoria in Adolescents & Adults
 ;;^UTILITY(U,$J,358.3,10691,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,10691,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,10692,0)
 ;;=F64.8^^42^477^2
 ;;^UTILITY(U,$J,358.3,10692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10692,1,3,0)
 ;;=3^Gender Dysphoria,Other Specified
