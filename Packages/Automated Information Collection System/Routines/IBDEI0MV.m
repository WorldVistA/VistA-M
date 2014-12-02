IBDEI0MV ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11231,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11231,1,2,0)
 ;;=2^44366
 ;;^UTILITY(U,$J,358.3,11231,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Control of Hemorrhage
 ;;^UTILITY(U,$J,358.3,11232,0)
 ;;=44370^^72^731^4^^^^1
 ;;^UTILITY(U,$J,358.3,11232,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11232,1,2,0)
 ;;=2^44370
 ;;^UTILITY(U,$J,358.3,11232,1,3,0)
 ;;=3^Sm Intestine Endos w/Stent Placement
 ;;^UTILITY(U,$J,358.3,11233,0)
 ;;=44372^^72^731^3^^^^1
 ;;^UTILITY(U,$J,358.3,11233,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11233,1,2,0)
 ;;=2^44372
 ;;^UTILITY(U,$J,358.3,11233,1,3,0)
 ;;=3^Sm Intestine Endos w/J-Tube Placement
 ;;^UTILITY(U,$J,358.3,11234,0)
 ;;=44373^^72^731^2^^^^1
 ;;^UTILITY(U,$J,358.3,11234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11234,1,2,0)
 ;;=2^44373
 ;;^UTILITY(U,$J,358.3,11234,1,3,0)
 ;;=3^Sm Intestine Endos w/J-Tube Conversion
 ;;^UTILITY(U,$J,358.3,11235,0)
 ;;=46600^^72^732^11^^^^1
 ;;^UTILITY(U,$J,358.3,11235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11235,1,2,0)
 ;;=2^46600
 ;;^UTILITY(U,$J,358.3,11235,1,3,0)
 ;;=3^Anoscopy, Diagnositc
 ;;^UTILITY(U,$J,358.3,11236,0)
 ;;=46606^^72^732^5^^^^1
 ;;^UTILITY(U,$J,358.3,11236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11236,1,2,0)
 ;;=2^46606
 ;;^UTILITY(U,$J,358.3,11236,1,3,0)
 ;;=3^Anoscopy w/Biopsy
 ;;^UTILITY(U,$J,358.3,11237,0)
 ;;=45330^^72^732^12^^^^1
 ;;^UTILITY(U,$J,358.3,11237,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11237,1,2,0)
 ;;=2^45330
 ;;^UTILITY(U,$J,358.3,11237,1,3,0)
 ;;=3^Flex Sig Diagnostic
 ;;^UTILITY(U,$J,358.3,11238,0)
 ;;=45331^^72^732^17^^^^1
 ;;^UTILITY(U,$J,358.3,11238,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11238,1,2,0)
 ;;=2^45331
 ;;^UTILITY(U,$J,358.3,11238,1,3,0)
 ;;=3^Flex Sig w/Biopsy
 ;;^UTILITY(U,$J,358.3,11239,0)
 ;;=45333^^72^732^20^^^^1
 ;;^UTILITY(U,$J,358.3,11239,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11239,1,2,0)
 ;;=2^45333
 ;;^UTILITY(U,$J,358.3,11239,1,3,0)
 ;;=3^Flex Sig w/Tumor Removal by Hot Forceps
 ;;^UTILITY(U,$J,358.3,11240,0)
 ;;=45338^^72^732^16^^^^1
 ;;^UTILITY(U,$J,358.3,11240,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11240,1,2,0)
 ;;=2^45338
 ;;^UTILITY(U,$J,358.3,11240,1,3,0)
 ;;=3^Flex Sig W/Tumor Removal by Snare
 ;;^UTILITY(U,$J,358.3,11241,0)
 ;;=45332^^72^732^15^^^^1
 ;;^UTILITY(U,$J,358.3,11241,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11241,1,2,0)
 ;;=2^45332
 ;;^UTILITY(U,$J,358.3,11241,1,3,0)
 ;;=3^Flex Sig W/FB Removal
 ;;^UTILITY(U,$J,358.3,11242,0)
 ;;=45339^^72^732^13^^^^1
 ;;^UTILITY(U,$J,358.3,11242,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11242,1,2,0)
 ;;=2^45339
 ;;^UTILITY(U,$J,358.3,11242,1,3,0)
 ;;=3^Flex Sig W/Ablation of Tumor
 ;;^UTILITY(U,$J,358.3,11243,0)
 ;;=45334^^72^732^14^^^^1
 ;;^UTILITY(U,$J,358.3,11243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11243,1,2,0)
 ;;=2^45334
 ;;^UTILITY(U,$J,358.3,11243,1,3,0)
 ;;=3^Flex Sig W/Control of Hemorrhage
 ;;^UTILITY(U,$J,358.3,11244,0)
 ;;=45300^^72^732^32^^^^1
 ;;^UTILITY(U,$J,358.3,11244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11244,1,2,0)
 ;;=2^45300
 ;;^UTILITY(U,$J,358.3,11244,1,3,0)
 ;;=3^Rigid Sigmoidoscopy
 ;;^UTILITY(U,$J,358.3,11245,0)
 ;;=45303^^72^732^26^^^^1
 ;;^UTILITY(U,$J,358.3,11245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11245,1,2,0)
 ;;=2^45303
 ;;^UTILITY(U,$J,358.3,11245,1,3,0)
 ;;=3^Rigid Proctosig w/Dilation
 ;;^UTILITY(U,$J,358.3,11246,0)
 ;;=45305^^72^732^23^^^^1
 ;;^UTILITY(U,$J,358.3,11246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11246,1,2,0)
 ;;=2^45305
 ;;^UTILITY(U,$J,358.3,11246,1,3,0)
 ;;=3^Rigid Proctosig w/Biopsy(s)
