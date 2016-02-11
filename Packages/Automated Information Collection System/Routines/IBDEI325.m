IBDEI325 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51262,1,4,0)
 ;;=4^M90.88
 ;;^UTILITY(U,$J,358.3,51262,2)
 ;;=^5015190
 ;;^UTILITY(U,$J,358.3,51263,0)
 ;;=M90.89^^222^2472^57
 ;;^UTILITY(U,$J,358.3,51263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51263,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, mult sites
 ;;^UTILITY(U,$J,358.3,51263,1,4,0)
 ;;=4^M90.89
 ;;^UTILITY(U,$J,358.3,51263,2)
 ;;=^5015191
 ;;^UTILITY(U,$J,358.3,51264,0)
 ;;=M81.8^^222^2473^1
 ;;^UTILITY(U,$J,358.3,51264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51264,1,3,0)
 ;;=3^Osteoporosis w/o current path fx, oth
 ;;^UTILITY(U,$J,358.3,51264,1,4,0)
 ;;=4^M81.8
 ;;^UTILITY(U,$J,358.3,51264,2)
 ;;=^5013557
 ;;^UTILITY(U,$J,358.3,51265,0)
 ;;=M81.0^^222^2473^2
 ;;^UTILITY(U,$J,358.3,51265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51265,1,3,0)
 ;;=3^Osteoporosis, age-related w/o current path fx
 ;;^UTILITY(U,$J,358.3,51265,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,51265,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,51266,0)
 ;;=M00.9^^222^2474^34
 ;;^UTILITY(U,$J,358.3,51266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51266,1,3,0)
 ;;=3^Pyogenic arthritis, unspec
 ;;^UTILITY(U,$J,358.3,51266,1,4,0)
 ;;=4^M00.9
 ;;^UTILITY(U,$J,358.3,51266,2)
 ;;=^5009693
 ;;^UTILITY(U,$J,358.3,51267,0)
 ;;=M00.10^^222^2474^16
 ;;^UTILITY(U,$J,358.3,51267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51267,1,3,0)
 ;;=3^Pneumicoccal arthritis, unspec joint
 ;;^UTILITY(U,$J,358.3,51267,1,4,0)
 ;;=4^M00.10
 ;;^UTILITY(U,$J,358.3,51267,2)
 ;;=^5009621
 ;;^UTILITY(U,$J,358.3,51268,0)
 ;;=M00.011^^222^2474^47
 ;;^UTILITY(U,$J,358.3,51268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51268,1,3,0)
 ;;=3^Staphylococcal arthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,51268,1,4,0)
 ;;=4^M00.011
 ;;^UTILITY(U,$J,358.3,51268,2)
 ;;=^5009598
 ;;^UTILITY(U,$J,358.3,51269,0)
 ;;=M00.012^^222^2474^40
 ;;^UTILITY(U,$J,358.3,51269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51269,1,3,0)
 ;;=3^Staphylococcal arthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,51269,1,4,0)
 ;;=4^M00.012
 ;;^UTILITY(U,$J,358.3,51269,2)
 ;;=^5009599
 ;;^UTILITY(U,$J,358.3,51270,0)
 ;;=M00.111^^222^2474^29
 ;;^UTILITY(U,$J,358.3,51270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51270,1,3,0)
 ;;=3^Pneumococcal arthritis, rt shldr
 ;;^UTILITY(U,$J,358.3,51270,1,4,0)
 ;;=4^M00.111
 ;;^UTILITY(U,$J,358.3,51270,2)
 ;;=^5009622
 ;;^UTILITY(U,$J,358.3,51271,0)
 ;;=M00.112^^222^2474^22
 ;;^UTILITY(U,$J,358.3,51271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51271,1,3,0)
 ;;=3^Pneumococcal arthritis, lft shldr
 ;;^UTILITY(U,$J,358.3,51271,1,4,0)
 ;;=4^M00.112
 ;;^UTILITY(U,$J,358.3,51271,2)
 ;;=^5009623
 ;;^UTILITY(U,$J,358.3,51272,0)
 ;;=M00.211^^222^2474^62
 ;;^UTILITY(U,$J,358.3,51272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51272,1,3,0)
 ;;=3^Streptococcal arthritis, rt shldr, oth
 ;;^UTILITY(U,$J,358.3,51272,1,4,0)
 ;;=4^M00.211
 ;;^UTILITY(U,$J,358.3,51272,2)
 ;;=^5009646
 ;;^UTILITY(U,$J,358.3,51273,0)
 ;;=M00.212^^222^2474^56
 ;;^UTILITY(U,$J,358.3,51273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51273,1,3,0)
 ;;=3^Streptococcal arthritis, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,51273,1,4,0)
 ;;=4^M00.212
 ;;^UTILITY(U,$J,358.3,51273,2)
 ;;=^5009647
 ;;^UTILITY(U,$J,358.3,51274,0)
 ;;=M00.811^^222^2474^2
 ;;^UTILITY(U,$J,358.3,51274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51274,1,3,0)
 ;;=3^Arthritis d/t oth bacteria, rt shldr
 ;;^UTILITY(U,$J,358.3,51274,1,4,0)
 ;;=4^M00.811
 ;;^UTILITY(U,$J,358.3,51274,2)
 ;;=^5009670
 ;;^UTILITY(U,$J,358.3,51275,0)
 ;;=M00.812^^222^2474^1
 ;;^UTILITY(U,$J,358.3,51275,1,0)
 ;;=^358.31IA^4^2
