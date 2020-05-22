IBDEI03B ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7831,1,3,0)
 ;;=3^Gastro-esophageal reflux disease w/ Esophagitis
 ;;^UTILITY(U,$J,358.3,7831,1,4,0)
 ;;=4^K21.0
 ;;^UTILITY(U,$J,358.3,7831,2)
 ;;=^5008504
 ;;^UTILITY(U,$J,358.3,7832,0)
 ;;=K20.0^^45^443^12
 ;;^UTILITY(U,$J,358.3,7832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7832,1,3,0)
 ;;=3^Eosinophilic esophagitis
 ;;^UTILITY(U,$J,358.3,7832,1,4,0)
 ;;=4^K20.0
 ;;^UTILITY(U,$J,358.3,7832,2)
 ;;=^336605
 ;;^UTILITY(U,$J,358.3,7833,0)
 ;;=K22.10^^45^443^41
 ;;^UTILITY(U,$J,358.3,7833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7833,1,3,0)
 ;;=3^Ulcer of Esophagus w/o Bleeding
 ;;^UTILITY(U,$J,358.3,7833,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,7833,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,7834,0)
 ;;=K22.5^^45^443^10
 ;;^UTILITY(U,$J,358.3,7834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7834,1,3,0)
 ;;=3^Diverticulum of esophagus, acquired
 ;;^UTILITY(U,$J,358.3,7834,1,4,0)
 ;;=4^K22.5
 ;;^UTILITY(U,$J,358.3,7834,2)
 ;;=^5008509
 ;;^UTILITY(U,$J,358.3,7835,0)
 ;;=K22.6^^45^443^23
 ;;^UTILITY(U,$J,358.3,7835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7835,1,3,0)
 ;;=3^Gastro-esophageal laceration-hemorrhage syndrome
 ;;^UTILITY(U,$J,358.3,7835,1,4,0)
 ;;=4^K22.6
 ;;^UTILITY(U,$J,358.3,7835,2)
 ;;=^5008510
 ;;^UTILITY(U,$J,358.3,7836,0)
 ;;=K21.9^^45^443^25
 ;;^UTILITY(U,$J,358.3,7836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7836,1,3,0)
 ;;=3^Gastro-esophageal reflux disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,7836,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,7836,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,7837,0)
 ;;=K22.70^^45^443^5
 ;;^UTILITY(U,$J,358.3,7837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7837,1,3,0)
 ;;=3^Barrett's esophagus w/o dysplasia
 ;;^UTILITY(U,$J,358.3,7837,1,4,0)
 ;;=4^K22.70
 ;;^UTILITY(U,$J,358.3,7837,2)
 ;;=^5008511
 ;;^UTILITY(U,$J,358.3,7838,0)
 ;;=K22.710^^45^443^4
 ;;^UTILITY(U,$J,358.3,7838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7838,1,3,0)
 ;;=3^Barrett's esophagus w/ low grade dysplasia
 ;;^UTILITY(U,$J,358.3,7838,1,4,0)
 ;;=4^K22.710
 ;;^UTILITY(U,$J,358.3,7838,2)
 ;;=^5008512
 ;;^UTILITY(U,$J,358.3,7839,0)
 ;;=K22.711^^45^443^3
 ;;^UTILITY(U,$J,358.3,7839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7839,1,3,0)
 ;;=3^Barrett's esophagus w/ high grade dysplasia
 ;;^UTILITY(U,$J,358.3,7839,1,4,0)
 ;;=4^K22.711
 ;;^UTILITY(U,$J,358.3,7839,2)
 ;;=^5008513
 ;;^UTILITY(U,$J,358.3,7840,0)
 ;;=K44.9^^45^443^8
 ;;^UTILITY(U,$J,358.3,7840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7840,1,3,0)
 ;;=3^Diaphragmatic (Hiatal) hernia
 ;;^UTILITY(U,$J,358.3,7840,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,7840,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,7841,0)
 ;;=Q39.4^^45^443^15
 ;;^UTILITY(U,$J,358.3,7841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7841,1,3,0)
 ;;=3^Esophageal web
 ;;^UTILITY(U,$J,358.3,7841,1,4,0)
 ;;=4^Q39.4
 ;;^UTILITY(U,$J,358.3,7841,2)
 ;;=^5018659
 ;;^UTILITY(U,$J,358.3,7842,0)
 ;;=T18.128A^^45^443^17
 ;;^UTILITY(U,$J,358.3,7842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7842,1,3,0)
 ;;=3^Food in Esophagus,Initial
 ;;^UTILITY(U,$J,358.3,7842,1,4,0)
 ;;=4^T18.128A
 ;;^UTILITY(U,$J,358.3,7842,2)
 ;;=^5046594
 ;;^UTILITY(U,$J,358.3,7843,0)
 ;;=T18.198A^^45^443^20
 ;;^UTILITY(U,$J,358.3,7843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7843,1,3,0)
 ;;=3^Foreign body in Esophagus,Initial
 ;;^UTILITY(U,$J,358.3,7843,1,4,0)
 ;;=4^T18.198A
 ;;^UTILITY(U,$J,358.3,7843,2)
 ;;=^5046600
 ;;^UTILITY(U,$J,358.3,7844,0)
 ;;=K20.8^^45^443^16
 ;;^UTILITY(U,$J,358.3,7844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7844,1,3,0)
 ;;=3^Esophagitis,Other
 ;;^UTILITY(U,$J,358.3,7844,1,4,0)
 ;;=4^K20.8
 ;;^UTILITY(U,$J,358.3,7844,2)
 ;;=^295748
 ;;^UTILITY(U,$J,358.3,7845,0)
 ;;=R93.3^^45^443^1
 ;;^UTILITY(U,$J,358.3,7845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7845,1,3,0)
 ;;=3^Abnormal imaging Digestive tract
 ;;^UTILITY(U,$J,358.3,7845,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,7845,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,7846,0)
 ;;=K22.4^^45^443^11
 ;;^UTILITY(U,$J,358.3,7846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7846,1,3,0)
 ;;=3^Dyskinesia of Esophagus
 ;;^UTILITY(U,$J,358.3,7846,1,4,0)
 ;;=4^K22.4
 ;;^UTILITY(U,$J,358.3,7846,2)
 ;;=^37546
 ;;^UTILITY(U,$J,358.3,7847,0)
 ;;=T18.128D^^45^443^19
 ;;^UTILITY(U,$J,358.3,7847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7847,1,3,0)
 ;;=3^Food in Esophagus,Subsequent
 ;;^UTILITY(U,$J,358.3,7847,1,4,0)
 ;;=4^T18.128D
 ;;^UTILITY(U,$J,358.3,7847,2)
 ;;=^5046595
 ;;^UTILITY(U,$J,358.3,7848,0)
 ;;=T18.128S^^45^443^18
 ;;^UTILITY(U,$J,358.3,7848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7848,1,3,0)
 ;;=3^Food in Esophagus,Sequela
 ;;^UTILITY(U,$J,358.3,7848,1,4,0)
 ;;=4^T18.128S
 ;;^UTILITY(U,$J,358.3,7848,2)
 ;;=^5046596
 ;;^UTILITY(U,$J,358.3,7849,0)
 ;;=T18.198D^^45^443^22
 ;;^UTILITY(U,$J,358.3,7849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7849,1,3,0)
 ;;=3^Foreign body in Esophagus,Subsequent
 ;;^UTILITY(U,$J,358.3,7849,1,4,0)
 ;;=4^T18.198D
 ;;^UTILITY(U,$J,358.3,7849,2)
 ;;=^5046601
 ;;^UTILITY(U,$J,358.3,7850,0)
 ;;=T18.198S^^45^443^21
 ;;^UTILITY(U,$J,358.3,7850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7850,1,3,0)
 ;;=3^Foreign body in Esophagus,Sequela
 ;;^UTILITY(U,$J,358.3,7850,1,4,0)
 ;;=4^T18.198S
 ;;^UTILITY(U,$J,358.3,7850,2)
 ;;=^5046602
 ;;^UTILITY(U,$J,358.3,7851,0)
 ;;=K22.8^^45^443^26
 ;;^UTILITY(U,$J,358.3,7851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7851,1,3,0)
 ;;=3^Hemorrhage of Esophagus
 ;;^UTILITY(U,$J,358.3,7851,1,4,0)
 ;;=4^K22.8
 ;;^UTILITY(U,$J,358.3,7851,2)
 ;;=^5008515
 ;;^UTILITY(U,$J,358.3,7852,0)
 ;;=C15.3^^45^443^31
 ;;^UTILITY(U,$J,358.3,7852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7852,1,3,0)
 ;;=3^Malignant Neop,Esophagus,Upper Third
 ;;^UTILITY(U,$J,358.3,7852,1,4,0)
 ;;=4^C15.3
 ;;^UTILITY(U,$J,358.3,7852,2)
 ;;=^267059
 ;;^UTILITY(U,$J,358.3,7853,0)
 ;;=C15.4^^45^443^28
 ;;^UTILITY(U,$J,358.3,7853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7853,1,3,0)
 ;;=3^Malignant Neop,Esophagus,Middle Third
 ;;^UTILITY(U,$J,358.3,7853,1,4,0)
 ;;=4^C15.4
 ;;^UTILITY(U,$J,358.3,7853,2)
 ;;=^267060
 ;;^UTILITY(U,$J,358.3,7854,0)
 ;;=C15.5^^45^443^27
 ;;^UTILITY(U,$J,358.3,7854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7854,1,3,0)
 ;;=3^Malignant Neop,Esophagus,Lower Third
 ;;^UTILITY(U,$J,358.3,7854,1,4,0)
 ;;=4^C15.5
 ;;^UTILITY(U,$J,358.3,7854,2)
 ;;=^267061
 ;;^UTILITY(U,$J,358.3,7855,0)
 ;;=C15.8^^45^443^29
 ;;^UTILITY(U,$J,358.3,7855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7855,1,3,0)
 ;;=3^Malignant Neop,Esophagus,Overlapping Sites
 ;;^UTILITY(U,$J,358.3,7855,1,4,0)
 ;;=4^C15.8
 ;;^UTILITY(U,$J,358.3,7855,2)
 ;;=^5000918
 ;;^UTILITY(U,$J,358.3,7856,0)
 ;;=C15.9^^45^443^30
 ;;^UTILITY(U,$J,358.3,7856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7856,1,3,0)
 ;;=3^Malignant Neop,Esophagus,Unspec
 ;;^UTILITY(U,$J,358.3,7856,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,7856,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,7857,0)
 ;;=K22.2^^45^443^32
 ;;^UTILITY(U,$J,358.3,7857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7857,1,3,0)
 ;;=3^Obstruction of Esophagus
 ;;^UTILITY(U,$J,358.3,7857,1,4,0)
 ;;=4^K22.2
 ;;^UTILITY(U,$J,358.3,7857,2)
 ;;=^5008507
 ;;^UTILITY(U,$J,358.3,7858,0)
 ;;=K22.3^^45^443^33
 ;;^UTILITY(U,$J,358.3,7858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7858,1,3,0)
 ;;=3^Perforation of Esophagus
 ;;^UTILITY(U,$J,358.3,7858,1,4,0)
 ;;=4^K22.3
 ;;^UTILITY(U,$J,358.3,7858,2)
 ;;=^5008508
 ;;^UTILITY(U,$J,358.3,7859,0)
 ;;=T54.3X1A^^45^443^37
 ;;^UTILITY(U,$J,358.3,7859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7859,1,3,0)
 ;;=3^Toxic Alkali Injury,Accidental,Initial
 ;;^UTILITY(U,$J,358.3,7859,1,4,0)
 ;;=4^T54.3X1A
 ;;^UTILITY(U,$J,358.3,7859,2)
 ;;=^5052610
 ;;^UTILITY(U,$J,358.3,7860,0)
 ;;=T54.3X1D^^45^443^39
 ;;^UTILITY(U,$J,358.3,7860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7860,1,3,0)
 ;;=3^Toxic Alkali Injury,Accidental,Subsequent
 ;;^UTILITY(U,$J,358.3,7860,1,4,0)
 ;;=4^T54.3X1D
 ;;^UTILITY(U,$J,358.3,7860,2)
 ;;=^5052611
 ;;^UTILITY(U,$J,358.3,7861,0)
 ;;=T54.3X1S^^45^443^38
 ;;^UTILITY(U,$J,358.3,7861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7861,1,3,0)
 ;;=3^Toxic Alkali Injury,Accidental,Sequela
 ;;^UTILITY(U,$J,358.3,7861,1,4,0)
 ;;=4^T54.3X1S
 ;;^UTILITY(U,$J,358.3,7861,2)
 ;;=^5052612
 ;;^UTILITY(U,$J,358.3,7862,0)
 ;;=T54.2X1A^^45^443^34
 ;;^UTILITY(U,$J,358.3,7862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7862,1,3,0)
 ;;=3^Toxic Acid Injury,Accidental,Initial
 ;;^UTILITY(U,$J,358.3,7862,1,4,0)
 ;;=4^T54.2X1A
 ;;^UTILITY(U,$J,358.3,7862,2)
 ;;=^5052598
 ;;^UTILITY(U,$J,358.3,7863,0)
 ;;=T54.2X1D^^45^443^36
 ;;^UTILITY(U,$J,358.3,7863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7863,1,3,0)
 ;;=3^Toxic Acid Injury,Accidental,Subsequent
 ;;^UTILITY(U,$J,358.3,7863,1,4,0)
 ;;=4^T54.2X1D
 ;;^UTILITY(U,$J,358.3,7863,2)
 ;;=^5052599
 ;;^UTILITY(U,$J,358.3,7864,0)
 ;;=T54.2X1S^^45^443^35
 ;;^UTILITY(U,$J,358.3,7864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7864,1,3,0)
 ;;=3^Toxic Acid Injury,Accidental,Sequela
 ;;^UTILITY(U,$J,358.3,7864,1,4,0)
 ;;=4^T54.2X1S
 ;;^UTILITY(U,$J,358.3,7864,2)
 ;;=^5052600
 ;;^UTILITY(U,$J,358.3,7865,0)
 ;;=K22.11^^45^443^40
 ;;^UTILITY(U,$J,358.3,7865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7865,1,3,0)
 ;;=3^Ulcer of Esophagus w/ Bleeding
 ;;^UTILITY(U,$J,358.3,7865,1,4,0)
 ;;=4^K22.11
 ;;^UTILITY(U,$J,358.3,7865,2)
 ;;=^329930
 ;;^UTILITY(U,$J,358.3,7866,0)
 ;;=K22.9^^45^443^9
 ;;^UTILITY(U,$J,358.3,7866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7866,1,3,0)
 ;;=3^Disease of Esophagus,Unspec
 ;;^UTILITY(U,$J,358.3,7866,1,4,0)
 ;;=4^K22.9
 ;;^UTILITY(U,$J,358.3,7866,2)
 ;;=^5008516
 ;;^UTILITY(U,$J,358.3,7867,0)
 ;;=D00.1^^45^443^7
 ;;^UTILITY(U,$J,358.3,7867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7867,1,3,0)
 ;;=3^Carcinoma in Situ,Esophagus
 ;;^UTILITY(U,$J,358.3,7867,1,4,0)
 ;;=4^D00.1
 ;;^UTILITY(U,$J,358.3,7867,2)
 ;;=^267710
 ;;^UTILITY(U,$J,358.3,7868,0)
 ;;=D12.5^^45^444^12
 ;;^UTILITY(U,$J,358.3,7868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7868,1,3,0)
 ;;=3^Benign neoplasm,Sigmoid
 ;;^UTILITY(U,$J,358.3,7868,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,7868,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,7869,0)
 ;;=D12.4^^45^444^9
 ;;^UTILITY(U,$J,358.3,7869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7869,1,3,0)
 ;;=3^Benign neoplasm,Descending
 ;;^UTILITY(U,$J,358.3,7869,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,7869,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,7870,0)
 ;;=D12.2^^45^444^7
 ;;^UTILITY(U,$J,358.3,7870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7870,1,3,0)
 ;;=3^Benign neoplasm,Ascending
 ;;^UTILITY(U,$J,358.3,7870,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,7870,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,7871,0)
 ;;=D12.3^^45^444^13
 ;;^UTILITY(U,$J,358.3,7871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7871,1,3,0)
 ;;=3^Benign neoplasm,Transverse
 ;;^UTILITY(U,$J,358.3,7871,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,7871,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,7872,0)
 ;;=D12.6^^45^444^14
 ;;^UTILITY(U,$J,358.3,7872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7872,1,3,0)
 ;;=3^Benign neoplasm,Unspec Colon
 ;;^UTILITY(U,$J,358.3,7872,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,7872,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,7873,0)
 ;;=D12.1^^45^444^6
 ;;^UTILITY(U,$J,358.3,7873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7873,1,3,0)
 ;;=3^Benign neoplasm,Appendix
 ;;^UTILITY(U,$J,358.3,7873,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,7873,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,7874,0)
 ;;=D12.0^^45^444^8
 ;;^UTILITY(U,$J,358.3,7874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7874,1,3,0)
 ;;=3^Benign neoplasm,Cecum
 ;;^UTILITY(U,$J,358.3,7874,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,7874,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,7875,0)
 ;;=D12.7^^45^444^10
 ;;^UTILITY(U,$J,358.3,7875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7875,1,3,0)
 ;;=3^Benign neoplasm,Rectosigmoid
 ;;^UTILITY(U,$J,358.3,7875,1,4,0)
 ;;=4^D12.7
 ;;^UTILITY(U,$J,358.3,7875,2)
 ;;=^5001970
 ;;^UTILITY(U,$J,358.3,7876,0)
 ;;=D12.8^^45^444^11
 ;;^UTILITY(U,$J,358.3,7876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7876,1,3,0)
 ;;=3^Benign neoplasm,Rectum
 ;;^UTILITY(U,$J,358.3,7876,1,4,0)
 ;;=4^D12.8
 ;;^UTILITY(U,$J,358.3,7876,2)
 ;;=^5001971
 ;;^UTILITY(U,$J,358.3,7877,0)
 ;;=K57.30^^45^444^28
 ;;^UTILITY(U,$J,358.3,7877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7877,1,3,0)
 ;;=3^Diverticulosis of Colon w/o Bleeding
 ;;^UTILITY(U,$J,358.3,7877,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,7877,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,7878,0)
 ;;=K57.20^^45^444^23
 ;;^UTILITY(U,$J,358.3,7878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7878,1,3,0)
 ;;=3^Diverticulitis of Colon w/ Perf & Abscess
 ;;^UTILITY(U,$J,358.3,7878,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,7878,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,7879,0)
 ;;=K57.32^^45^444^26
 ;;^UTILITY(U,$J,358.3,7879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7879,1,3,0)
 ;;=3^Diverticulitis of Colon,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7879,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,7879,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,7880,0)
 ;;=K55.20^^45^444^5
 ;;^UTILITY(U,$J,358.3,7880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7880,1,3,0)
 ;;=3^Angiodysplasia of Colon w/o Bleeding
 ;;^UTILITY(U,$J,358.3,7880,1,4,0)
 ;;=4^K55.20
 ;;^UTILITY(U,$J,358.3,7880,2)
 ;;=^5008707
 ;;^UTILITY(U,$J,358.3,7881,0)
 ;;=K52.21^^45^444^2
 ;;^UTILITY(U,$J,358.3,7881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7881,1,3,0)
 ;;=3^Allergic/Dietetic Gastroenteritis/Colitis,Food Protein
 ;;^UTILITY(U,$J,358.3,7881,1,4,0)
 ;;=4^K52.21
 ;;^UTILITY(U,$J,358.3,7881,2)
 ;;=^5138713
 ;;^UTILITY(U,$J,358.3,7882,0)
 ;;=K52.29^^45^444^3
 ;;^UTILITY(U,$J,358.3,7882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7882,1,3,0)
 ;;=3^Allergic/Dietetic Gastroenteritis/Colitis,Other
 ;;^UTILITY(U,$J,358.3,7882,1,4,0)
 ;;=4^K52.29
 ;;^UTILITY(U,$J,358.3,7882,2)
 ;;=^5138715
 ;;^UTILITY(U,$J,358.3,7883,0)
 ;;=R93.3^^45^444^1
 ;;^UTILITY(U,$J,358.3,7883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7883,1,3,0)
 ;;=3^Abnormal imaging Digestive tract
 ;;^UTILITY(U,$J,358.3,7883,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,7883,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,7884,0)
 ;;=K55.21^^45^444^4
 ;;^UTILITY(U,$J,358.3,7884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7884,1,3,0)
 ;;=3^Angiodysplasia of Colon w/ Bleeding
 ;;^UTILITY(U,$J,358.3,7884,1,4,0)
 ;;=4^K55.21
 ;;^UTILITY(U,$J,358.3,7884,2)
 ;;=^5008708
 ;;^UTILITY(U,$J,358.3,7885,0)
 ;;=D01.0^^45^444^15
 ;;^UTILITY(U,$J,358.3,7885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7885,1,3,0)
 ;;=3^Carcinoma in situ of Colon
 ;;^UTILITY(U,$J,358.3,7885,1,4,0)
 ;;=4^D01.0
 ;;^UTILITY(U,$J,358.3,7885,2)
 ;;=^267712
 ;;^UTILITY(U,$J,358.3,7886,0)
 ;;=D01.2^^45^444^16
 ;;^UTILITY(U,$J,358.3,7886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7886,1,3,0)
 ;;=3^Carcinoma in situ of Rectum
 ;;^UTILITY(U,$J,358.3,7886,1,4,0)
 ;;=4^D01.2
 ;;^UTILITY(U,$J,358.3,7886,2)
 ;;=^267713
 ;;^UTILITY(U,$J,358.3,7887,0)
 ;;=K52.831^^45^444^20
 ;;^UTILITY(U,$J,358.3,7887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7887,1,3,0)
 ;;=3^Collagenous colitis
 ;;^UTILITY(U,$J,358.3,7887,1,4,0)
 ;;=4^K52.831
 ;;^UTILITY(U,$J,358.3,7887,2)
 ;;=^7034137
 ;;^UTILITY(U,$J,358.3,7888,0)
 ;;=K63.81^^45^444^21
 ;;^UTILITY(U,$J,358.3,7888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7888,1,3,0)
 ;;=3^Dieulafoy lesion of Intestine
 ;;^UTILITY(U,$J,358.3,7888,1,4,0)
 ;;=4^K63.81
 ;;^UTILITY(U,$J,358.3,7888,2)
 ;;=^5008766
 ;;^UTILITY(U,$J,358.3,7889,0)
 ;;=K57.31^^45^444^27
 ;;^UTILITY(U,$J,358.3,7889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7889,1,3,0)
 ;;=3^Diverticulosis of Colon w/ Bleeding
 ;;^UTILITY(U,$J,358.3,7889,1,4,0)
 ;;=4^K57.31
 ;;^UTILITY(U,$J,358.3,7889,2)
 ;;=^5008724
 ;;^UTILITY(U,$J,358.3,7890,0)
 ;;=K57.21^^45^444^24
 ;;^UTILITY(U,$J,358.3,7890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7890,1,3,0)
 ;;=3^Diverticulitis of Colon w/ Perf,Abscess & Bleed
 ;;^UTILITY(U,$J,358.3,7890,1,4,0)
 ;;=4^K57.21
 ;;^UTILITY(U,$J,358.3,7890,2)
 ;;=^5008722
 ;;^UTILITY(U,$J,358.3,7891,0)
 ;;=K52.82^^45^444^29
 ;;^UTILITY(U,$J,358.3,7891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7891,1,3,0)
 ;;=3^Eosinophilic colitis
 ;;^UTILITY(U,$J,358.3,7891,1,4,0)
 ;;=4^K52.82
 ;;^UTILITY(U,$J,358.3,7891,2)
 ;;=^336608
 ;;^UTILITY(U,$J,358.3,7892,0)
 ;;=K56.41^^45^444^30
 ;;^UTILITY(U,$J,358.3,7892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7892,1,3,0)
 ;;=3^Fecal impaction
 ;;^UTILITY(U,$J,358.3,7892,1,4,0)
 ;;=4^K56.41
 ;;^UTILITY(U,$J,358.3,7892,2)
 ;;=^186798
 ;;^UTILITY(U,$J,358.3,7893,0)
 ;;=T18.4XXA^^45^444^32
 ;;^UTILITY(U,$J,358.3,7893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7893,1,3,0)
 ;;=3^Foreign Body in Colon,Initial
 ;;^UTILITY(U,$J,358.3,7893,1,4,0)
 ;;=4^T18.4XXA
 ;;^UTILITY(U,$J,358.3,7893,2)
 ;;=^5046609
 ;;^UTILITY(U,$J,358.3,7894,0)
 ;;=T18.4XXD^^45^444^33
 ;;^UTILITY(U,$J,358.3,7894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7894,1,3,0)
 ;;=3^Foreign Body in Colon,Subsequent
 ;;^UTILITY(U,$J,358.3,7894,1,4,0)
 ;;=4^T18.4XXD
 ;;^UTILITY(U,$J,358.3,7894,2)
 ;;=^5046610
 ;;^UTILITY(U,$J,358.3,7895,0)
 ;;=K56.0^^45^444^34
 ;;^UTILITY(U,$J,358.3,7895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7895,1,3,0)
 ;;=3^Ileus
 ;;^UTILITY(U,$J,358.3,7895,1,4,0)
 ;;=4^K56.0
 ;;^UTILITY(U,$J,358.3,7895,2)
 ;;=^89879
 ;;^UTILITY(U,$J,358.3,7896,0)
 ;;=K55.031^^45^444^36
 ;;^UTILITY(U,$J,358.3,7896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7896,1,3,0)
 ;;=3^Ischemic colitis,Segmental
 ;;^UTILITY(U,$J,358.3,7896,1,4,0)
 ;;=4^K55.031
 ;;^UTILITY(U,$J,358.3,7896,2)
 ;;=^5138725
 ;;^UTILITY(U,$J,358.3,7897,0)
 ;;=K55.032^^45^444^35
 ;;^UTILITY(U,$J,358.3,7897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7897,1,3,0)
 ;;=3^Ischemic colitis,Diffuse
 ;;^UTILITY(U,$J,358.3,7897,1,4,0)
 ;;=4^K55.032
 ;;^UTILITY(U,$J,358.3,7897,2)
 ;;=^5138726
 ;;^UTILITY(U,$J,358.3,7898,0)
 ;;=K52.832^^45^444^37
 ;;^UTILITY(U,$J,358.3,7898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7898,1,3,0)
 ;;=3^Lymphocytic Colitis
 ;;^UTILITY(U,$J,358.3,7898,1,4,0)
 ;;=4^K52.832
 ;;^UTILITY(U,$J,358.3,7898,2)
 ;;=^5138716
 ;;^UTILITY(U,$J,358.3,7899,0)
 ;;=C18.1^^45^444^38
 ;;^UTILITY(U,$J,358.3,7899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7899,1,3,0)
 ;;=3^Malignant neoplasm,Appendix
 ;;^UTILITY(U,$J,358.3,7899,1,4,0)
 ;;=4^C18.1
 ;;^UTILITY(U,$J,358.3,7899,2)
 ;;=^5000927
 ;;^UTILITY(U,$J,358.3,7900,0)
 ;;=C18.0^^45^444^40
 ;;^UTILITY(U,$J,358.3,7900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7900,1,3,0)
 ;;=3^Malignant neoplasm,Cecum
 ;;^UTILITY(U,$J,358.3,7900,1,4,0)
 ;;=4^C18.0
 ;;^UTILITY(U,$J,358.3,7900,2)
 ;;=c182^267083
 ;;^UTILITY(U,$J,358.3,7901,0)
 ;;=C18.2^^45^444^39
 ;;^UTILITY(U,$J,358.3,7901,1,0)
 ;;=^358.31IA^4^2
