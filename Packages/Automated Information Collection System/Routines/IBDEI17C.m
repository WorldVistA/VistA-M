IBDEI17C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20082,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20082,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,20082,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,20083,0)
 ;;=W18.40XA^^94^935^105
 ;;^UTILITY(U,$J,358.3,20083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20083,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,20083,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,20083,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,20084,0)
 ;;=W18.40XD^^94^935^106
 ;;^UTILITY(U,$J,358.3,20084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20084,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20084,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,20084,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,20085,0)
 ;;=W18.41XA^^94^935^107
 ;;^UTILITY(U,$J,358.3,20085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20085,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,20085,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,20085,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,20086,0)
 ;;=W18.41XD^^94^935^108
 ;;^UTILITY(U,$J,358.3,20086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20086,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20086,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,20086,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,20087,0)
 ;;=W18.42XA^^94^935^109
 ;;^UTILITY(U,$J,358.3,20087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20087,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,20087,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,20087,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,20088,0)
 ;;=W18.42XD^^94^935^110
 ;;^UTILITY(U,$J,358.3,20088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20088,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20088,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,20088,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,20089,0)
 ;;=W18.43XA^^94^935^103
 ;;^UTILITY(U,$J,358.3,20089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20089,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,20089,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,20089,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,20090,0)
 ;;=W18.43XD^^94^935^104
 ;;^UTILITY(U,$J,358.3,20090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20090,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20090,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,20090,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,20091,0)
 ;;=W18.49XA^^94^935^111
 ;;^UTILITY(U,$J,358.3,20091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20091,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,20091,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,20091,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,20092,0)
 ;;=W18.49XD^^94^935^112
 ;;^UTILITY(U,$J,358.3,20092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20092,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,20092,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,20092,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,20093,0)
 ;;=W19.XXXA^^94^935^89
 ;;^UTILITY(U,$J,358.3,20093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20093,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,20093,1,4,0)
 ;;=4^W19.XXXA
