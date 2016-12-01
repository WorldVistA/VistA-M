IBDEI0BP ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14847,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,14847,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,14847,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,14848,0)
 ;;=F31.72^^45^656^21
 ;;^UTILITY(U,$J,358.3,14848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14848,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,14848,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,14848,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,14849,0)
 ;;=F06.33^^45^656^3
 ;;^UTILITY(U,$J,358.3,14849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14849,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic/Hypomanic-Like Episode
 ;;^UTILITY(U,$J,358.3,14849,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,14849,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,14850,0)
 ;;=F31.9^^45^656^12
 ;;^UTILITY(U,$J,358.3,14850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14850,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Unsp
 ;;^UTILITY(U,$J,358.3,14850,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,14850,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,14851,0)
 ;;=F31.9^^45^656^19
 ;;^UTILITY(U,$J,358.3,14851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14851,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unsp
 ;;^UTILITY(U,$J,358.3,14851,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,14851,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,14852,0)
 ;;=F31.89^^45^656^4
 ;;^UTILITY(U,$J,358.3,14852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14852,1,3,0)
 ;;=3^Bipolar & Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,14852,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,14852,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,14853,0)
 ;;=F31.9^^45^656^5
 ;;^UTILITY(U,$J,358.3,14853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14853,1,3,0)
 ;;=3^Bipolar & Related Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,14853,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,14853,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,14854,0)
 ;;=A81.00^^45^657^8
 ;;^UTILITY(U,$J,358.3,14854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14854,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,14854,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,14854,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,14855,0)
 ;;=A81.09^^45^657^7
 ;;^UTILITY(U,$J,358.3,14855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14855,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,14855,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,14855,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,14856,0)
 ;;=A81.2^^45^657^72
 ;;^UTILITY(U,$J,358.3,14856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14856,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,14856,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,14856,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,14857,0)
 ;;=F01.50^^45^657^46
 ;;^UTILITY(U,$J,358.3,14857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14857,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,14857,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,14857,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,14858,0)
 ;;=F01.51^^45^657^47
 ;;^UTILITY(U,$J,358.3,14858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14858,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,14858,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,14858,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,14859,0)
 ;;=F02.80^^45^657^34
 ;;^UTILITY(U,$J,358.3,14859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14859,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,14859,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,14859,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,14860,0)
 ;;=F02.81^^45^657^35
 ;;^UTILITY(U,$J,358.3,14860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14860,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,14860,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,14860,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,14861,0)
 ;;=G30.9^^45^657^4
 ;;^UTILITY(U,$J,358.3,14861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14861,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,14861,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,14861,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,14862,0)
 ;;=G31.01^^45^657^70
 ;;^UTILITY(U,$J,358.3,14862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14862,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,14862,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,14862,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,14863,0)
 ;;=G94.^^45^657^6
 ;;^UTILITY(U,$J,358.3,14863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14863,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,14863,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,14863,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,14864,0)
 ;;=G31.83^^45^657^18
 ;;^UTILITY(U,$J,358.3,14864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14864,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,14864,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,14864,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,14865,0)
 ;;=G31.89^^45^657^11
 ;;^UTILITY(U,$J,358.3,14865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14865,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,14865,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,14865,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,14866,0)
 ;;=G31.9^^45^657^12
 ;;^UTILITY(U,$J,358.3,14866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14866,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,14866,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,14866,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,14867,0)
 ;;=G23.8^^45^657^10
 ;;^UTILITY(U,$J,358.3,14867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14867,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,14867,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,14867,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,14868,0)
 ;;=G30.0^^45^657^2
 ;;^UTILITY(U,$J,358.3,14868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14868,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,14868,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,14868,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,14869,0)
 ;;=G30.1^^45^657^3
 ;;^UTILITY(U,$J,358.3,14869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14869,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,14869,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,14869,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,14870,0)
 ;;=B20.^^45^657^21
 ;;^UTILITY(U,$J,358.3,14870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14870,1,3,0)
 ;;=3^HIV Infection
 ;;^UTILITY(U,$J,358.3,14870,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,14870,2)
 ;;=^5000555^
 ;;^UTILITY(U,$J,358.3,14871,0)
 ;;=G10.^^45^657^22
 ;;^UTILITY(U,$J,358.3,14871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14871,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,14871,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,14871,2)
 ;;=^5003751^
 ;;^UTILITY(U,$J,358.3,14872,0)
 ;;=G30.8^^45^657^1
 ;;^UTILITY(U,$J,358.3,14872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14872,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,14872,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,14872,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,14873,0)
 ;;=A81.89^^45^657^5
 ;;^UTILITY(U,$J,358.3,14873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14873,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,14873,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,14873,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,14874,0)
 ;;=G20.^^45^657^69
 ;;^UTILITY(U,$J,358.3,14874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14874,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,14874,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,14874,2)
 ;;=^5003770^
 ;;^UTILITY(U,$J,358.3,14875,0)
 ;;=G23.1^^45^657^73
 ;;^UTILITY(U,$J,358.3,14875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14875,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,14875,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,14875,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,14876,0)
 ;;=F03.91^^45^657^17
 ;;^UTILITY(U,$J,358.3,14876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14876,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,14876,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,14876,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,14877,0)
 ;;=F03.90^^45^657^19
 ;;^UTILITY(U,$J,358.3,14877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14877,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,14877,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,14877,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,14878,0)
 ;;=F02.81^^45^657^40
 ;;^UTILITY(U,$J,358.3,14878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14878,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob ALZHEIMER'S DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,14878,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,14878,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,14879,0)
 ;;=F02.80^^45^657^41
 ;;^UTILITY(U,$J,358.3,14879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14879,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob ALZHEIMER'S DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,14879,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,14879,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,14880,0)
 ;;=G31.84^^45^657^56
 ;;^UTILITY(U,$J,358.3,14880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14880,1,3,0)
 ;;=3^Mild Neurocog D/O d/t ALZHEIMER'S DISEASE
 ;;^UTILITY(U,$J,358.3,14880,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,14880,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,14881,0)
 ;;=F02.81^^45^657^24
 ;;^UTILITY(U,$J,358.3,14881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14881,1,3,0)
 ;;=3^Major Neurocog D/O d/t ANOTHER MED COND w/ Behav Disturb
