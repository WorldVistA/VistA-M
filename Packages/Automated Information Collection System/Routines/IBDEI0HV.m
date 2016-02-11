IBDEI0HV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8005,0)
 ;;=E10.51^^55^532^3
 ;;^UTILITY(U,$J,358.3,8005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8005,1,3,0)
 ;;=3^Type 1 diab w diabetic peripheral angiopath w/o gangrene
 ;;^UTILITY(U,$J,358.3,8005,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,8005,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,8006,0)
 ;;=E10.52^^55^532^4
 ;;^UTILITY(U,$J,358.3,8006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8006,1,3,0)
 ;;=3^Type 1 diab w diabetic peripheral angiopathy w gangrene
 ;;^UTILITY(U,$J,358.3,8006,1,4,0)
 ;;=4^E10.52
 ;;^UTILITY(U,$J,358.3,8006,2)
 ;;=^5002611
 ;;^UTILITY(U,$J,358.3,8007,0)
 ;;=E11.649^^55^532^18
 ;;^UTILITY(U,$J,358.3,8007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8007,1,3,0)
 ;;=3^Type 2 diab w hypoglycemia without coma
 ;;^UTILITY(U,$J,358.3,8007,1,4,0)
 ;;=4^E11.649
 ;;^UTILITY(U,$J,358.3,8007,2)
 ;;=^5002662
 ;;^UTILITY(U,$J,358.3,8008,0)
 ;;=E11.641^^55^532^17
 ;;^UTILITY(U,$J,358.3,8008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8008,1,3,0)
 ;;=3^Type 2 diab w hypoglycemia with coma
 ;;^UTILITY(U,$J,358.3,8008,1,4,0)
 ;;=4^E11.641
 ;;^UTILITY(U,$J,358.3,8008,2)
 ;;=^5002661
 ;;^UTILITY(U,$J,358.3,8009,0)
 ;;=E11.9^^55^533^2
 ;;^UTILITY(U,$J,358.3,8009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8009,1,3,0)
 ;;=3^Type 2 diabetes mellitus without complications
 ;;^UTILITY(U,$J,358.3,8009,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,8009,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,8010,0)
 ;;=E10.9^^55^533^1
 ;;^UTILITY(U,$J,358.3,8010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8010,1,3,0)
 ;;=3^Type 1 diabetes mellitus without complications
 ;;^UTILITY(U,$J,358.3,8010,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,8010,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,8011,0)
 ;;=J02.0^^55^534^115
 ;;^UTILITY(U,$J,358.3,8011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8011,1,3,0)
 ;;=3^Streptococcal pharyngitis
 ;;^UTILITY(U,$J,358.3,8011,1,4,0)
 ;;=4^J02.0
 ;;^UTILITY(U,$J,358.3,8011,2)
 ;;=^114607
 ;;^UTILITY(U,$J,358.3,8012,0)
 ;;=J03.00^^55^534^13
 ;;^UTILITY(U,$J,358.3,8012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8012,1,3,0)
 ;;=3^Acute streptococcal tonsillitis, unspecified
 ;;^UTILITY(U,$J,358.3,8012,1,4,0)
 ;;=4^J03.00
 ;;^UTILITY(U,$J,358.3,8012,2)
 ;;=^5008131
 ;;^UTILITY(U,$J,358.3,8013,0)
 ;;=B37.0^^55^534^33
 ;;^UTILITY(U,$J,358.3,8013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8013,1,3,0)
 ;;=3^Candidal stomatitis
 ;;^UTILITY(U,$J,358.3,8013,1,4,0)
 ;;=4^B37.0
 ;;^UTILITY(U,$J,358.3,8013,2)
 ;;=^5000612
 ;;^UTILITY(U,$J,358.3,8014,0)
 ;;=B37.83^^55^534^32
 ;;^UTILITY(U,$J,358.3,8014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8014,1,3,0)
 ;;=3^Candidal cheilitis
 ;;^UTILITY(U,$J,358.3,8014,1,4,0)
 ;;=4^B37.83
 ;;^UTILITY(U,$J,358.3,8014,2)
 ;;=^5000622
 ;;^UTILITY(U,$J,358.3,8015,0)
 ;;=D14.1^^55^534^23
 ;;^UTILITY(U,$J,358.3,8015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8015,1,3,0)
 ;;=3^Benign neoplasm of larynx
 ;;^UTILITY(U,$J,358.3,8015,1,4,0)
 ;;=4^D14.1
 ;;^UTILITY(U,$J,358.3,8015,2)
 ;;=^267598
 ;;^UTILITY(U,$J,358.3,8016,0)
 ;;=D14.2^^55^534^24
 ;;^UTILITY(U,$J,358.3,8016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8016,1,3,0)
 ;;=3^Benign neoplasm of trachea
 ;;^UTILITY(U,$J,358.3,8016,1,4,0)
 ;;=4^D14.2
 ;;^UTILITY(U,$J,358.3,8016,2)
 ;;=^267599
 ;;^UTILITY(U,$J,358.3,8017,0)
 ;;=H40.9^^55^534^74
 ;;^UTILITY(U,$J,358.3,8017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8017,1,3,0)
 ;;=3^Glaucoma,Unspec
 ;;^UTILITY(U,$J,358.3,8017,1,4,0)
 ;;=4^H40.9
 ;;^UTILITY(U,$J,358.3,8017,2)
 ;;=^5005931
 ;;^UTILITY(U,$J,358.3,8018,0)
 ;;=H26.9^^55^534^34
