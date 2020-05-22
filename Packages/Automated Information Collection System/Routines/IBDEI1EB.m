IBDEI1EB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22321,0)
 ;;=I38.^^102^1141^77
 ;;^UTILITY(U,$J,358.3,22321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22321,1,3,0)
 ;;=3^Endocarditis
 ;;^UTILITY(U,$J,358.3,22321,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,22321,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,22322,0)
 ;;=T82.6XXA^^102^1141^78
 ;;^UTILITY(U,$J,358.3,22322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22322,1,3,0)
 ;;=3^Endocarditis, prosthetic valve
 ;;^UTILITY(U,$J,358.3,22322,1,4,0)
 ;;=4^T82.6XXA
 ;;^UTILITY(U,$J,358.3,22322,2)
 ;;=^5054908
 ;;^UTILITY(U,$J,358.3,22323,0)
 ;;=N45.1^^102^1141^83
 ;;^UTILITY(U,$J,358.3,22323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22323,1,3,0)
 ;;=3^Epididymitis
 ;;^UTILITY(U,$J,358.3,22323,1,4,0)
 ;;=4^N45.1
 ;;^UTILITY(U,$J,358.3,22323,2)
 ;;=^41396
 ;;^UTILITY(U,$J,358.3,22324,0)
 ;;=B27.00^^102^1141^85
 ;;^UTILITY(U,$J,358.3,22324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22324,1,3,0)
 ;;=3^Epstein-Barr virus infection
 ;;^UTILITY(U,$J,358.3,22324,1,4,0)
 ;;=4^B27.00
 ;;^UTILITY(U,$J,358.3,22324,2)
 ;;=^5000566
 ;;^UTILITY(U,$J,358.3,22325,0)
 ;;=R50.9^^102^1141^90
 ;;^UTILITY(U,$J,358.3,22325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22325,1,3,0)
 ;;=3^Fever, unspecified
 ;;^UTILITY(U,$J,358.3,22325,1,4,0)
 ;;=4^R50.9
 ;;^UTILITY(U,$J,358.3,22325,2)
 ;;=^5019512
 ;;^UTILITY(U,$J,358.3,22326,0)
 ;;=M79.7^^102^1141^91
 ;;^UTILITY(U,$J,358.3,22326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22326,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,22326,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,22326,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,22327,0)
 ;;=L97.519^^102^1141^97
 ;;^UTILITY(U,$J,358.3,22327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22327,1,3,0)
 ;;=3^Foot ulcer,non-pressure,chr,oth prt right foot,unsp severity
 ;;^UTILITY(U,$J,358.3,22327,1,4,0)
 ;;=4^L97.519
 ;;^UTILITY(U,$J,358.3,22327,2)
 ;;=^5009549
 ;;^UTILITY(U,$J,358.3,22328,0)
 ;;=L97.529^^102^1141^96
 ;;^UTILITY(U,$J,358.3,22328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22328,1,3,0)
 ;;=3^Foot ulcer,non-pressure,chr,oth prt left foot,unsp severity
 ;;^UTILITY(U,$J,358.3,22328,1,4,0)
 ;;=4^L97.529
 ;;^UTILITY(U,$J,358.3,22328,2)
 ;;=^5009554
 ;;^UTILITY(U,$J,358.3,22329,0)
 ;;=L97.419^^102^1141^95
 ;;^UTILITY(U,$J,358.3,22329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22329,1,3,0)
 ;;=3^Foot ulcer,non-pressure,chr right heel/midfoot,unsp severity
 ;;^UTILITY(U,$J,358.3,22329,1,4,0)
 ;;=4^L97.419
 ;;^UTILITY(U,$J,358.3,22329,2)
 ;;=^5009534
 ;;^UTILITY(U,$J,358.3,22330,0)
 ;;=L97.429^^102^1141^94
 ;;^UTILITY(U,$J,358.3,22330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22330,1,3,0)
 ;;=3^Foot ulcer,non-pressure,chr left heel/midfoot,unsp severity
 ;;^UTILITY(U,$J,358.3,22330,1,4,0)
 ;;=4^L97.429
 ;;^UTILITY(U,$J,358.3,22330,2)
 ;;=^5009539
 ;;^UTILITY(U,$J,358.3,22331,0)
 ;;=E11.621^^102^1141^93
 ;;^UTILITY(U,$J,358.3,22331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22331,1,3,0)
 ;;=3^Foot ulcer, diabetic, type II
 ;;^UTILITY(U,$J,358.3,22331,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,22331,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,22332,0)
 ;;=E10.621^^102^1141^92
 ;;^UTILITY(U,$J,358.3,22332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22332,1,3,0)
 ;;=3^Foot ulcer, diabetic, type I
 ;;^UTILITY(U,$J,358.3,22332,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,22332,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,22333,0)
 ;;=K29.70^^102^1141^98
