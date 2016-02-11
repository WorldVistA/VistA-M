IBDEI27Y ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37278,1,4,0)
 ;;=4^M19.021
 ;;^UTILITY(U,$J,358.3,37278,2)
 ;;=^5010811
 ;;^UTILITY(U,$J,358.3,37279,0)
 ;;=M12.522^^172^1878^45
 ;;^UTILITY(U,$J,358.3,37279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37279,1,3,0)
 ;;=3^Traumatic arthropathy, left elbow
 ;;^UTILITY(U,$J,358.3,37279,1,4,0)
 ;;=4^M12.522
 ;;^UTILITY(U,$J,358.3,37279,2)
 ;;=^5010623
 ;;^UTILITY(U,$J,358.3,37280,0)
 ;;=M12.521^^172^1878^46
 ;;^UTILITY(U,$J,358.3,37280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37280,1,3,0)
 ;;=3^Traumatic arthropathy, right elbow
 ;;^UTILITY(U,$J,358.3,37280,1,4,0)
 ;;=4^M12.521
 ;;^UTILITY(U,$J,358.3,37280,2)
 ;;=^5010622
 ;;^UTILITY(U,$J,358.3,37281,0)
 ;;=S42.402A^^172^1878^19
 ;;^UTILITY(U,$J,358.3,37281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37281,1,3,0)
 ;;=3^Fracture of lower end of left humerus, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,37281,1,4,0)
 ;;=4^S42.402A
 ;;^UTILITY(U,$J,358.3,37281,2)
 ;;=^5134713
 ;;^UTILITY(U,$J,358.3,37282,0)
 ;;=S42.401A^^172^1878^20
 ;;^UTILITY(U,$J,358.3,37282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37282,1,3,0)
 ;;=3^Fracture of lower end of right humerus, init,Unspec
 ;;^UTILITY(U,$J,358.3,37282,1,4,0)
 ;;=4^S42.401A
 ;;^UTILITY(U,$J,358.3,37282,2)
 ;;=^5027294
 ;;^UTILITY(U,$J,358.3,37283,0)
 ;;=S53.402A^^172^1878^41
 ;;^UTILITY(U,$J,358.3,37283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37283,1,3,0)
 ;;=3^Sprain of left elbow, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37283,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,37283,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,37284,0)
 ;;=S53.401A^^172^1878^43
 ;;^UTILITY(U,$J,358.3,37284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37284,1,3,0)
 ;;=3^Sprain of right elbow, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,37284,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,37284,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,37285,0)
 ;;=S50.02XD^^172^1878^6
 ;;^UTILITY(U,$J,358.3,37285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37285,1,3,0)
 ;;=3^Contusion of left elbow, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37285,1,4,0)
 ;;=4^S50.02XD
 ;;^UTILITY(U,$J,358.3,37285,2)
 ;;=^5028489
 ;;^UTILITY(U,$J,358.3,37286,0)
 ;;=S50.01XD^^172^1878^8
 ;;^UTILITY(U,$J,358.3,37286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37286,1,3,0)
 ;;=3^Contusion of right elbow, subsequent encounter
 ;;^UTILITY(U,$J,358.3,37286,1,4,0)
 ;;=4^S50.01XD
 ;;^UTILITY(U,$J,358.3,37286,2)
 ;;=^5028486
 ;;^UTILITY(U,$J,358.3,37287,0)
 ;;=S52.122D^^172^1878^10
 ;;^UTILITY(U,$J,358.3,37287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37287,1,3,0)
 ;;=3^Disp fx of head of left radius, subs encntr
 ;;^UTILITY(U,$J,358.3,37287,1,4,0)
 ;;=4^S52.122D
 ;;^UTILITY(U,$J,358.3,37287,2)
 ;;=^5029066
 ;;^UTILITY(U,$J,358.3,37288,0)
 ;;=S52.121D^^172^1878^12
 ;;^UTILITY(U,$J,358.3,37288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37288,1,3,0)
 ;;=3^Disp fx of head of right radius, subs encntr
 ;;^UTILITY(U,$J,358.3,37288,1,4,0)
 ;;=4^S52.121D
 ;;^UTILITY(U,$J,358.3,37288,2)
 ;;=^5029050
 ;;^UTILITY(U,$J,358.3,37289,0)
 ;;=S52.032D^^172^1878^15
 ;;^UTILITY(U,$J,358.3,37289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37289,1,3,0)
 ;;=3^Disp fx of olecran pro w/ intartic extn left ulna, subs encntr
 ;;^UTILITY(U,$J,358.3,37289,1,4,0)
 ;;=4^S52.032D
 ;;^UTILITY(U,$J,358.3,37289,2)
 ;;=^5135083
 ;;^UTILITY(U,$J,358.3,37290,0)
 ;;=S52.031D^^172^1878^16
 ;;^UTILITY(U,$J,358.3,37290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37290,1,3,0)
 ;;=3^Disp fx of olecran pro w/ intartic extn right ulna, subs encntr
 ;;^UTILITY(U,$J,358.3,37290,1,4,0)
 ;;=4^S52.031D
