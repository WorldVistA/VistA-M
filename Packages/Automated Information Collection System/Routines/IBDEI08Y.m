IBDEI08Y ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3642,1,3,0)
 ;;=3^Renal Tubular Function Impaired,Disorder from,Unspec
 ;;^UTILITY(U,$J,358.3,3642,1,4,0)
 ;;=4^N25.9
 ;;^UTILITY(U,$J,358.3,3642,2)
 ;;=^5015619
 ;;^UTILITY(U,$J,358.3,3643,0)
 ;;=M89.00^^28^258^1
 ;;^UTILITY(U,$J,358.3,3643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3643,1,3,0)
 ;;=3^Algoneurodystrophy (RSD),Unspec Site
 ;;^UTILITY(U,$J,358.3,3643,1,4,0)
 ;;=4^M89.00
 ;;^UTILITY(U,$J,358.3,3643,2)
 ;;=^5014900
 ;;^UTILITY(U,$J,358.3,3644,0)
 ;;=Z89.612^^28^258^2
 ;;^UTILITY(U,$J,358.3,3644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3644,1,3,0)
 ;;=3^Amputation,Acquired Absence,Left Leg above Knee
 ;;^UTILITY(U,$J,358.3,3644,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,3644,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,3645,0)
 ;;=Z89.512^^28^258^3
 ;;^UTILITY(U,$J,358.3,3645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3645,1,3,0)
 ;;=3^Amputation,Acquired Absence,Left Leg below Knee
 ;;^UTILITY(U,$J,358.3,3645,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,3645,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,3646,0)
 ;;=Z89.611^^28^258^4
 ;;^UTILITY(U,$J,358.3,3646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3646,1,3,0)
 ;;=3^Amputation,Acquired Absence,Right Leg above Knee
 ;;^UTILITY(U,$J,358.3,3646,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,3646,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,3647,0)
 ;;=Z89.511^^28^258^5
 ;;^UTILITY(U,$J,358.3,3647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3647,1,3,0)
 ;;=3^Amputation,Acquired Absence,Right Leg below Knee
 ;;^UTILITY(U,$J,358.3,3647,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,3647,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,3648,0)
 ;;=M48.10^^28^258^6
 ;;^UTILITY(U,$J,358.3,3648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3648,1,3,0)
 ;;=3^Ankylosing Hyperostosis,Unspec Site
 ;;^UTILITY(U,$J,358.3,3648,1,4,0)
 ;;=4^M48.10
 ;;^UTILITY(U,$J,358.3,3648,2)
 ;;=^5012096
 ;;^UTILITY(U,$J,358.3,3649,0)
 ;;=M45.9^^28^258^7
 ;;^UTILITY(U,$J,358.3,3649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3649,1,3,0)
 ;;=3^Ankylosing Spondylitis,Spine,Unspec Site
 ;;^UTILITY(U,$J,358.3,3649,1,4,0)
 ;;=4^M45.9
 ;;^UTILITY(U,$J,358.3,3649,2)
 ;;=^5011969
 ;;^UTILITY(U,$J,358.3,3650,0)
 ;;=M13.0^^28^258^11
 ;;^UTILITY(U,$J,358.3,3650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3650,1,3,0)
 ;;=3^Arthritis,Polyarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,3650,1,4,0)
 ;;=4^M13.0
 ;;^UTILITY(U,$J,358.3,3650,2)
 ;;=^5010667
 ;;^UTILITY(U,$J,358.3,3651,0)
 ;;=M15.9^^28^258^12
 ;;^UTILITY(U,$J,358.3,3651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3651,1,3,0)
 ;;=3^Arthritis,Polyosteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,3651,1,4,0)
 ;;=4^M15.9
 ;;^UTILITY(U,$J,358.3,3651,2)
 ;;=^5010768
 ;;^UTILITY(U,$J,358.3,3652,0)
 ;;=M15.4^^28^258^8
 ;;^UTILITY(U,$J,358.3,3652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3652,1,3,0)
 ;;=3^Arthritis (Osteo),Erosive
 ;;^UTILITY(U,$J,358.3,3652,1,4,0)
 ;;=4^M15.4
 ;;^UTILITY(U,$J,358.3,3652,2)
 ;;=^5010766
 ;;^UTILITY(U,$J,358.3,3653,0)
 ;;=M15.0^^28^258^9
 ;;^UTILITY(U,$J,358.3,3653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3653,1,3,0)
 ;;=3^Arthritis (Osteo),Primary Generalized
 ;;^UTILITY(U,$J,358.3,3653,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,3653,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,3654,0)
 ;;=M13.10^^28^258^10
 ;;^UTILITY(U,$J,358.3,3654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3654,1,3,0)
 ;;=3^Arthritis,Monoarthritis,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,3654,1,4,0)
 ;;=4^M13.10
 ;;^UTILITY(U,$J,358.3,3654,2)
 ;;=^5010668
 ;;^UTILITY(U,$J,358.3,3655,0)
 ;;=M15.3^^28^258^13
