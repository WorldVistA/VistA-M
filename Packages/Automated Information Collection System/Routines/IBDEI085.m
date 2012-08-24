IBDEI085 ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10910,1,5,0)
 ;;=5^Compartmental syndrome, nontraumatic
 ;;^UTILITY(U,$J,358.3,10910,2)
 ;;=^336656
 ;;^UTILITY(U,$J,358.3,10911,0)
 ;;=453.89^^86^669^15
 ;;^UTILITY(U,$J,358.3,10911,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10911,1,3,0)
 ;;=3^453.89
 ;;^UTILITY(U,$J,358.3,10911,1,5,0)
 ;;=5^Claudication, venous
 ;;^UTILITY(U,$J,358.3,10911,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,10912,0)
 ;;=735.8^^86^670^2
 ;;^UTILITY(U,$J,358.3,10912,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10912,1,3,0)
 ;;=3^735.8
 ;;^UTILITY(U,$J,358.3,10912,1,5,0)
 ;;=5^Deformity, toe- acquired
 ;;^UTILITY(U,$J,358.3,10912,2)
 ;;=^272714
 ;;^UTILITY(U,$J,358.3,10913,0)
 ;;=736.70^^86^670^3
 ;;^UTILITY(U,$J,358.3,10913,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10913,1,3,0)
 ;;=3^736.70
 ;;^UTILITY(U,$J,358.3,10913,1,5,0)
 ;;=5^Deformity, ankle and foot- acquired
 ;;^UTILITY(U,$J,358.3,10913,2)
 ;;=^123805
 ;;^UTILITY(U,$J,358.3,10914,0)
 ;;=755.66^^86^670^4
 ;;^UTILITY(U,$J,358.3,10914,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10914,1,3,0)
 ;;=3^755.66
 ;;^UTILITY(U,$J,358.3,10914,1,5,0)
 ;;=5^Deformity, toe- congenital
 ;;^UTILITY(U,$J,358.3,10914,2)
 ;;=^273059
 ;;^UTILITY(U,$J,358.3,10915,0)
 ;;=754.70^^86^670^5
 ;;^UTILITY(U,$J,358.3,10915,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10915,1,3,0)
 ;;=3^754.70
 ;;^UTILITY(U,$J,358.3,10915,1,5,0)
 ;;=5^Deformity, foot- congenital
 ;;^UTILITY(U,$J,358.3,10915,2)
 ;;=^25440
 ;;^UTILITY(U,$J,358.3,10916,0)
 ;;=755.69^^86^670^6
 ;;^UTILITY(U,$J,358.3,10916,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10916,1,3,0)
 ;;=3^755.69
 ;;^UTILITY(U,$J,358.3,10916,1,5,0)
 ;;=5^Deformity, ankle- congenital
 ;;^UTILITY(U,$J,358.3,10916,2)
 ;;=^273054
 ;;^UTILITY(U,$J,358.3,10917,0)
 ;;=692.9^^86^670^7
 ;;^UTILITY(U,$J,358.3,10917,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10917,1,3,0)
 ;;=3^692.9
 ;;^UTILITY(U,$J,358.3,10917,1,5,0)
 ;;=5^Dermatitis (contact/eczema/venenata)
 ;;^UTILITY(U,$J,358.3,10917,2)
 ;;=^27800
 ;;^UTILITY(U,$J,358.3,10918,0)
 ;;=459.81^^86^670^8
 ;;^UTILITY(U,$J,358.3,10918,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10918,1,3,0)
 ;;=3^459.81
 ;;^UTILITY(U,$J,358.3,10918,1,5,0)
 ;;=5^Dermatitis, Stasis (w/o varicose veins) 
 ;;^UTILITY(U,$J,358.3,10918,2)
 ;;=^125826
 ;;^UTILITY(U,$J,358.3,10919,0)
 ;;=454.1^^86^670^9
 ;;^UTILITY(U,$J,358.3,10919,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10919,1,3,0)
 ;;=3^454.1
 ;;^UTILITY(U,$J,358.3,10919,1,5,0)
 ;;=5^Dermatitis, Status due to varicose veins 
 ;;^UTILITY(U,$J,358.3,10919,2)
 ;;=^125435
 ;;^UTILITY(U,$J,358.3,10920,0)
 ;;=454.2^^86^670^11
 ;;^UTILITY(U,$J,358.3,10920,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10920,1,3,0)
 ;;=3^454.2
 ;;^UTILITY(U,$J,358.3,10920,1,5,0)
 ;;=5^Dermatitis, Stasis with ulcer/ulcerated
 ;;^UTILITY(U,$J,358.3,10920,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,10921,0)
 ;;=110.4^^86^670^12
 ;;^UTILITY(U,$J,358.3,10921,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10921,1,3,0)
 ;;=3^110.4
 ;;^UTILITY(U,$J,358.3,10921,1,5,0)
 ;;=5^Dermatophytosis of foot
 ;;^UTILITY(U,$J,358.3,10921,2)
 ;;=^33168
 ;;^UTILITY(U,$J,358.3,10922,0)
 ;;=250.00^^86^670^13
 ;;^UTILITY(U,$J,358.3,10922,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10922,1,3,0)
 ;;=3^250.00
 ;;^UTILITY(U,$J,358.3,10922,1,5,0)
 ;;=5^DM II w/o complication 
 ;;^UTILITY(U,$J,358.3,10922,2)
 ;;=^33605
 ;;^UTILITY(U,$J,358.3,10923,0)
 ;;=250.01^^86^670^39
 ;;^UTILITY(U,$J,358.3,10923,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10923,1,3,0)
 ;;=3^250.01
 ;;^UTILITY(U,$J,358.3,10923,1,5,0)
 ;;=5^DM I w/o complication 
 ;;^UTILITY(U,$J,358.3,10923,2)
 ;;=^33586
 ;;^UTILITY(U,$J,358.3,10924,0)
 ;;=838.00^^86^670^65
 ;;^UTILITY(U,$J,358.3,10924,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10924,1,3,0)
 ;;=3^838.00
 ;;^UTILITY(U,$J,358.3,10924,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; foot, unspecified
 ;;^UTILITY(U,$J,358.3,10924,2)
 ;;=^274391
 ;;^UTILITY(U,$J,358.3,10925,0)
 ;;=838.01^^86^670^66
 ;;^UTILITY(U,$J,358.3,10925,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10925,1,3,0)
 ;;=3^838.01
 ;;^UTILITY(U,$J,358.3,10925,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; tarsal(bone), joint unspecified 
 ;;^UTILITY(U,$J,358.3,10925,2)
 ;;=^274394
 ;;^UTILITY(U,$J,358.3,10926,0)
 ;;=838.02^^86^670^67
 ;;^UTILITY(U,$J,358.3,10926,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10926,1,3,0)
 ;;=3^838.02
 ;;^UTILITY(U,$J,358.3,10926,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; midtarsal (joint)
 ;;^UTILITY(U,$J,358.3,10926,2)
 ;;=^274395
 ;;^UTILITY(U,$J,358.3,10927,0)
 ;;=838.03^^86^670^68
 ;;^UTILITY(U,$J,358.3,10927,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10927,1,3,0)
 ;;=3^838.03
 ;;^UTILITY(U,$J,358.3,10927,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; tarsometatarsal (joint)
 ;;^UTILITY(U,$J,358.3,10927,2)
 ;;=^274396
 ;;^UTILITY(U,$J,358.3,10928,0)
 ;;=838.04^^86^670^69
 ;;^UTILITY(U,$J,358.3,10928,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10928,1,3,0)
 ;;=3^838.04
 ;;^UTILITY(U,$J,358.3,10928,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; metatarsal(bone), joint unspecified
 ;;^UTILITY(U,$J,358.3,10928,2)
 ;;=^274397
 ;;^UTILITY(U,$J,358.3,10929,0)
 ;;=838.05^^86^670^70
 ;;^UTILITY(U,$J,358.3,10929,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10929,1,3,0)
 ;;=3^838.05
 ;;^UTILITY(U,$J,358.3,10929,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; metatarsophalangeal(joint)
 ;;^UTILITY(U,$J,358.3,10929,2)
 ;;=^274398
 ;;^UTILITY(U,$J,358.3,10930,0)
 ;;=838.06^^86^670^71
 ;;^UTILITY(U,$J,358.3,10930,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10930,1,3,0)
 ;;=3^838.06
 ;;^UTILITY(U,$J,358.3,10930,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; interphalangeal(joint) foot
 ;;^UTILITY(U,$J,358.3,10930,2)
 ;;=^274399
 ;;^UTILITY(U,$J,358.3,10931,0)
 ;;=838.09^^86^670^72
 ;;^UTILITY(U,$J,358.3,10931,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10931,1,3,0)
 ;;=3^838.09
 ;;^UTILITY(U,$J,358.3,10931,1,5,0)
 ;;=5^Dislocation of foot, closed dislocation; other, toe(s)
 ;;^UTILITY(U,$J,358.3,10931,2)
 ;;=^274400
 ;;^UTILITY(U,$J,358.3,10932,0)
 ;;=12.5^1^86^670^12.5^-DIABETES MELLITUS^1^1
 ;;^UTILITY(U,$J,358.3,10932,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10932,1,3,0)
 ;;=3
 ;;^UTILITY(U,$J,358.3,10932,1,5,0)
 ;;=5
 ;;^UTILITY(U,$J,358.3,10933,0)
 ;;=64.5^1^86^670^64.5^-Dislocation^1^1
 ;;^UTILITY(U,$J,358.3,10933,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10933,1,3,0)
 ;;=3
 ;;^UTILITY(U,$J,358.3,10933,1,5,0)
 ;;=5
 ;;^UTILITY(U,$J,358.3,10934,0)
 ;;=459.10^^86^670^10
 ;;^UTILITY(U,$J,358.3,10934,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10934,1,3,0)
 ;;=3^459.10
 ;;^UTILITY(U,$J,358.3,10934,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,10934,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,10935,0)
 ;;=719.7^^86^670^64
 ;;^UTILITY(U,$J,358.3,10935,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10935,1,3,0)
 ;;=3^719.7
 ;;^UTILITY(U,$J,358.3,10935,1,5,0)
 ;;=5^Difficulty In Walking
 ;;^UTILITY(U,$J,358.3,10935,2)
 ;;=^329945
 ;;^UTILITY(U,$J,358.3,10936,0)
 ;;=453.40^^86^670^1
 ;;^UTILITY(U,$J,358.3,10936,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10936,1,3,0)
 ;;=3^453.40
 ;;^UTILITY(U,$J,358.3,10936,1,5,0)
 ;;=5^Deep vein thrombosis lower extremity
 ;;^UTILITY(U,$J,358.3,10936,2)
 ;;=^338554
 ;;^UTILITY(U,$J,358.3,10937,0)
 ;;=692.9^^86^671^1
 ;;^UTILITY(U,$J,358.3,10937,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10937,1,3,0)
 ;;=3^692.9
 ;;^UTILITY(U,$J,358.3,10937,1,5,0)
 ;;=5^Eczema
 ;;^UTILITY(U,$J,358.3,10937,2)
 ;;=^27800
 ;;^UTILITY(U,$J,358.3,10938,0)
 ;;=691.8^^86^671^2
 ;;^UTILITY(U,$J,358.3,10938,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10938,1,3,0)
 ;;=3^691.8
 ;;^UTILITY(U,$J,358.3,10938,1,5,0)
 ;;=5^Eczema, allergic
 ;;^UTILITY(U,$J,358.3,10938,2)
 ;;=^87342
 ;;^UTILITY(U,$J,358.3,10939,0)
 ;;=782.3^^86^671^3
 ;;^UTILITY(U,$J,358.3,10939,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10939,1,3,0)
 ;;=3^782.3
 ;;^UTILITY(U,$J,358.3,10939,1,5,0)
 ;;=5^Edema (any site)
 ;;^UTILITY(U,$J,358.3,10939,2)
 ;;=^38340
 ;;^UTILITY(U,$J,358.3,10940,0)
 ;;=726.70^^86^671^4
 ;;^UTILITY(U,$J,358.3,10940,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10940,1,3,0)
 ;;=3^726.70
 ;;^UTILITY(U,$J,358.3,10940,1,5,0)
 ;;=5^Enthesopathy of ankle & tarsus, unspecified
 ;;^UTILITY(U,$J,358.3,10940,2)
 ;;=^272548
 ;;^UTILITY(U,$J,358.3,10941,0)
 ;;=736.72^^86^671^5
 ;;^UTILITY(U,$J,358.3,10941,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10941,1,3,0)
 ;;=3^736.72
 ;;^UTILITY(U,$J,358.3,10941,1,5,0)
 ;;=5^Equinus deformity of foot, acquired
 ;;^UTILITY(U,$J,358.3,10941,2)
 ;;=^272744
 ;;^UTILITY(U,$J,358.3,10942,0)
 ;;=726.91^^86^671^6
 ;;^UTILITY(U,$J,358.3,10942,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10942,1,3,0)
 ;;=3^726.91
 ;;^UTILITY(U,$J,358.3,10942,1,5,0)
 ;;=5^Exostosis of unspecified site
 ;;^UTILITY(U,$J,358.3,10942,2)
 ;;=^43688
 ;;^UTILITY(U,$J,358.3,10943,0)
 ;;=728.71^^86^672^1
 ;;^UTILITY(U,$J,358.3,10943,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10943,1,3,0)
 ;;=3^728.71
 ;;^UTILITY(U,$J,358.3,10943,1,5,0)
 ;;=5^Fascite, Plantar
 ;;^UTILITY(U,$J,358.3,10943,2)
 ;;=^272598
 ;;^UTILITY(U,$J,358.3,10944,0)
 ;;=729.1^^86^672^2
 ;;^UTILITY(U,$J,358.3,10944,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10944,1,3,0)
 ;;=3^729.1
 ;;^UTILITY(U,$J,358.3,10944,1,5,0)
 ;;=5^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,10944,2)
 ;;=^80160
 ;;^UTILITY(U,$J,358.3,10945,0)
 ;;=709.8^^86^672^3
 ;;^UTILITY(U,$J,358.3,10945,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10945,1,3,0)
 ;;=3^709.8
 ;;^UTILITY(U,$J,358.3,10945,1,5,0)
 ;;=5^Fissured skin
 ;;^UTILITY(U,$J,358.3,10945,2)
 ;;=^88026
 ;;^UTILITY(U,$J,358.3,10946,0)
 ;;=V53.7^^86^672^4
 ;;^UTILITY(U,$J,358.3,10946,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10946,1,3,0)
 ;;=3^V53.7
