IBDEI08K ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3886,1,4,0)
 ;;=4^625.6
 ;;^UTILITY(U,$J,358.3,3886,1,5,0)
 ;;=5^Incontinence, stress, female
 ;;^UTILITY(U,$J,358.3,3886,2)
 ;;=^114717
 ;;^UTILITY(U,$J,358.3,3887,0)
 ;;=788.31^^33^284^88
 ;;^UTILITY(U,$J,358.3,3887,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3887,1,4,0)
 ;;=4^788.31
 ;;^UTILITY(U,$J,358.3,3887,1,5,0)
 ;;=5^Incontinence, urge
 ;;^UTILITY(U,$J,358.3,3887,2)
 ;;=^260046
 ;;^UTILITY(U,$J,358.3,3888,0)
 ;;=788.43^^33^284^107
 ;;^UTILITY(U,$J,358.3,3888,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3888,1,4,0)
 ;;=4^788.43
 ;;^UTILITY(U,$J,358.3,3888,1,5,0)
 ;;=5^Nocturia
 ;;^UTILITY(U,$J,358.3,3888,2)
 ;;=Nocturia^84740
 ;;^UTILITY(U,$J,358.3,3889,0)
 ;;=788.5^^33^284^110
 ;;^UTILITY(U,$J,358.3,3889,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3889,1,4,0)
 ;;=4^788.5
 ;;^UTILITY(U,$J,358.3,3889,1,5,0)
 ;;=5^Oliguria/Anuria
 ;;^UTILITY(U,$J,358.3,3889,2)
 ;;=Oliguria/Anuria^85458
 ;;^UTILITY(U,$J,358.3,3890,0)
 ;;=788.42^^33^284^121
 ;;^UTILITY(U,$J,358.3,3890,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3890,1,4,0)
 ;;=4^788.42
 ;;^UTILITY(U,$J,358.3,3890,1,5,0)
 ;;=5^Polyuria
 ;;^UTILITY(U,$J,358.3,3890,2)
 ;;=Polyuria^96503
 ;;^UTILITY(U,$J,358.3,3891,0)
 ;;=788.0^^33^284^125
 ;;^UTILITY(U,$J,358.3,3891,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3891,1,4,0)
 ;;=4^788.0
 ;;^UTILITY(U,$J,358.3,3891,1,5,0)
 ;;=5^Renal Colic
 ;;^UTILITY(U,$J,358.3,3891,2)
 ;;=Renal Colic^265306
 ;;^UTILITY(U,$J,358.3,3892,0)
 ;;=788.20^^33^284^126
 ;;^UTILITY(U,$J,358.3,3892,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3892,1,4,0)
 ;;=4^788.20
 ;;^UTILITY(U,$J,358.3,3892,1,5,0)
 ;;=5^Retention, urinary
 ;;^UTILITY(U,$J,358.3,3892,2)
 ;;=^295812
 ;;^UTILITY(U,$J,358.3,3893,0)
 ;;=788.62^^33^284^130
 ;;^UTILITY(U,$J,358.3,3893,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3893,1,4,0)
 ;;=4^788.62
 ;;^UTILITY(U,$J,358.3,3893,1,5,0)
 ;;=5^Slowing, urine stream
 ;;^UTILITY(U,$J,358.3,3893,2)
 ;;=^295769
 ;;^UTILITY(U,$J,358.3,3894,0)
 ;;=788.7^^33^284^143
 ;;^UTILITY(U,$J,358.3,3894,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3894,1,4,0)
 ;;=4^788.7
 ;;^UTILITY(U,$J,358.3,3894,1,5,0)
 ;;=5^Urethral Discharge
 ;;^UTILITY(U,$J,358.3,3894,2)
 ;;=^265872
 ;;^UTILITY(U,$J,358.3,3895,0)
 ;;=599.0^^33^284^144
 ;;^UTILITY(U,$J,358.3,3895,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3895,1,4,0)
 ;;=4^599.0
 ;;^UTILITY(U,$J,358.3,3895,1,5,0)
 ;;=5^Urinary tract infection
 ;;^UTILITY(U,$J,358.3,3895,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,3896,0)
 ;;=784.49^^33^284^115
 ;;^UTILITY(U,$J,358.3,3896,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3896,1,4,0)
 ;;=4^784.49
 ;;^UTILITY(U,$J,358.3,3896,1,5,0)
 ;;=5^Other Voice and Resonance Disorders
 ;;^UTILITY(U,$J,358.3,3896,2)
 ;;=Other Voice and Resonance Disorders^88244
 ;;^UTILITY(U,$J,358.3,3897,0)
 ;;=525.10^^33^284^95
 ;;^UTILITY(U,$J,358.3,3897,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3897,1,4,0)
 ;;=4^525.10
 ;;^UTILITY(U,$J,358.3,3897,1,5,0)
 ;;=5^Loss of Teeth
 ;;^UTILITY(U,$J,358.3,3897,2)
 ;;=Loss of Teeth^323490
 ;;^UTILITY(U,$J,358.3,3898,0)
 ;;=795.39^^33^284^122
 ;;^UTILITY(U,$J,358.3,3898,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3898,1,4,0)
 ;;=4^795.39
 ;;^UTILITY(U,$J,358.3,3898,1,5,0)
 ;;=5^Positive Culture findings
 ;;^UTILITY(U,$J,358.3,3898,2)
 ;;=Positive Culture findings^328582
 ;;^UTILITY(U,$J,358.3,3899,0)
 ;;=564.00^^33^284^41
 ;;^UTILITY(U,$J,358.3,3899,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3899,1,4,0)
 ;;=4^564.00
 ;;^UTILITY(U,$J,358.3,3899,1,5,0)
 ;;=5^Constipation
 ;;^UTILITY(U,$J,358.3,3899,2)
 ;;=Constipation^323537
