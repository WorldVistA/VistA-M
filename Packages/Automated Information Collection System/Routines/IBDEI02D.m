IBDEI02D ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5378,1,2,0)
 ;;=2^29125
 ;;^UTILITY(U,$J,358.3,5378,1,3,0)
 ;;=3^Apply Forearm Splint;Static
 ;;^UTILITY(U,$J,358.3,5379,0)
 ;;=29515^^36^323^5^^^^1
 ;;^UTILITY(U,$J,358.3,5379,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5379,1,2,0)
 ;;=2^29515
 ;;^UTILITY(U,$J,358.3,5379,1,3,0)
 ;;=3^Apply Lower Leg Splint
 ;;^UTILITY(U,$J,358.3,5380,0)
 ;;=29505^^36^323^4^^^^1
 ;;^UTILITY(U,$J,358.3,5380,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5380,1,2,0)
 ;;=2^29505
 ;;^UTILITY(U,$J,358.3,5380,1,3,0)
 ;;=3^Apply Long Leg Splint
 ;;^UTILITY(U,$J,358.3,5381,0)
 ;;=26600^^36^323^20^^^^1
 ;;^UTILITY(U,$J,358.3,5381,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5381,1,2,0)
 ;;=2^26600
 ;;^UTILITY(U,$J,358.3,5381,1,3,0)
 ;;=3^Metacarpal Fx,Closed Txmt w/o Manip,Ea Bone
 ;;^UTILITY(U,$J,358.3,5382,0)
 ;;=26605^^36^323^19^^^^1
 ;;^UTILITY(U,$J,358.3,5382,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5382,1,2,0)
 ;;=2^26605
 ;;^UTILITY(U,$J,358.3,5382,1,3,0)
 ;;=3^Metacarpal Fx,Closed Txmt w/ Manip,Ea Bone
 ;;^UTILITY(U,$J,358.3,5383,0)
 ;;=27250^^36^323^16^^^^1
 ;;^UTILITY(U,$J,358.3,5383,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5383,1,2,0)
 ;;=2^27250
 ;;^UTILITY(U,$J,358.3,5383,1,3,0)
 ;;=3^Closed Tx Hip Dislocation,Traumatic w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,5384,0)
 ;;=27265^^36^323^18^^^^1
 ;;^UTILITY(U,$J,358.3,5384,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5384,1,2,0)
 ;;=2^27265
 ;;^UTILITY(U,$J,358.3,5384,1,3,0)
 ;;=3^Closed Tx Post-Hip Arthroplasty w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,5385,0)
 ;;=27562^^36^323^17^^^^1
 ;;^UTILITY(U,$J,358.3,5385,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5385,1,2,0)
 ;;=2^27562
 ;;^UTILITY(U,$J,358.3,5385,1,3,0)
 ;;=3^Closed Tx Patella Dislocation w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,5386,0)
 ;;=27840^^36^323^13^^^^1
 ;;^UTILITY(U,$J,358.3,5386,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5386,1,2,0)
 ;;=2^27840
 ;;^UTILITY(U,$J,358.3,5386,1,3,0)
 ;;=3^Closed Tx Ankle Dislocation w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,5387,0)
 ;;=24600^^36^323^15^^^^1
 ;;^UTILITY(U,$J,358.3,5387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5387,1,2,0)
 ;;=2^24600
 ;;^UTILITY(U,$J,358.3,5387,1,3,0)
 ;;=3^Closed Tx Elbow Dislocation w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,5388,0)
 ;;=25605^^36^323^14^^^^1
 ;;^UTILITY(U,$J,358.3,5388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5388,1,2,0)
 ;;=2^25605
 ;;^UTILITY(U,$J,358.3,5388,1,3,0)
 ;;=3^Closed Tx Distal Radial Fx w/ Manipulation
 ;;^UTILITY(U,$J,358.3,5389,0)
 ;;=D7820^^36^323^12^^^^1
 ;;^UTILITY(U,$J,358.3,5389,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5389,1,2,0)
 ;;=2^D7820
 ;;^UTILITY(U,$J,358.3,5389,1,3,0)
 ;;=3^Closed Reduction of TMJ Dislocation
 ;;^UTILITY(U,$J,358.3,5390,0)
 ;;=J3535^^36^324^7^^^^1
 ;;^UTILITY(U,$J,358.3,5390,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5390,1,2,0)
 ;;=2^J3535
 ;;^UTILITY(U,$J,358.3,5390,1,3,0)
 ;;=3^Drug Admin Thru Metered Dose Inhaler
 ;;^UTILITY(U,$J,358.3,5391,0)
 ;;=J7608^^36^324^1^^^^1
 ;;^UTILITY(U,$J,358.3,5391,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5391,1,2,0)
 ;;=2^J7608
 ;;^UTILITY(U,$J,358.3,5391,1,3,0)
 ;;=3^Acetylcysteine,Inhale,Non-Compd,Unit Dose
 ;;^UTILITY(U,$J,358.3,5392,0)
 ;;=J7609^^36^324^4^^^^1
 ;;^UTILITY(U,$J,358.3,5392,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5392,1,2,0)
 ;;=2^J7609
 ;;^UTILITY(U,$J,358.3,5392,1,3,0)
 ;;=3^Albuterol,Inhale,Compd,Unit Dose 1mg
 ;;^UTILITY(U,$J,358.3,5393,0)
 ;;=J7610^^36^324^3^^^^1
 ;;^UTILITY(U,$J,358.3,5393,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5393,1,2,0)
 ;;=2^J7610
 ;;^UTILITY(U,$J,358.3,5393,1,3,0)
 ;;=3^Albuterol,Inhale,Compd,Concentrate Frm 1mg
 ;;^UTILITY(U,$J,358.3,5394,0)
 ;;=J7613^^36^324^6^^^^1
 ;;^UTILITY(U,$J,358.3,5394,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5394,1,2,0)
 ;;=2^J7613
 ;;^UTILITY(U,$J,358.3,5394,1,3,0)
 ;;=3^Albuterol,Inhale,Non-Compd,Unit Dose 1mg
 ;;^UTILITY(U,$J,358.3,5395,0)
 ;;=J7611^^36^324^5^^^^1
 ;;^UTILITY(U,$J,358.3,5395,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5395,1,2,0)
 ;;=2^J7611
 ;;^UTILITY(U,$J,358.3,5395,1,3,0)
 ;;=3^Albuterol,Inhale,Non-Compd,Concentrate Frm 1mg
 ;;^UTILITY(U,$J,358.3,5396,0)
 ;;=J7644^^36^324^8^^^^1
 ;;^UTILITY(U,$J,358.3,5396,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5396,1,2,0)
 ;;=2^J7644
 ;;^UTILITY(U,$J,358.3,5396,1,3,0)
 ;;=3^Ipratropium Bromide Inhale,Non-Compd,Unit per mg
 ;;^UTILITY(U,$J,358.3,5397,0)
 ;;=J7620^^36^324^2^^^^1
 ;;^UTILITY(U,$J,358.3,5397,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5397,1,2,0)
 ;;=2^J7620
 ;;^UTILITY(U,$J,358.3,5397,1,3,0)
 ;;=3^Albuterol 2.5mg/Ipratropium Bromide 0.5mg Non-Comp
 ;;^UTILITY(U,$J,358.3,5398,0)
 ;;=36556^^36^325^5^^^^1
 ;;^UTILITY(U,$J,358.3,5398,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5398,1,2,0)
 ;;=2^36556
 ;;^UTILITY(U,$J,358.3,5398,1,3,0)
 ;;=3^Central Venous Line
 ;;^UTILITY(U,$J,358.3,5399,0)
 ;;=36600^^36^325^3^^^^1
 ;;^UTILITY(U,$J,358.3,5399,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5399,1,2,0)
 ;;=2^36600
 ;;^UTILITY(U,$J,358.3,5399,1,3,0)
 ;;=3^Arterial Puncture (ABG)
 ;;^UTILITY(U,$J,358.3,5400,0)
 ;;=36680^^36^325^4^^^^1
 ;;^UTILITY(U,$J,358.3,5400,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5400,1,2,0)
 ;;=2^36680
 ;;^UTILITY(U,$J,358.3,5400,1,3,0)
 ;;=3^Intraosseous Line Placement
 ;;^UTILITY(U,$J,358.3,5401,0)
 ;;=37195^^36^325^16^^^^1
 ;;^UTILITY(U,$J,358.3,5401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5401,1,2,0)
 ;;=2^37195
 ;;^UTILITY(U,$J,358.3,5401,1,3,0)
 ;;=3^Thrombolysis Cerebral,IV Infusion
 ;;^UTILITY(U,$J,358.3,5402,0)
 ;;=92953^^36^325^10^^^^1
 ;;^UTILITY(U,$J,358.3,5402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5402,1,2,0)
 ;;=2^92953
 ;;^UTILITY(U,$J,358.3,5402,1,3,0)
 ;;=3^Pacing,Transcutaneous
 ;;^UTILITY(U,$J,358.3,5403,0)
 ;;=92960^^36^325^9^^^^1
 ;;^UTILITY(U,$J,358.3,5403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5403,1,2,0)
 ;;=2^92960
 ;;^UTILITY(U,$J,358.3,5403,1,3,0)
 ;;=3^Defibrillation for Cardioversion,External (NOT in CPR)
 ;;^UTILITY(U,$J,358.3,5404,0)
 ;;=92977^^36^325^15^^^^1
 ;;^UTILITY(U,$J,358.3,5404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5404,1,2,0)
 ;;=2^92977
 ;;^UTILITY(U,$J,358.3,5404,1,3,0)
 ;;=3^Thrombolysis Coronary,IV Infusion
 ;;^UTILITY(U,$J,358.3,5405,0)
 ;;=36430^^36^325^19^^^^1
 ;;^UTILITY(U,$J,358.3,5405,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5405,1,2,0)
 ;;=2^36430
 ;;^UTILITY(U,$J,358.3,5405,1,3,0)
 ;;=3^Transfusion,Blood/Blood Components
 ;;^UTILITY(U,$J,358.3,5406,0)
 ;;=31500^^36^325^6^^^^1
 ;;^UTILITY(U,$J,358.3,5406,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5406,1,2,0)
 ;;=2^31500
 ;;^UTILITY(U,$J,358.3,5406,1,3,0)
 ;;=3^Enodotracheal Intubation
 ;;^UTILITY(U,$J,358.3,5407,0)
 ;;=31505^^36^325^7^^^^1
 ;;^UTILITY(U,$J,358.3,5407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5407,1,2,0)
 ;;=2^31505
 ;;^UTILITY(U,$J,358.3,5407,1,3,0)
 ;;=3^Indirect Laryngoscopy
 ;;^UTILITY(U,$J,358.3,5408,0)
 ;;=92950^^36^325^8^^^^1
 ;;^UTILITY(U,$J,358.3,5408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5408,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,5408,1,3,0)
 ;;=3^CPR Resuscitation
 ;;^UTILITY(U,$J,358.3,5409,0)
 ;;=32554^^36^325^11^^^^1
 ;;^UTILITY(U,$J,358.3,5409,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5409,1,2,0)
 ;;=2^32554
 ;;^UTILITY(U,$J,358.3,5409,1,3,0)
 ;;=3^Thoracentesis w/o Imaging Guidance
 ;;^UTILITY(U,$J,358.3,5410,0)
 ;;=32555^^36^325^12^^^^1
 ;;^UTILITY(U,$J,358.3,5410,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5410,1,2,0)
 ;;=2^32555
 ;;^UTILITY(U,$J,358.3,5410,1,3,0)
 ;;=3^Thoracentesis w/ Imaging Guidance
 ;;^UTILITY(U,$J,358.3,5411,0)
 ;;=31605^^36^325^13^^^^1
 ;;^UTILITY(U,$J,358.3,5411,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5411,1,2,0)
 ;;=2^31605
 ;;^UTILITY(U,$J,358.3,5411,1,3,0)
 ;;=3^Trachestomy,Emergent,Cricothyroid
 ;;^UTILITY(U,$J,358.3,5412,0)
 ;;=32551^^36^325^14^^^^1
 ;;^UTILITY(U,$J,358.3,5412,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5412,1,2,0)
 ;;=2^32551
 ;;^UTILITY(U,$J,358.3,5412,1,3,0)
 ;;=3^Chest Tube Insertion
 ;;^UTILITY(U,$J,358.3,5413,0)
 ;;=99152^^36^325^17^^^^1
 ;;^UTILITY(U,$J,358.3,5413,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5413,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,5413,1,3,0)
 ;;=3^Moderate Sedation,1st 15 min
 ;;^UTILITY(U,$J,358.3,5414,0)
 ;;=99153^^36^325^18^^^^1
 ;;^UTILITY(U,$J,358.3,5414,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5414,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,5414,1,3,0)
 ;;=3^Moderate Sedation,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,5415,0)
 ;;=99292^^36^325^2^^^^1
 ;;^UTILITY(U,$J,358.3,5415,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5415,1,2,0)
 ;;=2^99292
 ;;^UTILITY(U,$J,358.3,5415,1,3,0)
 ;;=3^Critical Care,Ea Addl 30 Min
 ;;^UTILITY(U,$J,358.3,5416,0)
 ;;=43753^^36^326^7^^^^1
 ;;^UTILITY(U,$J,358.3,5416,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5416,1,2,0)
 ;;=2^43753
 ;;^UTILITY(U,$J,358.3,5416,1,3,0)
 ;;=3^Gastric Lavage
 ;;^UTILITY(U,$J,358.3,5417,0)
 ;;=45915^^36^326^4^^^^1
 ;;^UTILITY(U,$J,358.3,5417,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5417,1,2,0)
 ;;=2^45915
 ;;^UTILITY(U,$J,358.3,5417,1,3,0)
 ;;=3^Fecal Impaction Removal or FB
 ;;^UTILITY(U,$J,358.3,5418,0)
 ;;=46050^^36^326^9^^^^1
 ;;^UTILITY(U,$J,358.3,5418,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5418,1,2,0)
 ;;=2^46050
 ;;^UTILITY(U,$J,358.3,5418,1,3,0)
 ;;=3^Perianal Abscess I&D
 ;;^UTILITY(U,$J,358.3,5419,0)
 ;;=46320^^36^326^8^^^^1
 ;;^UTILITY(U,$J,358.3,5419,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5419,1,2,0)
 ;;=2^46320
 ;;^UTILITY(U,$J,358.3,5419,1,3,0)
 ;;=3^Hemorrhoid Excision,Thrombosed,External
 ;;^UTILITY(U,$J,358.3,5420,0)
 ;;=49082^^36^326^2^^^^1
 ;;^UTILITY(U,$J,358.3,5420,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5420,1,2,0)
 ;;=2^49082
 ;;^UTILITY(U,$J,358.3,5420,1,3,0)
 ;;=3^Abdominal Paracentesis w/o Imaging
 ;;^UTILITY(U,$J,358.3,5421,0)
 ;;=49083^^36^326^1^^^^1
 ;;^UTILITY(U,$J,358.3,5421,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5421,1,2,0)
 ;;=2^49083
 ;;^UTILITY(U,$J,358.3,5421,1,3,0)
 ;;=3^Abdominal Paracentesis w/ Imaging
 ;;^UTILITY(U,$J,358.3,5422,0)
 ;;=56420^^36^326^3^^^^1
 ;;^UTILITY(U,$J,358.3,5422,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5422,1,2,0)
 ;;=2^56420
 ;;^UTILITY(U,$J,358.3,5422,1,3,0)
 ;;=3^Bartholin's Cyst I&D
 ;;^UTILITY(U,$J,358.3,5423,0)
 ;;=56405^^36^326^11^^^^1
 ;;^UTILITY(U,$J,358.3,5423,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5423,1,2,0)
 ;;=2^56405
 ;;^UTILITY(U,$J,358.3,5423,1,3,0)
 ;;=3^Vulva/Perineum Abscess I&D
 ;;^UTILITY(U,$J,358.3,5424,0)
 ;;=58301^^36^326^10^^^^1
 ;;^UTILITY(U,$J,358.3,5424,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5424,1,2,0)
 ;;=2^58301
 ;;^UTILITY(U,$J,358.3,5424,1,3,0)
 ;;=3^Removal IUD
 ;;^UTILITY(U,$J,358.3,5425,0)
 ;;=43762^^36^326^6^^^^1
 ;;^UTILITY(U,$J,358.3,5425,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5425,1,2,0)
 ;;=2^43762
 ;;^UTILITY(U,$J,358.3,5425,1,3,0)
 ;;=3^GTube Change Bedside (Simple)
 ;;^UTILITY(U,$J,358.3,5426,0)
 ;;=43763^^36^326^5^^^^1
 ;;^UTILITY(U,$J,358.3,5426,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5426,1,2,0)
 ;;=2^43763
 ;;^UTILITY(U,$J,358.3,5426,1,3,0)
 ;;=3^GTube Change Bedside (Complicated)
 ;;^UTILITY(U,$J,358.3,5427,0)
 ;;=69200^^36^327^3^^^^1
 ;;^UTILITY(U,$J,358.3,5427,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5427,1,2,0)
 ;;=2^69200
 ;;^UTILITY(U,$J,358.3,5427,1,3,0)
 ;;=3^Remove FB,External Ear Canal
 ;;^UTILITY(U,$J,358.3,5428,0)
 ;;=69209^^36^327^4^^^^1
 ;;^UTILITY(U,$J,358.3,5428,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5428,1,2,0)
 ;;=2^69209
 ;;^UTILITY(U,$J,358.3,5428,1,3,0)
 ;;=3^Remove Impacted Ear Wax w/ Lavage,Unilat
 ;;^UTILITY(U,$J,358.3,5429,0)
 ;;=62270^^36^327^1^^^^1
 ;;^UTILITY(U,$J,358.3,5429,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5429,1,2,0)
 ;;=2^62270
 ;;^UTILITY(U,$J,358.3,5429,1,3,0)
 ;;=3^Lumbar Puncture
 ;;^UTILITY(U,$J,358.3,5430,0)
 ;;=64450^^36^327^2^^^^1
 ;;^UTILITY(U,$J,358.3,5430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5430,1,2,0)
 ;;=2^64450
 ;;^UTILITY(U,$J,358.3,5430,1,3,0)
 ;;=3^Peripheral Nerve Block
 ;;^UTILITY(U,$J,358.3,5431,0)
 ;;=31505^^36^327^5^^^^1
 ;;^UTILITY(U,$J,358.3,5431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5431,1,2,0)
 ;;=2^31505
 ;;^UTILITY(U,$J,358.3,5431,1,3,0)
 ;;=3^Indirect Laryngoscopy
 ;;^UTILITY(U,$J,358.3,5432,0)
 ;;=42809^^36^327^6^^^^1
 ;;^UTILITY(U,$J,358.3,5432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5432,1,2,0)
 ;;=2^42809
 ;;^UTILITY(U,$J,358.3,5432,1,3,0)
 ;;=3^Remove FB,Pharynx
 ;;^UTILITY(U,$J,358.3,5433,0)
 ;;=30901^^36^327^7^^^^1
 ;;^UTILITY(U,$J,358.3,5433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5433,1,2,0)
 ;;=2^30901
 ;;^UTILITY(U,$J,358.3,5433,1,3,0)
 ;;=3^Control Nosebleed,Ant Simple (Packing)
 ;;^UTILITY(U,$J,358.3,5434,0)
 ;;=30905^^36^327^8^^^^1
 ;;^UTILITY(U,$J,358.3,5434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5434,1,2,0)
 ;;=2^30905
 ;;^UTILITY(U,$J,358.3,5434,1,3,0)
 ;;=3^Control Nosebleed,Post,Init
 ;;^UTILITY(U,$J,358.3,5435,0)
 ;;=65220^^36^327^9^^^^1
 ;;^UTILITY(U,$J,358.3,5435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5435,1,2,0)
 ;;=2^65220
 ;;^UTILITY(U,$J,358.3,5435,1,3,0)
 ;;=3^Remove FB,Cornea w/o Slit Lamp
 ;;^UTILITY(U,$J,358.3,5436,0)
 ;;=65222^^36^327^10^^^^1
 ;;^UTILITY(U,$J,358.3,5436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5436,1,2,0)
 ;;=2^65222
 ;;^UTILITY(U,$J,358.3,5436,1,3,0)
 ;;=3^Remove FB,Cornea w/ Slit Lamp
 ;;^UTILITY(U,$J,358.3,5437,0)
 ;;=65205^^36^327^11^^^^1
 ;;^UTILITY(U,$J,358.3,5437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5437,1,2,0)
 ;;=2^65205
 ;;^UTILITY(U,$J,358.3,5437,1,3,0)
 ;;=3^Remove FB,External Eye/Conjuctiva
 ;;^UTILITY(U,$J,358.3,5438,0)
 ;;=65210^^36^327^12^^^^1
 ;;^UTILITY(U,$J,358.3,5438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5438,1,2,0)
 ;;=2^65210
 ;;^UTILITY(U,$J,358.3,5438,1,3,0)
 ;;=3^Remove FB,External Eye/Conjuctivl-Embedded
 ;;^UTILITY(U,$J,358.3,5439,0)
 ;;=12051^^36^328^14^^^^1
 ;;^UTILITY(U,$J,358.3,5439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5439,1,2,0)
 ;;=2^12051
 ;;^UTILITY(U,$J,358.3,5439,1,3,0)
 ;;=3^Intermd < 2.5cm Face/Ears/Eyelids/Mucous Membranes
 ;;^UTILITY(U,$J,358.3,5440,0)
 ;;=12052^^36^328^15^^^^1
 ;;^UTILITY(U,$J,358.3,5440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5440,1,2,0)
 ;;=2^12052
 ;;^UTILITY(U,$J,358.3,5440,1,3,0)
 ;;=3^Intermd 2.6-5.0cm Face/Ears/Eyelids/Mucous Membranes
 ;;^UTILITY(U,$J,358.3,5441,0)
 ;;=12053^^36^328^16^^^^1
 ;;^UTILITY(U,$J,358.3,5441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5441,1,2,0)
 ;;=2^12053
 ;;^UTILITY(U,$J,358.3,5441,1,3,0)
 ;;=3^Intermd 5.1-7.5cm Face/Ears/Eyelids/Mucous Membranes
 ;;^UTILITY(U,$J,358.3,5442,0)
 ;;=64450^^36^328^1^^^^1
 ;;^UTILITY(U,$J,358.3,5442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5442,1,2,0)
 ;;=2^64450
 ;;^UTILITY(U,$J,358.3,5442,1,3,0)
 ;;=3^Peripheral Nerve Block
 ;;^UTILITY(U,$J,358.3,5443,0)
 ;;=12001^^36^328^2^^^^1
 ;;^UTILITY(U,$J,358.3,5443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5443,1,2,0)
 ;;=2^12001
 ;;^UTILITY(U,$J,358.3,5443,1,3,0)
 ;;=3^Simp < 2.5cm Extrem/Scalp/Trnk/Neck/Ext Genit
 ;;^UTILITY(U,$J,358.3,5444,0)
 ;;=12002^^36^328^3^^^^1
 ;;^UTILITY(U,$J,358.3,5444,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5444,1,2,0)
 ;;=2^12002
 ;;^UTILITY(U,$J,358.3,5444,1,3,0)
 ;;=3^Simp 2.6-7.5cm Extrem/Scalp/Trnk/Neck/Ext Genit
 ;;^UTILITY(U,$J,358.3,5445,0)
 ;;=12004^^36^328^4^^^^1
 ;;^UTILITY(U,$J,358.3,5445,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5445,1,2,0)
 ;;=2^12004
 ;;^UTILITY(U,$J,358.3,5445,1,3,0)
 ;;=3^Simp 7.6-12.5cm Extrem/Scalp/Trnk/Neck/Ext Genit
 ;;^UTILITY(U,$J,358.3,5446,0)
 ;;=12011^^36^328^5^^^^1
 ;;^UTILITY(U,$J,358.3,5446,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5446,1,2,0)
 ;;=2^12011
 ;;^UTILITY(U,$J,358.3,5446,1,3,0)
 ;;=3^Simp < 2.5cm Face/Ears/Eyelids/Lips/Muc Memb
 ;;^UTILITY(U,$J,358.3,5447,0)
 ;;=12013^^36^328^6^^^^1
 ;;^UTILITY(U,$J,358.3,5447,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5447,1,2,0)
 ;;=2^12013
 ;;^UTILITY(U,$J,358.3,5447,1,3,0)
 ;;=3^Simp 2.6-5.1cm Face/Ears/Eyelids/Lips/Muc Memb
 ;;^UTILITY(U,$J,358.3,5448,0)
 ;;=12014^^36^328^7^^^^1
 ;;^UTILITY(U,$J,358.3,5448,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5448,1,2,0)
 ;;=2^12014
 ;;^UTILITY(U,$J,358.3,5448,1,3,0)
 ;;=3^Simp 5.1-7.5cm Face/Ears/Eyelids/Lips/Muc Memb
 ;;^UTILITY(U,$J,358.3,5449,0)
 ;;=12041^^36^328^8^^^^1
 ;;^UTILITY(U,$J,358.3,5449,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5449,1,2,0)
 ;;=2^12041
 ;;^UTILITY(U,$J,358.3,5449,1,3,0)
 ;;=3^Intermd < 2.5cm Hands/Feet/Neck/Ext Genit
 ;;^UTILITY(U,$J,358.3,5450,0)
 ;;=12042^^36^328^9^^^^1
 ;;^UTILITY(U,$J,358.3,5450,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5450,1,2,0)
 ;;=2^12042
 ;;^UTILITY(U,$J,358.3,5450,1,3,0)
 ;;=3^Intermd 2.6-7.5cm Hands/Feet/Neck/Ext Genit
 ;;^UTILITY(U,$J,358.3,5451,0)
 ;;=12044^^36^328^10^^^^1
 ;;^UTILITY(U,$J,358.3,5451,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5451,1,2,0)
 ;;=2^12044
 ;;^UTILITY(U,$J,358.3,5451,1,3,0)
 ;;=3^Intermd 7.6-12.5cm Hands/Feet/Neck/Ext Genit
 ;;^UTILITY(U,$J,358.3,5452,0)
 ;;=12031^^36^328^11^^^^1
 ;;^UTILITY(U,$J,358.3,5452,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5452,1,2,0)
 ;;=2^12031
 ;;^UTILITY(U,$J,358.3,5452,1,3,0)
 ;;=3^Intermd < 2.5cm Extrem/Scalp/Trunk
 ;;^UTILITY(U,$J,358.3,5453,0)
 ;;=12032^^36^328^12^^^^1
 ;;^UTILITY(U,$J,358.3,5453,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5453,1,2,0)
 ;;=2^12032
 ;;^UTILITY(U,$J,358.3,5453,1,3,0)
 ;;=3^Intermd 2.6-7.5cm Extrem/Scalp/Trunk
 ;;^UTILITY(U,$J,358.3,5454,0)
 ;;=12034^^36^328^13^^^^1
 ;;^UTILITY(U,$J,358.3,5454,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5454,1,2,0)
 ;;=2^12034
 ;;^UTILITY(U,$J,358.3,5454,1,3,0)
 ;;=3^Intermd 7.6-12.5cm Extrem/Scalp/Trunk
 ;;^UTILITY(U,$J,358.3,5455,0)
 ;;=16000^^36^329^12^^^^1
 ;;^UTILITY(U,$J,358.3,5455,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5455,1,2,0)
 ;;=2^16000
 ;;^UTILITY(U,$J,358.3,5455,1,3,0)
 ;;=3^1st Degree Burn Treatment
 ;;^UTILITY(U,$J,358.3,5456,0)
 ;;=16020^^36^329^13^^^^1
 ;;^UTILITY(U,$J,358.3,5456,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5456,1,2,0)
 ;;=2^16020
 ;;^UTILITY(U,$J,358.3,5456,1,3,0)
 ;;=3^Partial Thickness Dress/Debride < 5%
 ;;^UTILITY(U,$J,358.3,5457,0)
 ;;=16025^^36^329^14^^^^1
 ;;^UTILITY(U,$J,358.3,5457,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5457,1,2,0)
 ;;=2^16025
 ;;^UTILITY(U,$J,358.3,5457,1,3,0)
 ;;=3^Partial Thickness Dress/Debride 5-10%
 ;;^UTILITY(U,$J,358.3,5458,0)
 ;;=16030^^36^329^15^^^^1
 ;;^UTILITY(U,$J,358.3,5458,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5458,1,2,0)
 ;;=2^16030
 ;;^UTILITY(U,$J,358.3,5458,1,3,0)
 ;;=3^Partial Thickness Dress/Debride > 10%
 ;;^UTILITY(U,$J,358.3,5459,0)
 ;;=64450^^36^329^1^^^^1
 ;;^UTILITY(U,$J,358.3,5459,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5459,1,2,0)
 ;;=2^64450
 ;;^UTILITY(U,$J,358.3,5459,1,3,0)
 ;;=3^Peripheral Nerve Block
 ;;^UTILITY(U,$J,358.3,5460,0)
 ;;=97602^^36^329^2^^^^1
