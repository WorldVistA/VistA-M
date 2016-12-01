IBDEI0CF ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15736,1,3,0)
 ;;=3^Thrombosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,15736,1,4,0)
 ;;=4^T84.86XD
 ;;^UTILITY(U,$J,358.3,15736,2)
 ;;=^5055470
 ;;^UTILITY(U,$J,358.3,15737,0)
 ;;=T84.86XS^^47^705^19
 ;;^UTILITY(U,$J,358.3,15737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15737,1,3,0)
 ;;=3^Thrombosis due to internal orth prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,15737,1,4,0)
 ;;=4^T84.86XS
 ;;^UTILITY(U,$J,358.3,15737,2)
 ;;=^5055471
 ;;^UTILITY(U,$J,358.3,15738,0)
 ;;=M76.62^^47^706^1
 ;;^UTILITY(U,$J,358.3,15738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15738,1,3,0)
 ;;=3^Achilles tendinitis, left leg
 ;;^UTILITY(U,$J,358.3,15738,1,4,0)
 ;;=4^M76.62
 ;;^UTILITY(U,$J,358.3,15738,2)
 ;;=^5013286
 ;;^UTILITY(U,$J,358.3,15739,0)
 ;;=M76.61^^47^706^2
 ;;^UTILITY(U,$J,358.3,15739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15739,1,3,0)
 ;;=3^Achilles tendinitis, right leg
 ;;^UTILITY(U,$J,358.3,15739,1,4,0)
 ;;=4^M76.61
 ;;^UTILITY(U,$J,358.3,15739,2)
 ;;=^5013285
 ;;^UTILITY(U,$J,358.3,15740,0)
 ;;=M75.02^^47^706^3
 ;;^UTILITY(U,$J,358.3,15740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15740,1,3,0)
 ;;=3^Adhesive capsulitis of left shoulder
 ;;^UTILITY(U,$J,358.3,15740,1,4,0)
 ;;=4^M75.02
 ;;^UTILITY(U,$J,358.3,15740,2)
 ;;=^5013240
 ;;^UTILITY(U,$J,358.3,15741,0)
 ;;=M75.01^^47^706^4
 ;;^UTILITY(U,$J,358.3,15741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15741,1,3,0)
 ;;=3^Adhesive capsulitis of right shoulder
 ;;^UTILITY(U,$J,358.3,15741,1,4,0)
 ;;=4^M75.01
 ;;^UTILITY(U,$J,358.3,15741,2)
 ;;=^5013239
 ;;^UTILITY(U,$J,358.3,15742,0)
 ;;=M81.0^^47^706^5
 ;;^UTILITY(U,$J,358.3,15742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15742,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,15742,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,15742,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,15743,0)
 ;;=M75.22^^47^706^6
 ;;^UTILITY(U,$J,358.3,15743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15743,1,3,0)
 ;;=3^Bicipital tendinitis, left shoulder
 ;;^UTILITY(U,$J,358.3,15743,1,4,0)
 ;;=4^M75.22
 ;;^UTILITY(U,$J,358.3,15743,2)
 ;;=^5013252
 ;;^UTILITY(U,$J,358.3,15744,0)
 ;;=M75.21^^47^706^7
 ;;^UTILITY(U,$J,358.3,15744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15744,1,3,0)
 ;;=3^Bicipital tendinitis, right shoulder
 ;;^UTILITY(U,$J,358.3,15744,1,4,0)
 ;;=4^M75.21
 ;;^UTILITY(U,$J,358.3,15744,2)
 ;;=^5013251
 ;;^UTILITY(U,$J,358.3,15745,0)
 ;;=M17.0^^47^706^8
 ;;^UTILITY(U,$J,358.3,15745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15745,1,3,0)
 ;;=3^Bilateral primary osteoarthritis of knee
 ;;^UTILITY(U,$J,358.3,15745,1,4,0)
 ;;=4^M17.0
 ;;^UTILITY(U,$J,358.3,15745,2)
 ;;=^5010784
 ;;^UTILITY(U,$J,358.3,15746,0)
 ;;=M75.52^^47^706^9
 ;;^UTILITY(U,$J,358.3,15746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15746,1,3,0)
 ;;=3^Bursitis of left shoulder
 ;;^UTILITY(U,$J,358.3,15746,1,4,0)
 ;;=4^M75.52
 ;;^UTILITY(U,$J,358.3,15746,2)
 ;;=^5133691
 ;;^UTILITY(U,$J,358.3,15747,0)
 ;;=M75.51^^47^706^10
 ;;^UTILITY(U,$J,358.3,15747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15747,1,3,0)
 ;;=3^Bursitis of right shoulder
 ;;^UTILITY(U,$J,358.3,15747,1,4,0)
 ;;=4^M75.51
 ;;^UTILITY(U,$J,358.3,15747,2)
 ;;=^5133690
 ;;^UTILITY(U,$J,358.3,15748,0)
 ;;=M75.32^^47^706^11
 ;;^UTILITY(U,$J,358.3,15748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15748,1,3,0)
 ;;=3^Calcific tendinitis of left shoulder
 ;;^UTILITY(U,$J,358.3,15748,1,4,0)
 ;;=4^M75.32
 ;;^UTILITY(U,$J,358.3,15748,2)
 ;;=^5013255
 ;;^UTILITY(U,$J,358.3,15749,0)
 ;;=M75.31^^47^706^12
 ;;^UTILITY(U,$J,358.3,15749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15749,1,3,0)
 ;;=3^Calcific tendinitis of right shoulder
 ;;^UTILITY(U,$J,358.3,15749,1,4,0)
 ;;=4^M75.31
 ;;^UTILITY(U,$J,358.3,15749,2)
 ;;=^5013254
 ;;^UTILITY(U,$J,358.3,15750,0)
 ;;=M22.42^^47^706^13
 ;;^UTILITY(U,$J,358.3,15750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15750,1,3,0)
 ;;=3^Chondromalacia patellae, left knee
 ;;^UTILITY(U,$J,358.3,15750,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,15750,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,15751,0)
 ;;=M22.41^^47^706^14
 ;;^UTILITY(U,$J,358.3,15751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15751,1,3,0)
 ;;=3^Chondromalacia patellae, right knee
 ;;^UTILITY(U,$J,358.3,15751,1,4,0)
 ;;=4^M22.41
 ;;^UTILITY(U,$J,358.3,15751,2)
 ;;=^5011186
 ;;^UTILITY(U,$J,358.3,15752,0)
 ;;=M62.472^^47^706^15
 ;;^UTILITY(U,$J,358.3,15752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15752,1,3,0)
 ;;=3^Contracture of muscle, left ankle and foot
 ;;^UTILITY(U,$J,358.3,15752,1,4,0)
 ;;=4^M62.472
 ;;^UTILITY(U,$J,358.3,15752,2)
 ;;=^5012651
 ;;^UTILITY(U,$J,358.3,15753,0)
 ;;=M62.432^^47^706^16
 ;;^UTILITY(U,$J,358.3,15753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15753,1,3,0)
 ;;=3^Contracture of muscle, left forearm
 ;;^UTILITY(U,$J,358.3,15753,1,4,0)
 ;;=4^M62.432
 ;;^UTILITY(U,$J,358.3,15753,2)
 ;;=^5012639
 ;;^UTILITY(U,$J,358.3,15754,0)
 ;;=M62.442^^47^706^17
 ;;^UTILITY(U,$J,358.3,15754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15754,1,3,0)
 ;;=3^Contracture of muscle, left hand
 ;;^UTILITY(U,$J,358.3,15754,1,4,0)
 ;;=4^M62.442
 ;;^UTILITY(U,$J,358.3,15754,2)
 ;;=^5012642
 ;;^UTILITY(U,$J,358.3,15755,0)
 ;;=M62.462^^47^706^18
 ;;^UTILITY(U,$J,358.3,15755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15755,1,3,0)
 ;;=3^Contracture of muscle, left lower leg
 ;;^UTILITY(U,$J,358.3,15755,1,4,0)
 ;;=4^M62.462
 ;;^UTILITY(U,$J,358.3,15755,2)
 ;;=^5012648
 ;;^UTILITY(U,$J,358.3,15756,0)
 ;;=M62.412^^47^706^19
 ;;^UTILITY(U,$J,358.3,15756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15756,1,3,0)
 ;;=3^Contracture of muscle, left shoulder
 ;;^UTILITY(U,$J,358.3,15756,1,4,0)
 ;;=4^M62.412
 ;;^UTILITY(U,$J,358.3,15756,2)
 ;;=^5012633
 ;;^UTILITY(U,$J,358.3,15757,0)
 ;;=M62.452^^47^706^20
 ;;^UTILITY(U,$J,358.3,15757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15757,1,3,0)
 ;;=3^Contracture of muscle, left thigh
 ;;^UTILITY(U,$J,358.3,15757,1,4,0)
 ;;=4^M62.452
 ;;^UTILITY(U,$J,358.3,15757,2)
 ;;=^5012645
 ;;^UTILITY(U,$J,358.3,15758,0)
 ;;=M62.422^^47^706^21
 ;;^UTILITY(U,$J,358.3,15758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15758,1,3,0)
 ;;=3^Contracture of muscle, left upper arm
 ;;^UTILITY(U,$J,358.3,15758,1,4,0)
 ;;=4^M62.422
 ;;^UTILITY(U,$J,358.3,15758,2)
 ;;=^5012636
 ;;^UTILITY(U,$J,358.3,15759,0)
 ;;=M62.49^^47^706^22
 ;;^UTILITY(U,$J,358.3,15759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15759,1,3,0)
 ;;=3^Contracture of muscle, multiple sites
 ;;^UTILITY(U,$J,358.3,15759,1,4,0)
 ;;=4^M62.49
 ;;^UTILITY(U,$J,358.3,15759,2)
 ;;=^5012654
 ;;^UTILITY(U,$J,358.3,15760,0)
 ;;=M62.48^^47^706^23
 ;;^UTILITY(U,$J,358.3,15760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15760,1,3,0)
 ;;=3^Contracture of muscle, other site
 ;;^UTILITY(U,$J,358.3,15760,1,4,0)
 ;;=4^M62.48
 ;;^UTILITY(U,$J,358.3,15760,2)
 ;;=^5012653
 ;;^UTILITY(U,$J,358.3,15761,0)
 ;;=M62.471^^47^706^24
 ;;^UTILITY(U,$J,358.3,15761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15761,1,3,0)
 ;;=3^Contracture of muscle, right ankle and foot
 ;;^UTILITY(U,$J,358.3,15761,1,4,0)
 ;;=4^M62.471
 ;;^UTILITY(U,$J,358.3,15761,2)
 ;;=^5012650
 ;;^UTILITY(U,$J,358.3,15762,0)
 ;;=M62.431^^47^706^25
 ;;^UTILITY(U,$J,358.3,15762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15762,1,3,0)
 ;;=3^Contracture of muscle, right forearm
 ;;^UTILITY(U,$J,358.3,15762,1,4,0)
 ;;=4^M62.431
 ;;^UTILITY(U,$J,358.3,15762,2)
 ;;=^5012638
 ;;^UTILITY(U,$J,358.3,15763,0)
 ;;=M62.441^^47^706^26
 ;;^UTILITY(U,$J,358.3,15763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15763,1,3,0)
 ;;=3^Contracture of muscle, right hand
 ;;^UTILITY(U,$J,358.3,15763,1,4,0)
 ;;=4^M62.441
 ;;^UTILITY(U,$J,358.3,15763,2)
 ;;=^5012641
 ;;^UTILITY(U,$J,358.3,15764,0)
 ;;=M62.461^^47^706^27
 ;;^UTILITY(U,$J,358.3,15764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15764,1,3,0)
 ;;=3^Contracture of muscle, right lower leg
 ;;^UTILITY(U,$J,358.3,15764,1,4,0)
 ;;=4^M62.461
 ;;^UTILITY(U,$J,358.3,15764,2)
 ;;=^5012647
 ;;^UTILITY(U,$J,358.3,15765,0)
 ;;=M62.411^^47^706^28
 ;;^UTILITY(U,$J,358.3,15765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15765,1,3,0)
 ;;=3^Contracture of muscle, right shoulder
 ;;^UTILITY(U,$J,358.3,15765,1,4,0)
 ;;=4^M62.411
 ;;^UTILITY(U,$J,358.3,15765,2)
 ;;=^5012632
 ;;^UTILITY(U,$J,358.3,15766,0)
 ;;=M62.451^^47^706^29
 ;;^UTILITY(U,$J,358.3,15766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15766,1,3,0)
 ;;=3^Contracture of muscle, right thigh
 ;;^UTILITY(U,$J,358.3,15766,1,4,0)
 ;;=4^M62.451
 ;;^UTILITY(U,$J,358.3,15766,2)
 ;;=^5012644
 ;;^UTILITY(U,$J,358.3,15767,0)
 ;;=M62.421^^47^706^30
 ;;^UTILITY(U,$J,358.3,15767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15767,1,3,0)
 ;;=3^Contracture of muscle, right upper arm
 ;;^UTILITY(U,$J,358.3,15767,1,4,0)
 ;;=4^M62.421
 ;;^UTILITY(U,$J,358.3,15767,2)
 ;;=^5012635
 ;;^UTILITY(U,$J,358.3,15768,0)
 ;;=M25.262^^47^706^31
 ;;^UTILITY(U,$J,358.3,15768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15768,1,3,0)
 ;;=3^Flail joint, left knee
 ;;^UTILITY(U,$J,358.3,15768,1,4,0)
 ;;=4^M25.262
 ;;^UTILITY(U,$J,358.3,15768,2)
 ;;=^5011544
 ;;^UTILITY(U,$J,358.3,15769,0)
 ;;=M25.212^^47^706^32
 ;;^UTILITY(U,$J,358.3,15769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15769,1,3,0)
 ;;=3^Flail joint, left shoulder
 ;;^UTILITY(U,$J,358.3,15769,1,4,0)
 ;;=4^M25.212
 ;;^UTILITY(U,$J,358.3,15769,2)
 ;;=^5011529
 ;;^UTILITY(U,$J,358.3,15770,0)
 ;;=M25.261^^47^706^33
 ;;^UTILITY(U,$J,358.3,15770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15770,1,3,0)
 ;;=3^Flail joint, right knee
 ;;^UTILITY(U,$J,358.3,15770,1,4,0)
 ;;=4^M25.261
 ;;^UTILITY(U,$J,358.3,15770,2)
 ;;=^5011543
 ;;^UTILITY(U,$J,358.3,15771,0)
 ;;=M25.211^^47^706^34
 ;;^UTILITY(U,$J,358.3,15771,1,0)
 ;;=^358.31IA^4^2
