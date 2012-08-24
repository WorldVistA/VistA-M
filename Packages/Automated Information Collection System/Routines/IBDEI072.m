IBDEI072 ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9344,0)
 ;;=98961^^70^555^2^^^^1
 ;;^UTILITY(U,$J,358.3,9344,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9344,1,2,0)
 ;;=2^2-4 PATIENTS, EA 30 MIN
 ;;^UTILITY(U,$J,358.3,9344,1,3,0)
 ;;=3^98961
 ;;^UTILITY(U,$J,358.3,9345,0)
 ;;=98962^^70^555^3^^^^1
 ;;^UTILITY(U,$J,358.3,9345,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9345,1,2,0)
 ;;=2^5-8 PATIENTS, EA 30 MIN
 ;;^UTILITY(U,$J,358.3,9345,1,3,0)
 ;;=3^98962
 ;;^UTILITY(U,$J,358.3,9346,0)
 ;;=99211^^71^556^1
 ;;^UTILITY(U,$J,358.3,9346,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9346,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,9346,1,3,0)
 ;;=3^RN/LPN Visit
 ;;^UTILITY(U,$J,358.3,9347,0)
 ;;=99212^^71^556^2
 ;;^UTILITY(U,$J,358.3,9347,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9347,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,9347,1,3,0)
 ;;=3^Problem Focused
 ;;^UTILITY(U,$J,358.3,9348,0)
 ;;=99213^^71^556^3
 ;;^UTILITY(U,$J,358.3,9348,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9348,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,9348,1,3,0)
 ;;=3^Exp Prob Focused
 ;;^UTILITY(U,$J,358.3,9349,0)
 ;;=99214^^71^556^4
 ;;^UTILITY(U,$J,358.3,9349,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9349,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,9349,1,3,0)
 ;;=3^Detailed
 ;;^UTILITY(U,$J,358.3,9350,0)
 ;;=99215^^71^556^5
 ;;^UTILITY(U,$J,358.3,9350,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9350,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,9350,1,3,0)
 ;;=3^Comprehensive
 ;;^UTILITY(U,$J,358.3,9351,0)
 ;;=99241^^71^557^1
 ;;^UTILITY(U,$J,358.3,9351,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9351,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,9351,1,3,0)
 ;;=3^Prob Focused
 ;;^UTILITY(U,$J,358.3,9352,0)
 ;;=99242^^71^557^2
 ;;^UTILITY(U,$J,358.3,9352,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9352,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,9352,1,3,0)
 ;;=3^Exp Problem Focused
 ;;^UTILITY(U,$J,358.3,9353,0)
 ;;=99243^^71^557^3
 ;;^UTILITY(U,$J,358.3,9353,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9353,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,9353,1,3,0)
 ;;=3^Detailed
 ;;^UTILITY(U,$J,358.3,9354,0)
 ;;=99244^^71^557^4
 ;;^UTILITY(U,$J,358.3,9354,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9354,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,9354,1,3,0)
 ;;=3^Comprehensive, Mod Cmplx
 ;;^UTILITY(U,$J,358.3,9355,0)
 ;;=99245^^71^557^5
 ;;^UTILITY(U,$J,358.3,9355,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9355,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,9355,1,3,0)
 ;;=3^Comprehensive, High Cmplx
 ;;^UTILITY(U,$J,358.3,9356,0)
 ;;=99201^^71^558^1
 ;;^UTILITY(U,$J,358.3,9356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9356,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,9356,1,3,0)
 ;;=3^Prob Focused
 ;;^UTILITY(U,$J,358.3,9357,0)
 ;;=99202^^71^558^2
 ;;^UTILITY(U,$J,358.3,9357,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9357,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,9357,1,3,0)
 ;;=3^Expanded Prob Focus
 ;;^UTILITY(U,$J,358.3,9358,0)
 ;;=99203^^71^558^3
 ;;^UTILITY(U,$J,358.3,9358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9358,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,9358,1,3,0)
 ;;=3^Detailed
 ;;^UTILITY(U,$J,358.3,9359,0)
 ;;=99204^^71^558^4
 ;;^UTILITY(U,$J,358.3,9359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9359,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,9359,1,3,0)
 ;;=3^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,9360,0)
 ;;=99205^^71^558^5
 ;;^UTILITY(U,$J,358.3,9360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9360,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,9360,1,3,0)
 ;;=3^Comprehensive, High Complx
 ;;^UTILITY(U,$J,358.3,9361,0)
 ;;=433.10^^72^559^1
 ;;^UTILITY(U,$J,358.3,9361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9361,1,2,0)
 ;;=2^433.10
 ;;^UTILITY(U,$J,358.3,9361,1,3,0)
 ;;=3^Carotid Artery Sten
 ;;^UTILITY(U,$J,358.3,9361,2)
 ;;=Carotid Artery Stenosis^295801
 ;;^UTILITY(U,$J,358.3,9362,0)
 ;;=437.0^^72^559^2
 ;;^UTILITY(U,$J,358.3,9362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9362,1,2,0)
 ;;=2^437.0
 ;;^UTILITY(U,$J,358.3,9362,1,3,0)
 ;;=3^Intracran Arter Sten
 ;;^UTILITY(U,$J,358.3,9362,2)
 ;;=Intercranial Arterial Stenosis^21571
 ;;^UTILITY(U,$J,358.3,9363,0)
 ;;=435.2^^72^559^6
 ;;^UTILITY(U,$J,358.3,9363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9363,1,2,0)
 ;;=2^435.2
 ;;^UTILITY(U,$J,358.3,9363,1,3,0)
 ;;=3^Subclavian Stenosis
 ;;^UTILITY(U,$J,358.3,9363,2)
 ;;=Subclavian Stenosis^115012
 ;;^UTILITY(U,$J,358.3,9364,0)
 ;;=435.9^^72^559^7
 ;;^UTILITY(U,$J,358.3,9364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9364,1,2,0)
 ;;=2^435.9
 ;;^UTILITY(U,$J,358.3,9364,1,3,0)
 ;;=3^Trans Ischemic Attack
 ;;^UTILITY(U,$J,358.3,9364,2)
 ;;=Trans Ischemic Attack^21635
 ;;^UTILITY(U,$J,358.3,9365,0)
 ;;=435.3^^72^559^8
 ;;^UTILITY(U,$J,358.3,9365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9365,1,2,0)
 ;;=2^435.3
 ;;^UTILITY(U,$J,358.3,9365,1,3,0)
 ;;=3^Vertebral Basilar Insuff
 ;;^UTILITY(U,$J,358.3,9365,2)
 ;;=Vertebral Basilar Insuffiency^260000
 ;;^UTILITY(U,$J,358.3,9366,0)
 ;;=438.20^^72^559^4
 ;;^UTILITY(U,$J,358.3,9366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9366,1,2,0)
 ;;=2^438.20
 ;;^UTILITY(U,$J,358.3,9366,1,3,0)
 ;;=3^Stroke w/Hemiplegia
 ;;^UTILITY(U,$J,358.3,9366,2)
 ;;=Stroke w/Hemiplegia^317910
 ;;^UTILITY(U,$J,358.3,9367,0)
 ;;=438.11^^72^559^3
 ;;^UTILITY(U,$J,358.3,9367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9367,1,2,0)
 ;;=2^438.11
 ;;^UTILITY(U,$J,358.3,9367,1,3,0)
 ;;=3^Stroke w/Aphasia
 ;;^UTILITY(U,$J,358.3,9367,2)
 ;;=Stroke w/Aphasia^317907
 ;;^UTILITY(U,$J,358.3,9368,0)
 ;;=438.6^^72^559^5.1
 ;;^UTILITY(U,$J,358.3,9368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9368,1,2,0)
 ;;=2^438.6
 ;;^UTILITY(U,$J,358.3,9368,1,3,0)
 ;;=3^Stroke w/Sensory Loss
 ;;^UTILITY(U,$J,358.3,9368,2)
 ;;=Stroke w/Sensory Loss^328503
 ;;^UTILITY(U,$J,358.3,9369,0)
 ;;=438.7^^72^559^5.2
 ;;^UTILITY(U,$J,358.3,9369,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9369,1,2,0)
 ;;=2^438.7
 ;;^UTILITY(U,$J,358.3,9369,1,3,0)
 ;;=3^Stroke w/Vision Loss
 ;;^UTILITY(U,$J,358.3,9369,2)
 ;;=Stroke w/Vision Loss^328504
 ;;^UTILITY(U,$J,358.3,9370,0)
 ;;=438.85^^72^559^5.3
 ;;^UTILITY(U,$J,358.3,9370,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9370,1,2,0)
 ;;=2^438.85
 ;;^UTILITY(U,$J,358.3,9370,1,3,0)
 ;;=3^Stroke w/Vertigo
 ;;^UTILITY(U,$J,358.3,9370,2)
 ;;=^328508
 ;;^UTILITY(U,$J,358.3,9371,0)
 ;;=438.82^^72^559^5.5
 ;;^UTILITY(U,$J,358.3,9371,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9371,1,2,0)
 ;;=2^438.82
 ;;^UTILITY(U,$J,358.3,9371,1,3,0)
 ;;=3^Stroke w/dysphagia
 ;;^UTILITY(U,$J,358.3,9371,2)
 ;;=Stroke w/dysphagia^317923
 ;;^UTILITY(U,$J,358.3,9372,0)
 ;;=438.89^^72^559^5
 ;;^UTILITY(U,$J,358.3,9372,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9372,1,2,0)
 ;;=2^438.89
 ;;^UTILITY(U,$J,358.3,9372,1,3,0)
 ;;=3^Stroke with Other Deficits
 ;;^UTILITY(U,$J,358.3,9372,2)
 ;;=^317924
 ;;^UTILITY(U,$J,358.3,9373,0)
 ;;=V12.54^^72^559^9
 ;;^UTILITY(U,$J,358.3,9373,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9373,1,2,0)
 ;;=2^V12.54
 ;;^UTILITY(U,$J,358.3,9373,1,3,0)
 ;;=3^Stroke F/U, No Residuals
 ;;^UTILITY(U,$J,358.3,9373,2)
 ;;=^335309
 ;;^UTILITY(U,$J,358.3,9374,0)
 ;;=345.10^^72^560^3
 ;;^UTILITY(U,$J,358.3,9374,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9374,1,2,0)
 ;;=2^345.10
 ;;^UTILITY(U,$J,358.3,9374,1,3,0)
 ;;=3^Myoclonic Seizures
 ;;^UTILITY(U,$J,358.3,9374,2)
 ;;=Myoclonic Epilepsy^268463
 ;;^UTILITY(U,$J,358.3,9375,0)
 ;;=345.11^^72^560^4
 ;;^UTILITY(U,$J,358.3,9375,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9375,1,2,0)
 ;;=2^345.11
 ;;^UTILITY(U,$J,358.3,9375,1,3,0)
 ;;=3^Myoclonic Seizures, Intractible
 ;;^UTILITY(U,$J,358.3,9375,2)
 ;;=Myoclonic, Intractable Epilepsy^268464
 ;;^UTILITY(U,$J,358.3,9376,0)
 ;;=345.50^^72^560^7
 ;;^UTILITY(U,$J,358.3,9376,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9376,1,2,0)
 ;;=2^345.50
 ;;^UTILITY(U,$J,358.3,9376,1,3,0)
 ;;=3^Simple Partial Seizures
 ;;^UTILITY(U,$J,358.3,9376,2)
 ;;=Simple Partial Epilepsy^268470
 ;;^UTILITY(U,$J,358.3,9377,0)
 ;;=345.51^^72^560^8
 ;;^UTILITY(U,$J,358.3,9377,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9377,1,2,0)
 ;;=2^345.51
 ;;^UTILITY(U,$J,358.3,9377,1,3,0)
 ;;=3^Simple Partial Seizures, Intract
 ;;^UTILITY(U,$J,358.3,9377,2)
 ;;=Simple Epilepsy Partial, Intract^268467
 ;;^UTILITY(U,$J,358.3,9378,0)
 ;;=345.40^^72^560^1
 ;;^UTILITY(U,$J,358.3,9378,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9378,1,2,0)
 ;;=2^345.40
 ;;^UTILITY(U,$J,358.3,9378,1,3,0)
 ;;=3^Complex Partial Seizures
 ;;^UTILITY(U,$J,358.3,9378,2)
 ;;=Cmplx Partial Epilepsy^268467
 ;;^UTILITY(U,$J,358.3,9379,0)
 ;;=345.41^^72^560^2
 ;;^UTILITY(U,$J,358.3,9379,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9379,1,2,0)
 ;;=2^345.41
 ;;^UTILITY(U,$J,358.3,9379,1,3,0)
 ;;=3^Complex Partial Seizures, Intractible
 ;;^UTILITY(U,$J,358.3,9379,2)
 ;;=Complex Partial Seizures, Intractible^268469
 ;;^UTILITY(U,$J,358.3,9380,0)
 ;;=345.90^^72^560^11
 ;;^UTILITY(U,$J,358.3,9380,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9380,1,2,0)
 ;;=2^345.90
 ;;^UTILITY(U,$J,358.3,9380,1,3,0)
 ;;=3^Unspecified Epilepsy
 ;;^UTILITY(U,$J,358.3,9380,2)
 ;;=Unspecified Epilepsy^268477
 ;;^UTILITY(U,$J,358.3,9381,0)
 ;;=345.91^^72^560^12
 ;;^UTILITY(U,$J,358.3,9381,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9381,1,2,0)
 ;;=2^345.91
 ;;^UTILITY(U,$J,358.3,9381,1,3,0)
 ;;=3^Unspecified Epilipsy, Intract
 ;;^UTILITY(U,$J,358.3,9381,2)
 ;;=Unspecified, Intract Epilepsy^268478
 ;;^UTILITY(U,$J,358.3,9382,0)
 ;;=780.02^^72^560^9
 ;;^UTILITY(U,$J,358.3,9382,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9382,1,2,0)
 ;;=2^780.02
 ;;^UTILITY(U,$J,358.3,9382,1,3,0)
 ;;=3^Trans Alt of Awareness
 ;;^UTILITY(U,$J,358.3,9382,2)
 ;;=Trans Alt of Awareness^293932
 ;;^UTILITY(U,$J,358.3,9383,0)
 ;;=780.09^^72^560^10
 ;;^UTILITY(U,$J,358.3,9383,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,9383,1,2,0)
 ;;=2^780.09
