IBDEI0Q7 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34680,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,34680,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,34681,0)
 ;;=I35.2^^100^1506^11
 ;;^UTILITY(U,$J,358.3,34681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34681,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,34681,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,34681,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,34682,0)
 ;;=I35.9^^100^1506^8
 ;;^UTILITY(U,$J,358.3,34682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34682,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,34682,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,34682,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,34683,0)
 ;;=I38.^^100^1506^4
 ;;^UTILITY(U,$J,358.3,34683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34683,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,34683,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,34683,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,34684,0)
 ;;=I05.0^^100^1506^18
 ;;^UTILITY(U,$J,358.3,34684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34684,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,34684,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,34684,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,34685,0)
 ;;=I05.8^^100^1506^19
 ;;^UTILITY(U,$J,358.3,34685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34685,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,34685,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,34685,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,34686,0)
 ;;=I05.9^^100^1506^20
 ;;^UTILITY(U,$J,358.3,34686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34686,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,34686,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,34686,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,34687,0)
 ;;=I07.1^^100^1506^21
 ;;^UTILITY(U,$J,358.3,34687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34687,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,34687,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,34687,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,34688,0)
 ;;=I07.9^^100^1506^22
 ;;^UTILITY(U,$J,358.3,34688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34688,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,34688,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,34688,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,34689,0)
 ;;=I08.0^^100^1506^16
 ;;^UTILITY(U,$J,358.3,34689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34689,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,34689,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,34689,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,34690,0)
 ;;=I09.89^^100^1506^17
 ;;^UTILITY(U,$J,358.3,34690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34690,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,34690,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,34690,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,34691,0)
 ;;=I47.1^^100^1506^24
 ;;^UTILITY(U,$J,358.3,34691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34691,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,34691,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,34691,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,34692,0)
 ;;=I48.0^^100^1506^15
 ;;^UTILITY(U,$J,358.3,34692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34692,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,34692,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,34692,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,34693,0)
 ;;=I49.5^^100^1506^23
 ;;^UTILITY(U,$J,358.3,34693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34693,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,34693,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,34693,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,34694,0)
 ;;=I49.8^^100^1506^3
 ;;^UTILITY(U,$J,358.3,34694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34694,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,34694,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,34694,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,34695,0)
 ;;=I49.9^^100^1506^2
 ;;^UTILITY(U,$J,358.3,34695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34695,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,34695,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,34695,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,34696,0)
 ;;=R00.1^^100^1506^1
 ;;^UTILITY(U,$J,358.3,34696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34696,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,34696,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,34696,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,34697,0)
 ;;=I34.1^^100^1506^14
 ;;^UTILITY(U,$J,358.3,34697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34697,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,34697,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,34697,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,34698,0)
 ;;=D68.4^^100^1507^1
 ;;^UTILITY(U,$J,358.3,34698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34698,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,34698,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,34698,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,34699,0)
 ;;=D59.9^^100^1507^2
 ;;^UTILITY(U,$J,358.3,34699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34699,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,34699,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,34699,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,34700,0)
 ;;=C91.00^^100^1507^5
 ;;^UTILITY(U,$J,358.3,34700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34700,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,34700,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,34700,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,34701,0)
 ;;=C91.01^^100^1507^4
 ;;^UTILITY(U,$J,358.3,34701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34701,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,34701,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,34701,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,34702,0)
 ;;=C92.01^^100^1507^7
 ;;^UTILITY(U,$J,358.3,34702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34702,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,34702,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,34702,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,34703,0)
 ;;=C92.00^^100^1507^8
 ;;^UTILITY(U,$J,358.3,34703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34703,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,34703,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,34703,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,34704,0)
 ;;=C92.61^^100^1507^9
 ;;^UTILITY(U,$J,358.3,34704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34704,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,34704,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,34704,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,34705,0)
 ;;=C92.60^^100^1507^10
 ;;^UTILITY(U,$J,358.3,34705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34705,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,34705,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,34705,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,34706,0)
 ;;=C92.A1^^100^1507^11
 ;;^UTILITY(U,$J,358.3,34706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34706,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,34706,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,34706,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,34707,0)
 ;;=C92.A0^^100^1507^12
 ;;^UTILITY(U,$J,358.3,34707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34707,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,34707,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,34707,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,34708,0)
 ;;=C92.51^^100^1507^13
 ;;^UTILITY(U,$J,358.3,34708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34708,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,34708,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,34708,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,34709,0)
 ;;=C92.50^^100^1507^14
 ;;^UTILITY(U,$J,358.3,34709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34709,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,34709,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,34709,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,34710,0)
 ;;=C94.40^^100^1507^17
 ;;^UTILITY(U,$J,358.3,34710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34710,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,34710,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,34710,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,34711,0)
 ;;=C94.42^^100^1507^15
 ;;^UTILITY(U,$J,358.3,34711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34711,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,34711,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,34711,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,34712,0)
 ;;=C94.41^^100^1507^16
 ;;^UTILITY(U,$J,358.3,34712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34712,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,34712,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,34712,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,34713,0)
 ;;=D62.^^100^1507^18
 ;;^UTILITY(U,$J,358.3,34713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34713,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,34713,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,34713,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,34714,0)
 ;;=C92.41^^100^1507^19
 ;;^UTILITY(U,$J,358.3,34714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34714,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,34714,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,34714,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,34715,0)
 ;;=C92.40^^100^1507^20
 ;;^UTILITY(U,$J,358.3,34715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34715,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
