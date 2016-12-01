IBDEI0KX ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26465,1,4,0)
 ;;=4^F14.929
 ;;^UTILITY(U,$J,358.3,26465,2)
 ;;=^5003273
 ;;^UTILITY(U,$J,358.3,26466,0)
 ;;=F14.121^^69^1101^58
 ;;^UTILITY(U,$J,358.3,26466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26466,1,3,0)
 ;;=3^Cocaine Intoxication Delirium  w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,26466,1,4,0)
 ;;=4^F14.121
 ;;^UTILITY(U,$J,358.3,26466,2)
 ;;=^5003241
 ;;^UTILITY(U,$J,358.3,26467,0)
 ;;=F14.221^^69^1101^59
 ;;^UTILITY(U,$J,358.3,26467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26467,1,3,0)
 ;;=3^Cocaine Intoxication Delirium  w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,26467,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,26467,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,26468,0)
 ;;=F14.921^^69^1101^60
 ;;^UTILITY(U,$J,358.3,26468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26468,1,3,0)
 ;;=3^Cocaine Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,26468,1,4,0)
 ;;=4^F14.921
 ;;^UTILITY(U,$J,358.3,26468,2)
 ;;=^5003271
 ;;^UTILITY(U,$J,358.3,26469,0)
 ;;=F14.10^^69^1101^68
 ;;^UTILITY(U,$J,358.3,26469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26469,1,3,0)
 ;;=3^Cocaine Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,26469,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,26469,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,26470,0)
 ;;=F14.20^^69^1101^69
 ;;^UTILITY(U,$J,358.3,26470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26470,1,3,0)
 ;;=3^Cocaine Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,26470,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,26470,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,26471,0)
 ;;=F14.20^^69^1101^70
 ;;^UTILITY(U,$J,358.3,26471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26471,1,3,0)
 ;;=3^Cocaine Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,26471,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,26471,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,26472,0)
 ;;=F14.23^^69^1101^71
 ;;^UTILITY(U,$J,358.3,26472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26472,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,26472,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,26472,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,26473,0)
 ;;=Z91.120^^69^1102^1
 ;;^UTILITY(U,$J,358.3,26473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26473,1,3,0)
 ;;=3^Intentional Underdosing d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,26473,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,26473,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,26474,0)
 ;;=Z91.128^^69^1102^2
 ;;^UTILITY(U,$J,358.3,26474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26474,1,3,0)
 ;;=3^Intentional Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,26474,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,26474,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,26475,0)
 ;;=Z91.130^^69^1102^15
 ;;^UTILITY(U,$J,358.3,26475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26475,1,3,0)
 ;;=3^Unintented Underdosing d/t Age-Related Disability
 ;;^UTILITY(U,$J,358.3,26475,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,26475,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,26476,0)
 ;;=Z91.138^^69^1102^16
 ;;^UTILITY(U,$J,358.3,26476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26476,1,3,0)
 ;;=3^Unintented Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,26476,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,26476,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,26477,0)
 ;;=T38.3X6A^^69^1102^3
 ;;^UTILITY(U,$J,358.3,26477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26477,1,3,0)
 ;;=3^Underdosing Insulin/Hypoglycemic Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,26477,1,4,0)
 ;;=4^T38.3X6A
 ;;^UTILITY(U,$J,358.3,26477,2)
 ;;=^5049649
 ;;^UTILITY(U,$J,358.3,26478,0)
 ;;=T38.3X6S^^69^1102^4
 ;;^UTILITY(U,$J,358.3,26478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26478,1,3,0)
 ;;=3^Underdosing Insulin/Hypoglycemic Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,26478,1,4,0)
 ;;=4^T38.3X6S
 ;;^UTILITY(U,$J,358.3,26478,2)
 ;;=^5049651
 ;;^UTILITY(U,$J,358.3,26479,0)
 ;;=T38.3X6D^^69^1102^5
 ;;^UTILITY(U,$J,358.3,26479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26479,1,3,0)
 ;;=3^Underdosing Insulin/Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,26479,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,26479,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,26480,0)
 ;;=T46.5X6A^^69^1102^9
 ;;^UTILITY(U,$J,358.3,26480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26480,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,26480,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,26480,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,26481,0)
 ;;=T46.5X6D^^69^1102^10
 ;;^UTILITY(U,$J,358.3,26481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26481,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26481,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,26481,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,26482,0)
 ;;=T46.5X6S^^69^1102^11
 ;;^UTILITY(U,$J,358.3,26482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26482,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,26482,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,26482,2)
 ;;=^5051355
 ;;^UTILITY(U,$J,358.3,26483,0)
 ;;=T43.206A^^69^1102^6
 ;;^UTILITY(U,$J,358.3,26483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26483,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
 ;;^UTILITY(U,$J,358.3,26483,1,4,0)
 ;;=4^T43.206A
 ;;^UTILITY(U,$J,358.3,26483,2)
 ;;=^5050543
 ;;^UTILITY(U,$J,358.3,26484,0)
 ;;=T43.206S^^69^1102^7
 ;;^UTILITY(U,$J,358.3,26484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26484,1,3,0)
 ;;=3^Underdosing of Antidepressants,Sequela
 ;;^UTILITY(U,$J,358.3,26484,1,4,0)
 ;;=4^T43.206S
 ;;^UTILITY(U,$J,358.3,26484,2)
 ;;=^5050545
 ;;^UTILITY(U,$J,358.3,26485,0)
 ;;=T43.206D^^69^1102^8
 ;;^UTILITY(U,$J,358.3,26485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26485,1,3,0)
 ;;=3^Underdosing of Antidepressants,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26485,1,4,0)
 ;;=4^T43.206D
 ;;^UTILITY(U,$J,358.3,26485,2)
 ;;=^5050544
 ;;^UTILITY(U,$J,358.3,26486,0)
 ;;=T43.506A^^69^1102^12
 ;;^UTILITY(U,$J,358.3,26486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26486,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Init Encntr
 ;;^UTILITY(U,$J,358.3,26486,1,4,0)
 ;;=4^T43.506A
 ;;^UTILITY(U,$J,358.3,26486,2)
 ;;=^5050651
 ;;^UTILITY(U,$J,358.3,26487,0)
 ;;=T43.506S^^69^1102^13
 ;;^UTILITY(U,$J,358.3,26487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26487,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Sequela
 ;;^UTILITY(U,$J,358.3,26487,1,4,0)
 ;;=4^T43.506S
 ;;^UTILITY(U,$J,358.3,26487,2)
 ;;=^5050653
 ;;^UTILITY(U,$J,358.3,26488,0)
 ;;=T43.506D^^69^1102^14
 ;;^UTILITY(U,$J,358.3,26488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26488,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Subs Encntr
 ;;^UTILITY(U,$J,358.3,26488,1,4,0)
 ;;=4^T43.506D
 ;;^UTILITY(U,$J,358.3,26488,2)
 ;;=^5050652
 ;;^UTILITY(U,$J,358.3,26489,0)
 ;;=90832^^70^1103^7^^^^1
 ;;^UTILITY(U,$J,358.3,26489,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26489,1,2,0)
 ;;=2^90832
 ;;^UTILITY(U,$J,358.3,26489,1,3,0)
 ;;=3^Psychotherapy 16-37 min
 ;;^UTILITY(U,$J,358.3,26490,0)
 ;;=90834^^70^1103^8^^^^1
 ;;^UTILITY(U,$J,358.3,26490,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26490,1,2,0)
 ;;=2^90834
 ;;^UTILITY(U,$J,358.3,26490,1,3,0)
 ;;=3^Psychotherapy 38-52 min
 ;;^UTILITY(U,$J,358.3,26491,0)
 ;;=90837^^70^1103^9^^^^1
 ;;^UTILITY(U,$J,358.3,26491,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26491,1,2,0)
 ;;=2^90837
 ;;^UTILITY(U,$J,358.3,26491,1,3,0)
 ;;=3^Psychotherapy 53-89 min
 ;;^UTILITY(U,$J,358.3,26492,0)
 ;;=90853^^70^1103^3^^^^1
 ;;^UTILITY(U,$J,358.3,26492,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26492,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,26492,1,3,0)
 ;;=3^Group Psychotherapy
 ;;^UTILITY(U,$J,358.3,26493,0)
 ;;=90846^^70^1103^2^^^^1
 ;;^UTILITY(U,$J,358.3,26493,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26493,1,2,0)
 ;;=2^90846
 ;;^UTILITY(U,$J,358.3,26493,1,3,0)
 ;;=3^Family Psychotherapy w/o Pt
 ;;^UTILITY(U,$J,358.3,26494,0)
 ;;=90847^^70^1103^1^^^^1
 ;;^UTILITY(U,$J,358.3,26494,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26494,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,26494,1,3,0)
 ;;=3^Family Psychotherapy w/ Pt
 ;;^UTILITY(U,$J,358.3,26495,0)
 ;;=90875^^70^1103^4^^^^1
 ;;^UTILITY(U,$J,358.3,26495,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26495,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,26495,1,3,0)
 ;;=3^Ind Psychophysiological Tx w/ Biofeed,30 min
 ;;^UTILITY(U,$J,358.3,26496,0)
 ;;=90876^^70^1103^5^^^^1
 ;;^UTILITY(U,$J,358.3,26496,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26496,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,26496,1,3,0)
 ;;=3^Ind Psychophysiological Tx w/ Biofeed,45 min
 ;;^UTILITY(U,$J,358.3,26497,0)
 ;;=90847^^70^1103^6^^^^1
 ;;^UTILITY(U,$J,358.3,26497,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26497,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,26497,1,3,0)
 ;;=3^Multiple Family Psychotherapy
 ;;^UTILITY(U,$J,358.3,26498,0)
 ;;=90839^^70^1104^1^^^^1
 ;;^UTILITY(U,$J,358.3,26498,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26498,1,2,0)
 ;;=2^90839
 ;;^UTILITY(U,$J,358.3,26498,1,3,0)
 ;;=3^PsychTx Crisis;Init 30-74 Min
 ;;^UTILITY(U,$J,358.3,26499,0)
 ;;=90840^^70^1104^2^^^^1
 ;;^UTILITY(U,$J,358.3,26499,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26499,1,2,0)
 ;;=2^90840
 ;;^UTILITY(U,$J,358.3,26499,1,3,0)
 ;;=3^PsychTx Crisis;Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,26500,0)
 ;;=97545^^70^1105^35^^^^1
 ;;^UTILITY(U,$J,358.3,26500,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26500,1,2,0)
 ;;=2^97545
 ;;^UTILITY(U,$J,358.3,26500,1,3,0)
 ;;=3^Work Hardening/Conditioning,Init 2 hrs
 ;;^UTILITY(U,$J,358.3,26501,0)
 ;;=97546^^70^1105^36^^^^1
 ;;^UTILITY(U,$J,358.3,26501,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26501,1,2,0)
 ;;=2^97546
 ;;^UTILITY(U,$J,358.3,26501,1,3,0)
 ;;=3^Work Hardening/Conditioning,ea addl hr
 ;;^UTILITY(U,$J,358.3,26502,0)
 ;;=97537^^70^1105^5^^^^1
