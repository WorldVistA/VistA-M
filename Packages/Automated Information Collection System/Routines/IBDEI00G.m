IBDEI00G ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3)
 ;;=^IBE(358.3,
 ;;^UTILITY(U,$J,358.3,0)
 ;;=IMP/EXP SELECTION^358.3I^48320^46875
 ;;^UTILITY(U,$J,358.3,1,0)
 ;;=H0001^^1^1^1^^^^1
 ;;^UTILITY(U,$J,358.3,1,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1,1,2,0)
 ;;=2^H0001
 ;;^UTILITY(U,$J,358.3,1,1,3,0)
 ;;=3^Addictions Assessment
 ;;^UTILITY(U,$J,358.3,2,0)
 ;;=H0002^^1^1^13^^^^1
 ;;^UTILITY(U,$J,358.3,2,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2,1,2,0)
 ;;=2^H0002
 ;;^UTILITY(U,$J,358.3,2,1,3,0)
 ;;=3^Screen for Addictions Admission Eligibility
 ;;^UTILITY(U,$J,358.3,3,0)
 ;;=H0004^^1^1^9
 ;;^UTILITY(U,$J,358.3,3,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,3,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,3,1,3,0)
 ;;=3^Individual Counseling & Therapy,per 15 Min
 ;;^UTILITY(U,$J,358.3,4,0)
 ;;=H0005^^1^1^2^^^^1
 ;;^UTILITY(U,$J,358.3,4,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,4,1,2,0)
 ;;=2^H0005
 ;;^UTILITY(U,$J,358.3,4,1,3,0)
 ;;=3^Addictions Group Counseling by Clinician
 ;;^UTILITY(U,$J,358.3,5,0)
 ;;=H0020^^1^1^10^^^^1
 ;;^UTILITY(U,$J,358.3,5,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,5,1,3,0)
 ;;=3^Methadone Admin &/or Service by Licensed Program
 ;;^UTILITY(U,$J,358.3,6,0)
 ;;=H0030^^1^1^4^^^^1
 ;;^UTILITY(U,$J,358.3,6,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,6,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,7,0)
 ;;=H0025^^1^1^3^^^^1
 ;;^UTILITY(U,$J,358.3,7,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,7,1,3,0)
 ;;=3^Addictions Hlth Prevention Ed Service
 ;;^UTILITY(U,$J,358.3,8,0)
 ;;=H0046^^1^1^11^^^^1
 ;;^UTILITY(U,$J,358.3,8,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,8,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,9,0)
 ;;=H0003^^1^1^6^^^^1
 ;;^UTILITY(U,$J,358.3,9,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9,1,2,0)
 ;;=2^H0003
 ;;^UTILITY(U,$J,358.3,9,1,3,0)
 ;;=3^Alcohol/Drug Screen;lab analysis
 ;;^UTILITY(U,$J,358.3,10,0)
 ;;=H0006^^1^1^5^^^^1
 ;;^UTILITY(U,$J,358.3,10,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10,1,2,0)
 ;;=2^H0006
 ;;^UTILITY(U,$J,358.3,10,1,3,0)
 ;;=3^Alcohol/Drug Case Management
 ;;^UTILITY(U,$J,358.3,11,0)
 ;;=H2027^^1^1^12^^^^1
 ;;^UTILITY(U,$J,358.3,11,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,11,1,2,0)
 ;;=2^H2027
 ;;^UTILITY(U,$J,358.3,11,1,3,0)
 ;;=3^Psychoeducational Svc,ea 15min
 ;;^UTILITY(U,$J,358.3,12,0)
 ;;=H2011^^1^1^7^^^^1
 ;;^UTILITY(U,$J,358.3,12,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,12,1,2,0)
 ;;=2^H2011
 ;;^UTILITY(U,$J,358.3,12,1,3,0)
 ;;=3^Crisis Intervention Service,per 15 min
 ;;^UTILITY(U,$J,358.3,13,0)
 ;;=S9484^^1^1^8^^^^1
 ;;^UTILITY(U,$J,358.3,13,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,13,1,2,0)
 ;;=2^S9484
 ;;^UTILITY(U,$J,358.3,13,1,3,0)
 ;;=3^Crisis Intervention,per hr
 ;;^UTILITY(U,$J,358.3,14,0)
 ;;=90791^^1^2^1^^^^1
 ;;^UTILITY(U,$J,358.3,14,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14,1,2,0)
 ;;=2^90791
 ;;^UTILITY(U,$J,358.3,14,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation
 ;;^UTILITY(U,$J,358.3,15,0)
 ;;=90792^^1^2^2^^^^1
 ;;^UTILITY(U,$J,358.3,15,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15,1,2,0)
 ;;=2^90792
 ;;^UTILITY(U,$J,358.3,15,1,3,0)
 ;;=3^Psychiatric Diagnostic Evaluation w/ Medical Services
 ;;^UTILITY(U,$J,358.3,16,0)
 ;;=90853^^1^3^3^^^^1
 ;;^UTILITY(U,$J,358.3,16,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,16,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,16,1,3,0)
 ;;=3^Group Psychotherapy
 ;;^UTILITY(U,$J,358.3,17,0)
 ;;=90846^^1^3^1^^^^1
 ;;^UTILITY(U,$J,358.3,17,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17,1,2,0)
 ;;=2^90846
 ;;^UTILITY(U,$J,358.3,17,1,3,0)
 ;;=3^Family Psychotherapy w/o Pt
 ;;^UTILITY(U,$J,358.3,18,0)
 ;;=90847^^1^3^2^^^^1
 ;;^UTILITY(U,$J,358.3,18,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,18,1,3,0)
 ;;=3^Family Psychotherpy w/ Pt
 ;;^UTILITY(U,$J,358.3,19,0)
 ;;=90875^^1^3^18^^^^1
 ;;^UTILITY(U,$J,358.3,19,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,19,1,3,0)
 ;;=3^Psych Thpy w/ Biofeedback 20-30min
 ;;^UTILITY(U,$J,358.3,20,0)
 ;;=90876^^1^3^19^^^^1
 ;;^UTILITY(U,$J,358.3,20,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,20,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,20,1,3,0)
 ;;=3^Psych Thpy w/ Biofeedback 45-50min
 ;;^UTILITY(U,$J,358.3,21,0)
 ;;=90832^^1^3^12^^^^1
 ;;^UTILITY(U,$J,358.3,21,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,21,1,2,0)
 ;;=2^90832
 ;;^UTILITY(U,$J,358.3,21,1,3,0)
 ;;=3^PsyTx Pt/Fam 16-37 Min
 ;;^UTILITY(U,$J,358.3,22,0)
 ;;=90834^^1^3^14^^^^1
 ;;^UTILITY(U,$J,358.3,22,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22,1,2,0)
 ;;=2^90834
 ;;^UTILITY(U,$J,358.3,22,1,3,0)
 ;;=3^PsyTx Pt/Fam 38-52 Min
 ;;^UTILITY(U,$J,358.3,23,0)
 ;;=90837^^1^3^16^^^^1
 ;;^UTILITY(U,$J,358.3,23,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23,1,2,0)
 ;;=2^90837
 ;;^UTILITY(U,$J,358.3,23,1,3,0)
 ;;=3^PsyTx Pt/Fam 53-89 Min
 ;;^UTILITY(U,$J,358.3,24,0)
 ;;=90833^^1^3^13^^^^1
 ;;^UTILITY(U,$J,358.3,24,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24,1,2,0)
 ;;=2^90833
 ;;^UTILITY(U,$J,358.3,24,1,3,0)
 ;;=3^PsyTx Pt/Fam 16-37 Min-Report w/ E&M code
 ;;^UTILITY(U,$J,358.3,25,0)
 ;;=90836^^1^3^15^^^^1
 ;;^UTILITY(U,$J,358.3,25,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,25,1,2,0)
 ;;=2^90836
 ;;^UTILITY(U,$J,358.3,25,1,3,0)
 ;;=3^PsyTx Pt/Fam 38-52 Min-Report w/ E&M code
 ;;^UTILITY(U,$J,358.3,26,0)
 ;;=90838^^1^3^17^^^^1
 ;;^UTILITY(U,$J,358.3,26,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26,1,2,0)
 ;;=2^90838
 ;;^UTILITY(U,$J,358.3,26,1,3,0)
 ;;=3^PsyTx Pt/Fam 53-89 Min-Report w/ E&M code
 ;;^UTILITY(U,$J,358.3,27,0)
 ;;=90839^^1^3^9^^^^1
 ;;^UTILITY(U,$J,358.3,27,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27,1,2,0)
 ;;=2^90839
 ;;^UTILITY(U,$J,358.3,27,1,3,0)
 ;;=3^PsyTx Crisis Initial 30-74 Min
 ;;^UTILITY(U,$J,358.3,28,0)
 ;;=90840^^1^3^10^^^^1
 ;;^UTILITY(U,$J,358.3,28,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28,1,2,0)
 ;;=2^90840
 ;;^UTILITY(U,$J,358.3,28,1,3,0)
 ;;=3^PsyTx Crisis,Ea Addl 30Min
 ;;^UTILITY(U,$J,358.3,29,0)
 ;;=90785^^1^3^11^^^^1
 ;;^UTILITY(U,$J,358.3,29,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29,1,2,0)
 ;;=2^90785
 ;;^UTILITY(U,$J,358.3,29,1,3,0)
 ;;=3^PsyTx Interactive Complexity,Add-On
 ;;^UTILITY(U,$J,358.3,30,0)
 ;;=99354^^1^3^7^^^^1
 ;;^UTILITY(U,$J,358.3,30,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,30,1,2,0)
 ;;=2^99354
 ;;^UTILITY(U,$J,358.3,30,1,3,0)
 ;;=3^Prolonged Svc/OPT 1st Hr,Add-On
 ;;^UTILITY(U,$J,358.3,31,0)
 ;;=99355^^1^3^8^^^^1
 ;;^UTILITY(U,$J,358.3,31,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,31,1,3,0)
 ;;=3^Prolonged Svc/OPT,Ea Addl 30 Min,Add-On
 ;;^UTILITY(U,$J,358.3,32,0)
 ;;=99356^^1^3^5^^^^1
 ;;^UTILITY(U,$J,358.3,32,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,32,1,2,0)
 ;;=2^99356
 ;;^UTILITY(U,$J,358.3,32,1,3,0)
 ;;=3^Prolonged Svc INPT/OBS 1st Hr,Add-On
 ;;^UTILITY(U,$J,358.3,33,0)
 ;;=99357^^1^3^6^^^^1
 ;;^UTILITY(U,$J,358.3,33,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,33,1,2,0)
 ;;=2^99357
 ;;^UTILITY(U,$J,358.3,33,1,3,0)
 ;;=3^Prolonged Svc INPT/OBS,Ea Addl 30 Min,Add-On
 ;;^UTILITY(U,$J,358.3,34,0)
 ;;=90849^^1^3^4^^^^1
 ;;^UTILITY(U,$J,358.3,34,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,34,1,2,0)
 ;;=2^90849
 ;;^UTILITY(U,$J,358.3,34,1,3,0)
 ;;=3^Multiple Family Psychotherapy
 ;;^UTILITY(U,$J,358.3,35,0)
 ;;=96116^^1^4^11^^^^1
 ;;^UTILITY(U,$J,358.3,35,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,35,1,2,0)
 ;;=2^96116
 ;;^UTILITY(U,$J,358.3,35,1,3,0)
 ;;=3^Neurobehavioral Status Exam by Psych/Phys,Per Hr w/ Interp & Rpt
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
