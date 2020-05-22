IBDEI2MB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41803,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left hip 
 ;;^UTILITY(U,$J,358.3,41803,1,4,0)
 ;;=4^M06.052
 ;;^UTILITY(U,$J,358.3,41803,2)
 ;;=^5010061
 ;;^UTILITY(U,$J,358.3,41804,0)
 ;;=M06.062^^155^2064^109
 ;;^UTILITY(U,$J,358.3,41804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41804,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left knee 
 ;;^UTILITY(U,$J,358.3,41804,1,4,0)
 ;;=4^M06.062
 ;;^UTILITY(U,$J,358.3,41804,2)
 ;;=^5010064
 ;;^UTILITY(U,$J,358.3,41805,0)
 ;;=M06.012^^155^2064^110
 ;;^UTILITY(U,$J,358.3,41805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41805,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left shoulder
 ;;^UTILITY(U,$J,358.3,41805,1,4,0)
 ;;=4^M06.012
 ;;^UTILITY(U,$J,358.3,41805,2)
 ;;=^5010049
 ;;^UTILITY(U,$J,358.3,41806,0)
 ;;=M06.032^^155^2064^111
 ;;^UTILITY(U,$J,358.3,41806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41806,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, left wrist 
 ;;^UTILITY(U,$J,358.3,41806,1,4,0)
 ;;=4^M06.032
 ;;^UTILITY(U,$J,358.3,41806,2)
 ;;=^5010055
 ;;^UTILITY(U,$J,358.3,41807,0)
 ;;=M06.071^^155^2064^112
 ;;^UTILITY(U,$J,358.3,41807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41807,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right ank/ft 
 ;;^UTILITY(U,$J,358.3,41807,1,4,0)
 ;;=4^M06.071
 ;;^UTILITY(U,$J,358.3,41807,2)
 ;;=^5010066
 ;;^UTILITY(U,$J,358.3,41808,0)
 ;;=M06.021^^155^2064^113
 ;;^UTILITY(U,$J,358.3,41808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41808,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right elbow 
 ;;^UTILITY(U,$J,358.3,41808,1,4,0)
 ;;=4^M06.021
 ;;^UTILITY(U,$J,358.3,41808,2)
 ;;=^5010051
 ;;^UTILITY(U,$J,358.3,41809,0)
 ;;=M06.041^^155^2064^114
 ;;^UTILITY(U,$J,358.3,41809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41809,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right hand 
 ;;^UTILITY(U,$J,358.3,41809,1,4,0)
 ;;=4^M06.041
 ;;^UTILITY(U,$J,358.3,41809,2)
 ;;=^5010057
 ;;^UTILITY(U,$J,358.3,41810,0)
 ;;=M06.051^^155^2064^115
 ;;^UTILITY(U,$J,358.3,41810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41810,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right hip 
 ;;^UTILITY(U,$J,358.3,41810,1,4,0)
 ;;=4^M06.051
 ;;^UTILITY(U,$J,358.3,41810,2)
 ;;=^5010060
 ;;^UTILITY(U,$J,358.3,41811,0)
 ;;=M06.061^^155^2064^116
 ;;^UTILITY(U,$J,358.3,41811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41811,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right knee
 ;;^UTILITY(U,$J,358.3,41811,1,4,0)
 ;;=4^M06.061
 ;;^UTILITY(U,$J,358.3,41811,2)
 ;;=^5010063
 ;;^UTILITY(U,$J,358.3,41812,0)
 ;;=M06.011^^155^2064^117
 ;;^UTILITY(U,$J,358.3,41812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41812,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right shoulder
 ;;^UTILITY(U,$J,358.3,41812,1,4,0)
 ;;=4^M06.011
 ;;^UTILITY(U,$J,358.3,41812,2)
 ;;=^5010048
 ;;^UTILITY(U,$J,358.3,41813,0)
 ;;=M06.031^^155^2064^118
 ;;^UTILITY(U,$J,358.3,41813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41813,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, right wrist 
 ;;^UTILITY(U,$J,358.3,41813,1,4,0)
 ;;=4^M06.031
 ;;^UTILITY(U,$J,358.3,41813,2)
 ;;=^5010054
 ;;^UTILITY(U,$J,358.3,41814,0)
 ;;=M06.08^^155^2064^119
 ;;^UTILITY(U,$J,358.3,41814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41814,1,3,0)
 ;;=3^Rheu arthrit w/o rheumatoid factor, vertebrae
