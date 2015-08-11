IBDEI1SV ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32146,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Unspec
 ;;^UTILITY(U,$J,358.3,32146,1,4,0)
 ;;=4^M32.9
 ;;^UTILITY(U,$J,358.3,32146,2)
 ;;=^5011761
 ;;^UTILITY(U,$J,358.3,32147,0)
 ;;=M32.0^^190^1949^148
 ;;^UTILITY(U,$J,358.3,32147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32147,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Drug-Induced
 ;;^UTILITY(U,$J,358.3,32147,1,4,0)
 ;;=4^M32.0
 ;;^UTILITY(U,$J,358.3,32147,2)
 ;;=^5011752
 ;;^UTILITY(U,$J,358.3,32148,0)
 ;;=M32.13^^190^1949^150
 ;;^UTILITY(U,$J,358.3,32148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32148,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Lung Involvement
 ;;^UTILITY(U,$J,358.3,32148,1,4,0)
 ;;=4^M32.13
 ;;^UTILITY(U,$J,358.3,32148,2)
 ;;=^5011756
 ;;^UTILITY(U,$J,358.3,32149,0)
 ;;=M32.14^^190^1949^149
 ;;^UTILITY(U,$J,358.3,32149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32149,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Glomerular Disease
 ;;^UTILITY(U,$J,358.3,32149,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,32149,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,32150,0)
 ;;=M32.12^^190^1949^151
 ;;^UTILITY(U,$J,358.3,32150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32150,1,3,0)
 ;;=3^Systemic Lupus Erythematosus,Pericarditis
 ;;^UTILITY(U,$J,358.3,32150,1,4,0)
 ;;=4^M32.12
 ;;^UTILITY(U,$J,358.3,32150,2)
 ;;=^5011755
 ;;^UTILITY(U,$J,358.3,32151,0)
 ;;=M05.59^^190^1949^132
 ;;^UTILITY(U,$J,358.3,32151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32151,1,3,0)
 ;;=3^Rheumatoid Polyneuropathy w/ Rheumatoid Arthritis of Mult Sites
 ;;^UTILITY(U,$J,358.3,32151,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,32151,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,32152,0)
 ;;=M05.711^^190^1949^126
 ;;^UTILITY(U,$J,358.3,32152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32152,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,32152,1,4,0)
 ;;=4^M05.711
 ;;^UTILITY(U,$J,358.3,32152,2)
 ;;=^5010001
 ;;^UTILITY(U,$J,358.3,32153,0)
 ;;=M05.712^^190^1949^119
 ;;^UTILITY(U,$J,358.3,32153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32153,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,32153,1,4,0)
 ;;=4^M05.712
 ;;^UTILITY(U,$J,358.3,32153,2)
 ;;=^5010002
 ;;^UTILITY(U,$J,358.3,32154,0)
 ;;=M05.731^^190^1949^127
 ;;^UTILITY(U,$J,358.3,32154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32154,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,32154,1,4,0)
 ;;=4^M05.731
 ;;^UTILITY(U,$J,358.3,32154,2)
 ;;=^5010007
 ;;^UTILITY(U,$J,358.3,32155,0)
 ;;=M05.732^^190^1949^120
 ;;^UTILITY(U,$J,358.3,32155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32155,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,32155,1,4,0)
 ;;=4^M05.732
 ;;^UTILITY(U,$J,358.3,32155,2)
 ;;=^5010008
 ;;^UTILITY(U,$J,358.3,32156,0)
 ;;=M05.741^^190^1949^123
 ;;^UTILITY(U,$J,358.3,32156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32156,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,32156,1,4,0)
 ;;=4^M05.741
 ;;^UTILITY(U,$J,358.3,32156,2)
 ;;=^5010010
 ;;^UTILITY(U,$J,358.3,32157,0)
 ;;=M05.742^^190^1949^116
 ;;^UTILITY(U,$J,358.3,32157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32157,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,32157,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,32157,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,32158,0)
 ;;=M05.751^^190^1949^124
 ;;^UTILITY(U,$J,358.3,32158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32158,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,32158,1,4,0)
 ;;=4^M05.751
