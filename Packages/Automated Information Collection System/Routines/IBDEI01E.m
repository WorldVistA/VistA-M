IBDEI01E ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,867,1,3,0)
 ;;=3^Cocaine Intoxication w/o  Percept Disturb w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,867,1,4,0)
 ;;=4^F14.229
 ;;^UTILITY(U,$J,358.3,867,2)
 ;;=^5003258
 ;;^UTILITY(U,$J,358.3,868,0)
 ;;=F14.929^^3^64^66
 ;;^UTILITY(U,$J,358.3,868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,868,1,3,0)
 ;;=3^Cocaine Intoxication w/o Percept Disturb w/o Use D/O
 ;;^UTILITY(U,$J,358.3,868,1,4,0)
 ;;=4^F14.929
 ;;^UTILITY(U,$J,358.3,868,2)
 ;;=^5003273
 ;;^UTILITY(U,$J,358.3,869,0)
 ;;=F14.121^^3^64^58
 ;;^UTILITY(U,$J,358.3,869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,869,1,3,0)
 ;;=3^Cocaine Intoxication Delirium  w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,869,1,4,0)
 ;;=4^F14.121
 ;;^UTILITY(U,$J,358.3,869,2)
 ;;=^5003241
 ;;^UTILITY(U,$J,358.3,870,0)
 ;;=F14.221^^3^64^59
 ;;^UTILITY(U,$J,358.3,870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,870,1,3,0)
 ;;=3^Cocaine Intoxication Delirium  w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,870,1,4,0)
 ;;=4^F14.221
 ;;^UTILITY(U,$J,358.3,870,2)
 ;;=^5003256
 ;;^UTILITY(U,$J,358.3,871,0)
 ;;=F14.921^^3^64^60
 ;;^UTILITY(U,$J,358.3,871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,871,1,3,0)
 ;;=3^Cocaine Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,871,1,4,0)
 ;;=4^F14.921
 ;;^UTILITY(U,$J,358.3,871,2)
 ;;=^5003271
 ;;^UTILITY(U,$J,358.3,872,0)
 ;;=F14.10^^3^64^68
 ;;^UTILITY(U,$J,358.3,872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,872,1,3,0)
 ;;=3^Cocaine Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,872,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,872,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,873,0)
 ;;=F14.20^^3^64^69
 ;;^UTILITY(U,$J,358.3,873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,873,1,3,0)
 ;;=3^Cocaine Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,873,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,873,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,874,0)
 ;;=F14.20^^3^64^70
 ;;^UTILITY(U,$J,358.3,874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,874,1,3,0)
 ;;=3^Cocaine Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,874,1,4,0)
 ;;=4^F14.20
 ;;^UTILITY(U,$J,358.3,874,2)
 ;;=^5003253
 ;;^UTILITY(U,$J,358.3,875,0)
 ;;=F14.23^^3^64^71
 ;;^UTILITY(U,$J,358.3,875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,875,1,3,0)
 ;;=3^Cocaine Withdrawal
 ;;^UTILITY(U,$J,358.3,875,1,4,0)
 ;;=4^F14.23
 ;;^UTILITY(U,$J,358.3,875,2)
 ;;=^5003259
 ;;^UTILITY(U,$J,358.3,876,0)
 ;;=99211^^4^65^1
 ;;^UTILITY(U,$J,358.3,876,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,876,1,1,0)
 ;;=1^Face-to-Face Visit
 ;;^UTILITY(U,$J,358.3,876,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,877,0)
 ;;=99377^^5^66^3^^^^1
 ;;^UTILITY(U,$J,358.3,877,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,877,1,2,0)
 ;;=2^Hospice Care 15-29min
 ;;^UTILITY(U,$J,358.3,877,1,3,0)
 ;;=3^99377
 ;;^UTILITY(U,$J,358.3,878,0)
 ;;=99378^^5^66^4^^^^1
 ;;^UTILITY(U,$J,358.3,878,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,878,1,2,0)
 ;;=2^Hospice Care 30 min or >
 ;;^UTILITY(U,$J,358.3,878,1,3,0)
 ;;=3^99378
 ;;^UTILITY(U,$J,358.3,879,0)
 ;;=99374^^5^66^1^^^^1
 ;;^UTILITY(U,$J,358.3,879,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,879,1,2,0)
 ;;=2^Home Health Agency 15-29min
 ;;^UTILITY(U,$J,358.3,879,1,3,0)
 ;;=3^99374
 ;;^UTILITY(U,$J,358.3,880,0)
 ;;=99375^^5^66^2^^^^1
 ;;^UTILITY(U,$J,358.3,880,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,880,1,2,0)
 ;;=2^Home Health Agency 30 min or >
 ;;^UTILITY(U,$J,358.3,880,1,3,0)
 ;;=3^99375
 ;;^UTILITY(U,$J,358.3,881,0)
 ;;=S5100^^5^67^1^^^^1
 ;;^UTILITY(U,$J,358.3,881,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,881,1,2,0)
 ;;=2^Day Care Svcs,per 15min
 ;;^UTILITY(U,$J,358.3,881,1,3,0)
 ;;=3^S5100
 ;;^UTILITY(U,$J,358.3,882,0)
 ;;=S5101^^5^67^2^^^^1
 ;;^UTILITY(U,$J,358.3,882,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,882,1,2,0)
 ;;=2^Day Care Svcs,per half day
 ;;^UTILITY(U,$J,358.3,882,1,3,0)
 ;;=3^S5101
 ;;^UTILITY(U,$J,358.3,883,0)
 ;;=S5102^^5^67^3^^^^1
 ;;^UTILITY(U,$J,358.3,883,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,883,1,2,0)
 ;;=2^Day Care Svcs,per diem
 ;;^UTILITY(U,$J,358.3,883,1,3,0)
 ;;=3^S5102
 ;;^UTILITY(U,$J,358.3,884,0)
 ;;=T1016^^5^68^8^^^^1
 ;;^UTILITY(U,$J,358.3,884,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,884,1,2,0)
 ;;=2^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,884,1,3,0)
 ;;=3^T1016
 ;;^UTILITY(U,$J,358.3,885,0)
 ;;=I50.9^^6^69^1
 ;;^UTILITY(U,$J,358.3,885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,885,1,3,0)
 ;;=3^CHF,Unspec
 ;;^UTILITY(U,$J,358.3,885,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,885,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,886,0)
 ;;=I10.^^6^69^2
 ;;^UTILITY(U,$J,358.3,886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,886,1,3,0)
 ;;=3^HTN,Essential
 ;;^UTILITY(U,$J,358.3,886,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,886,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,887,0)
 ;;=E78.4^^6^69^3
 ;;^UTILITY(U,$J,358.3,887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,887,1,3,0)
 ;;=3^Hyperlipidemia,Other
 ;;^UTILITY(U,$J,358.3,887,1,4,0)
 ;;=4^E78.4
 ;;^UTILITY(U,$J,358.3,887,2)
 ;;=^5002968
 ;;^UTILITY(U,$J,358.3,888,0)
 ;;=E78.5^^6^69^4
 ;;^UTILITY(U,$J,358.3,888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,888,1,3,0)
 ;;=3^Hyperlipidemia,Unspec
 ;;^UTILITY(U,$J,358.3,888,1,4,0)
 ;;=4^E78.5
 ;;^UTILITY(U,$J,358.3,888,2)
 ;;=^5002969
 ;;^UTILITY(U,$J,358.3,889,0)
 ;;=Z51.5^^6^70^7
 ;;^UTILITY(U,$J,358.3,889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,889,1,3,0)
 ;;=3^Palliative Care Encounter
 ;;^UTILITY(U,$J,358.3,889,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,889,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,890,0)
 ;;=Z99.81^^6^70^4
 ;;^UTILITY(U,$J,358.3,890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,890,1,3,0)
 ;;=3^Dependence on Supplemental Oxygen
 ;;^UTILITY(U,$J,358.3,890,1,4,0)
 ;;=4^Z99.81
 ;;^UTILITY(U,$J,358.3,890,2)
 ;;=^5063760
 ;;^UTILITY(U,$J,358.3,891,0)
 ;;=Z71.89^^6^70^2
 ;;^UTILITY(U,$J,358.3,891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,891,1,3,0)
 ;;=3^Counseling,Other Specified
 ;;^UTILITY(U,$J,358.3,891,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,891,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,892,0)
 ;;=Z65.9^^6^70^8
 ;;^UTILITY(U,$J,358.3,892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,892,1,3,0)
 ;;=3^Problem Related to Unspec Psychosocial Circumstances
 ;;^UTILITY(U,$J,358.3,892,1,4,0)
 ;;=4^Z65.9
 ;;^UTILITY(U,$J,358.3,892,2)
 ;;=^5063186
 ;;^UTILITY(U,$J,358.3,893,0)
 ;;=Z23.^^6^70^6
 ;;^UTILITY(U,$J,358.3,893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,893,1,3,0)
 ;;=3^Immunization Encounter
 ;;^UTILITY(U,$J,358.3,893,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,893,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,894,0)
 ;;=Z51.89^^6^70^9
 ;;^UTILITY(U,$J,358.3,894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,894,1,3,0)
 ;;=3^Specified Aftercare Encounter
 ;;^UTILITY(U,$J,358.3,894,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,894,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,895,0)
 ;;=Z71.9^^6^70^3
 ;;^UTILITY(U,$J,358.3,895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,895,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,895,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,895,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,896,0)
 ;;=Z51.81^^6^70^10
 ;;^UTILITY(U,$J,358.3,896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,896,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,896,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,896,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,897,0)
 ;;=Z02.89^^6^70^1
 ;;^UTILITY(U,$J,358.3,897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,897,1,3,0)
 ;;=3^Administrative Examination Encounter
 ;;^UTILITY(U,$J,358.3,897,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,897,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,898,0)
 ;;=Z71.3^^6^70^5
 ;;^UTILITY(U,$J,358.3,898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,898,1,3,0)
 ;;=3^Dietary Counseling & Surveillance
 ;;^UTILITY(U,$J,358.3,898,1,4,0)
 ;;=4^Z71.3
