IBDEI0LI ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27195,1,3,0)
 ;;=3^Attention Deficit Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,27195,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,27195,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,27196,0)
 ;;=F06.1^^71^1150^8
 ;;^UTILITY(U,$J,358.3,27196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27196,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,27196,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,27196,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,27197,0)
 ;;=F80.81^^71^1150^9
 ;;^UTILITY(U,$J,358.3,27197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27197,1,3,0)
 ;;=3^Child-Onset Fluency Disorder (Stuttering)
 ;;^UTILITY(U,$J,358.3,27197,1,4,0)
 ;;=4^F80.81
 ;;^UTILITY(U,$J,358.3,27197,2)
 ;;=^5003676
 ;;^UTILITY(U,$J,358.3,27198,0)
 ;;=F70.^^71^1150^13
 ;;^UTILITY(U,$J,358.3,27198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27198,1,3,0)
 ;;=3^Intellectual Disability,Mild
 ;;^UTILITY(U,$J,358.3,27198,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,27198,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,27199,0)
 ;;=F71.^^71^1150^14
 ;;^UTILITY(U,$J,358.3,27199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27199,1,3,0)
 ;;=3^Intellectual Disability,Moderate
 ;;^UTILITY(U,$J,358.3,27199,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,27199,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,27200,0)
 ;;=F73.^^71^1150^15
 ;;^UTILITY(U,$J,358.3,27200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27200,1,3,0)
 ;;=3^Intellectual Disability,Profound
 ;;^UTILITY(U,$J,358.3,27200,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,27200,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,27201,0)
 ;;=F72.^^71^1150^16
 ;;^UTILITY(U,$J,358.3,27201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27201,1,3,0)
 ;;=3^Intellectual Disability,Severe
 ;;^UTILITY(U,$J,358.3,27201,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,27201,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,27202,0)
 ;;=F90.8^^71^1150^5
 ;;^UTILITY(U,$J,358.3,27202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27202,1,3,0)
 ;;=3^Attention Deficit/Hyperactivity Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,27202,1,4,0)
 ;;=4^F90.8
 ;;^UTILITY(U,$J,358.3,27202,2)
 ;;=^5003695
 ;;^UTILITY(U,$J,358.3,27203,0)
 ;;=F95.1^^71^1150^25
 ;;^UTILITY(U,$J,358.3,27203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27203,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Vocal Tics Only
 ;;^UTILITY(U,$J,358.3,27203,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,27203,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,27204,0)
 ;;=F98.4^^71^1150^30
 ;;^UTILITY(U,$J,358.3,27204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27204,1,3,0)
 ;;=3^Stereotypic Movement D/O w/ Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,27204,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,27204,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,27205,0)
 ;;=F98.4^^71^1150^31
 ;;^UTILITY(U,$J,358.3,27205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27205,1,3,0)
 ;;=3^Stereotypic Movement D/O w/o Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,27205,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,27205,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,27206,0)
 ;;=F90.9^^71^1150^6
 ;;^UTILITY(U,$J,358.3,27206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27206,1,3,0)
 ;;=3^Attention Deficit/Hyperativity Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27206,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,27206,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,27207,0)
 ;;=F79.^^71^1150^17
 ;;^UTILITY(U,$J,358.3,27207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27207,1,3,0)
 ;;=3^Intellectual Disability,Unspec
 ;;^UTILITY(U,$J,358.3,27207,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,27207,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,27208,0)
 ;;=F15.929^^71^1151^7
 ;;^UTILITY(U,$J,358.3,27208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27208,1,3,0)
 ;;=3^Caffeine Intoxication
 ;;^UTILITY(U,$J,358.3,27208,1,4,0)
 ;;=4^F15.929
 ;;^UTILITY(U,$J,358.3,27208,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,27209,0)
 ;;=F15.93^^71^1151^8
 ;;^UTILITY(U,$J,358.3,27209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27209,1,3,0)
 ;;=3^Caffeine Withdrawal
 ;;^UTILITY(U,$J,358.3,27209,1,4,0)
 ;;=4^F15.93
 ;;^UTILITY(U,$J,358.3,27209,2)
 ;;=^5003315
 ;;^UTILITY(U,$J,358.3,27210,0)
 ;;=F15.180^^71^1151^1
 ;;^UTILITY(U,$J,358.3,27210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27210,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27210,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,27210,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,27211,0)
 ;;=F15.280^^71^1151^2
 ;;^UTILITY(U,$J,358.3,27211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27211,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27211,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,27211,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,27212,0)
 ;;=F15.980^^71^1151^3
 ;;^UTILITY(U,$J,358.3,27212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27212,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27212,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,27212,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,27213,0)
 ;;=F15.182^^71^1151^4
 ;;^UTILITY(U,$J,358.3,27213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27213,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,27213,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,27213,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,27214,0)
 ;;=F15.282^^71^1151^5
 ;;^UTILITY(U,$J,358.3,27214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27214,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,27214,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,27214,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,27215,0)
 ;;=F15.982^^71^1151^6
 ;;^UTILITY(U,$J,358.3,27215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27215,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,27215,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,27215,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,27216,0)
 ;;=F15.99^^71^1151^9
 ;;^UTILITY(U,$J,358.3,27216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27216,1,3,0)
 ;;=3^Caffeinie Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27216,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,27216,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,27217,0)
 ;;=R45.851^^71^1152^1
 ;;^UTILITY(U,$J,358.3,27217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27217,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,27217,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,27217,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,27218,0)
 ;;=F19.14^^71^1153^1
 ;;^UTILITY(U,$J,358.3,27218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27218,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27218,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,27218,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,27219,0)
 ;;=F19.24^^71^1153^2
 ;;^UTILITY(U,$J,358.3,27219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27219,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27219,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,27219,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,27220,0)
 ;;=F19.94^^71^1153^3
 ;;^UTILITY(U,$J,358.3,27220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27220,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27220,1,4,0)
 ;;=4^F19.94
 ;;^UTILITY(U,$J,358.3,27220,2)
 ;;=^5003460
 ;;^UTILITY(U,$J,358.3,27221,0)
 ;;=F19.17^^71^1153^4
 ;;^UTILITY(U,$J,358.3,27221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27221,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27221,1,4,0)
 ;;=4^F19.17
 ;;^UTILITY(U,$J,358.3,27221,2)
 ;;=^5003426
 ;;^UTILITY(U,$J,358.3,27222,0)
 ;;=F19.27^^71^1153^5
 ;;^UTILITY(U,$J,358.3,27222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27222,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27222,1,4,0)
 ;;=4^F19.27
 ;;^UTILITY(U,$J,358.3,27222,2)
 ;;=^5003446
 ;;^UTILITY(U,$J,358.3,27223,0)
 ;;=F19.97^^71^1153^6
 ;;^UTILITY(U,$J,358.3,27223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27223,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27223,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,27223,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,27224,0)
 ;;=F19.188^^71^1153^7
 ;;^UTILITY(U,$J,358.3,27224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27224,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27224,1,4,0)
 ;;=4^F19.188
 ;;^UTILITY(U,$J,358.3,27224,2)
 ;;=^5133361
 ;;^UTILITY(U,$J,358.3,27225,0)
 ;;=F19.288^^71^1153^8
 ;;^UTILITY(U,$J,358.3,27225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27225,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27225,1,4,0)
 ;;=4^F19.288
 ;;^UTILITY(U,$J,358.3,27225,2)
 ;;=^5133362
 ;;^UTILITY(U,$J,358.3,27226,0)
 ;;=F19.988^^71^1153^9
 ;;^UTILITY(U,$J,358.3,27226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27226,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27226,1,4,0)
 ;;=4^F19.988
 ;;^UTILITY(U,$J,358.3,27226,2)
 ;;=^5133363
 ;;^UTILITY(U,$J,358.3,27227,0)
 ;;=F19.188^^71^1153^10
 ;;^UTILITY(U,$J,358.3,27227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27227,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27227,1,4,0)
 ;;=4^F19.188
 ;;^UTILITY(U,$J,358.3,27227,2)
 ;;=^5133361
 ;;^UTILITY(U,$J,358.3,27228,0)
 ;;=F19.288^^71^1153^11
 ;;^UTILITY(U,$J,358.3,27228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27228,1,3,0)
 ;;=3^Other/Unknown Substance Induced Obsess-Compul & Rel D/O w/ Mod-Sev Use D/O
