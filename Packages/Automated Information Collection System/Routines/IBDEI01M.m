IBDEI01M ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1792,1,3,0)
 ;;=3^Amputation,Traumatic,Left 1 Lesser Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,1792,1,4,0)
 ;;=4^S98.132A
 ;;^UTILITY(U,$J,358.3,1792,2)
 ;;=^5046284
 ;;^UTILITY(U,$J,358.3,1793,0)
 ;;=S98.212A^^8^91^45
 ;;^UTILITY(U,$J,358.3,1793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1793,1,3,0)
 ;;=3^Amputation,Traumatic,Left 2 or More Lesser Toes,Init Encntr
 ;;^UTILITY(U,$J,358.3,1793,1,4,0)
 ;;=4^S98.212A
 ;;^UTILITY(U,$J,358.3,1793,2)
 ;;=^5046302
 ;;^UTILITY(U,$J,358.3,1794,0)
 ;;=S68.111A^^8^91^49
 ;;^UTILITY(U,$J,358.3,1794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1794,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1794,1,4,0)
 ;;=4^S68.111A
 ;;^UTILITY(U,$J,358.3,1794,2)
 ;;=^5036642
 ;;^UTILITY(U,$J,358.3,1795,0)
 ;;=S68.117A^^8^91^50
 ;;^UTILITY(U,$J,358.3,1795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1795,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1795,1,4,0)
 ;;=4^S68.117A
 ;;^UTILITY(U,$J,358.3,1795,2)
 ;;=^5036660
 ;;^UTILITY(U,$J,358.3,1796,0)
 ;;=S68.113A^^8^91^51
 ;;^UTILITY(U,$J,358.3,1796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1796,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1796,1,4,0)
 ;;=4^S68.113A
 ;;^UTILITY(U,$J,358.3,1796,2)
 ;;=^5036648
 ;;^UTILITY(U,$J,358.3,1797,0)
 ;;=S68.115A^^8^91^52
 ;;^UTILITY(U,$J,358.3,1797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1797,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1797,1,4,0)
 ;;=4^S68.115A
 ;;^UTILITY(U,$J,358.3,1797,2)
 ;;=^5036654
 ;;^UTILITY(U,$J,358.3,1798,0)
 ;;=S68.012A^^8^91^53
 ;;^UTILITY(U,$J,358.3,1798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1798,1,3,0)
 ;;=3^Amputation,Traumatic,Left MCP Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,1798,1,4,0)
 ;;=4^S68.012A
 ;;^UTILITY(U,$J,358.3,1798,2)
 ;;=^5036624
 ;;^UTILITY(U,$J,358.3,1799,0)
 ;;=S68.611A^^8^91^56
 ;;^UTILITY(U,$J,358.3,1799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1799,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1799,1,4,0)
 ;;=4^S68.611A
 ;;^UTILITY(U,$J,358.3,1799,2)
 ;;=^5036738
 ;;^UTILITY(U,$J,358.3,1800,0)
 ;;=S68.617A^^8^91^57
 ;;^UTILITY(U,$J,358.3,1800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1800,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1800,1,4,0)
 ;;=4^S68.617A
 ;;^UTILITY(U,$J,358.3,1800,2)
 ;;=^5036756
 ;;^UTILITY(U,$J,358.3,1801,0)
 ;;=S68.613A^^8^91^58
 ;;^UTILITY(U,$J,358.3,1801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1801,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1801,1,4,0)
 ;;=4^S68.613A
 ;;^UTILITY(U,$J,358.3,1801,2)
 ;;=^5036744
 ;;^UTILITY(U,$J,358.3,1802,0)
 ;;=S68.615A^^8^91^59
 ;;^UTILITY(U,$J,358.3,1802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1802,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1802,1,4,0)
 ;;=4^S68.615A
 ;;^UTILITY(U,$J,358.3,1802,2)
 ;;=^5036750
 ;;^UTILITY(U,$J,358.3,1803,0)
 ;;=S68.512A^^8^91^60
 ;;^UTILITY(U,$J,358.3,1803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1803,1,3,0)
 ;;=3^Amputation,Traumatic,Left Trnsphal Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,1803,1,4,0)
 ;;=4^S68.512A
 ;;^UTILITY(U,$J,358.3,1803,2)
 ;;=^5036720
 ;;^UTILITY(U,$J,358.3,1804,0)
 ;;=S58.111A^^8^91^63
 ;;^UTILITY(U,$J,358.3,1804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1804,1,3,0)
 ;;=3^Amputation,Traumatic,Right Arm Between Elbow & Wrist Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,1804,1,4,0)
 ;;=4^S58.111A
 ;;^UTILITY(U,$J,358.3,1804,2)
 ;;=^5031925
 ;;^UTILITY(U,$J,358.3,1805,0)
 ;;=S98.131A^^8^91^61
 ;;^UTILITY(U,$J,358.3,1805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1805,1,3,0)
 ;;=3^Amputation,Traumatic,Right 1 Lesser Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,1805,1,4,0)
 ;;=4^S98.131A
 ;;^UTILITY(U,$J,358.3,1805,2)
 ;;=^5046281
 ;;^UTILITY(U,$J,358.3,1806,0)
 ;;=S98.011A^^8^91^64
 ;;^UTILITY(U,$J,358.3,1806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1806,1,3,0)
 ;;=3^Amputation,Traumatic,Right Foot at Ankle Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,1806,1,4,0)
 ;;=4^S98.011A
 ;;^UTILITY(U,$J,358.3,1806,2)
 ;;=^5046245
 ;;^UTILITY(U,$J,358.3,1807,0)
 ;;=S98.911A^^8^91^65
 ;;^UTILITY(U,$J,358.3,1807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1807,1,3,0)
 ;;=3^Amputation,Traumatic,Right Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,1807,1,4,0)
 ;;=4^S98.911A
 ;;^UTILITY(U,$J,358.3,1807,2)
 ;;=^5046335
 ;;^UTILITY(U,$J,358.3,1808,0)
 ;;=S98.111A^^8^91^66
 ;;^UTILITY(U,$J,358.3,1808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1808,1,3,0)
 ;;=3^Amputation,Traumatic,Right Great Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,1808,1,4,0)
 ;;=4^S98.111A
 ;;^UTILITY(U,$J,358.3,1808,2)
 ;;=^5046263
 ;;^UTILITY(U,$J,358.3,1809,0)
 ;;=S98.311A^^8^91^72
 ;;^UTILITY(U,$J,358.3,1809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1809,1,3,0)
 ;;=3^Amputation,Traumatic,Right Midfoot,Init Encntr
 ;;^UTILITY(U,$J,358.3,1809,1,4,0)
 ;;=4^S98.311A
 ;;^UTILITY(U,$J,358.3,1809,2)
 ;;=^5046317
 ;;^UTILITY(U,$J,358.3,1810,0)
 ;;=S48.911A^^8^91^73
 ;;^UTILITY(U,$J,358.3,1810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1810,1,3,0)
 ;;=3^Amputation,Traumatic,Right Shoulder/Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,1810,1,4,0)
 ;;=4^S48.911A
 ;;^UTILITY(U,$J,358.3,1810,2)
 ;;=^5028323
 ;;^UTILITY(U,$J,358.3,1811,0)
 ;;=S98.211A^^8^91^62
 ;;^UTILITY(U,$J,358.3,1811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1811,1,3,0)
 ;;=3^Amputation,Traumatic,Right 2 or More Lesser Toes,Init Encntr
 ;;^UTILITY(U,$J,358.3,1811,1,4,0)
 ;;=4^S98.211A
 ;;^UTILITY(U,$J,358.3,1811,2)
 ;;=^5046299
 ;;^UTILITY(U,$J,358.3,1812,0)
 ;;=S68.110A^^8^91^67
 ;;^UTILITY(U,$J,358.3,1812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1812,1,3,0)
 ;;=3^Amputation,Traumatic,Right MCP Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1812,1,4,0)
 ;;=4^S68.110A
 ;;^UTILITY(U,$J,358.3,1812,2)
 ;;=^5036639
 ;;^UTILITY(U,$J,358.3,1813,0)
 ;;=S68.116A^^8^91^68
 ;;^UTILITY(U,$J,358.3,1813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1813,1,3,0)
 ;;=3^Amputation,Traumatic,Right MCP Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1813,1,4,0)
 ;;=4^S68.116A
 ;;^UTILITY(U,$J,358.3,1813,2)
 ;;=^5036657
 ;;^UTILITY(U,$J,358.3,1814,0)
 ;;=S68.112A^^8^91^69
 ;;^UTILITY(U,$J,358.3,1814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1814,1,3,0)
 ;;=3^Amputation,Traumatic,Right MCP Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1814,1,4,0)
 ;;=4^S68.112A
 ;;^UTILITY(U,$J,358.3,1814,2)
 ;;=^5036645
 ;;^UTILITY(U,$J,358.3,1815,0)
 ;;=S68.114A^^8^91^70
 ;;^UTILITY(U,$J,358.3,1815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1815,1,3,0)
 ;;=3^Amputation,Traumatic,Right MCP Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1815,1,4,0)
 ;;=4^S68.114A
 ;;^UTILITY(U,$J,358.3,1815,2)
 ;;=^5036651
 ;;^UTILITY(U,$J,358.3,1816,0)
 ;;=S68.011A^^8^91^71
 ;;^UTILITY(U,$J,358.3,1816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1816,1,3,0)
 ;;=3^Amputation,Traumatic,Right MCP Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,1816,1,4,0)
 ;;=4^S68.011A
 ;;^UTILITY(U,$J,358.3,1816,2)
 ;;=^5036621
 ;;^UTILITY(U,$J,358.3,1817,0)
 ;;=S68.610A^^8^91^74
 ;;^UTILITY(U,$J,358.3,1817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1817,1,3,0)
 ;;=3^Amputation,Traumatic,Right Trnsphal Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1817,1,4,0)
 ;;=4^S68.610A
 ;;^UTILITY(U,$J,358.3,1817,2)
 ;;=^5036735
 ;;^UTILITY(U,$J,358.3,1818,0)
 ;;=S68.616A^^8^91^75
 ;;^UTILITY(U,$J,358.3,1818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1818,1,3,0)
 ;;=3^Amputation,Traumatic,Right Trnsphal Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1818,1,4,0)
 ;;=4^S68.616A
 ;;^UTILITY(U,$J,358.3,1818,2)
 ;;=^5036753
 ;;^UTILITY(U,$J,358.3,1819,0)
 ;;=S68.612A^^8^91^76
 ;;^UTILITY(U,$J,358.3,1819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1819,1,3,0)
 ;;=3^Amputation,Traumatic,Right Trnsphal Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1819,1,4,0)
 ;;=4^S68.612A
 ;;^UTILITY(U,$J,358.3,1819,2)
 ;;=^5036741
 ;;^UTILITY(U,$J,358.3,1820,0)
 ;;=S68.614A^^8^91^77
 ;;^UTILITY(U,$J,358.3,1820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1820,1,3,0)
 ;;=3^Amputation,Traumatic,Right Trnsphal Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,1820,1,4,0)
 ;;=4^S68.614A
 ;;^UTILITY(U,$J,358.3,1820,2)
 ;;=^5036747
 ;;^UTILITY(U,$J,358.3,1821,0)
 ;;=S68.511A^^8^91^78
 ;;^UTILITY(U,$J,358.3,1821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1821,1,3,0)
 ;;=3^Amputation,Traumatic,Right Trnsphal Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,1821,1,4,0)
 ;;=4^S68.511A
 ;;^UTILITY(U,$J,358.3,1821,2)
 ;;=^5036717
 ;;^UTILITY(U,$J,358.3,1822,0)
 ;;=Q83.0^^8^91^107
 ;;^UTILITY(U,$J,358.3,1822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1822,1,3,0)
 ;;=3^Congenital Absence Breast w/ Absent Nipple
 ;;^UTILITY(U,$J,358.3,1822,1,4,0)
 ;;=4^Q83.0
 ;;^UTILITY(U,$J,358.3,1822,2)
 ;;=^5019054
 ;;^UTILITY(U,$J,358.3,1823,0)
 ;;=Q67.0^^8^91^110
 ;;^UTILITY(U,$J,358.3,1823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1823,1,3,0)
 ;;=3^Congenital Facial Asymmetry
 ;;^UTILITY(U,$J,358.3,1823,1,4,0)
 ;;=4^Q67.0
 ;;^UTILITY(U,$J,358.3,1823,2)
 ;;=^5018876
 ;;^UTILITY(U,$J,358.3,1824,0)
 ;;=Q27.9^^8^91^112
 ;;^UTILITY(U,$J,358.3,1824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1824,1,3,0)
 ;;=3^Congenital Malformation Peripheral Vascular System,Unspec
 ;;^UTILITY(U,$J,358.3,1824,1,4,0)
 ;;=4^Q27.9
 ;;^UTILITY(U,$J,358.3,1824,2)
 ;;=^5018592
 ;;^UTILITY(U,$J,358.3,1825,0)
 ;;=M24.542^^8^91^115
 ;;^UTILITY(U,$J,358.3,1825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1825,1,3,0)
 ;;=3^Contracture,Left Hand
 ;;^UTILITY(U,$J,358.3,1825,1,4,0)
 ;;=4^M24.542
