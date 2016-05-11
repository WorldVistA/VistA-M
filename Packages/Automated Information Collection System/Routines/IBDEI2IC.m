IBDEI2IC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42513,0)
 ;;=W18.40XA^^159^2023^105
 ;;^UTILITY(U,$J,358.3,42513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42513,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,42513,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,42513,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,42514,0)
 ;;=W18.40XD^^159^2023^106
 ;;^UTILITY(U,$J,358.3,42514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42514,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42514,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,42514,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,42515,0)
 ;;=W18.41XA^^159^2023^107
 ;;^UTILITY(U,$J,358.3,42515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42515,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,42515,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,42515,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,42516,0)
 ;;=W18.41XD^^159^2023^108
 ;;^UTILITY(U,$J,358.3,42516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42516,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42516,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,42516,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,42517,0)
 ;;=W18.42XA^^159^2023^109
 ;;^UTILITY(U,$J,358.3,42517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42517,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,42517,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,42517,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,42518,0)
 ;;=W18.42XD^^159^2023^110
 ;;^UTILITY(U,$J,358.3,42518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42518,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42518,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,42518,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,42519,0)
 ;;=W18.43XA^^159^2023^103
 ;;^UTILITY(U,$J,358.3,42519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42519,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,42519,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,42519,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,42520,0)
 ;;=W18.43XD^^159^2023^104
 ;;^UTILITY(U,$J,358.3,42520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42520,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42520,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,42520,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,42521,0)
 ;;=W18.49XA^^159^2023^111
 ;;^UTILITY(U,$J,358.3,42521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42521,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,42521,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,42521,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,42522,0)
 ;;=W18.49XD^^159^2023^112
 ;;^UTILITY(U,$J,358.3,42522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42522,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,42522,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,42522,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,42523,0)
 ;;=W19.XXXA^^159^2023^89
 ;;^UTILITY(U,$J,358.3,42523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42523,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,42523,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,42523,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,42524,0)
 ;;=W19.XXXD^^159^2023^90
 ;;^UTILITY(U,$J,358.3,42524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42524,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
