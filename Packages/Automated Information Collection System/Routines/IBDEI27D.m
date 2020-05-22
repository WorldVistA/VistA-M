IBDEI27D ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35176,1,4,0)
 ;;=4^S02.413S
 ;;^UTILITY(U,$J,358.3,35176,2)
 ;;=^5020353
 ;;^UTILITY(U,$J,358.3,35177,0)
 ;;=S02.400S^^137^1797^39
 ;;^UTILITY(U,$J,358.3,35177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35177,1,3,0)
 ;;=3^Malar fracture unspecified, sequela
 ;;^UTILITY(U,$J,358.3,35177,1,4,0)
 ;;=4^S02.400S
 ;;^UTILITY(U,$J,358.3,35177,2)
 ;;=^5020323
 ;;^UTILITY(U,$J,358.3,35178,0)
 ;;=S02.401S^^137^1797^40
 ;;^UTILITY(U,$J,358.3,35178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35178,1,3,0)
 ;;=3^Maxillary fracture, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,35178,1,4,0)
 ;;=4^S02.401S
 ;;^UTILITY(U,$J,358.3,35178,2)
 ;;=^5020329
 ;;^UTILITY(U,$J,358.3,35179,0)
 ;;=S02.113S^^137^1797^19
 ;;^UTILITY(U,$J,358.3,35179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35179,1,3,0)
 ;;=3^Fx,Occipital condyle unspec, sequela
 ;;^UTILITY(U,$J,358.3,35179,1,4,0)
 ;;=4^S02.113S
 ;;^UTILITY(U,$J,358.3,35179,2)
 ;;=^5020287
 ;;^UTILITY(U,$J,358.3,35180,0)
 ;;=S02.110S^^137^1797^44
 ;;^UTILITY(U,$J,358.3,35180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35180,1,3,0)
 ;;=3^Type I occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,35180,1,4,0)
 ;;=4^S02.110S
 ;;^UTILITY(U,$J,358.3,35180,2)
 ;;=^5020269
 ;;^UTILITY(U,$J,358.3,35181,0)
 ;;=S02.111S^^137^1797^45
 ;;^UTILITY(U,$J,358.3,35181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35181,1,3,0)
 ;;=3^Type II occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,35181,1,4,0)
 ;;=4^S02.111S
 ;;^UTILITY(U,$J,358.3,35181,2)
 ;;=^5020275
 ;;^UTILITY(U,$J,358.3,35182,0)
 ;;=S02.112S^^137^1797^46
 ;;^UTILITY(U,$J,358.3,35182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35182,1,3,0)
 ;;=3^Type III occipital condyle fracture, sequela
 ;;^UTILITY(U,$J,358.3,35182,1,4,0)
 ;;=4^S02.112S
 ;;^UTILITY(U,$J,358.3,35182,2)
 ;;=^5020281
 ;;^UTILITY(U,$J,358.3,35183,0)
 ;;=S02.402S^^137^1797^47
 ;;^UTILITY(U,$J,358.3,35183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35183,1,3,0)
 ;;=3^Zygomatic fracture, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,35183,1,4,0)
 ;;=4^S02.402S
 ;;^UTILITY(U,$J,358.3,35183,2)
 ;;=^5020335
 ;;^UTILITY(U,$J,358.3,35184,0)
 ;;=F10.20^^137^1798^1
 ;;^UTILITY(U,$J,358.3,35184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35184,1,3,0)
 ;;=3^Alcohol dependence, uncomplicated
 ;;^UTILITY(U,$J,358.3,35184,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,35184,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,35185,0)
 ;;=F31.10^^137^1798^2
 ;;^UTILITY(U,$J,358.3,35185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35185,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unsp
 ;;^UTILITY(U,$J,358.3,35185,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,35185,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,35186,0)
 ;;=F32.9^^137^1798^5
 ;;^UTILITY(U,$J,358.3,35186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35186,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,35186,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,35186,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,35187,0)
 ;;=F20.0^^137^1798^6
 ;;^UTILITY(U,$J,358.3,35187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35187,1,3,0)
 ;;=3^Paranoid schizophrenia
 ;;^UTILITY(U,$J,358.3,35187,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,35187,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,35188,0)
 ;;=F06.0^^137^1798^7
 ;;^UTILITY(U,$J,358.3,35188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35188,1,3,0)
 ;;=3^Psychotic disorder w hallucin due to known physiol condition
