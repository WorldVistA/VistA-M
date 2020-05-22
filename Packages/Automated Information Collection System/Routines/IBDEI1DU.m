IBDEI1DU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22095,1,3,0)
 ;;=3^Counseling,Dietary
 ;;^UTILITY(U,$J,358.3,22095,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,22095,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,22096,0)
 ;;=Z71.6^^99^1125^7
 ;;^UTILITY(U,$J,358.3,22096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22096,1,3,0)
 ;;=3^Counseling,Tobacco Abuse
 ;;^UTILITY(U,$J,358.3,22096,1,4,0)
 ;;=4^Z71.6
 ;;^UTILITY(U,$J,358.3,22096,2)
 ;;=^5063250
 ;;^UTILITY(U,$J,358.3,22097,0)
 ;;=Z69.011^^99^1125^12
 ;;^UTILITY(U,$J,358.3,22097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22097,1,3,0)
 ;;=3^Encntr for mntl hlth serv for perp of prntl child abuse
 ;;^UTILITY(U,$J,358.3,22097,1,4,0)
 ;;=4^Z69.011
 ;;^UTILITY(U,$J,358.3,22097,2)
 ;;=^5063229
 ;;^UTILITY(U,$J,358.3,22098,0)
 ;;=Z91.120^^99^1125^39
 ;;^UTILITY(U,$J,358.3,22098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22098,1,3,0)
 ;;=3^Pt's intent underdose of meds d/t financial hardship
 ;;^UTILITY(U,$J,358.3,22098,1,4,0)
 ;;=4^Z91.120
 ;;^UTILITY(U,$J,358.3,22098,2)
 ;;=^5063612
 ;;^UTILITY(U,$J,358.3,22099,0)
 ;;=Z91.128^^99^1125^40
 ;;^UTILITY(U,$J,358.3,22099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22099,1,3,0)
 ;;=3^Pt's intent underdose of meds d/t oth reasons
 ;;^UTILITY(U,$J,358.3,22099,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,22099,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,22100,0)
 ;;=Z63.71^^99^1125^45
 ;;^UTILITY(U,$J,358.3,22100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22100,1,3,0)
 ;;=3^Stress on family d/t rtrn of family member from deployment
 ;;^UTILITY(U,$J,358.3,22100,1,4,0)
 ;;=4^Z63.71
 ;;^UTILITY(U,$J,358.3,22100,2)
 ;;=^5063171
 ;;^UTILITY(U,$J,358.3,22101,0)
 ;;=Z79.84^^99^1125^30
 ;;^UTILITY(U,$J,358.3,22101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22101,1,3,0)
 ;;=3^Long term (current) use of oral hypoglycemic drugs
 ;;^UTILITY(U,$J,358.3,22101,1,4,0)
 ;;=4^Z79.84
 ;;^UTILITY(U,$J,358.3,22101,2)
 ;;=^5140432
 ;;^UTILITY(U,$J,358.3,22102,0)
 ;;=Z03.89^^99^1126^1
 ;;^UTILITY(U,$J,358.3,22102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22102,1,3,0)
 ;;=3^Observation for Suspected Diseases & Condition Ruled Out
 ;;^UTILITY(U,$J,358.3,22102,1,4,0)
 ;;=4^Z03.89
 ;;^UTILITY(U,$J,358.3,22102,2)
 ;;=^5062656
 ;;^UTILITY(U,$J,358.3,22103,0)
 ;;=E11.9^^99^1127^13
 ;;^UTILITY(U,$J,358.3,22103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22103,1,3,0)
 ;;=3^Type 2 DM w/o Complications
 ;;^UTILITY(U,$J,358.3,22103,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,22103,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,22104,0)
 ;;=E11.65^^99^1127^9
 ;;^UTILITY(U,$J,358.3,22104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22104,1,3,0)
 ;;=3^Type 2 DM w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,22104,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,22104,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,22105,0)
 ;;=E10.9^^99^1127^6
 ;;^UTILITY(U,$J,358.3,22105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22105,1,3,0)
 ;;=3^Type 1 DM w/o Complications
 ;;^UTILITY(U,$J,358.3,22105,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,22105,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,22106,0)
 ;;=E10.65^^99^1127^4
 ;;^UTILITY(U,$J,358.3,22106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22106,1,3,0)
 ;;=3^Type 1 DM w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,22106,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,22106,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,22107,0)
 ;;=E11.42^^99^1127^7
