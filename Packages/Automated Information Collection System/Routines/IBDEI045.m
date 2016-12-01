IBDEI045 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4967,1,3,0)
 ;;=3^Sezary Disease,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,4967,1,4,0)
 ;;=4^C84.19
 ;;^UTILITY(U,$J,358.3,4967,2)
 ;;=^5001640
 ;;^UTILITY(U,$J,358.3,4968,0)
 ;;=C84.13^^22^303^26
 ;;^UTILITY(U,$J,358.3,4968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4968,1,3,0)
 ;;=3^Sezary Disease,Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,4968,1,4,0)
 ;;=4^C84.13
 ;;^UTILITY(U,$J,358.3,4968,2)
 ;;=^5001634
 ;;^UTILITY(U,$J,358.3,4969,0)
 ;;=C84.16^^22^303^27
 ;;^UTILITY(U,$J,358.3,4969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4969,1,3,0)
 ;;=3^Sezary Disease,Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,4969,1,4,0)
 ;;=4^C84.16
 ;;^UTILITY(U,$J,358.3,4969,2)
 ;;=^5001637
 ;;^UTILITY(U,$J,358.3,4970,0)
 ;;=C84.12^^22^303^28
 ;;^UTILITY(U,$J,358.3,4970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4970,1,3,0)
 ;;=3^Sezary Disease,Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,4970,1,4,0)
 ;;=4^C84.12
 ;;^UTILITY(U,$J,358.3,4970,2)
 ;;=^5001633
 ;;^UTILITY(U,$J,358.3,4971,0)
 ;;=C84.14^^22^303^22
 ;;^UTILITY(U,$J,358.3,4971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4971,1,3,0)
 ;;=3^Sezary Disease,Axilla/Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,4971,1,4,0)
 ;;=4^C84.14
 ;;^UTILITY(U,$J,358.3,4971,2)
 ;;=^5001635
 ;;^UTILITY(U,$J,358.3,4972,0)
 ;;=C84.11^^22^303^24
 ;;^UTILITY(U,$J,358.3,4972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4972,1,3,0)
 ;;=3^Sezary Disease,Head/Face/Neck Lymph Nodes
 ;;^UTILITY(U,$J,358.3,4972,1,4,0)
 ;;=4^C84.11
 ;;^UTILITY(U,$J,358.3,4972,2)
 ;;=^5001632
 ;;^UTILITY(U,$J,358.3,4973,0)
 ;;=C84.15^^22^303^25
 ;;^UTILITY(U,$J,358.3,4973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4973,1,3,0)
 ;;=3^Sezary Disease,Inguinal Region/LE Lymph Nodes
 ;;^UTILITY(U,$J,358.3,4973,1,4,0)
 ;;=4^C84.15
 ;;^UTILITY(U,$J,358.3,4973,2)
 ;;=^5001636
 ;;^UTILITY(U,$J,358.3,4974,0)
 ;;=C84.18^^22^303^29
 ;;^UTILITY(U,$J,358.3,4974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4974,1,3,0)
 ;;=3^Sezary Disease,Multiple Site Lymph Nodes
 ;;^UTILITY(U,$J,358.3,4974,1,4,0)
 ;;=4^C84.18
 ;;^UTILITY(U,$J,358.3,4974,2)
 ;;=^5001639
 ;;^UTILITY(U,$J,358.3,4975,0)
 ;;=C84.17^^22^303^30
 ;;^UTILITY(U,$J,358.3,4975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4975,1,3,0)
 ;;=3^Sezary Disease,Spleen
 ;;^UTILITY(U,$J,358.3,4975,1,4,0)
 ;;=4^C84.17
 ;;^UTILITY(U,$J,358.3,4975,2)
 ;;=^5001638
 ;;^UTILITY(U,$J,358.3,4976,0)
 ;;=C84.10^^22^303^31
 ;;^UTILITY(U,$J,358.3,4976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4976,1,3,0)
 ;;=3^Sezary Disease,Unspec Site
 ;;^UTILITY(U,$J,358.3,4976,1,4,0)
 ;;=4^C84.10
 ;;^UTILITY(U,$J,358.3,4976,2)
 ;;=^5001631
 ;;^UTILITY(U,$J,358.3,4977,0)
 ;;=A53.9^^22^303^44
 ;;^UTILITY(U,$J,358.3,4977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4977,1,3,0)
 ;;=3^Syphilis,Unspec
 ;;^UTILITY(U,$J,358.3,4977,1,4,0)
 ;;=4^A53.9
 ;;^UTILITY(U,$J,358.3,4977,2)
 ;;=^5000310
 ;;^UTILITY(U,$J,358.3,4978,0)
 ;;=B35.1^^22^304^9
 ;;^UTILITY(U,$J,358.3,4978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4978,1,3,0)
 ;;=3^Tinea Unguium
 ;;^UTILITY(U,$J,358.3,4978,1,4,0)
 ;;=4^B35.1
 ;;^UTILITY(U,$J,358.3,4978,2)
 ;;=^119748
 ;;^UTILITY(U,$J,358.3,4979,0)
 ;;=F63.3^^22^304^12
 ;;^UTILITY(U,$J,358.3,4979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4979,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,4979,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,4979,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,4980,0)
 ;;=B35.2^^22^304^6
 ;;^UTILITY(U,$J,358.3,4980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4980,1,3,0)
 ;;=3^Tinea Manuum
 ;;^UTILITY(U,$J,358.3,4980,1,4,0)
 ;;=4^B35.2
 ;;^UTILITY(U,$J,358.3,4980,2)
 ;;=^5000605
 ;;^UTILITY(U,$J,358.3,4981,0)
 ;;=B35.6^^22^304^5
 ;;^UTILITY(U,$J,358.3,4981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4981,1,3,0)
 ;;=3^Tinea Cruris
 ;;^UTILITY(U,$J,358.3,4981,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,4981,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,4982,0)
 ;;=B35.3^^22^304^8
 ;;^UTILITY(U,$J,358.3,4982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4982,1,3,0)
 ;;=3^Tinea Pedis
 ;;^UTILITY(U,$J,358.3,4982,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,4982,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,4983,0)
 ;;=B35.4^^22^304^4
 ;;^UTILITY(U,$J,358.3,4983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4983,1,3,0)
 ;;=3^Tinea Corporis
 ;;^UTILITY(U,$J,358.3,4983,1,4,0)
 ;;=4^B35.4
 ;;^UTILITY(U,$J,358.3,4983,2)
 ;;=^119704
 ;;^UTILITY(U,$J,358.3,4984,0)
 ;;=L51.2^^22^304^11
 ;;^UTILITY(U,$J,358.3,4984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4984,1,3,0)
 ;;=3^Toxic Epidermal Necrolysis
 ;;^UTILITY(U,$J,358.3,4984,1,4,0)
 ;;=4^L51.2
 ;;^UTILITY(U,$J,358.3,4984,2)
 ;;=^5009206
 ;;^UTILITY(U,$J,358.3,4985,0)
 ;;=B35.0^^22^304^2
 ;;^UTILITY(U,$J,358.3,4985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4985,1,3,0)
 ;;=3^Tinea Barae/Capitis
 ;;^UTILITY(U,$J,358.3,4985,1,4,0)
 ;;=4^B35.0
 ;;^UTILITY(U,$J,358.3,4985,2)
 ;;=^5000604
 ;;^UTILITY(U,$J,358.3,4986,0)
 ;;=B36.3^^22^304^3
 ;;^UTILITY(U,$J,358.3,4986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4986,1,3,0)
 ;;=3^Tinea Blanca
 ;;^UTILITY(U,$J,358.3,4986,1,4,0)
 ;;=4^B36.3
 ;;^UTILITY(U,$J,358.3,4986,2)
 ;;=^266864
 ;;^UTILITY(U,$J,358.3,4987,0)
 ;;=B36.1^^22^304^7
 ;;^UTILITY(U,$J,358.3,4987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4987,1,3,0)
 ;;=3^Tinea Nigra
 ;;^UTILITY(U,$J,358.3,4987,1,4,0)
 ;;=4^B36.1
 ;;^UTILITY(U,$J,358.3,4987,2)
 ;;=^264999
 ;;^UTILITY(U,$J,358.3,4988,0)
 ;;=B36.0^^22^304^10
 ;;^UTILITY(U,$J,358.3,4988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4988,1,3,0)
 ;;=3^Tinea Veriscolor
 ;;^UTILITY(U,$J,358.3,4988,1,4,0)
 ;;=4^B36.0
 ;;^UTILITY(U,$J,358.3,4988,2)
 ;;=^5000608
 ;;^UTILITY(U,$J,358.3,4989,0)
 ;;=L81.8^^22^304^1
 ;;^UTILITY(U,$J,358.3,4989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4989,1,3,0)
 ;;=3^Tattoo Pigmentation
 ;;^UTILITY(U,$J,358.3,4989,1,4,0)
 ;;=4^L81.8
 ;;^UTILITY(U,$J,358.3,4989,2)
 ;;=^5009318
 ;;^UTILITY(U,$J,358.3,4990,0)
 ;;=L80.^^22^305^12
 ;;^UTILITY(U,$J,358.3,4990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4990,1,3,0)
 ;;=3^Vitiligo
 ;;^UTILITY(U,$J,358.3,4990,1,4,0)
 ;;=4^L80.
 ;;^UTILITY(U,$J,358.3,4990,2)
 ;;=^127071
 ;;^UTILITY(U,$J,358.3,4991,0)
 ;;=I83.019^^22^305^7
 ;;^UTILITY(U,$J,358.3,4991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4991,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer Site Unspec
 ;;^UTILITY(U,$J,358.3,4991,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,4991,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,4992,0)
 ;;=I83.029^^22^305^2
 ;;^UTILITY(U,$J,358.3,4992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4992,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer Site Unspec
 ;;^UTILITY(U,$J,358.3,4992,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,4992,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,4993,0)
 ;;=I83.012^^22^305^8
 ;;^UTILITY(U,$J,358.3,4993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4993,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,4993,1,4,0)
 ;;=4^I83.012
 ;;^UTILITY(U,$J,358.3,4993,2)
 ;;=^5007974
 ;;^UTILITY(U,$J,358.3,4994,0)
 ;;=I83.013^^22^305^9
 ;;^UTILITY(U,$J,358.3,4994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4994,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,4994,1,4,0)
 ;;=4^I83.013
 ;;^UTILITY(U,$J,358.3,4994,2)
 ;;=^5007975
 ;;^UTILITY(U,$J,358.3,4995,0)
 ;;=I83.014^^22^305^10
 ;;^UTILITY(U,$J,358.3,4995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4995,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,4995,1,4,0)
 ;;=4^I83.014
 ;;^UTILITY(U,$J,358.3,4995,2)
 ;;=^5007976
 ;;^UTILITY(U,$J,358.3,4996,0)
 ;;=I83.11^^22^305^6
 ;;^UTILITY(U,$J,358.3,4996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4996,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,4996,1,4,0)
 ;;=4^I83.11
 ;;^UTILITY(U,$J,358.3,4996,2)
 ;;=^5007988
 ;;^UTILITY(U,$J,358.3,4997,0)
 ;;=I83.022^^22^305^3
 ;;^UTILITY(U,$J,358.3,4997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4997,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,4997,1,4,0)
 ;;=4^I83.022
 ;;^UTILITY(U,$J,358.3,4997,2)
 ;;=^5007981
 ;;^UTILITY(U,$J,358.3,4998,0)
 ;;=I83.023^^22^305^4
 ;;^UTILITY(U,$J,358.3,4998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4998,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,4998,1,4,0)
 ;;=4^I83.023
 ;;^UTILITY(U,$J,358.3,4998,2)
 ;;=^5007982
 ;;^UTILITY(U,$J,358.3,4999,0)
 ;;=I83.024^^22^305^5
 ;;^UTILITY(U,$J,358.3,4999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4999,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,4999,1,4,0)
 ;;=4^I83.024
 ;;^UTILITY(U,$J,358.3,4999,2)
 ;;=^5007983
 ;;^UTILITY(U,$J,358.3,5000,0)
 ;;=I83.12^^22^305^1
 ;;^UTILITY(U,$J,358.3,5000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5000,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Inflammation
 ;;^UTILITY(U,$J,358.3,5000,1,4,0)
 ;;=4^I83.12
 ;;^UTILITY(U,$J,358.3,5000,2)
 ;;=^5007989
 ;;^UTILITY(U,$J,358.3,5001,0)
 ;;=I87.2^^22^305^11
 ;;^UTILITY(U,$J,358.3,5001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5001,1,3,0)
 ;;=3^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,5001,1,4,0)
 ;;=4^I87.2
 ;;^UTILITY(U,$J,358.3,5001,2)
 ;;=^5008047
 ;;^UTILITY(U,$J,358.3,5002,0)
 ;;=L85.3^^22^306^1
 ;;^UTILITY(U,$J,358.3,5002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5002,1,3,0)
 ;;=3^Xerosis Cutis
 ;;^UTILITY(U,$J,358.3,5002,1,4,0)
 ;;=4^L85.3
 ;;^UTILITY(U,$J,358.3,5002,2)
 ;;=^5009323
 ;;^UTILITY(U,$J,358.3,5003,0)
 ;;=L03.113^^22^307^32
 ;;^UTILITY(U,$J,358.3,5003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5003,1,3,0)
 ;;=3^Cellulitis of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,5003,1,4,0)
 ;;=4^L03.113
