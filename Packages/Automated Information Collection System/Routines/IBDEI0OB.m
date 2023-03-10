IBDEI0OB ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10932,1,3,0)
 ;;=3^Opioid Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,10932,1,4,0)
 ;;=4^F11.94
 ;;^UTILITY(U,$J,358.3,10932,2)
 ;;=^5003148
 ;;^UTILITY(U,$J,358.3,10933,0)
 ;;=F11.181^^42^494^10
 ;;^UTILITY(U,$J,358.3,10933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10933,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,10933,1,4,0)
 ;;=4^F11.181
 ;;^UTILITY(U,$J,358.3,10933,2)
 ;;=^5003123
 ;;^UTILITY(U,$J,358.3,10934,0)
 ;;=F11.281^^42^494^11
 ;;^UTILITY(U,$J,358.3,10934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10934,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,10934,1,4,0)
 ;;=4^F11.281
 ;;^UTILITY(U,$J,358.3,10934,2)
 ;;=^5003138
 ;;^UTILITY(U,$J,358.3,10935,0)
 ;;=F11.981^^42^494^12
 ;;^UTILITY(U,$J,358.3,10935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10935,1,3,0)
 ;;=3^Opioid Induced Sexual Dysfunction w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,10935,1,4,0)
 ;;=4^F11.981
 ;;^UTILITY(U,$J,358.3,10935,2)
 ;;=^5003152
 ;;^UTILITY(U,$J,358.3,10936,0)
 ;;=F11.282^^42^494^14
 ;;^UTILITY(U,$J,358.3,10936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10936,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,10936,1,4,0)
 ;;=4^F11.282
 ;;^UTILITY(U,$J,358.3,10936,2)
 ;;=^5003139
 ;;^UTILITY(U,$J,358.3,10937,0)
 ;;=F11.982^^42^494^15
 ;;^UTILITY(U,$J,358.3,10937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10937,1,3,0)
 ;;=3^Opioid Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,10937,1,4,0)
 ;;=4^F11.982
 ;;^UTILITY(U,$J,358.3,10937,2)
 ;;=^5003153
 ;;^UTILITY(U,$J,358.3,10938,0)
 ;;=F11.121^^42^494^16
 ;;^UTILITY(U,$J,358.3,10938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10938,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,10938,1,4,0)
 ;;=4^F11.121
 ;;^UTILITY(U,$J,358.3,10938,2)
 ;;=^5003116
 ;;^UTILITY(U,$J,358.3,10939,0)
 ;;=F11.221^^42^494^17
 ;;^UTILITY(U,$J,358.3,10939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10939,1,3,0)
 ;;=3^Opioid Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,10939,1,4,0)
 ;;=4^F11.221
 ;;^UTILITY(U,$J,358.3,10939,2)
 ;;=^5003130
 ;;^UTILITY(U,$J,358.3,10940,0)
 ;;=F11.229^^42^494^22
 ;;^UTILITY(U,$J,358.3,10940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10940,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,10940,1,4,0)
 ;;=4^F11.229
 ;;^UTILITY(U,$J,358.3,10940,2)
 ;;=^5003132
 ;;^UTILITY(U,$J,358.3,10941,0)
 ;;=F11.929^^42^494^23
 ;;^UTILITY(U,$J,358.3,10941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10941,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbance w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,10941,1,4,0)
 ;;=4^F11.929
 ;;^UTILITY(U,$J,358.3,10941,2)
 ;;=^5003146
 ;;^UTILITY(U,$J,358.3,10942,0)
 ;;=F11.122^^42^494^18
 ;;^UTILITY(U,$J,358.3,10942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10942,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,10942,1,4,0)
 ;;=4^F11.122
 ;;^UTILITY(U,$J,358.3,10942,2)
 ;;=^5003117
 ;;^UTILITY(U,$J,358.3,10943,0)
 ;;=F11.222^^42^494^19
 ;;^UTILITY(U,$J,358.3,10943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10943,1,3,0)
 ;;=3^Opioid Intoxication w/ Perceptual Disturbance w/ Mod/Severe Use Disorder
