IBDEI0GS ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7544,0)
 ;;=43278^^37^374^2^^^^1
 ;;^UTILITY(U,$J,358.3,7544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7544,1,2,0)
 ;;=2^43278
 ;;^UTILITY(U,$J,358.3,7544,1,3,0)
 ;;=3^ERCP w/ Ablation
 ;;^UTILITY(U,$J,358.3,7545,0)
 ;;=43275^^37^374^8^^^^1
 ;;^UTILITY(U,$J,358.3,7545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7545,1,2,0)
 ;;=2^43275
 ;;^UTILITY(U,$J,358.3,7545,1,3,0)
 ;;=3^ERCP w/ Foreign Body or Stent Removal
 ;;^UTILITY(U,$J,358.3,7546,0)
 ;;=48148^^37^374^1^^^^1
 ;;^UTILITY(U,$J,358.3,7546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7546,1,2,0)
 ;;=2^48148
 ;;^UTILITY(U,$J,358.3,7546,1,3,0)
 ;;=3^Ampullectomy
 ;;^UTILITY(U,$J,358.3,7547,0)
 ;;=74328^^37^374^14^^^^1
 ;;^UTILITY(U,$J,358.3,7547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7547,1,2,0)
 ;;=2^74328
 ;;^UTILITY(U,$J,358.3,7547,1,3,0)
 ;;=3^Fluoroscopy,Bile Duct
 ;;^UTILITY(U,$J,358.3,7548,0)
 ;;=74329^^37^374^16^^^^1
 ;;^UTILITY(U,$J,358.3,7548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7548,1,2,0)
 ;;=2^74329
 ;;^UTILITY(U,$J,358.3,7548,1,3,0)
 ;;=3^Fluoroscopy,Pancreatic Duct
 ;;^UTILITY(U,$J,358.3,7549,0)
 ;;=74330^^37^374^15^^^^1
 ;;^UTILITY(U,$J,358.3,7549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7549,1,2,0)
 ;;=2^74330
 ;;^UTILITY(U,$J,358.3,7549,1,3,0)
 ;;=3^Fluoroscopy,Bile and Pancreatic Ducts
 ;;^UTILITY(U,$J,358.3,7550,0)
 ;;=43246^^37^375^1^^^^1
 ;;^UTILITY(U,$J,358.3,7550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7550,1,2,0)
 ;;=2^43246
 ;;^UTILITY(U,$J,358.3,7550,1,3,0)
 ;;=3^EGD w/ Percutaneous G-Tube Placement
 ;;^UTILITY(U,$J,358.3,7551,0)
 ;;=44373^^37^375^2^^^^1
 ;;^UTILITY(U,$J,358.3,7551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7551,1,2,0)
 ;;=2^44373
 ;;^UTILITY(U,$J,358.3,7551,1,3,0)
 ;;=3^Enteroscopy w/ Conversion of G-Tube to J-Tube
 ;;^UTILITY(U,$J,358.3,7552,0)
 ;;=44372^^37^375^3^^^^1
 ;;^UTILITY(U,$J,358.3,7552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7552,1,2,0)
 ;;=2^44372
 ;;^UTILITY(U,$J,358.3,7552,1,3,0)
 ;;=3^Enteroscopy w/ Percutaneous J-Tube Placement
 ;;^UTILITY(U,$J,358.3,7553,0)
 ;;=43762^^37^375^4^^^^1
 ;;^UTILITY(U,$J,358.3,7553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7553,1,2,0)
 ;;=2^43762
 ;;^UTILITY(U,$J,358.3,7553,1,3,0)
 ;;=3^G-Tube Change
 ;;^UTILITY(U,$J,358.3,7554,0)
 ;;=43763^^37^375^5^^^^1
 ;;^UTILITY(U,$J,358.3,7554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7554,1,2,0)
 ;;=2^43763
 ;;^UTILITY(U,$J,358.3,7554,1,3,0)
 ;;=3^G-Tube Change Rev of Gastrostomy
 ;;^UTILITY(U,$J,358.3,7555,0)
 ;;=91111^^37^376^4^^^^1
 ;;^UTILITY(U,$J,358.3,7555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7555,1,2,0)
 ;;=2^91111
 ;;^UTILITY(U,$J,358.3,7555,1,3,0)
 ;;=3^GI Tract Imaging,Intraluminal,Esophagus,Int & Rpt
 ;;^UTILITY(U,$J,358.3,7556,0)
 ;;=91110^^37^376^5^^^^1
 ;;^UTILITY(U,$J,358.3,7556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7556,1,2,0)
 ;;=2^91110
 ;;^UTILITY(U,$J,358.3,7556,1,3,0)
 ;;=3^GI Tract Imaging,Intraluminal,Esophagus-Ileum,Int & Rpt
 ;;^UTILITY(U,$J,358.3,7557,0)
 ;;=91120^^37^376^9^^^^1
 ;;^UTILITY(U,$J,358.3,7557,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7557,1,2,0)
 ;;=2^91120
 ;;^UTILITY(U,$J,358.3,7557,1,3,0)
 ;;=3^Rectal Sensation Test
 ;;^UTILITY(U,$J,358.3,7558,0)
 ;;=91065^^37^376^8^^^^1
 ;;^UTILITY(U,$J,358.3,7558,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7558,1,2,0)
 ;;=2^91065
 ;;^UTILITY(U,$J,358.3,7558,1,3,0)
 ;;=3^Hydrogen Breath Test
