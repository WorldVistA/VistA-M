IBDEI0PA ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32051,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,32052,0)
 ;;=F31.10^^94^1411^2
 ;;^UTILITY(U,$J,358.3,32052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32052,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unsp
 ;;^UTILITY(U,$J,358.3,32052,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,32052,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,32053,0)
 ;;=F32.9^^94^1411^5
 ;;^UTILITY(U,$J,358.3,32053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32053,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,32053,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,32053,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,32054,0)
 ;;=F20.0^^94^1411^6
 ;;^UTILITY(U,$J,358.3,32054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32054,1,3,0)
 ;;=3^Paranoid schizophrenia
 ;;^UTILITY(U,$J,358.3,32054,1,4,0)
 ;;=4^F20.0
 ;;^UTILITY(U,$J,358.3,32054,2)
 ;;=^5003469
 ;;^UTILITY(U,$J,358.3,32055,0)
 ;;=F06.0^^94^1411^7
 ;;^UTILITY(U,$J,358.3,32055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32055,1,3,0)
 ;;=3^Psychotic disorder w hallucin due to known physiol condition
 ;;^UTILITY(U,$J,358.3,32055,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,32055,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,32056,0)
 ;;=F20.9^^94^1411^8
 ;;^UTILITY(U,$J,358.3,32056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32056,1,3,0)
 ;;=3^Schizophrenia, unspecified
 ;;^UTILITY(U,$J,358.3,32056,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,32056,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,32057,0)
 ;;=F03.91^^94^1411^3
 ;;^UTILITY(U,$J,358.3,32057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32057,1,3,0)
 ;;=3^Dementia with behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,32057,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,32057,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,32058,0)
 ;;=F03.90^^94^1411^4
 ;;^UTILITY(U,$J,358.3,32058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32058,1,3,0)
 ;;=3^Dementia without behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,32058,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,32058,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,32059,0)
 ;;=M76.62^^94^1412^1
 ;;^UTILITY(U,$J,358.3,32059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32059,1,3,0)
 ;;=3^Achilles tendinitis, left leg
 ;;^UTILITY(U,$J,358.3,32059,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,32059,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,32060,0)
 ;;=M76.61^^94^1412^2
 ;;^UTILITY(U,$J,358.3,32060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32060,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,32060,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,32060,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,32061,0)
 ;;=M75.02^^94^1412^3
 ;;^UTILITY(U,$J,358.3,32061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32061,1,3,0)
 ;;=3^Adhesive capsulitis of left shoulder
 ;;^UTILITY(U,$J,358.3,32061,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,32061,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,32062,0)
 ;;=M75.01^^94^1412^4
 ;;^UTILITY(U,$J,358.3,32062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32062,1,3,0)
 ;;=3^Adhesive capsulitis of right shoulder
 ;;^UTILITY(U,$J,358.3,32062,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,32062,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,32063,0)
 ;;=M75.22^^94^1412^5
 ;;^UTILITY(U,$J,358.3,32063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32063,1,3,0)
 ;;=3^Bicipital tendinitis, left shoulder
 ;;^UTILITY(U,$J,358.3,32063,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,32063,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,32064,0)
 ;;=M75.21^^94^1412^6
 ;;^UTILITY(U,$J,358.3,32064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32064,1,3,0)
 ;;=3^Bicipital tendinitis, right shoulder
 ;;^UTILITY(U,$J,358.3,32064,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,32064,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,32065,0)
 ;;=M75.52^^94^1412^7
 ;;^UTILITY(U,$J,358.3,32065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32065,1,3,0)
 ;;=3^Bursitis of left shoulder
 ;;^UTILITY(U,$J,358.3,32065,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,32065,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,32066,0)
 ;;=M75.51^^94^1412^8
 ;;^UTILITY(U,$J,358.3,32066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32066,1,3,0)
 ;;=3^Bursitis of right shoulder
 ;;^UTILITY(U,$J,358.3,32066,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,32066,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,32067,0)
 ;;=M75.32^^94^1412^9
 ;;^UTILITY(U,$J,358.3,32067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32067,1,3,0)
 ;;=3^Calcific tendinitis of left shoulder
 ;;^UTILITY(U,$J,358.3,32067,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,32067,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,32068,0)
 ;;=M75.31^^94^1412^10
 ;;^UTILITY(U,$J,358.3,32068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32068,1,3,0)
 ;;=3^Calcific tendinitis of right shoulder
 ;;^UTILITY(U,$J,358.3,32068,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,32068,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,32069,0)
 ;;=M22.42^^94^1412^11
 ;;^UTILITY(U,$J,358.3,32069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32069,1,3,0)
 ;;=3^Chondromalacia patellae, left knee
 ;;^UTILITY(U,$J,358.3,32069,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,32069,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,32070,0)
 ;;=M22.41^^94^1412^12
 ;;^UTILITY(U,$J,358.3,32070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32070,1,3,0)
 ;;=3^Chondromalacia patellae, right knee
 ;;^UTILITY(U,$J,358.3,32070,1,4,0)
 ;;=4^M22.41
 ;;^UTILITY(U,$J,358.3,32070,2)
 ;;=^5011186
 ;;^UTILITY(U,$J,358.3,32071,0)
 ;;=M23.52^^94^1412^13
 ;;^UTILITY(U,$J,358.3,32071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32071,1,3,0)
 ;;=3^Chronic instability of knee, left knee
 ;;^UTILITY(U,$J,358.3,32071,1,4,0)
 ;;=4^M23.52
 ;;^UTILITY(U,$J,358.3,32071,2)
 ;;=^5011255
 ;;^UTILITY(U,$J,358.3,32072,0)
 ;;=M23.51^^94^1412^14
 ;;^UTILITY(U,$J,358.3,32072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32072,1,3,0)
 ;;=3^Chronic instability of knee, right knee
 ;;^UTILITY(U,$J,358.3,32072,1,4,0)
 ;;=4^M23.51
 ;;^UTILITY(U,$J,358.3,32072,2)
 ;;=^5011254
 ;;^UTILITY(U,$J,358.3,32073,0)
 ;;=T20.40XS^^94^1412^15
 ;;^UTILITY(U,$J,358.3,32073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32073,1,3,0)
 ;;=3^Corros unsp degree of head, face, and neck, unsp site, sqla
 ;;^UTILITY(U,$J,358.3,32073,1,4,0)
 ;;=4^T20.40XS
 ;;^UTILITY(U,$J,358.3,32073,2)
 ;;=^5046773
 ;;^UTILITY(U,$J,358.3,32074,0)
 ;;=M62.9^^94^1412^16
 ;;^UTILITY(U,$J,358.3,32074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32074,1,3,0)
 ;;=3^Disorder of muscle, unspecified
 ;;^UTILITY(U,$J,358.3,32074,1,4,0)
 ;;=4^M62.9
 ;;^UTILITY(U,$J,358.3,32074,2)
 ;;=^5012684
 ;;^UTILITY(U,$J,358.3,32075,0)
 ;;=M25.40^^94^1412^17
 ;;^UTILITY(U,$J,358.3,32075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32075,1,3,0)
 ;;=3^Effusion, unspecified joint
 ;;^UTILITY(U,$J,358.3,32075,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,32075,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,32076,0)
 ;;=M21.42^^94^1412^18
 ;;^UTILITY(U,$J,358.3,32076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32076,1,3,0)
 ;;=3^Flat foot [pes planus] (acquired), left foot
 ;;^UTILITY(U,$J,358.3,32076,1,4,0)
 ;;=4^M21.42
 ;;^UTILITY(U,$J,358.3,32076,2)
 ;;=^5011115
 ;;^UTILITY(U,$J,358.3,32077,0)
 ;;=M21.41^^94^1412^19
 ;;^UTILITY(U,$J,358.3,32077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32077,1,3,0)
 ;;=3^Flat foot [pes planus] (acquired), right foot
 ;;^UTILITY(U,$J,358.3,32077,1,4,0)
 ;;=4^M21.41
 ;;^UTILITY(U,$J,358.3,32077,2)
 ;;=^5011114
 ;;^UTILITY(U,$J,358.3,32078,0)
 ;;=M76.22^^94^1412^20
 ;;^UTILITY(U,$J,358.3,32078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32078,1,3,0)
 ;;=3^Iliac crest spur, left hip
 ;;^UTILITY(U,$J,358.3,32078,1,4,0)
 ;;=4^M76.22
 ;;^UTILITY(U,$J,358.3,32078,2)
 ;;=^5013274
 ;;^UTILITY(U,$J,358.3,32079,0)
 ;;=M76.21^^94^1412^21
 ;;^UTILITY(U,$J,358.3,32079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32079,1,3,0)
 ;;=3^Iliac crest spur, right hip
 ;;^UTILITY(U,$J,358.3,32079,1,4,0)
 ;;=4^M76.21
 ;;^UTILITY(U,$J,358.3,32079,2)
 ;;=^5013273
 ;;^UTILITY(U,$J,358.3,32080,0)
 ;;=M77.12^^94^1412^26
 ;;^UTILITY(U,$J,358.3,32080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32080,1,3,0)
 ;;=3^Lateral epicondylitis, left elbow
 ;;^UTILITY(U,$J,358.3,32080,1,4,0)
 ;;=4^M77.12
 ;;^UTILITY(U,$J,358.3,32080,2)
 ;;=^5013305
 ;;^UTILITY(U,$J,358.3,32081,0)
 ;;=M77.02^^94^1412^28
 ;;^UTILITY(U,$J,358.3,32081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32081,1,3,0)
 ;;=3^Medial epicondylitis, left elbow
 ;;^UTILITY(U,$J,358.3,32081,1,4,0)
 ;;=4^M77.02
 ;;^UTILITY(U,$J,358.3,32081,2)
 ;;=^5013302
 ;;^UTILITY(U,$J,358.3,32082,0)
 ;;=M77.11^^94^1412^27
 ;;^UTILITY(U,$J,358.3,32082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32082,1,3,0)
 ;;=3^Lateral epicondylitis, right elbow
 ;;^UTILITY(U,$J,358.3,32082,1,4,0)
 ;;=4^M77.11
 ;;^UTILITY(U,$J,358.3,32082,2)
 ;;=^5013304
 ;;^UTILITY(U,$J,358.3,32083,0)
 ;;=M25.572^^94^1412^31
 ;;^UTILITY(U,$J,358.3,32083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32083,1,3,0)
 ;;=3^Pain in left ankle & foot joints
 ;;^UTILITY(U,$J,358.3,32083,1,4,0)
 ;;=4^M25.572
 ;;^UTILITY(U,$J,358.3,32083,2)
 ;;=^5011618
 ;;^UTILITY(U,$J,358.3,32084,0)
 ;;=M25.522^^94^1412^32
 ;;^UTILITY(U,$J,358.3,32084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32084,1,3,0)
 ;;=3^Pain in left elbow
 ;;^UTILITY(U,$J,358.3,32084,1,4,0)
 ;;=4^M25.522
 ;;^UTILITY(U,$J,358.3,32084,2)
 ;;=^5011606
 ;;^UTILITY(U,$J,358.3,32085,0)
 ;;=M79.642^^94^1412^33
 ;;^UTILITY(U,$J,358.3,32085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32085,1,3,0)
 ;;=3^Pain in left hand
 ;;^UTILITY(U,$J,358.3,32085,1,4,0)
 ;;=4^M79.642
 ;;^UTILITY(U,$J,358.3,32085,2)
 ;;=^5013339
 ;;^UTILITY(U,$J,358.3,32086,0)
 ;;=M25.552^^94^1412^34
 ;;^UTILITY(U,$J,358.3,32086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32086,1,3,0)
 ;;=3^Pain in left hip
 ;;^UTILITY(U,$J,358.3,32086,1,4,0)
 ;;=4^M25.552
 ;;^UTILITY(U,$J,358.3,32086,2)
 ;;=^5011612
