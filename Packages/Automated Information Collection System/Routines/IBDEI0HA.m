IBDEI0HA ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17364,0)
 ;;=K57.30^^76^890^5
 ;;^UTILITY(U,$J,358.3,17364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17364,1,3,0)
 ;;=3^Dvrtclos of lg int w/o perforation or abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,17364,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,17364,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,17365,0)
 ;;=L25.9^^76^890^2
 ;;^UTILITY(U,$J,358.3,17365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17365,1,3,0)
 ;;=3^Dermatitis, contact, unspec cause
 ;;^UTILITY(U,$J,358.3,17365,1,4,0)
 ;;=4^L25.9
 ;;^UTILITY(U,$J,358.3,17365,2)
 ;;=^5133647
 ;;^UTILITY(U,$J,358.3,17366,0)
 ;;=R42.^^76^890^4
 ;;^UTILITY(U,$J,358.3,17366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17366,1,3,0)
 ;;=3^Dizziness & giddiness
 ;;^UTILITY(U,$J,358.3,17366,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,17366,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,17367,0)
 ;;=R06.00^^76^890^7
 ;;^UTILITY(U,$J,358.3,17367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17367,1,3,0)
 ;;=3^Dyspnea, unspec
 ;;^UTILITY(U,$J,358.3,17367,1,4,0)
 ;;=4^R06.00
 ;;^UTILITY(U,$J,358.3,17367,2)
 ;;=^5019180
 ;;^UTILITY(U,$J,358.3,17368,0)
 ;;=R13.10^^76^890^6
 ;;^UTILITY(U,$J,358.3,17368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17368,1,3,0)
 ;;=3^Dysphagia, unspec
 ;;^UTILITY(U,$J,358.3,17368,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,17368,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,17369,0)
 ;;=R19.7^^76^890^3
 ;;^UTILITY(U,$J,358.3,17369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17369,1,3,0)
 ;;=3^Diarrhea, unspec
 ;;^UTILITY(U,$J,358.3,17369,1,4,0)
 ;;=4^R19.7
 ;;^UTILITY(U,$J,358.3,17369,2)
 ;;=^5019276
 ;;^UTILITY(U,$J,358.3,17370,0)
 ;;=F05.^^76^891^5
 ;;^UTILITY(U,$J,358.3,17370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17370,1,3,0)
 ;;=3^Delirium d/t known physiological condition
 ;;^UTILITY(U,$J,358.3,17370,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,17370,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,17371,0)
 ;;=F03.90^^76^891^9
 ;;^UTILITY(U,$J,358.3,17371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17371,1,3,0)
 ;;=3^Dementia w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,17371,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,17371,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,17372,0)
 ;;=F03.91^^76^891^8
 ;;^UTILITY(U,$J,358.3,17372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17372,1,3,0)
 ;;=3^Dementia w/ behavioral disturbances, unspec
 ;;^UTILITY(U,$J,358.3,17372,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,17372,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,17373,0)
 ;;=G30.9^^76^891^3
 ;;^UTILITY(U,$J,358.3,17373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17373,1,3,0)
 ;;=3^Alzheimer's disease w/ behavioral disturance, unspec
 ;;^UTILITY(U,$J,358.3,17373,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,17373,2)
 ;;=^5003808^F02.81
 ;;^UTILITY(U,$J,358.3,17374,0)
 ;;=G30.9^^76^891^4
 ;;^UTILITY(U,$J,358.3,17374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17374,1,3,0)
 ;;=3^Alzheimer's disease w/o behavioral disturbance, unspec
 ;;^UTILITY(U,$J,358.3,17374,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,17374,2)
 ;;=^5003808^F02.80
 ;;^UTILITY(U,$J,358.3,17375,0)
 ;;=G30.0^^76^891^1
 ;;^UTILITY(U,$J,358.3,17375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17375,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,17375,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,17375,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,17376,0)
 ;;=G30.1^^76^891^2
 ;;^UTILITY(U,$J,358.3,17376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17376,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,17376,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,17376,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,17377,0)
 ;;=F02.81^^76^891^6
 ;;^UTILITY(U,$J,358.3,17377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17377,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,17377,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,17377,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,17378,0)
 ;;=F02.80^^76^891^7
 ;;^UTILITY(U,$J,358.3,17378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17378,1,3,0)
 ;;=3^Dementia in Diseases Classd Elswhr w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,17378,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,17378,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,17379,0)
 ;;=F32.9^^76^892^3
 ;;^UTILITY(U,$J,358.3,17379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17379,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspec
 ;;^UTILITY(U,$J,358.3,17379,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,17379,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,17380,0)
 ;;=F33.9^^76^892^2
 ;;^UTILITY(U,$J,358.3,17380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17380,1,3,0)
 ;;=3^Major depressive disorder, recurrent, unspec
 ;;^UTILITY(U,$J,358.3,17380,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,17380,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,17381,0)
 ;;=F34.1^^76^892^1
 ;;^UTILITY(U,$J,358.3,17381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17381,1,3,0)
 ;;=3^Dysthymic disorder
 ;;^UTILITY(U,$J,358.3,17381,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,17381,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,17382,0)
 ;;=E87.70^^76^893^19
 ;;^UTILITY(U,$J,358.3,17382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17382,1,3,0)
 ;;=3^Fluid overload, unspec
 ;;^UTILITY(U,$J,358.3,17382,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,17382,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,17383,0)
 ;;=J43.9^^76^893^2
 ;;^UTILITY(U,$J,358.3,17383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17383,1,3,0)
 ;;=3^Emphysema, unspec
 ;;^UTILITY(U,$J,358.3,17383,1,4,0)
 ;;=4^J43.9
 ;;^UTILITY(U,$J,358.3,17383,2)
 ;;=^5008238
 ;;^UTILITY(U,$J,358.3,17384,0)
 ;;=K20.9^^76^893^7
 ;;^UTILITY(U,$J,358.3,17384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17384,1,3,0)
 ;;=3^Esophagitis, unspec
 ;;^UTILITY(U,$J,358.3,17384,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,17384,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,17385,0)
 ;;=K22.10^^76^893^9
 ;;^UTILITY(U,$J,358.3,17385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17385,1,3,0)
 ;;=3^Esophagus Ulcer w/o Bleeding
 ;;^UTILITY(U,$J,358.3,17385,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,17385,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,17386,0)
 ;;=K22.11^^76^893^8
 ;;^UTILITY(U,$J,358.3,17386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17386,1,3,0)
 ;;=3^Esophagus Ulcer w/ Bleeding
 ;;^UTILITY(U,$J,358.3,17386,1,4,0)
 ;;=4^K22.11
 ;;^UTILITY(U,$J,358.3,17386,2)
 ;;=^329930
 ;;^UTILITY(U,$J,358.3,17387,0)
 ;;=K22.2^^76^893^6
 ;;^UTILITY(U,$J,358.3,17387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17387,1,3,0)
 ;;=3^Esophageal obstruction
 ;;^UTILITY(U,$J,358.3,17387,1,4,0)
 ;;=4^K22.2
 ;;^UTILITY(U,$J,358.3,17387,2)
 ;;=^5008507
 ;;^UTILITY(U,$J,358.3,17388,0)
 ;;=M79.7^^76^893^18
 ;;^UTILITY(U,$J,358.3,17388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17388,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,17388,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,17388,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,17389,0)
 ;;=R50.9^^76^893^17
 ;;^UTILITY(U,$J,358.3,17389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17389,1,3,0)
 ;;=3^Fever, unspec
 ;;^UTILITY(U,$J,358.3,17389,1,4,0)
 ;;=4^R50.9
 ;;^UTILITY(U,$J,358.3,17389,2)
 ;;=^5019512
 ;;^UTILITY(U,$J,358.3,17390,0)
 ;;=R53.83^^76^893^16
 ;;^UTILITY(U,$J,358.3,17390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17390,1,3,0)
 ;;=3^Fatigue, oth
 ;;^UTILITY(U,$J,358.3,17390,1,4,0)
 ;;=4^R53.83
 ;;^UTILITY(U,$J,358.3,17390,2)
 ;;=^5019520
 ;;^UTILITY(U,$J,358.3,17391,0)
 ;;=R60.9^^76^893^1
 ;;^UTILITY(U,$J,358.3,17391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17391,1,3,0)
 ;;=3^Edema, unspec
 ;;^UTILITY(U,$J,358.3,17391,1,4,0)
 ;;=4^R60.9
 ;;^UTILITY(U,$J,358.3,17391,2)
 ;;=^5019534
 ;;^UTILITY(U,$J,358.3,17392,0)
 ;;=R04.0^^76^893^5
 ;;^UTILITY(U,$J,358.3,17392,1,0)
 ;;=^358.31IA^4^2
