IBDEI033 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,900,1,4,0)
 ;;=4^B37.83
 ;;^UTILITY(U,$J,358.3,900,2)
 ;;=^5000622
 ;;^UTILITY(U,$J,358.3,901,0)
 ;;=D14.1^^3^35^23
 ;;^UTILITY(U,$J,358.3,901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,901,1,3,0)
 ;;=3^Benign neoplasm of larynx
 ;;^UTILITY(U,$J,358.3,901,1,4,0)
 ;;=4^D14.1
 ;;^UTILITY(U,$J,358.3,901,2)
 ;;=^267598
 ;;^UTILITY(U,$J,358.3,902,0)
 ;;=D14.2^^3^35^24
 ;;^UTILITY(U,$J,358.3,902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,902,1,3,0)
 ;;=3^Benign neoplasm of trachea
 ;;^UTILITY(U,$J,358.3,902,1,4,0)
 ;;=4^D14.2
 ;;^UTILITY(U,$J,358.3,902,2)
 ;;=^267599
 ;;^UTILITY(U,$J,358.3,903,0)
 ;;=H40.9^^3^35^74
 ;;^UTILITY(U,$J,358.3,903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,903,1,3,0)
 ;;=3^Glaucoma,Unspec
 ;;^UTILITY(U,$J,358.3,903,1,4,0)
 ;;=4^H40.9
 ;;^UTILITY(U,$J,358.3,903,2)
 ;;=^5005931
 ;;^UTILITY(U,$J,358.3,904,0)
 ;;=H26.9^^3^35^34
 ;;^UTILITY(U,$J,358.3,904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,904,1,3,0)
 ;;=3^Cataract,Unspec
 ;;^UTILITY(U,$J,358.3,904,1,4,0)
 ;;=4^H26.9
 ;;^UTILITY(U,$J,358.3,904,2)
 ;;=^5005363
 ;;^UTILITY(U,$J,358.3,905,0)
 ;;=H10.9^^3^35^55
 ;;^UTILITY(U,$J,358.3,905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,905,1,3,0)
 ;;=3^Conjunctivitis,Unspec
 ;;^UTILITY(U,$J,358.3,905,1,4,0)
 ;;=4^H10.9
 ;;^UTILITY(U,$J,358.3,905,2)
 ;;=^5004716
 ;;^UTILITY(U,$J,358.3,906,0)
 ;;=H11.33^^3^35^52
 ;;^UTILITY(U,$J,358.3,906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,906,1,3,0)
 ;;=3^Conjunctival hemorrhage, bilateral
 ;;^UTILITY(U,$J,358.3,906,1,4,0)
 ;;=4^H11.33
 ;;^UTILITY(U,$J,358.3,906,2)
 ;;=^5004784
 ;;^UTILITY(U,$J,358.3,907,0)
 ;;=H11.32^^3^35^53
 ;;^UTILITY(U,$J,358.3,907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,907,1,3,0)
 ;;=3^Conjunctival hemorrhage, left eye
 ;;^UTILITY(U,$J,358.3,907,1,4,0)
 ;;=4^H11.32
 ;;^UTILITY(U,$J,358.3,907,2)
 ;;=^5004783
 ;;^UTILITY(U,$J,358.3,908,0)
 ;;=H11.31^^3^35^54
 ;;^UTILITY(U,$J,358.3,908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,908,1,3,0)
 ;;=3^Conjunctival hemorrhage, right eye
 ;;^UTILITY(U,$J,358.3,908,1,4,0)
 ;;=4^H11.31
 ;;^UTILITY(U,$J,358.3,908,2)
 ;;=^5004782
 ;;^UTILITY(U,$J,358.3,909,0)
 ;;=H01.002^^3^35^30
 ;;^UTILITY(U,$J,358.3,909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,909,1,3,0)
 ;;=3^Blepharitis Right Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,909,1,4,0)
 ;;=4^H01.002
 ;;^UTILITY(U,$J,358.3,909,2)
 ;;=^5004239
 ;;^UTILITY(U,$J,358.3,910,0)
 ;;=H01.004^^3^35^29
 ;;^UTILITY(U,$J,358.3,910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,910,1,3,0)
 ;;=3^Blepharitis Left Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,910,1,4,0)
 ;;=4^H01.004
 ;;^UTILITY(U,$J,358.3,910,2)
 ;;=^5004241
 ;;^UTILITY(U,$J,358.3,911,0)
 ;;=H01.005^^3^35^28
 ;;^UTILITY(U,$J,358.3,911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,911,1,3,0)
 ;;=3^Blepharitis Left Lower Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,911,1,4,0)
 ;;=4^H01.005
 ;;^UTILITY(U,$J,358.3,911,2)
 ;;=^5133380
 ;;^UTILITY(U,$J,358.3,912,0)
 ;;=H01.001^^3^35^31
 ;;^UTILITY(U,$J,358.3,912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,912,1,3,0)
 ;;=3^Blepharitis Right Upper Eyelid,Unspec
 ;;^UTILITY(U,$J,358.3,912,1,4,0)
 ;;=4^H01.001
 ;;^UTILITY(U,$J,358.3,912,2)
 ;;=^5004238
 ;;^UTILITY(U,$J,358.3,913,0)
 ;;=H05.011^^3^35^38
 ;;^UTILITY(U,$J,358.3,913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,913,1,3,0)
 ;;=3^Cellulitis of right orbit
 ;;^UTILITY(U,$J,358.3,913,1,4,0)
 ;;=4^H05.011
 ;;^UTILITY(U,$J,358.3,913,2)
 ;;=^5004560
 ;;^UTILITY(U,$J,358.3,914,0)
 ;;=H05.012^^3^35^37
 ;;^UTILITY(U,$J,358.3,914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,914,1,3,0)
 ;;=3^Cellulitis of left orbit
