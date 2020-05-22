IBDEI2UB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45303,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,45304,0)
 ;;=F03.90^^172^2263^9
 ;;^UTILITY(U,$J,358.3,45304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45304,1,3,0)
 ;;=3^Dementia w/o behavioral disturbance
 ;;^UTILITY(U,$J,358.3,45304,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,45304,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,45305,0)
 ;;=F07.0^^172^2263^15
 ;;^UTILITY(U,$J,358.3,45305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45305,1,3,0)
 ;;=3^Personality change d/t physiological condition
 ;;^UTILITY(U,$J,358.3,45305,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,45305,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,45306,0)
 ;;=F10.10^^172^2263^3
 ;;^UTILITY(U,$J,358.3,45306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45306,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,45306,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,45306,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,45307,0)
 ;;=F10.20^^172^2263^4
 ;;^UTILITY(U,$J,358.3,45307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45307,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,45307,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,45307,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,45308,0)
 ;;=F17.200^^172^2263^12
 ;;^UTILITY(U,$J,358.3,45308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45308,1,3,0)
 ;;=3^Nicotine dependence, unspecified, uncomplicated
 ;;^UTILITY(U,$J,358.3,45308,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,45308,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,45309,0)
 ;;=F20.5^^172^2263^16
 ;;^UTILITY(U,$J,358.3,45309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45309,1,3,0)
 ;;=3^Residual schizophrenia
 ;;^UTILITY(U,$J,358.3,45309,1,4,0)
 ;;=4^F20.5
 ;;^UTILITY(U,$J,358.3,45309,2)
 ;;=^5003473
 ;;^UTILITY(U,$J,358.3,45310,0)
 ;;=F31.9^^172^2263^6
 ;;^UTILITY(U,$J,358.3,45310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45310,1,3,0)
 ;;=3^Bipolar disorder, unspecified
 ;;^UTILITY(U,$J,358.3,45310,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,45310,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,45311,0)
 ;;=F32.9^^172^2263^11
 ;;^UTILITY(U,$J,358.3,45311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45311,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,45311,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,45311,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,45312,0)
 ;;=F33.9^^172^2263^10
 ;;^UTILITY(U,$J,358.3,45312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45312,1,3,0)
 ;;=3^Major depressive disorder, recurrent, unspecified
 ;;^UTILITY(U,$J,358.3,45312,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,45312,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,45313,0)
 ;;=F41.9^^172^2263^5
 ;;^UTILITY(U,$J,358.3,45313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45313,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,45313,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,45313,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,45314,0)
 ;;=F43.0^^172^2263^1
 ;;^UTILITY(U,$J,358.3,45314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45314,1,3,0)
 ;;=3^Acute stress reaction
 ;;^UTILITY(U,$J,358.3,45314,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,45314,2)
 ;;=^5003569
 ;;^UTILITY(U,$J,358.3,45315,0)
 ;;=F43.10^^172^2263^14
 ;;^UTILITY(U,$J,358.3,45315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45315,1,3,0)
 ;;=3^PTSD, unspec
 ;;^UTILITY(U,$J,358.3,45315,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,45315,2)
 ;;=^5003570
