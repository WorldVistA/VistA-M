IBDEI0GN ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7215,0)
 ;;=G47.00^^58^472^13
 ;;^UTILITY(U,$J,358.3,7215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7215,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,7215,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,7215,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,7216,0)
 ;;=F40.11^^58^472^28
 ;;^UTILITY(U,$J,358.3,7216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7216,1,3,0)
 ;;=3^Social Phobia,Generalized
 ;;^UTILITY(U,$J,358.3,7216,1,4,0)
 ;;=4^F40.11
 ;;^UTILITY(U,$J,358.3,7216,2)
 ;;=^5003545
 ;;^UTILITY(U,$J,358.3,7217,0)
 ;;=F06.31^^58^472^16
 ;;^UTILITY(U,$J,358.3,7217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7217,1,3,0)
 ;;=3^Mood Disorder d/t Physiological Cond w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,7217,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,7217,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,7218,0)
 ;;=F20.0^^58^472^22
 ;;^UTILITY(U,$J,358.3,7218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7218,1,3,0)
 ;;=3^Paranoid Schizophrenia
 ;;^UTILITY(U,$J,358.3,7218,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,7218,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,7219,0)
 ;;=F42.2^^58^472^15
 ;;^UTILITY(U,$J,358.3,7219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7219,1,3,0)
 ;;=3^Mixed Obsessional Thoughts & Acts
 ;;^UTILITY(U,$J,358.3,7219,1,4,0)
 ;;=4^F42.2
 ;;^UTILITY(U,$J,358.3,7219,2)
 ;;=^5138444
 ;;^UTILITY(U,$J,358.3,7220,0)
 ;;=F42.3^^58^472^12
 ;;^UTILITY(U,$J,358.3,7220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7220,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,7220,1,4,0)
 ;;=4^F42.3
 ;;^UTILITY(U,$J,358.3,7220,2)
 ;;=^5138445
 ;;^UTILITY(U,$J,358.3,7221,0)
 ;;=F42.4^^58^472^9
 ;;^UTILITY(U,$J,358.3,7221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7221,1,3,0)
 ;;=3^Excoriation Disorder
 ;;^UTILITY(U,$J,358.3,7221,1,4,0)
 ;;=4^F42.4
 ;;^UTILITY(U,$J,358.3,7221,2)
 ;;=^5138446
 ;;^UTILITY(U,$J,358.3,7222,0)
 ;;=F42.8^^58^472^17
 ;;^UTILITY(U,$J,358.3,7222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7222,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder,Other
 ;;^UTILITY(U,$J,358.3,7222,1,4,0)
 ;;=4^F42.8
 ;;^UTILITY(U,$J,358.3,7222,2)
 ;;=^5138447
 ;;^UTILITY(U,$J,358.3,7223,0)
 ;;=F42.9^^58^472^18
 ;;^UTILITY(U,$J,358.3,7223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7223,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,7223,1,4,0)
 ;;=4^F42.9
 ;;^UTILITY(U,$J,358.3,7223,2)
 ;;=^5138448
 ;;^UTILITY(U,$J,358.3,7224,0)
 ;;=M02.30^^58^473^144
 ;;^UTILITY(U,$J,358.3,7224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7224,1,3,0)
 ;;=3^Reiter's Disease,Unspec Site
 ;;^UTILITY(U,$J,358.3,7224,1,4,0)
 ;;=4^M02.30
 ;;^UTILITY(U,$J,358.3,7224,2)
 ;;=^5009790
 ;;^UTILITY(U,$J,358.3,7225,0)
 ;;=M10.9^^58^473^40
 ;;^UTILITY(U,$J,358.3,7225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7225,1,3,0)
 ;;=3^Gout,Unspec
 ;;^UTILITY(U,$J,358.3,7225,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,7225,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,7226,0)
 ;;=G90.59^^58^473^34
 ;;^UTILITY(U,$J,358.3,7226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7226,1,3,0)
 ;;=3^Complex Regional Pain Syndrome I,Unspec
 ;;^UTILITY(U,$J,358.3,7226,1,4,0)
 ;;=4^G90.59
 ;;^UTILITY(U,$J,358.3,7226,2)
 ;;=^5004171
 ;;^UTILITY(U,$J,358.3,7227,0)
 ;;=G56.01^^58^473^12
 ;;^UTILITY(U,$J,358.3,7227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7227,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
