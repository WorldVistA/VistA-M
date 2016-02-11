IBDEI1I9 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25154,1,3,0)
 ;;=3^Dilated Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,25154,1,4,0)
 ;;=4^I42.0
 ;;^UTILITY(U,$J,358.3,25154,2)
 ;;=^5007194
 ;;^UTILITY(U,$J,358.3,25155,0)
 ;;=I50.21^^124^1240^5
 ;;^UTILITY(U,$J,358.3,25155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25155,1,3,0)
 ;;=3^Acute Systolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,25155,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,25155,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,25156,0)
 ;;=I50.22^^124^1240^19
 ;;^UTILITY(U,$J,358.3,25156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25156,1,3,0)
 ;;=3^Chronic Systolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,25156,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,25156,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,25157,0)
 ;;=I50.23^^124^1240^8
 ;;^UTILITY(U,$J,358.3,25157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25157,1,3,0)
 ;;=3^Acute on Chronic Systolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,25157,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,25157,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,25158,0)
 ;;=I50.31^^124^1240^4
 ;;^UTILITY(U,$J,358.3,25158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25158,1,3,0)
 ;;=3^Acute Diastolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,25158,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,25158,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,25159,0)
 ;;=I50.32^^124^1240^18
 ;;^UTILITY(U,$J,358.3,25159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25159,1,3,0)
 ;;=3^Chronic Diastolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,25159,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,25159,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,25160,0)
 ;;=I50.33^^124^1240^7
 ;;^UTILITY(U,$J,358.3,25160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25160,1,3,0)
 ;;=3^Acute on Chronic Diastolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,25160,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,25160,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,25161,0)
 ;;=I50.41^^124^1240^3
 ;;^UTILITY(U,$J,358.3,25161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25161,1,3,0)
 ;;=3^Acute Combined Systolic & Diastolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,25161,1,4,0)
 ;;=4^I50.41
 ;;^UTILITY(U,$J,358.3,25161,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,25162,0)
 ;;=I50.42^^124^1240^17
 ;;^UTILITY(U,$J,358.3,25162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25162,1,3,0)
 ;;=3^Chronic Combined Systolic & Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,25162,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,25162,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,25163,0)
 ;;=I50.43^^124^1240^6
 ;;^UTILITY(U,$J,358.3,25163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25163,1,3,0)
 ;;=3^Acute on Chronic Combined Systolic & Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,25163,1,4,0)
 ;;=4^I50.43
 ;;^UTILITY(U,$J,358.3,25163,2)
 ;;=^5007250
 ;;^UTILITY(U,$J,358.3,25164,0)
 ;;=I21.3^^124^1240^47
 ;;^UTILITY(U,$J,358.3,25164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25164,1,3,0)
 ;;=3^STEMI,Unspec Site,Initial
 ;;^UTILITY(U,$J,358.3,25164,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,25164,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,25165,0)
 ;;=I21.4^^124^1240^23
 ;;^UTILITY(U,$J,358.3,25165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25165,1,3,0)
 ;;=3^NSTEMI,Initial
 ;;^UTILITY(U,$J,358.3,25165,1,4,0)
 ;;=4^I21.4
 ;;^UTILITY(U,$J,358.3,25165,2)
 ;;=^5007088
 ;;^UTILITY(U,$J,358.3,25166,0)
 ;;=I21.01^^124^1240^42
 ;;^UTILITY(U,$J,358.3,25166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25166,1,3,0)
 ;;=3^STEMI,Lt Main Coronary Artery,Initial
 ;;^UTILITY(U,$J,358.3,25166,1,4,0)
 ;;=4^I21.01
 ;;^UTILITY(U,$J,358.3,25166,2)
 ;;=^5007080
