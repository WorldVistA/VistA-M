IBDEI0CL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5767,0)
 ;;=I65.29^^30^383^18
 ;;^UTILITY(U,$J,358.3,5767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5767,1,3,0)
 ;;=3^Occlusion & Stenosis Unspec Carotid Artery
 ;;^UTILITY(U,$J,358.3,5767,1,4,0)
 ;;=4^I65.29
 ;;^UTILITY(U,$J,358.3,5767,2)
 ;;=^5007363
 ;;^UTILITY(U,$J,358.3,5768,0)
 ;;=I65.22^^30^383^16
 ;;^UTILITY(U,$J,358.3,5768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5768,1,3,0)
 ;;=3^Occlusion & Stenosis Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,5768,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,5768,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,5769,0)
 ;;=I65.23^^30^383^15
 ;;^UTILITY(U,$J,358.3,5769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5769,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,5769,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,5769,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,5770,0)
 ;;=I65.21^^30^383^17
 ;;^UTILITY(U,$J,358.3,5770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5770,1,3,0)
 ;;=3^Occlusion & Stenosis Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,5770,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,5770,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,5771,0)
 ;;=I70.219^^30^383^3
 ;;^UTILITY(U,$J,358.3,5771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5771,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Unspec Extrm
 ;;^UTILITY(U,$J,358.3,5771,1,4,0)
 ;;=4^I70.219
 ;;^UTILITY(U,$J,358.3,5771,2)
 ;;=^5007582
 ;;^UTILITY(U,$J,358.3,5772,0)
 ;;=I70.213^^30^383^4
 ;;^UTILITY(U,$J,358.3,5772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5772,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Bilat Legs
 ;;^UTILITY(U,$J,358.3,5772,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,5772,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,5773,0)
 ;;=I70.212^^30^383^5
 ;;^UTILITY(U,$J,358.3,5773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5773,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Left Leg
 ;;^UTILITY(U,$J,358.3,5773,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,5773,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,5774,0)
 ;;=I70.211^^30^383^6
 ;;^UTILITY(U,$J,358.3,5774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5774,1,3,0)
 ;;=3^Athscl Native Arteries of Extrm w/ Intrmt Claud,Right Leg
 ;;^UTILITY(U,$J,358.3,5774,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,5774,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,5775,0)
 ;;=I70.25^^30^383^2
 ;;^UTILITY(U,$J,358.3,5775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5775,1,3,0)
 ;;=3^Athscl Native Arteries of Extremitis w/ Ulceration
 ;;^UTILITY(U,$J,358.3,5775,1,4,0)
 ;;=4^I70.25
 ;;^UTILITY(U,$J,358.3,5775,2)
 ;;=^5007602
 ;;^UTILITY(U,$J,358.3,5776,0)
 ;;=I70.249^^30^383^7
 ;;^UTILITY(U,$J,358.3,5776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5776,1,3,0)
 ;;=3^Athscl Natv Art of Lt Leg w/ Ulceration of Unspec Site
 ;;^UTILITY(U,$J,358.3,5776,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,5776,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,5777,0)
 ;;=I70.239^^30^383^8
 ;;^UTILITY(U,$J,358.3,5777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5777,1,3,0)
 ;;=3^Athscl Natv Art of Rt Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,5777,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,5777,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,5778,0)
 ;;=I70.269^^30^383^9
 ;;^UTILITY(U,$J,358.3,5778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5778,1,3,0)
 ;;=3^Athscl Natv Arteries of Extrm w/ Gangrene,Unspec Extremity
 ;;^UTILITY(U,$J,358.3,5778,1,4,0)
 ;;=4^I70.269
 ;;^UTILITY(U,$J,358.3,5778,2)
 ;;=^5007607
 ;;^UTILITY(U,$J,358.3,5779,0)
 ;;=I70.263^^30^383^10
 ;;^UTILITY(U,$J,358.3,5779,1,0)
 ;;=^358.31IA^4^2
