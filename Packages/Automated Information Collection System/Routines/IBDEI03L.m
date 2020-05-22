IBDEI03L ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8544,1,2,0)
 ;;=2^45349
 ;;^UTILITY(U,$J,358.3,8544,1,3,0)
 ;;=3^Flex Sig w/ EMR
 ;;^UTILITY(U,$J,358.3,8545,0)
 ;;=45338^^46^460^10^^^^1
 ;;^UTILITY(U,$J,358.3,8545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8545,1,2,0)
 ;;=2^45338
 ;;^UTILITY(U,$J,358.3,8545,1,3,0)
 ;;=3^Flex Sig w/ Snare
 ;;^UTILITY(U,$J,358.3,8546,0)
 ;;=45347^^46^460^11^^^^1
 ;;^UTILITY(U,$J,358.3,8546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8546,1,2,0)
 ;;=2^45347
 ;;^UTILITY(U,$J,358.3,8546,1,3,0)
 ;;=3^Flex Sig w/ Stent Placement
 ;;^UTILITY(U,$J,358.3,8547,0)
 ;;=45378^^46^461^12^^^^1
 ;;^UTILITY(U,$J,358.3,8547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8547,1,2,0)
 ;;=2^45378
 ;;^UTILITY(U,$J,358.3,8547,1,3,0)
 ;;=3^Colonoscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,8548,0)
 ;;=45380^^46^461^2^^^^1
 ;;^UTILITY(U,$J,358.3,8548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8548,1,2,0)
 ;;=2^45380
 ;;^UTILITY(U,$J,358.3,8548,1,3,0)
 ;;=3^Colonoscopy w/ Biopsy
 ;;^UTILITY(U,$J,358.3,8549,0)
 ;;=45384^^46^461^8^^^^1
 ;;^UTILITY(U,$J,358.3,8549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8549,1,2,0)
 ;;=2^45384
 ;;^UTILITY(U,$J,358.3,8549,1,3,0)
 ;;=3^Colonoscopy w/ Hot Forceps
 ;;^UTILITY(U,$J,358.3,8550,0)
 ;;=45385^^46^461^9^^^^1
 ;;^UTILITY(U,$J,358.3,8550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8550,1,2,0)
 ;;=2^45385
 ;;^UTILITY(U,$J,358.3,8550,1,3,0)
 ;;=3^Colonoscopy w/ Snare
 ;;^UTILITY(U,$J,358.3,8551,0)
 ;;=45379^^46^461^7^^^^1
 ;;^UTILITY(U,$J,358.3,8551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8551,1,2,0)
 ;;=2^45379
 ;;^UTILITY(U,$J,358.3,8551,1,3,0)
 ;;=3^Colonoscopy w/ Foreign Body Removal
 ;;^UTILITY(U,$J,358.3,8552,0)
 ;;=45382^^46^461^3^^^^1
 ;;^UTILITY(U,$J,358.3,8552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8552,1,2,0)
 ;;=2^45382
 ;;^UTILITY(U,$J,358.3,8552,1,3,0)
 ;;=3^Colonoscopy w/ Control of Bleeding
 ;;^UTILITY(U,$J,358.3,8553,0)
 ;;=45386^^46^461^5^^^^1
 ;;^UTILITY(U,$J,358.3,8553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8553,1,2,0)
 ;;=2^45386
 ;;^UTILITY(U,$J,358.3,8553,1,3,0)
 ;;=3^Colonoscopy w/ Dilation
 ;;^UTILITY(U,$J,358.3,8554,0)
 ;;=45381^^46^461^11^^^^1
 ;;^UTILITY(U,$J,358.3,8554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8554,1,2,0)
 ;;=2^45381
 ;;^UTILITY(U,$J,358.3,8554,1,3,0)
 ;;=3^Colonoscopy w/ Submucosal Injection
 ;;^UTILITY(U,$J,358.3,8555,0)
 ;;=45389^^46^461^10^^^^1
 ;;^UTILITY(U,$J,358.3,8555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8555,1,2,0)
 ;;=2^45389
 ;;^UTILITY(U,$J,358.3,8555,1,3,0)
 ;;=3^Colonoscopy w/ Stent
 ;;^UTILITY(U,$J,358.3,8556,0)
 ;;=45388^^46^461^1^^^^1
 ;;^UTILITY(U,$J,358.3,8556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8556,1,2,0)
 ;;=2^45388
 ;;^UTILITY(U,$J,358.3,8556,1,3,0)
 ;;=3^Colonoscopy w/ Ablation
 ;;^UTILITY(U,$J,358.3,8557,0)
 ;;=45393^^46^461^4^^^^1
 ;;^UTILITY(U,$J,358.3,8557,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8557,1,2,0)
 ;;=2^45393
 ;;^UTILITY(U,$J,358.3,8557,1,3,0)
 ;;=3^Colonoscopy w/ Decompression
 ;;^UTILITY(U,$J,358.3,8558,0)
 ;;=G0121^^46^461^13^^^^1
 ;;^UTILITY(U,$J,358.3,8558,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8558,1,2,0)
 ;;=2^G0121
 ;;^UTILITY(U,$J,358.3,8558,1,3,0)
 ;;=3^Colonoscopy,Screening (Averagte Risk)
 ;;^UTILITY(U,$J,358.3,8559,0)
 ;;=G0105^^46^461^14^^^^1
 ;;^UTILITY(U,$J,358.3,8559,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8559,1,2,0)
 ;;=2^G0105
 ;;^UTILITY(U,$J,358.3,8559,1,3,0)
 ;;=3^Colonoscopy,Screening (High Risk)
 ;;^UTILITY(U,$J,358.3,8560,0)
 ;;=45390^^46^461^6^^^^1
 ;;^UTILITY(U,$J,358.3,8560,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8560,1,2,0)
 ;;=2^45390
 ;;^UTILITY(U,$J,358.3,8560,1,3,0)
 ;;=3^Colonoscopy w/ EMR
 ;;^UTILITY(U,$J,358.3,8561,0)
 ;;=43260^^46^462^13^^^^1
 ;;^UTILITY(U,$J,358.3,8561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8561,1,2,0)
 ;;=2^43260
 ;;^UTILITY(U,$J,358.3,8561,1,3,0)
 ;;=3^ERCP,Diagnostic
 ;;^UTILITY(U,$J,358.3,8562,0)
 ;;=43264^^46^462^5^^^^1
 ;;^UTILITY(U,$J,358.3,8562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8562,1,2,0)
 ;;=2^43264
 ;;^UTILITY(U,$J,358.3,8562,1,3,0)
 ;;=3^ERCP w/ Calculi or Debris Removal
 ;;^UTILITY(U,$J,358.3,8563,0)
 ;;=43262^^46^462^10^^^^1
 ;;^UTILITY(U,$J,358.3,8563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8563,1,2,0)
 ;;=2^43262
 ;;^UTILITY(U,$J,358.3,8563,1,3,0)
 ;;=3^ERCP w/ Sphincterotomy/Papillotomy
 ;;^UTILITY(U,$J,358.3,8564,0)
 ;;=43261^^46^462^3^^^^1
 ;;^UTILITY(U,$J,358.3,8564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8564,1,2,0)
 ;;=2^43261
 ;;^UTILITY(U,$J,358.3,8564,1,3,0)
 ;;=3^ERCP w/ Biopsy
 ;;^UTILITY(U,$J,358.3,8565,0)
 ;;=43263^^46^462^9^^^^1
 ;;^UTILITY(U,$J,358.3,8565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8565,1,2,0)
 ;;=2^43263
 ;;^UTILITY(U,$J,358.3,8565,1,3,0)
 ;;=3^ERCP w/ Pressure Measurement of Sphincter
 ;;^UTILITY(U,$J,358.3,8566,0)
 ;;=43265^^46^462^4^^^^1
 ;;^UTILITY(U,$J,358.3,8566,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8566,1,2,0)
 ;;=2^43265
 ;;^UTILITY(U,$J,358.3,8566,1,3,0)
 ;;=3^ERCP w/ Calculi Destruction,Any Method
 ;;^UTILITY(U,$J,358.3,8567,0)
 ;;=43273^^46^462^7^^^^1
 ;;^UTILITY(U,$J,358.3,8567,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8567,1,2,0)
 ;;=2^43273
 ;;^UTILITY(U,$J,358.3,8567,1,3,0)
 ;;=3^ERCP w/ Direct Visualization of Pancreatic/Common Bile Duct
 ;;^UTILITY(U,$J,358.3,8568,0)
 ;;=43274^^46^462^12^^^^1
 ;;^UTILITY(U,$J,358.3,8568,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8568,1,2,0)
 ;;=2^43274
 ;;^UTILITY(U,$J,358.3,8568,1,3,0)
 ;;=3^ERCP w/ Stent Placement
 ;;^UTILITY(U,$J,358.3,8569,0)
 ;;=43276^^46^462^11^^^^1
 ;;^UTILITY(U,$J,358.3,8569,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8569,1,2,0)
 ;;=2^43276
 ;;^UTILITY(U,$J,358.3,8569,1,3,0)
 ;;=3^ERCP w/ Stent Change or Removal
 ;;^UTILITY(U,$J,358.3,8570,0)
 ;;=43277^^46^462^6^^^^1
 ;;^UTILITY(U,$J,358.3,8570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8570,1,2,0)
 ;;=2^43277
 ;;^UTILITY(U,$J,358.3,8570,1,3,0)
 ;;=3^ERCP w/ Dilation
 ;;^UTILITY(U,$J,358.3,8571,0)
 ;;=43278^^46^462^2^^^^1
 ;;^UTILITY(U,$J,358.3,8571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8571,1,2,0)
 ;;=2^43278
 ;;^UTILITY(U,$J,358.3,8571,1,3,0)
 ;;=3^ERCP w/ Ablation
 ;;^UTILITY(U,$J,358.3,8572,0)
 ;;=43275^^46^462^8^^^^1
 ;;^UTILITY(U,$J,358.3,8572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8572,1,2,0)
 ;;=2^43275
 ;;^UTILITY(U,$J,358.3,8572,1,3,0)
 ;;=3^ERCP w/ Foreign Body or Stent Removal
 ;;^UTILITY(U,$J,358.3,8573,0)
 ;;=48148^^46^462^1^^^^1
 ;;^UTILITY(U,$J,358.3,8573,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8573,1,2,0)
 ;;=2^48148
 ;;^UTILITY(U,$J,358.3,8573,1,3,0)
 ;;=3^Ampullectomy
 ;;^UTILITY(U,$J,358.3,8574,0)
 ;;=74328^^46^462^14^^^^1
 ;;^UTILITY(U,$J,358.3,8574,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8574,1,2,0)
 ;;=2^74328
 ;;^UTILITY(U,$J,358.3,8574,1,3,0)
 ;;=3^Fluoroscopy,Bile Duct
 ;;^UTILITY(U,$J,358.3,8575,0)
 ;;=74329^^46^462^16^^^^1
 ;;^UTILITY(U,$J,358.3,8575,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8575,1,2,0)
 ;;=2^74329
 ;;^UTILITY(U,$J,358.3,8575,1,3,0)
 ;;=3^Fluoroscopy,Pancreatic Duct
 ;;^UTILITY(U,$J,358.3,8576,0)
 ;;=74330^^46^462^15^^^^1
 ;;^UTILITY(U,$J,358.3,8576,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8576,1,2,0)
 ;;=2^74330
 ;;^UTILITY(U,$J,358.3,8576,1,3,0)
 ;;=3^Fluoroscopy,Bile and Pancreatic Ducts
 ;;^UTILITY(U,$J,358.3,8577,0)
 ;;=43246^^46^463^1^^^^1
 ;;^UTILITY(U,$J,358.3,8577,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8577,1,2,0)
 ;;=2^43246
 ;;^UTILITY(U,$J,358.3,8577,1,3,0)
 ;;=3^EGD w/ Percutaneous G-Tube Placement
 ;;^UTILITY(U,$J,358.3,8578,0)
 ;;=44373^^46^463^2^^^^1
 ;;^UTILITY(U,$J,358.3,8578,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8578,1,2,0)
 ;;=2^44373
 ;;^UTILITY(U,$J,358.3,8578,1,3,0)
 ;;=3^Enteroscopy w/ Conversion of G-Tube to J-Tube
 ;;^UTILITY(U,$J,358.3,8579,0)
 ;;=44372^^46^463^3^^^^1
 ;;^UTILITY(U,$J,358.3,8579,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8579,1,2,0)
 ;;=2^44372
 ;;^UTILITY(U,$J,358.3,8579,1,3,0)
 ;;=3^Enteroscopy w/ Percutaneous J-Tube Placement
 ;;^UTILITY(U,$J,358.3,8580,0)
 ;;=43762^^46^463^4^^^^1
 ;;^UTILITY(U,$J,358.3,8580,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8580,1,2,0)
 ;;=2^43762
 ;;^UTILITY(U,$J,358.3,8580,1,3,0)
 ;;=3^G-Tube Change
 ;;^UTILITY(U,$J,358.3,8581,0)
 ;;=43763^^46^463^5^^^^1
 ;;^UTILITY(U,$J,358.3,8581,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8581,1,2,0)
 ;;=2^43763
 ;;^UTILITY(U,$J,358.3,8581,1,3,0)
 ;;=3^G-Tube Change Rev of Gastrostomy
 ;;^UTILITY(U,$J,358.3,8582,0)
 ;;=91111^^46^464^5^^^^1
 ;;^UTILITY(U,$J,358.3,8582,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8582,1,2,0)
 ;;=2^91111
 ;;^UTILITY(U,$J,358.3,8582,1,3,0)
 ;;=3^GI Tract Capsule Imaging Study
 ;;^UTILITY(U,$J,358.3,8583,0)
 ;;=91110^^46^464^3^^^^1
 ;;^UTILITY(U,$J,358.3,8583,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8583,1,2,0)
 ;;=2^91110
 ;;^UTILITY(U,$J,358.3,8583,1,3,0)
 ;;=3^Esophageal Capsule Imaging Study
 ;;^UTILITY(U,$J,358.3,8584,0)
 ;;=91120^^46^464^9^^^^1
 ;;^UTILITY(U,$J,358.3,8584,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8584,1,2,0)
 ;;=2^91120
 ;;^UTILITY(U,$J,358.3,8584,1,3,0)
 ;;=3^Rectal Sensation Test
 ;;^UTILITY(U,$J,358.3,8585,0)
 ;;=91065^^46^464^8^^^^1
 ;;^UTILITY(U,$J,358.3,8585,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8585,1,2,0)
 ;;=2^91065
 ;;^UTILITY(U,$J,358.3,8585,1,3,0)
 ;;=3^Hydrogen Breath Test
 ;;^UTILITY(U,$J,358.3,8586,0)
 ;;=46600^^46^464^2^^^^1
 ;;^UTILITY(U,$J,358.3,8586,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8586,1,2,0)
 ;;=2^46600
 ;;^UTILITY(U,$J,358.3,8586,1,3,0)
 ;;=3^Anoscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,8587,0)
 ;;=44705^^46^464^4^^^^1
 ;;^UTILITY(U,$J,358.3,8587,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8587,1,2,0)
 ;;=2^44705
 ;;^UTILITY(U,$J,358.3,8587,1,3,0)
 ;;=3^Fecal Microbiota Transplantation
 ;;^UTILITY(U,$J,358.3,8588,0)
 ;;=87077^^46^464^1^^^^1
 ;;^UTILITY(U,$J,358.3,8588,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8588,1,2,0)
 ;;=2^87077
 ;;^UTILITY(U,$J,358.3,8588,1,3,0)
 ;;=3^Aerobic Isolate,Ea Isolate Test
 ;;^UTILITY(U,$J,358.3,8589,0)
 ;;=46221^^46^464^7^^^^1
 ;;^UTILITY(U,$J,358.3,8589,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8589,1,2,0)
 ;;=2^46221
 ;;^UTILITY(U,$J,358.3,8589,1,3,0)
 ;;=3^Hemorrhoidectomy by Rubber Band Ligation
 ;;^UTILITY(U,$J,358.3,8590,0)
 ;;=83013^^46^464^6^^^^1
 ;;^UTILITY(U,$J,358.3,8590,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8590,1,2,0)
 ;;=2^83013
 ;;^UTILITY(U,$J,358.3,8590,1,3,0)
 ;;=3^H Pylori Urea Breath Test
 ;;^UTILITY(U,$J,358.3,8591,0)
 ;;=96372^^46^464^10^^^^1
 ;;^UTILITY(U,$J,358.3,8591,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8591,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,8591,1,3,0)
 ;;=3^Subcutaneous or Intramuscular Injection
 ;;^UTILITY(U,$J,358.3,8592,0)
 ;;=90471^^46^465^1^^^^1
 ;;^UTILITY(U,$J,358.3,8592,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8592,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,8592,1,3,0)
 ;;=3^Immunization Admin,1 Vaccine
 ;;^UTILITY(U,$J,358.3,8593,0)
 ;;=90472^^46^465^2^^^^1
 ;;^UTILITY(U,$J,358.3,8593,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8593,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,8593,1,3,0)
 ;;=3^Immunization Admin,Ea Addl
 ;;^UTILITY(U,$J,358.3,8594,0)
 ;;=90632^^46^465^4^^^^1
 ;;^UTILITY(U,$J,358.3,8594,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8594,1,2,0)
 ;;=2^90632
 ;;^UTILITY(U,$J,358.3,8594,1,3,0)
 ;;=3^Hepatitis A Vaccine
 ;;^UTILITY(U,$J,358.3,8595,0)
 ;;=90746^^46^465^8^^^^1
 ;;^UTILITY(U,$J,358.3,8595,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8595,1,2,0)
 ;;=2^90746
 ;;^UTILITY(U,$J,358.3,8595,1,3,0)
 ;;=3^Hepatitis B Vaccine,3 Dose Schedule
 ;;^UTILITY(U,$J,358.3,8596,0)
 ;;=90747^^46^465^10^^^^1
 ;;^UTILITY(U,$J,358.3,8596,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8596,1,2,0)
 ;;=2^90747
 ;;^UTILITY(U,$J,358.3,8596,1,3,0)
 ;;=3^Hepatitis B Vaccine,Dialysis/Immunosupp,4 Dose
 ;;^UTILITY(U,$J,358.3,8597,0)
 ;;=90636^^46^465^3^^^^1
 ;;^UTILITY(U,$J,358.3,8597,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8597,1,2,0)
 ;;=2^90636
 ;;^UTILITY(U,$J,358.3,8597,1,3,0)
 ;;=3^Hepatitis A & B Combination Vaccine
 ;;^UTILITY(U,$J,358.3,8598,0)
 ;;=4155F^^46^465^5^^^^1
 ;;^UTILITY(U,$J,358.3,8598,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8598,1,2,0)
 ;;=2^4155F
 ;;^UTILITY(U,$J,358.3,8598,1,3,0)
 ;;=3^Hepatitis A Vaccine Previously Received
 ;;^UTILITY(U,$J,358.3,8599,0)
 ;;=G0010^^46^465^6^^^^1
 ;;^UTILITY(U,$J,358.3,8599,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8599,1,2,0)
 ;;=2^G0010
 ;;^UTILITY(U,$J,358.3,8599,1,3,0)
 ;;=3^Hepatitis B Vaccine,Admin
 ;;^UTILITY(U,$J,358.3,8600,0)
 ;;=90739^^46^465^7^^^^1
 ;;^UTILITY(U,$J,358.3,8600,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8600,1,2,0)
 ;;=2^90739
 ;;^UTILITY(U,$J,358.3,8600,1,3,0)
 ;;=3^Hepatitis B Vaccine,2 Dose Schedule
 ;;^UTILITY(U,$J,358.3,8601,0)
 ;;=90740^^46^465^9^^^^1
 ;;^UTILITY(U,$J,358.3,8601,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8601,1,2,0)
 ;;=2^90740
 ;;^UTILITY(U,$J,358.3,8601,1,3,0)
 ;;=3^Hepatitis B Vaccine,Dialysis/Immunosupp,3 Dose
 ;;^UTILITY(U,$J,358.3,8602,0)
 ;;=91037^^46^466^5^^^^1
 ;;^UTILITY(U,$J,358.3,8602,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8602,1,2,0)
 ;;=2^91037
 ;;^UTILITY(U,$J,358.3,8602,1,3,0)
 ;;=3^Esoph Imped Funct Test < 1hr
 ;;^UTILITY(U,$J,358.3,8603,0)
 ;;=91038^^46^466^6^^^^1
 ;;^UTILITY(U,$J,358.3,8603,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8603,1,2,0)
 ;;=2^91038
 ;;^UTILITY(U,$J,358.3,8603,1,3,0)
 ;;=3^Esoph Imped Funct Test > 1hr
 ;;^UTILITY(U,$J,358.3,8604,0)
 ;;=91010^^46^466^7^^^^1
 ;;^UTILITY(U,$J,358.3,8604,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8604,1,2,0)
 ;;=2^91010
 ;;^UTILITY(U,$J,358.3,8604,1,3,0)
 ;;=3^Esophageal Manometry Study
 ;;^UTILITY(U,$J,358.3,8605,0)
 ;;=91034^^46^466^10^^^^1
 ;;^UTILITY(U,$J,358.3,8605,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8605,1,2,0)
 ;;=2^91034
 ;;^UTILITY(U,$J,358.3,8605,1,3,0)
 ;;=3^Nasal pH probe placement & pH Study
 ;;^UTILITY(U,$J,358.3,8606,0)
 ;;=91030^^46^466^1^^^^1
 ;;^UTILITY(U,$J,358.3,8606,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8606,1,2,0)
 ;;=2^91030
 ;;^UTILITY(U,$J,358.3,8606,1,3,0)
 ;;=3^Acid Perfusion of Esophagus
 ;;^UTILITY(U,$J,358.3,8607,0)
 ;;=91013^^46^466^8^^^^1
 ;;^UTILITY(U,$J,358.3,8607,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8607,1,2,0)
 ;;=2^91013
 ;;^UTILITY(U,$J,358.3,8607,1,3,0)
 ;;=3^Esophageal Motility w/ Stim/Perfusion
 ;;^UTILITY(U,$J,358.3,8608,0)
 ;;=91112^^46^466^9^^^^1
 ;;^UTILITY(U,$J,358.3,8608,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8608,1,2,0)
 ;;=2^91112
 ;;^UTILITY(U,$J,358.3,8608,1,3,0)
 ;;=3^GI Tract Pressure,pH,Temp & Transit Study
 ;;^UTILITY(U,$J,358.3,8609,0)
 ;;=91122^^46^466^2^^^^1
 ;;^UTILITY(U,$J,358.3,8609,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8609,1,2,0)
 ;;=2^91122
 ;;^UTILITY(U,$J,358.3,8609,1,3,0)
 ;;=3^Anorectal Manometry
 ;;^UTILITY(U,$J,358.3,8610,0)
 ;;=90912^^46^466^3^^^^1
 ;;^UTILITY(U,$J,358.3,8610,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8610,1,2,0)
 ;;=2^90912
 ;;^UTILITY(U,$J,358.3,8610,1,3,0)
 ;;=3^Biofeedback Trng,1st 15 min
 ;;^UTILITY(U,$J,358.3,8611,0)
 ;;=90913^^46^466^4^^^^1
 ;;^UTILITY(U,$J,358.3,8611,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8611,1,2,0)
 ;;=2^90913
 ;;^UTILITY(U,$J,358.3,8611,1,3,0)
 ;;=3^Biofeedback Trng,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,8612,0)
 ;;=45391^^46^467^2^^^^1
 ;;^UTILITY(U,$J,358.3,8612,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8612,1,2,0)
 ;;=2^45391
 ;;^UTILITY(U,$J,358.3,8612,1,3,0)
 ;;=3^Colonoscopy w/ EUS
 ;;^UTILITY(U,$J,358.3,8613,0)
 ;;=45392^^46^467^3^^^^1
 ;;^UTILITY(U,$J,358.3,8613,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8613,1,2,0)
 ;;=2^45392
 ;;^UTILITY(U,$J,358.3,8613,1,3,0)
 ;;=3^Colonoscopy w/ EUS & FNA
 ;;^UTILITY(U,$J,358.3,8614,0)
 ;;=43259^^46^467^4^^^^1
 ;;^UTILITY(U,$J,358.3,8614,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8614,1,2,0)
 ;;=2^43259
 ;;^UTILITY(U,$J,358.3,8614,1,3,0)
 ;;=3^EGD w/ EUS
 ;;^UTILITY(U,$J,358.3,8615,0)
 ;;=43238^^46^467^1^^^^1
 ;;^UTILITY(U,$J,358.3,8615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8615,1,2,0)
 ;;=2^43238
 ;;^UTILITY(U,$J,358.3,8615,1,3,0)
 ;;=3
 ;;^UTILITY(U,$J,358.3,8616,0)
 ;;=43238^^46^467^5^^^^1
 ;;^UTILITY(U,$J,358.3,8616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8616,1,2,0)
 ;;=2^43238
 ;;^UTILITY(U,$J,358.3,8616,1,3,0)
 ;;=3^EGD w/ EUS & FNA
 ;;^UTILITY(U,$J,358.3,8617,0)
 ;;=43253^^46^467^7^^^^1
 ;;^UTILITY(U,$J,358.3,8617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8617,1,2,0)
 ;;=2^43253
 ;;^UTILITY(U,$J,358.3,8617,1,3,0)
 ;;=3^EGD w/ EUS & Therapeutic Injection
 ;;^UTILITY(U,$J,358.3,8618,0)
 ;;=43240^^46^467^6^^^^1
 ;;^UTILITY(U,$J,358.3,8618,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8618,1,2,0)
 ;;=2^43240
 ;;^UTILITY(U,$J,358.3,8618,1,3,0)
 ;;=3^EGD w/ EUS & Pseudocyst Drainage
 ;;^UTILITY(U,$J,358.3,8619,0)
 ;;=45341^^46^467^8^^^^1
 ;;^UTILITY(U,$J,358.3,8619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8619,1,2,0)
 ;;=2^45341
 ;;^UTILITY(U,$J,358.3,8619,1,3,0)
 ;;=3^Flex Sig w/ EUS
 ;;^UTILITY(U,$J,358.3,8620,0)
 ;;=45342^^46^467^9^^^^1
 ;;^UTILITY(U,$J,358.3,8620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8620,1,2,0)
 ;;=2^45342
 ;;^UTILITY(U,$J,358.3,8620,1,3,0)
 ;;=3^Flex Sig w/ EUS & FNA
 ;;^UTILITY(U,$J,358.3,8621,0)
 ;;=49083^^46^468^1^^^^1
 ;;^UTILITY(U,$J,358.3,8621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8621,1,2,0)
 ;;=2^49083
 ;;^UTILITY(U,$J,358.3,8621,1,3,0)
 ;;=3^Abd Paracentesis w/ Imag Guide
 ;;^UTILITY(U,$J,358.3,8622,0)
 ;;=49082^^46^468^2^^^^1
 ;;^UTILITY(U,$J,358.3,8622,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8622,1,2,0)
 ;;=2^49082
 ;;^UTILITY(U,$J,358.3,8622,1,3,0)
 ;;=3^Abd Paracentesis w/o Imag Guide
 ;;^UTILITY(U,$J,358.3,8623,0)
 ;;=43460^^46^468^3^^^^1
 ;;^UTILITY(U,$J,358.3,8623,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8623,1,2,0)
 ;;=2^43460
 ;;^UTILITY(U,$J,358.3,8623,1,3,0)
 ;;=3^Esophagogastric Tamponade w/ Balloon
 ;;^UTILITY(U,$J,358.3,8624,0)
 ;;=47000^^46^468^4^^^^1
 ;;^UTILITY(U,$J,358.3,8624,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8624,1,2,0)
 ;;=2^47000
 ;;^UTILITY(U,$J,358.3,8624,1,3,0)
 ;;=3^Liver Biopsy,Percutaneous
 ;;^UTILITY(U,$J,358.3,8625,0)
 ;;=91200^^46^468^5^^^^1
 ;;^UTILITY(U,$J,358.3,8625,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8625,1,2,0)
 ;;=2^91200
 ;;^UTILITY(U,$J,358.3,8625,1,3,0)
 ;;=3^Transient Shear Wave Elastography
 ;;^UTILITY(U,$J,358.3,8626,0)
 ;;=99078^^46^468^6^^^^1
 ;;^UTILITY(U,$J,358.3,8626,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8626,1,2,0)
 ;;=2^99078
 ;;^UTILITY(U,$J,358.3,8626,1,3,0)
 ;;=3^Education Session,Group
 ;;^UTILITY(U,$J,358.3,8627,0)
 ;;=99152^^46^469^1^^^^1
 ;;^UTILITY(U,$J,358.3,8627,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8627,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,8627,1,3,0)
 ;;=3^Same Provider Performing Procedure,Init 15 min
 ;;^UTILITY(U,$J,358.3,8628,0)
 ;;=99153^^46^469^2^^^^1
