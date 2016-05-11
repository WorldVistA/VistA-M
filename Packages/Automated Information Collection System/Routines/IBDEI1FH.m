IBDEI1FH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24273,0)
 ;;=F15.10^^90^1062^4
 ;;^UTILITY(U,$J,358.3,24273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24273,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24273,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,24273,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,24274,0)
 ;;=F15.14^^90^1062^2
 ;;^UTILITY(U,$J,358.3,24274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24274,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24274,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,24274,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,24275,0)
 ;;=F15.182^^90^1062^3
 ;;^UTILITY(U,$J,358.3,24275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24275,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24275,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,24275,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,24276,0)
 ;;=F15.20^^90^1062^5
 ;;^UTILITY(U,$J,358.3,24276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24276,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24276,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,24276,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,24277,0)
 ;;=F15.21^^90^1062^6
 ;;^UTILITY(U,$J,358.3,24277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24277,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,24277,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,24277,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,24278,0)
 ;;=F15.23^^90^1062^1
 ;;^UTILITY(U,$J,358.3,24278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24278,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,24278,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,24278,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,24279,0)
 ;;=F12.10^^90^1063^16
 ;;^UTILITY(U,$J,358.3,24279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24279,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,24279,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,24279,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,24280,0)
 ;;=F12.180^^90^1063^20
 ;;^UTILITY(U,$J,358.3,24280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24280,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,24280,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,24280,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,24281,0)
 ;;=F12.188^^90^1063^22
 ;;^UTILITY(U,$J,358.3,24281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24281,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24281,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,24281,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,24282,0)
 ;;=F12.20^^90^1063^17
 ;;^UTILITY(U,$J,358.3,24282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24282,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,24282,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,24282,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,24283,0)
 ;;=F12.21^^90^1063^18
 ;;^UTILITY(U,$J,358.3,24283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24283,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,24283,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,24283,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,24284,0)
 ;;=F12.288^^90^1063^19
 ;;^UTILITY(U,$J,358.3,24284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24284,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,24284,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,24284,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,24285,0)
 ;;=F12.280^^90^1063^21
 ;;^UTILITY(U,$J,358.3,24285,1,0)
 ;;=^358.31IA^4^2
