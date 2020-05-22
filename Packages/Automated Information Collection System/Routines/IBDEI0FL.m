IBDEI0FL ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6728,1,3,0)
 ;;=3^Primary osteoarthritis, lft ankle & foot
 ;;^UTILITY(U,$J,358.3,6728,1,4,0)
 ;;=4^M19.072
 ;;^UTILITY(U,$J,358.3,6728,2)
 ;;=^5010821
 ;;^UTILITY(U,$J,358.3,6729,0)
 ;;=M17.9^^56^439^75
 ;;^UTILITY(U,$J,358.3,6729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6729,1,3,0)
 ;;=3^Osteoarthritis of knee, unspec
 ;;^UTILITY(U,$J,358.3,6729,1,4,0)
 ;;=4^M17.9
 ;;^UTILITY(U,$J,358.3,6729,2)
 ;;=^5010794
 ;;^UTILITY(U,$J,358.3,6730,0)
 ;;=M12.9^^56^439^4
 ;;^UTILITY(U,$J,358.3,6730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6730,1,3,0)
 ;;=3^Arthropathy, unspec
 ;;^UTILITY(U,$J,358.3,6730,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,6730,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,6731,0)
 ;;=M22.41^^56^439^25
 ;;^UTILITY(U,$J,358.3,6731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6731,1,3,0)
 ;;=3^Chondromalacia patellae, rt knee
 ;;^UTILITY(U,$J,358.3,6731,1,4,0)
 ;;=4^M22.41
 ;;^UTILITY(U,$J,358.3,6731,2)
 ;;=^5011186
 ;;^UTILITY(U,$J,358.3,6732,0)
 ;;=M22.42^^56^439^24
 ;;^UTILITY(U,$J,358.3,6732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6732,1,3,0)
 ;;=3^Chondromalacia patellae, lft knee
 ;;^UTILITY(U,$J,358.3,6732,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,6732,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,6733,0)
 ;;=M22.91^^56^439^29
 ;;^UTILITY(U,$J,358.3,6733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6733,1,3,0)
 ;;=3^Disorder of patella, rt knee, unspec
 ;;^UTILITY(U,$J,358.3,6733,1,4,0)
 ;;=4^M22.91
 ;;^UTILITY(U,$J,358.3,6733,2)
 ;;=^5133780
 ;;^UTILITY(U,$J,358.3,6734,0)
 ;;=M22.92^^56^439^28
 ;;^UTILITY(U,$J,358.3,6734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6734,1,3,0)
 ;;=3^Disorder of patella, lft knee, unspec
 ;;^UTILITY(U,$J,358.3,6734,1,4,0)
 ;;=4^M22.92
 ;;^UTILITY(U,$J,358.3,6734,2)
 ;;=^5133781
 ;;^UTILITY(U,$J,358.3,6735,0)
 ;;=M23.91^^56^439^59
 ;;^UTILITY(U,$J,358.3,6735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6735,1,3,0)
 ;;=3^Internal derangement of rt knee, unspec
 ;;^UTILITY(U,$J,358.3,6735,1,4,0)
 ;;=4^M23.91
 ;;^UTILITY(U,$J,358.3,6735,2)
 ;;=^5133806
 ;;^UTILITY(U,$J,358.3,6736,0)
 ;;=M23.92^^56^439^58
 ;;^UTILITY(U,$J,358.3,6736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6736,1,3,0)
 ;;=3^Internal derangement of lft knee, unspec
 ;;^UTILITY(U,$J,358.3,6736,1,4,0)
 ;;=4^M23.92
 ;;^UTILITY(U,$J,358.3,6736,2)
 ;;=^5133807
 ;;^UTILITY(U,$J,358.3,6737,0)
 ;;=M24.811^^56^439^63
 ;;^UTILITY(U,$J,358.3,6737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6737,1,3,0)
 ;;=3^Joint derangements of rt shldr, oth, spec, NEC
 ;;^UTILITY(U,$J,358.3,6737,1,4,0)
 ;;=4^M24.811
 ;;^UTILITY(U,$J,358.3,6737,2)
 ;;=^5011453
 ;;^UTILITY(U,$J,358.3,6738,0)
 ;;=M24.812^^56^439^62
 ;;^UTILITY(U,$J,358.3,6738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6738,1,3,0)
 ;;=3^Joint derangements of lft shldr, oth, spec, NEC
 ;;^UTILITY(U,$J,358.3,6738,1,4,0)
 ;;=4^M24.812
 ;;^UTILITY(U,$J,358.3,6738,2)
 ;;=^5011454
 ;;^UTILITY(U,$J,358.3,6739,0)
 ;;=M25.311^^56^439^57
 ;;^UTILITY(U,$J,358.3,6739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6739,1,3,0)
 ;;=3^Instability, rt shldr
 ;;^UTILITY(U,$J,358.3,6739,1,4,0)
 ;;=4^M25.311
 ;;^UTILITY(U,$J,358.3,6739,2)
 ;;=^5011551
 ;;^UTILITY(U,$J,358.3,6740,0)
 ;;=M25.312^^56^439^54
 ;;^UTILITY(U,$J,358.3,6740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6740,1,3,0)
 ;;=3^Instability, lft shldr
