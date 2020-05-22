IBDEI1H8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23615,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,23615,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,23615,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,23616,0)
 ;;=F15.21^^105^1176^7
 ;;^UTILITY(U,$J,358.3,23616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23616,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,23616,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,23616,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,23617,0)
 ;;=F15.23^^105^1176^2
 ;;^UTILITY(U,$J,358.3,23617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23617,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,23617,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,23617,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,23618,0)
 ;;=F15.11^^105^1176^1
 ;;^UTILITY(U,$J,358.3,23618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23618,1,3,0)
 ;;=3^Amphetamine or Other Stimulalant Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,23618,1,4,0)
 ;;=4^F15.11
 ;;^UTILITY(U,$J,358.3,23618,2)
 ;;=^5151304
 ;;^UTILITY(U,$J,358.3,23619,0)
 ;;=F12.10^^105^1177^3
 ;;^UTILITY(U,$J,358.3,23619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23619,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,23619,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,23619,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,23620,0)
 ;;=F12.180^^105^1177^8
 ;;^UTILITY(U,$J,358.3,23620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23620,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
 ;;^UTILITY(U,$J,358.3,23620,1,4,0)
 ;;=4^F12.180
 ;;^UTILITY(U,$J,358.3,23620,2)
 ;;=^5003163
 ;;^UTILITY(U,$J,358.3,23621,0)
 ;;=F12.188^^105^1177^10
 ;;^UTILITY(U,$J,358.3,23621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23621,1,3,0)
 ;;=3^Cannabis-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23621,1,4,0)
 ;;=4^F12.188
 ;;^UTILITY(U,$J,358.3,23621,2)
 ;;=^5003164
 ;;^UTILITY(U,$J,358.3,23622,0)
 ;;=F12.20^^105^1177^4
 ;;^UTILITY(U,$J,358.3,23622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23622,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,23622,1,4,0)
 ;;=4^F12.20
 ;;^UTILITY(U,$J,358.3,23622,2)
 ;;=^5003166
 ;;^UTILITY(U,$J,358.3,23623,0)
 ;;=F12.21^^105^1177^5
 ;;^UTILITY(U,$J,358.3,23623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23623,1,3,0)
 ;;=3^Cannabis Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,23623,1,4,0)
 ;;=4^F12.21
 ;;^UTILITY(U,$J,358.3,23623,2)
 ;;=^5003167
 ;;^UTILITY(U,$J,358.3,23624,0)
 ;;=F12.288^^105^1177^7
 ;;^UTILITY(U,$J,358.3,23624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23624,1,3,0)
 ;;=3^Cannabis Withdrawal
 ;;^UTILITY(U,$J,358.3,23624,1,4,0)
 ;;=4^F12.288
 ;;^UTILITY(U,$J,358.3,23624,2)
 ;;=^5003176
 ;;^UTILITY(U,$J,358.3,23625,0)
 ;;=F12.280^^105^1177^9
 ;;^UTILITY(U,$J,358.3,23625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23625,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23625,1,4,0)
 ;;=4^F12.280
 ;;^UTILITY(U,$J,358.3,23625,2)
 ;;=^5003175
 ;;^UTILITY(U,$J,358.3,23626,0)
 ;;=F12.11^^105^1177^1
 ;;^UTILITY(U,$J,358.3,23626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23626,1,3,0)
 ;;=3^Cannabis Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,23626,1,4,0)
 ;;=4^F12.11
 ;;^UTILITY(U,$J,358.3,23626,2)
 ;;=^268236
