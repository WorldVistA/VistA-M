IBDEI04W ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1767,1,3,0)
 ;;=3^History of falling
 ;;^UTILITY(U,$J,358.3,1767,1,4,0)
 ;;=4^Z91.81
 ;;^UTILITY(U,$J,358.3,1767,2)
 ;;=^5063625
 ;;^UTILITY(U,$J,358.3,1768,0)
 ;;=R09.1^^3^52^6
 ;;^UTILITY(U,$J,358.3,1768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1768,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,1768,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,1768,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,1769,0)
 ;;=J91.0^^3^52^3
 ;;^UTILITY(U,$J,358.3,1769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1769,1,3,0)
 ;;=3^Malignant pleural effusion
 ;;^UTILITY(U,$J,358.3,1769,1,4,0)
 ;;=4^J91.0
 ;;^UTILITY(U,$J,358.3,1769,2)
 ;;=^336603
 ;;^UTILITY(U,$J,358.3,1770,0)
 ;;=J90.^^3^52^5
 ;;^UTILITY(U,$J,358.3,1770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1770,1,3,0)
 ;;=3^Pleural effusion, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,1770,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,1770,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,1771,0)
 ;;=J91.8^^3^52^4
 ;;^UTILITY(U,$J,358.3,1771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1771,1,3,0)
 ;;=3^Pleural effusion in other conditions classified elsewhere
 ;;^UTILITY(U,$J,358.3,1771,1,4,0)
 ;;=4^J91.8
 ;;^UTILITY(U,$J,358.3,1771,2)
 ;;=^5008311
 ;;^UTILITY(U,$J,358.3,1772,0)
 ;;=J93.0^^3^52^10
 ;;^UTILITY(U,$J,358.3,1772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1772,1,3,0)
 ;;=3^Spontaneous tension pneumothorax
 ;;^UTILITY(U,$J,358.3,1772,1,4,0)
 ;;=4^J93.0
 ;;^UTILITY(U,$J,358.3,1772,2)
 ;;=^269987
 ;;^UTILITY(U,$J,358.3,1773,0)
 ;;=J93.11^^3^52^8
 ;;^UTILITY(U,$J,358.3,1773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1773,1,3,0)
 ;;=3^Primary spontaneous pneumothorax
 ;;^UTILITY(U,$J,358.3,1773,1,4,0)
 ;;=4^J93.11
 ;;^UTILITY(U,$J,358.3,1773,2)
 ;;=^340529
 ;;^UTILITY(U,$J,358.3,1774,0)
 ;;=J93.12^^3^52^9
 ;;^UTILITY(U,$J,358.3,1774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1774,1,3,0)
 ;;=3^Secondary spontaneous pneumothorax
 ;;^UTILITY(U,$J,358.3,1774,1,4,0)
 ;;=4^J93.12
 ;;^UTILITY(U,$J,358.3,1774,2)
 ;;=^340530
 ;;^UTILITY(U,$J,358.3,1775,0)
 ;;=J93.81^^3^52^2
 ;;^UTILITY(U,$J,358.3,1775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1775,1,3,0)
 ;;=3^Chronic pneumothorax
 ;;^UTILITY(U,$J,358.3,1775,1,4,0)
 ;;=4^J93.81
 ;;^UTILITY(U,$J,358.3,1775,2)
 ;;=^340531
 ;;^UTILITY(U,$J,358.3,1776,0)
 ;;=J93.82^^3^52^1
 ;;^UTILITY(U,$J,358.3,1776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1776,1,3,0)
 ;;=3^Air Leak NEC
 ;;^UTILITY(U,$J,358.3,1776,1,4,0)
 ;;=4^J93.82
 ;;^UTILITY(U,$J,358.3,1776,2)
 ;;=^5008314
 ;;^UTILITY(U,$J,358.3,1777,0)
 ;;=J93.9^^3^52^7
 ;;^UTILITY(U,$J,358.3,1777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1777,1,3,0)
 ;;=3^Pneumothorax, unspecified
 ;;^UTILITY(U,$J,358.3,1777,1,4,0)
 ;;=4^J93.9
 ;;^UTILITY(U,$J,358.3,1777,2)
 ;;=^5008315
 ;;^UTILITY(U,$J,358.3,1778,0)
 ;;=J12.9^^3^53^11
 ;;^UTILITY(U,$J,358.3,1778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1778,1,3,0)
 ;;=3^Viral pneumonia, unspecified
 ;;^UTILITY(U,$J,358.3,1778,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,1778,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,1779,0)
 ;;=J13.^^3^53^7
 ;;^UTILITY(U,$J,358.3,1779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1779,1,3,0)
 ;;=3^Pneumonia due to Streptococcus pneumoniae
 ;;^UTILITY(U,$J,358.3,1779,1,4,0)
 ;;=4^J13.
 ;;^UTILITY(U,$J,358.3,1779,2)
 ;;=^5008170
 ;;^UTILITY(U,$J,358.3,1780,0)
 ;;=J15.4^^3^53^9
 ;;^UTILITY(U,$J,358.3,1780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1780,1,3,0)
 ;;=3^Pneumonia due to other streptococci
 ;;^UTILITY(U,$J,358.3,1780,1,4,0)
 ;;=4^J15.4
