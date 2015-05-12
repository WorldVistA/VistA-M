IBDEI0GT ; ; 19-NOV-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22710,1,3,0)
 ;;=3^707.15
 ;;^UTILITY(U,$J,358.3,22710,1,5,0)
 ;;=5^Ulcer of Toe, non-diabetic
 ;;^UTILITY(U,$J,358.3,22710,2)
 ;;=^322148
 ;;^UTILITY(U,$J,358.3,22711,0)
 ;;=250.80^^123^1372^7
 ;;^UTILITY(U,$J,358.3,22711,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22711,1,3,0)
 ;;=3^250.80
 ;;^UTILITY(U,$J,358.3,22711,1,5,0)
 ;;=5^Diabetic Foot Ulcer, Type II
 ;;^UTILITY(U,$J,358.3,22711,2)
 ;;=^267846^707.15
 ;;^UTILITY(U,$J,358.3,22712,0)
 ;;=250.81^^123^1372^8
 ;;^UTILITY(U,$J,358.3,22712,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22712,1,3,0)
 ;;=3^250.81
 ;;^UTILITY(U,$J,358.3,22712,1,5,0)
 ;;=5^Diabetic Foot Ulcer, Type I
 ;;^UTILITY(U,$J,358.3,22712,2)
 ;;=^331812
 ;;^UTILITY(U,$J,358.3,22713,0)
 ;;=443.9^^123^1373^1
 ;;^UTILITY(U,$J,358.3,22713,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22713,1,3,0)
 ;;=3^443.9
 ;;^UTILITY(U,$J,358.3,22713,1,5,0)
 ;;=5^Vascular Disease, Peripheral
 ;;^UTILITY(U,$J,358.3,22713,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,22714,0)
 ;;=459.81^^123^1373^2
 ;;^UTILITY(U,$J,358.3,22714,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22714,1,3,0)
 ;;=3^459.81
 ;;^UTILITY(U,$J,358.3,22714,1,5,0)
 ;;=5^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,22714,2)
 ;;=^125826
 ;;^UTILITY(U,$J,358.3,22715,0)
 ;;=078.10^^123^1373^3
 ;;^UTILITY(U,$J,358.3,22715,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22715,1,3,0)
 ;;=3^078.10
 ;;^UTILITY(U,$J,358.3,22715,1,5,0)
 ;;=5^Verruca
 ;;^UTILITY(U,$J,358.3,22715,2)
 ;;=^295787
 ;;^UTILITY(U,$J,358.3,22716,0)
 ;;=706.8^^123^1374^1
 ;;^UTILITY(U,$J,358.3,22716,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22716,1,3,0)
 ;;=3^706.8
 ;;^UTILITY(U,$J,358.3,22716,1,5,0)
 ;;=5^Xerosis
 ;;^UTILITY(U,$J,358.3,22716,2)
 ;;=^271931
 ;;^UTILITY(U,$J,358.3,22717,0)
 ;;=V87.39^^123^1375^1
 ;;^UTILITY(U,$J,358.3,22717,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22717,1,3,0)
 ;;=3^V87.39
 ;;^UTILITY(U,$J,358.3,22717,1,5,0)
 ;;=5^Cont/Exp Hazard Sub NEC
 ;;^UTILITY(U,$J,358.3,22717,2)
 ;;=^336815
 ;;^UTILITY(U,$J,358.3,22718,0)
 ;;=V60.0^^123^1375^2
 ;;^UTILITY(U,$J,358.3,22718,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22718,1,3,0)
 ;;=3^V60.0
 ;;^UTILITY(U,$J,358.3,22718,1,5,0)
 ;;=5^Homelessness
 ;;^UTILITY(U,$J,358.3,22718,2)
 ;;=^295539
 ;;^UTILITY(U,$J,358.3,22719,0)
 ;;=10060^^124^1376^1
 ;;^UTILITY(U,$J,358.3,22719,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22719,1,2,0)
 ;;=2^Incision and Drainage of abscess, simple or single
 ;;^UTILITY(U,$J,358.3,22719,1,3,0)
 ;;=3^10060
 ;;^UTILITY(U,$J,358.3,22720,0)
 ;;=10061^^124^1376^2
 ;;^UTILITY(U,$J,358.3,22720,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22720,1,2,0)
 ;;=2^Incision and Drainage of abscess; complicated or multiple
 ;;^UTILITY(U,$J,358.3,22720,1,3,0)
 ;;=3^10061
 ;;^UTILITY(U,$J,358.3,22721,0)
 ;;=10120^^124^1376^3
 ;;^UTILITY(U,$J,358.3,22721,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22721,1,2,0)
 ;;=2^Incision & Removal FB,Subq Tissue;Simple
 ;;^UTILITY(U,$J,358.3,22721,1,3,0)
 ;;=3^10120
 ;;^UTILITY(U,$J,358.3,22722,0)
 ;;=10121^^124^1376^4
 ;;^UTILITY(U,$J,358.3,22722,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22722,1,2,0)
 ;;=2^Incision & Removal FB,Subq Tissue;Complicated
 ;;^UTILITY(U,$J,358.3,22722,1,3,0)
 ;;=3^10121
 ;;^UTILITY(U,$J,358.3,22723,0)
 ;;=10140^^124^1376^5
 ;;^UTILITY(U,$J,358.3,22723,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22723,1,2,0)
 ;;=2^Incision and Drainage of hematoma, seroma or fluid collection
 ;;^UTILITY(U,$J,358.3,22723,1,3,0)
 ;;=3^10140
 ;;^UTILITY(U,$J,358.3,22724,0)
 ;;=10160^^124^1376^6
 ;;^UTILITY(U,$J,358.3,22724,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22724,1,2,0)
 ;;=2^Puncture aspiration of abscess, hemtoma, bulla, or cyst
 ;;^UTILITY(U,$J,358.3,22724,1,3,0)
 ;;=3^10160
 ;;^UTILITY(U,$J,358.3,22725,0)
 ;;=10180^^124^1376^7
 ;;^UTILITY(U,$J,358.3,22725,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22725,1,2,0)
 ;;=2^Incision and Drainage, complex, postoperative wound infection
 ;;^UTILITY(U,$J,358.3,22725,1,3,0)
 ;;=3^10180
 ;;^UTILITY(U,$J,358.3,22726,0)
 ;;=11000^^124^1377^1
 ;;^UTILITY(U,$J,358.3,22726,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22726,1,2,0)
 ;;=2^Debr of extensive eczematous 10%
 ;;^UTILITY(U,$J,358.3,22726,1,3,0)
 ;;=3^11000
 ;;^UTILITY(U,$J,358.3,22727,0)
 ;;=11010^^124^1377^3
 ;;^UTILITY(U,$J,358.3,22727,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22727,1,2,0)
 ;;=2^Debridement including removal of foreign material associated w/open fracture(s) &/or dislocation(s); skin and subcutaneous tissues
 ;;^UTILITY(U,$J,358.3,22727,1,3,0)
 ;;=3^11010
 ;;^UTILITY(U,$J,358.3,22728,0)
 ;;=11011^^124^1377^4
 ;;^UTILITY(U,$J,358.3,22728,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22728,1,2,0)
 ;;=2^Debridement including removal of foreign material associated w/ open FX(s) and/or dislocation(s);skin, subcutaneous tissue, muscle fascia, & muscle
 ;;^UTILITY(U,$J,358.3,22728,1,3,0)
 ;;=3^11011
 ;;^UTILITY(U,$J,358.3,22729,0)
 ;;=11042^^124^1377^8
 ;;^UTILITY(U,$J,358.3,22729,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22729,1,2,0)
 ;;=2^Debridement; Skin & Subcutaneous Tissue
 ;;^UTILITY(U,$J,358.3,22729,1,3,0)
 ;;=3^11042
 ;;^UTILITY(U,$J,358.3,22730,0)
 ;;=11043^^124^1377^9
 ;;^UTILITY(U,$J,358.3,22730,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22730,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue & Muscle 
 ;;^UTILITY(U,$J,358.3,22730,1,3,0)
 ;;=3^11043
 ;;^UTILITY(U,$J,358.3,22731,0)
 ;;=11044^^124^1377^10
 ;;^UTILITY(U,$J,358.3,22731,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22731,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue, Muscle & Bone
 ;;^UTILITY(U,$J,358.3,22731,1,3,0)
 ;;=3^11044
 ;;^UTILITY(U,$J,358.3,22732,0)
 ;;=11012^^124^1377^5^^^^1
 ;;^UTILITY(U,$J,358.3,22732,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22732,1,2,0)
 ;;=2^Debridement incl. removal of foreign material associate w/ openFx(s) &/or dislocation(s); skin, subcutaneous tissue, muscle fascia, muscle & bone
 ;;^UTILITY(U,$J,358.3,22732,1,3,0)
 ;;=3^11012
 ;;^UTILITY(U,$J,358.3,22733,0)
 ;;=11001^^124^1377^2^^^^1
 ;;^UTILITY(U,$J,358.3,22733,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22733,1,2,0)
 ;;=2^Debr of extensive eczematous;ea addl 10%
 ;;^UTILITY(U,$J,358.3,22733,1,3,0)
 ;;=3^11001
 ;;^UTILITY(U,$J,358.3,22734,0)
 ;;=11300^^124^1378^1
 ;;^UTILITY(U,$J,358.3,22734,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22734,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesions, Single; trunk, arms, legs- 0.5 cm or less
 ;;^UTILITY(U,$J,358.3,22734,1,3,0)
 ;;=3^11300
 ;;^UTILITY(U,$J,358.3,22735,0)
 ;;=11301^^124^1378^2
 ;;^UTILITY(U,$J,358.3,22735,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22735,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; trunk, arms or legs- 0.6 to 1.0 cm
 ;;^UTILITY(U,$J,358.3,22735,1,3,0)
 ;;=3^11301
 ;;^UTILITY(U,$J,358.3,22736,0)
 ;;=11302^^124^1378^3
 ;;^UTILITY(U,$J,358.3,22736,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22736,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single- trunk, arms or legs 1.1 to 2.0 cm
 ;;^UTILITY(U,$J,358.3,22736,1,3,0)
 ;;=3^11302
 ;;^UTILITY(U,$J,358.3,22737,0)
 ;;=11305^^124^1378^5
 ;;^UTILITY(U,$J,358.3,22737,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22737,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion Single; scalp, neck, hands, feet, genitalia- 0.5 cm or less
 ;;^UTILITY(U,$J,358.3,22737,1,3,0)
 ;;=3^11305
 ;;^UTILITY(U,$J,358.3,22738,0)
 ;;=11306^^124^1378^6
 ;;^UTILITY(U,$J,358.3,22738,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22738,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- 0.6 to 1.0 cm 
 ;;^UTILITY(U,$J,358.3,22738,1,3,0)
 ;;=3^11306
 ;;^UTILITY(U,$J,358.3,22739,0)
 ;;=11307^^124^1378^7
 ;;^UTILITY(U,$J,358.3,22739,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22739,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- 1.1 to 2.0 cm
 ;;^UTILITY(U,$J,358.3,22739,1,3,0)
 ;;=3^11307
 ;;^UTILITY(U,$J,358.3,22740,0)
 ;;=11308^^124^1378^8
 ;;^UTILITY(U,$J,358.3,22740,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22740,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- over 2.0 cm
 ;;^UTILITY(U,$J,358.3,22740,1,3,0)
 ;;=3^11308
 ;;^UTILITY(U,$J,358.3,22741,0)
 ;;=11303^^124^1378^4^^^^1
 ;;^UTILITY(U,$J,358.3,22741,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22741,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; trunk, arms or legs- over 2.0 cm
 ;;^UTILITY(U,$J,358.3,22741,1,3,0)
 ;;=3^11303
 ;;^UTILITY(U,$J,358.3,22742,0)
 ;;=11719^^124^1379^1^^^^1
 ;;^UTILITY(U,$J,358.3,22742,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22742,1,2,0)
 ;;=2^Trimming Nondystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,22742,1,3,0)
 ;;=3^11719
 ;;^UTILITY(U,$J,358.3,22743,0)
 ;;=G0127^^124^1379^2^^^^1
 ;;^UTILITY(U,$J,358.3,22743,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22743,1,2,0)
 ;;=2^Trimming Dystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,22743,1,3,0)
 ;;=3^G0127
 ;;^UTILITY(U,$J,358.3,22744,0)
 ;;=11720^^124^1379^3^^^^1
 ;;^UTILITY(U,$J,358.3,22744,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22744,1,2,0)
 ;;=2^Debridement of Nail(s)any method(s); 1-5 
 ;;^UTILITY(U,$J,358.3,22744,1,3,0)
 ;;=3^11720
 ;;^UTILITY(U,$J,358.3,22745,0)
 ;;=11721^^124^1379^4^^^^1
 ;;^UTILITY(U,$J,358.3,22745,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22745,1,2,0)
 ;;=2^Debridement of Nails any method; 6 or more
 ;;^UTILITY(U,$J,358.3,22745,1,3,0)
 ;;=3^11721
 ;;^UTILITY(U,$J,358.3,22746,0)
 ;;=11730^^124^1379^5^^^^1
 ;;^UTILITY(U,$J,358.3,22746,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22746,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,single
 ;;^UTILITY(U,$J,358.3,22746,1,3,0)
 ;;=3^11730
 ;;^UTILITY(U,$J,358.3,22747,0)
 ;;=11732^^124^1379^6^^^^1
