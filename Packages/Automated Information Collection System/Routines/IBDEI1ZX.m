IBDEI1ZX ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31850,1,4,0)
 ;;=4^O36.80X1
 ;;^UTILITY(U,$J,358.3,31850,2)
 ;;=^5017083
 ;;^UTILITY(U,$J,358.3,31851,0)
 ;;=O36.80X2^^126^1633^22
 ;;^UTILITY(U,$J,358.3,31851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31851,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, fetus 2
 ;;^UTILITY(U,$J,358.3,31851,1,4,0)
 ;;=4^O36.80X2
 ;;^UTILITY(U,$J,358.3,31851,2)
 ;;=^5017084
 ;;^UTILITY(U,$J,358.3,31852,0)
 ;;=O36.80X3^^126^1633^23
 ;;^UTILITY(U,$J,358.3,31852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31852,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, fetus 3
 ;;^UTILITY(U,$J,358.3,31852,1,4,0)
 ;;=4^O36.80X3
 ;;^UTILITY(U,$J,358.3,31852,2)
 ;;=^5017085
 ;;^UTILITY(U,$J,358.3,31853,0)
 ;;=O36.80X4^^126^1633^24
 ;;^UTILITY(U,$J,358.3,31853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31853,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, fetus 4
 ;;^UTILITY(U,$J,358.3,31853,1,4,0)
 ;;=4^O36.80X4
 ;;^UTILITY(U,$J,358.3,31853,2)
 ;;=^5017086
 ;;^UTILITY(U,$J,358.3,31854,0)
 ;;=O36.80X5^^126^1633^25
 ;;^UTILITY(U,$J,358.3,31854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31854,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, fetus 5
 ;;^UTILITY(U,$J,358.3,31854,1,4,0)
 ;;=4^O36.80X5
 ;;^UTILITY(U,$J,358.3,31854,2)
 ;;=^5017087
 ;;^UTILITY(U,$J,358.3,31855,0)
 ;;=Z39.0^^126^1633^18
 ;;^UTILITY(U,$J,358.3,31855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31855,1,3,0)
 ;;=3^Care and exam of mother immediately after del
 ;;^UTILITY(U,$J,358.3,31855,1,4,0)
 ;;=4^Z39.0
 ;;^UTILITY(U,$J,358.3,31855,2)
 ;;=^5062904
 ;;^UTILITY(U,$J,358.3,31856,0)
 ;;=Z39.1^^126^1633^17
 ;;^UTILITY(U,$J,358.3,31856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31856,1,3,0)
 ;;=3^Care and exam of lactating mother
 ;;^UTILITY(U,$J,358.3,31856,1,4,0)
 ;;=4^Z39.1
 ;;^UTILITY(U,$J,358.3,31856,2)
 ;;=^5062905
 ;;^UTILITY(U,$J,358.3,31857,0)
 ;;=Z39.2^^126^1633^27
 ;;^UTILITY(U,$J,358.3,31857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31857,1,3,0)
 ;;=3^Routine postpartum follow-up
 ;;^UTILITY(U,$J,358.3,31857,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,31857,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,31858,0)
 ;;=O09.A1^^126^1633^52
 ;;^UTILITY(U,$J,358.3,31858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31858,1,3,0)
 ;;=3^Suprvsn of preg w history of molar preg,1st trimester
 ;;^UTILITY(U,$J,358.3,31858,1,4,0)
 ;;=4^O09.A1
 ;;^UTILITY(U,$J,358.3,31858,2)
 ;;=^5139001
 ;;^UTILITY(U,$J,358.3,31859,0)
 ;;=O09.A2^^126^1633^53
 ;;^UTILITY(U,$J,358.3,31859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31859,1,3,0)
 ;;=3^Suprvsn of preg w history of molar preg,2nd trimester
 ;;^UTILITY(U,$J,358.3,31859,1,4,0)
 ;;=4^O09.A2
 ;;^UTILITY(U,$J,358.3,31859,2)
 ;;=^5139002
 ;;^UTILITY(U,$J,358.3,31860,0)
 ;;=O09.A3^^126^1633^54
 ;;^UTILITY(U,$J,358.3,31860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31860,1,3,0)
 ;;=3^Suprvsn of preg w history of molar preg,3rd trimester
 ;;^UTILITY(U,$J,358.3,31860,1,4,0)
 ;;=4^O09.A3
 ;;^UTILITY(U,$J,358.3,31860,2)
 ;;=^5139003
 ;;^UTILITY(U,$J,358.3,31861,0)
 ;;=Z36.86^^126^1633^1
 ;;^UTILITY(U,$J,358.3,31861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31861,1,3,0)
 ;;=3^Antenatal Screening for Cervical Length
 ;;^UTILITY(U,$J,358.3,31861,1,4,0)
 ;;=4^Z36.86
 ;;^UTILITY(U,$J,358.3,31861,2)
 ;;=^5151851
 ;;^UTILITY(U,$J,358.3,31862,0)
 ;;=Z36.0^^126^1633^2
 ;;^UTILITY(U,$J,358.3,31862,1,0)
 ;;=^358.31IA^4^2
