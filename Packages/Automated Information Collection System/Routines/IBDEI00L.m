IBDEI00L ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,826,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,826,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,827,0)
 ;;=D47.1^^12^86^36
 ;;^UTILITY(U,$J,358.3,827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,827,1,3,0)
 ;;=3^Myeloproliferative Disease,Chr
 ;;^UTILITY(U,$J,358.3,827,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,827,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,828,0)
 ;;=D47.9^^12^86^37
 ;;^UTILITY(U,$J,358.3,828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,828,1,3,0)
 ;;=3^Neop Uncrt Behavior Lymphoid/Hematopoietic/Related Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,828,1,4,0)
 ;;=4^D47.9
 ;;^UTILITY(U,$J,358.3,828,2)
 ;;=^5002260
 ;;^UTILITY(U,$J,358.3,829,0)
 ;;=C80.0^^12^86^4
 ;;^UTILITY(U,$J,358.3,829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,829,1,3,0)
 ;;=3^Disseminated Malig Neop,Unspec
 ;;^UTILITY(U,$J,358.3,829,1,4,0)
 ;;=4^C80.0
 ;;^UTILITY(U,$J,358.3,829,2)
 ;;=^5001388
 ;;^UTILITY(U,$J,358.3,830,0)
 ;;=D47.2^^12^86^28
 ;;^UTILITY(U,$J,358.3,830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,830,1,3,0)
 ;;=3^Monoclonal Gammopathy
 ;;^UTILITY(U,$J,358.3,830,1,4,0)
 ;;=4^D47.2
 ;;^UTILITY(U,$J,358.3,830,2)
 ;;=^5002257
 ;;^UTILITY(U,$J,358.3,831,0)
 ;;=C90.00^^12^86^29
 ;;^UTILITY(U,$J,358.3,831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,831,1,3,0)
 ;;=3^Multiple Myeloma,Not in Remission
 ;;^UTILITY(U,$J,358.3,831,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,831,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,832,0)
 ;;=C84.00^^12^86^31
 ;;^UTILITY(U,$J,358.3,832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,832,1,3,0)
 ;;=3^Mycosis Fungoides,Unspec Site
 ;;^UTILITY(U,$J,358.3,832,1,4,0)
 ;;=4^C84.00
 ;;^UTILITY(U,$J,358.3,832,2)
 ;;=^5001621
 ;;^UTILITY(U,$J,358.3,833,0)
 ;;=C84.09^^12^86^30
 ;;^UTILITY(U,$J,358.3,833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,833,1,3,0)
 ;;=3^Mycosis Fungoides,Extrnod & Solid Org Sites
 ;;^UTILITY(U,$J,358.3,833,1,4,0)
 ;;=4^C84.09
 ;;^UTILITY(U,$J,358.3,833,2)
 ;;=^5001630
 ;;^UTILITY(U,$J,358.3,834,0)
 ;;=C79.71^^12^87^2
 ;;^UTILITY(U,$J,358.3,834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,834,1,3,0)
 ;;=3^Malig Neop Adrenal Gland,Right,Secondary
 ;;^UTILITY(U,$J,358.3,834,1,4,0)
 ;;=4^C79.71
 ;;^UTILITY(U,$J,358.3,834,2)
 ;;=^5001356
 ;;^UTILITY(U,$J,358.3,835,0)
 ;;=C79.72^^12^87^1
 ;;^UTILITY(U,$J,358.3,835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,835,1,3,0)
 ;;=3^Malig Neop Adrenal Gland,Left,Secondary
 ;;^UTILITY(U,$J,358.3,835,1,4,0)
 ;;=4^C79.72
 ;;^UTILITY(U,$J,358.3,835,2)
 ;;=^5001357
 ;;^UTILITY(U,$J,358.3,836,0)
 ;;=C79.51^^12^87^5
 ;;^UTILITY(U,$J,358.3,836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,836,1,3,0)
 ;;=3^Malig Neop Bone,Secondary
 ;;^UTILITY(U,$J,358.3,836,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,836,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,837,0)
 ;;=C79.52^^12^87^4
 ;;^UTILITY(U,$J,358.3,837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,837,1,3,0)
 ;;=3^Malig Neop Bone Marrow,Secondary
 ;;^UTILITY(U,$J,358.3,837,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,837,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,838,0)
 ;;=C79.31^^12^87^6
 ;;^UTILITY(U,$J,358.3,838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,838,1,3,0)
 ;;=3^Malig Neop Brain,Secondary
 ;;^UTILITY(U,$J,358.3,838,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,838,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,839,0)
 ;;=C79.32^^12^87^7
 ;;^UTILITY(U,$J,358.3,839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,839,1,3,0)
 ;;=3^Malig Neop Cerebral Meninges,Secondary
 ;;^UTILITY(U,$J,358.3,839,1,4,0)
 ;;=4^C79.32
 ;;^UTILITY(U,$J,358.3,839,2)
 ;;=^5001348
 ;;^UTILITY(U,$J,358.3,840,0)
 ;;=C78.7^^12^87^11
 ;;^UTILITY(U,$J,358.3,840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,840,1,3,0)
 ;;=3^Malig Neop Liver/Intrahepatic Bile Duct,Secondary
 ;;^UTILITY(U,$J,358.3,840,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,840,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,841,0)
 ;;=C78.01^^12^87^13
 ;;^UTILITY(U,$J,358.3,841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,841,1,3,0)
 ;;=3^Malig Neop Lung,Right,Secondary
 ;;^UTILITY(U,$J,358.3,841,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,841,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,842,0)
 ;;=C78.02^^12^87^12
 ;;^UTILITY(U,$J,358.3,842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,842,1,3,0)
 ;;=3^Malig Neop Lung,Left,Secondary
 ;;^UTILITY(U,$J,358.3,842,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,842,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,843,0)
 ;;=C77.2^^12^87^9
 ;;^UTILITY(U,$J,358.3,843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,843,1,3,0)
 ;;=3^Malig Neop Intra-Abdominal Lymph Nodes,Secondary
 ;;^UTILITY(U,$J,358.3,843,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,843,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,844,0)
 ;;=C77.3^^12^87^3
 ;;^UTILITY(U,$J,358.3,844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,844,1,3,0)
 ;;=3^Malig Neop Axilla/Upper Limb Lymph Nodes,Secondary
 ;;^UTILITY(U,$J,358.3,844,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,844,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,845,0)
 ;;=C77.0^^12^87^8
 ;;^UTILITY(U,$J,358.3,845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,845,1,3,0)
 ;;=3^Malig Neop Head/Face/Neck,Secondary
 ;;^UTILITY(U,$J,358.3,845,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,845,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,846,0)
 ;;=C77.1^^12^87^10
 ;;^UTILITY(U,$J,358.3,846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,846,1,3,0)
 ;;=3^Malig Neop Intrathoracic Lymph Nodes,Secondary
 ;;^UTILITY(U,$J,358.3,846,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,846,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,847,0)
 ;;=C77.8^^12^87^14
 ;;^UTILITY(U,$J,358.3,847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,847,1,3,0)
 ;;=3^Malig Neop Lymph Nodes,Multiple Regions,Secondary
 ;;^UTILITY(U,$J,358.3,847,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,847,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,848,0)
 ;;=C79.2^^12^87^15
 ;;^UTILITY(U,$J,358.3,848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,848,1,3,0)
 ;;=3^Malig Neop Skin,Secondary
 ;;^UTILITY(U,$J,358.3,848,1,4,0)
 ;;=4^C79.2
 ;;^UTILITY(U,$J,358.3,848,2)
 ;;=^267333
 ;;^UTILITY(U,$J,358.3,849,0)
 ;;=C74.91^^12^88^9
 ;;^UTILITY(U,$J,358.3,849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,849,1,3,0)
 ;;=3^Malig Neop Adrenal Gland,Right,Unspec Part
 ;;^UTILITY(U,$J,358.3,849,1,4,0)
 ;;=4^C74.91
 ;;^UTILITY(U,$J,358.3,849,2)
 ;;=^5001318
 ;;^UTILITY(U,$J,358.3,850,0)
 ;;=C74.92^^12^88^8
 ;;^UTILITY(U,$J,358.3,850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,850,1,3,0)
 ;;=3^Malig Neop Adrenal Gland,Left,Unspec Part
 ;;^UTILITY(U,$J,358.3,850,1,4,0)
 ;;=4^C74.92
 ;;^UTILITY(U,$J,358.3,850,2)
 ;;=^5001319
 ;;^UTILITY(U,$J,358.3,851,0)
 ;;=C74.01^^12^88^5
 ;;^UTILITY(U,$J,358.3,851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,851,1,3,0)
 ;;=3^Malig Neop Adrenal Gland Cortex,Right
 ;;^UTILITY(U,$J,358.3,851,1,4,0)
 ;;=4^C74.01
 ;;^UTILITY(U,$J,358.3,851,2)
 ;;=^5001312
 ;;^UTILITY(U,$J,358.3,852,0)
 ;;=C74.02^^12^88^4
 ;;^UTILITY(U,$J,358.3,852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,852,1,3,0)
 ;;=3^Malig Neop Adrenal Gland Cortex,Left
 ;;^UTILITY(U,$J,358.3,852,1,4,0)
 ;;=4^C74.02
 ;;^UTILITY(U,$J,358.3,852,2)
 ;;=^5001313
 ;;^UTILITY(U,$J,358.3,853,0)
 ;;=C74.11^^12^88^7
 ;;^UTILITY(U,$J,358.3,853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,853,1,3,0)
 ;;=3^Malig Neop Adrenal Gland Medulla,Right
 ;;^UTILITY(U,$J,358.3,853,1,4,0)
 ;;=4^C74.11
 ;;^UTILITY(U,$J,358.3,853,2)
 ;;=^5001315
 ;;^UTILITY(U,$J,358.3,854,0)
 ;;=C74.12^^12^88^6
 ;;^UTILITY(U,$J,358.3,854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,854,1,3,0)
 ;;=3^Malig Neop Adrenal Gland Medulla,Left
 ;;^UTILITY(U,$J,358.3,854,1,4,0)
 ;;=4^C74.12
 ;;^UTILITY(U,$J,358.3,854,2)
 ;;=^5001316
 ;;^UTILITY(U,$J,358.3,855,0)
 ;;=C44.91^^12^88^1
 ;;^UTILITY(U,$J,358.3,855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,855,1,3,0)
 ;;=3^BCC of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,855,1,4,0)
 ;;=4^C44.91
 ;;^UTILITY(U,$J,358.3,855,2)
 ;;=^5001092
 ;;^UTILITY(U,$J,358.3,856,0)
 ;;=C41.9^^12^88^10
 ;;^UTILITY(U,$J,358.3,856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,856,1,3,0)
 ;;=3^Malig Neop Bone & Articular Cartilage,Unspec
 ;;^UTILITY(U,$J,358.3,856,1,4,0)
 ;;=4^C41.9
 ;;^UTILITY(U,$J,358.3,856,2)
 ;;=^5000993
 ;;^UTILITY(U,$J,358.3,857,0)
 ;;=C71.9^^12^88^11
 ;;^UTILITY(U,$J,358.3,857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,857,1,3,0)
 ;;=3^Malig Neop Brain,Unspec
 ;;^UTILITY(U,$J,358.3,857,1,4,0)
 ;;=4^C71.9
 ;;^UTILITY(U,$J,358.3,857,2)
 ;;=^5001297
 ;;^UTILITY(U,$J,358.3,858,0)
 ;;=C46.9^^12^88^2
 ;;^UTILITY(U,$J,358.3,858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,858,1,3,0)
 ;;=3^Kaposi's Sarcoma,Unspec
 ;;^UTILITY(U,$J,358.3,858,1,4,0)
 ;;=4^C46.9
 ;;^UTILITY(U,$J,358.3,858,2)
 ;;=^5001108
 ;;^UTILITY(U,$J,358.3,859,0)
 ;;=C43.9^^12^88^3
 ;;^UTILITY(U,$J,358.3,859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,859,1,3,0)
 ;;=3^Malig Melanoma Skin,Unspec
 ;;^UTILITY(U,$J,358.3,859,1,4,0)
 ;;=4^C43.9
 ;;^UTILITY(U,$J,358.3,859,2)
 ;;=^5001015
 ;;^UTILITY(U,$J,358.3,860,0)
 ;;=D03.9^^12^88^18
 ;;^UTILITY(U,$J,358.3,860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,860,1,3,0)
 ;;=3^Melanoma in Situ,Unspec
 ;;^UTILITY(U,$J,358.3,860,1,4,0)
 ;;=4^D03.9
 ;;^UTILITY(U,$J,358.3,860,2)
 ;;=^5001908
 ;;^UTILITY(U,$J,358.3,861,0)
 ;;=C44.99^^12^88^16
 ;;^UTILITY(U,$J,358.3,861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,861,1,3,0)
 ;;=3^Malig Neop Skin,Unspec
 ;;^UTILITY(U,$J,358.3,861,1,4,0)
 ;;=4^C44.99
 ;;^UTILITY(U,$J,358.3,861,2)
 ;;=^5001094
 ;;^UTILITY(U,$J,358.3,862,0)
 ;;=C48.2^^12^88^14
 ;;^UTILITY(U,$J,358.3,862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,862,1,3,0)
 ;;=3^Malig Neop Peritoneum,Unspec
 ;;^UTILITY(U,$J,358.3,862,1,4,0)
 ;;=4^C48.2
 ;;^UTILITY(U,$J,358.3,862,2)
 ;;=^5001122
 ;;^UTILITY(U,$J,358.3,863,0)
 ;;=C38.4^^12^88^15
 ;;^UTILITY(U,$J,358.3,863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,863,1,3,0)
 ;;=3^Malig Neop Pleura
 ;;^UTILITY(U,$J,358.3,863,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,863,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,864,0)
 ;;=C44.92^^12^88^19
 ;;^UTILITY(U,$J,358.3,864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,864,1,3,0)
 ;;=3^SCC of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,864,1,4,0)
 ;;=4^C44.92
 ;;^UTILITY(U,$J,358.3,864,2)
 ;;=^5001093
 ;;^UTILITY(U,$J,358.3,865,0)
 ;;=C49.9^^12^88^13
 ;;^UTILITY(U,$J,358.3,865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,865,1,3,0)
 ;;=3^Malig Neop Connective & Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,865,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,865,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,866,0)
 ;;=C72.0^^12^88^17
 ;;^UTILITY(U,$J,358.3,866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,866,1,3,0)
 ;;=3^Malig Neop Spinal Cord
 ;;^UTILITY(U,$J,358.3,866,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,866,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,867,0)
 ;;=C72.1^^12^88^12
 ;;^UTILITY(U,$J,358.3,867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,867,1,3,0)
 ;;=3^Malig Neop Cauda Equina
 ;;^UTILITY(U,$J,358.3,867,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,867,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,868,0)
 ;;=C92.40^^12^89^15
 ;;^UTILITY(U,$J,358.3,868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,868,1,3,0)
 ;;=3^Promyelocytic Leukemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,868,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,868,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,869,0)
 ;;=C92.41^^12^89^14
 ;;^UTILITY(U,$J,358.3,869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,869,1,3,0)
 ;;=3^Promyelocytic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,869,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,869,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,870,0)
 ;;=C92.50^^12^89^11
 ;;^UTILITY(U,$J,358.3,870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,870,1,3,0)
 ;;=3^Myelomonocytic Leumkemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,870,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,870,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,871,0)
 ;;=C92.51^^12^89^10
 ;;^UTILITY(U,$J,358.3,871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,871,1,3,0)
 ;;=3^Myelomonocytic Leumkemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,871,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,871,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,872,0)
 ;;=C92.00^^12^89^4
 ;;^UTILITY(U,$J,358.3,872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,872,1,3,0)
 ;;=3^Myeloblastic Leukemia,Acute,Not in Remission
 ;;^UTILITY(U,$J,358.3,872,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,872,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,873,0)
 ;;=C92.01^^12^89^3
 ;;^UTILITY(U,$J,358.3,873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,873,1,3,0)
 ;;=3^Myeloblastic Leukemia,Acute,In Remission
 ;;^UTILITY(U,$J,358.3,873,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,873,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,874,0)
 ;;=C92.10^^12^89^7
 ;;^UTILITY(U,$J,358.3,874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,874,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-Positive,Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,874,1,4,0)
 ;;=4^C92.10
 ;;^UTILITY(U,$J,358.3,874,2)
 ;;=^5001792
 ;;^UTILITY(U,$J,358.3,875,0)
 ;;=C92.11^^12^89^6
 ;;^UTILITY(U,$J,358.3,875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,875,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-Positive,Chr,In Remission
 ;;^UTILITY(U,$J,358.3,875,1,4,0)
 ;;=4^C92.11
 ;;^UTILITY(U,$J,358.3,875,2)
 ;;=^5001793
 ;;^UTILITY(U,$J,358.3,876,0)
 ;;=C92.20^^12^89^9
 ;;^UTILITY(U,$J,358.3,876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,876,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-neg,Atyp Chr,Not in Remission
 ;;^UTILITY(U,$J,358.3,876,1,4,0)
 ;;=4^C92.20
 ;;^UTILITY(U,$J,358.3,876,2)
 ;;=^5001795
 ;;^UTILITY(U,$J,358.3,877,0)
 ;;=C92.21^^12^89^8
 ;;^UTILITY(U,$J,358.3,877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,877,1,3,0)
 ;;=3^Myeloid Leukemia BCR/ABL-neg,Atyp Chr,In Remission
 ;;^UTILITY(U,$J,358.3,877,1,4,0)
 ;;=4^C92.21
 ;;^UTILITY(U,$J,358.3,877,2)
 ;;=^5001796
 ;;^UTILITY(U,$J,358.3,878,0)
 ;;=D46.9^^12^89^5
 ;;^UTILITY(U,$J,358.3,878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,878,1,3,0)
 ;;=3^Myelodysplastic Syndrome,Unspec
 ;;^UTILITY(U,$J,358.3,878,1,4,0)
 ;;=4^D46.9
 ;;^UTILITY(U,$J,358.3,878,2)
 ;;=^334031
 ;;^UTILITY(U,$J,358.3,879,0)
 ;;=D45.^^12^89^12
 ;;^UTILITY(U,$J,358.3,879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,879,1,3,0)
 ;;=3^Polycythemia Vera
 ;;^UTILITY(U,$J,358.3,879,1,4,0)
 ;;=4^D45.
 ;;^UTILITY(U,$J,358.3,879,2)
 ;;=^96105
 ;;^UTILITY(U,$J,358.3,880,0)
 ;;=D75.1^^12^89^13
 ;;^UTILITY(U,$J,358.3,880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,880,1,3,0)
 ;;=3^Polycythemia,Secondary
 ;;^UTILITY(U,$J,358.3,880,1,4,0)
 ;;=4^D75.1
 ;;^UTILITY(U,$J,358.3,880,2)
 ;;=^186856
 ;;^UTILITY(U,$J,358.3,881,0)
 ;;=D68.51^^12^89^1
 ;;^UTILITY(U,$J,358.3,881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,881,1,3,0)
 ;;=3^Activated Protein C Resistance
 ;;^UTILITY(U,$J,358.3,881,1,4,0)
 ;;=4^D68.51
 ;;^UTILITY(U,$J,358.3,881,2)
 ;;=^5002358
 ;;^UTILITY(U,$J,358.3,882,0)
 ;;=D68.52^^12^89^16
 ;;^UTILITY(U,$J,358.3,882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,882,1,3,0)
 ;;=3^Prothrombin Gene Mutation
 ;;^UTILITY(U,$J,358.3,882,1,4,0)
 ;;=4^D68.52
 ;;^UTILITY(U,$J,358.3,882,2)
 ;;=^5002359
 ;;^UTILITY(U,$J,358.3,883,0)
 ;;=D68.59^^12^89^17
 ;;^UTILITY(U,$J,358.3,883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,883,1,3,0)
 ;;=3^Thrombophilia,Primary,Other
 ;;^UTILITY(U,$J,358.3,883,1,4,0)
 ;;=4^D68.59
 ;;^UTILITY(U,$J,358.3,883,2)
 ;;=^5002360
 ;;^UTILITY(U,$J,358.3,884,0)
 ;;=D68.62^^12^89^2
 ;;^UTILITY(U,$J,358.3,884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,884,1,3,0)
 ;;=3^Lupus Anticoagulant Syndrome
 ;;^UTILITY(U,$J,358.3,884,1,4,0)
 ;;=4^D68.62
 ;;^UTILITY(U,$J,358.3,884,2)
 ;;=^5002361
 ;;^UTILITY(U,$J,358.3,885,0)
 ;;=D72.9^^12^89^18
 ;;^UTILITY(U,$J,358.3,885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,885,1,3,0)
 ;;=3^White Blood Cell Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,885,1,4,0)
 ;;=4^D72.9
 ;;^UTILITY(U,$J,358.3,885,2)
 ;;=^5002381
 ;;^UTILITY(U,$J,358.3,886,0)
 ;;=Z85.038^^12^90^15
 ;;^UTILITY(U,$J,358.3,886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,886,1,3,0)
 ;;=3^Personal Hx Malig Neop Large Intestine
 ;;^UTILITY(U,$J,358.3,886,1,4,0)
 ;;=4^Z85.038
 ;;^UTILITY(U,$J,358.3,886,2)
 ;;=^5063399
 ;;^UTILITY(U,$J,358.3,887,0)
 ;;=Z85.51^^12^90^3
 ;;^UTILITY(U,$J,358.3,887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,887,1,3,0)
 ;;=3^Personal Hx Malig Neop Bladder
 ;;^UTILITY(U,$J,358.3,887,1,4,0)
 ;;=4^Z85.51
 ;;^UTILITY(U,$J,358.3,887,2)
 ;;=^5063428
 ;;^UTILITY(U,$J,358.3,888,0)
 ;;=Z85.830^^12^90^4
 ;;^UTILITY(U,$J,358.3,888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,888,1,3,0)
 ;;=3^Personal Hx Malig Neop Bone
 ;;^UTILITY(U,$J,358.3,888,1,4,0)
 ;;=4^Z85.830
 ;;^UTILITY(U,$J,358.3,888,2)
 ;;=^5063444
 ;;^UTILITY(U,$J,358.3,889,0)
 ;;=Z85.841^^12^90^5
 ;;^UTILITY(U,$J,358.3,889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,889,1,3,0)
 ;;=3^Personal Hx Malig Neop Brain
 ;;^UTILITY(U,$J,358.3,889,1,4,0)
 ;;=4^Z85.841
 ;;^UTILITY(U,$J,358.3,889,2)
 ;;=^5063447
 ;;^UTILITY(U,$J,358.3,890,0)
 ;;=Z85.3^^12^90^6
 ;;^UTILITY(U,$J,358.3,890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,890,1,3,0)
 ;;=3^Personal Hx Malig Neop Breast
 ;;^UTILITY(U,$J,358.3,890,1,4,0)
 ;;=4^Z85.3
 ;;^UTILITY(U,$J,358.3,890,2)
 ;;=^5063416
 ;;^UTILITY(U,$J,358.3,891,0)
 ;;=Z85.840^^12^90^12
 ;;^UTILITY(U,$J,358.3,891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,891,1,3,0)
 ;;=3^Personal Hx Malig Neop Eye
 ;;^UTILITY(U,$J,358.3,891,1,4,0)
 ;;=4^Z85.840
 ;;^UTILITY(U,$J,358.3,891,2)
 ;;=^5063446
 ;;^UTILITY(U,$J,358.3,892,0)
 ;;=Z85.028^^12^90^28
 ;;^UTILITY(U,$J,358.3,892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,892,1,3,0)
 ;;=3^Personal Hx Malig Neop Stomach
 ;;^UTILITY(U,$J,358.3,892,1,4,0)
 ;;=4^Z85.028
 ;;^UTILITY(U,$J,358.3,892,2)
 ;;=^5063397
 ;;^UTILITY(U,$J,358.3,893,0)
 ;;=Z85.09^^12^90^9
 ;;^UTILITY(U,$J,358.3,893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,893,1,3,0)
 ;;=3^Personal Hx Malig Neop Digestive Organs
 ;;^UTILITY(U,$J,358.3,893,1,4,0)
 ;;=4^Z85.09
 ;;^UTILITY(U,$J,358.3,893,2)
 ;;=^5063406
 ;;^UTILITY(U,$J,358.3,894,0)
 ;;=Z85.528^^12^90^14
 ;;^UTILITY(U,$J,358.3,894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,894,1,3,0)
 ;;=3^Personal Hx Malig Neop Kidney
 ;;^UTILITY(U,$J,358.3,894,1,4,0)
 ;;=4^Z85.528
 ;;^UTILITY(U,$J,358.3,894,2)
 ;;=^5063430
 ;;^UTILITY(U,$J,358.3,895,0)
 ;;=Z85.05^^12^90^17
 ;;^UTILITY(U,$J,358.3,895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,895,1,3,0)
 ;;=3^Personal Hx Malig Neop Liver
 ;;^UTILITY(U,$J,358.3,895,1,4,0)
 ;;=4^Z85.05
 ;;^UTILITY(U,$J,358.3,895,2)
 ;;=^5063402
 ;;^UTILITY(U,$J,358.3,896,0)
 ;;=Z85.43^^12^90^21
 ;;^UTILITY(U,$J,358.3,896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,896,1,3,0)
 ;;=3^Personal Hx Malig Neop Ovary
 ;;^UTILITY(U,$J,358.3,896,1,4,0)
 ;;=4^Z85.43
 ;;^UTILITY(U,$J,358.3,896,2)
 ;;=^5063420
 ;;^UTILITY(U,$J,358.3,897,0)
 ;;=Z85.850^^12^90^30
 ;;^UTILITY(U,$J,358.3,897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,897,1,3,0)
 ;;=3^Personal Hx Malig Neop Thyroid
