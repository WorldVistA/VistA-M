IBDEI03W ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4929,1,3,0)
 ;;=3^Esophagoscopy w/remov tumor/polyp-Snare
 ;;^UTILITY(U,$J,358.3,4930,0)
 ;;=43219^^44^338^19^^^^1
 ;;^UTILITY(U,$J,358.3,4930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4930,1,2,0)
 ;;=2^43219
 ;;^UTILITY(U,$J,358.3,4930,1,3,0)
 ;;=3^Esophag w/insert plastic tube/stent
 ;;^UTILITY(U,$J,358.3,4931,0)
 ;;=43228^^44^338^26^^^^1
 ;;^UTILITY(U,$J,358.3,4931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4931,1,2,0)
 ;;=2^43228
 ;;^UTILITY(U,$J,358.3,4931,1,3,0)
 ;;=3^Esophagoscopy w/ablation tumor
 ;;^UTILITY(U,$J,358.3,4932,0)
 ;;=43231^^44^338^20^^^^1
 ;;^UTILITY(U,$J,358.3,4932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4932,1,2,0)
 ;;=2^43231
 ;;^UTILITY(U,$J,358.3,4932,1,3,0)
 ;;=3^Esophagoscopy w endoscopic ultrasound
 ;;^UTILITY(U,$J,358.3,4933,0)
 ;;=43232^^44^338^30^^^^1
 ;;^UTILITY(U,$J,358.3,4933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4933,1,2,0)
 ;;=2^43232
 ;;^UTILITY(U,$J,358.3,4933,1,3,0)
 ;;=3^Esophagoscopy w/tx-endoscop U/S FNA/bx
 ;;^UTILITY(U,$J,358.3,4934,0)
 ;;=43234^^44^338^17^^^^1
 ;;^UTILITY(U,$J,358.3,4934,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4934,1,2,0)
 ;;=2^43234
 ;;^UTILITY(U,$J,358.3,4934,1,3,0)
 ;;=3^EGD,simple primary exam
 ;;^UTILITY(U,$J,358.3,4935,0)
 ;;=43236^^44^338^14^^^^1
 ;;^UTILITY(U,$J,358.3,4935,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4935,1,2,0)
 ;;=2^43236
 ;;^UTILITY(U,$J,358.3,4935,1,3,0)
 ;;=3^EGD, Diagnostic w/submucosal inj(s)
 ;;^UTILITY(U,$J,358.3,4936,0)
 ;;=43237^^44^338^16^^^^1
 ;;^UTILITY(U,$J,358.3,4936,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4936,1,2,0)
 ;;=2^43237
 ;;^UTILITY(U,$J,358.3,4936,1,3,0)
 ;;=3^EGD,Diag US of esophagus
 ;;^UTILITY(U,$J,358.3,4937,0)
 ;;=43238^^44^338^12^^^^1
 ;;^UTILITY(U,$J,358.3,4937,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4937,1,2,0)
 ;;=2^43238
 ;;^UTILITY(U,$J,358.3,4937,1,3,0)
 ;;=3^EGD, Diag-w/transendoscope U/S FNA/bx
 ;;^UTILITY(U,$J,358.3,4938,0)
 ;;=43257^^44^338^10^^^^1
 ;;^UTILITY(U,$J,358.3,4938,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4938,1,2,0)
 ;;=2^43257
 ;;^UTILITY(U,$J,358.3,4938,1,3,0)
 ;;=3^EGD w/Thermal Energy Delivery
 ;;^UTILITY(U,$J,358.3,4939,0)
 ;;=44360^^44^339^1^^^^1
 ;;^UTILITY(U,$J,358.3,4939,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4939,1,2,0)
 ;;=2^44360
 ;;^UTILITY(U,$J,358.3,4939,1,3,0)
 ;;=3^Small Intestinal Endoscopy, Diagnostic
 ;;^UTILITY(U,$J,358.3,4940,0)
 ;;=44361^^44^339^2^^^^1
 ;;^UTILITY(U,$J,358.3,4940,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4940,1,2,0)
 ;;=2^44361
 ;;^UTILITY(U,$J,358.3,4940,1,3,0)
 ;;=3^Sm Intentine Endoscopy w/Biopsy
 ;;^UTILITY(U,$J,358.3,4941,0)
 ;;=44365^^44^339^5^^^^1
 ;;^UTILITY(U,$J,358.3,4941,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4941,1,2,0)
 ;;=2^44365
 ;;^UTILITY(U,$J,358.3,4941,1,3,0)
 ;;=3^Sm Intesting Endoscopy w/hot cautery tumor removal
 ;;^UTILITY(U,$J,358.3,4942,0)
 ;;=44364^^44^339^4^^^^1
 ;;^UTILITY(U,$J,358.3,4942,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4942,1,2,0)
 ;;=2^44364
 ;;^UTILITY(U,$J,358.3,4942,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Snare Tumor Removal
 ;;^UTILITY(U,$J,358.3,4943,0)
 ;;=44363^^44^339^3^^^^1
 ;;^UTILITY(U,$J,358.3,4943,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4943,1,2,0)
 ;;=2^44363
 ;;^UTILITY(U,$J,358.3,4943,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/FB Removal
 ;;^UTILITY(U,$J,358.3,4944,0)
 ;;=44369^^44^339^7^^^^1
 ;;^UTILITY(U,$J,358.3,4944,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4944,1,2,0)
 ;;=2^44369
 ;;^UTILITY(U,$J,358.3,4944,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Ablation of Tumor
 ;;^UTILITY(U,$J,358.3,4945,0)
 ;;=44366^^44^339^6^^^^1
 ;;^UTILITY(U,$J,358.3,4945,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4945,1,2,0)
 ;;=2^44366
 ;;^UTILITY(U,$J,358.3,4945,1,3,0)
 ;;=3^Sm Intestine Endoscopy w/Control of Hemorrhage
 ;;^UTILITY(U,$J,358.3,4946,0)
 ;;=44370^^44^339^8^^^^1
 ;;^UTILITY(U,$J,358.3,4946,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4946,1,2,0)
 ;;=2^44370
 ;;^UTILITY(U,$J,358.3,4946,1,3,0)
 ;;=3^Sm Intestine Endos w/Stent Placement
 ;;^UTILITY(U,$J,358.3,4947,0)
 ;;=44372^^44^339^9^^^^1
 ;;^UTILITY(U,$J,358.3,4947,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4947,1,2,0)
 ;;=2^44372
 ;;^UTILITY(U,$J,358.3,4947,1,3,0)
 ;;=3^Small Intes Endos w/J-Tube Placement
 ;;^UTILITY(U,$J,358.3,4948,0)
 ;;=44373^^44^339^10^^^^1
 ;;^UTILITY(U,$J,358.3,4948,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4948,1,2,0)
 ;;=2^44373
 ;;^UTILITY(U,$J,358.3,4948,1,3,0)
 ;;=3^Sm Intestine Endos w/J-Tube Conversion
 ;;^UTILITY(U,$J,358.3,4949,0)
 ;;=46600^^44^340^1^^^^1
 ;;^UTILITY(U,$J,358.3,4949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4949,1,2,0)
 ;;=2^46600
 ;;^UTILITY(U,$J,358.3,4949,1,3,0)
 ;;=3^Anoscopy, Diagnositc
 ;;^UTILITY(U,$J,358.3,4950,0)
 ;;=46606^^44^340^2^^^^1
 ;;^UTILITY(U,$J,358.3,4950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4950,1,2,0)
 ;;=2^46606
 ;;^UTILITY(U,$J,358.3,4950,1,3,0)
 ;;=3^Anoscopy, W Biopsy
 ;;^UTILITY(U,$J,358.3,4951,0)
 ;;=45330^^44^340^3^^^^1
 ;;^UTILITY(U,$J,358.3,4951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4951,1,2,0)
 ;;=2^45330
 ;;^UTILITY(U,$J,358.3,4951,1,3,0)
 ;;=3^Flex Sig Diagnostic
 ;;^UTILITY(U,$J,358.3,4952,0)
 ;;=45331^^44^340^8^^^^1
 ;;^UTILITY(U,$J,358.3,4952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4952,1,2,0)
 ;;=2^45331
 ;;^UTILITY(U,$J,358.3,4952,1,3,0)
 ;;=3^Flex Sig w/Biopsy
 ;;^UTILITY(U,$J,358.3,4953,0)
 ;;=45333^^44^340^11^^^^1
 ;;^UTILITY(U,$J,358.3,4953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4953,1,2,0)
 ;;=2^45333
 ;;^UTILITY(U,$J,358.3,4953,1,3,0)
 ;;=3^Flex Sig w/Tumor Removal by Hot Forceps
 ;;^UTILITY(U,$J,358.3,4954,0)
 ;;=45338^^44^340^7^^^^1
 ;;^UTILITY(U,$J,358.3,4954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4954,1,2,0)
 ;;=2^45338
 ;;^UTILITY(U,$J,358.3,4954,1,3,0)
 ;;=3^Flex Sig W/Tumor Removal by Snare
 ;;^UTILITY(U,$J,358.3,4955,0)
 ;;=45332^^44^340^6^^^^1
 ;;^UTILITY(U,$J,358.3,4955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4955,1,2,0)
 ;;=2^45332
 ;;^UTILITY(U,$J,358.3,4955,1,3,0)
 ;;=3^Flex Sig W/FB Removal
 ;;^UTILITY(U,$J,358.3,4956,0)
 ;;=45339^^44^340^4^^^^1
 ;;^UTILITY(U,$J,358.3,4956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4956,1,2,0)
 ;;=2^45339
 ;;^UTILITY(U,$J,358.3,4956,1,3,0)
 ;;=3^Flex Sig W/Ablation of Tumor
 ;;^UTILITY(U,$J,358.3,4957,0)
 ;;=45334^^44^340^5^^^^1
 ;;^UTILITY(U,$J,358.3,4957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4957,1,2,0)
 ;;=2^45334
 ;;^UTILITY(U,$J,358.3,4957,1,3,0)
 ;;=3^Flex Sig W/Control of Hemorrhage
 ;;^UTILITY(U,$J,358.3,4958,0)
 ;;=45300^^44^340^22^^^^1
 ;;^UTILITY(U,$J,358.3,4958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4958,1,2,0)
 ;;=2^45300
 ;;^UTILITY(U,$J,358.3,4958,1,3,0)
 ;;=3^Rigid Sigmoidoscopy
 ;;^UTILITY(U,$J,358.3,4959,0)
 ;;=45303^^44^340^16^^^^1
 ;;^UTILITY(U,$J,358.3,4959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4959,1,2,0)
 ;;=2^45303
 ;;^UTILITY(U,$J,358.3,4959,1,3,0)
 ;;=3^Rigid Proctosig w/Dilation
 ;;^UTILITY(U,$J,358.3,4960,0)
 ;;=45305^^44^340^13^^^^1
 ;;^UTILITY(U,$J,358.3,4960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4960,1,2,0)
 ;;=2^45305
 ;;^UTILITY(U,$J,358.3,4960,1,3,0)
 ;;=3^Rigid Proctosig w/Biopsy(s)
 ;;^UTILITY(U,$J,358.3,4961,0)
 ;;=45307^^44^340^17^^^^1
 ;;^UTILITY(U,$J,358.3,4961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4961,1,2,0)
 ;;=2^45307
 ;;^UTILITY(U,$J,358.3,4961,1,3,0)
 ;;=3^Rigid Proctosig w/Removal FB
 ;;^UTILITY(U,$J,358.3,4962,0)
 ;;=45308^^44^340^19^^^^1
 ;;^UTILITY(U,$J,358.3,4962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4962,1,2,0)
 ;;=2^45308
 ;;^UTILITY(U,$J,358.3,4962,1,3,0)
 ;;=3^Rigid Proctosig w/Tumor Rem-Hot Forceps
 ;;^UTILITY(U,$J,358.3,4963,0)
 ;;=45309^^44^340^21^^^^1
 ;;^UTILITY(U,$J,358.3,4963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4963,1,2,0)
 ;;=2^45309
 ;;^UTILITY(U,$J,358.3,4963,1,3,0)
 ;;=3^Rigid Proctosig w/Tumor Rem-Snare
 ;;^UTILITY(U,$J,358.3,4964,0)
 ;;=45315^^44^340^20^^^^1
 ;;^UTILITY(U,$J,358.3,4964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4964,1,2,0)
 ;;=2^45315
 ;;^UTILITY(U,$J,358.3,4964,1,3,0)
 ;;=3^Rigid Proctosig w/Tumor Rem-Ht FRCP/Snar
 ;;^UTILITY(U,$J,358.3,4965,0)
 ;;=45317^^44^340^14^^^^1
 ;;^UTILITY(U,$J,358.3,4965,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4965,1,2,0)
 ;;=2^45317
 ;;^UTILITY(U,$J,358.3,4965,1,3,0)
 ;;=3^Rigid Proctosig w/Control of Bleed
 ;;^UTILITY(U,$J,358.3,4966,0)
 ;;=45320^^44^340^12^^^^1
 ;;^UTILITY(U,$J,358.3,4966,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4966,1,2,0)
 ;;=2^45320
 ;;^UTILITY(U,$J,358.3,4966,1,3,0)
 ;;=3^Rigid Proctosig w/Ablation Tumor
 ;;^UTILITY(U,$J,358.3,4967,0)
 ;;=45321^^44^340^15^^^^1
 ;;^UTILITY(U,$J,358.3,4967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4967,1,2,0)
 ;;=2^45321
 ;;^UTILITY(U,$J,358.3,4967,1,3,0)
 ;;=3^Rigid Proctosig w/Decomp Volvulus
 ;;^UTILITY(U,$J,358.3,4968,0)
 ;;=45327^^44^340^18^^^^1
 ;;^UTILITY(U,$J,358.3,4968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4968,1,2,0)
 ;;=2^45327
 ;;^UTILITY(U,$J,358.3,4968,1,3,0)
 ;;=3^Rigid Proctosig w/Stent Placement
 ;;^UTILITY(U,$J,358.3,4969,0)
 ;;=45335^^44^340^10^^^^1
 ;;^UTILITY(U,$J,358.3,4969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4969,1,2,0)
 ;;=2^45335
 ;;^UTILITY(U,$J,358.3,4969,1,3,0)
 ;;=3^Flex Sig w/Submucosal Inj
 ;;^UTILITY(U,$J,358.3,4970,0)
 ;;=45337^^44^340^9^^^^1
 ;;^UTILITY(U,$J,358.3,4970,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4970,1,2,0)
 ;;=2^45337
 ;;^UTILITY(U,$J,358.3,4970,1,3,0)
 ;;=3^Flex Sig w/Decompression Volvulus
 ;;^UTILITY(U,$J,358.3,4971,0)
 ;;=45378^^44^341^1^^^^1
 ;;^UTILITY(U,$J,358.3,4971,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4971,1,2,0)
 ;;=2^45378
 ;;^UTILITY(U,$J,358.3,4971,1,3,0)
 ;;=3^Colonoscopy, Diagnostic
 ;;^UTILITY(U,$J,358.3,4972,0)
 ;;=45380^^44^341^3^^^^1
 ;;^UTILITY(U,$J,358.3,4972,1,0)
 ;;=^358.31IA^3^2
