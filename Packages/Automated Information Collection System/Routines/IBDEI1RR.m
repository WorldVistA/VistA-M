IBDEI1RR ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30070,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,30070,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,30071,0)
 ;;=Z31.5^^118^1497^4
 ;;^UTILITY(U,$J,358.3,30071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30071,1,3,0)
 ;;=3^Genetic Counseling
 ;;^UTILITY(U,$J,358.3,30071,1,4,0)
 ;;=4^Z31.5
 ;;^UTILITY(U,$J,358.3,30071,2)
 ;;=^5062838
 ;;^UTILITY(U,$J,358.3,30072,0)
 ;;=Z51.11^^118^1497^2
 ;;^UTILITY(U,$J,358.3,30072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30072,1,3,0)
 ;;=3^Antineoplastic Chemotherapy
 ;;^UTILITY(U,$J,358.3,30072,1,4,0)
 ;;=4^Z51.11
 ;;^UTILITY(U,$J,358.3,30072,2)
 ;;=^5063061
 ;;^UTILITY(U,$J,358.3,30073,0)
 ;;=Z71.3^^118^1497^3
 ;;^UTILITY(U,$J,358.3,30073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30073,1,3,0)
 ;;=3^Dietary counseling and surveillance
 ;;^UTILITY(U,$J,358.3,30073,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,30073,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,30074,0)
 ;;=Z71.89^^118^1497^8
 ;;^UTILITY(U,$J,358.3,30074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30074,1,3,0)
 ;;=3^Specified Counseling NEC
 ;;^UTILITY(U,$J,358.3,30074,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,30074,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,30075,0)
 ;;=Z51.89^^118^1497^1
 ;;^UTILITY(U,$J,358.3,30075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30075,1,3,0)
 ;;=3^Aftercare NEC
 ;;^UTILITY(U,$J,358.3,30075,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,30075,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,30076,0)
 ;;=Z12.39^^118^1497^5
 ;;^UTILITY(U,$J,358.3,30076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30076,1,3,0)
 ;;=3^Malig Neop of Breast Screening
 ;;^UTILITY(U,$J,358.3,30076,1,4,0)
 ;;=4^Z12.39
 ;;^UTILITY(U,$J,358.3,30076,2)
 ;;=^5062686
 ;;^UTILITY(U,$J,358.3,30077,0)
 ;;=Z12.4^^118^1497^6
 ;;^UTILITY(U,$J,358.3,30077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30077,1,3,0)
 ;;=3^Malig Neop of Cervix Screening
 ;;^UTILITY(U,$J,358.3,30077,1,4,0)
 ;;=4^Z12.4
 ;;^UTILITY(U,$J,358.3,30077,2)
 ;;=^5062687
 ;;^UTILITY(U,$J,358.3,30078,0)
 ;;=Z12.12^^118^1497^7
 ;;^UTILITY(U,$J,358.3,30078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30078,1,3,0)
 ;;=3^Malig Neop of Rectum Screening
 ;;^UTILITY(U,$J,358.3,30078,1,4,0)
 ;;=4^Z12.12
 ;;^UTILITY(U,$J,358.3,30078,2)
 ;;=^5062682
 ;;^UTILITY(U,$J,358.3,30079,0)
 ;;=C61.^^118^1498^11
 ;;^UTILITY(U,$J,358.3,30079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30079,1,3,0)
 ;;=3^Malignant neoplasm of prostate
 ;;^UTILITY(U,$J,358.3,30079,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,30079,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,30080,0)
 ;;=C62.11^^118^1498^6
 ;;^UTILITY(U,$J,358.3,30080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30080,1,3,0)
 ;;=3^Malignant neoplasm of descended right testis
 ;;^UTILITY(U,$J,358.3,30080,1,4,0)
 ;;=4^C62.11
 ;;^UTILITY(U,$J,358.3,30080,2)
 ;;=^5001234
 ;;^UTILITY(U,$J,358.3,30081,0)
 ;;=C62.12^^118^1498^5
 ;;^UTILITY(U,$J,358.3,30081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30081,1,3,0)
 ;;=3^Malignant neoplasm of descended left testis
 ;;^UTILITY(U,$J,358.3,30081,1,4,0)
 ;;=4^C62.12
 ;;^UTILITY(U,$J,358.3,30081,2)
 ;;=^5001235
 ;;^UTILITY(U,$J,358.3,30082,0)
 ;;=C62.91^^118^1498^3
 ;;^UTILITY(U,$J,358.3,30082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30082,1,3,0)
 ;;=3^Malig neoplasm of right testis, unsp descended or undescended
 ;;^UTILITY(U,$J,358.3,30082,1,4,0)
 ;;=4^C62.91
 ;;^UTILITY(U,$J,358.3,30082,2)
 ;;=^5001237
 ;;^UTILITY(U,$J,358.3,30083,0)
 ;;=C62.92^^118^1498^2
 ;;^UTILITY(U,$J,358.3,30083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30083,1,3,0)
 ;;=3^Malig neoplasm of left testis, unsp descended or undescended
