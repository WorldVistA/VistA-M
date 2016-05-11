IBDEI04Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1786,1,4,0)
 ;;=4^I70.513
 ;;^UTILITY(U,$J,358.3,1786,2)
 ;;=^5007694
 ;;^UTILITY(U,$J,358.3,1787,0)
 ;;=I70.8^^11^156^15
 ;;^UTILITY(U,$J,358.3,1787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1787,1,3,0)
 ;;=3^Atherosclerosis of Oth Arteries
 ;;^UTILITY(U,$J,358.3,1787,1,4,0)
 ;;=4^I70.8
 ;;^UTILITY(U,$J,358.3,1787,2)
 ;;=^5007783
 ;;^UTILITY(U,$J,358.3,1788,0)
 ;;=I71.00^^11^156^62
 ;;^UTILITY(U,$J,358.3,1788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1788,1,3,0)
 ;;=3^Dissection of Aorta,Unspec Site
 ;;^UTILITY(U,$J,358.3,1788,1,4,0)
 ;;=4^I71.00
 ;;^UTILITY(U,$J,358.3,1788,2)
 ;;=^35660
 ;;^UTILITY(U,$J,358.3,1789,0)
 ;;=I71.01^^11^156^63
 ;;^UTILITY(U,$J,358.3,1789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1789,1,3,0)
 ;;=3^Dissection of Thoracic Aorta
 ;;^UTILITY(U,$J,358.3,1789,1,4,0)
 ;;=4^I71.01
 ;;^UTILITY(U,$J,358.3,1789,2)
 ;;=^303289
 ;;^UTILITY(U,$J,358.3,1790,0)
 ;;=I71.02^^11^156^61
 ;;^UTILITY(U,$J,358.3,1790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1790,1,3,0)
 ;;=3^Dissection of Abdominal Aorta
 ;;^UTILITY(U,$J,358.3,1790,1,4,0)
 ;;=4^I71.02
 ;;^UTILITY(U,$J,358.3,1790,2)
 ;;=^303290
 ;;^UTILITY(U,$J,358.3,1791,0)
 ;;=I71.03^^11^156^64
 ;;^UTILITY(U,$J,358.3,1791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1791,1,3,0)
 ;;=3^Dissection of Thoracoabdominal Aorta
 ;;^UTILITY(U,$J,358.3,1791,1,4,0)
 ;;=4^I71.03
 ;;^UTILITY(U,$J,358.3,1791,2)
 ;;=^303291
 ;;^UTILITY(U,$J,358.3,1792,0)
 ;;=I71.1^^11^156^87
 ;;^UTILITY(U,$J,358.3,1792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1792,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,1792,1,4,0)
 ;;=4^I71.1
 ;;^UTILITY(U,$J,358.3,1792,2)
 ;;=^5007786
 ;;^UTILITY(U,$J,358.3,1793,0)
 ;;=I71.2^^11^156^88
 ;;^UTILITY(U,$J,358.3,1793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1793,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,1793,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,1793,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,1794,0)
 ;;=I71.3^^11^156^1
 ;;^UTILITY(U,$J,358.3,1794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1794,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,1794,1,4,0)
 ;;=4^I71.3
 ;;^UTILITY(U,$J,358.3,1794,2)
 ;;=^5007788
 ;;^UTILITY(U,$J,358.3,1795,0)
 ;;=I71.4^^11^156^2
 ;;^UTILITY(U,$J,358.3,1795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1795,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,1795,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,1795,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,1796,0)
 ;;=I71.8^^11^156^9
 ;;^UTILITY(U,$J,358.3,1796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1796,1,3,0)
 ;;=3^Aortic Aneurysm of Unspec Site w/ Rupture
 ;;^UTILITY(U,$J,358.3,1796,1,4,0)
 ;;=4^I71.8
 ;;^UTILITY(U,$J,358.3,1796,2)
 ;;=^9279
 ;;^UTILITY(U,$J,358.3,1797,0)
 ;;=I71.5^^11^156^89
 ;;^UTILITY(U,$J,358.3,1797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1797,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,1797,1,4,0)
 ;;=4^I71.5
 ;;^UTILITY(U,$J,358.3,1797,2)
 ;;=^5007790
 ;;^UTILITY(U,$J,358.3,1798,0)
 ;;=I71.6^^11^156^90
 ;;^UTILITY(U,$J,358.3,1798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1798,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,1798,1,4,0)
 ;;=4^I71.6
 ;;^UTILITY(U,$J,358.3,1798,2)
 ;;=^5007791
 ;;^UTILITY(U,$J,358.3,1799,0)
 ;;=I72.1^^11^156^8
 ;;^UTILITY(U,$J,358.3,1799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1799,1,3,0)
 ;;=3^Aneurysm of Upper Extremity Artery
 ;;^UTILITY(U,$J,358.3,1799,1,4,0)
 ;;=4^I72.1
