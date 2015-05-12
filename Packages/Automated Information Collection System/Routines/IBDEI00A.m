IBDEI00A ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36,1,4,0)
 ;;=4^I72.4
 ;;^UTILITY(U,$J,358.3,36,2)
 ;;=^269777
 ;;^UTILITY(U,$J,358.3,37,0)
 ;;=I72.0^^1^1^4
 ;;^UTILITY(U,$J,358.3,37,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37,1,3,0)
 ;;=3^Aneurysm of Carotid Artery
 ;;^UTILITY(U,$J,358.3,37,1,4,0)
 ;;=4^I72.0
 ;;^UTILITY(U,$J,358.3,37,2)
 ;;=^5007793
 ;;^UTILITY(U,$J,358.3,38,0)
 ;;=I72.3^^1^1^5
 ;;^UTILITY(U,$J,358.3,38,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38,1,3,0)
 ;;=3^Aneurysm of Iliac Artery
 ;;^UTILITY(U,$J,358.3,38,1,4,0)
 ;;=4^I72.3
 ;;^UTILITY(U,$J,358.3,38,2)
 ;;=^269775
 ;;^UTILITY(U,$J,358.3,39,0)
 ;;=I72.8^^1^1^3
 ;;^UTILITY(U,$J,358.3,39,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39,1,3,0)
 ;;=3^Aneurysm of Arteries NEC
 ;;^UTILITY(U,$J,358.3,39,1,4,0)
 ;;=4^I72.8
 ;;^UTILITY(U,$J,358.3,39,2)
 ;;=^5007794
 ;;^UTILITY(U,$J,358.3,40,0)
 ;;=I72.2^^1^1^7
 ;;^UTILITY(U,$J,358.3,40,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40,1,3,0)
 ;;=3^Aneurysm of Renal Artery
 ;;^UTILITY(U,$J,358.3,40,1,4,0)
 ;;=4^I72.2
 ;;^UTILITY(U,$J,358.3,40,2)
 ;;=^269773
 ;;^UTILITY(U,$J,358.3,41,0)
 ;;=I72.9^^1^1^8
 ;;^UTILITY(U,$J,358.3,41,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41,1,3,0)
 ;;=3^Aneurysm of Unspec Site
 ;;^UTILITY(U,$J,358.3,41,1,4,0)
 ;;=4^I72.9
 ;;^UTILITY(U,$J,358.3,41,2)
 ;;=^5007795
 ;;^UTILITY(U,$J,358.3,42,0)
 ;;=I71.9^^1^1^9
 ;;^UTILITY(U,$J,358.3,42,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42,1,3,0)
 ;;=3^Aortic Aneurysm w/o Rupture,Unspec Site
 ;;^UTILITY(U,$J,358.3,42,1,4,0)
 ;;=4^I71.9
 ;;^UTILITY(U,$J,358.3,42,2)
 ;;=^5007792
 ;;^UTILITY(U,$J,358.3,43,0)
 ;;=I83.93^^1^1^10
 ;;^UTILITY(U,$J,358.3,43,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43,1,3,0)
 ;;=3^Asymptomatic Varicose Veins of Bilateral Lower Extremities
 ;;^UTILITY(U,$J,358.3,43,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,43,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,44,0)
 ;;=I83.92^^1^1^11
 ;;^UTILITY(U,$J,358.3,44,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44,1,3,0)
 ;;=3^Asymptomatic Varicose Veins of Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,44,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,44,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,45,0)
 ;;=I83.91^^1^1^12
 ;;^UTILITY(U,$J,358.3,45,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45,1,3,0)
 ;;=3^Asymptomatic Varicose Veins of Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,45,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,45,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,46,0)
 ;;=I70.263^^1^1^14
 ;;^UTILITY(U,$J,358.3,46,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Gangrene
 ;;^UTILITY(U,$J,358.3,46,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,46,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,47,0)
 ;;=I70.262^^1^1^20
 ;;^UTILITY(U,$J,358.3,47,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,47,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,47,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,48,0)
 ;;=I70.261^^1^1^27
 ;;^UTILITY(U,$J,358.3,48,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,48,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,48,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,49,0)
 ;;=I70.213^^1^1^13
 ;;^UTILITY(U,$J,358.3,49,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,49,1,3,0)
 ;;=3^Athscl Native Arteries of Bilater Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,49,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,49,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,50,0)
 ;;=I70.212^^1^1^22
 ;;^UTILITY(U,$J,358.3,50,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,50,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,50,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,51,0)
 ;;=I70.211^^1^1^28
 ;;^UTILITY(U,$J,358.3,51,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,51,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,51,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,52,0)
 ;;=I70.223^^1^1^15
 ;;^UTILITY(U,$J,358.3,52,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,52,1,4,0)
 ;;=4^I70.223
 ;;^UTILITY(U,$J,358.3,52,2)
 ;;=^5007585
 ;;^UTILITY(U,$J,358.3,53,0)
 ;;=I70.222^^1^1^24
 ;;^UTILITY(U,$J,358.3,53,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,53,1,4,0)
 ;;=4^I70.222
 ;;^UTILITY(U,$J,358.3,53,2)
 ;;=^5007584
 ;;^UTILITY(U,$J,358.3,54,0)
 ;;=I70.221^^1^1^29
 ;;^UTILITY(U,$J,358.3,54,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,54,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,54,1,4,0)
 ;;=4^I70.221
 ;;^UTILITY(U,$J,358.3,54,2)
 ;;=^5007583
 ;;^UTILITY(U,$J,358.3,55,0)
 ;;=I70.243^^1^1^17
 ;;^UTILITY(U,$J,358.3,55,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,55,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,55,1,4,0)
 ;;=4^I70.243
 ;;^UTILITY(U,$J,358.3,55,2)
 ;;=^5007597
 ;;^UTILITY(U,$J,358.3,56,0)
 ;;=I70.242^^1^1^18
 ;;^UTILITY(U,$J,358.3,56,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,56,1,4,0)
 ;;=4^I70.242
 ;;^UTILITY(U,$J,358.3,56,2)
 ;;=^5007596
 ;;^UTILITY(U,$J,358.3,57,0)
 ;;=I70.245^^1^1^19
 ;;^UTILITY(U,$J,358.3,57,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,57,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,57,1,4,0)
 ;;=4^I70.245
 ;;^UTILITY(U,$J,358.3,57,2)
 ;;=^5007599
 ;;^UTILITY(U,$J,358.3,58,0)
 ;;=I70.248^^1^1^23
 ;;^UTILITY(U,$J,358.3,58,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Lower Leg Ulcer
 ;;^UTILITY(U,$J,358.3,58,1,4,0)
 ;;=4^I70.248
 ;;^UTILITY(U,$J,358.3,58,2)
 ;;=^5007600
 ;;^UTILITY(U,$J,358.3,59,0)
 ;;=I70.241^^1^1^25
 ;;^UTILITY(U,$J,358.3,59,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,59,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,59,1,4,0)
 ;;=4^I70.241
 ;;^UTILITY(U,$J,358.3,59,2)
 ;;=^5007595
 ;;^UTILITY(U,$J,358.3,60,0)
 ;;=I70.249^^1^1^26
 ;;^UTILITY(U,$J,358.3,60,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,60,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Ulcer,Unspec Site
 ;;^UTILITY(U,$J,358.3,60,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,60,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,61,0)
 ;;=I70.244^^1^1^21
 ;;^UTILITY(U,$J,358.3,61,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,61,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,61,1,4,0)
 ;;=4^I70.244
 ;;^UTILITY(U,$J,358.3,61,2)
 ;;=^5007598
 ;;^UTILITY(U,$J,358.3,62,0)
 ;;=I70.25^^1^1^16
 ;;^UTILITY(U,$J,358.3,62,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,62,1,3,0)
 ;;=3^Athscl Native Arteries of Extremities w/ Ulceration
 ;;^UTILITY(U,$J,358.3,62,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,62,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,63,0)
 ;;=I70.233^^1^1^30
 ;;^UTILITY(U,$J,358.3,63,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,63,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,63,1,4,0)
 ;;=4^I70.233
 ;;^UTILITY(U,$J,358.3,63,2)
 ;;=^5007590
 ;;^UTILITY(U,$J,358.3,64,0)
 ;;=I70.232^^1^1^31
 ;;^UTILITY(U,$J,358.3,64,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,64,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,64,1,4,0)
 ;;=4^I70.232
 ;;^UTILITY(U,$J,358.3,64,2)
 ;;=^5007589
 ;;^UTILITY(U,$J,358.3,65,0)
 ;;=I70.235^^1^1^32
 ;;^UTILITY(U,$J,358.3,65,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,65,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,65,1,4,0)
 ;;=4^I70.235
 ;;^UTILITY(U,$J,358.3,65,2)
 ;;=^5007592
 ;;^UTILITY(U,$J,358.3,66,0)
 ;;=I70.238^^1^1^33
 ;;^UTILITY(U,$J,358.3,66,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,66,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Lower Leg Ulcer
 ;;^UTILITY(U,$J,358.3,66,1,4,0)
 ;;=4^I70.238
 ;;^UTILITY(U,$J,358.3,66,2)
 ;;=^5007593
 ;;^UTILITY(U,$J,358.3,67,0)
 ;;=I70.231^^1^1^34
 ;;^UTILITY(U,$J,358.3,67,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,67,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,67,1,4,0)
 ;;=4^I70.231
 ;;^UTILITY(U,$J,358.3,67,2)
 ;;=^5007588
 ;;^UTILITY(U,$J,358.3,68,0)
 ;;=I70.239^^1^1^35
 ;;^UTILITY(U,$J,358.3,68,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,68,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ulcer,Unspec Site
 ;;^UTILITY(U,$J,358.3,68,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,68,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,69,0)
 ;;=I70.234^^1^1^36
 ;;^UTILITY(U,$J,358.3,69,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,69,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,69,1,4,0)
 ;;=4^I70.234
 ;;^UTILITY(U,$J,358.3,69,2)
 ;;=^5007591
 ;;^UTILITY(U,$J,358.3,70,0)
 ;;=G56.42^^1^1^37
 ;;^UTILITY(U,$J,358.3,70,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,70,1,3,0)
 ;;=3^Causalgia of Left Upper Limb
 ;;^UTILITY(U,$J,358.3,70,1,4,0)
 ;;=4^G56.42
 ;;^UTILITY(U,$J,358.3,70,2)
 ;;=^5004031
 ;;^UTILITY(U,$J,358.3,71,0)
 ;;=G56.41^^1^1^38
 ;;^UTILITY(U,$J,358.3,71,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,71,1,3,0)
 ;;=3^Causalgia of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,71,1,4,0)
 ;;=4^G56.41
 ;;^UTILITY(U,$J,358.3,71,2)
 ;;=^5004030
 ;;^UTILITY(U,$J,358.3,72,0)
 ;;=L03.112^^1^1^39
 ;;^UTILITY(U,$J,358.3,72,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,72,1,3,0)
 ;;=3^Cellulitis of Left Axilla
 ;;^UTILITY(U,$J,358.3,72,1,4,0)
 ;;=4^L03.112
 ;;^UTILITY(U,$J,358.3,72,2)
 ;;=^5009032
