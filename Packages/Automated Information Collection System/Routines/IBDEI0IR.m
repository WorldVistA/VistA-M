IBDEI0IR ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18895,1,3,0)
 ;;=3^Chronic Osteomyelitis,Unspec Site,NEC
 ;;^UTILITY(U,$J,358.3,18895,1,4,0)
 ;;=4^M86.60
 ;;^UTILITY(U,$J,358.3,18895,2)
 ;;=^5014630
 ;;^UTILITY(U,$J,358.3,18896,0)
 ;;=R50.9^^84^968^52
 ;;^UTILITY(U,$J,358.3,18896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18896,1,3,0)
 ;;=3^Fever,Unspec
 ;;^UTILITY(U,$J,358.3,18896,1,4,0)
 ;;=4^R50.9
 ;;^UTILITY(U,$J,358.3,18896,2)
 ;;=^5019512
 ;;^UTILITY(U,$J,358.3,18897,0)
 ;;=N70.91^^84^968^90
 ;;^UTILITY(U,$J,358.3,18897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18897,1,3,0)
 ;;=3^Salpingitis,Unspec
 ;;^UTILITY(U,$J,358.3,18897,1,4,0)
 ;;=4^N70.91
 ;;^UTILITY(U,$J,358.3,18897,2)
 ;;=^5015806
 ;;^UTILITY(U,$J,358.3,18898,0)
 ;;=N70.93^^84^968^89
 ;;^UTILITY(U,$J,358.3,18898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18898,1,3,0)
 ;;=3^Salpingitis & Oophoritis,Unspec
 ;;^UTILITY(U,$J,358.3,18898,1,4,0)
 ;;=4^N70.93
 ;;^UTILITY(U,$J,358.3,18898,2)
 ;;=^5015808
 ;;^UTILITY(U,$J,358.3,18899,0)
 ;;=C77.0^^84^969^8
 ;;^UTILITY(U,$J,358.3,18899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18899,1,3,0)
 ;;=3^Secondary Malig Neop of Head/Face/Neck Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18899,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,18899,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,18900,0)
 ;;=C77.1^^84^969^12
 ;;^UTILITY(U,$J,358.3,18900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18900,1,3,0)
 ;;=3^Secondary Malig Neop of Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18900,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,18900,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,18901,0)
 ;;=C77.2^^84^969^10
 ;;^UTILITY(U,$J,358.3,18901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18901,1,3,0)
 ;;=3^Secondary Malig Neop of Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18901,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,18901,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,18902,0)
 ;;=C77.3^^84^969^1
 ;;^UTILITY(U,$J,358.3,18902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18902,1,3,0)
 ;;=3^Secondary Malig Neop of Axilla/Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18902,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,18902,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,18903,0)
 ;;=C77.4^^84^969^9
 ;;^UTILITY(U,$J,358.3,18903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18903,1,3,0)
 ;;=3^Secondary Malig Neop of Inguinal/Lower Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18903,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,18903,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,18904,0)
 ;;=C77.5^^84^969^11
 ;;^UTILITY(U,$J,358.3,18904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18904,1,3,0)
 ;;=3^Secondary Malig Neop of Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18904,1,4,0)
 ;;=4^C77.5
 ;;^UTILITY(U,$J,358.3,18904,2)
 ;;=^267319
 ;;^UTILITY(U,$J,358.3,18905,0)
 ;;=C77.8^^84^969^16
 ;;^UTILITY(U,$J,358.3,18905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18905,1,3,0)
 ;;=3^Secondary Malig Neop of Mult Region Lymph Nodes
 ;;^UTILITY(U,$J,358.3,18905,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,18905,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,18906,0)
 ;;=C78.01^^84^969^18
 ;;^UTILITY(U,$J,358.3,18906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18906,1,3,0)
 ;;=3^Secondary Malig Neop of Right Lung
 ;;^UTILITY(U,$J,358.3,18906,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,18906,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,18907,0)
 ;;=C78.02^^84^969^14
 ;;^UTILITY(U,$J,358.3,18907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18907,1,3,0)
 ;;=3^Secondary Malig Neop of Left Lung
 ;;^UTILITY(U,$J,358.3,18907,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,18907,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,18908,0)
 ;;=C79.19^^84^969^21
 ;;^UTILITY(U,$J,358.3,18908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18908,1,3,0)
 ;;=3^Secondary Malig Neop of Urinary Organs NEC
 ;;^UTILITY(U,$J,358.3,18908,1,4,0)
 ;;=4^C79.19
 ;;^UTILITY(U,$J,358.3,18908,2)
 ;;=^267332
 ;;^UTILITY(U,$J,358.3,18909,0)
 ;;=C79.11^^84^969^2
 ;;^UTILITY(U,$J,358.3,18909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18909,1,3,0)
 ;;=3^Secondary Malig Neop of Bladder
 ;;^UTILITY(U,$J,358.3,18909,1,4,0)
 ;;=4^C79.11
 ;;^UTILITY(U,$J,358.3,18909,2)
 ;;=^5001346
 ;;^UTILITY(U,$J,358.3,18910,0)
 ;;=C79.2^^84^969^20
 ;;^UTILITY(U,$J,358.3,18910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18910,1,3,0)
 ;;=3^Secondary Malig Neop of Skin
 ;;^UTILITY(U,$J,358.3,18910,1,4,0)
 ;;=4^C79.2
 ;;^UTILITY(U,$J,358.3,18910,2)
 ;;=^267333
 ;;^UTILITY(U,$J,358.3,18911,0)
 ;;=C79.31^^84^969^5
 ;;^UTILITY(U,$J,358.3,18911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18911,1,3,0)
 ;;=3^Secondary Malig Neop of Brain
 ;;^UTILITY(U,$J,358.3,18911,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,18911,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,18912,0)
 ;;=C79.32^^84^969^7
 ;;^UTILITY(U,$J,358.3,18912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18912,1,3,0)
 ;;=3^Secondary Malig Neop of Cerebral Meninges
 ;;^UTILITY(U,$J,358.3,18912,1,4,0)
 ;;=4^C79.32
 ;;^UTILITY(U,$J,358.3,18912,2)
 ;;=^5001348
 ;;^UTILITY(U,$J,358.3,18913,0)
 ;;=C79.51^^84^969^3
 ;;^UTILITY(U,$J,358.3,18913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18913,1,3,0)
 ;;=3^Secondary Malig Neop of Bone
 ;;^UTILITY(U,$J,358.3,18913,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,18913,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,18914,0)
 ;;=C79.52^^84^969^4
 ;;^UTILITY(U,$J,358.3,18914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18914,1,3,0)
 ;;=3^Secondary Malig Neop of Bone Marrow
 ;;^UTILITY(U,$J,358.3,18914,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,18914,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,18915,0)
 ;;=C79.61^^84^969^19
 ;;^UTILITY(U,$J,358.3,18915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18915,1,3,0)
 ;;=3^Secondary Malig Neop of Right Ovary
 ;;^UTILITY(U,$J,358.3,18915,1,4,0)
 ;;=4^C79.61
 ;;^UTILITY(U,$J,358.3,18915,2)
 ;;=^5001353
 ;;^UTILITY(U,$J,358.3,18916,0)
 ;;=C79.62^^84^969^15
 ;;^UTILITY(U,$J,358.3,18916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18916,1,3,0)
 ;;=3^Secondary Malig Neop of Left Ovary
 ;;^UTILITY(U,$J,358.3,18916,1,4,0)
 ;;=4^C79.62
 ;;^UTILITY(U,$J,358.3,18916,2)
 ;;=^5001354
 ;;^UTILITY(U,$J,358.3,18917,0)
 ;;=C79.71^^84^969^17
 ;;^UTILITY(U,$J,358.3,18917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18917,1,3,0)
 ;;=3^Secondary Malig Neop of Right Adrenal Gland
 ;;^UTILITY(U,$J,358.3,18917,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,18917,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,18918,0)
 ;;=C79.72^^84^969^13
 ;;^UTILITY(U,$J,358.3,18918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18918,1,3,0)
 ;;=3^Secondary Malig Neop of Left Adrenal Gland
 ;;^UTILITY(U,$J,358.3,18918,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,18918,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,18919,0)
 ;;=C79.81^^84^969^6
 ;;^UTILITY(U,$J,358.3,18919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18919,1,3,0)
 ;;=3^Secondary Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,18919,1,4,0)
 ;;=4^C79.81
 ;;^UTILITY(U,$J,358.3,18919,2)
 ;;=^267338
 ;;^UTILITY(U,$J,358.3,18920,0)
 ;;=K91.3^^84^970^5
 ;;^UTILITY(U,$J,358.3,18920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18920,1,3,0)
 ;;=3^Postprocedural Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,18920,1,4,0)
 ;;=4^K91.3
 ;;^UTILITY(U,$J,358.3,18920,2)
 ;;=^5008902
 ;;^UTILITY(U,$J,358.3,18921,0)
 ;;=T88.8XXA^^84^970^6
 ;;^UTILITY(U,$J,358.3,18921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18921,1,3,0)
 ;;=3^Surgical/Medical Care Complications NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,18921,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,18921,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,18922,0)
 ;;=T81.31XA^^84^970^2
 ;;^UTILITY(U,$J,358.3,18922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18922,1,3,0)
 ;;=3^Disruption of External Operation Surgical Wound NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,18922,1,4,0)
 ;;=4^T81.31XA
