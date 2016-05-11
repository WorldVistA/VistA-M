IBDEI022 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,474,0)
 ;;=F15.23^^3^50^1
 ;;^UTILITY(U,$J,358.3,474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,474,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,474,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,474,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,475,0)
 ;;=F12.10^^3^51^16
 ;;^UTILITY(U,$J,358.3,475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,475,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,475,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,475,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,476,0)
 ;;=F12.180^^3^51^20
 ;;^UTILITY(U,$J,358.3,476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,476,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,476,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,476,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,477,0)
 ;;=F12.188^^3^51^22
 ;;^UTILITY(U,$J,358.3,477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,477,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,477,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,477,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,478,0)
 ;;=F12.20^^3^51^17
 ;;^UTILITY(U,$J,358.3,478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,478,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,478,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,478,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,479,0)
 ;;=F12.21^^3^51^18
 ;;^UTILITY(U,$J,358.3,479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,479,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,479,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,479,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,480,0)
 ;;=F12.288^^3^51^19
 ;;^UTILITY(U,$J,358.3,480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,480,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,480,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,480,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,481,0)
 ;;=F12.280^^3^51^21
 ;;^UTILITY(U,$J,358.3,481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,481,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,481,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,481,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,482,0)
 ;;=F12.121^^3^51^6
 ;;^UTILITY(U,$J,358.3,482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,482,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,482,1,4,0)
 ;;=4^F12.121
 ;;^UTILITY(U,$J,358.3,482,2)
 ;;=^5003157
 ;;^UTILITY(U,$J,358.3,483,0)
 ;;=F12.221^^3^51^7
 ;;^UTILITY(U,$J,358.3,483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,483,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,483,1,4,0)
 ;;=4^F12.221
 ;;^UTILITY(U,$J,358.3,483,2)
 ;;=^5003169
 ;;^UTILITY(U,$J,358.3,484,0)
 ;;=F12.921^^3^51^8
 ;;^UTILITY(U,$J,358.3,484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,484,1,3,0)
 ;;=3^Cannabis Intoxication Delium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,484,1,4,0)
 ;;=4^F12.921
 ;;^UTILITY(U,$J,358.3,484,2)
 ;;=^5003180
 ;;^UTILITY(U,$J,358.3,485,0)
 ;;=F12.229^^3^51^12
 ;;^UTILITY(U,$J,358.3,485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,485,1,3,0)
 ;;=3^Cannabis Intoxication w/o Perceptual Disturbances w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,485,1,4,0)
 ;;=4^F12.229
 ;;^UTILITY(U,$J,358.3,485,2)
 ;;=^5003171
 ;;^UTILITY(U,$J,358.3,486,0)
 ;;=F12.122^^3^51^9
 ;;^UTILITY(U,$J,358.3,486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,486,1,3,0)
 ;;=3^Cannabis Intoxication w/ Perceptual Disturbances w/ Mild Use Disorder
