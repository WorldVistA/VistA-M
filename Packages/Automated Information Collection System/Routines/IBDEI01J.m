IBDEI01J ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1011,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,1011,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,1012,0)
 ;;=A81.2^^6^78^27
 ;;^UTILITY(U,$J,358.3,1012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1012,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,1012,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,1012,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,1013,0)
 ;;=B20.^^6^78^17
 ;;^UTILITY(U,$J,358.3,1013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1013,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,1013,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,1013,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,1014,0)
 ;;=B20.^^6^78^18
 ;;^UTILITY(U,$J,358.3,1014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1014,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,1014,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,1014,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,1015,0)
 ;;=F10.27^^6^78^1
 ;;^UTILITY(U,$J,358.3,1015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1015,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,1015,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,1015,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,1016,0)
 ;;=F19.97^^6^78^29
 ;;^UTILITY(U,$J,358.3,1016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1016,1,3,0)
 ;;=3^Psychoactive Subs Use w/ Subs-Induced Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,1016,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,1016,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,1017,0)
 ;;=G30.0^^6^78^2
 ;;^UTILITY(U,$J,358.3,1017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1017,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,1017,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,1017,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,1018,0)
 ;;=G30.1^^6^78^3
 ;;^UTILITY(U,$J,358.3,1018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1018,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,1018,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,1018,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,1019,0)
 ;;=G30.9^^6^78^4
 ;;^UTILITY(U,$J,358.3,1019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1019,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1019,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,1019,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,1020,0)
 ;;=G10.^^6^78^19
 ;;^UTILITY(U,$J,358.3,1020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1020,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,1020,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,1020,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,1021,0)
 ;;=G10.^^6^78^20
 ;;^UTILITY(U,$J,358.3,1021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1021,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,1021,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,1021,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,1022,0)
 ;;=G90.3^^6^78^21
 ;;^UTILITY(U,$J,358.3,1022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1022,1,3,0)
 ;;=3^Multi-System Degeneration of the Autonomic Nervous System
 ;;^UTILITY(U,$J,358.3,1022,1,4,0)
 ;;=4^G90.3
 ;;^UTILITY(U,$J,358.3,1022,2)
 ;;=^5004162
 ;;^UTILITY(U,$J,358.3,1023,0)
 ;;=G91.2^^6^78^22
 ;;^UTILITY(U,$J,358.3,1023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1023,1,3,0)
 ;;=3^NPH w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,1023,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,1023,2)
 ;;=^5004174^F02.81
 ;;^UTILITY(U,$J,358.3,1024,0)
 ;;=G91.2^^6^78^23
 ;;^UTILITY(U,$J,358.3,1024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1024,1,3,0)
 ;;=3^NPH w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,1024,1,4,0)
 ;;=4^G91.2
 ;;^UTILITY(U,$J,358.3,1024,2)
 ;;=^5004174^F02.80
 ;;^UTILITY(U,$J,358.3,1025,0)
 ;;=G30.8^^6^78^5
 ;;^UTILITY(U,$J,358.3,1025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1025,1,3,0)
 ;;=3^Alzheimer's Diseases NEC
 ;;^UTILITY(U,$J,358.3,1025,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,1025,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,1026,0)
 ;;=G31.09^^6^78^16
 ;;^UTILITY(U,$J,358.3,1026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1026,1,3,0)
 ;;=3^Frontotemporal Dementia NEC
 ;;^UTILITY(U,$J,358.3,1026,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,1026,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,1027,0)
 ;;=G20.^^6^78^24
 ;;^UTILITY(U,$J,358.3,1027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1027,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,1027,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,1027,2)
 ;;=^5003770^F02.81
 ;;^UTILITY(U,$J,358.3,1028,0)
 ;;=G20.^^6^78^25
 ;;^UTILITY(U,$J,358.3,1028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1028,1,3,0)
 ;;=3^Parkinson's Disease w/ Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,1028,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,1028,2)
 ;;=^5003770^F02.80
 ;;^UTILITY(U,$J,358.3,1029,0)
 ;;=G31.01^^6^78^26
 ;;^UTILITY(U,$J,358.3,1029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1029,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,1029,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,1029,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,1030,0)
 ;;=G23.1^^6^78^28
 ;;^UTILITY(U,$J,358.3,1030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1030,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia
 ;;^UTILITY(U,$J,358.3,1030,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,1030,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,1031,0)
 ;;=99212^^7^79^2
 ;;^UTILITY(U,$J,358.3,1031,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1031,1,1,0)
 ;;=1^Expanded Problem Focused
 ;;^UTILITY(U,$J,358.3,1031,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,1032,0)
 ;;=99213^^7^79^3
 ;;^UTILITY(U,$J,358.3,1032,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1032,1,1,0)
 ;;=1^Detailed Visit
 ;;^UTILITY(U,$J,358.3,1032,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,1033,0)
 ;;=99214^^7^79^4
 ;;^UTILITY(U,$J,358.3,1033,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1033,1,1,0)
 ;;=1^Comprehensive,Mod Complexity
 ;;^UTILITY(U,$J,358.3,1033,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,1034,0)
 ;;=99211^^7^79^1
 ;;^UTILITY(U,$J,358.3,1034,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1034,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,1034,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,1035,0)
 ;;=99242^^7^80^1
 ;;^UTILITY(U,$J,358.3,1035,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1035,1,1,0)
 ;;=1^Expanded Problem Focused
 ;;^UTILITY(U,$J,358.3,1035,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,1036,0)
 ;;=99243^^7^80^2
 ;;^UTILITY(U,$J,358.3,1036,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1036,1,1,0)
 ;;=1^Detailed Visit
 ;;^UTILITY(U,$J,358.3,1036,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,1037,0)
 ;;=99244^^7^80^3
 ;;^UTILITY(U,$J,358.3,1037,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1037,1,1,0)
 ;;=1^Comprehensive,Mod Complexity
 ;;^UTILITY(U,$J,358.3,1037,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,1038,0)
 ;;=99024^^7^81^1
 ;;^UTILITY(U,$J,358.3,1038,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,1038,1,1,0)
 ;;=1^Post Op visit in Global
 ;;^UTILITY(U,$J,358.3,1038,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,1039,0)
 ;;=64415^^8^82^4^^^^1
 ;;^UTILITY(U,$J,358.3,1039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1039,1,2,0)
 ;;=2^NERVE BLK BRACHIAL PLEXUS,SNGL INJ
 ;;^UTILITY(U,$J,358.3,1039,1,4,0)
 ;;=4^64415
 ;;^UTILITY(U,$J,358.3,1040,0)
 ;;=64416^^8^82^3^^^^1
 ;;^UTILITY(U,$J,358.3,1040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1040,1,2,0)
 ;;=2^NERVE BLK BRACHIAL PLEXUS,CONT INFUSION
 ;;^UTILITY(U,$J,358.3,1040,1,4,0)
 ;;=4^64416
 ;;^UTILITY(U,$J,358.3,1041,0)
 ;;=64413^^8^82^7^^^^1
 ;;^UTILITY(U,$J,358.3,1041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1041,1,2,0)
 ;;=2^NERVE BLK CERVICAL PLEXUS,INJ
 ;;^UTILITY(U,$J,358.3,1041,1,4,0)
 ;;=4^64413
 ;;^UTILITY(U,$J,358.3,1042,0)
 ;;=64402^^8^82^8^^^^1
