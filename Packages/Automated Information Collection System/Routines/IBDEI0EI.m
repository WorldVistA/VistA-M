IBDEI0EI ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14506,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,14507,0)
 ;;=I07.1^^61^739^21
 ;;^UTILITY(U,$J,358.3,14507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14507,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,14507,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,14507,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,14508,0)
 ;;=I07.9^^61^739^22
 ;;^UTILITY(U,$J,358.3,14508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14508,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,14508,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,14508,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,14509,0)
 ;;=I08.0^^61^739^16
 ;;^UTILITY(U,$J,358.3,14509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14509,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,14509,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,14509,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,14510,0)
 ;;=I09.89^^61^739^17
 ;;^UTILITY(U,$J,358.3,14510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14510,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,14510,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,14510,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,14511,0)
 ;;=I47.1^^61^739^24
 ;;^UTILITY(U,$J,358.3,14511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14511,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,14511,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,14511,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,14512,0)
 ;;=I48.0^^61^739^15
 ;;^UTILITY(U,$J,358.3,14512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14512,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,14512,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,14512,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,14513,0)
 ;;=I49.5^^61^739^23
 ;;^UTILITY(U,$J,358.3,14513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14513,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,14513,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,14513,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,14514,0)
 ;;=I49.8^^61^739^3
 ;;^UTILITY(U,$J,358.3,14514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14514,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,14514,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,14514,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,14515,0)
 ;;=I49.9^^61^739^2
 ;;^UTILITY(U,$J,358.3,14515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14515,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,14515,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,14515,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,14516,0)
 ;;=R00.1^^61^739^1
 ;;^UTILITY(U,$J,358.3,14516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14516,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,14516,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,14516,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,14517,0)
 ;;=I34.1^^61^739^14
 ;;^UTILITY(U,$J,358.3,14517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14517,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,14517,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,14517,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,14518,0)
 ;;=D68.4^^61^740^1
 ;;^UTILITY(U,$J,358.3,14518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14518,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,14518,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,14518,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,14519,0)
 ;;=D59.9^^61^740^2
 ;;^UTILITY(U,$J,358.3,14519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14519,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,14519,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,14519,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,14520,0)
 ;;=C91.00^^61^740^5
 ;;^UTILITY(U,$J,358.3,14520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14520,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,14520,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,14520,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,14521,0)
 ;;=C91.01^^61^740^4
 ;;^UTILITY(U,$J,358.3,14521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14521,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,14521,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,14521,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,14522,0)
 ;;=C92.01^^61^740^7
 ;;^UTILITY(U,$J,358.3,14522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14522,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,14522,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,14522,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,14523,0)
 ;;=C92.00^^61^740^8
 ;;^UTILITY(U,$J,358.3,14523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14523,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,14523,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,14523,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,14524,0)
 ;;=C92.61^^61^740^9
 ;;^UTILITY(U,$J,358.3,14524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14524,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,14524,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,14524,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,14525,0)
 ;;=C92.60^^61^740^10
 ;;^UTILITY(U,$J,358.3,14525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14525,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,14525,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,14525,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,14526,0)
 ;;=C92.A1^^61^740^11
 ;;^UTILITY(U,$J,358.3,14526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14526,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,14526,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,14526,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,14527,0)
 ;;=C92.A0^^61^740^12
 ;;^UTILITY(U,$J,358.3,14527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14527,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,14527,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,14527,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,14528,0)
 ;;=C92.51^^61^740^13
 ;;^UTILITY(U,$J,358.3,14528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14528,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,14528,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,14528,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,14529,0)
 ;;=C92.50^^61^740^14
 ;;^UTILITY(U,$J,358.3,14529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14529,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,14529,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,14529,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,14530,0)
 ;;=C94.40^^61^740^17
 ;;^UTILITY(U,$J,358.3,14530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14530,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,14530,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,14530,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,14531,0)
 ;;=C94.42^^61^740^15
 ;;^UTILITY(U,$J,358.3,14531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14531,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,14531,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,14531,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,14532,0)
 ;;=C94.41^^61^740^16
 ;;^UTILITY(U,$J,358.3,14532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14532,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,14532,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,14532,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,14533,0)
 ;;=D62.^^61^740^18
 ;;^UTILITY(U,$J,358.3,14533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14533,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,14533,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,14533,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,14534,0)
 ;;=C92.41^^61^740^19
 ;;^UTILITY(U,$J,358.3,14534,1,0)
 ;;=^358.31IA^4^2
