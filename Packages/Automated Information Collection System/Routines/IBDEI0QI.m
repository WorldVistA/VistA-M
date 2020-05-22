IBDEI0QI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11835,1,3,0)
 ;;=3^Combined Systolic/Diastolic Hrt Failure,Unspec
 ;;^UTILITY(U,$J,358.3,11835,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,11835,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,11836,0)
 ;;=I50.41^^80^760^2
 ;;^UTILITY(U,$J,358.3,11836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11836,1,3,0)
 ;;=3^Acute Combined Systolic/Diastolic Hrt Failure
 ;;^UTILITY(U,$J,358.3,11836,1,4,0)
 ;;=4^I50.41
 ;;^UTILITY(U,$J,358.3,11836,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,11837,0)
 ;;=I50.30^^80^760^16
 ;;^UTILITY(U,$J,358.3,11837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11837,1,3,0)
 ;;=3^Diastolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,11837,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,11837,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,11838,0)
 ;;=I50.31^^80^760^3
 ;;^UTILITY(U,$J,358.3,11838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11838,1,3,0)
 ;;=3^Acute Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,11838,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,11838,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,11839,0)
 ;;=I50.32^^80^760^13
 ;;^UTILITY(U,$J,358.3,11839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11839,1,3,0)
 ;;=3^Chronic Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,11839,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,11839,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,11840,0)
 ;;=I50.33^^80^760^6
 ;;^UTILITY(U,$J,358.3,11840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11840,1,3,0)
 ;;=3^Acute on Chronic Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,11840,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,11840,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,11841,0)
 ;;=I50.21^^80^760^4
 ;;^UTILITY(U,$J,358.3,11841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11841,1,3,0)
 ;;=3^Acute Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,11841,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,11841,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,11842,0)
 ;;=I50.22^^80^760^14
 ;;^UTILITY(U,$J,358.3,11842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11842,1,3,0)
 ;;=3^Chronic Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,11842,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,11842,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,11843,0)
 ;;=I50.23^^80^760^7
 ;;^UTILITY(U,$J,358.3,11843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11843,1,3,0)
 ;;=3^Acute on Chronic Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,11843,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,11843,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,11844,0)
 ;;=I50.20^^80^760^28
 ;;^UTILITY(U,$J,358.3,11844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11844,1,3,0)
 ;;=3^Systolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,11844,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,11844,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,11845,0)
 ;;=I65.23^^80^760^23
 ;;^UTILITY(U,$J,358.3,11845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11845,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,11845,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,11845,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,11846,0)
 ;;=I65.22^^80^760^24
 ;;^UTILITY(U,$J,358.3,11846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11846,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,11846,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,11846,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,11847,0)
 ;;=I65.21^^80^760^26
 ;;^UTILITY(U,$J,358.3,11847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11847,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
