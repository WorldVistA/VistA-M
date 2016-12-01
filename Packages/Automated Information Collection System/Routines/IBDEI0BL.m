IBDEI0BL ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14700,1,3,0)
 ;;=3^Antibiotics
 ;;^UTILITY(U,$J,358.3,14700,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,14700,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,14701,0)
 ;;=Z79.01^^43^645^2
 ;;^UTILITY(U,$J,358.3,14701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14701,1,3,0)
 ;;=3^Anticoagulants
 ;;^UTILITY(U,$J,358.3,14701,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,14701,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,14702,0)
 ;;=Z79.02^^43^645^3
 ;;^UTILITY(U,$J,358.3,14702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14702,1,3,0)
 ;;=3^Antiplatelets/Antithrombotics
 ;;^UTILITY(U,$J,358.3,14702,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,14702,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,14703,0)
 ;;=Z79.82^^43^645^4
 ;;^UTILITY(U,$J,358.3,14703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14703,1,3,0)
 ;;=3^Aspirin
 ;;^UTILITY(U,$J,358.3,14703,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,14703,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,14704,0)
 ;;=Z79.4^^43^645^5
 ;;^UTILITY(U,$J,358.3,14704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14704,1,3,0)
 ;;=3^Insulin
 ;;^UTILITY(U,$J,358.3,14704,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,14704,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,14705,0)
 ;;=Z79.1^^43^645^7
 ;;^UTILITY(U,$J,358.3,14705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14705,1,3,0)
 ;;=3^NSAID
 ;;^UTILITY(U,$J,358.3,14705,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,14705,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,14706,0)
 ;;=Z79.891^^43^645^8
 ;;^UTILITY(U,$J,358.3,14706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14706,1,3,0)
 ;;=3^Opiate Analgesic
 ;;^UTILITY(U,$J,358.3,14706,1,4,0)
 ;;=4^Z79.891
 ;;^UTILITY(U,$J,358.3,14706,2)
 ;;=^5063342
 ;;^UTILITY(U,$J,358.3,14707,0)
 ;;=Z79.51^^43^645^9
 ;;^UTILITY(U,$J,358.3,14707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14707,1,3,0)
 ;;=3^Steroids-Inhaled
 ;;^UTILITY(U,$J,358.3,14707,1,4,0)
 ;;=4^Z79.51
 ;;^UTILITY(U,$J,358.3,14707,2)
 ;;=^5063335
 ;;^UTILITY(U,$J,358.3,14708,0)
 ;;=Z79.52^^43^645^10
 ;;^UTILITY(U,$J,358.3,14708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14708,1,3,0)
 ;;=3^Steroids-Systemic
 ;;^UTILITY(U,$J,358.3,14708,1,4,0)
 ;;=4^Z79.52
 ;;^UTILITY(U,$J,358.3,14708,2)
 ;;=^5063336
 ;;^UTILITY(U,$J,358.3,14709,0)
 ;;=Z79.899^^43^645^6
 ;;^UTILITY(U,$J,358.3,14709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14709,1,3,0)
 ;;=3^Long Term Current Drug Therapy NEC
 ;;^UTILITY(U,$J,358.3,14709,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,14709,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,14710,0)
 ;;=90832^^44^646^9^^^^1
 ;;^UTILITY(U,$J,358.3,14710,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14710,1,2,0)
 ;;=2^90832
 ;;^UTILITY(U,$J,358.3,14710,1,3,0)
 ;;=3^Psychotherapy 16-37 min
 ;;^UTILITY(U,$J,358.3,14711,0)
 ;;=90834^^44^646^10^^^^1
 ;;^UTILITY(U,$J,358.3,14711,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14711,1,2,0)
 ;;=2^90834
 ;;^UTILITY(U,$J,358.3,14711,1,3,0)
 ;;=3^Psychotherapy 38-52 min
 ;;^UTILITY(U,$J,358.3,14712,0)
 ;;=90837^^44^646^11^^^^1
 ;;^UTILITY(U,$J,358.3,14712,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14712,1,2,0)
 ;;=2^90837
 ;;^UTILITY(U,$J,358.3,14712,1,3,0)
 ;;=3^Psychotherapy 53-89 min
 ;;^UTILITY(U,$J,358.3,14713,0)
 ;;=90846^^44^646^2^^^^1
 ;;^UTILITY(U,$J,358.3,14713,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14713,1,2,0)
 ;;=2^90846
 ;;^UTILITY(U,$J,358.3,14713,1,3,0)
 ;;=3^Family Psychotherapy w/o Pt
 ;;^UTILITY(U,$J,358.3,14714,0)
 ;;=90847^^44^646^1^^^^1
 ;;^UTILITY(U,$J,358.3,14714,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14714,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,14714,1,3,0)
 ;;=3^Family Psychotherapy w/ Pt
 ;;^UTILITY(U,$J,358.3,14715,0)
 ;;=90875^^44^646^3^^^^1
 ;;^UTILITY(U,$J,358.3,14715,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14715,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,14715,1,3,0)
 ;;=3^Ind Psychophysiological Tx w/ Biofeed,30min
 ;;^UTILITY(U,$J,358.3,14716,0)
 ;;=90876^^44^646^4^^^^1
 ;;^UTILITY(U,$J,358.3,14716,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14716,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,14716,1,3,0)
 ;;=3^Ind Psychophysiological Tx w/ Biofeed,45min
 ;;^UTILITY(U,$J,358.3,14717,0)
 ;;=99354^^44^646^7^^^^1
 ;;^UTILITY(U,$J,358.3,14717,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14717,1,2,0)
 ;;=2^99354
 ;;^UTILITY(U,$J,358.3,14717,1,3,0)
 ;;=3^Prolonged Svcs,OPT,1st hr,add-on
 ;;^UTILITY(U,$J,358.3,14718,0)
 ;;=99355^^44^646^8^^^^1
 ;;^UTILITY(U,$J,358.3,14718,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14718,1,2,0)
 ;;=2^99355
 ;;^UTILITY(U,$J,358.3,14718,1,3,0)
 ;;=3^Prolonged Svcs,OPT,ea addl 30min
 ;;^UTILITY(U,$J,358.3,14719,0)
 ;;=99356^^44^646^5^^^^1
 ;;^UTILITY(U,$J,358.3,14719,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14719,1,2,0)
 ;;=2^99356
 ;;^UTILITY(U,$J,358.3,14719,1,3,0)
 ;;=3^Prolonged Svc,INPT/OBS,1st hr
 ;;^UTILITY(U,$J,358.3,14720,0)
 ;;=99357^^44^646^6^^^^1
 ;;^UTILITY(U,$J,358.3,14720,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14720,1,2,0)
 ;;=2^99357
 ;;^UTILITY(U,$J,358.3,14720,1,3,0)
 ;;=3^Prolonged Svc,INPT/OBS,Ea Add 30min
 ;;^UTILITY(U,$J,358.3,14721,0)
 ;;=90839^^44^647^1^^^^1
 ;;^UTILITY(U,$J,358.3,14721,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14721,1,2,0)
 ;;=2^90839
 ;;^UTILITY(U,$J,358.3,14721,1,3,0)
 ;;=3^PsyTx Crisis;Init 30-74 Min
 ;;^UTILITY(U,$J,358.3,14722,0)
 ;;=90840^^44^647^2^^^^1
 ;;^UTILITY(U,$J,358.3,14722,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14722,1,2,0)
 ;;=2^90840
 ;;^UTILITY(U,$J,358.3,14722,1,3,0)
 ;;=3^PsyTx Crisis;Ea Addl 30 Min
 ;;^UTILITY(U,$J,358.3,14723,0)
 ;;=97545^^44^648^30^^^^1
 ;;^UTILITY(U,$J,358.3,14723,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14723,1,2,0)
 ;;=2^97545
 ;;^UTILITY(U,$J,358.3,14723,1,3,0)
 ;;=3^Work Therapy,1st 2 hrs
 ;;^UTILITY(U,$J,358.3,14724,0)
 ;;=97546^^44^648^31^^^^1
 ;;^UTILITY(U,$J,358.3,14724,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14724,1,2,0)
 ;;=2^97546
 ;;^UTILITY(U,$J,358.3,14724,1,3,0)
 ;;=3^Work Therapy,ea addl hr
 ;;^UTILITY(U,$J,358.3,14725,0)
 ;;=97537^^44^648^6^^^^1
 ;;^UTILITY(U,$J,358.3,14725,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14725,1,2,0)
 ;;=2^97537
 ;;^UTILITY(U,$J,358.3,14725,1,3,0)
 ;;=3^Community/Work Reintegration ea 15 min
 ;;^UTILITY(U,$J,358.3,14726,0)
 ;;=97532^^44^648^5^^^^1
 ;;^UTILITY(U,$J,358.3,14726,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14726,1,2,0)
 ;;=2^97532
 ;;^UTILITY(U,$J,358.3,14726,1,3,0)
 ;;=3^Cognitive Skills Development by PhD ea 15min
 ;;^UTILITY(U,$J,358.3,14727,0)
 ;;=97533^^44^648^23^^^^1
 ;;^UTILITY(U,$J,358.3,14727,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14727,1,2,0)
 ;;=2^97533
 ;;^UTILITY(U,$J,358.3,14727,1,3,0)
 ;;=3^Sensory Integrative Techniques,ea 15 min
 ;;^UTILITY(U,$J,358.3,14728,0)
 ;;=96119^^44^648^15^^^^1
 ;;^UTILITY(U,$J,358.3,14728,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14728,1,2,0)
 ;;=2^96119
 ;;^UTILITY(U,$J,358.3,14728,1,3,0)
 ;;=3^Neuropsych Tst admin by tech,per hr w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14729,0)
 ;;=96102^^44^648^21^^^^1
 ;;^UTILITY(U,$J,358.3,14729,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14729,1,2,0)
 ;;=2^96102
 ;;^UTILITY(U,$J,358.3,14729,1,3,0)
 ;;=3^Psych Test by Tech,per hr w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14730,0)
 ;;=96103^^44^648^19^^^^1
 ;;^UTILITY(U,$J,358.3,14730,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14730,1,2,0)
 ;;=2^96103
 ;;^UTILITY(U,$J,358.3,14730,1,3,0)
 ;;=3^Psych Test by Computer w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14731,0)
 ;;=96120^^44^648^13^^^^1
 ;;^UTILITY(U,$J,358.3,14731,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14731,1,2,0)
 ;;=2^96120
 ;;^UTILITY(U,$J,358.3,14731,1,3,0)
 ;;=3^Neuropsych Tst admin by Computer w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14732,0)
 ;;=96125^^44^648^25^^^^1
 ;;^UTILITY(U,$J,358.3,14732,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14732,1,2,0)
 ;;=2^96125
 ;;^UTILITY(U,$J,358.3,14732,1,3,0)
 ;;=3^Standard Cogn Perf Tst,per hr w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14733,0)
 ;;=Q3014^^44^648^26^^^^1
 ;;^UTILITY(U,$J,358.3,14733,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14733,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,14733,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,14734,0)
 ;;=90887^^44^648^7^^^^1
 ;;^UTILITY(U,$J,358.3,14734,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14734,1,2,0)
 ;;=2^90887
 ;;^UTILITY(U,$J,358.3,14734,1,3,0)
 ;;=3^Consult w/ Family,Interp/Expl Exam/Test Results
 ;;^UTILITY(U,$J,358.3,14735,0)
 ;;=90889^^44^648^16^^^^1
 ;;^UTILITY(U,$J,358.3,14735,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14735,1,2,0)
 ;;=2^90889
 ;;^UTILITY(U,$J,358.3,14735,1,3,0)
 ;;=3^Preparation of Report for Indiv/Agency/Insurance
 ;;^UTILITY(U,$J,358.3,14736,0)
 ;;=96118^^44^648^14^^^^1
 ;;^UTILITY(U,$J,358.3,14736,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14736,1,2,0)
 ;;=2^96118
 ;;^UTILITY(U,$J,358.3,14736,1,3,0)
 ;;=3^Neuropsych Tst admin by PhD,per hr w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14737,0)
 ;;=G0177^^44^648^29^^^^1
 ;;^UTILITY(U,$J,358.3,14737,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14737,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,14737,1,3,0)
 ;;=3^Train & Ed for Disabling MH Problem 45+ min
 ;;^UTILITY(U,$J,358.3,14738,0)
 ;;=96116^^44^648^12^^^^1
 ;;^UTILITY(U,$J,358.3,14738,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14738,1,2,0)
 ;;=2^96116
 ;;^UTILITY(U,$J,358.3,14738,1,3,0)
 ;;=3^Neurobehav Status Exam by PhD,per hr w/ Interpret & Rpt
 ;;^UTILITY(U,$J,358.3,14739,0)
 ;;=G0396^^44^648^1^^^^1
 ;;^UTILITY(U,$J,358.3,14739,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14739,1,2,0)
 ;;=2^G0396
 ;;^UTILITY(U,$J,358.3,14739,1,3,0)
 ;;=3^Alc/Drug Abuse Assm & Brief Intvn 15-30min
 ;;^UTILITY(U,$J,358.3,14740,0)
 ;;=G0397^^44^648^2^^^^1
 ;;^UTILITY(U,$J,358.3,14740,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,14740,1,2,0)
 ;;=2^G0397
