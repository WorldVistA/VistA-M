IBDEI37K ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53894,1,3,0)
 ;;=3^Enterocolitis due to Clostridium difficile
 ;;^UTILITY(U,$J,358.3,53894,1,4,0)
 ;;=4^A04.7
 ;;^UTILITY(U,$J,358.3,53894,2)
 ;;=^5000029
 ;;^UTILITY(U,$J,358.3,53895,0)
 ;;=R73.09^^253^2727^3
 ;;^UTILITY(U,$J,358.3,53895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53895,1,3,0)
 ;;=3^Abnormal glucose NEC
 ;;^UTILITY(U,$J,358.3,53895,1,4,0)
 ;;=4^R73.09
 ;;^UTILITY(U,$J,358.3,53895,2)
 ;;=^5019563
 ;;^UTILITY(U,$J,358.3,53896,0)
 ;;=R80.9^^253^2727^39
 ;;^UTILITY(U,$J,358.3,53896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53896,1,3,0)
 ;;=3^Proteinuria, unspecified
 ;;^UTILITY(U,$J,358.3,53896,1,4,0)
 ;;=4^R80.9
 ;;^UTILITY(U,$J,358.3,53896,2)
 ;;=^5019599
 ;;^UTILITY(U,$J,358.3,53897,0)
 ;;=R94.5^^253^2727^4
 ;;^UTILITY(U,$J,358.3,53897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53897,1,3,0)
 ;;=3^Abnormal results of liver function studies
 ;;^UTILITY(U,$J,358.3,53897,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,53897,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,53898,0)
 ;;=Z55.9^^253^2727^36
 ;;^UTILITY(U,$J,358.3,53898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53898,1,3,0)
 ;;=3^Problems related to education and literacy, unspecified
 ;;^UTILITY(U,$J,358.3,53898,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,53898,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,53899,0)
 ;;=Z76.82^^253^2727^10
 ;;^UTILITY(U,$J,358.3,53899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53899,1,3,0)
 ;;=3^Awaiting organ transplant status
 ;;^UTILITY(U,$J,358.3,53899,1,4,0)
 ;;=4^Z76.82
 ;;^UTILITY(U,$J,358.3,53899,2)
 ;;=^331582
 ;;^UTILITY(U,$J,358.3,53900,0)
 ;;=T81.30XA^^253^2728^25
 ;;^UTILITY(U,$J,358.3,53900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53900,1,3,0)
 ;;=3^Disruption of wound, unspecified, initial encounter
 ;;^UTILITY(U,$J,358.3,53900,1,4,0)
 ;;=4^T81.30XA
 ;;^UTILITY(U,$J,358.3,53900,2)
 ;;=^5054467
 ;;^UTILITY(U,$J,358.3,53901,0)
 ;;=T81.30XD^^253^2728^27
 ;;^UTILITY(U,$J,358.3,53901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53901,1,3,0)
 ;;=3^Disruption of wound, unspecified, subsequent encounter
 ;;^UTILITY(U,$J,358.3,53901,1,4,0)
 ;;=4^T81.30XD
 ;;^UTILITY(U,$J,358.3,53901,2)
 ;;=^5054468
 ;;^UTILITY(U,$J,358.3,53902,0)
 ;;=T81.30XS^^253^2728^26
 ;;^UTILITY(U,$J,358.3,53902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53902,1,3,0)
 ;;=3^Disruption of wound, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,53902,1,4,0)
 ;;=4^T81.30XS
 ;;^UTILITY(U,$J,358.3,53902,2)
 ;;=^5054469
 ;;^UTILITY(U,$J,358.3,53903,0)
 ;;=T81.31XA^^253^2728^16
 ;;^UTILITY(U,$J,358.3,53903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53903,1,3,0)
 ;;=3^Disruption of external surgical wound, NEC, init
 ;;^UTILITY(U,$J,358.3,53903,1,4,0)
 ;;=4^T81.31XA
 ;;^UTILITY(U,$J,358.3,53903,2)
 ;;=^5054470
 ;;^UTILITY(U,$J,358.3,53904,0)
 ;;=T81.31XD^^253^2728^17
 ;;^UTILITY(U,$J,358.3,53904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53904,1,3,0)
 ;;=3^Disruption of external surgical wound, NEC, subs
 ;;^UTILITY(U,$J,358.3,53904,1,4,0)
 ;;=4^T81.31XD
 ;;^UTILITY(U,$J,358.3,53904,2)
 ;;=^5054471
 ;;^UTILITY(U,$J,358.3,53905,0)
 ;;=T81.31XS^^253^2728^18
 ;;^UTILITY(U,$J,358.3,53905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53905,1,3,0)
 ;;=3^Disruption of external surgical wound, NEC, sequela
 ;;^UTILITY(U,$J,358.3,53905,1,4,0)
 ;;=4^T81.31XS
 ;;^UTILITY(U,$J,358.3,53905,2)
 ;;=^5054472
 ;;^UTILITY(U,$J,358.3,53906,0)
 ;;=T81.32XA^^253^2728^19
 ;;^UTILITY(U,$J,358.3,53906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53906,1,3,0)
 ;;=3^Disruption of internal surgical wound, NEC, init
