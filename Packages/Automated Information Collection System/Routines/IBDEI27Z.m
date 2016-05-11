IBDEI27Z ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37646,1,3,0)
 ;;=3^Streptococcal arthritis, vertebrae, oth
 ;;^UTILITY(U,$J,358.3,37646,1,4,0)
 ;;=4^M00.28
 ;;^UTILITY(U,$J,358.3,37646,2)
 ;;=^5009667
 ;;^UTILITY(U,$J,358.3,37647,0)
 ;;=M00.88^^140^1795^15
 ;;^UTILITY(U,$J,358.3,37647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37647,1,3,0)
 ;;=3^Arthritis d/t other bacteria, vertebrae
 ;;^UTILITY(U,$J,358.3,37647,1,4,0)
 ;;=4^M00.88
 ;;^UTILITY(U,$J,358.3,37647,2)
 ;;=^5009691
 ;;^UTILITY(U,$J,358.3,37648,0)
 ;;=M00.09^^140^1795^50
 ;;^UTILITY(U,$J,358.3,37648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37648,1,3,0)
 ;;=3^Staphylococcal polyarthritis
 ;;^UTILITY(U,$J,358.3,37648,1,4,0)
 ;;=4^M00.09
 ;;^UTILITY(U,$J,358.3,37648,2)
 ;;=^5009620
 ;;^UTILITY(U,$J,358.3,37649,0)
 ;;=M00.19^^140^1795^32
 ;;^UTILITY(U,$J,358.3,37649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37649,1,3,0)
 ;;=3^Pneumococcal polyarthritis
 ;;^UTILITY(U,$J,358.3,37649,1,4,0)
 ;;=4^M00.19
 ;;^UTILITY(U,$J,358.3,37649,2)
 ;;=^5009644
 ;;^UTILITY(U,$J,358.3,37650,0)
 ;;=M00.29^^140^1795^65
 ;;^UTILITY(U,$J,358.3,37650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37650,1,3,0)
 ;;=3^Streptococcal polyarthritis, oth
 ;;^UTILITY(U,$J,358.3,37650,1,4,0)
 ;;=4^M00.29
 ;;^UTILITY(U,$J,358.3,37650,2)
 ;;=^5009668
 ;;^UTILITY(U,$J,358.3,37651,0)
 ;;=M00.89^^140^1795^33
 ;;^UTILITY(U,$J,358.3,37651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37651,1,3,0)
 ;;=3^Polyarthritis d/t other bacteria
 ;;^UTILITY(U,$J,358.3,37651,1,4,0)
 ;;=4^M00.89
 ;;^UTILITY(U,$J,358.3,37651,2)
 ;;=^5009692
 ;;^UTILITY(U,$J,358.3,37652,0)
 ;;=M45.9^^140^1796^1
 ;;^UTILITY(U,$J,358.3,37652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37652,1,3,0)
 ;;=3^Ankylsng spndylsis of unspec sites in spine
 ;;^UTILITY(U,$J,358.3,37652,1,4,0)
 ;;=4^M45.9
 ;;^UTILITY(U,$J,358.3,37652,2)
 ;;=^5011969
 ;;^UTILITY(U,$J,358.3,37653,0)
 ;;=M46.90^^140^1796^4
 ;;^UTILITY(U,$J,358.3,37653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37653,1,3,0)
 ;;=3^Inflammatory spondylopathy, site unspec, unspec
 ;;^UTILITY(U,$J,358.3,37653,1,4,0)
 ;;=4^M46.90
 ;;^UTILITY(U,$J,358.3,37653,2)
 ;;=^5012030
 ;;^UTILITY(U,$J,358.3,37654,0)
 ;;=M47.817^^140^1796^18
 ;;^UTILITY(U,$J,358.3,37654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37654,1,3,0)
 ;;=3^Spndylsis w/o mylopthy or radclpthy, lumboscrl regn
 ;;^UTILITY(U,$J,358.3,37654,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,37654,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,37655,0)
 ;;=M51.34^^140^1796^7
 ;;^UTILITY(U,$J,358.3,37655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37655,1,3,0)
 ;;=3^Intrvrtbrl disc degen, thor regn, oth
 ;;^UTILITY(U,$J,358.3,37655,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,37655,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,37656,0)
 ;;=M51.35^^140^1796^8
 ;;^UTILITY(U,$J,358.3,37656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37656,1,3,0)
 ;;=3^Intrvrtbrl disc degen, thorclmbr regn, oth
 ;;^UTILITY(U,$J,358.3,37656,1,4,0)
 ;;=4^M51.35
 ;;^UTILITY(U,$J,358.3,37656,2)
 ;;=^5012252
 ;;^UTILITY(U,$J,358.3,37657,0)
 ;;=M51.36^^140^1796^6
 ;;^UTILITY(U,$J,358.3,37657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37657,1,3,0)
 ;;=3^Intrvrtbrl disc degen, lumb regn, oth
 ;;^UTILITY(U,$J,358.3,37657,1,4,0)
 ;;=4^M51.36
 ;;^UTILITY(U,$J,358.3,37657,2)
 ;;=^5012253
 ;;^UTILITY(U,$J,358.3,37658,0)
 ;;=M51.37^^140^1796^5
 ;;^UTILITY(U,$J,358.3,37658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37658,1,3,0)
 ;;=3^Intrvrtbrl disc degen, lmboscrl regn, oth
 ;;^UTILITY(U,$J,358.3,37658,1,4,0)
 ;;=4^M51.37
