IBDEI1SD ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30344,1,4,0)
 ;;=4^C7A.010
 ;;^UTILITY(U,$J,358.3,30344,2)
 ;;=^5001359
 ;;^UTILITY(U,$J,358.3,30345,0)
 ;;=C7A.011^^118^1505^44
 ;;^UTILITY(U,$J,358.3,30345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30345,1,3,0)
 ;;=3^Malignant carcinoid tumor of the jejunum
 ;;^UTILITY(U,$J,358.3,30345,1,4,0)
 ;;=4^C7A.011
 ;;^UTILITY(U,$J,358.3,30345,2)
 ;;=^5001360
 ;;^UTILITY(U,$J,358.3,30346,0)
 ;;=C7A.012^^118^1505^43
 ;;^UTILITY(U,$J,358.3,30346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30346,1,3,0)
 ;;=3^Malignant carcinoid tumor of the ileum
 ;;^UTILITY(U,$J,358.3,30346,1,4,0)
 ;;=4^C7A.012
 ;;^UTILITY(U,$J,358.3,30346,2)
 ;;=^5001361
 ;;^UTILITY(U,$J,358.3,30347,0)
 ;;=C93.30^^118^1505^38
 ;;^UTILITY(U,$J,358.3,30347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30347,1,3,0)
 ;;=3^Juvenile myelomonocytic leukemia,no remission
 ;;^UTILITY(U,$J,358.3,30347,1,4,0)
 ;;=4^C93.30
 ;;^UTILITY(U,$J,358.3,30347,2)
 ;;=^5001825
 ;;^UTILITY(U,$J,358.3,30348,0)
 ;;=C93.31^^118^1505^37
 ;;^UTILITY(U,$J,358.3,30348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30348,1,3,0)
 ;;=3^Juvenile myelomonocytic leukemia,in remission
 ;;^UTILITY(U,$J,358.3,30348,1,4,0)
 ;;=4^C93.31
 ;;^UTILITY(U,$J,358.3,30348,2)
 ;;=^5001826
 ;;^UTILITY(U,$J,358.3,30349,0)
 ;;=C93.32^^118^1505^36
 ;;^UTILITY(U,$J,358.3,30349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30349,1,3,0)
 ;;=3^Juvenile myelomonocytic leukemia,in relapse
 ;;^UTILITY(U,$J,358.3,30349,1,4,0)
 ;;=4^C93.32
 ;;^UTILITY(U,$J,358.3,30349,2)
 ;;=^5001827
 ;;^UTILITY(U,$J,358.3,30350,0)
 ;;=D48.0^^118^1506^5
 ;;^UTILITY(U,$J,358.3,30350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30350,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of bone/artic cartl
 ;;^UTILITY(U,$J,358.3,30350,1,4,0)
 ;;=4^D48.0
 ;;^UTILITY(U,$J,358.3,30350,2)
 ;;=^81953
 ;;^UTILITY(U,$J,358.3,30351,0)
 ;;=D48.1^^118^1506^6
 ;;^UTILITY(U,$J,358.3,30351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30351,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of connctv/soft tiss
 ;;^UTILITY(U,$J,358.3,30351,1,4,0)
 ;;=4^D48.1
 ;;^UTILITY(U,$J,358.3,30351,2)
 ;;=^267776
 ;;^UTILITY(U,$J,358.3,30352,0)
 ;;=D48.5^^118^1506^10
 ;;^UTILITY(U,$J,358.3,30352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30352,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of skin
 ;;^UTILITY(U,$J,358.3,30352,1,4,0)
 ;;=4^D48.5
 ;;^UTILITY(U,$J,358.3,30352,2)
 ;;=^267777
 ;;^UTILITY(U,$J,358.3,30353,0)
 ;;=D48.61^^118^1506^9
 ;;^UTILITY(U,$J,358.3,30353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30353,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of right breast
 ;;^UTILITY(U,$J,358.3,30353,1,4,0)
 ;;=4^D48.61
 ;;^UTILITY(U,$J,358.3,30353,2)
 ;;=^5002267
 ;;^UTILITY(U,$J,358.3,30354,0)
 ;;=D48.62^^118^1506^7
 ;;^UTILITY(U,$J,358.3,30354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30354,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of left breast
 ;;^UTILITY(U,$J,358.3,30354,1,4,0)
 ;;=4^D48.62
 ;;^UTILITY(U,$J,358.3,30354,2)
 ;;=^5002268
 ;;^UTILITY(U,$J,358.3,30355,0)
 ;;=D47.0^^118^1506^2
 ;;^UTILITY(U,$J,358.3,30355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30355,1,3,0)
 ;;=3^Histiocytic and mast cell tumors of uncertain behavior
 ;;^UTILITY(U,$J,358.3,30355,1,4,0)
 ;;=4^D47.0
 ;;^UTILITY(U,$J,358.3,30355,2)
 ;;=^5002255
 ;;^UTILITY(U,$J,358.3,30356,0)
 ;;=D46.0^^118^1506^18
 ;;^UTILITY(U,$J,358.3,30356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30356,1,3,0)
 ;;=3^Refractory anemia without ring sideroblasts, so stated
 ;;^UTILITY(U,$J,358.3,30356,1,4,0)
 ;;=4^D46.0
 ;;^UTILITY(U,$J,358.3,30356,2)
 ;;=^5002245
