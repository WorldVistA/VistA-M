IBDEI0F9 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6568,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,6568,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,6569,0)
 ;;=I05.0^^53^418^8
 ;;^UTILITY(U,$J,358.3,6569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6569,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,6569,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,6569,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,6570,0)
 ;;=I05.1^^53^418^7
 ;;^UTILITY(U,$J,358.3,6570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6570,1,3,0)
 ;;=3^Rheumatic Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,6570,1,4,0)
 ;;=4^I05.1
 ;;^UTILITY(U,$J,358.3,6570,2)
 ;;=^269568
 ;;^UTILITY(U,$J,358.3,6571,0)
 ;;=I05.2^^53^418^9
 ;;^UTILITY(U,$J,358.3,6571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6571,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,6571,1,4,0)
 ;;=4^I05.2
 ;;^UTILITY(U,$J,358.3,6571,2)
 ;;=^5007042
 ;;^UTILITY(U,$J,358.3,6572,0)
 ;;=I05.8^^53^418^10
 ;;^UTILITY(U,$J,358.3,6572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6572,1,3,0)
 ;;=3^Rheumatic Mitral Valve Diseases NEC
 ;;^UTILITY(U,$J,358.3,6572,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,6572,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,6573,0)
 ;;=I06.0^^53^418^2
 ;;^UTILITY(U,$J,358.3,6573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6573,1,3,0)
 ;;=3^Rheumatic Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,6573,1,4,0)
 ;;=4^I06.0
 ;;^UTILITY(U,$J,358.3,6573,2)
 ;;=^269573
 ;;^UTILITY(U,$J,358.3,6574,0)
 ;;=I06.1^^53^418^1
 ;;^UTILITY(U,$J,358.3,6574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6574,1,3,0)
 ;;=3^Rheumatic Aortic Insufficiency
 ;;^UTILITY(U,$J,358.3,6574,1,4,0)
 ;;=4^I06.1
 ;;^UTILITY(U,$J,358.3,6574,2)
 ;;=^269575
 ;;^UTILITY(U,$J,358.3,6575,0)
 ;;=I06.2^^53^418^3
 ;;^UTILITY(U,$J,358.3,6575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6575,1,3,0)
 ;;=3^Rheumatic Aortic Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,6575,1,4,0)
 ;;=4^I06.2
 ;;^UTILITY(U,$J,358.3,6575,2)
 ;;=^269577
 ;;^UTILITY(U,$J,358.3,6576,0)
 ;;=I06.8^^53^418^4
 ;;^UTILITY(U,$J,358.3,6576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6576,1,3,0)
 ;;=3^Rheumatic Aortic Valve Diseases NEC
 ;;^UTILITY(U,$J,358.3,6576,1,4,0)
 ;;=4^I06.8
 ;;^UTILITY(U,$J,358.3,6576,2)
 ;;=^5007045
 ;;^UTILITY(U,$J,358.3,6577,0)
 ;;=I09.89^^53^418^6
 ;;^UTILITY(U,$J,358.3,6577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6577,1,3,0)
 ;;=3^Rheumatic Heart Diseases
 ;;^UTILITY(U,$J,358.3,6577,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,6577,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,6578,0)
 ;;=I08.8^^53^418^11
 ;;^UTILITY(U,$J,358.3,6578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6578,1,3,0)
 ;;=3^Rheumatic Multiple Valve Dieases NEC
 ;;^UTILITY(U,$J,358.3,6578,1,4,0)
 ;;=4^I08.8
 ;;^UTILITY(U,$J,358.3,6578,2)
 ;;=^5007056
 ;;^UTILITY(U,$J,358.3,6579,0)
 ;;=T82.9XXA^^53^419^2
 ;;^UTILITY(U,$J,358.3,6579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6579,1,3,0)
 ;;=3^Complication of Cardiac/Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6579,1,4,0)
 ;;=4^T82.9XXA
 ;;^UTILITY(U,$J,358.3,6579,2)
 ;;=^5054956
 ;;^UTILITY(U,$J,358.3,6580,0)
 ;;=T82.857A^^53^419^9
 ;;^UTILITY(U,$J,358.3,6580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6580,1,3,0)
 ;;=3^Stenosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,6580,1,4,0)
 ;;=4^T82.857A
 ;;^UTILITY(U,$J,358.3,6580,2)
 ;;=^5054938
