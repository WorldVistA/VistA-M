IBDEI26L ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36625,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,36625,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,36626,0)
 ;;=D05.91^^169^1852^2
 ;;^UTILITY(U,$J,358.3,36626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36626,1,3,0)
 ;;=3^Carcinoma in Situ of Right Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,36626,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,36626,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,36627,0)
 ;;=D05.02^^169^1852^9
 ;;^UTILITY(U,$J,358.3,36627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36627,1,3,0)
 ;;=3^Lobular carcinoma in situ of left breast
 ;;^UTILITY(U,$J,358.3,36627,1,4,0)
 ;;=4^D05.02
 ;;^UTILITY(U,$J,358.3,36627,2)
 ;;=^5001928
 ;;^UTILITY(U,$J,358.3,36628,0)
 ;;=D05.11^^169^1852^8
 ;;^UTILITY(U,$J,358.3,36628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36628,1,3,0)
 ;;=3^Intraductal carcinoma in situ of right breast
 ;;^UTILITY(U,$J,358.3,36628,1,4,0)
 ;;=4^D05.11
 ;;^UTILITY(U,$J,358.3,36628,2)
 ;;=^5001930
 ;;^UTILITY(U,$J,358.3,36629,0)
 ;;=D05.12^^169^1852^7
 ;;^UTILITY(U,$J,358.3,36629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36629,1,3,0)
 ;;=3^Intraductal carcinoma in situ of left breast
 ;;^UTILITY(U,$J,358.3,36629,1,4,0)
 ;;=4^D05.12
 ;;^UTILITY(U,$J,358.3,36629,2)
 ;;=^5001931
 ;;^UTILITY(U,$J,358.3,36630,0)
 ;;=D06.9^^169^1852^3
 ;;^UTILITY(U,$J,358.3,36630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36630,1,3,0)
 ;;=3^Carcinoma in situ of cervix, unspecified
 ;;^UTILITY(U,$J,358.3,36630,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,36630,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,36631,0)
 ;;=D06.0^^169^1852^4
 ;;^UTILITY(U,$J,358.3,36631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36631,1,3,0)
 ;;=3^Carcinoma in situ of endocervix
 ;;^UTILITY(U,$J,358.3,36631,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,36631,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,36632,0)
 ;;=D06.1^^169^1852^5
 ;;^UTILITY(U,$J,358.3,36632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36632,1,3,0)
 ;;=3^Carcinoma in situ of exocervix
 ;;^UTILITY(U,$J,358.3,36632,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,36632,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,36633,0)
 ;;=D06.7^^169^1852^6
 ;;^UTILITY(U,$J,358.3,36633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36633,1,3,0)
 ;;=3^Carcinoma in situ of other parts of cervix
 ;;^UTILITY(U,$J,358.3,36633,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,36633,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,36634,0)
 ;;=D66.^^169^1853^16
 ;;^UTILITY(U,$J,358.3,36634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36634,1,3,0)
 ;;=3^Hereditary factor VIII deficiency
 ;;^UTILITY(U,$J,358.3,36634,1,4,0)
 ;;=4^D66.
 ;;^UTILITY(U,$J,358.3,36634,2)
 ;;=^5002353
 ;;^UTILITY(U,$J,358.3,36635,0)
 ;;=D67.^^169^1853^15
 ;;^UTILITY(U,$J,358.3,36635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36635,1,3,0)
 ;;=3^Hereditary factor IX deficiency
 ;;^UTILITY(U,$J,358.3,36635,1,4,0)
 ;;=4^D67.
 ;;^UTILITY(U,$J,358.3,36635,2)
 ;;=^5002354
 ;;^UTILITY(U,$J,358.3,36636,0)
 ;;=D68.1^^169^1853^17
 ;;^UTILITY(U,$J,358.3,36636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36636,1,3,0)
 ;;=3^Hereditary factor XI deficiency
 ;;^UTILITY(U,$J,358.3,36636,1,4,0)
 ;;=4^D68.1
 ;;^UTILITY(U,$J,358.3,36636,2)
 ;;=^5002355
 ;;^UTILITY(U,$J,358.3,36637,0)
 ;;=D68.2^^169^1853^14
 ;;^UTILITY(U,$J,358.3,36637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36637,1,3,0)
 ;;=3^Hereditary deficiency of other clotting factors
 ;;^UTILITY(U,$J,358.3,36637,1,4,0)
 ;;=4^D68.2
 ;;^UTILITY(U,$J,358.3,36637,2)
 ;;=^5002356
 ;;^UTILITY(U,$J,358.3,36638,0)
 ;;=D68.0^^169^1853^26
 ;;^UTILITY(U,$J,358.3,36638,1,0)
 ;;=^358.31IA^4^2
