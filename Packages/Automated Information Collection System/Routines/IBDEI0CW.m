IBDEI0CW ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12901,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12901,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,12901,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,12902,0)
 ;;=H0003^^57^670^5^^^^1
 ;;^UTILITY(U,$J,358.3,12902,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12902,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,12902,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,12903,0)
 ;;=H0004^^57^670^6^^^^1
 ;;^UTILITY(U,$J,358.3,12903,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12903,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,12903,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,12904,0)
 ;;=H0006^^57^670^4^^^^1
 ;;^UTILITY(U,$J,358.3,12904,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12904,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,12904,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,12905,0)
 ;;=H0020^^57^670^7^^^^1
 ;;^UTILITY(U,$J,358.3,12905,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12905,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,12905,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,12906,0)
 ;;=H0025^^57^670^2^^^^1
 ;;^UTILITY(U,$J,358.3,12906,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12906,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,12906,1,3,0)
 ;;=3^Addictions Health Prevention Ed Service
 ;;^UTILITY(U,$J,358.3,12907,0)
 ;;=H0030^^57^670^3^^^^1
 ;;^UTILITY(U,$J,358.3,12907,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12907,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,12907,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,12908,0)
 ;;=90791^^57^671^1^^^^1
 ;;^UTILITY(U,$J,358.3,12908,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12908,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,12908,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,12909,0)
 ;;=T74.11XA^^58^672^5
 ;;^UTILITY(U,$J,358.3,12909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12909,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,12909,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,12909,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,12910,0)
 ;;=T74.11XD^^58^672^6
 ;;^UTILITY(U,$J,358.3,12910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12910,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,12910,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,12910,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,12911,0)
 ;;=T76.11XA^^58^672^7
 ;;^UTILITY(U,$J,358.3,12911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12911,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,12911,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,12911,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,12912,0)
 ;;=T76.11XD^^58^672^8
 ;;^UTILITY(U,$J,358.3,12912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12912,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,12912,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,12912,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,12913,0)
 ;;=Z69.11^^58^672^31
 ;;^UTILITY(U,$J,358.3,12913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12913,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,12913,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,12913,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,12914,0)
 ;;=Z91.410^^58^672^35
 ;;^UTILITY(U,$J,358.3,12914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12914,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,12914,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,12914,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,12915,0)
 ;;=Z69.12^^58^672^27
 ;;^UTILITY(U,$J,358.3,12915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12915,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,12915,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,12915,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,12916,0)
 ;;=T74.21XA^^58^672^13
 ;;^UTILITY(U,$J,358.3,12916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12916,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,12916,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,12916,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,12917,0)
 ;;=T74.21XD^^58^672^14
 ;;^UTILITY(U,$J,358.3,12917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12917,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,12917,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,12917,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,12918,0)
 ;;=T76.21XA^^58^672^15
 ;;^UTILITY(U,$J,358.3,12918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12918,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,12918,1,4,0)
 ;;=4^T76.21XA
 ;;^UTILITY(U,$J,358.3,12918,2)
 ;;=^5054227
 ;;^UTILITY(U,$J,358.3,12919,0)
 ;;=T76.21XD^^58^672^16
 ;;^UTILITY(U,$J,358.3,12919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12919,1,3,0)
 ;;=3^Adult Sexual Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,12919,1,4,0)
 ;;=4^T76.21XD
 ;;^UTILITY(U,$J,358.3,12919,2)
 ;;=^5054228
 ;;^UTILITY(U,$J,358.3,12920,0)
 ;;=Z69.81^^58^672^30
 ;;^UTILITY(U,$J,358.3,12920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12920,1,3,0)
 ;;=3^MH Svc for Victim of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,12920,1,4,0)
 ;;=4^Z69.81
 ;;^UTILITY(U,$J,358.3,12920,2)
 ;;=^5063234
 ;;^UTILITY(U,$J,358.3,12921,0)
 ;;=Z69.82^^58^672^22
 ;;^UTILITY(U,$J,358.3,12921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12921,1,3,0)
 ;;=3^MH Svc for Perpetrator of Nonspousal/Nonpartner Abuse
 ;;^UTILITY(U,$J,358.3,12921,1,4,0)
 ;;=4^Z69.82
 ;;^UTILITY(U,$J,358.3,12921,2)
 ;;=^5063235
 ;;^UTILITY(U,$J,358.3,12922,0)
 ;;=T74.01XA^^58^672^1
 ;;^UTILITY(U,$J,358.3,12922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12922,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,12922,1,4,0)
 ;;=4^T74.01XA
 ;;^UTILITY(U,$J,358.3,12922,2)
 ;;=^5054140
 ;;^UTILITY(U,$J,358.3,12923,0)
 ;;=T74.01XD^^58^672^2
 ;;^UTILITY(U,$J,358.3,12923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12923,1,3,0)
 ;;=3^Adult Neglect,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,12923,1,4,0)
 ;;=4^T74.01XD
 ;;^UTILITY(U,$J,358.3,12923,2)
 ;;=^5054141
 ;;^UTILITY(U,$J,358.3,12924,0)
 ;;=T76.01XA^^58^672^3
 ;;^UTILITY(U,$J,358.3,12924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12924,1,3,0)
 ;;=3^Adult Neglect,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,12924,1,4,0)
 ;;=4^T76.01XA
 ;;^UTILITY(U,$J,358.3,12924,2)
 ;;=^5054215
 ;;^UTILITY(U,$J,358.3,12925,0)
 ;;=T76.01XD^^58^672^4
 ;;^UTILITY(U,$J,358.3,12925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12925,1,3,0)
 ;;=3^Adult Neglect,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,12925,1,4,0)
 ;;=4^T76.01XD
 ;;^UTILITY(U,$J,358.3,12925,2)
 ;;=^5054216
 ;;^UTILITY(U,$J,358.3,12926,0)
 ;;=Z91.412^^58^672^40
 ;;^UTILITY(U,$J,358.3,12926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12926,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Neglect
 ;;^UTILITY(U,$J,358.3,12926,1,4,0)
 ;;=4^Z91.412
 ;;^UTILITY(U,$J,358.3,12926,2)
 ;;=^5063621
 ;;^UTILITY(U,$J,358.3,12927,0)
 ;;=T74.31XA^^58^672^9
 ;;^UTILITY(U,$J,358.3,12927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12927,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,12927,1,4,0)
 ;;=4^T74.31XA
 ;;^UTILITY(U,$J,358.3,12927,2)
 ;;=^5054158
 ;;^UTILITY(U,$J,358.3,12928,0)
 ;;=T74.31XD^^58^672^10
 ;;^UTILITY(U,$J,358.3,12928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12928,1,3,0)
 ;;=3^Adult Psychological Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,12928,1,4,0)
 ;;=4^T74.31XD
