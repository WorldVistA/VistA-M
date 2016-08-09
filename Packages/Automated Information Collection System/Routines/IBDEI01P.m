IBDEI01P ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1206,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,1207,0)
 ;;=C32.9^^9^110^6
 ;;^UTILITY(U,$J,358.3,1207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1207,1,3,0)
 ;;=3^Malig Neop Larynx,Unspec
 ;;^UTILITY(U,$J,358.3,1207,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,1207,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,1208,0)
 ;;=C34.91^^9^110^11
 ;;^UTILITY(U,$J,358.3,1208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1208,1,3,0)
 ;;=3^Malig Neop Right Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,1208,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,1208,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,1209,0)
 ;;=C34.92^^9^110^7
 ;;^UTILITY(U,$J,358.3,1209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1209,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,1209,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,1209,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,1210,0)
 ;;=C44.91^^9^110^1
 ;;^UTILITY(U,$J,358.3,1210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1210,1,3,0)
 ;;=3^Basal Cell Carcinoma Skin,Unspec
 ;;^UTILITY(U,$J,358.3,1210,1,4,0)
 ;;=4^C44.91
 ;;^UTILITY(U,$J,358.3,1210,2)
 ;;=^5001092
 ;;^UTILITY(U,$J,358.3,1211,0)
 ;;=C44.99^^9^110^14
 ;;^UTILITY(U,$J,358.3,1211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1211,1,3,0)
 ;;=3^Malig Neop Skin,Other Spec
 ;;^UTILITY(U,$J,358.3,1211,1,4,0)
 ;;=4^C44.99
 ;;^UTILITY(U,$J,358.3,1211,2)
 ;;=^5001094
 ;;^UTILITY(U,$J,358.3,1212,0)
 ;;=C50.912^^9^110^8
 ;;^UTILITY(U,$J,358.3,1212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1212,1,3,0)
 ;;=3^Malig Neop Left Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,1212,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,1212,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,1213,0)
 ;;=C50.911^^9^110^12
 ;;^UTILITY(U,$J,358.3,1213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1213,1,3,0)
 ;;=3^Malig Neop Right Female Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,1213,1,4,0)
 ;;=4^C50.911
 ;;^UTILITY(U,$J,358.3,1213,2)
 ;;=^5001195
 ;;^UTILITY(U,$J,358.3,1214,0)
 ;;=C61.^^9^110^10
 ;;^UTILITY(U,$J,358.3,1214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1214,1,3,0)
 ;;=3^Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,1214,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,1214,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,1215,0)
 ;;=C67.9^^9^110^3
 ;;^UTILITY(U,$J,358.3,1215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1215,1,3,0)
 ;;=3^Malig Neop Bladder,Unspec
 ;;^UTILITY(U,$J,358.3,1215,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,1215,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,1216,0)
 ;;=C64.2^^9^110^9
 ;;^UTILITY(U,$J,358.3,1216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1216,1,3,0)
 ;;=3^Malig Neop Left Kidney,Except Renal Pelvis
 ;;^UTILITY(U,$J,358.3,1216,1,4,0)
 ;;=4^C64.2
 ;;^UTILITY(U,$J,358.3,1216,2)
 ;;=^5001249
 ;;^UTILITY(U,$J,358.3,1217,0)
 ;;=C64.1^^9^110^13
 ;;^UTILITY(U,$J,358.3,1217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1217,1,3,0)
 ;;=3^Malig Neop Right Kidney,Except Renal Pelvis
 ;;^UTILITY(U,$J,358.3,1217,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,1217,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,1218,0)
 ;;=C79.51^^9^110^16
 ;;^UTILITY(U,$J,358.3,1218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1218,1,3,0)
 ;;=3^Secondary Malig Neop Bone
 ;;^UTILITY(U,$J,358.3,1218,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,1218,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,1219,0)
 ;;=C79.52^^9^110^17
 ;;^UTILITY(U,$J,358.3,1219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1219,1,3,0)
 ;;=3^Secondary Malig Neop Bone Marrow
 ;;^UTILITY(U,$J,358.3,1219,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,1219,2)
 ;;=^5001351
 ;;^UTILITY(U,$J,358.3,1220,0)
 ;;=Z12.9^^9^110^15
 ;;^UTILITY(U,$J,358.3,1220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1220,1,3,0)
 ;;=3^Screening Malig Neop Site Unspec
 ;;^UTILITY(U,$J,358.3,1220,1,4,0)
 ;;=4^Z12.9
 ;;^UTILITY(U,$J,358.3,1220,2)
 ;;=^5062698
 ;;^UTILITY(U,$J,358.3,1221,0)
 ;;=D17.9^^9^110^2
 ;;^UTILITY(U,$J,358.3,1221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1221,1,3,0)
 ;;=3^Benign Neop Lipomatous,Unspec
 ;;^UTILITY(U,$J,358.3,1221,1,4,0)
 ;;=4^D17.9
 ;;^UTILITY(U,$J,358.3,1221,2)
 ;;=^5002020
 ;;^UTILITY(U,$J,358.3,1222,0)
 ;;=E11.9^^9^111^15
 ;;^UTILITY(U,$J,358.3,1222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1222,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,1222,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,1222,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,1223,0)
 ;;=E10.9^^9^111^12
 ;;^UTILITY(U,$J,358.3,1223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1223,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,1223,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,1223,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,1224,0)
 ;;=E11.65^^9^111^14
 ;;^UTILITY(U,$J,358.3,1224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1224,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,1224,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,1224,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,1225,0)
 ;;=E10.65^^9^111^11
 ;;^UTILITY(U,$J,358.3,1225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1225,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,1225,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,1225,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,1226,0)
 ;;=E86.0^^9^111^1
 ;;^UTILITY(U,$J,358.3,1226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1226,1,3,0)
 ;;=3^Dehydration
 ;;^UTILITY(U,$J,358.3,1226,1,4,0)
 ;;=4^E86.0
 ;;^UTILITY(U,$J,358.3,1226,2)
 ;;=^332743
 ;;^UTILITY(U,$J,358.3,1227,0)
 ;;=F03.90^^9^111^4
 ;;^UTILITY(U,$J,358.3,1227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1227,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,1227,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,1227,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,1228,0)
 ;;=F02.80^^9^111^3
 ;;^UTILITY(U,$J,358.3,1228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1228,1,3,0)
 ;;=3^Dementia in Oth Diseases w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,1228,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,1228,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,1229,0)
 ;;=F02.81^^9^111^2
 ;;^UTILITY(U,$J,358.3,1229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1229,1,3,0)
 ;;=3^Dementia in Oth Diseases w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,1229,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,1229,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,1230,0)
 ;;=F32.9^^9^111^6
 ;;^UTILITY(U,$J,358.3,1230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1230,1,3,0)
 ;;=3^Depressive Disorder,Major,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,1230,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,1230,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,1231,0)
 ;;=K57.30^^9^111^19
 ;;^UTILITY(U,$J,358.3,1231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1231,1,3,0)
 ;;=3^Diverticulosis Lg Intest w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,1231,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,1231,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,1232,0)
 ;;=R42.^^9^111^20
 ;;^UTILITY(U,$J,358.3,1232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1232,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,1232,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,1232,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,1233,0)
 ;;=R06.00^^9^111^24
 ;;^UTILITY(U,$J,358.3,1233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1233,1,3,0)
 ;;=3^Dyspnea,Unspec
 ;;^UTILITY(U,$J,358.3,1233,1,4,0)
 ;;=4^R06.00
 ;;^UTILITY(U,$J,358.3,1233,2)
 ;;=^5019180
 ;;^UTILITY(U,$J,358.3,1234,0)
 ;;=R13.10^^9^111^23
 ;;^UTILITY(U,$J,358.3,1234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1234,1,3,0)
 ;;=3^Dysphagia,Unspec
 ;;^UTILITY(U,$J,358.3,1234,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,1234,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,1235,0)
 ;;=R19.7^^9^111^18
 ;;^UTILITY(U,$J,358.3,1235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1235,1,3,0)
 ;;=3^Diarrhea,Unspec
