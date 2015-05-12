IBDEI017 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1243,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,1244,0)
 ;;=E11.65^^4^61^4
 ;;^UTILITY(U,$J,358.3,1244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1244,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,1244,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,1244,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,1245,0)
 ;;=E10.65^^4^61^2
 ;;^UTILITY(U,$J,358.3,1245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1245,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,1245,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,1245,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,1246,0)
 ;;=R73.09^^4^61^1
 ;;^UTILITY(U,$J,358.3,1246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1246,1,3,0)
 ;;=3^Abnormal Glucose
 ;;^UTILITY(U,$J,358.3,1246,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,1246,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,1247,0)
 ;;=Z79.4^^4^61^6
 ;;^UTILITY(U,$J,358.3,1247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1247,1,3,0)
 ;;=3^Long Term (Current) Use of Insulin
 ;;^UTILITY(U,$J,358.3,1247,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,1247,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,1248,0)
 ;;=E66.9^^4^62^2
 ;;^UTILITY(U,$J,358.3,1248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1248,1,3,0)
 ;;=3^Obesity,Unspec
 ;;^UTILITY(U,$J,358.3,1248,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,1248,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,1249,0)
 ;;=E66.01^^4^62^1
 ;;^UTILITY(U,$J,358.3,1249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1249,1,3,0)
 ;;=3^Morbid Obesity d/t Excess Calories
 ;;^UTILITY(U,$J,358.3,1249,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,1249,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,1250,0)
 ;;=E66.3^^4^62^3
 ;;^UTILITY(U,$J,358.3,1250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1250,1,3,0)
 ;;=3^Overweight
 ;;^UTILITY(U,$J,358.3,1250,1,4,0)
 ;;=4^E66.3
 ;;^UTILITY(U,$J,358.3,1250,2)
 ;;=^5002830
 ;;^UTILITY(U,$J,358.3,1251,0)
 ;;=G40.A01^^5^63^3
 ;;^UTILITY(U,$J,358.3,1251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1251,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1251,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,1251,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,1252,0)
 ;;=G40.A09^^5^63^4
 ;;^UTILITY(U,$J,358.3,1252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1252,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1252,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,1252,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,1253,0)
 ;;=G40.A11^^5^63^1
 ;;^UTILITY(U,$J,358.3,1253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1253,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1253,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,1253,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,1254,0)
 ;;=G40.A19^^5^63^2
 ;;^UTILITY(U,$J,358.3,1254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1254,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1254,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,1254,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,1255,0)
 ;;=G40.309^^5^63^17
 ;;^UTILITY(U,$J,358.3,1255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1255,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1255,1,4,0)
 ;;=4^G40.309
 ;;^UTILITY(U,$J,358.3,1255,2)
 ;;=^5003842
 ;;^UTILITY(U,$J,358.3,1256,0)
 ;;=G40.311^^5^63^15
 ;;^UTILITY(U,$J,358.3,1256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1256,1,3,0)
 ;;=3^Generalized Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1256,1,4,0)
 ;;=4^G40.311
 ;;^UTILITY(U,$J,358.3,1256,2)
 ;;=^5003843
 ;;^UTILITY(U,$J,358.3,1257,0)
 ;;=G40.319^^5^63^16
 ;;^UTILITY(U,$J,358.3,1257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1257,1,3,0)
 ;;=3^Generalized Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1257,1,4,0)
 ;;=4^G40.319
 ;;^UTILITY(U,$J,358.3,1257,2)
 ;;=^5003844
 ;;^UTILITY(U,$J,358.3,1258,0)
 ;;=G40.409^^5^63^20
 ;;^UTILITY(U,$J,358.3,1258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1258,1,3,0)
 ;;=3^Generalized Seizures,Other, Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1258,1,4,0)
 ;;=4^G40.409
 ;;^UTILITY(U,$J,358.3,1258,2)
 ;;=^5003846
 ;;^UTILITY(U,$J,358.3,1259,0)
 ;;=G40.411^^5^63^18
 ;;^UTILITY(U,$J,358.3,1259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1259,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1259,1,4,0)
 ;;=4^G40.411
 ;;^UTILITY(U,$J,358.3,1259,2)
 ;;=^5003847
 ;;^UTILITY(U,$J,358.3,1260,0)
 ;;=G40.419^^5^63^19
 ;;^UTILITY(U,$J,358.3,1260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1260,1,3,0)
 ;;=3^Generalized Seizures,Other, Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1260,1,4,0)
 ;;=4^G40.419
 ;;^UTILITY(U,$J,358.3,1260,2)
 ;;=^5003848
 ;;^UTILITY(U,$J,358.3,1261,0)
 ;;=G40.209^^5^63^7
 ;;^UTILITY(U,$J,358.3,1261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1261,1,3,0)
 ;;=3^Complex Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1261,1,4,0)
 ;;=4^G40.209
 ;;^UTILITY(U,$J,358.3,1261,2)
 ;;=^5003838
 ;;^UTILITY(U,$J,358.3,1262,0)
 ;;=G40.211^^5^63^5
 ;;^UTILITY(U,$J,358.3,1262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1262,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1262,1,4,0)
 ;;=4^G40.211
 ;;^UTILITY(U,$J,358.3,1262,2)
 ;;=^5003839
 ;;^UTILITY(U,$J,358.3,1263,0)
 ;;=G40.219^^5^63^6
 ;;^UTILITY(U,$J,358.3,1263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1263,1,3,0)
 ;;=3^Complex Partial Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1263,1,4,0)
 ;;=4^G40.219
 ;;^UTILITY(U,$J,358.3,1263,2)
 ;;=^5003840
 ;;^UTILITY(U,$J,358.3,1264,0)
 ;;=G40.109^^5^63^28
 ;;^UTILITY(U,$J,358.3,1264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1264,1,3,0)
 ;;=3^Simple Partial Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1264,1,4,0)
 ;;=4^G40.109
 ;;^UTILITY(U,$J,358.3,1264,2)
 ;;=^5003834
 ;;^UTILITY(U,$J,358.3,1265,0)
 ;;=G40.111^^5^63^26
 ;;^UTILITY(U,$J,358.3,1265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1265,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1265,1,4,0)
 ;;=4^G40.111
 ;;^UTILITY(U,$J,358.3,1265,2)
 ;;=^5003835
 ;;^UTILITY(U,$J,358.3,1266,0)
 ;;=G40.119^^5^63^27
 ;;^UTILITY(U,$J,358.3,1266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1266,1,3,0)
 ;;=3^Simple Partial Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1266,1,4,0)
 ;;=4^G40.119
 ;;^UTILITY(U,$J,358.3,1266,2)
 ;;=^5003836
 ;;^UTILITY(U,$J,358.3,1267,0)
 ;;=G40.B09^^5^63^23
 ;;^UTILITY(U,$J,358.3,1267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1267,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1267,1,4,0)
 ;;=4^G40.B09
 ;;^UTILITY(U,$J,358.3,1267,2)
 ;;=^5003873
 ;;^UTILITY(U,$J,358.3,1268,0)
 ;;=G40.B11^^5^63^21
 ;;^UTILITY(U,$J,358.3,1268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1268,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1268,1,4,0)
 ;;=4^G40.B11
 ;;^UTILITY(U,$J,358.3,1268,2)
 ;;=^5003874
 ;;^UTILITY(U,$J,358.3,1269,0)
 ;;=G40.B19^^5^63^22
 ;;^UTILITY(U,$J,358.3,1269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1269,1,3,0)
 ;;=3^Juvenile Myoclonic Epilepsy Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1269,1,4,0)
 ;;=4^G40.B19
 ;;^UTILITY(U,$J,358.3,1269,2)
 ;;=^5003875
 ;;^UTILITY(U,$J,358.3,1270,0)
 ;;=G40.509^^5^63^14
 ;;^UTILITY(U,$J,358.3,1270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1270,1,3,0)
 ;;=3^Epileptic Seizures d/t External Causes Not Intractalbe w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1270,1,4,0)
 ;;=4^G40.509
 ;;^UTILITY(U,$J,358.3,1270,2)
 ;;=^5003850
 ;;^UTILITY(U,$J,358.3,1271,0)
 ;;=G40.909^^5^63^13
 ;;^UTILITY(U,$J,358.3,1271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1271,1,3,0)
 ;;=3^Epilepsy Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,1271,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,1271,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,1272,0)
 ;;=G40.911^^5^63^10
 ;;^UTILITY(U,$J,358.3,1272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1272,1,3,0)
 ;;=3^Epilepsy Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,1272,1,4,0)
 ;;=4^G40.911
 ;;^UTILITY(U,$J,358.3,1272,2)
 ;;=^5003866
 ;;^UTILITY(U,$J,358.3,1273,0)
 ;;=G40.919^^5^63^11
 ;;^UTILITY(U,$J,358.3,1273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1273,1,3,0)
 ;;=3^Epilepsy Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,1273,1,4,0)
 ;;=4^G40.919
 ;;^UTILITY(U,$J,358.3,1273,2)
 ;;=^5003867
 ;;^UTILITY(U,$J,358.3,1274,0)
 ;;=G93.81^^5^63^24
 ;;^UTILITY(U,$J,358.3,1274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1274,1,3,0)
 ;;=3^Mesial Temporal Sclerosis
 ;;^UTILITY(U,$J,358.3,1274,1,4,0)
 ;;=4^G93.81
 ;;^UTILITY(U,$J,358.3,1274,2)
 ;;=^338233
 ;;^UTILITY(U,$J,358.3,1275,0)
 ;;=F44.5^^5^63^8
 ;;^UTILITY(U,$J,358.3,1275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1275,1,3,0)
 ;;=3^Conversion Disorder w/ Seizures/Convulsions
 ;;^UTILITY(U,$J,358.3,1275,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,1275,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,1276,0)
 ;;=R40.4^^5^63^31
 ;;^UTILITY(U,$J,358.3,1276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1276,1,3,0)
 ;;=3^Transient Alteration of Awareness
 ;;^UTILITY(U,$J,358.3,1276,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,1276,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,1277,0)
 ;;=R40.1^^5^63^30
 ;;^UTILITY(U,$J,358.3,1277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1277,1,3,0)
 ;;=3^Stupor
 ;;^UTILITY(U,$J,358.3,1277,1,4,0)
 ;;=4^R40.1
 ;;^UTILITY(U,$J,358.3,1277,2)
 ;;=^5019353
 ;;^UTILITY(U,$J,358.3,1278,0)
 ;;=R40.0^^5^63^29
 ;;^UTILITY(U,$J,358.3,1278,1,0)
 ;;=^358.31IA^4^2
