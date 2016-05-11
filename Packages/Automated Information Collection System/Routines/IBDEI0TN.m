IBDEI0TN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13902,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,13902,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,13902,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,13903,0)
 ;;=M06.39^^53^599^157
 ;;^UTILITY(U,$J,358.3,13903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13903,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,13903,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,13903,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,13904,0)
 ;;=M15.0^^53^599^121
 ;;^UTILITY(U,$J,358.3,13904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13904,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,13904,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,13904,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,13905,0)
 ;;=M06.9^^53^599^156
 ;;^UTILITY(U,$J,358.3,13905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13905,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,13905,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,13905,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,13906,0)
 ;;=M16.0^^53^599^124
 ;;^UTILITY(U,$J,358.3,13906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13906,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,13906,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,13906,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,13907,0)
 ;;=M16.11^^53^599^133
 ;;^UTILITY(U,$J,358.3,13907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13907,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,13907,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,13907,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,13908,0)
 ;;=M16.12^^53^599^127
 ;;^UTILITY(U,$J,358.3,13908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13908,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,13908,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,13908,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,13909,0)
 ;;=M17.0^^53^599^123
 ;;^UTILITY(U,$J,358.3,13909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13909,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,13909,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,13909,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,13910,0)
 ;;=M17.11^^53^599^134
 ;;^UTILITY(U,$J,358.3,13910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13910,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,13910,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,13910,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,13911,0)
 ;;=M17.12^^53^599^128
 ;;^UTILITY(U,$J,358.3,13911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13911,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,13911,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,13911,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,13912,0)
 ;;=M18.0^^53^599^122
 ;;^UTILITY(U,$J,358.3,13912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13912,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,13912,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,13912,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,13913,0)
 ;;=M18.11^^53^599^132
 ;;^UTILITY(U,$J,358.3,13913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13913,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,13913,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,13913,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,13914,0)
 ;;=M18.12^^53^599^126
 ;;^UTILITY(U,$J,358.3,13914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13914,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,13914,1,4,0)
 ;;=4^M18.12
