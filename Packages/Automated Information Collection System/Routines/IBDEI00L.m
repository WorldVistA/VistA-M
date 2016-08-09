IBDEI00L ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36,0)
 ;;=96120^^1^4^12^^^^1
 ;;^UTILITY(U,$J,358.3,36,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,36,1,2,0)
 ;;=2^96120
 ;;^UTILITY(U,$J,358.3,36,1,3,0)
 ;;=3^Neuropsych Tst Admin by Computer w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,37,0)
 ;;=96118^^1^4^13^^^^1
 ;;^UTILITY(U,$J,358.3,37,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37,1,2,0)
 ;;=2^96118
 ;;^UTILITY(U,$J,358.3,37,1,3,0)
 ;;=3^Neuropsych Tst Admin by Psych/Phys,Per Hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,38,0)
 ;;=96119^^1^4^14^^^^1
 ;;^UTILITY(U,$J,358.3,38,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,38,1,2,0)
 ;;=2^96119
 ;;^UTILITY(U,$J,358.3,38,1,3,0)
 ;;=3^Neuropsych Tst Admin by Tech Per Hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,39,0)
 ;;=90899^^1^4^22^^^^1
 ;;^UTILITY(U,$J,358.3,39,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,39,1,2,0)
 ;;=2^90899
 ;;^UTILITY(U,$J,358.3,39,1,3,0)
 ;;=3^Unlisted Psych Service 
 ;;^UTILITY(U,$J,358.3,40,0)
 ;;=96103^^1^4^16^^^^1
 ;;^UTILITY(U,$J,358.3,40,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,40,1,2,0)
 ;;=2^96103
 ;;^UTILITY(U,$J,358.3,40,1,3,0)
 ;;=3^Psych Tst Admin by Computer w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,41,0)
 ;;=96101^^1^4^17^^^^1
 ;;^UTILITY(U,$J,358.3,41,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41,1,2,0)
 ;;=2^96101
 ;;^UTILITY(U,$J,358.3,41,1,3,0)
 ;;=3^Psych Tst Admin by Psych/Phys,Per Hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,42,0)
 ;;=96102^^1^4^18^^^^1
 ;;^UTILITY(U,$J,358.3,42,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,42,1,2,0)
 ;;=2^96102
 ;;^UTILITY(U,$J,358.3,42,1,3,0)
 ;;=3^Psych Tst Admin by Tech Ea Hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,43,0)
 ;;=96127^^1^4^1^^^^1
 ;;^UTILITY(U,$J,358.3,43,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,43,1,2,0)
 ;;=2^96127
 ;;^UTILITY(U,$J,358.3,43,1,3,0)
 ;;=3^Brief Emotional/Behav Assess w/ Score & Document 
 ;;^UTILITY(U,$J,358.3,44,0)
 ;;=T1016^^1^4^2^^^^1
 ;;^UTILITY(U,$J,358.3,44,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,44,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,44,1,3,0)
 ;;=3^Case Mgmt,ea 15 min
 ;;^UTILITY(U,$J,358.3,45,0)
 ;;=99078^^1^4^3^^^^1
 ;;^UTILITY(U,$J,358.3,45,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,45,1,2,0)
 ;;=2^99078
 ;;^UTILITY(U,$J,358.3,45,1,3,0)
 ;;=3^Education Svcs in Group Setting
 ;;^UTILITY(U,$J,358.3,46,0)
 ;;=S9446^^1^4^4^^^^1
 ;;^UTILITY(U,$J,358.3,46,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,46,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,46,1,3,0)
 ;;=3^Group Education Svcs Non-Phys,NOS
 ;;^UTILITY(U,$J,358.3,47,0)
 ;;=96150^^1^4^5^^^^1
 ;;^UTILITY(U,$J,358.3,47,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,47,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,47,1,3,0)
 ;;=3^Hlth/Behav Assm,Indiv,Init,ea 15 min
 ;;^UTILITY(U,$J,358.3,48,0)
 ;;=96155^^1^4^7^^^^1
 ;;^UTILITY(U,$J,358.3,48,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,48,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,48,1,3,0)
 ;;=3^Hlth/Behav Family Interven w/o Pt,ea 15 min
 ;;^UTILITY(U,$J,358.3,49,0)
 ;;=96154^^1^4^6^^^^1
 ;;^UTILITY(U,$J,358.3,49,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,49,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,49,1,3,0)
 ;;=3^Hlth/Behav Family Interven w/ Pt,ea 15 min
 ;;^UTILITY(U,$J,358.3,50,0)
 ;;=96153^^1^4^8^^^^1
 ;;^UTILITY(U,$J,358.3,50,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,50,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,50,1,3,0)
 ;;=3^Hlth/Behav Group,2+ pts,ea 15 min
 ;;^UTILITY(U,$J,358.3,51,0)
 ;;=96152^^1^4^9^^^^1
 ;;^UTILITY(U,$J,358.3,51,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,51,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,51,1,3,0)
 ;;=3^Hlth/Behav Interven,Indiv,ea 15 min
 ;;^UTILITY(U,$J,358.3,52,0)
 ;;=96151^^1^4^10^^^^1
 ;;^UTILITY(U,$J,358.3,52,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,52,1,3,0)
 ;;=3^Hlth/Behav Reassm,Indiv,ea 15 min
 ;;^UTILITY(U,$J,358.3,53,0)
 ;;=S9452^^1^4^15^^^^1
 ;;^UTILITY(U,$J,358.3,53,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,53,1,2,0)
 ;;=2^S9452
 ;;^UTILITY(U,$J,358.3,53,1,3,0)
 ;;=3^Nutrition Class,Non-Phys,per session
 ;;^UTILITY(U,$J,358.3,54,0)
 ;;=98961^^1^4^19^^^^1
 ;;^UTILITY(U,$J,358.3,54,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,54,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,54,1,3,0)
 ;;=3^Self Mgmt Educ/Trng,2-4 pts,ea 30 min
 ;;^UTILITY(U,$J,358.3,55,0)
 ;;=98962^^1^4^20^^^^1
 ;;^UTILITY(U,$J,358.3,55,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,55,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,55,1,3,0)
 ;;=3^Self Mgmt Educ/Trng,5-8 pts,ea 30 min
 ;;^UTILITY(U,$J,358.3,56,0)
 ;;=S9454^^1^4^21^^^^1
 ;;^UTILITY(U,$J,358.3,56,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,56,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,56,1,3,0)
 ;;=3^Stress Mgmt Class
 ;;^UTILITY(U,$J,358.3,57,0)
 ;;=S9449^^1^4^23^^^^1
 ;;^UTILITY(U,$J,358.3,57,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,57,1,2,0)
 ;;=2^S9449
 ;;^UTILITY(U,$J,358.3,57,1,3,0)
 ;;=3^Weight Mgmt Class,Non-Phys,per session
 ;;^UTILITY(U,$J,358.3,58,0)
 ;;=99406^^1^5^2^^^^1
 ;;^UTILITY(U,$J,358.3,58,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,58,1,2,0)
 ;;=2^99406
 ;;^UTILITY(U,$J,358.3,58,1,3,0)
 ;;=3^Smoking/Tob Cessation Counsel,Asymp PT, 3-10Min
 ;;^UTILITY(U,$J,358.3,59,0)
 ;;=99407^^1^5^3^^^^1
 ;;^UTILITY(U,$J,358.3,59,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,59,1,2,0)
 ;;=2^99407
 ;;^UTILITY(U,$J,358.3,59,1,3,0)
 ;;=3^Smoking/Tob Cessation Counsel,Asympt PT,>10Min
 ;;^UTILITY(U,$J,358.3,60,0)
 ;;=S9453^^1^5^1^^^^1
 ;;^UTILITY(U,$J,358.3,60,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,60,1,2,0)
 ;;=2^S9453
 ;;^UTILITY(U,$J,358.3,60,1,3,0)
 ;;=3^Smoking Cessation Class,Non-Phys,per session
 ;;^UTILITY(U,$J,358.3,61,0)
 ;;=J2680^^1^6^1^^^^1
 ;;^UTILITY(U,$J,358.3,61,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,61,1,2,0)
 ;;=2^J2680
 ;;^UTILITY(U,$J,358.3,61,1,3,0)
 ;;=3^Fluphenazine Decanoate up to 25mg
 ;;^UTILITY(U,$J,358.3,62,0)
 ;;=J2426^^1^6^3^^^^1
 ;;^UTILITY(U,$J,358.3,62,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,62,1,2,0)
 ;;=2^J2426
 ;;^UTILITY(U,$J,358.3,62,1,3,0)
 ;;=3^Paliperidone Palmitate Extended Release 1mg
 ;;^UTILITY(U,$J,358.3,63,0)
 ;;=J1631^^1^6^2^^^^1
 ;;^UTILITY(U,$J,358.3,63,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,63,1,2,0)
 ;;=2^J1631
 ;;^UTILITY(U,$J,358.3,63,1,3,0)
 ;;=3^Haliperidol Decanoate per 50mg
 ;;^UTILITY(U,$J,358.3,64,0)
 ;;=J2794^^1^6^4^^^^1
 ;;^UTILITY(U,$J,358.3,64,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,64,1,2,0)
 ;;=2^J2794
 ;;^UTILITY(U,$J,358.3,64,1,3,0)
 ;;=3^Risperidone Long Acting 0.5mg
 ;;^UTILITY(U,$J,358.3,65,0)
 ;;=96372^^1^6^5^^^^1
 ;;^UTILITY(U,$J,358.3,65,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,65,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,65,1,3,0)
 ;;=3^Ther/Proph/Diag Inj,SC/IM
 ;;^UTILITY(U,$J,358.3,66,0)
 ;;=99212^^2^7^1
 ;;^UTILITY(U,$J,358.3,66,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,66,1,1,0)
 ;;=1^PROBLEM FOCUSED HX OR EXAM;SF MDM
 ;;^UTILITY(U,$J,358.3,66,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,67,0)
 ;;=99213^^2^7^2
 ;;^UTILITY(U,$J,358.3,67,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,67,1,1,0)
 ;;=1^EXPAND PROB FOCUS HX OR EXAM;LOW COMPLEX MDM
 ;;^UTILITY(U,$J,358.3,67,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,68,0)
 ;;=99214^^2^7^3
 ;;^UTILITY(U,$J,358.3,68,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,68,1,1,0)
 ;;=1^DETAILED HX OR EXAM;MOD COMPLEX MDM
 ;;^UTILITY(U,$J,358.3,68,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,69,0)
 ;;=99215^^2^7^4
 ;;^UTILITY(U,$J,358.3,69,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,69,1,1,0)
 ;;=1^COMPREH HX OR EXAM;HIGH COMPLEX MDM
 ;;^UTILITY(U,$J,358.3,69,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,70,0)
 ;;=99241^^2^8^1
 ;;^UTILITY(U,$J,358.3,70,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,70,1,1,0)
 ;;=1^PROBLEM FOCUSED HX & EXAM;SF MDM
