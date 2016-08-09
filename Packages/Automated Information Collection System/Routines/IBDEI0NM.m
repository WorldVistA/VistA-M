IBDEI0NM ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23833,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,23833,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,23834,0)
 ;;=T76.01XD^^92^1101^4
 ;;^UTILITY(U,$J,358.3,23834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23834,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,23834,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,23834,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,23835,0)
 ;;=Z91.412^^92^1101^40
 ;;^UTILITY(U,$J,358.3,23835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23835,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,23835,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,23835,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,23836,0)
 ;;=T74.31XA^^92^1101^9
 ;;^UTILITY(U,$J,358.3,23836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23836,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,23836,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,23836,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,23837,0)
 ;;=T74.31XD^^92^1101^10
 ;;^UTILITY(U,$J,358.3,23837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23837,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,23837,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,23837,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,23838,0)
 ;;=T76.31XA^^92^1101^11
 ;;^UTILITY(U,$J,358.3,23838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23838,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,23838,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,23838,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,23839,0)
 ;;=T76.31XD^^92^1101^12
 ;;^UTILITY(U,$J,358.3,23839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23839,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,23839,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,23839,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,23840,0)
 ;;=Z91.411^^92^1101^41
 ;;^UTILITY(U,$J,358.3,23840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23840,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,23840,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,23840,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,23841,0)
 ;;=Z69.021^^92^1101^18
 ;;^UTILITY(U,$J,358.3,23841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23841,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,23841,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,23841,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,23842,0)
 ;;=Z69.021^^92^1101^19
 ;;^UTILITY(U,$J,358.3,23842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23842,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,23842,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,23842,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,23843,0)
 ;;=Z69.021^^92^1101^20
 ;;^UTILITY(U,$J,358.3,23843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23843,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,23843,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,23843,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,23844,0)
 ;;=Z69.021^^92^1101^21
 ;;^UTILITY(U,$J,358.3,23844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23844,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,23844,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,23844,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,23845,0)
 ;;=Z69.011^^92^1101^23
 ;;^UTILITY(U,$J,358.3,23845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23845,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,23845,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,23845,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,23846,0)
 ;;=Z69.011^^92^1101^24
 ;;^UTILITY(U,$J,358.3,23846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23846,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,23846,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,23846,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,23847,0)
 ;;=Z69.011^^92^1101^25
 ;;^UTILITY(U,$J,358.3,23847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23847,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,23847,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,23847,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,23848,0)
 ;;=Z69.011^^92^1101^26
 ;;^UTILITY(U,$J,358.3,23848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23848,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,23848,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,23848,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,23849,0)
 ;;=Z69.12^^92^1101^17
 ;;^UTILITY(U,$J,358.3,23849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23849,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,23849,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,23849,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,23850,0)
 ;;=Z69.12^^92^1101^28
 ;;^UTILITY(U,$J,358.3,23850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23850,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,23850,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,23850,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,23851,0)
 ;;=Z69.12^^92^1101^29
 ;;^UTILITY(U,$J,358.3,23851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23851,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,23851,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,23851,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,23852,0)
 ;;=Z69.11^^92^1101^32
 ;;^UTILITY(U,$J,358.3,23852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23852,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,23852,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,23852,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,23853,0)
 ;;=Z69.11^^92^1101^33
 ;;^UTILITY(U,$J,358.3,23853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23853,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,23853,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,23853,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,23854,0)
 ;;=Z69.11^^92^1101^34
 ;;^UTILITY(U,$J,358.3,23854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23854,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,23854,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,23854,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,23855,0)
 ;;=Z62.812^^92^1101^36
 ;;^UTILITY(U,$J,358.3,23855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23855,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,23855,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,23855,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,23856,0)
 ;;=Z62.810^^92^1101^37
 ;;^UTILITY(U,$J,358.3,23856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23856,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,23856,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,23856,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,23857,0)
 ;;=Z62.810^^92^1101^39
 ;;^UTILITY(U,$J,358.3,23857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23857,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,23857,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,23857,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,23858,0)
 ;;=Z62.811^^92^1101^38
 ;;^UTILITY(U,$J,358.3,23858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23858,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,23858,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,23858,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,23859,0)
 ;;=Z91.410^^92^1101^42
 ;;^UTILITY(U,$J,358.3,23859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23859,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
