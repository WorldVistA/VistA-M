IBDEI22N ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35129,0)
 ;;=W18.40XA^^131^1699^105
 ;;^UTILITY(U,$J,358.3,35129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35129,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,35129,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,35129,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,35130,0)
 ;;=W18.40XD^^131^1699^106
 ;;^UTILITY(U,$J,358.3,35130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35130,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35130,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,35130,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,35131,0)
 ;;=W18.41XA^^131^1699^107
 ;;^UTILITY(U,$J,358.3,35131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35131,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,35131,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,35131,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,35132,0)
 ;;=W18.41XD^^131^1699^108
 ;;^UTILITY(U,$J,358.3,35132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35132,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35132,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,35132,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,35133,0)
 ;;=W18.42XA^^131^1699^109
 ;;^UTILITY(U,$J,358.3,35133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35133,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,35133,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,35133,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,35134,0)
 ;;=W18.42XD^^131^1699^110
 ;;^UTILITY(U,$J,358.3,35134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35134,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35134,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,35134,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,35135,0)
 ;;=W18.43XA^^131^1699^103
 ;;^UTILITY(U,$J,358.3,35135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35135,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,35135,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,35135,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,35136,0)
 ;;=W18.43XD^^131^1699^104
 ;;^UTILITY(U,$J,358.3,35136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35136,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35136,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,35136,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,35137,0)
 ;;=W18.49XA^^131^1699^111
 ;;^UTILITY(U,$J,358.3,35137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35137,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,35137,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,35137,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,35138,0)
 ;;=W18.49XD^^131^1699^112
 ;;^UTILITY(U,$J,358.3,35138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35138,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,35138,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,35138,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,35139,0)
 ;;=W19.XXXA^^131^1699^89
 ;;^UTILITY(U,$J,358.3,35139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35139,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,35139,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,35139,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,35140,0)
 ;;=W19.XXXD^^131^1699^90
 ;;^UTILITY(U,$J,358.3,35140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35140,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
