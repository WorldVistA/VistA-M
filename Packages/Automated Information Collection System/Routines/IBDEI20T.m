IBDEI20T ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35325,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,35325,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,35326,0)
 ;;=F80.0^^186^2032^7
 ;;^UTILITY(U,$J,358.3,35326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35326,1,3,0)
 ;;=3^Phonological disorder
 ;;^UTILITY(U,$J,358.3,35326,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,35326,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,35327,0)
 ;;=F82.^^186^2032^5
 ;;^UTILITY(U,$J,358.3,35327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35327,1,3,0)
 ;;=3^Motor Function Development Disorder NEC
 ;;^UTILITY(U,$J,358.3,35327,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,35327,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,35328,0)
 ;;=F81.0^^186^2032^9
 ;;^UTILITY(U,$J,358.3,35328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35328,1,3,0)
 ;;=3^Reading Disorder NEC
 ;;^UTILITY(U,$J,358.3,35328,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,35328,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,35329,0)
 ;;=F80.4^^186^2032^10
 ;;^UTILITY(U,$J,358.3,35329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35329,1,3,0)
 ;;=3^Speech and language development delay due to hearing loss
 ;;^UTILITY(U,$J,358.3,35329,1,4,0)
 ;;=4^F80.4
 ;;^UTILITY(U,$J,358.3,35329,2)
 ;;=^5003675
 ;;^UTILITY(U,$J,358.3,35330,0)
 ;;=I69.020^^186^2033^3
 ;;^UTILITY(U,$J,358.3,35330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35330,1,3,0)
 ;;=3^Aphasia following nontraumatic subarachnoid hemorrhage
 ;;^UTILITY(U,$J,358.3,35330,1,4,0)
 ;;=4^I69.020
 ;;^UTILITY(U,$J,358.3,35330,2)
 ;;=^5007395
 ;;^UTILITY(U,$J,358.3,35331,0)
 ;;=I69.320^^186^2033^1
 ;;^UTILITY(U,$J,358.3,35331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35331,1,3,0)
 ;;=3^Aphasia following cerebral infarction
 ;;^UTILITY(U,$J,358.3,35331,1,4,0)
 ;;=4^I69.320
 ;;^UTILITY(U,$J,358.3,35331,2)
 ;;=^5007491
 ;;^UTILITY(U,$J,358.3,35332,0)
 ;;=I69.120^^186^2033^2
 ;;^UTILITY(U,$J,358.3,35332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35332,1,3,0)
 ;;=3^Aphasia following nontraumatic intracerebral hemorrhage
 ;;^UTILITY(U,$J,358.3,35332,1,4,0)
 ;;=4^I69.120
 ;;^UTILITY(U,$J,358.3,35332,2)
 ;;=^5007427
 ;;^UTILITY(U,$J,358.3,35333,0)
 ;;=I69.820^^186^2033^4
 ;;^UTILITY(U,$J,358.3,35333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35333,1,3,0)
 ;;=3^Aphasia following other cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,35333,1,4,0)
 ;;=4^I69.820
 ;;^UTILITY(U,$J,358.3,35333,2)
 ;;=^5007522
 ;;^UTILITY(U,$J,358.3,35334,0)
 ;;=I69.220^^186^2033^5
 ;;^UTILITY(U,$J,358.3,35334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35334,1,3,0)
 ;;=3^Aphasia following other nontraumatic intracranial hemorrhage
 ;;^UTILITY(U,$J,358.3,35334,1,4,0)
 ;;=4^I69.220
 ;;^UTILITY(U,$J,358.3,35334,2)
 ;;=^5007459
 ;;^UTILITY(U,$J,358.3,35335,0)
 ;;=I69.920^^186^2033^6
 ;;^UTILITY(U,$J,358.3,35335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35335,1,3,0)
 ;;=3^Aphasia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,35335,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,35335,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,35336,0)
 ;;=I69.390^^186^2033^7
 ;;^UTILITY(U,$J,358.3,35336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35336,1,3,0)
 ;;=3^Apraxia following cerebral infarction
 ;;^UTILITY(U,$J,358.3,35336,1,4,0)
 ;;=4^I69.390
 ;;^UTILITY(U,$J,358.3,35336,2)
 ;;=^5007515
 ;;^UTILITY(U,$J,358.3,35337,0)
 ;;=I69.190^^186^2033^8
 ;;^UTILITY(U,$J,358.3,35337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35337,1,3,0)
 ;;=3^Apraxia following nontraumatic intracerebral hemorrhage
 ;;^UTILITY(U,$J,358.3,35337,1,4,0)
 ;;=4^I69.190
 ;;^UTILITY(U,$J,358.3,35337,2)
 ;;=^5007452
