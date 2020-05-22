IBDEI0G8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7024,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7024,1,2,0)
 ;;=2^97804
 ;;^UTILITY(U,$J,358.3,7024,1,3,0)
 ;;=3^Medical Nutrition Tx;Init,Grp,Ea 30 min
 ;;^UTILITY(U,$J,358.3,7025,0)
 ;;=G0270^^57^456^4^^^^1
 ;;^UTILITY(U,$J,358.3,7025,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7025,1,2,0)
 ;;=2^G0270
 ;;^UTILITY(U,$J,358.3,7025,1,3,0)
 ;;=3^Medical Nutrition Tx;Reassess,Ind,F-T-F,Ea 30 min
 ;;^UTILITY(U,$J,358.3,7026,0)
 ;;=G0271^^57^456^3^^^^1
 ;;^UTILITY(U,$J,358.3,7026,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7026,1,2,0)
 ;;=2^G0271
 ;;^UTILITY(U,$J,358.3,7026,1,3,0)
 ;;=3^Medical Nutrition Tx;Reassess,Grp,Ea 30 min
 ;;^UTILITY(U,$J,358.3,7027,0)
 ;;=S9452^^57^456^5^^^^1
 ;;^UTILITY(U,$J,358.3,7027,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7027,1,2,0)
 ;;=2^S9452
 ;;^UTILITY(U,$J,358.3,7027,1,3,0)
 ;;=3^Nutrition Classes,Non-Phys,per Session
 ;;^UTILITY(U,$J,358.3,7028,0)
 ;;=S5190^^57^456^6^^^^1
 ;;^UTILITY(U,$J,358.3,7028,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7028,1,2,0)
 ;;=2^S5190
 ;;^UTILITY(U,$J,358.3,7028,1,3,0)
 ;;=3^Well Assess by Non-MD
 ;;^UTILITY(U,$J,358.3,7029,0)
 ;;=Z02.9^^58^457^7
 ;;^UTILITY(U,$J,358.3,7029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7029,1,3,0)
 ;;=3^Administrative Examinations,Unspec
 ;;^UTILITY(U,$J,358.3,7029,1,4,0)
 ;;=4^Z02.9
 ;;^UTILITY(U,$J,358.3,7029,2)
 ;;=^5062646
 ;;^UTILITY(U,$J,358.3,7030,0)
 ;;=Z71.3^^58^457^8
 ;;^UTILITY(U,$J,358.3,7030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7030,1,3,0)
 ;;=3^Dietary Counseling and Surveillance
 ;;^UTILITY(U,$J,358.3,7030,1,4,0)
 ;;=4^Z71.3
 ;;^UTILITY(U,$J,358.3,7030,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,7031,0)
 ;;=Z71.89^^58^457^9
 ;;^UTILITY(U,$J,358.3,7031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7031,1,3,0)
 ;;=3^Counseling,Oth Specified
 ;;^UTILITY(U,$J,358.3,7031,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,7031,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,7032,0)
 ;;=Z71.9^^58^457^10
 ;;^UTILITY(U,$J,358.3,7032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7032,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,7032,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,7032,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,7033,0)
 ;;=Z73.3^^58^457^11
 ;;^UTILITY(U,$J,358.3,7033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7033,1,3,0)
 ;;=3^Stress NEC
 ;;^UTILITY(U,$J,358.3,7033,1,4,0)
 ;;=4^Z73.3
 ;;^UTILITY(U,$J,358.3,7033,2)
 ;;=^5063271
 ;;^UTILITY(U,$J,358.3,7034,0)
 ;;=Z87.820^^58^458^2
 ;;^UTILITY(U,$J,358.3,7034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7034,1,3,0)
 ;;=3^Personal Hx of TBI
 ;;^UTILITY(U,$J,358.3,7034,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,7034,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,7035,0)
 ;;=Z85.830^^58^458^1
 ;;^UTILITY(U,$J,358.3,7035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7035,1,3,0)
 ;;=3^Personal Hx of Malig Neop of Bone
 ;;^UTILITY(U,$J,358.3,7035,1,4,0)
 ;;=4^Z85.830
 ;;^UTILITY(U,$J,358.3,7035,2)
 ;;=^5063444
 ;;^UTILITY(U,$J,358.3,7036,0)
 ;;=Z96.651^^58^458^3
 ;;^UTILITY(U,$J,358.3,7036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7036,1,3,0)
 ;;=3^Presence of Right Artificial Knee Joint
 ;;^UTILITY(U,$J,358.3,7036,1,4,0)
 ;;=4^Z96.651
 ;;^UTILITY(U,$J,358.3,7036,2)
 ;;=^5063705
 ;;^UTILITY(U,$J,358.3,7037,0)
 ;;=Z96.652^^58^458^4
 ;;^UTILITY(U,$J,358.3,7037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7037,1,3,0)
 ;;=3^Presence of Left Artificial Knee Joint
