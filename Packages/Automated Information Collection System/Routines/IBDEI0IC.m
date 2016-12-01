IBDEI0IC ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23269,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,23269,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,23269,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,23270,0)
 ;;=F31.2^^61^897^9
 ;;^UTILITY(U,$J,358.3,23270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23270,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,23270,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,23270,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,23271,0)
 ;;=F31.73^^61^897^10
 ;;^UTILITY(U,$J,358.3,23271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23271,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,23271,1,4,0)
 ;;=4^F31.73
 ;;^UTILITY(U,$J,358.3,23271,2)
 ;;=^5003513
 ;;^UTILITY(U,$J,358.3,23272,0)
 ;;=F31.74^^61^897^11
 ;;^UTILITY(U,$J,358.3,23272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23272,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Full Remission
 ;;^UTILITY(U,$J,358.3,23272,1,4,0)
 ;;=4^F31.74
 ;;^UTILITY(U,$J,358.3,23272,2)
 ;;=^5003514
 ;;^UTILITY(U,$J,358.3,23273,0)
 ;;=F31.31^^61^897^13
 ;;^UTILITY(U,$J,358.3,23273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23273,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Mild
 ;;^UTILITY(U,$J,358.3,23273,1,4,0)
 ;;=4^F31.31
 ;;^UTILITY(U,$J,358.3,23273,2)
 ;;=^5003501
 ;;^UTILITY(U,$J,358.3,23274,0)
 ;;=F31.32^^61^897^14
 ;;^UTILITY(U,$J,358.3,23274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23274,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Moderate
 ;;^UTILITY(U,$J,358.3,23274,1,4,0)
 ;;=4^F31.32
 ;;^UTILITY(U,$J,358.3,23274,2)
 ;;=^5003502
 ;;^UTILITY(U,$J,358.3,23275,0)
 ;;=F31.4^^61^897^15
 ;;^UTILITY(U,$J,358.3,23275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23275,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Severe
 ;;^UTILITY(U,$J,358.3,23275,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,23275,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,23276,0)
 ;;=F31.5^^61^897^16
 ;;^UTILITY(U,$J,358.3,23276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23276,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,23276,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,23276,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,23277,0)
 ;;=F31.75^^61^897^18
 ;;^UTILITY(U,$J,358.3,23277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23277,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,23277,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,23277,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,23278,0)
 ;;=F31.76^^61^897^17
 ;;^UTILITY(U,$J,358.3,23278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23278,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,23278,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,23278,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,23279,0)
 ;;=F31.81^^61^897^23
 ;;^UTILITY(U,$J,358.3,23279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23279,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,23279,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,23279,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,23280,0)
 ;;=F34.0^^61^897^24
 ;;^UTILITY(U,$J,358.3,23280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23280,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,23280,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,23280,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,23281,0)
 ;;=F31.0^^61^897^20
 ;;^UTILITY(U,$J,358.3,23281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23281,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,23281,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,23281,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,23282,0)
 ;;=F31.71^^61^897^22
 ;;^UTILITY(U,$J,358.3,23282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23282,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,23282,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,23282,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,23283,0)
 ;;=F31.72^^61^897^21
 ;;^UTILITY(U,$J,358.3,23283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23283,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,23283,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,23283,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,23284,0)
 ;;=F06.33^^61^897^3
 ;;^UTILITY(U,$J,358.3,23284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23284,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Med Cond w/ Manic/Hypomanic-Like Episode
 ;;^UTILITY(U,$J,358.3,23284,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,23284,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,23285,0)
 ;;=F31.9^^61^897^12
 ;;^UTILITY(U,$J,358.3,23285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23285,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Unsp
 ;;^UTILITY(U,$J,358.3,23285,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,23285,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,23286,0)
 ;;=F31.9^^61^897^19
 ;;^UTILITY(U,$J,358.3,23286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23286,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,Unsp
 ;;^UTILITY(U,$J,358.3,23286,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,23286,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,23287,0)
 ;;=F31.89^^61^897^4
 ;;^UTILITY(U,$J,358.3,23287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23287,1,3,0)
 ;;=3^Bipolar & Related Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,23287,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,23287,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,23288,0)
 ;;=F31.9^^61^897^5
 ;;^UTILITY(U,$J,358.3,23288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23288,1,3,0)
 ;;=3^Bipolar & Related Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,23288,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,23288,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,23289,0)
 ;;=A81.00^^61^898^8
 ;;^UTILITY(U,$J,358.3,23289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23289,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23289,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,23289,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,23290,0)
 ;;=A81.09^^61^898^7
 ;;^UTILITY(U,$J,358.3,23290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23290,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,23290,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,23290,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,23291,0)
 ;;=A81.2^^61^898^72
 ;;^UTILITY(U,$J,358.3,23291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23291,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,23291,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,23291,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,23292,0)
 ;;=F01.50^^61^898^46
 ;;^UTILITY(U,$J,358.3,23292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23292,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,23292,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,23292,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,23293,0)
 ;;=F01.51^^61^898^47
 ;;^UTILITY(U,$J,358.3,23293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23293,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,23293,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,23293,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,23294,0)
 ;;=F02.80^^61^898^34
 ;;^UTILITY(U,$J,358.3,23294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23294,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,23294,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,23294,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,23295,0)
 ;;=F02.81^^61^898^35
 ;;^UTILITY(U,$J,358.3,23295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23295,1,3,0)
 ;;=3^Major Neurocog D/O d/t Poss ALZHEIMER'S DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,23295,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,23295,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,23296,0)
 ;;=G30.9^^61^898^4
 ;;^UTILITY(U,$J,358.3,23296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23296,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,23296,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,23296,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,23297,0)
 ;;=G31.01^^61^898^70
 ;;^UTILITY(U,$J,358.3,23297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23297,1,3,0)
 ;;=3^Pick's Disease
 ;;^UTILITY(U,$J,358.3,23297,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,23297,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,23298,0)
 ;;=G94.^^61^898^6
 ;;^UTILITY(U,$J,358.3,23298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23298,1,3,0)
 ;;=3^Brain Disorders in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,23298,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,23298,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,23299,0)
 ;;=G31.83^^61^898^18
 ;;^UTILITY(U,$J,358.3,23299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23299,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,23299,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,23299,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,23300,0)
 ;;=G31.89^^61^898^11
 ;;^UTILITY(U,$J,358.3,23300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23300,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System NEC
 ;;^UTILITY(U,$J,358.3,23300,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,23300,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,23301,0)
 ;;=G31.9^^61^898^12
 ;;^UTILITY(U,$J,358.3,23301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23301,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,23301,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,23301,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,23302,0)
 ;;=G23.8^^61^898^10
 ;;^UTILITY(U,$J,358.3,23302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23302,1,3,0)
 ;;=3^Degenerative Diseases of Basal Ganglia NEC
