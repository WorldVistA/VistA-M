IBDEI088 ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10834,1,3,0)
 ;;=3^Anoscopy, W Biopsy
 ;;^UTILITY(U,$J,358.3,10835,0)
 ;;=45330^^84^718^4^^^^1
 ;;^UTILITY(U,$J,358.3,10835,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10835,1,2,0)
 ;;=2^45330
 ;;^UTILITY(U,$J,358.3,10835,1,3,0)
 ;;=3^Flex Sig Diagnostic
 ;;^UTILITY(U,$J,358.3,10836,0)
 ;;=45331^^84^718^9^^^^1
 ;;^UTILITY(U,$J,358.3,10836,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10836,1,2,0)
 ;;=2^45331
 ;;^UTILITY(U,$J,358.3,10836,1,3,0)
 ;;=3^Flex Sig w/Biopsy
 ;;^UTILITY(U,$J,358.3,10837,0)
 ;;=45333^^84^718^12^^^^1
 ;;^UTILITY(U,$J,358.3,10837,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10837,1,2,0)
 ;;=2^45333
 ;;^UTILITY(U,$J,358.3,10837,1,3,0)
 ;;=3^Flex Sig w/Tumor Removal by Hot Forceps
 ;;^UTILITY(U,$J,358.3,10838,0)
 ;;=45338^^84^718^8^^^^1
 ;;^UTILITY(U,$J,358.3,10838,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10838,1,2,0)
 ;;=2^45338
 ;;^UTILITY(U,$J,358.3,10838,1,3,0)
 ;;=3^Flex Sig W/Tumor Removal by Snare
 ;;^UTILITY(U,$J,358.3,10839,0)
 ;;=45332^^84^718^7^^^^1
 ;;^UTILITY(U,$J,358.3,10839,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10839,1,2,0)
 ;;=2^45332
 ;;^UTILITY(U,$J,358.3,10839,1,3,0)
 ;;=3^Flex Sig W/FB Removal
 ;;^UTILITY(U,$J,358.3,10840,0)
 ;;=45339^^84^718^5^^^^1
 ;;^UTILITY(U,$J,358.3,10840,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10840,1,2,0)
 ;;=2^45339
 ;;^UTILITY(U,$J,358.3,10840,1,3,0)
 ;;=3^Flex Sig W/Ablation of Tumor
 ;;^UTILITY(U,$J,358.3,10841,0)
 ;;=45334^^84^718^6^^^^1
 ;;^UTILITY(U,$J,358.3,10841,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10841,1,2,0)
 ;;=2^45334
 ;;^UTILITY(U,$J,358.3,10841,1,3,0)
 ;;=3^Flex Sig W/Control of Hemorrhage
 ;;^UTILITY(U,$J,358.3,10842,0)
 ;;=45300^^84^718^23^^^^1
 ;;^UTILITY(U,$J,358.3,10842,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10842,1,2,0)
 ;;=2^45300
 ;;^UTILITY(U,$J,358.3,10842,1,3,0)
 ;;=3^Rigid Sigmoidoscopy
 ;;^UTILITY(U,$J,358.3,10843,0)
 ;;=45303^^84^718^17^^^^1
 ;;^UTILITY(U,$J,358.3,10843,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10843,1,2,0)
 ;;=2^45303
 ;;^UTILITY(U,$J,358.3,10843,1,3,0)
 ;;=3^Rigid Proctosig w/Dilation
 ;;^UTILITY(U,$J,358.3,10844,0)
 ;;=45305^^84^718^14^^^^1
 ;;^UTILITY(U,$J,358.3,10844,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10844,1,2,0)
 ;;=2^45305
 ;;^UTILITY(U,$J,358.3,10844,1,3,0)
 ;;=3^Rigid Proctosig w/Biopsy(s)
 ;;^UTILITY(U,$J,358.3,10845,0)
 ;;=45307^^84^718^18^^^^1
 ;;^UTILITY(U,$J,358.3,10845,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10845,1,2,0)
 ;;=2^45307
 ;;^UTILITY(U,$J,358.3,10845,1,3,0)
 ;;=3^Rigid Proctosig w/Removal FB
 ;;^UTILITY(U,$J,358.3,10846,0)
 ;;=45308^^84^718^20^^^^1
 ;;^UTILITY(U,$J,358.3,10846,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10846,1,2,0)
 ;;=2^45308
 ;;^UTILITY(U,$J,358.3,10846,1,3,0)
 ;;=3^Rigid Proctosig w/Tumor Rem-Hot Forceps
 ;;^UTILITY(U,$J,358.3,10847,0)
 ;;=45309^^84^718^22^^^^1
 ;;^UTILITY(U,$J,358.3,10847,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10847,1,2,0)
 ;;=2^45309
 ;;^UTILITY(U,$J,358.3,10847,1,3,0)
 ;;=3^Rigid Proctosig w/Tumor Rem-Snare
 ;;^UTILITY(U,$J,358.3,10848,0)
 ;;=45315^^84^718^21^^^^1
 ;;^UTILITY(U,$J,358.3,10848,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10848,1,2,0)
 ;;=2^45315
 ;;^UTILITY(U,$J,358.3,10848,1,3,0)
 ;;=3^Rigid Proctosig w/Tumor Rem-Ht FRCP/Snar
 ;;^UTILITY(U,$J,358.3,10849,0)
 ;;=45317^^84^718^15^^^^1
 ;;^UTILITY(U,$J,358.3,10849,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10849,1,2,0)
 ;;=2^45317
 ;;^UTILITY(U,$J,358.3,10849,1,3,0)
 ;;=3^Rigid Proctosig w/Control of Bleed
 ;;^UTILITY(U,$J,358.3,10850,0)
 ;;=45320^^84^718^13^^^^1
 ;;^UTILITY(U,$J,358.3,10850,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10850,1,2,0)
 ;;=2^45320
 ;;^UTILITY(U,$J,358.3,10850,1,3,0)
 ;;=3^Rigid Proctosig w/Ablation Tumor
 ;;^UTILITY(U,$J,358.3,10851,0)
 ;;=45321^^84^718^16^^^^1
 ;;^UTILITY(U,$J,358.3,10851,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10851,1,2,0)
 ;;=2^45321
 ;;^UTILITY(U,$J,358.3,10851,1,3,0)
 ;;=3^Rigid Proctosig w/Decomp Volvulus
 ;;^UTILITY(U,$J,358.3,10852,0)
 ;;=45327^^84^718^19^^^^1
 ;;^UTILITY(U,$J,358.3,10852,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10852,1,2,0)
 ;;=2^45327
 ;;^UTILITY(U,$J,358.3,10852,1,3,0)
 ;;=3^Rigid Proctosig w/Stent Placement
 ;;^UTILITY(U,$J,358.3,10853,0)
 ;;=45335^^84^718^11^^^^1
 ;;^UTILITY(U,$J,358.3,10853,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10853,1,2,0)
 ;;=2^45335
 ;;^UTILITY(U,$J,358.3,10853,1,3,0)
 ;;=3^Flex Sig w/Submucosal Inj
 ;;^UTILITY(U,$J,358.3,10854,0)
 ;;=45337^^84^718^10^^^^1
 ;;^UTILITY(U,$J,358.3,10854,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10854,1,2,0)
 ;;=2^45337
 ;;^UTILITY(U,$J,358.3,10854,1,3,0)
 ;;=3^Flex Sig w/Decompression Volvulus
 ;;^UTILITY(U,$J,358.3,10855,0)
 ;;=46604^^84^718^1^^^^1
 ;;^UTILITY(U,$J,358.3,10855,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10855,1,2,0)
 ;;=2^46604
 ;;^UTILITY(U,$J,358.3,10855,1,3,0)
 ;;=3^Anoscopy & Dilation (Balloon,Guidewire)
 ;;^UTILITY(U,$J,358.3,10856,0)
 ;;=45378^^84^719^1^^^^1
 ;;^UTILITY(U,$J,358.3,10856,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10856,1,2,0)
 ;;=2^45378
 ;;^UTILITY(U,$J,358.3,10856,1,3,0)
 ;;=3^Colonoscopy, Diagnostic
 ;;^UTILITY(U,$J,358.3,10857,0)
 ;;=45380^^84^719^3^^^^1
 ;;^UTILITY(U,$J,358.3,10857,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10857,1,2,0)
 ;;=2^45380
 ;;^UTILITY(U,$J,358.3,10857,1,3,0)
 ;;=3^Colonoscopy w/Biopsy
 ;;^UTILITY(U,$J,358.3,10858,0)
 ;;=45384^^84^719^6^^^^1
 ;;^UTILITY(U,$J,358.3,10858,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10858,1,2,0)
 ;;=2^45384
 ;;^UTILITY(U,$J,358.3,10858,1,3,0)
 ;;=3^Colonoscopy w/Tumor Removal by hot forceps
 ;;^UTILITY(U,$J,358.3,10859,0)
 ;;=45385^^84^719^7^^^^1
 ;;^UTILITY(U,$J,358.3,10859,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10859,1,2,0)
 ;;=2^45385
 ;;^UTILITY(U,$J,358.3,10859,1,3,0)
 ;;=3^Colonoscopy w/tumor removal by snare
 ;;^UTILITY(U,$J,358.3,10860,0)
 ;;=45379^^84^719^2^^^^1
 ;;^UTILITY(U,$J,358.3,10860,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10860,1,2,0)
 ;;=2^45379
 ;;^UTILITY(U,$J,358.3,10860,1,3,0)
 ;;=3^Colonoscopy w/FB Removal
 ;;^UTILITY(U,$J,358.3,10861,0)
 ;;=45383^^84^719^5^^^^1
 ;;^UTILITY(U,$J,358.3,10861,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10861,1,2,0)
 ;;=2^45383
 ;;^UTILITY(U,$J,358.3,10861,1,3,0)
 ;;=3^Colonoscopy w/Ablation of tumor
 ;;^UTILITY(U,$J,358.3,10862,0)
 ;;=45382^^84^719^4^^^^1
 ;;^UTILITY(U,$J,358.3,10862,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10862,1,2,0)
 ;;=2^45382
 ;;^UTILITY(U,$J,358.3,10862,1,3,0)
 ;;=3^Colonoscopy w/ control hemorrhage
 ;;^UTILITY(U,$J,358.3,10863,0)
 ;;=45386^^84^719^8^^^^1
 ;;^UTILITY(U,$J,358.3,10863,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10863,1,2,0)
 ;;=2^45386
 ;;^UTILITY(U,$J,358.3,10863,1,3,0)
 ;;=3^Colonoscopy w/Balloon Dilation Stricture
 ;;^UTILITY(U,$J,358.3,10864,0)
 ;;=45387^^84^719^9^^^^1
 ;;^UTILITY(U,$J,358.3,10864,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10864,1,2,0)
 ;;=2^45387
 ;;^UTILITY(U,$J,358.3,10864,1,3,0)
 ;;=3^Colonos w/Stent Placement inc dilation
 ;;^UTILITY(U,$J,358.3,10865,0)
 ;;=45391^^84^719^10^^^^1
 ;;^UTILITY(U,$J,358.3,10865,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10865,1,2,0)
 ;;=2^45391
 ;;^UTILITY(U,$J,358.3,10865,1,3,0)
 ;;=3^Colonoscopy w/EUS
 ;;^UTILITY(U,$J,358.3,10866,0)
 ;;=45392^^84^719^11^^^^1
 ;;^UTILITY(U,$J,358.3,10866,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10866,1,2,0)
 ;;=2^45392
 ;;^UTILITY(U,$J,358.3,10866,1,3,0)
 ;;=3^Colonos w/intramural/transmural FNA/BX
 ;;^UTILITY(U,$J,358.3,10867,0)
 ;;=43260^^84^720^1^^^^1
 ;;^UTILITY(U,$J,358.3,10867,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10867,1,2,0)
 ;;=2^43260
 ;;^UTILITY(U,$J,358.3,10867,1,3,0)
 ;;=3^ERCP, Diagnostic, with or w/o Specimen
 ;;^UTILITY(U,$J,358.3,10868,0)
 ;;=43271^^84^720^11^^^^1
 ;;^UTILITY(U,$J,358.3,10868,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10868,1,2,0)
 ;;=2^43271
 ;;^UTILITY(U,$J,358.3,10868,1,3,0)
 ;;=3^ERCP w/Balloon Dilation
 ;;^UTILITY(U,$J,358.3,10869,0)
 ;;=43267^^84^720^7^^^^1
 ;;^UTILITY(U,$J,358.3,10869,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10869,1,2,0)
 ;;=2^43267
 ;;^UTILITY(U,$J,358.3,10869,1,3,0)
 ;;=3^ERCP w/Nasobiliary Tube Placement.
 ;;^UTILITY(U,$J,358.3,10870,0)
 ;;=43264^^84^720^5^^^^1
 ;;^UTILITY(U,$J,358.3,10870,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10870,1,2,0)
 ;;=2^43264
 ;;^UTILITY(U,$J,358.3,10870,1,3,0)
 ;;=3^ERCP w/Stone Removal
 ;;^UTILITY(U,$J,358.3,10871,0)
 ;;=43268^^84^720^9^^^^1
 ;;^UTILITY(U,$J,358.3,10871,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10871,1,2,0)
 ;;=2^43268
 ;;^UTILITY(U,$J,358.3,10871,1,3,0)
 ;;=3^ERCP w/Stent Placement
 ;;^UTILITY(U,$J,358.3,10872,0)
 ;;=43269^^84^720^10^^^^1
 ;;^UTILITY(U,$J,358.3,10872,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10872,1,2,0)
 ;;=2^43269
 ;;^UTILITY(U,$J,358.3,10872,1,3,0)
 ;;=3^ERCP w/Stent Change or Removal
 ;;^UTILITY(U,$J,358.3,10873,0)
 ;;=43262^^84^720^3^^^^1
 ;;^UTILITY(U,$J,358.3,10873,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10873,1,2,0)
 ;;=2^43262
 ;;^UTILITY(U,$J,358.3,10873,1,3,0)
 ;;=3^ERCP w/Papillotomy/Sphincterotomy
 ;;^UTILITY(U,$J,358.3,10874,0)
 ;;=43261^^84^720^2^^^^1
 ;;^UTILITY(U,$J,358.3,10874,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10874,1,2,0)
 ;;=2^43261
 ;;^UTILITY(U,$J,358.3,10874,1,3,0)
 ;;=3^ERCP w/Biopsy,single or multi
 ;;^UTILITY(U,$J,358.3,10875,0)
 ;;=43263^^84^720^4^^^^1
 ;;^UTILITY(U,$J,358.3,10875,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10875,1,2,0)
 ;;=2^43263
 ;;^UTILITY(U,$J,358.3,10875,1,3,0)
 ;;=3^ERCP w/Pressure measure Sphincter
 ;;^UTILITY(U,$J,358.3,10876,0)
 ;;=43265^^84^720^6^^^^1
 ;;^UTILITY(U,$J,358.3,10876,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10876,1,2,0)
 ;;=2^43265
 ;;^UTILITY(U,$J,358.3,10876,1,3,0)
 ;;=3^ERCP w/Retrograde Destruct/lithotripsy
 ;;^UTILITY(U,$J,358.3,10877,0)
 ;;=43272^^84^720^12^^^^1
