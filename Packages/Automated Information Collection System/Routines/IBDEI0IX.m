IBDEI0IX ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23985,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23985,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,23985,1,3,0)
 ;;=3^Self-Mgmt Educ 2-4 Pts,Ea 30min
 ;;^UTILITY(U,$J,358.3,23986,0)
 ;;=98962^^62^938^6^^^^1
 ;;^UTILITY(U,$J,358.3,23986,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23986,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,23986,1,3,0)
 ;;=3^Self-Mgmt Educ 5-8 Pts,Ea 30min
 ;;^UTILITY(U,$J,358.3,23987,0)
 ;;=96153^^62^938^3^^^^1
 ;;^UTILITY(U,$J,358.3,23987,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23987,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,23987,1,3,0)
 ;;=3^Group Health/Behav Interv,Ea 15min
 ;;^UTILITY(U,$J,358.3,23988,0)
 ;;=H0046^^62^938^4^^^^1
 ;;^UTILITY(U,$J,358.3,23988,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23988,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,23988,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,23989,0)
 ;;=Q3014^^62^939^7^^^^1
 ;;^UTILITY(U,$J,358.3,23989,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23989,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,23989,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,23990,0)
 ;;=90889^^62^939^4^^^^1
 ;;^UTILITY(U,$J,358.3,23990,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23990,1,2,0)
 ;;=2^90889
 ;;^UTILITY(U,$J,358.3,23990,1,3,0)
 ;;=3^Preparation of Report for Indiv/Agency/Insurance
 ;;^UTILITY(U,$J,358.3,23991,0)
 ;;=G0177^^62^939^8^^^^1
 ;;^UTILITY(U,$J,358.3,23991,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23991,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,23991,1,3,0)
 ;;=3^Train/Ed Svcs for Care/Tx of Disabiling MH Problem,45+ min
 ;;^UTILITY(U,$J,358.3,23992,0)
 ;;=99368^^62^940^3^^^^1
 ;;^UTILITY(U,$J,358.3,23992,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23992,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,23992,1,3,0)
 ;;=3^Non-Phys Team Conf w/o Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,23993,0)
 ;;=99366^^62^940^1^^^^1
 ;;^UTILITY(U,$J,358.3,23993,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23993,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,23993,1,3,0)
 ;;=3^Non-Phys Team Conf w/ Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,23994,0)
 ;;=H0001^^62^941^1^^^^1
 ;;^UTILITY(U,$J,358.3,23994,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23994,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,23994,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,23995,0)
 ;;=H0002^^62^941^9^^^^1
 ;;^UTILITY(U,$J,358.3,23995,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23995,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,23995,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,23996,0)
 ;;=H0003^^62^941^6^^^^1
 ;;^UTILITY(U,$J,358.3,23996,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23996,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,23996,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,23997,0)
 ;;=H0004^^62^941^7^^^^1
 ;;^UTILITY(U,$J,358.3,23997,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23997,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,23997,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,23998,0)
 ;;=H0005^^62^941^3^^^^1
 ;;^UTILITY(U,$J,358.3,23998,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23998,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,23998,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,23999,0)
 ;;=H0006^^62^941^5^^^^1
 ;;^UTILITY(U,$J,358.3,23999,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23999,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,23999,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,24000,0)
 ;;=H0020^^62^941^8^^^^1
 ;;^UTILITY(U,$J,358.3,24000,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24000,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,24000,1,3,0)
 ;;=3^Methadone Administration &/or Svc by Lincensed Program
 ;;^UTILITY(U,$J,358.3,24001,0)
 ;;=H0025^^62^941^2^^^^1
 ;;^UTILITY(U,$J,358.3,24001,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24001,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,24001,1,3,0)
 ;;=3^Addictions Health Prevention/Education
 ;;^UTILITY(U,$J,358.3,24002,0)
 ;;=H0030^^62^941^4^^^^1
 ;;^UTILITY(U,$J,358.3,24002,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24002,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,24002,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,24003,0)
 ;;=99600^^62^942^1^^^^1
 ;;^UTILITY(U,$J,358.3,24003,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24003,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,24003,1,3,0)
 ;;=3^Case Management in Pts Home
 ;;^UTILITY(U,$J,358.3,24004,0)
 ;;=T1016^^62^942^2^^^^1
 ;;^UTILITY(U,$J,358.3,24004,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24004,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,24004,1,3,0)
 ;;=3^Case Management per 15min
 ;;^UTILITY(U,$J,358.3,24005,0)
 ;;=96372^^62^943^1^^^^1
 ;;^UTILITY(U,$J,358.3,24005,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24005,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,24005,1,3,0)
 ;;=3^Ther/Proph/Diag Inj SC/IM
 ;;^UTILITY(U,$J,358.3,24006,0)
 ;;=96374^^62^943^2^^^^1
 ;;^UTILITY(U,$J,358.3,24006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24006,1,2,0)
 ;;=2^96374
 ;;^UTILITY(U,$J,358.3,24006,1,3,0)
 ;;=3^Ther/Proph/Diag Inj IV Push
 ;;^UTILITY(U,$J,358.3,24007,0)
 ;;=96376^^62^943^3^^^^1
 ;;^UTILITY(U,$J,358.3,24007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24007,1,2,0)
 ;;=2^96376
 ;;^UTILITY(U,$J,358.3,24007,1,3,0)
 ;;=3^Tx/Pro/Dx Inj,ea addl sequential IVP of Same Drug-Add-on
 ;;^UTILITY(U,$J,358.3,24008,0)
 ;;=J2680^^62^944^2^^^^1
 ;;^UTILITY(U,$J,358.3,24008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24008,1,2,0)
 ;;=2^J2680
 ;;^UTILITY(U,$J,358.3,24008,1,3,0)
 ;;=3^Fluphenazine Decanoate up to 25mg
 ;;^UTILITY(U,$J,358.3,24009,0)
 ;;=J1631^^62^944^3^^^^1
 ;;^UTILITY(U,$J,358.3,24009,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24009,1,2,0)
 ;;=2^J1631
 ;;^UTILITY(U,$J,358.3,24009,1,3,0)
 ;;=3^Haloperidol Decanoate per 50mg
 ;;^UTILITY(U,$J,358.3,24010,0)
 ;;=J2315^^62^944^4^^^^1
 ;;^UTILITY(U,$J,358.3,24010,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24010,1,2,0)
 ;;=2^J2315
 ;;^UTILITY(U,$J,358.3,24010,1,3,0)
 ;;=3^Naltrexone,Depot Form 1mg
 ;;^UTILITY(U,$J,358.3,24011,0)
 ;;=J2426^^62^944^5^^^^1
 ;;^UTILITY(U,$J,358.3,24011,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24011,1,2,0)
 ;;=2^J2426
 ;;^UTILITY(U,$J,358.3,24011,1,3,0)
 ;;=3^Paliperidone Palmitate Extend Release per 1mg
 ;;^UTILITY(U,$J,358.3,24012,0)
 ;;=J2794^^62^944^6^^^^1
 ;;^UTILITY(U,$J,358.3,24012,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24012,1,2,0)
 ;;=2^J2794
 ;;^UTILITY(U,$J,358.3,24012,1,3,0)
 ;;=3^Risperidone Long Act per 0.5mg
 ;;^UTILITY(U,$J,358.3,24013,0)
 ;;=J2315^^62^944^7^^^^1
 ;;^UTILITY(U,$J,358.3,24013,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24013,1,2,0)
 ;;=2^J2315
 ;;^UTILITY(U,$J,358.3,24013,1,3,0)
 ;;=3^Vivitrol 1mg
 ;;^UTILITY(U,$J,358.3,24014,0)
 ;;=J0401^^62^944^1^^^^1
 ;;^UTILITY(U,$J,358.3,24014,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24014,1,2,0)
 ;;=2^J0401
 ;;^UTILITY(U,$J,358.3,24014,1,3,0)
 ;;=3^Aripiprazole Ext Rel 1mg
 ;;^UTILITY(U,$J,358.3,24015,0)
 ;;=96150^^62^945^1^^^^1
 ;;^UTILITY(U,$J,358.3,24015,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24015,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,24015,1,3,0)
 ;;=3^Behavior/Health Init Assm,Ea 15min
 ;;^UTILITY(U,$J,358.3,24016,0)
 ;;=96151^^62^945^2^^^^1
 ;;^UTILITY(U,$J,358.3,24016,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24016,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,24016,1,3,0)
 ;;=3^Behavior/Health Re-Assm,Ea 15min
 ;;^UTILITY(U,$J,358.3,24017,0)
 ;;=99211^^63^946^1
 ;;^UTILITY(U,$J,358.3,24017,1,0)
 ;;=^358.31IA^1^1
 ;;^UTILITY(U,$J,358.3,24017,1,1,0)
 ;;=1^Nursing Only Visit
 ;;^UTILITY(U,$J,358.3,24018,0)
 ;;=T74.11XA^^64^947^5
 ;;^UTILITY(U,$J,358.3,24018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24018,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24018,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,24018,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,24019,0)
 ;;=T74.11XD^^64^947^6
 ;;^UTILITY(U,$J,358.3,24019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24019,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,24019,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,24019,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,24020,0)
 ;;=T76.11XA^^64^947^7
 ;;^UTILITY(U,$J,358.3,24020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24020,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,24020,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,24020,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,24021,0)
 ;;=T76.11XD^^64^947^8
 ;;^UTILITY(U,$J,358.3,24021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24021,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,24021,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,24021,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,24022,0)
 ;;=Z69.11^^64^947^31
 ;;^UTILITY(U,$J,358.3,24022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24022,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,24022,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,24022,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,24023,0)
 ;;=Z91.410^^64^947^35
 ;;^UTILITY(U,$J,358.3,24023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24023,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,24023,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,24023,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,24024,0)
 ;;=Z69.12^^64^947^27
 ;;^UTILITY(U,$J,358.3,24024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24024,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,24024,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,24024,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,24025,0)
 ;;=T74.21XA^^64^947^13
 ;;^UTILITY(U,$J,358.3,24025,1,0)
 ;;=^358.31IA^4^2
