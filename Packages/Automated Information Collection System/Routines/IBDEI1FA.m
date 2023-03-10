IBDEI1FA ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23012,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,23012,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,23013,0)
 ;;=D75.89^^78^996^3
 ;;^UTILITY(U,$J,358.3,23013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23013,1,3,0)
 ;;=3^Blood & blood forming organ disease, oth spec
 ;;^UTILITY(U,$J,358.3,23013,1,4,0)
 ;;=4^D75.89
 ;;^UTILITY(U,$J,358.3,23013,2)
 ;;=^5002392
 ;;^UTILITY(U,$J,358.3,23014,0)
 ;;=D89.2^^78^996^16
 ;;^UTILITY(U,$J,358.3,23014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23014,1,3,0)
 ;;=3^Hypergammaglobulinemia, unspecified
 ;;^UTILITY(U,$J,358.3,23014,1,4,0)
 ;;=4^D89.2
 ;;^UTILITY(U,$J,358.3,23014,2)
 ;;=^5002455
 ;;^UTILITY(U,$J,358.3,23015,0)
 ;;=E03.9^^78^996^24
 ;;^UTILITY(U,$J,358.3,23015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23015,1,3,0)
 ;;=3^Hypothyroidism, unspecified
 ;;^UTILITY(U,$J,358.3,23015,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,23015,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,23016,0)
 ;;=E05.90^^78^996^30
 ;;^UTILITY(U,$J,358.3,23016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23016,1,3,0)
 ;;=3^Thyrotoxicosis w/o thyrotoxic crisis/storm
 ;;^UTILITY(U,$J,358.3,23016,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,23016,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,23017,0)
 ;;=E08.42^^78^996^10
 ;;^UTILITY(U,$J,358.3,23017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23017,1,3,0)
 ;;=3^DM d/t underlying condition w/ diabetic polyneuropathy
 ;;^UTILITY(U,$J,358.3,23017,1,4,0)
 ;;=4^E08.42
 ;;^UTILITY(U,$J,358.3,23017,2)
 ;;=^5002524
 ;;^UTILITY(U,$J,358.3,23018,0)
 ;;=E09.42^^78^996^11
 ;;^UTILITY(U,$J,358.3,23018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23018,1,3,0)
 ;;=3^DM drug-induced w/ neurological compl w/ diabetic polyneuropathy
 ;;^UTILITY(U,$J,358.3,23018,1,4,0)
 ;;=4^E09.42
 ;;^UTILITY(U,$J,358.3,23018,2)
 ;;=^5002566
 ;;^UTILITY(U,$J,358.3,23019,0)
 ;;=E10.42^^78^996^4
 ;;^UTILITY(U,$J,358.3,23019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23019,1,3,0)
 ;;=3^DM Type 1 w/ diabetic polyneuropathy
 ;;^UTILITY(U,$J,358.3,23019,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,23019,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,23020,0)
 ;;=E10.65^^78^996^5
 ;;^UTILITY(U,$J,358.3,23020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23020,1,3,0)
 ;;=3^DM Type 1 w/ hyperglycemia
 ;;^UTILITY(U,$J,358.3,23020,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,23020,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,23021,0)
 ;;=E10.9^^78^996^6
 ;;^UTILITY(U,$J,358.3,23021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23021,1,3,0)
 ;;=3^DM Type 1 w/o complications
 ;;^UTILITY(U,$J,358.3,23021,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,23021,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,23022,0)
 ;;=E11.42^^78^996^7
 ;;^UTILITY(U,$J,358.3,23022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23022,1,3,0)
 ;;=3^DM Type 2 w/ diabetic polyneuropathy
 ;;^UTILITY(U,$J,358.3,23022,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,23022,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,23023,0)
 ;;=E11.65^^78^996^8
 ;;^UTILITY(U,$J,358.3,23023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23023,1,3,0)
 ;;=3^DM Type 2 w/ hyperglycemia
 ;;^UTILITY(U,$J,358.3,23023,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,23023,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,23024,0)
 ;;=E11.9^^78^996^9
 ;;^UTILITY(U,$J,358.3,23024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23024,1,3,0)
 ;;=3^DM Type 2 w/o complications
 ;;^UTILITY(U,$J,358.3,23024,1,4,0)
 ;;=4^E11.9
