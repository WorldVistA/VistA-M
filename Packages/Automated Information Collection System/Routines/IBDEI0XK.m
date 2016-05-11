IBDEI0XK ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15739,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15739,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,15739,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,15740,0)
 ;;=F11.921^^58^688^15
 ;;^UTILITY(U,$J,358.3,15740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15740,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15740,1,4,0)
 ;;=4^F11.921
 ;;^UTILITY(U,$J,358.3,15740,2)
 ;;=^5003144
 ;;^UTILITY(U,$J,358.3,15741,0)
 ;;=F11.229^^58^688^20
 ;;^UTILITY(U,$J,358.3,15741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15741,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15741,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,15741,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,15742,0)
 ;;=F11.929^^58^688^21
 ;;^UTILITY(U,$J,358.3,15742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15742,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15742,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,15742,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,15743,0)
 ;;=F11.122^^58^688^16
 ;;^UTILITY(U,$J,358.3,15743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15743,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15743,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,15743,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,15744,0)
 ;;=F11.222^^58^688^17
 ;;^UTILITY(U,$J,358.3,15744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15744,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15744,1,4,0)
 ;;=4^F11.222
 ;;^UTILITY(U,$J,358.3,15744,2)
 ;;=^5003131
 ;;^UTILITY(U,$J,358.3,15745,0)
 ;;=F11.922^^58^688^18
 ;;^UTILITY(U,$J,358.3,15745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15745,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15745,1,4,0)
 ;;=4^F11.922
 ;;^UTILITY(U,$J,358.3,15745,2)
 ;;=^5003145
 ;;^UTILITY(U,$J,358.3,15746,0)
 ;;=F11.99^^58^688^22
 ;;^UTILITY(U,$J,358.3,15746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15746,1,3,0)
 ;;=3^Opioid Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15746,1,4,0)
 ;;=4^F11.99
 ;;^UTILITY(U,$J,358.3,15746,2)
 ;;=^5133352
 ;;^UTILITY(U,$J,358.3,15747,0)
 ;;=F19.10^^58^689^3
 ;;^UTILITY(U,$J,358.3,15747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15747,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15747,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,15747,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,15748,0)
 ;;=F19.14^^58^689^1
 ;;^UTILITY(U,$J,358.3,15748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15748,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,15748,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,15748,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,15749,0)
 ;;=F19.182^^58^689^2
 ;;^UTILITY(U,$J,358.3,15749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15749,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,15749,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,15749,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,15750,0)
 ;;=F19.20^^58^689^6
 ;;^UTILITY(U,$J,358.3,15750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15750,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,15750,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,15750,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,15751,0)
 ;;=F19.21^^58^689^5
 ;;^UTILITY(U,$J,358.3,15751,1,0)
 ;;=^358.31IA^4^2
