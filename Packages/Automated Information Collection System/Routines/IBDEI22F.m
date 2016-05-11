IBDEI22F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35030,1,4,0)
 ;;=4^R40.2223
 ;;^UTILITY(U,$J,358.3,35030,2)
 ;;=^5019383
 ;;^UTILITY(U,$J,358.3,35031,0)
 ;;=R40.2222^^131^1698^20
 ;;^UTILITY(U,$J,358.3,35031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35031,1,3,0)
 ;;=3^Coma Scale,Best Verbal,Incomprehensible Words,Emger Dept
 ;;^UTILITY(U,$J,358.3,35031,1,4,0)
 ;;=4^R40.2222
 ;;^UTILITY(U,$J,358.3,35031,2)
 ;;=^5019382
 ;;^UTILITY(U,$J,358.3,35032,0)
 ;;=R40.2221^^131^1698^21
 ;;^UTILITY(U,$J,358.3,35032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35032,1,3,0)
 ;;=3^Coma Scale,Best Verbal,Incomprehensible Words,in the Field
 ;;^UTILITY(U,$J,358.3,35032,1,4,0)
 ;;=4^R40.2221
 ;;^UTILITY(U,$J,358.3,35032,2)
 ;;=^5019381
 ;;^UTILITY(U,$J,358.3,35033,0)
 ;;=R40.2220^^131^1698^22
 ;;^UTILITY(U,$J,358.3,35033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35033,1,3,0)
 ;;=3^Coma Scale,Best Verbal,Incomprehensible Words,Unspec Time
 ;;^UTILITY(U,$J,358.3,35033,1,4,0)
 ;;=4^R40.2220
 ;;^UTILITY(U,$J,358.3,35033,2)
 ;;=^5019380
 ;;^UTILITY(U,$J,358.3,35034,0)
 ;;=R40.2214^^131^1698^23
 ;;^UTILITY(U,$J,358.3,35034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35034,1,3,0)
 ;;=3^Coma Scale,Best Verbal,None,24+ Hrs
 ;;^UTILITY(U,$J,358.3,35034,1,4,0)
 ;;=4^R40.2214
 ;;^UTILITY(U,$J,358.3,35034,2)
 ;;=^5019379
 ;;^UTILITY(U,$J,358.3,35035,0)
 ;;=R40.2213^^131^1698^25
 ;;^UTILITY(U,$J,358.3,35035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35035,1,3,0)
 ;;=3^Coma Scale,Best Verbal,None,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,35035,1,4,0)
 ;;=4^R40.2213
 ;;^UTILITY(U,$J,358.3,35035,2)
 ;;=^5019378
 ;;^UTILITY(U,$J,358.3,35036,0)
 ;;=R40.2212^^131^1698^24
 ;;^UTILITY(U,$J,358.3,35036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35036,1,3,0)
 ;;=3^Coma Scale,Best Verbal,None,Emger Dept
 ;;^UTILITY(U,$J,358.3,35036,1,4,0)
 ;;=4^R40.2212
 ;;^UTILITY(U,$J,358.3,35036,2)
 ;;=^5019377
 ;;^UTILITY(U,$J,358.3,35037,0)
 ;;=R40.2344^^131^1698^6
 ;;^UTILITY(U,$J,358.3,35037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35037,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,24+ Hrs
 ;;^UTILITY(U,$J,358.3,35037,1,4,0)
 ;;=4^R40.2344
 ;;^UTILITY(U,$J,358.3,35037,2)
 ;;=^5019419
 ;;^UTILITY(U,$J,358.3,35038,0)
 ;;=R40.2343^^131^1698^7
 ;;^UTILITY(U,$J,358.3,35038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35038,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,at Hospital Admission
 ;;^UTILITY(U,$J,358.3,35038,1,4,0)
 ;;=4^R40.2343
 ;;^UTILITY(U,$J,358.3,35038,2)
 ;;=^5019418
 ;;^UTILITY(U,$J,358.3,35039,0)
 ;;=R40.2342^^131^1698^8
 ;;^UTILITY(U,$J,358.3,35039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35039,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Emger Dept
 ;;^UTILITY(U,$J,358.3,35039,1,4,0)
 ;;=4^R40.2342
 ;;^UTILITY(U,$J,358.3,35039,2)
 ;;=^5019417
 ;;^UTILITY(U,$J,358.3,35040,0)
 ;;=R40.2341^^131^1698^9
 ;;^UTILITY(U,$J,358.3,35040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35040,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,in the Field
 ;;^UTILITY(U,$J,358.3,35040,1,4,0)
 ;;=4^R40.2341
 ;;^UTILITY(U,$J,358.3,35040,2)
 ;;=^5019416
 ;;^UTILITY(U,$J,358.3,35041,0)
 ;;=R40.2340^^131^1698^10
 ;;^UTILITY(U,$J,358.3,35041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35041,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Flexion Withdrawal,Unspec Time
 ;;^UTILITY(U,$J,358.3,35041,1,4,0)
 ;;=4^R40.2340
 ;;^UTILITY(U,$J,358.3,35041,2)
 ;;=^5019415
 ;;^UTILITY(U,$J,358.3,35042,0)
 ;;=R40.2324^^131^1698^1
 ;;^UTILITY(U,$J,358.3,35042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35042,1,3,0)
 ;;=3^Coma Scale,Best Motor Resp,Extension,24+ Hrs
