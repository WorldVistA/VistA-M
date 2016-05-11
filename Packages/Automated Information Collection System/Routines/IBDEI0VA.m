IBDEI0VA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14665,0)
 ;;=W18.12XA^^53^612^61
 ;;^UTILITY(U,$J,358.3,14665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14665,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,14665,1,4,0)
 ;;=4^W18.12XA
 ;;^UTILITY(U,$J,358.3,14665,2)
 ;;=^5059804
 ;;^UTILITY(U,$J,358.3,14666,0)
 ;;=W18.12XD^^53^612^62
 ;;^UTILITY(U,$J,358.3,14666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14666,1,3,0)
 ;;=3^Fall from Toilet w/ Strike Against Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14666,1,4,0)
 ;;=4^W18.12XD
 ;;^UTILITY(U,$J,358.3,14666,2)
 ;;=^5137984
 ;;^UTILITY(U,$J,358.3,14667,0)
 ;;=W18.2XXA^^53^612^73
 ;;^UTILITY(U,$J,358.3,14667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14667,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Init Encntr
 ;;^UTILITY(U,$J,358.3,14667,1,4,0)
 ;;=4^W18.2XXA
 ;;^UTILITY(U,$J,358.3,14667,2)
 ;;=^5059806
 ;;^UTILITY(U,$J,358.3,14668,0)
 ;;=W18.2XXD^^53^612^74
 ;;^UTILITY(U,$J,358.3,14668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14668,1,3,0)
 ;;=3^Fall in Empty Shower/Bathtub,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14668,1,4,0)
 ;;=4^W18.2XXD
 ;;^UTILITY(U,$J,358.3,14668,2)
 ;;=^5059807
 ;;^UTILITY(U,$J,358.3,14669,0)
 ;;=W18.40XA^^53^612^105
 ;;^UTILITY(U,$J,358.3,14669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14669,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Init Encntr
 ;;^UTILITY(U,$J,358.3,14669,1,4,0)
 ;;=4^W18.40XA
 ;;^UTILITY(U,$J,358.3,14669,2)
 ;;=^5059818
 ;;^UTILITY(U,$J,358.3,14670,0)
 ;;=W18.40XD^^53^612^106
 ;;^UTILITY(U,$J,358.3,14670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14670,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14670,1,4,0)
 ;;=4^W18.40XD
 ;;^UTILITY(U,$J,358.3,14670,2)
 ;;=^5059819
 ;;^UTILITY(U,$J,358.3,14671,0)
 ;;=W18.41XA^^53^612^107
 ;;^UTILITY(U,$J,358.3,14671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14671,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Init Encntr
 ;;^UTILITY(U,$J,358.3,14671,1,4,0)
 ;;=4^W18.41XA
 ;;^UTILITY(U,$J,358.3,14671,2)
 ;;=^5059821
 ;;^UTILITY(U,$J,358.3,14672,0)
 ;;=W18.41XD^^53^612^108
 ;;^UTILITY(U,$J,358.3,14672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14672,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping on Obj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14672,1,4,0)
 ;;=4^W18.41XD
 ;;^UTILITY(U,$J,358.3,14672,2)
 ;;=^5059822
 ;;^UTILITY(U,$J,358.3,14673,0)
 ;;=W18.42XA^^53^612^109
 ;;^UTILITY(U,$J,358.3,14673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14673,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Init Encntr
 ;;^UTILITY(U,$J,358.3,14673,1,4,0)
 ;;=4^W18.42XA
 ;;^UTILITY(U,$J,358.3,14673,2)
 ;;=^5059824
 ;;^UTILITY(U,$J,358.3,14674,0)
 ;;=W18.42XD^^53^612^110
 ;;^UTILITY(U,$J,358.3,14674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14674,1,3,0)
 ;;=3^Slipping/Tripping/Stumbling w/o Falling d/t Stepping into Hole,Subs Encntr
 ;;^UTILITY(U,$J,358.3,14674,1,4,0)
 ;;=4^W18.42XD
 ;;^UTILITY(U,$J,358.3,14674,2)
 ;;=^5059825
 ;;^UTILITY(U,$J,358.3,14675,0)
 ;;=W18.43XA^^53^612^103
 ;;^UTILITY(U,$J,358.3,14675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14675,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Init Encntr
 ;;^UTILITY(U,$J,358.3,14675,1,4,0)
 ;;=4^W18.43XA
 ;;^UTILITY(U,$J,358.3,14675,2)
 ;;=^5059827
 ;;^UTILITY(U,$J,358.3,14676,0)
 ;;=W18.43XD^^53^612^104
 ;;^UTILITY(U,$J,358.3,14676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14676,1,3,0)
 ;;=3^Slipping/Tripping w/o Fall d/t Step from One Level to Another,Subs Encntr
