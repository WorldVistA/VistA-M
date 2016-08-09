IBDEI02A ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1817,1,4,0)
 ;;=4^Z01.118
 ;;^UTILITY(U,$J,358.3,1817,2)
 ;;=^5062616
 ;;^UTILITY(U,$J,358.3,1818,0)
 ;;=Z01.10^^11^146^5
 ;;^UTILITY(U,$J,358.3,1818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1818,1,3,0)
 ;;=3^Ears/Hearing Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,1818,1,4,0)
 ;;=4^Z01.10
 ;;^UTILITY(U,$J,358.3,1818,2)
 ;;=^5062614
 ;;^UTILITY(U,$J,358.3,1819,0)
 ;;=Z46.1^^11^146^17
 ;;^UTILITY(U,$J,358.3,1819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1819,1,3,0)
 ;;=3^Fitting/Adjustment of Hearing Aid
 ;;^UTILITY(U,$J,358.3,1819,1,4,0)
 ;;=4^Z46.1
 ;;^UTILITY(U,$J,358.3,1819,2)
 ;;=^5063014
 ;;^UTILITY(U,$J,358.3,1820,0)
 ;;=Z09.^^11^146^14
 ;;^UTILITY(U,$J,358.3,1820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1820,1,3,0)
 ;;=3^F/U Exam After Trtmt for Cond Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,1820,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,1820,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,1821,0)
 ;;=Z02.79^^11^146^21
 ;;^UTILITY(U,$J,358.3,1821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1821,1,3,0)
 ;;=3^Medical Certificate Issue NEC
 ;;^UTILITY(U,$J,358.3,1821,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,1821,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,1822,0)
 ;;=Z02.1^^11^146^9
 ;;^UTILITY(U,$J,358.3,1822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1822,1,3,0)
 ;;=3^Exam for Employment
 ;;^UTILITY(U,$J,358.3,1822,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,1822,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,1823,0)
 ;;=Z13.5^^11^146^13
 ;;^UTILITY(U,$J,358.3,1823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1823,1,3,0)
 ;;=3^Eye/Ear Disorder Screening
 ;;^UTILITY(U,$J,358.3,1823,1,4,0)
 ;;=4^Z13.5
 ;;^UTILITY(U,$J,358.3,1823,2)
 ;;=^5062706
 ;;^UTILITY(U,$J,358.3,1824,0)
 ;;=Z82.2^^11^146^15
 ;;^UTILITY(U,$J,358.3,1824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1824,1,3,0)
 ;;=3^Family history of deafness and hearing loss
 ;;^UTILITY(U,$J,358.3,1824,1,4,0)
 ;;=4^Z82.2
 ;;^UTILITY(U,$J,358.3,1824,2)
 ;;=^5063366
 ;;^UTILITY(U,$J,358.3,1825,0)
 ;;=Z83.52^^11^146^16
 ;;^UTILITY(U,$J,358.3,1825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1825,1,3,0)
 ;;=3^Family history of ear disorders
 ;;^UTILITY(U,$J,358.3,1825,1,4,0)
 ;;=4^Z83.52
 ;;^UTILITY(U,$J,358.3,1825,2)
 ;;=^5063384
 ;;^UTILITY(U,$J,358.3,1826,0)
 ;;=Z91.81^^11^146^19
 ;;^UTILITY(U,$J,358.3,1826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1826,1,3,0)
 ;;=3^History of falling
 ;;^UTILITY(U,$J,358.3,1826,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,1826,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,1827,0)
 ;;=Z76.5^^11^146^20
 ;;^UTILITY(U,$J,358.3,1827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1827,1,3,0)
 ;;=3^Malingerer [conscious simulation]
 ;;^UTILITY(U,$J,358.3,1827,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,1827,2)
 ;;=^5063302
 ;;^UTILITY(U,$J,358.3,1828,0)
 ;;=Z53.09^^11^146^22
 ;;^UTILITY(U,$J,358.3,1828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1828,1,3,0)
 ;;=3^Proc/trtmt not crd out bec of contraindication
 ;;^UTILITY(U,$J,358.3,1828,1,4,0)
 ;;=4^Z53.09
 ;;^UTILITY(U,$J,358.3,1828,2)
 ;;=^5063093
 ;;^UTILITY(U,$J,358.3,1829,0)
 ;;=Z53.29^^11^146^24
 ;;^UTILITY(U,$J,358.3,1829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1829,1,3,0)
 ;;=3^Proc/trtmt not crd out bec pt decision for oth reasons
 ;;^UTILITY(U,$J,358.3,1829,1,4,0)
 ;;=4^Z53.29
 ;;^UTILITY(U,$J,358.3,1829,2)
 ;;=^5063097
 ;;^UTILITY(U,$J,358.3,1830,0)
 ;;=Z53.1^^11^146^23
 ;;^UTILITY(U,$J,358.3,1830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1830,1,3,0)
 ;;=3^Proc/trtmt not crd out bec pt belief and group pressure
 ;;^UTILITY(U,$J,358.3,1830,1,4,0)
 ;;=4^Z53.1
 ;;^UTILITY(U,$J,358.3,1830,2)
 ;;=^5063094
 ;;^UTILITY(U,$J,358.3,1831,0)
 ;;=Z53.21^^11^146^26
 ;;^UTILITY(U,$J,358.3,1831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1831,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t pt lv bef seen by hlth care prov
 ;;^UTILITY(U,$J,358.3,1831,1,4,0)
 ;;=4^Z53.21
 ;;^UTILITY(U,$J,358.3,1831,2)
 ;;=^5063096
 ;;^UTILITY(U,$J,358.3,1832,0)
 ;;=Z53.8^^11^146^25
 ;;^UTILITY(U,$J,358.3,1832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1832,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t other reasons
 ;;^UTILITY(U,$J,358.3,1832,1,4,0)
 ;;=4^Z53.8
 ;;^UTILITY(U,$J,358.3,1832,2)
 ;;=^5063098
 ;;^UTILITY(U,$J,358.3,1833,0)
 ;;=Z01.12^^11^146^18
 ;;^UTILITY(U,$J,358.3,1833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1833,1,3,0)
 ;;=3^Hearing Conservation and Treatment
 ;;^UTILITY(U,$J,358.3,1833,1,4,0)
 ;;=4^Z01.12
 ;;^UTILITY(U,$J,358.3,1833,2)
 ;;=^5062617
 ;;^UTILITY(U,$J,358.3,1834,0)
 ;;=99201^^12^147^1
 ;;^UTILITY(U,$J,358.3,1834,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1834,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,1834,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,1835,0)
 ;;=99202^^12^147^2
 ;;^UTILITY(U,$J,358.3,1835,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1835,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,1835,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,1836,0)
 ;;=99203^^12^147^3
 ;;^UTILITY(U,$J,358.3,1836,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1836,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,1836,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,1837,0)
 ;;=99204^^12^147^4
 ;;^UTILITY(U,$J,358.3,1837,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1837,1,1,0)
 ;;=1^Comprehensive,Moderate MDM
 ;;^UTILITY(U,$J,358.3,1837,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,1838,0)
 ;;=99205^^12^147^5
 ;;^UTILITY(U,$J,358.3,1838,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1838,1,1,0)
 ;;=1^Comprehensive,High MDM
 ;;^UTILITY(U,$J,358.3,1838,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,1839,0)
 ;;=99211^^12^148^1
 ;;^UTILITY(U,$J,358.3,1839,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1839,1,1,0)
 ;;=1^Brief (Any provider type)
 ;;^UTILITY(U,$J,358.3,1839,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,1840,0)
 ;;=99212^^12^148^2
 ;;^UTILITY(U,$J,358.3,1840,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1840,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,1840,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,1841,0)
 ;;=99213^^12^148^3
 ;;^UTILITY(U,$J,358.3,1841,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1841,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,1841,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,1842,0)
 ;;=99214^^12^148^4
 ;;^UTILITY(U,$J,358.3,1842,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1842,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,1842,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,1843,0)
 ;;=99215^^12^148^5
 ;;^UTILITY(U,$J,358.3,1843,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1843,1,1,0)
 ;;=1^Comprehensive
 ;;^UTILITY(U,$J,358.3,1843,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,1844,0)
 ;;=99241^^12^149^1
 ;;^UTILITY(U,$J,358.3,1844,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1844,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,1844,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,1845,0)
 ;;=99242^^12^149^2
 ;;^UTILITY(U,$J,358.3,1845,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1845,1,1,0)
 ;;=1^Exp Problem Focused
 ;;^UTILITY(U,$J,358.3,1845,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,1846,0)
 ;;=99243^^12^149^3
 ;;^UTILITY(U,$J,358.3,1846,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1846,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,1846,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,1847,0)
 ;;=99244^^12^149^4
 ;;^UTILITY(U,$J,358.3,1847,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1847,1,1,0)
 ;;=1^Comprehensive,Moderate MDM
 ;;^UTILITY(U,$J,358.3,1847,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,1848,0)
 ;;=99245^^12^149^5
 ;;^UTILITY(U,$J,358.3,1848,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1848,1,1,0)
 ;;=1^Comprehensive,High MDM
 ;;^UTILITY(U,$J,358.3,1848,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,1849,0)
 ;;=99201^^13^150^1
 ;;^UTILITY(U,$J,358.3,1849,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1849,1,1,0)
 ;;=1^Problem Focus
