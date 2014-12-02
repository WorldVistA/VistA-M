IBDEI07O ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3439,1,4,0)
 ;;=4^533.90
 ;;^UTILITY(U,$J,358.3,3439,1,5,0)
 ;;=5^PUD
 ;;^UTILITY(U,$J,358.3,3439,2)
 ;;=^93051
 ;;^UTILITY(U,$J,358.3,3440,0)
 ;;=794.8^^33^278^3
 ;;^UTILITY(U,$J,358.3,3440,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3440,1,4,0)
 ;;=4^794.8
 ;;^UTILITY(U,$J,358.3,3440,1,5,0)
 ;;=5^Abnormal LFT's
 ;;^UTILITY(U,$J,358.3,3440,2)
 ;;=^273450
 ;;^UTILITY(U,$J,358.3,3441,0)
 ;;=584.9^^33^279^2
 ;;^UTILITY(U,$J,358.3,3441,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3441,1,4,0)
 ;;=4^584.9
 ;;^UTILITY(U,$J,358.3,3441,1,5,0)
 ;;=5^Acute Renal Failure
 ;;^UTILITY(U,$J,358.3,3441,2)
 ;;=^67114
 ;;^UTILITY(U,$J,358.3,3442,0)
 ;;=583.9^^33^279^17
 ;;^UTILITY(U,$J,358.3,3442,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3442,1,4,0)
 ;;=4^583.9
 ;;^UTILITY(U,$J,358.3,3442,1,5,0)
 ;;=5^Glomerulonephritis
 ;;^UTILITY(U,$J,358.3,3442,2)
 ;;=^83446
 ;;^UTILITY(U,$J,358.3,3443,0)
 ;;=403.90^^33^279^50
 ;;^UTILITY(U,$J,358.3,3443,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3443,1,4,0)
 ;;=4^403.90
 ;;^UTILITY(U,$J,358.3,3443,1,5,0)
 ;;=5^Renal Insufficiency with Hypertension (CRI and HTN)
 ;;^UTILITY(U,$J,358.3,3443,2)
 ;;=Renal Insufficiency with Hypertension (CRI and HTN)^269609
 ;;^UTILITY(U,$J,358.3,3444,0)
 ;;=593.9^^33^279^9
 ;;^UTILITY(U,$J,358.3,3444,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3444,1,4,0)
 ;;=4^593.9
 ;;^UTILITY(U,$J,358.3,3444,1,5,0)
 ;;=5^Chronic Renal Insufficiency
 ;;^UTILITY(U,$J,358.3,3444,2)
 ;;=Chronic Renal Insufficiency^123849
 ;;^UTILITY(U,$J,358.3,3445,0)
 ;;=581.9^^33^279^35
 ;;^UTILITY(U,$J,358.3,3445,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3445,1,4,0)
 ;;=4^581.9
 ;;^UTILITY(U,$J,358.3,3445,1,5,0)
 ;;=5^Nephrotic Syndrome
 ;;^UTILITY(U,$J,358.3,3445,2)
 ;;=^82357
 ;;^UTILITY(U,$J,358.3,3446,0)
 ;;=753.12^^33^279^42
 ;;^UTILITY(U,$J,358.3,3446,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3446,1,4,0)
 ;;=4^753.12
 ;;^UTILITY(U,$J,358.3,3446,1,5,0)
 ;;=5^Polycystic Kidney Disease
 ;;^UTILITY(U,$J,358.3,3446,2)
 ;;=^67295
 ;;^UTILITY(U,$J,358.3,3447,0)
 ;;=791.0^^33^279^44
 ;;^UTILITY(U,$J,358.3,3447,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3447,1,4,0)
 ;;=4^791.0
 ;;^UTILITY(U,$J,358.3,3447,1,5,0)
 ;;=5^Proteinuria
 ;;^UTILITY(U,$J,358.3,3447,2)
 ;;=Proteinuria^99873
 ;;^UTILITY(U,$J,358.3,3448,0)
 ;;=791.9^^33^279^47
 ;;^UTILITY(U,$J,358.3,3448,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3448,1,4,0)
 ;;=4^791.9
 ;;^UTILITY(U,$J,358.3,3448,1,5,0)
 ;;=5^Pyuria
 ;;^UTILITY(U,$J,358.3,3448,2)
 ;;=^273408
 ;;^UTILITY(U,$J,358.3,3449,0)
 ;;=592.0^^33^279^48
 ;;^UTILITY(U,$J,358.3,3449,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3449,1,4,0)
 ;;=4^592.0
 ;;^UTILITY(U,$J,358.3,3449,1,5,0)
 ;;=5^Renal Calculi
 ;;^UTILITY(U,$J,358.3,3449,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,3450,0)
 ;;=403.91^^33^279^49
 ;;^UTILITY(U,$J,358.3,3450,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3450,1,4,0)
 ;;=4^403.91
 ;;^UTILITY(U,$J,358.3,3450,1,5,0)
 ;;=5^Renal Failure, Chronic Hypertensive
 ;;^UTILITY(U,$J,358.3,3450,2)
 ;;=^269610
 ;;^UTILITY(U,$J,358.3,3451,0)
 ;;=586.^^33^279^52
 ;;^UTILITY(U,$J,358.3,3451,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3451,1,4,0)
 ;;=4^586.
 ;;^UTILITY(U,$J,358.3,3451,1,5,0)
 ;;=5^Uremia
 ;;^UTILITY(U,$J,358.3,3451,2)
 ;;=Uremia^104733
 ;;^UTILITY(U,$J,358.3,3452,0)
 ;;=599.0^^33^279^62
 ;;^UTILITY(U,$J,358.3,3452,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3452,1,4,0)
 ;;=4^599.0
 ;;^UTILITY(U,$J,358.3,3452,1,5,0)
 ;;=5^Urinary Tract Infection
 ;;^UTILITY(U,$J,358.3,3452,2)
 ;;=Urinary Tract Infection^124436
 ;;^UTILITY(U,$J,358.3,3453,0)
 ;;=275.42^^33^279^26
