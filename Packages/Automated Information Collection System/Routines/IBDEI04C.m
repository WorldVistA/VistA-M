IBDEI04C ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1605,1,3,0)
 ;;=3^Cardiomyopathy in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,1605,1,4,0)
 ;;=4^I43.
 ;;^UTILITY(U,$J,358.3,1605,2)
 ;;=^5007201
 ;;^UTILITY(U,$J,358.3,1606,0)
 ;;=I42.7^^11^145^7
 ;;^UTILITY(U,$J,358.3,1606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1606,1,3,0)
 ;;=3^Cardiomyopathy d/t Drug/External Agent
 ;;^UTILITY(U,$J,358.3,1606,1,4,0)
 ;;=4^I42.7
 ;;^UTILITY(U,$J,358.3,1606,2)
 ;;=^5007198
 ;;^UTILITY(U,$J,358.3,1607,0)
 ;;=I42.9^^11^145^9
 ;;^UTILITY(U,$J,358.3,1607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1607,1,3,0)
 ;;=3^Cardiomyopathy,Unspec
 ;;^UTILITY(U,$J,358.3,1607,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,1607,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,1608,0)
 ;;=I50.9^^11^145^22
 ;;^UTILITY(U,$J,358.3,1608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1608,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1608,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,1608,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,1609,0)
 ;;=I50.1^^11^145^33
 ;;^UTILITY(U,$J,358.3,1609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1609,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,1609,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,1609,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,1610,0)
 ;;=I50.20^^11^145^55
 ;;^UTILITY(U,$J,358.3,1610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1610,1,3,0)
 ;;=3^Systolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1610,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,1610,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,1611,0)
 ;;=I50.30^^11^145^19
 ;;^UTILITY(U,$J,358.3,1611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1611,1,3,0)
 ;;=3^Diastolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1611,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,1611,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,1612,0)
 ;;=I50.40^^11^145^54
 ;;^UTILITY(U,$J,358.3,1612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1612,1,3,0)
 ;;=3^Systolic & Diastolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,1612,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,1612,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,1613,0)
 ;;=I51.7^^11^145^6
 ;;^UTILITY(U,$J,358.3,1613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1613,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,1613,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,1613,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,1614,0)
 ;;=I97.111^^11^145^42
 ;;^UTILITY(U,$J,358.3,1614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1614,1,3,0)
 ;;=3^Postprocedural Cardiac Insufficiency Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1614,1,4,0)
 ;;=4^I97.111
 ;;^UTILITY(U,$J,358.3,1614,2)
 ;;=^5008084
 ;;^UTILITY(U,$J,358.3,1615,0)
 ;;=I97.120^^11^145^38
 ;;^UTILITY(U,$J,358.3,1615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1615,1,3,0)
 ;;=3^Postprocedural Cardiac Arrest Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1615,1,4,0)
 ;;=4^I97.120
 ;;^UTILITY(U,$J,358.3,1615,2)
 ;;=^5008085
 ;;^UTILITY(U,$J,358.3,1616,0)
 ;;=I97.121^^11^145^39
 ;;^UTILITY(U,$J,358.3,1616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1616,1,3,0)
 ;;=3^Postprocedural Cardiac Arrest Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1616,1,4,0)
 ;;=4^I97.121
 ;;^UTILITY(U,$J,358.3,1616,2)
 ;;=^5008086
 ;;^UTILITY(U,$J,358.3,1617,0)
 ;;=I97.130^^11^145^44
 ;;^UTILITY(U,$J,358.3,1617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1617,1,3,0)
 ;;=3^Postprocedural Heart Failure Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1617,1,4,0)
 ;;=4^I97.130
 ;;^UTILITY(U,$J,358.3,1617,2)
 ;;=^5008087
 ;;^UTILITY(U,$J,358.3,1618,0)
 ;;=I97.131^^11^145^45
