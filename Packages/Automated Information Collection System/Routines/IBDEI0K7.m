IBDEI0K7 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25557,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,25557,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,25558,0)
 ;;=F14.20^^66^1034^69
 ;;^UTILITY(U,$J,358.3,25558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25558,1,3,0)
 ;;=3^Cocaine Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,25558,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,25558,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,25559,0)
 ;;=F14.20^^66^1034^70
 ;;^UTILITY(U,$J,358.3,25559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25559,1,3,0)
 ;;=3^Cocaine Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,25559,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,25559,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,25560,0)
 ;;=F14.23^^66^1034^71
 ;;^UTILITY(U,$J,358.3,25560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25560,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,25560,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,25560,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,25561,0)
 ;;=Z91.120^^66^1035^1
 ;;^UTILITY(U,$J,358.3,25561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25561,1,3,0)
 ;;=3^Intentional Underdosing d/t Financial Hardship
 ;;^UTILITY(U,$J,358.3,25561,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,25561,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,25562,0)
 ;;=Z91.128^^66^1035^2
 ;;^UTILITY(U,$J,358.3,25562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25562,1,3,0)
 ;;=3^Intentional Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,25562,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,25562,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,25563,0)
 ;;=Z91.130^^66^1035^15
 ;;^UTILITY(U,$J,358.3,25563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25563,1,3,0)
 ;;=3^Unintented Underdosing d/t Age-Related Disability
 ;;^UTILITY(U,$J,358.3,25563,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,25563,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,25564,0)
 ;;=Z91.138^^66^1035^16
 ;;^UTILITY(U,$J,358.3,25564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25564,1,3,0)
 ;;=3^Unintented Underdosing,Other Reasons
 ;;^UTILITY(U,$J,358.3,25564,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,25564,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,25565,0)
 ;;=T38.3X6A^^66^1035^3
 ;;^UTILITY(U,$J,358.3,25565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25565,1,3,0)
 ;;=3^Underdosing Insulin/Hypoglycemic Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,25565,1,4,0)
 ;;=4^T38.3X6A
 ;;^UTILITY(U,$J,358.3,25565,2)
 ;;=^5049649
 ;;^UTILITY(U,$J,358.3,25566,0)
 ;;=T38.3X6S^^66^1035^4
 ;;^UTILITY(U,$J,358.3,25566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25566,1,3,0)
 ;;=3^Underdosing Insulin/Hypoglycemic Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,25566,1,4,0)
 ;;=4^T38.3X6S
 ;;^UTILITY(U,$J,358.3,25566,2)
 ;;=^5049651
 ;;^UTILITY(U,$J,358.3,25567,0)
 ;;=T38.3X6D^^66^1035^5
 ;;^UTILITY(U,$J,358.3,25567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25567,1,3,0)
 ;;=3^Underdosing Insulin/Hypoglycemic Drugs,Sub Encntr
 ;;^UTILITY(U,$J,358.3,25567,1,4,0)
 ;;=4^T38.3X6D
 ;;^UTILITY(U,$J,358.3,25567,2)
 ;;=^5049650
 ;;^UTILITY(U,$J,358.3,25568,0)
 ;;=T46.5X6A^^66^1035^9
 ;;^UTILITY(U,$J,358.3,25568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25568,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Init Encntr
 ;;^UTILITY(U,$J,358.3,25568,1,4,0)
 ;;=4^T46.5X6A
 ;;^UTILITY(U,$J,358.3,25568,2)
 ;;=^5051353
 ;;^UTILITY(U,$J,358.3,25569,0)
 ;;=T46.5X6D^^66^1035^10
 ;;^UTILITY(U,$J,358.3,25569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25569,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Subs Encntr
 ;;^UTILITY(U,$J,358.3,25569,1,4,0)
 ;;=4^T46.5X6D
 ;;^UTILITY(U,$J,358.3,25569,2)
 ;;=^5051354
 ;;^UTILITY(U,$J,358.3,25570,0)
 ;;=T46.5X6S^^66^1035^11
 ;;^UTILITY(U,$J,358.3,25570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25570,1,3,0)
 ;;=3^Underdosing of Antihypertensive Drugs,Sequela
 ;;^UTILITY(U,$J,358.3,25570,1,4,0)
 ;;=4^T46.5X6S
 ;;^UTILITY(U,$J,358.3,25570,2)
 ;;=^5051355
 ;;^UTILITY(U,$J,358.3,25571,0)
 ;;=T43.206A^^66^1035^6
 ;;^UTILITY(U,$J,358.3,25571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25571,1,3,0)
 ;;=3^Underdosing of Antidepressants,Init Encntr
 ;;^UTILITY(U,$J,358.3,25571,1,4,0)
 ;;=4^T43.206A
 ;;^UTILITY(U,$J,358.3,25571,2)
 ;;=^5050543
 ;;^UTILITY(U,$J,358.3,25572,0)
 ;;=T43.206S^^66^1035^7
 ;;^UTILITY(U,$J,358.3,25572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25572,1,3,0)
 ;;=3^Underdosing of Antidepressants,Sequela
 ;;^UTILITY(U,$J,358.3,25572,1,4,0)
 ;;=4^T43.206S
 ;;^UTILITY(U,$J,358.3,25572,2)
 ;;=^5050545
 ;;^UTILITY(U,$J,358.3,25573,0)
 ;;=T43.206D^^66^1035^8
 ;;^UTILITY(U,$J,358.3,25573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25573,1,3,0)
 ;;=3^Underdosing of Antidepressants,Subs Encntr
 ;;^UTILITY(U,$J,358.3,25573,1,4,0)
 ;;=4^T43.206D
 ;;^UTILITY(U,$J,358.3,25573,2)
 ;;=^5050544
 ;;^UTILITY(U,$J,358.3,25574,0)
 ;;=T43.506A^^66^1035^12
 ;;^UTILITY(U,$J,358.3,25574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25574,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Init Encntr
 ;;^UTILITY(U,$J,358.3,25574,1,4,0)
 ;;=4^T43.506A
 ;;^UTILITY(U,$J,358.3,25574,2)
 ;;=^5050651
 ;;^UTILITY(U,$J,358.3,25575,0)
 ;;=T43.506S^^66^1035^13
 ;;^UTILITY(U,$J,358.3,25575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25575,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Sequela
 ;;^UTILITY(U,$J,358.3,25575,1,4,0)
 ;;=4^T43.506S
 ;;^UTILITY(U,$J,358.3,25575,2)
 ;;=^5050653
 ;;^UTILITY(U,$J,358.3,25576,0)
 ;;=T43.506D^^66^1035^14
 ;;^UTILITY(U,$J,358.3,25576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25576,1,3,0)
 ;;=3^Underdosing of Antipsychotics & Neuroleptics,Subs Encntr
 ;;^UTILITY(U,$J,358.3,25576,1,4,0)
 ;;=4^T43.506D
 ;;^UTILITY(U,$J,358.3,25576,2)
 ;;=^5050652
 ;;^UTILITY(U,$J,358.3,25577,0)
 ;;=90833^^67^1036^1^^^^1
 ;;^UTILITY(U,$J,358.3,25577,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25577,1,2,0)
 ;;=2^90833
 ;;^UTILITY(U,$J,358.3,25577,1,3,0)
 ;;=3^Psytx 16-37 min;Report w/ E&M
 ;;^UTILITY(U,$J,358.3,25578,0)
 ;;=90836^^67^1036^2^^^^1
 ;;^UTILITY(U,$J,358.3,25578,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25578,1,2,0)
 ;;=2^90836
 ;;^UTILITY(U,$J,358.3,25578,1,3,0)
 ;;=3^Psytx 38-52 min;Report w/ E&M
 ;;^UTILITY(U,$J,358.3,25579,0)
 ;;=90838^^67^1036^3^^^^1
 ;;^UTILITY(U,$J,358.3,25579,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25579,1,2,0)
 ;;=2^90838
 ;;^UTILITY(U,$J,358.3,25579,1,3,0)
 ;;=3^Psytx 53-89 min;Report w/ E&M
 ;;^UTILITY(U,$J,358.3,25580,0)
 ;;=90853^^67^1037^4^^^^1
 ;;^UTILITY(U,$J,358.3,25580,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25580,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,25580,1,3,0)
 ;;=3^Group Psychotherapy
 ;;^UTILITY(U,$J,358.3,25581,0)
 ;;=90846^^67^1037^5^^^^1
 ;;^UTILITY(U,$J,358.3,25581,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25581,1,2,0)
 ;;=2^90846
 ;;^UTILITY(U,$J,358.3,25581,1,3,0)
 ;;=3^Family Psychotherapy w/o pt.
 ;;^UTILITY(U,$J,358.3,25582,0)
 ;;=90847^^67^1037^6^^^^1
 ;;^UTILITY(U,$J,358.3,25582,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25582,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,25582,1,3,0)
 ;;=3^Family Psychotherpy w/pt.
 ;;^UTILITY(U,$J,358.3,25583,0)
 ;;=90875^^67^1037^7^^^^1
 ;;^UTILITY(U,$J,358.3,25583,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25583,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,25583,1,3,0)
 ;;=3^Indiv Psychophysiological Tx w/ Biofeedback,30 min
 ;;^UTILITY(U,$J,358.3,25584,0)
 ;;=90876^^67^1037^8^^^^1
 ;;^UTILITY(U,$J,358.3,25584,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25584,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,25584,1,3,0)
 ;;=3^Indiv Psychophysiological Tx w/ Biofeedback,45 min
 ;;^UTILITY(U,$J,358.3,25585,0)
 ;;=90832^^67^1037^1^^^^1
 ;;^UTILITY(U,$J,358.3,25585,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25585,1,2,0)
 ;;=2^90832
 ;;^UTILITY(U,$J,358.3,25585,1,3,0)
 ;;=3^Psychotherapy 16-37 min
 ;;^UTILITY(U,$J,358.3,25586,0)
 ;;=90834^^67^1037^2^^^^1
 ;;^UTILITY(U,$J,358.3,25586,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25586,1,2,0)
 ;;=2^90834
 ;;^UTILITY(U,$J,358.3,25586,1,3,0)
 ;;=3^Psychotherapy 38-52 min
 ;;^UTILITY(U,$J,358.3,25587,0)
 ;;=90837^^67^1037^3^^^^1
 ;;^UTILITY(U,$J,358.3,25587,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25587,1,2,0)
 ;;=2^90837
 ;;^UTILITY(U,$J,358.3,25587,1,3,0)
 ;;=3^Psychotherapy 53-89 min
 ;;^UTILITY(U,$J,358.3,25588,0)
 ;;=90849^^67^1037^9^^^^1
 ;;^UTILITY(U,$J,358.3,25588,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25588,1,2,0)
 ;;=2^90849
 ;;^UTILITY(U,$J,358.3,25588,1,3,0)
 ;;=3^Multiple Family Psychotherapy
 ;;^UTILITY(U,$J,358.3,25589,0)
 ;;=J1631^^67^1038^13^^^^1
 ;;^UTILITY(U,$J,358.3,25589,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25589,1,2,0)
 ;;=2^J1631
 ;;^UTILITY(U,$J,358.3,25589,1,3,0)
 ;;=3^Haloperidol Decanoate,per 50 mg
 ;;^UTILITY(U,$J,358.3,25590,0)
 ;;=97545^^67^1038^44^^^^1
 ;;^UTILITY(U,$J,358.3,25590,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25590,1,2,0)
 ;;=2^97545
 ;;^UTILITY(U,$J,358.3,25590,1,3,0)
 ;;=3^Work Hardening/Conditioning,Init 2 hrs
 ;;^UTILITY(U,$J,358.3,25591,0)
 ;;=97546^^67^1038^45^^^^1
 ;;^UTILITY(U,$J,358.3,25591,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25591,1,2,0)
 ;;=2^97546
 ;;^UTILITY(U,$J,358.3,25591,1,3,0)
 ;;=3^Work Hardening/Conditioning,ea addl hr
 ;;^UTILITY(U,$J,358.3,25592,0)
 ;;=97537^^67^1038^4^^^^1
 ;;^UTILITY(U,$J,358.3,25592,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25592,1,2,0)
 ;;=2^97537
 ;;^UTILITY(U,$J,358.3,25592,1,3,0)
 ;;=3^Community/Work Reintegration ea 15 min by Phd/Phys
 ;;^UTILITY(U,$J,358.3,25593,0)
 ;;=97532^^67^1038^3^^^^1
 ;;^UTILITY(U,$J,358.3,25593,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25593,1,2,0)
 ;;=2^97532
 ;;^UTILITY(U,$J,358.3,25593,1,3,0)
 ;;=3^Cognitive Skills Development,ea 15 min
 ;;^UTILITY(U,$J,358.3,25594,0)
 ;;=97533^^67^1038^32^^^^1
 ;;^UTILITY(U,$J,358.3,25594,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25594,1,2,0)
 ;;=2^97533
 ;;^UTILITY(U,$J,358.3,25594,1,3,0)
 ;;=3^Sensory Integrative Techniques,per 15 min
