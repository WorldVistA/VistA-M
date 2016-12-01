IBDEI0L0 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26580,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26580,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,26580,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,26581,0)
 ;;=T76.01XA^^71^1113^3
 ;;^UTILITY(U,$J,358.3,26581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26581,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26581,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,26581,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,26582,0)
 ;;=T76.01XD^^71^1113^4
 ;;^UTILITY(U,$J,358.3,26582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26582,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,26582,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,26582,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,26583,0)
 ;;=Z91.412^^71^1113^40
 ;;^UTILITY(U,$J,358.3,26583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26583,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,26583,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,26583,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,26584,0)
 ;;=T74.31XA^^71^1113^9
 ;;^UTILITY(U,$J,358.3,26584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26584,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26584,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,26584,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,26585,0)
 ;;=T74.31XD^^71^1113^10
 ;;^UTILITY(U,$J,358.3,26585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26585,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26585,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,26585,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,26586,0)
 ;;=T76.31XA^^71^1113^11
 ;;^UTILITY(U,$J,358.3,26586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26586,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,26586,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,26586,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,26587,0)
 ;;=T76.31XD^^71^1113^12
 ;;^UTILITY(U,$J,358.3,26587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26587,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26587,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,26587,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,26588,0)
 ;;=Z91.411^^71^1113^41
 ;;^UTILITY(U,$J,358.3,26588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26588,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,26588,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,26588,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,26589,0)
 ;;=Z69.021^^71^1113^18
 ;;^UTILITY(U,$J,358.3,26589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26589,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,26589,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,26589,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,26590,0)
 ;;=Z69.021^^71^1113^19
 ;;^UTILITY(U,$J,358.3,26590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26590,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,26590,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,26590,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,26591,0)
 ;;=Z69.021^^71^1113^20
 ;;^UTILITY(U,$J,358.3,26591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26591,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,26591,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,26591,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,26592,0)
 ;;=Z69.021^^71^1113^21
 ;;^UTILITY(U,$J,358.3,26592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26592,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,26592,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,26592,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,26593,0)
 ;;=Z69.011^^71^1113^23
 ;;^UTILITY(U,$J,358.3,26593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26593,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,26593,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,26593,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,26594,0)
 ;;=Z69.011^^71^1113^24
 ;;^UTILITY(U,$J,358.3,26594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26594,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,26594,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,26594,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,26595,0)
 ;;=Z69.011^^71^1113^25
 ;;^UTILITY(U,$J,358.3,26595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26595,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,26595,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,26595,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,26596,0)
 ;;=Z69.011^^71^1113^26
 ;;^UTILITY(U,$J,358.3,26596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26596,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,26596,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,26596,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,26597,0)
 ;;=Z69.12^^71^1113^17
 ;;^UTILITY(U,$J,358.3,26597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26597,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,26597,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,26597,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,26598,0)
 ;;=Z69.12^^71^1113^28
 ;;^UTILITY(U,$J,358.3,26598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26598,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,26598,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,26598,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,26599,0)
 ;;=Z69.12^^71^1113^29
 ;;^UTILITY(U,$J,358.3,26599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26599,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,26599,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,26599,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,26600,0)
 ;;=Z69.11^^71^1113^32
 ;;^UTILITY(U,$J,358.3,26600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26600,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,26600,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,26600,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,26601,0)
 ;;=Z69.11^^71^1113^33
 ;;^UTILITY(U,$J,358.3,26601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26601,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,26601,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,26601,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,26602,0)
 ;;=Z69.11^^71^1113^34
 ;;^UTILITY(U,$J,358.3,26602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26602,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,26602,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,26602,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,26603,0)
 ;;=Z62.812^^71^1113^36
 ;;^UTILITY(U,$J,358.3,26603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26603,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,26603,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,26603,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,26604,0)
 ;;=Z62.810^^71^1113^37
 ;;^UTILITY(U,$J,358.3,26604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26604,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,26604,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,26604,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,26605,0)
 ;;=Z62.810^^71^1113^39
 ;;^UTILITY(U,$J,358.3,26605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26605,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,26605,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,26605,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,26606,0)
 ;;=Z62.811^^71^1113^38
 ;;^UTILITY(U,$J,358.3,26606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26606,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,26606,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,26606,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,26607,0)
 ;;=Z91.410^^71^1113^42
 ;;^UTILITY(U,$J,358.3,26607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26607,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,26607,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,26607,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,26608,0)
 ;;=F06.4^^71^1114^3
 ;;^UTILITY(U,$J,358.3,26608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26608,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26608,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,26608,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,26609,0)
 ;;=F41.0^^71^1114^12
 ;;^UTILITY(U,$J,358.3,26609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26609,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,26609,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,26609,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,26610,0)
 ;;=F41.1^^71^1114^10
 ;;^UTILITY(U,$J,358.3,26610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26610,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,26610,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,26610,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,26611,0)
 ;;=F40.10^^71^1114^17
 ;;^UTILITY(U,$J,358.3,26611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26611,1,3,0)
 ;;=3^Social Anxiety Disorder (Social Phobia)
 ;;^UTILITY(U,$J,358.3,26611,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,26611,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,26612,0)
 ;;=F40.218^^71^1114^2
 ;;^UTILITY(U,$J,358.3,26612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26612,1,3,0)
 ;;=3^Animal Phobia
 ;;^UTILITY(U,$J,358.3,26612,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,26612,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,26613,0)
 ;;=F40.228^^71^1114^11
 ;;^UTILITY(U,$J,358.3,26613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26613,1,3,0)
 ;;=3^Natural Environment Phobia
 ;;^UTILITY(U,$J,358.3,26613,1,4,0)
 ;;=4^F40.228
