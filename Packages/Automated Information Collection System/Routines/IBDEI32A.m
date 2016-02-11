IBDEI32A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51326,1,3,0)
 ;;=3^Streptococcal arthritis, vertebrae, oth
 ;;^UTILITY(U,$J,358.3,51326,1,4,0)
 ;;=4^M00.28
 ;;^UTILITY(U,$J,358.3,51326,2)
 ;;=^5009667
 ;;^UTILITY(U,$J,358.3,51327,0)
 ;;=M00.88^^222^2474^15
 ;;^UTILITY(U,$J,358.3,51327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51327,1,3,0)
 ;;=3^Arthritis d/t other bacteria, vertebrae
 ;;^UTILITY(U,$J,358.3,51327,1,4,0)
 ;;=4^M00.88
 ;;^UTILITY(U,$J,358.3,51327,2)
 ;;=^5009691
 ;;^UTILITY(U,$J,358.3,51328,0)
 ;;=M00.09^^222^2474^50
 ;;^UTILITY(U,$J,358.3,51328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51328,1,3,0)
 ;;=3^Staphylococcal polyarthritis
 ;;^UTILITY(U,$J,358.3,51328,1,4,0)
 ;;=4^M00.09
 ;;^UTILITY(U,$J,358.3,51328,2)
 ;;=^5009620
 ;;^UTILITY(U,$J,358.3,51329,0)
 ;;=M00.19^^222^2474^32
 ;;^UTILITY(U,$J,358.3,51329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51329,1,3,0)
 ;;=3^Pneumococcal polyarthritis
 ;;^UTILITY(U,$J,358.3,51329,1,4,0)
 ;;=4^M00.19
 ;;^UTILITY(U,$J,358.3,51329,2)
 ;;=^5009644
 ;;^UTILITY(U,$J,358.3,51330,0)
 ;;=M00.29^^222^2474^65
 ;;^UTILITY(U,$J,358.3,51330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51330,1,3,0)
 ;;=3^Streptococcal polyarthritis, oth
 ;;^UTILITY(U,$J,358.3,51330,1,4,0)
 ;;=4^M00.29
 ;;^UTILITY(U,$J,358.3,51330,2)
 ;;=^5009668
 ;;^UTILITY(U,$J,358.3,51331,0)
 ;;=M00.89^^222^2474^33
 ;;^UTILITY(U,$J,358.3,51331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51331,1,3,0)
 ;;=3^Polyarthritis d/t other bacteria
 ;;^UTILITY(U,$J,358.3,51331,1,4,0)
 ;;=4^M00.89
 ;;^UTILITY(U,$J,358.3,51331,2)
 ;;=^5009692
 ;;^UTILITY(U,$J,358.3,51332,0)
 ;;=M45.9^^222^2475^1
 ;;^UTILITY(U,$J,358.3,51332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51332,1,3,0)
 ;;=3^Ankylsng spndylsis of unspec sites in spine
 ;;^UTILITY(U,$J,358.3,51332,1,4,0)
 ;;=4^M45.9
 ;;^UTILITY(U,$J,358.3,51332,2)
 ;;=^5011969
 ;;^UTILITY(U,$J,358.3,51333,0)
 ;;=M46.90^^222^2475^4
 ;;^UTILITY(U,$J,358.3,51333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51333,1,3,0)
 ;;=3^Inflammatory spondylopathy, site unspec, unspec
 ;;^UTILITY(U,$J,358.3,51333,1,4,0)
 ;;=4^M46.90
 ;;^UTILITY(U,$J,358.3,51333,2)
 ;;=^5012030
 ;;^UTILITY(U,$J,358.3,51334,0)
 ;;=M47.817^^222^2475^18
 ;;^UTILITY(U,$J,358.3,51334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51334,1,3,0)
 ;;=3^Spndylsis w/o mylopthy or radclpthy, lumboscrl regn
 ;;^UTILITY(U,$J,358.3,51334,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,51334,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,51335,0)
 ;;=M51.34^^222^2475^7
 ;;^UTILITY(U,$J,358.3,51335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51335,1,3,0)
 ;;=3^Intrvrtbrl disc degen, thor regn, oth
 ;;^UTILITY(U,$J,358.3,51335,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,51335,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,51336,0)
 ;;=M51.35^^222^2475^8
 ;;^UTILITY(U,$J,358.3,51336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51336,1,3,0)
 ;;=3^Intrvrtbrl disc degen, thorclmbr regn, oth
 ;;^UTILITY(U,$J,358.3,51336,1,4,0)
 ;;=4^M51.35
 ;;^UTILITY(U,$J,358.3,51336,2)
 ;;=^5012252
 ;;^UTILITY(U,$J,358.3,51337,0)
 ;;=M51.36^^222^2475^6
 ;;^UTILITY(U,$J,358.3,51337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51337,1,3,0)
 ;;=3^Intrvrtbrl disc degen, lumb regn, oth
 ;;^UTILITY(U,$J,358.3,51337,1,4,0)
 ;;=4^M51.36
 ;;^UTILITY(U,$J,358.3,51337,2)
 ;;=^5012253
 ;;^UTILITY(U,$J,358.3,51338,0)
 ;;=M51.37^^222^2475^5
 ;;^UTILITY(U,$J,358.3,51338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51338,1,3,0)
 ;;=3^Intrvrtbrl disc degen, lmboscrl regn, oth
 ;;^UTILITY(U,$J,358.3,51338,1,4,0)
 ;;=4^M51.37
