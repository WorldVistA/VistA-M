IBDEI06W ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2711,0)
 ;;=G04.90^^7^83^66
 ;;^UTILITY(U,$J,358.3,2711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2711,1,3,0)
 ;;=3^Encephalitis and encephalomyelitis, unsp
 ;;^UTILITY(U,$J,358.3,2711,1,4,0)
 ;;=4^G04.90
 ;;^UTILITY(U,$J,358.3,2711,2)
 ;;=^5003741
 ;;^UTILITY(U,$J,358.3,2712,0)
 ;;=I38.^^7^83^68
 ;;^UTILITY(U,$J,358.3,2712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2712,1,3,0)
 ;;=3^Endocarditis
 ;;^UTILITY(U,$J,358.3,2712,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,2712,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,2713,0)
 ;;=T82.6XXA^^7^83^69
 ;;^UTILITY(U,$J,358.3,2713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2713,1,3,0)
 ;;=3^Endocarditis, prosthetic valve
 ;;^UTILITY(U,$J,358.3,2713,1,4,0)
 ;;=4^T82.6XXA
 ;;^UTILITY(U,$J,358.3,2713,2)
 ;;=^5054908
 ;;^UTILITY(U,$J,358.3,2714,0)
 ;;=N45.1^^7^83^72
 ;;^UTILITY(U,$J,358.3,2714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2714,1,3,0)
 ;;=3^Epididymitis
 ;;^UTILITY(U,$J,358.3,2714,1,4,0)
 ;;=4^N45.1
 ;;^UTILITY(U,$J,358.3,2714,2)
 ;;=^41396
 ;;^UTILITY(U,$J,358.3,2715,0)
 ;;=B27.00^^7^83^73
 ;;^UTILITY(U,$J,358.3,2715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2715,1,3,0)
 ;;=3^Epstein-Barr virus infection
 ;;^UTILITY(U,$J,358.3,2715,1,4,0)
 ;;=4^B27.00
 ;;^UTILITY(U,$J,358.3,2715,2)
 ;;=^5000566
 ;;^UTILITY(U,$J,358.3,2716,0)
 ;;=R50.9^^7^83^78
 ;;^UTILITY(U,$J,358.3,2716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2716,1,3,0)
 ;;=3^Fever, unspecified
 ;;^UTILITY(U,$J,358.3,2716,1,4,0)
 ;;=4^R50.9
 ;;^UTILITY(U,$J,358.3,2716,2)
 ;;=^5019512
 ;;^UTILITY(U,$J,358.3,2717,0)
 ;;=M79.7^^7^83^79
 ;;^UTILITY(U,$J,358.3,2717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2717,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,2717,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,2717,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,2718,0)
 ;;=L97.519^^7^83^85
 ;;^UTILITY(U,$J,358.3,2718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2718,1,3,0)
 ;;=3^Foot ulcer,non-pressure,chr,oth prt right foot,unsp severity
 ;;^UTILITY(U,$J,358.3,2718,1,4,0)
 ;;=4^L97.519
 ;;^UTILITY(U,$J,358.3,2718,2)
 ;;=^5009549
 ;;^UTILITY(U,$J,358.3,2719,0)
 ;;=L97.529^^7^83^84
 ;;^UTILITY(U,$J,358.3,2719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2719,1,3,0)
 ;;=3^Foot ulcer,non-pressure,chr,oth prt left foot,unsp severity
 ;;^UTILITY(U,$J,358.3,2719,1,4,0)
 ;;=4^L97.529
 ;;^UTILITY(U,$J,358.3,2719,2)
 ;;=^5009554
 ;;^UTILITY(U,$J,358.3,2720,0)
 ;;=L97.419^^7^83^83
 ;;^UTILITY(U,$J,358.3,2720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2720,1,3,0)
 ;;=3^Foot ulcer,non-pressure,chr right heel/midfoot,unsp severity
 ;;^UTILITY(U,$J,358.3,2720,1,4,0)
 ;;=4^L97.419
 ;;^UTILITY(U,$J,358.3,2720,2)
 ;;=^5009534
 ;;^UTILITY(U,$J,358.3,2721,0)
 ;;=L97.429^^7^83^82
 ;;^UTILITY(U,$J,358.3,2721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2721,1,3,0)
 ;;=3^Foot ulcer,non-pressure,chr left heel/midfoot,unsp severity
 ;;^UTILITY(U,$J,358.3,2721,1,4,0)
 ;;=4^L97.429
 ;;^UTILITY(U,$J,358.3,2721,2)
 ;;=^5009539
 ;;^UTILITY(U,$J,358.3,2722,0)
 ;;=E11.621^^7^83^81
 ;;^UTILITY(U,$J,358.3,2722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2722,1,3,0)
 ;;=3^Foot ulcer, diabetic, type II
 ;;^UTILITY(U,$J,358.3,2722,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,2722,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,2723,0)
 ;;=E10.621^^7^83^80
 ;;^UTILITY(U,$J,358.3,2723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2723,1,3,0)
 ;;=3^Foot ulcer, diabetic, type I
 ;;^UTILITY(U,$J,358.3,2723,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,2723,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,2724,0)
 ;;=K29.70^^7^83^86
 ;;^UTILITY(U,$J,358.3,2724,1,0)
 ;;=^358.31IA^4^2
