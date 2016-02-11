IBDEI19A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21003,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,21003,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,21003,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,21004,0)
 ;;=F12.10^^99^1009^1
 ;;^UTILITY(U,$J,358.3,21004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21004,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,21004,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,21004,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,21005,0)
 ;;=F12.180^^99^1009^2
 ;;^UTILITY(U,$J,358.3,21005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21005,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,21005,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,21005,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,21006,0)
 ;;=F12.188^^99^1009^3
 ;;^UTILITY(U,$J,358.3,21006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21006,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,21006,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,21006,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,21007,0)
 ;;=F12.20^^99^1009^4
 ;;^UTILITY(U,$J,358.3,21007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21007,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,21007,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,21007,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,21008,0)
 ;;=F12.21^^99^1009^5
 ;;^UTILITY(U,$J,358.3,21008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21008,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,21008,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,21008,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,21009,0)
 ;;=F12.288^^99^1009^6
 ;;^UTILITY(U,$J,358.3,21009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21009,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,21009,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,21009,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,21010,0)
 ;;=F12.280^^99^1009^7
 ;;^UTILITY(U,$J,358.3,21010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21010,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,21010,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,21010,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,21011,0)
 ;;=F16.10^^99^1010^1
 ;;^UTILITY(U,$J,358.3,21011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21011,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,21011,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,21011,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,21012,0)
 ;;=F16.20^^99^1010^2
 ;;^UTILITY(U,$J,358.3,21012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21012,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,21012,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,21012,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,21013,0)
 ;;=F16.21^^99^1010^3
 ;;^UTILITY(U,$J,358.3,21013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21013,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,21013,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,21013,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,21014,0)
 ;;=F11.10^^99^1011^4
 ;;^UTILITY(U,$J,358.3,21014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21014,1,3,0)
 ;;=3^Opioid Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,21014,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,21014,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,21015,0)
 ;;=F11.129^^99^1011^3
 ;;^UTILITY(U,$J,358.3,21015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21015,1,3,0)
 ;;=3^Opioid Intoxication w/o Perceptual Disturbances;Mild Use Disorder
