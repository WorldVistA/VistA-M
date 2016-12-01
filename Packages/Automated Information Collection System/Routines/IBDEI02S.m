IBDEI02S ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3194,0)
 ;;=19086^^19^225^2^^^^1
 ;;^UTILITY(U,$J,358.3,3194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3194,1,2,0)
 ;;=2^Bx,Breast w/Device w/MRI,Ea Addl Lesion
 ;;^UTILITY(U,$J,358.3,3194,1,4,0)
 ;;=4^19086
 ;;^UTILITY(U,$J,358.3,3195,0)
 ;;=97602^^19^225^11^^^^1
 ;;^UTILITY(U,$J,358.3,3195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3195,1,2,0)
 ;;=2^Deb Non-Selective w/ Collagenase
 ;;^UTILITY(U,$J,358.3,3195,1,4,0)
 ;;=4^97602
 ;;^UTILITY(U,$J,358.3,3196,0)
 ;;=10060^^19^226^17
 ;;^UTILITY(U,$J,358.3,3196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3196,1,2,0)
 ;;=2^I&D abscess,simple or single
 ;;^UTILITY(U,$J,358.3,3196,1,4,0)
 ;;=4^10060
 ;;^UTILITY(U,$J,358.3,3197,0)
 ;;=10061^^19^226^16
 ;;^UTILITY(U,$J,358.3,3197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3197,1,2,0)
 ;;=2^I&D abscess,complic or multip
 ;;^UTILITY(U,$J,358.3,3197,1,4,0)
 ;;=4^10061
 ;;^UTILITY(U,$J,358.3,3198,0)
 ;;=10160^^19^226^22
 ;;^UTILITY(U,$J,358.3,3198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3198,1,2,0)
 ;;=2^Needle asp absc/cyst/hematoma
 ;;^UTILITY(U,$J,358.3,3198,1,4,0)
 ;;=4^10160
 ;;^UTILITY(U,$J,358.3,3199,0)
 ;;=10140^^19^226^19
 ;;^UTILITY(U,$J,358.3,3199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3199,1,2,0)
 ;;=2^I&D hematoma/seroma,skin
 ;;^UTILITY(U,$J,358.3,3199,1,4,0)
 ;;=4^10140
 ;;^UTILITY(U,$J,358.3,3200,0)
 ;;=19000^^19^226^7
 ;;^UTILITY(U,$J,358.3,3200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3200,1,2,0)
 ;;=2^Aspirate breast cyst, first
 ;;^UTILITY(U,$J,358.3,3200,1,4,0)
 ;;=4^19000
 ;;^UTILITY(U,$J,358.3,3201,0)
 ;;=19001^^19^226^8
 ;;^UTILITY(U,$J,358.3,3201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3201,1,2,0)
 ;;=2^Aspirate each addit breast cyst
 ;;^UTILITY(U,$J,358.3,3201,1,4,0)
 ;;=4^19001
 ;;^UTILITY(U,$J,358.3,3202,0)
 ;;=26011^^19^226^9
 ;;^UTILITY(U,$J,358.3,3202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3202,1,2,0)
 ;;=2^Drain abscess finger,complic
 ;;^UTILITY(U,$J,358.3,3202,1,4,0)
 ;;=4^26011
 ;;^UTILITY(U,$J,358.3,3203,0)
 ;;=26020^^19^226^13
 ;;^UTILITY(U,$J,358.3,3203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3203,1,2,0)
 ;;=2^Drain tendon sheath,Ea Hand
 ;;^UTILITY(U,$J,358.3,3203,1,4,0)
 ;;=4^26020
 ;;^UTILITY(U,$J,358.3,3204,0)
 ;;=10120^^19^226^24
 ;;^UTILITY(U,$J,358.3,3204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3204,1,2,0)
 ;;=2^Removal,foreign body,simple
 ;;^UTILITY(U,$J,358.3,3204,1,4,0)
 ;;=4^10120
 ;;^UTILITY(U,$J,358.3,3205,0)
 ;;=10121^^19^226^23
 ;;^UTILITY(U,$J,358.3,3205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3205,1,2,0)
 ;;=2^Removal,foreign body,complex
 ;;^UTILITY(U,$J,358.3,3205,1,4,0)
 ;;=4^10121
 ;;^UTILITY(U,$J,358.3,3206,0)
 ;;=26010^^19^226^10^^^^1
 ;;^UTILITY(U,$J,358.3,3206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3206,1,2,0)
 ;;=2^Drain abscess finger,simple
 ;;^UTILITY(U,$J,358.3,3206,1,4,0)
 ;;=4^26010
 ;;^UTILITY(U,$J,358.3,3207,0)
 ;;=10180^^19^226^18^^^^1
 ;;^UTILITY(U,$J,358.3,3207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3207,1,2,0)
 ;;=2^I&D complex postop wound
 ;;^UTILITY(U,$J,358.3,3207,1,4,0)
 ;;=4^10180
 ;;^UTILITY(U,$J,358.3,3208,0)
 ;;=20600^^19^226^6^^^^1
 ;;^UTILITY(U,$J,358.3,3208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3208,1,2,0)
 ;;=2^Aspir/inject bursa/small joint w/o US
 ;;^UTILITY(U,$J,358.3,3208,1,4,0)
 ;;=4^20600
 ;;^UTILITY(U,$J,358.3,3209,0)
 ;;=20605^^19^226^2^^^^1
 ;;^UTILITY(U,$J,358.3,3209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3209,1,2,0)
 ;;=2^Aspir/inject bursa/intmed joint w/o US
 ;;^UTILITY(U,$J,358.3,3209,1,4,0)
 ;;=4^20605
 ;;^UTILITY(U,$J,358.3,3210,0)
 ;;=20610^^19^226^4^^^^1
 ;;^UTILITY(U,$J,358.3,3210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3210,1,2,0)
 ;;=2^Aspir/inject bursa/large joint w/o US
 ;;^UTILITY(U,$J,358.3,3210,1,4,0)
 ;;=4^20610
 ;;^UTILITY(U,$J,358.3,3211,0)
 ;;=10080^^19^226^11^^^^1
 ;;^UTILITY(U,$J,358.3,3211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3211,1,2,0)
 ;;=2^Drain pilonidal cyst, simple
 ;;^UTILITY(U,$J,358.3,3211,1,4,0)
 ;;=4^10080
 ;;^UTILITY(U,$J,358.3,3212,0)
 ;;=10081^^19^226^12^^^^1
 ;;^UTILITY(U,$J,358.3,3212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3212,1,2,0)
 ;;=2^Drain pilonidal cyst,complex
 ;;^UTILITY(U,$J,358.3,3212,1,4,0)
 ;;=4^10081
 ;;^UTILITY(U,$J,358.3,3213,0)
 ;;=10021^^19^226^15^^^^1
 ;;^UTILITY(U,$J,358.3,3213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3213,1,2,0)
 ;;=2^FNA w/o Image Guidance
 ;;^UTILITY(U,$J,358.3,3213,1,4,0)
 ;;=4^10021
 ;;^UTILITY(U,$J,358.3,3214,0)
 ;;=10022^^19^226^14^^^^1
 ;;^UTILITY(U,$J,358.3,3214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3214,1,2,0)
 ;;=2^FNA w/ Image Guidance
 ;;^UTILITY(U,$J,358.3,3214,1,4,0)
 ;;=4^10022
 ;;^UTILITY(U,$J,358.3,3215,0)
 ;;=19020^^19^226^21^^^^1
 ;;^UTILITY(U,$J,358.3,3215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3215,1,2,0)
 ;;=2^Mastotomy w/Explor/Drainage of Abscess Deep
 ;;^UTILITY(U,$J,358.3,3215,1,4,0)
 ;;=4^19020
 ;;^UTILITY(U,$J,358.3,3216,0)
 ;;=10030^^19^226^20^^^^1
 ;;^UTILITY(U,$J,358.3,3216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3216,1,2,0)
 ;;=2^Image Guided Collect Cath Absc/Cyst
 ;;^UTILITY(U,$J,358.3,3216,1,4,0)
 ;;=4^10030
 ;;^UTILITY(U,$J,358.3,3217,0)
 ;;=20606^^19^226^1^^^^1
 ;;^UTILITY(U,$J,358.3,3217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3217,1,2,0)
 ;;=2^Aspir/inject bursa/intmed joint w/ US
 ;;^UTILITY(U,$J,358.3,3217,1,4,0)
 ;;=4^20606
 ;;^UTILITY(U,$J,358.3,3218,0)
 ;;=20610^^19^226^3^^^^1
 ;;^UTILITY(U,$J,358.3,3218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3218,1,2,0)
 ;;=2^Aspir/inject bursa/large joint w/ US
 ;;^UTILITY(U,$J,358.3,3218,1,4,0)
 ;;=4^20610
 ;;^UTILITY(U,$J,358.3,3219,0)
 ;;=20604^^19^226^5^^^^1
 ;;^UTILITY(U,$J,358.3,3219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3219,1,2,0)
 ;;=2^Aspir/inject bursa/small joint w/ US
 ;;^UTILITY(U,$J,358.3,3219,1,4,0)
 ;;=4^20604
 ;;^UTILITY(U,$J,358.3,3220,0)
 ;;=17000^^19^227^4
 ;;^UTILITY(U,$J,358.3,3220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3220,1,2,0)
 ;;=2^Destroy Skin Lesion, first 
 ;;^UTILITY(U,$J,358.3,3220,1,4,0)
 ;;=4^17000
 ;;^UTILITY(U,$J,358.3,3221,0)
 ;;=11200^^19^227^2
 ;;^UTILITY(U,$J,358.3,3221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3221,1,2,0)
 ;;=2^Destroy 1-15 Skin Tags, any method
 ;;^UTILITY(U,$J,358.3,3221,1,4,0)
 ;;=4^11200
 ;;^UTILITY(U,$J,358.3,3222,0)
 ;;=17003^^19^227^6^^^^1
 ;;^UTILITY(U,$J,358.3,3222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3222,1,2,0)
 ;;=2^Each Addl Lesion 2-14 (use with 17000)
 ;;^UTILITY(U,$J,358.3,3222,1,4,0)
 ;;=4^17003
 ;;^UTILITY(U,$J,358.3,3223,0)
 ;;=17004^^19^227^3^^^^1
 ;;^UTILITY(U,$J,358.3,3223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3223,1,2,0)
 ;;=2^Destroy 15+ Skin Lesions
 ;;^UTILITY(U,$J,358.3,3223,1,4,0)
 ;;=4^17004
 ;;^UTILITY(U,$J,358.3,3224,0)
 ;;=11770^^19^227^9^^^^1
 ;;^UTILITY(U,$J,358.3,3224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3224,1,2,0)
 ;;=2^Excise Pilonidal Cyst,Sinus,Simple
 ;;^UTILITY(U,$J,358.3,3224,1,4,0)
 ;;=4^11770
 ;;^UTILITY(U,$J,358.3,3225,0)
 ;;=11771^^19^227^8^^^^1
 ;;^UTILITY(U,$J,358.3,3225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3225,1,2,0)
 ;;=2^Excise Pilonidal Cyst,Sinus,Extensive
 ;;^UTILITY(U,$J,358.3,3225,1,4,0)
 ;;=4^11771
 ;;^UTILITY(U,$J,358.3,3226,0)
 ;;=11772^^19^227^7^^^^1
 ;;^UTILITY(U,$J,358.3,3226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3226,1,2,0)
 ;;=2^Excise Pilonidal Cyst,Sinus,Complicated
 ;;^UTILITY(U,$J,358.3,3226,1,4,0)
 ;;=4^11772
 ;;^UTILITY(U,$J,358.3,3227,0)
 ;;=11201^^19^227^5^^^^1
 ;;^UTILITY(U,$J,358.3,3227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3227,1,2,0)
 ;;=2^Destroy Skin Tags,Ea Addl 10
 ;;^UTILITY(U,$J,358.3,3227,1,4,0)
 ;;=4^11201
 ;;^UTILITY(U,$J,358.3,3228,0)
 ;;=17250^^19^227^1^^^^1
 ;;^UTILITY(U,$J,358.3,3228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3228,1,2,0)
 ;;=2^Chem Cautery w/ Silver Nitrate
 ;;^UTILITY(U,$J,358.3,3228,1,4,0)
 ;;=4^17250
 ;;^UTILITY(U,$J,358.3,3229,0)
 ;;=11055^^19^228^1^^^^1
 ;;^UTILITY(U,$J,358.3,3229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3229,1,2,0)
 ;;=2^Pare/cut corn/callus, single
 ;;^UTILITY(U,$J,358.3,3229,1,4,0)
 ;;=4^11055
 ;;^UTILITY(U,$J,358.3,3230,0)
 ;;=11056^^19^228^2^^^^1
 ;;^UTILITY(U,$J,358.3,3230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3230,1,2,0)
 ;;=2^Pare/cut corn/callus, 2-4
 ;;^UTILITY(U,$J,358.3,3230,1,4,0)
 ;;=4^11056
 ;;^UTILITY(U,$J,358.3,3231,0)
 ;;=11057^^19^228^3^^^^1
 ;;^UTILITY(U,$J,358.3,3231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3231,1,2,0)
 ;;=2^Pare/cut corn/callus, >4
 ;;^UTILITY(U,$J,358.3,3231,1,4,0)
 ;;=4^11057
 ;;^UTILITY(U,$J,358.3,3232,0)
 ;;=11420^^19^229^1^^^^1
 ;;^UTILITY(U,$J,358.3,3232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3232,1,2,0)
 ;;=2^Scalp/Neck/Head 0.5 cm or less Benign Excision
 ;;^UTILITY(U,$J,358.3,3232,1,4,0)
 ;;=4^11420
 ;;^UTILITY(U,$J,358.3,3233,0)
 ;;=11421^^19^229^2^^^^1
 ;;^UTILITY(U,$J,358.3,3233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3233,1,2,0)
 ;;=2^Scalp/Neck/Head 0.6 - 1.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,3233,1,4,0)
 ;;=4^11421
 ;;^UTILITY(U,$J,358.3,3234,0)
 ;;=11422^^19^229^3^^^^1
 ;;^UTILITY(U,$J,358.3,3234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3234,1,2,0)
 ;;=2^Scalp/Neck/Head 1.1 - 2.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,3234,1,4,0)
 ;;=4^11422
 ;;^UTILITY(U,$J,358.3,3235,0)
 ;;=11423^^19^229^4^^^^1
 ;;^UTILITY(U,$J,358.3,3235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3235,1,2,0)
 ;;=2^Scalp/Neck/Head 2.1 - 3.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,3235,1,4,0)
 ;;=4^11423
 ;;^UTILITY(U,$J,358.3,3236,0)
 ;;=11424^^19^229^5^^^^1
 ;;^UTILITY(U,$J,358.3,3236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3236,1,2,0)
 ;;=2^Scalp/Neck/Head 3.1 - 4.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,3236,1,4,0)
 ;;=4^11424
 ;;^UTILITY(U,$J,358.3,3237,0)
 ;;=11426^^19^229^6^^^^1
