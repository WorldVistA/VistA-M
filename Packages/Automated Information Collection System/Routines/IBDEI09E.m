IBDEI09E ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9363,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,9364,0)
 ;;=J32.4^^48^555^6
 ;;^UTILITY(U,$J,358.3,9364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9364,1,3,0)
 ;;=3^Chronic pansinusitis
 ;;^UTILITY(U,$J,358.3,9364,1,4,0)
 ;;=4^J32.4
 ;;^UTILITY(U,$J,358.3,9364,2)
 ;;=^5008206
 ;;^UTILITY(U,$J,358.3,9365,0)
 ;;=J35.01^^48^555^10
 ;;^UTILITY(U,$J,358.3,9365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9365,1,3,0)
 ;;=3^Chronic tonsillitis
 ;;^UTILITY(U,$J,358.3,9365,1,4,0)
 ;;=4^J35.01
 ;;^UTILITY(U,$J,358.3,9365,2)
 ;;=^259089
 ;;^UTILITY(U,$J,358.3,9366,0)
 ;;=J36.^^48^555^19
 ;;^UTILITY(U,$J,358.3,9366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9366,1,3,0)
 ;;=3^Peritonsillar abscess
 ;;^UTILITY(U,$J,358.3,9366,1,4,0)
 ;;=4^J36.
 ;;^UTILITY(U,$J,358.3,9366,2)
 ;;=^92333
 ;;^UTILITY(U,$J,358.3,9367,0)
 ;;=J37.0^^48^555^4
 ;;^UTILITY(U,$J,358.3,9367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9367,1,3,0)
 ;;=3^Chronic laryngitis
 ;;^UTILITY(U,$J,358.3,9367,1,4,0)
 ;;=4^J37.0
 ;;^UTILITY(U,$J,358.3,9367,2)
 ;;=^269902
 ;;^UTILITY(U,$J,358.3,9368,0)
 ;;=J30.9^^48^555^2
 ;;^UTILITY(U,$J,358.3,9368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9368,1,3,0)
 ;;=3^Allergic rhinitis, unspecified
 ;;^UTILITY(U,$J,358.3,9368,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,9368,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,9369,0)
 ;;=J30.0^^48^555^23
 ;;^UTILITY(U,$J,358.3,9369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9369,1,3,0)
 ;;=3^Vasomotor rhinitis
 ;;^UTILITY(U,$J,358.3,9369,1,4,0)
 ;;=4^J30.0
 ;;^UTILITY(U,$J,358.3,9369,2)
 ;;=^5008201
 ;;^UTILITY(U,$J,358.3,9370,0)
 ;;=J34.3^^48^555^14
 ;;^UTILITY(U,$J,358.3,9370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9370,1,3,0)
 ;;=3^Hypertrophy of nasal turbinates
 ;;^UTILITY(U,$J,358.3,9370,1,4,0)
 ;;=4^J34.3
 ;;^UTILITY(U,$J,358.3,9370,2)
 ;;=^269909
 ;;^UTILITY(U,$J,358.3,9371,0)
 ;;=M95.0^^48^555^1
 ;;^UTILITY(U,$J,358.3,9371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9371,1,3,0)
 ;;=3^Acquired deformity of nose
 ;;^UTILITY(U,$J,358.3,9371,1,4,0)
 ;;=4^M95.0
 ;;^UTILITY(U,$J,358.3,9371,2)
 ;;=^5015367
 ;;^UTILITY(U,$J,358.3,9372,0)
 ;;=J38.00^^48^555^18
 ;;^UTILITY(U,$J,358.3,9372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9372,1,3,0)
 ;;=3^Paralysis of vocal cords and larynx, unspecified
 ;;^UTILITY(U,$J,358.3,9372,1,4,0)
 ;;=4^J38.00
 ;;^UTILITY(U,$J,358.3,9372,2)
 ;;=^5008219
 ;;^UTILITY(U,$J,358.3,9373,0)
 ;;=J38.1^^48^555^22
 ;;^UTILITY(U,$J,358.3,9373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9373,1,3,0)
 ;;=3^Polyp of vocal cord and larynx
 ;;^UTILITY(U,$J,358.3,9373,1,4,0)
 ;;=4^J38.1
 ;;^UTILITY(U,$J,358.3,9373,2)
 ;;=^5008222
 ;;^UTILITY(U,$J,358.3,9374,0)
 ;;=J38.7^^48^555^15
 ;;^UTILITY(U,$J,358.3,9374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9374,1,3,0)
 ;;=3^Larynx Diseases NEC
 ;;^UTILITY(U,$J,358.3,9374,1,4,0)
 ;;=4^J38.7
 ;;^UTILITY(U,$J,358.3,9374,2)
 ;;=^5008227
 ;;^UTILITY(U,$J,358.3,9375,0)
 ;;=K13.21^^48^555^16
 ;;^UTILITY(U,$J,358.3,9375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9375,1,3,0)
 ;;=3^Leukoplakia of oral mucosa, including tongue
 ;;^UTILITY(U,$J,358.3,9375,1,4,0)
 ;;=4^K13.21
 ;;^UTILITY(U,$J,358.3,9375,2)
 ;;=^270054
 ;;^UTILITY(U,$J,358.3,9376,0)
 ;;=R43.0^^48^555^3
 ;;^UTILITY(U,$J,358.3,9376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9376,1,3,0)
 ;;=3^Anosmia
 ;;^UTILITY(U,$J,358.3,9376,1,4,0)
 ;;=4^R43.0
 ;;^UTILITY(U,$J,358.3,9376,2)
 ;;=^7949
 ;;^UTILITY(U,$J,358.3,9377,0)
 ;;=R49.0^^48^555^12
 ;;^UTILITY(U,$J,358.3,9377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9377,1,3,0)
 ;;=3^Dysphonia
 ;;^UTILITY(U,$J,358.3,9377,1,4,0)
 ;;=4^R49.0
 ;;^UTILITY(U,$J,358.3,9377,2)
 ;;=^5019501
 ;;^UTILITY(U,$J,358.3,9378,0)
 ;;=R04.0^^48^555^13
 ;;^UTILITY(U,$J,358.3,9378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9378,1,3,0)
 ;;=3^Epistaxis
 ;;^UTILITY(U,$J,358.3,9378,1,4,0)
 ;;=4^R04.0
 ;;^UTILITY(U,$J,358.3,9378,2)
 ;;=^5019173
 ;;^UTILITY(U,$J,358.3,9379,0)
 ;;=J34.89^^48^555^17
 ;;^UTILITY(U,$J,358.3,9379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9379,1,3,0)
 ;;=3^Nose & Nasal Sinus Disorders,Oth Specified
 ;;^UTILITY(U,$J,358.3,9379,1,4,0)
 ;;=4^J34.89
 ;;^UTILITY(U,$J,358.3,9379,2)
 ;;=^5008211
 ;;^UTILITY(U,$J,358.3,9380,0)
 ;;=H60.391^^48^556^34
 ;;^UTILITY(U,$J,358.3,9380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9380,1,3,0)
 ;;=3^Infective otitis externa, right ear NEC
 ;;^UTILITY(U,$J,358.3,9380,1,4,0)
 ;;=4^H60.391
 ;;^UTILITY(U,$J,358.3,9380,2)
 ;;=^5006459
 ;;^UTILITY(U,$J,358.3,9381,0)
 ;;=H60.392^^48^556^33
 ;;^UTILITY(U,$J,358.3,9381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9381,1,3,0)
 ;;=3^Infective otitis externa, left ear NEC
 ;;^UTILITY(U,$J,358.3,9381,1,4,0)
 ;;=4^H60.392
 ;;^UTILITY(U,$J,358.3,9381,2)
 ;;=^5006460
 ;;^UTILITY(U,$J,358.3,9382,0)
 ;;=H60.393^^48^556^32
 ;;^UTILITY(U,$J,358.3,9382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9382,1,3,0)
 ;;=3^Infective otitis externa, bilateral NEC
 ;;^UTILITY(U,$J,358.3,9382,1,4,0)
 ;;=4^H60.393
 ;;^UTILITY(U,$J,358.3,9382,2)
 ;;=^5006461
 ;;^UTILITY(U,$J,358.3,9383,0)
 ;;=H62.41^^48^556^46
 ;;^UTILITY(U,$J,358.3,9383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9383,1,3,0)
 ;;=3^Otitis externa in oth diseases classd elswhr, right ear
 ;;^UTILITY(U,$J,358.3,9383,1,4,0)
 ;;=4^H62.41
 ;;^UTILITY(U,$J,358.3,9383,2)
 ;;=^5006562
 ;;^UTILITY(U,$J,358.3,9384,0)
 ;;=H62.42^^48^556^47
 ;;^UTILITY(U,$J,358.3,9384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9384,1,3,0)
 ;;=3^Otitis externa in oth diseases classd elswhr, left ear
 ;;^UTILITY(U,$J,358.3,9384,1,4,0)
 ;;=4^H62.42
 ;;^UTILITY(U,$J,358.3,9384,2)
 ;;=^5006563
 ;;^UTILITY(U,$J,358.3,9385,0)
 ;;=H62.43^^48^556^48
 ;;^UTILITY(U,$J,358.3,9385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9385,1,3,0)
 ;;=3^Otitis externa in oth diseases classd elswhr, bilateral
 ;;^UTILITY(U,$J,358.3,9385,1,4,0)
 ;;=4^H62.43
 ;;^UTILITY(U,$J,358.3,9385,2)
 ;;=^5006564
 ;;^UTILITY(U,$J,358.3,9386,0)
 ;;=B36.9^^48^556^58
 ;;^UTILITY(U,$J,358.3,9386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9386,1,3,0)
 ;;=3^Superficial mycosis, unspecified
 ;;^UTILITY(U,$J,358.3,9386,1,4,0)
 ;;=4^B36.9
 ;;^UTILITY(U,$J,358.3,9386,2)
 ;;=^5000611
 ;;^UTILITY(U,$J,358.3,9387,0)
 ;;=H60.21^^48^556^39
 ;;^UTILITY(U,$J,358.3,9387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9387,1,3,0)
 ;;=3^Malignant otitis externa, right ear
 ;;^UTILITY(U,$J,358.3,9387,1,4,0)
 ;;=4^H60.21
 ;;^UTILITY(U,$J,358.3,9387,2)
 ;;=^5006444
 ;;^UTILITY(U,$J,358.3,9388,0)
 ;;=H60.22^^48^556^38
 ;;^UTILITY(U,$J,358.3,9388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9388,1,3,0)
 ;;=3^Malignant otitis externa, left ear
 ;;^UTILITY(U,$J,358.3,9388,1,4,0)
 ;;=4^H60.22
 ;;^UTILITY(U,$J,358.3,9388,2)
 ;;=^5006445
 ;;^UTILITY(U,$J,358.3,9389,0)
 ;;=H60.23^^48^556^37
 ;;^UTILITY(U,$J,358.3,9389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9389,1,3,0)
 ;;=3^Malignant otitis externa, bilateral
 ;;^UTILITY(U,$J,358.3,9389,1,4,0)
 ;;=4^H60.23
 ;;^UTILITY(U,$J,358.3,9389,2)
 ;;=^5006446
 ;;^UTILITY(U,$J,358.3,9390,0)
 ;;=H60.511^^48^556^2
 ;;^UTILITY(U,$J,358.3,9390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9390,1,3,0)
 ;;=3^Acute actinic otitis externa, right ear
 ;;^UTILITY(U,$J,358.3,9390,1,4,0)
 ;;=4^H60.511
 ;;^UTILITY(U,$J,358.3,9390,2)
 ;;=^5006470
 ;;^UTILITY(U,$J,358.3,9391,0)
 ;;=H60.512^^48^556^1
 ;;^UTILITY(U,$J,358.3,9391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9391,1,3,0)
 ;;=3^Acute actinic otitis externa, left ear
 ;;^UTILITY(U,$J,358.3,9391,1,4,0)
 ;;=4^H60.512
 ;;^UTILITY(U,$J,358.3,9391,2)
 ;;=^5006471
 ;;^UTILITY(U,$J,358.3,9392,0)
 ;;=H61.23^^48^556^29
 ;;^UTILITY(U,$J,358.3,9392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9392,1,3,0)
 ;;=3^Impacted cerumen, bilateral
