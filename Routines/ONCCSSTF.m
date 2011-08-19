ONCCSSTF ;Hines OIFO/GWB - COLLABORATIVE STAGING STUFFING ;01/07/04
 ;;2.11;ONCOLOGY;**40,43,46,48,49**;Mar 07, 1995;Build 38
 ;
 Q:$G(TOP)=""
 N MM,MO
 S MO=$$HIST^ONCFUNC(D0)
 S MM="NO"
 I $$MELANOMA^ONCOU55(D0) D
 .S:$P($G(^ONCO(165.5,D0,"CS")),U,5)="" $P(^ONCO(165.5,D0,"CS"),U,5)=$P($G(^ONCO(165.5,D0,2)),U,9)
 E  D
 .S:$P($G(^ONCO(165.5,D0,"CS1")),U,10)="" $P(^ONCO(165.5,D0,"CS1"),U,10)=$P($G(^ONCO(165.5,D0,2)),U,9)
 ;
 ;Pharynx, NOS, Other Ill-Defined Oral Cavity Sites
 I (TOP=67140)!(TOP=67142)!(TOP=67148) D EVAL9
 ;Other & Ill-defined Digestive Organs
 I ($E(TOP,3,4)=26) D EVAL9
 ;Middle Ear
 I TOP=67301 D EVAL9
 ;Accessory (Paranasal) Sinuses
 I (TOP=67312)!(TOP=67313)!(TOP=67318)!(TOP=67319) D EVAL9
 ;Trachea
 I TOP=67339 D EVAL9
 ;Other & Ill-Defined Respiratory Sites & Intrathoracic Organs
 I (TOP=67390)!(TOP=67398)!(TOP=67399) D EVAL9
 ;Broad & Round Ligaments, Parametrium, Uterine Adnexa
 I (TOP=67571)!(TOP=67572)!(TOP=67573)!(TOP=67574) D EVAL9
 ;Other & Unspecified Female Genital Organs
 I (TOP=67577)!(TOP=67578)!(TOP=67579) D EVAL9
 ;Prostate
 I TOP=67619 D
 .S:$P($G(^ONCO(165.5,D0,2.2)),U,2)=99 $P(^ONCO(165.5,D0,"CS"),U,7)="097"
 .N GS
 .S GS=$$GET1^DIQ(165.5,D0,623)
 .I GS'="" S GS=$S(GS="02":"002",GS="03":"003",GS="04":"004",GS="05":"005",GS="06":"006",GS="07":"007",GS="08":"008",GS="09":"009",GS="10":"010",1:"") S $P(^ONCO(165.5,D0,"CS"),U,10)=GS
 ;Other & Unspecified Male Genital Organs
 I ($E(TOP,3,4)=63) D EVAL9
 ;Paraurethral Gland, Overlapping Lesion of Urinary Organs, &
 ;Unspecified Urinary Organs
 I (TOP=67681)!(TOP=67688)!(TOP=67689) D EVAL9
 ;Cornea, Retina, Choroid, Ciliary Body, Eyeball, Overlapping &
 ;Other Eye
 I '$$MELANOMA^ONCOU55(D0),(TOP=67691)!(TOP=67692)!(TOP=67693)!(TOP=67694)!(TOP=67698)!(TOP=67699) D EVAL9
 ;Brain & Cerebral Meninges
 I (TOP=67700)!($E(TOP,3,4)=71) D EVAL9,LN
 ;Other Parts of CNS
 I (TOP=67701)!(TOP=67709)!($E(TOP,3,4)=72) D EVAL9,LN
 ;Thymus, Adrenal (Suprarenal) Gland, & Other Endocrine Glands
 I (TOP=67379)!($E(TOP,3,4)=74)!($E(TOP,3,4)=75) D EVAL9
 ;
MM ;Malignant Melanoma of Skin, Vulva, Penis, Scrotum
 I $$MELANOMA^ONCOU55(D0),($E(TOP,3,4)=44)!($E(TOP,3,4)=51)!($E(TOP,3,4)=60)!(TOP=67632) D SSF56 Q
 ;Malignant Melanoma of Conjunctiva
 I $$MELANOMA^ONCOU55(D0),TOP=67690 S MM="YES" G SSF26
 ;Malignant Melanoma of Iris & Ciliary Body
 I $$MELANOMA^ONCOU55(D0),TOP=67694 S MM="YES" G SSF26
 ;Malignant Melanoma of Choroid
 I $$MELANOMA^ONCOU55(D0),TOP=67693 S MM="YES" G SSF26
 ;Malignant Melanoma of Other Eye
 I $$MELANOMA^ONCOU55(D0),(TOP=67691)!(TOP=67692)!(TOP=67695)!(TOP=67698)!(TOP=67699) D SSF168 Q
MFSD ;Mycosis Fungoides and Sezary Disease of Skin, Vulva, Penis, Scrotum
 I (MO=97003)!(MO=97013),($E(TOP,3,4)=44)!($E(TOP,3,4)=51)!($E(TOP,3,4)=60)!(TOP=67632) D SSF26 Q
RET ;Retinoblastoma
 I $E(MO,1,3)=951,($E(TOP,3,4)=69) S MM="YES" G SSF26
 ;Kaposi Sarcoma of All Sites (9140)
 I MO=91403 D  D EVAL9 S MM="YES" G SSF26
 .S $P(^ONCO(165.5,D0,"CS1"),U,10)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,3)=88
LYMPH ;Hodgkin & Non-Hodgkin Lymphomas of All Sites
 ;(excl. Mycosis Fungoides & Sezary Disease)
 I $$LYMPHOMA^ONCFUNC(D0),MO'=97003,MO'=97013 D LN D  Q
 .S $P(^ONCO(165.5,D0,"CS1"),U,10)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,2)=9
 .S $P(^ONCO(165.5,D0,"CS"),U,4)=9
 .S $P(^ONCO(165.5,D0,"CS"),U,3)=88
 .S $P(^ONCO(165.5,D0,"CS"),U,8)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,9)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,10)=888
HRIMN ;Hematopoietic, Reticuloendothelial, Immunoproliferative, &
 ;Myeloproliferative Neoplasms
 I (MO'<97310)&(MO'>99899) D EVAL9,LN,SSF168 D  Q
 .S $P(^ONCO(165.5,D0,"CS1"),U,10)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,3)=88
 .;EXTENSION (CS) (165.5,30.2) stuffing with 80 (Systemic disease)
 .I (MO'=97313)&($E(MO,1,4)'=9740)&($E(MO,1,4)'=9750)&($E(MO,1,4)'=9755)&($E(MO,1,4)'=9756)&($E(MO,1,4)'=9757)&($E(MO,1,4)'=9758)&($E(MO,1,4)'=9930) D
 ..S $P(^ONCO(165.5,D0,"CS"),U,11)=80
 ;
SSF16 ;SITE-SPECIFIC FACTOR 1-6 = 888 (Not applicable for this site)
 ;Esophagus
 I ($E(TOP,3,4)=15) D SSF168 Q
 ;Small Intestine
 I ($E(TOP,3,4)=17) D SSF168 Q
 ;Anus
 I ($E(TOP,3,4)=21) D SSF168 Q
 ;Gallbladder
 I TOP=67239 D SSF168 Q
 ;Extrahepatic Bile Duct(s)
 I TOP=67240 D SSF168 Q
 ;Ampulla of Vater
 I TOP=67241 D SSF168 Q
 ;Other Biliary & Biliary, NOS
 I (TOP=67248)!(TOP=67249) D SSF168 Q
 ;Pancreas: Head
 I TOP=67250 D SSF168 Q
 ;Pancreas: Body & Tail
 I (TOP=67251)!(TOP=67252) D SSF168 Q
 ;Pancreas: Other & Unspecified
 I (TOP=67253)!(TOP=67254)!(TOP=67257)!(TOP=67258)!(TOP=67259) D SSF168 Q
 ;Other & Ill-defined Digestive Organs
 I (TOP=67260)!(TOP=6728)!(TOP=67269) D SSF168 Q
 ;Trachea
 I TOP=67339 D SSF168 Q
 ;Lung
 I ($E(TOP,3,4)=34) D SSF168 Q
 ;Heart, Mediastinum
 I (TOP=67380)!(TOP=67381)!(TOP=67382)!(TOP=67383)!(TOP=67388) D SSF168 Q
 ;Other & Ill-Defined Respiratory Sites & Intrathoracic Organs
 I (TOP=67390)!(TOP=67398)!(TOP=67399) D SSF168 Q
 ;Bone
 I ($E(TOP,3,4)=40)!($E(TOP,3,4)=41) D SSF168 Q
 ;Skin
 ;(excl. Mycosis Fungoides & Sezary Disease)
 I (TOP=67440)!(TOP=67442)!(TOP=67443)!(TOP=67444)!(TOP=67445)!(TOP=67446)!(TOP=67447)!(TOP=67448)!(TOP=67449),MO'=97003,MO'=97013 D SSF168 Q
 ;Skin of Eyelid
 I TOP=67441 D SSF168 Q
 ;Peripheral Nerves & Autonomic Nervous System;
 ;Connective, Subcutaneous, & Other Soft Tissues
 I ($E(TOP,3,4)=47)!($E(TOP,3,4)=49) D SSF168 Q
 ;Retroperitoneum & Peritoneum
 I ($E(TOP,3,4)=48) D SSF168 Q
 ;Vulva
 I ($E(TOP,3,4)=51) D SSF168 Q
 ;Vagina
 I TOP=67529 D SSF168 Q
 ;Cervix Uteri
 I ($E(TOP,3,4)=53) D SSF168 Q
 ;Corpus Uteri; Uterus, NOS
 I ($E(TOP,3,4)=54)!(TOP=67559) D SSF168 Q
 ;Fallopian Tube
 I TOP=67570 D SSF168 Q
 ;Broad & Round Ligaments, Parametrium, Uterine Adnexa
 I (TOP=67571)!(TOP=67572)!(TOP=67573)!(TOP=67574) D SSF168 Q
 ;Other & Unspecified Female Genital Organs
 I (TOP=67577)!(TOP=67578)!(TOP=67579) D SSF168 Q
 ;Penis
 I ($E(TOP,3,4)=60) D SSF168 Q
 ;Other & Unspecified Male Genital Organs
 I ($E(TOP,3,4)=63) D SSF168 Q
 ;Scrotum
 I TOP=67632 D SSF168 Q
 ;Kidney (Renal Parenchyma)
 I TOP=67649 D SSF168 Q
 ;Renal Pelvis & Ureter
 I (TOP=67659)!(TOP=67669) D SSF168 Q
 ;Bladder
 I ($E(TOP,3,4)=67) D SSF168 Q
 ;Urethra
 I TOP=67680 D SSF168 Q
 ;Paraurethral Gland, Overlapping Lesion of Urinary Organs, &
 ;Unspecified Urinary Organs
 I (TOP=67681)!(TOP=67688)!(TOP=67689) D SSF168 Q
 ;Conjunctiva
 I TOP=67690 D SSF168 Q
 ;Cornea, Retina, Choroid, Ciliary Body, Eyeball, Overlapping &
 ;Other Eye
 I (TOP=67691)!(TOP=67692)!(TOP=67693)!(TOP=67694)!(TOP=67698)!(TOP=67699) D SSF168 Q
 ;Lacrimal Gland
 I TOP=67695 D SSF168 Q
 ;Orbit
 I TOP=67696 D SSF168 Q
 ;Other & Ill-Defined Sites, Unknown Primary Site
 I ($E(TOP,3,4)=42)!($E(TOP,3,4)=76)!($E(TOP,3,4)=77)!(TOP=67809) D EVAL9,LN,SSF168 D  Q
 .S $P(^ONCO(165.5,D0,"CS"),U,11)=88
 .S $P(^ONCO(165.5,D0,"CS"),U,3)=88
 ;
SSF26 ;SITE-SPECIFIC FACTOR 2-6 = 888 (Not applicable for this site)
 ;Pleura
 ;Mycosis Fungoides & Sezary Disease (9700-9701)
 ;Ovary
 ;Placenta
 I TOP=67589 D LN S $P(^ONCO(165.5,D0,"CS"),U,2)=9
 ;Brain & Cerebral Meninges
 ;Other Parts of CNS
 ;Thyroid
 ;Thymus, Adrenal (Suprarenal) Gland, & Other Endocrine Glands
 ;Stomach
 I (TOP=67384)!(MO=97003)!(MO=97013)!(TOP=67569)!(TOP=67589)!(MM="YES")!(TOP=67700)!($E(TOP,3,4)=71)!(TOP=67701)!(TOP=67709)!($E(TOP,3,4)=72)!(TOP=67739)!(TOP=67379)!($E(TOP,3,4)=74)!($E(TOP,3,4)=75)!($E(TOP,3,4)=16) D  Q
 .S $P(^ONCO(165.5,D0,"CS"),U,6)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,7)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,8)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,9)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,10)=888
 ;
SSF36 ;SITE-SPECIFIC FACTOR 3-6 = 888 (Not applicable for this site)
 ;Colon
 ;Rectosigmoid, Rectum
 ;Liver & Intrahepatic Bile Ducts
 I ($E(TOP,3,4)=18)!(TOP=67199)!(TOP=67209)!($E(TOP,3,4)=22) D  Q
 .S $P(^ONCO(165.5,D0,"CS"),U,7)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,8)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,9)=888
 .S $P(^ONCO(165.5,D0,"CS"),U,10)=888
 ;
SSF6 ;SITE-SPECIFIC FACTOR 6 = 888 (Not applicable for this site)
 ;Testis
 I ($E(TOP,3,4)=62) D  Q
 .S $P(^ONCO(165.5,D0,"CS"),U,10)=888
 ;
 Q
 ;
EVAL9 S $P(^ONCO(165.5,D0,"CS"),U,1)=9
 S $P(^ONCO(165.5,D0,"CS"),U,2)=9
 S $P(^ONCO(165.5,D0,"CS"),U,4)=9
 Q
 ;
SSF168 S $P(^ONCO(165.5,D0,"CS"),U,5)=888
 S $P(^ONCO(165.5,D0,"CS"),U,6)=888
 S $P(^ONCO(165.5,D0,"CS"),U,7)=888
 S $P(^ONCO(165.5,D0,"CS"),U,8)=888
 S $P(^ONCO(165.5,D0,"CS"),U,9)=888
 S $P(^ONCO(165.5,D0,"CS"),U,10)=888
 Q
 ;
SSF56 ;SITE-SPECIFIC FACTOR 5-6 = 888 (Not applicable for this site)
 S $P(^ONCO(165.5,D0,"CS"),U,9)=888
 S $P(^ONCO(165.5,D0,"CS"),U,10)=888
 Q
 ;
LN S $P(^ONCO(165.5,D0,"CS"),U,12)=88
 S $P(^ONCO(165.5,D0,2),U,12)=99
 S $P(^ONCO(165.5,D0,2),U,13)=99
 Q
