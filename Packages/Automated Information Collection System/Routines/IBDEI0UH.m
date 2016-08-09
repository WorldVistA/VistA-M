IBDEI0UH ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30633,1,3,0)
 ;;=3^Other/Unknown Substance Intoxication Delirium w/o Use D/O
 ;;^UTILITY(U,$J,358.3,30633,1,4,0)
 ;;=4^F19.921
 ;;^UTILITY(U,$J,358.3,30633,2)
 ;;=^5003453
 ;;^UTILITY(U,$J,358.3,30634,0)
 ;;=F19.10^^113^1481^29
 ;;^UTILITY(U,$J,358.3,30634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30634,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,30634,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,30634,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,30635,0)
 ;;=F19.20^^113^1481^30
 ;;^UTILITY(U,$J,358.3,30635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30635,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Moderate Use D/O
 ;;^UTILITY(U,$J,358.3,30635,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,30635,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,30636,0)
 ;;=F19.20^^113^1481^31
 ;;^UTILITY(U,$J,358.3,30636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30636,1,3,0)
 ;;=3^Other/Unknown Substance Use D/O w/ Severe Use D/O
 ;;^UTILITY(U,$J,358.3,30636,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,30636,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,30637,0)
 ;;=F19.239^^113^1481^32
 ;;^UTILITY(U,$J,358.3,30637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30637,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal
 ;;^UTILITY(U,$J,358.3,30637,1,4,0)
 ;;=4^F19.239
 ;;^UTILITY(U,$J,358.3,30637,2)
 ;;=^5003440
 ;;^UTILITY(U,$J,358.3,30638,0)
 ;;=F19.231^^113^1481^33
 ;;^UTILITY(U,$J,358.3,30638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30638,1,3,0)
 ;;=3^Other/Unknown Substance Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,30638,1,4,0)
 ;;=4^F19.231
 ;;^UTILITY(U,$J,358.3,30638,2)
 ;;=^5003438
 ;;^UTILITY(U,$J,358.3,30639,0)
 ;;=F19.99^^113^1481^28
 ;;^UTILITY(U,$J,358.3,30639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30639,1,3,0)
 ;;=3^Other/Unknown Substance Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,30639,1,4,0)
 ;;=4^F19.99
 ;;^UTILITY(U,$J,358.3,30639,2)
 ;;=^5133364
 ;;^UTILITY(U,$J,358.3,30640,0)
 ;;=F15.10^^113^1482^72
 ;;^UTILITY(U,$J,358.3,30640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30640,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Mild
 ;;^UTILITY(U,$J,358.3,30640,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,30640,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,30641,0)
 ;;=F15.20^^113^1482^73
 ;;^UTILITY(U,$J,358.3,30641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30641,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Moderate
 ;;^UTILITY(U,$J,358.3,30641,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,30641,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,30642,0)
 ;;=F15.20^^113^1482^74
 ;;^UTILITY(U,$J,358.3,30642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30642,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,30642,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,30642,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,30643,0)
 ;;=F15.99^^113^1482^35
 ;;^UTILITY(U,$J,358.3,30643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30643,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,30643,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,30643,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,30644,0)
 ;;=F14.99^^113^1482^67
 ;;^UTILITY(U,$J,358.3,30644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30644,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30644,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,30644,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,30645,0)
 ;;=F14.99^^113^1482^75
 ;;^UTILITY(U,$J,358.3,30645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30645,1,3,0)
 ;;=3^Stimulant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,30645,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,30645,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,30646,0)
 ;;=F15.180^^113^1482^4
 ;;^UTILITY(U,$J,358.3,30646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30646,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,30646,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,30646,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,30647,0)
 ;;=F15.280^^113^1482^5
 ;;^UTILITY(U,$J,358.3,30647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30647,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,30647,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,30647,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,30648,0)
 ;;=F15.980^^113^1482^6
 ;;^UTILITY(U,$J,358.3,30648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30648,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,30648,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,30648,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,30649,0)
 ;;=F15.14^^113^1482^7
 ;;^UTILITY(U,$J,358.3,30649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30649,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,30649,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,30649,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,30650,0)
 ;;=F15.24^^113^1482^8
 ;;^UTILITY(U,$J,358.3,30650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30650,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,30650,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,30650,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,30651,0)
 ;;=F15.94^^113^1482^9
 ;;^UTILITY(U,$J,358.3,30651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30651,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,30651,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,30651,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,30652,0)
 ;;=F15.921^^113^1482^10
 ;;^UTILITY(U,$J,358.3,30652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30652,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,30652,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,30652,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,30653,0)
 ;;=F15.14^^113^1482^11
 ;;^UTILITY(U,$J,358.3,30653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30653,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,30653,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,30653,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,30654,0)
 ;;=F15.24^^113^1482^12
 ;;^UTILITY(U,$J,358.3,30654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30654,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,30654,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,30654,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,30655,0)
 ;;=F15.94^^113^1482^13
 ;;^UTILITY(U,$J,358.3,30655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30655,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,30655,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,30655,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,30656,0)
 ;;=F15.188^^113^1482^14
 ;;^UTILITY(U,$J,358.3,30656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30656,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,30656,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,30656,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,30657,0)
 ;;=F15.288^^113^1482^15
 ;;^UTILITY(U,$J,358.3,30657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30657,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,30657,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,30657,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,30658,0)
 ;;=F15.988^^113^1482^16
 ;;^UTILITY(U,$J,358.3,30658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30658,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,30658,1,4,0)
 ;;=4^F15.988
