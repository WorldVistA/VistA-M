IBDEI29L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38033,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Confirmed Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,38033,1,4,0)
 ;;=4^T74.31XD
 ;;^UTILITY(U,$J,358.3,38033,2)
 ;;=^5054159
 ;;^UTILITY(U,$J,358.3,38034,0)
 ;;=T76.31XA^^177^1914^22
 ;;^UTILITY(U,$J,358.3,38034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38034,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Initial Encnter
 ;;^UTILITY(U,$J,358.3,38034,1,4,0)
 ;;=4^T76.31XA
 ;;^UTILITY(U,$J,358.3,38034,2)
 ;;=^5054233
 ;;^UTILITY(U,$J,358.3,38035,0)
 ;;=T76.31XD^^177^1914^23
 ;;^UTILITY(U,$J,358.3,38035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38035,1,3,0)
 ;;=3^Spouse/Partner or Nonspouse/Nonpartner Abuse,Psychological Suspected Subsequent Encnter
 ;;^UTILITY(U,$J,358.3,38035,1,4,0)
 ;;=4^T76.31XD
 ;;^UTILITY(U,$J,358.3,38035,2)
 ;;=^5054234
 ;;^UTILITY(U,$J,358.3,38036,0)
 ;;=Z91.411^^177^1914^6
 ;;^UTILITY(U,$J,358.3,38036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38036,1,3,0)
 ;;=3^Personal Hx of Spouse or Parnter Psychological Abuse
 ;;^UTILITY(U,$J,358.3,38036,1,4,0)
 ;;=4^Z91.411
 ;;^UTILITY(U,$J,358.3,38036,2)
 ;;=^5063620
 ;;^UTILITY(U,$J,358.3,38037,0)
 ;;=F06.4^^177^1915^6
 ;;^UTILITY(U,$J,358.3,38037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38037,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,38037,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,38037,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,38038,0)
 ;;=F41.0^^177^1915^14
 ;;^UTILITY(U,$J,358.3,38038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38038,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,38038,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,38038,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,38039,0)
 ;;=F41.1^^177^1915^12
 ;;^UTILITY(U,$J,358.3,38039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38039,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,38039,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,38039,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,38040,0)
 ;;=F41.9^^177^1915^5
 ;;^UTILITY(U,$J,358.3,38040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38040,1,3,0)
 ;;=3^Anxiety Disorder NOS
 ;;^UTILITY(U,$J,358.3,38040,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,38040,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,38041,0)
 ;;=F40.02^^177^1915^2
 ;;^UTILITY(U,$J,358.3,38041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38041,1,3,0)
 ;;=3^Agoraphobia
 ;;^UTILITY(U,$J,358.3,38041,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,38041,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,38042,0)
 ;;=F40.10^^177^1915^16
 ;;^UTILITY(U,$J,358.3,38042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38042,1,3,0)
 ;;=3^Social Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,38042,1,4,0)
 ;;=4^F40.10
 ;;^UTILITY(U,$J,358.3,38042,2)
 ;;=^5003544
 ;;^UTILITY(U,$J,358.3,38043,0)
 ;;=F40.218^^177^1915^4
 ;;^UTILITY(U,$J,358.3,38043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38043,1,3,0)
 ;;=3^Animal Type Phobias
 ;;^UTILITY(U,$J,358.3,38043,1,4,0)
 ;;=4^F40.218
 ;;^UTILITY(U,$J,358.3,38043,2)
 ;;=^5003547
 ;;^UTILITY(U,$J,358.3,38044,0)
 ;;=F40.228^^177^1915^13
 ;;^UTILITY(U,$J,358.3,38044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38044,1,3,0)
 ;;=3^Natural Environment Type Phobia
 ;;^UTILITY(U,$J,358.3,38044,1,4,0)
 ;;=4^F40.228
 ;;^UTILITY(U,$J,358.3,38044,2)
 ;;=^5003549
 ;;^UTILITY(U,$J,358.3,38045,0)
 ;;=F40.230^^177^1915^8
 ;;^UTILITY(U,$J,358.3,38045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38045,1,3,0)
 ;;=3^Fear of Blood
 ;;^UTILITY(U,$J,358.3,38045,1,4,0)
 ;;=4^F40.230
 ;;^UTILITY(U,$J,358.3,38045,2)
 ;;=^5003550
