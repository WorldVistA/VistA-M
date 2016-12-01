IBDEI01M ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1567,0)
 ;;=I31.0^^8^122^4
 ;;^UTILITY(U,$J,358.3,1567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1567,1,3,0)
 ;;=3^Adhesive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,1567,1,4,0)
 ;;=4^I31.0
 ;;^UTILITY(U,$J,358.3,1567,2)
 ;;=^5007161
 ;;^UTILITY(U,$J,358.3,1568,0)
 ;;=I31.1^^8^122^6
 ;;^UTILITY(U,$J,358.3,1568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1568,1,3,0)
 ;;=3^Constrictive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,1568,1,4,0)
 ;;=4^I31.1
 ;;^UTILITY(U,$J,358.3,1568,2)
 ;;=^5007162
 ;;^UTILITY(U,$J,358.3,1569,0)
 ;;=E78.0^^8^123^5
 ;;^UTILITY(U,$J,358.3,1569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1569,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,1569,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,1569,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,1570,0)
 ;;=E78.1^^8^123^6
 ;;^UTILITY(U,$J,358.3,1570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1570,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,1570,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,1570,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,1571,0)
 ;;=E78.2^^8^123^4
 ;;^UTILITY(U,$J,358.3,1571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1571,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,1571,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,1571,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,1572,0)
 ;;=E78.4^^8^123^1
 ;;^UTILITY(U,$J,358.3,1572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1572,1,3,0)
 ;;=3^Hyperlipidemia NEC
 ;;^UTILITY(U,$J,358.3,1572,1,4,0)
 ;;=4^E78.4
 ;;^UTILITY(U,$J,358.3,1572,2)
 ;;=^5002968
 ;;^UTILITY(U,$J,358.3,1573,0)
 ;;=E78.5^^8^123^2
 ;;^UTILITY(U,$J,358.3,1573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1573,1,3,0)
 ;;=3^Hyperlipidemia,Unspec
 ;;^UTILITY(U,$J,358.3,1573,1,4,0)
 ;;=4^E78.5
 ;;^UTILITY(U,$J,358.3,1573,2)
 ;;=^5002969
 ;;^UTILITY(U,$J,358.3,1574,0)
 ;;=E78.6^^8^123^3
 ;;^UTILITY(U,$J,358.3,1574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1574,1,3,0)
 ;;=3^Lipoprotein Deficiency
 ;;^UTILITY(U,$J,358.3,1574,1,4,0)
 ;;=4^E78.6
 ;;^UTILITY(U,$J,358.3,1574,2)
 ;;=^5002970
 ;;^UTILITY(U,$J,358.3,1575,0)
 ;;=I22.0^^8^124^7
 ;;^UTILITY(U,$J,358.3,1575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1575,1,3,0)
 ;;=3^Subsequent STEMI of Anterior Wall
 ;;^UTILITY(U,$J,358.3,1575,1,4,0)
 ;;=4^I22.0
 ;;^UTILITY(U,$J,358.3,1575,2)
 ;;=^5007089
 ;;^UTILITY(U,$J,358.3,1576,0)
 ;;=I21.09^^8^124^2
 ;;^UTILITY(U,$J,358.3,1576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1576,1,3,0)
 ;;=3^STEMI Involving Coronary Artery of Anterior Wall
 ;;^UTILITY(U,$J,358.3,1576,1,4,0)
 ;;=4^I21.09
 ;;^UTILITY(U,$J,358.3,1576,2)
 ;;=^5007082
 ;;^UTILITY(U,$J,358.3,1577,0)
 ;;=I21.02^^8^124^4
 ;;^UTILITY(U,$J,358.3,1577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1577,1,3,0)
 ;;=3^STEMI Involving Left Anterior Descending Coronary Artery
 ;;^UTILITY(U,$J,358.3,1577,1,4,0)
 ;;=4^I21.02
 ;;^UTILITY(U,$J,358.3,1577,2)
 ;;=^5007081
 ;;^UTILITY(U,$J,358.3,1578,0)
 ;;=I21.01^^8^124^5
 ;;^UTILITY(U,$J,358.3,1578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1578,1,3,0)
 ;;=3^STEMI Involving Left Main Coronary Artery
 ;;^UTILITY(U,$J,358.3,1578,1,4,0)
 ;;=4^I21.01
 ;;^UTILITY(U,$J,358.3,1578,2)
 ;;=^5007080
 ;;^UTILITY(U,$J,358.3,1579,0)
 ;;=I21.19^^8^124^3
 ;;^UTILITY(U,$J,358.3,1579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1579,1,3,0)
 ;;=3^STEMI Involving Coronary Artery of Inferior Wall
 ;;^UTILITY(U,$J,358.3,1579,1,4,0)
 ;;=4^I21.19
 ;;^UTILITY(U,$J,358.3,1579,2)
 ;;=^5007084
 ;;^UTILITY(U,$J,358.3,1580,0)
 ;;=I22.1^^8^124^8
 ;;^UTILITY(U,$J,358.3,1580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1580,1,3,0)
 ;;=3^Subsequent STEMI of Inferior Wall
 ;;^UTILITY(U,$J,358.3,1580,1,4,0)
 ;;=4^I22.1
 ;;^UTILITY(U,$J,358.3,1580,2)
 ;;=^5007090
 ;;^UTILITY(U,$J,358.3,1581,0)
 ;;=I21.4^^8^124^1
 ;;^UTILITY(U,$J,358.3,1581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1581,1,3,0)
 ;;=3^NSTEMI
 ;;^UTILITY(U,$J,358.3,1581,1,4,0)
 ;;=4^I21.4
 ;;^UTILITY(U,$J,358.3,1581,2)
 ;;=^5007088
 ;;^UTILITY(U,$J,358.3,1582,0)
 ;;=I21.3^^8^124^6
 ;;^UTILITY(U,$J,358.3,1582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1582,1,3,0)
 ;;=3^STEMI of Unspec Site
 ;;^UTILITY(U,$J,358.3,1582,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,1582,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,1583,0)
 ;;=I34.2^^8^125^2
 ;;^UTILITY(U,$J,358.3,1583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1583,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,1583,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,1583,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,1584,0)
 ;;=I35.0^^8^125^1
 ;;^UTILITY(U,$J,358.3,1584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1584,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,1584,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,1584,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,1585,0)
 ;;=I36.1^^8^125^4
 ;;^UTILITY(U,$J,358.3,1585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1585,1,3,0)
 ;;=3^Nonrheumatic Tricuspid Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,1585,1,4,0)
 ;;=4^I36.1
 ;;^UTILITY(U,$J,358.3,1585,2)
 ;;=^5007180
 ;;^UTILITY(U,$J,358.3,1586,0)
 ;;=I37.0^^8^125^3
 ;;^UTILITY(U,$J,358.3,1586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1586,1,3,0)
 ;;=3^Nonrheumatic Pulmonary Valve Stenosis
 ;;^UTILITY(U,$J,358.3,1586,1,4,0)
 ;;=4^I37.0
 ;;^UTILITY(U,$J,358.3,1586,2)
 ;;=^5007184
 ;;^UTILITY(U,$J,358.3,1587,0)
 ;;=I51.1^^8^126^1
 ;;^UTILITY(U,$J,358.3,1587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1587,1,3,0)
 ;;=3^Rupture of Chordae Tendineae NEC
 ;;^UTILITY(U,$J,358.3,1587,1,4,0)
 ;;=4^I51.1
 ;;^UTILITY(U,$J,358.3,1587,2)
 ;;=^5007253
 ;;^UTILITY(U,$J,358.3,1588,0)
 ;;=I51.2^^8^126^2
 ;;^UTILITY(U,$J,358.3,1588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1588,1,3,0)
 ;;=3^Rupture of Papillary Muscle NEC
 ;;^UTILITY(U,$J,358.3,1588,1,4,0)
 ;;=4^I51.2
 ;;^UTILITY(U,$J,358.3,1588,2)
 ;;=^5007254
 ;;^UTILITY(U,$J,358.3,1589,0)
 ;;=I38.^^8^127^4
 ;;^UTILITY(U,$J,358.3,1589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1589,1,3,0)
 ;;=3^Endocarditis Valve,Unspec
 ;;^UTILITY(U,$J,358.3,1589,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,1589,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,1590,0)
 ;;=T82.01XA^^8^127^1
 ;;^UTILITY(U,$J,358.3,1590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1590,1,3,0)
 ;;=3^Breakdown of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,1590,1,4,0)
 ;;=4^T82.01XA
 ;;^UTILITY(U,$J,358.3,1590,2)
 ;;=^5054668
 ;;^UTILITY(U,$J,358.3,1591,0)
 ;;=T82.02XA^^8^127^2
 ;;^UTILITY(U,$J,358.3,1591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1591,1,3,0)
 ;;=3^Displacement of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,1591,1,4,0)
 ;;=4^T82.02XA
 ;;^UTILITY(U,$J,358.3,1591,2)
 ;;=^5054671
 ;;^UTILITY(U,$J,358.3,1592,0)
 ;;=T82.03XA^^8^127^5
 ;;^UTILITY(U,$J,358.3,1592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1592,1,3,0)
 ;;=3^Leakage of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,1592,1,4,0)
 ;;=4^T82.03XA
 ;;^UTILITY(U,$J,358.3,1592,2)
 ;;=^5054674
 ;;^UTILITY(U,$J,358.3,1593,0)
 ;;=T82.09XA^^8^127^7
 ;;^UTILITY(U,$J,358.3,1593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1593,1,3,0)
 ;;=3^Mech Compl of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,1593,1,4,0)
 ;;=4^T82.09XA
 ;;^UTILITY(U,$J,358.3,1593,2)
 ;;=^5054677
 ;;^UTILITY(U,$J,358.3,1594,0)
 ;;=T82.817A^^8^127^3
 ;;^UTILITY(U,$J,358.3,1594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1594,1,3,0)
 ;;=3^Embolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1594,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,1594,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,1595,0)
 ;;=T82.867A^^8^127^10
 ;;^UTILITY(U,$J,358.3,1595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1595,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1595,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,1595,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,1596,0)
 ;;=Z95.2^^8^127^9
 ;;^UTILITY(U,$J,358.3,1596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1596,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,1596,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,1596,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,1597,0)
 ;;=Z98.89^^8^127^8
 ;;^UTILITY(U,$J,358.3,1597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1597,1,3,0)
 ;;=3^Postprocedural States NEC
 ;;^UTILITY(U,$J,358.3,1597,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,1597,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,1598,0)
 ;;=Z79.01^^8^127^6
 ;;^UTILITY(U,$J,358.3,1598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1598,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,1598,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,1598,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,1599,0)
 ;;=I65.1^^8^128^75
 ;;^UTILITY(U,$J,358.3,1599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1599,1,3,0)
 ;;=3^Occlusion/Stenosis of Basilar Artery
 ;;^UTILITY(U,$J,358.3,1599,1,4,0)
 ;;=4^I65.1
 ;;^UTILITY(U,$J,358.3,1599,2)
 ;;=^269747
 ;;^UTILITY(U,$J,358.3,1600,0)
 ;;=I63.22^^8^128^52
 ;;^UTILITY(U,$J,358.3,1600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1600,1,3,0)
 ;;=3^Cerebral Inarction d/t Unspec Occlusion/Stenosis of Basilar Arteries
 ;;^UTILITY(U,$J,358.3,1600,1,4,0)
 ;;=4^I63.22
 ;;^UTILITY(U,$J,358.3,1600,2)
 ;;=^5007315
 ;;^UTILITY(U,$J,358.3,1601,0)
 ;;=I65.21^^8^128^81
 ;;^UTILITY(U,$J,358.3,1601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1601,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,1601,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,1601,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,1602,0)
 ;;=I65.22^^8^128^78
 ;;^UTILITY(U,$J,358.3,1602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1602,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,1602,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,1602,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,1603,0)
 ;;=I65.23^^8^128^76
