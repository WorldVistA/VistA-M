IBDEI1BL ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21099,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21099,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,21099,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,21100,0)
 ;;=F11.181^^95^1046^10
 ;;^UTILITY(U,$J,358.3,21100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21100,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21100,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,21100,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,21101,0)
 ;;=F11.281^^95^1046^11
 ;;^UTILITY(U,$J,358.3,21101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21101,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21101,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,21101,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,21102,0)
 ;;=F11.981^^95^1046^12
 ;;^UTILITY(U,$J,358.3,21102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21102,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21102,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,21102,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,21103,0)
 ;;=F11.282^^95^1046^14
 ;;^UTILITY(U,$J,358.3,21103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21103,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21103,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,21103,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,21104,0)
 ;;=F11.982^^95^1046^15
 ;;^UTILITY(U,$J,358.3,21104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21104,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21104,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,21104,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,21105,0)
 ;;=F11.121^^95^1046^16
 ;;^UTILITY(U,$J,358.3,21105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21105,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21105,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,21105,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,21106,0)
 ;;=F11.221^^95^1046^17
 ;;^UTILITY(U,$J,358.3,21106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21106,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21106,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,21106,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,21107,0)
 ;;=F11.229^^95^1046^22
 ;;^UTILITY(U,$J,358.3,21107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21107,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21107,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,21107,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,21108,0)
 ;;=F11.929^^95^1046^23
 ;;^UTILITY(U,$J,358.3,21108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21108,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,21108,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,21108,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,21109,0)
 ;;=F11.122^^95^1046^18
 ;;^UTILITY(U,$J,358.3,21109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21109,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21109,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,21109,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,21110,0)
 ;;=F11.222^^95^1046^19
 ;;^UTILITY(U,$J,358.3,21110,1,0)
 ;;=^358.31IA^4^2
