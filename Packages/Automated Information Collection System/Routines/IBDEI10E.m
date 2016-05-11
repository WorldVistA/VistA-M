IBDEI10E ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17116,0)
 ;;=Z69.011^^70^809^12
 ;;^UTILITY(U,$J,358.3,17116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17116,1,3,0)
 ;;=3^Encntr for mntl hlth serv for perp of prntl child abuse
 ;;^UTILITY(U,$J,358.3,17116,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,17116,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,17117,0)
 ;;=Z91.120^^70^809^38
 ;;^UTILITY(U,$J,358.3,17117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17117,1,3,0)
 ;;=3^Pt's intent underdose of meds d/t financial hardship
 ;;^UTILITY(U,$J,358.3,17117,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,17117,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,17118,0)
 ;;=Z91.128^^70^809^39
 ;;^UTILITY(U,$J,358.3,17118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17118,1,3,0)
 ;;=3^Pt's intent underdose of meds d/t oth reasons
 ;;^UTILITY(U,$J,358.3,17118,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,17118,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,17119,0)
 ;;=Z63.71^^70^809^44
 ;;^UTILITY(U,$J,358.3,17119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17119,1,3,0)
 ;;=3^Stress on family d/t rtrn of family member from deployment
 ;;^UTILITY(U,$J,358.3,17119,1,4,0)
 ;;=4^Z63.71
 ;;^UTILITY(U,$J,358.3,17119,2)
 ;;=^5063171
 ;;^UTILITY(U,$J,358.3,17120,0)
 ;;=Z03.89^^70^810^1
 ;;^UTILITY(U,$J,358.3,17120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17120,1,3,0)
 ;;=3^Observation for Suspected Diseases & Condition Ruled Out
 ;;^UTILITY(U,$J,358.3,17120,1,4,0)
 ;;=4^Z03.89
 ;;^UTILITY(U,$J,358.3,17120,2)
 ;;=^5062656
 ;;^UTILITY(U,$J,358.3,17121,0)
 ;;=E11.9^^70^811^11
 ;;^UTILITY(U,$J,358.3,17121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17121,1,3,0)
 ;;=3^Type 2 DM w/o Complications
 ;;^UTILITY(U,$J,358.3,17121,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,17121,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,17122,0)
 ;;=E11.65^^70^811^9
 ;;^UTILITY(U,$J,358.3,17122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17122,1,3,0)
 ;;=3^Type 2 DM w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,17122,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,17122,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,17123,0)
 ;;=E10.9^^70^811^6
 ;;^UTILITY(U,$J,358.3,17123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17123,1,3,0)
 ;;=3^Type 1 DM w/o Complications
 ;;^UTILITY(U,$J,358.3,17123,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,17123,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,17124,0)
 ;;=E10.65^^70^811^4
 ;;^UTILITY(U,$J,358.3,17124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17124,1,3,0)
 ;;=3^Type 1 DM w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,17124,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,17124,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,17125,0)
 ;;=E11.42^^70^811^7
 ;;^UTILITY(U,$J,358.3,17125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17125,1,3,0)
 ;;=3^Type 2 DM w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,17125,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,17125,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,17126,0)
 ;;=E10.42^^70^811^2
 ;;^UTILITY(U,$J,358.3,17126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17126,1,3,0)
 ;;=3^Type 1 DM w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,17126,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,17126,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,17127,0)
 ;;=E13.42^^70^811^1
 ;;^UTILITY(U,$J,358.3,17127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17127,1,3,0)
 ;;=3^Secondary Type DM w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,17127,1,4,0)
 ;;=4^E13.42
 ;;^UTILITY(U,$J,358.3,17127,2)
 ;;=^5002686
 ;;^UTILITY(U,$J,358.3,17128,0)
 ;;=E10.621^^70^811^3
 ;;^UTILITY(U,$J,358.3,17128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17128,1,3,0)
 ;;=3^Type 1 DM w/ Foot Ulcer
