IBDEI0JV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8955,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic polyneurop
 ;;^UTILITY(U,$J,358.3,8955,1,4,0)
 ;;=4^E08.42
 ;;^UTILITY(U,$J,358.3,8955,2)
 ;;=^5002524
 ;;^UTILITY(U,$J,358.3,8956,0)
 ;;=E08.43^^55^555^14
 ;;^UTILITY(U,$J,358.3,8956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8956,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic autonm (poly)neuropathy
 ;;^UTILITY(U,$J,358.3,8956,1,4,0)
 ;;=4^E08.43
 ;;^UTILITY(U,$J,358.3,8956,2)
 ;;=^5002525
 ;;^UTILITY(U,$J,358.3,8957,0)
 ;;=E08.44^^55^555^15
 ;;^UTILITY(U,$J,358.3,8957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8957,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic amyotrophy
 ;;^UTILITY(U,$J,358.3,8957,1,4,0)
 ;;=4^E08.44
 ;;^UTILITY(U,$J,358.3,8957,2)
 ;;=^5002526
 ;;^UTILITY(U,$J,358.3,8958,0)
 ;;=E08.49^^55^555^16
 ;;^UTILITY(U,$J,358.3,8958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8958,1,3,0)
 ;;=3^Diabetes due to underlying condition w oth diabetic neuro comp
 ;;^UTILITY(U,$J,358.3,8958,1,4,0)
 ;;=4^E08.49
 ;;^UTILITY(U,$J,358.3,8958,2)
 ;;=^5002527
 ;;^UTILITY(U,$J,358.3,8959,0)
 ;;=E08.610^^55^555^17
 ;;^UTILITY(U,$J,358.3,8959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8959,1,3,0)
 ;;=3^Diabetes due to underlying condition w diabetic neuropathic arthrop
 ;;^UTILITY(U,$J,358.3,8959,1,4,0)
 ;;=4^E08.610
 ;;^UTILITY(U,$J,358.3,8959,2)
 ;;=^5002531
 ;;^UTILITY(U,$J,358.3,8960,0)
 ;;=E09.40^^55^555^43
 ;;^UTILITY(U,$J,358.3,8960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8960,1,3,0)
 ;;=3^Drug/chem diabetes w neuro comp w diabetic neuropathy, unsp
 ;;^UTILITY(U,$J,358.3,8960,1,4,0)
 ;;=4^E09.40
 ;;^UTILITY(U,$J,358.3,8960,2)
 ;;=^5002564
 ;;^UTILITY(U,$J,358.3,8961,0)
 ;;=E09.41^^55^555^44
 ;;^UTILITY(U,$J,358.3,8961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8961,1,3,0)
 ;;=3^Drug/chem diabetes w neuro comp w diabetic mononeuropathy
 ;;^UTILITY(U,$J,358.3,8961,1,4,0)
 ;;=4^E09.41
 ;;^UTILITY(U,$J,358.3,8961,2)
 ;;=^5002565
 ;;^UTILITY(U,$J,358.3,8962,0)
 ;;=E09.42^^55^555^46
 ;;^UTILITY(U,$J,358.3,8962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8962,1,3,0)
 ;;=3^Drug/chem diabetes w neurological comp w diabetic polyneurop
 ;;^UTILITY(U,$J,358.3,8962,1,4,0)
 ;;=4^E09.42
 ;;^UTILITY(U,$J,358.3,8962,2)
 ;;=^5002566
 ;;^UTILITY(U,$J,358.3,8963,0)
 ;;=E09.43^^55^555^42
 ;;^UTILITY(U,$J,358.3,8963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8963,1,3,0)
 ;;=3^Drug/chem diabetes w neuro comp w diab autonm (poly)neuropathy
 ;;^UTILITY(U,$J,358.3,8963,1,4,0)
 ;;=4^E09.43
 ;;^UTILITY(U,$J,358.3,8963,2)
 ;;=^5002567
 ;;^UTILITY(U,$J,358.3,8964,0)
 ;;=E09.44^^55^555^47
 ;;^UTILITY(U,$J,358.3,8964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8964,1,3,0)
 ;;=3^Drug/chem diabetes w neurological comp w diabetic amyotrophy
 ;;^UTILITY(U,$J,358.3,8964,1,4,0)
 ;;=4^E09.44
 ;;^UTILITY(U,$J,358.3,8964,2)
 ;;=^5002568
 ;;^UTILITY(U,$J,358.3,8965,0)
 ;;=E09.49^^55^555^45
 ;;^UTILITY(U,$J,358.3,8965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8965,1,3,0)
 ;;=3^Drug/chem diabetes w neuro comp w oth diabetic neuro comp
 ;;^UTILITY(U,$J,358.3,8965,1,4,0)
 ;;=4^E09.49
 ;;^UTILITY(U,$J,358.3,8965,2)
 ;;=^5002569
 ;;^UTILITY(U,$J,358.3,8966,0)
 ;;=E09.610^^55^555^35
 ;;^UTILITY(U,$J,358.3,8966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8966,1,3,0)
 ;;=3^Drug/chem diabetes w diabetic neuropathic arthropathy
 ;;^UTILITY(U,$J,358.3,8966,1,4,0)
 ;;=4^E09.610
 ;;^UTILITY(U,$J,358.3,8966,2)
 ;;=^5002573
 ;;^UTILITY(U,$J,358.3,8967,0)
 ;;=E08.51^^55^555^18
 ;;^UTILITY(U,$J,358.3,8967,1,0)
 ;;=^358.31IA^4^2
