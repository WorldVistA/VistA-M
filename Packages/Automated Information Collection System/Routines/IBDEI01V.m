IBDEI01V ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4149,1,3,0)
 ;;=3^Medroxyprogesterone Acetate 1mg
 ;;^UTILITY(U,$J,358.3,4150,0)
 ;;=J2175^^30^244^31^^^^1
 ;;^UTILITY(U,$J,358.3,4150,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4150,1,2,0)
 ;;=2^J2175
 ;;^UTILITY(U,$J,358.3,4150,1,3,0)
 ;;=3^Meperdine HCL 100mg
 ;;^UTILITY(U,$J,358.3,4151,0)
 ;;=J7169^^30^244^12^^^^1
 ;;^UTILITY(U,$J,358.3,4151,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4151,1,2,0)
 ;;=2^J7169
 ;;^UTILITY(U,$J,358.3,4151,1,3,0)
 ;;=3^Coagulation Factor Xa 10mg
 ;;^UTILITY(U,$J,358.3,4152,0)
 ;;=29580^^30^245^27^^^^1
 ;;^UTILITY(U,$J,358.3,4152,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4152,1,2,0)
 ;;=2^29580
 ;;^UTILITY(U,$J,358.3,4152,1,3,0)
 ;;=3^Unna Boot Compression Dressing for Venous Stasis
 ;;^UTILITY(U,$J,358.3,4153,0)
 ;;=29700^^30^245^11^^^^1
 ;;^UTILITY(U,$J,358.3,4153,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4153,1,2,0)
 ;;=2^29700
 ;;^UTILITY(U,$J,358.3,4153,1,3,0)
 ;;=3^Cast Removal,Short
 ;;^UTILITY(U,$J,358.3,4154,0)
 ;;=29705^^30^245^10^^^^1
 ;;^UTILITY(U,$J,358.3,4154,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4154,1,2,0)
 ;;=2^29705
 ;;^UTILITY(U,$J,358.3,4154,1,3,0)
 ;;=3^Cast Removal,Long
 ;;^UTILITY(U,$J,358.3,4155,0)
 ;;=29540^^30^245^22^^^^1
 ;;^UTILITY(U,$J,358.3,4155,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4155,1,2,0)
 ;;=2^29540
 ;;^UTILITY(U,$J,358.3,4155,1,3,0)
 ;;=3^Strapping;Ankle/Foot
 ;;^UTILITY(U,$J,358.3,4156,0)
 ;;=29260^^30^245^23^^^^1
 ;;^UTILITY(U,$J,358.3,4156,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4156,1,2,0)
 ;;=2^29260
 ;;^UTILITY(U,$J,358.3,4156,1,3,0)
 ;;=3^Strapping;Elbow/Wrist
 ;;^UTILITY(U,$J,358.3,4157,0)
 ;;=29280^^30^245^24^^^^1
 ;;^UTILITY(U,$J,358.3,4157,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4157,1,2,0)
 ;;=2^29280
 ;;^UTILITY(U,$J,358.3,4157,1,3,0)
 ;;=3^Strapping;Finger/Hand
 ;;^UTILITY(U,$J,358.3,4158,0)
 ;;=29530^^30^245^25^^^^1
 ;;^UTILITY(U,$J,358.3,4158,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4158,1,2,0)
 ;;=2^29530
 ;;^UTILITY(U,$J,358.3,4158,1,3,0)
 ;;=3^Strapping;Knee
 ;;^UTILITY(U,$J,358.3,4159,0)
 ;;=29550^^30^245^26^^^^1
 ;;^UTILITY(U,$J,358.3,4159,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4159,1,2,0)
 ;;=2^29550
 ;;^UTILITY(U,$J,358.3,4159,1,3,0)
 ;;=3^Strapping;Toes
 ;;^UTILITY(U,$J,358.3,4160,0)
 ;;=20610^^30^245^7^^^^1
 ;;^UTILITY(U,$J,358.3,4160,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4160,1,2,0)
 ;;=2^20610
 ;;^UTILITY(U,$J,358.3,4160,1,3,0)
 ;;=3^Arthocentesis,Knee/Shldr/Hip w/o US Guidance
 ;;^UTILITY(U,$J,358.3,4161,0)
 ;;=20611^^30^245^6^^^^1
 ;;^UTILITY(U,$J,358.3,4161,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4161,1,2,0)
 ;;=2^20611
 ;;^UTILITY(U,$J,358.3,4161,1,3,0)
 ;;=3^Arthocentesis,Knee/Shldr/Hip w/ US Guidance
 ;;^UTILITY(U,$J,358.3,4162,0)
 ;;=20605^^30^245^9^^^^1
 ;;^UTILITY(U,$J,358.3,4162,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4162,1,2,0)
 ;;=2^20605
 ;;^UTILITY(U,$J,358.3,4162,1,3,0)
 ;;=3^Arthrocentesis,Wrst/Elb/Ank/Ac Jt w/o US Guidance
 ;;^UTILITY(U,$J,358.3,4163,0)
 ;;=20606^^30^245^8^^^^1
 ;;^UTILITY(U,$J,358.3,4163,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4163,1,2,0)
 ;;=2^20606
 ;;^UTILITY(U,$J,358.3,4163,1,3,0)
 ;;=3^Arthrocentesis,Wrst/Elb/Ank/Ac Jt w/ US Guidance
 ;;^UTILITY(U,$J,358.3,4164,0)
 ;;=23650^^30^245^21^^^^1
 ;;^UTILITY(U,$J,358.3,4164,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4164,1,2,0)
 ;;=2^23650
 ;;^UTILITY(U,$J,358.3,4164,1,3,0)
 ;;=3^Shld Disloc;Closed Txmt w/ Manip w/o Anesth
 ;;^UTILITY(U,$J,358.3,4165,0)
 ;;=29130^^30^245^1^^^^1
 ;;^UTILITY(U,$J,358.3,4165,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4165,1,2,0)
 ;;=2^29130
 ;;^UTILITY(U,$J,358.3,4165,1,3,0)
 ;;=3^Apply Finger Splint;Static
 ;;^UTILITY(U,$J,358.3,4166,0)
 ;;=29105^^30^245^3^^^^1
 ;;^UTILITY(U,$J,358.3,4166,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4166,1,2,0)
 ;;=2^29105
 ;;^UTILITY(U,$J,358.3,4166,1,3,0)
 ;;=3^Apply Long Arm Splint
 ;;^UTILITY(U,$J,358.3,4167,0)
 ;;=29125^^30^245^2^^^^1
 ;;^UTILITY(U,$J,358.3,4167,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4167,1,2,0)
 ;;=2^29125
 ;;^UTILITY(U,$J,358.3,4167,1,3,0)
 ;;=3^Apply Forearm Splint;Static
 ;;^UTILITY(U,$J,358.3,4168,0)
 ;;=29515^^30^245^5^^^^1
 ;;^UTILITY(U,$J,358.3,4168,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4168,1,2,0)
 ;;=2^29515
 ;;^UTILITY(U,$J,358.3,4168,1,3,0)
 ;;=3^Apply Lower Leg Splint
 ;;^UTILITY(U,$J,358.3,4169,0)
 ;;=29505^^30^245^4^^^^1
 ;;^UTILITY(U,$J,358.3,4169,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4169,1,2,0)
 ;;=2^29505
 ;;^UTILITY(U,$J,358.3,4169,1,3,0)
 ;;=3^Apply Long Leg Splint
 ;;^UTILITY(U,$J,358.3,4170,0)
 ;;=26600^^30^245^20^^^^1
 ;;^UTILITY(U,$J,358.3,4170,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4170,1,2,0)
 ;;=2^26600
 ;;^UTILITY(U,$J,358.3,4170,1,3,0)
 ;;=3^Metacarpal Fx,Closed Txmt w/o Manip,Ea Bone
 ;;^UTILITY(U,$J,358.3,4171,0)
 ;;=26605^^30^245^19^^^^1
 ;;^UTILITY(U,$J,358.3,4171,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4171,1,2,0)
 ;;=2^26605
 ;;^UTILITY(U,$J,358.3,4171,1,3,0)
 ;;=3^Metacarpal Fx,Closed Txmt w/ Manip,Ea Bone
 ;;^UTILITY(U,$J,358.3,4172,0)
 ;;=27250^^30^245^16^^^^1
 ;;^UTILITY(U,$J,358.3,4172,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4172,1,2,0)
 ;;=2^27250
 ;;^UTILITY(U,$J,358.3,4172,1,3,0)
 ;;=3^Closed Tx Hip Dislocation,Traumatic w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,4173,0)
 ;;=27265^^30^245^18^^^^1
 ;;^UTILITY(U,$J,358.3,4173,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4173,1,2,0)
 ;;=2^27265
 ;;^UTILITY(U,$J,358.3,4173,1,3,0)
 ;;=3^Closed Tx Post-Hip Arthroplasty w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,4174,0)
 ;;=27562^^30^245^17^^^^1
 ;;^UTILITY(U,$J,358.3,4174,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4174,1,2,0)
 ;;=2^27562
 ;;^UTILITY(U,$J,358.3,4174,1,3,0)
 ;;=3^Closed Tx Patella Dislocation w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,4175,0)
 ;;=27840^^30^245^13^^^^1
 ;;^UTILITY(U,$J,358.3,4175,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4175,1,2,0)
 ;;=2^27840
 ;;^UTILITY(U,$J,358.3,4175,1,3,0)
 ;;=3^Closed Tx Ankle Dislocation w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,4176,0)
 ;;=24600^^30^245^15^^^^1
 ;;^UTILITY(U,$J,358.3,4176,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4176,1,2,0)
 ;;=2^24600
 ;;^UTILITY(U,$J,358.3,4176,1,3,0)
 ;;=3^Closed Tx Elbow Dislocation w/o Anesthesia
 ;;^UTILITY(U,$J,358.3,4177,0)
 ;;=25605^^30^245^14^^^^1
 ;;^UTILITY(U,$J,358.3,4177,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4177,1,2,0)
 ;;=2^25605
 ;;^UTILITY(U,$J,358.3,4177,1,3,0)
 ;;=3^Closed Tx Distal Radial Fx w/ Manipulation
 ;;^UTILITY(U,$J,358.3,4178,0)
 ;;=D7820^^30^245^12^^^^1
 ;;^UTILITY(U,$J,358.3,4178,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4178,1,2,0)
 ;;=2^D7820
 ;;^UTILITY(U,$J,358.3,4178,1,3,0)
 ;;=3^Closed Reduction of TMJ Dislocation
 ;;^UTILITY(U,$J,358.3,4179,0)
 ;;=J3535^^30^246^7^^^^1
 ;;^UTILITY(U,$J,358.3,4179,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4179,1,2,0)
 ;;=2^J3535
 ;;^UTILITY(U,$J,358.3,4179,1,3,0)
 ;;=3^Drug Admin Thru Metered Dose Inhaler
 ;;^UTILITY(U,$J,358.3,4180,0)
 ;;=J7608^^30^246^1^^^^1
 ;;^UTILITY(U,$J,358.3,4180,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4180,1,2,0)
 ;;=2^J7608
 ;;^UTILITY(U,$J,358.3,4180,1,3,0)
 ;;=3^Acetylcysteine,Inhale,Non-Compd,Unit Dose
 ;;^UTILITY(U,$J,358.3,4181,0)
 ;;=J7609^^30^246^4^^^^1
 ;;^UTILITY(U,$J,358.3,4181,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4181,1,2,0)
 ;;=2^J7609
 ;;^UTILITY(U,$J,358.3,4181,1,3,0)
 ;;=3^Albuterol,Inhale,Compd,Unit Dose 1mg
 ;;^UTILITY(U,$J,358.3,4182,0)
 ;;=J7610^^30^246^3^^^^1
 ;;^UTILITY(U,$J,358.3,4182,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4182,1,2,0)
 ;;=2^J7610
 ;;^UTILITY(U,$J,358.3,4182,1,3,0)
 ;;=3^Albuterol,Inhale,Compd,Concentrate Frm 1mg
 ;;^UTILITY(U,$J,358.3,4183,0)
 ;;=J7613^^30^246^6^^^^1
 ;;^UTILITY(U,$J,358.3,4183,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4183,1,2,0)
 ;;=2^J7613
 ;;^UTILITY(U,$J,358.3,4183,1,3,0)
 ;;=3^Albuterol,Inhale,Non-Compd,Unit Dose 1mg
 ;;^UTILITY(U,$J,358.3,4184,0)
 ;;=J7611^^30^246^5^^^^1
 ;;^UTILITY(U,$J,358.3,4184,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4184,1,2,0)
 ;;=2^J7611
 ;;^UTILITY(U,$J,358.3,4184,1,3,0)
 ;;=3^Albuterol,Inhale,Non-Compd,Concentrate Frm 1mg
 ;;^UTILITY(U,$J,358.3,4185,0)
 ;;=J7644^^30^246^8^^^^1
 ;;^UTILITY(U,$J,358.3,4185,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4185,1,2,0)
 ;;=2^J7644
 ;;^UTILITY(U,$J,358.3,4185,1,3,0)
 ;;=3^Ipratropium Bromide Inhale,Non-Compd,Unit per mg
 ;;^UTILITY(U,$J,358.3,4186,0)
 ;;=J7620^^30^246^2^^^^1
 ;;^UTILITY(U,$J,358.3,4186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4186,1,2,0)
 ;;=2^J7620
 ;;^UTILITY(U,$J,358.3,4186,1,3,0)
 ;;=3^Albuterol 2.5mg/Ipratropium Bromide 0.5mg Non-Comp
 ;;^UTILITY(U,$J,358.3,4187,0)
 ;;=36556^^30^247^5^^^^1
 ;;^UTILITY(U,$J,358.3,4187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4187,1,2,0)
 ;;=2^36556
 ;;^UTILITY(U,$J,358.3,4187,1,3,0)
 ;;=3^Central Venous Line
 ;;^UTILITY(U,$J,358.3,4188,0)
 ;;=36600^^30^247^3^^^^1
 ;;^UTILITY(U,$J,358.3,4188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4188,1,2,0)
 ;;=2^36600
 ;;^UTILITY(U,$J,358.3,4188,1,3,0)
 ;;=3^Arterial Puncture (ABG)
 ;;^UTILITY(U,$J,358.3,4189,0)
 ;;=36680^^30^247^4^^^^1
 ;;^UTILITY(U,$J,358.3,4189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4189,1,2,0)
 ;;=2^36680
 ;;^UTILITY(U,$J,358.3,4189,1,3,0)
 ;;=3^Intraosseous Line Placement
 ;;^UTILITY(U,$J,358.3,4190,0)
 ;;=37195^^30^247^16^^^^1
 ;;^UTILITY(U,$J,358.3,4190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4190,1,2,0)
 ;;=2^37195
 ;;^UTILITY(U,$J,358.3,4190,1,3,0)
 ;;=3^Thrombolysis Cerebral,IV Infusion
 ;;^UTILITY(U,$J,358.3,4191,0)
 ;;=92953^^30^247^10^^^^1
 ;;^UTILITY(U,$J,358.3,4191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4191,1,2,0)
 ;;=2^92953
 ;;^UTILITY(U,$J,358.3,4191,1,3,0)
 ;;=3^Pacing,Transcutaneous
 ;;^UTILITY(U,$J,358.3,4192,0)
 ;;=92960^^30^247^9^^^^1
 ;;^UTILITY(U,$J,358.3,4192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4192,1,2,0)
 ;;=2^92960
 ;;^UTILITY(U,$J,358.3,4192,1,3,0)
 ;;=3^Defibrillation for Cardioversion,External (NOT in CPR)
 ;;^UTILITY(U,$J,358.3,4193,0)
 ;;=92977^^30^247^15^^^^1
 ;;^UTILITY(U,$J,358.3,4193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4193,1,2,0)
 ;;=2^92977
 ;;^UTILITY(U,$J,358.3,4193,1,3,0)
 ;;=3^Thrombolysis Coronary,IV Infusion
 ;;^UTILITY(U,$J,358.3,4194,0)
 ;;=36430^^30^247^19^^^^1
 ;;^UTILITY(U,$J,358.3,4194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4194,1,2,0)
 ;;=2^36430
 ;;^UTILITY(U,$J,358.3,4194,1,3,0)
 ;;=3^Transfusion,Blood/Blood Components
 ;;^UTILITY(U,$J,358.3,4195,0)
 ;;=31500^^30^247^6^^^^1
 ;;^UTILITY(U,$J,358.3,4195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4195,1,2,0)
 ;;=2^31500
 ;;^UTILITY(U,$J,358.3,4195,1,3,0)
 ;;=3^Enodotracheal Intubation
 ;;^UTILITY(U,$J,358.3,4196,0)
 ;;=31505^^30^247^7^^^^1
 ;;^UTILITY(U,$J,358.3,4196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4196,1,2,0)
 ;;=2^31505
 ;;^UTILITY(U,$J,358.3,4196,1,3,0)
 ;;=3^Indirect Laryngoscopy
 ;;^UTILITY(U,$J,358.3,4197,0)
 ;;=92950^^30^247^8^^^^1
 ;;^UTILITY(U,$J,358.3,4197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4197,1,2,0)
 ;;=2^92950
 ;;^UTILITY(U,$J,358.3,4197,1,3,0)
 ;;=3^CPR Resuscitation
 ;;^UTILITY(U,$J,358.3,4198,0)
 ;;=32554^^30^247^11^^^^1
 ;;^UTILITY(U,$J,358.3,4198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4198,1,2,0)
 ;;=2^32554
 ;;^UTILITY(U,$J,358.3,4198,1,3,0)
 ;;=3^Thoracentesis w/o Imaging Guidance
 ;;^UTILITY(U,$J,358.3,4199,0)
 ;;=32555^^30^247^12^^^^1
 ;;^UTILITY(U,$J,358.3,4199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4199,1,2,0)
 ;;=2^32555
 ;;^UTILITY(U,$J,358.3,4199,1,3,0)
 ;;=3^Thoracentesis w/ Imaging Guidance
 ;;^UTILITY(U,$J,358.3,4200,0)
 ;;=31605^^30^247^13^^^^1
 ;;^UTILITY(U,$J,358.3,4200,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4200,1,2,0)
 ;;=2^31605
 ;;^UTILITY(U,$J,358.3,4200,1,3,0)
 ;;=3^Trachestomy,Emergent,Cricothyroid
 ;;^UTILITY(U,$J,358.3,4201,0)
 ;;=32551^^30^247^14^^^^1
 ;;^UTILITY(U,$J,358.3,4201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4201,1,2,0)
 ;;=2^32551
 ;;^UTILITY(U,$J,358.3,4201,1,3,0)
 ;;=3^Chest Tube Insertion
 ;;^UTILITY(U,$J,358.3,4202,0)
 ;;=99152^^30^247^17^^^^1
 ;;^UTILITY(U,$J,358.3,4202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4202,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,4202,1,3,0)
 ;;=3^Moderate Sedation,1st 15 min
 ;;^UTILITY(U,$J,358.3,4203,0)
 ;;=99153^^30^247^18^^^^1
 ;;^UTILITY(U,$J,358.3,4203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4203,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,4203,1,3,0)
 ;;=3^Moderate Sedation,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,4204,0)
 ;;=99292^^30^247^2^^^^1
 ;;^UTILITY(U,$J,358.3,4204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4204,1,2,0)
 ;;=2^99292
 ;;^UTILITY(U,$J,358.3,4204,1,3,0)
 ;;=3^Critical Care,Ea Addl 30 Min
 ;;^UTILITY(U,$J,358.3,4205,0)
 ;;=43753^^30^248^7^^^^1
 ;;^UTILITY(U,$J,358.3,4205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4205,1,2,0)
 ;;=2^43753
 ;;^UTILITY(U,$J,358.3,4205,1,3,0)
 ;;=3^Gastric Lavage
 ;;^UTILITY(U,$J,358.3,4206,0)
 ;;=45915^^30^248^4^^^^1
 ;;^UTILITY(U,$J,358.3,4206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4206,1,2,0)
 ;;=2^45915
 ;;^UTILITY(U,$J,358.3,4206,1,3,0)
 ;;=3^Fecal Impaction Removal or FB
 ;;^UTILITY(U,$J,358.3,4207,0)
 ;;=46050^^30^248^9^^^^1
 ;;^UTILITY(U,$J,358.3,4207,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4207,1,2,0)
 ;;=2^46050
 ;;^UTILITY(U,$J,358.3,4207,1,3,0)
 ;;=3^Perianal Abscess I&D
 ;;^UTILITY(U,$J,358.3,4208,0)
 ;;=46320^^30^248^8^^^^1
 ;;^UTILITY(U,$J,358.3,4208,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4208,1,2,0)
 ;;=2^46320
 ;;^UTILITY(U,$J,358.3,4208,1,3,0)
 ;;=3^Hemorrhoid Excision,Thrombosed,External
 ;;^UTILITY(U,$J,358.3,4209,0)
 ;;=49082^^30^248^2^^^^1
 ;;^UTILITY(U,$J,358.3,4209,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4209,1,2,0)
 ;;=2^49082
 ;;^UTILITY(U,$J,358.3,4209,1,3,0)
 ;;=3^Abdominal Paracentesis w/o Imaging
 ;;^UTILITY(U,$J,358.3,4210,0)
 ;;=49083^^30^248^1^^^^1
 ;;^UTILITY(U,$J,358.3,4210,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4210,1,2,0)
 ;;=2^49083
 ;;^UTILITY(U,$J,358.3,4210,1,3,0)
 ;;=3^Abdominal Paracentesis w/ Imaging
 ;;^UTILITY(U,$J,358.3,4211,0)
 ;;=56420^^30^248^3^^^^1
 ;;^UTILITY(U,$J,358.3,4211,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4211,1,2,0)
 ;;=2^56420
 ;;^UTILITY(U,$J,358.3,4211,1,3,0)
 ;;=3^Bartholin's Cyst I&D
 ;;^UTILITY(U,$J,358.3,4212,0)
 ;;=56405^^30^248^11^^^^1
 ;;^UTILITY(U,$J,358.3,4212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4212,1,2,0)
 ;;=2^56405
 ;;^UTILITY(U,$J,358.3,4212,1,3,0)
 ;;=3^Vulva/Perineum Abscess I&D
 ;;^UTILITY(U,$J,358.3,4213,0)
 ;;=58301^^30^248^10^^^^1
 ;;^UTILITY(U,$J,358.3,4213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4213,1,2,0)
 ;;=2^58301
 ;;^UTILITY(U,$J,358.3,4213,1,3,0)
 ;;=3^Removal IUD
 ;;^UTILITY(U,$J,358.3,4214,0)
 ;;=43762^^30^248^6^^^^1
 ;;^UTILITY(U,$J,358.3,4214,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4214,1,2,0)
 ;;=2^43762
 ;;^UTILITY(U,$J,358.3,4214,1,3,0)
 ;;=3^GTube Change Bedside (Simple)
 ;;^UTILITY(U,$J,358.3,4215,0)
 ;;=43763^^30^248^5^^^^1
 ;;^UTILITY(U,$J,358.3,4215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4215,1,2,0)
 ;;=2^43763
 ;;^UTILITY(U,$J,358.3,4215,1,3,0)
 ;;=3^GTube Change Bedside (Complicated)
 ;;^UTILITY(U,$J,358.3,4216,0)
 ;;=69200^^30^249^4^^^^1
 ;;^UTILITY(U,$J,358.3,4216,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4216,1,2,0)
 ;;=2^69200
 ;;^UTILITY(U,$J,358.3,4216,1,3,0)
 ;;=3^Remove FB,External Ear Canal
 ;;^UTILITY(U,$J,358.3,4217,0)
 ;;=69209^^30^249^5^^^^1
 ;;^UTILITY(U,$J,358.3,4217,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4217,1,2,0)
 ;;=2^69209
 ;;^UTILITY(U,$J,358.3,4217,1,3,0)
 ;;=3^Remove Impacted Ear Wax w/ Lavage,Unilat
 ;;^UTILITY(U,$J,358.3,4218,0)
 ;;=62270^^30^249^1^^^^1
 ;;^UTILITY(U,$J,358.3,4218,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4218,1,2,0)
 ;;=2^62270
 ;;^UTILITY(U,$J,358.3,4218,1,3,0)
 ;;=3^Lumbar Puncture
 ;;^UTILITY(U,$J,358.3,4219,0)
 ;;=64450^^30^249^3^^^^1
 ;;^UTILITY(U,$J,358.3,4219,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4219,1,2,0)
 ;;=2^64450
 ;;^UTILITY(U,$J,358.3,4219,1,3,0)
 ;;=3^Peripheral Nerve Block
 ;;^UTILITY(U,$J,358.3,4220,0)
 ;;=31505^^30^249^6^^^^1
 ;;^UTILITY(U,$J,358.3,4220,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4220,1,2,0)
 ;;=2^31505
 ;;^UTILITY(U,$J,358.3,4220,1,3,0)
 ;;=3^Indirect Laryngoscopy
 ;;^UTILITY(U,$J,358.3,4221,0)
 ;;=42809^^30^249^7^^^^1
 ;;^UTILITY(U,$J,358.3,4221,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4221,1,2,0)
 ;;=2^42809
 ;;^UTILITY(U,$J,358.3,4221,1,3,0)
 ;;=3^Remove FB,Pharynx
 ;;^UTILITY(U,$J,358.3,4222,0)
 ;;=30901^^30^249^8^^^^1
 ;;^UTILITY(U,$J,358.3,4222,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4222,1,2,0)
 ;;=2^30901
 ;;^UTILITY(U,$J,358.3,4222,1,3,0)
 ;;=3^Control Nosebleed,Ant Simple (Packing)
 ;;^UTILITY(U,$J,358.3,4223,0)
 ;;=30905^^30^249^9^^^^1
 ;;^UTILITY(U,$J,358.3,4223,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4223,1,2,0)
 ;;=2^30905
 ;;^UTILITY(U,$J,358.3,4223,1,3,0)
 ;;=3^Control Nosebleed,Post,Init
 ;;^UTILITY(U,$J,358.3,4224,0)
 ;;=65220^^30^249^10^^^^1
 ;;^UTILITY(U,$J,358.3,4224,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4224,1,2,0)
 ;;=2^65220
 ;;^UTILITY(U,$J,358.3,4224,1,3,0)
 ;;=3^Remove FB,Cornea w/o Slit Lamp
 ;;^UTILITY(U,$J,358.3,4225,0)
 ;;=65222^^30^249^11^^^^1
 ;;^UTILITY(U,$J,358.3,4225,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4225,1,2,0)
 ;;=2^65222
 ;;^UTILITY(U,$J,358.3,4225,1,3,0)
 ;;=3^Remove FB,Cornea w/ Slit Lamp
 ;;^UTILITY(U,$J,358.3,4226,0)
 ;;=65205^^30^249^12^^^^1
 ;;^UTILITY(U,$J,358.3,4226,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4226,1,2,0)
 ;;=2^65205
 ;;^UTILITY(U,$J,358.3,4226,1,3,0)
 ;;=3^Remove FB,External Eye/Conjuctiva
 ;;^UTILITY(U,$J,358.3,4227,0)
 ;;=65210^^30^249^13^^^^1
 ;;^UTILITY(U,$J,358.3,4227,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4227,1,2,0)
 ;;=2^65210
 ;;^UTILITY(U,$J,358.3,4227,1,3,0)
 ;;=3^Remove FB,External Eye/Conjuctivl-Embedded
 ;;^UTILITY(U,$J,358.3,4228,0)
 ;;=64435^^30^249^2^^^^1
 ;;^UTILITY(U,$J,358.3,4228,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4228,1,2,0)
 ;;=2^64435
 ;;^UTILITY(U,$J,358.3,4228,1,3,0)
 ;;=3^Paracervical Nerve Block
 ;;^UTILITY(U,$J,358.3,4229,0)
 ;;=12051^^30^250^14^^^^1
 ;;^UTILITY(U,$J,358.3,4229,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4229,1,2,0)
 ;;=2^12051
 ;;^UTILITY(U,$J,358.3,4229,1,3,0)
 ;;=3^Intermd < 2.5cm Face/Ears/Eyelids/Mucous Membranes
 ;;^UTILITY(U,$J,358.3,4230,0)
 ;;=12052^^30^250^15^^^^1
 ;;^UTILITY(U,$J,358.3,4230,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4230,1,2,0)
 ;;=2^12052
 ;;^UTILITY(U,$J,358.3,4230,1,3,0)
 ;;=3^Intermd 2.6-5.0cm Face/Ears/Eyelids/Mucous Membranes
 ;;^UTILITY(U,$J,358.3,4231,0)
 ;;=12053^^30^250^16^^^^1
 ;;^UTILITY(U,$J,358.3,4231,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4231,1,2,0)
 ;;=2^12053
 ;;^UTILITY(U,$J,358.3,4231,1,3,0)
 ;;=3^Intermd 5.1-7.5cm Face/Ears/Eyelids/Mucous Membranes
 ;;^UTILITY(U,$J,358.3,4232,0)
 ;;=64450^^30^250^1^^^^1
