IBDEI01W ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,396,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,396,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,397,0)
 ;;=F52.31^^3^47^3
 ;;^UTILITY(U,$J,358.3,397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,397,1,3,0)
 ;;=3^Female Orgasmic Disorder
 ;;^UTILITY(U,$J,358.3,397,1,4,0)
 ;;=4^F52.31
 ;;^UTILITY(U,$J,358.3,397,2)
 ;;=^331926
 ;;^UTILITY(U,$J,358.3,398,0)
 ;;=F52.22^^3^47^4
 ;;^UTILITY(U,$J,358.3,398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,398,1,3,0)
 ;;=3^Female Sexual Interest/Arousal Disorder
 ;;^UTILITY(U,$J,358.3,398,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,398,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,399,0)
 ;;=F52.6^^3^47^5
 ;;^UTILITY(U,$J,358.3,399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,399,1,3,0)
 ;;=3^Genito-Pelvic Pain/Penetration Disorder
 ;;^UTILITY(U,$J,358.3,399,1,4,0)
 ;;=4^F52.6
 ;;^UTILITY(U,$J,358.3,399,2)
 ;;=^5003623
 ;;^UTILITY(U,$J,358.3,400,0)
 ;;=F52.0^^3^47^6
 ;;^UTILITY(U,$J,358.3,400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,400,1,3,0)
 ;;=3^Male Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,400,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,400,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,401,0)
 ;;=F52.4^^3^47^7
 ;;^UTILITY(U,$J,358.3,401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,401,1,3,0)
 ;;=3^Premature (Early) Ejaculation
 ;;^UTILITY(U,$J,358.3,401,1,4,0)
 ;;=4^F52.4
 ;;^UTILITY(U,$J,358.3,401,2)
 ;;=^331928
 ;;^UTILITY(U,$J,358.3,402,0)
 ;;=F52.8^^3^47^9
 ;;^UTILITY(U,$J,358.3,402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,402,1,3,0)
 ;;=3^Sexual Dysfuntion NEC
 ;;^UTILITY(U,$J,358.3,402,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,402,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,403,0)
 ;;=F52.9^^3^47^8
 ;;^UTILITY(U,$J,358.3,403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,403,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,403,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,403,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,404,0)
 ;;=G47.09^^3^48^14
 ;;^UTILITY(U,$J,358.3,404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,404,1,3,0)
 ;;=3^Insomnia,Other
 ;;^UTILITY(U,$J,358.3,404,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,404,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,405,0)
 ;;=G47.00^^3^48^15
 ;;^UTILITY(U,$J,358.3,405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,405,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,405,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,405,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,406,0)
 ;;=G47.10^^3^48^12
 ;;^UTILITY(U,$J,358.3,406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,406,1,3,0)
 ;;=3^Hypersomnolence Disorder/Unspec Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,406,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,406,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,407,0)
 ;;=G47.419^^3^48^17
 ;;^UTILITY(U,$J,358.3,407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,407,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy w/ Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,407,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,407,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,408,0)
 ;;=G47.33^^3^48^21
 ;;^UTILITY(U,$J,358.3,408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,408,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,408,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,408,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,409,0)
 ;;=G47.31^^3^48^1
 ;;^UTILITY(U,$J,358.3,409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,409,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,409,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,409,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,410,0)
 ;;=G47.21^^3^48^5
 ;;^UTILITY(U,$J,358.3,410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,410,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
