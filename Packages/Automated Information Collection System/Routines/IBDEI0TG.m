IBDEI0TG ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29644,1,3,0)
 ;;=3^Compartment syndrome of other sites, subs encntr
 ;;^UTILITY(U,$J,358.3,29644,1,4,0)
 ;;=4^T79.A9XD
 ;;^UTILITY(U,$J,358.3,29644,2)
 ;;=^5054342
 ;;^UTILITY(U,$J,358.3,29645,0)
 ;;=G90.513^^111^1429^19
 ;;^UTILITY(U,$J,358.3,29645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29645,1,3,0)
 ;;=3^Complex regional pain syndrome I of upper limb, bilateral
 ;;^UTILITY(U,$J,358.3,29645,1,4,0)
 ;;=4^G90.513
 ;;^UTILITY(U,$J,358.3,29645,2)
 ;;=^5004166
 ;;^UTILITY(U,$J,358.3,29646,0)
 ;;=T84.52XD^^111^1429^25
 ;;^UTILITY(U,$J,358.3,29646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29646,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left hip prosth, subs
 ;;^UTILITY(U,$J,358.3,29646,1,4,0)
 ;;=4^T84.52XD
 ;;^UTILITY(U,$J,358.3,29646,2)
 ;;=^5055389
 ;;^UTILITY(U,$J,358.3,29647,0)
 ;;=T84.54XD^^111^1429^26
 ;;^UTILITY(U,$J,358.3,29647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29647,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left knee prosth, subs
 ;;^UTILITY(U,$J,358.3,29647,1,4,0)
 ;;=4^T84.54XD
 ;;^UTILITY(U,$J,358.3,29647,2)
 ;;=^5055395
 ;;^UTILITY(U,$J,358.3,29648,0)
 ;;=T84.51XD^^111^1429^29
 ;;^UTILITY(U,$J,358.3,29648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29648,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right hip prosth, subs
 ;;^UTILITY(U,$J,358.3,29648,1,4,0)
 ;;=4^T84.51XD
 ;;^UTILITY(U,$J,358.3,29648,2)
 ;;=^5055386
 ;;^UTILITY(U,$J,358.3,29649,0)
 ;;=T84.53XD^^111^1429^30
 ;;^UTILITY(U,$J,358.3,29649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29649,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right knee prosth, subs
 ;;^UTILITY(U,$J,358.3,29649,1,4,0)
 ;;=4^T84.53XD
 ;;^UTILITY(U,$J,358.3,29649,2)
 ;;=^5055392
 ;;^UTILITY(U,$J,358.3,29650,0)
 ;;=T84.59XD^^111^1429^32
 ;;^UTILITY(U,$J,358.3,29650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29650,1,3,0)
 ;;=3^Infect/inflm reaction d/t oth internal joint prosth, subs
 ;;^UTILITY(U,$J,358.3,29650,1,4,0)
 ;;=4^T84.59XD
 ;;^UTILITY(U,$J,358.3,29650,2)
 ;;=^5055398
 ;;^UTILITY(U,$J,358.3,29651,0)
 ;;=M93.211^^111^1429^46
 ;;^UTILITY(U,$J,358.3,29651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29651,1,3,0)
 ;;=3^Osteochondritis dissecans, right shoulder
 ;;^UTILITY(U,$J,358.3,29651,1,4,0)
 ;;=4^M93.211
 ;;^UTILITY(U,$J,358.3,29651,2)
 ;;=^5015256
 ;;^UTILITY(U,$J,358.3,29652,0)
 ;;=M93.212^^111^1429^40
 ;;^UTILITY(U,$J,358.3,29652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29652,1,3,0)
 ;;=3^Osteochondritis dissecans, left shoulder
 ;;^UTILITY(U,$J,358.3,29652,1,4,0)
 ;;=4^M93.212
 ;;^UTILITY(U,$J,358.3,29652,2)
 ;;=^5015257
 ;;^UTILITY(U,$J,358.3,29653,0)
 ;;=M93.222^^111^1429^37
 ;;^UTILITY(U,$J,358.3,29653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29653,1,3,0)
 ;;=3^Osteochondritis dissecans, left elbow
 ;;^UTILITY(U,$J,358.3,29653,1,4,0)
 ;;=4^M93.222
 ;;^UTILITY(U,$J,358.3,29653,2)
 ;;=^5015260
 ;;^UTILITY(U,$J,358.3,29654,0)
 ;;=M93.221^^111^1429^43
 ;;^UTILITY(U,$J,358.3,29654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29654,1,3,0)
 ;;=3^Osteochondritis dissecans, right elbow
 ;;^UTILITY(U,$J,358.3,29654,1,4,0)
 ;;=4^M93.221
 ;;^UTILITY(U,$J,358.3,29654,2)
 ;;=^5015259
 ;;^UTILITY(U,$J,358.3,29655,0)
 ;;=M93.231^^111^1429^47
 ;;^UTILITY(U,$J,358.3,29655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29655,1,3,0)
 ;;=3^Osteochondritis dissecans, right wrist
 ;;^UTILITY(U,$J,358.3,29655,1,4,0)
 ;;=4^M93.231
 ;;^UTILITY(U,$J,358.3,29655,2)
 ;;=^5015262
 ;;^UTILITY(U,$J,358.3,29656,0)
 ;;=M93.232^^111^1429^41
 ;;^UTILITY(U,$J,358.3,29656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29656,1,3,0)
 ;;=3^Osteochondritis dissecans, left wrist
 ;;^UTILITY(U,$J,358.3,29656,1,4,0)
 ;;=4^M93.232
 ;;^UTILITY(U,$J,358.3,29656,2)
 ;;=^5015263
 ;;^UTILITY(U,$J,358.3,29657,0)
 ;;=M93.241^^111^1429^35
 ;;^UTILITY(U,$J,358.3,29657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29657,1,3,0)
 ;;=3^Osteochondritis dissecans, joints of right hand
 ;;^UTILITY(U,$J,358.3,29657,1,4,0)
 ;;=4^M93.241
 ;;^UTILITY(U,$J,358.3,29657,2)
 ;;=^5015265
 ;;^UTILITY(U,$J,358.3,29658,0)
 ;;=M93.242^^111^1429^34
 ;;^UTILITY(U,$J,358.3,29658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29658,1,3,0)
 ;;=3^Osteochondritis dissecans, joints of left hand
 ;;^UTILITY(U,$J,358.3,29658,1,4,0)
 ;;=4^M93.242
 ;;^UTILITY(U,$J,358.3,29658,2)
 ;;=^5015266
 ;;^UTILITY(U,$J,358.3,29659,0)
 ;;=M93.251^^111^1429^44
 ;;^UTILITY(U,$J,358.3,29659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29659,1,3,0)
 ;;=3^Osteochondritis dissecans, right hip
 ;;^UTILITY(U,$J,358.3,29659,1,4,0)
 ;;=4^M93.251
 ;;^UTILITY(U,$J,358.3,29659,2)
 ;;=^5015268
 ;;^UTILITY(U,$J,358.3,29660,0)
 ;;=M93.252^^111^1429^38
 ;;^UTILITY(U,$J,358.3,29660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29660,1,3,0)
 ;;=3^Osteochondritis dissecans, left hip
 ;;^UTILITY(U,$J,358.3,29660,1,4,0)
 ;;=4^M93.252
 ;;^UTILITY(U,$J,358.3,29660,2)
 ;;=^5015269
 ;;^UTILITY(U,$J,358.3,29661,0)
 ;;=M93.261^^111^1429^45
 ;;^UTILITY(U,$J,358.3,29661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29661,1,3,0)
 ;;=3^Osteochondritis dissecans, right knee
 ;;^UTILITY(U,$J,358.3,29661,1,4,0)
 ;;=4^M93.261
 ;;^UTILITY(U,$J,358.3,29661,2)
 ;;=^5015271
 ;;^UTILITY(U,$J,358.3,29662,0)
 ;;=M93.262^^111^1429^39
 ;;^UTILITY(U,$J,358.3,29662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29662,1,3,0)
 ;;=3^Osteochondritis dissecans, left knee
 ;;^UTILITY(U,$J,358.3,29662,1,4,0)
 ;;=4^M93.262
 ;;^UTILITY(U,$J,358.3,29662,2)
 ;;=^5015272
 ;;^UTILITY(U,$J,358.3,29663,0)
 ;;=G89.11^^111^1430^1
 ;;^UTILITY(U,$J,358.3,29663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29663,1,3,0)
 ;;=3^Acute pain due to trauma
 ;;^UTILITY(U,$J,358.3,29663,1,4,0)
 ;;=4^G89.11
 ;;^UTILITY(U,$J,358.3,29663,2)
 ;;=^5004152
 ;;^UTILITY(U,$J,358.3,29664,0)
 ;;=G89.21^^111^1430^3
 ;;^UTILITY(U,$J,358.3,29664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29664,1,3,0)
 ;;=3^Chronic pain due to trauma
 ;;^UTILITY(U,$J,358.3,29664,1,4,0)
 ;;=4^G89.21
 ;;^UTILITY(U,$J,358.3,29664,2)
 ;;=^5004155
 ;;^UTILITY(U,$J,358.3,29665,0)
 ;;=G89.18^^111^1430^2
 ;;^UTILITY(U,$J,358.3,29665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29665,1,3,0)
 ;;=3^Acute postprocedural pain NEC
 ;;^UTILITY(U,$J,358.3,29665,1,4,0)
 ;;=4^G89.18
 ;;^UTILITY(U,$J,358.3,29665,2)
 ;;=^5004154
 ;;^UTILITY(U,$J,358.3,29666,0)
 ;;=G89.28^^111^1430^4
 ;;^UTILITY(U,$J,358.3,29666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29666,1,3,0)
 ;;=3^Chronic postprocedural pain NEC
 ;;^UTILITY(U,$J,358.3,29666,1,4,0)
 ;;=4^G89.28
 ;;^UTILITY(U,$J,358.3,29666,2)
 ;;=^5004157
 ;;^UTILITY(U,$J,358.3,29667,0)
 ;;=M00.851^^111^1431^2
 ;;^UTILITY(U,$J,358.3,29667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29667,1,3,0)
 ;;=3^Arthritis d/t other bacteria, right hip
 ;;^UTILITY(U,$J,358.3,29667,1,4,0)
 ;;=4^M00.851
 ;;^UTILITY(U,$J,358.3,29667,2)
 ;;=^5009682
 ;;^UTILITY(U,$J,358.3,29668,0)
 ;;=M00.852^^111^1431^1
 ;;^UTILITY(U,$J,358.3,29668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29668,1,3,0)
 ;;=3^Arthritis d/t other bacteria, left hip
 ;;^UTILITY(U,$J,358.3,29668,1,4,0)
 ;;=4^M00.852
 ;;^UTILITY(U,$J,358.3,29668,2)
 ;;=^5009683
 ;;^UTILITY(U,$J,358.3,29669,0)
 ;;=S70.02XA^^111^1431^5
 ;;^UTILITY(U,$J,358.3,29669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29669,1,3,0)
 ;;=3^Contusion of left hip, initial encounter
 ;;^UTILITY(U,$J,358.3,29669,1,4,0)
 ;;=4^S70.02XA
 ;;^UTILITY(U,$J,358.3,29669,2)
 ;;=^5036837
 ;;^UTILITY(U,$J,358.3,29670,0)
 ;;=S70.01XA^^111^1431^7
 ;;^UTILITY(U,$J,358.3,29670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29670,1,3,0)
 ;;=3^Contusion of right hip, initial encounter
 ;;^UTILITY(U,$J,358.3,29670,1,4,0)
 ;;=4^S70.01XA
 ;;^UTILITY(U,$J,358.3,29670,2)
 ;;=^5036834
 ;;^UTILITY(U,$J,358.3,29671,0)
 ;;=S72.142A^^111^1431^19
