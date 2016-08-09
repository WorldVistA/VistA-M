IBDEI0OE ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24585,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,24586,0)
 ;;=H0006^^93^1146^5^^^^1
 ;;^UTILITY(U,$J,358.3,24586,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24586,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,24586,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,24587,0)
 ;;=H0020^^93^1146^8^^^^1
 ;;^UTILITY(U,$J,358.3,24587,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24587,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,24587,1,3,0)
 ;;=3^Methadone Administration &/or Svc by Lincensed Program
 ;;^UTILITY(U,$J,358.3,24588,0)
 ;;=H0025^^93^1146^2^^^^1
 ;;^UTILITY(U,$J,358.3,24588,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24588,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,24588,1,3,0)
 ;;=3^Addictions Health Prevention/Education
 ;;^UTILITY(U,$J,358.3,24589,0)
 ;;=H0030^^93^1146^4^^^^1
 ;;^UTILITY(U,$J,358.3,24589,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24589,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,24589,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,24590,0)
 ;;=99600^^93^1147^1^^^^1
 ;;^UTILITY(U,$J,358.3,24590,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24590,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,24590,1,3,0)
 ;;=3^Case Management in Pts Home
 ;;^UTILITY(U,$J,358.3,24591,0)
 ;;=T1016^^93^1147^2^^^^1
 ;;^UTILITY(U,$J,358.3,24591,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24591,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,24591,1,3,0)
 ;;=3^Case Management per 15min
 ;;^UTILITY(U,$J,358.3,24592,0)
 ;;=96372^^93^1148^1^^^^1
 ;;^UTILITY(U,$J,358.3,24592,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24592,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,24592,1,3,0)
 ;;=3^Ther/Proph/Diag Inj SC/IM
 ;;^UTILITY(U,$J,358.3,24593,0)
 ;;=96374^^93^1148^2^^^^1
 ;;^UTILITY(U,$J,358.3,24593,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24593,1,2,0)
 ;;=2^96374
 ;;^UTILITY(U,$J,358.3,24593,1,3,0)
 ;;=3^Ther/Proph/Diag Inj IV Push
 ;;^UTILITY(U,$J,358.3,24594,0)
 ;;=96376^^93^1148^3^^^^1
 ;;^UTILITY(U,$J,358.3,24594,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24594,1,2,0)
 ;;=2^96376
 ;;^UTILITY(U,$J,358.3,24594,1,3,0)
 ;;=3^Tx/Pro/Dx Inj,ea addl sequential IVP of Same Drug-Add-on
 ;;^UTILITY(U,$J,358.3,24595,0)
 ;;=J2680^^93^1149^1^^^^1
 ;;^UTILITY(U,$J,358.3,24595,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24595,1,2,0)
 ;;=2^J2680
 ;;^UTILITY(U,$J,358.3,24595,1,3,0)
 ;;=3^Fluphenazine Decanoate up to 25mg
 ;;^UTILITY(U,$J,358.3,24596,0)
 ;;=J1631^^93^1149^2^^^^1
 ;;^UTILITY(U,$J,358.3,24596,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24596,1,2,0)
 ;;=2^J1631
 ;;^UTILITY(U,$J,358.3,24596,1,3,0)
 ;;=3^Haloperidol Decanoate per 50mg
 ;;^UTILITY(U,$J,358.3,24597,0)
 ;;=J2315^^93^1149^3^^^^1
 ;;^UTILITY(U,$J,358.3,24597,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24597,1,2,0)
 ;;=2^J2315
 ;;^UTILITY(U,$J,358.3,24597,1,3,0)
 ;;=3^Naltrexone,Depot Form 1mg
 ;;^UTILITY(U,$J,358.3,24598,0)
 ;;=J2426^^93^1149^4^^^^1
 ;;^UTILITY(U,$J,358.3,24598,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24598,1,2,0)
 ;;=2^J2426
 ;;^UTILITY(U,$J,358.3,24598,1,3,0)
 ;;=3^Paliperidone Palmitate Extend Release per 1mg
 ;;^UTILITY(U,$J,358.3,24599,0)
 ;;=J2794^^93^1149^5^^^^1
 ;;^UTILITY(U,$J,358.3,24599,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24599,1,2,0)
 ;;=2^J2794
 ;;^UTILITY(U,$J,358.3,24599,1,3,0)
 ;;=3^Risperidone Long Act per 0.5mg
 ;;^UTILITY(U,$J,358.3,24600,0)
 ;;=J2315^^93^1149^6^^^^1
 ;;^UTILITY(U,$J,358.3,24600,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24600,1,2,0)
 ;;=2^J2315
 ;;^UTILITY(U,$J,358.3,24600,1,3,0)
 ;;=3^Vivitrol 1mg
 ;;^UTILITY(U,$J,358.3,24601,0)
 ;;=96150^^93^1150^1^^^^1
 ;;^UTILITY(U,$J,358.3,24601,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24601,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,24601,1,3,0)
 ;;=3^Behavior/Health Init Assm,Ea 15min
 ;;^UTILITY(U,$J,358.3,24602,0)
 ;;=96151^^93^1150^2^^^^1
 ;;^UTILITY(U,$J,358.3,24602,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24602,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,24602,1,3,0)
 ;;=3^Behavior/Health Re-Assm,Ea 15min
 ;;^UTILITY(U,$J,358.3,24603,0)
 ;;=99211^^94^1151^1
 ;;^UTILITY(U,$J,358.3,24603,1,0)
 ;;=^358.31IA^1^1
 ;;^UTILITY(U,$J,358.3,24603,1,1,0)
 ;;=1^Nursing Only Visit
 ;;^UTILITY(U,$J,358.3,24604,0)
 ;;=T74.11XA^^95^1152^5
 ;;^UTILITY(U,$J,358.3,24604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24604,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24604,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,24604,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,24605,0)
 ;;=T74.11XD^^95^1152^6
 ;;^UTILITY(U,$J,358.3,24605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24605,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24605,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,24605,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,24606,0)
 ;;=T76.11XA^^95^1152^7
 ;;^UTILITY(U,$J,358.3,24606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24606,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24606,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,24606,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,24607,0)
 ;;=T76.11XD^^95^1152^8
 ;;^UTILITY(U,$J,358.3,24607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24607,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24607,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,24607,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,24608,0)
 ;;=Z69.11^^95^1152^31
 ;;^UTILITY(U,$J,358.3,24608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24608,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,24608,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24608,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24609,0)
 ;;=Z91.410^^95^1152^35
 ;;^UTILITY(U,$J,358.3,24609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24609,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,24609,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,24609,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,24610,0)
 ;;=Z69.12^^95^1152^27
 ;;^UTILITY(U,$J,358.3,24610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24610,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,24610,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24610,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24611,0)
 ;;=T74.21XA^^95^1152^13
 ;;^UTILITY(U,$J,358.3,24611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24611,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,24611,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,24611,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,24612,0)
 ;;=T74.21XD^^95^1152^14
 ;;^UTILITY(U,$J,358.3,24612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24612,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24612,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,24612,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,24613,0)
 ;;=T76.21XA^^95^1152^15
 ;;^UTILITY(U,$J,358.3,24613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24613,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24613,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,24613,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,24614,0)
 ;;=T76.21XD^^95^1152^16
 ;;^UTILITY(U,$J,358.3,24614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24614,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24614,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,24614,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,24615,0)
 ;;=Z69.81^^95^1152^30
 ;;^UTILITY(U,$J,358.3,24615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24615,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
