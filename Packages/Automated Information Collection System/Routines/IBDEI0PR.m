IBDEI0PR ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25902,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,25903,0)
 ;;=F18.121^^97^1227^16
 ;;^UTILITY(U,$J,358.3,25903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25903,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25903,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,25903,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,25904,0)
 ;;=F18.221^^97^1227^17
 ;;^UTILITY(U,$J,358.3,25904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25904,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25904,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,25904,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,25905,0)
 ;;=F18.921^^97^1227^18
 ;;^UTILITY(U,$J,358.3,25905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25905,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25905,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,25905,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,25906,0)
 ;;=F18.129^^97^1227^19
 ;;^UTILITY(U,$J,358.3,25906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25906,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25906,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,25906,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,25907,0)
 ;;=F18.229^^97^1227^20
 ;;^UTILITY(U,$J,358.3,25907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25907,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25907,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,25907,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,25908,0)
 ;;=F18.929^^97^1227^21
 ;;^UTILITY(U,$J,358.3,25908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25908,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25908,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,25908,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,25909,0)
 ;;=F18.180^^97^1227^1
 ;;^UTILITY(U,$J,358.3,25909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25909,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25909,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,25909,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,25910,0)
 ;;=F18.280^^97^1227^2
 ;;^UTILITY(U,$J,358.3,25910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25910,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25910,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,25910,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,25911,0)
 ;;=F18.980^^97^1227^3
 ;;^UTILITY(U,$J,358.3,25911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25911,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25911,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,25911,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,25912,0)
 ;;=F18.94^^97^1227^6
 ;;^UTILITY(U,$J,358.3,25912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25912,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25912,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,25912,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,25913,0)
 ;;=F18.17^^97^1227^7
 ;;^UTILITY(U,$J,358.3,25913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25913,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25913,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,25913,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,25914,0)
 ;;=F18.27^^97^1227^8
 ;;^UTILITY(U,$J,358.3,25914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25914,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25914,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,25914,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,25915,0)
 ;;=F18.97^^97^1227^9
 ;;^UTILITY(U,$J,358.3,25915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25915,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25915,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,25915,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,25916,0)
 ;;=F18.188^^97^1227^10
 ;;^UTILITY(U,$J,358.3,25916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25916,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25916,1,4,0)
 ;;=4^F18.188
 ;;^UTILITY(U,$J,358.3,25916,2)
 ;;=^5003390
 ;;^UTILITY(U,$J,358.3,25917,0)
 ;;=F18.288^^97^1227^11
 ;;^UTILITY(U,$J,358.3,25917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25917,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25917,1,4,0)
 ;;=4^F18.288
 ;;^UTILITY(U,$J,358.3,25917,2)
 ;;=^5003403
 ;;^UTILITY(U,$J,358.3,25918,0)
 ;;=F18.988^^97^1227^12
 ;;^UTILITY(U,$J,358.3,25918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25918,1,3,0)
 ;;=3^Inhalant Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25918,1,4,0)
 ;;=4^F18.988
 ;;^UTILITY(U,$J,358.3,25918,2)
 ;;=^5003415
 ;;^UTILITY(U,$J,358.3,25919,0)
 ;;=F18.159^^97^1227^13
 ;;^UTILITY(U,$J,358.3,25919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25919,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25919,1,4,0)
 ;;=4^F18.159
 ;;^UTILITY(U,$J,358.3,25919,2)
 ;;=^5003387
 ;;^UTILITY(U,$J,358.3,25920,0)
 ;;=F18.259^^97^1227^14
 ;;^UTILITY(U,$J,358.3,25920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25920,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25920,1,4,0)
 ;;=4^F18.259
 ;;^UTILITY(U,$J,358.3,25920,2)
 ;;=^5003400
 ;;^UTILITY(U,$J,358.3,25921,0)
 ;;=F18.959^^97^1227^15
 ;;^UTILITY(U,$J,358.3,25921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25921,1,3,0)
 ;;=3^Inhalant Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25921,1,4,0)
 ;;=4^F18.959
 ;;^UTILITY(U,$J,358.3,25921,2)
 ;;=^5003412
 ;;^UTILITY(U,$J,358.3,25922,0)
 ;;=F18.99^^97^1227^22
 ;;^UTILITY(U,$J,358.3,25922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25922,1,3,0)
 ;;=3^Inhalant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25922,1,4,0)
 ;;=4^F18.99
 ;;^UTILITY(U,$J,358.3,25922,2)
 ;;=^5133360
 ;;^UTILITY(U,$J,358.3,25923,0)
 ;;=F18.20^^97^1227^25
 ;;^UTILITY(U,$J,358.3,25923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25923,1,3,0)
 ;;=3^Inhalant Use Disorder,Severe
 ;;^UTILITY(U,$J,358.3,25923,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,25923,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,25924,0)
 ;;=Z00.6^^97^1228^1
 ;;^UTILITY(U,$J,358.3,25924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25924,1,3,0)
 ;;=3^Exam of Participant of Control in Clinical Research Program
 ;;^UTILITY(U,$J,358.3,25924,1,4,0)
 ;;=4^Z00.6
 ;;^UTILITY(U,$J,358.3,25924,2)
 ;;=^5062608
 ;;^UTILITY(U,$J,358.3,25925,0)
 ;;=F45.22^^97^1229^1
 ;;^UTILITY(U,$J,358.3,25925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25925,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,25925,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,25925,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,25926,0)
 ;;=F45.8^^97^1229^16
 ;;^UTILITY(U,$J,358.3,25926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25926,1,3,0)
 ;;=3^Somatoform Disorders,Other Specified
 ;;^UTILITY(U,$J,358.3,25926,1,4,0)
 ;;=4^F45.8
 ;;^UTILITY(U,$J,358.3,25926,2)
 ;;=^331915
 ;;^UTILITY(U,$J,358.3,25927,0)
 ;;=F45.0^^97^1229^14
 ;;^UTILITY(U,$J,358.3,25927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25927,1,3,0)
 ;;=3^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,25927,1,4,0)
 ;;=4^F45.0
 ;;^UTILITY(U,$J,358.3,25927,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,25928,0)
 ;;=F45.9^^97^1229^15
 ;;^UTILITY(U,$J,358.3,25928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25928,1,3,0)
 ;;=3^Somatoform Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25928,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,25928,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,25929,0)
 ;;=F45.1^^97^1229^13
