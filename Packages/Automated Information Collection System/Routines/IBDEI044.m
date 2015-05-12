IBDEI044 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5017,0)
 ;;=C92.20^^22^216^85
 ;;^UTILITY(U,$J,358.3,5017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5017,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Negative,Not in Remission
 ;;^UTILITY(U,$J,358.3,5017,1,4,0)
 ;;=4^C92.20
 ;;^UTILITY(U,$J,358.3,5017,2)
 ;;=^5001795
 ;;^UTILITY(U,$J,358.3,5018,0)
 ;;=C92.21^^22^216^86
 ;;^UTILITY(U,$J,358.3,5018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5018,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Negative,In Remission
 ;;^UTILITY(U,$J,358.3,5018,1,4,0)
 ;;=4^C92.21
 ;;^UTILITY(U,$J,358.3,5018,2)
 ;;=^5001796
 ;;^UTILITY(U,$J,358.3,5019,0)
 ;;=C92.22^^22^216^87
 ;;^UTILITY(U,$J,358.3,5019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5019,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Negative,In Relapse
 ;;^UTILITY(U,$J,358.3,5019,1,4,0)
 ;;=4^C92.22
 ;;^UTILITY(U,$J,358.3,5019,2)
 ;;=^5001797
 ;;^UTILITY(U,$J,358.3,5020,0)
 ;;=C92.30^^22^216^371
 ;;^UTILITY(U,$J,358.3,5020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5020,1,3,0)
 ;;=3^Myeloid Sarcoma,Not in Remission
 ;;^UTILITY(U,$J,358.3,5020,1,4,0)
 ;;=4^C92.30
 ;;^UTILITY(U,$J,358.3,5020,2)
 ;;=^5001798
 ;;^UTILITY(U,$J,358.3,5021,0)
 ;;=C92.31^^22^216^370
 ;;^UTILITY(U,$J,358.3,5021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5021,1,3,0)
 ;;=3^Myeloid Sarcoma,In Remission
 ;;^UTILITY(U,$J,358.3,5021,1,4,0)
 ;;=4^C92.31
 ;;^UTILITY(U,$J,358.3,5021,2)
 ;;=^5001799
 ;;^UTILITY(U,$J,358.3,5022,0)
 ;;=C92.32^^22^216^369
 ;;^UTILITY(U,$J,358.3,5022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5022,1,3,0)
 ;;=3^Myeloid Sarcoma,In Relapse
 ;;^UTILITY(U,$J,358.3,5022,1,4,0)
 ;;=4^C92.32
 ;;^UTILITY(U,$J,358.3,5022,2)
 ;;=^5001800
 ;;^UTILITY(U,$J,358.3,5023,0)
 ;;=C92.40^^22^216^33
 ;;^UTILITY(U,$J,358.3,5023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5023,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5023,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,5023,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,5024,0)
 ;;=C92.41^^22^216^32
 ;;^UTILITY(U,$J,358.3,5024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5024,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,5024,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,5024,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,5025,0)
 ;;=C92.42^^22^216^31
 ;;^UTILITY(U,$J,358.3,5025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5025,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,5025,1,4,0)
 ;;=4^C92.42
 ;;^UTILITY(U,$J,358.3,5025,2)
 ;;=^5001803
 ;;^UTILITY(U,$J,358.3,5026,0)
 ;;=C92.50^^22^216^27
 ;;^UTILITY(U,$J,358.3,5026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5026,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5026,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,5026,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,5027,0)
 ;;=C92.51^^22^216^26
 ;;^UTILITY(U,$J,358.3,5027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5027,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,5027,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,5027,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,5028,0)
 ;;=C92.52^^22^216^25
 ;;^UTILITY(U,$J,358.3,5028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5028,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,5028,1,4,0)
 ;;=4^C92.52
 ;;^UTILITY(U,$J,358.3,5028,2)
 ;;=^5001806
 ;;^UTILITY(U,$J,358.3,5029,0)
 ;;=C92.60^^22^216^19
 ;;^UTILITY(U,$J,358.3,5029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5029,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,5029,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,5029,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,5030,0)
 ;;=C92.61^^22^216^20
 ;;^UTILITY(U,$J,358.3,5030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5030,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,5030,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,5030,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,5031,0)
 ;;=C92.62^^22^216^21
 ;;^UTILITY(U,$J,358.3,5031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5031,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Relapse
 ;;^UTILITY(U,$J,358.3,5031,1,4,0)
 ;;=4^C92.62
 ;;^UTILITY(U,$J,358.3,5031,2)
 ;;=^5001809
 ;;^UTILITY(U,$J,358.3,5032,0)
 ;;=C92.A0^^22^216^22
 ;;^UTILITY(U,$J,358.3,5032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5032,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilineage Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5032,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,5032,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,5033,0)
 ;;=C92.A1^^22^216^23
 ;;^UTILITY(U,$J,358.3,5033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5033,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilineage Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,5033,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,5033,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,5034,0)
 ;;=C92.A2^^22^216^24
 ;;^UTILITY(U,$J,358.3,5034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5034,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilineage Dysplasia,In Relapse
 ;;^UTILITY(U,$J,358.3,5034,1,4,0)
 ;;=4^C92.A2
 ;;^UTILITY(U,$J,358.3,5034,2)
 ;;=^5001815
 ;;^UTILITY(U,$J,358.3,5035,0)
 ;;=C92.Z0^^22^216^365
 ;;^UTILITY(U,$J,358.3,5035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5035,1,3,0)
 ;;=3^Myeloid Leukemia NEC,Not in Remission
 ;;^UTILITY(U,$J,358.3,5035,1,4,0)
 ;;=4^C92.Z0
 ;;^UTILITY(U,$J,358.3,5035,2)
 ;;=^5001816
 ;;^UTILITY(U,$J,358.3,5036,0)
 ;;=C92.Z1^^22^216^364
 ;;^UTILITY(U,$J,358.3,5036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5036,1,3,0)
 ;;=3^Myeloid Leukemia NEC,In Remission
 ;;^UTILITY(U,$J,358.3,5036,1,4,0)
 ;;=4^C92.Z1
 ;;^UTILITY(U,$J,358.3,5036,2)
 ;;=^5001817
 ;;^UTILITY(U,$J,358.3,5037,0)
 ;;=C92.Z2^^22^216^363
 ;;^UTILITY(U,$J,358.3,5037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5037,1,3,0)
 ;;=3^Myeloid Leukemia NEC,In Relapse
 ;;^UTILITY(U,$J,358.3,5037,1,4,0)
 ;;=4^C92.Z2
 ;;^UTILITY(U,$J,358.3,5037,2)
 ;;=^5001818
 ;;^UTILITY(U,$J,358.3,5038,0)
 ;;=C92.90^^22^216^368
 ;;^UTILITY(U,$J,358.3,5038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5038,1,3,0)
 ;;=3^Myeloid Leukemia,Unspec,Not in Remission
 ;;^UTILITY(U,$J,358.3,5038,1,4,0)
 ;;=4^C92.90
 ;;^UTILITY(U,$J,358.3,5038,2)
 ;;=^5001810
 ;;^UTILITY(U,$J,358.3,5039,0)
 ;;=C92.91^^22^216^367
 ;;^UTILITY(U,$J,358.3,5039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5039,1,3,0)
 ;;=3^Myeloid Leukemia,Unspec,In Remission
 ;;^UTILITY(U,$J,358.3,5039,1,4,0)
 ;;=4^C92.91
 ;;^UTILITY(U,$J,358.3,5039,2)
 ;;=^5001811
 ;;^UTILITY(U,$J,358.3,5040,0)
 ;;=C92.92^^22^216^366
 ;;^UTILITY(U,$J,358.3,5040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5040,1,3,0)
 ;;=3^Myeloid Leukemia,Unspec,In Relapse
 ;;^UTILITY(U,$J,358.3,5040,1,4,0)
 ;;=4^C92.92
 ;;^UTILITY(U,$J,358.3,5040,2)
 ;;=^5001812
 ;;^UTILITY(U,$J,358.3,5041,0)
 ;;=C93.00^^22^216^15
 ;;^UTILITY(U,$J,358.3,5041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5041,1,3,0)
 ;;=3^Acute Monoblastic/Monocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5041,1,4,0)
 ;;=4^C93.00
 ;;^UTILITY(U,$J,358.3,5041,2)
 ;;=^5001819
 ;;^UTILITY(U,$J,358.3,5042,0)
 ;;=C93.01^^22^216^13
 ;;^UTILITY(U,$J,358.3,5042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5042,1,3,0)
 ;;=3^Acute Monoblastic/Monocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,5042,1,4,0)
 ;;=4^C93.01
 ;;^UTILITY(U,$J,358.3,5042,2)
 ;;=^5001820
 ;;^UTILITY(U,$J,358.3,5043,0)
 ;;=C93.02^^22^216^14
 ;;^UTILITY(U,$J,358.3,5043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5043,1,3,0)
 ;;=3^Acute Monoblastic/Monocytic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,5043,1,4,0)
 ;;=4^C93.02
 ;;^UTILITY(U,$J,358.3,5043,2)
 ;;=^5001821
 ;;^UTILITY(U,$J,358.3,5044,0)
 ;;=C93.10^^22^216^93
 ;;^UTILITY(U,$J,358.3,5044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5044,1,3,0)
 ;;=3^Chronic Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5044,1,4,0)
 ;;=4^C93.10
 ;;^UTILITY(U,$J,358.3,5044,2)
 ;;=^5001822
 ;;^UTILITY(U,$J,358.3,5045,0)
 ;;=C93.11^^22^216^92
 ;;^UTILITY(U,$J,358.3,5045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5045,1,3,0)
 ;;=3^Chronic Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,5045,1,4,0)
 ;;=4^C93.11
 ;;^UTILITY(U,$J,358.3,5045,2)
 ;;=^5001823
 ;;^UTILITY(U,$J,358.3,5046,0)
 ;;=C93.12^^22^216^91
 ;;^UTILITY(U,$J,358.3,5046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5046,1,3,0)
 ;;=3^Chronic Myelomonocytic Leukemia,In Relaspe
 ;;^UTILITY(U,$J,358.3,5046,1,4,0)
 ;;=4^C93.12
 ;;^UTILITY(U,$J,358.3,5046,2)
 ;;=^5001824
 ;;^UTILITY(U,$J,358.3,5047,0)
 ;;=C93.30^^22^216^238
 ;;^UTILITY(U,$J,358.3,5047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5047,1,3,0)
 ;;=3^Juvenile Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,5047,1,4,0)
 ;;=4^C93.30
 ;;^UTILITY(U,$J,358.3,5047,2)
 ;;=^5001825
 ;;^UTILITY(U,$J,358.3,5048,0)
 ;;=C93.31^^22^216^237
 ;;^UTILITY(U,$J,358.3,5048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5048,1,3,0)
 ;;=3^Juvenile Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,5048,1,4,0)
 ;;=4^C93.31
 ;;^UTILITY(U,$J,358.3,5048,2)
 ;;=^5001826
 ;;^UTILITY(U,$J,358.3,5049,0)
 ;;=C93.32^^22^216^236
 ;;^UTILITY(U,$J,358.3,5049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5049,1,3,0)
 ;;=3^Juvenile Myelomonocytic Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,5049,1,4,0)
 ;;=4^C93.32
 ;;^UTILITY(U,$J,358.3,5049,2)
 ;;=^5001827
 ;;^UTILITY(U,$J,358.3,5050,0)
 ;;=C93.Z0^^22^216^343
 ;;^UTILITY(U,$J,358.3,5050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5050,1,3,0)
 ;;=3^Monocytic Leukemia NEC,Not in Remission
 ;;^UTILITY(U,$J,358.3,5050,1,4,0)
 ;;=4^C93.Z0
 ;;^UTILITY(U,$J,358.3,5050,2)
 ;;=^5001831
 ;;^UTILITY(U,$J,358.3,5051,0)
 ;;=C93.Z1^^22^216^342
 ;;^UTILITY(U,$J,358.3,5051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5051,1,3,0)
 ;;=3^Monocytic Leukemia NEC,In Remission
