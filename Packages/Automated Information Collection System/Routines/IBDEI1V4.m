IBDEI1V4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31649,1,4,0)
 ;;=4^M00.071
 ;;^UTILITY(U,$J,358.3,31649,2)
 ;;=^5009616
 ;;^UTILITY(U,$J,358.3,31650,0)
 ;;=M06.072^^126^1604^36
 ;;^UTILITY(U,$J,358.3,31650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31650,1,3,0)
 ;;=3^Arthritis, Rheum w/o Rheum Factor, lft ank & ft
 ;;^UTILITY(U,$J,358.3,31650,1,4,0)
 ;;=4^M06.072
 ;;^UTILITY(U,$J,358.3,31650,2)
 ;;=^5010067
 ;;^UTILITY(U,$J,358.3,31651,0)
 ;;=M06.071^^126^1604^37
 ;;^UTILITY(U,$J,358.3,31651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31651,1,3,0)
 ;;=3^Arthritis, Rheum w/o Rheum Factor, rt ank & ft
 ;;^UTILITY(U,$J,358.3,31651,1,4,0)
 ;;=4^M06.071
 ;;^UTILITY(U,$J,358.3,31651,2)
 ;;=^5010066
 ;;^UTILITY(U,$J,358.3,31652,0)
 ;;=M05.772^^126^1604^30
 ;;^UTILITY(U,$J,358.3,31652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31652,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Fact, lft ank & ft w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,31652,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,31652,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,31653,0)
 ;;=M05.771^^126^1604^31
 ;;^UTILITY(U,$J,358.3,31653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31653,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Fact, rt ank & ft w/o org/sys involv
 ;;^UTILITY(U,$J,358.3,31653,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,31653,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,31654,0)
 ;;=M06.872^^126^1604^38
 ;;^UTILITY(U,$J,358.3,31654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31654,1,3,0)
 ;;=3^Arthritis, Rheum, lft ank & ft, oth, spec
 ;;^UTILITY(U,$J,358.3,31654,1,4,0)
 ;;=4^M06.872
 ;;^UTILITY(U,$J,358.3,31654,2)
 ;;=^5010141
 ;;^UTILITY(U,$J,358.3,31655,0)
 ;;=M06.871^^126^1604^40
 ;;^UTILITY(U,$J,358.3,31655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31655,1,3,0)
 ;;=3^Arthritis, Rheum, rt ank & ft, oth, spec
 ;;^UTILITY(U,$J,358.3,31655,1,4,0)
 ;;=4^M06.871
 ;;^UTILITY(U,$J,358.3,31655,2)
 ;;=^5010140
 ;;^UTILITY(U,$J,358.3,31656,0)
 ;;=M06.89^^126^1604^39
 ;;^UTILITY(U,$J,358.3,31656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31656,1,3,0)
 ;;=3^Arthritis, Rheum, multpl sites, oth, spec
 ;;^UTILITY(U,$J,358.3,31656,1,4,0)
 ;;=4^M06.89
 ;;^UTILITY(U,$J,358.3,31656,2)
 ;;=^5010144
 ;;^UTILITY(U,$J,358.3,31657,0)
 ;;=M05.9^^126^1604^35
 ;;^UTILITY(U,$J,358.3,31657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31657,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, unspec
 ;;^UTILITY(U,$J,358.3,31657,1,4,0)
 ;;=4^M05.9
 ;;^UTILITY(U,$J,358.3,31657,2)
 ;;=^5010046
 ;;^UTILITY(U,$J,358.3,31658,0)
 ;;=M05.89^^126^1604^33
 ;;^UTILITY(U,$J,358.3,31658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31658,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, multpl sites, oth
 ;;^UTILITY(U,$J,358.3,31658,1,4,0)
 ;;=4^M05.89
 ;;^UTILITY(U,$J,358.3,31658,2)
 ;;=^5010045
 ;;^UTILITY(U,$J,358.3,31659,0)
 ;;=M05.872^^126^1604^32
 ;;^UTILITY(U,$J,358.3,31659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31659,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, lft ank & ft
 ;;^UTILITY(U,$J,358.3,31659,1,4,0)
 ;;=4^M05.872
 ;;^UTILITY(U,$J,358.3,31659,2)
 ;;=^5010043
 ;;^UTILITY(U,$J,358.3,31660,0)
 ;;=M05.871^^126^1604^34
 ;;^UTILITY(U,$J,358.3,31660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31660,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, rt ank & ft
 ;;^UTILITY(U,$J,358.3,31660,1,4,0)
 ;;=4^M05.871
 ;;^UTILITY(U,$J,358.3,31660,2)
 ;;=^5010042
 ;;^UTILITY(U,$J,358.3,31661,0)
 ;;=M12.571^^126^1604^47
 ;;^UTILITY(U,$J,358.3,31661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31661,1,3,0)
 ;;=3^Arthropathy, Traumatic, rt ank & ft
 ;;^UTILITY(U,$J,358.3,31661,1,4,0)
 ;;=4^M12.571
