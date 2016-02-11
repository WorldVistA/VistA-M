IBDEI08Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3533,2)
 ;;=^5015692
 ;;^UTILITY(U,$J,358.3,3534,0)
 ;;=N40.2^^28^255^68
 ;;^UTILITY(U,$J,358.3,3534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3534,1,3,0)
 ;;=3^Prostate,Nodular w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,3534,1,4,0)
 ;;=4^N40.2
 ;;^UTILITY(U,$J,358.3,3534,2)
 ;;=^5015691
 ;;^UTILITY(U,$J,358.3,3535,0)
 ;;=Z87.430^^28^255^56
 ;;^UTILITY(U,$J,358.3,3535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3535,1,3,0)
 ;;=3^Personal Hx of Prostatic Dysplasia
 ;;^UTILITY(U,$J,358.3,3535,1,4,0)
 ;;=4^Z87.430
 ;;^UTILITY(U,$J,358.3,3535,2)
 ;;=^5063493
 ;;^UTILITY(U,$J,358.3,3536,0)
 ;;=N41.2^^28^255^1
 ;;^UTILITY(U,$J,358.3,3536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3536,1,3,0)
 ;;=3^Abscess of Prostate
 ;;^UTILITY(U,$J,358.3,3536,1,4,0)
 ;;=4^N41.2
 ;;^UTILITY(U,$J,358.3,3536,2)
 ;;=^270416
 ;;^UTILITY(U,$J,358.3,3537,0)
 ;;=N41.0^^28^255^69
 ;;^UTILITY(U,$J,358.3,3537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3537,1,3,0)
 ;;=3^Prostatitis,Acute
 ;;^UTILITY(U,$J,358.3,3537,1,4,0)
 ;;=4^N41.0
 ;;^UTILITY(U,$J,358.3,3537,2)
 ;;=^259106
 ;;^UTILITY(U,$J,358.3,3538,0)
 ;;=N41.1^^28^255^70
 ;;^UTILITY(U,$J,358.3,3538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3538,1,3,0)
 ;;=3^Prostatitis,Chronic
 ;;^UTILITY(U,$J,358.3,3538,1,4,0)
 ;;=4^N41.1
 ;;^UTILITY(U,$J,358.3,3538,2)
 ;;=^186931
 ;;^UTILITY(U,$J,358.3,3539,0)
 ;;=N41.4^^28^255^71
 ;;^UTILITY(U,$J,358.3,3539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3539,1,3,0)
 ;;=3^Prostatitis,Granulomatous
 ;;^UTILITY(U,$J,358.3,3539,1,4,0)
 ;;=4^N41.4
 ;;^UTILITY(U,$J,358.3,3539,2)
 ;;=^52938
 ;;^UTILITY(U,$J,358.3,3540,0)
 ;;=N41.3^^28^255^72
 ;;^UTILITY(U,$J,358.3,3540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3540,1,3,0)
 ;;=3^Prostatocystitis
 ;;^UTILITY(U,$J,358.3,3540,1,4,0)
 ;;=4^N41.3
 ;;^UTILITY(U,$J,358.3,3540,2)
 ;;=^270418
 ;;^UTILITY(U,$J,358.3,3541,0)
 ;;=N70.93^^28^255^73
 ;;^UTILITY(U,$J,358.3,3541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3541,1,3,0)
 ;;=3^Salpingitis & Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,3541,1,4,0)
 ;;=4^N70.93
 ;;^UTILITY(U,$J,358.3,3541,2)
 ;;=^5015808
 ;;^UTILITY(U,$J,358.3,3542,0)
 ;;=R39.16^^28^255^77
 ;;^UTILITY(U,$J,358.3,3542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3542,1,3,0)
 ;;=3^Straining to Void
 ;;^UTILITY(U,$J,358.3,3542,1,4,0)
 ;;=4^R39.16
 ;;^UTILITY(U,$J,358.3,3542,2)
 ;;=^5019346
 ;;^UTILITY(U,$J,358.3,3543,0)
 ;;=N53.9^^28^255^74
 ;;^UTILITY(U,$J,358.3,3543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3543,1,3,0)
 ;;=3^Sexual Dysfunction,Male,Unspec
 ;;^UTILITY(U,$J,358.3,3543,1,4,0)
 ;;=4^N53.9
 ;;^UTILITY(U,$J,358.3,3543,2)
 ;;=^5015769
 ;;^UTILITY(U,$J,358.3,3544,0)
 ;;=R37.^^28^255^75
 ;;^UTILITY(U,$J,358.3,3544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3544,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,3544,1,4,0)
 ;;=4^R37.
 ;;^UTILITY(U,$J,358.3,3544,2)
 ;;=^5019339
 ;;^UTILITY(U,$J,358.3,3545,0)
 ;;=N43.40^^28^255^76
 ;;^UTILITY(U,$J,358.3,3545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3545,1,3,0)
 ;;=3^Spermatocele of Epididymis,Unspec
 ;;^UTILITY(U,$J,358.3,3545,1,4,0)
 ;;=4^N43.40
 ;;^UTILITY(U,$J,358.3,3545,2)
 ;;=^5015701
 ;;^UTILITY(U,$J,358.3,3546,0)
 ;;=N44.8^^28^255^78
 ;;^UTILITY(U,$J,358.3,3546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3546,1,3,0)
 ;;=3^Testis Noninflammatory Disorder,Other
 ;;^UTILITY(U,$J,358.3,3546,1,4,0)
 ;;=4^N44.8
 ;;^UTILITY(U,$J,358.3,3546,2)
 ;;=^5015706
 ;;^UTILITY(U,$J,358.3,3547,0)
 ;;=N44.00^^28^255^79
 ;;^UTILITY(U,$J,358.3,3547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3547,1,3,0)
 ;;=3^Torsion of Testis,Unspec
