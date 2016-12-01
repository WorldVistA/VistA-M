IBDEI0BM ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14740,1,3,0)
 ;;=3^Alc/Drug Abuse Assm & Intvn > 30min
 ;;^UTILITY(U,$J,358.3,14741,0)
 ;;=G0409^^44^648^18^^^^1
 ;;^UTILITY(U,$J,358.3,14741,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14741,1,2,0)
 ;;=2^G0409
 ;;^UTILITY(U,$J,358.3,14741,1,3,0)
 ;;=3^Psych Svcs by CORF R/T Pt rehab goals,ea 15min
 ;;^UTILITY(U,$J,358.3,14742,0)
 ;;=S9453^^44^648^24^^^^1
 ;;^UTILITY(U,$J,358.3,14742,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14742,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,14742,1,3,0)
 ;;=3^Smoking Cessation Class per session
 ;;^UTILITY(U,$J,358.3,14743,0)
 ;;=G0436^^44^648^28^^^^1
 ;;^UTILITY(U,$J,358.3,14743,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14743,1,2,0)
 ;;=2^G0436
 ;;^UTILITY(U,$J,358.3,14743,1,3,0)
 ;;=3^Tob/Smoking Cess Counsel Asymp Pt,3-10min
 ;;^UTILITY(U,$J,358.3,14744,0)
 ;;=G0437^^44^648^27^^^^1
 ;;^UTILITY(U,$J,358.3,14744,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14744,1,2,0)
 ;;=2^G0437
 ;;^UTILITY(U,$J,358.3,14744,1,3,0)
 ;;=3^Tob/Smoking Cess Counsel Asymp Pt > 10min
 ;;^UTILITY(U,$J,358.3,14745,0)
 ;;=96101^^44^648^20^^^^1
 ;;^UTILITY(U,$J,358.3,14745,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14745,1,2,0)
 ;;=2^96101
 ;;^UTILITY(U,$J,358.3,14745,1,3,0)
 ;;=3^Psych Test by PhD,per hr w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14746,0)
 ;;=96105^^44^648^3^^^^1
 ;;^UTILITY(U,$J,358.3,14746,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14746,1,2,0)
 ;;=2^96105
 ;;^UTILITY(U,$J,358.3,14746,1,3,0)
 ;;=3^Aphasia Assessment by PhD,per hr
 ;;^UTILITY(U,$J,358.3,14747,0)
 ;;=T1016^^44^648^4^^^^1
 ;;^UTILITY(U,$J,358.3,14747,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14747,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,14747,1,3,0)
 ;;=3^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,14748,0)
 ;;=S9484^^44^648^8^^^^1
 ;;^UTILITY(U,$J,358.3,14748,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14748,1,2,0)
 ;;=2^S9484
 ;;^UTILITY(U,$J,358.3,14748,1,3,0)
 ;;=3^Crisis Intervention MH Svc,per hr
 ;;^UTILITY(U,$J,358.3,14749,0)
 ;;=96110^^44^648^9^^^^1
 ;;^UTILITY(U,$J,358.3,14749,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14749,1,2,0)
 ;;=2^96110
 ;;^UTILITY(U,$J,358.3,14749,1,3,0)
 ;;=3^Developmental Screen by PhD w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14750,0)
 ;;=96111^^44^648^10^^^^1
 ;;^UTILITY(U,$J,358.3,14750,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14750,1,2,0)
 ;;=2^96111
 ;;^UTILITY(U,$J,358.3,14750,1,3,0)
 ;;=3^Developmental Testing by PhD w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14751,0)
 ;;=90882^^44^648^11^^^^1
 ;;^UTILITY(U,$J,358.3,14751,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14751,1,2,0)
 ;;=2^90882
 ;;^UTILITY(U,$J,358.3,14751,1,3,0)
 ;;=3^Envir Intervent w/ Agency/Inst
 ;;^UTILITY(U,$J,358.3,14752,0)
 ;;=90885^^44^648^17^^^^1
 ;;^UTILITY(U,$J,358.3,14752,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14752,1,2,0)
 ;;=2^90885
 ;;^UTILITY(U,$J,358.3,14752,1,3,0)
 ;;=3^Psych Eval of Hosp Records for Med Dx
 ;;^UTILITY(U,$J,358.3,14753,0)
 ;;=H2027^^44^648^22^^^^1
 ;;^UTILITY(U,$J,358.3,14753,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14753,1,2,0)
 ;;=2^H2027
 ;;^UTILITY(U,$J,358.3,14753,1,3,0)
 ;;=3^Psychoed Svc w/ Pt & Fam,ea 15 min
 ;;^UTILITY(U,$J,358.3,14754,0)
 ;;=96150^^44^649^1^^^^1
 ;;^UTILITY(U,$J,358.3,14754,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14754,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,14754,1,3,0)
 ;;=3^Hlth/Behav Assess,Initial,ea 15min
 ;;^UTILITY(U,$J,358.3,14755,0)
 ;;=96151^^44^649^5^^^^1
 ;;^UTILITY(U,$J,358.3,14755,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14755,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,14755,1,3,0)
 ;;=3^Hlth/Behav Reassess,ea 15min
 ;;^UTILITY(U,$J,358.3,14756,0)
 ;;=96152^^44^649^4^^^^1
 ;;^UTILITY(U,$J,358.3,14756,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14756,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,14756,1,3,0)
 ;;=3^Hlth/Behav Intervent,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,14757,0)
 ;;=96154^^44^649^2^^^^1
 ;;^UTILITY(U,$J,358.3,14757,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14757,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,14757,1,3,0)
 ;;=3^Hlth/Behav Intervent,Fam w/Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,14758,0)
 ;;=96155^^44^649^3^^^^1
 ;;^UTILITY(U,$J,358.3,14758,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14758,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,14758,1,3,0)
 ;;=3^Hlth/Behav Intervent,Fam w/o Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,14759,0)
 ;;=99368^^44^650^2^^^^1
 ;;^UTILITY(U,$J,358.3,14759,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14759,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,14759,1,3,0)
 ;;=3^Non-Rx Provider Team Conf w/o Pt &/or Family 30+ min
 ;;^UTILITY(U,$J,358.3,14760,0)
 ;;=99366^^44^650^1^^^^1
 ;;^UTILITY(U,$J,358.3,14760,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14760,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,14760,1,3,0)
 ;;=3^Non-Rx Provider Team Conf w/ Pt &/or Family 30+ min
 ;;^UTILITY(U,$J,358.3,14761,0)
 ;;=90785^^44^651^1^^^^1
 ;;^UTILITY(U,$J,358.3,14761,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14761,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,14761,1,3,0)
 ;;=3^Interactive Complexity
 ;;^UTILITY(U,$J,358.3,14762,0)
 ;;=H0001^^44^652^1^^^^1
 ;;^UTILITY(U,$J,358.3,14762,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14762,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,14762,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,14763,0)
 ;;=H0002^^44^652^8^^^^1
 ;;^UTILITY(U,$J,358.3,14763,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14763,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,14763,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,14764,0)
 ;;=H0003^^44^652^5^^^^1
 ;;^UTILITY(U,$J,358.3,14764,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14764,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,14764,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,14765,0)
 ;;=H0004^^44^652^6^^^^1
 ;;^UTILITY(U,$J,358.3,14765,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14765,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,14765,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 min
 ;;^UTILITY(U,$J,358.3,14766,0)
 ;;=H0006^^44^652^4^^^^1
 ;;^UTILITY(U,$J,358.3,14766,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14766,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,14766,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,14767,0)
 ;;=H0020^^44^652^7^^^^1
 ;;^UTILITY(U,$J,358.3,14767,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14767,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,14767,1,3,0)
 ;;=3^Methadone Admin &/or Svc by Licensed Program
 ;;^UTILITY(U,$J,358.3,14768,0)
 ;;=H0025^^44^652^2^^^^1
 ;;^UTILITY(U,$J,358.3,14768,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14768,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,14768,1,3,0)
 ;;=3^Addictions Health Prevention Ed Service
 ;;^UTILITY(U,$J,358.3,14769,0)
 ;;=H0030^^44^652^3^^^^1
 ;;^UTILITY(U,$J,358.3,14769,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14769,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,14769,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,14770,0)
 ;;=90791^^44^653^1^^^^1
 ;;^UTILITY(U,$J,358.3,14770,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14770,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,14770,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,14771,0)
 ;;=T74.11XA^^45^654^5
 ;;^UTILITY(U,$J,358.3,14771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14771,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,14771,1,4,0)
 ;;=4^T74.11XA
 ;;^UTILITY(U,$J,358.3,14771,2)
 ;;=^5054146
 ;;^UTILITY(U,$J,358.3,14772,0)
 ;;=T74.11XD^^45^654^6
 ;;^UTILITY(U,$J,358.3,14772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14772,1,3,0)
 ;;=3^Adult Physical Abuse,Confirmed,Subsequent Encounter 
 ;;^UTILITY(U,$J,358.3,14772,1,4,0)
 ;;=4^T74.11XD
 ;;^UTILITY(U,$J,358.3,14772,2)
 ;;=^5054147
 ;;^UTILITY(U,$J,358.3,14773,0)
 ;;=T76.11XA^^45^654^7
 ;;^UTILITY(U,$J,358.3,14773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14773,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Initial Encounter  
 ;;^UTILITY(U,$J,358.3,14773,1,4,0)
 ;;=4^T76.11XA
 ;;^UTILITY(U,$J,358.3,14773,2)
 ;;=^5054221
 ;;^UTILITY(U,$J,358.3,14774,0)
 ;;=T76.11XD^^45^654^8
 ;;^UTILITY(U,$J,358.3,14774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14774,1,3,0)
 ;;=3^Adult Physical Abuse,Suspected,Subsequent Encounter  
 ;;^UTILITY(U,$J,358.3,14774,1,4,0)
 ;;=4^T76.11XD
 ;;^UTILITY(U,$J,358.3,14774,2)
 ;;=^5054222
 ;;^UTILITY(U,$J,358.3,14775,0)
 ;;=Z69.11^^45^654^31
 ;;^UTILITY(U,$J,358.3,14775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14775,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Neglect
 ;;^UTILITY(U,$J,358.3,14775,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,14775,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,14776,0)
 ;;=Z91.410^^45^654^35
 ;;^UTILITY(U,$J,358.3,14776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14776,1,3,0)
 ;;=3^Past Hx of Spouse/Partner Violence,Physical 
 ;;^UTILITY(U,$J,358.3,14776,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,14776,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,14777,0)
 ;;=Z69.12^^45^654^27
 ;;^UTILITY(U,$J,358.3,14777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14777,1,3,0)
 ;;=3^MH Svc for Perpetrator of Spousal/Partner Violence-Physical,Sexual or Psychological
 ;;^UTILITY(U,$J,358.3,14777,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,14777,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,14778,0)
 ;;=T74.21XA^^45^654^13
 ;;^UTILITY(U,$J,358.3,14778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14778,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Initial Encounter 
 ;;^UTILITY(U,$J,358.3,14778,1,4,0)
 ;;=4^T74.21XA
 ;;^UTILITY(U,$J,358.3,14778,2)
 ;;=^5054152
 ;;^UTILITY(U,$J,358.3,14779,0)
 ;;=T74.21XD^^45^654^14
 ;;^UTILITY(U,$J,358.3,14779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14779,1,3,0)
 ;;=3^Adult Sexual Abuse,Confirmed,Subsequent Encounter 
