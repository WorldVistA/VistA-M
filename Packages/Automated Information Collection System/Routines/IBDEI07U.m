IBDEI07U ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10501,1,3,0)
 ;;=3^Removal of Int Fixation Dev
 ;;^UTILITY(U,$J,358.3,10501,1,4,0)
 ;;=4^V54.01
 ;;^UTILITY(U,$J,358.3,10501,2)
 ;;=^329975
 ;;^UTILITY(U,$J,358.3,10502,0)
 ;;=V58.32^^83^638^1
 ;;^UTILITY(U,$J,358.3,10502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10502,1,3,0)
 ;;=3^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,10502,1,4,0)
 ;;=4^V58.32
 ;;^UTILITY(U,$J,358.3,10502,2)
 ;;=^334217
 ;;^UTILITY(U,$J,358.3,10503,0)
 ;;=V58.31^^83^638^2
 ;;^UTILITY(U,$J,358.3,10503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10503,1,3,0)
 ;;=3^Removal/Change Surgical Dressing
 ;;^UTILITY(U,$J,358.3,10503,1,4,0)
 ;;=4^V58.31
 ;;^UTILITY(U,$J,358.3,10503,2)
 ;;=^334216
 ;;^UTILITY(U,$J,358.3,10504,0)
 ;;=10060^^84^639^1
 ;;^UTILITY(U,$J,358.3,10504,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10504,1,2,0)
 ;;=2^Incision and Drainage of abscess, simple or single
 ;;^UTILITY(U,$J,358.3,10504,1,3,0)
 ;;=3^10060
 ;;^UTILITY(U,$J,358.3,10505,0)
 ;;=10061^^84^639^2
 ;;^UTILITY(U,$J,358.3,10505,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10505,1,2,0)
 ;;=2^Incision and Drainage of abscess; complicated or multiple
 ;;^UTILITY(U,$J,358.3,10505,1,3,0)
 ;;=3^10061
 ;;^UTILITY(U,$J,358.3,10506,0)
 ;;=10120^^84^639^3
 ;;^UTILITY(U,$J,358.3,10506,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10506,1,2,0)
 ;;=2^Incision & Removal foreign body, subcutaneous tissues; simple
 ;;^UTILITY(U,$J,358.3,10506,1,3,0)
 ;;=3^10120
 ;;^UTILITY(U,$J,358.3,10507,0)
 ;;=10121^^84^639^4
 ;;^UTILITY(U,$J,358.3,10507,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10507,1,2,0)
 ;;=2^Incision & Removal foreign body, subcutaneous tissues; complicated
 ;;^UTILITY(U,$J,358.3,10507,1,3,0)
 ;;=3^10121
 ;;^UTILITY(U,$J,358.3,10508,0)
 ;;=10140^^84^639^5
 ;;^UTILITY(U,$J,358.3,10508,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10508,1,2,0)
 ;;=2^Incision and Drainage of hematoma, seroma or fluid collection
 ;;^UTILITY(U,$J,358.3,10508,1,3,0)
 ;;=3^10140
 ;;^UTILITY(U,$J,358.3,10509,0)
 ;;=10160^^84^639^6
 ;;^UTILITY(U,$J,358.3,10509,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10509,1,2,0)
 ;;=2^Puncture aspiration of abscess, hemtoma, bulla, or cyst
 ;;^UTILITY(U,$J,358.3,10509,1,3,0)
 ;;=3^10160
 ;;^UTILITY(U,$J,358.3,10510,0)
 ;;=10180^^84^639^7
 ;;^UTILITY(U,$J,358.3,10510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10510,1,2,0)
 ;;=2^Incision and Drainage, complex, postoperative wound infection
 ;;^UTILITY(U,$J,358.3,10510,1,3,0)
 ;;=3^10180
 ;;^UTILITY(U,$J,358.3,10511,0)
 ;;=11000^^84^640^1
 ;;^UTILITY(U,$J,358.3,10511,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10511,1,2,0)
 ;;=2^Debridement of extensive eczematous or infected skin; up to 10% body surface
 ;;^UTILITY(U,$J,358.3,10511,1,3,0)
 ;;=3^11000
 ;;^UTILITY(U,$J,358.3,10512,0)
 ;;=11010^^84^640^3
 ;;^UTILITY(U,$J,358.3,10512,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10512,1,2,0)
 ;;=2^Debridement including removal of foreign material associated w/open fracture(s) &/or dislocation(s); skin and subcutaneous tissues
 ;;^UTILITY(U,$J,358.3,10512,1,3,0)
 ;;=3^11010
 ;;^UTILITY(U,$J,358.3,10513,0)
 ;;=11011^^84^640^4
 ;;^UTILITY(U,$J,358.3,10513,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10513,1,2,0)
 ;;=2^Debridement including removal of foreign material associated w/ open FX(s) and/or dislocation(s);skin, subcutaneous tissue, muscle fascia, & muscle
 ;;^UTILITY(U,$J,358.3,10513,1,3,0)
 ;;=3^11011
 ;;^UTILITY(U,$J,358.3,10514,0)
 ;;=11042^^84^640^8
 ;;^UTILITY(U,$J,358.3,10514,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10514,1,2,0)
 ;;=2^Debridement; Skin & Subcutaneous Tissue
 ;;^UTILITY(U,$J,358.3,10514,1,3,0)
 ;;=3^11042
 ;;^UTILITY(U,$J,358.3,10515,0)
 ;;=11043^^84^640^9
 ;;^UTILITY(U,$J,358.3,10515,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10515,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue & Muscle 
 ;;^UTILITY(U,$J,358.3,10515,1,3,0)
 ;;=3^11043
 ;;^UTILITY(U,$J,358.3,10516,0)
 ;;=11044^^84^640^10
 ;;^UTILITY(U,$J,358.3,10516,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10516,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue, Muscle & Bone
 ;;^UTILITY(U,$J,358.3,10516,1,3,0)
 ;;=3^11044
 ;;^UTILITY(U,$J,358.3,10517,0)
 ;;=11012^^84^640^5^^^^1
 ;;^UTILITY(U,$J,358.3,10517,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10517,1,2,0)
 ;;=2^Debridement incl. removal of foreign material associate w/ openFx(s) &/or dislocation(s); skin, subcutaneous tissue, muscle fascia, muscle & bone
 ;;^UTILITY(U,$J,358.3,10517,1,3,0)
 ;;=3^11012
 ;;^UTILITY(U,$J,358.3,10518,0)
 ;;=11001^^84^640^2^^^^1
 ;;^UTILITY(U,$J,358.3,10518,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10518,1,2,0)
 ;;=2^Debridement of extensive eczematous or infected skin; each additional 10% body surf
 ;;^UTILITY(U,$J,358.3,10518,1,3,0)
 ;;=3^11001
 ;;^UTILITY(U,$J,358.3,10519,0)
 ;;=11300^^84^641^1
 ;;^UTILITY(U,$J,358.3,10519,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10519,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesions, Single; trunk, arms, legs- 0.5 cm or less
 ;;^UTILITY(U,$J,358.3,10519,1,3,0)
 ;;=3^11300
 ;;^UTILITY(U,$J,358.3,10520,0)
 ;;=11301^^84^641^2
 ;;^UTILITY(U,$J,358.3,10520,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10520,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; trunk, arms or legs- 0.6 to 1.0 cm
 ;;^UTILITY(U,$J,358.3,10520,1,3,0)
 ;;=3^11301
 ;;^UTILITY(U,$J,358.3,10521,0)
 ;;=11302^^84^641^3
 ;;^UTILITY(U,$J,358.3,10521,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10521,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single- trunk, arms or legs 1.1 to 2.0 cm
 ;;^UTILITY(U,$J,358.3,10521,1,3,0)
 ;;=3^11302
 ;;^UTILITY(U,$J,358.3,10522,0)
 ;;=11305^^84^641^5
 ;;^UTILITY(U,$J,358.3,10522,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10522,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion Single; scalp, neck, hands, feet, genitalia- 0.5 cm or less
 ;;^UTILITY(U,$J,358.3,10522,1,3,0)
 ;;=3^11305
 ;;^UTILITY(U,$J,358.3,10523,0)
 ;;=11306^^84^641^6
 ;;^UTILITY(U,$J,358.3,10523,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10523,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- 0.6 to 1.0 cm 
 ;;^UTILITY(U,$J,358.3,10523,1,3,0)
 ;;=3^11306
 ;;^UTILITY(U,$J,358.3,10524,0)
 ;;=11307^^84^641^7
 ;;^UTILITY(U,$J,358.3,10524,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10524,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- 1.1 to 2.0 cm
 ;;^UTILITY(U,$J,358.3,10524,1,3,0)
 ;;=3^11307
 ;;^UTILITY(U,$J,358.3,10525,0)
 ;;=11308^^84^641^8
 ;;^UTILITY(U,$J,358.3,10525,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10525,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- over 2.0 cm
 ;;^UTILITY(U,$J,358.3,10525,1,3,0)
 ;;=3^11308
 ;;^UTILITY(U,$J,358.3,10526,0)
 ;;=11303^^84^641^4^^^^1
 ;;^UTILITY(U,$J,358.3,10526,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10526,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; trunk, arms or legs- over 2.0 cm
 ;;^UTILITY(U,$J,358.3,10526,1,3,0)
 ;;=3^11303
 ;;^UTILITY(U,$J,358.3,10527,0)
 ;;=11719^^84^642^1^^^^1
 ;;^UTILITY(U,$J,358.3,10527,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10527,1,2,0)
 ;;=2^Trimming Nondystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,10527,1,3,0)
 ;;=3^11719
 ;;^UTILITY(U,$J,358.3,10528,0)
 ;;=G0127^^84^642^2^^^^1
 ;;^UTILITY(U,$J,358.3,10528,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10528,1,2,0)
 ;;=2^Trimming Dystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,10528,1,3,0)
 ;;=3^G0127
 ;;^UTILITY(U,$J,358.3,10529,0)
 ;;=11720^^84^642^3^^^^1
 ;;^UTILITY(U,$J,358.3,10529,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10529,1,2,0)
 ;;=2^Debridement of Nail(s)any method(s); 1-5 
 ;;^UTILITY(U,$J,358.3,10529,1,3,0)
 ;;=3^11720
 ;;^UTILITY(U,$J,358.3,10530,0)
 ;;=11721^^84^642^4^^^^1
 ;;^UTILITY(U,$J,358.3,10530,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10530,1,2,0)
 ;;=2^Debridement of Nails any method; 6 or more
 ;;^UTILITY(U,$J,358.3,10530,1,3,0)
 ;;=3^11721
 ;;^UTILITY(U,$J,358.3,10531,0)
 ;;=11730^^84^642^5^^^^1
 ;;^UTILITY(U,$J,358.3,10531,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10531,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,single
 ;;^UTILITY(U,$J,358.3,10531,1,3,0)
 ;;=3^11730
 ;;^UTILITY(U,$J,358.3,10532,0)
 ;;=11732^^84^642^6^^^^1
 ;;^UTILITY(U,$J,358.3,10532,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10532,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,ea addl nail
 ;;^UTILITY(U,$J,358.3,10532,1,3,0)
 ;;=3^11732
 ;;^UTILITY(U,$J,358.3,10533,0)
 ;;=11740^^84^642^7^^^^1
 ;;^UTILITY(U,$J,358.3,10533,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10533,1,2,0)
 ;;=2^Evacuation Subungual Hematoma
 ;;^UTILITY(U,$J,358.3,10533,1,3,0)
 ;;=3^11740
 ;;^UTILITY(U,$J,358.3,10534,0)
 ;;=11750^^84^642^8^^^^1
 ;;^UTILITY(U,$J,358.3,10534,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10534,1,2,0)
 ;;=2^Excision of Nail and Nail Matrx, partial or complete, for permanent removal
 ;;^UTILITY(U,$J,358.3,10534,1,3,0)
 ;;=3^11750
 ;;^UTILITY(U,$J,358.3,10535,0)
 ;;=11755^^84^642^9^^^^1
 ;;^UTILITY(U,$J,358.3,10535,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10535,1,2,0)
 ;;=2^Biopsy of Nail Unit
 ;;^UTILITY(U,$J,358.3,10535,1,3,0)
 ;;=3^11755
 ;;^UTILITY(U,$J,358.3,10536,0)
 ;;=11760^^84^642^10^^^^1
 ;;^UTILITY(U,$J,358.3,10536,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10536,1,2,0)
 ;;=2^Repair of Nail Bed
 ;;^UTILITY(U,$J,358.3,10536,1,3,0)
 ;;=3^11760
 ;;^UTILITY(U,$J,358.3,10537,0)
 ;;=11765^^84^642^11^^^^1
 ;;^UTILITY(U,$J,358.3,10537,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10537,1,2,0)
 ;;=2^Wedge Excision of Skin Nail Fold
 ;;^UTILITY(U,$J,358.3,10537,1,3,0)
 ;;=3^11765
 ;;^UTILITY(U,$J,358.3,10538,0)
 ;;=11055^^84^643^1^^^^1
 ;;^UTILITY(U,$J,358.3,10538,1,0)
 ;;=^358.31IA^3^2
