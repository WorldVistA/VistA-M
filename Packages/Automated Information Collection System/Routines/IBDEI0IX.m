IBDEI0IX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8508,1,3,0)
 ;;=3^Endocarditis, valve unspecified
 ;;^UTILITY(U,$J,358.3,8508,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,8508,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,8509,0)
 ;;=J00.^^55^540^19
 ;;^UTILITY(U,$J,358.3,8509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8509,1,3,0)
 ;;=3^Acute nasopharyngitis [common cold]
 ;;^UTILITY(U,$J,358.3,8509,1,4,0)
 ;;=4^J00.
 ;;^UTILITY(U,$J,358.3,8509,2)
 ;;=^5008115
 ;;^UTILITY(U,$J,358.3,8510,0)
 ;;=J01.90^^55^540^21
 ;;^UTILITY(U,$J,358.3,8510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8510,1,3,0)
 ;;=3^Acute sinusitis, unspecified
 ;;^UTILITY(U,$J,358.3,8510,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,8510,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,8511,0)
 ;;=J02.9^^55^540^20
 ;;^UTILITY(U,$J,358.3,8511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8511,1,3,0)
 ;;=3^Acute pharyngitis, unspecified
 ;;^UTILITY(U,$J,358.3,8511,1,4,0)
 ;;=4^J02.9
 ;;^UTILITY(U,$J,358.3,8511,2)
 ;;=^5008130
 ;;^UTILITY(U,$J,358.3,8512,0)
 ;;=J03.90^^55^540^22
 ;;^UTILITY(U,$J,358.3,8512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8512,1,3,0)
 ;;=3^Acute tonsillitis, unspecified
 ;;^UTILITY(U,$J,358.3,8512,1,4,0)
 ;;=4^J03.90
 ;;^UTILITY(U,$J,358.3,8512,2)
 ;;=^5008135
 ;;^UTILITY(U,$J,358.3,8513,0)
 ;;=J04.0^^55^540^7
 ;;^UTILITY(U,$J,358.3,8513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8513,1,3,0)
 ;;=3^Acute laryngitis
 ;;^UTILITY(U,$J,358.3,8513,1,4,0)
 ;;=4^J04.0
 ;;^UTILITY(U,$J,358.3,8513,2)
 ;;=^5008137
 ;;^UTILITY(U,$J,358.3,8514,0)
 ;;=J06.9^^55^540^23
 ;;^UTILITY(U,$J,358.3,8514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8514,1,3,0)
 ;;=3^Acute upper respiratory infection, unspecified
 ;;^UTILITY(U,$J,358.3,8514,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,8514,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,8515,0)
 ;;=J20.9^^55^540^4
 ;;^UTILITY(U,$J,358.3,8515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8515,1,3,0)
 ;;=3^Acute bronchitis, unspecified
 ;;^UTILITY(U,$J,358.3,8515,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,8515,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,8516,0)
 ;;=J32.9^^55^540^46
 ;;^UTILITY(U,$J,358.3,8516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8516,1,3,0)
 ;;=3^Chronic sinusitis, unspecified
 ;;^UTILITY(U,$J,358.3,8516,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,8516,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,8517,0)
 ;;=J18.9^^55^540^90
 ;;^UTILITY(U,$J,358.3,8517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8517,1,3,0)
 ;;=3^Pneumonia, unspecified organism
 ;;^UTILITY(U,$J,358.3,8517,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,8517,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,8518,0)
 ;;=J12.9^^55^540^109
 ;;^UTILITY(U,$J,358.3,8518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8518,1,3,0)
 ;;=3^Viral pneumonia, unspecified
 ;;^UTILITY(U,$J,358.3,8518,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,8518,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,8519,0)
 ;;=J11.00^^55^540^62
 ;;^UTILITY(U,$J,358.3,8519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8519,1,3,0)
 ;;=3^Flu d/t unidentified flu virus w unsp type of pneumonia
 ;;^UTILITY(U,$J,358.3,8519,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,8519,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,8520,0)
 ;;=J10.1^^55^540^61
 ;;^UTILITY(U,$J,358.3,8520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8520,1,3,0)
 ;;=3^Flu d/t oth ident influenza virus w oth resp manifest
 ;;^UTILITY(U,$J,358.3,8520,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,8520,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,8521,0)
 ;;=J11.1^^55^540^63
 ;;^UTILITY(U,$J,358.3,8521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8521,1,3,0)
 ;;=3^Flu d/t unidentified influenza virus w oth resp manifest
