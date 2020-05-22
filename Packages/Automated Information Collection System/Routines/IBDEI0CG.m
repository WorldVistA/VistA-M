IBDEI0CG ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30482,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,30483,0)
 ;;=I35.1^^92^1204^9
 ;;^UTILITY(U,$J,358.3,30483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30483,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,30483,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,30483,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,30484,0)
 ;;=I35.2^^92^1204^11
 ;;^UTILITY(U,$J,358.3,30484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30484,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,30484,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,30484,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,30485,0)
 ;;=I35.9^^92^1204^8
 ;;^UTILITY(U,$J,358.3,30485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30485,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30485,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,30485,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,30486,0)
 ;;=I38.^^92^1204^4
 ;;^UTILITY(U,$J,358.3,30486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30486,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,30486,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,30486,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,30487,0)
 ;;=I05.0^^92^1204^18
 ;;^UTILITY(U,$J,358.3,30487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30487,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,30487,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,30487,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,30488,0)
 ;;=I05.8^^92^1204^19
 ;;^UTILITY(U,$J,358.3,30488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30488,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,30488,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,30488,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,30489,0)
 ;;=I05.9^^92^1204^20
 ;;^UTILITY(U,$J,358.3,30489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30489,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,30489,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,30489,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,30490,0)
 ;;=I07.1^^92^1204^21
 ;;^UTILITY(U,$J,358.3,30490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30490,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,30490,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,30490,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,30491,0)
 ;;=I07.9^^92^1204^22
 ;;^UTILITY(U,$J,358.3,30491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30491,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,30491,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,30491,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,30492,0)
 ;;=I08.0^^92^1204^16
 ;;^UTILITY(U,$J,358.3,30492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30492,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,30492,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,30492,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,30493,0)
 ;;=I09.89^^92^1204^17
 ;;^UTILITY(U,$J,358.3,30493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30493,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,30493,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,30493,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,30494,0)
 ;;=I47.1^^92^1204^24
 ;;^UTILITY(U,$J,358.3,30494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30494,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,30494,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,30494,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,30495,0)
 ;;=I48.0^^92^1204^15
 ;;^UTILITY(U,$J,358.3,30495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30495,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,30495,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,30495,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,30496,0)
 ;;=I49.5^^92^1204^23
 ;;^UTILITY(U,$J,358.3,30496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30496,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,30496,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,30496,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,30497,0)
 ;;=I49.8^^92^1204^3
 ;;^UTILITY(U,$J,358.3,30497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30497,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,30497,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,30497,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,30498,0)
 ;;=I49.9^^92^1204^2
 ;;^UTILITY(U,$J,358.3,30498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30498,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,30498,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,30498,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,30499,0)
 ;;=R00.1^^92^1204^1
 ;;^UTILITY(U,$J,358.3,30499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30499,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,30499,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,30499,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,30500,0)
 ;;=I34.1^^92^1204^14
 ;;^UTILITY(U,$J,358.3,30500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30500,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,30500,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,30500,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,30501,0)
 ;;=D68.4^^92^1205^1
 ;;^UTILITY(U,$J,358.3,30501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30501,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,30501,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,30501,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,30502,0)
 ;;=D59.9^^92^1205^2
 ;;^UTILITY(U,$J,358.3,30502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30502,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,30502,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,30502,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,30503,0)
 ;;=C91.00^^92^1205^5
 ;;^UTILITY(U,$J,358.3,30503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30503,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,30503,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,30503,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,30504,0)
 ;;=C91.01^^92^1205^4
 ;;^UTILITY(U,$J,358.3,30504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30504,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,30504,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,30504,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,30505,0)
 ;;=C92.01^^92^1205^7
 ;;^UTILITY(U,$J,358.3,30505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30505,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,30505,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,30505,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,30506,0)
 ;;=C92.00^^92^1205^8
 ;;^UTILITY(U,$J,358.3,30506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30506,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,30506,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,30506,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,30507,0)
 ;;=C92.61^^92^1205^9
 ;;^UTILITY(U,$J,358.3,30507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30507,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,30507,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,30507,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,30508,0)
 ;;=C92.60^^92^1205^10
 ;;^UTILITY(U,$J,358.3,30508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30508,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,30508,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,30508,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,30509,0)
 ;;=C92.A1^^92^1205^11
 ;;^UTILITY(U,$J,358.3,30509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30509,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,30509,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,30509,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,30510,0)
 ;;=C92.A0^^92^1205^12
 ;;^UTILITY(U,$J,358.3,30510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30510,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,30510,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,30510,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,30511,0)
 ;;=C92.51^^92^1205^13
 ;;^UTILITY(U,$J,358.3,30511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30511,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,30511,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,30511,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,30512,0)
 ;;=C92.50^^92^1205^14
 ;;^UTILITY(U,$J,358.3,30512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30512,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,30512,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,30512,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,30513,0)
 ;;=C94.40^^92^1205^17
 ;;^UTILITY(U,$J,358.3,30513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30513,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,30513,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,30513,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,30514,0)
 ;;=C94.42^^92^1205^15
 ;;^UTILITY(U,$J,358.3,30514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30514,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,30514,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,30514,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,30515,0)
 ;;=C94.41^^92^1205^16
 ;;^UTILITY(U,$J,358.3,30515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30515,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,30515,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,30515,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,30516,0)
 ;;=D62.^^92^1205^18
 ;;^UTILITY(U,$J,358.3,30516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30516,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,30516,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,30516,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,30517,0)
 ;;=C92.41^^92^1205^19
 ;;^UTILITY(U,$J,358.3,30517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30517,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,30517,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,30517,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,30518,0)
 ;;=C92.40^^92^1205^20
 ;;^UTILITY(U,$J,358.3,30518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30518,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,30518,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,30518,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,30519,0)
 ;;=D56.0^^92^1205^21
 ;;^UTILITY(U,$J,358.3,30519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30519,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,30519,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,30519,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,30520,0)
 ;;=D63.1^^92^1205^23
 ;;^UTILITY(U,$J,358.3,30520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30520,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,30520,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,30520,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,30521,0)
 ;;=D63.0^^92^1205^24
 ;;^UTILITY(U,$J,358.3,30521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30521,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,30521,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,30521,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,30522,0)
 ;;=D63.8^^92^1205^22
 ;;^UTILITY(U,$J,358.3,30522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30522,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,30522,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,30522,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,30523,0)
 ;;=C22.3^^92^1205^27
 ;;^UTILITY(U,$J,358.3,30523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30523,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,30523,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,30523,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,30524,0)
 ;;=D61.9^^92^1205^28
 ;;^UTILITY(U,$J,358.3,30524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30524,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,30524,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,30524,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,30525,0)
 ;;=D56.1^^92^1205^30
 ;;^UTILITY(U,$J,358.3,30525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30525,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,30525,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,30525,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,30526,0)
 ;;=C83.79^^92^1205^32
 ;;^UTILITY(U,$J,358.3,30526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30526,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,30526,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,30526,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,30527,0)
 ;;=C83.70^^92^1205^33
 ;;^UTILITY(U,$J,358.3,30527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30527,1,3,0)
 ;;=3^Burkitt Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,30527,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,30527,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,30528,0)
 ;;=D09.0^^92^1205^40
 ;;^UTILITY(U,$J,358.3,30528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30528,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,30528,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,30528,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,30529,0)
 ;;=D06.9^^92^1205^41
 ;;^UTILITY(U,$J,358.3,30529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30529,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix
 ;;^UTILITY(U,$J,358.3,30529,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,30529,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,30530,0)
 ;;=D06.0^^92^1205^43
 ;;^UTILITY(U,$J,358.3,30530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30530,1,3,0)
 ;;=3^Carcinoma in Situ of Endocervix
 ;;^UTILITY(U,$J,358.3,30530,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,30530,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,30531,0)
 ;;=D06.1^^92^1205^44
 ;;^UTILITY(U,$J,358.3,30531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30531,1,3,0)
 ;;=3^Carcinoma in Situ of Exocervix
 ;;^UTILITY(U,$J,358.3,30531,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,30531,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,30532,0)
 ;;=D06.7^^92^1205^42
 ;;^UTILITY(U,$J,358.3,30532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30532,1,3,0)
 ;;=3^Carcinoma in Situ of Cervix,Other Parts
 ;;^UTILITY(U,$J,358.3,30532,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,30532,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,30533,0)
 ;;=D04.9^^92^1205^45
 ;;^UTILITY(U,$J,358.3,30533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30533,1,3,0)
 ;;=3^Carcinoma in Situ of Skin
 ;;^UTILITY(U,$J,358.3,30533,1,4,0)
 ;;=4^D04.9
 ;;^UTILITY(U,$J,358.3,30533,2)
 ;;=^5001925
 ;;^UTILITY(U,$J,358.3,30534,0)
 ;;=C91.11^^92^1205^48
 ;;^UTILITY(U,$J,358.3,30534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30534,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,In Remission
 ;;^UTILITY(U,$J,358.3,30534,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,30534,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,30535,0)
 ;;=C91.10^^92^1205^49
 ;;^UTILITY(U,$J,358.3,30535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30535,1,3,0)
 ;;=3^Chronic Lymphocytic Leukemia of B-Cell Type,Not in Remission
 ;;^UTILITY(U,$J,358.3,30535,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,30535,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,30536,0)
 ;;=C92.11^^92^1205^50
 ;;^UTILITY(U,$J,358.3,30536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30536,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,In Remission
 ;;^UTILITY(U,$J,358.3,30536,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,30536,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,30537,0)
 ;;=C92.10^^92^1205^51
 ;;^UTILITY(U,$J,358.3,30537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30537,1,3,0)
 ;;=3^Chronic Myeloid Leukemia,BCR/ABL-Positive,Not in Remission
 ;;^UTILITY(U,$J,358.3,30537,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,30537,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,30538,0)
 ;;=D47.1^^92^1205^52
 ;;^UTILITY(U,$J,358.3,30538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30538,1,3,0)
 ;;=3^Chronic Myeloproliferative Disease
 ;;^UTILITY(U,$J,358.3,30538,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,30538,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,30539,0)
 ;;=C82.69^^92^1205^53
 ;;^UTILITY(U,$J,358.3,30539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30539,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,30539,1,4,0)
 ;;=4^C82.69
 ;;^UTILITY(U,$J,358.3,30539,2)
 ;;=^5001530
 ;;^UTILITY(U,$J,358.3,30540,0)
 ;;=C82.60^^92^1205^54
 ;;^UTILITY(U,$J,358.3,30540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30540,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,30540,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,30540,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,30541,0)
 ;;=D56.2^^92^1205^55
 ;;^UTILITY(U,$J,358.3,30541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30541,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,30541,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,30541,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,30542,0)
 ;;=D75.9^^92^1205^56
 ;;^UTILITY(U,$J,358.3,30542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30542,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,30542,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,30542,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,30543,0)
 ;;=D59.0^^92^1205^59
 ;;^UTILITY(U,$J,358.3,30543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30543,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,30543,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,30543,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,30544,0)
 ;;=D59.2^^92^1205^60
 ;;^UTILITY(U,$J,358.3,30544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30544,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,30544,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,30544,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,30545,0)
 ;;=R59.9^^92^1205^63
 ;;^UTILITY(U,$J,358.3,30545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30545,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,30545,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,30545,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,30546,0)
 ;;=D47.3^^92^1205^64
 ;;^UTILITY(U,$J,358.3,30546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30546,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,30546,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,30546,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,30547,0)
 ;;=C82.09^^92^1205^65
 ;;^UTILITY(U,$J,358.3,30547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30547,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,30547,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,30547,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,30548,0)
 ;;=C82.00^^92^1205^66
 ;;^UTILITY(U,$J,358.3,30548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30548,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,30548,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,30548,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,30549,0)
 ;;=C82.19^^92^1205^67
 ;;^UTILITY(U,$J,358.3,30549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30549,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,30549,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,30549,2)
 ;;=^5001480
