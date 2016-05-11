IBDEI1IW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25852,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,25852,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,25852,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,25853,0)
 ;;=T76.31XD^^98^1209^12
 ;;^UTILITY(U,$J,358.3,25853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25853,1,3,0)
 ;;=3^Adult Psychological Abuse,Suspected,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,25853,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,25853,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,25854,0)
 ;;=Z91.411^^98^1209^30
 ;;^UTILITY(U,$J,358.3,25854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25854,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25854,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,25854,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,25855,0)
 ;;=Z69.021^^98^1209^17
 ;;^UTILITY(U,$J,358.3,25855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25855,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Abuse
 ;;^UTILITY(U,$J,358.3,25855,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25855,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25856,0)
 ;;=Z69.021^^98^1209^18
 ;;^UTILITY(U,$J,358.3,25856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25856,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Neglect
 ;;^UTILITY(U,$J,358.3,25856,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25856,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25857,0)
 ;;=Z69.021^^98^1209^19
 ;;^UTILITY(U,$J,358.3,25857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25857,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25857,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25857,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25858,0)
 ;;=Z69.021^^98^1209^20
 ;;^UTILITY(U,$J,358.3,25858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25858,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonparental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,25858,1,4,0)
 ;;=4^Z69.021
 ;;^UTILITY(U,$J,358.3,25858,2)
 ;;=^5063231
 ;;^UTILITY(U,$J,358.3,25859,0)
 ;;=Z69.011^^98^1209^22
 ;;^UTILITY(U,$J,358.3,25859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25859,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Abuse
 ;;^UTILITY(U,$J,358.3,25859,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25859,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25860,0)
 ;;=Z69.011^^98^1209^23
 ;;^UTILITY(U,$J,358.3,25860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25860,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Neglect
 ;;^UTILITY(U,$J,358.3,25860,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25860,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25861,0)
 ;;=Z69.011^^98^1209^24
 ;;^UTILITY(U,$J,358.3,25861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25861,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Psychological Abuse
 ;;^UTILITY(U,$J,358.3,25861,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25861,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25862,0)
 ;;=Z69.011^^98^1209^25
 ;;^UTILITY(U,$J,358.3,25862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25862,1,3,0)
 ;;=3^MH Svc for Perpetrator of Parental Child Sexual Abuse
 ;;^UTILITY(U,$J,358.3,25862,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,25862,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,25863,0)
 ;;=F06.4^^98^1210^6
 ;;^UTILITY(U,$J,358.3,25863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25863,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,25863,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,25863,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,25864,0)
 ;;=F41.0^^98^1210^15
 ;;^UTILITY(U,$J,358.3,25864,1,0)
 ;;=^358.31IA^4^2
