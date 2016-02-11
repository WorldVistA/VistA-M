IBDEI369 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53257,1,3,0)
 ;;=3^Dementia in oth diseases w/o behavrl disturb
 ;;^UTILITY(U,$J,358.3,53257,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,53257,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,53258,0)
 ;;=F02.81^^245^2676^6
 ;;^UTILITY(U,$J,358.3,53258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53258,1,3,0)
 ;;=3^Dementia in oth diseases w/ behavioral disturb
 ;;^UTILITY(U,$J,358.3,53258,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,53258,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,53259,0)
 ;;=F03.90^^245^2676^8
 ;;^UTILITY(U,$J,358.3,53259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53259,1,3,0)
 ;;=3^Dementia w/o behavioral disturbance
 ;;^UTILITY(U,$J,358.3,53259,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,53259,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,53260,0)
 ;;=F07.0^^245^2676^14
 ;;^UTILITY(U,$J,358.3,53260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53260,1,3,0)
 ;;=3^Personality change d/t physiological condition
 ;;^UTILITY(U,$J,358.3,53260,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,53260,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,53261,0)
 ;;=F10.10^^245^2676^2
 ;;^UTILITY(U,$J,358.3,53261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53261,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,53261,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,53261,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,53262,0)
 ;;=F10.20^^245^2676^3
 ;;^UTILITY(U,$J,358.3,53262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53262,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,53262,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,53262,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,53263,0)
 ;;=F17.200^^245^2676^11
 ;;^UTILITY(U,$J,358.3,53263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53263,1,3,0)
 ;;=3^Nicotine dependence, unspecified, uncomplicated
 ;;^UTILITY(U,$J,358.3,53263,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,53263,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,53264,0)
 ;;=F20.5^^245^2676^15
 ;;^UTILITY(U,$J,358.3,53264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53264,1,3,0)
 ;;=3^Residual schizophrenia
 ;;^UTILITY(U,$J,358.3,53264,1,4,0)
 ;;=4^F20.5
 ;;^UTILITY(U,$J,358.3,53264,2)
 ;;=^5003473
 ;;^UTILITY(U,$J,358.3,53265,0)
 ;;=F31.9^^245^2676^5
 ;;^UTILITY(U,$J,358.3,53265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53265,1,3,0)
 ;;=3^Bipolar disorder, unspecified
 ;;^UTILITY(U,$J,358.3,53265,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,53265,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,53266,0)
 ;;=F32.9^^245^2676^10
 ;;^UTILITY(U,$J,358.3,53266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53266,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,53266,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,53266,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,53267,0)
 ;;=F33.9^^245^2676^9
 ;;^UTILITY(U,$J,358.3,53267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53267,1,3,0)
 ;;=3^Major depressive disorder, recurrent, unspecified
 ;;^UTILITY(U,$J,358.3,53267,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,53267,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,53268,0)
 ;;=F41.9^^245^2676^4
 ;;^UTILITY(U,$J,358.3,53268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53268,1,3,0)
 ;;=3^Anxiety disorder, unspecified
 ;;^UTILITY(U,$J,358.3,53268,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,53268,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,53269,0)
 ;;=F43.0^^245^2676^1
 ;;^UTILITY(U,$J,358.3,53269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53269,1,3,0)
 ;;=3^Acute stress reaction
 ;;^UTILITY(U,$J,358.3,53269,1,4,0)
 ;;=4^F43.0
 ;;^UTILITY(U,$J,358.3,53269,2)
 ;;=^5003569
