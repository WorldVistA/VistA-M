IBDEI0GR ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7529,0)
 ;;=45388^^37^373^1^^^^1
 ;;^UTILITY(U,$J,358.3,7529,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7529,1,2,0)
 ;;=2^45388
 ;;^UTILITY(U,$J,358.3,7529,1,3,0)
 ;;=3^Colonoscopy w/ Ablation
 ;;^UTILITY(U,$J,358.3,7530,0)
 ;;=45393^^37^373^4^^^^1
 ;;^UTILITY(U,$J,358.3,7530,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7530,1,2,0)
 ;;=2^45393
 ;;^UTILITY(U,$J,358.3,7530,1,3,0)
 ;;=3^Colonoscopy w/ Decompression
 ;;^UTILITY(U,$J,358.3,7531,0)
 ;;=G0121^^37^373^13^^^^1
 ;;^UTILITY(U,$J,358.3,7531,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7531,1,2,0)
 ;;=2^G0121
 ;;^UTILITY(U,$J,358.3,7531,1,3,0)
 ;;=3^Colonoscopy,Screening (Average Risk)
 ;;^UTILITY(U,$J,358.3,7532,0)
 ;;=G0105^^37^373^14^^^^1
 ;;^UTILITY(U,$J,358.3,7532,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7532,1,2,0)
 ;;=2^G0105
 ;;^UTILITY(U,$J,358.3,7532,1,3,0)
 ;;=3^Colonoscopy,Screening (High Risk)
 ;;^UTILITY(U,$J,358.3,7533,0)
 ;;=45390^^37^373^6^^^^1
 ;;^UTILITY(U,$J,358.3,7533,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7533,1,2,0)
 ;;=2^45390
 ;;^UTILITY(U,$J,358.3,7533,1,3,0)
 ;;=3^Colonoscopy w/ EMR
 ;;^UTILITY(U,$J,358.3,7534,0)
 ;;=43260^^37^374^13^^^^1
 ;;^UTILITY(U,$J,358.3,7534,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7534,1,2,0)
 ;;=2^43260
 ;;^UTILITY(U,$J,358.3,7534,1,3,0)
 ;;=3^ERCP,Diagnostic
 ;;^UTILITY(U,$J,358.3,7535,0)
 ;;=43264^^37^374^5^^^^1
 ;;^UTILITY(U,$J,358.3,7535,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7535,1,2,0)
 ;;=2^43264
 ;;^UTILITY(U,$J,358.3,7535,1,3,0)
 ;;=3^ERCP w/ Calculi or Debris Removal
 ;;^UTILITY(U,$J,358.3,7536,0)
 ;;=43262^^37^374^10^^^^1
 ;;^UTILITY(U,$J,358.3,7536,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7536,1,2,0)
 ;;=2^43262
 ;;^UTILITY(U,$J,358.3,7536,1,3,0)
 ;;=3^ERCP w/ Sphincterotomy/Papillotomy
 ;;^UTILITY(U,$J,358.3,7537,0)
 ;;=43261^^37^374^3^^^^1
 ;;^UTILITY(U,$J,358.3,7537,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7537,1,2,0)
 ;;=2^43261
 ;;^UTILITY(U,$J,358.3,7537,1,3,0)
 ;;=3^ERCP w/ Biopsy
 ;;^UTILITY(U,$J,358.3,7538,0)
 ;;=43263^^37^374^9^^^^1
 ;;^UTILITY(U,$J,358.3,7538,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7538,1,2,0)
 ;;=2^43263
 ;;^UTILITY(U,$J,358.3,7538,1,3,0)
 ;;=3^ERCP w/ Pressure Measurement of Sphincter
 ;;^UTILITY(U,$J,358.3,7539,0)
 ;;=43265^^37^374^4^^^^1
 ;;^UTILITY(U,$J,358.3,7539,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7539,1,2,0)
 ;;=2^43265
 ;;^UTILITY(U,$J,358.3,7539,1,3,0)
 ;;=3^ERCP w/ Calculi Destruction,Any Method
 ;;^UTILITY(U,$J,358.3,7540,0)
 ;;=43273^^37^374^7^^^^1
 ;;^UTILITY(U,$J,358.3,7540,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7540,1,2,0)
 ;;=2^43273
 ;;^UTILITY(U,$J,358.3,7540,1,3,0)
 ;;=3^ERCP w/ Direct Visualization of Pancreatic/Common Bile Duct
 ;;^UTILITY(U,$J,358.3,7541,0)
 ;;=43274^^37^374^12^^^^1
 ;;^UTILITY(U,$J,358.3,7541,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7541,1,2,0)
 ;;=2^43274
 ;;^UTILITY(U,$J,358.3,7541,1,3,0)
 ;;=3^ERCP w/ Stent Placement
 ;;^UTILITY(U,$J,358.3,7542,0)
 ;;=43276^^37^374^11^^^^1
 ;;^UTILITY(U,$J,358.3,7542,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7542,1,2,0)
 ;;=2^43276
 ;;^UTILITY(U,$J,358.3,7542,1,3,0)
 ;;=3^ERCP w/ Stent Change or Removal
 ;;^UTILITY(U,$J,358.3,7543,0)
 ;;=43277^^37^374^6^^^^1
 ;;^UTILITY(U,$J,358.3,7543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7543,1,2,0)
 ;;=2^43277
 ;;^UTILITY(U,$J,358.3,7543,1,3,0)
 ;;=3^ERCP w/ Dilation
