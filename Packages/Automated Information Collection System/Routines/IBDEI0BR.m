IBDEI0BR ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5558,0)
 ;;=840.0^^45^496^53
 ;;^UTILITY(U,$J,358.3,5558,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5558,1,4,0)
 ;;=4^840.0
 ;;^UTILITY(U,$J,358.3,5558,1,5,0)
 ;;=5^Shoulder Sprain
 ;;^UTILITY(U,$J,358.3,5558,2)
 ;;=Shoulder Sprain^274465
 ;;^UTILITY(U,$J,358.3,5559,0)
 ;;=840.4^^45^496^67
 ;;^UTILITY(U,$J,358.3,5559,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5559,1,4,0)
 ;;=4^840.4
 ;;^UTILITY(U,$J,358.3,5559,1,5,0)
 ;;=5^Sprain, Rotator Cuff
 ;;^UTILITY(U,$J,358.3,5559,2)
 ;;=Sprain, Rotator Cuff^274469
 ;;^UTILITY(U,$J,358.3,5560,0)
 ;;=841.9^^45^496^58
 ;;^UTILITY(U,$J,358.3,5560,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5560,1,4,0)
 ;;=4^841.9
 ;;^UTILITY(U,$J,358.3,5560,1,5,0)
 ;;=5^Sprain Elbow
 ;;^UTILITY(U,$J,358.3,5560,2)
 ;;=Sprain, Elbow^274480
 ;;^UTILITY(U,$J,358.3,5561,0)
 ;;=844.8^^45^496^66
 ;;^UTILITY(U,$J,358.3,5561,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5561,1,4,0)
 ;;=4^844.8
 ;;^UTILITY(U,$J,358.3,5561,1,5,0)
 ;;=5^Sprain of Knee
 ;;^UTILITY(U,$J,358.3,5561,2)
 ;;=Sprain of Knee^274503
 ;;^UTILITY(U,$J,358.3,5562,0)
 ;;=913.0^^45^496^1
 ;;^UTILITY(U,$J,358.3,5562,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5562,1,4,0)
 ;;=4^913.0
 ;;^UTILITY(U,$J,358.3,5562,1,5,0)
 ;;=5^Abrasion Elbow/Wrist w/o Infec
 ;;^UTILITY(U,$J,358.3,5562,2)
 ;;=^275297
 ;;^UTILITY(U,$J,358.3,5563,0)
 ;;=916.0^^45^496^6
 ;;^UTILITY(U,$J,358.3,5563,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5563,1,4,0)
 ;;=4^916.0
 ;;^UTILITY(U,$J,358.3,5563,1,5,0)
 ;;=5^Abrasion Lower Ext w/o Infec
 ;;^UTILITY(U,$J,358.3,5563,2)
 ;;=^275330
 ;;^UTILITY(U,$J,358.3,5564,0)
 ;;=910.0^^45^496^2
 ;;^UTILITY(U,$J,358.3,5564,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5564,1,4,0)
 ;;=4^910.0
 ;;^UTILITY(U,$J,358.3,5564,1,5,0)
 ;;=5^Abrasion Face/Neck/Scalp w/o Infec
 ;;^UTILITY(U,$J,358.3,5564,2)
 ;;=^275263
 ;;^UTILITY(U,$J,358.3,5565,0)
 ;;=915.0^^45^496^3
 ;;^UTILITY(U,$J,358.3,5565,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5565,1,4,0)
 ;;=4^915.0
 ;;^UTILITY(U,$J,358.3,5565,1,5,0)
 ;;=5^Abrasion Finger w/o Infec
 ;;^UTILITY(U,$J,358.3,5565,2)
 ;;=^275319
 ;;^UTILITY(U,$J,358.3,5566,0)
 ;;=917.0^^45^496^4
 ;;^UTILITY(U,$J,358.3,5566,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5566,1,4,0)
 ;;=4^917.0
 ;;^UTILITY(U,$J,358.3,5566,1,5,0)
 ;;=5^Abrasion Foot/Toes w/o Infec
 ;;^UTILITY(U,$J,358.3,5566,2)
 ;;=^275341
 ;;^UTILITY(U,$J,358.3,5567,0)
 ;;=914.0^^45^496^5
 ;;^UTILITY(U,$J,358.3,5567,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5567,1,4,0)
 ;;=4^914.0
 ;;^UTILITY(U,$J,358.3,5567,1,5,0)
 ;;=5^Abrasion Hand w/o Infec
 ;;^UTILITY(U,$J,358.3,5567,2)
 ;;=^275308
 ;;^UTILITY(U,$J,358.3,5568,0)
 ;;=911.0^^45^496^7
 ;;^UTILITY(U,$J,358.3,5568,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5568,1,4,0)
 ;;=4^911.0
 ;;^UTILITY(U,$J,358.3,5568,1,5,0)
 ;;=5^Abrasion Trunk w/o Infec
 ;;^UTILITY(U,$J,358.3,5568,2)
 ;;=^275275
 ;;^UTILITY(U,$J,358.3,5569,0)
 ;;=912.0^^45^496^8
 ;;^UTILITY(U,$J,358.3,5569,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5569,1,4,0)
 ;;=4^912.0
 ;;^UTILITY(U,$J,358.3,5569,1,5,0)
 ;;=5^Abrasion Upper Ext w/o Infec
 ;;^UTILITY(U,$J,358.3,5569,2)
 ;;=^275286
 ;;^UTILITY(U,$J,358.3,5570,0)
 ;;=940.3^^45^496^11
 ;;^UTILITY(U,$J,358.3,5570,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5570,1,4,0)
 ;;=4^940.3
 ;;^UTILITY(U,$J,358.3,5570,1,5,0)
 ;;=5^Acid Burn Cornea/Conjunc Sac
 ;;^UTILITY(U,$J,358.3,5570,2)
 ;;=^275515
 ;;^UTILITY(U,$J,358.3,5571,0)
 ;;=940.2^^45^496^12
 ;;^UTILITY(U,$J,358.3,5571,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5571,1,4,0)
 ;;=4^940.2
 ;;^UTILITY(U,$J,358.3,5571,1,5,0)
 ;;=5^Alkaline Burn Cornea/Conjunc Sac
