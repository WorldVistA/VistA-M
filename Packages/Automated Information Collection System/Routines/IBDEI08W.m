IBDEI08W ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3877,1,3,0)
 ;;=3^F/U Exam After Treatment Encounter
 ;;^UTILITY(U,$J,358.3,3877,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,3877,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,3878,0)
 ;;=Z00.01^^18^224^60
 ;;^UTILITY(U,$J,358.3,3878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3878,1,3,0)
 ;;=3^General Medical Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,3878,1,4,0)
 ;;=4^Z00.01
 ;;^UTILITY(U,$J,358.3,3878,2)
 ;;=^5062600
 ;;^UTILITY(U,$J,358.3,3879,0)
 ;;=Z00.00^^18^224^61
 ;;^UTILITY(U,$J,358.3,3879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3879,1,3,0)
 ;;=3^General Medical Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,3879,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,3879,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,3880,0)
 ;;=Z23.^^18^224^69
 ;;^UTILITY(U,$J,358.3,3880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3880,1,3,0)
 ;;=3^Immunization Encounter
 ;;^UTILITY(U,$J,358.3,3880,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,3880,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,3881,0)
 ;;=Z03.89^^18^224^81
 ;;^UTILITY(U,$J,358.3,3881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3881,1,3,0)
 ;;=3^Observation for Suspected Diseases/Ruled Out Conditions
 ;;^UTILITY(U,$J,358.3,3881,1,4,0)
 ;;=4^Z03.89
 ;;^UTILITY(U,$J,358.3,3881,2)
 ;;=^5062656
 ;;^UTILITY(U,$J,358.3,3882,0)
 ;;=Z04.9^^18^224^82
 ;;^UTILITY(U,$J,358.3,3882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3882,1,3,0)
 ;;=3^Observation/Exam,Unspec Reason
 ;;^UTILITY(U,$J,358.3,3882,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,3882,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,3883,0)
 ;;=Z51.5^^18^224^94
 ;;^UTILITY(U,$J,358.3,3883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3883,1,3,0)
 ;;=3^Palliative Care Encounter
 ;;^UTILITY(U,$J,358.3,3883,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,3883,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,3884,0)
 ;;=Z12.9^^18^224^162
 ;;^UTILITY(U,$J,358.3,3884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3884,1,3,0)
 ;;=3^Screening for Malig Neop,Unspec Site
 ;;^UTILITY(U,$J,358.3,3884,1,4,0)
 ;;=4^Z12.9
 ;;^UTILITY(U,$J,358.3,3884,2)
 ;;=^5062698
 ;;^UTILITY(U,$J,358.3,3885,0)
 ;;=Z13.9^^18^224^163
 ;;^UTILITY(U,$J,358.3,3885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3885,1,3,0)
 ;;=3^Screening,Unspec
 ;;^UTILITY(U,$J,358.3,3885,1,4,0)
 ;;=4^Z13.9
 ;;^UTILITY(U,$J,358.3,3885,2)
 ;;=^5062721
 ;;^UTILITY(U,$J,358.3,3886,0)
 ;;=Z48.89^^18^224^164
 ;;^UTILITY(U,$J,358.3,3886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3886,1,3,0)
 ;;=3^Surgical Aftercare Encounter,Other Spec
 ;;^UTILITY(U,$J,358.3,3886,1,4,0)
 ;;=4^Z48.89
 ;;^UTILITY(U,$J,358.3,3886,2)
 ;;=^5063055
 ;;^UTILITY(U,$J,358.3,3887,0)
 ;;=Z51.81^^18^224^167
 ;;^UTILITY(U,$J,358.3,3887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3887,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,3887,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,3887,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,3888,0)
 ;;=Z77.9^^18^224^55
 ;;^UTILITY(U,$J,358.3,3888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3888,1,3,0)
 ;;=3^Exposures/Contact with Hazardous Substances
 ;;^UTILITY(U,$J,358.3,3888,1,4,0)
 ;;=4^Z77.9
 ;;^UTILITY(U,$J,358.3,3888,2)
 ;;=^5063326
 ;;^UTILITY(U,$J,358.3,3889,0)
 ;;=R50.9^^18^224^57
 ;;^UTILITY(U,$J,358.3,3889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3889,1,3,0)
 ;;=3^Fever,Unspec
 ;;^UTILITY(U,$J,358.3,3889,1,4,0)
 ;;=4^R50.9
 ;;^UTILITY(U,$J,358.3,3889,2)
 ;;=^5019512
 ;;^UTILITY(U,$J,358.3,3890,0)
 ;;=Z96.9^^18^224^58
 ;;^UTILITY(U,$J,358.3,3890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3890,1,3,0)
 ;;=3^Functional Implant,Unspec
