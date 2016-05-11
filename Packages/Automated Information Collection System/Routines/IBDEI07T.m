IBDEI07T ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3352,2)
 ;;=^5012096
 ;;^UTILITY(U,$J,358.3,3353,0)
 ;;=M45.9^^18^219^7
 ;;^UTILITY(U,$J,358.3,3353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3353,1,3,0)
 ;;=3^Ankylosing Spondylitis,Spine,Unspec Site
 ;;^UTILITY(U,$J,358.3,3353,1,4,0)
 ;;=4^M45.9
 ;;^UTILITY(U,$J,358.3,3353,2)
 ;;=^5011969
 ;;^UTILITY(U,$J,358.3,3354,0)
 ;;=M13.0^^18^219^11
 ;;^UTILITY(U,$J,358.3,3354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3354,1,3,0)
 ;;=3^Arthritis,Polyarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,3354,1,4,0)
 ;;=4^M13.0
 ;;^UTILITY(U,$J,358.3,3354,2)
 ;;=^5010667
 ;;^UTILITY(U,$J,358.3,3355,0)
 ;;=M15.9^^18^219^12
 ;;^UTILITY(U,$J,358.3,3355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3355,1,3,0)
 ;;=3^Arthritis,Polyosteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,3355,1,4,0)
 ;;=4^M15.9
 ;;^UTILITY(U,$J,358.3,3355,2)
 ;;=^5010768
 ;;^UTILITY(U,$J,358.3,3356,0)
 ;;=M15.4^^18^219^8
 ;;^UTILITY(U,$J,358.3,3356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3356,1,3,0)
 ;;=3^Arthritis (Osteo),Erosive
 ;;^UTILITY(U,$J,358.3,3356,1,4,0)
 ;;=4^M15.4
 ;;^UTILITY(U,$J,358.3,3356,2)
 ;;=^5010766
 ;;^UTILITY(U,$J,358.3,3357,0)
 ;;=M15.0^^18^219^9
 ;;^UTILITY(U,$J,358.3,3357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3357,1,3,0)
 ;;=3^Arthritis (Osteo),Primary Generalized
 ;;^UTILITY(U,$J,358.3,3357,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,3357,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,3358,0)
 ;;=M13.10^^18^219^10
 ;;^UTILITY(U,$J,358.3,3358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3358,1,3,0)
 ;;=3^Arthritis,Monoarthritis,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,3358,1,4,0)
 ;;=4^M13.10
 ;;^UTILITY(U,$J,358.3,3358,2)
 ;;=^5010668
 ;;^UTILITY(U,$J,358.3,3359,0)
 ;;=M15.3^^18^219^13
 ;;^UTILITY(U,$J,358.3,3359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3359,1,3,0)
 ;;=3^Arthritis,Secondary Multiple
 ;;^UTILITY(U,$J,358.3,3359,1,4,0)
 ;;=4^M15.3
 ;;^UTILITY(U,$J,358.3,3359,2)
 ;;=^5010765
 ;;^UTILITY(U,$J,358.3,3360,0)
 ;;=M11.9^^18^219^14
 ;;^UTILITY(U,$J,358.3,3360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3360,1,3,0)
 ;;=3^Arthropathy,Crystal,Unspec
 ;;^UTILITY(U,$J,358.3,3360,1,4,0)
 ;;=4^M11.9
 ;;^UTILITY(U,$J,358.3,3360,2)
 ;;=^5010497
 ;;^UTILITY(U,$J,358.3,3361,0)
 ;;=M12.9^^18^219^15
 ;;^UTILITY(U,$J,358.3,3361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3361,1,3,0)
 ;;=3^Arthropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3361,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,3361,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,3362,0)
 ;;=Z97.10^^18^219^16
 ;;^UTILITY(U,$J,358.3,3362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3362,1,3,0)
 ;;=3^Artificial Limb,Unspec
 ;;^UTILITY(U,$J,358.3,3362,1,4,0)
 ;;=4^Z97.10
 ;;^UTILITY(U,$J,358.3,3362,2)
 ;;=^5063721
 ;;^UTILITY(U,$J,358.3,3363,0)
 ;;=M99.9^^18^219^17
 ;;^UTILITY(U,$J,358.3,3363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3363,1,3,0)
 ;;=3^Biomechanical Lesion,Unspec
 ;;^UTILITY(U,$J,358.3,3363,1,4,0)
 ;;=4^M99.9
 ;;^UTILITY(U,$J,358.3,3363,2)
 ;;=^5015490
 ;;^UTILITY(U,$J,358.3,3364,0)
 ;;=M85.9^^18^219^27
 ;;^UTILITY(U,$J,358.3,3364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3364,1,3,0)
 ;;=3^Done Density/Structure Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3364,1,4,0)
 ;;=4^M85.9
 ;;^UTILITY(U,$J,358.3,3364,2)
 ;;=^5014496
 ;;^UTILITY(U,$J,358.3,3365,0)
 ;;=M89.20^^18^219^18
 ;;^UTILITY(U,$J,358.3,3365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3365,1,3,0)
 ;;=3^Bone Development/Growth Disorder,Unspec Site
 ;;^UTILITY(U,$J,358.3,3365,1,4,0)
 ;;=4^M89.20
 ;;^UTILITY(U,$J,358.3,3365,2)
 ;;=^5014959
 ;;^UTILITY(U,$J,358.3,3366,0)
 ;;=M89.9^^18^219^19
