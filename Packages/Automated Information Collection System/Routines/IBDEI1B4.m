IBDEI1B4 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20895,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,20895,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,20896,0)
 ;;=Z62.812^^95^1032^7
 ;;^UTILITY(U,$J,358.3,20896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20896,1,3,0)
 ;;=3^Personal Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,20896,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,20896,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,20897,0)
 ;;=Z62.810^^95^1032^8
 ;;^UTILITY(U,$J,358.3,20897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20897,1,3,0)
 ;;=3^Personal Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,20897,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,20897,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,20898,0)
 ;;=Z91.83^^95^1032^23
 ;;^UTILITY(U,$J,358.3,20898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20898,1,3,0)
 ;;=3^Wandering Associated w/ a Mental Disorder
 ;;^UTILITY(U,$J,358.3,20898,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,20898,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,20899,0)
 ;;=Z62.810^^95^1032^10
 ;;^UTILITY(U,$J,358.3,20899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20899,1,3,0)
 ;;=3^Personal Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,20899,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,20899,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,20900,0)
 ;;=Z91.412^^95^1032^15
 ;;^UTILITY(U,$J,358.3,20900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20900,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,20900,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,20900,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,20901,0)
 ;;=Z91.411^^95^1032^16
 ;;^UTILITY(U,$J,358.3,20901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20901,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,20901,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,20901,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,20902,0)
 ;;=Z91.410^^95^1032^17
 ;;^UTILITY(U,$J,358.3,20902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20902,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,20902,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,20902,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,20903,0)
 ;;=Z91.410^^95^1032^18
 ;;^UTILITY(U,$J,358.3,20903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20903,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,20903,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,20903,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,20904,0)
 ;;=Z75.3^^95^1032^21
 ;;^UTILITY(U,$J,358.3,20904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20904,1,3,0)
 ;;=3^Unavailability/Inaccessibility of Health Care Facilities
 ;;^UTILITY(U,$J,358.3,20904,1,4,0)
 ;;=4^Z75.3
 ;;^UTILITY(U,$J,358.3,20904,2)
 ;;=^5063292
 ;;^UTILITY(U,$J,358.3,20905,0)
 ;;=Z75.4^^95^1032^22
 ;;^UTILITY(U,$J,358.3,20905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20905,1,3,0)
 ;;=3^Unavailability/Inaccessibility of Other Helping Agencies
 ;;^UTILITY(U,$J,358.3,20905,1,4,0)
 ;;=4^Z75.4
 ;;^UTILITY(U,$J,358.3,20905,2)
 ;;=^5063293
 ;;^UTILITY(U,$J,358.3,20906,0)
 ;;=Z91.42^^95^1032^11
 ;;^UTILITY(U,$J,358.3,20906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20906,1,3,0)
 ;;=3^Personal Hx of Forced Labor/Sexual Exploitation
 ;;^UTILITY(U,$J,358.3,20906,1,4,0)
 ;;=4^Z91.42
 ;;^UTILITY(U,$J,358.3,20906,2)
 ;;=^5157633
 ;;^UTILITY(U,$J,358.3,20907,0)
 ;;=Z70.9^^95^1033^2
 ;;^UTILITY(U,$J,358.3,20907,1,0)
 ;;=^358.31IA^4^2
