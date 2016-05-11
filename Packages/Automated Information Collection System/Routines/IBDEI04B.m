IBDEI04B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1592,1,3,0)
 ;;=3^Complication of Vein Following Procedure NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,1592,1,4,0)
 ;;=4^T81.72XA
 ;;^UTILITY(U,$J,358.3,1592,2)
 ;;=^5054650
 ;;^UTILITY(U,$J,358.3,1593,0)
 ;;=T82.817A^^11^145^20
 ;;^UTILITY(U,$J,358.3,1593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1593,1,3,0)
 ;;=3^Embolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1593,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,1593,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,1594,0)
 ;;=T82.818A^^11^145^21
 ;;^UTILITY(U,$J,358.3,1594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1594,1,3,0)
 ;;=3^Embolism of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1594,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,1594,2)
 ;;=^5054917
 ;;^UTILITY(U,$J,358.3,1595,0)
 ;;=I26.99^^11^145^49
 ;;^UTILITY(U,$J,358.3,1595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1595,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale NEC
 ;;^UTILITY(U,$J,358.3,1595,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,1595,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,1596,0)
 ;;=I27.0^^11^145^46
 ;;^UTILITY(U,$J,358.3,1596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1596,1,3,0)
 ;;=3^Primary Pulmonary Hypertension
 ;;^UTILITY(U,$J,358.3,1596,1,4,0)
 ;;=4^I27.0
 ;;^UTILITY(U,$J,358.3,1596,2)
 ;;=^265310
 ;;^UTILITY(U,$J,358.3,1597,0)
 ;;=I27.1^^11^145^32
 ;;^UTILITY(U,$J,358.3,1597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1597,1,3,0)
 ;;=3^Kyphoscoliotic Hrt Disease
 ;;^UTILITY(U,$J,358.3,1597,1,4,0)
 ;;=4^I27.1
 ;;^UTILITY(U,$J,358.3,1597,2)
 ;;=^265120
 ;;^UTILITY(U,$J,358.3,1598,0)
 ;;=I27.2^^11^145^52
 ;;^UTILITY(U,$J,358.3,1598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1598,1,3,0)
 ;;=3^Secondary Pulmonary Hypertension NEC
 ;;^UTILITY(U,$J,358.3,1598,1,4,0)
 ;;=4^I27.2
 ;;^UTILITY(U,$J,358.3,1598,2)
 ;;=^5007151
 ;;^UTILITY(U,$J,358.3,1599,0)
 ;;=I27.89^^11^145^50
 ;;^UTILITY(U,$J,358.3,1599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1599,1,3,0)
 ;;=3^Pulmonary Hrt Diseases NEC
 ;;^UTILITY(U,$J,358.3,1599,1,4,0)
 ;;=4^I27.89
 ;;^UTILITY(U,$J,358.3,1599,2)
 ;;=^5007153
 ;;^UTILITY(U,$J,358.3,1600,0)
 ;;=I27.81^^11^145^18
 ;;^UTILITY(U,$J,358.3,1600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1600,1,3,0)
 ;;=3^Cor Pulmonale,Chronic
 ;;^UTILITY(U,$J,358.3,1600,1,4,0)
 ;;=4^I27.81
 ;;^UTILITY(U,$J,358.3,1600,2)
 ;;=^5007152
 ;;^UTILITY(U,$J,358.3,1601,0)
 ;;=I42.1^^11^145^36
 ;;^UTILITY(U,$J,358.3,1601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1601,1,3,0)
 ;;=3^Obstructive Hypertrophic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,1601,1,4,0)
 ;;=4^I42.1
 ;;^UTILITY(U,$J,358.3,1601,2)
 ;;=^340520
 ;;^UTILITY(U,$J,358.3,1602,0)
 ;;=I42.2^^11^145^31
 ;;^UTILITY(U,$J,358.3,1602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1602,1,3,0)
 ;;=3^Hypertrophic Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,1602,1,4,0)
 ;;=4^I42.2
 ;;^UTILITY(U,$J,358.3,1602,2)
 ;;=^340521
 ;;^UTILITY(U,$J,358.3,1603,0)
 ;;=I42.5^^11^145^51
 ;;^UTILITY(U,$J,358.3,1603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1603,1,3,0)
 ;;=3^Restrictive Cardiomyopathy NEC
 ;;^UTILITY(U,$J,358.3,1603,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,1603,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,1604,0)
 ;;=I42.6^^11^145^4
 ;;^UTILITY(U,$J,358.3,1604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1604,1,3,0)
 ;;=3^Alcoholic Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,1604,1,4,0)
 ;;=4^I42.6
 ;;^UTILITY(U,$J,358.3,1604,2)
 ;;=^5007197
 ;;^UTILITY(U,$J,358.3,1605,0)
 ;;=I43.^^11^145^8
