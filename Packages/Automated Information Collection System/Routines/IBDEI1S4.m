IBDEI1S4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30233,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,30233,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,30234,0)
 ;;=C77.4^^118^1503^6
 ;;^UTILITY(U,$J,358.3,30234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30234,1,3,0)
 ;;=3^Secondary malignant neoplasm of inguinal and lower limb nodes
 ;;^UTILITY(U,$J,358.3,30234,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,30234,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,30235,0)
 ;;=C77.8^^118^1503^15
 ;;^UTILITY(U,$J,358.3,30235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30235,1,3,0)
 ;;=3^Secondary malignant neoplasm of nodes of multiple regions
 ;;^UTILITY(U,$J,358.3,30235,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,30235,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,30236,0)
 ;;=C77.9^^118^1503^13
 ;;^UTILITY(U,$J,358.3,30236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30236,1,3,0)
 ;;=3^Secondary malignant neoplasm of lymph node, unsp
 ;;^UTILITY(U,$J,358.3,30236,1,4,0)
 ;;=4^C77.9
 ;;^UTILITY(U,$J,358.3,30236,2)
 ;;=^5001333
 ;;^UTILITY(U,$J,358.3,30237,0)
 ;;=C78.01^^118^1503^18
 ;;^UTILITY(U,$J,358.3,30237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30237,1,3,0)
 ;;=3^Secondary malignant neoplasm of right lung
 ;;^UTILITY(U,$J,358.3,30237,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,30237,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,30238,0)
 ;;=C78.02^^118^1503^11
 ;;^UTILITY(U,$J,358.3,30238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30238,1,3,0)
 ;;=3^Secondary malignant neoplasm of left lung
 ;;^UTILITY(U,$J,358.3,30238,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,30238,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,30239,0)
 ;;=C78.7^^118^1503^12
 ;;^UTILITY(U,$J,358.3,30239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30239,1,3,0)
 ;;=3^Secondary malignant neoplasm of liver and intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,30239,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,30239,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,30240,0)
 ;;=C79.2^^118^1503^19
 ;;^UTILITY(U,$J,358.3,30240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30240,1,3,0)
 ;;=3^Secondary malignant neoplasm of skin
 ;;^UTILITY(U,$J,358.3,30240,1,4,0)
 ;;=4^C79.2
 ;;^UTILITY(U,$J,358.3,30240,2)
 ;;=^267333
 ;;^UTILITY(U,$J,358.3,30241,0)
 ;;=C79.31^^118^1503^4
 ;;^UTILITY(U,$J,358.3,30241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30241,1,3,0)
 ;;=3^Secondary malignant neoplasm of brain
 ;;^UTILITY(U,$J,358.3,30241,1,4,0)
 ;;=4^C79.31
 ;;^UTILITY(U,$J,358.3,30241,2)
 ;;=^5001347
 ;;^UTILITY(U,$J,358.3,30242,0)
 ;;=C79.32^^118^1503^5
 ;;^UTILITY(U,$J,358.3,30242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30242,1,3,0)
 ;;=3^Secondary malignant neoplasm of cerebral meninges
 ;;^UTILITY(U,$J,358.3,30242,1,4,0)
 ;;=4^C79.32
 ;;^UTILITY(U,$J,358.3,30242,2)
 ;;=^5001348
 ;;^UTILITY(U,$J,358.3,30243,0)
 ;;=C79.49^^118^1503^16
 ;;^UTILITY(U,$J,358.3,30243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30243,1,3,0)
 ;;=3^Secondary malignant neoplasm of oth parts of nervous system
 ;;^UTILITY(U,$J,358.3,30243,1,4,0)
 ;;=4^C79.49
 ;;^UTILITY(U,$J,358.3,30243,2)
 ;;=^267335
 ;;^UTILITY(U,$J,358.3,30244,0)
 ;;=C79.51^^118^1503^2
 ;;^UTILITY(U,$J,358.3,30244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30244,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone
 ;;^UTILITY(U,$J,358.3,30244,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,30244,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,30245,0)
 ;;=C79.52^^118^1503^3
 ;;^UTILITY(U,$J,358.3,30245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30245,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone marrow
 ;;^UTILITY(U,$J,358.3,30245,1,4,0)
 ;;=4^C79.52
 ;;^UTILITY(U,$J,358.3,30245,2)
 ;;=^5001351
