IBDEI04S ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1813,1,3,0)
 ;;=3^Embolism/Thrombosis of Iliac Artery
 ;;^UTILITY(U,$J,358.3,1813,1,4,0)
 ;;=4^I74.5
 ;;^UTILITY(U,$J,358.3,1813,2)
 ;;=^269792
 ;;^UTILITY(U,$J,358.3,1814,0)
 ;;=I74.8^^11^156^66
 ;;^UTILITY(U,$J,358.3,1814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1814,1,3,0)
 ;;=3^Embolism/Thrombosis of Arteries NEC
 ;;^UTILITY(U,$J,358.3,1814,1,4,0)
 ;;=4^I74.8
 ;;^UTILITY(U,$J,358.3,1814,2)
 ;;=^5007804
 ;;^UTILITY(U,$J,358.3,1815,0)
 ;;=I77.0^^11^156^12
 ;;^UTILITY(U,$J,358.3,1815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1815,1,3,0)
 ;;=3^Arteriovenous Fistula,Acquired
 ;;^UTILITY(U,$J,358.3,1815,1,4,0)
 ;;=4^I77.0
 ;;^UTILITY(U,$J,358.3,1815,2)
 ;;=^46674
 ;;^UTILITY(U,$J,358.3,1816,0)
 ;;=I77.1^^11^156^86
 ;;^UTILITY(U,$J,358.3,1816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1816,1,3,0)
 ;;=3^Stricture of Artery
 ;;^UTILITY(U,$J,358.3,1816,1,4,0)
 ;;=4^I77.1
 ;;^UTILITY(U,$J,358.3,1816,2)
 ;;=^114763
 ;;^UTILITY(U,$J,358.3,1817,0)
 ;;=I77.3^^11^156^11
 ;;^UTILITY(U,$J,358.3,1817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1817,1,3,0)
 ;;=3^Arterial Fibromuscular Dysplasia
 ;;^UTILITY(U,$J,358.3,1817,1,4,0)
 ;;=4^I77.3
 ;;^UTILITY(U,$J,358.3,1817,2)
 ;;=^5007812
 ;;^UTILITY(U,$J,358.3,1818,0)
 ;;=I77.6^^11^156^13
 ;;^UTILITY(U,$J,358.3,1818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1818,1,3,0)
 ;;=3^Arteritis,Unspec
 ;;^UTILITY(U,$J,358.3,1818,1,4,0)
 ;;=4^I77.6
 ;;^UTILITY(U,$J,358.3,1818,2)
 ;;=^5007813
 ;;^UTILITY(U,$J,358.3,1819,0)
 ;;=I82.90^^11^156^71
 ;;^UTILITY(U,$J,358.3,1819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1819,1,3,0)
 ;;=3^Embolism/Thrombosis of Unspec Vein,Acute
 ;;^UTILITY(U,$J,358.3,1819,1,4,0)
 ;;=4^I82.90
 ;;^UTILITY(U,$J,358.3,1819,2)
 ;;=^5007940
 ;;^UTILITY(U,$J,358.3,1820,0)
 ;;=I82.91^^11^156^72
 ;;^UTILITY(U,$J,358.3,1820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1820,1,3,0)
 ;;=3^Embolism/Thrombosis of Unspec Vein,Chronic
 ;;^UTILITY(U,$J,358.3,1820,1,4,0)
 ;;=4^I82.91
 ;;^UTILITY(U,$J,358.3,1820,2)
 ;;=^5007941
 ;;^UTILITY(U,$J,358.3,1821,0)
 ;;=I87.2^^11^156^96
 ;;^UTILITY(U,$J,358.3,1821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1821,1,3,0)
 ;;=3^Venous Insufficiency
 ;;^UTILITY(U,$J,358.3,1821,1,4,0)
 ;;=4^I87.2
 ;;^UTILITY(U,$J,358.3,1821,2)
 ;;=^5008047
 ;;^UTILITY(U,$J,358.3,1822,0)
 ;;=I82.0^^11^156^51
 ;;^UTILITY(U,$J,358.3,1822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1822,1,3,0)
 ;;=3^Budd-Chiari Syndrome
 ;;^UTILITY(U,$J,358.3,1822,1,4,0)
 ;;=4^I82.0
 ;;^UTILITY(U,$J,358.3,1822,2)
 ;;=^5007846
 ;;^UTILITY(U,$J,358.3,1823,0)
 ;;=I82.1^^11^156^92
 ;;^UTILITY(U,$J,358.3,1823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1823,1,3,0)
 ;;=3^Thrombophlebitis Migrans
 ;;^UTILITY(U,$J,358.3,1823,1,4,0)
 ;;=4^I82.1
 ;;^UTILITY(U,$J,358.3,1823,2)
 ;;=^5007847
 ;;^UTILITY(U,$J,358.3,1824,0)
 ;;=I82.3^^11^156^69
 ;;^UTILITY(U,$J,358.3,1824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1824,1,3,0)
 ;;=3^Embolism/Thrombosis of Renal Vein
 ;;^UTILITY(U,$J,358.3,1824,1,4,0)
 ;;=4^I82.3
 ;;^UTILITY(U,$J,358.3,1824,2)
 ;;=^269818
 ;;^UTILITY(U,$J,358.3,1825,0)
 ;;=I87.1^^11^156^95
 ;;^UTILITY(U,$J,358.3,1825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1825,1,3,0)
 ;;=3^Vein Compression
 ;;^UTILITY(U,$J,358.3,1825,1,4,0)
 ;;=4^I87.1
 ;;^UTILITY(U,$J,358.3,1825,2)
 ;;=^269850
 ;;^UTILITY(U,$J,358.3,1826,0)
 ;;=T82.818A^^11^156^65
 ;;^UTILITY(U,$J,358.3,1826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1826,1,3,0)
 ;;=3^Embolism of Vascular Prosthetic Device/Implant/Graft,Init Encntr
