IBDEI1XM ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30861,1,3,0)
 ;;=3^Urinary Retention,Unspec
 ;;^UTILITY(U,$J,358.3,30861,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,30861,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,30862,0)
 ;;=I75.81^^123^1596^8
 ;;^UTILITY(U,$J,358.3,30862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30862,1,3,0)
 ;;=3^Atheroembolism of Kidney
 ;;^UTILITY(U,$J,358.3,30862,1,4,0)
 ;;=4^I75.81
 ;;^UTILITY(U,$J,358.3,30862,2)
 ;;=^328516
 ;;^UTILITY(U,$J,358.3,30863,0)
 ;;=R34.^^123^1596^7
 ;;^UTILITY(U,$J,358.3,30863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30863,1,3,0)
 ;;=3^Anuria and Oliguria
 ;;^UTILITY(U,$J,358.3,30863,1,4,0)
 ;;=4^R34.
 ;;^UTILITY(U,$J,358.3,30863,2)
 ;;=^5019333
 ;;^UTILITY(U,$J,358.3,30864,0)
 ;;=K76.7^^123^1596^9
 ;;^UTILITY(U,$J,358.3,30864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30864,1,3,0)
 ;;=3^Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,30864,1,4,0)
 ;;=4^K76.7
 ;;^UTILITY(U,$J,358.3,30864,2)
 ;;=^56497
 ;;^UTILITY(U,$J,358.3,30865,0)
 ;;=N00.0^^123^1597^8
 ;;^UTILITY(U,$J,358.3,30865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30865,1,3,0)
 ;;=3^Acute nephritic syndrome w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,30865,1,4,0)
 ;;=4^N00.0
 ;;^UTILITY(U,$J,358.3,30865,2)
 ;;=^5015491
 ;;^UTILITY(U,$J,358.3,30866,0)
 ;;=N00.1^^123^1597^7
 ;;^UTILITY(U,$J,358.3,30866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30866,1,3,0)
 ;;=3^Acute nephritic syndrome w/ focal and segmental glomerular lesions
 ;;^UTILITY(U,$J,358.3,30866,1,4,0)
 ;;=4^N00.1
 ;;^UTILITY(U,$J,358.3,30866,2)
 ;;=^5015492
 ;;^UTILITY(U,$J,358.3,30867,0)
 ;;=N00.2^^123^1597^4
 ;;^UTILITY(U,$J,358.3,30867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30867,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,30867,1,4,0)
 ;;=4^N00.2
 ;;^UTILITY(U,$J,358.3,30867,2)
 ;;=^5015493
 ;;^UTILITY(U,$J,358.3,30868,0)
 ;;=N00.3^^123^1597^5
 ;;^UTILITY(U,$J,358.3,30868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30868,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,30868,1,4,0)
 ;;=4^N00.3
 ;;^UTILITY(U,$J,358.3,30868,2)
 ;;=^5015494
 ;;^UTILITY(U,$J,358.3,30869,0)
 ;;=N00.4^^123^1597^3
 ;;^UTILITY(U,$J,358.3,30869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30869,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,30869,1,4,0)
 ;;=4^N00.4
 ;;^UTILITY(U,$J,358.3,30869,2)
 ;;=^5015495
 ;;^UTILITY(U,$J,358.3,30870,0)
 ;;=N00.5^^123^1597^6
 ;;^UTILITY(U,$J,358.3,30870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30870,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,30870,1,4,0)
 ;;=4^N00.5
 ;;^UTILITY(U,$J,358.3,30870,2)
 ;;=^5015496
 ;;^UTILITY(U,$J,358.3,30871,0)
 ;;=N00.6^^123^1597^1
 ;;^UTILITY(U,$J,358.3,30871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30871,1,3,0)
 ;;=3^Acute nephritic syndrome w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,30871,1,4,0)
 ;;=4^N00.6
 ;;^UTILITY(U,$J,358.3,30871,2)
 ;;=^5015497
 ;;^UTILITY(U,$J,358.3,30872,0)
 ;;=N00.7^^123^1597^2
 ;;^UTILITY(U,$J,358.3,30872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30872,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,30872,1,4,0)
 ;;=4^N00.7
 ;;^UTILITY(U,$J,358.3,30872,2)
 ;;=^5015498
 ;;^UTILITY(U,$J,358.3,30873,0)
 ;;=N00.8^^123^1597^9
