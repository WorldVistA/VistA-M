IBDEI0BO ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15535,1,3,0)
 ;;=3^Screen for Addictions Admit
 ;;^UTILITY(U,$J,358.3,15536,0)
 ;;=H0003^^113^962^6^^^^1
 ;;^UTILITY(U,$J,358.3,15536,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15536,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,15536,1,3,0)
 ;;=3^Alcohol/Drug Scrn;lab analysis
 ;;^UTILITY(U,$J,358.3,15537,0)
 ;;=H0004^^113^962^7^^^^1
 ;;^UTILITY(U,$J,358.3,15537,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15537,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,15537,1,3,0)
 ;;=3^Individual Counseling per 15 min
 ;;^UTILITY(U,$J,358.3,15538,0)
 ;;=H0005^^113^962^3^^^^1
 ;;^UTILITY(U,$J,358.3,15538,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15538,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,15538,1,3,0)
 ;;=3^Addictions Group
 ;;^UTILITY(U,$J,358.3,15539,0)
 ;;=H0006^^113^962^5^^^^1
 ;;^UTILITY(U,$J,358.3,15539,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15539,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,15539,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,15540,0)
 ;;=H0020^^113^962^8^^^^1
 ;;^UTILITY(U,$J,358.3,15540,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15540,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,15540,1,3,0)
 ;;=3^Methadone Administration
 ;;^UTILITY(U,$J,358.3,15541,0)
 ;;=H0025^^113^962^2^^^^1
 ;;^UTILITY(U,$J,358.3,15541,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15541,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,15541,1,3,0)
 ;;=3^Addictions Education Service
 ;;^UTILITY(U,$J,358.3,15542,0)
 ;;=H0030^^113^962^4^^^^1
 ;;^UTILITY(U,$J,358.3,15542,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15542,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,15542,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,15543,0)
 ;;=H0046^^113^962^9^^^^1
 ;;^UTILITY(U,$J,358.3,15543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15543,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,15543,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,15544,0)
 ;;=10060^^114^963^1
 ;;^UTILITY(U,$J,358.3,15544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15544,1,2,0)
 ;;=2^Incision and Drainage of abscess, simple or single
 ;;^UTILITY(U,$J,358.3,15544,1,3,0)
 ;;=3^10060
 ;;^UTILITY(U,$J,358.3,15545,0)
 ;;=10061^^114^963^2
 ;;^UTILITY(U,$J,358.3,15545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15545,1,2,0)
 ;;=2^Incision and Drainage of abscess; complicated or multiple
 ;;^UTILITY(U,$J,358.3,15545,1,3,0)
 ;;=3^10061
 ;;^UTILITY(U,$J,358.3,15546,0)
 ;;=10120^^114^963^3
 ;;^UTILITY(U,$J,358.3,15546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15546,1,2,0)
 ;;=2^Incision & Removal foreign body, subcutaneous tissues; simple
 ;;^UTILITY(U,$J,358.3,15546,1,3,0)
 ;;=3^10120
 ;;^UTILITY(U,$J,358.3,15547,0)
 ;;=10121^^114^963^4
 ;;^UTILITY(U,$J,358.3,15547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15547,1,2,0)
 ;;=2^Incision & Removal foreign body, subcutaneous tissues; complicated
 ;;^UTILITY(U,$J,358.3,15547,1,3,0)
 ;;=3^10121
 ;;^UTILITY(U,$J,358.3,15548,0)
 ;;=10140^^114^963^5
 ;;^UTILITY(U,$J,358.3,15548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15548,1,2,0)
 ;;=2^Incision and Drainage of hematoma, seroma or fluid collection
 ;;^UTILITY(U,$J,358.3,15548,1,3,0)
 ;;=3^10140
 ;;^UTILITY(U,$J,358.3,15549,0)
 ;;=10160^^114^963^6
 ;;^UTILITY(U,$J,358.3,15549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15549,1,2,0)
 ;;=2^Puncture aspiration of abscess, hemtoma, bulla, or cyst
 ;;^UTILITY(U,$J,358.3,15549,1,3,0)
 ;;=3^10160
 ;;^UTILITY(U,$J,358.3,15550,0)
 ;;=10180^^114^963^7
 ;;^UTILITY(U,$J,358.3,15550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15550,1,2,0)
 ;;=2^Incision and Drainage, complex, postoperative wound infection
 ;;^UTILITY(U,$J,358.3,15550,1,3,0)
 ;;=3^10180
 ;;^UTILITY(U,$J,358.3,15551,0)
 ;;=11000^^114^964^1
 ;;^UTILITY(U,$J,358.3,15551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15551,1,2,0)
 ;;=2^Debr of extensive eczematous 10%
 ;;^UTILITY(U,$J,358.3,15551,1,3,0)
 ;;=3^11000
 ;;^UTILITY(U,$J,358.3,15552,0)
 ;;=11010^^114^964^3
 ;;^UTILITY(U,$J,358.3,15552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15552,1,2,0)
 ;;=2^Debridement including removal of foreign material associated w/open fracture(s) &/or dislocation(s); skin and subcutaneous tissues
 ;;^UTILITY(U,$J,358.3,15552,1,3,0)
 ;;=3^11010
 ;;^UTILITY(U,$J,358.3,15553,0)
 ;;=11011^^114^964^4
 ;;^UTILITY(U,$J,358.3,15553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15553,1,2,0)
 ;;=2^Debridement including removal of foreign material associated w/ open FX(s) and/or dislocation(s);skin, subcutaneous tissue, muscle fascia, & muscle
 ;;^UTILITY(U,$J,358.3,15553,1,3,0)
 ;;=3^11011
 ;;^UTILITY(U,$J,358.3,15554,0)
 ;;=11042^^114^964^8
 ;;^UTILITY(U,$J,358.3,15554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15554,1,2,0)
 ;;=2^Debridement; Skin & Subcutaneous Tissue
 ;;^UTILITY(U,$J,358.3,15554,1,3,0)
 ;;=3^11042
 ;;^UTILITY(U,$J,358.3,15555,0)
 ;;=11043^^114^964^9
 ;;^UTILITY(U,$J,358.3,15555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15555,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue & Muscle 
 ;;^UTILITY(U,$J,358.3,15555,1,3,0)
 ;;=3^11043
 ;;^UTILITY(U,$J,358.3,15556,0)
 ;;=11044^^114^964^10
 ;;^UTILITY(U,$J,358.3,15556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15556,1,2,0)
 ;;=2^Debridement; Skin, Subcutaneous Tissue, Muscle & Bone
 ;;^UTILITY(U,$J,358.3,15556,1,3,0)
 ;;=3^11044
 ;;^UTILITY(U,$J,358.3,15557,0)
 ;;=11012^^114^964^5^^^^1
 ;;^UTILITY(U,$J,358.3,15557,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15557,1,2,0)
 ;;=2^Debridement incl. removal of foreign material associate w/ openFx(s) &/or dislocation(s); skin, subcutaneous tissue, muscle fascia, muscle & bone
 ;;^UTILITY(U,$J,358.3,15557,1,3,0)
 ;;=3^11012
 ;;^UTILITY(U,$J,358.3,15558,0)
 ;;=11001^^114^964^2^^^^1
 ;;^UTILITY(U,$J,358.3,15558,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15558,1,2,0)
 ;;=2^Debr of extensive eczematous;ea addl 10%
 ;;^UTILITY(U,$J,358.3,15558,1,3,0)
 ;;=3^11001
 ;;^UTILITY(U,$J,358.3,15559,0)
 ;;=11300^^114^965^1
 ;;^UTILITY(U,$J,358.3,15559,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15559,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesions, Single; trunk, arms, legs- 0.5 cm or less
 ;;^UTILITY(U,$J,358.3,15559,1,3,0)
 ;;=3^11300
 ;;^UTILITY(U,$J,358.3,15560,0)
 ;;=11301^^114^965^2
 ;;^UTILITY(U,$J,358.3,15560,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15560,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; trunk, arms or legs- 0.6 to 1.0 cm
 ;;^UTILITY(U,$J,358.3,15560,1,3,0)
 ;;=3^11301
 ;;^UTILITY(U,$J,358.3,15561,0)
 ;;=11302^^114^965^3
 ;;^UTILITY(U,$J,358.3,15561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15561,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single- trunk, arms or legs 1.1 to 2.0 cm
 ;;^UTILITY(U,$J,358.3,15561,1,3,0)
 ;;=3^11302
 ;;^UTILITY(U,$J,358.3,15562,0)
 ;;=11305^^114^965^5
 ;;^UTILITY(U,$J,358.3,15562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15562,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion Single; scalp, neck, hands, feet, genitalia- 0.5 cm or less
 ;;^UTILITY(U,$J,358.3,15562,1,3,0)
 ;;=3^11305
 ;;^UTILITY(U,$J,358.3,15563,0)
 ;;=11306^^114^965^6
 ;;^UTILITY(U,$J,358.3,15563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15563,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- 0.6 to 1.0 cm 
 ;;^UTILITY(U,$J,358.3,15563,1,3,0)
 ;;=3^11306
 ;;^UTILITY(U,$J,358.3,15564,0)
 ;;=11307^^114^965^7
 ;;^UTILITY(U,$J,358.3,15564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15564,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- 1.1 to 2.0 cm
 ;;^UTILITY(U,$J,358.3,15564,1,3,0)
 ;;=3^11307
 ;;^UTILITY(U,$J,358.3,15565,0)
 ;;=11308^^114^965^8
 ;;^UTILITY(U,$J,358.3,15565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15565,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; scalp, neck, hands, feet, genitalia- over 2.0 cm
 ;;^UTILITY(U,$J,358.3,15565,1,3,0)
 ;;=3^11308
 ;;^UTILITY(U,$J,358.3,15566,0)
 ;;=11303^^114^965^4^^^^1
 ;;^UTILITY(U,$J,358.3,15566,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15566,1,2,0)
 ;;=2^Shaving of Epidermal or Dermal Lesion, Single; trunk, arms or legs- over 2.0 cm
 ;;^UTILITY(U,$J,358.3,15566,1,3,0)
 ;;=3^11303
 ;;^UTILITY(U,$J,358.3,15567,0)
 ;;=11719^^114^966^1^^^^1
 ;;^UTILITY(U,$J,358.3,15567,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15567,1,2,0)
 ;;=2^Trimming Nondystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,15567,1,3,0)
 ;;=3^11719
 ;;^UTILITY(U,$J,358.3,15568,0)
 ;;=G0127^^114^966^2^^^^1
 ;;^UTILITY(U,$J,358.3,15568,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15568,1,2,0)
 ;;=2^Trimming Dystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,15568,1,3,0)
 ;;=3^G0127
 ;;^UTILITY(U,$J,358.3,15569,0)
 ;;=11720^^114^966^3^^^^1
 ;;^UTILITY(U,$J,358.3,15569,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15569,1,2,0)
 ;;=2^Debridement of Nail(s)any method(s); 1-5 
 ;;^UTILITY(U,$J,358.3,15569,1,3,0)
 ;;=3^11720
 ;;^UTILITY(U,$J,358.3,15570,0)
 ;;=11721^^114^966^4^^^^1
 ;;^UTILITY(U,$J,358.3,15570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15570,1,2,0)
 ;;=2^Debridement of Nails any method; 6 or more
 ;;^UTILITY(U,$J,358.3,15570,1,3,0)
 ;;=3^11721
 ;;^UTILITY(U,$J,358.3,15571,0)
 ;;=11730^^114^966^5^^^^1
 ;;^UTILITY(U,$J,358.3,15571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15571,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,single
 ;;^UTILITY(U,$J,358.3,15571,1,3,0)
 ;;=3^11730
 ;;^UTILITY(U,$J,358.3,15572,0)
 ;;=11732^^114^966^6^^^^1
 ;;^UTILITY(U,$J,358.3,15572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15572,1,2,0)
 ;;=2^Avulsion of Nail Plate,part/comp,ea addl nail
 ;;^UTILITY(U,$J,358.3,15572,1,3,0)
 ;;=3^11732
 ;;^UTILITY(U,$J,358.3,15573,0)
 ;;=11740^^114^966^7^^^^1
 ;;^UTILITY(U,$J,358.3,15573,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15573,1,2,0)
 ;;=2^Evacuation Subungual Hematoma
