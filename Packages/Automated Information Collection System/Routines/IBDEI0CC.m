IBDEI0CC ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12362,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,12362,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,12363,0)
 ;;=T81.33XA^^56^653^4
 ;;^UTILITY(U,$J,358.3,12363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12363,1,3,0)
 ;;=3^Disruption of Traumatic Injury Wound Repair,Init Encntr
 ;;^UTILITY(U,$J,358.3,12363,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,12363,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,12364,0)
 ;;=T81.4XXA^^56^653^5
 ;;^UTILITY(U,$J,358.3,12364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12364,1,3,0)
 ;;=3^Infection Following a Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,12364,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,12364,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,12365,0)
 ;;=T81.89XA^^56^653^1
 ;;^UTILITY(U,$J,358.3,12365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12365,1,3,0)
 ;;=3^Complications of Procedures NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,12365,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,12365,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,12366,0)
 ;;=K91.89^^56^653^7
 ;;^UTILITY(U,$J,358.3,12366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12366,1,3,0)
 ;;=3^Postprocedural Complications/Disorders of Digestive System
 ;;^UTILITY(U,$J,358.3,12366,1,4,0)
 ;;=4^K91.89
 ;;^UTILITY(U,$J,358.3,12366,2)
 ;;=^5008912
 ;;^UTILITY(U,$J,358.3,12367,0)
 ;;=T88.8XXA^^56^653^2
 ;;^UTILITY(U,$J,358.3,12367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12367,1,3,0)
 ;;=3^Complications of Surgical/Medical Care NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,12367,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,12367,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,12368,0)
 ;;=T81.83XA^^56^653^6
 ;;^UTILITY(U,$J,358.3,12368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12368,1,3,0)
 ;;=3^Persistent Postprocedural Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,12368,1,4,0)
 ;;=4^T81.83XA
 ;;^UTILITY(U,$J,358.3,12368,2)
 ;;=^5054659
 ;;^UTILITY(U,$J,358.3,12369,0)
 ;;=I97.610^^56^653^9
 ;;^UTILITY(U,$J,358.3,12369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12369,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Cath
 ;;^UTILITY(U,$J,358.3,12369,1,4,0)
 ;;=4^I97.610
 ;;^UTILITY(U,$J,358.3,12369,2)
 ;;=^5008099
 ;;^UTILITY(U,$J,358.3,12370,0)
 ;;=H95.42^^56^653^13
 ;;^UTILITY(U,$J,358.3,12370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12370,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,12370,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,12370,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,12371,0)
 ;;=I97.611^^56^653^10
 ;;^UTILITY(U,$J,358.3,12371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12371,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,12371,1,4,0)
 ;;=4^I97.611
 ;;^UTILITY(U,$J,358.3,12371,2)
 ;;=^5008100
 ;;^UTILITY(U,$J,358.3,12372,0)
 ;;=I97.62^^56^653^11
 ;;^UTILITY(U,$J,358.3,12372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12372,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System
 ;;^UTILITY(U,$J,358.3,12372,1,4,0)
 ;;=4^I97.62
 ;;^UTILITY(U,$J,358.3,12372,2)
 ;;=^5008102
 ;;^UTILITY(U,$J,358.3,12373,0)
 ;;=K91.841^^56^653^12
 ;;^UTILITY(U,$J,358.3,12373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12373,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Digestive System
 ;;^UTILITY(U,$J,358.3,12373,1,4,0)
 ;;=4^K91.841
 ;;^UTILITY(U,$J,358.3,12373,2)
 ;;=^5008911
 ;;^UTILITY(U,$J,358.3,12374,0)
 ;;=N99.821^^56^653^15
 ;;^UTILITY(U,$J,358.3,12374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12374,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of GU System
 ;;^UTILITY(U,$J,358.3,12374,1,4,0)
 ;;=4^N99.821
 ;;^UTILITY(U,$J,358.3,12374,2)
 ;;=^5015969
 ;;^UTILITY(U,$J,358.3,12375,0)
 ;;=G97.52^^56^653^17
 ;;^UTILITY(U,$J,358.3,12375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12375,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Nervous System
 ;;^UTILITY(U,$J,358.3,12375,1,4,0)
 ;;=4^G97.52
 ;;^UTILITY(U,$J,358.3,12375,2)
 ;;=^5004210
 ;;^UTILITY(U,$J,358.3,12376,0)
 ;;=J95.831^^56^653^18
 ;;^UTILITY(U,$J,358.3,12376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12376,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Respiratory System
 ;;^UTILITY(U,$J,358.3,12376,1,4,0)
 ;;=4^J95.831
 ;;^UTILITY(U,$J,358.3,12376,2)
 ;;=^5008341
 ;;^UTILITY(U,$J,358.3,12377,0)
 ;;=H95.42^^56^653^14
 ;;^UTILITY(U,$J,358.3,12377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12377,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,12377,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,12377,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,12378,0)
 ;;=H59.323^^56^653^8
 ;;^UTILITY(U,$J,358.3,12378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12378,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Bilateral Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,12378,1,4,0)
 ;;=4^H59.323
 ;;^UTILITY(U,$J,358.3,12378,2)
 ;;=^5006423
 ;;^UTILITY(U,$J,358.3,12379,0)
 ;;=H59.322^^56^653^16
 ;;^UTILITY(U,$J,358.3,12379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12379,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Left Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,12379,1,4,0)
 ;;=4^H59.322
 ;;^UTILITY(U,$J,358.3,12379,2)
 ;;=^5006422
 ;;^UTILITY(U,$J,358.3,12380,0)
 ;;=H59.321^^56^653^19
 ;;^UTILITY(U,$J,358.3,12380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12380,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Right Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,12380,1,4,0)
 ;;=4^H59.321
 ;;^UTILITY(U,$J,358.3,12380,2)
 ;;=^5006421
 ;;^UTILITY(U,$J,358.3,12381,0)
 ;;=L76.22^^56^653^20
 ;;^UTILITY(U,$J,358.3,12381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12381,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Skin
 ;;^UTILITY(U,$J,358.3,12381,1,4,0)
 ;;=4^L76.22
 ;;^UTILITY(U,$J,358.3,12381,2)
 ;;=^5009307
 ;;^UTILITY(U,$J,358.3,12382,0)
 ;;=D78.22^^56^653^21
 ;;^UTILITY(U,$J,358.3,12382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12382,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Spleen
 ;;^UTILITY(U,$J,358.3,12382,1,4,0)
 ;;=4^D78.22
 ;;^UTILITY(U,$J,358.3,12382,2)
 ;;=^5002402
 ;;^UTILITY(U,$J,358.3,12383,0)
 ;;=K91.82^^56^653^22
 ;;^UTILITY(U,$J,358.3,12383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12383,1,3,0)
 ;;=3^Postprocedural Hepatic Failure
 ;;^UTILITY(U,$J,358.3,12383,1,4,0)
 ;;=4^K91.82
 ;;^UTILITY(U,$J,358.3,12383,2)
 ;;=^5008908
 ;;^UTILITY(U,$J,358.3,12384,0)
 ;;=K91.83^^56^653^23
 ;;^UTILITY(U,$J,358.3,12384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12384,1,3,0)
 ;;=3^Postprocedural Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,12384,1,4,0)
 ;;=4^K91.83
 ;;^UTILITY(U,$J,358.3,12384,2)
 ;;=^5008909
 ;;^UTILITY(U,$J,358.3,12385,0)
 ;;=K91.3^^56^653^24
 ;;^UTILITY(U,$J,358.3,12385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12385,1,3,0)
 ;;=3^Postprocedural Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,12385,1,4,0)
 ;;=4^K91.3
 ;;^UTILITY(U,$J,358.3,12385,2)
 ;;=^5008902
 ;;^UTILITY(U,$J,358.3,12386,0)
 ;;=K68.11^^56^653^25
 ;;^UTILITY(U,$J,358.3,12386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12386,1,3,0)
 ;;=3^Postprocedural Retroperitoneal Abscess
 ;;^UTILITY(U,$J,358.3,12386,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,12386,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,12387,0)
 ;;=K91.850^^56^653^26
 ;;^UTILITY(U,$J,358.3,12387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12387,1,3,0)
 ;;=3^Pouchitis
 ;;^UTILITY(U,$J,358.3,12387,1,4,0)
 ;;=4^K91.850
 ;;^UTILITY(U,$J,358.3,12387,2)
 ;;=^338261
 ;;^UTILITY(U,$J,358.3,12388,0)
 ;;=C34.91^^56^654^22
 ;;^UTILITY(U,$J,358.3,12388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12388,1,3,0)
 ;;=3^Malig Neop of Right Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,12388,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,12388,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,12389,0)
 ;;=C34.92^^56^654^21
