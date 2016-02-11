IBDEI367 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53230,2)
 ;;=^5002455
 ;;^UTILITY(U,$J,358.3,53231,0)
 ;;=E03.9^^245^2675^24
 ;;^UTILITY(U,$J,358.3,53231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53231,1,3,0)
 ;;=3^Hypothyroidism, unspecified
 ;;^UTILITY(U,$J,358.3,53231,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,53231,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,53232,0)
 ;;=E05.90^^245^2675^30
 ;;^UTILITY(U,$J,358.3,53232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53232,1,3,0)
 ;;=3^Thyrotoxicosis w/o thyrotoxic crisis/storm
 ;;^UTILITY(U,$J,358.3,53232,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,53232,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,53233,0)
 ;;=E08.42^^245^2675^10
 ;;^UTILITY(U,$J,358.3,53233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53233,1,3,0)
 ;;=3^DM d/t underlying condition w/ diabetic polyneuropathy
 ;;^UTILITY(U,$J,358.3,53233,1,4,0)
 ;;=4^E08.42
 ;;^UTILITY(U,$J,358.3,53233,2)
 ;;=^5002524
 ;;^UTILITY(U,$J,358.3,53234,0)
 ;;=E09.42^^245^2675^11
 ;;^UTILITY(U,$J,358.3,53234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53234,1,3,0)
 ;;=3^DM drug-induced w/ neurological compl w/ diabetic polyneuropathy
 ;;^UTILITY(U,$J,358.3,53234,1,4,0)
 ;;=4^E09.42
 ;;^UTILITY(U,$J,358.3,53234,2)
 ;;=^5002566
 ;;^UTILITY(U,$J,358.3,53235,0)
 ;;=E10.42^^245^2675^4
 ;;^UTILITY(U,$J,358.3,53235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53235,1,3,0)
 ;;=3^DM Type 1 w/ diabetic polyneuropathy
 ;;^UTILITY(U,$J,358.3,53235,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,53235,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,53236,0)
 ;;=E10.65^^245^2675^5
 ;;^UTILITY(U,$J,358.3,53236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53236,1,3,0)
 ;;=3^DM Type 1 w/ hyperglycemia
 ;;^UTILITY(U,$J,358.3,53236,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,53236,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,53237,0)
 ;;=E10.9^^245^2675^6
 ;;^UTILITY(U,$J,358.3,53237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53237,1,3,0)
 ;;=3^DM Type 1 w/o complications
 ;;^UTILITY(U,$J,358.3,53237,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,53237,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,53238,0)
 ;;=E11.42^^245^2675^7
 ;;^UTILITY(U,$J,358.3,53238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53238,1,3,0)
 ;;=3^DM Type 2 w/ diabetic polyneuropathy
 ;;^UTILITY(U,$J,358.3,53238,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,53238,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,53239,0)
 ;;=E11.65^^245^2675^8
 ;;^UTILITY(U,$J,358.3,53239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53239,1,3,0)
 ;;=3^DM Type 2 w/ hyperglycemia
 ;;^UTILITY(U,$J,358.3,53239,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,53239,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,53240,0)
 ;;=E11.9^^245^2675^9
 ;;^UTILITY(U,$J,358.3,53240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53240,1,3,0)
 ;;=3^DM Type 2 w/o complications
 ;;^UTILITY(U,$J,358.3,53240,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,53240,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,53241,0)
 ;;=E13.42^^245^2675^12
 ;;^UTILITY(U,$J,358.3,53241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53241,1,3,0)
 ;;=3^DM oth w/ diabetic polyneuropathy
 ;;^UTILITY(U,$J,358.3,53241,1,4,0)
 ;;=4^E13.42
 ;;^UTILITY(U,$J,358.3,53241,2)
 ;;=^5002686
 ;;^UTILITY(U,$J,358.3,53242,0)
 ;;=E16.2^^245^2675^22
 ;;^UTILITY(U,$J,358.3,53242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53242,1,3,0)
 ;;=3^Hypoglycemia, unspecified
 ;;^UTILITY(U,$J,358.3,53242,1,4,0)
 ;;=4^E16.2
 ;;^UTILITY(U,$J,358.3,53242,2)
 ;;=^5002708
 ;;^UTILITY(U,$J,358.3,53243,0)
 ;;=E46.^^245^2675^26
 ;;^UTILITY(U,$J,358.3,53243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53243,1,3,0)
 ;;=3^Malnutrition, protein-calorie, unspec
