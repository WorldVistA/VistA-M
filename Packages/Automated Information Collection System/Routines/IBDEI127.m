IBDEI127 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17993,1,4,0)
 ;;=4^T80.212A
 ;;^UTILITY(U,$J,358.3,17993,2)
 ;;=^5054353
 ;;^UTILITY(U,$J,358.3,17994,0)
 ;;=T80.22XA^^76^860^3
 ;;^UTILITY(U,$J,358.3,17994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17994,1,3,0)
 ;;=3^Infection Following Transfusion/Infusion/Injec Blood Products,Init Encntr
 ;;^UTILITY(U,$J,358.3,17994,1,4,0)
 ;;=4^T80.22XA
 ;;^UTILITY(U,$J,358.3,17994,2)
 ;;=^5054362
 ;;^UTILITY(U,$J,358.3,17995,0)
 ;;=T80.29XA^^76^860^2
 ;;^UTILITY(U,$J,358.3,17995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17995,1,3,0)
 ;;=3^Infection Following Infusion/Transfusion/Therapeutic Injection,Init Encntr
 ;;^UTILITY(U,$J,358.3,17995,1,4,0)
 ;;=4^T80.29XA
 ;;^UTILITY(U,$J,358.3,17995,2)
 ;;=^5054365
 ;;^UTILITY(U,$J,358.3,17996,0)
 ;;=T81.4XXA^^76^860^4
 ;;^UTILITY(U,$J,358.3,17996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17996,1,3,0)
 ;;=3^Infection Following a Procedure NEC,Init  Encntr
 ;;^UTILITY(U,$J,358.3,17996,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,17996,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,17997,0)
 ;;=T83.51XA^^76^860^8
 ;;^UTILITY(U,$J,358.3,17997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17997,1,3,0)
 ;;=3^Infection d/t Indwelling Urinary Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,17997,1,4,0)
 ;;=4^T83.51XA
 ;;^UTILITY(U,$J,358.3,17997,2)
 ;;=^5055058
 ;;^UTILITY(U,$J,358.3,17998,0)
 ;;=T85.79XA^^76^860^7
 ;;^UTILITY(U,$J,358.3,17998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17998,1,3,0)
 ;;=3^Infection d/t Implantable Device Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,17998,1,4,0)
 ;;=4^T85.79XA
 ;;^UTILITY(U,$J,358.3,17998,2)
 ;;=^5055676
 ;;^UTILITY(U,$J,358.3,17999,0)
 ;;=T82.6XXA^^76^860^5
 ;;^UTILITY(U,$J,358.3,17999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17999,1,3,0)
 ;;=3^Infection d/t Cardiac Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,17999,1,4,0)
 ;;=4^T82.6XXA
 ;;^UTILITY(U,$J,358.3,17999,2)
 ;;=^5054908
 ;;^UTILITY(U,$J,358.3,18000,0)
 ;;=T84.52XA^^76^860^9
 ;;^UTILITY(U,$J,358.3,18000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18000,1,3,0)
 ;;=3^Infection d/t Left Hip Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,18000,1,4,0)
 ;;=4^T84.52XA
 ;;^UTILITY(U,$J,358.3,18000,2)
 ;;=^5055388
 ;;^UTILITY(U,$J,358.3,18001,0)
 ;;=T84.54XA^^76^860^10
 ;;^UTILITY(U,$J,358.3,18001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18001,1,3,0)
 ;;=3^Infection d/t Left Knee Prosthesis,Init Encntrreaction due to internal left knee prosth, init
 ;;^UTILITY(U,$J,358.3,18001,1,4,0)
 ;;=4^T84.54XA
 ;;^UTILITY(U,$J,358.3,18001,2)
 ;;=^5055394
 ;;^UTILITY(U,$J,358.3,18002,0)
 ;;=T84.51XA^^76^860^11
 ;;^UTILITY(U,$J,358.3,18002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18002,1,3,0)
 ;;=3^Infection d/t Right Hip Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,18002,1,4,0)
 ;;=4^T84.51XA
 ;;^UTILITY(U,$J,358.3,18002,2)
 ;;=^5055385
 ;;^UTILITY(U,$J,358.3,18003,0)
 ;;=T84.53XA^^76^860^12
 ;;^UTILITY(U,$J,358.3,18003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18003,1,3,0)
 ;;=3^Infection d/t Right Knee Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,18003,1,4,0)
 ;;=4^T84.53XA
 ;;^UTILITY(U,$J,358.3,18003,2)
 ;;=^5055391
 ;;^UTILITY(U,$J,358.3,18004,0)
 ;;=T84.59XA^^76^860^13
 ;;^UTILITY(U,$J,358.3,18004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18004,1,3,0)
 ;;=3^Infection d/t Shoulder Joint Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,18004,1,4,0)
 ;;=4^T84.59XA
 ;;^UTILITY(U,$J,358.3,18004,2)
 ;;=^5055397
 ;;^UTILITY(U,$J,358.3,18005,0)
 ;;=47000^^77^861^3^^^^1
 ;;^UTILITY(U,$J,358.3,18005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18005,1,2,0)
 ;;=2^Percutaneous Liver Biopsy
