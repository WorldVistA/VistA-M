IBDEI09C ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9306,1,3,0)
 ;;=3^Leukoplakia of oral mucosa, including tongue
 ;;^UTILITY(U,$J,358.3,9306,1,4,0)
 ;;=4^K13.21
 ;;^UTILITY(U,$J,358.3,9306,2)
 ;;=^270054
 ;;^UTILITY(U,$J,358.3,9307,0)
 ;;=K14.0^^48^552^7
 ;;^UTILITY(U,$J,358.3,9307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9307,1,3,0)
 ;;=3^Glossitis
 ;;^UTILITY(U,$J,358.3,9307,1,4,0)
 ;;=4^K14.0
 ;;^UTILITY(U,$J,358.3,9307,2)
 ;;=^51478
 ;;^UTILITY(U,$J,358.3,9308,0)
 ;;=K14.1^^48^552^6
 ;;^UTILITY(U,$J,358.3,9308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9308,1,3,0)
 ;;=3^Geographic tongue
 ;;^UTILITY(U,$J,358.3,9308,1,4,0)
 ;;=4^K14.1
 ;;^UTILITY(U,$J,358.3,9308,2)
 ;;=^5008498
 ;;^UTILITY(U,$J,358.3,9309,0)
 ;;=K14.3^^48^552^9
 ;;^UTILITY(U,$J,358.3,9309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9309,1,3,0)
 ;;=3^Hypertrophy of tongue papillae
 ;;^UTILITY(U,$J,358.3,9309,1,4,0)
 ;;=4^K14.3
 ;;^UTILITY(U,$J,358.3,9309,2)
 ;;=^5008499
 ;;^UTILITY(U,$J,358.3,9310,0)
 ;;=K14.8^^48^552^16
 ;;^UTILITY(U,$J,358.3,9310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9310,1,3,0)
 ;;=3^Tongue Diseases NEC
 ;;^UTILITY(U,$J,358.3,9310,1,4,0)
 ;;=4^K14.8
 ;;^UTILITY(U,$J,358.3,9310,2)
 ;;=^5008502
 ;;^UTILITY(U,$J,358.3,9311,0)
 ;;=R13.10^^48^552^5
 ;;^UTILITY(U,$J,358.3,9311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9311,1,3,0)
 ;;=3^Dysphagia, unspecified
 ;;^UTILITY(U,$J,358.3,9311,1,4,0)
 ;;=4^R13.10
 ;;^UTILITY(U,$J,358.3,9311,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,9312,0)
 ;;=R13.12^^48^552^2
 ;;^UTILITY(U,$J,358.3,9312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9312,1,3,0)
 ;;=3^Dysphagia, oropharyngeal phase
 ;;^UTILITY(U,$J,358.3,9312,1,4,0)
 ;;=4^R13.12
 ;;^UTILITY(U,$J,358.3,9312,2)
 ;;=^335277
 ;;^UTILITY(U,$J,358.3,9313,0)
 ;;=R13.13^^48^552^3
 ;;^UTILITY(U,$J,358.3,9313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9313,1,3,0)
 ;;=3^Dysphagia, pharyngeal phase
 ;;^UTILITY(U,$J,358.3,9313,1,4,0)
 ;;=4^R13.13
 ;;^UTILITY(U,$J,358.3,9313,2)
 ;;=^335278
 ;;^UTILITY(U,$J,358.3,9314,0)
 ;;=R13.14^^48^552^4
 ;;^UTILITY(U,$J,358.3,9314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9314,1,3,0)
 ;;=3^Dysphagia, pharyngoesophageal phase
 ;;^UTILITY(U,$J,358.3,9314,1,4,0)
 ;;=4^R13.14
 ;;^UTILITY(U,$J,358.3,9314,2)
 ;;=^335279
 ;;^UTILITY(U,$J,358.3,9315,0)
 ;;=S02.2XXA^^48^553^2
 ;;^UTILITY(U,$J,358.3,9315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9315,1,3,0)
 ;;=3^Fracture of nasal bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,9315,1,4,0)
 ;;=4^S02.2XXA
 ;;^UTILITY(U,$J,358.3,9315,2)
 ;;=^5020306
 ;;^UTILITY(U,$J,358.3,9316,0)
 ;;=S02.609A^^48^553^1
 ;;^UTILITY(U,$J,358.3,9316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9316,1,3,0)
 ;;=3^Fracture of mandible, unsp, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,9316,1,4,0)
 ;;=4^S02.609A
 ;;^UTILITY(U,$J,358.3,9316,2)
 ;;=^5020372
 ;;^UTILITY(U,$J,358.3,9317,0)
 ;;=S02.92XA^^48^553^4
 ;;^UTILITY(U,$J,358.3,9317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9317,1,3,0)
 ;;=3^Fracture of unsp facial bones, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,9317,1,4,0)
 ;;=4^S02.92XA
 ;;^UTILITY(U,$J,358.3,9317,2)
 ;;=^5020438
 ;;^UTILITY(U,$J,358.3,9318,0)
 ;;=S02.3XXA^^48^553^3
 ;;^UTILITY(U,$J,358.3,9318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9318,1,3,0)
 ;;=3^Fracture of orbital floor, init encntr for closed fracture
 ;;^UTILITY(U,$J,358.3,9318,1,4,0)
 ;;=4^S02.3XXA
 ;;^UTILITY(U,$J,358.3,9318,2)
 ;;=^5020312
 ;;^UTILITY(U,$J,358.3,9319,0)
 ;;=S02.92XB^^48^553^5
 ;;^UTILITY(U,$J,358.3,9319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9319,1,3,0)
 ;;=3^Fracture of unsp facial bones, init encntr for open fracture
 ;;^UTILITY(U,$J,358.3,9319,1,4,0)
 ;;=4^S02.92XB
 ;;^UTILITY(U,$J,358.3,9319,2)
 ;;=^5020439
 ;;^UTILITY(U,$J,358.3,9320,0)
 ;;=C00.2^^48^554^13
 ;;^UTILITY(U,$J,358.3,9320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9320,1,3,0)
 ;;=3^Malignant neoplasm of external lip, unspecified
 ;;^UTILITY(U,$J,358.3,9320,1,4,0)
 ;;=4^C00.2
 ;;^UTILITY(U,$J,358.3,9320,2)
 ;;=^5000884
 ;;^UTILITY(U,$J,358.3,9321,0)
 ;;=C02.9^^48^554^30
 ;;^UTILITY(U,$J,358.3,9321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9321,1,3,0)
 ;;=3^Malignant neoplasm of tongue, unspecified
 ;;^UTILITY(U,$J,358.3,9321,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,9321,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,9322,0)
 ;;=C07.^^48^554^24
 ;;^UTILITY(U,$J,358.3,9322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9322,1,3,0)
 ;;=3^Malignant neoplasm of parotid gland
 ;;^UTILITY(U,$J,358.3,9322,1,4,0)
 ;;=4^C07.
 ;;^UTILITY(U,$J,358.3,9322,2)
 ;;=^267005
 ;;^UTILITY(U,$J,358.3,9323,0)
 ;;=C08.0^^48^554^27
 ;;^UTILITY(U,$J,358.3,9323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9323,1,3,0)
 ;;=3^Malignant neoplasm of submandibular gland
 ;;^UTILITY(U,$J,358.3,9323,1,4,0)
 ;;=4^C08.0
 ;;^UTILITY(U,$J,358.3,9323,2)
 ;;=^267006
 ;;^UTILITY(U,$J,358.3,9324,0)
 ;;=C03.9^^48^554^16
 ;;^UTILITY(U,$J,358.3,9324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9324,1,3,0)
 ;;=3^Malignant neoplasm of gum, unspecified
 ;;^UTILITY(U,$J,358.3,9324,1,4,0)
 ;;=4^C03.9
 ;;^UTILITY(U,$J,358.3,9324,2)
 ;;=^5000892
 ;;^UTILITY(U,$J,358.3,9325,0)
 ;;=C04.9^^48^554^14
 ;;^UTILITY(U,$J,358.3,9325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9325,1,3,0)
 ;;=3^Malignant neoplasm of floor of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,9325,1,4,0)
 ;;=4^C04.9
 ;;^UTILITY(U,$J,358.3,9325,2)
 ;;=^5000896
 ;;^UTILITY(U,$J,358.3,9326,0)
 ;;=C05.2^^48^554^32
 ;;^UTILITY(U,$J,358.3,9326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9326,1,3,0)
 ;;=3^Malignant neoplasm of uvula
 ;;^UTILITY(U,$J,358.3,9326,1,4,0)
 ;;=4^C05.2
 ;;^UTILITY(U,$J,358.3,9326,2)
 ;;=^267023
 ;;^UTILITY(U,$J,358.3,9327,0)
 ;;=C06.9^^48^554^20
 ;;^UTILITY(U,$J,358.3,9327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9327,1,3,0)
 ;;=3^Malignant neoplasm of mouth, unspecified
 ;;^UTILITY(U,$J,358.3,9327,1,4,0)
 ;;=4^C06.9
 ;;^UTILITY(U,$J,358.3,9327,2)
 ;;=^5000901
 ;;^UTILITY(U,$J,358.3,9328,0)
 ;;=C09.9^^48^554^31
 ;;^UTILITY(U,$J,358.3,9328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9328,1,3,0)
 ;;=3^Malignant neoplasm of tonsil, unspecified
 ;;^UTILITY(U,$J,358.3,9328,1,4,0)
 ;;=4^C09.9
 ;;^UTILITY(U,$J,358.3,9328,2)
 ;;=^5000905
 ;;^UTILITY(U,$J,358.3,9329,0)
 ;;=C10.9^^48^554^23
 ;;^UTILITY(U,$J,358.3,9329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9329,1,3,0)
 ;;=3^Malignant neoplasm of oropharynx, unspecified
 ;;^UTILITY(U,$J,358.3,9329,1,4,0)
 ;;=4^C10.9
 ;;^UTILITY(U,$J,358.3,9329,2)
 ;;=^5000909
 ;;^UTILITY(U,$J,358.3,9330,0)
 ;;=C11.9^^48^554^22
 ;;^UTILITY(U,$J,358.3,9330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9330,1,3,0)
 ;;=3^Malignant neoplasm of nasopharynx, unspecified
 ;;^UTILITY(U,$J,358.3,9330,1,4,0)
 ;;=4^C11.9
 ;;^UTILITY(U,$J,358.3,9330,2)
 ;;=^5000911
 ;;^UTILITY(U,$J,358.3,9331,0)
 ;;=C12.^^48^554^25
 ;;^UTILITY(U,$J,358.3,9331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9331,1,3,0)
 ;;=3^Malignant neoplasm of pyriform sinus
 ;;^UTILITY(U,$J,358.3,9331,1,4,0)
 ;;=4^C12.
 ;;^UTILITY(U,$J,358.3,9331,2)
 ;;=^267046
 ;;^UTILITY(U,$J,358.3,9332,0)
 ;;=C13.9^^48^554^18
 ;;^UTILITY(U,$J,358.3,9332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9332,1,3,0)
 ;;=3^Malignant neoplasm of hypopharynx, unspecified
 ;;^UTILITY(U,$J,358.3,9332,1,4,0)
 ;;=4^C13.9
 ;;^UTILITY(U,$J,358.3,9332,2)
 ;;=^5000915
 ;;^UTILITY(U,$J,358.3,9333,0)
 ;;=C30.0^^48^554^21
 ;;^UTILITY(U,$J,358.3,9333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9333,1,3,0)
 ;;=3^Malignant neoplasm of nasal cavity
 ;;^UTILITY(U,$J,358.3,9333,1,4,0)
 ;;=4^C30.0
 ;;^UTILITY(U,$J,358.3,9333,2)
 ;;=^5000949
 ;;^UTILITY(U,$J,358.3,9334,0)
 ;;=C31.9^^48^554^12
 ;;^UTILITY(U,$J,358.3,9334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9334,1,3,0)
 ;;=3^Malignant neoplasm of accessory sinus, unspecified
