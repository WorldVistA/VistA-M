IBDEI0KY ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26502,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26502,1,2,0)
 ;;=2^97537
 ;;^UTILITY(U,$J,358.3,26502,1,3,0)
 ;;=3^Community/Work Reintegration,ea 15 min
 ;;^UTILITY(U,$J,358.3,26503,0)
 ;;=97532^^70^1105^4^^^^1
 ;;^UTILITY(U,$J,358.3,26503,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26503,1,2,0)
 ;;=2^97532
 ;;^UTILITY(U,$J,358.3,26503,1,3,0)
 ;;=3^Cognitive Skills Development,ea 15min
 ;;^UTILITY(U,$J,358.3,26504,0)
 ;;=97533^^70^1105^28^^^^1
 ;;^UTILITY(U,$J,358.3,26504,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26504,1,2,0)
 ;;=2^97533
 ;;^UTILITY(U,$J,358.3,26504,1,3,0)
 ;;=3^Sensory Integrative Techniques,ea 15 min
 ;;^UTILITY(U,$J,358.3,26505,0)
 ;;=H0046^^70^1105^19^^^^1
 ;;^UTILITY(U,$J,358.3,26505,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26505,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,26505,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,26506,0)
 ;;=96102^^70^1105^22^^^^1
 ;;^UTILITY(U,$J,358.3,26506,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26506,1,2,0)
 ;;=2^96102
 ;;^UTILITY(U,$J,358.3,26506,1,3,0)
 ;;=3^Psych Test Admin by Tech,per hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26507,0)
 ;;=96103^^70^1105^20^^^^1
 ;;^UTILITY(U,$J,358.3,26507,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26507,1,2,0)
 ;;=2^96103
 ;;^UTILITY(U,$J,358.3,26507,1,3,0)
 ;;=3^Psych Test Admin by Computer w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26508,0)
 ;;=96125^^70^1105^29^^^^1
 ;;^UTILITY(U,$J,358.3,26508,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26508,1,2,0)
 ;;=2^96125
 ;;^UTILITY(U,$J,358.3,26508,1,3,0)
 ;;=3^Standardized Cognitive Performance Tst,per hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26509,0)
 ;;=Q3014^^70^1105^31^^^^1
 ;;^UTILITY(U,$J,358.3,26509,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26509,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,26509,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,26510,0)
 ;;=90887^^70^1105^6^^^^1
 ;;^UTILITY(U,$J,358.3,26510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26510,1,2,0)
 ;;=2^90887
 ;;^UTILITY(U,$J,358.3,26510,1,3,0)
 ;;=3^Consultation w/ Family for Interp/Explain Exam/Tst Results
 ;;^UTILITY(U,$J,358.3,26511,0)
 ;;=90889^^70^1105^25^^^^1
 ;;^UTILITY(U,$J,358.3,26511,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26511,1,2,0)
 ;;=2^90889
 ;;^UTILITY(U,$J,358.3,26511,1,3,0)
 ;;=3^Report Preparation for Ind/Agency/Insurance
 ;;^UTILITY(U,$J,358.3,26512,0)
 ;;=G0177^^70^1105^32^^^^1
 ;;^UTILITY(U,$J,358.3,26512,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26512,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,26512,1,3,0)
 ;;=3^Train & Ed for Disabiling MH Problem 45+ min
 ;;^UTILITY(U,$J,358.3,26513,0)
 ;;=96116^^70^1105^14^^^^1
 ;;^UTILITY(U,$J,358.3,26513,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26513,1,2,0)
 ;;=2^96116
 ;;^UTILITY(U,$J,358.3,26513,1,3,0)
 ;;=3^Neurobehavioral Status Exam by Psych,per hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26514,0)
 ;;=98961^^70^1105^26^^^^1
 ;;^UTILITY(U,$J,358.3,26514,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26514,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,26514,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,2-4 Pts,ea 30 min
 ;;^UTILITY(U,$J,358.3,26515,0)
 ;;=98962^^70^1105^27^^^^1
 ;;^UTILITY(U,$J,358.3,26515,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26515,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,26515,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,5-8 Pts,ea 30 min
 ;;^UTILITY(U,$J,358.3,26516,0)
 ;;=99078^^70^1105^13^^^^1
 ;;^UTILITY(U,$J,358.3,26516,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26516,1,2,0)
 ;;=2^99078
 ;;^UTILITY(U,$J,358.3,26516,1,3,0)
 ;;=3^Group Health Education/Counseling Svc
 ;;^UTILITY(U,$J,358.3,26517,0)
 ;;=96127^^70^1105^2^^^^1
 ;;^UTILITY(U,$J,358.3,26517,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26517,1,2,0)
 ;;=2^96127
 ;;^UTILITY(U,$J,358.3,26517,1,3,0)
 ;;=3^Brief Emot/Behav Assmt w/ Score & Docum
 ;;^UTILITY(U,$J,358.3,26518,0)
 ;;=96101^^70^1105^21^^^^1
 ;;^UTILITY(U,$J,358.3,26518,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26518,1,2,0)
 ;;=2^96101
 ;;^UTILITY(U,$J,358.3,26518,1,3,0)
 ;;=3^Psych Test Admin by Psych,per hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26519,0)
 ;;=90899^^70^1105^33^^^^1
 ;;^UTILITY(U,$J,358.3,26519,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26519,1,2,0)
 ;;=2^90899
 ;;^UTILITY(U,$J,358.3,26519,1,3,0)
 ;;=3^Unlisted Psychiatric Service
 ;;^UTILITY(U,$J,358.3,26520,0)
 ;;=96105^^70^1105^1^^^^1
 ;;^UTILITY(U,$J,358.3,26520,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26520,1,2,0)
 ;;=2^96105
 ;;^UTILITY(U,$J,358.3,26520,1,3,0)
 ;;=3^Aphasia Assessment,per hr
 ;;^UTILITY(U,$J,358.3,26521,0)
 ;;=S9484^^70^1105^7^^^^1
 ;;^UTILITY(U,$J,358.3,26521,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26521,1,2,0)
 ;;=2^S9484
 ;;^UTILITY(U,$J,358.3,26521,1,3,0)
 ;;=3^Crisis Intervention MH Svcs,per hr
 ;;^UTILITY(U,$J,358.3,26522,0)
 ;;=H2011^^70^1105^8^^^^1
 ;;^UTILITY(U,$J,358.3,26522,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26522,1,2,0)
 ;;=2^H2011
 ;;^UTILITY(U,$J,358.3,26522,1,3,0)
 ;;=3^Crisis Intervention Svc,per 15 min
 ;;^UTILITY(U,$J,358.3,26523,0)
 ;;=96110^^70^1105^9^^^^1
 ;;^UTILITY(U,$J,358.3,26523,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26523,1,2,0)
 ;;=2^96110
 ;;^UTILITY(U,$J,358.3,26523,1,3,0)
 ;;=3^Developmental Screening by Psych w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26524,0)
 ;;=96111^^70^1105^10^^^^1
 ;;^UTILITY(U,$J,358.3,26524,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26524,1,2,0)
 ;;=2^96111
 ;;^UTILITY(U,$J,358.3,26524,1,3,0)
 ;;=3^Developmental Testing by Psych w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26525,0)
 ;;=96020^^70^1105^11^^^^1
 ;;^UTILITY(U,$J,358.3,26525,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26525,1,2,0)
 ;;=2^96020
 ;;^UTILITY(U,$J,358.3,26525,1,3,0)
 ;;=3^Functional Brain Mapping w/ Test Administration
 ;;^UTILITY(U,$J,358.3,26526,0)
 ;;=S9446^^70^1105^12^^^^1
 ;;^UTILITY(U,$J,358.3,26526,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26526,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,26526,1,3,0)
 ;;=3^Group Educational Svc,NOS
 ;;^UTILITY(U,$J,358.3,26527,0)
 ;;=96120^^70^1105^15^^^^1
 ;;^UTILITY(U,$J,358.3,26527,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26527,1,2,0)
 ;;=2^96120
 ;;^UTILITY(U,$J,358.3,26527,1,3,0)
 ;;=3^Neuropsych Test Admin by Computer w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26528,0)
 ;;=96119^^70^1105^17^^^^1
 ;;^UTILITY(U,$J,358.3,26528,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26528,1,2,0)
 ;;=2^96119
 ;;^UTILITY(U,$J,358.3,26528,1,3,0)
 ;;=3^Neuropsych Test Admin by Tech,per hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26529,0)
 ;;=96118^^70^1105^16^^^^1
 ;;^UTILITY(U,$J,358.3,26529,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26529,1,2,0)
 ;;=2^96118
 ;;^UTILITY(U,$J,358.3,26529,1,3,0)
 ;;=3^Neuropsych Test Admin by Psych,per hr w/ Interp & Rpt
 ;;^UTILITY(U,$J,358.3,26530,0)
 ;;=S9452^^70^1105^18^^^^1
 ;;^UTILITY(U,$J,358.3,26530,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26530,1,2,0)
 ;;=2^S9452
 ;;^UTILITY(U,$J,358.3,26530,1,3,0)
 ;;=3^Nutrition Class,Non-MD,per session
 ;;^UTILITY(U,$J,358.3,26531,0)
 ;;=90885^^70^1105^23^^^^1
 ;;^UTILITY(U,$J,358.3,26531,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26531,1,2,0)
 ;;=2^90885
 ;;^UTILITY(U,$J,358.3,26531,1,3,0)
 ;;=3^Psychiatric Evaluation of Records for Med Dx
 ;;^UTILITY(U,$J,358.3,26532,0)
 ;;=H2027^^70^1105^24^^^^1
 ;;^UTILITY(U,$J,358.3,26532,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26532,1,2,0)
 ;;=2^H2027
 ;;^UTILITY(U,$J,358.3,26532,1,3,0)
 ;;=3^Psychoeducational Svc,Pt & Family,ea 15 min
 ;;^UTILITY(U,$J,358.3,26533,0)
 ;;=S9454^^70^1105^30^^^^1
 ;;^UTILITY(U,$J,358.3,26533,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26533,1,2,0)
 ;;=2^S9454
 ;;^UTILITY(U,$J,358.3,26533,1,3,0)
 ;;=3^Stress Mgmt Class,Non-MD,per session
 ;;^UTILITY(U,$J,358.3,26534,0)
 ;;=S9449^^70^1105^34^^^^1
 ;;^UTILITY(U,$J,358.3,26534,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26534,1,2,0)
 ;;=2^S9449
 ;;^UTILITY(U,$J,358.3,26534,1,3,0)
 ;;=3^Weight Mgmt Class,Non-MD,per session
 ;;^UTILITY(U,$J,358.3,26535,0)
 ;;=T1016^^70^1105^3^^^^1
 ;;^UTILITY(U,$J,358.3,26535,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26535,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,26535,1,3,0)
 ;;=3^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,26536,0)
 ;;=96150^^70^1106^1^^^^1
 ;;^UTILITY(U,$J,358.3,26536,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26536,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,26536,1,3,0)
 ;;=3^Hlth/Behavior Assessm,Initial,ea 15min
 ;;^UTILITY(U,$J,358.3,26537,0)
 ;;=96151^^70^1106^2^^^^1
 ;;^UTILITY(U,$J,358.3,26537,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26537,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,26537,1,3,0)
 ;;=3^Hlth/Behavior Reassessm,ea 15min
 ;;^UTILITY(U,$J,358.3,26538,0)
 ;;=96152^^70^1106^3^^^^1
 ;;^UTILITY(U,$J,358.3,26538,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26538,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,26538,1,3,0)
 ;;=3^Hlth/Behavior Intervent,Ind,ea 15min
 ;;^UTILITY(U,$J,358.3,26539,0)
 ;;=96153^^70^1106^4^^^^1
 ;;^UTILITY(U,$J,358.3,26539,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26539,1,2,0)
 ;;=2^96153
 ;;^UTILITY(U,$J,358.3,26539,1,3,0)
 ;;=3^Hlth/Behavior Intervent,Grp,ea 15min
 ;;^UTILITY(U,$J,358.3,26540,0)
 ;;=96154^^70^1106^5^^^^1
 ;;^UTILITY(U,$J,358.3,26540,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26540,1,2,0)
 ;;=2^96154
 ;;^UTILITY(U,$J,358.3,26540,1,3,0)
 ;;=3^Hlth/Behavior Intervent,Fam w/Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,26541,0)
 ;;=96155^^70^1106^6^^^^1
 ;;^UTILITY(U,$J,358.3,26541,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26541,1,2,0)
 ;;=2^96155
 ;;^UTILITY(U,$J,358.3,26541,1,3,0)
 ;;=3^Hlth/Behavior Intervent,Fam w/o Pt,ea 15min
 ;;^UTILITY(U,$J,358.3,26542,0)
 ;;=99368^^70^1107^2^^^^1
 ;;^UTILITY(U,$J,358.3,26542,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,26542,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,26542,1,3,0)
 ;;=3^Non-phys Team Conf w/o Pt &/or Family,30+ min
