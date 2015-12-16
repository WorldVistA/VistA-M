IBDEI1VV ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33130,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,33130,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,33130,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,33131,0)
 ;;=M15.0^^182^1998^94
 ;;^UTILITY(U,$J,358.3,33131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33131,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,33131,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,33131,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,33132,0)
 ;;=M06.9^^182^1998^129
 ;;^UTILITY(U,$J,358.3,33132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33132,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,33132,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,33132,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,33133,0)
 ;;=M16.0^^182^1998^97
 ;;^UTILITY(U,$J,358.3,33133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33133,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,33133,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,33133,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,33134,0)
 ;;=M16.11^^182^1998^106
 ;;^UTILITY(U,$J,358.3,33134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33134,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,33134,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,33134,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,33135,0)
 ;;=M16.12^^182^1998^100
 ;;^UTILITY(U,$J,358.3,33135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33135,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,33135,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,33135,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,33136,0)
 ;;=M17.0^^182^1998^96
 ;;^UTILITY(U,$J,358.3,33136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33136,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,33136,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,33136,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,33137,0)
 ;;=M17.11^^182^1998^107
 ;;^UTILITY(U,$J,358.3,33137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33137,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,33137,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,33137,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,33138,0)
 ;;=M17.12^^182^1998^101
 ;;^UTILITY(U,$J,358.3,33138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33138,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,33138,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,33138,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,33139,0)
 ;;=M18.0^^182^1998^95
 ;;^UTILITY(U,$J,358.3,33139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33139,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,33139,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,33139,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,33140,0)
 ;;=M18.11^^182^1998^105
 ;;^UTILITY(U,$J,358.3,33140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33140,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,33140,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,33140,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,33141,0)
 ;;=M18.12^^182^1998^99
 ;;^UTILITY(U,$J,358.3,33141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33141,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,33141,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,33141,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,33142,0)
 ;;=M19.011^^182^1998^108
 ;;^UTILITY(U,$J,358.3,33142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33142,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,33142,1,4,0)
 ;;=4^M19.011
