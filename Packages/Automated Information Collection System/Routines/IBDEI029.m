IBDEI029 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2480,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,2481,0)
 ;;=K58.0^^14^184^5
 ;;^UTILITY(U,$J,358.3,2481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2481,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,2481,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,2481,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,2482,0)
 ;;=K58.9^^14^184^6
 ;;^UTILITY(U,$J,358.3,2482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2482,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,2482,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,2482,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,2483,0)
 ;;=K59.1^^14^184^2
 ;;^UTILITY(U,$J,358.3,2483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2483,1,3,0)
 ;;=3^Functional Diarrhea
 ;;^UTILITY(U,$J,358.3,2483,1,4,0)
 ;;=4^K59.1
 ;;^UTILITY(U,$J,358.3,2483,2)
 ;;=^270281
 ;;^UTILITY(U,$J,358.3,2484,0)
 ;;=K91.2^^14^184^7
 ;;^UTILITY(U,$J,358.3,2484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2484,1,3,0)
 ;;=3^Postsurgical Malabsorption NEC
 ;;^UTILITY(U,$J,358.3,2484,1,4,0)
 ;;=4^K91.2
 ;;^UTILITY(U,$J,358.3,2484,2)
 ;;=^5008901
 ;;^UTILITY(U,$J,358.3,2485,0)
 ;;=S06.2X1S^^14^185^3
 ;;^UTILITY(U,$J,358.3,2485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2485,1,3,0)
 ;;=3^Diffuse TBI w/ LOC of < 31 min,Sequela
 ;;^UTILITY(U,$J,358.3,2485,1,4,0)
 ;;=4^S06.2X1S
 ;;^UTILITY(U,$J,358.3,2485,2)
 ;;=^5020731
 ;;^UTILITY(U,$J,358.3,2486,0)
 ;;=S14.2XXD^^14^185^12
 ;;^UTILITY(U,$J,358.3,2486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2486,1,3,0)
 ;;=3^Nerve Root of Cervical Spine Inj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2486,1,4,0)
 ;;=4^S14.2XXD
 ;;^UTILITY(U,$J,358.3,2486,2)
 ;;=^5022203
 ;;^UTILITY(U,$J,358.3,2487,0)
 ;;=S16.1XXD^^14^185^11
 ;;^UTILITY(U,$J,358.3,2487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2487,1,3,0)
 ;;=3^Neck Muscle/Fascia/Tendon Strain,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2487,1,4,0)
 ;;=4^S16.1XXD
 ;;^UTILITY(U,$J,358.3,2487,2)
 ;;=^5022359
 ;;^UTILITY(U,$J,358.3,2488,0)
 ;;=S16.2XXD^^14^185^10
 ;;^UTILITY(U,$J,358.3,2488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2488,1,3,0)
 ;;=3^Neck Muscle/Fascia/Tendon Laceration,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2488,1,4,0)
 ;;=4^S16.2XXD
 ;;^UTILITY(U,$J,358.3,2488,2)
 ;;=^5022362
 ;;^UTILITY(U,$J,358.3,2489,0)
 ;;=S19.9XXD^^14^185^9
 ;;^UTILITY(U,$J,358.3,2489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2489,1,3,0)
 ;;=3^Neck Injury,Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2489,1,4,0)
 ;;=4^S19.9XXD
 ;;^UTILITY(U,$J,358.3,2489,2)
 ;;=^5022401
 ;;^UTILITY(U,$J,358.3,2490,0)
 ;;=S29.092D^^14^185^18
 ;;^UTILITY(U,$J,358.3,2490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2490,1,3,0)
 ;;=3^Thorax Back Wall Muscle/Tendon Inj,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2490,1,4,0)
 ;;=4^S29.092D
 ;;^UTILITY(U,$J,358.3,2490,2)
 ;;=^5023796
 ;;^UTILITY(U,$J,358.3,2491,0)
 ;;=S33.5XXA^^14^185^6
 ;;^UTILITY(U,$J,358.3,2491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2491,1,3,0)
 ;;=3^Lumbar Spine Ligament Sprain,Init Encntr
 ;;^UTILITY(U,$J,358.3,2491,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,2491,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,2492,0)
 ;;=S39.012D^^14^185^5
 ;;^UTILITY(U,$J,358.3,2492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2492,1,3,0)
 ;;=3^Lower Back Muscle/Fascia/Tendon Strain,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2492,1,4,0)
 ;;=4^S39.012D
 ;;^UTILITY(U,$J,358.3,2492,2)
 ;;=^5026103
 ;;^UTILITY(U,$J,358.3,2493,0)
 ;;=S44.8X2D^^14^185^16
 ;;^UTILITY(U,$J,358.3,2493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2493,1,3,0)
 ;;=3^Shoulder/Upper Arm Nerve Inj,Left Arm,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2493,1,4,0)
 ;;=4^S44.8X2D
 ;;^UTILITY(U,$J,358.3,2493,2)
 ;;=^5027994
 ;;^UTILITY(U,$J,358.3,2494,0)
 ;;=S46.091S^^14^185^15
 ;;^UTILITY(U,$J,358.3,2494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2494,1,3,0)
 ;;=3^Rotator Cuff Muscle/Tendon Inj,Right Shoulder,Sequela
 ;;^UTILITY(U,$J,358.3,2494,1,4,0)
 ;;=4^S46.091S
 ;;^UTILITY(U,$J,358.3,2494,2)
 ;;=^5028166
 ;;^UTILITY(U,$J,358.3,2495,0)
 ;;=S76.312A^^14^185^7
 ;;^UTILITY(U,$J,358.3,2495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2495,1,3,0)
 ;;=3^Muscle/Fascia/Tendon Strain,Left Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,2495,1,4,0)
 ;;=4^S76.312A
 ;;^UTILITY(U,$J,358.3,2495,2)
 ;;=^5039609
 ;;^UTILITY(U,$J,358.3,2496,0)
 ;;=S83.91XA^^14^185^13
 ;;^UTILITY(U,$J,358.3,2496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2496,1,3,0)
 ;;=3^Right Knee Sprain,Init Encntr
 ;;^UTILITY(U,$J,358.3,2496,1,4,0)
 ;;=4^S83.91XA
 ;;^UTILITY(U,$J,358.3,2496,2)
 ;;=^5043172
 ;;^UTILITY(U,$J,358.3,2497,0)
 ;;=S88.112S^^14^185^1
 ;;^UTILITY(U,$J,358.3,2497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2497,1,3,0)
 ;;=3^Complete Traumatic Amputation,Between Left Knee and Ankle,Sequela
 ;;^UTILITY(U,$J,358.3,2497,1,4,0)
 ;;=4^S88.112S
 ;;^UTILITY(U,$J,358.3,2497,2)
 ;;=^5043606
 ;;^UTILITY(U,$J,358.3,2498,0)
 ;;=S44.8X1D^^14^185^17
 ;;^UTILITY(U,$J,358.3,2498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2498,1,3,0)
 ;;=3^Shoulder/Upper Arm Nerve Inj,Right Arm,Subs Encntr
 ;;^UTILITY(U,$J,358.3,2498,1,4,0)
 ;;=4^S44.8X1D
 ;;^UTILITY(U,$J,358.3,2498,2)
 ;;=^5027991
 ;;^UTILITY(U,$J,358.3,2499,0)
 ;;=S46.092S^^14^185^14
 ;;^UTILITY(U,$J,358.3,2499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2499,1,3,0)
 ;;=3^Rotator Cuff Muscle/Tendon Inj,Left Shoulder,Sequela
 ;;^UTILITY(U,$J,358.3,2499,1,4,0)
 ;;=4^S46.092S
 ;;^UTILITY(U,$J,358.3,2499,2)
 ;;=^5134838
 ;;^UTILITY(U,$J,358.3,2500,0)
 ;;=S76.311A^^14^185^8
 ;;^UTILITY(U,$J,358.3,2500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2500,1,3,0)
 ;;=3^Muscle/Fascia/Tendon Strain,Left Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,2500,1,4,0)
 ;;=4^S76.311A
 ;;^UTILITY(U,$J,358.3,2500,2)
 ;;=^5039606
 ;;^UTILITY(U,$J,358.3,2501,0)
 ;;=S83.92XA^^14^185^4
 ;;^UTILITY(U,$J,358.3,2501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2501,1,3,0)
 ;;=3^Left Knee Sprain,Init Encntr
 ;;^UTILITY(U,$J,358.3,2501,1,4,0)
 ;;=4^S83.92XA
 ;;^UTILITY(U,$J,358.3,2501,2)
 ;;=^5043175
 ;;^UTILITY(U,$J,358.3,2502,0)
 ;;=S88.111S^^14^185^2
 ;;^UTILITY(U,$J,358.3,2502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2502,1,3,0)
 ;;=3^Complete Traumatic Amputation,Between Right Knee and Ankle,Sequela
 ;;^UTILITY(U,$J,358.3,2502,1,4,0)
 ;;=4^S88.111S
 ;;^UTILITY(U,$J,358.3,2502,2)
 ;;=^5043603
 ;;^UTILITY(U,$J,358.3,2503,0)
 ;;=C79.51^^14^186^5
 ;;^UTILITY(U,$J,358.3,2503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2503,1,3,0)
 ;;=3^Secondary Malig Neop of Bone
 ;;^UTILITY(U,$J,358.3,2503,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,2503,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,2504,0)
 ;;=C7A.8^^14^186^3
 ;;^UTILITY(U,$J,358.3,2504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2504,1,3,0)
 ;;=3^Malig Neuroendocrine Tumors NEC
 ;;^UTILITY(U,$J,358.3,2504,1,4,0)
 ;;=4^C7A.8
 ;;^UTILITY(U,$J,358.3,2504,2)
 ;;=^5001380
 ;;^UTILITY(U,$J,358.3,2505,0)
 ;;=C82.90^^14^186^2
 ;;^UTILITY(U,$J,358.3,2505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2505,1,3,0)
 ;;=3^Follicular Lymphoma
 ;;^UTILITY(U,$J,358.3,2505,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,2505,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,2506,0)
 ;;=C90.00^^14^186^4
 ;;^UTILITY(U,$J,358.3,2506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2506,1,3,0)
 ;;=3^Multiple Myeloma,Not in Remission
 ;;^UTILITY(U,$J,358.3,2506,1,4,0)
 ;;=4^C90.00
 ;;^UTILITY(U,$J,358.3,2506,2)
 ;;=^5001752
 ;;^UTILITY(U,$J,358.3,2507,0)
 ;;=D09.0^^14^186^1
 ;;^UTILITY(U,$J,358.3,2507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2507,1,3,0)
 ;;=3^Carcinoma in Situ of Bladder
 ;;^UTILITY(U,$J,358.3,2507,1,4,0)
 ;;=4^D09.0
 ;;^UTILITY(U,$J,358.3,2507,2)
 ;;=^267742
 ;;^UTILITY(U,$J,358.3,2508,0)
 ;;=J30.9^^14^187^1
 ;;^UTILITY(U,$J,358.3,2508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2508,1,3,0)
 ;;=3^Allergic Rhinitis,Unspec
 ;;^UTILITY(U,$J,358.3,2508,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,2508,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,2509,0)
 ;;=J31.0^^14^187^3
 ;;^UTILITY(U,$J,358.3,2509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2509,1,3,0)
 ;;=3^Chronic Rhinitis
 ;;^UTILITY(U,$J,358.3,2509,1,4,0)
 ;;=4^J31.0
 ;;^UTILITY(U,$J,358.3,2509,2)
 ;;=^24434
 ;;^UTILITY(U,$J,358.3,2510,0)
 ;;=J44.9^^14^187^2
 ;;^UTILITY(U,$J,358.3,2510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2510,1,3,0)
 ;;=3^Chronic Obstructive Pulmonary Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2510,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,2510,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,2511,0)
 ;;=J45.40^^14^187^4
 ;;^UTILITY(U,$J,358.3,2511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2511,1,3,0)
 ;;=3^Moderate Persistent Asthma,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2511,1,4,0)
 ;;=4^J45.40
 ;;^UTILITY(U,$J,358.3,2511,2)
 ;;=^5008248
 ;;^UTILITY(U,$J,358.3,2512,0)
 ;;=R07.0^^14^188^14
 ;;^UTILITY(U,$J,358.3,2512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2512,1,3,0)
 ;;=3^Pain in Throat
 ;;^UTILITY(U,$J,358.3,2512,1,4,0)
 ;;=4^R07.0
 ;;^UTILITY(U,$J,358.3,2512,2)
 ;;=^5019195
 ;;^UTILITY(U,$J,358.3,2513,0)
 ;;=R07.2^^14^188^20
 ;;^UTILITY(U,$J,358.3,2513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2513,1,3,0)
 ;;=3^Precordial Pain
 ;;^UTILITY(U,$J,358.3,2513,1,4,0)
 ;;=4^R07.2
 ;;^UTILITY(U,$J,358.3,2513,2)
 ;;=^5019197
 ;;^UTILITY(U,$J,358.3,2514,0)
 ;;=R07.81^^14^188^19
 ;;^UTILITY(U,$J,358.3,2514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2514,1,3,0)
 ;;=3^Pleurodynia
 ;;^UTILITY(U,$J,358.3,2514,1,4,0)
 ;;=4^R07.81
 ;;^UTILITY(U,$J,358.3,2514,2)
 ;;=^5019198
 ;;^UTILITY(U,$J,358.3,2515,0)
 ;;=R07.9^^14^188^3
 ;;^UTILITY(U,$J,358.3,2515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2515,1,3,0)
 ;;=3^Chest Pain,Unspec
 ;;^UTILITY(U,$J,358.3,2515,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,2515,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,2516,0)
 ;;=R10.2^^14^188^17
 ;;^UTILITY(U,$J,358.3,2516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2516,1,3,0)
 ;;=3^Pelvic and Perineal Pain
