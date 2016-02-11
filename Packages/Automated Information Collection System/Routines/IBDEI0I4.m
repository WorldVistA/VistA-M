IBDEI0I4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8126,0)
 ;;=S02.2XXA^^55^534^73
 ;;^UTILITY(U,$J,358.3,8126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8126,1,3,0)
 ;;=3^Fracture of nasal bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,8126,1,4,0)
 ;;=4^S02.2XXA
 ;;^UTILITY(U,$J,358.3,8126,2)
 ;;=^5020306
 ;;^UTILITY(U,$J,358.3,8127,0)
 ;;=S05.01XA^^55^534^89
 ;;^UTILITY(U,$J,358.3,8127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8127,1,3,0)
 ;;=3^Inj conjunctiva and corneal abrasion w/o fb, right eye, init
 ;;^UTILITY(U,$J,358.3,8127,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,8127,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,8128,0)
 ;;=S05.02XA^^55^534^90
 ;;^UTILITY(U,$J,358.3,8128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8128,1,3,0)
 ;;=3^Inj conjunctiva and corneal abrasion w/o fb, left eye, init
 ;;^UTILITY(U,$J,358.3,8128,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,8128,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,8129,0)
 ;;=T17.1XXA^^55^534^72
 ;;^UTILITY(U,$J,358.3,8129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8129,1,3,0)
 ;;=3^Foreign body in nostril, initial encounter
 ;;^UTILITY(U,$J,358.3,8129,1,4,0)
 ;;=4^T17.1XXA
 ;;^UTILITY(U,$J,358.3,8129,2)
 ;;=^5046429
 ;;^UTILITY(U,$J,358.3,8130,0)
 ;;=E05.90^^55^535^20
 ;;^UTILITY(U,$J,358.3,8130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8130,1,3,0)
 ;;=3^Thyrotoxicosis, unsp without thyrotoxic crisis or storm
 ;;^UTILITY(U,$J,358.3,8130,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,8130,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,8131,0)
 ;;=E03.9^^55^535^11
 ;;^UTILITY(U,$J,358.3,8131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8131,1,3,0)
 ;;=3^Hypothyroidism, unspecified
 ;;^UTILITY(U,$J,358.3,8131,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,8131,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,8132,0)
 ;;=E07.9^^55^535^19
 ;;^UTILITY(U,$J,358.3,8132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8132,1,3,0)
 ;;=3^Thyroid Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,8132,1,4,0)
 ;;=4^E07.9
 ;;^UTILITY(U,$J,358.3,8132,2)
 ;;=^5002502
 ;;^UTILITY(U,$J,358.3,8133,0)
 ;;=E21.3^^55^535^9
 ;;^UTILITY(U,$J,358.3,8133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8133,1,3,0)
 ;;=3^Hyperparathyroidism, unspecified
 ;;^UTILITY(U,$J,358.3,8133,1,4,0)
 ;;=4^E21.3
 ;;^UTILITY(U,$J,358.3,8133,2)
 ;;=^331438
 ;;^UTILITY(U,$J,358.3,8134,0)
 ;;=E21.0^^55^535^15
 ;;^UTILITY(U,$J,358.3,8134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8134,1,3,0)
 ;;=3^Primary hyperparathyroidism
 ;;^UTILITY(U,$J,358.3,8134,1,4,0)
 ;;=4^E21.0
 ;;^UTILITY(U,$J,358.3,8134,2)
 ;;=^331439
 ;;^UTILITY(U,$J,358.3,8135,0)
 ;;=E21.1^^55^535^17
 ;;^UTILITY(U,$J,358.3,8135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8135,1,3,0)
 ;;=3^Secondary hyperparathyroidism, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,8135,1,4,0)
 ;;=4^E21.1
 ;;^UTILITY(U,$J,358.3,8135,2)
 ;;=^5002715
 ;;^UTILITY(U,$J,358.3,8136,0)
 ;;=E27.1^^55^535^14
 ;;^UTILITY(U,$J,358.3,8136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8136,1,3,0)
 ;;=3^Primary adrenocortical insufficiency
 ;;^UTILITY(U,$J,358.3,8136,1,4,0)
 ;;=4^E27.1
 ;;^UTILITY(U,$J,358.3,8136,2)
 ;;=^5002740
 ;;^UTILITY(U,$J,358.3,8137,0)
 ;;=E27.2^^55^535^2
 ;;^UTILITY(U,$J,358.3,8137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8137,1,3,0)
 ;;=3^Addisonian crisis
 ;;^UTILITY(U,$J,358.3,8137,1,4,0)
 ;;=4^E27.2
 ;;^UTILITY(U,$J,358.3,8137,2)
 ;;=^263725
 ;;^UTILITY(U,$J,358.3,8138,0)
 ;;=E27.40^^55^535^3
 ;;^UTILITY(U,$J,358.3,8138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8138,1,3,0)
 ;;=3^Adrenocortical Insufficiency,Unspec
 ;;^UTILITY(U,$J,358.3,8138,1,4,0)
 ;;=4^E27.40
