IBDEI0FF ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6643,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,6644,0)
 ;;=I50.30^^53^429^4
 ;;^UTILITY(U,$J,358.3,6644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6644,1,3,0)
 ;;=3^Heart Failure,Diastolic,Unspec
 ;;^UTILITY(U,$J,358.3,6644,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,6644,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,6645,0)
 ;;=I50.31^^53^429^1
 ;;^UTILITY(U,$J,358.3,6645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6645,1,3,0)
 ;;=3^Heart Failure,Diastolic,Acute
 ;;^UTILITY(U,$J,358.3,6645,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,6645,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,6646,0)
 ;;=I50.32^^53^429^3
 ;;^UTILITY(U,$J,358.3,6646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6646,1,3,0)
 ;;=3^Heart Failure,Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,6646,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,6646,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,6647,0)
 ;;=I50.33^^53^429^2
 ;;^UTILITY(U,$J,358.3,6647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6647,1,3,0)
 ;;=3^Heart Failure,Diastolic,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6647,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,6647,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,6648,0)
 ;;=I50.40^^53^429^8
 ;;^UTILITY(U,$J,358.3,6648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6648,1,3,0)
 ;;=3^Heart Failure,Systolic & Diastolic,Unspec
 ;;^UTILITY(U,$J,358.3,6648,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,6648,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,6649,0)
 ;;=I50.41^^53^429^5
 ;;^UTILITY(U,$J,358.3,6649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6649,1,3,0)
 ;;=3^Heart Failure,Systolic & Diastolic,Acute
 ;;^UTILITY(U,$J,358.3,6649,1,4,0)
 ;;=4^I50.41
 ;;^UTILITY(U,$J,358.3,6649,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,6650,0)
 ;;=I50.42^^53^429^7
 ;;^UTILITY(U,$J,358.3,6650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6650,1,3,0)
 ;;=3^Heart Failure,Systolic & Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,6650,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,6650,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,6651,0)
 ;;=I50.43^^53^429^6
 ;;^UTILITY(U,$J,358.3,6651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6651,1,3,0)
 ;;=3^Heart Failure,Systolic & Diastolic,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,6651,1,4,0)
 ;;=4^I50.43
 ;;^UTILITY(U,$J,358.3,6651,2)
 ;;=^5007250
 ;;^UTILITY(U,$J,358.3,6652,0)
 ;;=I50.9^^53^429^13
 ;;^UTILITY(U,$J,358.3,6652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6652,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,6652,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,6652,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,6653,0)
 ;;=I09.81^^53^429^15
 ;;^UTILITY(U,$J,358.3,6653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6653,1,3,0)
 ;;=3^Rheumatic Heart Failure
 ;;^UTILITY(U,$J,358.3,6653,1,4,0)
 ;;=4^I09.81
 ;;^UTILITY(U,$J,358.3,6653,2)
 ;;=^5007059
 ;;^UTILITY(U,$J,358.3,6654,0)
 ;;=I10.^^53^430^1
 ;;^UTILITY(U,$J,358.3,6654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6654,1,3,0)
 ;;=3^Essential/Primary Hypertension
 ;;^UTILITY(U,$J,358.3,6654,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,6654,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,6655,0)
 ;;=I11.0^^53^430^12
 ;;^UTILITY(U,$J,358.3,6655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6655,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure
 ;;^UTILITY(U,$J,358.3,6655,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,6655,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,6656,0)
 ;;=I11.9^^53^430^13
 ;;^UTILITY(U,$J,358.3,6656,1,0)
 ;;=^358.31IA^4^2
