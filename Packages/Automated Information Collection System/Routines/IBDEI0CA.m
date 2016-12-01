IBDEI0CA ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15567,1,2,0)
 ;;=2^Serv Asmnt/Care Plan Waiver
 ;;^UTILITY(U,$J,358.3,15567,1,3,0)
 ;;=3^T2024
 ;;^UTILITY(U,$J,358.3,15568,0)
 ;;=97110^^46^700^5^^^^1
 ;;^UTILITY(U,$J,358.3,15568,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15568,1,2,0)
 ;;=2^Therapeutic Exercises
 ;;^UTILITY(U,$J,358.3,15568,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,15569,0)
 ;;=97116^^46^700^1^^^^1
 ;;^UTILITY(U,$J,358.3,15569,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15569,1,2,0)
 ;;=2^Gait Training Therapy
 ;;^UTILITY(U,$J,358.3,15569,1,3,0)
 ;;=3^97116
 ;;^UTILITY(U,$J,358.3,15570,0)
 ;;=97530^^46^700^4^^^^1
 ;;^UTILITY(U,$J,358.3,15570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15570,1,2,0)
 ;;=2^Therapeutic Activities
 ;;^UTILITY(U,$J,358.3,15570,1,3,0)
 ;;=3^97530
 ;;^UTILITY(U,$J,358.3,15571,0)
 ;;=97542^^46^700^6^^^^1
 ;;^UTILITY(U,$J,358.3,15571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15571,1,2,0)
 ;;=2^Wheelchair Mgmt Training
 ;;^UTILITY(U,$J,358.3,15571,1,3,0)
 ;;=3^97542
 ;;^UTILITY(U,$J,358.3,15572,0)
 ;;=G0153^^46^701^1^^^^1
 ;;^UTILITY(U,$J,358.3,15572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15572,1,2,0)
 ;;=2^Speech-Language Therapy,Ea 15min
 ;;^UTILITY(U,$J,358.3,15572,1,3,0)
 ;;=3^G0153
 ;;^UTILITY(U,$J,358.3,15573,0)
 ;;=Z89.012^^47^702^10
 ;;^UTILITY(U,$J,358.3,15573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15573,1,3,0)
 ;;=3^Acquired absence of left thumb
 ;;^UTILITY(U,$J,358.3,15573,1,4,0)
 ;;=4^Z89.012
 ;;^UTILITY(U,$J,358.3,15573,2)
 ;;=^5063532
 ;;^UTILITY(U,$J,358.3,15574,0)
 ;;=Z89.011^^47^702^25
 ;;^UTILITY(U,$J,358.3,15574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15574,1,3,0)
 ;;=3^Acquired absence of right thumb
 ;;^UTILITY(U,$J,358.3,15574,1,4,0)
 ;;=4^Z89.011
 ;;^UTILITY(U,$J,358.3,15574,2)
 ;;=^5063531
 ;;^UTILITY(U,$J,358.3,15575,0)
 ;;=Z89.021^^47^702^16
 ;;^UTILITY(U,$J,358.3,15575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15575,1,3,0)
 ;;=3^Acquired absence of right finger(s)
 ;;^UTILITY(U,$J,358.3,15575,1,4,0)
 ;;=4^Z89.021
 ;;^UTILITY(U,$J,358.3,15575,2)
 ;;=^5063534
 ;;^UTILITY(U,$J,358.3,15576,0)
 ;;=Z89.022^^47^702^2
 ;;^UTILITY(U,$J,358.3,15576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15576,1,3,0)
 ;;=3^Acquired absence of left finger(s)
 ;;^UTILITY(U,$J,358.3,15576,1,4,0)
 ;;=4^Z89.022
 ;;^UTILITY(U,$J,358.3,15576,2)
 ;;=^5063535
 ;;^UTILITY(U,$J,358.3,15577,0)
 ;;=Z89.112^^47^702^5
 ;;^UTILITY(U,$J,358.3,15577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15577,1,3,0)
 ;;=3^Acquired absence of left hand
 ;;^UTILITY(U,$J,358.3,15577,1,4,0)
 ;;=4^Z89.112
 ;;^UTILITY(U,$J,358.3,15577,2)
 ;;=^5063538
 ;;^UTILITY(U,$J,358.3,15578,0)
 ;;=Z89.111^^47^702^19
 ;;^UTILITY(U,$J,358.3,15578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15578,1,3,0)
 ;;=3^Acquired absence of right hand
 ;;^UTILITY(U,$J,358.3,15578,1,4,0)
 ;;=4^Z89.111
 ;;^UTILITY(U,$J,358.3,15578,2)
 ;;=^5063537
 ;;^UTILITY(U,$J,358.3,15579,0)
 ;;=Z89.122^^47^702^14
 ;;^UTILITY(U,$J,358.3,15579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15579,1,3,0)
 ;;=3^Acquired absence of left wrist
 ;;^UTILITY(U,$J,358.3,15579,1,4,0)
 ;;=4^Z89.122
 ;;^UTILITY(U,$J,358.3,15579,2)
 ;;=^5063541
 ;;^UTILITY(U,$J,358.3,15580,0)
 ;;=Z89.121^^47^702^29
 ;;^UTILITY(U,$J,358.3,15580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15580,1,3,0)
 ;;=3^Acquired absence of right wrist
 ;;^UTILITY(U,$J,358.3,15580,1,4,0)
 ;;=4^Z89.121
 ;;^UTILITY(U,$J,358.3,15580,2)
 ;;=^5063540
 ;;^UTILITY(U,$J,358.3,15581,0)
 ;;=Z89.211^^47^702^28
 ;;^UTILITY(U,$J,358.3,15581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15581,1,3,0)
 ;;=3^Acquired absence of right upper limb below elbow
 ;;^UTILITY(U,$J,358.3,15581,1,4,0)
 ;;=4^Z89.211
 ;;^UTILITY(U,$J,358.3,15581,2)
 ;;=^5063545
 ;;^UTILITY(U,$J,358.3,15582,0)
 ;;=Z89.212^^47^702^13
 ;;^UTILITY(U,$J,358.3,15582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15582,1,3,0)
 ;;=3^Acquired absence of left upper limb below elbow
 ;;^UTILITY(U,$J,358.3,15582,1,4,0)
 ;;=4^Z89.212
 ;;^UTILITY(U,$J,358.3,15582,2)
 ;;=^5063546
 ;;^UTILITY(U,$J,358.3,15583,0)
 ;;=Z89.221^^47^702^27
 ;;^UTILITY(U,$J,358.3,15583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15583,1,3,0)
 ;;=3^Acquired absence of right upper limb above elbow
 ;;^UTILITY(U,$J,358.3,15583,1,4,0)
 ;;=4^Z89.221
 ;;^UTILITY(U,$J,358.3,15583,2)
 ;;=^5063548
 ;;^UTILITY(U,$J,358.3,15584,0)
 ;;=Z89.222^^47^702^12
 ;;^UTILITY(U,$J,358.3,15584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15584,1,3,0)
 ;;=3^Acquired absence of left upper limb above elbow
 ;;^UTILITY(U,$J,358.3,15584,1,4,0)
 ;;=4^Z89.222
 ;;^UTILITY(U,$J,358.3,15584,2)
 ;;=^5063549
 ;;^UTILITY(U,$J,358.3,15585,0)
 ;;=Z89.232^^47^702^9
 ;;^UTILITY(U,$J,358.3,15585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15585,1,3,0)
 ;;=3^Acquired absence of left shoulder
 ;;^UTILITY(U,$J,358.3,15585,1,4,0)
 ;;=4^Z89.232
 ;;^UTILITY(U,$J,358.3,15585,2)
 ;;=^5063552
 ;;^UTILITY(U,$J,358.3,15586,0)
 ;;=Z89.231^^47^702^24
 ;;^UTILITY(U,$J,358.3,15586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15586,1,3,0)
 ;;=3^Acquired absence of right shoulder
 ;;^UTILITY(U,$J,358.3,15586,1,4,0)
 ;;=4^Z89.231
 ;;^UTILITY(U,$J,358.3,15586,2)
 ;;=^5063551
 ;;^UTILITY(U,$J,358.3,15587,0)
 ;;=Z89.611^^47^702^21
 ;;^UTILITY(U,$J,358.3,15587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15587,1,3,0)
 ;;=3^Acquired absence of right leg above knee
 ;;^UTILITY(U,$J,358.3,15587,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,15587,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,15588,0)
 ;;=Z89.411^^47^702^18
 ;;^UTILITY(U,$J,358.3,15588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15588,1,3,0)
 ;;=3^Acquired absence of right great toe
 ;;^UTILITY(U,$J,358.3,15588,1,4,0)
 ;;=4^Z89.411
 ;;^UTILITY(U,$J,358.3,15588,2)
 ;;=^5063554
 ;;^UTILITY(U,$J,358.3,15589,0)
 ;;=Z89.412^^47^702^4
 ;;^UTILITY(U,$J,358.3,15589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15589,1,3,0)
 ;;=3^Acquired absence of left great toe
 ;;^UTILITY(U,$J,358.3,15589,1,4,0)
 ;;=4^Z89.412
 ;;^UTILITY(U,$J,358.3,15589,2)
 ;;=^5063555
 ;;^UTILITY(U,$J,358.3,15590,0)
 ;;=Z89.422^^47^702^11
 ;;^UTILITY(U,$J,358.3,15590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15590,1,3,0)
 ;;=3^Acquired absence of left toe(s)
 ;;^UTILITY(U,$J,358.3,15590,1,4,0)
 ;;=4^Z89.422
 ;;^UTILITY(U,$J,358.3,15590,2)
 ;;=^5063558
 ;;^UTILITY(U,$J,358.3,15591,0)
 ;;=Z89.421^^47^702^26
 ;;^UTILITY(U,$J,358.3,15591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15591,1,3,0)
 ;;=3^Acquired absence of right toe(s)
 ;;^UTILITY(U,$J,358.3,15591,1,4,0)
 ;;=4^Z89.421
 ;;^UTILITY(U,$J,358.3,15591,2)
 ;;=^5063557
 ;;^UTILITY(U,$J,358.3,15592,0)
 ;;=Z89.431^^47^702^17
 ;;^UTILITY(U,$J,358.3,15592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15592,1,3,0)
 ;;=3^Acquired absence of right foot
 ;;^UTILITY(U,$J,358.3,15592,1,4,0)
 ;;=4^Z89.431
 ;;^UTILITY(U,$J,358.3,15592,2)
 ;;=^5063560
 ;;^UTILITY(U,$J,358.3,15593,0)
 ;;=Z89.432^^47^702^3
 ;;^UTILITY(U,$J,358.3,15593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15593,1,3,0)
 ;;=3^Acquired absence of left foot
 ;;^UTILITY(U,$J,358.3,15593,1,4,0)
 ;;=4^Z89.432
 ;;^UTILITY(U,$J,358.3,15593,2)
 ;;=^5063561
 ;;^UTILITY(U,$J,358.3,15594,0)
 ;;=Z89.442^^47^702^1
 ;;^UTILITY(U,$J,358.3,15594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15594,1,3,0)
 ;;=3^Acquired absence of left ankle
 ;;^UTILITY(U,$J,358.3,15594,1,4,0)
 ;;=4^Z89.442
 ;;^UTILITY(U,$J,358.3,15594,2)
 ;;=^5063564
 ;;^UTILITY(U,$J,358.3,15595,0)
 ;;=Z89.441^^47^702^15
 ;;^UTILITY(U,$J,358.3,15595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15595,1,3,0)
 ;;=3^Acquired absence of right ankle
 ;;^UTILITY(U,$J,358.3,15595,1,4,0)
 ;;=4^Z89.441
 ;;^UTILITY(U,$J,358.3,15595,2)
 ;;=^5063563
 ;;^UTILITY(U,$J,358.3,15596,0)
 ;;=Z89.511^^47^702^23
 ;;^UTILITY(U,$J,358.3,15596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15596,1,3,0)
 ;;=3^Acquired absence of right leg below knee
 ;;^UTILITY(U,$J,358.3,15596,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,15596,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,15597,0)
 ;;=Z89.512^^47^702^8
 ;;^UTILITY(U,$J,358.3,15597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15597,1,3,0)
 ;;=3^Acquired absence of left leg below knee
 ;;^UTILITY(U,$J,358.3,15597,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,15597,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,15598,0)
 ;;=Z89.611^^47^702^22
 ;;^UTILITY(U,$J,358.3,15598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15598,1,3,0)
 ;;=3^Acquired absence of right leg above knee
 ;;^UTILITY(U,$J,358.3,15598,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,15598,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,15599,0)
 ;;=Z89.612^^47^702^7
 ;;^UTILITY(U,$J,358.3,15599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15599,1,3,0)
 ;;=3^Acquired absence of left leg above knee
 ;;^UTILITY(U,$J,358.3,15599,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,15599,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,15600,0)
 ;;=Z89.622^^47^702^6
 ;;^UTILITY(U,$J,358.3,15600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15600,1,3,0)
 ;;=3^Acquired absence of left hip joint
 ;;^UTILITY(U,$J,358.3,15600,1,4,0)
 ;;=4^Z89.622
 ;;^UTILITY(U,$J,358.3,15600,2)
 ;;=^5063576
 ;;^UTILITY(U,$J,358.3,15601,0)
 ;;=Z89.621^^47^702^20
 ;;^UTILITY(U,$J,358.3,15601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15601,1,3,0)
 ;;=3^Acquired absence of right hip joint
 ;;^UTILITY(U,$J,358.3,15601,1,4,0)
 ;;=4^Z89.621
 ;;^UTILITY(U,$J,358.3,15601,2)
 ;;=^5063575
 ;;^UTILITY(U,$J,358.3,15602,0)
 ;;=R47.01^^47^703^1
 ;;^UTILITY(U,$J,358.3,15602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15602,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,15602,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,15602,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,15603,0)
 ;;=I69.320^^47^703^2
 ;;^UTILITY(U,$J,358.3,15603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15603,1,3,0)
 ;;=3^Aphasia following cerebral infarction
