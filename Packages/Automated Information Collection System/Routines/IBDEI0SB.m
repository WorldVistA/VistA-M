IBDEI0SB ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37392,0)
 ;;=T84.84XD^^106^1589^14
 ;;^UTILITY(U,$J,358.3,37392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37392,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,37392,1,4,0)
 ;;=4^T84.84XD
 ;;^UTILITY(U,$J,358.3,37392,2)
 ;;=^5055464
 ;;^UTILITY(U,$J,358.3,37393,0)
 ;;=T84.84XS^^106^1589^15
 ;;^UTILITY(U,$J,358.3,37393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37393,1,3,0)
 ;;=3^Pain due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,37393,1,4,0)
 ;;=4^T84.84XS
 ;;^UTILITY(U,$J,358.3,37393,2)
 ;;=^5055465
 ;;^UTILITY(U,$J,358.3,37394,0)
 ;;=T84.85XA^^106^1589^16
 ;;^UTILITY(U,$J,358.3,37394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37394,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,37394,1,4,0)
 ;;=4^T84.85XA
 ;;^UTILITY(U,$J,358.3,37394,2)
 ;;=^5055466
 ;;^UTILITY(U,$J,358.3,37395,0)
 ;;=T84.85XD^^106^1589^17
 ;;^UTILITY(U,$J,358.3,37395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37395,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,37395,1,4,0)
 ;;=4^T84.85XD
 ;;^UTILITY(U,$J,358.3,37395,2)
 ;;=^5055467
 ;;^UTILITY(U,$J,358.3,37396,0)
 ;;=T84.85XS^^106^1589^18
 ;;^UTILITY(U,$J,358.3,37396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37396,1,3,0)
 ;;=3^Stenosis due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,37396,1,4,0)
 ;;=4^T84.85XS
 ;;^UTILITY(U,$J,358.3,37396,2)
 ;;=^5055468
 ;;^UTILITY(U,$J,358.3,37397,0)
 ;;=T84.86XA^^106^1589^20
 ;;^UTILITY(U,$J,358.3,37397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37397,1,3,0)
 ;;=3^Thrombosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,37397,1,4,0)
 ;;=4^T84.86XA
 ;;^UTILITY(U,$J,358.3,37397,2)
 ;;=^5055469
 ;;^UTILITY(U,$J,358.3,37398,0)
 ;;=T84.86XD^^106^1589^21
 ;;^UTILITY(U,$J,358.3,37398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37398,1,3,0)
 ;;=3^Thrombosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,37398,1,4,0)
 ;;=4^T84.86XD
 ;;^UTILITY(U,$J,358.3,37398,2)
 ;;=^5055470
 ;;^UTILITY(U,$J,358.3,37399,0)
 ;;=T84.86XS^^106^1589^19
 ;;^UTILITY(U,$J,358.3,37399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37399,1,3,0)
 ;;=3^Thrombosis due to internal orth prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,37399,1,4,0)
 ;;=4^T84.86XS
 ;;^UTILITY(U,$J,358.3,37399,2)
 ;;=^5055471
 ;;^UTILITY(U,$J,358.3,37400,0)
 ;;=M76.62^^106^1590^1
 ;;^UTILITY(U,$J,358.3,37400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37400,1,3,0)
 ;;=3^Achilles tendinitis, left leg
 ;;^UTILITY(U,$J,358.3,37400,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,37400,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,37401,0)
 ;;=M76.61^^106^1590^2
 ;;^UTILITY(U,$J,358.3,37401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37401,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,37401,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,37401,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,37402,0)
 ;;=M75.02^^106^1590^3
 ;;^UTILITY(U,$J,358.3,37402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37402,1,3,0)
 ;;=3^Adhesive capsulitis of left shoulder
 ;;^UTILITY(U,$J,358.3,37402,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,37402,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,37403,0)
 ;;=M75.01^^106^1590^4
 ;;^UTILITY(U,$J,358.3,37403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37403,1,3,0)
 ;;=3^Adhesive capsulitis of right shoulder
 ;;^UTILITY(U,$J,358.3,37403,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,37403,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,37404,0)
 ;;=M81.0^^106^1590^5
 ;;^UTILITY(U,$J,358.3,37404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37404,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,37404,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,37404,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,37405,0)
 ;;=M75.22^^106^1590^6
 ;;^UTILITY(U,$J,358.3,37405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37405,1,3,0)
 ;;=3^Bicipital tendinitis, left shoulder
 ;;^UTILITY(U,$J,358.3,37405,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,37405,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,37406,0)
 ;;=M75.21^^106^1590^7
 ;;^UTILITY(U,$J,358.3,37406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37406,1,3,0)
 ;;=3^Bicipital tendinitis, right shoulder
 ;;^UTILITY(U,$J,358.3,37406,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,37406,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,37407,0)
 ;;=M17.0^^106^1590^8
 ;;^UTILITY(U,$J,358.3,37407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37407,1,3,0)
 ;;=3^Bilateral primary osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,37407,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,37407,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,37408,0)
 ;;=M75.52^^106^1590^9
 ;;^UTILITY(U,$J,358.3,37408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37408,1,3,0)
 ;;=3^Bursitis of left shoulder
 ;;^UTILITY(U,$J,358.3,37408,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,37408,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,37409,0)
 ;;=M75.51^^106^1590^10
 ;;^UTILITY(U,$J,358.3,37409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37409,1,3,0)
 ;;=3^Bursitis of right shoulder
 ;;^UTILITY(U,$J,358.3,37409,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,37409,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,37410,0)
 ;;=M75.32^^106^1590^11
 ;;^UTILITY(U,$J,358.3,37410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37410,1,3,0)
 ;;=3^Calcific tendinitis of left shoulder
 ;;^UTILITY(U,$J,358.3,37410,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,37410,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,37411,0)
 ;;=M75.31^^106^1590^12
 ;;^UTILITY(U,$J,358.3,37411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37411,1,3,0)
 ;;=3^Calcific tendinitis of right shoulder
 ;;^UTILITY(U,$J,358.3,37411,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,37411,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,37412,0)
 ;;=M22.42^^106^1590^13
 ;;^UTILITY(U,$J,358.3,37412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37412,1,3,0)
 ;;=3^Chondromalacia patellae, left knee
 ;;^UTILITY(U,$J,358.3,37412,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,37412,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,37413,0)
 ;;=M22.41^^106^1590^14
 ;;^UTILITY(U,$J,358.3,37413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37413,1,3,0)
 ;;=3^Chondromalacia patellae, right knee
 ;;^UTILITY(U,$J,358.3,37413,1,4,0)
 ;;=4^M22.41
 ;;^UTILITY(U,$J,358.3,37413,2)
 ;;=^5011186
 ;;^UTILITY(U,$J,358.3,37414,0)
 ;;=M62.472^^106^1590^15
 ;;^UTILITY(U,$J,358.3,37414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37414,1,3,0)
 ;;=3^Contracture of muscle, left ankle and foot
 ;;^UTILITY(U,$J,358.3,37414,1,4,0)
 ;;=4^M62.472
 ;;^UTILITY(U,$J,358.3,37414,2)
 ;;=^5012651
 ;;^UTILITY(U,$J,358.3,37415,0)
 ;;=M62.432^^106^1590^16
 ;;^UTILITY(U,$J,358.3,37415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37415,1,3,0)
 ;;=3^Contracture of muscle, left forearm
 ;;^UTILITY(U,$J,358.3,37415,1,4,0)
 ;;=4^M62.432
 ;;^UTILITY(U,$J,358.3,37415,2)
 ;;=^5012639
 ;;^UTILITY(U,$J,358.3,37416,0)
 ;;=M62.442^^106^1590^17
 ;;^UTILITY(U,$J,358.3,37416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37416,1,3,0)
 ;;=3^Contracture of muscle, left hand
 ;;^UTILITY(U,$J,358.3,37416,1,4,0)
 ;;=4^M62.442
 ;;^UTILITY(U,$J,358.3,37416,2)
 ;;=^5012642
 ;;^UTILITY(U,$J,358.3,37417,0)
 ;;=M62.462^^106^1590^18
 ;;^UTILITY(U,$J,358.3,37417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37417,1,3,0)
 ;;=3^Contracture of muscle, left lower leg
 ;;^UTILITY(U,$J,358.3,37417,1,4,0)
 ;;=4^M62.462
 ;;^UTILITY(U,$J,358.3,37417,2)
 ;;=^5012648
 ;;^UTILITY(U,$J,358.3,37418,0)
 ;;=M62.412^^106^1590^19
 ;;^UTILITY(U,$J,358.3,37418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37418,1,3,0)
 ;;=3^Contracture of muscle, left shoulder
 ;;^UTILITY(U,$J,358.3,37418,1,4,0)
 ;;=4^M62.412
 ;;^UTILITY(U,$J,358.3,37418,2)
 ;;=^5012633
 ;;^UTILITY(U,$J,358.3,37419,0)
 ;;=M62.452^^106^1590^20
 ;;^UTILITY(U,$J,358.3,37419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37419,1,3,0)
 ;;=3^Contracture of muscle, left thigh
 ;;^UTILITY(U,$J,358.3,37419,1,4,0)
 ;;=4^M62.452
 ;;^UTILITY(U,$J,358.3,37419,2)
 ;;=^5012645
 ;;^UTILITY(U,$J,358.3,37420,0)
 ;;=M62.422^^106^1590^21
 ;;^UTILITY(U,$J,358.3,37420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37420,1,3,0)
 ;;=3^Contracture of muscle, left upper arm
 ;;^UTILITY(U,$J,358.3,37420,1,4,0)
 ;;=4^M62.422
 ;;^UTILITY(U,$J,358.3,37420,2)
 ;;=^5012636
 ;;^UTILITY(U,$J,358.3,37421,0)
 ;;=M62.49^^106^1590^22
 ;;^UTILITY(U,$J,358.3,37421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37421,1,3,0)
 ;;=3^Contracture of muscle, multiple sites
 ;;^UTILITY(U,$J,358.3,37421,1,4,0)
 ;;=4^M62.49
 ;;^UTILITY(U,$J,358.3,37421,2)
 ;;=^5012654
 ;;^UTILITY(U,$J,358.3,37422,0)
 ;;=M62.48^^106^1590^23
 ;;^UTILITY(U,$J,358.3,37422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37422,1,3,0)
 ;;=3^Contracture of muscle, other site
 ;;^UTILITY(U,$J,358.3,37422,1,4,0)
 ;;=4^M62.48
 ;;^UTILITY(U,$J,358.3,37422,2)
 ;;=^5012653
 ;;^UTILITY(U,$J,358.3,37423,0)
 ;;=M62.471^^106^1590^24
 ;;^UTILITY(U,$J,358.3,37423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37423,1,3,0)
 ;;=3^Contracture of muscle, right ankle and foot
 ;;^UTILITY(U,$J,358.3,37423,1,4,0)
 ;;=4^M62.471
 ;;^UTILITY(U,$J,358.3,37423,2)
 ;;=^5012650
 ;;^UTILITY(U,$J,358.3,37424,0)
 ;;=M62.431^^106^1590^25
 ;;^UTILITY(U,$J,358.3,37424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37424,1,3,0)
 ;;=3^Contracture of muscle, right forearm
 ;;^UTILITY(U,$J,358.3,37424,1,4,0)
 ;;=4^M62.431
 ;;^UTILITY(U,$J,358.3,37424,2)
 ;;=^5012638
 ;;^UTILITY(U,$J,358.3,37425,0)
 ;;=M62.441^^106^1590^26
 ;;^UTILITY(U,$J,358.3,37425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37425,1,3,0)
 ;;=3^Contracture of muscle, right hand
 ;;^UTILITY(U,$J,358.3,37425,1,4,0)
 ;;=4^M62.441
 ;;^UTILITY(U,$J,358.3,37425,2)
 ;;=^5012641
 ;;^UTILITY(U,$J,358.3,37426,0)
 ;;=M62.461^^106^1590^27
