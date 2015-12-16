IBDEI1R9 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31020,1,3,0)
 ;;=3^Incomplete rotatr-cuff tear/ruptr of r shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,31020,1,4,0)
 ;;=4^M75.111
 ;;^UTILITY(U,$J,358.3,31020,2)
 ;;=^5013245
 ;;^UTILITY(U,$J,358.3,31021,0)
 ;;=M25.512^^179^1938^25
 ;;^UTILITY(U,$J,358.3,31021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31021,1,3,0)
 ;;=3^Pain in left shoulder
 ;;^UTILITY(U,$J,358.3,31021,1,4,0)
 ;;=4^M25.512
 ;;^UTILITY(U,$J,358.3,31021,2)
 ;;=^5011603
 ;;^UTILITY(U,$J,358.3,31022,0)
 ;;=M25.511^^179^1938^26
 ;;^UTILITY(U,$J,358.3,31022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31022,1,3,0)
 ;;=3^Pain in right shoulder
 ;;^UTILITY(U,$J,358.3,31022,1,4,0)
 ;;=4^M25.511
 ;;^UTILITY(U,$J,358.3,31022,2)
 ;;=^5011602
 ;;^UTILITY(U,$J,358.3,31023,0)
 ;;=S43.025A^^179^1938^27
 ;;^UTILITY(U,$J,358.3,31023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31023,1,3,0)
 ;;=3^Posterior dislocation of left humerus, initial encounter
 ;;^UTILITY(U,$J,358.3,31023,1,4,0)
 ;;=4^S43.025A
 ;;^UTILITY(U,$J,358.3,31023,2)
 ;;=^5027699
 ;;^UTILITY(U,$J,358.3,31024,0)
 ;;=S43.024A^^179^1938^28
 ;;^UTILITY(U,$J,358.3,31024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31024,1,3,0)
 ;;=3^Posterior dislocation of right humerus, initial encounter
 ;;^UTILITY(U,$J,358.3,31024,1,4,0)
 ;;=4^S43.024A
 ;;^UTILITY(U,$J,358.3,31024,2)
 ;;=^5027696
 ;;^UTILITY(U,$J,358.3,31025,0)
 ;;=M19.012^^179^1938^29
 ;;^UTILITY(U,$J,358.3,31025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31025,1,3,0)
 ;;=3^Primary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,31025,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,31025,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,31026,0)
 ;;=M19.011^^179^1938^30
 ;;^UTILITY(U,$J,358.3,31026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31026,1,3,0)
 ;;=3^Primary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,31026,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,31026,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,31027,0)
 ;;=M24.412^^179^1938^31
 ;;^UTILITY(U,$J,358.3,31027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31027,1,3,0)
 ;;=3^Recurrent dislocation, left shoulder
 ;;^UTILITY(U,$J,358.3,31027,1,4,0)
 ;;=4^M24.412
 ;;^UTILITY(U,$J,358.3,31027,2)
 ;;=^5011372
 ;;^UTILITY(U,$J,358.3,31028,0)
 ;;=M24.411^^179^1938^32
 ;;^UTILITY(U,$J,358.3,31028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31028,1,3,0)
 ;;=3^Recurrent dislocation, right shoulder
 ;;^UTILITY(U,$J,358.3,31028,1,4,0)
 ;;=4^M24.411
 ;;^UTILITY(U,$J,358.3,31028,2)
 ;;=^5011371
 ;;^UTILITY(U,$J,358.3,31029,0)
 ;;=M75.122^^179^1938^33
 ;;^UTILITY(U,$J,358.3,31029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31029,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of left shoulder, not trauma, complete
 ;;^UTILITY(U,$J,358.3,31029,1,4,0)
 ;;=4^M75.122
 ;;^UTILITY(U,$J,358.3,31029,2)
 ;;=^5013249
 ;;^UTILITY(U,$J,358.3,31030,0)
 ;;=M75.121^^179^1938^34
 ;;^UTILITY(U,$J,358.3,31030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31030,1,3,0)
 ;;=3^Rotatr-cuff tear/ruptr of r shoulder, not trauma, complete
 ;;^UTILITY(U,$J,358.3,31030,1,4,0)
 ;;=4^M75.121
 ;;^UTILITY(U,$J,358.3,31030,2)
 ;;=^5013248
 ;;^UTILITY(U,$J,358.3,31031,0)
 ;;=M12.512^^179^1938^35
 ;;^UTILITY(U,$J,358.3,31031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31031,1,3,0)
 ;;=3^Traumatic arthropathy, left shoulder
 ;;^UTILITY(U,$J,358.3,31031,1,4,0)
 ;;=4^M12.512
 ;;^UTILITY(U,$J,358.3,31031,2)
 ;;=^5010620
 ;;^UTILITY(U,$J,358.3,31032,0)
 ;;=M12.511^^179^1938^36
 ;;^UTILITY(U,$J,358.3,31032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31032,1,3,0)
 ;;=3^Traumatic arthropathy, right shoulder
