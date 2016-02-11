IBDEI2A7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38313,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38313,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,38313,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,38314,0)
 ;;=F12.180^^177^1942^2
 ;;^UTILITY(U,$J,358.3,38314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38314,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,38314,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,38314,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,38315,0)
 ;;=F12.188^^177^1942^3
 ;;^UTILITY(U,$J,358.3,38315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38315,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38315,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,38315,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,38316,0)
 ;;=F12.20^^177^1942^4
 ;;^UTILITY(U,$J,358.3,38316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38316,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38316,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,38316,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,38317,0)
 ;;=F12.21^^177^1942^5
 ;;^UTILITY(U,$J,358.3,38317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38317,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,38317,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,38317,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,38318,0)
 ;;=F12.288^^177^1942^6
 ;;^UTILITY(U,$J,358.3,38318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38318,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,38318,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,38318,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,38319,0)
 ;;=F12.280^^177^1942^7
 ;;^UTILITY(U,$J,358.3,38319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38319,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38319,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,38319,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,38320,0)
 ;;=F16.10^^177^1943^1
 ;;^UTILITY(U,$J,358.3,38320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38320,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38320,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,38320,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,38321,0)
 ;;=F16.20^^177^1943^2
 ;;^UTILITY(U,$J,358.3,38321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38321,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38321,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,38321,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,38322,0)
 ;;=F16.21^^177^1943^3
 ;;^UTILITY(U,$J,358.3,38322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38322,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,38322,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,38322,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,38323,0)
 ;;=F11.10^^177^1944^4
 ;;^UTILITY(U,$J,358.3,38323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38323,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38323,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,38323,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,38324,0)
 ;;=F11.129^^177^1944^3
 ;;^UTILITY(U,$J,358.3,38324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38324,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38324,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,38324,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,38325,0)
 ;;=F11.14^^177^1944^8
 ;;^UTILITY(U,$J,358.3,38325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38325,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38325,1,4,0)
 ;;=4^F11.14
