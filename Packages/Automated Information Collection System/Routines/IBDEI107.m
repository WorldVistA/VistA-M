IBDEI107 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36432,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,36432,1,3,0)
 ;;=3^Psychosocial Assessment
 ;;^UTILITY(U,$J,358.3,36433,0)
 ;;=T1016^^134^1790^1^^^^1
 ;;^UTILITY(U,$J,358.3,36433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36433,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,36433,1,3,0)
 ;;=3^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,36434,0)
 ;;=G0155^^134^1791^1^^^^1
 ;;^UTILITY(U,$J,358.3,36434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36434,1,2,0)
 ;;=2^G0155
 ;;^UTILITY(U,$J,358.3,36434,1,3,0)
 ;;=3^Home Visit Ea 15 min
 ;;^UTILITY(U,$J,358.3,36435,0)
 ;;=99510^^134^1791^3^^^^1
 ;;^UTILITY(U,$J,358.3,36435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36435,1,2,0)
 ;;=2^99510
 ;;^UTILITY(U,$J,358.3,36435,1,3,0)
 ;;=3^Home Visit for Indiv/Fam/Marriage Counseling
 ;;^UTILITY(U,$J,358.3,36436,0)
 ;;=99509^^134^1791^2^^^^1
 ;;^UTILITY(U,$J,358.3,36436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36436,1,2,0)
 ;;=2^99509
 ;;^UTILITY(U,$J,358.3,36436,1,3,0)
 ;;=3^Home Visit for ADL
 ;;^UTILITY(U,$J,358.3,36437,0)
 ;;=S9127^^134^1791^5^^^^1
 ;;^UTILITY(U,$J,358.3,36437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36437,1,2,0)
 ;;=2^S9127
 ;;^UTILITY(U,$J,358.3,36437,1,3,0)
 ;;=3^SW Visit in Home,per diem
 ;;^UTILITY(U,$J,358.3,36438,0)
 ;;=T1016^^134^1791^4^^^^1
 ;;^UTILITY(U,$J,358.3,36438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36438,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,36438,1,3,0)
 ;;=3^Home Visit for Individual Case Management
 ;;^UTILITY(U,$J,358.3,36439,0)
 ;;=T1016^^134^1792^3^^^^1
 ;;^UTILITY(U,$J,358.3,36439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36439,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,36439,1,3,0)
 ;;=3^Community Residential Care F/U,ea 15 min
 ;;^UTILITY(U,$J,358.3,36440,0)
 ;;=T1016^^134^1792^4^^^^1
 ;;^UTILITY(U,$J,358.3,36440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36440,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,36440,1,3,0)
 ;;=3^Contract Nursing Home F/U,ea 15 min
 ;;^UTILITY(U,$J,358.3,36441,0)
 ;;=S9453^^134^1793^1^^^^1
 ;;^UTILITY(U,$J,358.3,36441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36441,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,36441,1,3,0)
 ;;=3^Smoking Cessation Class
 ;;^UTILITY(U,$J,358.3,36442,0)
 ;;=96150^^134^1794^2^^^^1
 ;;^UTILITY(U,$J,358.3,36442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36442,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,36442,1,3,0)
 ;;=3^Assess Hlth/Beh,Init Ea 15min
 ;;^UTILITY(U,$J,358.3,36443,0)
 ;;=96151^^134^1794^3^^^^1
 ;;^UTILITY(U,$J,358.3,36443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36443,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,36443,1,3,0)
 ;;=3^Assess Hlth/Beh,Subs Ea 15min
 ;;^UTILITY(U,$J,358.3,36444,0)
 ;;=96152^^134^1794^7^^^^1
 ;;^UTILITY(U,$J,358.3,36444,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36444,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,36444,1,3,0)
 ;;=3^Inter Hlth/Beh,Ind Ea 15min
 ;;^UTILITY(U,$J,358.3,36445,0)
 ;;=96153^^134^1794^6^^^^1
 ;;^UTILITY(U,$J,358.3,36445,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36445,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,36445,1,3,0)
 ;;=3^Inter Hlth/Beh,Grp Ea 15min
 ;;^UTILITY(U,$J,358.3,36446,0)
 ;;=96154^^134^1794^5^^^^1
 ;;^UTILITY(U,$J,358.3,36446,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36446,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,36446,1,3,0)
 ;;=3^Inter Hlth/Beh,Fam w/Pt Ea 15m
 ;;^UTILITY(U,$J,358.3,36447,0)
 ;;=96155^^134^1794^4^^^^1
 ;;^UTILITY(U,$J,358.3,36447,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36447,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,36447,1,3,0)
 ;;=3^Int Hlth/Beh Fam w/o Pt Ea 15m
 ;;^UTILITY(U,$J,358.3,36448,0)
 ;;=99420^^134^1794^1^^^^1
 ;;^UTILITY(U,$J,358.3,36448,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36448,1,2,0)
 ;;=2^99420
 ;;^UTILITY(U,$J,358.3,36448,1,3,0)
 ;;=3^Admin/Int Hlth Risk Assess Tst
 ;;^UTILITY(U,$J,358.3,36449,0)
 ;;=S9445^^134^1795^3^^^^1
 ;;^UTILITY(U,$J,358.3,36449,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36449,1,2,0)
 ;;=2^S9445
 ;;^UTILITY(U,$J,358.3,36449,1,3,0)
 ;;=3^Pt Educ,Individual,NOS
 ;;^UTILITY(U,$J,358.3,36450,0)
 ;;=S9446^^134^1795^2^^^^1
 ;;^UTILITY(U,$J,358.3,36450,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36450,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,36450,1,3,0)
 ;;=3^Pt Educ,Group,NOS
 ;;^UTILITY(U,$J,358.3,36451,0)
 ;;=G0177^^134^1795^1^^^^1
 ;;^UTILITY(U,$J,358.3,36451,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36451,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,36451,1,3,0)
 ;;=3^Train & Ed Svcs R/T Care & Tx of Disabling MH Problem 45+ min
 ;;^UTILITY(U,$J,358.3,36452,0)
 ;;=S9454^^134^1795^4^^^^1
 ;;^UTILITY(U,$J,358.3,36452,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36452,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,36452,1,3,0)
 ;;=3^Stress Mgmt Class
 ;;^UTILITY(U,$J,358.3,36453,0)
 ;;=99366^^134^1796^1^^^^1
 ;;^UTILITY(U,$J,358.3,36453,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36453,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,36453,1,3,0)
 ;;=3^Non-Phy Team Conf w/ Pt &/or Fam,30 min+
 ;;^UTILITY(U,$J,358.3,36454,0)
 ;;=T74.11XA^^135^1797^5
 ;;^UTILITY(U,$J,358.3,36454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36454,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,36454,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,36454,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,36455,0)
 ;;=T74.11XD^^135^1797^6
 ;;^UTILITY(U,$J,358.3,36455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36455,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,36455,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,36455,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,36456,0)
 ;;=T76.11XA^^135^1797^7
 ;;^UTILITY(U,$J,358.3,36456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36456,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,36456,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,36456,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,36457,0)
 ;;=T76.11XD^^135^1797^8
 ;;^UTILITY(U,$J,358.3,36457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36457,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,36457,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,36457,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,36458,0)
 ;;=Z69.11^^135^1797^31
 ;;^UTILITY(U,$J,358.3,36458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36458,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,36458,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,36458,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,36459,0)
 ;;=Z91.410^^135^1797^35
 ;;^UTILITY(U,$J,358.3,36459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36459,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,36459,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,36459,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,36460,0)
 ;;=Z69.12^^135^1797^27
 ;;^UTILITY(U,$J,358.3,36460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36460,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,36460,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,36460,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,36461,0)
 ;;=T74.21XA^^135^1797^13
 ;;^UTILITY(U,$J,358.3,36461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36461,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,36461,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,36461,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,36462,0)
 ;;=T74.21XD^^135^1797^14
 ;;^UTILITY(U,$J,358.3,36462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36462,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,36462,1,4,0)
 ;;=4^T74.21XD
 ;;^UTILITY(U,$J,358.3,36462,2)
 ;;=^5054153
 ;;^UTILITY(U,$J,358.3,36463,0)
 ;;=T76.21XA^^135^1797^15
