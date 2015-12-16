IBDEI07X ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3210,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,3210,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,3210,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,3211,0)
 ;;=F25.0^^8^109^3
 ;;^UTILITY(U,$J,358.3,3211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3211,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,3211,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,3211,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,3212,0)
 ;;=F25.1^^8^109^4
 ;;^UTILITY(U,$J,358.3,3212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3212,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,3212,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,3212,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,3213,0)
 ;;=F52.32^^8^110^1
 ;;^UTILITY(U,$J,358.3,3213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3213,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,3213,1,4,0)
 ;;=4^F52.32
 ;;^UTILITY(U,$J,358.3,3213,2)
 ;;=^331927
 ;;^UTILITY(U,$J,358.3,3214,0)
 ;;=F52.21^^8^110^2
 ;;^UTILITY(U,$J,358.3,3214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3214,1,3,0)
 ;;=3^Erectile Disorder
 ;;^UTILITY(U,$J,358.3,3214,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,3214,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,3215,0)
 ;;=F52.31^^8^110^3
 ;;^UTILITY(U,$J,358.3,3215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3215,1,3,0)
 ;;=3^Female Orgasmic Disorder
 ;;^UTILITY(U,$J,358.3,3215,1,4,0)
 ;;=4^F52.31
 ;;^UTILITY(U,$J,358.3,3215,2)
 ;;=^331926
 ;;^UTILITY(U,$J,358.3,3216,0)
 ;;=F52.22^^8^110^4
 ;;^UTILITY(U,$J,358.3,3216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3216,1,3,0)
 ;;=3^Female Sexual Interest/Arousal Disorder
 ;;^UTILITY(U,$J,358.3,3216,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,3216,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,3217,0)
 ;;=F52.6^^8^110^5
 ;;^UTILITY(U,$J,358.3,3217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3217,1,3,0)
 ;;=3^Genito-Pelvic Pain/Penetration Disorder
 ;;^UTILITY(U,$J,358.3,3217,1,4,0)
 ;;=4^F52.6
 ;;^UTILITY(U,$J,358.3,3217,2)
 ;;=^5003623
 ;;^UTILITY(U,$J,358.3,3218,0)
 ;;=F52.0^^8^110^6
 ;;^UTILITY(U,$J,358.3,3218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3218,1,3,0)
 ;;=3^Male Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,3218,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,3218,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,3219,0)
 ;;=F52.4^^8^110^7
 ;;^UTILITY(U,$J,358.3,3219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3219,1,3,0)
 ;;=3^Premature (Early) Ejaculation
 ;;^UTILITY(U,$J,358.3,3219,1,4,0)
 ;;=4^F52.4
 ;;^UTILITY(U,$J,358.3,3219,2)
 ;;=^331928
 ;;^UTILITY(U,$J,358.3,3220,0)
 ;;=F52.8^^8^110^9
 ;;^UTILITY(U,$J,358.3,3220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3220,1,3,0)
 ;;=3^Sexual Dysfuntion NEC
 ;;^UTILITY(U,$J,358.3,3220,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,3220,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,3221,0)
 ;;=F52.9^^8^110^8
 ;;^UTILITY(U,$J,358.3,3221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3221,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,3221,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,3221,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,3222,0)
 ;;=G47.09^^8^111^11
 ;;^UTILITY(U,$J,358.3,3222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3222,1,3,0)
 ;;=3^Insomnia Disorder NEC
 ;;^UTILITY(U,$J,358.3,3222,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,3222,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,3223,0)
 ;;=G47.00^^8^111^10
 ;;^UTILITY(U,$J,358.3,3223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3223,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,3223,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,3223,2)
 ;;=^332924
