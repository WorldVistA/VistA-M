IBDEI03C ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7961,1,3,0)
 ;;=3^ERCP w/ Stent Placement
 ;;^UTILITY(U,$J,358.3,7962,0)
 ;;=43276^^43^403^11^^^^1
 ;;^UTILITY(U,$J,358.3,7962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7962,1,2,0)
 ;;=2^43276
 ;;^UTILITY(U,$J,358.3,7962,1,3,0)
 ;;=3^ERCP w/ Stent Change or Removal
 ;;^UTILITY(U,$J,358.3,7963,0)
 ;;=43277^^43^403^6^^^^1
 ;;^UTILITY(U,$J,358.3,7963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7963,1,2,0)
 ;;=2^43277
 ;;^UTILITY(U,$J,358.3,7963,1,3,0)
 ;;=3^ERCP w/ Dilation
 ;;^UTILITY(U,$J,358.3,7964,0)
 ;;=43278^^43^403^2^^^^1
 ;;^UTILITY(U,$J,358.3,7964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7964,1,2,0)
 ;;=2^43278
 ;;^UTILITY(U,$J,358.3,7964,1,3,0)
 ;;=3^ERCP w/ Ablation
 ;;^UTILITY(U,$J,358.3,7965,0)
 ;;=43275^^43^403^8^^^^1
 ;;^UTILITY(U,$J,358.3,7965,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7965,1,2,0)
 ;;=2^43275
 ;;^UTILITY(U,$J,358.3,7965,1,3,0)
 ;;=3^ERCP w/ Foreign Body or Stent Removal
 ;;^UTILITY(U,$J,358.3,7966,0)
 ;;=48148^^43^403^1^^^^1
 ;;^UTILITY(U,$J,358.3,7966,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7966,1,2,0)
 ;;=2^48148
 ;;^UTILITY(U,$J,358.3,7966,1,3,0)
 ;;=3^Ampullectomy
 ;;^UTILITY(U,$J,358.3,7967,0)
 ;;=74328^^43^403^14^^^^1
 ;;^UTILITY(U,$J,358.3,7967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7967,1,2,0)
 ;;=2^74328
 ;;^UTILITY(U,$J,358.3,7967,1,3,0)
 ;;=3^Fluoroscopy,Bile Duct
 ;;^UTILITY(U,$J,358.3,7968,0)
 ;;=74329^^43^403^16^^^^1
 ;;^UTILITY(U,$J,358.3,7968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7968,1,2,0)
 ;;=2^74329
 ;;^UTILITY(U,$J,358.3,7968,1,3,0)
 ;;=3^Fluoroscopy,Pancreatic Duct
 ;;^UTILITY(U,$J,358.3,7969,0)
 ;;=74330^^43^403^15^^^^1
 ;;^UTILITY(U,$J,358.3,7969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7969,1,2,0)
 ;;=2^74330
 ;;^UTILITY(U,$J,358.3,7969,1,3,0)
 ;;=3^Fluoroscopy,Bile and Pancreatic Ducts
 ;;^UTILITY(U,$J,358.3,7970,0)
 ;;=43246^^43^404^1^^^^1
 ;;^UTILITY(U,$J,358.3,7970,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7970,1,2,0)
 ;;=2^43246
 ;;^UTILITY(U,$J,358.3,7970,1,3,0)
 ;;=3^EGD w/ Percutaneous G-Tube Placement
 ;;^UTILITY(U,$J,358.3,7971,0)
 ;;=44373^^43^404^2^^^^1
 ;;^UTILITY(U,$J,358.3,7971,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7971,1,2,0)
 ;;=2^44373
 ;;^UTILITY(U,$J,358.3,7971,1,3,0)
 ;;=3^Enteroscopy w/ Conversion of G-Tube to J-Tube
 ;;^UTILITY(U,$J,358.3,7972,0)
 ;;=44372^^43^404^3^^^^1
 ;;^UTILITY(U,$J,358.3,7972,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7972,1,2,0)
 ;;=2^44372
 ;;^UTILITY(U,$J,358.3,7972,1,3,0)
 ;;=3^Enteroscopy w/ Percutaneous J-Tube Placement
 ;;^UTILITY(U,$J,358.3,7973,0)
 ;;=43762^^43^404^4^^^^1
 ;;^UTILITY(U,$J,358.3,7973,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7973,1,2,0)
 ;;=2^43762
 ;;^UTILITY(U,$J,358.3,7973,1,3,0)
 ;;=3^G-Tube Change
 ;;^UTILITY(U,$J,358.3,7974,0)
 ;;=43763^^43^404^5^^^^1
 ;;^UTILITY(U,$J,358.3,7974,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7974,1,2,0)
 ;;=2^43763
 ;;^UTILITY(U,$J,358.3,7974,1,3,0)
 ;;=3^G-Tube Change Rev of Gastrostomy
 ;;^UTILITY(U,$J,358.3,7975,0)
 ;;=91111^^43^405^4^^^^1
 ;;^UTILITY(U,$J,358.3,7975,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7975,1,2,0)
 ;;=2^91111
 ;;^UTILITY(U,$J,358.3,7975,1,3,0)
 ;;=3^GI Tract Imaging,Intraluminal,Esophagus,Int & Rpt
 ;;^UTILITY(U,$J,358.3,7976,0)
 ;;=91110^^43^405^5^^^^1
 ;;^UTILITY(U,$J,358.3,7976,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7976,1,2,0)
 ;;=2^91110
 ;;^UTILITY(U,$J,358.3,7976,1,3,0)
 ;;=3^GI Tract Imaging,Intraluminal,Esophagus-Ileum,Int & Rpt
 ;;^UTILITY(U,$J,358.3,7977,0)
 ;;=91120^^43^405^9^^^^1
 ;;^UTILITY(U,$J,358.3,7977,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7977,1,2,0)
 ;;=2^91120
 ;;^UTILITY(U,$J,358.3,7977,1,3,0)
 ;;=3^Rectal Sensation Test
 ;;^UTILITY(U,$J,358.3,7978,0)
 ;;=91065^^43^405^8^^^^1
 ;;^UTILITY(U,$J,358.3,7978,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7978,1,2,0)
 ;;=2^91065
 ;;^UTILITY(U,$J,358.3,7978,1,3,0)
 ;;=3^Hydrogen Breath Test
 ;;^UTILITY(U,$J,358.3,7979,0)
 ;;=46600^^43^405^2^^^^1
 ;;^UTILITY(U,$J,358.3,7979,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7979,1,2,0)
 ;;=2^46600
 ;;^UTILITY(U,$J,358.3,7979,1,3,0)
 ;;=3^Anoscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,7980,0)
 ;;=44705^^43^405^3^^^^1
 ;;^UTILITY(U,$J,358.3,7980,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7980,1,2,0)
 ;;=2^44705
 ;;^UTILITY(U,$J,358.3,7980,1,3,0)
 ;;=3^Fecal Microbiota Transplantation
 ;;^UTILITY(U,$J,358.3,7981,0)
 ;;=87077^^43^405^1^^^^1
 ;;^UTILITY(U,$J,358.3,7981,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7981,1,2,0)
 ;;=2^87077
 ;;^UTILITY(U,$J,358.3,7981,1,3,0)
 ;;=3^Aerobic Isolate,Ea Isolate Test
 ;;^UTILITY(U,$J,358.3,7982,0)
 ;;=46221^^43^405^7^^^^1
 ;;^UTILITY(U,$J,358.3,7982,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7982,1,2,0)
 ;;=2^46221
 ;;^UTILITY(U,$J,358.3,7982,1,3,0)
 ;;=3^Hemorrhoidectomy by Rubber Band Ligation
 ;;^UTILITY(U,$J,358.3,7983,0)
 ;;=83013^^43^405^6^^^^1
 ;;^UTILITY(U,$J,358.3,7983,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7983,1,2,0)
 ;;=2^83013
 ;;^UTILITY(U,$J,358.3,7983,1,3,0)
 ;;=3^H Pylori Urea Breath Test
 ;;^UTILITY(U,$J,358.3,7984,0)
 ;;=96372^^43^405^10^^^^1
 ;;^UTILITY(U,$J,358.3,7984,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7984,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,7984,1,3,0)
 ;;=3^Subcutaneous or Intramuscular Injection
 ;;^UTILITY(U,$J,358.3,7985,0)
 ;;=90471^^43^406^1^^^^1
 ;;^UTILITY(U,$J,358.3,7985,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7985,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,7985,1,3,0)
 ;;=3^Immunization Admin,1 Vaccine
 ;;^UTILITY(U,$J,358.3,7986,0)
 ;;=90472^^43^406^2^^^^1
 ;;^UTILITY(U,$J,358.3,7986,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7986,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,7986,1,3,0)
 ;;=3^Immunization Admin,Ea Addl
 ;;^UTILITY(U,$J,358.3,7987,0)
 ;;=90632^^43^406^7^^^^1
 ;;^UTILITY(U,$J,358.3,7987,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7987,1,2,0)
 ;;=2^90632
 ;;^UTILITY(U,$J,358.3,7987,1,3,0)
 ;;=3^Hepatitis A Vaccine
 ;;^UTILITY(U,$J,358.3,7988,0)
 ;;=90746^^43^406^11^^^^1
 ;;^UTILITY(U,$J,358.3,7988,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7988,1,2,0)
 ;;=2^90746
 ;;^UTILITY(U,$J,358.3,7988,1,3,0)
 ;;=3^Hepatitis B Vaccine,3 Dose Schedule
 ;;^UTILITY(U,$J,358.3,7989,0)
 ;;=90747^^43^406^13^^^^1
 ;;^UTILITY(U,$J,358.3,7989,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7989,1,2,0)
 ;;=2^90747
 ;;^UTILITY(U,$J,358.3,7989,1,3,0)
 ;;=3^Hepatitis B Vaccine,Dialysis/Immunosupp,4 Dose
 ;;^UTILITY(U,$J,358.3,7990,0)
 ;;=90636^^43^406^6^^^^1
 ;;^UTILITY(U,$J,358.3,7990,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7990,1,2,0)
 ;;=2^90636
 ;;^UTILITY(U,$J,358.3,7990,1,3,0)
 ;;=3^Hepatitis A & B Combination Vaccine
 ;;^UTILITY(U,$J,358.3,7991,0)
 ;;=4155F^^43^406^8^^^^1
 ;;^UTILITY(U,$J,358.3,7991,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7991,1,2,0)
 ;;=2^4155F
 ;;^UTILITY(U,$J,358.3,7991,1,3,0)
 ;;=3^Hepatitis A Vaccine Previously Received
 ;;^UTILITY(U,$J,358.3,7992,0)
 ;;=G0010^^43^406^9^^^^1
 ;;^UTILITY(U,$J,358.3,7992,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7992,1,2,0)
 ;;=2^G0010
 ;;^UTILITY(U,$J,358.3,7992,1,3,0)
 ;;=3^Hepatitis B Vaccine,Admin
 ;;^UTILITY(U,$J,358.3,7993,0)
 ;;=90739^^43^406^10^^^^1
 ;;^UTILITY(U,$J,358.3,7993,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7993,1,2,0)
 ;;=2^90739
 ;;^UTILITY(U,$J,358.3,7993,1,3,0)
 ;;=3^Hepatitis B Vaccine,2 Dose Schedule
 ;;^UTILITY(U,$J,358.3,7994,0)
 ;;=90740^^43^406^12^^^^1
 ;;^UTILITY(U,$J,358.3,7994,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7994,1,2,0)
 ;;=2^90740
 ;;^UTILITY(U,$J,358.3,7994,1,3,0)
 ;;=3^Hepatitis B Vaccine,Dialysis/Immunosupp,3 Dose
 ;;^UTILITY(U,$J,358.3,7995,0)
 ;;=90688^^43^406^4^^^^1
 ;;^UTILITY(U,$J,358.3,7995,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7995,1,2,0)
 ;;=2^90688
 ;;^UTILITY(U,$J,358.3,7995,1,3,0)
 ;;=3^Fluzone Multi-Dose Quadrivalent 
 ;;^UTILITY(U,$J,358.3,7996,0)
 ;;=90662^^43^406^5^^^^1
 ;;^UTILITY(U,$J,358.3,7996,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7996,1,2,0)
 ;;=2^90662
 ;;^UTILITY(U,$J,358.3,7996,1,3,0)
 ;;=3^Fluzone Single Dose Quadrivalent
 ;;^UTILITY(U,$J,358.3,7997,0)
 ;;=90686^^43^406^3^^^^1
 ;;^UTILITY(U,$J,358.3,7997,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7997,1,2,0)
 ;;=2^90686
 ;;^UTILITY(U,$J,358.3,7997,1,3,0)
 ;;=3^Fluarix Single Dose
 ;;^UTILITY(U,$J,358.3,7998,0)
 ;;=91037^^43^407^5^^^^1
 ;;^UTILITY(U,$J,358.3,7998,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7998,1,2,0)
 ;;=2^91037
 ;;^UTILITY(U,$J,358.3,7998,1,3,0)
 ;;=3^Esoph Imped Funct Test < 1hr
 ;;^UTILITY(U,$J,358.3,7999,0)
 ;;=91038^^43^407^6^^^^1
 ;;^UTILITY(U,$J,358.3,7999,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7999,1,2,0)
 ;;=2^91038
 ;;^UTILITY(U,$J,358.3,7999,1,3,0)
 ;;=3^Esoph Imped Funct Test > 1hr
 ;;^UTILITY(U,$J,358.3,8000,0)
 ;;=91010^^43^407^7^^^^1
 ;;^UTILITY(U,$J,358.3,8000,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8000,1,2,0)
 ;;=2^91010
 ;;^UTILITY(U,$J,358.3,8000,1,3,0)
 ;;=3^Esophageal Manometry Study
 ;;^UTILITY(U,$J,358.3,8001,0)
 ;;=91034^^43^407^10^^^^1
 ;;^UTILITY(U,$J,358.3,8001,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8001,1,2,0)
 ;;=2^91034
 ;;^UTILITY(U,$J,358.3,8001,1,3,0)
 ;;=3^Nasal pH probe placement & pH Study
 ;;^UTILITY(U,$J,358.3,8002,0)
 ;;=91030^^43^407^1^^^^1
 ;;^UTILITY(U,$J,358.3,8002,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8002,1,2,0)
 ;;=2^91030
 ;;^UTILITY(U,$J,358.3,8002,1,3,0)
 ;;=3^Acid Perfusion of Esophagus
 ;;^UTILITY(U,$J,358.3,8003,0)
 ;;=91013^^43^407^8^^^^1
 ;;^UTILITY(U,$J,358.3,8003,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8003,1,2,0)
 ;;=2^91013
 ;;^UTILITY(U,$J,358.3,8003,1,3,0)
 ;;=3^Esophageal Motility w/ Stim/Perfusion
 ;;^UTILITY(U,$J,358.3,8004,0)
 ;;=91112^^43^407^9^^^^1
 ;;^UTILITY(U,$J,358.3,8004,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8004,1,2,0)
 ;;=2^91112
 ;;^UTILITY(U,$J,358.3,8004,1,3,0)
 ;;=3^GI Tract Pressure,pH,Temp & Transit Study
 ;;^UTILITY(U,$J,358.3,8005,0)
 ;;=91122^^43^407^2^^^^1
 ;;^UTILITY(U,$J,358.3,8005,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8005,1,2,0)
 ;;=2^91122
 ;;^UTILITY(U,$J,358.3,8005,1,3,0)
 ;;=3^Anorectal Manometry
 ;;^UTILITY(U,$J,358.3,8006,0)
 ;;=90912^^43^407^3^^^^1
 ;;^UTILITY(U,$J,358.3,8006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8006,1,2,0)
 ;;=2^90912
 ;;^UTILITY(U,$J,358.3,8006,1,3,0)
 ;;=3^Biofeedback Trng,1st 15 min
 ;;^UTILITY(U,$J,358.3,8007,0)
 ;;=90913^^43^407^4^^^^1
 ;;^UTILITY(U,$J,358.3,8007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8007,1,2,0)
 ;;=2^90913
 ;;^UTILITY(U,$J,358.3,8007,1,3,0)
 ;;=3^Biofeedback Trng,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,8008,0)
 ;;=45391^^43^408^2^^^^1
 ;;^UTILITY(U,$J,358.3,8008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8008,1,2,0)
 ;;=2^45391
 ;;^UTILITY(U,$J,358.3,8008,1,3,0)
 ;;=3^Colonoscopy w/ EUS
 ;;^UTILITY(U,$J,358.3,8009,0)
 ;;=45392^^43^408^3^^^^1
 ;;^UTILITY(U,$J,358.3,8009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8009,1,2,0)
 ;;=2^45392
 ;;^UTILITY(U,$J,358.3,8009,1,3,0)
 ;;=3^Colonoscopy w/ EUS & FNA
 ;;^UTILITY(U,$J,358.3,8010,0)
 ;;=43259^^43^408^4^^^^1
 ;;^UTILITY(U,$J,358.3,8010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8010,1,2,0)
 ;;=2^43259
 ;;^UTILITY(U,$J,358.3,8010,1,3,0)
 ;;=3^EGD w/ EUS
 ;;^UTILITY(U,$J,358.3,8011,0)
 ;;=43238^^43^408^1^^^^1
 ;;^UTILITY(U,$J,358.3,8011,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8011,1,2,0)
 ;;=2^43238
 ;;^UTILITY(U,$J,358.3,8011,1,3,0)
 ;;=3
 ;;^UTILITY(U,$J,358.3,8012,0)
 ;;=43238^^43^408^5^^^^1
 ;;^UTILITY(U,$J,358.3,8012,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8012,1,2,0)
 ;;=2^43238
 ;;^UTILITY(U,$J,358.3,8012,1,3,0)
 ;;=3^EGD w/ EUS & FNA
 ;;^UTILITY(U,$J,358.3,8013,0)
 ;;=43253^^43^408^7^^^^1
 ;;^UTILITY(U,$J,358.3,8013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8013,1,2,0)
 ;;=2^43253
 ;;^UTILITY(U,$J,358.3,8013,1,3,0)
 ;;=3^EGD w/ EUS & Therapeutic Injection
 ;;^UTILITY(U,$J,358.3,8014,0)
 ;;=43240^^43^408^6^^^^1
 ;;^UTILITY(U,$J,358.3,8014,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8014,1,2,0)
 ;;=2^43240
 ;;^UTILITY(U,$J,358.3,8014,1,3,0)
 ;;=3^EGD w/ EUS & Pseudocyst Drainage
 ;;^UTILITY(U,$J,358.3,8015,0)
 ;;=45341^^43^408^8^^^^1
 ;;^UTILITY(U,$J,358.3,8015,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8015,1,2,0)
 ;;=2^45341
 ;;^UTILITY(U,$J,358.3,8015,1,3,0)
 ;;=3^Flex Sig w/ EUS
 ;;^UTILITY(U,$J,358.3,8016,0)
 ;;=45342^^43^408^9^^^^1
 ;;^UTILITY(U,$J,358.3,8016,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8016,1,2,0)
 ;;=2^45342
 ;;^UTILITY(U,$J,358.3,8016,1,3,0)
 ;;=3^Flex Sig w/ EUS & FNA
 ;;^UTILITY(U,$J,358.3,8017,0)
 ;;=49083^^43^409^1^^^^1
 ;;^UTILITY(U,$J,358.3,8017,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8017,1,2,0)
 ;;=2^49083
 ;;^UTILITY(U,$J,358.3,8017,1,3,0)
 ;;=3^Abd Paracentesis w/ Imag Guide
 ;;^UTILITY(U,$J,358.3,8018,0)
 ;;=49082^^43^409^2^^^^1
 ;;^UTILITY(U,$J,358.3,8018,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8018,1,2,0)
 ;;=2^49082
 ;;^UTILITY(U,$J,358.3,8018,1,3,0)
 ;;=3^Abd Paracentesis w/o Imag Guide
 ;;^UTILITY(U,$J,358.3,8019,0)
 ;;=43460^^43^409^3^^^^1
 ;;^UTILITY(U,$J,358.3,8019,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8019,1,2,0)
 ;;=2^43460
 ;;^UTILITY(U,$J,358.3,8019,1,3,0)
 ;;=3^Esophagogastric Tamponade w/ Balloon
 ;;^UTILITY(U,$J,358.3,8020,0)
 ;;=47000^^43^409^4^^^^1
 ;;^UTILITY(U,$J,358.3,8020,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8020,1,2,0)
 ;;=2^47000
 ;;^UTILITY(U,$J,358.3,8020,1,3,0)
 ;;=3^Liver Biopsy,Percutaneous
 ;;^UTILITY(U,$J,358.3,8021,0)
 ;;=91200^^43^409^5^^^^1
 ;;^UTILITY(U,$J,358.3,8021,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8021,1,2,0)
 ;;=2^91200
 ;;^UTILITY(U,$J,358.3,8021,1,3,0)
 ;;=3^Transient Shear Wave Elastography
 ;;^UTILITY(U,$J,358.3,8022,0)
 ;;=99078^^43^409^6^^^^1
 ;;^UTILITY(U,$J,358.3,8022,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8022,1,2,0)
 ;;=2^99078
 ;;^UTILITY(U,$J,358.3,8022,1,3,0)
 ;;=3^Education Session,Group
 ;;^UTILITY(U,$J,358.3,8023,0)
 ;;=99152^^43^410^1^^^^1
 ;;^UTILITY(U,$J,358.3,8023,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8023,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,8023,1,3,0)
 ;;=3^Same Provider Performing Procedure,Init 15 min
 ;;^UTILITY(U,$J,358.3,8024,0)
 ;;=99153^^43^410^2^^^^1
 ;;^UTILITY(U,$J,358.3,8024,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8024,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,8024,1,3,0)
 ;;=3^Same Provider Performing Procedure,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,8025,0)
 ;;=99156^^43^410^3^^^^1
 ;;^UTILITY(U,$J,358.3,8025,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8025,1,2,0)
 ;;=2^99156
 ;;^UTILITY(U,$J,358.3,8025,1,3,0)
 ;;=3^Different Provider Performing Proc,Init 15 min
 ;;^UTILITY(U,$J,358.3,8026,0)
 ;;=99157^^43^410^4^^^^1
 ;;^UTILITY(U,$J,358.3,8026,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8026,1,2,0)
 ;;=2^99157
 ;;^UTILITY(U,$J,358.3,8026,1,3,0)
 ;;=3^Different Provider Performing Proc,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,8027,0)
 ;;=D9223^^43^410^6^^^^1
 ;;^UTILITY(U,$J,358.3,8027,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8027,1,2,0)
 ;;=2^D9223
 ;;^UTILITY(U,$J,358.3,8027,1,3,0)
 ;;=3^Deep Sedation/General Anes,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,8028,0)
 ;;=D9222^^43^410^5^^^^1
 ;;^UTILITY(U,$J,358.3,8028,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8028,1,2,0)
 ;;=2^D9222
 ;;^UTILITY(U,$J,358.3,8028,1,3,0)
 ;;=3^Deep Sedation/General Anes,1st 15 min
 ;;^UTILITY(U,$J,358.3,8029,0)
 ;;=45380^^43^411^1^^^^1
 ;;^UTILITY(U,$J,358.3,8029,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8029,1,2,0)
 ;;=2^45380
 ;;^UTILITY(U,$J,358.3,8029,1,3,0)
 ;;=3^Colonoscopy w/ Biopsy
 ;;^UTILITY(U,$J,358.3,8030,0)
 ;;=99152^^43^411^8^^^^1
 ;;^UTILITY(U,$J,358.3,8030,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8030,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,8030,1,3,0)
 ;;=3^Same Provider Performing Procedure,1st 15 min
 ;;^UTILITY(U,$J,358.3,8031,0)
 ;;=99153^^43^411^9^^^^1
 ;;^UTILITY(U,$J,358.3,8031,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8031,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,8031,1,3,0)
 ;;=3^Same Provider Performing Procedure,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,8032,0)
 ;;=J2250^^43^411^7^^^^1
 ;;^UTILITY(U,$J,358.3,8032,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8032,1,2,0)
 ;;=2^J2250
 ;;^UTILITY(U,$J,358.3,8032,1,3,0)
 ;;=3^Midazolam HCL,per 1mg
 ;;^UTILITY(U,$J,358.3,8032,3,0)
 ;;=^357.33^1^1
 ;;^UTILITY(U,$J,358.3,8032,3,1,0)
 ;;=JA
 ;;^UTILITY(U,$J,358.3,8033,0)
 ;;=J2175^^43^411^6^^^^1
 ;;^UTILITY(U,$J,358.3,8033,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8033,1,2,0)
 ;;=2^J2175
 ;;^UTILITY(U,$J,358.3,8033,1,3,0)
 ;;=3^Meperidine HCL,per 100mg
 ;;^UTILITY(U,$J,358.3,8033,3,0)
 ;;=^357.33^1^1
 ;;^UTILITY(U,$J,358.3,8033,3,1,0)
 ;;=JA
 ;;^UTILITY(U,$J,358.3,8034,0)
 ;;=43239^^43^411^4^^^^1
 ;;^UTILITY(U,$J,358.3,8034,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8034,1,2,0)
 ;;=2^43239
 ;;^UTILITY(U,$J,358.3,8034,1,3,0)
 ;;=3^EGD w/ Biopsy
 ;;^UTILITY(U,$J,358.3,8035,0)
 ;;=45378^^43^411^3^^^^1
 ;;^UTILITY(U,$J,358.3,8035,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8035,1,2,0)
 ;;=2^45378
 ;;^UTILITY(U,$J,358.3,8035,1,3,0)
 ;;=3^Colonoscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,8036,0)
 ;;=45385^^43^411^2^^^^1
 ;;^UTILITY(U,$J,358.3,8036,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8036,1,2,0)
 ;;=2^45385
 ;;^UTILITY(U,$J,358.3,8036,1,3,0)
 ;;=3^Colonoscopy w/ Snare
 ;;^UTILITY(U,$J,358.3,8037,0)
 ;;=J3010^^43^411^5^^^^1
 ;;^UTILITY(U,$J,358.3,8037,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8037,1,2,0)
 ;;=2^J3010
 ;;^UTILITY(U,$J,358.3,8037,1,3,0)
 ;;=3^Fentanyl Citrate,per 0.1mg
 ;;^UTILITY(U,$J,358.3,8038,0)
 ;;=99417^^43^412^1^^^^1
 ;;^UTILITY(U,$J,358.3,8038,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8038,1,2,0)
 ;;=2^99417
 ;;^UTILITY(U,$J,358.3,8038,1,3,0)
 ;;=3^Prolonged Svc,Ea 15min;Only w/ 99205 or 99215
 ;;^UTILITY(U,$J,358.3,8039,0)
 ;;=44380^^43^413^2^^^^1
 ;;^UTILITY(U,$J,358.3,8039,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8039,1,2,0)
 ;;=2^44380
 ;;^UTILITY(U,$J,358.3,8039,1,3,0)
 ;;=3^Ileoscopy via Stoma,Diagnostic
 ;;^UTILITY(U,$J,358.3,8040,0)
 ;;=44382^^43^413^1^^^^1
 ;;^UTILITY(U,$J,358.3,8040,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8040,1,2,0)
 ;;=2^44382
 ;;^UTILITY(U,$J,358.3,8040,1,3,0)
 ;;=3^Ileoscopy via Stoma w/ Transendo Balloon Dilation
 ;;^UTILITY(U,$J,358.3,8041,0)
 ;;=99341^^44^414^1
 ;;^UTILITY(U,$J,358.3,8041,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,8041,1,1,0)
 ;;=1^PROBLEM FOCUSED VISIT
 ;;^UTILITY(U,$J,358.3,8041,1,2,0)
 ;;=2^99341
 ;;^UTILITY(U,$J,358.3,8042,0)
 ;;=99342^^44^414^2
 ;;^UTILITY(U,$J,358.3,8042,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,8042,1,1,0)
 ;;=1^EXP PROBLEM FOCUSED VISIT
 ;;^UTILITY(U,$J,358.3,8042,1,2,0)
 ;;=2^99342
 ;;^UTILITY(U,$J,358.3,8043,0)
 ;;=99343^^44^414^3
 ;;^UTILITY(U,$J,358.3,8043,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,8043,1,1,0)
 ;;=1^DETAILED VISIT
 ;;^UTILITY(U,$J,358.3,8043,1,2,0)
 ;;=2^99343
 ;;^UTILITY(U,$J,358.3,8044,0)
 ;;=99344^^44^414^4
 ;;^UTILITY(U,$J,358.3,8044,1,0)
 ;;=^358.31IA^2^2
