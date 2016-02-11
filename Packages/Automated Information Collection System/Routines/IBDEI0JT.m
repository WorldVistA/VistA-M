IBDEI0JT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8930,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,8930,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,8931,0)
 ;;=E08.9^^55^555^31
 ;;^UTILITY(U,$J,358.3,8931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8931,1,3,0)
 ;;=3^Diabetes due to underlying condition w/o complications
 ;;^UTILITY(U,$J,358.3,8931,1,4,0)
 ;;=4^E08.9
 ;;^UTILITY(U,$J,358.3,8931,2)
 ;;=^5002544
 ;;^UTILITY(U,$J,358.3,8932,0)
 ;;=E09.9^^55^555^61
 ;;^UTILITY(U,$J,358.3,8932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8932,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus w/o complications
 ;;^UTILITY(U,$J,358.3,8932,1,4,0)
 ;;=4^E09.9
 ;;^UTILITY(U,$J,358.3,8932,2)
 ;;=^5002586
 ;;^UTILITY(U,$J,358.3,8933,0)
 ;;=E08.65^^55^555^1
 ;;^UTILITY(U,$J,358.3,8933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8933,1,3,0)
 ;;=3^Diabetes due to underlying condition w hyperglycemia
 ;;^UTILITY(U,$J,358.3,8933,1,4,0)
 ;;=4^E08.65
 ;;^UTILITY(U,$J,358.3,8933,2)
 ;;=^5002541
 ;;^UTILITY(U,$J,358.3,8934,0)
 ;;=E09.65^^55^555^58
 ;;^UTILITY(U,$J,358.3,8934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8934,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus w hyperglycemia
 ;;^UTILITY(U,$J,358.3,8934,1,4,0)
 ;;=4^E09.65
 ;;^UTILITY(U,$J,358.3,8934,2)
 ;;=^5002583
 ;;^UTILITY(U,$J,358.3,8935,0)
 ;;=E08.10^^55^555^2
 ;;^UTILITY(U,$J,358.3,8935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8935,1,3,0)
 ;;=3^Diabetes due to underlying condition w ketoacidosis w/o coma
 ;;^UTILITY(U,$J,358.3,8935,1,4,0)
 ;;=4^E08.10
 ;;^UTILITY(U,$J,358.3,8935,2)
 ;;=^5002505
 ;;^UTILITY(U,$J,358.3,8936,0)
 ;;=E09.10^^55^555^41
 ;;^UTILITY(U,$J,358.3,8936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8936,1,3,0)
 ;;=3^Drug/chem diabetes w ketoacidosis w/o coma
 ;;^UTILITY(U,$J,358.3,8936,1,4,0)
 ;;=4^E09.10
 ;;^UTILITY(U,$J,358.3,8936,2)
 ;;=^5002547
 ;;^UTILITY(U,$J,358.3,8937,0)
 ;;=E08.01^^55^555^3
 ;;^UTILITY(U,$J,358.3,8937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8937,1,3,0)
 ;;=3^Diabetes due to underlying condition w hyprosm w coma
 ;;^UTILITY(U,$J,358.3,8937,1,4,0)
 ;;=4^E08.01
 ;;^UTILITY(U,$J,358.3,8937,2)
 ;;=^5002504
 ;;^UTILITY(U,$J,358.3,8938,0)
 ;;=E09.01^^55^555^37
 ;;^UTILITY(U,$J,358.3,8938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8938,1,3,0)
 ;;=3^Drug/chem diabetes w hyperosmolarity w coma
 ;;^UTILITY(U,$J,358.3,8938,1,4,0)
 ;;=4^E09.01
 ;;^UTILITY(U,$J,358.3,8938,2)
 ;;=^5002546
 ;;^UTILITY(U,$J,358.3,8939,0)
 ;;=E08.11^^55^555^4
 ;;^UTILITY(U,$J,358.3,8939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8939,1,3,0)
 ;;=3^Diabetes due to underlying condition w ketoacidosis w coma
 ;;^UTILITY(U,$J,358.3,8939,1,4,0)
 ;;=4^E08.11
 ;;^UTILITY(U,$J,358.3,8939,2)
 ;;=^5002506
 ;;^UTILITY(U,$J,358.3,8940,0)
 ;;=E08.641^^55^555^5
 ;;^UTILITY(U,$J,358.3,8940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8940,1,3,0)
 ;;=3^Diabetes due to underlying condition w hypoglycemia w coma
 ;;^UTILITY(U,$J,358.3,8940,1,4,0)
 ;;=4^E08.641
 ;;^UTILITY(U,$J,358.3,8940,2)
 ;;=^5002539
 ;;^UTILITY(U,$J,358.3,8941,0)
 ;;=E09.11^^55^555^40
 ;;^UTILITY(U,$J,358.3,8941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8941,1,3,0)
 ;;=3^Drug/chem diabetes w ketoacidosis w coma
 ;;^UTILITY(U,$J,358.3,8941,1,4,0)
 ;;=4^E09.11
 ;;^UTILITY(U,$J,358.3,8941,2)
 ;;=^5002548
 ;;^UTILITY(U,$J,358.3,8942,0)
 ;;=E09.641^^55^555^38
 ;;^UTILITY(U,$J,358.3,8942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8942,1,3,0)
 ;;=3^Drug/chem diabetes w hypoglycemia w coma
 ;;^UTILITY(U,$J,358.3,8942,1,4,0)
 ;;=4^E09.641
 ;;^UTILITY(U,$J,358.3,8942,2)
 ;;=^5002581
 ;;^UTILITY(U,$J,358.3,8943,0)
 ;;=E08.21^^55^555^6
