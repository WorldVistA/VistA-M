IBDEI0JE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9014,1,4,0)
 ;;=4^H25.11
 ;;^UTILITY(U,$J,358.3,9014,2)
 ;;=^5005284
 ;;^UTILITY(U,$J,358.3,9015,0)
 ;;=H25.12^^41^471^5
 ;;^UTILITY(U,$J,358.3,9015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9015,1,3,0)
 ;;=3^Cataract,Age-Related Nuclear,Left Eye
 ;;^UTILITY(U,$J,358.3,9015,1,4,0)
 ;;=4^H25.12
 ;;^UTILITY(U,$J,358.3,9015,2)
 ;;=^5005285
 ;;^UTILITY(U,$J,358.3,9016,0)
 ;;=H25.13^^41^471^4
 ;;^UTILITY(U,$J,358.3,9016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9016,1,3,0)
 ;;=3^Cataract,Age-Related Nuclear,Bilateral
 ;;^UTILITY(U,$J,358.3,9016,1,4,0)
 ;;=4^H25.13
 ;;^UTILITY(U,$J,358.3,9016,2)
 ;;=^5005286
 ;;^UTILITY(U,$J,358.3,9017,0)
 ;;=H40.013^^41^471^26
 ;;^UTILITY(U,$J,358.3,9017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9017,1,3,0)
 ;;=3^Open Angle w/ Boderline Findings,Low Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,9017,1,4,0)
 ;;=4^H40.013
 ;;^UTILITY(U,$J,358.3,9017,2)
 ;;=^5005726
 ;;^UTILITY(U,$J,358.3,9018,0)
 ;;=H40.012^^41^471^27
 ;;^UTILITY(U,$J,358.3,9018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9018,1,3,0)
 ;;=3^Open Angle w/ Boderline Findings,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,9018,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,9018,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,9019,0)
 ;;=H40.011^^41^471^28
 ;;^UTILITY(U,$J,358.3,9019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9019,1,3,0)
 ;;=3^Open Angle w/ Boderline Findings,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,9019,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,9019,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,9020,0)
 ;;=H54.0^^41^472^1
 ;;^UTILITY(U,$J,358.3,9020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9020,1,3,0)
 ;;=3^Blindness,Both Eyes
 ;;^UTILITY(U,$J,358.3,9020,1,4,0)
 ;;=4^H54.0
 ;;^UTILITY(U,$J,358.3,9020,2)
 ;;=^5006357
 ;;^UTILITY(U,$J,358.3,9021,0)
 ;;=H54.12^^41^472^2
 ;;^UTILITY(U,$J,358.3,9021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9021,1,3,0)
 ;;=3^Blindness-Left Eye/Low Vision-Right Eye
 ;;^UTILITY(U,$J,358.3,9021,1,4,0)
 ;;=4^H54.12
 ;;^UTILITY(U,$J,358.3,9021,2)
 ;;=^5006360
 ;;^UTILITY(U,$J,358.3,9022,0)
 ;;=H54.11^^41^472^5
 ;;^UTILITY(U,$J,358.3,9022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9022,1,3,0)
 ;;=3^Blindness-Right Eye/Low Vision-Left Eye
 ;;^UTILITY(U,$J,358.3,9022,1,4,0)
 ;;=4^H54.11
 ;;^UTILITY(U,$J,358.3,9022,2)
 ;;=^5006359
 ;;^UTILITY(U,$J,358.3,9023,0)
 ;;=H54.2^^41^472^8
 ;;^UTILITY(U,$J,358.3,9023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9023,1,3,0)
 ;;=3^Low Vision,Both Eyes
 ;;^UTILITY(U,$J,358.3,9023,1,4,0)
 ;;=4^H54.2
 ;;^UTILITY(U,$J,358.3,9023,2)
 ;;=^5006361
 ;;^UTILITY(U,$J,358.3,9024,0)
 ;;=H54.3^^41^472^9
 ;;^UTILITY(U,$J,358.3,9024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9024,1,3,0)
 ;;=3^Unqualified Visual Loss,Both Eyes
 ;;^UTILITY(U,$J,358.3,9024,1,4,0)
 ;;=4^H54.3
 ;;^UTILITY(U,$J,358.3,9024,2)
 ;;=^268886
 ;;^UTILITY(U,$J,358.3,9025,0)
 ;;=H54.41^^41^472^6
 ;;^UTILITY(U,$J,358.3,9025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9025,1,3,0)
 ;;=3^Blindness-Right Eye/Normal Vision-Left Eye
 ;;^UTILITY(U,$J,358.3,9025,1,4,0)
 ;;=4^H54.41
 ;;^UTILITY(U,$J,358.3,9025,2)
 ;;=^5006363
 ;;^UTILITY(U,$J,358.3,9026,0)
 ;;=H54.42^^41^472^3
 ;;^UTILITY(U,$J,358.3,9026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9026,1,3,0)
 ;;=3^Blindness-Left Eye/Normal Vision-Right Eye
 ;;^UTILITY(U,$J,358.3,9026,1,4,0)
 ;;=4^H54.42
 ;;^UTILITY(U,$J,358.3,9026,2)
 ;;=^5133518
 ;;^UTILITY(U,$J,358.3,9027,0)
 ;;=H54.7^^41^472^10
 ;;^UTILITY(U,$J,358.3,9027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9027,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,9027,1,4,0)
 ;;=4^H54.7
