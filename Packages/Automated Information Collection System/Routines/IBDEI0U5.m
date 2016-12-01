IBDEI0U5 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39656,1,3,0)
 ;;=3^Inter Hlth/Beh,Grp Ea 15min
 ;;^UTILITY(U,$J,358.3,39657,0)
 ;;=96154^^113^1665^5^^^^1
 ;;^UTILITY(U,$J,358.3,39657,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39657,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,39657,1,3,0)
 ;;=3^Inter Hlth/Beh,Fam w/Pt Ea 15m
 ;;^UTILITY(U,$J,358.3,39658,0)
 ;;=96155^^113^1665^4^^^^1
 ;;^UTILITY(U,$J,358.3,39658,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39658,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,39658,1,3,0)
 ;;=3^Int Hlth/Beh Fam w/o Pt Ea 15m
 ;;^UTILITY(U,$J,358.3,39659,0)
 ;;=99420^^113^1665^1^^^^1
 ;;^UTILITY(U,$J,358.3,39659,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39659,1,2,0)
 ;;=2^99420
 ;;^UTILITY(U,$J,358.3,39659,1,3,0)
 ;;=3^Admin/Int Hlth Risk Assess Tst
 ;;^UTILITY(U,$J,358.3,39660,0)
 ;;=S9445^^113^1666^3^^^^1
 ;;^UTILITY(U,$J,358.3,39660,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39660,1,2,0)
 ;;=2^S9445
 ;;^UTILITY(U,$J,358.3,39660,1,3,0)
 ;;=3^Pt Educ,Individual,NOS
 ;;^UTILITY(U,$J,358.3,39661,0)
 ;;=S9446^^113^1666^2^^^^1
 ;;^UTILITY(U,$J,358.3,39661,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39661,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,39661,1,3,0)
 ;;=3^Pt Educ,Group,NOS
 ;;^UTILITY(U,$J,358.3,39662,0)
 ;;=G0177^^113^1666^1^^^^1
 ;;^UTILITY(U,$J,358.3,39662,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39662,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,39662,1,3,0)
 ;;=3^Train & Ed Svcs R/T Care & Tx of Disabling MH Problem 45+ min
 ;;^UTILITY(U,$J,358.3,39663,0)
 ;;=S9454^^113^1666^4^^^^1
 ;;^UTILITY(U,$J,358.3,39663,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39663,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,39663,1,3,0)
 ;;=3^Stress Mgmt Class
 ;;^UTILITY(U,$J,358.3,39664,0)
 ;;=99366^^113^1667^1^^^^1
 ;;^UTILITY(U,$J,358.3,39664,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39664,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,39664,1,3,0)
 ;;=3^Non-Phy Team Conf w/ Pt &/or Fam,30 min+
 ;;^UTILITY(U,$J,358.3,39665,0)
 ;;=99368^^113^1667^2^^^^1
 ;;^UTILITY(U,$J,358.3,39665,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39665,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,39665,1,3,0)
 ;;=3^Non-Phy Team Conf w/o Pt Present,30 min+
 ;;^UTILITY(U,$J,358.3,39666,0)
 ;;=T74.11XA^^114^1668^5
 ;;^UTILITY(U,$J,358.3,39666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39666,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,39666,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,39666,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,39667,0)
 ;;=T74.11XD^^114^1668^6
 ;;^UTILITY(U,$J,358.3,39667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39667,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,39667,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,39667,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,39668,0)
 ;;=T76.11XA^^114^1668^7
 ;;^UTILITY(U,$J,358.3,39668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39668,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,39668,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,39668,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,39669,0)
 ;;=T76.11XD^^114^1668^8
 ;;^UTILITY(U,$J,358.3,39669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39669,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,39669,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,39669,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,39670,0)
 ;;=Z69.11^^114^1668^31
 ;;^UTILITY(U,$J,358.3,39670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39670,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,39670,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,39670,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,39671,0)
 ;;=Z91.410^^114^1668^35
 ;;^UTILITY(U,$J,358.3,39671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39671,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,39671,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,39671,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,39672,0)
 ;;=Z69.12^^114^1668^27
 ;;^UTILITY(U,$J,358.3,39672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39672,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,39672,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,39672,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,39673,0)
 ;;=T74.21XA^^114^1668^13
 ;;^UTILITY(U,$J,358.3,39673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39673,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,39673,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,39673,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,39674,0)
 ;;=T74.21XD^^114^1668^14
 ;;^UTILITY(U,$J,358.3,39674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39674,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,39674,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,39674,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,39675,0)
 ;;=T76.21XA^^114^1668^15
 ;;^UTILITY(U,$J,358.3,39675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39675,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,39675,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,39675,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,39676,0)
 ;;=T76.21XD^^114^1668^16
 ;;^UTILITY(U,$J,358.3,39676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39676,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,39676,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,39676,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,39677,0)
 ;;=Z69.81^^114^1668^30
 ;;^UTILITY(U,$J,358.3,39677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39677,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,39677,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,39677,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,39678,0)
 ;;=Z69.82^^114^1668^22
 ;;^UTILITY(U,$J,358.3,39678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39678,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,39678,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,39678,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,39679,0)
 ;;=T74.01XA^^114^1668^1
 ;;^UTILITY(U,$J,358.3,39679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39679,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,39679,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,39679,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,39680,0)
 ;;=T74.01XD^^114^1668^2
 ;;^UTILITY(U,$J,358.3,39680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39680,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,39680,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,39680,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,39681,0)
 ;;=T76.01XA^^114^1668^3
 ;;^UTILITY(U,$J,358.3,39681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39681,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,39681,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,39681,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,39682,0)
 ;;=T76.01XD^^114^1668^4
 ;;^UTILITY(U,$J,358.3,39682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39682,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,39682,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,39682,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,39683,0)
 ;;=Z91.412^^114^1668^40
 ;;^UTILITY(U,$J,358.3,39683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39683,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,39683,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,39683,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,39684,0)
 ;;=T74.31XA^^114^1668^9
 ;;^UTILITY(U,$J,358.3,39684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39684,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,39684,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,39684,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,39685,0)
 ;;=T74.31XD^^114^1668^10
 ;;^UTILITY(U,$J,358.3,39685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39685,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,39685,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,39685,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,39686,0)
 ;;=T76.31XA^^114^1668^11
 ;;^UTILITY(U,$J,358.3,39686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39686,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,39686,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,39686,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,39687,0)
 ;;=T76.31XD^^114^1668^12
 ;;^UTILITY(U,$J,358.3,39687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39687,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,39687,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,39687,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,39688,0)
 ;;=Z91.411^^114^1668^41
 ;;^UTILITY(U,$J,358.3,39688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39688,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,39688,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,39688,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,39689,0)
 ;;=Z69.021^^114^1668^18
 ;;^UTILITY(U,$J,358.3,39689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39689,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,39689,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,39689,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,39690,0)
 ;;=Z69.021^^114^1668^19
 ;;^UTILITY(U,$J,358.3,39690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39690,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,39690,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,39690,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,39691,0)
 ;;=Z69.021^^114^1668^20
 ;;^UTILITY(U,$J,358.3,39691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39691,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
