IBDEI0SA ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28430,1,4,0)
 ;;=4^C92.32
 ;;^UTILITY(U,$J,358.3,28430,2)
 ;;=^5001800
 ;;^UTILITY(U,$J,358.3,28431,0)
 ;;=C92.90^^105^1381^54
 ;;^UTILITY(U,$J,358.3,28431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28431,1,3,0)
 ;;=3^Myeloid leukemia, unspecified, not having achieved remission
 ;;^UTILITY(U,$J,358.3,28431,1,4,0)
 ;;=4^C92.90
 ;;^UTILITY(U,$J,358.3,28431,2)
 ;;=^5001810
 ;;^UTILITY(U,$J,358.3,28432,0)
 ;;=C92.91^^105^1381^53
 ;;^UTILITY(U,$J,358.3,28432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28432,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,28432,1,4,0)
 ;;=4^C92.91
 ;;^UTILITY(U,$J,358.3,28432,2)
 ;;=^5001811
 ;;^UTILITY(U,$J,358.3,28433,0)
 ;;=C92.92^^105^1381^52
 ;;^UTILITY(U,$J,358.3,28433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28433,1,3,0)
 ;;=3^Myeloid leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,28433,1,4,0)
 ;;=4^C92.92
 ;;^UTILITY(U,$J,358.3,28433,2)
 ;;=^5001812
 ;;^UTILITY(U,$J,358.3,28434,0)
 ;;=C93.00^^105^1381^12
 ;;^UTILITY(U,$J,358.3,28434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28434,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, not achieve remission
 ;;^UTILITY(U,$J,358.3,28434,1,4,0)
 ;;=4^C93.00
 ;;^UTILITY(U,$J,358.3,28434,2)
 ;;=^5001819
 ;;^UTILITY(U,$J,358.3,28435,0)
 ;;=C93.01^^105^1381^10
 ;;^UTILITY(U,$J,358.3,28435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28435,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,28435,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,28435,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,28436,0)
 ;;=C93.02^^105^1381^11
 ;;^UTILITY(U,$J,358.3,28436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28436,1,3,0)
 ;;=3^Acute monoblastic/monocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,28436,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,28436,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,28437,0)
 ;;=C93.10^^105^1381^31
 ;;^UTILITY(U,$J,358.3,28437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28437,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,28437,1,4,0)
 ;;=4^C93.10
 ;;^UTILITY(U,$J,358.3,28437,2)
 ;;=^5001822
 ;;^UTILITY(U,$J,358.3,28438,0)
 ;;=C93.11^^105^1381^33
 ;;^UTILITY(U,$J,358.3,28438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28438,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,28438,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,28438,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,28439,0)
 ;;=C93.12^^105^1381^32
 ;;^UTILITY(U,$J,358.3,28439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28439,1,3,0)
 ;;=3^Chronic myelomonocytic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,28439,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,28439,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,28440,0)
 ;;=C93.90^^105^1381^48
 ;;^UTILITY(U,$J,358.3,28440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28440,1,3,0)
 ;;=3^Monocytic leukemia, unsp, not having achieved remission
 ;;^UTILITY(U,$J,358.3,28440,1,4,0)
 ;;=4^C93.90
 ;;^UTILITY(U,$J,358.3,28440,2)
 ;;=^5001828
 ;;^UTILITY(U,$J,358.3,28441,0)
 ;;=C93.91^^105^1381^50
 ;;^UTILITY(U,$J,358.3,28441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28441,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in remission
 ;;^UTILITY(U,$J,358.3,28441,1,4,0)
 ;;=4^C93.91
 ;;^UTILITY(U,$J,358.3,28441,2)
 ;;=^5001829
 ;;^UTILITY(U,$J,358.3,28442,0)
 ;;=C93.92^^105^1381^49
 ;;^UTILITY(U,$J,358.3,28442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28442,1,3,0)
 ;;=3^Monocytic leukemia, unspecified in relapse
 ;;^UTILITY(U,$J,358.3,28442,1,4,0)
 ;;=4^C93.92
 ;;^UTILITY(U,$J,358.3,28442,2)
 ;;=^5001830
 ;;^UTILITY(U,$J,358.3,28443,0)
 ;;=C94.00^^105^1381^3
 ;;^UTILITY(U,$J,358.3,28443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28443,1,3,0)
 ;;=3^Acute erythroid leukemia, not having achieved remission
 ;;^UTILITY(U,$J,358.3,28443,1,4,0)
 ;;=4^C94.00
 ;;^UTILITY(U,$J,358.3,28443,2)
 ;;=^5001834
 ;;^UTILITY(U,$J,358.3,28444,0)
 ;;=C94.01^^105^1381^2
 ;;^UTILITY(U,$J,358.3,28444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28444,1,3,0)
 ;;=3^Acute erythroid leukemia, in remission
 ;;^UTILITY(U,$J,358.3,28444,1,4,0)
 ;;=4^C94.01
 ;;^UTILITY(U,$J,358.3,28444,2)
 ;;=^5001835
 ;;^UTILITY(U,$J,358.3,28445,0)
 ;;=C94.02^^105^1381^1
 ;;^UTILITY(U,$J,358.3,28445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28445,1,3,0)
 ;;=3^Acute erythroid leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,28445,1,4,0)
 ;;=4^C94.02
 ;;^UTILITY(U,$J,358.3,28445,2)
 ;;=^5001836
 ;;^UTILITY(U,$J,358.3,28446,0)
 ;;=C94.20^^105^1381^7
 ;;^UTILITY(U,$J,358.3,28446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28446,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia not achieve remission
 ;;^UTILITY(U,$J,358.3,28446,1,4,0)
 ;;=4^C94.20
 ;;^UTILITY(U,$J,358.3,28446,2)
 ;;=^5001837
 ;;^UTILITY(U,$J,358.3,28447,0)
 ;;=C94.21^^105^1381^9
 ;;^UTILITY(U,$J,358.3,28447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28447,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,28447,1,4,0)
 ;;=4^C94.21
 ;;^UTILITY(U,$J,358.3,28447,2)
 ;;=^5001838
 ;;^UTILITY(U,$J,358.3,28448,0)
 ;;=C94.22^^105^1381^8
 ;;^UTILITY(U,$J,358.3,28448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28448,1,3,0)
 ;;=3^Acute megakaryoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,28448,1,4,0)
 ;;=4^C94.22
 ;;^UTILITY(U,$J,358.3,28448,2)
 ;;=^5001839
 ;;^UTILITY(U,$J,358.3,28449,0)
 ;;=C94.30^^105^1381^45
 ;;^UTILITY(U,$J,358.3,28449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28449,1,3,0)
 ;;=3^Mast cell leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,28449,1,4,0)
 ;;=4^C94.30
 ;;^UTILITY(U,$J,358.3,28449,2)
 ;;=^5001840
 ;;^UTILITY(U,$J,358.3,28450,0)
 ;;=C94.31^^105^1381^47
 ;;^UTILITY(U,$J,358.3,28450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28450,1,3,0)
 ;;=3^Mast cell leukemia, in remission
 ;;^UTILITY(U,$J,358.3,28450,1,4,0)
 ;;=4^C94.31
 ;;^UTILITY(U,$J,358.3,28450,2)
 ;;=^5001841
 ;;^UTILITY(U,$J,358.3,28451,0)
 ;;=C94.32^^105^1381^46
 ;;^UTILITY(U,$J,358.3,28451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28451,1,3,0)
 ;;=3^Mast cell leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,28451,1,4,0)
 ;;=4^C94.32
 ;;^UTILITY(U,$J,358.3,28451,2)
 ;;=^5001842
 ;;^UTILITY(U,$J,358.3,28452,0)
 ;;=C95.00^^105^1381^4
 ;;^UTILITY(U,$J,358.3,28452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28452,1,3,0)
 ;;=3^Acute leukemia of unsp cell type not achieve remission
 ;;^UTILITY(U,$J,358.3,28452,1,4,0)
 ;;=4^C95.00
 ;;^UTILITY(U,$J,358.3,28452,2)
 ;;=^5001850
 ;;^UTILITY(U,$J,358.3,28453,0)
 ;;=C95.01^^105^1381^5
 ;;^UTILITY(U,$J,358.3,28453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28453,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in remission
 ;;^UTILITY(U,$J,358.3,28453,1,4,0)
 ;;=4^C95.01
 ;;^UTILITY(U,$J,358.3,28453,2)
 ;;=^5001851
 ;;^UTILITY(U,$J,358.3,28454,0)
 ;;=C95.02^^105^1381^6
 ;;^UTILITY(U,$J,358.3,28454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28454,1,3,0)
 ;;=3^Acute leukemia of unspecified cell type, in relapse
 ;;^UTILITY(U,$J,358.3,28454,1,4,0)
 ;;=4^C95.02
 ;;^UTILITY(U,$J,358.3,28454,2)
 ;;=^5001852
 ;;^UTILITY(U,$J,358.3,28455,0)
 ;;=D45.^^105^1381^58
 ;;^UTILITY(U,$J,358.3,28455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28455,1,3,0)
 ;;=3^Polycythemia vera
 ;;^UTILITY(U,$J,358.3,28455,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,28455,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,28456,0)
 ;;=C95.10^^105^1381^25
 ;;^UTILITY(U,$J,358.3,28456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28456,1,3,0)
 ;;=3^Chronic leukemia of unsp cell type not achieve remission
 ;;^UTILITY(U,$J,358.3,28456,1,4,0)
 ;;=4^C95.10
 ;;^UTILITY(U,$J,358.3,28456,2)
 ;;=^5001853
 ;;^UTILITY(U,$J,358.3,28457,0)
 ;;=C95.11^^105^1381^26
 ;;^UTILITY(U,$J,358.3,28457,1,0)
 ;;=^358.31IA^4^2
