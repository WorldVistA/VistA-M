IBDEI0QX ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27056,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27056,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,27056,1,3,0)
 ;;=3^Addictions Assessment,Alcohol and/or Drug
 ;;^UTILITY(U,$J,358.3,27057,0)
 ;;=H0002^^101^1311^11^^^^1
 ;;^UTILITY(U,$J,358.3,27057,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27057,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,27057,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,27058,0)
 ;;=H0003^^101^1311^6^^^^1
 ;;^UTILITY(U,$J,358.3,27058,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27058,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,27058,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,27059,0)
 ;;=H0004^^101^1311^9^^^^1
 ;;^UTILITY(U,$J,358.3,27059,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27059,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,27059,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,27060,0)
 ;;=H0005^^101^1311^2^^^^1
 ;;^UTILITY(U,$J,358.3,27060,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27060,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,27060,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,27061,0)
 ;;=H0006^^101^1311^5^^^^1
 ;;^UTILITY(U,$J,358.3,27061,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27061,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,27061,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,27062,0)
 ;;=H0020^^101^1311^10^^^^1
 ;;^UTILITY(U,$J,358.3,27062,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27062,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,27062,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,27063,0)
 ;;=H0025^^101^1311^3^^^^1
 ;;^UTILITY(U,$J,358.3,27063,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27063,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,27063,1,3,0)
 ;;=3^Addictions Health Prevention Education Service
 ;;^UTILITY(U,$J,358.3,27064,0)
 ;;=H0030^^101^1311^4^^^^1
 ;;^UTILITY(U,$J,358.3,27064,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27064,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,27064,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,27065,0)
 ;;=H0007^^101^1311^8^^^^1
 ;;^UTILITY(U,$J,358.3,27065,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27065,1,2,0)
 ;;=2^H0007
 ;;^UTILITY(U,$J,358.3,27065,1,3,0)
 ;;=3^Alcohol/Drug Svcs,Crisis Intervention
 ;;^UTILITY(U,$J,358.3,27066,0)
 ;;=H0014^^101^1311^7^^^^1
 ;;^UTILITY(U,$J,358.3,27066,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27066,1,2,0)
 ;;=2^H0014
 ;;^UTILITY(U,$J,358.3,27066,1,3,0)
 ;;=3^Alcohol/Drug Svcs,Ambulatory Detox
 ;;^UTILITY(U,$J,358.3,27067,0)
 ;;=90791^^101^1312^1^^^^1
 ;;^UTILITY(U,$J,358.3,27067,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27067,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,27067,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,27068,0)
 ;;=99354^^101^1313^1^^^^1
 ;;^UTILITY(U,$J,358.3,27068,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27068,1,2,0)
 ;;=2^99354
 ;;^UTILITY(U,$J,358.3,27068,1,3,0)
 ;;=3^Prolonged Svcs,Outpt,1st Hr
 ;;^UTILITY(U,$J,358.3,27069,0)
 ;;=99355^^101^1313^2^^^^1
 ;;^UTILITY(U,$J,358.3,27069,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27069,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,27069,1,3,0)
 ;;=3^Prolonged Svcs,Outpt,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,27070,0)
 ;;=99356^^101^1313^3^^^^1
 ;;^UTILITY(U,$J,358.3,27070,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27070,1,2,0)
 ;;=2^99356
 ;;^UTILITY(U,$J,358.3,27070,1,3,0)
 ;;=3^Prolonged Svcs,Inpt/OBS,1st Hr
 ;;^UTILITY(U,$J,358.3,27071,0)
 ;;=99357^^101^1313^4^^^^1
 ;;^UTILITY(U,$J,358.3,27071,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27071,1,2,0)
 ;;=2^99357
 ;;^UTILITY(U,$J,358.3,27071,1,3,0)
 ;;=3^Prolonged Svcs,Inpt/OBS,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,27072,0)
 ;;=99406^^101^1314^2^^^^1
 ;;^UTILITY(U,$J,358.3,27072,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27072,1,2,0)
 ;;=2^99406
 ;;^UTILITY(U,$J,358.3,27072,1,3,0)
 ;;=3^Tob Use & Smoking Cess Intermed Counsel,3-10mins
 ;;^UTILITY(U,$J,358.3,27073,0)
 ;;=99407^^101^1314^3^^^^1
 ;;^UTILITY(U,$J,358.3,27073,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27073,1,2,0)
 ;;=2^99407
 ;;^UTILITY(U,$J,358.3,27073,1,3,0)
 ;;=3^Tob Use & Smoking Cess Intensive Counsel > 10mins
 ;;^UTILITY(U,$J,358.3,27074,0)
 ;;=G0436^^101^1314^4^^^^1
 ;;^UTILITY(U,$J,358.3,27074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27074,1,2,0)
 ;;=2^G0436
 ;;^UTILITY(U,$J,358.3,27074,1,3,0)
 ;;=3^Tob & Smoking Cess Intermed Counsel,Asymp Pt,3-10mins
 ;;^UTILITY(U,$J,358.3,27075,0)
 ;;=G0437^^101^1314^5^^^^1
 ;;^UTILITY(U,$J,358.3,27075,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27075,1,2,0)
 ;;=2^G0437
 ;;^UTILITY(U,$J,358.3,27075,1,3,0)
 ;;=3^Tob & Smoking Cess Intensive Counsel,Asymp Pt > 10min
 ;;^UTILITY(U,$J,358.3,27076,0)
 ;;=S9453^^101^1314^1^^^^1
 ;;^UTILITY(U,$J,358.3,27076,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27076,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,27076,1,3,0)
 ;;=3^Smoking Cessation Class,Non-Phys,per session
 ;;^UTILITY(U,$J,358.3,27077,0)
 ;;=T74.11XA^^102^1315^5
 ;;^UTILITY(U,$J,358.3,27077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27077,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,27077,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,27077,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,27078,0)
 ;;=T74.11XD^^102^1315^6
 ;;^UTILITY(U,$J,358.3,27078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27078,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,27078,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,27078,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,27079,0)
 ;;=T76.11XA^^102^1315^7
 ;;^UTILITY(U,$J,358.3,27079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27079,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,27079,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,27079,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,27080,0)
 ;;=T76.11XD^^102^1315^8
 ;;^UTILITY(U,$J,358.3,27080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27080,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,27080,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,27080,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,27081,0)
 ;;=Z69.11^^102^1315^31
 ;;^UTILITY(U,$J,358.3,27081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27081,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,27081,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,27081,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,27082,0)
 ;;=Z91.410^^102^1315^35
 ;;^UTILITY(U,$J,358.3,27082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27082,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,27082,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,27082,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,27083,0)
 ;;=Z69.12^^102^1315^27
 ;;^UTILITY(U,$J,358.3,27083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27083,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,27083,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,27083,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,27084,0)
 ;;=T74.21XA^^102^1315^13
 ;;^UTILITY(U,$J,358.3,27084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27084,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,27084,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,27084,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,27085,0)
 ;;=T74.21XD^^102^1315^14
 ;;^UTILITY(U,$J,358.3,27085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27085,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,27085,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,27085,2)
 ;;=^5054153
