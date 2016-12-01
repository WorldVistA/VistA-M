IBDEI01J ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1458,1,3,0)
 ;;=3^Complication of Vein Following Procedure NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,1458,1,4,0)
 ;;=4^T81.72XA
 ;;^UTILITY(U,$J,358.3,1458,2)
 ;;=^5054650
 ;;^UTILITY(U,$J,358.3,1459,0)
 ;;=T82.817A^^8^117^20
 ;;^UTILITY(U,$J,358.3,1459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1459,1,3,0)
 ;;=3^Embolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1459,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,1459,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,1460,0)
 ;;=T82.818A^^8^117^21
 ;;^UTILITY(U,$J,358.3,1460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1460,1,3,0)
 ;;=3^Embolism of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1460,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,1460,2)
 ;;=^5054917
 ;;^UTILITY(U,$J,358.3,1461,0)
 ;;=I26.99^^8^117^49
 ;;^UTILITY(U,$J,358.3,1461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1461,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale NEC
 ;;^UTILITY(U,$J,358.3,1461,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,1461,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,1462,0)
 ;;=I27.0^^8^117^46
 ;;^UTILITY(U,$J,358.3,1462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1462,1,3,0)
 ;;=3^Primary Pulmonary Hypertension
 ;;^UTILITY(U,$J,358.3,1462,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,1462,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,1463,0)
 ;;=I27.1^^8^117^32
 ;;^UTILITY(U,$J,358.3,1463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1463,1,3,0)
 ;;=3^Kyphoscoliotic Hrt Disease
 ;;^UTILITY(U,$J,358.3,1463,1,4,0)
 ;;=4^I27.1
 ;;^UTILITY(U,$J,358.3,1463,2)
 ;;=^265120
 ;;^UTILITY(U,$J,358.3,1464,0)
 ;;=I27.2^^8^117^52
 ;;^UTILITY(U,$J,358.3,1464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1464,1,3,0)
 ;;=3^Secondary Pulmonary Hypertension NEC
 ;;^UTILITY(U,$J,358.3,1464,1,4,0)
 ;;=4^I27.2
 ;;^UTILITY(U,$J,358.3,1464,2)
 ;;=^5007151
 ;;^UTILITY(U,$J,358.3,1465,0)
 ;;=I27.89^^8^117^50
 ;;^UTILITY(U,$J,358.3,1465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1465,1,3,0)
 ;;=3^Pulmonary Hrt Diseases NEC
 ;;^UTILITY(U,$J,358.3,1465,1,4,0)
 ;;=4^I27.89
 ;;^UTILITY(U,$J,358.3,1465,2)
 ;;=^5007153
 ;;^UTILITY(U,$J,358.3,1466,0)
 ;;=I27.81^^8^117^18
 ;;^UTILITY(U,$J,358.3,1466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1466,1,3,0)
 ;;=3^Cor Pulmonale,Chronic
 ;;^UTILITY(U,$J,358.3,1466,1,4,0)
 ;;=4^I27.81
 ;;^UTILITY(U,$J,358.3,1466,2)
 ;;=^5007152
 ;;^UTILITY(U,$J,358.3,1467,0)
 ;;=I42.1^^8^117^36
 ;;^UTILITY(U,$J,358.3,1467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1467,1,3,0)
 ;;=3^Obstructive Hypertrophic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,1467,1,4,0)
 ;;=4^I42.1
 ;;^UTILITY(U,$J,358.3,1467,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,1468,0)
 ;;=I42.2^^8^117^31
 ;;^UTILITY(U,$J,358.3,1468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1468,1,3,0)
 ;;=3^Hypertrophic Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,1468,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,1468,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,1469,0)
 ;;=I42.5^^8^117^51
 ;;^UTILITY(U,$J,358.3,1469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1469,1,3,0)
 ;;=3^Restrictive Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,1469,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,1469,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,1470,0)
 ;;=I42.6^^8^117^4
 ;;^UTILITY(U,$J,358.3,1470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1470,1,3,0)
 ;;=3^Alcoholic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,1470,1,4,0)
 ;;=4^I42.6
 ;;^UTILITY(U,$J,358.3,1470,2)
 ;;=^5007197
 ;;^UTILITY(U,$J,358.3,1471,0)
 ;;=I43.^^8^117^8
 ;;^UTILITY(U,$J,358.3,1471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1471,1,3,0)
 ;;=3^Cardiomyopathy in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,1471,1,4,0)
 ;;=4^I43.
 ;;^UTILITY(U,$J,358.3,1471,2)
 ;;=^5007201
 ;;^UTILITY(U,$J,358.3,1472,0)
 ;;=I42.7^^8^117^7
 ;;^UTILITY(U,$J,358.3,1472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1472,1,3,0)
 ;;=3^Cardiomyopathy d/t Drug/External Agent
 ;;^UTILITY(U,$J,358.3,1472,1,4,0)
 ;;=4^I42.7
 ;;^UTILITY(U,$J,358.3,1472,2)
 ;;=^5007198
 ;;^UTILITY(U,$J,358.3,1473,0)
 ;;=I42.9^^8^117^9
 ;;^UTILITY(U,$J,358.3,1473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1473,1,3,0)
 ;;=3^Cardiomyopathy,Unspec
 ;;^UTILITY(U,$J,358.3,1473,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,1473,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,1474,0)
 ;;=I50.9^^8^117^22
 ;;^UTILITY(U,$J,358.3,1474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1474,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1474,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,1474,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,1475,0)
 ;;=I50.1^^8^117^33
 ;;^UTILITY(U,$J,358.3,1475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1475,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,1475,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,1475,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,1476,0)
 ;;=I50.20^^8^117^55
 ;;^UTILITY(U,$J,358.3,1476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1476,1,3,0)
 ;;=3^Systolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1476,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,1476,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,1477,0)
 ;;=I50.30^^8^117^19
 ;;^UTILITY(U,$J,358.3,1477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1477,1,3,0)
 ;;=3^Diastolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1477,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,1477,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,1478,0)
 ;;=I50.40^^8^117^54
 ;;^UTILITY(U,$J,358.3,1478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1478,1,3,0)
 ;;=3^Systolic & Diastolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1478,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,1478,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,1479,0)
 ;;=I51.7^^8^117^6
 ;;^UTILITY(U,$J,358.3,1479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1479,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,1479,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,1479,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,1480,0)
 ;;=I97.111^^8^117^42
 ;;^UTILITY(U,$J,358.3,1480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1480,1,3,0)
 ;;=3^Postprocedural Cardiac Insufficiency Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1480,1,4,0)
 ;;=4^I97.111
 ;;^UTILITY(U,$J,358.3,1480,2)
 ;;=^5008084
 ;;^UTILITY(U,$J,358.3,1481,0)
 ;;=I97.120^^8^117^38
 ;;^UTILITY(U,$J,358.3,1481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1481,1,3,0)
 ;;=3^Postprocedural Cardiac Arrest Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1481,1,4,0)
 ;;=4^I97.120
 ;;^UTILITY(U,$J,358.3,1481,2)
 ;;=^5008085
 ;;^UTILITY(U,$J,358.3,1482,0)
 ;;=I97.121^^8^117^39
 ;;^UTILITY(U,$J,358.3,1482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1482,1,3,0)
 ;;=3^Postprocedural Cardiac Arrest Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1482,1,4,0)
 ;;=4^I97.121
 ;;^UTILITY(U,$J,358.3,1482,2)
 ;;=^5008086
 ;;^UTILITY(U,$J,358.3,1483,0)
 ;;=I97.130^^8^117^44
 ;;^UTILITY(U,$J,358.3,1483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1483,1,3,0)
 ;;=3^Postprocedural Heart Failure Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1483,1,4,0)
 ;;=4^I97.130
 ;;^UTILITY(U,$J,358.3,1483,2)
 ;;=^5008087
 ;;^UTILITY(U,$J,358.3,1484,0)
 ;;=I97.131^^8^117^45
 ;;^UTILITY(U,$J,358.3,1484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1484,1,3,0)
 ;;=3^Postprocedural Heart Failure Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1484,1,4,0)
 ;;=4^I97.131
 ;;^UTILITY(U,$J,358.3,1484,2)
 ;;=^5008088
 ;;^UTILITY(U,$J,358.3,1485,0)
 ;;=I97.190^^8^117^40
 ;;^UTILITY(U,$J,358.3,1485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1485,1,3,0)
 ;;=3^Postprocedural Cardiac Function Disturbance Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1485,1,4,0)
 ;;=4^I97.190
 ;;^UTILITY(U,$J,358.3,1485,2)
 ;;=^5008089
 ;;^UTILITY(U,$J,358.3,1486,0)
 ;;=I97.191^^8^117^41
 ;;^UTILITY(U,$J,358.3,1486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1486,1,3,0)
 ;;=3^Postprocedural Cardiac Function Disturbance Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1486,1,4,0)
 ;;=4^I97.191
 ;;^UTILITY(U,$J,358.3,1486,2)
 ;;=^5008090
 ;;^UTILITY(U,$J,358.3,1487,0)
 ;;=I97.0^^8^117^37
 ;;^UTILITY(U,$J,358.3,1487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1487,1,3,0)
 ;;=3^Postcardiotomy Syndrome
 ;;^UTILITY(U,$J,358.3,1487,1,4,0)
 ;;=4^I97.0
 ;;^UTILITY(U,$J,358.3,1487,2)
 ;;=^5008082
 ;;^UTILITY(U,$J,358.3,1488,0)
 ;;=I97.110^^8^117^43
 ;;^UTILITY(U,$J,358.3,1488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1488,1,3,0)
 ;;=3^Postprocedural Cardiac Insufficiency Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1488,1,4,0)
 ;;=4^I97.110
 ;;^UTILITY(U,$J,358.3,1488,2)
 ;;=^5008083
 ;;^UTILITY(U,$J,358.3,1489,0)
 ;;=T86.20^^8^117^11
 ;;^UTILITY(U,$J,358.3,1489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1489,1,3,0)
 ;;=3^Complication of Heart Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,1489,1,4,0)
 ;;=4^T86.20
 ;;^UTILITY(U,$J,358.3,1489,2)
 ;;=^5055713
 ;;^UTILITY(U,$J,358.3,1490,0)
 ;;=T86.21^^8^117^25
 ;;^UTILITY(U,$J,358.3,1490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1490,1,3,0)
 ;;=3^Heart Transplant Rejection
 ;;^UTILITY(U,$J,358.3,1490,1,4,0)
 ;;=4^T86.21
 ;;^UTILITY(U,$J,358.3,1490,2)
 ;;=^5055714
 ;;^UTILITY(U,$J,358.3,1491,0)
 ;;=T86.22^^8^117^23
 ;;^UTILITY(U,$J,358.3,1491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1491,1,3,0)
 ;;=3^Heart Transplant Failure
 ;;^UTILITY(U,$J,358.3,1491,1,4,0)
 ;;=4^T86.22
 ;;^UTILITY(U,$J,358.3,1491,2)
 ;;=^5055715
 ;;^UTILITY(U,$J,358.3,1492,0)
 ;;=T86.23^^8^117^24
 ;;^UTILITY(U,$J,358.3,1492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1492,1,3,0)
 ;;=3^Heart Transplant Infection
 ;;^UTILITY(U,$J,358.3,1492,1,4,0)
 ;;=4^T86.23
 ;;^UTILITY(U,$J,358.3,1492,2)
 ;;=^5055716
 ;;^UTILITY(U,$J,358.3,1493,0)
 ;;=T86.290^^8^117^5
 ;;^UTILITY(U,$J,358.3,1493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1493,1,3,0)
 ;;=3^Cardiac Allograft Vasculopathy
