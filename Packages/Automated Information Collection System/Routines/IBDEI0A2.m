IBDEI0A2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4179,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,4180,0)
 ;;=Z12.9^^28^263^162
 ;;^UTILITY(U,$J,358.3,4180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4180,1,3,0)
 ;;=3^Screening for Malig Neop,Unspec Site
 ;;^UTILITY(U,$J,358.3,4180,1,4,0)
 ;;=4^Z12.9
 ;;^UTILITY(U,$J,358.3,4180,2)
 ;;=^5062698
 ;;^UTILITY(U,$J,358.3,4181,0)
 ;;=Z13.9^^28^263^163
 ;;^UTILITY(U,$J,358.3,4181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4181,1,3,0)
 ;;=3^Screening,Unspec
 ;;^UTILITY(U,$J,358.3,4181,1,4,0)
 ;;=4^Z13.9
 ;;^UTILITY(U,$J,358.3,4181,2)
 ;;=^5062721
 ;;^UTILITY(U,$J,358.3,4182,0)
 ;;=Z48.89^^28^263^164
 ;;^UTILITY(U,$J,358.3,4182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4182,1,3,0)
 ;;=3^Surgical Aftercare Encounter,Other Spec
 ;;^UTILITY(U,$J,358.3,4182,1,4,0)
 ;;=4^Z48.89
 ;;^UTILITY(U,$J,358.3,4182,2)
 ;;=^5063055
 ;;^UTILITY(U,$J,358.3,4183,0)
 ;;=Z51.81^^28^263^167
 ;;^UTILITY(U,$J,358.3,4183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4183,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,4183,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,4183,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,4184,0)
 ;;=Z77.9^^28^263^55
 ;;^UTILITY(U,$J,358.3,4184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4184,1,3,0)
 ;;=3^Exposures/Contact with Hazardous Substances
 ;;^UTILITY(U,$J,358.3,4184,1,4,0)
 ;;=4^Z77.9
 ;;^UTILITY(U,$J,358.3,4184,2)
 ;;=^5063326
 ;;^UTILITY(U,$J,358.3,4185,0)
 ;;=R50.9^^28^263^57
 ;;^UTILITY(U,$J,358.3,4185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4185,1,3,0)
 ;;=3^Fever,Unspec
 ;;^UTILITY(U,$J,358.3,4185,1,4,0)
 ;;=4^R50.9
 ;;^UTILITY(U,$J,358.3,4185,2)
 ;;=^5019512
 ;;^UTILITY(U,$J,358.3,4186,0)
 ;;=Z96.9^^28^263^58
 ;;^UTILITY(U,$J,358.3,4186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4186,1,3,0)
 ;;=3^Functional Implant,Unspec
 ;;^UTILITY(U,$J,358.3,4186,1,4,0)
 ;;=4^Z96.9
 ;;^UTILITY(U,$J,358.3,4186,2)
 ;;=^5063719
 ;;^UTILITY(U,$J,358.3,4187,0)
 ;;=Z72.6^^28^263^59
 ;;^UTILITY(U,$J,358.3,4187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4187,1,3,0)
 ;;=3^Gambling and Betting
 ;;^UTILITY(U,$J,358.3,4187,1,4,0)
 ;;=4^Z72.6
 ;;^UTILITY(U,$J,358.3,4187,2)
 ;;=^5063261
 ;;^UTILITY(U,$J,358.3,4188,0)
 ;;=Z72.53^^28^263^62
 ;;^UTILITY(U,$J,358.3,4188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4188,1,3,0)
 ;;=3^High Risk Bisexual Behavior
 ;;^UTILITY(U,$J,358.3,4188,1,4,0)
 ;;=4^Z72.53
 ;;^UTILITY(U,$J,358.3,4188,2)
 ;;=^5063260
 ;;^UTILITY(U,$J,358.3,4189,0)
 ;;=Z72.51^^28^263^63
 ;;^UTILITY(U,$J,358.3,4189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4189,1,3,0)
 ;;=3^High Risk Heterosexual Behavior
 ;;^UTILITY(U,$J,358.3,4189,1,4,0)
 ;;=4^Z72.51
 ;;^UTILITY(U,$J,358.3,4189,2)
 ;;=^5063258
 ;;^UTILITY(U,$J,358.3,4190,0)
 ;;=Z72.52^^28^263^64
 ;;^UTILITY(U,$J,358.3,4190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4190,1,3,0)
 ;;=3^High Risk Homosexual Behavior
 ;;^UTILITY(U,$J,358.3,4190,1,4,0)
 ;;=4^Z72.52
 ;;^UTILITY(U,$J,358.3,4190,2)
 ;;=^5063259
 ;;^UTILITY(U,$J,358.3,4191,0)
 ;;=R68.0^^28^263^65
 ;;^UTILITY(U,$J,358.3,4191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4191,1,3,0)
 ;;=3^Hypothermia,Not from Low Environmental Temperature
 ;;^UTILITY(U,$J,358.3,4191,1,4,0)
 ;;=4^R68.0
 ;;^UTILITY(U,$J,358.3,4191,2)
 ;;=^5019549
 ;;^UTILITY(U,$J,358.3,4192,0)
 ;;=R99.^^28^263^66
 ;;^UTILITY(U,$J,358.3,4192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4192,1,3,0)
 ;;=3^Ill-Defined/Unknown Cause of Mortality
 ;;^UTILITY(U,$J,358.3,4192,1,4,0)
 ;;=4^R99.
 ;;^UTILITY(U,$J,358.3,4192,2)
 ;;=^5019750
 ;;^UTILITY(U,$J,358.3,4193,0)
 ;;=R69.^^28^263^67
