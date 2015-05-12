IBDEI0H6 ; ; 19-NOV-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23214,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23214,1,4,0)
 ;;=4^424.90
 ;;^UTILITY(U,$J,358.3,23214,1,5,0)
 ;;=5^Valvular Heart Disease
 ;;^UTILITY(U,$J,358.3,23214,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,23215,0)
 ;;=V43.3^^127^1420^77
 ;;^UTILITY(U,$J,358.3,23215,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23215,1,4,0)
 ;;=4^V43.3
 ;;^UTILITY(U,$J,358.3,23215,1,5,0)
 ;;=5^S/P Heart Valve Replacement
 ;;^UTILITY(U,$J,358.3,23215,2)
 ;;=^295440
 ;;^UTILITY(U,$J,358.3,23216,0)
 ;;=401.1^^127^1420^56
 ;;^UTILITY(U,$J,358.3,23216,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23216,1,4,0)
 ;;=4^401.1
 ;;^UTILITY(U,$J,358.3,23216,1,5,0)
 ;;=5^Hypertension, Benign
 ;;^UTILITY(U,$J,358.3,23216,2)
 ;;=^269591
 ;;^UTILITY(U,$J,358.3,23217,0)
 ;;=796.2^^127^1420^30
 ;;^UTILITY(U,$J,358.3,23217,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23217,1,4,0)
 ;;=4^796.2
 ;;^UTILITY(U,$J,358.3,23217,1,5,0)
 ;;=5^Elev BP w/o dx hypertension
 ;;^UTILITY(U,$J,358.3,23217,2)
 ;;=^273464
 ;;^UTILITY(U,$J,358.3,23218,0)
 ;;=402.10^^127^1420^31
 ;;^UTILITY(U,$J,358.3,23218,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23218,1,4,0)
 ;;=4^402.10
 ;;^UTILITY(U,$J,358.3,23218,1,5,0)
 ;;=5^HTN w/ Heart Involvement
 ;;^UTILITY(U,$J,358.3,23218,2)
 ;;=^269598
 ;;^UTILITY(U,$J,358.3,23219,0)
 ;;=402.11^^127^1420^32
 ;;^UTILITY(U,$J,358.3,23219,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23219,1,4,0)
 ;;=4^402.11
 ;;^UTILITY(U,$J,358.3,23219,1,5,0)
 ;;=5^HTN with CHF
 ;;^UTILITY(U,$J,358.3,23219,2)
 ;;=HTN with CHF^269599
 ;;^UTILITY(U,$J,358.3,23220,0)
 ;;=403.11^^127^1420^37
 ;;^UTILITY(U,$J,358.3,23220,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23220,1,4,0)
 ;;=4^403.11
 ;;^UTILITY(U,$J,358.3,23220,1,5,0)
 ;;=5^HTN with Renal Failure
 ;;^UTILITY(U,$J,358.3,23220,2)
 ;;=^269608
 ;;^UTILITY(U,$J,358.3,23221,0)
 ;;=404.10^^127^1420^35
 ;;^UTILITY(U,$J,358.3,23221,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23221,1,4,0)
 ;;=4^404.10
 ;;^UTILITY(U,$J,358.3,23221,1,5,0)
 ;;=5^HTN with Heart & Renal Involvement
 ;;^UTILITY(U,$J,358.3,23221,2)
 ;;=^269618
 ;;^UTILITY(U,$J,358.3,23222,0)
 ;;=404.11^^127^1420^33
 ;;^UTILITY(U,$J,358.3,23222,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23222,1,4,0)
 ;;=4^404.11
 ;;^UTILITY(U,$J,358.3,23222,1,5,0)
 ;;=5^HTN with CHF & Renal Involvement
 ;;^UTILITY(U,$J,358.3,23222,2)
 ;;=^269619
 ;;^UTILITY(U,$J,358.3,23223,0)
 ;;=404.12^^127^1420^36
 ;;^UTILITY(U,$J,358.3,23223,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23223,1,4,0)
 ;;=4^404.12
 ;;^UTILITY(U,$J,358.3,23223,1,5,0)
 ;;=5^HTN with Heart Involvement & Renal Failure
 ;;^UTILITY(U,$J,358.3,23223,2)
 ;;=^269620
 ;;^UTILITY(U,$J,358.3,23224,0)
 ;;=404.13^^127^1420^34
 ;;^UTILITY(U,$J,358.3,23224,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23224,1,4,0)
 ;;=4^404.13
 ;;^UTILITY(U,$J,358.3,23224,1,5,0)
 ;;=5^HTN with CHF & Renal failure
 ;;^UTILITY(U,$J,358.3,23224,2)
 ;;=^269621
 ;;^UTILITY(U,$J,358.3,23225,0)
 ;;=401.9^^127^1420^57
 ;;^UTILITY(U,$J,358.3,23225,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23225,1,4,0)
 ;;=4^401.9
 ;;^UTILITY(U,$J,358.3,23225,1,5,0)
 ;;=5^Hypertension, Essential
 ;;^UTILITY(U,$J,358.3,23225,2)
 ;;=^186630
 ;;^UTILITY(U,$J,358.3,23226,0)
 ;;=272.0^^127^1420^55
 ;;^UTILITY(U,$J,358.3,23226,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23226,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,23226,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,23226,2)
 ;;=^59973
 ;;^UTILITY(U,$J,358.3,23227,0)
 ;;=272.1^^127^1420^58
 ;;^UTILITY(U,$J,358.3,23227,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23227,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,23227,1,5,0)
 ;;=5^Hypertriglyceridemia
 ;;^UTILITY(U,$J,358.3,23227,2)
 ;;=Hypertriglyceridemia^101303
 ;;^UTILITY(U,$J,358.3,23228,0)
 ;;=272.2^^127^1420^63
 ;;^UTILITY(U,$J,358.3,23228,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23228,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,23228,1,5,0)
 ;;=5^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,23228,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,23229,0)
 ;;=396.0^^127^1420^11
 ;;^UTILITY(U,$J,358.3,23229,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23229,1,4,0)
 ;;=4^396.0
 ;;^UTILITY(U,$J,358.3,23229,1,5,0)
 ;;=5^Aortic and Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,23229,2)
 ;;=Aortic and Mitral Stenosis^269580
 ;;^UTILITY(U,$J,358.3,23230,0)
 ;;=414.02^^127^1420^18
 ;;^UTILITY(U,$J,358.3,23230,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23230,1,4,0)
 ;;=4^414.02
 ;;^UTILITY(U,$J,358.3,23230,1,5,0)
 ;;=5^CAD, Occlusion of Venous Graft
 ;;^UTILITY(U,$J,358.3,23230,2)
 ;;=CAD, Occlusion of Venous Graft^303282
 ;;^UTILITY(U,$J,358.3,23231,0)
 ;;=459.10^^127^1420^73
 ;;^UTILITY(U,$J,358.3,23231,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23231,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,23231,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,23231,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,23232,0)
 ;;=428.20^^127^1420^50
 ;;^UTILITY(U,$J,358.3,23232,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23232,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,23232,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,23232,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,23233,0)
 ;;=428.21^^127^1420^42
 ;;^UTILITY(U,$J,358.3,23233,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23233,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,23233,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,23233,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,23234,0)
 ;;=428.22^^127^1420^44
 ;;^UTILITY(U,$J,358.3,23234,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23234,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,23234,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,23234,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,23235,0)
 ;;=428.23^^127^1420^49
 ;;^UTILITY(U,$J,358.3,23235,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23235,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,23235,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,23235,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,23236,0)
 ;;=428.30^^127^1420^45
 ;;^UTILITY(U,$J,358.3,23236,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23236,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,23236,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,23236,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,23237,0)
 ;;=428.31^^127^1420^41
 ;;^UTILITY(U,$J,358.3,23237,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23237,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,23237,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,23237,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,23238,0)
 ;;=428.32^^127^1420^43
 ;;^UTILITY(U,$J,358.3,23238,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23238,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,23238,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,23238,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,23239,0)
 ;;=428.33^^127^1420^47
 ;;^UTILITY(U,$J,358.3,23239,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23239,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,23239,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,23239,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,23240,0)
 ;;=428.40^^127^1420^46
 ;;^UTILITY(U,$J,358.3,23240,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23240,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,23240,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,23240,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,23241,0)
 ;;=428.41^^127^1420^48
 ;;^UTILITY(U,$J,358.3,23241,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23241,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,23241,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,23241,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,23242,0)
 ;;=428.42^^127^1420^52
 ;;^UTILITY(U,$J,358.3,23242,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23242,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,23242,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,23242,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,23243,0)
 ;;=428.43^^127^1420^51
 ;;^UTILITY(U,$J,358.3,23243,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23243,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,23243,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,23243,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,23244,0)
 ;;=396.3^^127^1420^10
 ;;^UTILITY(U,$J,358.3,23244,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23244,1,4,0)
 ;;=4^396.3
 ;;^UTILITY(U,$J,358.3,23244,1,5,0)
 ;;=5^Aortic and Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,23244,2)
 ;;=Aortic and Mitral Insufficiency^269583
 ;;^UTILITY(U,$J,358.3,23245,0)
 ;;=429.9^^127^1420^28
 ;;^UTILITY(U,$J,358.3,23245,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23245,1,4,0)
 ;;=4^429.9
 ;;^UTILITY(U,$J,358.3,23245,1,5,0)
 ;;=5^Diastolic Dysfunction
 ;;^UTILITY(U,$J,358.3,23245,2)
 ;;=^54741
 ;;^UTILITY(U,$J,358.3,23246,0)
 ;;=453.79^^127^1420^27
 ;;^UTILITY(U,$J,358.3,23246,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23246,1,4,0)
 ;;=4^453.79
 ;;^UTILITY(U,$J,358.3,23246,1,5,0)
 ;;=5^Chr Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,23246,2)
 ;;=^338251
 ;;^UTILITY(U,$J,358.3,23247,0)
 ;;=453.89^^127^1420^1
 ;;^UTILITY(U,$J,358.3,23247,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23247,1,4,0)
 ;;=4^453.89
 ;;^UTILITY(U,$J,358.3,23247,1,5,0)
 ;;=5^AC Venous Emblsm Oth Spec Veins
 ;;^UTILITY(U,$J,358.3,23247,2)
 ;;=^338259
 ;;^UTILITY(U,$J,358.3,23248,0)
 ;;=454.2^^127^1420^85
 ;;^UTILITY(U,$J,358.3,23248,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23248,1,4,0)
 ;;=4^454.2
