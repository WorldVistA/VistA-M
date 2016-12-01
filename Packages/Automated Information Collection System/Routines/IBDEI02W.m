IBDEI02W ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3366,0)
 ;;=R10.30^^20^250^7
 ;;^UTILITY(U,$J,358.3,3366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3366,1,3,0)
 ;;=3^Lower Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,3366,1,4,0)
 ;;=4^R10.30
 ;;^UTILITY(U,$J,358.3,3366,2)
 ;;=^5019210
 ;;^UTILITY(U,$J,358.3,3367,0)
 ;;=R10.2^^20^250^8
 ;;^UTILITY(U,$J,358.3,3367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3367,1,3,0)
 ;;=3^Pelvic/Perineal Pain
 ;;^UTILITY(U,$J,358.3,3367,1,4,0)
 ;;=4^R10.2
 ;;^UTILITY(U,$J,358.3,3367,2)
 ;;=^5019209
 ;;^UTILITY(U,$J,358.3,3368,0)
 ;;=R10.10^^20^250^12
 ;;^UTILITY(U,$J,358.3,3368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3368,1,3,0)
 ;;=3^Upper Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,3368,1,4,0)
 ;;=4^R10.10
 ;;^UTILITY(U,$J,358.3,3368,2)
 ;;=^5019205
 ;;^UTILITY(U,$J,358.3,3369,0)
 ;;=Z48.00^^20^251^12
 ;;^UTILITY(U,$J,358.3,3369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3369,1,3,0)
 ;;=3^Change/Removal Nonsurgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,3369,1,4,0)
 ;;=4^Z48.00
 ;;^UTILITY(U,$J,358.3,3369,2)
 ;;=^5063033
 ;;^UTILITY(U,$J,358.3,3370,0)
 ;;=Z48.01^^20^251^13
 ;;^UTILITY(U,$J,358.3,3370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3370,1,3,0)
 ;;=3^Change/Removal Surgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,3370,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,3370,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,3371,0)
 ;;=Z48.02^^20^251^16
 ;;^UTILITY(U,$J,358.3,3371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3371,1,3,0)
 ;;=3^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,3371,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,3371,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,3372,0)
 ;;=Z48.3^^20^251^4
 ;;^UTILITY(U,$J,358.3,3372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3372,1,3,0)
 ;;=3^Aftercare Following Neoplasm Surgery
 ;;^UTILITY(U,$J,358.3,3372,1,4,0)
 ;;=4^Z48.3
 ;;^UTILITY(U,$J,358.3,3372,2)
 ;;=^5063046
 ;;^UTILITY(U,$J,358.3,3373,0)
 ;;=Z48.810^^20^251^7
 ;;^UTILITY(U,$J,358.3,3373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3373,1,3,0)
 ;;=3^Aftercare Following Sense Organ Surgery
 ;;^UTILITY(U,$J,358.3,3373,1,4,0)
 ;;=4^Z48.810
 ;;^UTILITY(U,$J,358.3,3373,2)
 ;;=^5063047
 ;;^UTILITY(U,$J,358.3,3374,0)
 ;;=Z48.811^^20^251^5
 ;;^UTILITY(U,$J,358.3,3374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3374,1,3,0)
 ;;=3^Aftercare Following Nervous System Surgery
 ;;^UTILITY(U,$J,358.3,3374,1,4,0)
 ;;=4^Z48.811
 ;;^UTILITY(U,$J,358.3,3374,2)
 ;;=^5063048
 ;;^UTILITY(U,$J,358.3,3375,0)
 ;;=Z48.812^^20^251^1
 ;;^UTILITY(U,$J,358.3,3375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3375,1,3,0)
 ;;=3^Aftercare Following Circulatory System Surgery
 ;;^UTILITY(U,$J,358.3,3375,1,4,0)
 ;;=4^Z48.812
 ;;^UTILITY(U,$J,358.3,3375,2)
 ;;=^5063049
 ;;^UTILITY(U,$J,358.3,3376,0)
 ;;=Z48.813^^20^251^6
 ;;^UTILITY(U,$J,358.3,3376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3376,1,3,0)
 ;;=3^Aftercare Following Respiratory System Surgery
 ;;^UTILITY(U,$J,358.3,3376,1,4,0)
 ;;=4^Z48.813
 ;;^UTILITY(U,$J,358.3,3376,2)
 ;;=^5063050
 ;;^UTILITY(U,$J,358.3,3377,0)
 ;;=Z48.814^^20^251^10
 ;;^UTILITY(U,$J,358.3,3377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3377,1,3,0)
 ;;=3^Aftercare Following Teeth/Oral Cavity Surgery
 ;;^UTILITY(U,$J,358.3,3377,1,4,0)
 ;;=4^Z48.814
 ;;^UTILITY(U,$J,358.3,3377,2)
 ;;=^5063051
 ;;^UTILITY(U,$J,358.3,3378,0)
 ;;=Z48.815^^20^251^2
 ;;^UTILITY(U,$J,358.3,3378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3378,1,3,0)
 ;;=3^Aftercare Following Digestive System Surgery
 ;;^UTILITY(U,$J,358.3,3378,1,4,0)
 ;;=4^Z48.815
 ;;^UTILITY(U,$J,358.3,3378,2)
 ;;=^5063052
 ;;^UTILITY(U,$J,358.3,3379,0)
 ;;=Z48.816^^20^251^3
 ;;^UTILITY(U,$J,358.3,3379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3379,1,3,0)
 ;;=3^Aftercare Following GU System Surgery
 ;;^UTILITY(U,$J,358.3,3379,1,4,0)
 ;;=4^Z48.816
 ;;^UTILITY(U,$J,358.3,3379,2)
 ;;=^5063053
 ;;^UTILITY(U,$J,358.3,3380,0)
 ;;=Z48.817^^20^251^8
 ;;^UTILITY(U,$J,358.3,3380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3380,1,3,0)
 ;;=3^Aftercare Following Skin Surgery
 ;;^UTILITY(U,$J,358.3,3380,1,4,0)
 ;;=4^Z48.817
 ;;^UTILITY(U,$J,358.3,3380,2)
 ;;=^5063054
 ;;^UTILITY(U,$J,358.3,3381,0)
 ;;=Z48.89^^20^251^9
 ;;^UTILITY(U,$J,358.3,3381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3381,1,3,0)
 ;;=3^Aftercare Following Surgery NEC
 ;;^UTILITY(U,$J,358.3,3381,1,4,0)
 ;;=4^Z48.89
 ;;^UTILITY(U,$J,358.3,3381,2)
 ;;=^5063055
 ;;^UTILITY(U,$J,358.3,3382,0)
 ;;=Z09.^^20^251^11
 ;;^UTILITY(U,$J,358.3,3382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3382,1,3,0)
 ;;=3^Aftercare Following Treatment for Condition Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,3382,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,3382,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,3383,0)
 ;;=Z48.1^^20^251^14
 ;;^UTILITY(U,$J,358.3,3383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3383,1,3,0)
 ;;=3^Planned Postproc Wound Closure
 ;;^UTILITY(U,$J,358.3,3383,1,4,0)
 ;;=4^Z48.1
 ;;^UTILITY(U,$J,358.3,3383,2)
 ;;=^5063037
 ;;^UTILITY(U,$J,358.3,3384,0)
 ;;=Z48.03^^20^251^15
 ;;^UTILITY(U,$J,358.3,3384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3384,1,3,0)
 ;;=3^Removal of Drains
 ;;^UTILITY(U,$J,358.3,3384,1,4,0)
 ;;=4^Z48.03
 ;;^UTILITY(U,$J,358.3,3384,2)
 ;;=^5063036
 ;;^UTILITY(U,$J,358.3,3385,0)
 ;;=D23.0^^20^252^11
 ;;^UTILITY(U,$J,358.3,3385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3385,1,3,0)
 ;;=3^Benign Neop of Skin of Lip
 ;;^UTILITY(U,$J,358.3,3385,1,4,0)
 ;;=4^D23.0
 ;;^UTILITY(U,$J,358.3,3385,2)
 ;;=^5002059
 ;;^UTILITY(U,$J,358.3,3386,0)
 ;;=D22.0^^20^252^20
 ;;^UTILITY(U,$J,358.3,3386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3386,1,3,0)
 ;;=3^Melanocytic Nevi of Lip
 ;;^UTILITY(U,$J,358.3,3386,1,4,0)
 ;;=4^D22.0
 ;;^UTILITY(U,$J,358.3,3386,2)
 ;;=^5002041
 ;;^UTILITY(U,$J,358.3,3387,0)
 ;;=D22.12^^20^252^17
 ;;^UTILITY(U,$J,358.3,3387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3387,1,3,0)
 ;;=3^Melanocytic Nevi of Left Eyelid
 ;;^UTILITY(U,$J,358.3,3387,1,4,0)
 ;;=4^D22.12
 ;;^UTILITY(U,$J,358.3,3387,2)
 ;;=^5002044
 ;;^UTILITY(U,$J,358.3,3388,0)
 ;;=D23.11^^20^252^7
 ;;^UTILITY(U,$J,358.3,3388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3388,1,3,0)
 ;;=3^Benign Neop of Right Eyelid
 ;;^UTILITY(U,$J,358.3,3388,1,4,0)
 ;;=4^D23.11
 ;;^UTILITY(U,$J,358.3,3388,2)
 ;;=^5002061
 ;;^UTILITY(U,$J,358.3,3389,0)
 ;;=D23.12^^20^252^3
 ;;^UTILITY(U,$J,358.3,3389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3389,1,3,0)
 ;;=3^Benign Neop of Left Eyelid
 ;;^UTILITY(U,$J,358.3,3389,1,4,0)
 ;;=4^D23.12
 ;;^UTILITY(U,$J,358.3,3389,2)
 ;;=^5002062
 ;;^UTILITY(U,$J,358.3,3390,0)
 ;;=D22.11^^20^252^22
 ;;^UTILITY(U,$J,358.3,3390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3390,1,3,0)
 ;;=3^Melanocytic Nevi of Right Eyelid
 ;;^UTILITY(U,$J,358.3,3390,1,4,0)
 ;;=4^D22.11
 ;;^UTILITY(U,$J,358.3,3390,2)
 ;;=^5002043
 ;;^UTILITY(U,$J,358.3,3391,0)
 ;;=D23.21^^20^252^6
 ;;^UTILITY(U,$J,358.3,3391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3391,1,3,0)
 ;;=3^Benign Neop of Right Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,3391,1,4,0)
 ;;=4^D23.21
 ;;^UTILITY(U,$J,358.3,3391,2)
 ;;=^5002064
 ;;^UTILITY(U,$J,358.3,3392,0)
 ;;=D23.22^^20^252^2
 ;;^UTILITY(U,$J,358.3,3392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3392,1,3,0)
 ;;=3^Benign Neop of Left Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,3392,1,4,0)
 ;;=4^D23.22
 ;;^UTILITY(U,$J,358.3,3392,2)
 ;;=^5002065
 ;;^UTILITY(U,$J,358.3,3393,0)
 ;;=D22.22^^20^252^16
 ;;^UTILITY(U,$J,358.3,3393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3393,1,3,0)
 ;;=3^Melanocytic Nevi of Left Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,3393,1,4,0)
 ;;=4^D22.22
 ;;^UTILITY(U,$J,358.3,3393,2)
 ;;=^5002047
 ;;^UTILITY(U,$J,358.3,3394,0)
 ;;=D22.39^^20^252^14
 ;;^UTILITY(U,$J,358.3,3394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3394,1,3,0)
 ;;=3^Melanocytic Nevi of Face NEC
 ;;^UTILITY(U,$J,358.3,3394,1,4,0)
 ;;=4^D22.39
 ;;^UTILITY(U,$J,358.3,3394,2)
 ;;=^5002049
 ;;^UTILITY(U,$J,358.3,3395,0)
 ;;=D22.30^^20^252^15
 ;;^UTILITY(U,$J,358.3,3395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3395,1,3,0)
 ;;=3^Melanocytic Nevi of Face,Unspec
 ;;^UTILITY(U,$J,358.3,3395,1,4,0)
 ;;=4^D22.30
 ;;^UTILITY(U,$J,358.3,3395,2)
 ;;=^5002048
 ;;^UTILITY(U,$J,358.3,3396,0)
 ;;=D23.39^^20^252^1
 ;;^UTILITY(U,$J,358.3,3396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3396,1,3,0)
 ;;=3^Benign Neop of Face NEC
 ;;^UTILITY(U,$J,358.3,3396,1,4,0)
 ;;=4^D23.39
 ;;^UTILITY(U,$J,358.3,3396,2)
 ;;=^5002067
 ;;^UTILITY(U,$J,358.3,3397,0)
 ;;=D23.4^^20^252^10
 ;;^UTILITY(U,$J,358.3,3397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3397,1,3,0)
 ;;=3^Benign Neop of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,3397,1,4,0)
 ;;=4^D23.4
 ;;^UTILITY(U,$J,358.3,3397,2)
 ;;=^5002068
 ;;^UTILITY(U,$J,358.3,3398,0)
 ;;=D22.4^^20^252^25
 ;;^UTILITY(U,$J,358.3,3398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3398,1,3,0)
 ;;=3^Melanocytic Nevi of Scalp/Neck
 ;;^UTILITY(U,$J,358.3,3398,1,4,0)
 ;;=4^D22.4
 ;;^UTILITY(U,$J,358.3,3398,2)
 ;;=^5002050
 ;;^UTILITY(U,$J,358.3,3399,0)
 ;;=D22.5^^20^252^26
 ;;^UTILITY(U,$J,358.3,3399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3399,1,3,0)
 ;;=3^Melanocytic Nevi of Trunk
 ;;^UTILITY(U,$J,358.3,3399,1,4,0)
 ;;=4^D22.5
 ;;^UTILITY(U,$J,358.3,3399,2)
 ;;=^5002051
 ;;^UTILITY(U,$J,358.3,3400,0)
 ;;=D23.5^^20^252^13
 ;;^UTILITY(U,$J,358.3,3400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3400,1,3,0)
 ;;=3^Benign Neop of Trunk
 ;;^UTILITY(U,$J,358.3,3400,1,4,0)
 ;;=4^D23.5
 ;;^UTILITY(U,$J,358.3,3400,2)
 ;;=^5002069
 ;;^UTILITY(U,$J,358.3,3401,0)
 ;;=D22.61^^20^252^24
 ;;^UTILITY(U,$J,358.3,3401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3401,1,3,0)
 ;;=3^Melanocytic Nevi of Right Upper Limb
 ;;^UTILITY(U,$J,358.3,3401,1,4,0)
 ;;=4^D22.61
 ;;^UTILITY(U,$J,358.3,3401,2)
 ;;=^5002053
 ;;^UTILITY(U,$J,358.3,3402,0)
 ;;=D22.62^^20^252^19
