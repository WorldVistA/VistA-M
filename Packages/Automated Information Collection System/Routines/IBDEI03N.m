IBDEI03N ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1344,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1344,1,4,0)
 ;;=4^410.32
 ;;^UTILITY(U,$J,358.3,1344,1,5,0)
 ;;=5^Acute MI, Inferoposterior, Subsequent
 ;;^UTILITY(U,$J,358.3,1344,2)
 ;;=Acute MI, Inferoposterior, Subsequent^269652
 ;;^UTILITY(U,$J,358.3,1345,0)
 ;;=410.41^^11^120^18
 ;;^UTILITY(U,$J,358.3,1345,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1345,1,4,0)
 ;;=4^410.41
 ;;^UTILITY(U,$J,358.3,1345,1,5,0)
 ;;=5^Acute MI, Inferorposterior, Initial
 ;;^UTILITY(U,$J,358.3,1345,2)
 ;;=Acute MI, Inferorposterior, Initial^269655
 ;;^UTILITY(U,$J,358.3,1346,0)
 ;;=410.42^^11^120^8
 ;;^UTILITY(U,$J,358.3,1346,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1346,1,4,0)
 ;;=4^410.42
 ;;^UTILITY(U,$J,358.3,1346,1,5,0)
 ;;=5^Acute MI Inferior, Subsequent
 ;;^UTILITY(U,$J,358.3,1346,2)
 ;;=Acute MI Inferior, Subsequent^269656
 ;;^UTILITY(U,$J,358.3,1347,0)
 ;;=410.51^^11^120^19
 ;;^UTILITY(U,$J,358.3,1347,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1347,1,4,0)
 ;;=4^410.51
 ;;^UTILITY(U,$J,358.3,1347,1,5,0)
 ;;=5^Acute MI, Lateral, Initial
 ;;^UTILITY(U,$J,358.3,1347,2)
 ;;=Acute MI, Lateral, Initial^269659
 ;;^UTILITY(U,$J,358.3,1348,0)
 ;;=410.52^^11^120^20
 ;;^UTILITY(U,$J,358.3,1348,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1348,1,4,0)
 ;;=4^410.52
 ;;^UTILITY(U,$J,358.3,1348,1,5,0)
 ;;=5^Acute MI, Lateral, Subsequent
 ;;^UTILITY(U,$J,358.3,1348,2)
 ;;=Acute MI, Lateral, Subsequent^269660
 ;;^UTILITY(U,$J,358.3,1349,0)
 ;;=410.61^^11^120^2
 ;;^UTILITY(U,$J,358.3,1349,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1349,1,4,0)
 ;;=4^410.61
 ;;^UTILITY(U,$J,358.3,1349,1,5,0)
 ;;=5^AMI Post, Initial
 ;;^UTILITY(U,$J,358.3,1349,2)
 ;;=^269663
 ;;^UTILITY(U,$J,358.3,1350,0)
 ;;=410.62^^11^120^3
 ;;^UTILITY(U,$J,358.3,1350,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1350,1,4,0)
 ;;=4^410.62
 ;;^UTILITY(U,$J,358.3,1350,1,5,0)
 ;;=5^AMI Post, Subsequent
 ;;^UTILITY(U,$J,358.3,1350,2)
 ;;=^269664
 ;;^UTILITY(U,$J,358.3,1351,0)
 ;;=410.71^^11^120^21
 ;;^UTILITY(U,$J,358.3,1351,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1351,1,4,0)
 ;;=4^410.71
 ;;^UTILITY(U,$J,358.3,1351,1,5,0)
 ;;=5^Acute MI, Non Q Wave, Initial
 ;;^UTILITY(U,$J,358.3,1351,2)
 ;;=Acute MI, Non Q Wave, Initial^269667
 ;;^UTILITY(U,$J,358.3,1352,0)
 ;;=410.72^^11^120^22
 ;;^UTILITY(U,$J,358.3,1352,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1352,1,4,0)
 ;;=4^410.72
 ;;^UTILITY(U,$J,358.3,1352,1,5,0)
 ;;=5^Acute MI, Non-Q Wave, Subsequent
 ;;^UTILITY(U,$J,358.3,1352,2)
 ;;=Acute MI, Non-Q Wave, Subsequent^269668
 ;;^UTILITY(U,$J,358.3,1353,0)
 ;;=410.81^^11^120^23
 ;;^UTILITY(U,$J,358.3,1353,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1353,1,4,0)
 ;;=4^410.81
 ;;^UTILITY(U,$J,358.3,1353,1,5,0)
 ;;=5^Acute MI, Other, Initial
 ;;^UTILITY(U,$J,358.3,1353,2)
 ;;=Acute MI, Other, Initial^269671
 ;;^UTILITY(U,$J,358.3,1354,0)
 ;;=410.82^^11^120^24
 ;;^UTILITY(U,$J,358.3,1354,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1354,1,4,0)
 ;;=4^410.82
 ;;^UTILITY(U,$J,358.3,1354,1,5,0)
 ;;=5^Acute MI, Subseqent
 ;;^UTILITY(U,$J,358.3,1354,2)
 ;;=Acute MI, Subseqent^269672
 ;;^UTILITY(U,$J,358.3,1355,0)
 ;;=410.91^^11^120^4
 ;;^UTILITY(U,$J,358.3,1355,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1355,1,4,0)
 ;;=4^410.91
 ;;^UTILITY(U,$J,358.3,1355,1,5,0)
 ;;=5^AMI Unspec
 ;;^UTILITY(U,$J,358.3,1355,2)
 ;;=^269674
 ;;^UTILITY(U,$J,358.3,1356,0)
 ;;=410.92^^11^120^5
 ;;^UTILITY(U,$J,358.3,1356,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1356,1,4,0)
 ;;=4^410.92
 ;;^UTILITY(U,$J,358.3,1356,1,5,0)
 ;;=5^AMI Unspec, Subsequent
