IBDEI062 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2237,1,3,0)
 ;;=3^Pulmonary Embolism w/ Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,2237,1,4,0)
 ;;=4^I26.09
 ;;^UTILITY(U,$J,358.3,2237,2)
 ;;=^5007147
 ;;^UTILITY(U,$J,358.3,2238,0)
 ;;=I26.90^^19^192^53
 ;;^UTILITY(U,$J,358.3,2238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2238,1,3,0)
 ;;=3^Septic Pulmonary Embolism w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,2238,1,4,0)
 ;;=4^I26.90
 ;;^UTILITY(U,$J,358.3,2238,2)
 ;;=^5007148
 ;;^UTILITY(U,$J,358.3,2239,0)
 ;;=I26.99^^19^192^48
 ;;^UTILITY(U,$J,358.3,2239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2239,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale NEC
 ;;^UTILITY(U,$J,358.3,2239,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,2239,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,2240,0)
 ;;=T80.0XXA^^19^192^3
 ;;^UTILITY(U,$J,358.3,2240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2240,1,3,0)
 ;;=3^Air Embolism Following Infusion/Transfusion/Therapeutic Inj,Init Encntr
 ;;^UTILITY(U,$J,358.3,2240,1,4,0)
 ;;=4^T80.0XXA
 ;;^UTILITY(U,$J,358.3,2240,2)
 ;;=^5054344
 ;;^UTILITY(U,$J,358.3,2241,0)
 ;;=T81.718A^^19^192^10
 ;;^UTILITY(U,$J,358.3,2241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2241,1,3,0)
 ;;=3^Complication of Artery Following Procedure NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,2241,1,4,0)
 ;;=4^T81.718A
 ;;^UTILITY(U,$J,358.3,2241,2)
 ;;=^5054644
 ;;^UTILITY(U,$J,358.3,2242,0)
 ;;=T81.72XA^^19^192^15
 ;;^UTILITY(U,$J,358.3,2242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2242,1,3,0)
 ;;=3^Complication of Vein Following Procedure NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,2242,1,4,0)
 ;;=4^T81.72XA
 ;;^UTILITY(U,$J,358.3,2242,2)
 ;;=^5054650
 ;;^UTILITY(U,$J,358.3,2243,0)
 ;;=T82.817A^^19^192^20
 ;;^UTILITY(U,$J,358.3,2243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2243,1,3,0)
 ;;=3^Embolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2243,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,2243,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,2244,0)
 ;;=T82.818A^^19^192^21
 ;;^UTILITY(U,$J,358.3,2244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2244,1,3,0)
 ;;=3^Embolism of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,2244,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,2244,2)
 ;;=^5054917
 ;;^UTILITY(U,$J,358.3,2245,0)
 ;;=I26.99^^19^192^49
 ;;^UTILITY(U,$J,358.3,2245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2245,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale NEC
 ;;^UTILITY(U,$J,358.3,2245,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,2245,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,2246,0)
 ;;=I27.0^^19^192^46
 ;;^UTILITY(U,$J,358.3,2246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2246,1,3,0)
 ;;=3^Primary Pulmonary Hypertension
 ;;^UTILITY(U,$J,358.3,2246,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,2246,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,2247,0)
 ;;=I27.1^^19^192^32
 ;;^UTILITY(U,$J,358.3,2247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2247,1,3,0)
 ;;=3^Kyphoscoliotic Hrt Disease
 ;;^UTILITY(U,$J,358.3,2247,1,4,0)
 ;;=4^I27.1
 ;;^UTILITY(U,$J,358.3,2247,2)
 ;;=^265120
 ;;^UTILITY(U,$J,358.3,2248,0)
 ;;=I27.2^^19^192^52
 ;;^UTILITY(U,$J,358.3,2248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2248,1,3,0)
 ;;=3^Secondary Pulmonary Hypertension NEC
 ;;^UTILITY(U,$J,358.3,2248,1,4,0)
 ;;=4^I27.2
 ;;^UTILITY(U,$J,358.3,2248,2)
 ;;=^5007151
 ;;^UTILITY(U,$J,358.3,2249,0)
 ;;=I27.89^^19^192^50
 ;;^UTILITY(U,$J,358.3,2249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2249,1,3,0)
 ;;=3^Pulmonary Hrt Diseases NEC
