IBDEI0C3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5212,0)
 ;;=I50.40^^40^357^15
 ;;^UTILITY(U,$J,358.3,5212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5212,1,3,0)
 ;;=3^Combined Systolic/Diastolic Hrt Failure,Unspec
 ;;^UTILITY(U,$J,358.3,5212,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,5212,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,5213,0)
 ;;=I50.41^^40^357^2
 ;;^UTILITY(U,$J,358.3,5213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5213,1,3,0)
 ;;=3^Acute Combined Systolic/Diastolic Hrt Failure
 ;;^UTILITY(U,$J,358.3,5213,1,4,0)
 ;;=4^I50.41
 ;;^UTILITY(U,$J,358.3,5213,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,5214,0)
 ;;=I50.30^^40^357^16
 ;;^UTILITY(U,$J,358.3,5214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5214,1,3,0)
 ;;=3^Diastolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,5214,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,5214,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,5215,0)
 ;;=I50.31^^40^357^3
 ;;^UTILITY(U,$J,358.3,5215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5215,1,3,0)
 ;;=3^Acute Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,5215,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,5215,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,5216,0)
 ;;=I50.32^^40^357^13
 ;;^UTILITY(U,$J,358.3,5216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5216,1,3,0)
 ;;=3^Chronic Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,5216,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,5216,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,5217,0)
 ;;=I50.33^^40^357^6
 ;;^UTILITY(U,$J,358.3,5217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5217,1,3,0)
 ;;=3^Acute on Chronic Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,5217,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,5217,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,5218,0)
 ;;=I50.21^^40^357^4
 ;;^UTILITY(U,$J,358.3,5218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5218,1,3,0)
 ;;=3^Acute Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,5218,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,5218,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,5219,0)
 ;;=I50.22^^40^357^14
 ;;^UTILITY(U,$J,358.3,5219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5219,1,3,0)
 ;;=3^Chronic Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,5219,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,5219,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,5220,0)
 ;;=I50.23^^40^357^7
 ;;^UTILITY(U,$J,358.3,5220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5220,1,3,0)
 ;;=3^Acute on Chronic Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,5220,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,5220,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,5221,0)
 ;;=I50.20^^40^357^28
 ;;^UTILITY(U,$J,358.3,5221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5221,1,3,0)
 ;;=3^Systolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,5221,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,5221,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,5222,0)
 ;;=I65.23^^40^357^23
 ;;^UTILITY(U,$J,358.3,5222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5222,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,5222,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,5222,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,5223,0)
 ;;=I65.22^^40^357^24
 ;;^UTILITY(U,$J,358.3,5223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5223,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,5223,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,5223,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,5224,0)
 ;;=I65.21^^40^357^26
 ;;^UTILITY(U,$J,358.3,5224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5224,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,5224,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,5224,2)
 ;;=^5007360
