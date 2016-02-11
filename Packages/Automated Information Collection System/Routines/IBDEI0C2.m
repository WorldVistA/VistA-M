IBDEI0C2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5199,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,5199,1,4,0)
 ;;=4^C50.521
 ;;^UTILITY(U,$J,358.3,5199,2)
 ;;=^5001182
 ;;^UTILITY(U,$J,358.3,5200,0)
 ;;=C50.522^^40^356^9
 ;;^UTILITY(U,$J,358.3,5200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5200,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,5200,1,4,0)
 ;;=4^C50.522
 ;;^UTILITY(U,$J,358.3,5200,2)
 ;;=^5133338
 ;;^UTILITY(U,$J,358.3,5201,0)
 ;;=C50.621^^40^356^3
 ;;^UTILITY(U,$J,358.3,5201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5201,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Right Breast
 ;;^UTILITY(U,$J,358.3,5201,1,4,0)
 ;;=4^C50.621
 ;;^UTILITY(U,$J,358.3,5201,2)
 ;;=^5001186
 ;;^UTILITY(U,$J,358.3,5202,0)
 ;;=C50.622^^40^356^2
 ;;^UTILITY(U,$J,358.3,5202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5202,1,3,0)
 ;;=3^Malig Neop of Axillary Tail of Left Breast
 ;;^UTILITY(U,$J,358.3,5202,1,4,0)
 ;;=4^C50.622
 ;;^UTILITY(U,$J,358.3,5202,2)
 ;;=^5001187
 ;;^UTILITY(U,$J,358.3,5203,0)
 ;;=C50.821^^40^356^14
 ;;^UTILITY(U,$J,358.3,5203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5203,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Right Breast
 ;;^UTILITY(U,$J,358.3,5203,1,4,0)
 ;;=4^C50.821
 ;;^UTILITY(U,$J,358.3,5203,2)
 ;;=^5001192
 ;;^UTILITY(U,$J,358.3,5204,0)
 ;;=C50.822^^40^356^13
 ;;^UTILITY(U,$J,358.3,5204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5204,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Left Breast
 ;;^UTILITY(U,$J,358.3,5204,1,4,0)
 ;;=4^C50.822
 ;;^UTILITY(U,$J,358.3,5204,2)
 ;;=^5001193
 ;;^UTILITY(U,$J,358.3,5205,0)
 ;;=C50.921^^40^356^15
 ;;^UTILITY(U,$J,358.3,5205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5205,1,3,0)
 ;;=3^Malig Neop of Right Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,5205,1,4,0)
 ;;=4^C50.921
 ;;^UTILITY(U,$J,358.3,5205,2)
 ;;=^5001198
 ;;^UTILITY(U,$J,358.3,5206,0)
 ;;=C50.922^^40^356^6
 ;;^UTILITY(U,$J,358.3,5206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5206,1,3,0)
 ;;=3^Malig Neop of Left Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,5206,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,5206,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,5207,0)
 ;;=N62.^^40^356^1
 ;;^UTILITY(U,$J,358.3,5207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5207,1,3,0)
 ;;=3^Hypertrophy of Breast
 ;;^UTILITY(U,$J,358.3,5207,1,4,0)
 ;;=4^N62.
 ;;^UTILITY(U,$J,358.3,5207,2)
 ;;=^5015790
 ;;^UTILITY(U,$J,358.3,5208,0)
 ;;=I25.10^^40^357^8
 ;;^UTILITY(U,$J,358.3,5208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5208,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,5208,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,5208,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,5209,0)
 ;;=I50.9^^40^357^22
 ;;^UTILITY(U,$J,358.3,5209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5209,1,3,0)
 ;;=3^Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,5209,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,5209,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,5210,0)
 ;;=I50.43^^40^357^5
 ;;^UTILITY(U,$J,358.3,5210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5210,1,3,0)
 ;;=3^Acute on Chronic Combined Systolic/Diastolic Hrt Failure
 ;;^UTILITY(U,$J,358.3,5210,1,4,0)
 ;;=4^I50.43
 ;;^UTILITY(U,$J,358.3,5210,2)
 ;;=^5007250
 ;;^UTILITY(U,$J,358.3,5211,0)
 ;;=I50.42^^40^357^12
 ;;^UTILITY(U,$J,358.3,5211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5211,1,3,0)
 ;;=3^Chronic Combined Systolic/Diastolic Hrt Failure
 ;;^UTILITY(U,$J,358.3,5211,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,5211,2)
 ;;=^5007249
