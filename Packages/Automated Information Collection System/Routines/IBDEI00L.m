IBDEI00L ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,203,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,203,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,203,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,204,0)
 ;;=F06.33^^3^25^3
 ;;^UTILITY(U,$J,358.3,204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,204,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic/Hypomanic-Like Episode
 ;;^UTILITY(U,$J,358.3,204,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,204,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,205,0)
 ;;=F31.9^^3^25^12
 ;;^UTILITY(U,$J,358.3,205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,205,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Unsp
 ;;^UTILITY(U,$J,358.3,205,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,205,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,206,0)
 ;;=F31.9^^3^25^19
 ;;^UTILITY(U,$J,358.3,206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,206,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unsp
 ;;^UTILITY(U,$J,358.3,206,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,206,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,207,0)
 ;;=F31.89^^3^25^4
 ;;^UTILITY(U,$J,358.3,207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,207,1,3,0)
 ;;=3^Bipolar & Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,207,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,207,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,208,0)
 ;;=F31.9^^3^25^5
 ;;^UTILITY(U,$J,358.3,208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,208,1,3,0)
 ;;=3^Bipolar & Related Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,208,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,208,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,209,0)
 ;;=A81.00^^3^26^8
 ;;^UTILITY(U,$J,358.3,209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,209,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,209,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,209,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,210,0)
 ;;=A81.09^^3^26^7
 ;;^UTILITY(U,$J,358.3,210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,210,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,210,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,210,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,211,0)
 ;;=A81.2^^3^26^72
 ;;^UTILITY(U,$J,358.3,211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,211,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,211,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,211,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,212,0)
 ;;=F01.50^^3^26^46
 ;;^UTILITY(U,$J,358.3,212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,212,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,212,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,212,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,213,0)
 ;;=F01.51^^3^26^47
 ;;^UTILITY(U,$J,358.3,213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,213,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,213,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,213,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,214,0)
 ;;=F02.80^^3^26^34
 ;;^UTILITY(U,$J,358.3,214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,214,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,214,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,214,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,215,0)
 ;;=F02.81^^3^26^35
 ;;^UTILITY(U,$J,358.3,215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,215,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,215,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,215,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,216,0)
 ;;=G30.9^^3^26^4
 ;;^UTILITY(U,$J,358.3,216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,216,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,216,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,216,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,217,0)
 ;;=G31.01^^3^26^70
 ;;^UTILITY(U,$J,358.3,217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,217,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,217,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,217,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,218,0)
 ;;=G94.^^3^26^6
 ;;^UTILITY(U,$J,358.3,218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,218,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,218,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,218,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,219,0)
 ;;=G31.83^^3^26^18
 ;;^UTILITY(U,$J,358.3,219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,219,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,219,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,219,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,220,0)
 ;;=G31.89^^3^26^11
 ;;^UTILITY(U,$J,358.3,220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,220,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,220,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,220,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,221,0)
 ;;=G31.9^^3^26^12
 ;;^UTILITY(U,$J,358.3,221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,221,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,221,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,221,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,222,0)
 ;;=G23.8^^3^26^10
 ;;^UTILITY(U,$J,358.3,222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,222,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
 ;;^UTILITY(U,$J,358.3,222,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,222,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,223,0)
 ;;=G30.0^^3^26^2
 ;;^UTILITY(U,$J,358.3,223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,223,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,223,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,223,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,224,0)
 ;;=G30.1^^3^26^3
 ;;^UTILITY(U,$J,358.3,224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,224,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,224,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,224,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,225,0)
 ;;=B20.^^3^26^21
 ;;^UTILITY(U,$J,358.3,225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,225,1,3,0)
 ;;=3^HIV Infection
 ;;^UTILITY(U,$J,358.3,225,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,225,2)
 ;;=^5000555^
 ;;^UTILITY(U,$J,358.3,226,0)
 ;;=G10.^^3^26^22
 ;;^UTILITY(U,$J,358.3,226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,226,1,3,0)
 ;;=3^Huntington's Disease
 ;;^UTILITY(U,$J,358.3,226,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,226,2)
 ;;=^5003751^
 ;;^UTILITY(U,$J,358.3,227,0)
 ;;=G30.8^^3^26^1
 ;;^UTILITY(U,$J,358.3,227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,227,1,3,0)
 ;;=3^Alzheimer's Disease NEC
 ;;^UTILITY(U,$J,358.3,227,1,4,0)
 ;;=4^G30.8
 ;;^UTILITY(U,$J,358.3,227,2)
 ;;=^5003807
 ;;^UTILITY(U,$J,358.3,228,0)
 ;;=A81.89^^3^26^5
 ;;^UTILITY(U,$J,358.3,228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,228,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,228,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,228,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,229,0)
 ;;=G20.^^3^26^69
 ;;^UTILITY(U,$J,358.3,229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,229,1,3,0)
 ;;=3^Parkinson's Disease
 ;;^UTILITY(U,$J,358.3,229,1,4,0)
 ;;=4^G20.
 ;;^UTILITY(U,$J,358.3,229,2)
 ;;=^5003770^
 ;;^UTILITY(U,$J,358.3,230,0)
 ;;=G23.1^^3^26^73
 ;;^UTILITY(U,$J,358.3,230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,230,1,3,0)
 ;;=3^Progressive Supranuclear Ophthalmoplegia Palsy
 ;;^UTILITY(U,$J,358.3,230,1,4,0)
 ;;=4^G23.1
 ;;^UTILITY(U,$J,358.3,230,2)
 ;;=^5003780
 ;;^UTILITY(U,$J,358.3,231,0)
 ;;=F03.91^^3^26^17
 ;;^UTILITY(U,$J,358.3,231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,231,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,231,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,231,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,232,0)
 ;;=F03.90^^3^26^19
 ;;^UTILITY(U,$J,358.3,232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,232,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,232,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,232,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,233,0)
 ;;=F02.81^^3^26^40
 ;;^UTILITY(U,$J,358.3,233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,233,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob ALZHEIMER'S DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,233,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,233,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,234,0)
 ;;=F02.80^^3^26^41
 ;;^UTILITY(U,$J,358.3,234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,234,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob ALZHEIMER'S DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,234,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,234,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,235,0)
 ;;=G31.84^^3^26^56
 ;;^UTILITY(U,$J,358.3,235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,235,1,3,0)
 ;;=3^Mild Neurocog D/O d/t ALZHEIMER'S DISEASE
 ;;^UTILITY(U,$J,358.3,235,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,235,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,236,0)
 ;;=F02.81^^3^26^24
 ;;^UTILITY(U,$J,358.3,236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,236,1,3,0)
 ;;=3^Major Neurocog D/O d/t ANOTHER MED COND w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,236,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,236,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,237,0)
 ;;=F02.80^^3^26^25
 ;;^UTILITY(U,$J,358.3,237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,237,1,3,0)
 ;;=3^Major Neurocog D/O d/t ANOTHER MED COND w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,237,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,237,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,238,0)
 ;;=G31.84^^3^26^57
 ;;^UTILITY(U,$J,358.3,238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,238,1,3,0)
 ;;=3^Mild Neurocog D/O d/t ANOTHER MEDICAL CONDITION
 ;;^UTILITY(U,$J,358.3,238,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,238,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,239,0)
 ;;=A81.01^^3^26^9
 ;;^UTILITY(U,$J,358.3,239,1,0)
 ;;=^358.31IA^4^2
