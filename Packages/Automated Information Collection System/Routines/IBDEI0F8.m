IBDEI0F8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7021,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,7022,0)
 ;;=M06.9^^30^402^147
 ;;^UTILITY(U,$J,358.3,7022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7022,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,7022,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,7022,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,7023,0)
 ;;=M16.0^^30^402^115
 ;;^UTILITY(U,$J,358.3,7023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7023,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
 ;;^UTILITY(U,$J,358.3,7023,1,4,0)
 ;;=4^M16.0
 ;;^UTILITY(U,$J,358.3,7023,2)
 ;;=^5010769
 ;;^UTILITY(U,$J,358.3,7024,0)
 ;;=M16.11^^30^402^124
 ;;^UTILITY(U,$J,358.3,7024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7024,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,7024,1,4,0)
 ;;=4^M16.11
 ;;^UTILITY(U,$J,358.3,7024,2)
 ;;=^5010771
 ;;^UTILITY(U,$J,358.3,7025,0)
 ;;=M16.12^^30^402^118
 ;;^UTILITY(U,$J,358.3,7025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7025,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,7025,1,4,0)
 ;;=4^M16.12
 ;;^UTILITY(U,$J,358.3,7025,2)
 ;;=^5010772
 ;;^UTILITY(U,$J,358.3,7026,0)
 ;;=M17.0^^30^402^114
 ;;^UTILITY(U,$J,358.3,7026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7026,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral Knees
 ;;^UTILITY(U,$J,358.3,7026,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,7026,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,7027,0)
 ;;=M17.11^^30^402^125
 ;;^UTILITY(U,$J,358.3,7027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7027,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,7027,1,4,0)
 ;;=4^M17.11
 ;;^UTILITY(U,$J,358.3,7027,2)
 ;;=^5010786
 ;;^UTILITY(U,$J,358.3,7028,0)
 ;;=M17.12^^30^402^119
 ;;^UTILITY(U,$J,358.3,7028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7028,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,7028,1,4,0)
 ;;=4^M17.12
 ;;^UTILITY(U,$J,358.3,7028,2)
 ;;=^5010787
 ;;^UTILITY(U,$J,358.3,7029,0)
 ;;=M18.0^^30^402^113
 ;;^UTILITY(U,$J,358.3,7029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7029,1,3,0)
 ;;=3^Primary Osteoarthritis of Bilateral 1st Carpometacarp Jts
 ;;^UTILITY(U,$J,358.3,7029,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,7029,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,7030,0)
 ;;=M18.11^^30^402^123
 ;;^UTILITY(U,$J,358.3,7030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7030,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,7030,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,7030,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,7031,0)
 ;;=M18.12^^30^402^117
 ;;^UTILITY(U,$J,358.3,7031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7031,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,7031,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,7031,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,7032,0)
 ;;=M19.011^^30^402^126
 ;;^UTILITY(U,$J,358.3,7032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7032,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,7032,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,7032,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,7033,0)
 ;;=M19.012^^30^402^120
 ;;^UTILITY(U,$J,358.3,7033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7033,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,7033,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,7033,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,7034,0)
 ;;=M19.031^^30^402^127
 ;;^UTILITY(U,$J,358.3,7034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7034,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
