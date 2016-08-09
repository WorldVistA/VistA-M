IBDEI0CX ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12928,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,12929,0)
 ;;=T76.31XA^^58^672^11
 ;;^UTILITY(U,$J,358.3,12929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12929,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,12929,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,12929,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,12930,0)
 ;;=T76.31XD^^58^672^12
 ;;^UTILITY(U,$J,358.3,12930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12930,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,12930,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,12930,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,12931,0)
 ;;=Z91.411^^58^672^41
 ;;^UTILITY(U,$J,358.3,12931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12931,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,12931,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,12931,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,12932,0)
 ;;=Z69.021^^58^672^18
 ;;^UTILITY(U,$J,358.3,12932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12932,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,12932,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,12932,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,12933,0)
 ;;=Z69.021^^58^672^19
 ;;^UTILITY(U,$J,358.3,12933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12933,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,12933,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,12933,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,12934,0)
 ;;=Z69.021^^58^672^20
 ;;^UTILITY(U,$J,358.3,12934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12934,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,12934,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,12934,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,12935,0)
 ;;=Z69.021^^58^672^21
 ;;^UTILITY(U,$J,358.3,12935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12935,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,12935,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,12935,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,12936,0)
 ;;=Z69.011^^58^672^23
 ;;^UTILITY(U,$J,358.3,12936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12936,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,12936,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,12936,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,12937,0)
 ;;=Z69.011^^58^672^24
 ;;^UTILITY(U,$J,358.3,12937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12937,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,12937,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,12937,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,12938,0)
 ;;=Z69.011^^58^672^25
 ;;^UTILITY(U,$J,358.3,12938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12938,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,12938,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,12938,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,12939,0)
 ;;=Z69.011^^58^672^26
 ;;^UTILITY(U,$J,358.3,12939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12939,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,12939,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,12939,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,12940,0)
 ;;=Z69.12^^58^672^17
 ;;^UTILITY(U,$J,358.3,12940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12940,1,3,0)
 ;;=3^MH SVC for Perpetrator of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,12940,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,12940,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,12941,0)
 ;;=Z69.12^^58^672^28
 ;;^UTILITY(U,$J,358.3,12941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12941,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,12941,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,12941,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,12942,0)
 ;;=Z69.12^^58^672^29
 ;;^UTILITY(U,$J,358.3,12942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12942,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,12942,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,12942,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,12943,0)
 ;;=Z69.11^^58^672^32
 ;;^UTILITY(U,$J,358.3,12943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12943,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,12943,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,12943,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,12944,0)
 ;;=Z69.11^^58^672^33
 ;;^UTILITY(U,$J,358.3,12944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12944,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,12944,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,12944,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,12945,0)
 ;;=Z69.11^^58^672^34
 ;;^UTILITY(U,$J,358.3,12945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12945,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,12945,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,12945,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,12946,0)
 ;;=Z62.812^^58^672^36
 ;;^UTILITY(U,$J,358.3,12946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12946,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,12946,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,12946,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,12947,0)
 ;;=Z62.810^^58^672^37
 ;;^UTILITY(U,$J,358.3,12947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12947,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,12947,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,12947,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,12948,0)
 ;;=Z62.810^^58^672^39
 ;;^UTILITY(U,$J,358.3,12948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12948,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,12948,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,12948,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,12949,0)
 ;;=Z62.811^^58^672^38
 ;;^UTILITY(U,$J,358.3,12949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12949,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,12949,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,12949,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,12950,0)
 ;;=Z91.410^^58^672^42
 ;;^UTILITY(U,$J,358.3,12950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12950,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,12950,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,12950,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,12951,0)
 ;;=F06.4^^58^673^3
 ;;^UTILITY(U,$J,358.3,12951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12951,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,12951,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,12951,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,12952,0)
 ;;=F41.0^^58^673^12
 ;;^UTILITY(U,$J,358.3,12952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12952,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,12952,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,12952,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,12953,0)
 ;;=F41.1^^58^673^10
 ;;^UTILITY(U,$J,358.3,12953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12953,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,12953,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,12953,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,12954,0)
 ;;=F40.10^^58^673^17
 ;;^UTILITY(U,$J,358.3,12954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12954,1,3,0)
 ;;=3^Social Anxiety Disorder (Social Phobia)
 ;;^UTILITY(U,$J,358.3,12954,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,12954,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,12955,0)
 ;;=F40.218^^58^673^2
