IBDEI00Q ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,193,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,193,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,194,0)
 ;;=F31.4^^3^25^15
 ;;^UTILITY(U,$J,358.3,194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,194,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,194,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,194,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,195,0)
 ;;=F31.5^^3^25^16
 ;;^UTILITY(U,$J,358.3,195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,195,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,195,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,195,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,196,0)
 ;;=F31.75^^3^25^18
 ;;^UTILITY(U,$J,358.3,196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,196,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,196,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,196,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,197,0)
 ;;=F31.76^^3^25^17
 ;;^UTILITY(U,$J,358.3,197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,197,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,197,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,197,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,198,0)
 ;;=F31.81^^3^25^23
 ;;^UTILITY(U,$J,358.3,198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,198,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,198,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,198,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,199,0)
 ;;=F34.0^^3^25^24
 ;;^UTILITY(U,$J,358.3,199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,199,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,199,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,199,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,200,0)
 ;;=F31.0^^3^25^20
 ;;^UTILITY(U,$J,358.3,200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,200,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,200,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,200,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,201,0)
 ;;=F31.71^^3^25^22
 ;;^UTILITY(U,$J,358.3,201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,201,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,201,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,201,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,202,0)
 ;;=F31.72^^3^25^21
 ;;^UTILITY(U,$J,358.3,202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,202,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,202,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,202,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,203,0)
 ;;=F06.33^^3^25^3
 ;;^UTILITY(U,$J,358.3,203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,203,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic/Hypomanic-Like Episode
 ;;^UTILITY(U,$J,358.3,203,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,203,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,204,0)
 ;;=F31.9^^3^25^12
 ;;^UTILITY(U,$J,358.3,204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,204,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Unsp
 ;;^UTILITY(U,$J,358.3,204,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,204,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,205,0)
 ;;=F31.9^^3^25^19
 ;;^UTILITY(U,$J,358.3,205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,205,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unsp
 ;;^UTILITY(U,$J,358.3,205,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,205,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,206,0)
 ;;=F31.89^^3^25^4
 ;;^UTILITY(U,$J,358.3,206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,206,1,3,0)
 ;;=3^Bipolar & Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,206,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,206,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,207,0)
 ;;=F31.9^^3^25^5
 ;;^UTILITY(U,$J,358.3,207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,207,1,3,0)
 ;;=3^Bipolar & Related Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,207,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,207,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,208,0)
 ;;=A81.00^^3^26^8
 ;;^UTILITY(U,$J,358.3,208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,208,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,208,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,208,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,209,0)
 ;;=A81.09^^3^26^7
 ;;^UTILITY(U,$J,358.3,209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,209,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,209,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,209,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,210,0)
 ;;=A81.2^^3^26^72
 ;;^UTILITY(U,$J,358.3,210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,210,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,210,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,210,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,211,0)
 ;;=F01.50^^3^26^46
 ;;^UTILITY(U,$J,358.3,211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,211,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,211,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,211,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,212,0)
 ;;=F01.51^^3^26^47
 ;;^UTILITY(U,$J,358.3,212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,212,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,212,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,212,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,213,0)
 ;;=F02.80^^3^26^34
 ;;^UTILITY(U,$J,358.3,213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,213,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,213,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,213,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,214,0)
 ;;=F02.81^^3^26^35
 ;;^UTILITY(U,$J,358.3,214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,214,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,214,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,214,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,215,0)
 ;;=G30.9^^3^26^4
 ;;^UTILITY(U,$J,358.3,215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,215,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,215,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,215,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,216,0)
 ;;=G31.01^^3^26^70
 ;;^UTILITY(U,$J,358.3,216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,216,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,216,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,216,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,217,0)
 ;;=G94.^^3^26^6
 ;;^UTILITY(U,$J,358.3,217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,217,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,217,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,217,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,218,0)
 ;;=G31.83^^3^26^18
 ;;^UTILITY(U,$J,358.3,218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,218,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,218,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,218,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,219,0)
 ;;=G31.89^^3^26^11
 ;;^UTILITY(U,$J,358.3,219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,219,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,219,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,219,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,220,0)
 ;;=G31.9^^3^26^12
 ;;^UTILITY(U,$J,358.3,220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,220,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,220,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,220,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,221,0)
 ;;=G23.8^^3^26^10
 ;;^UTILITY(U,$J,358.3,221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,221,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
