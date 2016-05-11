IBDEI27U ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37582,1,4,0)
 ;;=4^M90.88
 ;;^UTILITY(U,$J,358.3,37582,2)
 ;;=^5015190
 ;;^UTILITY(U,$J,358.3,37583,0)
 ;;=M90.89^^140^1793^57
 ;;^UTILITY(U,$J,358.3,37583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37583,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, mult sites
 ;;^UTILITY(U,$J,358.3,37583,1,4,0)
 ;;=4^M90.89
 ;;^UTILITY(U,$J,358.3,37583,2)
 ;;=^5015191
 ;;^UTILITY(U,$J,358.3,37584,0)
 ;;=M81.8^^140^1794^1
 ;;^UTILITY(U,$J,358.3,37584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37584,1,3,0)
 ;;=3^Osteoporosis w/o current path fx, oth
 ;;^UTILITY(U,$J,358.3,37584,1,4,0)
 ;;=4^M81.8
 ;;^UTILITY(U,$J,358.3,37584,2)
 ;;=^5013557
 ;;^UTILITY(U,$J,358.3,37585,0)
 ;;=M81.0^^140^1794^2
 ;;^UTILITY(U,$J,358.3,37585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37585,1,3,0)
 ;;=3^Osteoporosis, age-related w/o current path fx
 ;;^UTILITY(U,$J,358.3,37585,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,37585,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,37586,0)
 ;;=M00.9^^140^1795^34
 ;;^UTILITY(U,$J,358.3,37586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37586,1,3,0)
 ;;=3^Pyogenic arthritis, unspec
 ;;^UTILITY(U,$J,358.3,37586,1,4,0)
 ;;=4^M00.9
 ;;^UTILITY(U,$J,358.3,37586,2)
 ;;=^5009693
 ;;^UTILITY(U,$J,358.3,37587,0)
 ;;=M00.10^^140^1795^16
 ;;^UTILITY(U,$J,358.3,37587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37587,1,3,0)
 ;;=3^Pneumicoccal arthritis, unspec joint
 ;;^UTILITY(U,$J,358.3,37587,1,4,0)
 ;;=4^M00.10
 ;;^UTILITY(U,$J,358.3,37587,2)
 ;;=^5009621
 ;;^UTILITY(U,$J,358.3,37588,0)
 ;;=M00.011^^140^1795^47
 ;;^UTILITY(U,$J,358.3,37588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37588,1,3,0)
 ;;=3^Staphylococcal arthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,37588,1,4,0)
 ;;=4^M00.011
 ;;^UTILITY(U,$J,358.3,37588,2)
 ;;=^5009598
 ;;^UTILITY(U,$J,358.3,37589,0)
 ;;=M00.012^^140^1795^40
 ;;^UTILITY(U,$J,358.3,37589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37589,1,3,0)
 ;;=3^Staphylococcal arthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,37589,1,4,0)
 ;;=4^M00.012
 ;;^UTILITY(U,$J,358.3,37589,2)
 ;;=^5009599
 ;;^UTILITY(U,$J,358.3,37590,0)
 ;;=M00.111^^140^1795^29
 ;;^UTILITY(U,$J,358.3,37590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37590,1,3,0)
 ;;=3^Pneumococcal arthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,37590,1,4,0)
 ;;=4^M00.111
 ;;^UTILITY(U,$J,358.3,37590,2)
 ;;=^5009622
 ;;^UTILITY(U,$J,358.3,37591,0)
 ;;=M00.112^^140^1795^22
 ;;^UTILITY(U,$J,358.3,37591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37591,1,3,0)
 ;;=3^Pneumococcal arthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,37591,1,4,0)
 ;;=4^M00.112
 ;;^UTILITY(U,$J,358.3,37591,2)
 ;;=^5009623
 ;;^UTILITY(U,$J,358.3,37592,0)
 ;;=M00.211^^140^1795^62
 ;;^UTILITY(U,$J,358.3,37592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37592,1,3,0)
 ;;=3^Streptococcal arthritis, rt shldr, oth
 ;;^UTILITY(U,$J,358.3,37592,1,4,0)
 ;;=4^M00.211
 ;;^UTILITY(U,$J,358.3,37592,2)
 ;;=^5009646
 ;;^UTILITY(U,$J,358.3,37593,0)
 ;;=M00.212^^140^1795^56
 ;;^UTILITY(U,$J,358.3,37593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37593,1,3,0)
 ;;=3^Streptococcal arthritis, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,37593,1,4,0)
 ;;=4^M00.212
 ;;^UTILITY(U,$J,358.3,37593,2)
 ;;=^5009647
 ;;^UTILITY(U,$J,358.3,37594,0)
 ;;=M00.811^^140^1795^2
 ;;^UTILITY(U,$J,358.3,37594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37594,1,3,0)
 ;;=3^Arthritis d/t oth bacteria, rt shldr
 ;;^UTILITY(U,$J,358.3,37594,1,4,0)
 ;;=4^M00.811
 ;;^UTILITY(U,$J,358.3,37594,2)
 ;;=^5009670
 ;;^UTILITY(U,$J,358.3,37595,0)
 ;;=M00.812^^140^1795^1
 ;;^UTILITY(U,$J,358.3,37595,1,0)
 ;;=^358.31IA^4^2
