IBDEI12S ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39050,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,39050,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,39050,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,39051,0)
 ;;=I35.1^^148^1946^9
 ;;^UTILITY(U,$J,358.3,39051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39051,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,39051,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,39051,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,39052,0)
 ;;=I35.2^^148^1946^11
 ;;^UTILITY(U,$J,358.3,39052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39052,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,39052,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,39052,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,39053,0)
 ;;=I35.9^^148^1946^8
 ;;^UTILITY(U,$J,358.3,39053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39053,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,39053,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,39053,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,39054,0)
 ;;=I38.^^148^1946^4
 ;;^UTILITY(U,$J,358.3,39054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39054,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,39054,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,39054,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,39055,0)
 ;;=I05.0^^148^1946^18
 ;;^UTILITY(U,$J,358.3,39055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39055,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,39055,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,39055,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,39056,0)
 ;;=I05.8^^148^1946^19
 ;;^UTILITY(U,$J,358.3,39056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39056,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,39056,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,39056,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,39057,0)
 ;;=I05.9^^148^1946^20
 ;;^UTILITY(U,$J,358.3,39057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39057,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,39057,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,39057,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,39058,0)
 ;;=I07.1^^148^1946^21
 ;;^UTILITY(U,$J,358.3,39058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39058,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,39058,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,39058,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,39059,0)
 ;;=I07.9^^148^1946^22
 ;;^UTILITY(U,$J,358.3,39059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39059,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,39059,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,39059,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,39060,0)
 ;;=I08.0^^148^1946^16
 ;;^UTILITY(U,$J,358.3,39060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39060,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,39060,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,39060,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,39061,0)
 ;;=I09.89^^148^1946^17
 ;;^UTILITY(U,$J,358.3,39061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39061,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,39061,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,39061,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,39062,0)
 ;;=I47.1^^148^1946^24
 ;;^UTILITY(U,$J,358.3,39062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39062,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,39062,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,39062,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,39063,0)
 ;;=I48.0^^148^1946^15
 ;;^UTILITY(U,$J,358.3,39063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39063,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,39063,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,39063,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,39064,0)
 ;;=I49.5^^148^1946^23
 ;;^UTILITY(U,$J,358.3,39064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39064,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,39064,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,39064,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,39065,0)
 ;;=I49.8^^148^1946^3
 ;;^UTILITY(U,$J,358.3,39065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39065,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,39065,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,39065,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,39066,0)
 ;;=I49.9^^148^1946^2
 ;;^UTILITY(U,$J,358.3,39066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39066,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,39066,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,39066,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,39067,0)
 ;;=R00.1^^148^1946^1
 ;;^UTILITY(U,$J,358.3,39067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39067,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,39067,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,39067,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,39068,0)
 ;;=I34.1^^148^1946^14
 ;;^UTILITY(U,$J,358.3,39068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39068,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,39068,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,39068,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,39069,0)
 ;;=D68.4^^148^1947^1
 ;;^UTILITY(U,$J,358.3,39069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39069,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,39069,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,39069,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,39070,0)
 ;;=D59.9^^148^1947^2
 ;;^UTILITY(U,$J,358.3,39070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39070,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,39070,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,39070,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,39071,0)
 ;;=C91.00^^148^1947^5
 ;;^UTILITY(U,$J,358.3,39071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39071,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,39071,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,39071,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,39072,0)
 ;;=C91.01^^148^1947^4
 ;;^UTILITY(U,$J,358.3,39072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39072,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,39072,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,39072,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,39073,0)
 ;;=C92.01^^148^1947^7
 ;;^UTILITY(U,$J,358.3,39073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39073,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,39073,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,39073,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,39074,0)
 ;;=C92.00^^148^1947^8
 ;;^UTILITY(U,$J,358.3,39074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39074,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,39074,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,39074,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,39075,0)
 ;;=C92.61^^148^1947^9
 ;;^UTILITY(U,$J,358.3,39075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39075,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,39075,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,39075,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,39076,0)
 ;;=C92.60^^148^1947^10
 ;;^UTILITY(U,$J,358.3,39076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39076,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,39076,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,39076,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,39077,0)
 ;;=C92.A1^^148^1947^11
 ;;^UTILITY(U,$J,358.3,39077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39077,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,39077,1,4,0)
 ;;=4^C92.A1
