IBDEI0CN ; ; 03-MAY-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 03, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31738,1,3,0)
 ;;=3^Adjustment disorder w/ depressed mood
 ;;^UTILITY(U,$J,358.3,31738,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,31738,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,31739,0)
 ;;=G47.00^^94^1301^8
 ;;^UTILITY(U,$J,358.3,31739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31739,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,31739,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,31739,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,31740,0)
 ;;=F43.10^^94^1301^11
 ;;^UTILITY(U,$J,358.3,31740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31740,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,31740,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,31740,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,31741,0)
 ;;=F43.12^^94^1301^10
 ;;^UTILITY(U,$J,358.3,31741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31741,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,31741,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,31741,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,31742,0)
 ;;=F43.11^^94^1301^9
 ;;^UTILITY(U,$J,358.3,31742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31742,1,3,0)
 ;;=3^Post-traumatic stress disorder, acute
 ;;^UTILITY(U,$J,358.3,31742,1,4,0)
 ;;=4^F43.11
 ;;^UTILITY(U,$J,358.3,31742,2)
 ;;=^5003571
 ;;^UTILITY(U,$J,358.3,31743,0)
 ;;=F43.22^^94^1301^1
 ;;^UTILITY(U,$J,358.3,31743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31743,1,3,0)
 ;;=3^Adjustment disorder w/ anxiety
 ;;^UTILITY(U,$J,358.3,31743,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,31743,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,31744,0)
 ;;=F43.23^^94^1301^4
 ;;^UTILITY(U,$J,358.3,31744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31744,1,3,0)
 ;;=3^Adjustment disorder w/ mixed anxiety & depressed mood
 ;;^UTILITY(U,$J,358.3,31744,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,31744,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,31745,0)
 ;;=F43.24^^94^1301^3
 ;;^UTILITY(U,$J,358.3,31745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31745,1,3,0)
 ;;=3^Adjustment disorder w/ disturbance of conduct
 ;;^UTILITY(U,$J,358.3,31745,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,31745,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,31746,0)
 ;;=F43.25^^94^1301^5
 ;;^UTILITY(U,$J,358.3,31746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31746,1,3,0)
 ;;=3^Adjustment disorder w/ mixed disturb of emotions & conduct
 ;;^UTILITY(U,$J,358.3,31746,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,31746,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,31747,0)
 ;;=F43.29^^94^1301^6
 ;;^UTILITY(U,$J,358.3,31747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31747,1,3,0)
 ;;=3^Adjustment disorder w/ other symptoms
 ;;^UTILITY(U,$J,358.3,31747,1,4,0)
 ;;=4^F43.29
 ;;^UTILITY(U,$J,358.3,31747,2)
 ;;=^5003574
 ;;^UTILITY(U,$J,358.3,31748,0)
 ;;=F43.20^^94^1301^7
 ;;^UTILITY(U,$J,358.3,31748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31748,1,3,0)
 ;;=3^Adjustment disorder, unspec
 ;;^UTILITY(U,$J,358.3,31748,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,31748,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,31749,0)
 ;;=M79.7^^94^1302^2
 ;;^UTILITY(U,$J,358.3,31749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31749,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,31749,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,31749,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,31750,0)
 ;;=R20.2^^94^1302^7
 ;;^UTILITY(U,$J,358.3,31750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31750,1,3,0)
 ;;=3^Paresthesia of skin
 ;;^UTILITY(U,$J,358.3,31750,1,4,0)
 ;;=4^R20.2
 ;;^UTILITY(U,$J,358.3,31750,2)
 ;;=^5019280
 ;;^UTILITY(U,$J,358.3,31751,0)
 ;;=R42.^^94^1302^1
 ;;^UTILITY(U,$J,358.3,31751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31751,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,31751,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,31751,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,31752,0)
 ;;=G47.33^^94^1302^6
 ;;^UTILITY(U,$J,358.3,31752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31752,1,3,0)
 ;;=3^Obstructive Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,31752,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,31752,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,31753,0)
 ;;=R41.3^^94^1302^5
 ;;^UTILITY(U,$J,358.3,31753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31753,1,3,0)
 ;;=3^Memory Loss,NOS
 ;;^UTILITY(U,$J,358.3,31753,1,4,0)
 ;;=4^R41.3
 ;;^UTILITY(U,$J,358.3,31753,2)
 ;;=^5019439
 ;;^UTILITY(U,$J,358.3,31754,0)
 ;;=R43.0^^94^1302^4
 ;;^UTILITY(U,$J,358.3,31754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31754,1,3,0)
 ;;=3^Loss of Smell
 ;;^UTILITY(U,$J,358.3,31754,1,4,0)
 ;;=4^R43.0
 ;;^UTILITY(U,$J,358.3,31754,2)
 ;;=^7949
 ;;^UTILITY(U,$J,358.3,31755,0)
 ;;=R43.8^^94^1302^10
 ;;^UTILITY(U,$J,358.3,31755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31755,1,3,0)
 ;;=3^Smell & Taste Disturbance,Other
 ;;^UTILITY(U,$J,358.3,31755,1,4,0)
 ;;=4^R43.8
 ;;^UTILITY(U,$J,358.3,31755,2)
 ;;=^5019453
 ;;^UTILITY(U,$J,358.3,31756,0)
 ;;=R47.82^^94^1302^3
 ;;^UTILITY(U,$J,358.3,31756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31756,1,3,0)
 ;;=3^Fluency Disorder in Conditions Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,31756,1,4,0)
 ;;=4^R47.82
 ;;^UTILITY(U,$J,358.3,31756,2)
 ;;=^5019492
 ;;^UTILITY(U,$J,358.3,31757,0)
 ;;=R47.81^^94^1302^9
 ;;^UTILITY(U,$J,358.3,31757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31757,1,3,0)
 ;;=3^Slurred Speech
 ;;^UTILITY(U,$J,358.3,31757,1,4,0)
 ;;=4^R47.81
 ;;^UTILITY(U,$J,358.3,31757,2)
 ;;=^5019491
 ;;^UTILITY(U,$J,358.3,31758,0)
 ;;=R56.1^^94^1302^8
 ;;^UTILITY(U,$J,358.3,31758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31758,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,31758,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,31758,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,31759,0)
 ;;=G43.C0^^94^1303^23
 ;;^UTILITY(U,$J,358.3,31759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31759,1,3,0)
 ;;=3^Periodic headache syndromes in chld/adlt, not intractable
 ;;^UTILITY(U,$J,358.3,31759,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,31759,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,31760,0)
 ;;=G43.C1^^94^1303^22
 ;;^UTILITY(U,$J,358.3,31760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31760,1,3,0)
 ;;=3^Periodic headache syndromes in child or adult, intractable
 ;;^UTILITY(U,$J,358.3,31760,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,31760,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,31761,0)
 ;;=G43.909^^94^1303^20
 ;;^UTILITY(U,$J,358.3,31761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31761,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,31761,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,31761,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,31762,0)
 ;;=G43.919^^94^1303^18
 ;;^UTILITY(U,$J,358.3,31762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31762,1,3,0)
 ;;=3^Migraine, unsp, intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,31762,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,31762,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,31763,0)
 ;;=G44.209^^94^1303^31
 ;;^UTILITY(U,$J,358.3,31763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31763,1,3,0)
 ;;=3^Tension-type headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,31763,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,31763,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,31764,0)
 ;;=G43.901^^94^1303^19
 ;;^UTILITY(U,$J,358.3,31764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31764,1,3,0)
 ;;=3^Migraine, unsp, not intractable, with status migrainosus
 ;;^UTILITY(U,$J,358.3,31764,1,4,0)
 ;;=4^G43.901
 ;;^UTILITY(U,$J,358.3,31764,2)
 ;;=^5003908
 ;;^UTILITY(U,$J,358.3,31765,0)
 ;;=G43.911^^94^1303^17
 ;;^UTILITY(U,$J,358.3,31765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31765,1,3,0)
 ;;=3^Migraine, unsp, intractable, with status migrainosus
 ;;^UTILITY(U,$J,358.3,31765,1,4,0)
 ;;=4^G43.911
 ;;^UTILITY(U,$J,358.3,31765,2)
 ;;=^5003910
 ;;^UTILITY(U,$J,358.3,31766,0)
 ;;=G44.201^^94^1303^30
 ;;^UTILITY(U,$J,358.3,31766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31766,1,3,0)
 ;;=3^Tension-type headache, unspecified, intractable
 ;;^UTILITY(U,$J,358.3,31766,1,4,0)
 ;;=4^G44.201
 ;;^UTILITY(U,$J,358.3,31766,2)
 ;;=^5003935
 ;;^UTILITY(U,$J,358.3,31767,0)
 ;;=G44.211^^94^1303^10
 ;;^UTILITY(U,$J,358.3,31767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31767,1,3,0)
 ;;=3^Episodic tension-type headache, intractable
 ;;^UTILITY(U,$J,358.3,31767,1,4,0)
 ;;=4^G44.211
 ;;^UTILITY(U,$J,358.3,31767,2)
 ;;=^5003937
 ;;^UTILITY(U,$J,358.3,31768,0)
 ;;=G44.219^^94^1303^11
 ;;^UTILITY(U,$J,358.3,31768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31768,1,3,0)
 ;;=3^Episodic tension-type headache, not intractable
 ;;^UTILITY(U,$J,358.3,31768,1,4,0)
 ;;=4^G44.219
 ;;^UTILITY(U,$J,358.3,31768,2)
 ;;=^5003938
 ;;^UTILITY(U,$J,358.3,31769,0)
 ;;=G44.229^^94^1303^6
 ;;^UTILITY(U,$J,358.3,31769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31769,1,3,0)
 ;;=3^Chronic tension-type headache, not intractable
 ;;^UTILITY(U,$J,358.3,31769,1,4,0)
 ;;=4^G44.229
 ;;^UTILITY(U,$J,358.3,31769,2)
 ;;=^5003940
 ;;^UTILITY(U,$J,358.3,31770,0)
 ;;=G44.301^^94^1303^24
 ;;^UTILITY(U,$J,358.3,31770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31770,1,3,0)
 ;;=3^Post-traumatic headache, unspecified, intractable
 ;;^UTILITY(U,$J,358.3,31770,1,4,0)
 ;;=4^G44.301
 ;;^UTILITY(U,$J,358.3,31770,2)
 ;;=^5003941
 ;;^UTILITY(U,$J,358.3,31771,0)
 ;;=G44.309^^94^1303^25
 ;;^UTILITY(U,$J,358.3,31771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31771,1,3,0)
 ;;=3^Post-traumatic headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,31771,1,4,0)
 ;;=4^G44.309
 ;;^UTILITY(U,$J,358.3,31771,2)
 ;;=^5003942
 ;;^UTILITY(U,$J,358.3,31772,0)
 ;;=G44.311^^94^1303^1
 ;;^UTILITY(U,$J,358.3,31772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31772,1,3,0)
 ;;=3^Acute post-traumatic headache, intractable
 ;;^UTILITY(U,$J,358.3,31772,1,4,0)
 ;;=4^G44.311
 ;;^UTILITY(U,$J,358.3,31772,2)
 ;;=^5003943
 ;;^UTILITY(U,$J,358.3,31773,0)
 ;;=G44.319^^94^1303^2
 ;;^UTILITY(U,$J,358.3,31773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31773,1,3,0)
 ;;=3^Acute post-traumatic headache, not intractable
 ;;^UTILITY(U,$J,358.3,31773,1,4,0)
 ;;=4^G44.319
 ;;^UTILITY(U,$J,358.3,31773,2)
 ;;=^5003944
 ;;^UTILITY(U,$J,358.3,31774,0)
 ;;=G44.329^^94^1303^4
 ;;^UTILITY(U,$J,358.3,31774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31774,1,3,0)
 ;;=3^Chronic post-traumatic headache, not intractable
 ;;^UTILITY(U,$J,358.3,31774,1,4,0)
 ;;=4^G44.329
 ;;^UTILITY(U,$J,358.3,31774,2)
 ;;=^5003946
 ;;^UTILITY(U,$J,358.3,31775,0)
 ;;=G44.321^^94^1303^3
 ;;^UTILITY(U,$J,358.3,31775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31775,1,3,0)
 ;;=3^Chronic post-traumatic headache, intractable
 ;;^UTILITY(U,$J,358.3,31775,1,4,0)
 ;;=4^G44.321
 ;;^UTILITY(U,$J,358.3,31775,2)
 ;;=^5003945
 ;;^UTILITY(U,$J,358.3,31776,0)
 ;;=G44.40^^94^1303^8
 ;;^UTILITY(U,$J,358.3,31776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31776,1,3,0)
 ;;=3^Drug-induced headache, NEC, not intractable
 ;;^UTILITY(U,$J,358.3,31776,1,4,0)
 ;;=4^G44.40
 ;;^UTILITY(U,$J,358.3,31776,2)
 ;;=^5003947
 ;;^UTILITY(U,$J,358.3,31777,0)
 ;;=G44.41^^94^1303^9
 ;;^UTILITY(U,$J,358.3,31777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31777,1,3,0)
 ;;=3^Drug-induced headache, not elsewhere classified, intractable
 ;;^UTILITY(U,$J,358.3,31777,1,4,0)
 ;;=4^G44.41
 ;;^UTILITY(U,$J,358.3,31777,2)
 ;;=^5003948
 ;;^UTILITY(U,$J,358.3,31778,0)
 ;;=G44.51^^94^1303^15
 ;;^UTILITY(U,$J,358.3,31778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31778,1,3,0)
 ;;=3^Hemicrania continua
 ;;^UTILITY(U,$J,358.3,31778,1,4,0)
 ;;=4^G44.51
 ;;^UTILITY(U,$J,358.3,31778,2)
 ;;=^5003949
 ;;^UTILITY(U,$J,358.3,31779,0)
 ;;=G44.52^^94^1303^21
 ;;^UTILITY(U,$J,358.3,31779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31779,1,3,0)
 ;;=3^New daily persistent headache (NDPH)
 ;;^UTILITY(U,$J,358.3,31779,1,4,0)
 ;;=4^G44.52
 ;;^UTILITY(U,$J,358.3,31779,2)
 ;;=^5003950
 ;;^UTILITY(U,$J,358.3,31780,0)
 ;;=G44.53^^94^1303^29
 ;;^UTILITY(U,$J,358.3,31780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31780,1,3,0)
 ;;=3^Primary thunderclap headache
 ;;^UTILITY(U,$J,358.3,31780,1,4,0)
 ;;=4^G44.53
 ;;^UTILITY(U,$J,358.3,31780,2)
 ;;=^5003951
 ;;^UTILITY(U,$J,358.3,31781,0)
 ;;=G44.59^^94^1303^7
 ;;^UTILITY(U,$J,358.3,31781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31781,1,3,0)
 ;;=3^Complicated headache syndrome, other
 ;;^UTILITY(U,$J,358.3,31781,1,4,0)
 ;;=4^G44.59
 ;;^UTILITY(U,$J,358.3,31781,2)
 ;;=^336559
 ;;^UTILITY(U,$J,358.3,31782,0)
 ;;=G44.81^^94^1303^16
 ;;^UTILITY(U,$J,358.3,31782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31782,1,3,0)
 ;;=3^Hypnic Headache
 ;;^UTILITY(U,$J,358.3,31782,1,4,0)
 ;;=4^G44.81
 ;;^UTILITY(U,$J,358.3,31782,2)
 ;;=^336560
 ;;^UTILITY(U,$J,358.3,31783,0)
 ;;=G44.83^^94^1303^26
 ;;^UTILITY(U,$J,358.3,31783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31783,1,3,0)
 ;;=3^Primary cough headache
 ;;^UTILITY(U,$J,358.3,31783,1,4,0)
 ;;=4^G44.83
 ;;^UTILITY(U,$J,358.3,31783,2)
 ;;=^336562
 ;;^UTILITY(U,$J,358.3,31784,0)
 ;;=G44.84^^94^1303^27
 ;;^UTILITY(U,$J,358.3,31784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31784,1,3,0)
 ;;=3^Primary exertional headache
 ;;^UTILITY(U,$J,358.3,31784,1,4,0)
 ;;=4^G44.84
 ;;^UTILITY(U,$J,358.3,31784,2)
 ;;=^336563
 ;;^UTILITY(U,$J,358.3,31785,0)
 ;;=G44.85^^94^1303^28
 ;;^UTILITY(U,$J,358.3,31785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31785,1,3,0)
 ;;=3^Primary stabbing headache
 ;;^UTILITY(U,$J,358.3,31785,1,4,0)
 ;;=4^G44.85
 ;;^UTILITY(U,$J,358.3,31785,2)
 ;;=^5003953
 ;;^UTILITY(U,$J,358.3,31786,0)
 ;;=G44.89^^94^1303^12
 ;;^UTILITY(U,$J,358.3,31786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31786,1,3,0)
 ;;=3^Headache syndrome, other
 ;;^UTILITY(U,$J,358.3,31786,1,4,0)
 ;;=4^G44.89
 ;;^UTILITY(U,$J,358.3,31786,2)
 ;;=^5003954
 ;;^UTILITY(U,$J,358.3,31787,0)
 ;;=G44.221^^94^1303^5
 ;;^UTILITY(U,$J,358.3,31787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31787,1,3,0)
 ;;=3^Chronic tension-type headache, intractable
 ;;^UTILITY(U,$J,358.3,31787,1,4,0)
 ;;=4^G44.221
 ;;^UTILITY(U,$J,358.3,31787,2)
 ;;=^5003939
 ;;^UTILITY(U,$J,358.3,31788,0)
 ;;=R51.9^^94^1303^14
 ;;^UTILITY(U,$J,358.3,31788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31788,1,3,0)
 ;;=3^Headache,Unspec
 ;;^UTILITY(U,$J,358.3,31788,1,4,0)
 ;;=4^R51.9
 ;;^UTILITY(U,$J,358.3,31788,2)
 ;;=^5159306
 ;;^UTILITY(U,$J,358.3,31789,0)
 ;;=R51.0^^94^1303^13
 ;;^UTILITY(U,$J,358.3,31789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31789,1,3,0)
 ;;=3^Headache w/ Orthostatic Component,NEC
 ;;^UTILITY(U,$J,358.3,31789,1,4,0)
 ;;=4^R51.0
 ;;^UTILITY(U,$J,358.3,31789,2)
 ;;=^5159305
 ;;^UTILITY(U,$J,358.3,31790,0)
 ;;=Z65.5^^94^1304^1
 ;;^UTILITY(U,$J,358.3,31790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31790,1,3,0)
 ;;=3^Exposure to disaster, war and other hostilities
 ;;^UTILITY(U,$J,358.3,31790,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,31790,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,31791,0)
 ;;=E66.9^^94^1305^20
 ;;^UTILITY(U,$J,358.3,31791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31791,1,3,0)
 ;;=3^Obesity, unspecified
 ;;^UTILITY(U,$J,358.3,31791,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,31791,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,31792,0)
 ;;=E66.01^^94^1305^17
 ;;^UTILITY(U,$J,358.3,31792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31792,1,3,0)
 ;;=3^Morbid (severe) obesity due to excess calories
 ;;^UTILITY(U,$J,358.3,31792,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,31792,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,31793,0)
 ;;=R53.82^^94^1305^5
 ;;^UTILITY(U,$J,358.3,31793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31793,1,3,0)
 ;;=3^Chronic fatigue, unspecified
 ;;^UTILITY(U,$J,358.3,31793,1,4,0)
 ;;=4^R53.82
 ;;^UTILITY(U,$J,358.3,31793,2)
 ;;=^5019519
 ;;^UTILITY(U,$J,358.3,31794,0)
 ;;=R42.^^94^1305^9
 ;;^UTILITY(U,$J,358.3,31794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31794,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,31794,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,31794,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,31795,0)
 ;;=F51.02^^94^1305^3
 ;;^UTILITY(U,$J,358.3,31795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31795,1,3,0)
 ;;=3^Adjustment insomnia
 ;;^UTILITY(U,$J,358.3,31795,1,4,0)
 ;;=4^F51.02
 ;;^UTILITY(U,$J,358.3,31795,2)
 ;;=^5003604
 ;;^UTILITY(U,$J,358.3,31796,0)
 ;;=R53.81^^94^1305^16
 ;;^UTILITY(U,$J,358.3,31796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31796,1,3,0)
 ;;=3^Malaise NEC
 ;;^UTILITY(U,$J,358.3,31796,1,4,0)
 ;;=4^R53.81
 ;;^UTILITY(U,$J,358.3,31796,2)
 ;;=^5019518
 ;;^UTILITY(U,$J,358.3,31797,0)
 ;;=R25.2^^94^1305^6
 ;;^UTILITY(U,$J,358.3,31797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31797,1,3,0)
 ;;=3^Cramp and spasm
 ;;^UTILITY(U,$J,358.3,31797,1,4,0)
 ;;=4^R25.2
 ;;^UTILITY(U,$J,358.3,31797,2)
 ;;=^5019301
 ;;^UTILITY(U,$J,358.3,31798,0)
 ;;=F10.10^^94^1305^4
 ;;^UTILITY(U,$J,358.3,31798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31798,1,3,0)
 ;;=3^Alcohol abuse, uncomplicated
 ;;^UTILITY(U,$J,358.3,31798,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,31798,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,31799,0)
 ;;=F32.9^^94^1305^15
 ;;^UTILITY(U,$J,358.3,31799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31799,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,31799,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,31799,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,31800,0)
 ;;=R26.2^^94^1305^8
 ;;^UTILITY(U,$J,358.3,31800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31800,1,3,0)
 ;;=3^Difficulty in walking, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,31800,1,4,0)
 ;;=4^R26.2
 ;;^UTILITY(U,$J,358.3,31800,2)
 ;;=^5019306
 ;;^UTILITY(U,$J,358.3,31801,0)
 ;;=R43.9^^94^1305^22
 ;;^UTILITY(U,$J,358.3,31801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31801,1,3,0)
 ;;=3^Smell/Taste Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,31801,1,4,0)
 ;;=4^R43.9
 ;;^UTILITY(U,$J,358.3,31801,2)
 ;;=^5019454
 ;;^UTILITY(U,$J,358.3,31802,0)
 ;;=H91.91^^94^1305^12
 ;;^UTILITY(U,$J,358.3,31802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31802,1,3,0)
 ;;=3^Hearing loss,right ear,Unspec
 ;;^UTILITY(U,$J,358.3,31802,1,4,0)
 ;;=4^H91.91
 ;;^UTILITY(U,$J,358.3,31802,2)
 ;;=^5133553
 ;;^UTILITY(U,$J,358.3,31803,0)
 ;;=H91.92^^94^1305^11
 ;;^UTILITY(U,$J,358.3,31803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31803,1,3,0)
 ;;=3^Hearing loss,left ear,Unspec
 ;;^UTILITY(U,$J,358.3,31803,1,4,0)
 ;;=4^H91.92
 ;;^UTILITY(U,$J,358.3,31803,2)
 ;;=^5133554
 ;;^UTILITY(U,$J,358.3,31804,0)
 ;;=H91.93^^94^1305^10
 ;;^UTILITY(U,$J,358.3,31804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31804,1,3,0)
 ;;=3^Hearing loss,bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,31804,1,4,0)
 ;;=4^H91.93
 ;;^UTILITY(U,$J,358.3,31804,2)
 ;;=^5006944
 ;;^UTILITY(U,$J,358.3,31805,0)
 ;;=R27.9^^94^1305^14
 ;;^UTILITY(U,$J,358.3,31805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31805,1,3,0)
 ;;=3^Lack of coordination,Unspec
 ;;^UTILITY(U,$J,358.3,31805,1,4,0)
 ;;=4^R27.9
