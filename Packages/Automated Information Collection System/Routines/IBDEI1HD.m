IBDEI1HD ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24754,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,24754,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,24755,0)
 ;;=E55.9^^121^1222^98
 ;;^UTILITY(U,$J,358.3,24755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24755,1,3,0)
 ;;=3^Vitamin D Deficiency
 ;;^UTILITY(U,$J,358.3,24755,1,4,0)
 ;;=4^E55.9
 ;;^UTILITY(U,$J,358.3,24755,2)
 ;;=^5002799
 ;;^UTILITY(U,$J,358.3,24756,0)
 ;;=R63.4^^121^1222^99
 ;;^UTILITY(U,$J,358.3,24756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24756,1,3,0)
 ;;=3^Weight Loss
 ;;^UTILITY(U,$J,358.3,24756,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,24756,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,24757,0)
 ;;=T80.219A^^121^1223^6
 ;;^UTILITY(U,$J,358.3,24757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24757,1,3,0)
 ;;=3^Infection d/t Central Venous Cath,Init Encntr
 ;;^UTILITY(U,$J,358.3,24757,1,4,0)
 ;;=4^T80.219A
 ;;^UTILITY(U,$J,358.3,24757,2)
 ;;=^5054359
 ;;^UTILITY(U,$J,358.3,24758,0)
 ;;=T80.211A^^121^1223^1
 ;;^UTILITY(U,$J,358.3,24758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24758,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,24758,1,4,0)
 ;;=4^T80.211A
 ;;^UTILITY(U,$J,358.3,24758,2)
 ;;=^5054350
 ;;^UTILITY(U,$J,358.3,24759,0)
 ;;=T80.212A^^121^1223^14
 ;;^UTILITY(U,$J,358.3,24759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24759,1,3,0)
 ;;=3^Local Infection d/t Central Venous Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,24759,1,4,0)
 ;;=4^T80.212A
 ;;^UTILITY(U,$J,358.3,24759,2)
 ;;=^5054353
 ;;^UTILITY(U,$J,358.3,24760,0)
 ;;=T80.22XA^^121^1223^3
 ;;^UTILITY(U,$J,358.3,24760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24760,1,3,0)
 ;;=3^Infection Following Transfusion/Infusion/Injec Blood Products,Init Encntr
 ;;^UTILITY(U,$J,358.3,24760,1,4,0)
 ;;=4^T80.22XA
 ;;^UTILITY(U,$J,358.3,24760,2)
 ;;=^5054362
 ;;^UTILITY(U,$J,358.3,24761,0)
 ;;=T80.29XA^^121^1223^2
 ;;^UTILITY(U,$J,358.3,24761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24761,1,3,0)
 ;;=3^Infection Following Infusion/Transfusion/Therapeutic Injection,Init Encntr
 ;;^UTILITY(U,$J,358.3,24761,1,4,0)
 ;;=4^T80.29XA
 ;;^UTILITY(U,$J,358.3,24761,2)
 ;;=^5054365
 ;;^UTILITY(U,$J,358.3,24762,0)
 ;;=T81.4XXA^^121^1223^4
 ;;^UTILITY(U,$J,358.3,24762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24762,1,3,0)
 ;;=3^Infection Following a Procedure NEC,Init  Encntr
 ;;^UTILITY(U,$J,358.3,24762,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,24762,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,24763,0)
 ;;=T83.51XA^^121^1223^8
 ;;^UTILITY(U,$J,358.3,24763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24763,1,3,0)
 ;;=3^Infection d/t Indwelling Urinary Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,24763,1,4,0)
 ;;=4^T83.51XA
 ;;^UTILITY(U,$J,358.3,24763,2)
 ;;=^5055058
 ;;^UTILITY(U,$J,358.3,24764,0)
 ;;=T85.79XA^^121^1223^7
 ;;^UTILITY(U,$J,358.3,24764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24764,1,3,0)
 ;;=3^Infection d/t Implantable Device Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,24764,1,4,0)
 ;;=4^T85.79XA
 ;;^UTILITY(U,$J,358.3,24764,2)
 ;;=^5055676
 ;;^UTILITY(U,$J,358.3,24765,0)
 ;;=T82.6XXA^^121^1223^5
 ;;^UTILITY(U,$J,358.3,24765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24765,1,3,0)
 ;;=3^Infection d/t Cardiac Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,24765,1,4,0)
 ;;=4^T82.6XXA
 ;;^UTILITY(U,$J,358.3,24765,2)
 ;;=^5054908
 ;;^UTILITY(U,$J,358.3,24766,0)
 ;;=T84.52XA^^121^1223^9
 ;;^UTILITY(U,$J,358.3,24766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24766,1,3,0)
 ;;=3^Infection d/t Left Hip Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,24766,1,4,0)
 ;;=4^T84.52XA
