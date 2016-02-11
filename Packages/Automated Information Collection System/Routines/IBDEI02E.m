IBDEI02E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,353,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,353,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,353,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,354,0)
 ;;=F20.9^^3^46^5
 ;;^UTILITY(U,$J,358.3,354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,354,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,354,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,354,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,355,0)
 ;;=F20.81^^3^46^6
 ;;^UTILITY(U,$J,358.3,355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,355,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,355,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,355,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,356,0)
 ;;=F22.^^3^46^2
 ;;^UTILITY(U,$J,358.3,356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,356,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,356,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,356,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,357,0)
 ;;=F23.^^3^46^1
 ;;^UTILITY(U,$J,358.3,357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,357,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,357,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,357,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,358,0)
 ;;=F25.0^^3^46^3
 ;;^UTILITY(U,$J,358.3,358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,358,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,358,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,358,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,359,0)
 ;;=F25.1^^3^46^4
 ;;^UTILITY(U,$J,358.3,359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,359,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,359,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,359,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,360,0)
 ;;=F52.32^^3^47^1
 ;;^UTILITY(U,$J,358.3,360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,360,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,360,1,4,0)
 ;;=4^F52.32
 ;;^UTILITY(U,$J,358.3,360,2)
 ;;=^331927
 ;;^UTILITY(U,$J,358.3,361,0)
 ;;=F52.21^^3^47^2
 ;;^UTILITY(U,$J,358.3,361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,361,1,3,0)
 ;;=3^Erectile Disorder
 ;;^UTILITY(U,$J,358.3,361,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,361,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,362,0)
 ;;=F52.31^^3^47^3
 ;;^UTILITY(U,$J,358.3,362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,362,1,3,0)
 ;;=3^Female Orgasmic Disorder
 ;;^UTILITY(U,$J,358.3,362,1,4,0)
 ;;=4^F52.31
 ;;^UTILITY(U,$J,358.3,362,2)
 ;;=^331926
 ;;^UTILITY(U,$J,358.3,363,0)
 ;;=F52.22^^3^47^4
 ;;^UTILITY(U,$J,358.3,363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,363,1,3,0)
 ;;=3^Female Sexual Interest/Arousal Disorder
 ;;^UTILITY(U,$J,358.3,363,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,363,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,364,0)
 ;;=F52.6^^3^47^5
 ;;^UTILITY(U,$J,358.3,364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,364,1,3,0)
 ;;=3^Genito-Pelvic Pain/Penetration Disorder
 ;;^UTILITY(U,$J,358.3,364,1,4,0)
 ;;=4^F52.6
 ;;^UTILITY(U,$J,358.3,364,2)
 ;;=^5003623
 ;;^UTILITY(U,$J,358.3,365,0)
 ;;=F52.0^^3^47^6
 ;;^UTILITY(U,$J,358.3,365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,365,1,3,0)
 ;;=3^Male Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,365,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,365,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,366,0)
 ;;=F52.4^^3^47^7
 ;;^UTILITY(U,$J,358.3,366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,366,1,3,0)
 ;;=3^Premature (Early) Ejaculation
 ;;^UTILITY(U,$J,358.3,366,1,4,0)
 ;;=4^F52.4
 ;;^UTILITY(U,$J,358.3,366,2)
 ;;=^331928
 ;;^UTILITY(U,$J,358.3,367,0)
 ;;=F52.8^^3^47^9
