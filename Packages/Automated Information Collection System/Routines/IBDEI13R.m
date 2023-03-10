IBDEI13R ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17895,1,4,0)
 ;;=4^W18.12XA
 ;;^UTILITY(U,$J,358.3,17895,2)
 ;;=^5059804
 ;;^UTILITY(U,$J,358.3,17896,0)
 ;;=W18.12XD^^61^794^67
 ;;^UTILITY(U,$J,358.3,17896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17896,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17896,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,17896,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,17897,0)
 ;;=W18.2XXA^^61^794^78
 ;;^UTILITY(U,$J,358.3,17897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17897,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,17897,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,17897,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,17898,0)
 ;;=W18.2XXD^^61^794^79
 ;;^UTILITY(U,$J,358.3,17898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17898,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17898,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,17898,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,17899,0)
 ;;=W18.40XA^^61^794^114
 ;;^UTILITY(U,$J,358.3,17899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17899,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,17899,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,17899,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,17900,0)
 ;;=W18.40XD^^61^794^115
 ;;^UTILITY(U,$J,358.3,17900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17900,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17900,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,17900,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,17901,0)
 ;;=W18.41XA^^61^794^116
 ;;^UTILITY(U,$J,358.3,17901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17901,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,17901,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,17901,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,17902,0)
 ;;=W18.41XD^^61^794^117
 ;;^UTILITY(U,$J,358.3,17902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17902,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17902,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,17902,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,17903,0)
 ;;=W18.42XA^^61^794^118
 ;;^UTILITY(U,$J,358.3,17903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17903,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,17903,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,17903,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,17904,0)
 ;;=W18.42XD^^61^794^119
 ;;^UTILITY(U,$J,358.3,17904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17904,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,17904,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,17904,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,17905,0)
 ;;=W18.43XA^^61^794^112
 ;;^UTILITY(U,$J,358.3,17905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17905,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,17905,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,17905,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,17906,0)
 ;;=W18.43XD^^61^794^113
 ;;^UTILITY(U,$J,358.3,17906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17906,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
