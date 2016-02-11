IBDEI02I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,406,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,406,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,407,0)
 ;;=F12.188^^3^51^3
 ;;^UTILITY(U,$J,358.3,407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,407,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,407,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,407,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,408,0)
 ;;=F12.20^^3^51^4
 ;;^UTILITY(U,$J,358.3,408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,408,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,408,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,408,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,409,0)
 ;;=F12.21^^3^51^5
 ;;^UTILITY(U,$J,358.3,409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,409,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,409,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,409,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,410,0)
 ;;=F12.288^^3^51^6
 ;;^UTILITY(U,$J,358.3,410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,410,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,410,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,410,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,411,0)
 ;;=F12.280^^3^51^7
 ;;^UTILITY(U,$J,358.3,411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,411,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,411,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,411,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,412,0)
 ;;=F16.10^^3^52^1
 ;;^UTILITY(U,$J,358.3,412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,412,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,412,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,412,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,413,0)
 ;;=F16.20^^3^52^2
 ;;^UTILITY(U,$J,358.3,413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,413,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,413,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,413,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,414,0)
 ;;=F16.21^^3^52^3
 ;;^UTILITY(U,$J,358.3,414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,414,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,414,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,414,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,415,0)
 ;;=F11.10^^3^53^4
 ;;^UTILITY(U,$J,358.3,415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,415,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,415,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,415,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,416,0)
 ;;=F11.129^^3^53^3
 ;;^UTILITY(U,$J,358.3,416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,416,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,416,1,4,0)
 ;;=4^F11.129
 ;;^UTILITY(U,$J,358.3,416,2)
 ;;=^5003118
 ;;^UTILITY(U,$J,358.3,417,0)
 ;;=F11.14^^3^53^8
 ;;^UTILITY(U,$J,358.3,417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,417,1,3,0)
 ;;=3^Opioid-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,417,1,4,0)
 ;;=4^F11.14
 ;;^UTILITY(U,$J,358.3,417,2)
 ;;=^5003119
 ;;^UTILITY(U,$J,358.3,418,0)
 ;;=F11.182^^3^53^10
 ;;^UTILITY(U,$J,358.3,418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,418,1,3,0)
 ;;=3^Opioid-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,418,1,4,0)
 ;;=4^F11.182
 ;;^UTILITY(U,$J,358.3,418,2)
 ;;=^5003124
 ;;^UTILITY(U,$J,358.3,419,0)
 ;;=F11.20^^3^53^5
 ;;^UTILITY(U,$J,358.3,419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,419,1,3,0)
 ;;=3^Opioid Use Disorder,Moderate-Severe
