IBDEI1UF ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32865,1,4,0)
 ;;=4^W18.11XD
 ;;^UTILITY(U,$J,358.3,32865,2)
 ;;=^5059802
 ;;^UTILITY(U,$J,358.3,32866,0)
 ;;=W18.12XA^^190^1962^61
 ;;^UTILITY(U,$J,358.3,32866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32866,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,32866,1,4,0)
 ;;=4^W18.12XA
 ;;^UTILITY(U,$J,358.3,32866,2)
 ;;=^5059804
 ;;^UTILITY(U,$J,358.3,32867,0)
 ;;=W18.12XD^^190^1962^62
 ;;^UTILITY(U,$J,358.3,32867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32867,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32867,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,32867,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,32868,0)
 ;;=W18.2XXA^^190^1962^69
 ;;^UTILITY(U,$J,358.3,32868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32868,1,3,0)
 ;;=3^Fall into Empty Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,32868,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,32868,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,32869,0)
 ;;=W18.2XXD^^190^1962^70
 ;;^UTILITY(U,$J,358.3,32869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32869,1,3,0)
 ;;=3^Fall into Empty Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32869,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,32869,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,32870,0)
 ;;=W18.40XA^^190^1962^101
 ;;^UTILITY(U,$J,358.3,32870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32870,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,32870,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,32870,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,32871,0)
 ;;=W18.40XD^^190^1962^102
 ;;^UTILITY(U,$J,358.3,32871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32871,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32871,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,32871,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,32872,0)
 ;;=W18.41XA^^190^1962^103
 ;;^UTILITY(U,$J,358.3,32872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32872,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,32872,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,32872,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,32873,0)
 ;;=W18.41XD^^190^1962^104
 ;;^UTILITY(U,$J,358.3,32873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32873,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32873,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,32873,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,32874,0)
 ;;=W18.42XA^^190^1962^105
 ;;^UTILITY(U,$J,358.3,32874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32874,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,32874,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,32874,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,32875,0)
 ;;=W18.42XD^^190^1962^106
 ;;^UTILITY(U,$J,358.3,32875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32875,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32875,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,32875,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,32876,0)
 ;;=W18.43XA^^190^1962^99
 ;;^UTILITY(U,$J,358.3,32876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32876,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,32876,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,32876,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,32877,0)
 ;;=W18.43XD^^190^1962^100
 ;;^UTILITY(U,$J,358.3,32877,1,0)
 ;;=^358.31IA^4^2
