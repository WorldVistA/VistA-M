IBDEI0JY ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8992,1,3,0)
 ;;=3^Drug/chem diabetes w unsp complications
 ;;^UTILITY(U,$J,358.3,8992,1,4,0)
 ;;=4^E09.8
 ;;^UTILITY(U,$J,358.3,8992,2)
 ;;=^5002585
 ;;^UTILITY(U,$J,358.3,8993,0)
 ;;=E88.01^^55^556^13
 ;;^UTILITY(U,$J,358.3,8993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8993,1,3,0)
 ;;=3^Alpha-1-antitrypsin deficiency
 ;;^UTILITY(U,$J,358.3,8993,1,4,0)
 ;;=4^E88.01
 ;;^UTILITY(U,$J,358.3,8993,2)
 ;;=^331442
 ;;^UTILITY(U,$J,358.3,8994,0)
 ;;=E71.310^^55^556^70
 ;;^UTILITY(U,$J,358.3,8994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8994,1,3,0)
 ;;=3^Long chain/very long chain acyl CoA dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,8994,1,4,0)
 ;;=4^E71.310
 ;;^UTILITY(U,$J,358.3,8994,2)
 ;;=^5002870
 ;;^UTILITY(U,$J,358.3,8995,0)
 ;;=E71.311^^55^556^76
 ;;^UTILITY(U,$J,358.3,8995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8995,1,3,0)
 ;;=3^Medium chain acyl CoA dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,8995,1,4,0)
 ;;=4^E71.311
 ;;^UTILITY(U,$J,358.3,8995,2)
 ;;=^5002871
 ;;^UTILITY(U,$J,358.3,8996,0)
 ;;=E71.312^^55^556^99
 ;;^UTILITY(U,$J,358.3,8996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8996,1,3,0)
 ;;=3^Short chain acyl CoA dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,8996,1,4,0)
 ;;=4^E71.312
 ;;^UTILITY(U,$J,358.3,8996,2)
 ;;=^5002872
 ;;^UTILITY(U,$J,358.3,8997,0)
 ;;=E71.313^^55^556^48
 ;;^UTILITY(U,$J,358.3,8997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8997,1,3,0)
 ;;=3^Glutaric aciduria type II
 ;;^UTILITY(U,$J,358.3,8997,1,4,0)
 ;;=4^E71.313
 ;;^UTILITY(U,$J,358.3,8997,2)
 ;;=^5002873
 ;;^UTILITY(U,$J,358.3,8998,0)
 ;;=E71.314^^55^556^82
 ;;^UTILITY(U,$J,358.3,8998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8998,1,3,0)
 ;;=3^Muscle carnitine palmitoyltransferase deficiency
 ;;^UTILITY(U,$J,358.3,8998,1,4,0)
 ;;=4^E71.314
 ;;^UTILITY(U,$J,358.3,8998,2)
 ;;=^5002874
 ;;^UTILITY(U,$J,358.3,8999,0)
 ;;=E71.318^^55^556^39
 ;;^UTILITY(U,$J,358.3,8999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8999,1,3,0)
 ;;=3^Fatty-Acid Oxidation Disorders NEC
 ;;^UTILITY(U,$J,358.3,8999,1,4,0)
 ;;=4^E71.318
 ;;^UTILITY(U,$J,358.3,8999,2)
 ;;=^5002875
 ;;^UTILITY(U,$J,358.3,9000,0)
 ;;=E71.50^^55^556^89
 ;;^UTILITY(U,$J,358.3,9000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9000,1,3,0)
 ;;=3^Peroxisomal disorder, unspecified
 ;;^UTILITY(U,$J,358.3,9000,1,4,0)
 ;;=4^E71.50
 ;;^UTILITY(U,$J,358.3,9000,2)
 ;;=^5002880
 ;;^UTILITY(U,$J,358.3,9001,0)
 ;;=E71.510^^55^556^114
 ;;^UTILITY(U,$J,358.3,9001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9001,1,3,0)
 ;;=3^Zellweger syndrome
 ;;^UTILITY(U,$J,358.3,9001,1,4,0)
 ;;=4^E71.510
 ;;^UTILITY(U,$J,358.3,9001,2)
 ;;=^128776
 ;;^UTILITY(U,$J,358.3,9002,0)
 ;;=E71.522^^55^556^11
 ;;^UTILITY(U,$J,358.3,9002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9002,1,3,0)
 ;;=3^Adrenomyeloneuropathy
 ;;^UTILITY(U,$J,358.3,9002,1,4,0)
 ;;=4^E71.522
 ;;^UTILITY(U,$J,358.3,9002,2)
 ;;=^276921
 ;;^UTILITY(U,$J,358.3,9003,0)
 ;;=E71.529^^55^556^113
 ;;^UTILITY(U,$J,358.3,9003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9003,1,3,0)
 ;;=3^X-linked adrenoleukodystrophy, unspecified type
 ;;^UTILITY(U,$J,358.3,9003,1,4,0)
 ;;=4^E71.529
 ;;^UTILITY(U,$J,358.3,9003,2)
 ;;=^5002886
 ;;^UTILITY(U,$J,358.3,9004,0)
 ;;=E71.548^^55^556^90
 ;;^UTILITY(U,$J,358.3,9004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9004,1,3,0)
 ;;=3^Peroxisomal disorders NEC
 ;;^UTILITY(U,$J,358.3,9004,1,4,0)
 ;;=4^E71.548
 ;;^UTILITY(U,$J,358.3,9004,2)
 ;;=^5002891
 ;;^UTILITY(U,$J,358.3,9005,0)
 ;;=E88.40^^55^556^78
