IBDEI085 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3312,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Disturbance Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,3312,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,3312,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,3313,0)
 ;;=F43.10^^8^121^8
 ;;^UTILITY(U,$J,358.3,3313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3313,1,3,0)
 ;;=3^PTSD
 ;;^UTILITY(U,$J,358.3,3313,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,3313,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,3314,0)
 ;;=F43.8^^8^121^9
 ;;^UTILITY(U,$J,358.3,3314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3314,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder NEC
 ;;^UTILITY(U,$J,358.3,3314,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,3314,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,3315,0)
 ;;=F43.20^^8^121^7
 ;;^UTILITY(U,$J,358.3,3315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3315,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3315,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,3315,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,3316,0)
 ;;=F43.9^^8^121^10
 ;;^UTILITY(U,$J,358.3,3316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3316,1,3,0)
 ;;=3^Trauma/Stressor-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3316,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,3316,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,3317,0)
 ;;=F18.10^^8^122^1
 ;;^UTILITY(U,$J,358.3,3317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3317,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,3317,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,3317,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,3318,0)
 ;;=F18.20^^8^122^2
 ;;^UTILITY(U,$J,358.3,3318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3318,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,3318,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,3318,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,3319,0)
 ;;=F18.21^^8^122^3
 ;;^UTILITY(U,$J,358.3,3319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3319,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,3319,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,3319,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,3320,0)
 ;;=F18.14^^8^122^4
 ;;^UTILITY(U,$J,358.3,3320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3320,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3320,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,3320,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,3321,0)
 ;;=F18.24^^8^122^5
 ;;^UTILITY(U,$J,358.3,3321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3321,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,3321,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,3321,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,3322,0)
 ;;=H0001^^9^123^1^^^^1
 ;;^UTILITY(U,$J,358.3,3322,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3322,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,3322,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,3323,0)
 ;;=H0002^^9^123^11^^^^1
 ;;^UTILITY(U,$J,358.3,3323,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3323,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,3323,1,3,0)
 ;;=3^Screen for Addictions Admit Eligibility
 ;;^UTILITY(U,$J,358.3,3324,0)
 ;;=H0004^^9^123^7
 ;;^UTILITY(U,$J,358.3,3324,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3324,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,3324,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 Min
 ;;^UTILITY(U,$J,358.3,3325,0)
 ;;=H0005^^9^123^2^^^^1
 ;;^UTILITY(U,$J,358.3,3325,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3325,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,3325,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
