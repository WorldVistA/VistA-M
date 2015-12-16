IBDEI02G ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,596,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,597,0)
 ;;=C7A.010^^2^24^39
 ;;^UTILITY(U,$J,358.3,597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,597,1,3,0)
 ;;=3^Malignant carcinoid tumor of the duodenum
 ;;^UTILITY(U,$J,358.3,597,1,4,0)
 ;;=4^C7A.010
 ;;^UTILITY(U,$J,358.3,597,2)
 ;;=^5001359
 ;;^UTILITY(U,$J,358.3,598,0)
 ;;=C7A.011^^2^24^41
 ;;^UTILITY(U,$J,358.3,598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,598,1,3,0)
 ;;=3^Malignant carcinoid tumor of the jejunum
 ;;^UTILITY(U,$J,358.3,598,1,4,0)
 ;;=4^C7A.011
 ;;^UTILITY(U,$J,358.3,598,2)
 ;;=^5001360
 ;;^UTILITY(U,$J,358.3,599,0)
 ;;=C7A.012^^2^24^40
 ;;^UTILITY(U,$J,358.3,599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,599,1,3,0)
 ;;=3^Malignant carcinoid tumor of the ileum
 ;;^UTILITY(U,$J,358.3,599,1,4,0)
 ;;=4^C7A.012
 ;;^UTILITY(U,$J,358.3,599,2)
 ;;=^5001361
 ;;^UTILITY(U,$J,358.3,600,0)
 ;;=D48.0^^2^25^5
 ;;^UTILITY(U,$J,358.3,600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,600,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of bone/artic cartl
 ;;^UTILITY(U,$J,358.3,600,1,4,0)
 ;;=4^D48.0
 ;;^UTILITY(U,$J,358.3,600,2)
 ;;=^81953
 ;;^UTILITY(U,$J,358.3,601,0)
 ;;=D48.1^^2^25^6
 ;;^UTILITY(U,$J,358.3,601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,601,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of connctv/soft tiss
 ;;^UTILITY(U,$J,358.3,601,1,4,0)
 ;;=4^D48.1
 ;;^UTILITY(U,$J,358.3,601,2)
 ;;=^267776
 ;;^UTILITY(U,$J,358.3,602,0)
 ;;=D48.5^^2^25^10
 ;;^UTILITY(U,$J,358.3,602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,602,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of skin
 ;;^UTILITY(U,$J,358.3,602,1,4,0)
 ;;=4^D48.5
 ;;^UTILITY(U,$J,358.3,602,2)
 ;;=^267777
 ;;^UTILITY(U,$J,358.3,603,0)
 ;;=D48.61^^2^25^9
 ;;^UTILITY(U,$J,358.3,603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,603,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of right breast
 ;;^UTILITY(U,$J,358.3,603,1,4,0)
 ;;=4^D48.61
 ;;^UTILITY(U,$J,358.3,603,2)
 ;;=^5002267
 ;;^UTILITY(U,$J,358.3,604,0)
 ;;=D48.62^^2^25^7
 ;;^UTILITY(U,$J,358.3,604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,604,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of left breast
 ;;^UTILITY(U,$J,358.3,604,1,4,0)
 ;;=4^D48.62
 ;;^UTILITY(U,$J,358.3,604,2)
 ;;=^5002268
 ;;^UTILITY(U,$J,358.3,605,0)
 ;;=D47.0^^2^25^2
 ;;^UTILITY(U,$J,358.3,605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,605,1,3,0)
 ;;=3^Histiocytic and mast cell tumors of uncertain behavior
 ;;^UTILITY(U,$J,358.3,605,1,4,0)
 ;;=4^D47.0
 ;;^UTILITY(U,$J,358.3,605,2)
 ;;=^5002255
 ;;^UTILITY(U,$J,358.3,606,0)
 ;;=D46.0^^2^25^18
 ;;^UTILITY(U,$J,358.3,606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,606,1,3,0)
 ;;=3^Refractory anemia without ring sideroblasts, so stated
 ;;^UTILITY(U,$J,358.3,606,1,4,0)
 ;;=4^D46.0
 ;;^UTILITY(U,$J,358.3,606,2)
 ;;=^5002245
 ;;^UTILITY(U,$J,358.3,607,0)
 ;;=D46.1^^2^25^17
 ;;^UTILITY(U,$J,358.3,607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,607,1,3,0)
 ;;=3^Refractory anemia with ring sideroblasts
 ;;^UTILITY(U,$J,358.3,607,1,4,0)
 ;;=4^D46.1
 ;;^UTILITY(U,$J,358.3,607,2)
 ;;=^5002246
 ;;^UTILITY(U,$J,358.3,608,0)
 ;;=D46.20^^2^25^14
 ;;^UTILITY(U,$J,358.3,608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,608,1,3,0)
 ;;=3^Refractory anemia with excess of blasts, unspecified
 ;;^UTILITY(U,$J,358.3,608,1,4,0)
 ;;=4^D46.20
 ;;^UTILITY(U,$J,358.3,608,2)
 ;;=^5002247
 ;;^UTILITY(U,$J,358.3,609,0)
 ;;=D46.21^^2^25^15
 ;;^UTILITY(U,$J,358.3,609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,609,1,3,0)
 ;;=3^Refractory anemia with excess of blasts 1
 ;;^UTILITY(U,$J,358.3,609,1,4,0)
 ;;=4^D46.21
