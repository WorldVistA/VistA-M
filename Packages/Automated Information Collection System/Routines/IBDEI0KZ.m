IBDEI0KZ ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26543,0)
 ;;=99366^^70^1107^1^^^^1
 ;;^UTILITY(U,$J,358.3,26543,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26543,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,26543,1,3,0)
 ;;=3^Non-phys Team Conf w/ Pt &/or Family,30+ min
 ;;^UTILITY(U,$J,358.3,26544,0)
 ;;=90785^^70^1108^1^^^^1
 ;;^UTILITY(U,$J,358.3,26544,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26544,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,26544,1,3,0)
 ;;=3^Interactive Complexity
 ;;^UTILITY(U,$J,358.3,26545,0)
 ;;=H0001^^70^1109^1^^^^1
 ;;^UTILITY(U,$J,358.3,26545,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26545,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,26545,1,3,0)
 ;;=3^Addictions Assessment,Alcohol and/or Drug
 ;;^UTILITY(U,$J,358.3,26546,0)
 ;;=H0002^^70^1109^11^^^^1
 ;;^UTILITY(U,$J,358.3,26546,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26546,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,26546,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,26547,0)
 ;;=H0003^^70^1109^6^^^^1
 ;;^UTILITY(U,$J,358.3,26547,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26547,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,26547,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,26548,0)
 ;;=H0004^^70^1109^9^^^^1
 ;;^UTILITY(U,$J,358.3,26548,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26548,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,26548,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,26549,0)
 ;;=H0005^^70^1109^2^^^^1
 ;;^UTILITY(U,$J,358.3,26549,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26549,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,26549,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,26550,0)
 ;;=H0006^^70^1109^5^^^^1
 ;;^UTILITY(U,$J,358.3,26550,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26550,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,26550,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,26551,0)
 ;;=H0020^^70^1109^10^^^^1
 ;;^UTILITY(U,$J,358.3,26551,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26551,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,26551,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,26552,0)
 ;;=H0025^^70^1109^3^^^^1
 ;;^UTILITY(U,$J,358.3,26552,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26552,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,26552,1,3,0)
 ;;=3^Addictions Health Prevention Education Service
 ;;^UTILITY(U,$J,358.3,26553,0)
 ;;=H0030^^70^1109^4^^^^1
 ;;^UTILITY(U,$J,358.3,26553,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26553,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,26553,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,26554,0)
 ;;=H0007^^70^1109^8^^^^1
 ;;^UTILITY(U,$J,358.3,26554,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26554,1,2,0)
 ;;=2^H0007
 ;;^UTILITY(U,$J,358.3,26554,1,3,0)
 ;;=3^Alcohol/Drug Svcs,Crisis Intervention
 ;;^UTILITY(U,$J,358.3,26555,0)
 ;;=H0014^^70^1109^7^^^^1
 ;;^UTILITY(U,$J,358.3,26555,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26555,1,2,0)
 ;;=2^H0014
 ;;^UTILITY(U,$J,358.3,26555,1,3,0)
 ;;=3^Alcohol/Drug Svcs,Ambulatory Detox
 ;;^UTILITY(U,$J,358.3,26556,0)
 ;;=90791^^70^1110^1^^^^1
 ;;^UTILITY(U,$J,358.3,26556,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26556,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,26556,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,26557,0)
 ;;=99354^^70^1111^1^^^^1
 ;;^UTILITY(U,$J,358.3,26557,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26557,1,2,0)
 ;;=2^99354
 ;;^UTILITY(U,$J,358.3,26557,1,3,0)
 ;;=3^Prolonged Svcs,Outpt,1st Hr
 ;;^UTILITY(U,$J,358.3,26558,0)
 ;;=99355^^70^1111^2^^^^1
 ;;^UTILITY(U,$J,358.3,26558,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26558,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,26558,1,3,0)
 ;;=3^Prolonged Svcs,Outpt,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,26559,0)
 ;;=99356^^70^1111^3^^^^1
 ;;^UTILITY(U,$J,358.3,26559,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26559,1,2,0)
 ;;=2^99356
 ;;^UTILITY(U,$J,358.3,26559,1,3,0)
 ;;=3^Prolonged Svcs,Inpt/OBS,1st Hr
 ;;^UTILITY(U,$J,358.3,26560,0)
 ;;=99357^^70^1111^4^^^^1
 ;;^UTILITY(U,$J,358.3,26560,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26560,1,2,0)
 ;;=2^99357
 ;;^UTILITY(U,$J,358.3,26560,1,3,0)
 ;;=3^Prolonged Svcs,Inpt/OBS,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,26561,0)
 ;;=99406^^70^1112^2^^^^1
 ;;^UTILITY(U,$J,358.3,26561,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26561,1,2,0)
 ;;=2^99406
 ;;^UTILITY(U,$J,358.3,26561,1,3,0)
 ;;=3^Tob Use & Smoking Cess Intermed Counsel,3-10mins
 ;;^UTILITY(U,$J,358.3,26562,0)
 ;;=99407^^70^1112^3^^^^1
 ;;^UTILITY(U,$J,358.3,26562,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26562,1,2,0)
 ;;=2^99407
 ;;^UTILITY(U,$J,358.3,26562,1,3,0)
 ;;=3^Tob Use & Smoking Cess Intensive Counsel > 10mins
 ;;^UTILITY(U,$J,358.3,26563,0)
 ;;=G0436^^70^1112^4^^^^1
 ;;^UTILITY(U,$J,358.3,26563,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26563,1,2,0)
 ;;=2^G0436
 ;;^UTILITY(U,$J,358.3,26563,1,3,0)
 ;;=3^Tob & Smoking Cess Intermed Counsel,Asymp Pt,3-10mins
 ;;^UTILITY(U,$J,358.3,26564,0)
 ;;=G0437^^70^1112^5^^^^1
 ;;^UTILITY(U,$J,358.3,26564,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26564,1,2,0)
 ;;=2^G0437
 ;;^UTILITY(U,$J,358.3,26564,1,3,0)
 ;;=3^Tob & Smoking Cess Intensive Counsel,Asymp Pt > 10min
 ;;^UTILITY(U,$J,358.3,26565,0)
 ;;=S9453^^70^1112^1^^^^1
 ;;^UTILITY(U,$J,358.3,26565,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26565,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,26565,1,3,0)
 ;;=3^Smoking Cessation Class,Non-Phys,per session
 ;;^UTILITY(U,$J,358.3,26566,0)
 ;;=T74.11XA^^71^1113^5
 ;;^UTILITY(U,$J,358.3,26566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26566,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26566,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,26566,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,26567,0)
 ;;=T74.11XD^^71^1113^6
 ;;^UTILITY(U,$J,358.3,26567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26567,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26567,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,26567,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,26568,0)
 ;;=T76.11XA^^71^1113^7
 ;;^UTILITY(U,$J,358.3,26568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26568,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26568,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,26568,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,26569,0)
 ;;=T76.11XD^^71^1113^8
 ;;^UTILITY(U,$J,358.3,26569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26569,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,26569,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,26569,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,26570,0)
 ;;=Z69.11^^71^1113^31
 ;;^UTILITY(U,$J,358.3,26570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26570,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,26570,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,26570,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,26571,0)
 ;;=Z91.410^^71^1113^35
 ;;^UTILITY(U,$J,358.3,26571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26571,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,26571,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,26571,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,26572,0)
 ;;=Z69.12^^71^1113^27
 ;;^UTILITY(U,$J,358.3,26572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26572,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,26572,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,26572,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,26573,0)
 ;;=T74.21XA^^71^1113^13
 ;;^UTILITY(U,$J,358.3,26573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26573,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,26573,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,26573,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,26574,0)
 ;;=T74.21XD^^71^1113^14
 ;;^UTILITY(U,$J,358.3,26574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26574,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,26574,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,26574,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,26575,0)
 ;;=T76.21XA^^71^1113^15
 ;;^UTILITY(U,$J,358.3,26575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26575,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,26575,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,26575,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,26576,0)
 ;;=T76.21XD^^71^1113^16
 ;;^UTILITY(U,$J,358.3,26576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26576,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,26576,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,26576,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,26577,0)
 ;;=Z69.81^^71^1113^30
 ;;^UTILITY(U,$J,358.3,26577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26577,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,26577,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,26577,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,26578,0)
 ;;=Z69.82^^71^1113^22
 ;;^UTILITY(U,$J,358.3,26578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26578,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,26578,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,26578,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,26579,0)
 ;;=T74.01XA^^71^1113^1
 ;;^UTILITY(U,$J,358.3,26579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26579,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,26579,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,26579,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,26580,0)
 ;;=T74.01XD^^71^1113^2
 ;;^UTILITY(U,$J,358.3,26580,1,0)
 ;;=^358.31IA^4^2
