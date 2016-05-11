IBDEI0GV ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7799,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,7799,1,4,0)
 ;;=4^W18.12XA
 ;;^UTILITY(U,$J,358.3,7799,2)
 ;;=^5059804
 ;;^UTILITY(U,$J,358.3,7800,0)
 ;;=W18.12XD^^30^415^62
 ;;^UTILITY(U,$J,358.3,7800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7800,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7800,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,7800,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,7801,0)
 ;;=W18.2XXA^^30^415^73
 ;;^UTILITY(U,$J,358.3,7801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7801,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,7801,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,7801,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,7802,0)
 ;;=W18.2XXD^^30^415^74
 ;;^UTILITY(U,$J,358.3,7802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7802,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7802,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,7802,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,7803,0)
 ;;=W18.40XA^^30^415^105
 ;;^UTILITY(U,$J,358.3,7803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7803,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,7803,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,7803,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,7804,0)
 ;;=W18.40XD^^30^415^106
 ;;^UTILITY(U,$J,358.3,7804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7804,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7804,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,7804,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,7805,0)
 ;;=W18.41XA^^30^415^107
 ;;^UTILITY(U,$J,358.3,7805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7805,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,7805,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,7805,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,7806,0)
 ;;=W18.41XD^^30^415^108
 ;;^UTILITY(U,$J,358.3,7806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7806,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7806,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,7806,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,7807,0)
 ;;=W18.42XA^^30^415^109
 ;;^UTILITY(U,$J,358.3,7807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7807,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,7807,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,7807,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,7808,0)
 ;;=W18.42XD^^30^415^110
 ;;^UTILITY(U,$J,358.3,7808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7808,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7808,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,7808,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,7809,0)
 ;;=W18.43XA^^30^415^103
 ;;^UTILITY(U,$J,358.3,7809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7809,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,7809,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,7809,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,7810,0)
 ;;=W18.43XD^^30^415^104
 ;;^UTILITY(U,$J,358.3,7810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7810,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7810,1,4,0)
 ;;=4^W18.43XD
 ;;^UTILITY(U,$J,358.3,7810,2)
 ;;=^5059828
