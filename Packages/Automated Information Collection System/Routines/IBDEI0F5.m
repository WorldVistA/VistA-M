IBDEI0F5 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19146,0)
 ;;=I34.8^^55^787^6
 ;;^UTILITY(U,$J,358.3,19146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19146,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,19146,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,19146,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,19147,0)
 ;;=I34.0^^55^787^13
 ;;^UTILITY(U,$J,358.3,19147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19147,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,19147,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,19147,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,19148,0)
 ;;=I34.9^^55^787^12
 ;;^UTILITY(U,$J,358.3,19148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19148,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,19148,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,19148,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,19149,0)
 ;;=I34.2^^55^787^7
 ;;^UTILITY(U,$J,358.3,19149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19149,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,19149,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,19149,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,19150,0)
 ;;=I35.0^^55^787^10
 ;;^UTILITY(U,$J,358.3,19150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19150,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,19150,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,19150,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,19151,0)
 ;;=I35.1^^55^787^9
 ;;^UTILITY(U,$J,358.3,19151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19151,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,19151,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,19151,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,19152,0)
 ;;=I35.2^^55^787^11
 ;;^UTILITY(U,$J,358.3,19152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19152,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,19152,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,19152,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,19153,0)
 ;;=I35.9^^55^787^8
 ;;^UTILITY(U,$J,358.3,19153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19153,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,19153,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,19153,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,19154,0)
 ;;=I38.^^55^787^4
 ;;^UTILITY(U,$J,358.3,19154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19154,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,19154,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,19154,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,19155,0)
 ;;=I05.0^^55^787^18
 ;;^UTILITY(U,$J,358.3,19155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19155,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,19155,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,19155,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,19156,0)
 ;;=I05.8^^55^787^19
 ;;^UTILITY(U,$J,358.3,19156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19156,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,19156,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,19156,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,19157,0)
 ;;=I05.9^^55^787^20
 ;;^UTILITY(U,$J,358.3,19157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19157,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,19157,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,19157,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,19158,0)
 ;;=I07.1^^55^787^21
 ;;^UTILITY(U,$J,358.3,19158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19158,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,19158,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,19158,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,19159,0)
 ;;=I07.9^^55^787^22
 ;;^UTILITY(U,$J,358.3,19159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19159,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,19159,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,19159,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,19160,0)
 ;;=I08.0^^55^787^16
 ;;^UTILITY(U,$J,358.3,19160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19160,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,19160,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,19160,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,19161,0)
 ;;=I09.89^^55^787^17
 ;;^UTILITY(U,$J,358.3,19161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19161,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,19161,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,19161,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,19162,0)
 ;;=I47.1^^55^787^24
 ;;^UTILITY(U,$J,358.3,19162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19162,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,19162,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,19162,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,19163,0)
 ;;=I48.0^^55^787^15
 ;;^UTILITY(U,$J,358.3,19163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19163,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,19163,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,19163,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,19164,0)
 ;;=I49.5^^55^787^23
 ;;^UTILITY(U,$J,358.3,19164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19164,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,19164,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,19164,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,19165,0)
 ;;=I49.8^^55^787^3
 ;;^UTILITY(U,$J,358.3,19165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19165,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,19165,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,19165,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,19166,0)
 ;;=I49.9^^55^787^2
 ;;^UTILITY(U,$J,358.3,19166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19166,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,19166,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,19166,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,19167,0)
 ;;=R00.1^^55^787^1
 ;;^UTILITY(U,$J,358.3,19167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19167,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,19167,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,19167,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,19168,0)
 ;;=I34.1^^55^787^14
 ;;^UTILITY(U,$J,358.3,19168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19168,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,19168,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,19168,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,19169,0)
 ;;=D68.4^^55^788^1
 ;;^UTILITY(U,$J,358.3,19169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19169,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,19169,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,19169,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,19170,0)
 ;;=D59.9^^55^788^2
 ;;^UTILITY(U,$J,358.3,19170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19170,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,19170,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,19170,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,19171,0)
 ;;=C91.00^^55^788^5
 ;;^UTILITY(U,$J,358.3,19171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19171,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,19171,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,19171,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,19172,0)
 ;;=C91.01^^55^788^4
 ;;^UTILITY(U,$J,358.3,19172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19172,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,19172,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,19172,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,19173,0)
 ;;=C92.01^^55^788^7
 ;;^UTILITY(U,$J,358.3,19173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19173,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,19173,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,19173,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,19174,0)
 ;;=C92.00^^55^788^8
 ;;^UTILITY(U,$J,358.3,19174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19174,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,19174,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,19174,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,19175,0)
 ;;=C92.61^^55^788^9
 ;;^UTILITY(U,$J,358.3,19175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19175,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,19175,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,19175,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,19176,0)
 ;;=C92.60^^55^788^10
 ;;^UTILITY(U,$J,358.3,19176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19176,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,19176,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,19176,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,19177,0)
 ;;=C92.A1^^55^788^11
 ;;^UTILITY(U,$J,358.3,19177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19177,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,19177,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,19177,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,19178,0)
 ;;=C92.A0^^55^788^12
 ;;^UTILITY(U,$J,358.3,19178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19178,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,19178,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,19178,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,19179,0)
 ;;=C92.51^^55^788^13
 ;;^UTILITY(U,$J,358.3,19179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19179,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,19179,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,19179,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,19180,0)
 ;;=C92.50^^55^788^14
 ;;^UTILITY(U,$J,358.3,19180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19180,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,19180,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,19180,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,19181,0)
 ;;=C94.40^^55^788^17
