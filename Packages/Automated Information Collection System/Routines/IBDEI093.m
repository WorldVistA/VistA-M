IBDEI093 ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22218,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,22218,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,22218,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,22219,0)
 ;;=I34.8^^71^913^6
 ;;^UTILITY(U,$J,358.3,22219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22219,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,22219,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,22219,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,22220,0)
 ;;=I34.0^^71^913^13
 ;;^UTILITY(U,$J,358.3,22220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22220,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,22220,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,22220,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,22221,0)
 ;;=I34.9^^71^913^12
 ;;^UTILITY(U,$J,358.3,22221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22221,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,22221,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,22221,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,22222,0)
 ;;=I34.2^^71^913^7
 ;;^UTILITY(U,$J,358.3,22222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22222,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,22222,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,22222,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,22223,0)
 ;;=I35.0^^71^913^10
 ;;^UTILITY(U,$J,358.3,22223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22223,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,22223,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,22223,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,22224,0)
 ;;=I35.1^^71^913^9
 ;;^UTILITY(U,$J,358.3,22224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22224,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,22224,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,22224,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,22225,0)
 ;;=I35.2^^71^913^11
 ;;^UTILITY(U,$J,358.3,22225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22225,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,22225,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,22225,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,22226,0)
 ;;=I35.9^^71^913^8
 ;;^UTILITY(U,$J,358.3,22226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22226,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,22226,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,22226,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,22227,0)
 ;;=I38.^^71^913^4
 ;;^UTILITY(U,$J,358.3,22227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22227,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,22227,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,22227,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,22228,0)
 ;;=I05.0^^71^913^18
 ;;^UTILITY(U,$J,358.3,22228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22228,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,22228,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,22228,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,22229,0)
 ;;=I05.8^^71^913^19
 ;;^UTILITY(U,$J,358.3,22229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22229,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,22229,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,22229,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,22230,0)
 ;;=I05.9^^71^913^20
 ;;^UTILITY(U,$J,358.3,22230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22230,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22230,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,22230,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,22231,0)
 ;;=I07.1^^71^913^21
 ;;^UTILITY(U,$J,358.3,22231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22231,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,22231,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,22231,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,22232,0)
 ;;=I07.9^^71^913^22
 ;;^UTILITY(U,$J,358.3,22232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22232,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22232,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,22232,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,22233,0)
 ;;=I08.0^^71^913^16
 ;;^UTILITY(U,$J,358.3,22233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22233,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,22233,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,22233,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,22234,0)
 ;;=I09.89^^71^913^17
 ;;^UTILITY(U,$J,358.3,22234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22234,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,22234,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,22234,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,22235,0)
 ;;=I47.1^^71^913^24
 ;;^UTILITY(U,$J,358.3,22235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22235,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,22235,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,22235,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,22236,0)
 ;;=I48.0^^71^913^15
 ;;^UTILITY(U,$J,358.3,22236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22236,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,22236,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,22236,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,22237,0)
 ;;=I49.5^^71^913^23
 ;;^UTILITY(U,$J,358.3,22237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22237,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,22237,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,22237,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,22238,0)
 ;;=I49.8^^71^913^3
 ;;^UTILITY(U,$J,358.3,22238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22238,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,22238,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,22238,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,22239,0)
 ;;=I49.9^^71^913^2
 ;;^UTILITY(U,$J,358.3,22239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22239,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,22239,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,22239,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,22240,0)
 ;;=R00.1^^71^913^1
 ;;^UTILITY(U,$J,358.3,22240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22240,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,22240,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,22240,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,22241,0)
 ;;=I34.1^^71^913^14
 ;;^UTILITY(U,$J,358.3,22241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22241,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,22241,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,22241,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,22242,0)
 ;;=D68.4^^71^914^1
 ;;^UTILITY(U,$J,358.3,22242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22242,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,22242,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,22242,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,22243,0)
 ;;=D59.9^^71^914^2
 ;;^UTILITY(U,$J,358.3,22243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22243,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,22243,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,22243,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,22244,0)
 ;;=C91.00^^71^914^5
 ;;^UTILITY(U,$J,358.3,22244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22244,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22244,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,22244,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,22245,0)
 ;;=C91.01^^71^914^4
 ;;^UTILITY(U,$J,358.3,22245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22245,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22245,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,22245,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,22246,0)
 ;;=C92.01^^71^914^7
 ;;^UTILITY(U,$J,358.3,22246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22246,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22246,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,22246,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,22247,0)
 ;;=C92.00^^71^914^8
 ;;^UTILITY(U,$J,358.3,22247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22247,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22247,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,22247,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,22248,0)
 ;;=C92.61^^71^914^9
 ;;^UTILITY(U,$J,358.3,22248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22248,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,22248,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,22248,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,22249,0)
 ;;=C92.60^^71^914^10
 ;;^UTILITY(U,$J,358.3,22249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22249,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,22249,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,22249,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,22250,0)
 ;;=C92.A1^^71^914^11
 ;;^UTILITY(U,$J,358.3,22250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22250,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,22250,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,22250,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,22251,0)
 ;;=C92.A0^^71^914^12
 ;;^UTILITY(U,$J,358.3,22251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22251,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22251,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,22251,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,22252,0)
 ;;=C92.51^^71^914^13
 ;;^UTILITY(U,$J,358.3,22252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22252,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22252,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,22252,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,22253,0)
 ;;=C92.50^^71^914^14
 ;;^UTILITY(U,$J,358.3,22253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22253,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22253,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,22253,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,22254,0)
 ;;=C94.40^^71^914^17
 ;;^UTILITY(U,$J,358.3,22254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22254,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,22254,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,22254,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,22255,0)
 ;;=C94.42^^71^914^15
 ;;^UTILITY(U,$J,358.3,22255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22255,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,22255,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,22255,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,22256,0)
 ;;=C94.41^^71^914^16
 ;;^UTILITY(U,$J,358.3,22256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22256,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,22256,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,22256,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,22257,0)
 ;;=D62.^^71^914^18
 ;;^UTILITY(U,$J,358.3,22257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22257,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,22257,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,22257,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,22258,0)
 ;;=C92.41^^71^914^19
 ;;^UTILITY(U,$J,358.3,22258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22258,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,22258,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,22258,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,22259,0)
 ;;=C92.40^^71^914^20
 ;;^UTILITY(U,$J,358.3,22259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22259,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,22259,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,22259,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,22260,0)
 ;;=D56.0^^71^914^21
 ;;^UTILITY(U,$J,358.3,22260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22260,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,22260,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,22260,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,22261,0)
 ;;=D63.1^^71^914^23
 ;;^UTILITY(U,$J,358.3,22261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22261,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,22261,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,22261,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,22262,0)
 ;;=D63.0^^71^914^24
 ;;^UTILITY(U,$J,358.3,22262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22262,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,22262,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,22262,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,22263,0)
 ;;=D63.8^^71^914^22
 ;;^UTILITY(U,$J,358.3,22263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22263,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,22263,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,22263,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,22264,0)
 ;;=C22.3^^71^914^27
 ;;^UTILITY(U,$J,358.3,22264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22264,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,22264,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,22264,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,22265,0)
 ;;=D61.9^^71^914^28
 ;;^UTILITY(U,$J,358.3,22265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22265,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,22265,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,22265,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,22266,0)
 ;;=D56.1^^71^914^34
 ;;^UTILITY(U,$J,358.3,22266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22266,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,22266,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,22266,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,22267,0)
 ;;=C83.79^^71^914^36
 ;;^UTILITY(U,$J,358.3,22267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22267,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,22267,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,22267,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,22268,0)
 ;;=C83.70^^71^914^37
 ;;^UTILITY(U,$J,358.3,22268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22268,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,22268,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,22268,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,22269,0)
 ;;=D09.0^^71^914^44
 ;;^UTILITY(U,$J,358.3,22269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22269,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,22269,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,22269,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,22270,0)
 ;;=D06.9^^71^914^45
 ;;^UTILITY(U,$J,358.3,22270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22270,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,22270,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,22270,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,22271,0)
 ;;=D06.0^^71^914^47
 ;;^UTILITY(U,$J,358.3,22271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22271,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,22271,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,22271,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,22272,0)
 ;;=D06.1^^71^914^48
 ;;^UTILITY(U,$J,358.3,22272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22272,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,22272,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,22272,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,22273,0)
 ;;=D06.7^^71^914^46
 ;;^UTILITY(U,$J,358.3,22273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22273,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,22273,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,22273,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,22274,0)
 ;;=D04.9^^71^914^49
 ;;^UTILITY(U,$J,358.3,22274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22274,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,22274,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,22274,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,22275,0)
 ;;=C91.11^^71^914^52
 ;;^UTILITY(U,$J,358.3,22275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22275,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,22275,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,22275,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,22276,0)
 ;;=C91.10^^71^914^53
 ;;^UTILITY(U,$J,358.3,22276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22276,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,22276,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,22276,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,22277,0)
 ;;=C92.11^^71^914^54
 ;;^UTILITY(U,$J,358.3,22277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22277,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,22277,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,22277,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,22278,0)
 ;;=C92.10^^71^914^55
 ;;^UTILITY(U,$J,358.3,22278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22278,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,22278,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,22278,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,22279,0)
 ;;=D47.1^^71^914^56
 ;;^UTILITY(U,$J,358.3,22279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22279,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,22279,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,22279,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,22280,0)
 ;;=C82.69^^71^914^57
 ;;^UTILITY(U,$J,358.3,22280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22280,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,22280,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,22280,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,22281,0)
 ;;=C82.60^^71^914^58
 ;;^UTILITY(U,$J,358.3,22281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22281,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,22281,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,22281,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,22282,0)
 ;;=D56.2^^71^914^59
 ;;^UTILITY(U,$J,358.3,22282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22282,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,22282,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,22282,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,22283,0)
 ;;=D75.9^^71^914^60
 ;;^UTILITY(U,$J,358.3,22283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22283,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,22283,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,22283,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,22284,0)
 ;;=D59.0^^71^914^63
 ;;^UTILITY(U,$J,358.3,22284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22284,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,22284,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,22284,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,22285,0)
 ;;=D59.2^^71^914^64
 ;;^UTILITY(U,$J,358.3,22285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22285,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
