ICDDRGX2 ;MKN - GROUPER PROCESS ;06/04/12 3:45pm
 ;;18.0;DRG Grouper;**64**;Oct 20, 2000;Build 103
 ;
VARIABLS ;Apply Variables for MDC 1-22
 ;
 N ICDFI,ICDRGT,ICDN,ICDX,ICDREL
 ;Check if Procedure Codes related to Primary DX
 S (ICDFI,ICDREL)=0,ICDN="" F  S ICDN=$O(ICDPRC(ICDN)) Q:ICDN=""  S ICDX=$$MDCT^ICDEX(ICDPRC(ICDN),ICDDATE,.ICDMDC) S:ICDX=1 ICDREL=1
 I $D(ICD10OR(151)) S ICDRG=$S(ICDMCC=2:11,ICDMCC=1:12,1:13),ICDFI=1 G EXIT ;151=Tracheostomy for Face, Mouth and Neck Diagnoses
 I $D(ICD10OR(60)) S ICDRG=$S(ICDMCC=2:20,ICDMCC=1:21,1:22),ICDFI=1 G EXIT ;60=Intracranial Vascualr Procedure
 I ICDMDC=1 D
 . I $D(ICD10OR("Q")) D  Q:ICDFI  ;Craniotomy
 . . I $D(ICD10OR("C")) S ICDRG=23,ICDFI=1 Q  ;C=Chemotherapy Implant
 . . I $D(ICD10OR(77))!($D(ICD10PD(13))) D  Q  ;77=Major Device Implant or PDX of Acute Complex CNS
 . . . S ICDRG=$S(ICDMCC=2:23,1:24),ICDFI=1 Q
 . . I '($D(ICD10OR(77))!($D(ICD10PD(13)))) D  Q
 . . . S ICDRG=$S(ICDMCC=2:25,ICDMCC=1:26,1:27),ICDFI=1 Q
 . I $D(ICD10OR(144)) D  Q  ;Spinal Procedures
 . . I ICDMCC>0 S ICDRG=$S(ICDMCC=2:28,1:29),ICDFI=1 Q
 . . S ICDRG=$S($D(ICD10OR(143)):29,1:30),ICDFI=1 Q  ;143=Spinal NeuroStimulators
 . I $D(ICD10OR(164)) S ICDRG=$S(ICDMCC=2:31,ICDMCC=1:32,1:33),ICDFI=1 Q  ;164=Ventricualr Shunt Procedures
 . I $D(ICD10OR(33)) S ICDRG=$S(ICDMCC=2:34,ICDMCC=1:35,1:36),ICDFI=1 Q  ;33=Carotid Artery Stent Procedures
 . I $D(ICD10OR(174)) S ICDRG=$S(ICDMCC=2:37,ICDMCC=1:38,1:39),ICDFI=1 Q  ;Extracranial Procedures
 . I $D(ICD10OR(122)) D  Q  ;122=Peripheral and Cranial Nerve and Other Nervous System Procedures
 . . I ICDMCC>0 S ICDRG=$S(ICDMCC=2:40,1:41),ICDFI=1 Q
 . . I $D(ICD10OR(123)) S ICDRG=41,ICDFI=1 Q  ;123=Peripheral Neurostimulator Combinations
 . . S ICDRG=42,ICDFI=1 Q
 . I $D(ICD10OR(10)) S ICDRG=$S(ICDMCC=2:61,ICDMCC=1:62,1:63),ICDFI=1 Q  ;10=Acute Ischemic Stroke with Use of Thrombolytic Agent
 . I $D(ICD10PD(86)) S ICDRG=$S(ICDMCC=2:64,ICDMCC=1:65,1:66),ICDFI=1 Q  ;86=Intracranial Hemorrhage or Cerebral Infarction
 . I $D(ICD10PD(217)) S ICDRG=$S(ICDMCC=2:82,ICDMCC=1:83,1:84),ICDFI=1 Q  ;217=Traumatic Stupor and Coma, Coma > 1 Hour
 . I $D(ICD10PD(216)) S ICDRG=$S(ICDMCC=2:85,ICDMCC=1:86,1:87),ICDFI=1 Q  ;216=Traumatic Stupor and Coma, Coma < 1 Hour
 . I $D(ICD10PD(43)) S ICDRG=$S(ICDMCC=2:88,ICDMCC=1:89,1:90),ICDFI=1 Q  ;43=Concussion
 . I $D(ICD10PD(155)) S ICDRG=$S(ICDMCC=2:91,ICDMCC=1:92,1:93),ICDFI=1 Q  ;155=Other Disorders of Nervous System
 . I $D(ICD10PD(26)) S ICDRG=$S(ICDMCC=2:94,ICDMCC=1:95,1:96),ICDFI=1 Q  ;26=Bacterial and Tuberculous Infections of Nervous System
 . I $D(ICD10PD(140)) S ICDRG=$S(ICDMCC=2:97,ICDMCC=1:98,1:99),ICDFI=1 Q  ;140=Non-Bacterial Infections of Nervous System Except Viral Meningitis
 . I $D(ICD10PD(188)) S ICDRG=$S(ICDMCC=2:100,1:101),ICDFI=1 Q  ;188=Seizures
 . I $D(ICD10PD(74)) S ICDRG=$S(ICDMCC=2:102,1:103),ICDFI=1 Q  ;74=Headaches
 G:ICDFI EXIT
 I ICDMDC=2 D
 . I $D(ICD10OR(99)) S ICDRG=$S(ICDMCC=2:113,1:114),ICDFI=1 Q  ;Orbital Procedures
 . I $D(ICD10OR(46)) S ICDRG=115,ICDFI=1 Q  ;Extraocular Procedures
 . I $D(ICD10OR(61)) S ICDRG=$S(ICDMCC=2:116,1:117),ICDFI=1 Q  ;Intraocular Procedures
 G:ICDFI EXIT
 I ICDMDC=3,$D(ICD10OR(53)) D  ;53=Head and Neck procedures
 . I $D(ICD10OR(77)) S ICDRG=129,ICDFI=1 Q  ;77=Major Device Implane
 . S ICDRG=$S(ICDMCC>0:129,1:130),ICDFI=1 Q
 . I $D(ICD10OR(39)) S ICDRG=$S(ICDMCC>0:131,1:132),ICDFI=1 Q  ;39=Cranial/Facial Procedures
 G:ICDFI EXIT
 I $D(ICD10OR(76)) S ICDRG=$S(ICDMCC=2:163,ICDMCC=1:164,1:165),ICDFI=1 Q  ;76=Major Chest Procedures
 G:ICDFI EXIT
 I ICDMDC=4 D
 . I $D(ICD10OR(86)) S ICDRG=207,ICDFI=1 Q  ;86=Mechanical Ventilation 96+ hours
 . I $D(ICD10OR(87)) S ICDRG=208,ICDFI=1 Q  ;87=Mechanical Ventilation <96 hours
 G:ICDFI EXIT
 I $D(ICD10OR(32)),'$D(ICD10OR(38)) D  ;32=Cardiac Valve and Other Major Cardiothoracic Procedures  38=Coronary Bypass
 . I $D(ICD10OR(28)) S ICDRG=$S(ICDMCC=2:216,ICDMCC=1:217,1:218),ICDFI=1 Q  ;28=Cardiac Catherization
 . S ICDRG=$S(ICDMCC=2:219,ICDMCC=1:220,1:221),ICDFI=1 Q
 G:ICDFI EXIT
 I $D(ICD10OR(29)) D  ;29=Cardiac Defibrillator Implant
 . I $D(ICD10PD(22)),$D(ICD10OR(28)) S ICDRG=$S(ICDMCC=2:222,1:223),ICDFI=1 Q  ;22=AMI/HF/Shock and Cardiac Catheterization  28=Cardiac Catherization
 . I '$D(ICD10PD(22)),$D(ICD10OR(28)) S ICDRG=$S(ICDMCC=2:224,1:225),ICDFI=1 Q
 . I '$D(ICD10OR(28)) S ICDRG=$S(ICDMCC=2:226,1:227),ICDFI=1 Q
 G:ICDFI EXIT
 I $D(ICD10OR(38)) D  ;38=Coronary Bypass
 . I $D(ICD10OR(129)) S ICDRG=$S(ICDMCC=2:231,1:232),ICDFI=1 Q  ;129=PTCA
 . I $D(ICD10OR(28)) S ICDRG=$S(ICDMCC=2:233,1:234),ICDFI=1 Q  ;28=Cardiac Catheterization
 . S ICDRG=$S(ICDMCC=2:235,1:236),ICDFI=1 Q
 G:ICDFI EXIT
 I $D(ICD10OR(125)) S ICDRG=$S(ICDMCC=2:242,ICDMCC=1:243,1:244),ICDFI=1 G EXIT
 I $D(ICD10OR(12)) S ICDRG=245,ICDFI=1 G EXIT
 I $D(ICD10OR(120)) D  ;120=Percutaneous Cardiovascular Procedures without Coronary Artery Stent
 . I $D(ICD10OR(43)),ICDMCC=2 S ICDRG=246,ICDFI=1 Q  ;Drug-Eluting Stent
 . I $D(ICD10OR(43)),ICDMCC'=2,$D(ICD10OR(87)) S ICDRG=246,ICDFI=1 Q  ;;Drug-Eluting Stent and 4+ Vessels / Stents
 . I $D(ICD10OR(43)),ICDMCC'=2,'$D(ICD10OR(87)) S ICDRG=247,ICDFI=1 Q
 . I '$D(ICD10OR(43)),$D(ICD10OR(92)) D  G:ICDFI EXIT
 . . I ICDMCC=2 S ICDRG=248,ICDFI=1 Q  ;Non-Drug-Eluting Stent
 . . S ICDRG=$S($D(ICD10OR(87)):248,1:249),ICDFI=1 Q
 G:ICDFI EXIT
 I ICDMDC=5,$D(ICD10OR(121)) S ICDRG=$S(ICDMCC=2:250,1:251),ICDFI=1 G EXIT ;Percutaneous Cardiovascular Procedures with Coronary Artery Stent
 I $D(ICD10OR(31)),'$D(ICD10OR(101)) S ICDRG=$S(ICDMCC=2:260,ICDMCC=1:261,1:262),ICDFI=1 G EXIT ;30=Cardiac Pacemaker Revision Except Device Replacement
 I $D(ICD10PD(18)) D  ;Acute Myocardial Infarction
 . I 'ICDEXP S ICDRG=$S(ICDMCC=2:280,ICDMCC=1:281,1:282),ICDFI=1 Q  ;If Discharged Alive
 . S ICDRG=$S(ICDMCC=2:283,ICDMCC=1:284,1:285),ICDFI=1 Q
 G:ICDFI EXIT
 I $D(ICD10OR(37)) S ICDRG=$S(ICDMCC=2:286,1:287),ICDFI=1 G EXIT ;Circulatory Disorders Except AMI with Cardiac Catheterization
 I $D(ICD10PD(75)) S ICDRG=$S(ICDMCC=2:291,ICDMCC=1:292,1:293),ICDFI=1 G EXIT ;Heart Failure and Shock
 I $D(ICD10PD(31)) S ICDRG=$S(ICDMCC=2:296,ICDMCC=1:297,1:298),ICDFI=1 G EXIT ;Cardiac Arrest, Unexplained
 I $D(ICD10OR(130)) S ICDRG=$S(ICDMCC=2:332,ICDMCC=1:333,1:334),ICDFI=1 G EXIT ;Rectal Resection
 I $D(ICD10OR(20)) D  ;Appendectomy
 . I $D(ICD10PD(41)) S ICDRG=$S(ICDMCC=2:338,ICDMCC=1:339,1:340),ICDFI=1 Q
 . S ICDRG=$S(ICDMCC=2:341,ICDMCC=1:342,1:343),ICDFI=1 Q
 G:ICDFI EXIT
 I ICDMDC=6 D
 . I $D(ICD10OR("J")) S ICDRG=$S(ICDMCC=2:350,ICDMCC=1:351,1:352),ICDFI=1 Q  ;Inguinal and Femoral Hernia
 . I $D(ICD10OR(55)) S ICDRG=$S(ICDMCC=2:353,ICDMCC=1:354,1:355),ICDFI=1 Q  ;Hernia except Inguinal and Femoral
 G:ICDFI EXIT
 I $D(ICD10PD(94)) S ICDRG=$S(ICDMCC=2:368,ICDMCC=1:369,1:370),ICDFI=1 G EXIT ;Major Esophageal Disorders
 I $D(ICD10PD(40)) S ICDRG=$S(ICDMCC=2:380,ICDMCC=1:381,1:382),ICDFI=1 G EXIT ;Complicated Peptic Ulcer
 I $D(ICD10PD(216)) S ICDRG=$S(ICDMCC=2:383,1:384),ICDFI=1 G EXIT ;Uncomplicated Peptic Ulcer
 I $D(ICD10OR(36))!($D(ICD10OR(65))) D
 . I $D(ICD10OR(27)) S ICDRG=$S(ICDMCC=2:411,ICDMCC=1:412,1:413),ICDFI=1 Q
 . I '$D(ICD10OR(27)),'$D(ICD10OR(65)) S ICDRG=$S(ICDMCC=2:414,ICDMCC=1:415,1:416),ICDFI=1 Q
 . I '$D(ICD10OR(27)),$D(ICD10OR(65)) S ICDRG=$S(ICDMCC=2:417,ICDMCC=1:418,1:419),ICDFI=1 Q
 G:ICDFI EXIT
 I ICDMDC=7,$D(ICD10OR(54)) S ICDRG=$S(ICDMCC=2:420,ICDMCC=1:421,1:422),ICDFI=1 G EXIT ;54=Hepatobiliary Diagnostic Procedures
 I ICDMDC=8 D
 . I $D(ICD10OR(19)),$D(ICD10OR(127)) S ICDRG=$S(ICDMCC=2:453,ICDMCC=1:454,1:455),ICDFI=1 Q  ;19=Anterior Spinal Fusion 127=Posterior Spinal Fusion
 . I $D(ICD10OR(142)),$D(ICD10PD(206)) S ICDRG=$S(ICDMCC=2:456,ICDMCC=1:457,1:458),ICDFI=1 Q  ;180=Spinal Fusion except Cervical 206=Spinal Curvature / Malignancy / Infection
 . I $D(ICD10OR(142)) S ICDRG=$S(ICDMCC=2:459,1:460),ICDFI=1 Q  ;180=Spinal Fusion except Cervical
 . I $G(ICD10OR(173))=2 S ICDRG=$S(ICDMCC=2:461,1:462),ICDFI=1 Q  ;173=Bilateral or Multiple Major Joint Procedures of Lower Extremity
 . I $D(ICD10OR(79)) S ICDRG=$S(ICDMCC=2:469,1:470),ICDFI=1 Q  ;79=Major Joint Replacement or Reattachment of Lower Extremity
 G:ICDFI EXIT
 I $D(ICD10OR(64)) D  ;Knee procedures
 . I $D(ICD10PD(64)) S ICDRG=$S(ICDMCC=2:485,ICDMCC=1:486,1:487),ICDFI=1 Q
 . S ICDRG=$S(ICDMCC>0:488,1:489),ICDFI=1
 G:ICDFI EXIT
 I $D(ICD10OR(23)),'$D(ICD10OR(42)),'$D(ICD10OR(91)),ICDMCC=0 S ICDRG=491,ICDFI=1
 I $D(ICD10OR(23)),ICDMCC>0 S ICDRG=490,ICDFI=1
 I '$D(ICD10OR(23)),$D(ICD10OR(42)) S ICDRG=490,ICDFI=1
 I '$D(ICD10OR(23)),'$D(ICD10OR(42)),$D(ICD10OR(91)) S ICDRG=490,ICDFI=1
 G:ICDFI EXIT
 I ICDMDC=8,$D(ICD10OR(84)) S ICDRG=506,ICDFI=1 G EXIT ;84=Major Thumb or Joint Procedures
 I ICDMDC=8,$D(ICD10OR(51)) S ICDRG=513,ICDFI=1 G EXIT ;51=Hand or Wrist Procedures, Except Major Thumb or Joint Procedures
 I ICDMDC=9,$D(ICD10OR(137)) S ICDRG=$S(ICDMCC=2:570,ICDMCC=1:571,1:572),ICDFI=1 G EXIT ;Skin Debridemeny
 I ICDMDC=9,$D(ICD10OR("k")) D
 . I $D(ICD10PD(205))!($D(ICD10PD(34))) S ICDRG=$S(ICDMCC=2:573,ICDMCC=1:574,1:575),ICDFI=1 Q  ;205=Skin Ulcer  34=Cellulitis
 . S ICDRG=$S(ICDMCC=2:576,ICDMCC=1:577,1:578),ICDFI=1 Q
 G:ICDFI EXIT
 I $D(ICD10OR(85)) S ICDRG=$S(ICDMCC>0:582,1:583),ICDFI=1 G EXIT
 I ICDMDC=9,$D(ICD10PD(205)) S ICDRG=$S(ICDMCC=2:592,ICDMCC=1:593,1:594),ICDFI=1 G EXIT ;205=Skin Ulcers
 I $D(ICD10PD(102)) S ICDRG=$S(ICDMCC=2:597,ICDMCC=1:598,1:599),ICDFI=1 G EXIT ;102=Malignant Breat Disorder
 I $D(ICD10PD(142)) S ICDRG=$S(ICDMCC>0:600,1:601),ICDFI=1 G EXIT ;142=Non-Malignant Breast Disorders
 I $D(ICD10OR(15)) S ICDRG=$S(ICDMCC=2:616,ICDMCC=1:617,1:618),ICDFI=1 G EXIT ;15=Amputation of Lower Limb for Endocrine, Nutritional and Metabolic Disorders
 I $D(ICD10OR(63)) S ICDRG=652,ICDFI=1 G EXIT ;Kidney Transplant
 I ICDMDC=11,$D(ICD10OR(74)) S ICDRG=$S(ICDMCC=2:653,ICDMCC=1:654,1:655),ICDFI=1 G EXIT ;74=Major Bladder Procedures
 I $D(ICD10OR(62)) D  ;62=Kidney and Ureter Procedures
 . I $D(ICD10PD(136)) S ICDRG=$S(ICDMCC=2:656,ICDMCC=1:657,1:658),ICDFI=1 Q  ;136=Neoplasm
 . I '$D(ICD10PD(136)) S ICDRG=$S(ICDMCC=2:659,ICDMCC=1:660,1:661),ICDFI=1 Q
 G:ICDFI EXIT
 I ICDMDC=11,$D(ICD10OR(88)) S ICDRG=$S(ICDMCC=2:662,ICDMCC=1:663,1:664),ICDFI=1 G EXIT ;88=Minor Bladder Procedures
 I ICDMDC=11 D
 . I $D(ICD10OR(128)) S ICDRG=$S(ICDMCC=2:665,ICDMCC=1:666,1:667),ICDFI=1 Q  ;128=Prostatectomy
 . I $D(ICD10OR(107)) S ICDRG=$S(ICDMCC=2:673,ICDMCC=1:674,1:675),ICDFI=1 Q  ;107=Other Kidney and Urinary Tract Procedures
 G:ICDFI EXIT
 I $D(ICD10PD(184)) S ICDRG=$S(ICDMCC=2:682,ICDMCC=1:683,1:684),ICDFI=1 G EXIT ;184=Renal Failure
 I $D(ICD10PD(88)) S ICDRG=$S(ICDMCC=2:686,ICDMCC=1:687,1:688),ICDFI=1 G EXIT ;Kidney and Urinary Tract Neoplasms
 I $D(ICD10PD(220)) D  ;220=Urinary Stones
 . I $D(ICD10OR(45)) S ICDRG=$S(ICDMCC=2:691,1:692),ICDFI=1 Q  ;ESW Lithotripsy 
 . S ICDRG=$S(ICDMCC=2:693,1:694),ICDFI=1 Q
 G:ICDFI EXIT
 I $D(ICD10PD(89)) S ICDRG=$S(ICDMCC=2:695,1:696),ICDFI=1 G EXIT ;Kidney and Urinary Tract Signs and Symptoms
 I $D(ICD10OR(80)) S ICDRG=$S(ICDMCC>0:707,1:708),ICDFI=1 G EXIT ;80=Major Male Pelvic
 I ICDMDC=12,$D(ICD10OR(119)) S ICDRG=$S(ICDMCC>0:709,1:710),ICDFI=1 G EXIT ;119=Penis Procedures
 I $D(ICD10OR(147)) S ICDRG=$S(ICDMCC>0:711,1:712),ICDFI=1 G EXIT ;147=Testes Procedures
 I ICDMDC=12,$D(ICD10OR(153)) S ICDRG=$S(ICDMCC>0:713,1:714),ICDFI=1 G EXIT ;153=Transurethral Prostatectomy
 I SEX="M",ICDMDC=12,$D(ICD10OR(108)) D  ;108=Other Male Reproductive System O.R. Procedures
 . I $D(ICD10PD(98)) S ICDRG=$S(ICDMCC>0:715,1:716),ICDFI=1 Q  ;98=Malignancy
 . S ICDRG=$S(ICDMCC>0:717,1:718),ICDFI=1 Q
 G:ICDFI EXIT
 I ICDMDC=12,SEX="M",$D(ICD10PD(98)) S ICDRG=$S(ICDMCC=2:722,ICDMCC=1:723,1:724),ICDFI=1 G EXIT ;98=Malignancy, Male Reproductive System
 I SEX="F",$D(ICD10OR(118)) S ICDRG=$S(ICDMCC>0:734,1:735),ICDFI=1 G EXIT ;118=Pelvic Evisceration, Radical Hysterectomy and Radical Vulvectomy
 I $D(ICD10OR(158)),$D(ICD10PD(143)) S ICDRG=$S(ICDMCC=2:739,ICDMCC=1:740,1:741),ICDFI=1 G EXIT ;158=Uterine and Adnexal Procedures 143=Non-ovarian/adnexal Malignancy
 I $D(ICD10OR(158)),$D(ICD10PD(168)) S ICDRG=$S(ICDMCC=2:736,ICDMCC=1:737,1:738),ICDFI=1 G EXIT ;168=Ovarian or Adnexal Malignancy
 I SEX="F" D
 . I ICDMDC=13 D
 . . I $D(ICD10OR(157)) S ICDRG=$S(ICDMCC>0:742,1:743),ICDFI=1 Q  ;157=Uterine and Adnexal Procedures for Non-Malignancy
 . . I $D(ICD10OR(41)) S ICDRG=$S(ICDMCC>0:744,1:745),ICDFI=1 Q  ;41=D&C, Conization, Laparoscopy and Tubal Interruption
 . Q:ICDFI
 . ;I ICDMDC=14,$D(ICD10OR(41)),$D(ICD10OR(161)) D  ;D&C, Conization, Laparoscopy and Tubal Interruption
 . ;.S ICDRG=$S($D(ICD10OR(161)):767,1:768),ICDFI=1 Q  ;161=Sterilization and/or D&C
 . I ICDMDC=14,$D(ICD10OR(181)) D  ;181=Delivery procedures
 . . I $D(ICD10OR(183)) S ICDRG=767,ICDFI=1 Q  ;183=Sterilization and/or D&C
 . . I $D(ICD10OR(182)) S ICDRG=768,ICDFI=1 Q  ;182=Not Sterilization and/or D&C
 G:ICDFI=1 EXIT
 I $D(ICD10OR(159)) S ICDRG=$S(ICDMCC>0:746,1:747),ICDFI=1 G EXIT ;159=Vagina, Cervix and Vulva Procedures
 I $D(ICD10OR(47)) S ICDRG=748,ICDFI=1 G EXIT ;47=Female Reproductive System Reconstructive Procedures
 I SEX="F",$D(ICD10OR(104)) S ICDRG=$S(ICDMCC>0:749,1:750),ICDFI=1 G EXIT ;104=Other Female Reproductive System O.R. Procedures
 I SEX="F",$D(ICD10PD(100)) S ICDRG=$S(ICDMCC=2:754,ICDMCC=1:755,1:756),ICDFI=1 G EXIT ;98=Malignancy, Female Reproductive System
 I SEX="F",$D(ICD10PD(81)) S ICDRG=$S(ICDMCC=2:757,ICDMCC=1:758,1:759),ICDFI=1 G EXIT ;81=Infections, Female Reproductive System
 I $D(ICD10PD(130)) S ICDRG=$S(ICDMCC>0:760,1:761),ICDFI=1,ICDFI=1 G EXIT ;130=Menstrual and Other Female Reproductive System Disorders
 I $D(ICD10OR("c")) S ICDRG=$S(ICDMCC>0:765,1:766),ICDFI=1 G EXIT ;"c"=Cesarean Section
 I $D(ICD10OR(162)) S ICDRG=$S($D(ICD10OR(161)):767,1:768),ICDFI=1 G EXIT ;162=Vaginal Delivery 161=Sterilization and/or D&C
 I $D(ICD10PD(176)),$D(ICD10OR) S ICDRG=769,ICDFI=1 G EXIT ;176=Postpartum and Post Abortion Diagnoses with O.R. Procedure
 I $D(ICD10PD(176)),'$D(ICD10OR) S ICDRG=776,ICDFI=1 G EXIT ;176=Postpartum and Post Abortion Diagnoses with O.R. Procedure
 I $D(ICD10PD(10)) S ICDRG=779,ICDFI=1 G EXIT ;Abortion without D&C
 I $D(ICD10OR(145)) S ICDRG=$S(ICDMCC=2:799,ICDMCC=1:800,1:801),ICDFI=1 G EXIT ;145=Splenectomy
 I ICDMDC=16,$D(ICD10OR(110)) S ICDRG=$S(ICDMCC=2:802,ICDMCC=1:803,1:804),ICDFI=1 G EXIT ;110=Other O.R. Procedures of the Blood and Blood Forming Organs
 I $D(ICD10OR(94)) S ICDRG=$S(ICDMCC=2:808,ICDMCC=1:809,1:810),ICDFI=1 G EXIT ;94=Major Hematological/Immunological Diagnoses Except Sickle Cell Crisis and Coagulation
 I $D(ICD10PD(90)),$D(ICD10OR(81)) S ICDRG=$S(ICDMCC=2:820,ICDMCC=1:821,1:822),ICDFI=1 G EXIT ;90=Lymphoma and Leukemia with Major O.R. Procedure
 G ^ICDDRGX3
 ;
EXIT ;
 G EXIT^ICDDRGX3
 ;
