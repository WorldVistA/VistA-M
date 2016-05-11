IBDEI1RO ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30031,1,4,0)
 ;;=4^C57.01
 ;;^UTILITY(U,$J,358.3,30031,2)
 ;;=^5001216
 ;;^UTILITY(U,$J,358.3,30032,0)
 ;;=C57.02^^118^1495^12
 ;;^UTILITY(U,$J,358.3,30032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30032,1,3,0)
 ;;=3^Malignant neoplasm of left fallopian tube
 ;;^UTILITY(U,$J,358.3,30032,1,4,0)
 ;;=4^C57.02
 ;;^UTILITY(U,$J,358.3,30032,2)
 ;;=^5001217
 ;;^UTILITY(U,$J,358.3,30033,0)
 ;;=C52.^^118^1495^19
 ;;^UTILITY(U,$J,358.3,30033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30033,1,3,0)
 ;;=3^Malignant neoplasm of vagina
 ;;^UTILITY(U,$J,358.3,30033,1,4,0)
 ;;=4^C52.
 ;;^UTILITY(U,$J,358.3,30033,2)
 ;;=^267232
 ;;^UTILITY(U,$J,358.3,30034,0)
 ;;=C51.9^^118^1495^20
 ;;^UTILITY(U,$J,358.3,30034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30034,1,3,0)
 ;;=3^Malignant neoplasm of vulva, unspecified
 ;;^UTILITY(U,$J,358.3,30034,1,4,0)
 ;;=4^C51.9
 ;;^UTILITY(U,$J,358.3,30034,2)
 ;;=^5001202
 ;;^UTILITY(U,$J,358.3,30035,0)
 ;;=D05.01^^118^1495^10
 ;;^UTILITY(U,$J,358.3,30035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30035,1,3,0)
 ;;=3^Lobular carcinoma in situ of right breast
 ;;^UTILITY(U,$J,358.3,30035,1,4,0)
 ;;=4^D05.01
 ;;^UTILITY(U,$J,358.3,30035,2)
 ;;=^5001927
 ;;^UTILITY(U,$J,358.3,30036,0)
 ;;=D05.92^^118^1495^1
 ;;^UTILITY(U,$J,358.3,30036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30036,1,3,0)
 ;;=3^Carcinoma in Situ of Left Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,30036,1,4,0)
 ;;=4^D05.92
 ;;^UTILITY(U,$J,358.3,30036,2)
 ;;=^5001937
 ;;^UTILITY(U,$J,358.3,30037,0)
 ;;=D05.91^^118^1495^2
 ;;^UTILITY(U,$J,358.3,30037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30037,1,3,0)
 ;;=3^Carcinoma in Situ of Right Breast,Unspec Type
 ;;^UTILITY(U,$J,358.3,30037,1,4,0)
 ;;=4^D05.91
 ;;^UTILITY(U,$J,358.3,30037,2)
 ;;=^5001936
 ;;^UTILITY(U,$J,358.3,30038,0)
 ;;=D05.02^^118^1495^9
 ;;^UTILITY(U,$J,358.3,30038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30038,1,3,0)
 ;;=3^Lobular carcinoma in situ of left breast
 ;;^UTILITY(U,$J,358.3,30038,1,4,0)
 ;;=4^D05.02
 ;;^UTILITY(U,$J,358.3,30038,2)
 ;;=^5001928
 ;;^UTILITY(U,$J,358.3,30039,0)
 ;;=D05.11^^118^1495^8
 ;;^UTILITY(U,$J,358.3,30039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30039,1,3,0)
 ;;=3^Intraductal carcinoma in situ of right breast
 ;;^UTILITY(U,$J,358.3,30039,1,4,0)
 ;;=4^D05.11
 ;;^UTILITY(U,$J,358.3,30039,2)
 ;;=^5001930
 ;;^UTILITY(U,$J,358.3,30040,0)
 ;;=D05.12^^118^1495^7
 ;;^UTILITY(U,$J,358.3,30040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30040,1,3,0)
 ;;=3^Intraductal carcinoma in situ of left breast
 ;;^UTILITY(U,$J,358.3,30040,1,4,0)
 ;;=4^D05.12
 ;;^UTILITY(U,$J,358.3,30040,2)
 ;;=^5001931
 ;;^UTILITY(U,$J,358.3,30041,0)
 ;;=D06.9^^118^1495^3
 ;;^UTILITY(U,$J,358.3,30041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30041,1,3,0)
 ;;=3^Carcinoma in situ of cervix, unspecified
 ;;^UTILITY(U,$J,358.3,30041,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,30041,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,30042,0)
 ;;=D06.0^^118^1495^4
 ;;^UTILITY(U,$J,358.3,30042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30042,1,3,0)
 ;;=3^Carcinoma in situ of endocervix
 ;;^UTILITY(U,$J,358.3,30042,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,30042,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,30043,0)
 ;;=D06.1^^118^1495^5
 ;;^UTILITY(U,$J,358.3,30043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30043,1,3,0)
 ;;=3^Carcinoma in situ of exocervix
 ;;^UTILITY(U,$J,358.3,30043,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,30043,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,30044,0)
 ;;=D06.7^^118^1495^6
 ;;^UTILITY(U,$J,358.3,30044,1,0)
 ;;=^358.31IA^4^2
