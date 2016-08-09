IBDEI0LZ ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22166,0)
 ;;=I34.1^^89^1045^14
 ;;^UTILITY(U,$J,358.3,22166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22166,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,22166,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,22166,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,22167,0)
 ;;=D68.4^^89^1046^1
 ;;^UTILITY(U,$J,358.3,22167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22167,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,22167,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,22167,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,22168,0)
 ;;=D59.9^^89^1046^2
 ;;^UTILITY(U,$J,358.3,22168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22168,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,22168,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,22168,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,22169,0)
 ;;=C91.00^^89^1046^5
 ;;^UTILITY(U,$J,358.3,22169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22169,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22169,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,22169,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,22170,0)
 ;;=C91.01^^89^1046^4
 ;;^UTILITY(U,$J,358.3,22170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22170,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22170,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,22170,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,22171,0)
 ;;=C92.01^^89^1046^7
 ;;^UTILITY(U,$J,358.3,22171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22171,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22171,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,22171,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,22172,0)
 ;;=C92.00^^89^1046^8
 ;;^UTILITY(U,$J,358.3,22172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22172,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22172,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,22172,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,22173,0)
 ;;=C92.61^^89^1046^9
 ;;^UTILITY(U,$J,358.3,22173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22173,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,22173,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,22173,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,22174,0)
 ;;=C92.60^^89^1046^10
 ;;^UTILITY(U,$J,358.3,22174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22174,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,22174,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,22174,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,22175,0)
 ;;=C92.A1^^89^1046^11
 ;;^UTILITY(U,$J,358.3,22175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22175,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,22175,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,22175,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,22176,0)
 ;;=C92.A0^^89^1046^12
 ;;^UTILITY(U,$J,358.3,22176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22176,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22176,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,22176,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,22177,0)
 ;;=C92.51^^89^1046^13
 ;;^UTILITY(U,$J,358.3,22177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22177,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22177,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,22177,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,22178,0)
 ;;=C92.50^^89^1046^14
 ;;^UTILITY(U,$J,358.3,22178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22178,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22178,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,22178,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,22179,0)
 ;;=C94.40^^89^1046^17
 ;;^UTILITY(U,$J,358.3,22179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22179,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,22179,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,22179,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,22180,0)
 ;;=C94.42^^89^1046^15
 ;;^UTILITY(U,$J,358.3,22180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22180,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,22180,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,22180,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,22181,0)
 ;;=C94.41^^89^1046^16
 ;;^UTILITY(U,$J,358.3,22181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22181,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,22181,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,22181,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,22182,0)
 ;;=D62.^^89^1046^18
 ;;^UTILITY(U,$J,358.3,22182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22182,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,22182,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,22182,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,22183,0)
 ;;=C92.41^^89^1046^19
 ;;^UTILITY(U,$J,358.3,22183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22183,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22183,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,22183,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,22184,0)
 ;;=C92.40^^89^1046^20
 ;;^UTILITY(U,$J,358.3,22184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22184,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22184,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,22184,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,22185,0)
 ;;=D56.0^^89^1046^21
 ;;^UTILITY(U,$J,358.3,22185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22185,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,22185,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,22185,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,22186,0)
 ;;=D63.1^^89^1046^23
 ;;^UTILITY(U,$J,358.3,22186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22186,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,22186,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,22186,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,22187,0)
 ;;=D63.0^^89^1046^24
 ;;^UTILITY(U,$J,358.3,22187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22187,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,22187,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,22187,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,22188,0)
 ;;=D63.8^^89^1046^22
 ;;^UTILITY(U,$J,358.3,22188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22188,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,22188,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,22188,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,22189,0)
 ;;=C22.3^^89^1046^26
 ;;^UTILITY(U,$J,358.3,22189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22189,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,22189,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,22189,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,22190,0)
 ;;=D61.9^^89^1046^27
 ;;^UTILITY(U,$J,358.3,22190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22190,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,22190,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,22190,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,22191,0)
 ;;=D56.1^^89^1046^29
 ;;^UTILITY(U,$J,358.3,22191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22191,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,22191,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,22191,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,22192,0)
 ;;=C83.79^^89^1046^31
 ;;^UTILITY(U,$J,358.3,22192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22192,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,22192,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,22192,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,22193,0)
 ;;=C83.70^^89^1046^32
 ;;^UTILITY(U,$J,358.3,22193,1,0)
 ;;=^358.31IA^4^2
