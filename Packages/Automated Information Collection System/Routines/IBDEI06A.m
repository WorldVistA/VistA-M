IBDEI06A ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15233,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,15233,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,15233,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,15234,0)
 ;;=I07.9^^56^643^22
 ;;^UTILITY(U,$J,358.3,15234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15234,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,15234,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,15234,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,15235,0)
 ;;=I08.0^^56^643^16
 ;;^UTILITY(U,$J,358.3,15235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15235,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,15235,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,15235,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,15236,0)
 ;;=I09.89^^56^643^17
 ;;^UTILITY(U,$J,358.3,15236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15236,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,15236,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,15236,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,15237,0)
 ;;=I47.1^^56^643^24
 ;;^UTILITY(U,$J,358.3,15237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15237,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,15237,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,15237,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,15238,0)
 ;;=I48.0^^56^643^15
 ;;^UTILITY(U,$J,358.3,15238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15238,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,15238,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,15238,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,15239,0)
 ;;=I49.5^^56^643^23
 ;;^UTILITY(U,$J,358.3,15239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15239,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,15239,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,15239,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,15240,0)
 ;;=I49.8^^56^643^3
 ;;^UTILITY(U,$J,358.3,15240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15240,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,15240,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,15240,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,15241,0)
 ;;=I49.9^^56^643^2
 ;;^UTILITY(U,$J,358.3,15241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15241,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,15241,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,15241,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,15242,0)
 ;;=R00.1^^56^643^1
 ;;^UTILITY(U,$J,358.3,15242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15242,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,15242,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,15242,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,15243,0)
 ;;=I34.1^^56^643^14
 ;;^UTILITY(U,$J,358.3,15243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15243,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,15243,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,15243,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,15244,0)
 ;;=D68.4^^56^644^1
 ;;^UTILITY(U,$J,358.3,15244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15244,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,15244,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,15244,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,15245,0)
 ;;=D59.9^^56^644^2
 ;;^UTILITY(U,$J,358.3,15245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15245,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,15245,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,15245,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,15246,0)
 ;;=C91.00^^56^644^5
 ;;^UTILITY(U,$J,358.3,15246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15246,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,15246,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,15246,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,15247,0)
 ;;=C91.01^^56^644^4
 ;;^UTILITY(U,$J,358.3,15247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15247,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,15247,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,15247,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,15248,0)
 ;;=C92.01^^56^644^7
 ;;^UTILITY(U,$J,358.3,15248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15248,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,15248,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,15248,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,15249,0)
 ;;=C92.00^^56^644^8
 ;;^UTILITY(U,$J,358.3,15249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15249,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,15249,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,15249,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,15250,0)
 ;;=C92.61^^56^644^9
 ;;^UTILITY(U,$J,358.3,15250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15250,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,15250,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,15250,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,15251,0)
 ;;=C92.60^^56^644^10
 ;;^UTILITY(U,$J,358.3,15251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15251,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,15251,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,15251,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,15252,0)
 ;;=C92.A1^^56^644^11
 ;;^UTILITY(U,$J,358.3,15252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15252,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,15252,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,15252,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,15253,0)
 ;;=C92.A0^^56^644^12
 ;;^UTILITY(U,$J,358.3,15253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15253,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,15253,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,15253,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,15254,0)
 ;;=C92.51^^56^644^13
 ;;^UTILITY(U,$J,358.3,15254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15254,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,15254,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,15254,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,15255,0)
 ;;=C92.50^^56^644^14
 ;;^UTILITY(U,$J,358.3,15255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15255,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,15255,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,15255,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,15256,0)
 ;;=C94.40^^56^644^17
 ;;^UTILITY(U,$J,358.3,15256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15256,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,15256,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,15256,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,15257,0)
 ;;=C94.42^^56^644^15
 ;;^UTILITY(U,$J,358.3,15257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15257,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,15257,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,15257,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,15258,0)
 ;;=C94.41^^56^644^16
 ;;^UTILITY(U,$J,358.3,15258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15258,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,15258,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,15258,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,15259,0)
 ;;=D62.^^56^644^18
 ;;^UTILITY(U,$J,358.3,15259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15259,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,15259,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,15259,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,15260,0)
 ;;=C92.41^^56^644^19
 ;;^UTILITY(U,$J,358.3,15260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15260,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,15260,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,15260,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,15261,0)
 ;;=C92.40^^56^644^20
 ;;^UTILITY(U,$J,358.3,15261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15261,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,15261,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,15261,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,15262,0)
 ;;=D56.0^^56^644^21
 ;;^UTILITY(U,$J,358.3,15262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15262,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,15262,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,15262,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,15263,0)
 ;;=D63.1^^56^644^23
 ;;^UTILITY(U,$J,358.3,15263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15263,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,15263,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,15263,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,15264,0)
 ;;=D63.0^^56^644^24
 ;;^UTILITY(U,$J,358.3,15264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15264,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,15264,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,15264,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,15265,0)
 ;;=D63.8^^56^644^22
 ;;^UTILITY(U,$J,358.3,15265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15265,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,15265,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,15265,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,15266,0)
 ;;=C22.3^^56^644^27
 ;;^UTILITY(U,$J,358.3,15266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15266,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,15266,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,15266,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,15267,0)
 ;;=D61.9^^56^644^28
 ;;^UTILITY(U,$J,358.3,15267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15267,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,15267,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,15267,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,15268,0)
 ;;=D56.1^^56^644^34
 ;;^UTILITY(U,$J,358.3,15268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15268,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,15268,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,15268,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,15269,0)
 ;;=C83.79^^56^644^36
 ;;^UTILITY(U,$J,358.3,15269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15269,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,15269,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,15269,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,15270,0)
 ;;=C83.70^^56^644^37
 ;;^UTILITY(U,$J,358.3,15270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15270,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,15270,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,15270,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,15271,0)
 ;;=D09.0^^56^644^44
 ;;^UTILITY(U,$J,358.3,15271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15271,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,15271,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,15271,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,15272,0)
 ;;=D06.9^^56^644^45
 ;;^UTILITY(U,$J,358.3,15272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15272,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,15272,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,15272,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,15273,0)
 ;;=D06.0^^56^644^47
 ;;^UTILITY(U,$J,358.3,15273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15273,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,15273,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,15273,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,15274,0)
 ;;=D06.1^^56^644^48
 ;;^UTILITY(U,$J,358.3,15274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15274,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,15274,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,15274,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,15275,0)
 ;;=D06.7^^56^644^46
 ;;^UTILITY(U,$J,358.3,15275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15275,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,15275,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,15275,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,15276,0)
 ;;=D04.9^^56^644^49
 ;;^UTILITY(U,$J,358.3,15276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15276,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,15276,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,15276,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,15277,0)
 ;;=C91.11^^56^644^52
 ;;^UTILITY(U,$J,358.3,15277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15277,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,15277,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,15277,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,15278,0)
 ;;=C91.10^^56^644^53
 ;;^UTILITY(U,$J,358.3,15278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15278,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,15278,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,15278,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,15279,0)
 ;;=C92.11^^56^644^54
 ;;^UTILITY(U,$J,358.3,15279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15279,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,15279,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,15279,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,15280,0)
 ;;=C92.10^^56^644^55
 ;;^UTILITY(U,$J,358.3,15280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15280,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,15280,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,15280,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,15281,0)
 ;;=D47.1^^56^644^56
 ;;^UTILITY(U,$J,358.3,15281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15281,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,15281,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,15281,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,15282,0)
 ;;=C82.69^^56^644^57
 ;;^UTILITY(U,$J,358.3,15282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15282,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,15282,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,15282,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,15283,0)
 ;;=C82.60^^56^644^58
 ;;^UTILITY(U,$J,358.3,15283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15283,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,15283,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,15283,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,15284,0)
 ;;=D56.2^^56^644^59
 ;;^UTILITY(U,$J,358.3,15284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15284,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,15284,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,15284,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,15285,0)
 ;;=D75.9^^56^644^60
 ;;^UTILITY(U,$J,358.3,15285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15285,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,15285,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,15285,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,15286,0)
 ;;=D59.0^^56^644^63
 ;;^UTILITY(U,$J,358.3,15286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15286,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,15286,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,15286,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,15287,0)
 ;;=D59.2^^56^644^64
 ;;^UTILITY(U,$J,358.3,15287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15287,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,15287,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,15287,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,15288,0)
 ;;=R59.9^^56^644^67
 ;;^UTILITY(U,$J,358.3,15288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15288,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,15288,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,15288,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,15289,0)
 ;;=D47.3^^56^644^68
 ;;^UTILITY(U,$J,358.3,15289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15289,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,15289,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,15289,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,15290,0)
 ;;=C82.09^^56^644^69
 ;;^UTILITY(U,$J,358.3,15290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15290,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,15290,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,15290,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,15291,0)
 ;;=C82.00^^56^644^70
 ;;^UTILITY(U,$J,358.3,15291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15291,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,15291,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,15291,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,15292,0)
 ;;=C82.19^^56^644^71
 ;;^UTILITY(U,$J,358.3,15292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15292,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,15292,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,15292,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,15293,0)
 ;;=C82.10^^56^644^72
 ;;^UTILITY(U,$J,358.3,15293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15293,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,15293,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,15293,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,15294,0)
 ;;=C82.29^^56^644^73
 ;;^UTILITY(U,$J,358.3,15294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15294,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,15294,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,15294,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,15295,0)
 ;;=C82.20^^56^644^74
 ;;^UTILITY(U,$J,358.3,15295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15295,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,15295,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,15295,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,15296,0)
 ;;=C82.39^^56^644^75
 ;;^UTILITY(U,$J,358.3,15296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15296,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,15296,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,15296,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,15297,0)
 ;;=C82.30^^56^644^76
 ;;^UTILITY(U,$J,358.3,15297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15297,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
 ;;^UTILITY(U,$J,358.3,15297,1,4,0)
 ;;=4^C82.30
 ;;^UTILITY(U,$J,358.3,15297,2)
 ;;=^5001491
 ;;^UTILITY(U,$J,358.3,15298,0)
 ;;=C82.49^^56^644^77
 ;;^UTILITY(U,$J,358.3,15298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15298,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,15298,1,4,0)
 ;;=4^C82.49
 ;;^UTILITY(U,$J,358.3,15298,2)
 ;;=^5001510
 ;;^UTILITY(U,$J,358.3,15299,0)
 ;;=C82.40^^56^644^78
 ;;^UTILITY(U,$J,358.3,15299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15299,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Unspec Site
 ;;^UTILITY(U,$J,358.3,15299,1,4,0)
 ;;=4^C82.40
 ;;^UTILITY(U,$J,358.3,15299,2)
 ;;=^5001501
 ;;^UTILITY(U,$J,358.3,15300,0)
 ;;=C82.99^^56^644^79
 ;;^UTILITY(U,$J,358.3,15300,1,0)
 ;;=^358.31IA^4^2
