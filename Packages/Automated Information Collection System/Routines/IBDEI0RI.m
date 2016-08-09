IBDEI0RI ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27621,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27621,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,27621,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,27622,0)
 ;;=F18.229^^102^1345^20
 ;;^UTILITY(U,$J,358.3,27622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27622,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27622,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,27622,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,27623,0)
 ;;=F18.929^^102^1345^21
 ;;^UTILITY(U,$J,358.3,27623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27623,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27623,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,27623,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,27624,0)
 ;;=F18.180^^102^1345^1
 ;;^UTILITY(U,$J,358.3,27624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27624,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27624,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,27624,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,27625,0)
 ;;=F18.280^^102^1345^2
 ;;^UTILITY(U,$J,358.3,27625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27625,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27625,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,27625,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,27626,0)
 ;;=F18.980^^102^1345^3
 ;;^UTILITY(U,$J,358.3,27626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27626,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27626,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,27626,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,27627,0)
 ;;=F18.94^^102^1345^6
 ;;^UTILITY(U,$J,358.3,27627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27627,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27627,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,27627,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,27628,0)
 ;;=F18.17^^102^1345^7
 ;;^UTILITY(U,$J,358.3,27628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27628,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27628,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,27628,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,27629,0)
 ;;=F18.27^^102^1345^8
 ;;^UTILITY(U,$J,358.3,27629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27629,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27629,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,27629,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,27630,0)
 ;;=F18.97^^102^1345^9
 ;;^UTILITY(U,$J,358.3,27630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27630,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27630,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,27630,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,27631,0)
 ;;=F18.188^^102^1345^10
 ;;^UTILITY(U,$J,358.3,27631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27631,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27631,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,27631,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,27632,0)
 ;;=F18.288^^102^1345^11
 ;;^UTILITY(U,$J,358.3,27632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27632,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27632,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,27632,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,27633,0)
 ;;=F18.988^^102^1345^12
 ;;^UTILITY(U,$J,358.3,27633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27633,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27633,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,27633,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,27634,0)
 ;;=F18.159^^102^1345^13
 ;;^UTILITY(U,$J,358.3,27634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27634,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27634,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,27634,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,27635,0)
 ;;=F18.259^^102^1345^14
 ;;^UTILITY(U,$J,358.3,27635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27635,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27635,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,27635,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,27636,0)
 ;;=F18.959^^102^1345^15
 ;;^UTILITY(U,$J,358.3,27636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27636,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27636,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,27636,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,27637,0)
 ;;=F18.99^^102^1345^22
 ;;^UTILITY(U,$J,358.3,27637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27637,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27637,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,27637,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,27638,0)
 ;;=F18.20^^102^1345^25
 ;;^UTILITY(U,$J,358.3,27638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27638,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,27638,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,27638,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,27639,0)
 ;;=Z00.6^^102^1346^1
 ;;^UTILITY(U,$J,358.3,27639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27639,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,27639,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,27639,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,27640,0)
 ;;=F45.22^^102^1347^1
 ;;^UTILITY(U,$J,358.3,27640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27640,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,27640,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,27640,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,27641,0)
 ;;=F45.8^^102^1347^16
 ;;^UTILITY(U,$J,358.3,27641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27641,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,27641,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,27641,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,27642,0)
 ;;=F45.0^^102^1347^14
 ;;^UTILITY(U,$J,358.3,27642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27642,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,27642,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,27642,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,27643,0)
 ;;=F45.9^^102^1347^15
 ;;^UTILITY(U,$J,358.3,27643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27643,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27643,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,27643,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,27644,0)
 ;;=F45.1^^102^1347^13
 ;;^UTILITY(U,$J,358.3,27644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27644,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,27644,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,27644,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,27645,0)
 ;;=F44.4^^102^1347^2
 ;;^UTILITY(U,$J,358.3,27645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27645,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,27645,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,27645,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,27646,0)
 ;;=F44.6^^102^1347^3
 ;;^UTILITY(U,$J,358.3,27646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27646,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,27646,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,27646,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,27647,0)
 ;;=F44.5^^102^1347^4
 ;;^UTILITY(U,$J,358.3,27647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27647,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
