IBDEI1H5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23580,1,3,0)
 ;;=3^Colitis,C. Difficile,Recurrent
 ;;^UTILITY(U,$J,358.3,23580,1,4,0)
 ;;=4^A04.71
 ;;^UTILITY(U,$J,358.3,23580,2)
 ;;=^5151291
 ;;^UTILITY(U,$J,358.3,23581,0)
 ;;=A04.72^^105^1174^25
 ;;^UTILITY(U,$J,358.3,23581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23581,1,3,0)
 ;;=3^Colitis,C. Difficile,Not Spec as Recurrent
 ;;^UTILITY(U,$J,358.3,23581,1,4,0)
 ;;=4^A04.72
 ;;^UTILITY(U,$J,358.3,23581,2)
 ;;=^5151292
 ;;^UTILITY(U,$J,358.3,23582,0)
 ;;=T81.40XD^^105^1174^66
 ;;^UTILITY(U,$J,358.3,23582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23582,1,3,0)
 ;;=3^Infect Following Proced,Unspec,Subs
 ;;^UTILITY(U,$J,358.3,23582,1,4,0)
 ;;=4^T81.40XD
 ;;^UTILITY(U,$J,358.3,23582,2)
 ;;=^5157585
 ;;^UTILITY(U,$J,358.3,23583,0)
 ;;=T81.40XS^^105^1174^65
 ;;^UTILITY(U,$J,358.3,23583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23583,1,3,0)
 ;;=3^Infect Following Proced,Unspec,Sequela
 ;;^UTILITY(U,$J,358.3,23583,1,4,0)
 ;;=4^T81.40XS
 ;;^UTILITY(U,$J,358.3,23583,2)
 ;;=^5157586
 ;;^UTILITY(U,$J,358.3,23584,0)
 ;;=T81.41XA^^105^1174^60
 ;;^UTILITY(U,$J,358.3,23584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23584,1,3,0)
 ;;=3^Infect Following Proced,Superfic Incis Surg Site,Init
 ;;^UTILITY(U,$J,358.3,23584,1,4,0)
 ;;=4^T81.41XA
 ;;^UTILITY(U,$J,358.3,23584,2)
 ;;=^5157587
 ;;^UTILITY(U,$J,358.3,23585,0)
 ;;=T81.41XD^^105^1174^61
 ;;^UTILITY(U,$J,358.3,23585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23585,1,3,0)
 ;;=3^Infect Following Proced,Superfic Incis Surg Site,Subs
 ;;^UTILITY(U,$J,358.3,23585,1,4,0)
 ;;=4^T81.41XD
 ;;^UTILITY(U,$J,358.3,23585,2)
 ;;=^5157588
 ;;^UTILITY(U,$J,358.3,23586,0)
 ;;=T81.42XD^^105^1174^52
 ;;^UTILITY(U,$J,358.3,23586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23586,1,3,0)
 ;;=3^Infect Following Proced,Deep Incis Surg Site,Subs
 ;;^UTILITY(U,$J,358.3,23586,1,4,0)
 ;;=4^T81.42XD
 ;;^UTILITY(U,$J,358.3,23586,2)
 ;;=^5157591
 ;;^UTILITY(U,$J,358.3,23587,0)
 ;;=T81.42XA^^105^1174^51
 ;;^UTILITY(U,$J,358.3,23587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23587,1,3,0)
 ;;=3^Infect Following Proced,Deep Incis Surg Site,Init
 ;;^UTILITY(U,$J,358.3,23587,1,4,0)
 ;;=4^T81.42XA
 ;;^UTILITY(U,$J,358.3,23587,2)
 ;;=^5157590
 ;;^UTILITY(U,$J,358.3,23588,0)
 ;;=T81.42XS^^105^1174^53
 ;;^UTILITY(U,$J,358.3,23588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23588,1,3,0)
 ;;=3^Infect Following Proced,Deep Incis Surg Site,Sequela
 ;;^UTILITY(U,$J,358.3,23588,1,4,0)
 ;;=4^T81.42XS
 ;;^UTILITY(U,$J,358.3,23588,2)
 ;;=^5157592
 ;;^UTILITY(U,$J,358.3,23589,0)
 ;;=T81.43XA^^105^1174^54
 ;;^UTILITY(U,$J,358.3,23589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23589,1,3,0)
 ;;=3^Infect Following Proced,Organ/Space Surg Site,Init
 ;;^UTILITY(U,$J,358.3,23589,1,4,0)
 ;;=4^T81.43XA
 ;;^UTILITY(U,$J,358.3,23589,2)
 ;;=^5157593
 ;;^UTILITY(U,$J,358.3,23590,0)
 ;;=T81.43XD^^105^1174^55
 ;;^UTILITY(U,$J,358.3,23590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23590,1,3,0)
 ;;=3^Infect Following Proced,Organ/Space Surg Site,Subs
 ;;^UTILITY(U,$J,358.3,23590,1,4,0)
 ;;=4^T81.43XD
 ;;^UTILITY(U,$J,358.3,23590,2)
 ;;=^5157594
 ;;^UTILITY(U,$J,358.3,23591,0)
 ;;=T81.43XS^^105^1174^56
 ;;^UTILITY(U,$J,358.3,23591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23591,1,3,0)
 ;;=3^Infect Following Proced,Organ/Space Surg Site,Sequela
 ;;^UTILITY(U,$J,358.3,23591,1,4,0)
 ;;=4^T81.43XS
