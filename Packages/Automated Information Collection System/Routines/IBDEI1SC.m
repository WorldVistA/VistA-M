IBDEI1SC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29890,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,29890,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,29891,0)
 ;;=I08.0^^135^1371^16
 ;;^UTILITY(U,$J,358.3,29891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29891,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,29891,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,29891,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,29892,0)
 ;;=I09.89^^135^1371^17
 ;;^UTILITY(U,$J,358.3,29892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29892,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,29892,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,29892,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,29893,0)
 ;;=I47.1^^135^1371^24
 ;;^UTILITY(U,$J,358.3,29893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29893,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,29893,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,29893,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,29894,0)
 ;;=I48.0^^135^1371^15
 ;;^UTILITY(U,$J,358.3,29894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29894,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,29894,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,29894,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,29895,0)
 ;;=I49.5^^135^1371^23
 ;;^UTILITY(U,$J,358.3,29895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29895,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,29895,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,29895,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,29896,0)
 ;;=I49.8^^135^1371^3
 ;;^UTILITY(U,$J,358.3,29896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29896,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,29896,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,29896,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,29897,0)
 ;;=I49.9^^135^1371^2
 ;;^UTILITY(U,$J,358.3,29897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29897,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,29897,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,29897,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,29898,0)
 ;;=R00.1^^135^1371^1
 ;;^UTILITY(U,$J,358.3,29898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29898,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,29898,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,29898,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,29899,0)
 ;;=I34.1^^135^1371^14
 ;;^UTILITY(U,$J,358.3,29899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29899,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,29899,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,29899,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,29900,0)
 ;;=D68.4^^135^1372^1
 ;;^UTILITY(U,$J,358.3,29900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29900,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,29900,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,29900,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,29901,0)
 ;;=D59.9^^135^1372^2
 ;;^UTILITY(U,$J,358.3,29901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29901,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,29901,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,29901,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,29902,0)
 ;;=C91.00^^135^1372^5
 ;;^UTILITY(U,$J,358.3,29902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29902,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,29902,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,29902,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,29903,0)
 ;;=C91.01^^135^1372^4
 ;;^UTILITY(U,$J,358.3,29903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29903,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,29903,1,4,0)
 ;;=4^C91.01