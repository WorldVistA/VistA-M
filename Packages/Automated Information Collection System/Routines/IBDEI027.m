IBDEI027 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,537,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,537,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,537,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,538,0)
 ;;=F11.221^^3^53^14
 ;;^UTILITY(U,$J,358.3,538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,538,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,538,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,538,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,539,0)
 ;;=F11.921^^3^53^15
 ;;^UTILITY(U,$J,358.3,539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,539,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,539,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,539,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,540,0)
 ;;=F11.229^^3^53^20
 ;;^UTILITY(U,$J,358.3,540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,540,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,540,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,540,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,541,0)
 ;;=F11.929^^3^53^21
 ;;^UTILITY(U,$J,358.3,541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,541,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,541,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,541,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,542,0)
 ;;=F11.122^^3^53^16
 ;;^UTILITY(U,$J,358.3,542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,542,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,542,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,542,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,543,0)
 ;;=F11.222^^3^53^17
 ;;^UTILITY(U,$J,358.3,543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,543,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,543,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,543,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,544,0)
 ;;=F11.922^^3^53^18
 ;;^UTILITY(U,$J,358.3,544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,544,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,544,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,544,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,545,0)
 ;;=F11.99^^3^53^22
 ;;^UTILITY(U,$J,358.3,545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,545,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,545,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,545,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,546,0)
 ;;=F19.10^^3^54^3
 ;;^UTILITY(U,$J,358.3,546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,546,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,546,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,546,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,547,0)
 ;;=F19.14^^3^54^1
 ;;^UTILITY(U,$J,358.3,547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,547,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,547,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,547,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,548,0)
 ;;=F19.182^^3^54^2
 ;;^UTILITY(U,$J,358.3,548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,548,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,548,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,548,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,549,0)
 ;;=F19.20^^3^54^6
 ;;^UTILITY(U,$J,358.3,549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,549,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,549,1,4,0)
 ;;=4^F19.20
