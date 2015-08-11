IBDEI139 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19401,0)
 ;;=438.85^^108^1148^5.3
 ;;^UTILITY(U,$J,358.3,19401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19401,1,2,0)
 ;;=2^438.85
 ;;^UTILITY(U,$J,358.3,19401,1,3,0)
 ;;=3^Stroke w/Vertigo
 ;;^UTILITY(U,$J,358.3,19401,2)
 ;;=^328508
 ;;^UTILITY(U,$J,358.3,19402,0)
 ;;=438.82^^108^1148^5.5
 ;;^UTILITY(U,$J,358.3,19402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19402,1,2,0)
 ;;=2^438.82
 ;;^UTILITY(U,$J,358.3,19402,1,3,0)
 ;;=3^Stroke w/dysphagia
 ;;^UTILITY(U,$J,358.3,19402,2)
 ;;=Stroke w/dysphagia^317923
 ;;^UTILITY(U,$J,358.3,19403,0)
 ;;=438.89^^108^1148^5
 ;;^UTILITY(U,$J,358.3,19403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19403,1,2,0)
 ;;=2^438.89
 ;;^UTILITY(U,$J,358.3,19403,1,3,0)
 ;;=3^Stroke with Other Deficits
 ;;^UTILITY(U,$J,358.3,19403,2)
 ;;=^317924
 ;;^UTILITY(U,$J,358.3,19404,0)
 ;;=V12.54^^108^1148^9
 ;;^UTILITY(U,$J,358.3,19404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19404,1,2,0)
 ;;=2^V12.54
 ;;^UTILITY(U,$J,358.3,19404,1,3,0)
 ;;=3^Stroke F/U, No Residuals
 ;;^UTILITY(U,$J,358.3,19404,2)
 ;;=^335309
 ;;^UTILITY(U,$J,358.3,19405,0)
 ;;=345.10^^108^1149^8
 ;;^UTILITY(U,$J,358.3,19405,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19405,1,2,0)
 ;;=2^345.10
 ;;^UTILITY(U,$J,358.3,19405,1,3,0)
 ;;=3^Myoclonic Seizures
 ;;^UTILITY(U,$J,358.3,19405,2)
 ;;=Myoclonic Epilepsy^268463
 ;;^UTILITY(U,$J,358.3,19406,0)
 ;;=345.11^^108^1149^9
 ;;^UTILITY(U,$J,358.3,19406,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19406,1,2,0)
 ;;=2^345.11
 ;;^UTILITY(U,$J,358.3,19406,1,3,0)
 ;;=3^Myoclonic Seizures, Intractible
 ;;^UTILITY(U,$J,358.3,19406,2)
 ;;=Myoclonic, Intractable Epilepsy^268464
 ;;^UTILITY(U,$J,358.3,19407,0)
 ;;=345.50^^108^1149^11
 ;;^UTILITY(U,$J,358.3,19407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19407,1,2,0)
 ;;=2^345.50
 ;;^UTILITY(U,$J,358.3,19407,1,3,0)
 ;;=3^Simple Partial Seizures
 ;;^UTILITY(U,$J,358.3,19407,2)
 ;;=Simple Partial Epilepsy^268470
 ;;^UTILITY(U,$J,358.3,19408,0)
 ;;=345.51^^108^1149^12
 ;;^UTILITY(U,$J,358.3,19408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19408,1,2,0)
 ;;=2^345.51
 ;;^UTILITY(U,$J,358.3,19408,1,3,0)
 ;;=3^Simple Partial Seizures, Intract
 ;;^UTILITY(U,$J,358.3,19408,2)
 ;;=Simple Epilepsy Partial, Intract^268467
 ;;^UTILITY(U,$J,358.3,19409,0)
 ;;=345.40^^108^1149^2
 ;;^UTILITY(U,$J,358.3,19409,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19409,1,2,0)
 ;;=2^345.40
 ;;^UTILITY(U,$J,358.3,19409,1,3,0)
 ;;=3^Complex Partial Seizures
 ;;^UTILITY(U,$J,358.3,19409,2)
 ;;=Cmplx Partial Epilepsy^268467
 ;;^UTILITY(U,$J,358.3,19410,0)
 ;;=345.41^^108^1149^3
 ;;^UTILITY(U,$J,358.3,19410,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19410,1,2,0)
 ;;=2^345.41
 ;;^UTILITY(U,$J,358.3,19410,1,3,0)
 ;;=3^Complex Partial Seizures, Intractible
 ;;^UTILITY(U,$J,358.3,19410,2)
 ;;=Complex Partial Seizures, Intractible^268469
 ;;^UTILITY(U,$J,358.3,19411,0)
 ;;=345.90^^108^1149^6
 ;;^UTILITY(U,$J,358.3,19411,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19411,1,2,0)
 ;;=2^345.90
 ;;^UTILITY(U,$J,358.3,19411,1,3,0)
 ;;=3^Epilepsy,Unspec
 ;;^UTILITY(U,$J,358.3,19411,2)
 ;;=Unspecified Epilepsy^268477
 ;;^UTILITY(U,$J,358.3,19412,0)
 ;;=345.91^^108^1149^5
 ;;^UTILITY(U,$J,358.3,19412,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19412,1,2,0)
 ;;=2^345.91
 ;;^UTILITY(U,$J,358.3,19412,1,3,0)
 ;;=3^Epilepsy w/ Intractable Epilepsy,Unspec
 ;;^UTILITY(U,$J,358.3,19412,2)
 ;;=Unspecified, Intract Epilepsy^268478
 ;;^UTILITY(U,$J,358.3,19413,0)
 ;;=780.02^^108^1149^13
 ;;^UTILITY(U,$J,358.3,19413,1,0)
 ;;=^358.31IA^3^2
