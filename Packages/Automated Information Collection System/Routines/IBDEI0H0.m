IBDEI0H0 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21545,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,21545,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,21546,0)
 ;;=I08.0^^58^839^16
 ;;^UTILITY(U,$J,358.3,21546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21546,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,21546,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,21546,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,21547,0)
 ;;=I09.89^^58^839^17
 ;;^UTILITY(U,$J,358.3,21547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21547,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,21547,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,21547,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,21548,0)
 ;;=I47.1^^58^839^24
 ;;^UTILITY(U,$J,358.3,21548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21548,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,21548,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,21548,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,21549,0)
 ;;=I48.0^^58^839^15
 ;;^UTILITY(U,$J,358.3,21549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21549,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,21549,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,21549,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,21550,0)
 ;;=I49.5^^58^839^23
 ;;^UTILITY(U,$J,358.3,21550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21550,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,21550,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,21550,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,21551,0)
 ;;=I49.8^^58^839^3
 ;;^UTILITY(U,$J,358.3,21551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21551,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,21551,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,21551,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,21552,0)
 ;;=I49.9^^58^839^2
 ;;^UTILITY(U,$J,358.3,21552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21552,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,21552,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,21552,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,21553,0)
 ;;=R00.1^^58^839^1
 ;;^UTILITY(U,$J,358.3,21553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21553,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,21553,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,21553,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,21554,0)
 ;;=I34.1^^58^839^14
 ;;^UTILITY(U,$J,358.3,21554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21554,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,21554,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,21554,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,21555,0)
 ;;=D68.4^^58^840^1
 ;;^UTILITY(U,$J,358.3,21555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21555,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,21555,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,21555,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,21556,0)
 ;;=D59.9^^58^840^2
 ;;^UTILITY(U,$J,358.3,21556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21556,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,21556,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,21556,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,21557,0)
 ;;=C91.00^^58^840^5
 ;;^UTILITY(U,$J,358.3,21557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21557,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,21557,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,21557,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,21558,0)
 ;;=C91.01^^58^840^4
 ;;^UTILITY(U,$J,358.3,21558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21558,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,21558,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,21558,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,21559,0)
 ;;=C92.01^^58^840^7
 ;;^UTILITY(U,$J,358.3,21559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21559,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,21559,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,21559,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,21560,0)
 ;;=C92.00^^58^840^8
 ;;^UTILITY(U,$J,358.3,21560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21560,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,21560,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,21560,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,21561,0)
 ;;=C92.61^^58^840^9
 ;;^UTILITY(U,$J,358.3,21561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21561,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,21561,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,21561,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,21562,0)
 ;;=C92.60^^58^840^10
 ;;^UTILITY(U,$J,358.3,21562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21562,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,21562,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,21562,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,21563,0)
 ;;=C92.A1^^58^840^11
 ;;^UTILITY(U,$J,358.3,21563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21563,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,21563,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,21563,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,21564,0)
 ;;=C92.A0^^58^840^12
 ;;^UTILITY(U,$J,358.3,21564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21564,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,21564,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,21564,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,21565,0)
 ;;=C92.51^^58^840^13
 ;;^UTILITY(U,$J,358.3,21565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21565,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,21565,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,21565,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,21566,0)
 ;;=C92.50^^58^840^14
 ;;^UTILITY(U,$J,358.3,21566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21566,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,21566,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,21566,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,21567,0)
 ;;=C94.40^^58^840^17
 ;;^UTILITY(U,$J,358.3,21567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21567,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,21567,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,21567,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,21568,0)
 ;;=C94.42^^58^840^15
 ;;^UTILITY(U,$J,358.3,21568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21568,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,21568,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,21568,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,21569,0)
 ;;=C94.41^^58^840^16
 ;;^UTILITY(U,$J,358.3,21569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21569,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,21569,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,21569,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,21570,0)
 ;;=D62.^^58^840^18
 ;;^UTILITY(U,$J,358.3,21570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21570,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,21570,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,21570,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,21571,0)
 ;;=C92.41^^58^840^19
 ;;^UTILITY(U,$J,358.3,21571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21571,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,21571,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,21571,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,21572,0)
 ;;=C92.40^^58^840^20
 ;;^UTILITY(U,$J,358.3,21572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21572,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,21572,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,21572,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,21573,0)
 ;;=D56.0^^58^840^21
 ;;^UTILITY(U,$J,358.3,21573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21573,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,21573,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,21573,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,21574,0)
 ;;=D63.1^^58^840^23
 ;;^UTILITY(U,$J,358.3,21574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21574,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,21574,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,21574,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,21575,0)
 ;;=D63.0^^58^840^24
 ;;^UTILITY(U,$J,358.3,21575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21575,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,21575,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,21575,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,21576,0)
 ;;=D63.8^^58^840^22
 ;;^UTILITY(U,$J,358.3,21576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21576,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,21576,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,21576,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,21577,0)
 ;;=C22.3^^58^840^26
 ;;^UTILITY(U,$J,358.3,21577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21577,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,21577,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,21577,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,21578,0)
 ;;=D61.9^^58^840^27
 ;;^UTILITY(U,$J,358.3,21578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21578,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,21578,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,21578,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,21579,0)
 ;;=D56.1^^58^840^29
 ;;^UTILITY(U,$J,358.3,21579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21579,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,21579,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,21579,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,21580,0)
 ;;=C83.79^^58^840^31
 ;;^UTILITY(U,$J,358.3,21580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21580,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,21580,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,21580,2)
 ;;=^5001600
