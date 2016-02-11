IBDEI0JX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8979,1,4,0)
 ;;=4^E08.65
 ;;^UTILITY(U,$J,358.3,8979,2)
 ;;=^5002541
 ;;^UTILITY(U,$J,358.3,8980,0)
 ;;=E08.69^^55^555^29
 ;;^UTILITY(U,$J,358.3,8980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8980,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth complication
 ;;^UTILITY(U,$J,358.3,8980,1,4,0)
 ;;=4^E08.69
 ;;^UTILITY(U,$J,358.3,8980,2)
 ;;=^5002542
 ;;^UTILITY(U,$J,358.3,8981,0)
 ;;=E09.618^^55^555^50
 ;;^UTILITY(U,$J,358.3,8981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8981,1,3,0)
 ;;=3^Drug/chem diabetes w oth diabetic arthropathy
 ;;^UTILITY(U,$J,358.3,8981,1,4,0)
 ;;=4^E09.618
 ;;^UTILITY(U,$J,358.3,8981,2)
 ;;=^5002574
 ;;^UTILITY(U,$J,358.3,8982,0)
 ;;=E09.620^^55^555^33
 ;;^UTILITY(U,$J,358.3,8982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8982,1,3,0)
 ;;=3^Drug/chem diabetes w diabetic dermatitis
 ;;^UTILITY(U,$J,358.3,8982,1,4,0)
 ;;=4^E09.620
 ;;^UTILITY(U,$J,358.3,8982,2)
 ;;=^5002575
 ;;^UTILITY(U,$J,358.3,8983,0)
 ;;=E09.622^^55^555^60
 ;;^UTILITY(U,$J,358.3,8983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8983,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus w oth skin ulcer
 ;;^UTILITY(U,$J,358.3,8983,1,4,0)
 ;;=4^E09.622
 ;;^UTILITY(U,$J,358.3,8983,2)
 ;;=^5002577
 ;;^UTILITY(U,$J,358.3,8984,0)
 ;;=E09.621^^55^555^62
 ;;^UTILITY(U,$J,358.3,8984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8984,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus with foot ulcer
 ;;^UTILITY(U,$J,358.3,8984,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,8984,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,8985,0)
 ;;=E09.628^^55^555^53
 ;;^UTILITY(U,$J,358.3,8985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8985,1,3,0)
 ;;=3^Drug/chem diabetes w oth skin complications
 ;;^UTILITY(U,$J,358.3,8985,1,4,0)
 ;;=4^E09.628
 ;;^UTILITY(U,$J,358.3,8985,2)
 ;;=^5002578
 ;;^UTILITY(U,$J,358.3,8986,0)
 ;;=E09.630^^55^555^54
 ;;^UTILITY(U,$J,358.3,8986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8986,1,3,0)
 ;;=3^Drug/chem diabetes w periodontal disease
 ;;^UTILITY(U,$J,358.3,8986,1,4,0)
 ;;=4^E09.630
 ;;^UTILITY(U,$J,358.3,8986,2)
 ;;=^5002579
 ;;^UTILITY(U,$J,358.3,8987,0)
 ;;=E09.638^^55^555^52
 ;;^UTILITY(U,$J,358.3,8987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8987,1,3,0)
 ;;=3^Drug/chem diabetes w oth oral complications
 ;;^UTILITY(U,$J,358.3,8987,1,4,0)
 ;;=4^E09.638
 ;;^UTILITY(U,$J,358.3,8987,2)
 ;;=^5002580
 ;;^UTILITY(U,$J,358.3,8988,0)
 ;;=E09.65^^55^555^59
 ;;^UTILITY(U,$J,358.3,8988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8988,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus w hyperglycemia
 ;;^UTILITY(U,$J,358.3,8988,1,4,0)
 ;;=4^E09.65
 ;;^UTILITY(U,$J,358.3,8988,2)
 ;;=^5002583
 ;;^UTILITY(U,$J,358.3,8989,0)
 ;;=E09.69^^55^555^49
 ;;^UTILITY(U,$J,358.3,8989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8989,1,3,0)
 ;;=3^Drug/chem diabetes w oth complication
 ;;^UTILITY(U,$J,358.3,8989,1,4,0)
 ;;=4^E09.69
 ;;^UTILITY(U,$J,358.3,8989,2)
 ;;=^5002584
 ;;^UTILITY(U,$J,358.3,8990,0)
 ;;=E09.649^^55^555^39
 ;;^UTILITY(U,$J,358.3,8990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8990,1,3,0)
 ;;=3^Drug/chem diabetes w hypoglycemia w/o coma
 ;;^UTILITY(U,$J,358.3,8990,1,4,0)
 ;;=4^E09.649
 ;;^UTILITY(U,$J,358.3,8990,2)
 ;;=^5002582
 ;;^UTILITY(U,$J,358.3,8991,0)
 ;;=E08.8^^55^555^30
 ;;^UTILITY(U,$J,358.3,8991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8991,1,3,0)
 ;;=3^Diabetes due to underlying condition w unsp complications
 ;;^UTILITY(U,$J,358.3,8991,1,4,0)
 ;;=4^E08.8
 ;;^UTILITY(U,$J,358.3,8991,2)
 ;;=^5002543
 ;;^UTILITY(U,$J,358.3,8992,0)
 ;;=E09.8^^55^555^55
