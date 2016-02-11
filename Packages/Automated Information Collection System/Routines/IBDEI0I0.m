IBDEI0I0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8071,1,3,0)
 ;;=3^Acute maxillary sinusitis, unspecified
 ;;^UTILITY(U,$J,358.3,8071,1,4,0)
 ;;=4^J01.00
 ;;^UTILITY(U,$J,358.3,8071,2)
 ;;=^5008116
 ;;^UTILITY(U,$J,358.3,8072,0)
 ;;=J01.10^^55^534^2
 ;;^UTILITY(U,$J,358.3,8072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8072,1,3,0)
 ;;=3^Acute frontal sinusitis, unspecified
 ;;^UTILITY(U,$J,358.3,8072,1,4,0)
 ;;=4^J01.10
 ;;^UTILITY(U,$J,358.3,8072,2)
 ;;=^5008118
 ;;^UTILITY(U,$J,358.3,8073,0)
 ;;=J01.90^^55^534^12
 ;;^UTILITY(U,$J,358.3,8073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8073,1,3,0)
 ;;=3^Acute sinusitis, unspecified
 ;;^UTILITY(U,$J,358.3,8073,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,8073,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,8074,0)
 ;;=J02.9^^55^534^8
 ;;^UTILITY(U,$J,358.3,8074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8074,1,3,0)
 ;;=3^Acute pharyngitis, unspecified
 ;;^UTILITY(U,$J,358.3,8074,1,4,0)
 ;;=4^J02.9
 ;;^UTILITY(U,$J,358.3,8074,2)
 ;;=^5008130
 ;;^UTILITY(U,$J,358.3,8075,0)
 ;;=J03.90^^55^534^17
 ;;^UTILITY(U,$J,358.3,8075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8075,1,3,0)
 ;;=3^Acute tonsillitis, unspecified
 ;;^UTILITY(U,$J,358.3,8075,1,4,0)
 ;;=4^J03.90
 ;;^UTILITY(U,$J,358.3,8075,2)
 ;;=^5008135
 ;;^UTILITY(U,$J,358.3,8076,0)
 ;;=J04.0^^55^534^4
 ;;^UTILITY(U,$J,358.3,8076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8076,1,3,0)
 ;;=3^Acute laryngitis
 ;;^UTILITY(U,$J,358.3,8076,1,4,0)
 ;;=4^J04.0
 ;;^UTILITY(U,$J,358.3,8076,2)
 ;;=^5008137
 ;;^UTILITY(U,$J,358.3,8077,0)
 ;;=J06.0^^55^534^5
 ;;^UTILITY(U,$J,358.3,8077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8077,1,3,0)
 ;;=3^Acute laryngopharyngitis
 ;;^UTILITY(U,$J,358.3,8077,1,4,0)
 ;;=4^J06.0
 ;;^UTILITY(U,$J,358.3,8077,2)
 ;;=^269876
 ;;^UTILITY(U,$J,358.3,8078,0)
 ;;=J06.9^^55^534^18
 ;;^UTILITY(U,$J,358.3,8078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8078,1,3,0)
 ;;=3^Acute upper respiratory infection, unspecified
 ;;^UTILITY(U,$J,358.3,8078,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,8078,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,8079,0)
 ;;=J34.2^^55^534^57
 ;;^UTILITY(U,$J,358.3,8079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8079,1,3,0)
 ;;=3^Deviated nasal septum
 ;;^UTILITY(U,$J,358.3,8079,1,4,0)
 ;;=4^J34.2
 ;;^UTILITY(U,$J,358.3,8079,2)
 ;;=^259087
 ;;^UTILITY(U,$J,358.3,8080,0)
 ;;=J33.9^^55^534^96
 ;;^UTILITY(U,$J,358.3,8080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8080,1,3,0)
 ;;=3^Nasal polyp, unspecified
 ;;^UTILITY(U,$J,358.3,8080,1,4,0)
 ;;=4^J33.9
 ;;^UTILITY(U,$J,358.3,8080,2)
 ;;=^5008208
 ;;^UTILITY(U,$J,358.3,8081,0)
 ;;=J31.0^^55^534^45
 ;;^UTILITY(U,$J,358.3,8081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8081,1,3,0)
 ;;=3^Chronic rhinitis
 ;;^UTILITY(U,$J,358.3,8081,1,4,0)
 ;;=4^J31.0
 ;;^UTILITY(U,$J,358.3,8081,2)
 ;;=^24434
 ;;^UTILITY(U,$J,358.3,8082,0)
 ;;=J32.0^^55^534^44
 ;;^UTILITY(U,$J,358.3,8082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8082,1,3,0)
 ;;=3^Chronic maxillary sinusitis
 ;;^UTILITY(U,$J,358.3,8082,1,4,0)
 ;;=4^J32.0
 ;;^UTILITY(U,$J,358.3,8082,2)
 ;;=^24407
 ;;^UTILITY(U,$J,358.3,8083,0)
 ;;=J32.1^^55^534^41
 ;;^UTILITY(U,$J,358.3,8083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8083,1,3,0)
 ;;=3^Chronic frontal sinusitis
 ;;^UTILITY(U,$J,358.3,8083,1,4,0)
 ;;=4^J32.1
 ;;^UTILITY(U,$J,358.3,8083,2)
 ;;=^24380
 ;;^UTILITY(U,$J,358.3,8084,0)
 ;;=J32.9^^55^534^49
 ;;^UTILITY(U,$J,358.3,8084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8084,1,3,0)
 ;;=3^Chronic sinusitis, unspecified
 ;;^UTILITY(U,$J,358.3,8084,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,8084,2)
 ;;=^5008207
