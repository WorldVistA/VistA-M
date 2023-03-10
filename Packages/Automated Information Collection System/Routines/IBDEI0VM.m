IBDEI0VM ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14255,1,3,0)
 ;;=3^Fracture of unsp part of left clavicle, init for clos fx
 ;;^UTILITY(U,$J,358.3,14255,1,4,0)
 ;;=4^S42.002A
 ;;^UTILITY(U,$J,358.3,14255,2)
 ;;=^5026376
 ;;^UTILITY(U,$J,358.3,14256,0)
 ;;=S42.001A^^55^674^26
 ;;^UTILITY(U,$J,358.3,14256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14256,1,3,0)
 ;;=3^Fracture of unsp part of right clavicle, init for clos fx
 ;;^UTILITY(U,$J,358.3,14256,1,4,0)
 ;;=4^S42.001A
 ;;^UTILITY(U,$J,358.3,14256,2)
 ;;=^5026369
 ;;^UTILITY(U,$J,358.3,14257,0)
 ;;=M75.42^^55^674^29
 ;;^UTILITY(U,$J,358.3,14257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14257,1,3,0)
 ;;=3^Impingement syndrome of left shoulder
 ;;^UTILITY(U,$J,358.3,14257,1,4,0)
 ;;=4^M75.42
 ;;^UTILITY(U,$J,358.3,14257,2)
 ;;=^5013258
 ;;^UTILITY(U,$J,358.3,14258,0)
 ;;=M75.41^^55^674^30
 ;;^UTILITY(U,$J,358.3,14258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14258,1,3,0)
 ;;=3^Impingement syndrome of right shoulder
 ;;^UTILITY(U,$J,358.3,14258,1,4,0)
 ;;=4^M75.41
 ;;^UTILITY(U,$J,358.3,14258,2)
 ;;=^5013257
 ;;^UTILITY(U,$J,358.3,14259,0)
 ;;=M75.112^^55^674^31
 ;;^UTILITY(U,$J,358.3,14259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14259,1,3,0)
 ;;=3^Incomplete rotatr-cuff tear/ruptr of l shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,14259,1,4,0)
 ;;=4^M75.112
 ;;^UTILITY(U,$J,358.3,14259,2)
 ;;=^5013246
 ;;^UTILITY(U,$J,358.3,14260,0)
 ;;=M75.111^^55^674^32
 ;;^UTILITY(U,$J,358.3,14260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14260,1,3,0)
 ;;=3^Incomplete rotatr-cuff tear/ruptr of r shoulder, not trauma
 ;;^UTILITY(U,$J,358.3,14260,1,4,0)
 ;;=4^M75.111
 ;;^UTILITY(U,$J,358.3,14260,2)
 ;;=^5013245
 ;;^UTILITY(U,$J,358.3,14261,0)
 ;;=M25.512^^55^674^33
 ;;^UTILITY(U,$J,358.3,14261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14261,1,3,0)
 ;;=3^Pain in left shoulder
 ;;^UTILITY(U,$J,358.3,14261,1,4,0)
 ;;=4^M25.512
 ;;^UTILITY(U,$J,358.3,14261,2)
 ;;=^5011603
 ;;^UTILITY(U,$J,358.3,14262,0)
 ;;=M25.511^^55^674^34
 ;;^UTILITY(U,$J,358.3,14262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14262,1,3,0)
 ;;=3^Pain in right shoulder
 ;;^UTILITY(U,$J,358.3,14262,1,4,0)
 ;;=4^M25.511
 ;;^UTILITY(U,$J,358.3,14262,2)
 ;;=^5011602
 ;;^UTILITY(U,$J,358.3,14263,0)
 ;;=S43.025A^^55^674^37
 ;;^UTILITY(U,$J,358.3,14263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14263,1,3,0)
 ;;=3^Posterior dislocation of left humerus, initial encounter
 ;;^UTILITY(U,$J,358.3,14263,1,4,0)
 ;;=4^S43.025A
 ;;^UTILITY(U,$J,358.3,14263,2)
 ;;=^5027699
 ;;^UTILITY(U,$J,358.3,14264,0)
 ;;=S43.024A^^55^674^39
 ;;^UTILITY(U,$J,358.3,14264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14264,1,3,0)
 ;;=3^Posterior dislocation of right humerus, initial encounter
 ;;^UTILITY(U,$J,358.3,14264,1,4,0)
 ;;=4^S43.024A
 ;;^UTILITY(U,$J,358.3,14264,2)
 ;;=^5027696
 ;;^UTILITY(U,$J,358.3,14265,0)
 ;;=M19.012^^55^674^41
 ;;^UTILITY(U,$J,358.3,14265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14265,1,3,0)
 ;;=3^Primary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,14265,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,14265,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,14266,0)
 ;;=M19.011^^55^674^42
 ;;^UTILITY(U,$J,358.3,14266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14266,1,3,0)
 ;;=3^Primary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,14266,1,4,0)
 ;;=4^M19.011
