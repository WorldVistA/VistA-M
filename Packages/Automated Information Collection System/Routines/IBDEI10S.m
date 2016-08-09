IBDEI10S ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36998,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,36998,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,36998,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,36999,0)
 ;;=F18.229^^135^1827^20
 ;;^UTILITY(U,$J,358.3,36999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36999,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,36999,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,36999,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,37000,0)
 ;;=F18.929^^135^1827^21
 ;;^UTILITY(U,$J,358.3,37000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37000,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,37000,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,37000,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,37001,0)
 ;;=F18.180^^135^1827^1
 ;;^UTILITY(U,$J,358.3,37001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37001,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,37001,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,37001,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,37002,0)
 ;;=F18.280^^135^1827^2
 ;;^UTILITY(U,$J,358.3,37002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37002,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,37002,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,37002,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,37003,0)
 ;;=F18.980^^135^1827^3
 ;;^UTILITY(U,$J,358.3,37003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37003,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,37003,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,37003,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,37004,0)
 ;;=F18.94^^135^1827^6
 ;;^UTILITY(U,$J,358.3,37004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37004,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,37004,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,37004,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,37005,0)
 ;;=F18.17^^135^1827^7
 ;;^UTILITY(U,$J,358.3,37005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37005,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,37005,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,37005,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,37006,0)
 ;;=F18.27^^135^1827^8
 ;;^UTILITY(U,$J,358.3,37006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37006,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,37006,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,37006,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,37007,0)
 ;;=F18.97^^135^1827^9
 ;;^UTILITY(U,$J,358.3,37007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37007,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,37007,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,37007,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,37008,0)
 ;;=F18.188^^135^1827^10
 ;;^UTILITY(U,$J,358.3,37008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37008,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,37008,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,37008,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,37009,0)
 ;;=F18.288^^135^1827^11
 ;;^UTILITY(U,$J,358.3,37009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37009,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,37009,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,37009,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,37010,0)
 ;;=F18.988^^135^1827^12
 ;;^UTILITY(U,$J,358.3,37010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37010,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,37010,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,37010,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,37011,0)
 ;;=F18.159^^135^1827^13
 ;;^UTILITY(U,$J,358.3,37011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37011,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,37011,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,37011,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,37012,0)
 ;;=F18.259^^135^1827^14
 ;;^UTILITY(U,$J,358.3,37012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37012,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,37012,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,37012,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,37013,0)
 ;;=F18.959^^135^1827^15
 ;;^UTILITY(U,$J,358.3,37013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37013,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,37013,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,37013,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,37014,0)
 ;;=F18.99^^135^1827^22
 ;;^UTILITY(U,$J,358.3,37014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37014,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,37014,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,37014,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,37015,0)
 ;;=F18.20^^135^1827^25
 ;;^UTILITY(U,$J,358.3,37015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37015,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,37015,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,37015,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,37016,0)
 ;;=Z00.6^^135^1828^1
 ;;^UTILITY(U,$J,358.3,37016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37016,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,37016,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,37016,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,37017,0)
 ;;=F45.22^^135^1829^1
 ;;^UTILITY(U,$J,358.3,37017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37017,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,37017,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,37017,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,37018,0)
 ;;=F45.8^^135^1829^16
 ;;^UTILITY(U,$J,358.3,37018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37018,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,37018,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,37018,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,37019,0)
 ;;=F45.0^^135^1829^14
 ;;^UTILITY(U,$J,358.3,37019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37019,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,37019,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,37019,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,37020,0)
 ;;=F45.9^^135^1829^15
 ;;^UTILITY(U,$J,358.3,37020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37020,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,37020,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,37020,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,37021,0)
 ;;=F45.1^^135^1829^13
 ;;^UTILITY(U,$J,358.3,37021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37021,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,37021,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,37021,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,37022,0)
 ;;=F44.4^^135^1829^2
 ;;^UTILITY(U,$J,358.3,37022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37022,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,37022,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,37022,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,37023,0)
 ;;=F44.6^^135^1829^3
 ;;^UTILITY(U,$J,358.3,37023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37023,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,37023,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,37023,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,37024,0)
 ;;=F44.5^^135^1829^4
 ;;^UTILITY(U,$J,358.3,37024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37024,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
