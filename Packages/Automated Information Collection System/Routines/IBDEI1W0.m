IBDEI1W0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32050,1,3,0)
 ;;=3^Disp fx of cuboid bone of lft ft, init
 ;;^UTILITY(U,$J,358.3,32050,1,4,0)
 ;;=4^S92.212A
 ;;^UTILITY(U,$J,358.3,32050,2)
 ;;=^5044843
 ;;^UTILITY(U,$J,358.3,32051,0)
 ;;=S92.214A^^126^1609^311
 ;;^UTILITY(U,$J,358.3,32051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32051,1,3,0)
 ;;=3^Nondisp fx of cuboid bone of rt ft, init
 ;;^UTILITY(U,$J,358.3,32051,1,4,0)
 ;;=4^S92.214A
 ;;^UTILITY(U,$J,358.3,32051,2)
 ;;=^5044857
 ;;^UTILITY(U,$J,358.3,32052,0)
 ;;=S92.215A^^126^1609^310
 ;;^UTILITY(U,$J,358.3,32052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32052,1,3,0)
 ;;=3^Nondisp fx of cuboid bone of lft ft, init
 ;;^UTILITY(U,$J,358.3,32052,1,4,0)
 ;;=4^S92.215A
 ;;^UTILITY(U,$J,358.3,32052,2)
 ;;=^5044864
 ;;^UTILITY(U,$J,358.3,32053,0)
 ;;=S92.244A^^126^1609^335
 ;;^UTILITY(U,$J,358.3,32053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32053,1,3,0)
 ;;=3^Nondisp fx of medial cuneiform of rt ft, init
 ;;^UTILITY(U,$J,358.3,32053,1,4,0)
 ;;=4^S92.244A
 ;;^UTILITY(U,$J,358.3,32053,2)
 ;;=^5044983
 ;;^UTILITY(U,$J,358.3,32054,0)
 ;;=S92.245A^^126^1609^334
 ;;^UTILITY(U,$J,358.3,32054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32054,1,3,0)
 ;;=3^Nondisp fx of medial cuneiform of lft ft, init
 ;;^UTILITY(U,$J,358.3,32054,1,4,0)
 ;;=4^S92.245A
 ;;^UTILITY(U,$J,358.3,32054,2)
 ;;=^5044990
 ;;^UTILITY(U,$J,358.3,32055,0)
 ;;=S92.221A^^126^1609^100
 ;;^UTILITY(U,$J,358.3,32055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32055,1,3,0)
 ;;=3^Disp fx of ltrl cuneiform of rt ft, init
 ;;^UTILITY(U,$J,358.3,32055,1,4,0)
 ;;=4^S92.221A
 ;;^UTILITY(U,$J,358.3,32055,2)
 ;;=^5044878
 ;;^UTILITY(U,$J,358.3,32056,0)
 ;;=S92.222A^^126^1609^99
 ;;^UTILITY(U,$J,358.3,32056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32056,1,3,0)
 ;;=3^Disp fx of ltrl cuneiform of lft ft, init
 ;;^UTILITY(U,$J,358.3,32056,1,4,0)
 ;;=4^S92.222A
 ;;^UTILITY(U,$J,358.3,32056,2)
 ;;=^5044885
 ;;^UTILITY(U,$J,358.3,32057,0)
 ;;=S92.224A^^126^1609^325
 ;;^UTILITY(U,$J,358.3,32057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32057,1,3,0)
 ;;=3^Nondisp fx of ltrl cuneiform of rt ft, init
 ;;^UTILITY(U,$J,358.3,32057,1,4,0)
 ;;=4^S92.224A
 ;;^UTILITY(U,$J,358.3,32057,2)
 ;;=^5044899
 ;;^UTILITY(U,$J,358.3,32058,0)
 ;;=S92.225A^^126^1609^324
 ;;^UTILITY(U,$J,358.3,32058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32058,1,3,0)
 ;;=3^Nondisp fx of ltrl cuneiform of lft ft, init
 ;;^UTILITY(U,$J,358.3,32058,1,4,0)
 ;;=4^S92.225A
 ;;^UTILITY(U,$J,358.3,32058,2)
 ;;=^5044906
 ;;^UTILITY(U,$J,358.3,32059,0)
 ;;=S92.231A^^126^1609^96
 ;;^UTILITY(U,$J,358.3,32059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32059,1,3,0)
 ;;=3^Disp fx of intermed cuneiform of rt ft, init
 ;;^UTILITY(U,$J,358.3,32059,1,4,0)
 ;;=4^S92.231A
 ;;^UTILITY(U,$J,358.3,32059,2)
 ;;=^5044920
 ;;^UTILITY(U,$J,358.3,32060,0)
 ;;=S92.232A^^126^1609^95
 ;;^UTILITY(U,$J,358.3,32060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32060,1,3,0)
 ;;=3^Disp fx of intermed cuneiform of lft ft, init
 ;;^UTILITY(U,$J,358.3,32060,1,4,0)
 ;;=4^S92.232A
 ;;^UTILITY(U,$J,358.3,32060,2)
 ;;=^5044927
 ;;^UTILITY(U,$J,358.3,32061,0)
 ;;=S92.234A^^126^1609^319
 ;;^UTILITY(U,$J,358.3,32061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32061,1,3,0)
 ;;=3^Nondisp fx of intermed cuneiform of rt ft, init
 ;;^UTILITY(U,$J,358.3,32061,1,4,0)
 ;;=4^S92.234A
 ;;^UTILITY(U,$J,358.3,32061,2)
 ;;=^5044941
 ;;^UTILITY(U,$J,358.3,32062,0)
 ;;=S92.235A^^126^1609^318
 ;;^UTILITY(U,$J,358.3,32062,1,0)
 ;;=^358.31IA^4^2
