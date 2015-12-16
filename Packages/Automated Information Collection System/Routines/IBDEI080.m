IBDEI080 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3249,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,3249,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,3249,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,3250,0)
 ;;=F10.24^^8^112^9
 ;;^UTILITY(U,$J,358.3,3250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3250,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,3250,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,3250,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,3251,0)
 ;;=F10.29^^8^112^11
 ;;^UTILITY(U,$J,358.3,3251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3251,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3251,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,3251,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,3252,0)
 ;;=F15.10^^8^113^4
 ;;^UTILITY(U,$J,358.3,3252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3252,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,3252,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,3252,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,3253,0)
 ;;=F15.14^^8^113^2
 ;;^UTILITY(U,$J,358.3,3253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3253,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3253,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,3253,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,3254,0)
 ;;=F15.182^^8^113^3
 ;;^UTILITY(U,$J,358.3,3254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3254,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3254,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,3254,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,3255,0)
 ;;=F15.20^^8^113^5
 ;;^UTILITY(U,$J,358.3,3255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3255,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,3255,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,3255,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,3256,0)
 ;;=F15.21^^8^113^6
 ;;^UTILITY(U,$J,358.3,3256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3256,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,3256,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,3256,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,3257,0)
 ;;=F15.23^^8^113^1
 ;;^UTILITY(U,$J,358.3,3257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3257,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,3257,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,3257,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,3258,0)
 ;;=F12.10^^8^114^1
 ;;^UTILITY(U,$J,358.3,3258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3258,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,3258,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,3258,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,3259,0)
 ;;=F12.180^^8^114^2
 ;;^UTILITY(U,$J,358.3,3259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3259,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,3259,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,3259,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,3260,0)
 ;;=F12.188^^8^114^3
 ;;^UTILITY(U,$J,358.3,3260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3260,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,3260,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,3260,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,3261,0)
 ;;=F12.20^^8^114^4
 ;;^UTILITY(U,$J,358.3,3261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3261,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,3261,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,3261,2)
 ;;=^5003166
