IBDEI0HW ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8018,1,3,0)
 ;;=3^Cataract,Unspec
 ;;^UTILITY(U,$J,358.3,8018,1,4,0)
 ;;=4^H26.9
 ;;^UTILITY(U,$J,358.3,8018,2)
 ;;=^5005363
 ;;^UTILITY(U,$J,358.3,8019,0)
 ;;=H10.9^^55^534^55
 ;;^UTILITY(U,$J,358.3,8019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8019,1,3,0)
 ;;=3^Conjunctivitis,Unspec
 ;;^UTILITY(U,$J,358.3,8019,1,4,0)
 ;;=4^H10.9
 ;;^UTILITY(U,$J,358.3,8019,2)
 ;;=^5004716
 ;;^UTILITY(U,$J,358.3,8020,0)
 ;;=H11.33^^55^534^52
 ;;^UTILITY(U,$J,358.3,8020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8020,1,3,0)
 ;;=3^Conjunctival hemorrhage, bilateral
 ;;^UTILITY(U,$J,358.3,8020,1,4,0)
 ;;=4^H11.33
 ;;^UTILITY(U,$J,358.3,8020,2)
 ;;=^5004784
 ;;^UTILITY(U,$J,358.3,8021,0)
 ;;=H11.32^^55^534^53
 ;;^UTILITY(U,$J,358.3,8021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8021,1,3,0)
 ;;=3^Conjunctival hemorrhage, left eye
 ;;^UTILITY(U,$J,358.3,8021,1,4,0)
 ;;=4^H11.32
 ;;^UTILITY(U,$J,358.3,8021,2)
 ;;=^5004783
 ;;^UTILITY(U,$J,358.3,8022,0)
 ;;=H11.31^^55^534^54
 ;;^UTILITY(U,$J,358.3,8022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8022,1,3,0)
 ;;=3^Conjunctival hemorrhage, right eye
 ;;^UTILITY(U,$J,358.3,8022,1,4,0)
 ;;=4^H11.31
 ;;^UTILITY(U,$J,358.3,8022,2)
 ;;=^5004782
 ;;^UTILITY(U,$J,358.3,8023,0)
 ;;=H01.002^^55^534^30
 ;;^UTILITY(U,$J,358.3,8023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8023,1,3,0)
 ;;=3^Blepharitis Right Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,8023,1,4,0)
 ;;=4^H01.002
 ;;^UTILITY(U,$J,358.3,8023,2)
 ;;=^5004239
 ;;^UTILITY(U,$J,358.3,8024,0)
 ;;=H01.004^^55^534^29
 ;;^UTILITY(U,$J,358.3,8024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8024,1,3,0)
 ;;=3^Blepharitis Left Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,8024,1,4,0)
 ;;=4^H01.004
 ;;^UTILITY(U,$J,358.3,8024,2)
 ;;=^5004241
 ;;^UTILITY(U,$J,358.3,8025,0)
 ;;=H01.005^^55^534^28
 ;;^UTILITY(U,$J,358.3,8025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8025,1,3,0)
 ;;=3^Blepharitis Left Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,8025,1,4,0)
 ;;=4^H01.005
 ;;^UTILITY(U,$J,358.3,8025,2)
 ;;=^5133380
 ;;^UTILITY(U,$J,358.3,8026,0)
 ;;=H01.001^^55^534^31
 ;;^UTILITY(U,$J,358.3,8026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8026,1,3,0)
 ;;=3^Blepharitis Right Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,8026,1,4,0)
 ;;=4^H01.001
 ;;^UTILITY(U,$J,358.3,8026,2)
 ;;=^5004238
 ;;^UTILITY(U,$J,358.3,8027,0)
 ;;=H05.011^^55^534^38
 ;;^UTILITY(U,$J,358.3,8027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8027,1,3,0)
 ;;=3^Cellulitis of right orbit
 ;;^UTILITY(U,$J,358.3,8027,1,4,0)
 ;;=4^H05.011
 ;;^UTILITY(U,$J,358.3,8027,2)
 ;;=^5004560
 ;;^UTILITY(U,$J,358.3,8028,0)
 ;;=H05.012^^55^534^37
 ;;^UTILITY(U,$J,358.3,8028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8028,1,3,0)
 ;;=3^Cellulitis of left orbit
 ;;^UTILITY(U,$J,358.3,8028,1,4,0)
 ;;=4^H05.012
 ;;^UTILITY(U,$J,358.3,8028,2)
 ;;=^5004561
 ;;^UTILITY(U,$J,358.3,8029,0)
 ;;=H05.013^^55^534^36
 ;;^UTILITY(U,$J,358.3,8029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8029,1,3,0)
 ;;=3^Cellulitis of bilateral orbits
 ;;^UTILITY(U,$J,358.3,8029,1,4,0)
 ;;=4^H05.013
 ;;^UTILITY(U,$J,358.3,8029,2)
 ;;=^5004562
 ;;^UTILITY(U,$J,358.3,8030,0)
 ;;=H55.09^^55^534^97
 ;;^UTILITY(U,$J,358.3,8030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8030,1,3,0)
 ;;=3^Nystagmus NEC
 ;;^UTILITY(U,$J,358.3,8030,1,4,0)
 ;;=4^H55.09
 ;;^UTILITY(U,$J,358.3,8030,2)
 ;;=^87599
 ;;^UTILITY(U,$J,358.3,8031,0)
 ;;=H57.13^^55^534^98
 ;;^UTILITY(U,$J,358.3,8031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8031,1,3,0)
 ;;=3^Ocular pain, bilateral
