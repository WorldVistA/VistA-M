IBDEI1E4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23619,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,23620,0)
 ;;=W18.40XD^^87^1000^106
 ;;^UTILITY(U,$J,358.3,23620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23620,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23620,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,23620,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,23621,0)
 ;;=W18.41XA^^87^1000^107
 ;;^UTILITY(U,$J,358.3,23621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23621,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,23621,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,23621,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,23622,0)
 ;;=W18.41XD^^87^1000^108
 ;;^UTILITY(U,$J,358.3,23622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23622,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23622,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,23622,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,23623,0)
 ;;=W18.42XA^^87^1000^109
 ;;^UTILITY(U,$J,358.3,23623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23623,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,23623,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,23623,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,23624,0)
 ;;=W18.42XD^^87^1000^110
 ;;^UTILITY(U,$J,358.3,23624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23624,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23624,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,23624,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,23625,0)
 ;;=W18.43XA^^87^1000^103
 ;;^UTILITY(U,$J,358.3,23625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23625,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,23625,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,23625,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,23626,0)
 ;;=W18.43XD^^87^1000^104
 ;;^UTILITY(U,$J,358.3,23626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23626,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23626,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,23626,2)
 ;;=^5059828
 ;;^UTILITY(U,$J,358.3,23627,0)
 ;;=W18.49XA^^87^1000^111
 ;;^UTILITY(U,$J,358.3,23627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23627,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,23627,1,4,0)
 ;;=4^W18.49XA
 ;;^UTILITY(U,$J,358.3,23627,2)
 ;;=^5059830
 ;;^UTILITY(U,$J,358.3,23628,0)
 ;;=W18.49XD^^87^1000^112
 ;;^UTILITY(U,$J,358.3,23628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23628,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling NEC,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23628,1,4,0)
 ;;=4^W18.49XD
 ;;^UTILITY(U,$J,358.3,23628,2)
 ;;=^5059831
 ;;^UTILITY(U,$J,358.3,23629,0)
 ;;=W19.XXXA^^87^1000^89
 ;;^UTILITY(U,$J,358.3,23629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23629,1,3,0)
 ;;=3^Fall,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,23629,1,4,0)
 ;;=4^W19.XXXA
 ;;^UTILITY(U,$J,358.3,23629,2)
 ;;=^5059833
 ;;^UTILITY(U,$J,358.3,23630,0)
 ;;=W19.XXXD^^87^1000^90
 ;;^UTILITY(U,$J,358.3,23630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23630,1,3,0)
 ;;=3^Fall,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,23630,1,4,0)
 ;;=4^W19.XXXD
 ;;^UTILITY(U,$J,358.3,23630,2)
 ;;=^5059834
 ;;^UTILITY(U,$J,358.3,23631,0)
 ;;=W54.0XXA^^87^1000^11
 ;;^UTILITY(U,$J,358.3,23631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23631,1,3,0)
 ;;=3^Bitten by Dog,Init Encntr
