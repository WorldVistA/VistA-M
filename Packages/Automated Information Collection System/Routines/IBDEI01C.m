IBDEI01C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,126,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,126,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,126,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,127,0)
 ;;=T76.31XD^^3^23^12
 ;;^UTILITY(U,$J,358.3,127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,127,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,127,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,127,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,128,0)
 ;;=Z91.411^^3^23^30
 ;;^UTILITY(U,$J,358.3,128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,128,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,128,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,128,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,129,0)
 ;;=Z69.021^^3^23^17
 ;;^UTILITY(U,$J,358.3,129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,129,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,129,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,129,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,130,0)
 ;;=Z69.021^^3^23^18
 ;;^UTILITY(U,$J,358.3,130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,130,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,130,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,130,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,131,0)
 ;;=Z69.021^^3^23^19
 ;;^UTILITY(U,$J,358.3,131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,131,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,131,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,131,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,132,0)
 ;;=Z69.021^^3^23^20
 ;;^UTILITY(U,$J,358.3,132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,132,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,132,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,132,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,133,0)
 ;;=Z69.011^^3^23^22
 ;;^UTILITY(U,$J,358.3,133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,133,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,133,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,133,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,134,0)
 ;;=Z69.011^^3^23^23
 ;;^UTILITY(U,$J,358.3,134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,134,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,134,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,134,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,135,0)
 ;;=Z69.011^^3^23^24
 ;;^UTILITY(U,$J,358.3,135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,135,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,135,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,135,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,136,0)
 ;;=Z69.011^^3^23^25
 ;;^UTILITY(U,$J,358.3,136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,136,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,136,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,136,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,137,0)
 ;;=F06.4^^3^24^6
 ;;^UTILITY(U,$J,358.3,137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,137,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,137,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,137,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,138,0)
 ;;=F41.0^^3^24^15
 ;;^UTILITY(U,$J,358.3,138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,138,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,138,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,138,2)
 ;;=^5003564
