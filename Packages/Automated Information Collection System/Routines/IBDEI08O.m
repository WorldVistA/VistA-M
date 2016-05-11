IBDEI08O ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3768,1,3,0)
 ;;=3^Personal Hx of Pneumonia
 ;;^UTILITY(U,$J,358.3,3768,1,4,0)
 ;;=4^Z87.01
 ;;^UTILITY(U,$J,358.3,3768,2)
 ;;=^5063480
 ;;^UTILITY(U,$J,358.3,3769,0)
 ;;=J18.9^^18^222^51
 ;;^UTILITY(U,$J,358.3,3769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3769,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,3769,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,3769,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,3770,0)
 ;;=J12.9^^18^222^52
 ;;^UTILITY(U,$J,358.3,3770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3770,1,3,0)
 ;;=3^Pneumonia,Viral,Unspec
 ;;^UTILITY(U,$J,358.3,3770,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,3770,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,3771,0)
 ;;=J93.9^^18^222^53
 ;;^UTILITY(U,$J,358.3,3771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3771,1,3,0)
 ;;=3^Pneumothorax,Unspec
 ;;^UTILITY(U,$J,358.3,3771,1,4,0)
 ;;=4^J93.9
 ;;^UTILITY(U,$J,358.3,3771,2)
 ;;=^5008315
 ;;^UTILITY(U,$J,358.3,3772,0)
 ;;=J33.9^^18^222^54
 ;;^UTILITY(U,$J,358.3,3772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3772,1,3,0)
 ;;=3^Polyp,Nasal,Unspec
 ;;^UTILITY(U,$J,358.3,3772,1,4,0)
 ;;=4^J33.9
 ;;^UTILITY(U,$J,358.3,3772,2)
 ;;=^5008208
 ;;^UTILITY(U,$J,358.3,3773,0)
 ;;=R09.82^^18^222^55
 ;;^UTILITY(U,$J,358.3,3773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3773,1,3,0)
 ;;=3^Postnasal Drip
 ;;^UTILITY(U,$J,358.3,3773,1,4,0)
 ;;=4^R09.82
 ;;^UTILITY(U,$J,358.3,3773,2)
 ;;=^97058
 ;;^UTILITY(U,$J,358.3,3774,0)
 ;;=J84.9^^18^222^56
 ;;^UTILITY(U,$J,358.3,3774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3774,1,3,0)
 ;;=3^Pulmonary Disease,Interstitial,Unspec
 ;;^UTILITY(U,$J,358.3,3774,1,4,0)
 ;;=4^J84.9
 ;;^UTILITY(U,$J,358.3,3774,2)
 ;;=^5008304
 ;;^UTILITY(U,$J,358.3,3775,0)
 ;;=J81.0^^18^222^57
 ;;^UTILITY(U,$J,358.3,3775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3775,1,3,0)
 ;;=3^Pulmonary Edema,Acute
 ;;^UTILITY(U,$J,358.3,3775,1,4,0)
 ;;=4^J81.0
 ;;^UTILITY(U,$J,358.3,3775,2)
 ;;=^5008295
 ;;^UTILITY(U,$J,358.3,3776,0)
 ;;=J81.1^^18^222^58
 ;;^UTILITY(U,$J,358.3,3776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3776,1,3,0)
 ;;=3^Pulmonary Edema,Chronic
 ;;^UTILITY(U,$J,358.3,3776,1,4,0)
 ;;=4^J81.1
 ;;^UTILITY(U,$J,358.3,3776,2)
 ;;=^5008296
 ;;^UTILITY(U,$J,358.3,3777,0)
 ;;=J82.^^18^222^59
 ;;^UTILITY(U,$J,358.3,3777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3777,1,3,0)
 ;;=3^Pulmonary Eosinophilia NEC
 ;;^UTILITY(U,$J,358.3,3777,1,4,0)
 ;;=4^J82.
 ;;^UTILITY(U,$J,358.3,3777,2)
 ;;=^5008297
 ;;^UTILITY(U,$J,358.3,3778,0)
 ;;=J70.9^^18^222^60
 ;;^UTILITY(U,$J,358.3,3778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3778,1,3,0)
 ;;=3^Respiratory Conditions d/t Unspec External Agent
 ;;^UTILITY(U,$J,358.3,3778,1,4,0)
 ;;=4^J70.9
 ;;^UTILITY(U,$J,358.3,3778,2)
 ;;=^269985
 ;;^UTILITY(U,$J,358.3,3779,0)
 ;;=J98.9^^18^222^61
 ;;^UTILITY(U,$J,358.3,3779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3779,1,3,0)
 ;;=3^Respiratory Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3779,1,4,0)
 ;;=4^J98.9
 ;;^UTILITY(U,$J,358.3,3779,2)
 ;;=^5008366
 ;;^UTILITY(U,$J,358.3,3780,0)
 ;;=J06.9^^18^222^62
 ;;^UTILITY(U,$J,358.3,3780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3780,1,3,0)
 ;;=3^Respiratory Infection,Upper,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,3780,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,3780,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,3781,0)
 ;;=J39.9^^18^222^63
 ;;^UTILITY(U,$J,358.3,3781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3781,1,3,0)
 ;;=3^Respiratory Tract Disease,Upper,Unspec
 ;;^UTILITY(U,$J,358.3,3781,1,4,0)
 ;;=4^J39.9
