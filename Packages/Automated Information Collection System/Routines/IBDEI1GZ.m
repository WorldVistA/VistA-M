IBDEI1GZ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24958,0)
 ;;=F11.121^^93^1120^13
 ;;^UTILITY(U,$J,358.3,24958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24958,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24958,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,24958,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,24959,0)
 ;;=F11.221^^93^1120^14
 ;;^UTILITY(U,$J,358.3,24959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24959,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24959,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,24959,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,24960,0)
 ;;=F11.921^^93^1120^15
 ;;^UTILITY(U,$J,358.3,24960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24960,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24960,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,24960,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,24961,0)
 ;;=F11.229^^93^1120^20
 ;;^UTILITY(U,$J,358.3,24961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24961,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24961,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,24961,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,24962,0)
 ;;=F11.929^^93^1120^21
 ;;^UTILITY(U,$J,358.3,24962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24962,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24962,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,24962,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,24963,0)
 ;;=F11.122^^93^1120^16
 ;;^UTILITY(U,$J,358.3,24963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24963,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24963,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,24963,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,24964,0)
 ;;=F11.222^^93^1120^17
 ;;^UTILITY(U,$J,358.3,24964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24964,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24964,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,24964,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,24965,0)
 ;;=F11.922^^93^1120^18
 ;;^UTILITY(U,$J,358.3,24965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24965,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24965,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,24965,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,24966,0)
 ;;=F11.99^^93^1120^22
 ;;^UTILITY(U,$J,358.3,24966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24966,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24966,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,24966,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,24967,0)
 ;;=F19.10^^93^1121^3
 ;;^UTILITY(U,$J,358.3,24967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24967,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,24967,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,24967,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,24968,0)
 ;;=F19.14^^93^1121^1
 ;;^UTILITY(U,$J,358.3,24968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24968,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,24968,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,24968,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,24969,0)
 ;;=F19.182^^93^1121^2
 ;;^UTILITY(U,$J,358.3,24969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24969,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,24969,1,4,0)
 ;;=4^F19.182
