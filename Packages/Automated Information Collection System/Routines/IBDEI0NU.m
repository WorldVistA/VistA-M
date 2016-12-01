IBDEI0NU ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30233,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right knee prosth, init
 ;;^UTILITY(U,$J,358.3,30233,1,4,0)
 ;;=4^T84.53XA
 ;;^UTILITY(U,$J,358.3,30233,2)
 ;;=^5055391
 ;;^UTILITY(U,$J,358.3,30234,0)
 ;;=T84.59XA^^86^1303^31
 ;;^UTILITY(U,$J,358.3,30234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30234,1,3,0)
 ;;=3^Infect/inflm reaction d/t oth internal joint prosth, init
 ;;^UTILITY(U,$J,358.3,30234,1,4,0)
 ;;=4^T84.59XA
 ;;^UTILITY(U,$J,358.3,30234,2)
 ;;=^5055397
 ;;^UTILITY(U,$J,358.3,30235,0)
 ;;=M79.1^^86^1303^33
 ;;^UTILITY(U,$J,358.3,30235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30235,1,3,0)
 ;;=3^Myalgia
 ;;^UTILITY(U,$J,358.3,30235,1,4,0)
 ;;=4^M79.1
 ;;^UTILITY(U,$J,358.3,30235,2)
 ;;=^5013321
 ;;^UTILITY(U,$J,358.3,30236,0)
 ;;=M93.272^^86^1303^36
 ;;^UTILITY(U,$J,358.3,30236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30236,1,3,0)
 ;;=3^Osteochondritis dissecans, l ankle and joints of left foot
 ;;^UTILITY(U,$J,358.3,30236,1,4,0)
 ;;=4^M93.272
 ;;^UTILITY(U,$J,358.3,30236,2)
 ;;=^5015275
 ;;^UTILITY(U,$J,358.3,30237,0)
 ;;=M93.271^^86^1303^42
 ;;^UTILITY(U,$J,358.3,30237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30237,1,3,0)
 ;;=3^Osteochondritis dissecans, right ankle & joints of right foot
 ;;^UTILITY(U,$J,358.3,30237,1,4,0)
 ;;=4^M93.271
 ;;^UTILITY(U,$J,358.3,30237,2)
 ;;=^5015274
 ;;^UTILITY(U,$J,358.3,30238,0)
 ;;=C79.51^^86^1303^52
 ;;^UTILITY(U,$J,358.3,30238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30238,1,3,0)
 ;;=3^Secondary malignant neoplasm of bone
 ;;^UTILITY(U,$J,358.3,30238,1,4,0)
 ;;=4^C79.51
 ;;^UTILITY(U,$J,358.3,30238,2)
 ;;=^5001350
 ;;^UTILITY(U,$J,358.3,30239,0)
 ;;=L40.51^^86^1303^2
 ;;^UTILITY(U,$J,358.3,30239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30239,1,3,0)
 ;;=3^Arthropathic psoriasis, distal interphalangeal
 ;;^UTILITY(U,$J,358.3,30239,1,4,0)
 ;;=4^L40.51
 ;;^UTILITY(U,$J,358.3,30239,2)
 ;;=^5009166
 ;;^UTILITY(U,$J,358.3,30240,0)
 ;;=L40.52^^86^1303^48
 ;;^UTILITY(U,$J,358.3,30240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30240,1,3,0)
 ;;=3^Psoriatic arthritis mutilans
 ;;^UTILITY(U,$J,358.3,30240,1,4,0)
 ;;=4^L40.52
 ;;^UTILITY(U,$J,358.3,30240,2)
 ;;=^5009167
 ;;^UTILITY(U,$J,358.3,30241,0)
 ;;=L40.53^^86^1303^51
 ;;^UTILITY(U,$J,358.3,30241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30241,1,3,0)
 ;;=3^Psoriatic spondylitis
 ;;^UTILITY(U,$J,358.3,30241,1,4,0)
 ;;=4^L40.53
 ;;^UTILITY(U,$J,358.3,30241,2)
 ;;=^5009168
 ;;^UTILITY(U,$J,358.3,30242,0)
 ;;=L40.54^^86^1303^50
 ;;^UTILITY(U,$J,358.3,30242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30242,1,3,0)
 ;;=3^Psoriatic juvenile arthropathy
 ;;^UTILITY(U,$J,358.3,30242,1,4,0)
 ;;=4^L40.54
 ;;^UTILITY(U,$J,358.3,30242,2)
 ;;=^5009169
 ;;^UTILITY(U,$J,358.3,30243,0)
 ;;=L40.59^^86^1303^49
 ;;^UTILITY(U,$J,358.3,30243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30243,1,3,0)
 ;;=3^Psoriatic arthropathy, other
 ;;^UTILITY(U,$J,358.3,30243,1,4,0)
 ;;=4^L40.59
 ;;^UTILITY(U,$J,358.3,30243,2)
 ;;=^5009170
 ;;^UTILITY(U,$J,358.3,30244,0)
 ;;=T79.A11A^^86^1303^12
 ;;^UTILITY(U,$J,358.3,30244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30244,1,3,0)
 ;;=3^Compartment syndrome of right upper extrem, init encntr
 ;;^UTILITY(U,$J,358.3,30244,1,4,0)
 ;;=4^T79.A11A
 ;;^UTILITY(U,$J,358.3,30244,2)
 ;;=^5054326
 ;;^UTILITY(U,$J,358.3,30245,0)
 ;;=T79.A11D^^86^1303^13
 ;;^UTILITY(U,$J,358.3,30245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30245,1,3,0)
 ;;=3^Compartment syndrome of right upper extrem, subs
 ;;^UTILITY(U,$J,358.3,30245,1,4,0)
 ;;=4^T79.A11D
 ;;^UTILITY(U,$J,358.3,30245,2)
 ;;=^5054327
 ;;^UTILITY(U,$J,358.3,30246,0)
 ;;=T79.A12A^^86^1303^6
 ;;^UTILITY(U,$J,358.3,30246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30246,1,3,0)
 ;;=3^Compartment syndrome of left upper extremity, init
 ;;^UTILITY(U,$J,358.3,30246,1,4,0)
 ;;=4^T79.A12A
 ;;^UTILITY(U,$J,358.3,30246,2)
 ;;=^5054329
 ;;^UTILITY(U,$J,358.3,30247,0)
 ;;=T79.A12D^^86^1303^7
 ;;^UTILITY(U,$J,358.3,30247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30247,1,3,0)
 ;;=3^Compartment syndrome of left upper extremity, subs
 ;;^UTILITY(U,$J,358.3,30247,1,4,0)
 ;;=4^T79.A12D
 ;;^UTILITY(U,$J,358.3,30247,2)
 ;;=^5054330
 ;;^UTILITY(U,$J,358.3,30248,0)
 ;;=T79.A21A^^86^1303^10
 ;;^UTILITY(U,$J,358.3,30248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30248,1,3,0)
 ;;=3^Compartment syndrome of right lower extrem, init
 ;;^UTILITY(U,$J,358.3,30248,1,4,0)
 ;;=4^T79.A21A
 ;;^UTILITY(U,$J,358.3,30248,2)
 ;;=^5054335
 ;;^UTILITY(U,$J,358.3,30249,0)
 ;;=T79.A21D^^86^1303^11
 ;;^UTILITY(U,$J,358.3,30249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30249,1,3,0)
 ;;=3^Compartment syndrome of right lower extrem, subs
 ;;^UTILITY(U,$J,358.3,30249,1,4,0)
 ;;=4^T79.A21D
 ;;^UTILITY(U,$J,358.3,30249,2)
 ;;=^5054336
 ;;^UTILITY(U,$J,358.3,30250,0)
 ;;=T79.A22A^^86^1303^4
 ;;^UTILITY(U,$J,358.3,30250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30250,1,3,0)
 ;;=3^Compartment syndrome of left lower extremity, init
 ;;^UTILITY(U,$J,358.3,30250,1,4,0)
 ;;=4^T79.A22A
 ;;^UTILITY(U,$J,358.3,30250,2)
 ;;=^5137969
 ;;^UTILITY(U,$J,358.3,30251,0)
 ;;=T79.A22D^^86^1303^5
 ;;^UTILITY(U,$J,358.3,30251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30251,1,3,0)
 ;;=3^Compartment syndrome of left lower extremity, subs
 ;;^UTILITY(U,$J,358.3,30251,1,4,0)
 ;;=4^T79.A22D
 ;;^UTILITY(U,$J,358.3,30251,2)
 ;;=^5137970
 ;;^UTILITY(U,$J,358.3,30252,0)
 ;;=T79.A9XA^^86^1303^8
 ;;^UTILITY(U,$J,358.3,30252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30252,1,3,0)
 ;;=3^Compartment syndrome of other sites, init encntr
 ;;^UTILITY(U,$J,358.3,30252,1,4,0)
 ;;=4^T79.A9XA
 ;;^UTILITY(U,$J,358.3,30252,2)
 ;;=^5054341
 ;;^UTILITY(U,$J,358.3,30253,0)
 ;;=T79.A9XD^^86^1303^9
 ;;^UTILITY(U,$J,358.3,30253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30253,1,3,0)
 ;;=3^Compartment syndrome of other sites, subs encntr
 ;;^UTILITY(U,$J,358.3,30253,1,4,0)
 ;;=4^T79.A9XD
 ;;^UTILITY(U,$J,358.3,30253,2)
 ;;=^5054342
 ;;^UTILITY(U,$J,358.3,30254,0)
 ;;=G90.513^^86^1303^19
 ;;^UTILITY(U,$J,358.3,30254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30254,1,3,0)
 ;;=3^Complex regional pain syndrome I of upper limb, bilateral
 ;;^UTILITY(U,$J,358.3,30254,1,4,0)
 ;;=4^G90.513
 ;;^UTILITY(U,$J,358.3,30254,2)
 ;;=^5004166
 ;;^UTILITY(U,$J,358.3,30255,0)
 ;;=T84.52XD^^86^1303^25
 ;;^UTILITY(U,$J,358.3,30255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30255,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left hip prosth, subs
 ;;^UTILITY(U,$J,358.3,30255,1,4,0)
 ;;=4^T84.52XD
 ;;^UTILITY(U,$J,358.3,30255,2)
 ;;=^5055389
 ;;^UTILITY(U,$J,358.3,30256,0)
 ;;=T84.54XD^^86^1303^26
 ;;^UTILITY(U,$J,358.3,30256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30256,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left knee prosth, subs
 ;;^UTILITY(U,$J,358.3,30256,1,4,0)
 ;;=4^T84.54XD
 ;;^UTILITY(U,$J,358.3,30256,2)
 ;;=^5055395
 ;;^UTILITY(U,$J,358.3,30257,0)
 ;;=T84.51XD^^86^1303^29
 ;;^UTILITY(U,$J,358.3,30257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30257,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right hip prosth, subs
 ;;^UTILITY(U,$J,358.3,30257,1,4,0)
 ;;=4^T84.51XD
 ;;^UTILITY(U,$J,358.3,30257,2)
 ;;=^5055386
 ;;^UTILITY(U,$J,358.3,30258,0)
 ;;=T84.53XD^^86^1303^30
 ;;^UTILITY(U,$J,358.3,30258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30258,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right knee prosth, subs
 ;;^UTILITY(U,$J,358.3,30258,1,4,0)
 ;;=4^T84.53XD
 ;;^UTILITY(U,$J,358.3,30258,2)
 ;;=^5055392
 ;;^UTILITY(U,$J,358.3,30259,0)
 ;;=T84.59XD^^86^1303^32
 ;;^UTILITY(U,$J,358.3,30259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30259,1,3,0)
 ;;=3^Infect/inflm reaction d/t oth internal joint prosth, subs
 ;;^UTILITY(U,$J,358.3,30259,1,4,0)
 ;;=4^T84.59XD
 ;;^UTILITY(U,$J,358.3,30259,2)
 ;;=^5055398
 ;;^UTILITY(U,$J,358.3,30260,0)
 ;;=M93.211^^86^1303^46
 ;;^UTILITY(U,$J,358.3,30260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30260,1,3,0)
 ;;=3^Osteochondritis dissecans, right shoulder
 ;;^UTILITY(U,$J,358.3,30260,1,4,0)
 ;;=4^M93.211
 ;;^UTILITY(U,$J,358.3,30260,2)
 ;;=^5015256
 ;;^UTILITY(U,$J,358.3,30261,0)
 ;;=M93.212^^86^1303^40
 ;;^UTILITY(U,$J,358.3,30261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30261,1,3,0)
 ;;=3^Osteochondritis dissecans, left shoulder
 ;;^UTILITY(U,$J,358.3,30261,1,4,0)
 ;;=4^M93.212
 ;;^UTILITY(U,$J,358.3,30261,2)
 ;;=^5015257
 ;;^UTILITY(U,$J,358.3,30262,0)
 ;;=M93.222^^86^1303^37
 ;;^UTILITY(U,$J,358.3,30262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30262,1,3,0)
 ;;=3^Osteochondritis dissecans, left elbow
 ;;^UTILITY(U,$J,358.3,30262,1,4,0)
 ;;=4^M93.222
 ;;^UTILITY(U,$J,358.3,30262,2)
 ;;=^5015260
 ;;^UTILITY(U,$J,358.3,30263,0)
 ;;=M93.221^^86^1303^43
 ;;^UTILITY(U,$J,358.3,30263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30263,1,3,0)
 ;;=3^Osteochondritis dissecans, right elbow
 ;;^UTILITY(U,$J,358.3,30263,1,4,0)
 ;;=4^M93.221
 ;;^UTILITY(U,$J,358.3,30263,2)
 ;;=^5015259
 ;;^UTILITY(U,$J,358.3,30264,0)
 ;;=M93.231^^86^1303^47
 ;;^UTILITY(U,$J,358.3,30264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30264,1,3,0)
 ;;=3^Osteochondritis dissecans, right wrist
 ;;^UTILITY(U,$J,358.3,30264,1,4,0)
 ;;=4^M93.231
 ;;^UTILITY(U,$J,358.3,30264,2)
 ;;=^5015262
 ;;^UTILITY(U,$J,358.3,30265,0)
 ;;=M93.232^^86^1303^41
 ;;^UTILITY(U,$J,358.3,30265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30265,1,3,0)
 ;;=3^Osteochondritis dissecans, left wrist
 ;;^UTILITY(U,$J,358.3,30265,1,4,0)
 ;;=4^M93.232
 ;;^UTILITY(U,$J,358.3,30265,2)
 ;;=^5015263
 ;;^UTILITY(U,$J,358.3,30266,0)
 ;;=M93.241^^86^1303^35
 ;;^UTILITY(U,$J,358.3,30266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30266,1,3,0)
 ;;=3^Osteochondritis dissecans, joints of right hand
 ;;^UTILITY(U,$J,358.3,30266,1,4,0)
 ;;=4^M93.241
