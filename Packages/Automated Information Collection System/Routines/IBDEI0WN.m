IBDEI0WN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15321,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,15321,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,15322,0)
 ;;=T76.01XA^^58^658^3
 ;;^UTILITY(U,$J,358.3,15322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15322,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,15322,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,15322,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,15323,0)
 ;;=T76.01XD^^58^658^4
 ;;^UTILITY(U,$J,358.3,15323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15323,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,15323,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,15323,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,15324,0)
 ;;=Z91.412^^58^658^31
 ;;^UTILITY(U,$J,358.3,15324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15324,1,3,0)
 ;;=3^Personal Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,15324,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,15324,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,15325,0)
 ;;=T74.31XA^^58^658^9
 ;;^UTILITY(U,$J,358.3,15325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15325,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,15325,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,15325,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,15326,0)
 ;;=T74.31XD^^58^658^10
 ;;^UTILITY(U,$J,358.3,15326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15326,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,15326,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,15326,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,15327,0)
 ;;=T76.31XA^^58^658^11
 ;;^UTILITY(U,$J,358.3,15327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15327,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,15327,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,15327,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,15328,0)
 ;;=T76.31XD^^58^658^12
 ;;^UTILITY(U,$J,358.3,15328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15328,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,15328,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,15328,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,15329,0)
 ;;=Z91.411^^58^658^30
 ;;^UTILITY(U,$J,358.3,15329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15329,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,15329,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,15329,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,15330,0)
 ;;=Z69.021^^58^658^17
 ;;^UTILITY(U,$J,358.3,15330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15330,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,15330,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,15330,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,15331,0)
 ;;=Z69.021^^58^658^18
 ;;^UTILITY(U,$J,358.3,15331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15331,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,15331,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,15331,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,15332,0)
 ;;=Z69.021^^58^658^19
 ;;^UTILITY(U,$J,358.3,15332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15332,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,15332,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,15332,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,15333,0)
 ;;=Z69.021^^58^658^20
 ;;^UTILITY(U,$J,358.3,15333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15333,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
