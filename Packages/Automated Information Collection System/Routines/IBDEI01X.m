IBDEI01X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,124,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,125,0)
 ;;=T74.31XD^^3^23^21
 ;;^UTILITY(U,$J,358.3,125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,125,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,125,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,125,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,126,0)
 ;;=T76.31XA^^3^23^22
 ;;^UTILITY(U,$J,358.3,126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,126,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Initial Encnter
 ;;^UTILITY(U,$J,358.3,126,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,126,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,127,0)
 ;;=T76.31XD^^3^23^23
 ;;^UTILITY(U,$J,358.3,127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,127,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,127,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,127,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,128,0)
 ;;=Z91.411^^3^23^6
 ;;^UTILITY(U,$J,358.3,128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,128,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,128,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,128,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,129,0)
 ;;=F06.4^^3^24^6
 ;;^UTILITY(U,$J,358.3,129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,129,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,129,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,129,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,130,0)
 ;;=F41.0^^3^24^14
 ;;^UTILITY(U,$J,358.3,130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,130,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,130,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,130,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,131,0)
 ;;=F41.1^^3^24^12
 ;;^UTILITY(U,$J,358.3,131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,131,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,131,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,131,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,132,0)
 ;;=F41.9^^3^24^5
 ;;^UTILITY(U,$J,358.3,132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,132,1,3,0)
 ;;=3^Anxiety Disorder NOS
 ;;^UTILITY(U,$J,358.3,132,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,132,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,133,0)
 ;;=F40.02^^3^24^2
 ;;^UTILITY(U,$J,358.3,133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,133,1,3,0)
 ;;=3^Agoraphobia
 ;;^UTILITY(U,$J,358.3,133,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,133,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,134,0)
 ;;=F40.10^^3^24^16
 ;;^UTILITY(U,$J,358.3,134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,134,1,3,0)
 ;;=3^Social Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,134,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,134,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,135,0)
 ;;=F40.218^^3^24^4
 ;;^UTILITY(U,$J,358.3,135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,135,1,3,0)
 ;;=3^Animal Type Phobias
 ;;^UTILITY(U,$J,358.3,135,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,135,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,136,0)
 ;;=F40.228^^3^24^13
 ;;^UTILITY(U,$J,358.3,136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,136,1,3,0)
 ;;=3^Natural Environment Type Phobia
 ;;^UTILITY(U,$J,358.3,136,1,4,0)
 ;;=4^F40.228
 ;;^UTILITY(U,$J,358.3,136,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,137,0)
 ;;=F40.230^^3^24^8
 ;;^UTILITY(U,$J,358.3,137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,137,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,137,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,137,2)
 ;;=^5003550
 ;;^UTILITY(U,$J,358.3,138,0)
 ;;=F40.231^^3^24^9
