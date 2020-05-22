IBDEI0EO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6311,0)
 ;;=I43.^^53^406^16
 ;;^UTILITY(U,$J,358.3,6311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6311,1,3,0)
 ;;=3^Cardiomyopathy in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,6311,1,4,0)
 ;;=4^I43.
 ;;^UTILITY(U,$J,358.3,6311,2)
 ;;=^5007201
 ;;^UTILITY(U,$J,358.3,6312,0)
 ;;=I42.7^^53^406^15
 ;;^UTILITY(U,$J,358.3,6312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6312,1,3,0)
 ;;=3^Cardiomyopathy d/t Drug/External Agent
 ;;^UTILITY(U,$J,358.3,6312,1,4,0)
 ;;=4^I42.7
 ;;^UTILITY(U,$J,358.3,6312,2)
 ;;=^5007198
 ;;^UTILITY(U,$J,358.3,6313,0)
 ;;=I42.9^^53^406^17
 ;;^UTILITY(U,$J,358.3,6313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6313,1,3,0)
 ;;=3^Cardiomyopathy,Unspec
 ;;^UTILITY(U,$J,358.3,6313,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,6313,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,6314,0)
 ;;=I50.9^^53^406^35
 ;;^UTILITY(U,$J,358.3,6314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6314,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,6314,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,6314,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,6315,0)
 ;;=I50.1^^53^406^48
 ;;^UTILITY(U,$J,358.3,6315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6315,1,3,0)
 ;;=3^Left Ventricular Failure
 ;;^UTILITY(U,$J,358.3,6315,1,4,0)
 ;;=4^I50.1
 ;;^UTILITY(U,$J,358.3,6315,2)
 ;;=^5007238
 ;;^UTILITY(U,$J,358.3,6316,0)
 ;;=I50.20^^53^406^72
 ;;^UTILITY(U,$J,358.3,6316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6316,1,3,0)
 ;;=3^Systolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,6316,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,6316,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,6317,0)
 ;;=I50.40^^53^406^71
 ;;^UTILITY(U,$J,358.3,6317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6317,1,3,0)
 ;;=3^Systolic & Diastolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,6317,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,6317,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,6318,0)
 ;;=I51.7^^53^406^14
 ;;^UTILITY(U,$J,358.3,6318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6318,1,3,0)
 ;;=3^Cardiomegaly
 ;;^UTILITY(U,$J,358.3,6318,1,4,0)
 ;;=4^I51.7
 ;;^UTILITY(U,$J,358.3,6318,2)
 ;;=^5007257
 ;;^UTILITY(U,$J,358.3,6319,0)
 ;;=I97.111^^53^406^57
 ;;^UTILITY(U,$J,358.3,6319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6319,1,3,0)
 ;;=3^Postprocedural Cardiac Insufficiency Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,6319,1,4,0)
 ;;=4^I97.111
 ;;^UTILITY(U,$J,358.3,6319,2)
 ;;=^5008084
 ;;^UTILITY(U,$J,358.3,6320,0)
 ;;=I97.120^^53^406^53
 ;;^UTILITY(U,$J,358.3,6320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6320,1,3,0)
 ;;=3^Postprocedural Cardiac Arrest Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,6320,1,4,0)
 ;;=4^I97.120
 ;;^UTILITY(U,$J,358.3,6320,2)
 ;;=^5008085
 ;;^UTILITY(U,$J,358.3,6321,0)
 ;;=I97.121^^53^406^54
 ;;^UTILITY(U,$J,358.3,6321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6321,1,3,0)
 ;;=3^Postprocedural Cardiac Arrest Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,6321,1,4,0)
 ;;=4^I97.121
 ;;^UTILITY(U,$J,358.3,6321,2)
 ;;=^5008086
 ;;^UTILITY(U,$J,358.3,6322,0)
 ;;=I97.130^^53^406^59
 ;;^UTILITY(U,$J,358.3,6322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6322,1,3,0)
 ;;=3^Postprocedural Heart Failure Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,6322,1,4,0)
 ;;=4^I97.130
 ;;^UTILITY(U,$J,358.3,6322,2)
 ;;=^5008087
 ;;^UTILITY(U,$J,358.3,6323,0)
 ;;=I97.131^^53^406^60
