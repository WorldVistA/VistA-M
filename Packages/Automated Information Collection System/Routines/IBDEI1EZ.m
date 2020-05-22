IBDEI1EZ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22624,1,3,0)
 ;;=3^Weight Loss
 ;;^UTILITY(U,$J,358.3,22624,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,22624,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,22625,0)
 ;;=Z20.6^^102^1142^19
 ;;^UTILITY(U,$J,358.3,22625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22625,1,3,0)
 ;;=3^Contact/Suspected Exposure to HIV
 ;;^UTILITY(U,$J,358.3,22625,1,4,0)
 ;;=4^Z20.6
 ;;^UTILITY(U,$J,358.3,22625,2)
 ;;=^5062768
 ;;^UTILITY(U,$J,358.3,22626,0)
 ;;=B15.9^^102^1142^43
 ;;^UTILITY(U,$J,358.3,22626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22626,1,3,0)
 ;;=3^Hepatitis A,Acute
 ;;^UTILITY(U,$J,358.3,22626,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,22626,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,22627,0)
 ;;=T80.219A^^102^1143^6
 ;;^UTILITY(U,$J,358.3,22627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22627,1,3,0)
 ;;=3^Infection d/t Central Venous Cath,Init Encntr
 ;;^UTILITY(U,$J,358.3,22627,1,4,0)
 ;;=4^T80.219A
 ;;^UTILITY(U,$J,358.3,22627,2)
 ;;=^5054359
 ;;^UTILITY(U,$J,358.3,22628,0)
 ;;=T80.211A^^102^1143^1
 ;;^UTILITY(U,$J,358.3,22628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22628,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,22628,1,4,0)
 ;;=4^T80.211A
 ;;^UTILITY(U,$J,358.3,22628,2)
 ;;=^5054350
 ;;^UTILITY(U,$J,358.3,22629,0)
 ;;=T80.212A^^102^1143^17
 ;;^UTILITY(U,$J,358.3,22629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22629,1,3,0)
 ;;=3^Local Infection d/t Central Venous Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,22629,1,4,0)
 ;;=4^T80.212A
 ;;^UTILITY(U,$J,358.3,22629,2)
 ;;=^5054353
 ;;^UTILITY(U,$J,358.3,22630,0)
 ;;=T80.22XA^^102^1143^3
 ;;^UTILITY(U,$J,358.3,22630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22630,1,3,0)
 ;;=3^Infection Following Transfusion/Infusion/Injec Blood Products,Init Encntr
 ;;^UTILITY(U,$J,358.3,22630,1,4,0)
 ;;=4^T80.22XA
 ;;^UTILITY(U,$J,358.3,22630,2)
 ;;=^5054362
 ;;^UTILITY(U,$J,358.3,22631,0)
 ;;=T80.29XA^^102^1143^2
 ;;^UTILITY(U,$J,358.3,22631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22631,1,3,0)
 ;;=3^Infection Following Infusion/Transfusion/Therapeutic Injection,Init Encntr
 ;;^UTILITY(U,$J,358.3,22631,1,4,0)
 ;;=4^T80.29XA
 ;;^UTILITY(U,$J,358.3,22631,2)
 ;;=^5054365
 ;;^UTILITY(U,$J,358.3,22632,0)
 ;;=T85.79XA^^102^1143^7
 ;;^UTILITY(U,$J,358.3,22632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22632,1,3,0)
 ;;=3^Infection d/t Implantable Device Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,22632,1,4,0)
 ;;=4^T85.79XA
 ;;^UTILITY(U,$J,358.3,22632,2)
 ;;=^5055676
 ;;^UTILITY(U,$J,358.3,22633,0)
 ;;=T82.6XXA^^102^1143^5
 ;;^UTILITY(U,$J,358.3,22633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22633,1,3,0)
 ;;=3^Infection d/t Cardiac Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,22633,1,4,0)
 ;;=4^T82.6XXA
 ;;^UTILITY(U,$J,358.3,22633,2)
 ;;=^5054908
 ;;^UTILITY(U,$J,358.3,22634,0)
 ;;=T84.52XA^^102^1143^12
 ;;^UTILITY(U,$J,358.3,22634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22634,1,3,0)
 ;;=3^Infection d/t Left Hip Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,22634,1,4,0)
 ;;=4^T84.52XA
 ;;^UTILITY(U,$J,358.3,22634,2)
 ;;=^5055388
 ;;^UTILITY(U,$J,358.3,22635,0)
 ;;=T84.54XA^^102^1143^13
 ;;^UTILITY(U,$J,358.3,22635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22635,1,3,0)
 ;;=3^Infection d/t Left Knee Prosthesis,Init Encntrreaction due to internal left knee prosth, init
 ;;^UTILITY(U,$J,358.3,22635,1,4,0)
 ;;=4^T84.54XA
