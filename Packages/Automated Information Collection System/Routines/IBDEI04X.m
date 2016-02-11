IBDEI04X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1619,0)
 ;;=99367^^15^161^2^^^^1
 ;;^UTILITY(U,$J,358.3,1619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1619,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,1619,1,3,0)
 ;;=3^Interdisc. Team Mtg. w/o Pt w/Phys
 ;;^UTILITY(U,$J,358.3,1620,0)
 ;;=99600^^15^162^2^^^^1
 ;;^UTILITY(U,$J,358.3,1620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1620,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,1620,1,3,0)
 ;;=3^Home Visit by Nonphysician
 ;;^UTILITY(U,$J,358.3,1621,0)
 ;;=G0155^^15^162^1^^^^1
 ;;^UTILITY(U,$J,358.3,1621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1621,1,2,0)
 ;;=2^G0155
 ;;^UTILITY(U,$J,358.3,1621,1,3,0)
 ;;=3^Home Visit by CSW,ea 15 min
 ;;^UTILITY(U,$J,358.3,1622,0)
 ;;=92081^^15^163^5^^^^1
 ;;^UTILITY(U,$J,358.3,1622,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1622,1,2,0)
 ;;=2^92081
 ;;^UTILITY(U,$J,358.3,1622,1,3,0)
 ;;=3^Visual Field Exams
 ;;^UTILITY(U,$J,358.3,1623,0)
 ;;=99172^^15^163^2^^^^1
 ;;^UTILITY(U,$J,358.3,1623,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1623,1,2,0)
 ;;=2^99172
 ;;^UTILITY(U,$J,358.3,1623,1,3,0)
 ;;=3^Ocular Function Screen
 ;;^UTILITY(U,$J,358.3,1624,0)
 ;;=V2600^^15^163^1^^^^1
 ;;^UTILITY(U,$J,358.3,1624,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1624,1,2,0)
 ;;=2^V2600
 ;;^UTILITY(U,$J,358.3,1624,1,3,0)
 ;;=3^Hand Held Low Vision Aids
 ;;^UTILITY(U,$J,358.3,1625,0)
 ;;=V2610^^15^163^3^^^^1
 ;;^UTILITY(U,$J,358.3,1625,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1625,1,2,0)
 ;;=2^V2610
 ;;^UTILITY(U,$J,358.3,1625,1,3,0)
 ;;=3^Single Lens Spectacle Mount
 ;;^UTILITY(U,$J,358.3,1626,0)
 ;;=V2615^^15^163^4^^^^1
 ;;^UTILITY(U,$J,358.3,1626,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1626,1,2,0)
 ;;=2^V2615
 ;;^UTILITY(U,$J,358.3,1626,1,3,0)
 ;;=3^Telescope/Oth Compound Lens
 ;;^UTILITY(U,$J,358.3,1627,0)
 ;;=98969^^15^164^1^^^^1
 ;;^UTILITY(U,$J,358.3,1627,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1627,1,2,0)
 ;;=2^98969
 ;;^UTILITY(U,$J,358.3,1627,1,3,0)
 ;;=3^Online Service by HC Provider
 ;;^UTILITY(U,$J,358.3,1628,0)
 ;;=Q3014^^15^164^2^^^^1
 ;;^UTILITY(U,$J,358.3,1628,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1628,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,1628,1,3,0)
 ;;=3^Telehealth Originating Site Fee
 ;;^UTILITY(U,$J,358.3,1629,0)
 ;;=98960^^15^165^1^^^^1
 ;;^UTILITY(U,$J,358.3,1629,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1629,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,1629,1,3,0)
 ;;=3^Self-Mgmt Ed & Train 1 Pt
 ;;^UTILITY(U,$J,358.3,1630,0)
 ;;=98961^^15^165^2^^^^1
 ;;^UTILITY(U,$J,358.3,1630,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1630,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,1630,1,3,0)
 ;;=3^Self-Mgmt Ed & Train 2-4 Pts
 ;;^UTILITY(U,$J,358.3,1631,0)
 ;;=98962^^15^165^3^^^^1
 ;;^UTILITY(U,$J,358.3,1631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1631,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,1631,1,3,0)
 ;;=3^Self-Mgmt Ed & Train 5-8 Pts
 ;;^UTILITY(U,$J,358.3,1632,0)
 ;;=H52.521^^16^166^28
 ;;^UTILITY(U,$J,358.3,1632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1632,1,3,0)
 ;;=3^Paresis of Accommodation,Right Eye
 ;;^UTILITY(U,$J,358.3,1632,1,4,0)
 ;;=4^H52.521
 ;;^UTILITY(U,$J,358.3,1632,2)
 ;;=^5006282
 ;;^UTILITY(U,$J,358.3,1633,0)
 ;;=H52.522^^16^166^27
 ;;^UTILITY(U,$J,358.3,1633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1633,1,3,0)
 ;;=3^Paresis of Accommodation,Left Eye
 ;;^UTILITY(U,$J,358.3,1633,1,4,0)
 ;;=4^H52.522
 ;;^UTILITY(U,$J,358.3,1633,2)
 ;;=^5006283
 ;;^UTILITY(U,$J,358.3,1634,0)
 ;;=H52.523^^16^166^26
 ;;^UTILITY(U,$J,358.3,1634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1634,1,3,0)
 ;;=3^Paresis of Accommodation,Bilateral
