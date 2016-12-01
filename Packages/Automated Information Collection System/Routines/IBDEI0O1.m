IBDEI0O1 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30468,1,3,0)
 ;;=3^Sprain of left wrist, subsequent encounter
 ;;^UTILITY(U,$J,358.3,30468,1,4,0)
 ;;=4^S63.502D
 ;;^UTILITY(U,$J,358.3,30468,2)
 ;;=^5035587
 ;;^UTILITY(U,$J,358.3,30469,0)
 ;;=S63.501D^^86^1308^30
 ;;^UTILITY(U,$J,358.3,30469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30469,1,3,0)
 ;;=3^Sprain of right wrist, subsequent encounter
 ;;^UTILITY(U,$J,358.3,30469,1,4,0)
 ;;=4^S63.501D
 ;;^UTILITY(U,$J,358.3,30469,2)
 ;;=^5035584
 ;;^UTILITY(U,$J,358.3,30470,0)
 ;;=S52.501D^^86^1308^12
 ;;^UTILITY(U,$J,358.3,30470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30470,1,3,0)
 ;;=3^Fracture of the lower end of right radius, subs encntr
 ;;^UTILITY(U,$J,358.3,30470,1,4,0)
 ;;=4^S52.501D
 ;;^UTILITY(U,$J,358.3,30470,2)
 ;;=^5030590
 ;;^UTILITY(U,$J,358.3,30471,0)
 ;;=Z89.442^^86^1309^1
 ;;^UTILITY(U,$J,358.3,30471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30471,1,3,0)
 ;;=3^Acquired absence of left ankle
 ;;^UTILITY(U,$J,358.3,30471,1,4,0)
 ;;=4^Z89.442
 ;;^UTILITY(U,$J,358.3,30471,2)
 ;;=^5063564
 ;;^UTILITY(U,$J,358.3,30472,0)
 ;;=Z89.432^^86^1309^2
 ;;^UTILITY(U,$J,358.3,30472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30472,1,3,0)
 ;;=3^Acquired absence of left foot
 ;;^UTILITY(U,$J,358.3,30472,1,4,0)
 ;;=4^Z89.432
 ;;^UTILITY(U,$J,358.3,30472,2)
 ;;=^5063561
 ;;^UTILITY(U,$J,358.3,30473,0)
 ;;=Z89.412^^86^1309^3
 ;;^UTILITY(U,$J,358.3,30473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30473,1,3,0)
 ;;=3^Acquired absence of left great toe
 ;;^UTILITY(U,$J,358.3,30473,1,4,0)
 ;;=4^Z89.412
 ;;^UTILITY(U,$J,358.3,30473,2)
 ;;=^5063555
 ;;^UTILITY(U,$J,358.3,30474,0)
 ;;=Z89.112^^86^1309^4
 ;;^UTILITY(U,$J,358.3,30474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30474,1,3,0)
 ;;=3^Acquired absence of left hand
 ;;^UTILITY(U,$J,358.3,30474,1,4,0)
 ;;=4^Z89.112
 ;;^UTILITY(U,$J,358.3,30474,2)
 ;;=^5063538
 ;;^UTILITY(U,$J,358.3,30475,0)
 ;;=Z89.622^^86^1309^5
 ;;^UTILITY(U,$J,358.3,30475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30475,1,3,0)
 ;;=3^Acquired absence of left hip joint
 ;;^UTILITY(U,$J,358.3,30475,1,4,0)
 ;;=4^Z89.622
 ;;^UTILITY(U,$J,358.3,30475,2)
 ;;=^5063576
 ;;^UTILITY(U,$J,358.3,30476,0)
 ;;=Z89.612^^86^1309^6
 ;;^UTILITY(U,$J,358.3,30476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30476,1,3,0)
 ;;=3^Acquired absence of left leg above knee
 ;;^UTILITY(U,$J,358.3,30476,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,30476,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,30477,0)
 ;;=Z89.512^^86^1309^7
 ;;^UTILITY(U,$J,358.3,30477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30477,1,3,0)
 ;;=3^Acquired absence of left leg below knee
 ;;^UTILITY(U,$J,358.3,30477,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,30477,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,30478,0)
 ;;=Z89.212^^86^1309^8
 ;;^UTILITY(U,$J,358.3,30478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30478,1,3,0)
 ;;=3^Acquired absence of left upper limb below elbow
 ;;^UTILITY(U,$J,358.3,30478,1,4,0)
 ;;=4^Z89.212
 ;;^UTILITY(U,$J,358.3,30478,2)
 ;;=^5063546
 ;;^UTILITY(U,$J,358.3,30479,0)
 ;;=Z89.422^^86^1309^9
 ;;^UTILITY(U,$J,358.3,30479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30479,1,3,0)
 ;;=3^Acquired absence of other left toe(s)
 ;;^UTILITY(U,$J,358.3,30479,1,4,0)
 ;;=4^Z89.422
 ;;^UTILITY(U,$J,358.3,30479,2)
 ;;=^5063558
 ;;^UTILITY(U,$J,358.3,30480,0)
 ;;=Z89.421^^86^1309^10
 ;;^UTILITY(U,$J,358.3,30480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30480,1,3,0)
 ;;=3^Acquired absence of other right toe(s)
 ;;^UTILITY(U,$J,358.3,30480,1,4,0)
 ;;=4^Z89.421
 ;;^UTILITY(U,$J,358.3,30480,2)
 ;;=^5063557
 ;;^UTILITY(U,$J,358.3,30481,0)
 ;;=Z89.441^^86^1309^11
 ;;^UTILITY(U,$J,358.3,30481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30481,1,3,0)
 ;;=3^Acquired absence of right ankle
 ;;^UTILITY(U,$J,358.3,30481,1,4,0)
 ;;=4^Z89.441
 ;;^UTILITY(U,$J,358.3,30481,2)
 ;;=^5063563
 ;;^UTILITY(U,$J,358.3,30482,0)
 ;;=Z89.431^^86^1309^12
 ;;^UTILITY(U,$J,358.3,30482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30482,1,3,0)
 ;;=3^Acquired absence of right foot
 ;;^UTILITY(U,$J,358.3,30482,1,4,0)
 ;;=4^Z89.431
 ;;^UTILITY(U,$J,358.3,30482,2)
 ;;=^5063560
 ;;^UTILITY(U,$J,358.3,30483,0)
 ;;=Z89.411^^86^1309^13
 ;;^UTILITY(U,$J,358.3,30483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30483,1,3,0)
 ;;=3^Acquired absence of right great toe
 ;;^UTILITY(U,$J,358.3,30483,1,4,0)
 ;;=4^Z89.411
 ;;^UTILITY(U,$J,358.3,30483,2)
 ;;=^5063554
 ;;^UTILITY(U,$J,358.3,30484,0)
 ;;=Z89.111^^86^1309^14
 ;;^UTILITY(U,$J,358.3,30484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30484,1,3,0)
 ;;=3^Acquired absence of right hand
 ;;^UTILITY(U,$J,358.3,30484,1,4,0)
 ;;=4^Z89.111
 ;;^UTILITY(U,$J,358.3,30484,2)
 ;;=^5063537
 ;;^UTILITY(U,$J,358.3,30485,0)
 ;;=Z89.621^^86^1309^15
 ;;^UTILITY(U,$J,358.3,30485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30485,1,3,0)
 ;;=3^Acquired absence of right hip joint
 ;;^UTILITY(U,$J,358.3,30485,1,4,0)
 ;;=4^Z89.621
 ;;^UTILITY(U,$J,358.3,30485,2)
 ;;=^5063575
 ;;^UTILITY(U,$J,358.3,30486,0)
 ;;=Z89.611^^86^1309^16
 ;;^UTILITY(U,$J,358.3,30486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30486,1,3,0)
 ;;=3^Acquired absence of right leg above knee
 ;;^UTILITY(U,$J,358.3,30486,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,30486,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,30487,0)
 ;;=Z89.511^^86^1309^17
 ;;^UTILITY(U,$J,358.3,30487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30487,1,3,0)
 ;;=3^Acquired absence of right leg below knee
 ;;^UTILITY(U,$J,358.3,30487,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,30487,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,30488,0)
 ;;=Z89.211^^86^1309^18
 ;;^UTILITY(U,$J,358.3,30488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30488,1,3,0)
 ;;=3^Acquired absence of right upper limb below elbow
 ;;^UTILITY(U,$J,358.3,30488,1,4,0)
 ;;=4^Z89.211
 ;;^UTILITY(U,$J,358.3,30488,2)
 ;;=^5063545
 ;;^UTILITY(U,$J,358.3,30489,0)
 ;;=M14.60^^86^1310^1
 ;;^UTILITY(U,$J,358.3,30489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30489,1,3,0)
 ;;=3^Charcot's Joint,Unspec Site
 ;;^UTILITY(U,$J,358.3,30489,1,4,0)
 ;;=4^M14.60
 ;;^UTILITY(U,$J,358.3,30489,2)
 ;;=^5010714
 ;;^UTILITY(U,$J,358.3,30490,0)
 ;;=Z96.622^^86^1311^7
 ;;^UTILITY(U,$J,358.3,30490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30490,1,3,0)
 ;;=3^Presence of left artificial elbow joint
 ;;^UTILITY(U,$J,358.3,30490,1,4,0)
 ;;=4^Z96.622
 ;;^UTILITY(U,$J,358.3,30490,2)
 ;;=^5063696
 ;;^UTILITY(U,$J,358.3,30491,0)
 ;;=Z96.642^^86^1311^8
 ;;^UTILITY(U,$J,358.3,30491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30491,1,3,0)
 ;;=3^Presence of left artificial hip joint
 ;;^UTILITY(U,$J,358.3,30491,1,4,0)
 ;;=4^Z96.642
 ;;^UTILITY(U,$J,358.3,30491,2)
 ;;=^5063702
 ;;^UTILITY(U,$J,358.3,30492,0)
 ;;=Z96.652^^86^1311^9
 ;;^UTILITY(U,$J,358.3,30492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30492,1,3,0)
 ;;=3^Presence of left artificial knee joint
 ;;^UTILITY(U,$J,358.3,30492,1,4,0)
 ;;=4^Z96.652
 ;;^UTILITY(U,$J,358.3,30492,2)
 ;;=^5063706
 ;;^UTILITY(U,$J,358.3,30493,0)
 ;;=Z96.612^^86^1311^10
 ;;^UTILITY(U,$J,358.3,30493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30493,1,3,0)
 ;;=3^Presence of left artificial shoulder joint
 ;;^UTILITY(U,$J,358.3,30493,1,4,0)
 ;;=4^Z96.612
 ;;^UTILITY(U,$J,358.3,30493,2)
 ;;=^5063693
 ;;^UTILITY(U,$J,358.3,30494,0)
 ;;=Z96.621^^86^1311^11
 ;;^UTILITY(U,$J,358.3,30494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30494,1,3,0)
 ;;=3^Presence of right artificial elbow joint
 ;;^UTILITY(U,$J,358.3,30494,1,4,0)
 ;;=4^Z96.621
 ;;^UTILITY(U,$J,358.3,30494,2)
 ;;=^5063695
 ;;^UTILITY(U,$J,358.3,30495,0)
 ;;=Z96.641^^86^1311^12
 ;;^UTILITY(U,$J,358.3,30495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30495,1,3,0)
 ;;=3^Presence of right artificial hip joint
 ;;^UTILITY(U,$J,358.3,30495,1,4,0)
 ;;=4^Z96.641
 ;;^UTILITY(U,$J,358.3,30495,2)
 ;;=^5063701
 ;;^UTILITY(U,$J,358.3,30496,0)
 ;;=Z96.651^^86^1311^13
 ;;^UTILITY(U,$J,358.3,30496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30496,1,3,0)
 ;;=3^Presence of right artificial knee joint
 ;;^UTILITY(U,$J,358.3,30496,1,4,0)
 ;;=4^Z96.651
 ;;^UTILITY(U,$J,358.3,30496,2)
 ;;=^5063705
 ;;^UTILITY(U,$J,358.3,30497,0)
 ;;=Z96.611^^86^1311^14
 ;;^UTILITY(U,$J,358.3,30497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30497,1,3,0)
 ;;=3^Presence of right artificial shoulder joint
 ;;^UTILITY(U,$J,358.3,30497,1,4,0)
 ;;=4^Z96.611
 ;;^UTILITY(U,$J,358.3,30497,2)
 ;;=^5063692
 ;;^UTILITY(U,$J,358.3,30498,0)
 ;;=Z47.1^^86^1311^1
 ;;^UTILITY(U,$J,358.3,30498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30498,1,3,0)
 ;;=3^Aftercare Following Joint Replacement Surgery
 ;;^UTILITY(U,$J,358.3,30498,1,4,0)
 ;;=4^Z47.1
 ;;^UTILITY(U,$J,358.3,30498,2)
 ;;=^5063025
 ;;^UTILITY(U,$J,358.3,30499,0)
 ;;=Z48.01^^86^1311^2
 ;;^UTILITY(U,$J,358.3,30499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30499,1,3,0)
 ;;=3^Change/Remove Surgical Wound Dressing
 ;;^UTILITY(U,$J,358.3,30499,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,30499,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,30500,0)
 ;;=Z48.02^^86^1311^15
 ;;^UTILITY(U,$J,358.3,30500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30500,1,3,0)
 ;;=3^Suture Removal
 ;;^UTILITY(U,$J,358.3,30500,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,30500,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,30501,0)
 ;;=Z46.89^^86^1311^4
 ;;^UTILITY(U,$J,358.3,30501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30501,1,3,0)
 ;;=3^Fitting/Adjustment of Brace/Cast/Corset/Shoe
 ;;^UTILITY(U,$J,358.3,30501,1,4,0)
 ;;=4^Z46.89
 ;;^UTILITY(U,$J,358.3,30501,2)
 ;;=^5063023
 ;;^UTILITY(U,$J,358.3,30502,0)
 ;;=Z09.^^86^1311^3
 ;;^UTILITY(U,$J,358.3,30502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30502,1,3,0)
 ;;=3^F/U Exam After Treatment Other Than Malig Neop
 ;;^UTILITY(U,$J,358.3,30502,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,30502,2)
 ;;=^5062668
