IBDEI0L1 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9315,1,3,0)
 ;;=3^Infusion,IV,Addl Seq Infus New Med/Sub,Up to 1 hr
 ;;^UTILITY(U,$J,358.3,9316,0)
 ;;=99217^^70^635^1^^^^1
 ;;^UTILITY(U,$J,358.3,9316,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9316,1,2,0)
 ;;=2^99217
 ;;^UTILITY(U,$J,358.3,9316,1,3,0)
 ;;=3^Observation Care Discharge
 ;;^UTILITY(U,$J,358.3,9317,0)
 ;;=99292^^70^635^2^^^^1
 ;;^UTILITY(U,$J,358.3,9317,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9317,1,2,0)
 ;;=2^99292
 ;;^UTILITY(U,$J,358.3,9317,1,3,0)
 ;;=3^Critical Care,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,9318,0)
 ;;=99281^^71^636^1
 ;;^UTILITY(U,$J,358.3,9318,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9318,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,9318,1,2,0)
 ;;=2^99281
 ;;^UTILITY(U,$J,358.3,9319,0)
 ;;=99282^^71^636^2
 ;;^UTILITY(U,$J,358.3,9319,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9319,1,1,0)
 ;;=1^Expanded Problem Focus,Low
 ;;^UTILITY(U,$J,358.3,9319,1,2,0)
 ;;=2^99282
 ;;^UTILITY(U,$J,358.3,9320,0)
 ;;=99283^^71^636^3
 ;;^UTILITY(U,$J,358.3,9320,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9320,1,1,0)
 ;;=1^Expanded Problem Focus,Mod
 ;;^UTILITY(U,$J,358.3,9320,1,2,0)
 ;;=2^99283
 ;;^UTILITY(U,$J,358.3,9321,0)
 ;;=99284^^71^636^4
 ;;^UTILITY(U,$J,358.3,9321,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9321,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,9321,1,2,0)
 ;;=2^99284
 ;;^UTILITY(U,$J,358.3,9322,0)
 ;;=99285^^71^636^5
 ;;^UTILITY(U,$J,358.3,9322,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9322,1,1,0)
 ;;=1^Comprehensive
 ;;^UTILITY(U,$J,358.3,9322,1,2,0)
 ;;=2^99285
 ;;^UTILITY(U,$J,358.3,9323,0)
 ;;=99291^^71^636^6
 ;;^UTILITY(U,$J,358.3,9323,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9323,1,1,0)
 ;;=1^Critical Care,1st Hr (99292 on proc tab)
 ;;^UTILITY(U,$J,358.3,9323,1,2,0)
 ;;=2^99291
 ;;^UTILITY(U,$J,358.3,9324,0)
 ;;=99211^^71^637^1
 ;;^UTILITY(U,$J,358.3,9324,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9324,1,1,0)
 ;;=1^Nursing Visit (NO MD Seen)
 ;;^UTILITY(U,$J,358.3,9324,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,9325,0)
 ;;=99218^^71^638^1
 ;;^UTILITY(U,$J,358.3,9325,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9325,1,1,0)
 ;;=1^Detail Hx/Exam,Low MDM/Complex (3 of 3)
 ;;^UTILITY(U,$J,358.3,9325,1,2,0)
 ;;=2^99218
 ;;^UTILITY(U,$J,358.3,9326,0)
 ;;=99219^^71^638^2
 ;;^UTILITY(U,$J,358.3,9326,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9326,1,1,0)
 ;;=1^Comp Hx/Exam,Mod MDM/Complex (3 of 3)
 ;;^UTILITY(U,$J,358.3,9326,1,2,0)
 ;;=2^99219
 ;;^UTILITY(U,$J,358.3,9327,0)
 ;;=99220^^71^638^3
 ;;^UTILITY(U,$J,358.3,9327,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9327,1,1,0)
 ;;=1^Comp Hx/Exam,High MDM/Complex (3 of 3)
 ;;^UTILITY(U,$J,358.3,9327,1,2,0)
 ;;=2^99220
 ;;^UTILITY(U,$J,358.3,9328,0)
 ;;=99234^^71^639^1
 ;;^UTILITY(U,$J,358.3,9328,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9328,1,1,0)
 ;;=1^Detail Hx/Exam,Low MDM/Complex (3 of 3)
 ;;^UTILITY(U,$J,358.3,9328,1,2,0)
 ;;=2^99234
 ;;^UTILITY(U,$J,358.3,9329,0)
 ;;=99235^^71^639^2
 ;;^UTILITY(U,$J,358.3,9329,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9329,1,1,0)
 ;;=1^Comp Hx/Exam,Mod MDM/Complex (3 of 3)
 ;;^UTILITY(U,$J,358.3,9329,1,2,0)
 ;;=2^99235
 ;;^UTILITY(U,$J,358.3,9330,0)
 ;;=99236^^71^639^3
 ;;^UTILITY(U,$J,358.3,9330,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9330,1,1,0)
 ;;=1^Comp Hx/Exam,High MDM/Complex (3 of 3)
 ;;^UTILITY(U,$J,358.3,9330,1,2,0)
 ;;=2^99236
