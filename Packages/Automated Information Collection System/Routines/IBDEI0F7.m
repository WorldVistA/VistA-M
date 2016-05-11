IBDEI0F7 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7008,1,4,0)
 ;;=4^M05.741
 ;;^UTILITY(U,$J,358.3,7008,2)
 ;;=^5010010
 ;;^UTILITY(U,$J,358.3,7009,0)
 ;;=M05.742^^30^402^134
 ;;^UTILITY(U,$J,358.3,7009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7009,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,7009,1,4,0)
 ;;=4^M05.742
 ;;^UTILITY(U,$J,358.3,7009,2)
 ;;=^5010011
 ;;^UTILITY(U,$J,358.3,7010,0)
 ;;=M05.751^^30^402^142
 ;;^UTILITY(U,$J,358.3,7010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7010,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Hip
 ;;^UTILITY(U,$J,358.3,7010,1,4,0)
 ;;=4^M05.751
 ;;^UTILITY(U,$J,358.3,7010,2)
 ;;=^5010013
 ;;^UTILITY(U,$J,358.3,7011,0)
 ;;=M05.752^^30^402^135
 ;;^UTILITY(U,$J,358.3,7011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7011,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,7011,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,7011,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,7012,0)
 ;;=M05.761^^30^402^143
 ;;^UTILITY(U,$J,358.3,7012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7012,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,7012,1,4,0)
 ;;=4^M05.761
 ;;^UTILITY(U,$J,358.3,7012,2)
 ;;=^5010016
 ;;^UTILITY(U,$J,358.3,7013,0)
 ;;=M05.762^^30^402^136
 ;;^UTILITY(U,$J,358.3,7013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7013,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,7013,1,4,0)
 ;;=4^M05.762
 ;;^UTILITY(U,$J,358.3,7013,2)
 ;;=^5010017
 ;;^UTILITY(U,$J,358.3,7014,0)
 ;;=M05.771^^30^402^140
 ;;^UTILITY(U,$J,358.3,7014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7014,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Ankle
 ;;^UTILITY(U,$J,358.3,7014,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,7014,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,7015,0)
 ;;=M05.772^^30^402^133
 ;;^UTILITY(U,$J,358.3,7015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7015,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Ankle
 ;;^UTILITY(U,$J,358.3,7015,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,7015,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,7016,0)
 ;;=M05.79^^30^402^139
 ;;^UTILITY(U,$J,358.3,7016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7016,1,3,0)
 ;;=3^Rheumatoid Arthritis of Multiple Sites
 ;;^UTILITY(U,$J,358.3,7016,1,4,0)
 ;;=4^M05.79
 ;;^UTILITY(U,$J,358.3,7016,2)
 ;;=^5010022
 ;;^UTILITY(U,$J,358.3,7017,0)
 ;;=M06.00^^30^402^146
 ;;^UTILITY(U,$J,358.3,7017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7017,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,7017,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,7017,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,7018,0)
 ;;=M06.30^^30^402^149
 ;;^UTILITY(U,$J,358.3,7018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7018,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,7018,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,7018,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,7019,0)
 ;;=M06.4^^30^402^48
 ;;^UTILITY(U,$J,358.3,7019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7019,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,7019,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,7019,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,7020,0)
 ;;=M06.39^^30^402^148
 ;;^UTILITY(U,$J,358.3,7020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7020,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,7020,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,7020,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,7021,0)
 ;;=M15.0^^30^402^112
 ;;^UTILITY(U,$J,358.3,7021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7021,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,7021,1,4,0)
 ;;=4^M15.0
