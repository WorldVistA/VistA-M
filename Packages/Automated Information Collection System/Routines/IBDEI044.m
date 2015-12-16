IBDEI044 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1396,1,4,0)
 ;;=4^J01.90
 ;;^UTILITY(U,$J,358.3,1396,2)
 ;;=^5008127
 ;;^UTILITY(U,$J,358.3,1397,0)
 ;;=J02.9^^3^41^20
 ;;^UTILITY(U,$J,358.3,1397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1397,1,3,0)
 ;;=3^Acute pharyngitis, unspecified
 ;;^UTILITY(U,$J,358.3,1397,1,4,0)
 ;;=4^J02.9
 ;;^UTILITY(U,$J,358.3,1397,2)
 ;;=^5008130
 ;;^UTILITY(U,$J,358.3,1398,0)
 ;;=J03.90^^3^41^22
 ;;^UTILITY(U,$J,358.3,1398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1398,1,3,0)
 ;;=3^Acute tonsillitis, unspecified
 ;;^UTILITY(U,$J,358.3,1398,1,4,0)
 ;;=4^J03.90
 ;;^UTILITY(U,$J,358.3,1398,2)
 ;;=^5008135
 ;;^UTILITY(U,$J,358.3,1399,0)
 ;;=J04.0^^3^41^7
 ;;^UTILITY(U,$J,358.3,1399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1399,1,3,0)
 ;;=3^Acute laryngitis
 ;;^UTILITY(U,$J,358.3,1399,1,4,0)
 ;;=4^J04.0
 ;;^UTILITY(U,$J,358.3,1399,2)
 ;;=^5008137
 ;;^UTILITY(U,$J,358.3,1400,0)
 ;;=J06.9^^3^41^23
 ;;^UTILITY(U,$J,358.3,1400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1400,1,3,0)
 ;;=3^Acute upper respiratory infection, unspecified
 ;;^UTILITY(U,$J,358.3,1400,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,1400,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,1401,0)
 ;;=J20.9^^3^41^4
 ;;^UTILITY(U,$J,358.3,1401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1401,1,3,0)
 ;;=3^Acute bronchitis, unspecified
 ;;^UTILITY(U,$J,358.3,1401,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,1401,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,1402,0)
 ;;=J32.9^^3^41^46
 ;;^UTILITY(U,$J,358.3,1402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1402,1,3,0)
 ;;=3^Chronic sinusitis, unspecified
 ;;^UTILITY(U,$J,358.3,1402,1,4,0)
 ;;=4^J32.9
 ;;^UTILITY(U,$J,358.3,1402,2)
 ;;=^5008207
 ;;^UTILITY(U,$J,358.3,1403,0)
 ;;=J18.9^^3^41^90
 ;;^UTILITY(U,$J,358.3,1403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1403,1,3,0)
 ;;=3^Pneumonia, unspecified organism
 ;;^UTILITY(U,$J,358.3,1403,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,1403,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,1404,0)
 ;;=J12.9^^3^41^109
 ;;^UTILITY(U,$J,358.3,1404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1404,1,3,0)
 ;;=3^Viral pneumonia, unspecified
 ;;^UTILITY(U,$J,358.3,1404,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,1404,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,1405,0)
 ;;=J11.00^^3^41^62
 ;;^UTILITY(U,$J,358.3,1405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1405,1,3,0)
 ;;=3^Flu d/t unidentified flu virus w unsp type of pneumonia
 ;;^UTILITY(U,$J,358.3,1405,1,4,0)
 ;;=4^J11.00
 ;;^UTILITY(U,$J,358.3,1405,2)
 ;;=^5008156
 ;;^UTILITY(U,$J,358.3,1406,0)
 ;;=J10.1^^3^41^61
 ;;^UTILITY(U,$J,358.3,1406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1406,1,3,0)
 ;;=3^Flu d/t oth ident influenza virus w oth resp manifest
 ;;^UTILITY(U,$J,358.3,1406,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,1406,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,1407,0)
 ;;=J11.1^^3^41^63
 ;;^UTILITY(U,$J,358.3,1407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1407,1,3,0)
 ;;=3^Flu d/t unidentified influenza virus w oth resp manifest
 ;;^UTILITY(U,$J,358.3,1407,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,1407,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,1408,0)
 ;;=K52.9^^3^41^81
 ;;^UTILITY(U,$J,358.3,1408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1408,1,3,0)
 ;;=3^Noninfective gastroenteritis and colitis, unspecified
 ;;^UTILITY(U,$J,358.3,1408,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,1408,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,1409,0)
 ;;=K57.32^^3^41^55
 ;;^UTILITY(U,$J,358.3,1409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1409,1,3,0)
 ;;=3^Dvtrcli of lg int w/o perforation or abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,1409,1,4,0)
 ;;=4^K57.32
