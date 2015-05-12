IBDEI043 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4982,1,3,0)
 ;;=3^Solitary Plasmacytoma,In Remission
 ;;^UTILITY(U,$J,358.3,4982,1,4,0)
 ;;=4^C90.31
 ;;^UTILITY(U,$J,358.3,4982,2)
 ;;=^5001760
 ;;^UTILITY(U,$J,358.3,4983,0)
 ;;=C90.32^^22^216^473
 ;;^UTILITY(U,$J,358.3,4983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4983,1,3,0)
 ;;=3^Solitary Plasmacytoma,In Relapse
 ;;^UTILITY(U,$J,358.3,4983,1,4,0)
 ;;=4^C90.32
 ;;^UTILITY(U,$J,358.3,4983,2)
 ;;=^5001761
 ;;^UTILITY(U,$J,358.3,4984,0)
 ;;=C91.00^^22^216^9
 ;;^UTILITY(U,$J,358.3,4984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4984,1,3,0)
 ;;=3^Acute Lymphoblastic Leumkemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,4984,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,4984,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,4985,0)
 ;;=C91.01^^22^216^8
 ;;^UTILITY(U,$J,358.3,4985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4985,1,3,0)
 ;;=3^Acute Lymphoblastic Leumkemia,In Remission
 ;;^UTILITY(U,$J,358.3,4985,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,4985,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,4986,0)
 ;;=C91.02^^22^216^7
 ;;^UTILITY(U,$J,358.3,4986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4986,1,3,0)
 ;;=3^Acute Lymphoblastic Leumkemia,In Relapse
 ;;^UTILITY(U,$J,358.3,4986,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,4986,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,4987,0)
 ;;=C91.10^^22^216^82
 ;;^UTILITY(U,$J,358.3,4987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4987,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,4987,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,4987,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,4988,0)
 ;;=C91.11^^22^216^83
 ;;^UTILITY(U,$J,358.3,4988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4988,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,4988,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,4988,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,4989,0)
 ;;=C91.12^^22^216^84
 ;;^UTILITY(U,$J,358.3,4989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4989,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Relapse
 ;;^UTILITY(U,$J,358.3,4989,1,4,0)
 ;;=4^C91.12
 ;;^UTILITY(U,$J,358.3,4989,2)
 ;;=^5001767
 ;;^UTILITY(U,$J,358.3,4990,0)
 ;;=C91.30^^22^216^446
 ;;^UTILITY(U,$J,358.3,4990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4990,1,3,0)
 ;;=3^Prolymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,4990,1,4,0)
 ;;=4^C91.30
 ;;^UTILITY(U,$J,358.3,4990,2)
 ;;=^5001768
 ;;^UTILITY(U,$J,358.3,4991,0)
 ;;=C91.31^^22^216^447
 ;;^UTILITY(U,$J,358.3,4991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4991,1,3,0)
 ;;=3^Prolymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,4991,1,4,0)
 ;;=4^C91.31
 ;;^UTILITY(U,$J,358.3,4991,2)
 ;;=^5001769
 ;;^UTILITY(U,$J,358.3,4992,0)
 ;;=C91.32^^22^216^448
 ;;^UTILITY(U,$J,358.3,4992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4992,1,3,0)
 ;;=3^Prolymphocytic Leukemia of B-Cell Type,In Relapse
 ;;^UTILITY(U,$J,358.3,4992,1,4,0)
 ;;=4^C91.32
 ;;^UTILITY(U,$J,358.3,4992,2)
 ;;=^5001770
 ;;^UTILITY(U,$J,358.3,4993,0)
 ;;=C91.40^^22^216^212
 ;;^UTILITY(U,$J,358.3,4993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4993,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,4993,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,4993,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,4994,0)
 ;;=C91.41^^22^216^211
 ;;^UTILITY(U,$J,358.3,4994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4994,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,4994,1,4,0)
 ;;=4^C91.41
 ;;^UTILITY(U,$J,358.3,4994,2)
 ;;=^5001772
 ;;^UTILITY(U,$J,358.3,4995,0)
 ;;=C91.42^^22^216^210
 ;;^UTILITY(U,$J,358.3,4995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4995,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,4995,1,4,0)
 ;;=4^C91.42
 ;;^UTILITY(U,$J,358.3,4995,2)
 ;;=^5001773
 ;;^UTILITY(U,$J,358.3,4996,0)
 ;;=C91.50^^22^216^36
 ;;^UTILITY(U,$J,358.3,4996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4996,1,3,0)
 ;;=3^Adult T-Cell Lymphoma/Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,4996,1,4,0)
 ;;=4^C91.50
 ;;^UTILITY(U,$J,358.3,4996,2)
 ;;=^5001774
 ;;^UTILITY(U,$J,358.3,4997,0)
 ;;=C91.51^^22^216^35
 ;;^UTILITY(U,$J,358.3,4997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4997,1,3,0)
 ;;=3^Adult T-Cell Lymphoma/Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,4997,1,4,0)
 ;;=4^C91.51
 ;;^UTILITY(U,$J,358.3,4997,2)
 ;;=^5001775
 ;;^UTILITY(U,$J,358.3,4998,0)
 ;;=C91.52^^22^216^34
 ;;^UTILITY(U,$J,358.3,4998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4998,1,3,0)
 ;;=3^Adult T-Cell Lymphoma/Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,4998,1,4,0)
 ;;=4^C91.52
 ;;^UTILITY(U,$J,358.3,4998,2)
 ;;=^5001776
 ;;^UTILITY(U,$J,358.3,4999,0)
 ;;=C91.60^^22^216^449
 ;;^UTILITY(U,$J,358.3,4999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4999,1,3,0)
 ;;=3^Prolymphocytic Leukemia of T-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,4999,1,4,0)
 ;;=4^C91.60
 ;;^UTILITY(U,$J,358.3,4999,2)
 ;;=^5001777
 ;;^UTILITY(U,$J,358.3,5000,0)
 ;;=C91.61^^22^216^450
 ;;^UTILITY(U,$J,358.3,5000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5000,1,3,0)
 ;;=3^Prolymphocytic Leukemia of T-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,5000,1,4,0)
 ;;=4^C91.61
 ;;^UTILITY(U,$J,358.3,5000,2)
 ;;=^5001778
 ;;^UTILITY(U,$J,358.3,5001,0)
 ;;=C91.62^^22^216^451
 ;;^UTILITY(U,$J,358.3,5001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5001,1,3,0)
 ;;=3^Prolymphocytic Leukemia of T-Cell Type,In Relapse
 ;;^UTILITY(U,$J,358.3,5001,1,4,0)
 ;;=4^C91.62
 ;;^UTILITY(U,$J,358.3,5001,2)
 ;;=^5001779
 ;;^UTILITY(U,$J,358.3,5002,0)
 ;;=C91.A0^^22^216^301
 ;;^UTILITY(U,$J,358.3,5002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5002,1,3,0)
 ;;=3^Mature B-Cell Leukemia Burkitt Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,5002,1,4,0)
 ;;=4^C91.A0
 ;;^UTILITY(U,$J,358.3,5002,2)
 ;;=^5001783
 ;;^UTILITY(U,$J,358.3,5003,0)
 ;;=C91.A1^^22^216^299
 ;;^UTILITY(U,$J,358.3,5003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5003,1,3,0)
 ;;=3^Mature B-Cell Leukemia Burkitt Type,In Remission
 ;;^UTILITY(U,$J,358.3,5003,1,4,0)
 ;;=4^C91.A1
 ;;^UTILITY(U,$J,358.3,5003,2)
 ;;=^5001784
 ;;^UTILITY(U,$J,358.3,5004,0)
 ;;=C91.A2^^22^216^300
 ;;^UTILITY(U,$J,358.3,5004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5004,1,3,0)
 ;;=3^Mature B-Cell Leukemia Burkitt Type,In Relapse
 ;;^UTILITY(U,$J,358.3,5004,1,4,0)
 ;;=4^C91.A2
 ;;^UTILITY(U,$J,358.3,5004,2)
 ;;=^5001785
 ;;^UTILITY(U,$J,358.3,5005,0)
 ;;=C91.Z0^^22^216^277
 ;;^UTILITY(U,$J,358.3,5005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5005,1,3,0)
 ;;=3^Lymphoid Leukemia NEC,Not in Remission
 ;;^UTILITY(U,$J,358.3,5005,1,4,0)
 ;;=4^C91.Z0
 ;;^UTILITY(U,$J,358.3,5005,2)
 ;;=^5001786
 ;;^UTILITY(U,$J,358.3,5006,0)
 ;;=C91.Z1^^22^216^276
 ;;^UTILITY(U,$J,358.3,5006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5006,1,3,0)
 ;;=3^Lymphoid Leukemia NEC,In Remission
 ;;^UTILITY(U,$J,358.3,5006,1,4,0)
 ;;=4^C91.Z1
 ;;^UTILITY(U,$J,358.3,5006,2)
 ;;=^5001787
 ;;^UTILITY(U,$J,358.3,5007,0)
 ;;=C91.Z2^^22^216^275
 ;;^UTILITY(U,$J,358.3,5007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5007,1,3,0)
 ;;=3^Lymphoid Leukemia NEC,In Relapse
 ;;^UTILITY(U,$J,358.3,5007,1,4,0)
 ;;=4^C91.Z2
 ;;^UTILITY(U,$J,358.3,5007,2)
 ;;=^5001788
 ;;^UTILITY(U,$J,358.3,5008,0)
 ;;=C91.90^^22^216^280
 ;;^UTILITY(U,$J,358.3,5008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5008,1,3,0)
 ;;=3^Lymphoid Leukemia,Unspec,Not in Remission
 ;;^UTILITY(U,$J,358.3,5008,1,4,0)
 ;;=4^C91.90
 ;;^UTILITY(U,$J,358.3,5008,2)
 ;;=^5001780
 ;;^UTILITY(U,$J,358.3,5009,0)
 ;;=C91.91^^22^216^279
 ;;^UTILITY(U,$J,358.3,5009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5009,1,3,0)
 ;;=3^Lymphoid Leukemia,Unspec,In Remission
 ;;^UTILITY(U,$J,358.3,5009,1,4,0)
 ;;=4^C91.91
 ;;^UTILITY(U,$J,358.3,5009,2)
 ;;=^5001781
 ;;^UTILITY(U,$J,358.3,5010,0)
 ;;=C91.92^^22^216^278
 ;;^UTILITY(U,$J,358.3,5010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5010,1,3,0)
 ;;=3^Lymphoid Leukemia,Unspec,In Relapse
 ;;^UTILITY(U,$J,358.3,5010,1,4,0)
 ;;=4^C91.92
 ;;^UTILITY(U,$J,358.3,5010,2)
 ;;=^5001782
 ;;^UTILITY(U,$J,358.3,5011,0)
 ;;=C92.00^^22^216^18
 ;;^UTILITY(U,$J,358.3,5011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5011,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5011,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,5011,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,5012,0)
 ;;=C92.01^^22^216^17
 ;;^UTILITY(U,$J,358.3,5012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5012,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,5012,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,5012,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,5013,0)
 ;;=C92.02^^22^216^16
 ;;^UTILITY(U,$J,358.3,5013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5013,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,5013,1,4,0)
 ;;=4^C92.02
 ;;^UTILITY(U,$J,358.3,5013,2)
 ;;=^5001791
 ;;^UTILITY(U,$J,358.3,5014,0)
 ;;=C92.10^^22^216^88
 ;;^UTILITY(U,$J,358.3,5014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5014,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,5014,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,5014,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,5015,0)
 ;;=C92.11^^22^216^89
 ;;^UTILITY(U,$J,358.3,5015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5015,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,5015,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,5015,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,5016,0)
 ;;=C92.12^^22^216^90
 ;;^UTILITY(U,$J,358.3,5016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5016,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Relapse
 ;;^UTILITY(U,$J,358.3,5016,1,4,0)
 ;;=4^C92.12
 ;;^UTILITY(U,$J,358.3,5016,2)
 ;;=^5001794
