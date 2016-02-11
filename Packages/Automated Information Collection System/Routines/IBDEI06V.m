IBDEI06V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2631,1,3,0)
 ;;=3^Internal derangement of rt knee, unspec
 ;;^UTILITY(U,$J,358.3,2631,1,4,0)
 ;;=4^M23.91
 ;;^UTILITY(U,$J,358.3,2631,2)
 ;;=^5133806
 ;;^UTILITY(U,$J,358.3,2632,0)
 ;;=M23.92^^25^225^58
 ;;^UTILITY(U,$J,358.3,2632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2632,1,3,0)
 ;;=3^Internal derangement of lft knee, unspec
 ;;^UTILITY(U,$J,358.3,2632,1,4,0)
 ;;=4^M23.92
 ;;^UTILITY(U,$J,358.3,2632,2)
 ;;=^5133807
 ;;^UTILITY(U,$J,358.3,2633,0)
 ;;=M24.811^^25^225^63
 ;;^UTILITY(U,$J,358.3,2633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2633,1,3,0)
 ;;=3^Joint derangements of rt shldr, oth, spec, NEC
 ;;^UTILITY(U,$J,358.3,2633,1,4,0)
 ;;=4^M24.811
 ;;^UTILITY(U,$J,358.3,2633,2)
 ;;=^5011453
 ;;^UTILITY(U,$J,358.3,2634,0)
 ;;=M24.812^^25^225^62
 ;;^UTILITY(U,$J,358.3,2634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2634,1,3,0)
 ;;=3^Joint derangements of lft shldr, oth, spec, NEC
 ;;^UTILITY(U,$J,358.3,2634,1,4,0)
 ;;=4^M24.812
 ;;^UTILITY(U,$J,358.3,2634,2)
 ;;=^5011454
 ;;^UTILITY(U,$J,358.3,2635,0)
 ;;=M25.311^^25^225^57
 ;;^UTILITY(U,$J,358.3,2635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2635,1,3,0)
 ;;=3^Instability, rt shldr
 ;;^UTILITY(U,$J,358.3,2635,1,4,0)
 ;;=4^M25.311
 ;;^UTILITY(U,$J,358.3,2635,2)
 ;;=^5011551
 ;;^UTILITY(U,$J,358.3,2636,0)
 ;;=M25.312^^25^225^54
 ;;^UTILITY(U,$J,358.3,2636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2636,1,3,0)
 ;;=3^Instability, lft shldr
 ;;^UTILITY(U,$J,358.3,2636,1,4,0)
 ;;=4^M25.312
 ;;^UTILITY(U,$J,358.3,2636,2)
 ;;=^5011552
 ;;^UTILITY(U,$J,358.3,2637,0)
 ;;=M25.211^^25^225^33
 ;;^UTILITY(U,$J,358.3,2637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2637,1,3,0)
 ;;=3^Flail joint, rt shldr
 ;;^UTILITY(U,$J,358.3,2637,1,4,0)
 ;;=4^M25.211
 ;;^UTILITY(U,$J,358.3,2637,2)
 ;;=^5011528
 ;;^UTILITY(U,$J,358.3,2638,0)
 ;;=M25.212^^25^225^31
 ;;^UTILITY(U,$J,358.3,2638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2638,1,3,0)
 ;;=3^Flail joint, lft shldr
 ;;^UTILITY(U,$J,358.3,2638,1,4,0)
 ;;=4^M25.212
 ;;^UTILITY(U,$J,358.3,2638,2)
 ;;=^5011529
 ;;^UTILITY(U,$J,358.3,2639,0)
 ;;=M25.261^^25^225^32
 ;;^UTILITY(U,$J,358.3,2639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2639,1,3,0)
 ;;=3^Flail joint, rt knee
 ;;^UTILITY(U,$J,358.3,2639,1,4,0)
 ;;=4^M25.261
 ;;^UTILITY(U,$J,358.3,2639,2)
 ;;=^5011543
 ;;^UTILITY(U,$J,358.3,2640,0)
 ;;=M25.262^^25^225^30
 ;;^UTILITY(U,$J,358.3,2640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2640,1,3,0)
 ;;=3^Flail joint, lft knee
 ;;^UTILITY(U,$J,358.3,2640,1,4,0)
 ;;=4^M25.262
 ;;^UTILITY(U,$J,358.3,2640,2)
 ;;=^5011544
 ;;^UTILITY(U,$J,358.3,2641,0)
 ;;=M25.361^^25^225^55
 ;;^UTILITY(U,$J,358.3,2641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2641,1,3,0)
 ;;=3^Instability, rt knee
 ;;^UTILITY(U,$J,358.3,2641,1,4,0)
 ;;=4^M25.361
 ;;^UTILITY(U,$J,358.3,2641,2)
 ;;=^5011566
 ;;^UTILITY(U,$J,358.3,2642,0)
 ;;=M25.362^^25^225^52
 ;;^UTILITY(U,$J,358.3,2642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2642,1,3,0)
 ;;=3^Instability, lft knee
 ;;^UTILITY(U,$J,358.3,2642,1,4,0)
 ;;=4^M25.362
 ;;^UTILITY(U,$J,358.3,2642,2)
 ;;=^5011567
 ;;^UTILITY(U,$J,358.3,2643,0)
 ;;=M23.51^^25^225^56
 ;;^UTILITY(U,$J,358.3,2643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2643,1,3,0)
 ;;=3^Instability, rt knee, chronic
 ;;^UTILITY(U,$J,358.3,2643,1,4,0)
 ;;=4^M23.51
 ;;^UTILITY(U,$J,358.3,2643,2)
 ;;=^5011254
 ;;^UTILITY(U,$J,358.3,2644,0)
 ;;=M23.52^^25^225^53
 ;;^UTILITY(U,$J,358.3,2644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2644,1,3,0)
 ;;=3^Instability, lft knee, chronic
 ;;^UTILITY(U,$J,358.3,2644,1,4,0)
 ;;=4^M23.52
