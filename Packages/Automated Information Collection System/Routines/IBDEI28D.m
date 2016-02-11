IBDEI28D ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37466,1,3,0)
 ;;=3^Bilateral post-traumatic osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,37466,1,4,0)
 ;;=4^M17.2
 ;;^UTILITY(U,$J,358.3,37466,2)
 ;;=^5010788
 ;;^UTILITY(U,$J,358.3,37467,0)
 ;;=M17.31^^172^1884^51
 ;;^UTILITY(U,$J,358.3,37467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37467,1,3,0)
 ;;=3^Unilateral post-traumatic osteoarthritis, right knee
 ;;^UTILITY(U,$J,358.3,37467,1,4,0)
 ;;=4^M17.31
 ;;^UTILITY(U,$J,358.3,37467,2)
 ;;=^5010790
 ;;^UTILITY(U,$J,358.3,37468,0)
 ;;=M17.32^^172^1884^52
 ;;^UTILITY(U,$J,358.3,37468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37468,1,3,0)
 ;;=3^Unilateral post-traumatic osteoarthritis, left knee
 ;;^UTILITY(U,$J,358.3,37468,1,4,0)
 ;;=4^M17.32
 ;;^UTILITY(U,$J,358.3,37468,2)
 ;;=^5010791
 ;;^UTILITY(U,$J,358.3,37469,0)
 ;;=M17.4^^172^1884^5
 ;;^UTILITY(U,$J,358.3,37469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37469,1,3,0)
 ;;=3^Bilateral secondary osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,37469,1,4,0)
 ;;=4^M17.4
 ;;^UTILITY(U,$J,358.3,37469,2)
 ;;=^5010792
 ;;^UTILITY(U,$J,358.3,37470,0)
 ;;=M17.5^^172^1884^55
 ;;^UTILITY(U,$J,358.3,37470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37470,1,3,0)
 ;;=3^Unilateral secondary osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,37470,1,4,0)
 ;;=4^M17.5
 ;;^UTILITY(U,$J,358.3,37470,2)
 ;;=^5010793
 ;;^UTILITY(U,$J,358.3,37471,0)
 ;;=S83.095D^^172^1884^19
 ;;^UTILITY(U,$J,358.3,37471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37471,1,3,0)
 ;;=3^Dislocation of left patella, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37471,1,4,0)
 ;;=4^S83.095D
 ;;^UTILITY(U,$J,358.3,37471,2)
 ;;=^5137020
 ;;^UTILITY(U,$J,358.3,37472,0)
 ;;=S83.094D^^172^1884^21
 ;;^UTILITY(U,$J,358.3,37472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37472,1,3,0)
 ;;=3^Dislocation of right patella, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37472,1,4,0)
 ;;=4^S83.094D
 ;;^UTILITY(U,$J,358.3,37472,2)
 ;;=^5042933
 ;;^UTILITY(U,$J,358.3,37473,0)
 ;;=S83.282D^^172^1884^46
 ;;^UTILITY(U,$J,358.3,37473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37473,1,3,0)
 ;;=3^Tear of lat mensc, current injury, left knee, subs
 ;;^UTILITY(U,$J,358.3,37473,1,4,0)
 ;;=4^S83.282D
 ;;^UTILITY(U,$J,358.3,37473,2)
 ;;=^5137065
 ;;^UTILITY(U,$J,358.3,37474,0)
 ;;=S83.281D^^172^1884^47
 ;;^UTILITY(U,$J,358.3,37474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37474,1,3,0)
 ;;=3^Tear of lat mensc, current injury, right knee, subs
 ;;^UTILITY(U,$J,358.3,37474,1,4,0)
 ;;=4^S83.281D
 ;;^UTILITY(U,$J,358.3,37474,2)
 ;;=^5043092
 ;;^UTILITY(U,$J,358.3,37475,0)
 ;;=S83.241D^^172^1884^48
 ;;^UTILITY(U,$J,358.3,37475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37475,1,3,0)
 ;;=3^Tear of medial meniscus, current injury, r knee, subs
 ;;^UTILITY(U,$J,358.3,37475,1,4,0)
 ;;=4^S83.241D
 ;;^UTILITY(U,$J,358.3,37475,2)
 ;;=^5043062
 ;;^UTILITY(U,$J,358.3,37476,0)
 ;;=M81.0^^172^1885^1
 ;;^UTILITY(U,$J,358.3,37476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37476,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,37476,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,37476,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,37477,0)
 ;;=L40.50^^172^1885^3
 ;;^UTILITY(U,$J,358.3,37477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37477,1,3,0)
 ;;=3^Arthropathic psoriasis, unspecified
 ;;^UTILITY(U,$J,358.3,37477,1,4,0)
 ;;=4^L40.50
 ;;^UTILITY(U,$J,358.3,37477,2)
 ;;=^5009165
 ;;^UTILITY(U,$J,358.3,37478,0)
 ;;=G90.522^^172^1885^14
 ;;^UTILITY(U,$J,358.3,37478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37478,1,3,0)
 ;;=3^Complex regional pain syndrome I of left lower limb
