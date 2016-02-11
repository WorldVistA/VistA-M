IBDEI3CF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,56172,0)
 ;;=W18.40XA^^256^2794^105
 ;;^UTILITY(U,$J,358.3,56172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56172,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,56172,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,56172,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,56173,0)
 ;;=W18.40XD^^256^2794^106
 ;;^UTILITY(U,$J,358.3,56173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56173,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,56173,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,56173,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,56174,0)
 ;;=W18.41XA^^256^2794^107
 ;;^UTILITY(U,$J,358.3,56174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56174,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,56174,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,56174,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,56175,0)
 ;;=W18.41XD^^256^2794^108
 ;;^UTILITY(U,$J,358.3,56175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56175,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,56175,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,56175,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,56176,0)
 ;;=W18.42XA^^256^2794^109
 ;;^UTILITY(U,$J,358.3,56176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56176,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,56176,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,56176,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,56177,0)
 ;;=W18.42XD^^256^2794^110
 ;;^UTILITY(U,$J,358.3,56177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56177,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,56177,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,56177,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,56178,0)
 ;;=W18.43XA^^256^2794^103
 ;;^UTILITY(U,$J,358.3,56178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56178,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,56178,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,56178,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,56179,0)
 ;;=W18.43XD^^256^2794^104
 ;;^UTILITY(U,$J,358.3,56179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56179,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,56179,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,56179,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,56180,0)
 ;;=W18.49XA^^256^2794^111
 ;;^UTILITY(U,$J,358.3,56180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56180,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,56180,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,56180,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,56181,0)
 ;;=W18.49XD^^256^2794^112
 ;;^UTILITY(U,$J,358.3,56181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56181,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,56181,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,56181,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,56182,0)
 ;;=W19.XXXA^^256^2794^89
 ;;^UTILITY(U,$J,358.3,56182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56182,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,56182,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,56182,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,56183,0)
 ;;=W19.XXXD^^256^2794^90
 ;;^UTILITY(U,$J,358.3,56183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56183,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
