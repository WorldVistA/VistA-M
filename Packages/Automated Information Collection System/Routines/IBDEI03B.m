IBDEI03B ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1011,1,4,0)
 ;;=4^R13.14
 ;;^UTILITY(U,$J,358.3,1011,2)
 ;;=^335279
 ;;^UTILITY(U,$J,358.3,1012,0)
 ;;=S02.2XXA^^3^35^73
 ;;^UTILITY(U,$J,358.3,1012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1012,1,3,0)
 ;;=3^Fracture of nasal bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,1012,1,4,0)
 ;;=4^S02.2XXA
 ;;^UTILITY(U,$J,358.3,1012,2)
 ;;=^5020306
 ;;^UTILITY(U,$J,358.3,1013,0)
 ;;=S05.01XA^^3^35^89
 ;;^UTILITY(U,$J,358.3,1013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1013,1,3,0)
 ;;=3^Inj conjunctiva and corneal abrasion w/o fb, right eye, init
 ;;^UTILITY(U,$J,358.3,1013,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,1013,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,1014,0)
 ;;=S05.02XA^^3^35^90
 ;;^UTILITY(U,$J,358.3,1014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1014,1,3,0)
 ;;=3^Inj conjunctiva and corneal abrasion w/o fb, left eye, init
 ;;^UTILITY(U,$J,358.3,1014,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,1014,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,1015,0)
 ;;=T17.1XXA^^3^35^72
 ;;^UTILITY(U,$J,358.3,1015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1015,1,3,0)
 ;;=3^Foreign body in nostril, initial encounter
 ;;^UTILITY(U,$J,358.3,1015,1,4,0)
 ;;=4^T17.1XXA
 ;;^UTILITY(U,$J,358.3,1015,2)
 ;;=^5046429
 ;;^UTILITY(U,$J,358.3,1016,0)
 ;;=E05.90^^3^36^20
 ;;^UTILITY(U,$J,358.3,1016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1016,1,3,0)
 ;;=3^Thyrotoxicosis, unsp without thyrotoxic crisis or storm
 ;;^UTILITY(U,$J,358.3,1016,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,1016,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,1017,0)
 ;;=E03.9^^3^36^11
 ;;^UTILITY(U,$J,358.3,1017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1017,1,3,0)
 ;;=3^Hypothyroidism, unspecified
 ;;^UTILITY(U,$J,358.3,1017,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,1017,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,1018,0)
 ;;=E07.9^^3^36^19
 ;;^UTILITY(U,$J,358.3,1018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1018,1,3,0)
 ;;=3^Thyroid Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1018,1,4,0)
 ;;=4^E07.9
 ;;^UTILITY(U,$J,358.3,1018,2)
 ;;=^5002502
 ;;^UTILITY(U,$J,358.3,1019,0)
 ;;=E21.3^^3^36^9
 ;;^UTILITY(U,$J,358.3,1019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1019,1,3,0)
 ;;=3^Hyperparathyroidism, unspecified
 ;;^UTILITY(U,$J,358.3,1019,1,4,0)
 ;;=4^E21.3
 ;;^UTILITY(U,$J,358.3,1019,2)
 ;;=^331438
 ;;^UTILITY(U,$J,358.3,1020,0)
 ;;=E21.0^^3^36^15
 ;;^UTILITY(U,$J,358.3,1020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1020,1,3,0)
 ;;=3^Primary hyperparathyroidism
 ;;^UTILITY(U,$J,358.3,1020,1,4,0)
 ;;=4^E21.0
 ;;^UTILITY(U,$J,358.3,1020,2)
 ;;=^331439
 ;;^UTILITY(U,$J,358.3,1021,0)
 ;;=E21.1^^3^36^17
 ;;^UTILITY(U,$J,358.3,1021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1021,1,3,0)
 ;;=3^Secondary hyperparathyroidism, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,1021,1,4,0)
 ;;=4^E21.1
 ;;^UTILITY(U,$J,358.3,1021,2)
 ;;=^5002715
 ;;^UTILITY(U,$J,358.3,1022,0)
 ;;=E27.1^^3^36^14
 ;;^UTILITY(U,$J,358.3,1022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1022,1,3,0)
 ;;=3^Primary adrenocortical insufficiency
 ;;^UTILITY(U,$J,358.3,1022,1,4,0)
 ;;=4^E27.1
 ;;^UTILITY(U,$J,358.3,1022,2)
 ;;=^5002740
 ;;^UTILITY(U,$J,358.3,1023,0)
 ;;=E27.2^^3^36^2
 ;;^UTILITY(U,$J,358.3,1023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1023,1,3,0)
 ;;=3^Addisonian crisis
 ;;^UTILITY(U,$J,358.3,1023,1,4,0)
 ;;=4^E27.2
 ;;^UTILITY(U,$J,358.3,1023,2)
 ;;=^263725
 ;;^UTILITY(U,$J,358.3,1024,0)
 ;;=E27.40^^3^36^3
 ;;^UTILITY(U,$J,358.3,1024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1024,1,3,0)
 ;;=3^Adrenocortical Insufficiency,Unspec
