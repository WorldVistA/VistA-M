IBDEI014 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,879,2)
 ;;=^5003241
 ;;^UTILITY(U,$J,358.3,880,0)
 ;;=F14.221^^3^64^59
 ;;^UTILITY(U,$J,358.3,880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,880,1,3,0)
 ;;=3^Cocaine Intoxication Delirium  w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,880,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,880,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,881,0)
 ;;=F14.921^^3^64^60
 ;;^UTILITY(U,$J,358.3,881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,881,1,3,0)
 ;;=3^Cocaine Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,881,1,4,0)
 ;;=4^F14.921
 ;;^UTILITY(U,$J,358.3,881,2)
 ;;=^5003271
 ;;^UTILITY(U,$J,358.3,882,0)
 ;;=F14.10^^3^64^68
 ;;^UTILITY(U,$J,358.3,882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,882,1,3,0)
 ;;=3^Cocaine Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,882,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,882,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,883,0)
 ;;=F14.20^^3^64^69
 ;;^UTILITY(U,$J,358.3,883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,883,1,3,0)
 ;;=3^Cocaine Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,883,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,883,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,884,0)
 ;;=F14.20^^3^64^70
 ;;^UTILITY(U,$J,358.3,884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,884,1,3,0)
 ;;=3^Cocaine Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,884,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,884,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,885,0)
 ;;=F14.23^^3^64^71
 ;;^UTILITY(U,$J,358.3,885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,885,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,885,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,885,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,886,0)
 ;;=Z91.120^^3^65^1
 ;;^UTILITY(U,$J,358.3,886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,886,1,3,0)
 ;;=3^Intentional Underdosing d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,886,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,886,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,887,0)
 ;;=Z91.128^^3^65^2
 ;;^UTILITY(U,$J,358.3,887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,887,1,3,0)
 ;;=3^Intentional Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,887,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,887,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,888,0)
 ;;=Z91.130^^3^65^15
 ;;^UTILITY(U,$J,358.3,888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,888,1,3,0)
 ;;=3^Unintented Underdosing d/t Age-Related Disability
 ;;^UTILITY(U,$J,358.3,888,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,888,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,889,0)
 ;;=Z91.138^^3^65^16
 ;;^UTILITY(U,$J,358.3,889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,889,1,3,0)
 ;;=3^Unintented Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,889,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,889,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,890,0)
 ;;=T38.3X6A^^3^65^3
 ;;^UTILITY(U,$J,358.3,890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,890,1,3,0)
 ;;=3^Underdosing Insulin/Hypoglycemic Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,890,1,4,0)
 ;;=4^T38.3X6A
 ;;^UTILITY(U,$J,358.3,890,2)
 ;;=^5049649
 ;;^UTILITY(U,$J,358.3,891,0)
 ;;=T38.3X6S^^3^65^4
 ;;^UTILITY(U,$J,358.3,891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,891,1,3,0)
 ;;=3^Underdosing Insulin/Hypoglycemic Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,891,1,4,0)
 ;;=4^T38.3X6S
 ;;^UTILITY(U,$J,358.3,891,2)
 ;;=^5049651
 ;;^UTILITY(U,$J,358.3,892,0)
 ;;=T38.3X6D^^3^65^5
 ;;^UTILITY(U,$J,358.3,892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,892,1,3,0)
 ;;=3^Underdosing Insulin/Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,892,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,892,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,893,0)
 ;;=T46.5X6A^^3^65^9
 ;;^UTILITY(U,$J,358.3,893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,893,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,893,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,893,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,894,0)
 ;;=T46.5X6D^^3^65^10
 ;;^UTILITY(U,$J,358.3,894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,894,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,894,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,894,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,895,0)
 ;;=T46.5X6S^^3^65^11
 ;;^UTILITY(U,$J,358.3,895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,895,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,895,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,895,2)
 ;;=^5051355
 ;;^UTILITY(U,$J,358.3,896,0)
 ;;=T43.206A^^3^65^6
 ;;^UTILITY(U,$J,358.3,896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,896,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
 ;;^UTILITY(U,$J,358.3,896,1,4,0)
 ;;=4^T43.206A
 ;;^UTILITY(U,$J,358.3,896,2)
 ;;=^5050543
 ;;^UTILITY(U,$J,358.3,897,0)
 ;;=T43.206S^^3^65^7
 ;;^UTILITY(U,$J,358.3,897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,897,1,3,0)
 ;;=3^Underdosing of Antidepressants,Sequela
 ;;^UTILITY(U,$J,358.3,897,1,4,0)
 ;;=4^T43.206S
 ;;^UTILITY(U,$J,358.3,897,2)
 ;;=^5050545
 ;;^UTILITY(U,$J,358.3,898,0)
 ;;=T43.206D^^3^65^8
 ;;^UTILITY(U,$J,358.3,898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,898,1,3,0)
 ;;=3^Underdosing of Antidepressants,Subs Encntr
 ;;^UTILITY(U,$J,358.3,898,1,4,0)
 ;;=4^T43.206D
 ;;^UTILITY(U,$J,358.3,898,2)
 ;;=^5050544
 ;;^UTILITY(U,$J,358.3,899,0)
 ;;=T43.506A^^3^65^12
 ;;^UTILITY(U,$J,358.3,899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,899,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Init Encntr
 ;;^UTILITY(U,$J,358.3,899,1,4,0)
 ;;=4^T43.506A
 ;;^UTILITY(U,$J,358.3,899,2)
 ;;=^5050651
 ;;^UTILITY(U,$J,358.3,900,0)
 ;;=T43.506S^^3^65^13
 ;;^UTILITY(U,$J,358.3,900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,900,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Sequela
 ;;^UTILITY(U,$J,358.3,900,1,4,0)
 ;;=4^T43.506S
 ;;^UTILITY(U,$J,358.3,900,2)
 ;;=^5050653
 ;;^UTILITY(U,$J,358.3,901,0)
 ;;=T43.506D^^3^65^14
 ;;^UTILITY(U,$J,358.3,901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,901,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Subs Encntr
 ;;^UTILITY(U,$J,358.3,901,1,4,0)
 ;;=4^T43.506D
 ;;^UTILITY(U,$J,358.3,901,2)
 ;;=^5050652
 ;;^UTILITY(U,$J,358.3,902,0)
 ;;=99212^^4^66^2
 ;;^UTILITY(U,$J,358.3,902,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,902,1,1,0)
 ;;=1^Expanded Problem Focused
 ;;^UTILITY(U,$J,358.3,902,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,903,0)
 ;;=99213^^4^66^3
 ;;^UTILITY(U,$J,358.3,903,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,903,1,1,0)
 ;;=1^Detailed Visit
 ;;^UTILITY(U,$J,358.3,903,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,904,0)
 ;;=99214^^4^66^4
 ;;^UTILITY(U,$J,358.3,904,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,904,1,1,0)
 ;;=1^Comprehensive,Mod Complexity
 ;;^UTILITY(U,$J,358.3,904,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,905,0)
 ;;=99211^^4^66^1
 ;;^UTILITY(U,$J,358.3,905,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,905,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,905,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,906,0)
 ;;=99242^^4^67^1
 ;;^UTILITY(U,$J,358.3,906,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,906,1,1,0)
 ;;=1^Expanded Problem Focused
 ;;^UTILITY(U,$J,358.3,906,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,907,0)
 ;;=99243^^4^67^2
 ;;^UTILITY(U,$J,358.3,907,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,907,1,1,0)
 ;;=1^Detailed Visit
 ;;^UTILITY(U,$J,358.3,907,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,908,0)
 ;;=99244^^4^67^3
 ;;^UTILITY(U,$J,358.3,908,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,908,1,1,0)
 ;;=1^Comprehensive,Mod Complexity
 ;;^UTILITY(U,$J,358.3,908,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,909,0)
 ;;=99024^^4^68^1
 ;;^UTILITY(U,$J,358.3,909,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,909,1,1,0)
 ;;=1^Post Op visit in Global
 ;;^UTILITY(U,$J,358.3,909,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,910,0)
 ;;=64415^^5^69^4^^^^1
 ;;^UTILITY(U,$J,358.3,910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,910,1,2,0)
 ;;=2^NERVE BLK BRACHIAL PLEXUS,SNGL INJ
 ;;^UTILITY(U,$J,358.3,910,1,4,0)
 ;;=4^64415
 ;;^UTILITY(U,$J,358.3,911,0)
 ;;=64416^^5^69^3^^^^1
 ;;^UTILITY(U,$J,358.3,911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,911,1,2,0)
 ;;=2^NERVE BLK BRACHIAL PLEXUS,CONT INFUSION
 ;;^UTILITY(U,$J,358.3,911,1,4,0)
 ;;=4^64416
 ;;^UTILITY(U,$J,358.3,912,0)
 ;;=64413^^5^69^7^^^^1
 ;;^UTILITY(U,$J,358.3,912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,912,1,2,0)
 ;;=2^NERVE BLK CERVICAL PLEXUS,INJ
 ;;^UTILITY(U,$J,358.3,912,1,4,0)
 ;;=4^64413
 ;;^UTILITY(U,$J,358.3,913,0)
 ;;=64402^^5^69^8^^^^1
 ;;^UTILITY(U,$J,358.3,913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,913,1,2,0)
 ;;=2^NERVE BLK FACIAL NERVE,INJ
 ;;^UTILITY(U,$J,358.3,913,1,4,0)
 ;;=4^64402
 ;;^UTILITY(U,$J,358.3,914,0)
 ;;=64447^^5^69^10^^^^1
 ;;^UTILITY(U,$J,358.3,914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,914,1,2,0)
 ;;=2^NERVE BLK FEMORAL NERVE,SNGL INJ
 ;;^UTILITY(U,$J,358.3,914,1,4,0)
 ;;=4^64447
 ;;^UTILITY(U,$J,358.3,915,0)
 ;;=64448^^5^69^9^^^^1
 ;;^UTILITY(U,$J,358.3,915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,915,1,2,0)
 ;;=2^NERVE BLK FEMORAL NERVE,CONT INFUSION
 ;;^UTILITY(U,$J,358.3,915,1,4,0)
 ;;=4^64448
 ;;^UTILITY(U,$J,358.3,916,0)
 ;;=64405^^5^69^11^^^^1
 ;;^UTILITY(U,$J,358.3,916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,916,1,2,0)
 ;;=2^NERVE BLK GREATER OCCIPITAL NERVE,INJ
 ;;^UTILITY(U,$J,358.3,916,1,4,0)
 ;;=4^64405
 ;;^UTILITY(U,$J,358.3,917,0)
 ;;=64425^^5^69^12^^^^1
 ;;^UTILITY(U,$J,358.3,917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,917,1,2,0)
 ;;=2^NERVE BLK ILIOINGUINAL/ILIOHYPOGASTRIC,INJ
 ;;^UTILITY(U,$J,358.3,917,1,4,0)
 ;;=4^64425
 ;;^UTILITY(U,$J,358.3,918,0)
 ;;=64450^^5^69^17^^^^1
 ;;^UTILITY(U,$J,358.3,918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,918,1,2,0)
 ;;=2^NERVE BLK PERIPH NERVE/BRANCH NEC
 ;;^UTILITY(U,$J,358.3,918,1,4,0)
 ;;=4^64450
 ;;^UTILITY(U,$J,358.3,919,0)
 ;;=64508^^5^69^5^^^^1
