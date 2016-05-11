IBDEI04L ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1725,0)
 ;;=T82.02XA^^11^155^2
 ;;^UTILITY(U,$J,358.3,1725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1725,1,3,0)
 ;;=3^Displacement of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,1725,1,4,0)
 ;;=4^T82.02XA
 ;;^UTILITY(U,$J,358.3,1725,2)
 ;;=^5054671
 ;;^UTILITY(U,$J,358.3,1726,0)
 ;;=T82.03XA^^11^155^5
 ;;^UTILITY(U,$J,358.3,1726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1726,1,3,0)
 ;;=3^Leakage of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,1726,1,4,0)
 ;;=4^T82.03XA
 ;;^UTILITY(U,$J,358.3,1726,2)
 ;;=^5054674
 ;;^UTILITY(U,$J,358.3,1727,0)
 ;;=T82.09XA^^11^155^7
 ;;^UTILITY(U,$J,358.3,1727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1727,1,3,0)
 ;;=3^Mech Compl of Heart Valve Prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,1727,1,4,0)
 ;;=4^T82.09XA
 ;;^UTILITY(U,$J,358.3,1727,2)
 ;;=^5054677
 ;;^UTILITY(U,$J,358.3,1728,0)
 ;;=T82.817A^^11^155^3
 ;;^UTILITY(U,$J,358.3,1728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1728,1,3,0)
 ;;=3^Embolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1728,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,1728,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,1729,0)
 ;;=T82.867A^^11^155^10
 ;;^UTILITY(U,$J,358.3,1729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1729,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1729,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,1729,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,1730,0)
 ;;=Z95.2^^11^155^9
 ;;^UTILITY(U,$J,358.3,1730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1730,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,1730,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,1730,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,1731,0)
 ;;=Z98.89^^11^155^8
 ;;^UTILITY(U,$J,358.3,1731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1731,1,3,0)
 ;;=3^Postprocedural States NEC
 ;;^UTILITY(U,$J,358.3,1731,1,4,0)
 ;;=4^Z98.89
 ;;^UTILITY(U,$J,358.3,1731,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,1732,0)
 ;;=Z79.01^^11^155^6
 ;;^UTILITY(U,$J,358.3,1732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1732,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,1732,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,1732,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,1733,0)
 ;;=I65.1^^11^156^75
 ;;^UTILITY(U,$J,358.3,1733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1733,1,3,0)
 ;;=3^Occlusion/Stenosis of Basilar Artery
 ;;^UTILITY(U,$J,358.3,1733,1,4,0)
 ;;=4^I65.1
 ;;^UTILITY(U,$J,358.3,1733,2)
 ;;=^269747
 ;;^UTILITY(U,$J,358.3,1734,0)
 ;;=I63.22^^11^156^52
 ;;^UTILITY(U,$J,358.3,1734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1734,1,3,0)
 ;;=3^Cerebral Inarction d/t Unspec Occlusion/Stenosis of Basilar Arteries
 ;;^UTILITY(U,$J,358.3,1734,1,4,0)
 ;;=4^I63.22
 ;;^UTILITY(U,$J,358.3,1734,2)
 ;;=^5007315
 ;;^UTILITY(U,$J,358.3,1735,0)
 ;;=I65.21^^11^156^81
 ;;^UTILITY(U,$J,358.3,1735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1735,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,1735,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,1735,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,1736,0)
 ;;=I65.22^^11^156^78
 ;;^UTILITY(U,$J,358.3,1736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1736,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,1736,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,1736,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,1737,0)
 ;;=I65.23^^11^156^76
 ;;^UTILITY(U,$J,358.3,1737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1737,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
