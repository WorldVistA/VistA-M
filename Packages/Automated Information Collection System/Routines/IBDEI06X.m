IBDEI06X ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2724,1,3,0)
 ;;=3^Gastritis w/o bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,2724,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,2724,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,2725,0)
 ;;=K52.9^^7^83^87
 ;;^UTILITY(U,$J,358.3,2725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2725,1,3,0)
 ;;=3^Gastroenteritis and colitis, unspecified
 ;;^UTILITY(U,$J,358.3,2725,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,2725,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,2726,0)
 ;;=A60.00^^7^83^89
 ;;^UTILITY(U,$J,358.3,2726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2726,1,3,0)
 ;;=3^General Herpes, unsp
 ;;^UTILITY(U,$J,358.3,2726,1,4,0)
 ;;=4^A60.00
 ;;^UTILITY(U,$J,358.3,2726,2)
 ;;=^5000352
 ;;^UTILITY(U,$J,358.3,2727,0)
 ;;=A07.1^^7^83^90
 ;;^UTILITY(U,$J,358.3,2727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2727,1,3,0)
 ;;=3^Giardiasis
 ;;^UTILITY(U,$J,358.3,2727,1,4,0)
 ;;=4^A07.1
 ;;^UTILITY(U,$J,358.3,2727,2)
 ;;=^5000049
 ;;^UTILITY(U,$J,358.3,2728,0)
 ;;=B15.9^^7^83^95
 ;;^UTILITY(U,$J,358.3,2728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2728,1,3,0)
 ;;=3^Hepatitis A w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,2728,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,2728,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,2729,0)
 ;;=B19.10^^7^83^96
 ;;^UTILITY(U,$J,358.3,2729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2729,1,3,0)
 ;;=3^Hepatitis B w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,2729,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,2729,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,2730,0)
 ;;=B19.20^^7^83^99
 ;;^UTILITY(U,$J,358.3,2730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2730,1,3,0)
 ;;=3^Hepatitis C w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,2730,1,4,0)
 ;;=4^B19.20
 ;;^UTILITY(U,$J,358.3,2730,2)
 ;;=^331436
 ;;^UTILITY(U,$J,358.3,2731,0)
 ;;=B19.9^^7^83^103
 ;;^UTILITY(U,$J,358.3,2731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2731,1,3,0)
 ;;=3^Hepatitis w/o Hepatic Coma,Unspec
 ;;^UTILITY(U,$J,358.3,2731,1,4,0)
 ;;=4^B19.9
 ;;^UTILITY(U,$J,358.3,2731,2)
 ;;=^5000554
 ;;^UTILITY(U,$J,358.3,2732,0)
 ;;=K75.89^^7^83^102
 ;;^UTILITY(U,$J,358.3,2732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2732,1,3,0)
 ;;=3^Hepatitis NEC
 ;;^UTILITY(U,$J,358.3,2732,1,4,0)
 ;;=4^K75.89
 ;;^UTILITY(U,$J,358.3,2732,2)
 ;;=^5008829
 ;;^UTILITY(U,$J,358.3,2733,0)
 ;;=B00.1^^7^83^105
 ;;^UTILITY(U,$J,358.3,2733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2733,1,3,0)
 ;;=3^Herpes Simplex, Lip
 ;;^UTILITY(U,$J,358.3,2733,1,4,0)
 ;;=4^B00.1
 ;;^UTILITY(U,$J,358.3,2733,2)
 ;;=^5000468
 ;;^UTILITY(U,$J,358.3,2734,0)
 ;;=B00.2^^7^83^109
 ;;^UTILITY(U,$J,358.3,2734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2734,1,3,0)
 ;;=3^Herpesvirial gingivostomatitis and pharyngotonsillitis
 ;;^UTILITY(U,$J,358.3,2734,1,4,0)
 ;;=4^B00.2
 ;;^UTILITY(U,$J,358.3,2734,2)
 ;;=^5000469
 ;;^UTILITY(U,$J,358.3,2735,0)
 ;;=B02.9^^7^83^106
 ;;^UTILITY(U,$J,358.3,2735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2735,1,3,0)
 ;;=3^Herpes Zoster NOS
 ;;^UTILITY(U,$J,358.3,2735,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,2735,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,2736,0)
 ;;=A60.01^^7^83^110
 ;;^UTILITY(U,$J,358.3,2736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2736,1,3,0)
 ;;=3^Herpetic Infect of Penis
 ;;^UTILITY(U,$J,358.3,2736,1,4,0)
 ;;=4^A60.01
 ;;^UTILITY(U,$J,358.3,2736,2)
 ;;=^5000353
 ;;^UTILITY(U,$J,358.3,2737,0)
 ;;=A60.04^^7^83^111
 ;;^UTILITY(U,$J,358.3,2737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2737,1,3,0)
 ;;=3^Herpetic Vulvovaginitis
 ;;^UTILITY(U,$J,358.3,2737,1,4,0)
 ;;=4^A60.04
 ;;^UTILITY(U,$J,358.3,2737,2)
 ;;=^5000356
 ;;^UTILITY(U,$J,358.3,2738,0)
 ;;=B01.9^^7^83^108
