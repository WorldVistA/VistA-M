IBDEI04C ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1503,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,1503,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,1503,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,1504,0)
 ;;=F10.21^^3^44^3
 ;;^UTILITY(U,$J,358.3,1504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1504,1,3,0)
 ;;=3^Alcohol dependence, in remission
 ;;^UTILITY(U,$J,358.3,1504,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,1504,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,1505,0)
 ;;=F11.20^^3^44^19
 ;;^UTILITY(U,$J,358.3,1505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1505,1,3,0)
 ;;=3^Opioid dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,1505,1,4,0)
 ;;=4^F11.20
 ;;^UTILITY(U,$J,358.3,1505,2)
 ;;=^5003127
 ;;^UTILITY(U,$J,358.3,1506,0)
 ;;=F14.20^^3^44^8
 ;;^UTILITY(U,$J,358.3,1506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1506,1,3,0)
 ;;=3^Cocaine dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,1506,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,1506,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,1507,0)
 ;;=F10.10^^3^44^2
 ;;^UTILITY(U,$J,358.3,1507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1507,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,1507,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,1507,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,1508,0)
 ;;=F17.200^^3^44^16
 ;;^UTILITY(U,$J,358.3,1508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1508,1,3,0)
 ;;=3^Nicotine dependence, unspecified, uncomplicated
 ;;^UTILITY(U,$J,358.3,1508,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,1508,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,1509,0)
 ;;=F11.10^^3^44^18
 ;;^UTILITY(U,$J,358.3,1509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1509,1,3,0)
 ;;=3^Opioid abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,1509,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,1509,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,1510,0)
 ;;=F45.9^^3^44^28
 ;;^UTILITY(U,$J,358.3,1510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1510,1,3,0)
 ;;=3^Somatoform disorder, unspecified
 ;;^UTILITY(U,$J,358.3,1510,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,1510,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,1511,0)
 ;;=F43.21^^3^44^1
 ;;^UTILITY(U,$J,358.3,1511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1511,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,1511,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,1511,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,1512,0)
 ;;=F43.10^^3^44^24
 ;;^UTILITY(U,$J,358.3,1512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1512,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,1512,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,1512,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,1513,0)
 ;;=F43.12^^3^44^23
 ;;^UTILITY(U,$J,358.3,1513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1513,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,1513,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,1513,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,1514,0)
 ;;=F32.9^^3^44^14
 ;;^UTILITY(U,$J,358.3,1514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1514,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,1514,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,1514,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,1515,0)
 ;;=G47.62^^3^44^26
 ;;^UTILITY(U,$J,358.3,1515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1515,1,3,0)
 ;;=3^Sleep related leg cramps
 ;;^UTILITY(U,$J,358.3,1515,1,4,0)
 ;;=4^G47.62
 ;;^UTILITY(U,$J,358.3,1515,2)
 ;;=^332782
 ;;^UTILITY(U,$J,358.3,1516,0)
 ;;=G30.9^^3^44^5
 ;;^UTILITY(U,$J,358.3,1516,1,0)
 ;;=^358.31IA^4^2
