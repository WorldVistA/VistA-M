IBDEI0UF ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30581,1,3,0)
 ;;=3^Adult-Onset Fluency Disorder
 ;;^UTILITY(U,$J,358.3,30581,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,30581,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,30582,0)
 ;;=F90.2^^113^1478^2
 ;;^UTILITY(U,$J,358.3,30582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30582,1,3,0)
 ;;=3^Attention Deficit Disorder,Combined Presentation
 ;;^UTILITY(U,$J,358.3,30582,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,30582,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,30583,0)
 ;;=F90.1^^113^1478^3
 ;;^UTILITY(U,$J,358.3,30583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30583,1,3,0)
 ;;=3^Attention Deficit Disorder,Hyperactive/Impulsive Presentation
 ;;^UTILITY(U,$J,358.3,30583,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,30583,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,30584,0)
 ;;=F90.0^^113^1478^4
 ;;^UTILITY(U,$J,358.3,30584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30584,1,3,0)
 ;;=3^Attention Deficit Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,30584,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,30584,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,30585,0)
 ;;=F06.1^^113^1478^8
 ;;^UTILITY(U,$J,358.3,30585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30585,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,30585,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,30585,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,30586,0)
 ;;=F80.81^^113^1478^9
 ;;^UTILITY(U,$J,358.3,30586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30586,1,3,0)
 ;;=3^Child-Onset Fluency Disorder (Stuttering)
 ;;^UTILITY(U,$J,358.3,30586,1,4,0)
 ;;=4^F80.81
 ;;^UTILITY(U,$J,358.3,30586,2)
 ;;=^5003676
 ;;^UTILITY(U,$J,358.3,30587,0)
 ;;=F70.^^113^1478^13
 ;;^UTILITY(U,$J,358.3,30587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30587,1,3,0)
 ;;=3^Intellectual Disability,Mild
 ;;^UTILITY(U,$J,358.3,30587,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,30587,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,30588,0)
 ;;=F71.^^113^1478^14
 ;;^UTILITY(U,$J,358.3,30588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30588,1,3,0)
 ;;=3^Intellectual Disability,Moderate
 ;;^UTILITY(U,$J,358.3,30588,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,30588,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,30589,0)
 ;;=F73.^^113^1478^15
 ;;^UTILITY(U,$J,358.3,30589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30589,1,3,0)
 ;;=3^Intellectual Disability,Profound
 ;;^UTILITY(U,$J,358.3,30589,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,30589,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,30590,0)
 ;;=F72.^^113^1478^16
 ;;^UTILITY(U,$J,358.3,30590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30590,1,3,0)
 ;;=3^Intellectual Disability,Severe
 ;;^UTILITY(U,$J,358.3,30590,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,30590,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,30591,0)
 ;;=F90.8^^113^1478^5
 ;;^UTILITY(U,$J,358.3,30591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30591,1,3,0)
 ;;=3^Attention Deficit/Hyperactivity Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,30591,1,4,0)
 ;;=4^F90.8
 ;;^UTILITY(U,$J,358.3,30591,2)
 ;;=^5003695
 ;;^UTILITY(U,$J,358.3,30592,0)
 ;;=F95.1^^113^1478^25
 ;;^UTILITY(U,$J,358.3,30592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30592,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Vocal Tics Only
 ;;^UTILITY(U,$J,358.3,30592,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,30592,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,30593,0)
 ;;=F98.4^^113^1478^30
 ;;^UTILITY(U,$J,358.3,30593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30593,1,3,0)
 ;;=3^Stereotypic Movement D/O w/ Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,30593,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,30593,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,30594,0)
 ;;=F98.4^^113^1478^31
 ;;^UTILITY(U,$J,358.3,30594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30594,1,3,0)
 ;;=3^Stereotypic Movement D/O w/o Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,30594,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,30594,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,30595,0)
 ;;=F90.9^^113^1478^6
 ;;^UTILITY(U,$J,358.3,30595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30595,1,3,0)
 ;;=3^Attention Deficit/Hyperativity Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30595,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,30595,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,30596,0)
 ;;=F79.^^113^1478^17
 ;;^UTILITY(U,$J,358.3,30596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30596,1,3,0)
 ;;=3^Intellectual Disability,Unspec
 ;;^UTILITY(U,$J,358.3,30596,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,30596,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,30597,0)
 ;;=F15.929^^113^1479^7
 ;;^UTILITY(U,$J,358.3,30597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30597,1,3,0)
 ;;=3^Caffeine Intoxication
 ;;^UTILITY(U,$J,358.3,30597,1,4,0)
 ;;=4^F15.929
 ;;^UTILITY(U,$J,358.3,30597,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,30598,0)
 ;;=F15.93^^113^1479^8
 ;;^UTILITY(U,$J,358.3,30598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30598,1,3,0)
 ;;=3^Caffeine Withdrawal
 ;;^UTILITY(U,$J,358.3,30598,1,4,0)
 ;;=4^F15.93
 ;;^UTILITY(U,$J,358.3,30598,2)
 ;;=^5003315
 ;;^UTILITY(U,$J,358.3,30599,0)
 ;;=F15.180^^113^1479^1
 ;;^UTILITY(U,$J,358.3,30599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30599,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,30599,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,30599,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,30600,0)
 ;;=F15.280^^113^1479^2
 ;;^UTILITY(U,$J,358.3,30600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30600,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,30600,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,30600,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,30601,0)
 ;;=F15.980^^113^1479^3
 ;;^UTILITY(U,$J,358.3,30601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30601,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30601,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,30601,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,30602,0)
 ;;=F15.182^^113^1479^4
 ;;^UTILITY(U,$J,358.3,30602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30602,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,30602,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,30602,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,30603,0)
 ;;=F15.282^^113^1479^5
 ;;^UTILITY(U,$J,358.3,30603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30603,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,30603,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,30603,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,30604,0)
 ;;=F15.982^^113^1479^6
 ;;^UTILITY(U,$J,358.3,30604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30604,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,30604,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,30604,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,30605,0)
 ;;=F15.99^^113^1479^9
 ;;^UTILITY(U,$J,358.3,30605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30605,1,3,0)
 ;;=3^Caffeinie Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30605,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,30605,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,30606,0)
 ;;=R45.851^^113^1480^1
 ;;^UTILITY(U,$J,358.3,30606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30606,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,30606,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,30606,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,30607,0)
 ;;=F19.14^^113^1481^1
 ;;^UTILITY(U,$J,358.3,30607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30607,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,30607,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,30607,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,30608,0)
 ;;=F19.24^^113^1481^2
