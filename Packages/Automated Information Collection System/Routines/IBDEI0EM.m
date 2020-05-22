IBDEI0EM ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6286,1,3,0)
 ;;=3^Athscl Native Cor Art of Transplanted Hrt w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6286,1,4,0)
 ;;=4^I25.759
 ;;^UTILITY(U,$J,358.3,6286,2)
 ;;=^5007134
 ;;^UTILITY(U,$J,358.3,6287,0)
 ;;=I20.8^^53^405^1
 ;;^UTILITY(U,$J,358.3,6287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6287,1,3,0)
 ;;=3^Angina Pectoris NEC
 ;;^UTILITY(U,$J,358.3,6287,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,6287,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,6288,0)
 ;;=I20.9^^53^405^2
 ;;^UTILITY(U,$J,358.3,6288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6288,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,6288,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,6288,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,6289,0)
 ;;=R07.9^^53^405^38
 ;;^UTILITY(U,$J,358.3,6289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6289,1,3,0)
 ;;=3^Chest Pain,Unspec
 ;;^UTILITY(U,$J,358.3,6289,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,6289,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,6290,0)
 ;;=R07.2^^53^405^41
 ;;^UTILITY(U,$J,358.3,6290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6290,1,3,0)
 ;;=3^Precordial Pain
 ;;^UTILITY(U,$J,358.3,6290,1,4,0)
 ;;=4^R07.2
 ;;^UTILITY(U,$J,358.3,6290,2)
 ;;=^5019197
 ;;^UTILITY(U,$J,358.3,6291,0)
 ;;=R07.1^^53^405^37
 ;;^UTILITY(U,$J,358.3,6291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6291,1,3,0)
 ;;=3^Chest Pain on Breathing
 ;;^UTILITY(U,$J,358.3,6291,1,4,0)
 ;;=4^R07.1
 ;;^UTILITY(U,$J,358.3,6291,2)
 ;;=^5019196
 ;;^UTILITY(U,$J,358.3,6292,0)
 ;;=R07.81^^53^405^40
 ;;^UTILITY(U,$J,358.3,6292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6292,1,3,0)
 ;;=3^Pleurodynia
 ;;^UTILITY(U,$J,358.3,6292,1,4,0)
 ;;=4^R07.81
 ;;^UTILITY(U,$J,358.3,6292,2)
 ;;=^5019198
 ;;^UTILITY(U,$J,358.3,6293,0)
 ;;=R07.82^^53^405^39
 ;;^UTILITY(U,$J,358.3,6293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6293,1,3,0)
 ;;=3^Intercostal Pain
 ;;^UTILITY(U,$J,358.3,6293,1,4,0)
 ;;=4^R07.82
 ;;^UTILITY(U,$J,358.3,6293,2)
 ;;=^5019199
 ;;^UTILITY(U,$J,358.3,6294,0)
 ;;=R07.89^^53^405^36
 ;;^UTILITY(U,$J,358.3,6294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6294,1,3,0)
 ;;=3^Chest Pain NEC
 ;;^UTILITY(U,$J,358.3,6294,1,4,0)
 ;;=4^R07.89
 ;;^UTILITY(U,$J,358.3,6294,2)
 ;;=^5019200
 ;;^UTILITY(U,$J,358.3,6295,0)
 ;;=I26.09^^53^406^63
 ;;^UTILITY(U,$J,358.3,6295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6295,1,3,0)
 ;;=3^Pulmonary Embolism w/ Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,6295,1,4,0)
 ;;=4^I26.09
 ;;^UTILITY(U,$J,358.3,6295,2)
 ;;=^5007147
 ;;^UTILITY(U,$J,358.3,6296,0)
 ;;=I26.90^^53^406^70
 ;;^UTILITY(U,$J,358.3,6296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6296,1,3,0)
 ;;=3^Septic Pulmonary Embolism w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,6296,1,4,0)
 ;;=4^I26.90
 ;;^UTILITY(U,$J,358.3,6296,2)
 ;;=^5007148
 ;;^UTILITY(U,$J,358.3,6297,0)
 ;;=I26.99^^53^406^64
 ;;^UTILITY(U,$J,358.3,6297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6297,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale NEC
 ;;^UTILITY(U,$J,358.3,6297,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,6297,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,6298,0)
 ;;=T80.0XXA^^53^406^10
 ;;^UTILITY(U,$J,358.3,6298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6298,1,3,0)
 ;;=3^Air Embolism Following Infusion/Transfusion/Therapeutic Inj,Init Encntr
 ;;^UTILITY(U,$J,358.3,6298,1,4,0)
 ;;=4^T80.0XXA
