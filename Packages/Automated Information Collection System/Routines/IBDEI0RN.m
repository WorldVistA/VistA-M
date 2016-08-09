IBDEI0RN ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27754,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,27754,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,27755,0)
 ;;=F15.20^^102^1356^74
 ;;^UTILITY(U,$J,358.3,27755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27755,1,3,0)
 ;;=3^Other or Unspecified Stimulant Use D/O, Severe
 ;;^UTILITY(U,$J,358.3,27755,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,27755,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,27756,0)
 ;;=F15.99^^102^1356^35
 ;;^UTILITY(U,$J,358.3,27756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27756,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Related D/O,Unspec
 ;;^UTILITY(U,$J,358.3,27756,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,27756,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,27757,0)
 ;;=F14.99^^102^1356^67
 ;;^UTILITY(U,$J,358.3,27757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27757,1,3,0)
 ;;=3^Cocaine Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27757,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,27757,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,27758,0)
 ;;=F14.99^^102^1356^75
 ;;^UTILITY(U,$J,358.3,27758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27758,1,3,0)
 ;;=3^Stimulant Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,27758,1,4,0)
 ;;=4^F14.99
 ;;^UTILITY(U,$J,358.3,27758,2)
 ;;=^5133354
 ;;^UTILITY(U,$J,358.3,27759,0)
 ;;=F15.180^^102^1356^4
 ;;^UTILITY(U,$J,358.3,27759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27759,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27759,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,27759,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,27760,0)
 ;;=F15.280^^102^1356^5
 ;;^UTILITY(U,$J,358.3,27760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27760,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27760,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,27760,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,27761,0)
 ;;=F15.980^^102^1356^6
 ;;^UTILITY(U,$J,358.3,27761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27761,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Anxiety D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27761,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,27761,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,27762,0)
 ;;=F15.14^^102^1356^7
 ;;^UTILITY(U,$J,358.3,27762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27762,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27762,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,27762,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,27763,0)
 ;;=F15.24^^102^1356^8
 ;;^UTILITY(U,$J,358.3,27763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27763,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27763,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,27763,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,27764,0)
 ;;=F15.94^^102^1356^9
 ;;^UTILITY(U,$J,358.3,27764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27764,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Bipolar & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27764,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,27764,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,27765,0)
 ;;=F15.921^^102^1356^10
 ;;^UTILITY(U,$J,358.3,27765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27765,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Delirium
 ;;^UTILITY(U,$J,358.3,27765,1,4,0)
 ;;=4^F15.921
 ;;^UTILITY(U,$J,358.3,27765,2)
 ;;=^5003312
 ;;^UTILITY(U,$J,358.3,27766,0)
 ;;=F15.14^^102^1356^11
 ;;^UTILITY(U,$J,358.3,27766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27766,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27766,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,27766,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,27767,0)
 ;;=F15.24^^102^1356^12
 ;;^UTILITY(U,$J,358.3,27767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27767,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27767,1,4,0)
 ;;=4^F15.24
 ;;^UTILITY(U,$J,358.3,27767,2)
 ;;=^5003302
 ;;^UTILITY(U,$J,358.3,27768,0)
 ;;=F15.94^^102^1356^13
 ;;^UTILITY(U,$J,358.3,27768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27768,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27768,1,4,0)
 ;;=4^F15.94
 ;;^UTILITY(U,$J,358.3,27768,2)
 ;;=^5003316
 ;;^UTILITY(U,$J,358.3,27769,0)
 ;;=F15.188^^102^1356^14
 ;;^UTILITY(U,$J,358.3,27769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27769,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27769,1,4,0)
 ;;=4^F15.188
 ;;^UTILITY(U,$J,358.3,27769,2)
 ;;=^5133355
 ;;^UTILITY(U,$J,358.3,27770,0)
 ;;=F15.288^^102^1356^15
 ;;^UTILITY(U,$J,358.3,27770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27770,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27770,1,4,0)
 ;;=4^F15.288
 ;;^UTILITY(U,$J,358.3,27770,2)
 ;;=^5133356
 ;;^UTILITY(U,$J,358.3,27771,0)
 ;;=F15.988^^102^1356^16
 ;;^UTILITY(U,$J,358.3,27771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27771,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Obess-Compul & Rel D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27771,1,4,0)
 ;;=4^F15.988
 ;;^UTILITY(U,$J,358.3,27771,2)
 ;;=^5133357
 ;;^UTILITY(U,$J,358.3,27772,0)
 ;;=F15.159^^102^1356^17
 ;;^UTILITY(U,$J,358.3,27772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27772,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27772,1,4,0)
 ;;=4^F15.159
 ;;^UTILITY(U,$J,358.3,27772,2)
 ;;=^5003290
 ;;^UTILITY(U,$J,358.3,27773,0)
 ;;=F15.259^^102^1356^18
 ;;^UTILITY(U,$J,358.3,27773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27773,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27773,1,4,0)
 ;;=4^F15.259
 ;;^UTILITY(U,$J,358.3,27773,2)
 ;;=^5003305
 ;;^UTILITY(U,$J,358.3,27774,0)
 ;;=F15.959^^102^1356^19
 ;;^UTILITY(U,$J,358.3,27774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27774,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Psychotic D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27774,1,4,0)
 ;;=4^F15.959
 ;;^UTILITY(U,$J,358.3,27774,2)
 ;;=^5003319
 ;;^UTILITY(U,$J,358.3,27775,0)
 ;;=F15.181^^102^1356^20
 ;;^UTILITY(U,$J,358.3,27775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27775,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27775,1,4,0)
 ;;=4^F15.181
 ;;^UTILITY(U,$J,358.3,27775,2)
 ;;=^5003292
 ;;^UTILITY(U,$J,358.3,27776,0)
 ;;=F15.281^^102^1356^21
 ;;^UTILITY(U,$J,358.3,27776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27776,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,27776,1,4,0)
 ;;=4^F15.281
 ;;^UTILITY(U,$J,358.3,27776,2)
 ;;=^5003307
 ;;^UTILITY(U,$J,358.3,27777,0)
 ;;=F15.981^^102^1356^22
 ;;^UTILITY(U,$J,358.3,27777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27777,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sexual Dysfunction w/o Use D/O
 ;;^UTILITY(U,$J,358.3,27777,1,4,0)
 ;;=4^F15.981
 ;;^UTILITY(U,$J,358.3,27777,2)
 ;;=^5003321
 ;;^UTILITY(U,$J,358.3,27778,0)
 ;;=F15.182^^102^1356^23
 ;;^UTILITY(U,$J,358.3,27778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27778,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,27778,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,27778,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,27779,0)
 ;;=F15.282^^102^1356^24
 ;;^UTILITY(U,$J,358.3,27779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27779,1,3,0)
 ;;=3^Amphetamine/Other Stimulant Induced Sleep D/O w/ Mod-Sev Use D/O
