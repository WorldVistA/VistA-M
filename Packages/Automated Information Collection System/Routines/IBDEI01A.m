IBDEI01A ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2598,1,3,0)
 ;;=3^Aneurysm of Carotid Artery
 ;;^UTILITY(U,$J,358.3,2598,1,4,0)
 ;;=4^I72.0
 ;;^UTILITY(U,$J,358.3,2598,2)
 ;;=^5007793
 ;;^UTILITY(U,$J,358.3,2599,0)
 ;;=I72.8^^20^161^3
 ;;^UTILITY(U,$J,358.3,2599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2599,1,3,0)
 ;;=3^Aneurysm of Arteries NEC
 ;;^UTILITY(U,$J,358.3,2599,1,4,0)
 ;;=4^I72.8
 ;;^UTILITY(U,$J,358.3,2599,2)
 ;;=^5007794
 ;;^UTILITY(U,$J,358.3,2600,0)
 ;;=I73.00^^20^161^94
 ;;^UTILITY(U,$J,358.3,2600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2600,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,2600,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,2600,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,2601,0)
 ;;=I73.1^^20^161^103
 ;;^UTILITY(U,$J,358.3,2601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2601,1,3,0)
 ;;=3^Thromboangiitis Obliterans
 ;;^UTILITY(U,$J,358.3,2601,1,4,0)
 ;;=4^I73.1
 ;;^UTILITY(U,$J,358.3,2601,2)
 ;;=^5007798
 ;;^UTILITY(U,$J,358.3,2602,0)
 ;;=I73.9^^20^161^93
 ;;^UTILITY(U,$J,358.3,2602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2602,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2602,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,2602,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,2603,0)
 ;;=I74.01^^20^161^95
 ;;^UTILITY(U,$J,358.3,2603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2603,1,3,0)
 ;;=3^Saddle Embolus of Abdominal Aorta
 ;;^UTILITY(U,$J,358.3,2603,1,4,0)
 ;;=4^I74.01
 ;;^UTILITY(U,$J,358.3,2603,2)
 ;;=^340522
 ;;^UTILITY(U,$J,358.3,2604,0)
 ;;=I74.09^^20^161^12
 ;;^UTILITY(U,$J,358.3,2604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2604,1,3,0)
 ;;=3^Arterial Embolism/Thrombosis of Abdominal Aorta NEC
 ;;^UTILITY(U,$J,358.3,2604,1,4,0)
 ;;=4^I74.09
 ;;^UTILITY(U,$J,358.3,2604,2)
 ;;=^340523
 ;;^UTILITY(U,$J,358.3,2605,0)
 ;;=I74.11^^20^161^80
 ;;^UTILITY(U,$J,358.3,2605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2605,1,3,0)
 ;;=3^Embolism/Thrombosis of Thoracic Aorta
 ;;^UTILITY(U,$J,358.3,2605,1,4,0)
 ;;=4^I74.11
 ;;^UTILITY(U,$J,358.3,2605,2)
 ;;=^269787
 ;;^UTILITY(U,$J,358.3,2606,0)
 ;;=I74.2^^20^161^83
 ;;^UTILITY(U,$J,358.3,2606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2606,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,2606,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,2606,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,2607,0)
 ;;=I74.3^^20^161^78
 ;;^UTILITY(U,$J,358.3,2607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2607,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,2607,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,2607,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,2608,0)
 ;;=I74.5^^20^161^77
 ;;^UTILITY(U,$J,358.3,2608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2608,1,3,0)
 ;;=3^Embolism/Thrombosis of Iliac Artery
 ;;^UTILITY(U,$J,358.3,2608,1,4,0)
 ;;=4^I74.5
 ;;^UTILITY(U,$J,358.3,2608,2)
 ;;=^269792
 ;;^UTILITY(U,$J,358.3,2609,0)
 ;;=I74.8^^20^161^76
 ;;^UTILITY(U,$J,358.3,2609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2609,1,3,0)
 ;;=3^Embolism/Thrombosis of Arteries NEC
 ;;^UTILITY(U,$J,358.3,2609,1,4,0)
 ;;=4^I74.8
 ;;^UTILITY(U,$J,358.3,2609,2)
 ;;=^5007804
 ;;^UTILITY(U,$J,358.3,2610,0)
 ;;=I77.0^^20^161^14
 ;;^UTILITY(U,$J,358.3,2610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2610,1,3,0)
 ;;=3^Arteriovenous Fistula,Acquired
 ;;^UTILITY(U,$J,358.3,2610,1,4,0)
 ;;=4^I77.0
 ;;^UTILITY(U,$J,358.3,2610,2)
 ;;=^46674
 ;;^UTILITY(U,$J,358.3,2611,0)
 ;;=I77.1^^20^161^98
 ;;^UTILITY(U,$J,358.3,2611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2611,1,3,0)
 ;;=3^Stricture of Artery
 ;;^UTILITY(U,$J,358.3,2611,1,4,0)
 ;;=4^I77.1
 ;;^UTILITY(U,$J,358.3,2611,2)
 ;;=^114763
 ;;^UTILITY(U,$J,358.3,2612,0)
 ;;=I77.3^^20^161^13
 ;;^UTILITY(U,$J,358.3,2612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2612,1,3,0)
 ;;=3^Arterial Fibromuscular Dysplasia
 ;;^UTILITY(U,$J,358.3,2612,1,4,0)
 ;;=4^I77.3
 ;;^UTILITY(U,$J,358.3,2612,2)
 ;;=^5007812
 ;;^UTILITY(U,$J,358.3,2613,0)
 ;;=I77.6^^20^161^15
 ;;^UTILITY(U,$J,358.3,2613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2613,1,3,0)
 ;;=3^Arteritis,Unspec
 ;;^UTILITY(U,$J,358.3,2613,1,4,0)
 ;;=4^I77.6
 ;;^UTILITY(U,$J,358.3,2613,2)
 ;;=^5007813
 ;;^UTILITY(U,$J,358.3,2614,0)
 ;;=I82.90^^20^161^81
 ;;^UTILITY(U,$J,358.3,2614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2614,1,3,0)
 ;;=3^Embolism/Thrombosis of Unspec Vein,Acute
 ;;^UTILITY(U,$J,358.3,2614,1,4,0)
 ;;=4^I82.90
 ;;^UTILITY(U,$J,358.3,2614,2)
 ;;=^5007940
 ;;^UTILITY(U,$J,358.3,2615,0)
 ;;=I82.91^^20^161^82
 ;;^UTILITY(U,$J,358.3,2615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2615,1,3,0)
 ;;=3^Embolism/Thrombosis of Unspec Vein,Chronic
 ;;^UTILITY(U,$J,358.3,2615,1,4,0)
 ;;=4^I82.91
 ;;^UTILITY(U,$J,358.3,2615,2)
 ;;=^5007941
 ;;^UTILITY(U,$J,358.3,2616,0)
 ;;=I87.2^^20^161^108
 ;;^UTILITY(U,$J,358.3,2616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2616,1,3,0)
 ;;=3^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,2616,1,4,0)
 ;;=4^I87.2
 ;;^UTILITY(U,$J,358.3,2616,2)
 ;;=^5008047
 ;;^UTILITY(U,$J,358.3,2617,0)
 ;;=I82.0^^20^161^53
 ;;^UTILITY(U,$J,358.3,2617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2617,1,3,0)
 ;;=3^Budd-Chiari Syndrome
 ;;^UTILITY(U,$J,358.3,2617,1,4,0)
 ;;=4^I82.0
 ;;^UTILITY(U,$J,358.3,2617,2)
 ;;=^5007846
 ;;^UTILITY(U,$J,358.3,2618,0)
 ;;=I82.1^^20^161^104
 ;;^UTILITY(U,$J,358.3,2618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2618,1,3,0)
 ;;=3^Thrombophlebitis Migrans
 ;;^UTILITY(U,$J,358.3,2618,1,4,0)
 ;;=4^I82.1
 ;;^UTILITY(U,$J,358.3,2618,2)
 ;;=^5007847
 ;;^UTILITY(U,$J,358.3,2619,0)
 ;;=I82.3^^20^161^79
 ;;^UTILITY(U,$J,358.3,2619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2619,1,3,0)
 ;;=3^Embolism/Thrombosis of Renal Vein
 ;;^UTILITY(U,$J,358.3,2619,1,4,0)
 ;;=4^I82.3
 ;;^UTILITY(U,$J,358.3,2619,2)
 ;;=^269818
 ;;^UTILITY(U,$J,358.3,2620,0)
 ;;=I87.1^^20^161^107
 ;;^UTILITY(U,$J,358.3,2620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2620,1,3,0)
 ;;=3^Vein Compression
 ;;^UTILITY(U,$J,358.3,2620,1,4,0)
 ;;=4^I87.1
 ;;^UTILITY(U,$J,358.3,2620,2)
 ;;=^269850
 ;;^UTILITY(U,$J,358.3,2621,0)
 ;;=T82.818A^^20^161^75
 ;;^UTILITY(U,$J,358.3,2621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2621,1,3,0)
 ;;=3^Embolism of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2621,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,2621,2)
 ;;=^5054917
 ;;^UTILITY(U,$J,358.3,2622,0)
 ;;=T82.828A^^20^161^84
 ;;^UTILITY(U,$J,358.3,2622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2622,1,3,0)
 ;;=3^Fibrosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2622,1,4,0)
 ;;=4^T82.828A
 ;;^UTILITY(U,$J,358.3,2622,2)
 ;;=^5054923
 ;;^UTILITY(U,$J,358.3,2623,0)
 ;;=T82.868A^^20^161^105
 ;;^UTILITY(U,$J,358.3,2623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2623,1,3,0)
 ;;=3^Thrombosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2623,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,2623,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,2624,0)
 ;;=I72.5^^20^161^7
 ;;^UTILITY(U,$J,358.3,2624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2624,1,3,0)
 ;;=3^Aneurysm of Other Precerebral Arteries
 ;;^UTILITY(U,$J,358.3,2624,1,4,0)
 ;;=4^I72.5
 ;;^UTILITY(U,$J,358.3,2624,2)
 ;;=^5138668
 ;;^UTILITY(U,$J,358.3,2625,0)
 ;;=I72.6^^20^161^10
 ;;^UTILITY(U,$J,358.3,2625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2625,1,3,0)
 ;;=3^Aneurysm of Vertebral Artery
 ;;^UTILITY(U,$J,358.3,2625,1,4,0)
 ;;=4^I72.6
 ;;^UTILITY(U,$J,358.3,2625,2)
 ;;=^5138669
 ;;^UTILITY(U,$J,358.3,2626,0)
 ;;=I63.133^^20^161^54
 ;;^UTILITY(U,$J,358.3,2626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2626,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,2626,1,4,0)
 ;;=4^I63.133
 ;;^UTILITY(U,$J,358.3,2626,2)
 ;;=^5138605
 ;;^UTILITY(U,$J,358.3,2627,0)
 ;;=I63.033^^20^161^57
 ;;^UTILITY(U,$J,358.3,2627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2627,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,2627,1,4,0)
 ;;=4^I63.033
 ;;^UTILITY(U,$J,358.3,2627,2)
 ;;=^5138603
 ;;^UTILITY(U,$J,358.3,2628,0)
 ;;=I63.213^^20^161^65
 ;;^UTILITY(U,$J,358.3,2628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2628,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occl/Stenosis of Bilateral Vertebral Artery
 ;;^UTILITY(U,$J,358.3,2628,1,4,0)
 ;;=4^I63.213
 ;;^UTILITY(U,$J,358.3,2628,2)
 ;;=^5138606
 ;;^UTILITY(U,$J,358.3,2629,0)
 ;;=I77.77^^20^161^69
 ;;^UTILITY(U,$J,358.3,2629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2629,1,3,0)
 ;;=3^Dissection of Artery of Lower Extremity
 ;;^UTILITY(U,$J,358.3,2629,1,4,0)
 ;;=4^I77.77
 ;;^UTILITY(U,$J,358.3,2629,2)
 ;;=^5138672
 ;;^UTILITY(U,$J,358.3,2630,0)
 ;;=I77.76^^20^161^70
 ;;^UTILITY(U,$J,358.3,2630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2630,1,3,0)
 ;;=3^Dissection of Artery of Upper Extremity
 ;;^UTILITY(U,$J,358.3,2630,1,4,0)
 ;;=4^I77.76
 ;;^UTILITY(U,$J,358.3,2630,2)
 ;;=^8292560
 ;;^UTILITY(U,$J,358.3,2631,0)
 ;;=I77.75^^20^161^71
 ;;^UTILITY(U,$J,358.3,2631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2631,1,3,0)
 ;;=3^Dissection of Other Precerebral Arteries
 ;;^UTILITY(U,$J,358.3,2631,1,4,0)
 ;;=4^I77.75
 ;;^UTILITY(U,$J,358.3,2631,2)
 ;;=^5138671
 ;;^UTILITY(U,$J,358.3,2632,0)
 ;;=I77.79^^20^161^74
 ;;^UTILITY(U,$J,358.3,2632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2632,1,3,0)
 ;;=3^Dissection of Unspec Artery
 ;;^UTILITY(U,$J,358.3,2632,1,4,0)
 ;;=4^I77.79
 ;;^UTILITY(U,$J,358.3,2632,2)
 ;;=^328513
 ;;^UTILITY(U,$J,358.3,2633,0)
 ;;=T82.855A^^20^161^96
 ;;^UTILITY(U,$J,358.3,2633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2633,1,3,0)
 ;;=3^Stenosis/Restenosis of Coronary Artery Stent,Init Encntr
 ;;^UTILITY(U,$J,358.3,2633,1,4,0)
 ;;=4^T82.855A
 ;;^UTILITY(U,$J,358.3,2633,2)
 ;;=^5140030
 ;;^UTILITY(U,$J,358.3,2634,0)
 ;;=T82.856A^^20^161^97
 ;;^UTILITY(U,$J,358.3,2634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2634,1,3,0)
 ;;=3^Stenosis/Restenosis of Periph Vascular Stent,Init Encntr
 ;;^UTILITY(U,$J,358.3,2634,1,4,0)
 ;;=4^T82.856A
 ;;^UTILITY(U,$J,358.3,2634,2)
 ;;=^5140033
 ;;^UTILITY(U,$J,358.3,2635,0)
 ;;=I63.233^^20^161^66
 ;;^UTILITY(U,$J,358.3,2635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2635,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occl/Stenosis of Bilateral Carotid Artery
 ;;^UTILITY(U,$J,358.3,2635,1,4,0)
 ;;=4^I63.233
 ;;^UTILITY(U,$J,358.3,2635,2)
 ;;=^5138607
 ;;^UTILITY(U,$J,358.3,2636,0)
 ;;=I08.0^^20^162^5
 ;;^UTILITY(U,$J,358.3,2636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2636,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral and Aortic Valves
 ;;^UTILITY(U,$J,358.3,2636,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,2636,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,2637,0)
 ;;=I05.0^^20^162^8
 ;;^UTILITY(U,$J,358.3,2637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2637,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,2637,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,2637,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,2638,0)
 ;;=I05.1^^20^162^7
 ;;^UTILITY(U,$J,358.3,2638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2638,1,3,0)
 ;;=3^Rheumatic Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,2638,1,4,0)
 ;;=4^I05.1
 ;;^UTILITY(U,$J,358.3,2638,2)
 ;;=^269568
 ;;^UTILITY(U,$J,358.3,2639,0)
 ;;=I05.2^^20^162^9
 ;;^UTILITY(U,$J,358.3,2639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2639,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,2639,1,4,0)
 ;;=4^I05.2
 ;;^UTILITY(U,$J,358.3,2639,2)
 ;;=^5007042
 ;;^UTILITY(U,$J,358.3,2640,0)
 ;;=I05.8^^20^162^10
 ;;^UTILITY(U,$J,358.3,2640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2640,1,3,0)
 ;;=3^Rheumatic Mitral Valve Diseases NEC
 ;;^UTILITY(U,$J,358.3,2640,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,2640,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,2641,0)
 ;;=I06.0^^20^162^2
 ;;^UTILITY(U,$J,358.3,2641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2641,1,3,0)
 ;;=3^Rheumatic Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,2641,1,4,0)
 ;;=4^I06.0
 ;;^UTILITY(U,$J,358.3,2641,2)
 ;;=^269573
 ;;^UTILITY(U,$J,358.3,2642,0)
 ;;=I06.1^^20^162^1
 ;;^UTILITY(U,$J,358.3,2642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2642,1,3,0)
 ;;=3^Rheumatic Aortic Insufficiency
 ;;^UTILITY(U,$J,358.3,2642,1,4,0)
 ;;=4^I06.1
 ;;^UTILITY(U,$J,358.3,2642,2)
 ;;=^269575
 ;;^UTILITY(U,$J,358.3,2643,0)
 ;;=I06.2^^20^162^3
 ;;^UTILITY(U,$J,358.3,2643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2643,1,3,0)
 ;;=3^Rheumatic Aortic Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,2643,1,4,0)
 ;;=4^I06.2
 ;;^UTILITY(U,$J,358.3,2643,2)
 ;;=^269577
 ;;^UTILITY(U,$J,358.3,2644,0)
 ;;=I06.8^^20^162^4
 ;;^UTILITY(U,$J,358.3,2644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2644,1,3,0)
 ;;=3^Rheumatic Aortic Valve Diseases NEC
 ;;^UTILITY(U,$J,358.3,2644,1,4,0)
 ;;=4^I06.8
 ;;^UTILITY(U,$J,358.3,2644,2)
 ;;=^5007045
 ;;^UTILITY(U,$J,358.3,2645,0)
 ;;=I09.89^^20^162^6
 ;;^UTILITY(U,$J,358.3,2645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2645,1,3,0)
 ;;=3^Rheumatic Heart Diseases
 ;;^UTILITY(U,$J,358.3,2645,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,2645,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,2646,0)
 ;;=I08.8^^20^162^11
 ;;^UTILITY(U,$J,358.3,2646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2646,1,3,0)
 ;;=3^Rheumatic Multiple Valve Dieases NEC
 ;;^UTILITY(U,$J,358.3,2646,1,4,0)
 ;;=4^I08.8
 ;;^UTILITY(U,$J,358.3,2646,2)
 ;;=^5007056
 ;;^UTILITY(U,$J,358.3,2647,0)
 ;;=T82.9XXA^^20^163^2
 ;;^UTILITY(U,$J,358.3,2647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2647,1,3,0)
 ;;=3^Complication of Cardiac/Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2647,1,4,0)
 ;;=4^T82.9XXA
 ;;^UTILITY(U,$J,358.3,2647,2)
 ;;=^5054956
 ;;^UTILITY(U,$J,358.3,2648,0)
 ;;=T82.857A^^20^163^9
 ;;^UTILITY(U,$J,358.3,2648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2648,1,3,0)
 ;;=3^Stenosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2648,1,4,0)
 ;;=4^T82.857A
 ;;^UTILITY(U,$J,358.3,2648,2)
 ;;=^5054938
 ;;^UTILITY(U,$J,358.3,2649,0)
 ;;=T82.867A^^20^163^10
 ;;^UTILITY(U,$J,358.3,2649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2649,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2649,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,2649,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,2650,0)
 ;;=T82.897A^^20^163^3
 ;;^UTILITY(U,$J,358.3,2650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2650,1,3,0)
 ;;=3^Complications of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2650,1,4,0)
 ;;=4^T82.897A
 ;;^UTILITY(U,$J,358.3,2650,2)
 ;;=^5054950
 ;;^UTILITY(U,$J,358.3,2651,0)
 ;;=T82.817A^^20^163^4
 ;;^UTILITY(U,$J,358.3,2651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2651,1,3,0)
 ;;=3^Ebolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2651,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,2651,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,2652,0)
 ;;=T82.827A^^20^163^5
 ;;^UTILITY(U,$J,358.3,2652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2652,1,3,0)
 ;;=3^Fibrosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2652,1,4,0)
 ;;=4^T82.827A
 ;;^UTILITY(U,$J,358.3,2652,2)
 ;;=^5054920
 ;;^UTILITY(U,$J,358.3,2653,0)
 ;;=T82.837A^^20^163^6
 ;;^UTILITY(U,$J,358.3,2653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2653,1,3,0)
 ;;=3^Hemorrhage of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2653,1,4,0)
 ;;=4^T82.837A
 ;;^UTILITY(U,$J,358.3,2653,2)
 ;;=^5054926
 ;;^UTILITY(U,$J,358.3,2654,0)
 ;;=T82.847A^^20^163^7
 ;;^UTILITY(U,$J,358.3,2654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2654,1,3,0)
 ;;=3^Pain from Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2654,1,4,0)
 ;;=4^T82.847A
 ;;^UTILITY(U,$J,358.3,2654,2)
 ;;=^5054932
 ;;^UTILITY(U,$J,358.3,2655,0)
 ;;=Z45.09^^20^163^1
 ;;^UTILITY(U,$J,358.3,2655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2655,1,3,0)
 ;;=3^Adjustment/Management of Cardiac Device
 ;;^UTILITY(U,$J,358.3,2655,1,4,0)
 ;;=4^Z45.09
 ;;^UTILITY(U,$J,358.3,2655,2)
 ;;=^5062997
 ;;^UTILITY(U,$J,358.3,2656,0)
 ;;=Z01.810^^20^163^8
 ;;^UTILITY(U,$J,358.3,2656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2656,1,3,0)
 ;;=3^Preprocedural Cardiovascular Examination
 ;;^UTILITY(U,$J,358.3,2656,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,2656,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,2657,0)
 ;;=G90.01^^20^164^1
 ;;^UTILITY(U,$J,358.3,2657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2657,1,3,0)
 ;;=3^Carotid Sinus Syncope
 ;;^UTILITY(U,$J,358.3,2657,1,4,0)
 ;;=4^G90.01
 ;;^UTILITY(U,$J,358.3,2657,2)
 ;;=^5004160
 ;;^UTILITY(U,$J,358.3,2658,0)
 ;;=R55.^^20^164^2
 ;;^UTILITY(U,$J,358.3,2658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2658,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,2658,1,4,0)
 ;;=4^R55.
 ;;^UTILITY(U,$J,358.3,2658,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,2659,0)
 ;;=R45.851^^20^165^3
 ;;^UTILITY(U,$J,358.3,2659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2659,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,2659,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,2659,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,2660,0)
 ;;=T14.91XA^^20^165^4
 ;;^UTILITY(U,$J,358.3,2660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2660,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,2660,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,2660,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,2661,0)
 ;;=T14.91XD^^20^165^6
 ;;^UTILITY(U,$J,358.3,2661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2661,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,2661,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,2661,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,2662,0)
 ;;=T14.91XS^^20^165^5
 ;;^UTILITY(U,$J,358.3,2662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2662,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,2662,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,2662,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,2663,0)
 ;;=Z91.52^^20^165^1
 ;;^UTILITY(U,$J,358.3,2663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2663,1,3,0)
 ;;=3^Personal Hx of Non-Suicidal Self-Harm
 ;;^UTILITY(U,$J,358.3,2663,1,4,0)
 ;;=4^Z91.52
 ;;^UTILITY(U,$J,358.3,2663,2)
 ;;=^5161318
 ;;^UTILITY(U,$J,358.3,2664,0)
 ;;=Z91.51^^20^165^2
 ;;^UTILITY(U,$J,358.3,2664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2664,1,3,0)
 ;;=3^Personal Hx of Suicidal Behavior
 ;;^UTILITY(U,$J,358.3,2664,1,4,0)
 ;;=4^Z91.51
 ;;^UTILITY(U,$J,358.3,2664,2)
 ;;=^5161317
 ;;^UTILITY(U,$J,358.3,2665,0)
 ;;=R00.2^^20^166^4
 ;;^UTILITY(U,$J,358.3,2665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2665,1,3,0)
 ;;=3^Palpitations
 ;;^UTILITY(U,$J,358.3,2665,1,4,0)
 ;;=4^R00.2
 ;;^UTILITY(U,$J,358.3,2665,2)
 ;;=^5019165
 ;;^UTILITY(U,$J,358.3,2666,0)
 ;;=I49.1^^20^166^1
