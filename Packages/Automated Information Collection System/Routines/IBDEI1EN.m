IBDEI1EN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23448,1,3,0)
 ;;=3^Uniltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,23448,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,23448,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,23449,0)
 ;;=K40.20^^113^1130^4
 ;;^UTILITY(U,$J,358.3,23449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23449,1,3,0)
 ;;=3^Biltrl Ing hernia, w/o obst/ganr, not spcf as recur
 ;;^UTILITY(U,$J,358.3,23449,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,23449,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,23450,0)
 ;;=K42.9^^113^1130^35
 ;;^UTILITY(U,$J,358.3,23450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23450,1,3,0)
 ;;=3^Umbilical hernia w/o obst/gangr or gangrene
 ;;^UTILITY(U,$J,358.3,23450,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,23450,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,23451,0)
 ;;=K43.2^^113^1130^34
 ;;^UTILITY(U,$J,358.3,23451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23451,1,3,0)
 ;;=3^Incisional hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,23451,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,23451,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,23452,0)
 ;;=K44.9^^113^1130^5
 ;;^UTILITY(U,$J,358.3,23452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23452,1,3,0)
 ;;=3^Diaphragmatic hernia w/o obstr/gangr
 ;;^UTILITY(U,$J,358.3,23452,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,23452,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,23453,0)
 ;;=K46.9^^113^1130^1
 ;;^UTILITY(U,$J,358.3,23453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23453,1,3,0)
 ;;=3^Abdominal hernia w/o obstr/gangr, unspec
 ;;^UTILITY(U,$J,358.3,23453,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,23453,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,23454,0)
 ;;=K73.9^^113^1130^19
 ;;^UTILITY(U,$J,358.3,23454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23454,1,3,0)
 ;;=3^Hepatitis C,Chronic Unspec
 ;;^UTILITY(U,$J,358.3,23454,1,4,0)
 ;;=4^K73.9
 ;;^UTILITY(U,$J,358.3,23454,2)
 ;;=^5008815
 ;;^UTILITY(U,$J,358.3,23455,0)
 ;;=R31.9^^113^1130^8
 ;;^UTILITY(U,$J,358.3,23455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23455,1,3,0)
 ;;=3^Hematuria, unspec
 ;;^UTILITY(U,$J,358.3,23455,1,4,0)
 ;;=4^R31.9
 ;;^UTILITY(U,$J,358.3,23455,2)
 ;;=^5019328
 ;;^UTILITY(U,$J,358.3,23456,0)
 ;;=N43.3^^113^1130^22
 ;;^UTILITY(U,$J,358.3,23456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23456,1,3,0)
 ;;=3^Hydrocele, unspec
 ;;^UTILITY(U,$J,358.3,23456,1,4,0)
 ;;=4^N43.3
 ;;^UTILITY(U,$J,358.3,23456,2)
 ;;=^5015700
 ;;^UTILITY(U,$J,358.3,23457,0)
 ;;=R51.^^113^1130^6
 ;;^UTILITY(U,$J,358.3,23457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23457,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,23457,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,23457,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,23458,0)
 ;;=Z22.52^^113^1130^18
 ;;^UTILITY(U,$J,358.3,23458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23458,1,3,0)
 ;;=3^Hepatitis C Carrier
 ;;^UTILITY(U,$J,358.3,23458,1,4,0)
 ;;=4^Z22.52
 ;;^UTILITY(U,$J,358.3,23458,2)
 ;;=^5062790
 ;;^UTILITY(U,$J,358.3,23459,0)
 ;;=Z21.^^113^1130^3
 ;;^UTILITY(U,$J,358.3,23459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23459,1,3,0)
 ;;=3^Asymptomatic HIV infection status
 ;;^UTILITY(U,$J,358.3,23459,1,4,0)
 ;;=4^Z21.
 ;;^UTILITY(U,$J,358.3,23459,2)
 ;;=^5062777
 ;;^UTILITY(U,$J,358.3,23460,0)
 ;;=I69.959^^113^1130^16
 ;;^UTILITY(U,$J,358.3,23460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23460,1,3,0)
 ;;=3^Hemplga/Hempris folwng Cerebvasc Dz Aff Unspec Side
 ;;^UTILITY(U,$J,358.3,23460,1,4,0)
 ;;=4^I69.959
 ;;^UTILITY(U,$J,358.3,23460,2)
 ;;=^5007563
 ;;^UTILITY(U,$J,358.3,23461,0)
 ;;=K62.5^^113^1130^13
 ;;^UTILITY(U,$J,358.3,23461,1,0)
 ;;=^358.31IA^4^2
