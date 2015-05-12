IBDEI01L ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1756,0)
 ;;=R09.2^^7^90^14
 ;;^UTILITY(U,$J,358.3,1756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1756,1,3,0)
 ;;=3^Respiratory Arrest
 ;;^UTILITY(U,$J,358.3,1756,1,4,0)
 ;;=4^R09.2
 ;;^UTILITY(U,$J,358.3,1756,2)
 ;;=^276886
 ;;^UTILITY(U,$J,358.3,1757,0)
 ;;=Z87.09^^7^90^13
 ;;^UTILITY(U,$J,358.3,1757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1757,1,3,0)
 ;;=3^Personal Hx of Respiratory System Diseases
 ;;^UTILITY(U,$J,358.3,1757,1,4,0)
 ;;=4^Z87.09
 ;;^UTILITY(U,$J,358.3,1757,2)
 ;;=^5063481
 ;;^UTILITY(U,$J,358.3,1758,0)
 ;;=Z87.01^^7^90^12
 ;;^UTILITY(U,$J,358.3,1758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1758,1,3,0)
 ;;=3^Personal Hx of Recurrent Pneumonia
 ;;^UTILITY(U,$J,358.3,1758,1,4,0)
 ;;=4^Z87.01
 ;;^UTILITY(U,$J,358.3,1758,2)
 ;;=^5063480
 ;;^UTILITY(U,$J,358.3,1759,0)
 ;;=Q83.2^^8^91^1
 ;;^UTILITY(U,$J,358.3,1759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1759,1,3,0)
 ;;=3^Absent Nipple
 ;;^UTILITY(U,$J,358.3,1759,1,4,0)
 ;;=4^Q83.2
 ;;^UTILITY(U,$J,358.3,1759,2)
 ;;=^5019056
 ;;^UTILITY(U,$J,358.3,1760,0)
 ;;=Q83.1^^8^91^2
 ;;^UTILITY(U,$J,358.3,1760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1760,1,3,0)
 ;;=3^Accessory Breast
 ;;^UTILITY(U,$J,358.3,1760,1,4,0)
 ;;=4^Q83.1
 ;;^UTILITY(U,$J,358.3,1760,2)
 ;;=^5019055
 ;;^UTILITY(U,$J,358.3,1761,0)
 ;;=Q83.3^^8^91^3
 ;;^UTILITY(U,$J,358.3,1761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1761,1,3,0)
 ;;=3^Accessory Nipple
 ;;^UTILITY(U,$J,358.3,1761,1,4,0)
 ;;=4^Q83.3
 ;;^UTILITY(U,$J,358.3,1761,2)
 ;;=^5019057
 ;;^UTILITY(U,$J,358.3,1762,0)
 ;;=M95.0^^8^91^4
 ;;^UTILITY(U,$J,358.3,1762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1762,1,3,0)
 ;;=3^Acquired Deformity of Nose
 ;;^UTILITY(U,$J,358.3,1762,1,4,0)
 ;;=4^M95.0
 ;;^UTILITY(U,$J,358.3,1762,2)
 ;;=^5015367
 ;;^UTILITY(U,$J,358.3,1763,0)
 ;;=H61.113^^8^91^5
 ;;^UTILITY(U,$J,358.3,1763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1763,1,3,0)
 ;;=3^Acquired Deformity of Pinna,Bilateral
 ;;^UTILITY(U,$J,358.3,1763,1,4,0)
 ;;=4^H61.113
 ;;^UTILITY(U,$J,358.3,1763,2)
 ;;=^5006520
 ;;^UTILITY(U,$J,358.3,1764,0)
 ;;=H61.112^^8^91^6
 ;;^UTILITY(U,$J,358.3,1764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1764,1,3,0)
 ;;=3^Acquired Deformity of Pinna,Left Ear
 ;;^UTILITY(U,$J,358.3,1764,1,4,0)
 ;;=4^H61.112
 ;;^UTILITY(U,$J,358.3,1764,2)
 ;;=^5006519
 ;;^UTILITY(U,$J,358.3,1765,0)
 ;;=H61.111^^8^91^7
 ;;^UTILITY(U,$J,358.3,1765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1765,1,3,0)
 ;;=3^Acquired Deformity of Pinna,Right Ear
 ;;^UTILITY(U,$J,358.3,1765,1,4,0)
 ;;=4^H61.111
 ;;^UTILITY(U,$J,358.3,1765,2)
 ;;=^5006518
 ;;^UTILITY(U,$J,358.3,1766,0)
 ;;=C44.91^^8^91^85
 ;;^UTILITY(U,$J,358.3,1766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1766,1,3,0)
 ;;=3^BCC of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,1766,1,4,0)
 ;;=4^C44.91
 ;;^UTILITY(U,$J,358.3,1766,2)
 ;;=^5001092
 ;;^UTILITY(U,$J,358.3,1767,0)
 ;;=C44.119^^8^91^81
 ;;^UTILITY(U,$J,358.3,1767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1767,1,3,0)
 ;;=3^BCC of Skin,Left Eyelid
 ;;^UTILITY(U,$J,358.3,1767,1,4,0)
 ;;=4^C44.119
 ;;^UTILITY(U,$J,358.3,1767,2)
 ;;=^5001021
 ;;^UTILITY(U,$J,358.3,1768,0)
 ;;=C44.112^^8^91^83
 ;;^UTILITY(U,$J,358.3,1768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1768,1,3,0)
 ;;=3^BCC of Skin,Right Eyelid
 ;;^UTILITY(U,$J,358.3,1768,1,4,0)
 ;;=4^C44.112
 ;;^UTILITY(U,$J,358.3,1768,2)
 ;;=^5001020
 ;;^UTILITY(U,$J,358.3,1769,0)
 ;;=C44.41^^8^91^84
 ;;^UTILITY(U,$J,358.3,1769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1769,1,3,0)
 ;;=3^BCC of Skin,Scalp/Neck
 ;;^UTILITY(U,$J,358.3,1769,1,4,0)
 ;;=4^C44.41
 ;;^UTILITY(U,$J,358.3,1769,2)
 ;;=^340476
 ;;^UTILITY(U,$J,358.3,1770,0)
 ;;=C44.219^^8^91^80
 ;;^UTILITY(U,$J,358.3,1770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1770,1,3,0)
 ;;=3^BCC of Skin,Left Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,1770,1,4,0)
 ;;=4^C44.219
 ;;^UTILITY(U,$J,358.3,1770,2)
 ;;=^5001033
 ;;^UTILITY(U,$J,358.3,1771,0)
 ;;=C44.212^^8^91^82
 ;;^UTILITY(U,$J,358.3,1771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1771,1,3,0)
 ;;=3^BCC of Skin,Right Ear/External Auric Canal
 ;;^UTILITY(U,$J,358.3,1771,1,4,0)
 ;;=4^C44.212
 ;;^UTILITY(U,$J,358.3,1771,2)
 ;;=^5001032
 ;;^UTILITY(U,$J,358.3,1772,0)
 ;;=G51.0^^8^91^86
 ;;^UTILITY(U,$J,358.3,1772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1772,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,1772,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,1772,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,1773,0)
 ;;=D16.4^^8^91^87
 ;;^UTILITY(U,$J,358.3,1773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1773,1,3,0)
 ;;=3^Benign Neop Bones of Skull/Face
 ;;^UTILITY(U,$J,358.3,1773,1,4,0)
 ;;=4^D16.4
 ;;^UTILITY(U,$J,358.3,1773,2)
 ;;=^267606
 ;;^UTILITY(U,$J,358.3,1774,0)
 ;;=D21.12^^8^91^88
 ;;^UTILITY(U,$J,358.3,1774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1774,1,3,0)
 ;;=3^Benign Neop Connective/Soft Tissue,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,1774,1,4,0)
 ;;=4^D21.12
 ;;^UTILITY(U,$J,358.3,1774,2)
 ;;=^5002032
 ;;^UTILITY(U,$J,358.3,1775,0)
 ;;=D21.11^^8^91^89
 ;;^UTILITY(U,$J,358.3,1775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1775,1,3,0)
 ;;=3^Benign Neop Connective/Soft Tissue,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,1775,1,4,0)
 ;;=4^D21.11
 ;;^UTILITY(U,$J,358.3,1775,2)
 ;;=^5002031
 ;;^UTILITY(U,$J,358.3,1776,0)
 ;;=D21.9^^8^91^90
 ;;^UTILITY(U,$J,358.3,1776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1776,1,3,0)
 ;;=3^Benign Neop Connective/Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,1776,1,4,0)
 ;;=4^D21.9
 ;;^UTILITY(U,$J,358.3,1776,2)
 ;;=^5002040
 ;;^UTILITY(U,$J,358.3,1777,0)
 ;;=D10.0^^8^91^91
 ;;^UTILITY(U,$J,358.3,1777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1777,1,3,0)
 ;;=3^Benign Neop Lip
 ;;^UTILITY(U,$J,358.3,1777,1,4,0)
 ;;=4^D10.0
 ;;^UTILITY(U,$J,358.3,1777,2)
 ;;=^267578
 ;;^UTILITY(U,$J,358.3,1778,0)
 ;;=D11.9^^8^91^92
 ;;^UTILITY(U,$J,358.3,1778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1778,1,3,0)
 ;;=3^Benign Neop Major Salivary Gland,Unspec
 ;;^UTILITY(U,$J,358.3,1778,1,4,0)
 ;;=4^D11.9
 ;;^UTILITY(U,$J,358.3,1778,2)
 ;;=^5001962
 ;;^UTILITY(U,$J,358.3,1779,0)
 ;;=S14.3XXA^^8^91^97
 ;;^UTILITY(U,$J,358.3,1779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1779,1,3,0)
 ;;=3^Brachial Plexus Injury,Init Encntr
 ;;^UTILITY(U,$J,358.3,1779,1,4,0)
 ;;=4^S14.3XXA
 ;;^UTILITY(U,$J,358.3,1779,2)
 ;;=^5022205
 ;;^UTILITY(U,$J,358.3,1780,0)
 ;;=G56.02^^8^91^99
 ;;^UTILITY(U,$J,358.3,1780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1780,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,1780,1,4,0)
 ;;=4^G56.02
 ;;^UTILITY(U,$J,358.3,1780,2)
 ;;=^5004019
 ;;^UTILITY(U,$J,358.3,1781,0)
 ;;=G56.01^^8^91^100
 ;;^UTILITY(U,$J,358.3,1781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1781,1,3,0)
 ;;=3^Carpal Tunnel Syndrome,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,1781,1,4,0)
 ;;=4^G56.01
 ;;^UTILITY(U,$J,358.3,1781,2)
 ;;=^5004018
 ;;^UTILITY(U,$J,358.3,1782,0)
 ;;=L03.012^^8^91^101
 ;;^UTILITY(U,$J,358.3,1782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1782,1,3,0)
 ;;=3^Cellulitis,Left Finger
 ;;^UTILITY(U,$J,358.3,1782,1,4,0)
 ;;=4^L03.012
 ;;^UTILITY(U,$J,358.3,1782,2)
 ;;=^5009020
 ;;^UTILITY(U,$J,358.3,1783,0)
 ;;=L03.114^^8^91^102
 ;;^UTILITY(U,$J,358.3,1783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1783,1,3,0)
 ;;=3^Cellulitis,Left Upper Limb
 ;;^UTILITY(U,$J,358.3,1783,1,4,0)
 ;;=4^L03.114
 ;;^UTILITY(U,$J,358.3,1783,2)
 ;;=^5009034
 ;;^UTILITY(U,$J,358.3,1784,0)
 ;;=L03.011^^8^91^103
 ;;^UTILITY(U,$J,358.3,1784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1784,1,3,0)
 ;;=3^Cellulitis,Right Finger
 ;;^UTILITY(U,$J,358.3,1784,1,4,0)
 ;;=4^L03.011
 ;;^UTILITY(U,$J,358.3,1784,2)
 ;;=^5009019
 ;;^UTILITY(U,$J,358.3,1785,0)
 ;;=L03.113^^8^91^104
 ;;^UTILITY(U,$J,358.3,1785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1785,1,3,0)
 ;;=3^Cellulitis,Right Upper Limb
 ;;^UTILITY(U,$J,358.3,1785,1,4,0)
 ;;=4^L03.113
 ;;^UTILITY(U,$J,358.3,1785,2)
 ;;=^5009033
 ;;^UTILITY(U,$J,358.3,1786,0)
 ;;=Q35.9^^8^91^106
 ;;^UTILITY(U,$J,358.3,1786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1786,1,3,0)
 ;;=3^Cleft Palate,Unspec
 ;;^UTILITY(U,$J,358.3,1786,1,4,0)
 ;;=4^Q35.9
 ;;^UTILITY(U,$J,358.3,1786,2)
 ;;=^5018634
 ;;^UTILITY(U,$J,358.3,1787,0)
 ;;=S58.112A^^8^91^46
 ;;^UTILITY(U,$J,358.3,1787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1787,1,3,0)
 ;;=3^Amputation,Traumatic,Left Arm Between Elbow & Wrist Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,1787,1,4,0)
 ;;=4^S58.112A
 ;;^UTILITY(U,$J,358.3,1787,2)
 ;;=^5031928
 ;;^UTILITY(U,$J,358.3,1788,0)
 ;;=S98.012A^^8^91^47
 ;;^UTILITY(U,$J,358.3,1788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1788,1,3,0)
 ;;=3^Amputation,Traumatic,Left Foot at Ankle Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,1788,1,4,0)
 ;;=4^S98.012A
 ;;^UTILITY(U,$J,358.3,1788,2)
 ;;=^5046248
 ;;^UTILITY(U,$J,358.3,1789,0)
 ;;=S98.112A^^8^91^48
 ;;^UTILITY(U,$J,358.3,1789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1789,1,3,0)
 ;;=3^Amputation,Traumatic,Left Great Toe,Init Encntr
 ;;^UTILITY(U,$J,358.3,1789,1,4,0)
 ;;=4^S98.112A
 ;;^UTILITY(U,$J,358.3,1789,2)
 ;;=^5046266
 ;;^UTILITY(U,$J,358.3,1790,0)
 ;;=S98.312A^^8^91^54
 ;;^UTILITY(U,$J,358.3,1790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1790,1,3,0)
 ;;=3^Amputation,Traumatic,Left Midfoot,Init Encntr
 ;;^UTILITY(U,$J,358.3,1790,1,4,0)
 ;;=4^S98.312A
 ;;^UTILITY(U,$J,358.3,1790,2)
 ;;=^5046320
 ;;^UTILITY(U,$J,358.3,1791,0)
 ;;=S48.912A^^8^91^55
 ;;^UTILITY(U,$J,358.3,1791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1791,1,3,0)
 ;;=3^Amputation,Traumatic,Left Shoulder/Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,1791,1,4,0)
 ;;=4^S48.912A
 ;;^UTILITY(U,$J,358.3,1791,2)
 ;;=^5028326
 ;;^UTILITY(U,$J,358.3,1792,0)
 ;;=S98.132A^^8^91^44
 ;;^UTILITY(U,$J,358.3,1792,1,0)
 ;;=^358.31IA^4^2
