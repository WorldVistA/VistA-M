IBDEI0MY ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11278,0)
 ;;=45355^^72^733^3^^^^1
 ;;^UTILITY(U,$J,358.3,11278,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11278,1,2,0)
 ;;=2^45355
 ;;^UTILITY(U,$J,358.3,11278,1,3,0)
 ;;=3^Colonoscopy transabdominal,Single/Multi
 ;;^UTILITY(U,$J,358.3,11279,0)
 ;;=45381^^72^733^13^^^^1
 ;;^UTILITY(U,$J,358.3,11279,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11279,1,2,0)
 ;;=2^45381
 ;;^UTILITY(U,$J,358.3,11279,1,3,0)
 ;;=3^Colonoscopy,Submucosal Inj
 ;;^UTILITY(U,$J,358.3,11280,0)
 ;;=43260^^72^734^11^^^^1
 ;;^UTILITY(U,$J,358.3,11280,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11280,1,2,0)
 ;;=2^43260
 ;;^UTILITY(U,$J,358.3,11280,1,3,0)
 ;;=3^ERCP, Diagnostic, with or w/o Specimen
 ;;^UTILITY(U,$J,358.3,11281,0)
 ;;=43264^^72^734^10^^^^1
 ;;^UTILITY(U,$J,358.3,11281,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11281,1,2,0)
 ;;=2^43264
 ;;^UTILITY(U,$J,358.3,11281,1,3,0)
 ;;=3^ERCP w/Stone Removal
 ;;^UTILITY(U,$J,358.3,11282,0)
 ;;=43262^^72^734^6^^^^1
 ;;^UTILITY(U,$J,358.3,11282,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11282,1,2,0)
 ;;=2^43262
 ;;^UTILITY(U,$J,358.3,11282,1,3,0)
 ;;=3^ERCP w/Papillotomy/Sphincterotomy
 ;;^UTILITY(U,$J,358.3,11283,0)
 ;;=43261^^72^734^3^^^^1
 ;;^UTILITY(U,$J,358.3,11283,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11283,1,2,0)
 ;;=2^43261
 ;;^UTILITY(U,$J,358.3,11283,1,3,0)
 ;;=3^ERCP w/Biopsy,single or multi
 ;;^UTILITY(U,$J,358.3,11284,0)
 ;;=43263^^72^734^7^^^^1
 ;;^UTILITY(U,$J,358.3,11284,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11284,1,2,0)
 ;;=2^43263
 ;;^UTILITY(U,$J,358.3,11284,1,3,0)
 ;;=3^ERCP w/Pressure measure Sphincter
 ;;^UTILITY(U,$J,358.3,11285,0)
 ;;=43265^^72^734^8^^^^1
 ;;^UTILITY(U,$J,358.3,11285,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11285,1,2,0)
 ;;=2^43265
 ;;^UTILITY(U,$J,358.3,11285,1,3,0)
 ;;=3^ERCP w/Retrograde Destruct/lithotripsy
 ;;^UTILITY(U,$J,358.3,11286,0)
 ;;=43273^^72^734^12^^^^1
 ;;^UTILITY(U,$J,358.3,11286,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11286,1,2,0)
 ;;=2^43273
 ;;^UTILITY(U,$J,358.3,11286,1,3,0)
 ;;=3^Endoscopic Cannula of Papilla
 ;;^UTILITY(U,$J,358.3,11287,0)
 ;;=43274^^72^734^4^^^^1
 ;;^UTILITY(U,$J,358.3,11287,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11287,1,2,0)
 ;;=2^43274
 ;;^UTILITY(U,$J,358.3,11287,1,3,0)
 ;;=3^ERCP w/Nasobiliary Tube Placement
 ;;^UTILITY(U,$J,358.3,11288,0)
 ;;=43276^^72^734^9^^^^1
 ;;^UTILITY(U,$J,358.3,11288,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11288,1,2,0)
 ;;=2^43276
 ;;^UTILITY(U,$J,358.3,11288,1,3,0)
 ;;=3^ERCP w/Stent Change or Removal
 ;;^UTILITY(U,$J,358.3,11289,0)
 ;;=43277^^72^734^2^^^^1
 ;;^UTILITY(U,$J,358.3,11289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11289,1,2,0)
 ;;=2^43277
 ;;^UTILITY(U,$J,358.3,11289,1,3,0)
 ;;=3^ERCP w/Balloon Dilation
 ;;^UTILITY(U,$J,358.3,11290,0)
 ;;=43278^^72^734^5^^^^1
 ;;^UTILITY(U,$J,358.3,11290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11290,1,2,0)
 ;;=2^43278
 ;;^UTILITY(U,$J,358.3,11290,1,3,0)
 ;;=3^ERCP w/Other Ablation of Tumor/Polyp
 ;;^UTILITY(U,$J,358.3,11291,0)
 ;;=43275^^72^734^1^^^^1
 ;;^UTILITY(U,$J,358.3,11291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11291,1,2,0)
 ;;=2^43275
 ;;^UTILITY(U,$J,358.3,11291,1,3,0)
 ;;=3^ERCP w/ Removal FB(s)/Stent(s) from Ducts
 ;;^UTILITY(U,$J,358.3,11292,0)
 ;;=17250^^72^735^1^^^^1
 ;;^UTILITY(U,$J,358.3,11292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11292,1,2,0)
 ;;=2^17250
 ;;^UTILITY(U,$J,358.3,11292,1,3,0)
 ;;=3^Chemical Cautery of Granulation Tissue
 ;;^UTILITY(U,$J,358.3,11293,0)
 ;;=43246^^72^735^2^^^^1
 ;;^UTILITY(U,$J,358.3,11293,1,0)
 ;;=^358.31IA^3^2
