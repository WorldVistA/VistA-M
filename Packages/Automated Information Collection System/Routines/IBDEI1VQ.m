IBDEI1VQ ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33065,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavrl Disturb
 ;;^UTILITY(U,$J,358.3,33065,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,33065,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,33066,0)
 ;;=F02.81^^182^1996^10
 ;;^UTILITY(U,$J,358.3,33066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33066,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavrl Disturb
 ;;^UTILITY(U,$J,358.3,33066,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,33066,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,33067,0)
 ;;=F20.3^^182^1996^26
 ;;^UTILITY(U,$J,358.3,33067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33067,1,3,0)
 ;;=3^Undifferentiated Schizophrenia
 ;;^UTILITY(U,$J,358.3,33067,1,4,0)
 ;;=4^F20.3
 ;;^UTILITY(U,$J,358.3,33067,2)
 ;;=^5003472
 ;;^UTILITY(U,$J,358.3,33068,0)
 ;;=F20.9^^182^1996^23
 ;;^UTILITY(U,$J,358.3,33068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33068,1,3,0)
 ;;=3^Schizophrenia,Unspec
 ;;^UTILITY(U,$J,358.3,33068,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,33068,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,33069,0)
 ;;=F31.9^^182^1996^6
 ;;^UTILITY(U,$J,358.3,33069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33069,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33069,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,33069,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,33070,0)
 ;;=F31.72^^182^1996^7
 ;;^UTILITY(U,$J,358.3,33070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33070,1,3,0)
 ;;=3^Bipolr Disorder,Full Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,33070,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,33070,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,33071,0)
 ;;=F31.71^^182^1996^5
 ;;^UTILITY(U,$J,358.3,33071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33071,1,3,0)
 ;;=3^Bipolar Disorder,Part Remis,Most Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,33071,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,33071,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,33072,0)
 ;;=F31.70^^182^1996^4
 ;;^UTILITY(U,$J,358.3,33072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33072,1,3,0)
 ;;=3^Bipolar Disorder,In Remis,Most Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,33072,1,4,0)
 ;;=4^F31.70
 ;;^UTILITY(U,$J,358.3,33072,2)
 ;;=^5003510
 ;;^UTILITY(U,$J,358.3,33073,0)
 ;;=F29.^^182^1996^21
 ;;^UTILITY(U,$J,358.3,33073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33073,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Unspec
 ;;^UTILITY(U,$J,358.3,33073,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,33073,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,33074,0)
 ;;=F28.^^182^1996^22
 ;;^UTILITY(U,$J,358.3,33074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33074,1,3,0)
 ;;=3^Psychosis not d/t Substance/Known Physiol Cond,Oth
 ;;^UTILITY(U,$J,358.3,33074,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,33074,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,33075,0)
 ;;=F41.9^^182^1996^3
 ;;^UTILITY(U,$J,358.3,33075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33075,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,33075,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,33075,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,33076,0)
 ;;=F42.^^182^1996^15
 ;;^UTILITY(U,$J,358.3,33076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33076,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,33076,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,33076,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,33077,0)
 ;;=F45.0^^182^1996^24
 ;;^UTILITY(U,$J,358.3,33077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33077,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,33077,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,33077,2)
 ;;=^112280
