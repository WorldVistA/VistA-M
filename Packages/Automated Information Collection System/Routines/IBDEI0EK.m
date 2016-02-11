IBDEI0EK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6356,1,3,0)
 ;;=3^Puncture Wound w/o FB of Right Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,6356,1,4,0)
 ;;=4^S91.331A
 ;;^UTILITY(U,$J,358.3,6356,2)
 ;;=^5044332
 ;;^UTILITY(U,$J,358.3,6357,0)
 ;;=S71.031A^^40^388^46
 ;;^UTILITY(U,$J,358.3,6357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6357,1,3,0)
 ;;=3^Puncture Wound w/o FB of Right Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,6357,1,4,0)
 ;;=4^S71.031A
 ;;^UTILITY(U,$J,358.3,6357,2)
 ;;=^5036987
 ;;^UTILITY(U,$J,358.3,6358,0)
 ;;=S81.031A^^40^388^49
 ;;^UTILITY(U,$J,358.3,6358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6358,1,3,0)
 ;;=3^Puncture Wound w/o FB of Right Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,6358,1,4,0)
 ;;=4^S81.031A
 ;;^UTILITY(U,$J,358.3,6358,2)
 ;;=^5040044
 ;;^UTILITY(U,$J,358.3,6359,0)
 ;;=S81.831A^^40^388^54
 ;;^UTILITY(U,$J,358.3,6359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6359,1,3,0)
 ;;=3^Puncture Wound w/o FB of Right Lower Leg,Init Encntr
 ;;^UTILITY(U,$J,358.3,6359,1,4,0)
 ;;=4^S81.831A
 ;;^UTILITY(U,$J,358.3,6359,2)
 ;;=^5040083
 ;;^UTILITY(U,$J,358.3,6360,0)
 ;;=S71.131A^^40^388^60
 ;;^UTILITY(U,$J,358.3,6360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6360,1,3,0)
 ;;=3^Puncture Wound w/o FB of Right Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,6360,1,4,0)
 ;;=4^S71.131A
 ;;^UTILITY(U,$J,358.3,6360,2)
 ;;=^5037026
 ;;^UTILITY(U,$J,358.3,6361,0)
 ;;=Z01.83^^40^389^1
 ;;^UTILITY(U,$J,358.3,6361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6361,1,3,0)
 ;;=3^Encounter for Blood Typing
 ;;^UTILITY(U,$J,358.3,6361,1,4,0)
 ;;=4^Z01.83
 ;;^UTILITY(U,$J,358.3,6361,2)
 ;;=^5062630
 ;;^UTILITY(U,$J,358.3,6362,0)
 ;;=Z01.810^^40^389^2
 ;;^UTILITY(U,$J,358.3,6362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6362,1,3,0)
 ;;=3^Encounter for Preproc Cardiovascular Exam
 ;;^UTILITY(U,$J,358.3,6362,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,6362,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,6363,0)
 ;;=Z01.812^^40^389^4
 ;;^UTILITY(U,$J,358.3,6363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6363,1,3,0)
 ;;=3^Encounter for Preproc Laboratory Exam
 ;;^UTILITY(U,$J,358.3,6363,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,6363,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,6364,0)
 ;;=Z01.818^^40^389^3
 ;;^UTILITY(U,$J,358.3,6364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6364,1,3,0)
 ;;=3^Encounter for Preproc Exam,Unspec
 ;;^UTILITY(U,$J,358.3,6364,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,6364,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,6365,0)
 ;;=Z01.811^^40^389^5
 ;;^UTILITY(U,$J,358.3,6365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6365,1,3,0)
 ;;=3^Encounter for Preproc Respiratory Exam
 ;;^UTILITY(U,$J,358.3,6365,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,6365,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,6366,0)
 ;;=99201^^41^390^1
 ;;^UTILITY(U,$J,358.3,6366,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6366,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,6366,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,6367,0)
 ;;=99202^^41^390^2
 ;;^UTILITY(U,$J,358.3,6367,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6367,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,6367,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,6368,0)
 ;;=99203^^41^390^3
 ;;^UTILITY(U,$J,358.3,6368,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6368,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,6368,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,6369,0)
 ;;=99204^^41^390^4
 ;;^UTILITY(U,$J,358.3,6369,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6369,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,6369,1,2,0)
 ;;=2^99204
