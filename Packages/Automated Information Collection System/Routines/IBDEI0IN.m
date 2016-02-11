IBDEI0IN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8377,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone
 ;;^UTILITY(U,$J,358.3,8377,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,8377,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,8378,0)
 ;;=C79.52^^55^538^120
 ;;^UTILITY(U,$J,358.3,8378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8378,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone marrow
 ;;^UTILITY(U,$J,358.3,8378,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,8378,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,8379,0)
 ;;=C79.71^^55^538^125
 ;;^UTILITY(U,$J,358.3,8379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8379,1,3,0)
 ;;=3^Secondary malignant neoplasm of right adrenal gland
 ;;^UTILITY(U,$J,358.3,8379,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,8379,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,8380,0)
 ;;=C79.72^^55^538^122
 ;;^UTILITY(U,$J,358.3,8380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8380,1,3,0)
 ;;=3^Secondary malignant neoplasm of left adrenal gland
 ;;^UTILITY(U,$J,358.3,8380,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,8380,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,8381,0)
 ;;=C83.50^^55^538^46
 ;;^UTILITY(U,$J,358.3,8381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8381,1,3,0)
 ;;=3^Lymphoblastic (diffuse) lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,8381,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,8381,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,8382,0)
 ;;=C83.59^^55^538^47
 ;;^UTILITY(U,$J,358.3,8382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8382,1,3,0)
 ;;=3^Lymphoblastic lymphoma, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,8382,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,8382,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,8383,0)
 ;;=C83.70^^55^538^18
 ;;^UTILITY(U,$J,358.3,8383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8383,1,3,0)
 ;;=3^Burkitt lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,8383,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,8383,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,8384,0)
 ;;=C83.79^^55^538^17
 ;;^UTILITY(U,$J,358.3,8384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8384,1,3,0)
 ;;=3^Burkitt lymphoma, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,8384,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,8384,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,8385,0)
 ;;=C81.90^^55^538^40
 ;;^UTILITY(U,$J,358.3,8385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8385,1,3,0)
 ;;=3^Hodgkin lymphoma, unspecified, unspecified site
 ;;^UTILITY(U,$J,358.3,8385,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,8385,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,8386,0)
 ;;=C81.99^^55^538^39
 ;;^UTILITY(U,$J,358.3,8386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8386,1,3,0)
 ;;=3^Hodgkin lymphoma, unsp, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,8386,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,8386,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,8387,0)
 ;;=C82.90^^55^538^33
 ;;^UTILITY(U,$J,358.3,8387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8387,1,3,0)
 ;;=3^Follicular lymphoma, unspecified, unspecified site
 ;;^UTILITY(U,$J,358.3,8387,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,8387,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,8388,0)
 ;;=C82.99^^55^538^32
 ;;^UTILITY(U,$J,358.3,8388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8388,1,3,0)
 ;;=3^Follicular lymphoma, unsp, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,8388,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,8388,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,8389,0)
 ;;=C91.40^^55^538^34
 ;;^UTILITY(U,$J,358.3,8389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8389,1,3,0)
 ;;=3^Hairy cell leukemia not having achieved remission
