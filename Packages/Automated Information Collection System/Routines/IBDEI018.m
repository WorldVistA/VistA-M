IBDEI018 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1278,1,3,0)
 ;;=3^Somnolence
 ;;^UTILITY(U,$J,358.3,1278,1,4,0)
 ;;=4^R40.0
 ;;^UTILITY(U,$J,358.3,1278,2)
 ;;=^5019352
 ;;^UTILITY(U,$J,358.3,1279,0)
 ;;=R56.9^^5^63^9
 ;;^UTILITY(U,$J,358.3,1279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1279,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,1279,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,1279,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,1280,0)
 ;;=R56.1^^5^63^25
 ;;^UTILITY(U,$J,358.3,1280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1280,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,1280,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,1280,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,1281,0)
 ;;=G40.901^^5^63^12
 ;;^UTILITY(U,$J,358.3,1281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1281,1,3,0)
 ;;=3^Epilepsy Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,1281,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,1281,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,1282,0)
 ;;=G45.0^^5^64^18
 ;;^UTILITY(U,$J,358.3,1282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1282,1,3,0)
 ;;=3^Vertebro-Basilar Artery Syndrome
 ;;^UTILITY(U,$J,358.3,1282,1,4,0)
 ;;=4^G45.0
 ;;^UTILITY(U,$J,358.3,1282,2)
 ;;=^5003955
 ;;^UTILITY(U,$J,358.3,1283,0)
 ;;=G45.1^^5^64^4
 ;;^UTILITY(U,$J,358.3,1283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1283,1,3,0)
 ;;=3^Carotid Artery Syndrome
 ;;^UTILITY(U,$J,358.3,1283,1,4,0)
 ;;=4^G45.1
 ;;^UTILITY(U,$J,358.3,1283,2)
 ;;=^5003956
 ;;^UTILITY(U,$J,358.3,1284,0)
 ;;=G45.3^^5^64^1
 ;;^UTILITY(U,$J,358.3,1284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1284,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,1284,1,4,0)
 ;;=4^G45.3
 ;;^UTILITY(U,$J,358.3,1284,2)
 ;;=^304129
 ;;^UTILITY(U,$J,358.3,1285,0)
 ;;=G45.4^^5^64^16
 ;;^UTILITY(U,$J,358.3,1285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1285,1,3,0)
 ;;=3^Transient Global Amnesia
 ;;^UTILITY(U,$J,358.3,1285,1,4,0)
 ;;=4^G45.4
 ;;^UTILITY(U,$J,358.3,1285,2)
 ;;=^293883
 ;;^UTILITY(U,$J,358.3,1286,0)
 ;;=G45.8^^5^64^14
 ;;^UTILITY(U,$J,358.3,1286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1286,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Other
 ;;^UTILITY(U,$J,358.3,1286,1,4,0)
 ;;=4^G45.8
 ;;^UTILITY(U,$J,358.3,1286,2)
 ;;=^5003958
 ;;^UTILITY(U,$J,358.3,1287,0)
 ;;=G45.9^^5^64^15
 ;;^UTILITY(U,$J,358.3,1287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1287,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attacks,Unspec
 ;;^UTILITY(U,$J,358.3,1287,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,1287,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,1288,0)
 ;;=G46.0^^5^64^7
 ;;^UTILITY(U,$J,358.3,1288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1288,1,3,0)
 ;;=3^Middle Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,1288,1,4,0)
 ;;=4^G46.0
 ;;^UTILITY(U,$J,358.3,1288,2)
 ;;=^5003960
 ;;^UTILITY(U,$J,358.3,1289,0)
 ;;=G46.1^^5^64^2
 ;;^UTILITY(U,$J,358.3,1289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1289,1,3,0)
 ;;=3^Anterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,1289,1,4,0)
 ;;=4^G46.1
 ;;^UTILITY(U,$J,358.3,1289,2)
 ;;=^5003961
 ;;^UTILITY(U,$J,358.3,1290,0)
 ;;=G46.2^^5^64^11
 ;;^UTILITY(U,$J,358.3,1290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1290,1,3,0)
 ;;=3^Posterior Cerebral Artery Syndrome
 ;;^UTILITY(U,$J,358.3,1290,1,4,0)
 ;;=4^G46.2
 ;;^UTILITY(U,$J,358.3,1290,2)
 ;;=^5003962
 ;;^UTILITY(U,$J,358.3,1291,0)
 ;;=G46.3^^5^64^3
 ;;^UTILITY(U,$J,358.3,1291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1291,1,3,0)
 ;;=3^Brain Stem Stroke Syndrome
 ;;^UTILITY(U,$J,358.3,1291,1,4,0)
 ;;=4^G46.3
 ;;^UTILITY(U,$J,358.3,1291,2)
 ;;=^5003963
 ;;^UTILITY(U,$J,358.3,1292,0)
 ;;=G46.7^^5^64^6
 ;;^UTILITY(U,$J,358.3,1292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1292,1,3,0)
 ;;=3^Lacunar Syndromes,Other
 ;;^UTILITY(U,$J,358.3,1292,1,4,0)
 ;;=4^G46.7
 ;;^UTILITY(U,$J,358.3,1292,2)
 ;;=^5003967
 ;;^UTILITY(U,$J,358.3,1293,0)
 ;;=G46.8^^5^64^17
 ;;^UTILITY(U,$J,358.3,1293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1293,1,3,0)
 ;;=3^Vascular Syndromes of Brain in CVD,Other
 ;;^UTILITY(U,$J,358.3,1293,1,4,0)
 ;;=4^G46.8
 ;;^UTILITY(U,$J,358.3,1293,2)
 ;;=^5003968
 ;;^UTILITY(U,$J,358.3,1294,0)
 ;;=Z86.73^^5^64^10
 ;;^UTILITY(U,$J,358.3,1294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1294,1,3,0)
 ;;=3^Personal Hx of TIA/Cerebral Inf w/o Resid Deficits
 ;;^UTILITY(U,$J,358.3,1294,1,4,0)
 ;;=4^Z86.73
 ;;^UTILITY(U,$J,358.3,1294,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,1295,0)
 ;;=G46.4^^5^64^5
 ;;^UTILITY(U,$J,358.3,1295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1295,1,3,0)
 ;;=3^Cerebellar Stroke Syndrome
 ;;^UTILITY(U,$J,358.3,1295,1,4,0)
 ;;=4^G46.4
 ;;^UTILITY(U,$J,358.3,1295,2)
 ;;=^5003964
 ;;^UTILITY(U,$J,358.3,1296,0)
 ;;=I65.23^^5^64^8
 ;;^UTILITY(U,$J,358.3,1296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1296,1,3,0)
 ;;=3^Occlusion & Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,1296,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,1296,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,1297,0)
 ;;=I65.29^^5^64^9
 ;;^UTILITY(U,$J,358.3,1297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1297,1,3,0)
 ;;=3^Occlusion & Stenosis of Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,1297,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,1297,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,1298,0)
 ;;=G46.5^^5^64^12
 ;;^UTILITY(U,$J,358.3,1298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1298,1,3,0)
 ;;=3^Pure Motor Lacunar Syndrome
 ;;^UTILITY(U,$J,358.3,1298,1,4,0)
 ;;=4^G46.5
 ;;^UTILITY(U,$J,358.3,1298,2)
 ;;=^5003965
 ;;^UTILITY(U,$J,358.3,1299,0)
 ;;=G46.6^^5^64^13
 ;;^UTILITY(U,$J,358.3,1299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1299,1,3,0)
 ;;=3^Pure Sensory Lacunar Syndrome
 ;;^UTILITY(U,$J,358.3,1299,1,4,0)
 ;;=4^G46.6
 ;;^UTILITY(U,$J,358.3,1299,2)
 ;;=^5003966
 ;;^UTILITY(U,$J,358.3,1300,0)
 ;;=H81.10^^5^65^2
 ;;^UTILITY(U,$J,358.3,1300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1300,1,3,0)
 ;;=3^Benign Paroxysmal Vertigo
 ;;^UTILITY(U,$J,358.3,1300,1,4,0)
 ;;=4^H81.10
 ;;^UTILITY(U,$J,358.3,1300,2)
 ;;=^5006864
 ;;^UTILITY(U,$J,358.3,1301,0)
 ;;=R42.^^5^65^3
 ;;^UTILITY(U,$J,358.3,1301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1301,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,1301,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,1301,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,1302,0)
 ;;=H81.13^^5^65^1
 ;;^UTILITY(U,$J,358.3,1302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1302,1,3,0)
 ;;=3^Benign Paroxysmal Veritgo,Bilateral
 ;;^UTILITY(U,$J,358.3,1302,1,4,0)
 ;;=4^H81.13
 ;;^UTILITY(U,$J,358.3,1302,2)
 ;;=^5006867
 ;;^UTILITY(U,$J,358.3,1303,0)
 ;;=H81.49^^5^65^4
 ;;^UTILITY(U,$J,358.3,1303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1303,1,3,0)
 ;;=3^Vertigo of Central Origin
 ;;^UTILITY(U,$J,358.3,1303,1,4,0)
 ;;=4^H81.49
 ;;^UTILITY(U,$J,358.3,1303,2)
 ;;=^5006883
 ;;^UTILITY(U,$J,358.3,1304,0)
 ;;=G92.^^5^66^6
 ;;^UTILITY(U,$J,358.3,1304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1304,1,3,0)
 ;;=3^Toxic Encephalopathy
 ;;^UTILITY(U,$J,358.3,1304,1,4,0)
 ;;=4^G92.
 ;;^UTILITY(U,$J,358.3,1304,2)
 ;;=^259061
 ;;^UTILITY(U,$J,358.3,1305,0)
 ;;=G93.1^^5^66^1
 ;;^UTILITY(U,$J,358.3,1305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1305,1,3,0)
 ;;=3^Anoxic Brain Damage NEC
 ;;^UTILITY(U,$J,358.3,1305,1,4,0)
 ;;=4^G93.1
 ;;^UTILITY(U,$J,358.3,1305,2)
 ;;=^5004179
 ;;^UTILITY(U,$J,358.3,1306,0)
 ;;=F05.^^5^66^2
 ;;^UTILITY(U,$J,358.3,1306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1306,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,1306,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,1306,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,1307,0)
 ;;=G93.49^^5^66^3
 ;;^UTILITY(U,$J,358.3,1307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1307,1,3,0)
 ;;=3^Encephalopathy,Other
 ;;^UTILITY(U,$J,358.3,1307,1,4,0)
 ;;=4^G93.49
 ;;^UTILITY(U,$J,358.3,1307,2)
 ;;=^329919
 ;;^UTILITY(U,$J,358.3,1308,0)
 ;;=G93.40^^5^66^4
 ;;^UTILITY(U,$J,358.3,1308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1308,1,3,0)
 ;;=3^Encephalopathy,Unspec
 ;;^UTILITY(U,$J,358.3,1308,1,4,0)
 ;;=4^G93.40
 ;;^UTILITY(U,$J,358.3,1308,2)
 ;;=^329917
 ;;^UTILITY(U,$J,358.3,1309,0)
 ;;=G93.41^^5^66^5
 ;;^UTILITY(U,$J,358.3,1309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1309,1,3,0)
 ;;=3^Metabolic Encephalopathy
 ;;^UTILITY(U,$J,358.3,1309,1,4,0)
 ;;=4^G93.41
 ;;^UTILITY(U,$J,358.3,1309,2)
 ;;=^329918
 ;;^UTILITY(U,$J,358.3,1310,0)
 ;;=E51.2^^5^66^7
 ;;^UTILITY(U,$J,358.3,1310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1310,1,3,0)
 ;;=3^Wernicke's Encephalopathy
 ;;^UTILITY(U,$J,358.3,1310,1,4,0)
 ;;=4^E51.2
 ;;^UTILITY(U,$J,358.3,1310,2)
 ;;=^127769
 ;;^UTILITY(U,$J,358.3,1311,0)
 ;;=G43.009^^5^67^14
 ;;^UTILITY(U,$J,358.3,1311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1311,1,3,0)
 ;;=3^Migraine w/o Aura Not Intractable 
 ;;^UTILITY(U,$J,358.3,1311,1,4,0)
 ;;=4^G43.009
 ;;^UTILITY(U,$J,358.3,1311,2)
 ;;=^5003877
 ;;^UTILITY(U,$J,358.3,1312,0)
 ;;=G43.019^^5^67^12
 ;;^UTILITY(U,$J,358.3,1312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1312,1,3,0)
 ;;=3^Migraine w/o Aura Intractable
 ;;^UTILITY(U,$J,358.3,1312,1,4,0)
 ;;=4^G43.019
 ;;^UTILITY(U,$J,358.3,1312,2)
 ;;=^5003879
 ;;^UTILITY(U,$J,358.3,1313,0)
 ;;=G43.109^^5^67^11
 ;;^UTILITY(U,$J,358.3,1313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1313,1,3,0)
 ;;=3^Migraine w/ Aura Not Intractable
 ;;^UTILITY(U,$J,358.3,1313,1,4,0)
 ;;=4^G43.109
 ;;^UTILITY(U,$J,358.3,1313,2)
 ;;=^5003881
 ;;^UTILITY(U,$J,358.3,1314,0)
 ;;=G43.119^^5^67^9
 ;;^UTILITY(U,$J,358.3,1314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1314,1,3,0)
 ;;=3^Migraine w/ Aura Intractable
 ;;^UTILITY(U,$J,358.3,1314,1,4,0)
 ;;=4^G43.119
 ;;^UTILITY(U,$J,358.3,1314,2)
 ;;=^5003883
 ;;^UTILITY(U,$J,358.3,1315,0)
 ;;=G43.909^^5^67^8
 ;;^UTILITY(U,$J,358.3,1315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1315,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
