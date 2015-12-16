IBDEI04Z ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1807,2)
 ;;=^5019179
 ;;^UTILITY(U,$J,358.3,1808,0)
 ;;=R07.1^^3^55^7
 ;;^UTILITY(U,$J,358.3,1808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1808,1,3,0)
 ;;=3^Chest pain on breathing
 ;;^UTILITY(U,$J,358.3,1808,1,4,0)
 ;;=4^R07.1
 ;;^UTILITY(U,$J,358.3,1808,2)
 ;;=^5019196
 ;;^UTILITY(U,$J,358.3,1809,0)
 ;;=R07.81^^3^55^13
 ;;^UTILITY(U,$J,358.3,1809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1809,1,3,0)
 ;;=3^Pleurodynia
 ;;^UTILITY(U,$J,358.3,1809,1,4,0)
 ;;=4^R07.81
 ;;^UTILITY(U,$J,358.3,1809,2)
 ;;=^5019198
 ;;^UTILITY(U,$J,358.3,1810,0)
 ;;=R91.1^^3^55^17
 ;;^UTILITY(U,$J,358.3,1810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1810,1,3,0)
 ;;=3^Solitary pulmonary nodule
 ;;^UTILITY(U,$J,358.3,1810,1,4,0)
 ;;=4^R91.1
 ;;^UTILITY(U,$J,358.3,1810,2)
 ;;=^5019707
 ;;^UTILITY(U,$J,358.3,1811,0)
 ;;=R91.8^^3^55^1
 ;;^UTILITY(U,$J,358.3,1811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1811,1,3,0)
 ;;=3^Abnormal Finding of Lung Field,Nonspecific NEC
 ;;^UTILITY(U,$J,358.3,1811,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,1811,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,1812,0)
 ;;=R93.1^^3^55^2
 ;;^UTILITY(U,$J,358.3,1812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1812,1,3,0)
 ;;=3^Abnormal findings on dx imaging of heart and cor circ
 ;;^UTILITY(U,$J,358.3,1812,1,4,0)
 ;;=4^R93.1
 ;;^UTILITY(U,$J,358.3,1812,2)
 ;;=^5019714
 ;;^UTILITY(U,$J,358.3,1813,0)
 ;;=R76.12^^3^55^11
 ;;^UTILITY(U,$J,358.3,1813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1813,1,3,0)
 ;;=3^Nonspec reaction to gamma intrfrn respns w/o actv tubrclosis
 ;;^UTILITY(U,$J,358.3,1813,1,4,0)
 ;;=4^R76.12
 ;;^UTILITY(U,$J,358.3,1813,2)
 ;;=^5019571
 ;;^UTILITY(U,$J,358.3,1814,0)
 ;;=R09.01^^3^55^5
 ;;^UTILITY(U,$J,358.3,1814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1814,1,3,0)
 ;;=3^Asphyxia
 ;;^UTILITY(U,$J,358.3,1814,1,4,0)
 ;;=4^R09.01
 ;;^UTILITY(U,$J,358.3,1814,2)
 ;;=^11005
 ;;^UTILITY(U,$J,358.3,1815,0)
 ;;=R09.02^^3^55^10
 ;;^UTILITY(U,$J,358.3,1815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1815,1,3,0)
 ;;=3^Hypoxemia
 ;;^UTILITY(U,$J,358.3,1815,1,4,0)
 ;;=4^R09.02
 ;;^UTILITY(U,$J,358.3,1815,2)
 ;;=^332831
 ;;^UTILITY(U,$J,358.3,1816,0)
 ;;=Z86.718^^3^55^12
 ;;^UTILITY(U,$J,358.3,1816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1816,1,3,0)
 ;;=3^Personal history of other venous thrombosis and embolism
 ;;^UTILITY(U,$J,358.3,1816,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,1816,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,1817,0)
 ;;=E08.9^^3^56^31
 ;;^UTILITY(U,$J,358.3,1817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1817,1,3,0)
 ;;=3^Diabetes due to underlying condition w/o complications
 ;;^UTILITY(U,$J,358.3,1817,1,4,0)
 ;;=4^E08.9
 ;;^UTILITY(U,$J,358.3,1817,2)
 ;;=^5002544
 ;;^UTILITY(U,$J,358.3,1818,0)
 ;;=E09.9^^3^56^61
 ;;^UTILITY(U,$J,358.3,1818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1818,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus w/o complications
 ;;^UTILITY(U,$J,358.3,1818,1,4,0)
 ;;=4^E09.9
 ;;^UTILITY(U,$J,358.3,1818,2)
 ;;=^5002586
 ;;^UTILITY(U,$J,358.3,1819,0)
 ;;=E08.65^^3^56^1
 ;;^UTILITY(U,$J,358.3,1819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1819,1,3,0)
 ;;=3^Diabetes due to underlying condition w hyperglycemia
 ;;^UTILITY(U,$J,358.3,1819,1,4,0)
 ;;=4^E08.65
 ;;^UTILITY(U,$J,358.3,1819,2)
 ;;=^5002541
 ;;^UTILITY(U,$J,358.3,1820,0)
 ;;=E09.65^^3^56^58
 ;;^UTILITY(U,$J,358.3,1820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1820,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus w hyperglycemia
 ;;^UTILITY(U,$J,358.3,1820,1,4,0)
 ;;=4^E09.65
 ;;^UTILITY(U,$J,358.3,1820,2)
 ;;=^5002583
