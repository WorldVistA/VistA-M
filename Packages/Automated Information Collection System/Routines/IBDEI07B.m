IBDEI07B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2847,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,2847,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,2848,0)
 ;;=F02.81^^28^243^17
 ;;^UTILITY(U,$J,358.3,2848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2848,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,2848,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,2848,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,2849,0)
 ;;=F02.80^^28^243^20
 ;;^UTILITY(U,$J,358.3,2849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2849,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,2849,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,2849,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,2850,0)
 ;;=F04.^^28^243^5
 ;;^UTILITY(U,$J,358.3,2850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2850,1,3,0)
 ;;=3^Amnestic Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,2850,1,4,0)
 ;;=4^F04.
 ;;^UTILITY(U,$J,358.3,2850,2)
 ;;=^5003051
 ;;^UTILITY(U,$J,358.3,2851,0)
 ;;=R41.81^^28^243^7
 ;;^UTILITY(U,$J,358.3,2851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2851,1,3,0)
 ;;=3^Cognitive Decline,Age-Related
 ;;^UTILITY(U,$J,358.3,2851,1,4,0)
 ;;=4^R41.81
 ;;^UTILITY(U,$J,358.3,2851,2)
 ;;=^5019440
 ;;^UTILITY(U,$J,358.3,2852,0)
 ;;=R41.82^^28^243^8
 ;;^UTILITY(U,$J,358.3,2852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2852,1,3,0)
 ;;=3^Cognitive Decline,Altered Mental Status
 ;;^UTILITY(U,$J,358.3,2852,1,4,0)
 ;;=4^R41.82
 ;;^UTILITY(U,$J,358.3,2852,2)
 ;;=^5019441
 ;;^UTILITY(U,$J,358.3,2853,0)
 ;;=R41.841^^28^243^9
 ;;^UTILITY(U,$J,358.3,2853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2853,1,3,0)
 ;;=3^Cognitive Decline,Communication Deficit
 ;;^UTILITY(U,$J,358.3,2853,1,4,0)
 ;;=4^R41.841
 ;;^UTILITY(U,$J,358.3,2853,2)
 ;;=^5019444
 ;;^UTILITY(U,$J,358.3,2854,0)
 ;;=R41.0^^28^243^10
 ;;^UTILITY(U,$J,358.3,2854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2854,1,3,0)
 ;;=3^Cognitive Decline,Disorientation,Unspec
 ;;^UTILITY(U,$J,358.3,2854,1,4,0)
 ;;=4^R41.0
 ;;^UTILITY(U,$J,358.3,2854,2)
 ;;=^5019436
 ;;^UTILITY(U,$J,358.3,2855,0)
 ;;=R41.844^^28^243^11
 ;;^UTILITY(U,$J,358.3,2855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2855,1,3,0)
 ;;=3^Cognitive Decline,Frontal Lobe/Executive Function Deficit
 ;;^UTILITY(U,$J,358.3,2855,1,4,0)
 ;;=4^R41.844
 ;;^UTILITY(U,$J,358.3,2855,2)
 ;;=^5019447
 ;;^UTILITY(U,$J,358.3,2856,0)
 ;;=R41.843^^28^243^12
 ;;^UTILITY(U,$J,358.3,2856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2856,1,3,0)
 ;;=3^Cognitive Decline,Psychomotor Deficit
 ;;^UTILITY(U,$J,358.3,2856,1,4,0)
 ;;=4^R41.843
 ;;^UTILITY(U,$J,358.3,2856,2)
 ;;=^5019446
 ;;^UTILITY(U,$J,358.3,2857,0)
 ;;=R41.9^^28^243^13
 ;;^UTILITY(U,$J,358.3,2857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2857,1,3,0)
 ;;=3^Cognitive Decline,Unspec
 ;;^UTILITY(U,$J,358.3,2857,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,2857,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,2858,0)
 ;;=R41.842^^28^243^14
 ;;^UTILITY(U,$J,358.3,2858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2858,1,3,0)
 ;;=3^Cognitive Decline,Visuospatial Deficit
 ;;^UTILITY(U,$J,358.3,2858,1,4,0)
 ;;=4^R41.842
 ;;^UTILITY(U,$J,358.3,2858,2)
 ;;=^5019445
 ;;^UTILITY(U,$J,358.3,2859,0)
 ;;=G31.84^^28^243^15
 ;;^UTILITY(U,$J,358.3,2859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2859,1,3,0)
 ;;=3^Cognitive Impairment,Mild
 ;;^UTILITY(U,$J,358.3,2859,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,2859,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,2860,0)
 ;;=G31.83^^28^243^19
 ;;^UTILITY(U,$J,358.3,2860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2860,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,2860,1,4,0)
 ;;=4^G31.83
