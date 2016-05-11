IBDEI0GN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7698,1,3,0)
 ;;=3^Coma Scale,Eyes Open,to Pain,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,7698,1,4,0)
 ;;=4^R40.2123
 ;;^UTILITY(U,$J,358.3,7698,2)
 ;;=^5019363
 ;;^UTILITY(U,$J,358.3,7699,0)
 ;;=R40.2122^^30^414^32
 ;;^UTILITY(U,$J,358.3,7699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7699,1,3,0)
 ;;=3^Coma Scale,Eyes Open,to Pain,Emger Dept
 ;;^UTILITY(U,$J,358.3,7699,1,4,0)
 ;;=4^R40.2122
 ;;^UTILITY(U,$J,358.3,7699,2)
 ;;=^5019362
 ;;^UTILITY(U,$J,358.3,7700,0)
 ;;=R40.2124^^30^414^31
 ;;^UTILITY(U,$J,358.3,7700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7700,1,3,0)
 ;;=3^Coma Scale,Eyes Open,to Pain,24+ Hrs
 ;;^UTILITY(U,$J,358.3,7700,1,4,0)
 ;;=4^R40.2124
 ;;^UTILITY(U,$J,358.3,7700,2)
 ;;=^5019364
 ;;^UTILITY(U,$J,358.3,7701,0)
 ;;=R40.2211^^30^414^17
 ;;^UTILITY(U,$J,358.3,7701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7701,1,3,0)
 ;;=3^Coma Scale,Best Verbal Response,None,in the Field
 ;;^UTILITY(U,$J,358.3,7701,1,4,0)
 ;;=4^R40.2211
 ;;^UTILITY(U,$J,358.3,7701,2)
 ;;=^5019376
 ;;^UTILITY(U,$J,358.3,7702,0)
 ;;=R40.2210^^30^414^16
 ;;^UTILITY(U,$J,358.3,7702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7702,1,3,0)
 ;;=3^Coma Scale,Best Verbal Response,None,Unspec Time
 ;;^UTILITY(U,$J,358.3,7702,1,4,0)
 ;;=4^R40.2210
 ;;^UTILITY(U,$J,358.3,7702,2)
 ;;=^5019375
 ;;^UTILITY(U,$J,358.3,7703,0)
 ;;=R40.2224^^30^414^18
 ;;^UTILITY(U,$J,358.3,7703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7703,1,3,0)
 ;;=3^Coma Scale,Best Verbal,Incomprehensible Words,24+ Hrs
 ;;^UTILITY(U,$J,358.3,7703,1,4,0)
 ;;=4^R40.2224
 ;;^UTILITY(U,$J,358.3,7703,2)
 ;;=^5019384
 ;;^UTILITY(U,$J,358.3,7704,0)
 ;;=R40.2223^^30^414^19
 ;;^UTILITY(U,$J,358.3,7704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7704,1,3,0)
 ;;=3^Coma Scale,Best Verbal,Incomprehensible Words,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,7704,1,4,0)
 ;;=4^R40.2223
 ;;^UTILITY(U,$J,358.3,7704,2)
 ;;=^5019383
 ;;^UTILITY(U,$J,358.3,7705,0)
 ;;=R40.2222^^30^414^20
 ;;^UTILITY(U,$J,358.3,7705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7705,1,3,0)
 ;;=3^Coma Scale,Best Verbal,Incomprehensible Words,Emger Dept
 ;;^UTILITY(U,$J,358.3,7705,1,4,0)
 ;;=4^R40.2222
 ;;^UTILITY(U,$J,358.3,7705,2)
 ;;=^5019382
 ;;^UTILITY(U,$J,358.3,7706,0)
 ;;=R40.2221^^30^414^21
 ;;^UTILITY(U,$J,358.3,7706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7706,1,3,0)
 ;;=3^Coma Scale,Best Verbal,Incomprehensible Words,in the Field
 ;;^UTILITY(U,$J,358.3,7706,1,4,0)
 ;;=4^R40.2221
 ;;^UTILITY(U,$J,358.3,7706,2)
 ;;=^5019381
 ;;^UTILITY(U,$J,358.3,7707,0)
 ;;=R40.2220^^30^414^22
 ;;^UTILITY(U,$J,358.3,7707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7707,1,3,0)
 ;;=3^Coma Scale,Best Verbal,Incomprehensible Words,Unspec Time
 ;;^UTILITY(U,$J,358.3,7707,1,4,0)
 ;;=4^R40.2220
 ;;^UTILITY(U,$J,358.3,7707,2)
 ;;=^5019380
 ;;^UTILITY(U,$J,358.3,7708,0)
 ;;=R40.2214^^30^414^23
 ;;^UTILITY(U,$J,358.3,7708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7708,1,3,0)
 ;;=3^Coma Scale,Best Verbal,None,24+ Hrs
 ;;^UTILITY(U,$J,358.3,7708,1,4,0)
 ;;=4^R40.2214
 ;;^UTILITY(U,$J,358.3,7708,2)
 ;;=^5019379
 ;;^UTILITY(U,$J,358.3,7709,0)
 ;;=R40.2213^^30^414^25
 ;;^UTILITY(U,$J,358.3,7709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7709,1,3,0)
 ;;=3^Coma Scale,Best Verbal,None,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,7709,1,4,0)
 ;;=4^R40.2213
 ;;^UTILITY(U,$J,358.3,7709,2)
 ;;=^5019378
 ;;^UTILITY(U,$J,358.3,7710,0)
 ;;=R40.2212^^30^414^24
 ;;^UTILITY(U,$J,358.3,7710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7710,1,3,0)
 ;;=3^Coma Scale,Best Verbal,None,Emger Dept
