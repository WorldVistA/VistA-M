IBDEI0OP ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11097,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,11097,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,11098,0)
 ;;=F15.282^^42^506^5
 ;;^UTILITY(U,$J,358.3,11098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11098,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,11098,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,11098,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,11099,0)
 ;;=F15.982^^42^506^6
 ;;^UTILITY(U,$J,358.3,11099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11099,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,11099,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,11099,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,11100,0)
 ;;=F15.99^^42^506^9
 ;;^UTILITY(U,$J,358.3,11100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11100,1,3,0)
 ;;=3^Caffeinie Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11100,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,11100,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,11101,0)
 ;;=R45.851^^42^507^3
 ;;^UTILITY(U,$J,358.3,11101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11101,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,11101,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,11101,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,11102,0)
 ;;=T14.91XA^^42^507^4
 ;;^UTILITY(U,$J,358.3,11102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11102,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,11102,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,11102,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,11103,0)
 ;;=T14.91XD^^42^507^6
 ;;^UTILITY(U,$J,358.3,11103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11103,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,11103,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,11103,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,11104,0)
 ;;=T14.91XS^^42^507^5
 ;;^UTILITY(U,$J,358.3,11104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11104,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,11104,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,11104,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,11105,0)
 ;;=Z91.51^^42^507^2
 ;;^UTILITY(U,$J,358.3,11105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11105,1,3,0)
 ;;=3^Personal Hx of Suicidal Behavior
 ;;^UTILITY(U,$J,358.3,11105,1,4,0)
 ;;=4^Z91.51
 ;;^UTILITY(U,$J,358.3,11105,2)
 ;;=^5161317
 ;;^UTILITY(U,$J,358.3,11106,0)
 ;;=Z91.52^^42^507^1
 ;;^UTILITY(U,$J,358.3,11106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11106,1,3,0)
 ;;=3^Personal Hx of Non-Suicidal Self-Harm
 ;;^UTILITY(U,$J,358.3,11106,1,4,0)
 ;;=4^Z91.52
 ;;^UTILITY(U,$J,358.3,11106,2)
 ;;=^5161318
 ;;^UTILITY(U,$J,358.3,11107,0)
 ;;=F19.14^^42^508^1
 ;;^UTILITY(U,$J,358.3,11107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11107,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,11107,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,11107,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,11108,0)
 ;;=F19.24^^42^508^2
 ;;^UTILITY(U,$J,358.3,11108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11108,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,11108,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,11108,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,11109,0)
 ;;=F19.94^^42^508^3
 ;;^UTILITY(U,$J,358.3,11109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11109,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/o Use D/O
