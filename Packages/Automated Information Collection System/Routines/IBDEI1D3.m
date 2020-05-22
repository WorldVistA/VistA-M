IBDEI1D3 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21760,1,4,0)
 ;;=4^H91.90
 ;;^UTILITY(U,$J,358.3,21760,2)
 ;;=^5006943
 ;;^UTILITY(U,$J,358.3,21761,0)
 ;;=I10.^^99^1108^29
 ;;^UTILITY(U,$J,358.3,21761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21761,1,3,0)
 ;;=3^Hypertension, essential (primary)
 ;;^UTILITY(U,$J,358.3,21761,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,21761,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,21762,0)
 ;;=K64.8^^99^1108^15
 ;;^UTILITY(U,$J,358.3,21762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21762,1,3,0)
 ;;=3^Hemorrhoids, oth
 ;;^UTILITY(U,$J,358.3,21762,1,4,0)
 ;;=4^K64.8
 ;;^UTILITY(U,$J,358.3,21762,2)
 ;;=^5008774
 ;;^UTILITY(U,$J,358.3,21763,0)
 ;;=K64.4^^99^1108^14
 ;;^UTILITY(U,$J,358.3,21763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21763,1,3,0)
 ;;=3^Hemorrhoidal Skin Tags,Residual
 ;;^UTILITY(U,$J,358.3,21763,1,4,0)
 ;;=4^K64.4
 ;;^UTILITY(U,$J,358.3,21763,2)
 ;;=^269834
 ;;^UTILITY(U,$J,358.3,21764,0)
 ;;=I95.9^^99^1108^39
 ;;^UTILITY(U,$J,358.3,21764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21764,1,3,0)
 ;;=3^Hypotension, unspec
 ;;^UTILITY(U,$J,358.3,21764,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,21764,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,21765,0)
 ;;=K40.90^^99^1108^43
 ;;^UTILITY(U,$J,358.3,21765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21765,1,3,0)
 ;;=3^Uniltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,21765,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,21765,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,21766,0)
 ;;=K40.20^^99^1108^4
 ;;^UTILITY(U,$J,358.3,21766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21766,1,3,0)
 ;;=3^Biltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,21766,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,21766,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,21767,0)
 ;;=K42.9^^99^1108^42
 ;;^UTILITY(U,$J,358.3,21767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21767,1,3,0)
 ;;=3^Umbilical hernia w/o obst/gangr or gangrene
 ;;^UTILITY(U,$J,358.3,21767,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,21767,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,21768,0)
 ;;=K43.2^^99^1108^41
 ;;^UTILITY(U,$J,358.3,21768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21768,1,3,0)
 ;;=3^Incisional hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,21768,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,21768,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,21769,0)
 ;;=K44.9^^99^1108^5
 ;;^UTILITY(U,$J,358.3,21769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21769,1,3,0)
 ;;=3^Diaphragmatic hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,21769,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,21769,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,21770,0)
 ;;=K46.9^^99^1108^1
 ;;^UTILITY(U,$J,358.3,21770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21770,1,3,0)
 ;;=3^Abdominal hernia w/o obstr/gangr, unspec
 ;;^UTILITY(U,$J,358.3,21770,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,21770,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,21771,0)
 ;;=K73.9^^99^1108^20
 ;;^UTILITY(U,$J,358.3,21771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21771,1,3,0)
 ;;=3^Hepatitis C,Chronic Unspec
 ;;^UTILITY(U,$J,358.3,21771,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,21771,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,21772,0)
 ;;=R31.9^^99^1108^8
 ;;^UTILITY(U,$J,358.3,21772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21772,1,3,0)
 ;;=3^Hematuria, unspec
 ;;^UTILITY(U,$J,358.3,21772,1,4,0)
 ;;=4^R31.9
 ;;^UTILITY(U,$J,358.3,21772,2)
 ;;=^5019328
