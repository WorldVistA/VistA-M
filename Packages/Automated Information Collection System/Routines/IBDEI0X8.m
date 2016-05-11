IBDEI0X8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15591,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,15591,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,15592,0)
 ;;=F25.0^^58^681^3
 ;;^UTILITY(U,$J,358.3,15592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15592,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,15592,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,15592,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,15593,0)
 ;;=F25.1^^58^681^4
 ;;^UTILITY(U,$J,358.3,15593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15593,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,15593,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,15593,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,15594,0)
 ;;=F28.^^58^681^7
 ;;^UTILITY(U,$J,358.3,15594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15594,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,15594,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,15594,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,15595,0)
 ;;=F29.^^58^681^6
 ;;^UTILITY(U,$J,358.3,15595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15595,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15595,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,15595,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,15596,0)
 ;;=F52.32^^58^682^1
 ;;^UTILITY(U,$J,358.3,15596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15596,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,15596,1,4,0)
 ;;=4^F52.32
 ;;^UTILITY(U,$J,358.3,15596,2)
 ;;=^331927
 ;;^UTILITY(U,$J,358.3,15597,0)
 ;;=F52.21^^58^682^2
 ;;^UTILITY(U,$J,358.3,15597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15597,1,3,0)
 ;;=3^Erectile Disorder
 ;;^UTILITY(U,$J,358.3,15597,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,15597,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,15598,0)
 ;;=F52.31^^58^682^3
 ;;^UTILITY(U,$J,358.3,15598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15598,1,3,0)
 ;;=3^Female Orgasmic Disorder
 ;;^UTILITY(U,$J,358.3,15598,1,4,0)
 ;;=4^F52.31
 ;;^UTILITY(U,$J,358.3,15598,2)
 ;;=^331926
 ;;^UTILITY(U,$J,358.3,15599,0)
 ;;=F52.22^^58^682^4
 ;;^UTILITY(U,$J,358.3,15599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15599,1,3,0)
 ;;=3^Female Sexual Interest/Arousal Disorder
 ;;^UTILITY(U,$J,358.3,15599,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,15599,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,15600,0)
 ;;=F52.6^^58^682^5
 ;;^UTILITY(U,$J,358.3,15600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15600,1,3,0)
 ;;=3^Genito-Pelvic Pain/Penetration Disorder
 ;;^UTILITY(U,$J,358.3,15600,1,4,0)
 ;;=4^F52.6
 ;;^UTILITY(U,$J,358.3,15600,2)
 ;;=^5003623
 ;;^UTILITY(U,$J,358.3,15601,0)
 ;;=F52.0^^58^682^6
 ;;^UTILITY(U,$J,358.3,15601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15601,1,3,0)
 ;;=3^Male Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,15601,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,15601,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,15602,0)
 ;;=F52.4^^58^682^7
 ;;^UTILITY(U,$J,358.3,15602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15602,1,3,0)
 ;;=3^Premature (Early) Ejaculation
 ;;^UTILITY(U,$J,358.3,15602,1,4,0)
 ;;=4^F52.4
 ;;^UTILITY(U,$J,358.3,15602,2)
 ;;=^331928
 ;;^UTILITY(U,$J,358.3,15603,0)
 ;;=F52.8^^58^682^9
 ;;^UTILITY(U,$J,358.3,15603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15603,1,3,0)
 ;;=3^Sexual Dysfuntion NEC
 ;;^UTILITY(U,$J,358.3,15603,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,15603,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,15604,0)
 ;;=F52.9^^58^682^8
 ;;^UTILITY(U,$J,358.3,15604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15604,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,15604,1,4,0)
 ;;=4^F52.9
