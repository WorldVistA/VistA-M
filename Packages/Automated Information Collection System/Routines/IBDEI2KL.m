IBDEI2KL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43107,1,3,0)
 ;;=3^Traum subdr hem w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,43107,1,4,0)
 ;;=4^S06.5X3A
 ;;^UTILITY(U,$J,358.3,43107,2)
 ;;=^5021065
 ;;^UTILITY(U,$J,358.3,43108,0)
 ;;=S06.5X4A^^195^2167^48
 ;;^UTILITY(U,$J,358.3,43108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43108,1,3,0)
 ;;=3^Traum subdr hem w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,43108,1,4,0)
 ;;=4^S06.5X4A
 ;;^UTILITY(U,$J,358.3,43108,2)
 ;;=^5021068
 ;;^UTILITY(U,$J,358.3,43109,0)
 ;;=S06.5X5A^^195^2167^43
 ;;^UTILITY(U,$J,358.3,43109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43109,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,43109,1,4,0)
 ;;=4^S06.5X5A
 ;;^UTILITY(U,$J,358.3,43109,2)
 ;;=^5021071
 ;;^UTILITY(U,$J,358.3,43110,0)
 ;;=S06.5X6A^^195^2167^44
 ;;^UTILITY(U,$J,358.3,43110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43110,1,3,0)
 ;;=3^Traum subdr hem w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,43110,1,4,0)
 ;;=4^S06.5X6A
 ;;^UTILITY(U,$J,358.3,43110,2)
 ;;=^5021074
 ;;^UTILITY(U,$J,358.3,43111,0)
 ;;=S06.5X7A^^195^2167^50
 ;;^UTILITY(U,$J,358.3,43111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43111,1,3,0)
 ;;=3^Traum subdr hem w LOC w dth d/t brain inj bef reg consc,init
 ;;^UTILITY(U,$J,358.3,43111,1,4,0)
 ;;=4^S06.5X7A
 ;;^UTILITY(U,$J,358.3,43111,2)
 ;;=^5021077
 ;;^UTILITY(U,$J,358.3,43112,0)
 ;;=S06.5X8A^^195^2167^51
 ;;^UTILITY(U,$J,358.3,43112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43112,1,3,0)
 ;;=3^Traum subdr hem w LOC w dth d/t oth cause bef reg consc,init
 ;;^UTILITY(U,$J,358.3,43112,1,4,0)
 ;;=4^S06.5X8A
 ;;^UTILITY(U,$J,358.3,43112,2)
 ;;=^5021080
 ;;^UTILITY(U,$J,358.3,43113,0)
 ;;=S06.5X0S^^195^2167^54
 ;;^UTILITY(U,$J,358.3,43113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43113,1,3,0)
 ;;=3^Traum subdr hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,43113,1,4,0)
 ;;=4^S06.5X0S
 ;;^UTILITY(U,$J,358.3,43113,2)
 ;;=^5021058
 ;;^UTILITY(U,$J,358.3,43114,0)
 ;;=S06.5X8S^^195^2167^52
 ;;^UTILITY(U,$J,358.3,43114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43114,1,3,0)
 ;;=3^Traum subdr hem w LOC w dth d/t oth cause bef reg consc,sqla
 ;;^UTILITY(U,$J,358.3,43114,1,4,0)
 ;;=4^S06.5X8S
 ;;^UTILITY(U,$J,358.3,43114,2)
 ;;=^5021082
 ;;^UTILITY(U,$J,358.3,43115,0)
 ;;=S06.5X9S^^195^2167^49
 ;;^UTILITY(U,$J,358.3,43115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43115,1,3,0)
 ;;=3^Traum subdr hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,43115,1,4,0)
 ;;=4^S06.5X9S
 ;;^UTILITY(U,$J,358.3,43115,2)
 ;;=^5021085
 ;;^UTILITY(U,$J,358.3,43116,0)
 ;;=S06.6X0A^^195^2167^73
 ;;^UTILITY(U,$J,358.3,43116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43116,1,3,0)
 ;;=3^Traum subrac hem w/o LOC, init
 ;;^UTILITY(U,$J,358.3,43116,1,4,0)
 ;;=4^S06.6X0A
 ;;^UTILITY(U,$J,358.3,43116,2)
 ;;=^5021086
 ;;^UTILITY(U,$J,358.3,43117,0)
 ;;=S06.6X2D^^195^2167^63
 ;;^UTILITY(U,$J,358.3,43117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43117,1,3,0)
 ;;=3^Traum subrac hem w LOC of 31-59 min, subs
 ;;^UTILITY(U,$J,358.3,43117,1,4,0)
 ;;=4^S06.6X2D
 ;;^UTILITY(U,$J,358.3,43117,2)
 ;;=^5021093
 ;;^UTILITY(U,$J,358.3,43118,0)
 ;;=S06.6X3D^^195^2167^59
 ;;^UTILITY(U,$J,358.3,43118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43118,1,3,0)
 ;;=3^Traum subrac hem w LOC of 1-5 hrs 59 min, subs
 ;;^UTILITY(U,$J,358.3,43118,1,4,0)
 ;;=4^S06.6X3D
 ;;^UTILITY(U,$J,358.3,43118,2)
 ;;=^5021096
 ;;^UTILITY(U,$J,358.3,43119,0)
 ;;=S06.6X4D^^195^2167^64
 ;;^UTILITY(U,$J,358.3,43119,1,0)
 ;;=^358.31IA^4^2
