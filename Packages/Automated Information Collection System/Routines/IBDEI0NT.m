IBDEI0NT ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30200,1,4,0)
 ;;=4^M23.241
 ;;^UTILITY(U,$J,358.3,30200,2)
 ;;=^5011225
 ;;^UTILITY(U,$J,358.3,30201,0)
 ;;=M23.242^^86^1302^26
 ;;^UTILITY(U,$J,358.3,30201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30201,1,3,0)
 ;;=3^Derang Ant Horn Lateral Mensc d/t Old Tear/Inj,Left Knee
 ;;^UTILITY(U,$J,358.3,30201,1,4,0)
 ;;=4^M23.242
 ;;^UTILITY(U,$J,358.3,30201,2)
 ;;=^5011226
 ;;^UTILITY(U,$J,358.3,30202,0)
 ;;=M23.251^^86^1302^29
 ;;^UTILITY(U,$J,358.3,30202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30202,1,3,0)
 ;;=3^Derang Post Horn Lateral Mensc d/t Old Tear/Inj,Right Knee
 ;;^UTILITY(U,$J,358.3,30202,1,4,0)
 ;;=4^M23.251
 ;;^UTILITY(U,$J,358.3,30202,2)
 ;;=^5011228
 ;;^UTILITY(U,$J,358.3,30203,0)
 ;;=M23.252^^86^1302^30
 ;;^UTILITY(U,$J,358.3,30203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30203,1,3,0)
 ;;=3^Derang Post Horn Lateral Mensc d/t Old Tear/Inj,Left Knee
 ;;^UTILITY(U,$J,358.3,30203,1,4,0)
 ;;=4^M23.252
 ;;^UTILITY(U,$J,358.3,30203,2)
 ;;=^5011229
 ;;^UTILITY(U,$J,358.3,30204,0)
 ;;=S83.114A^^86^1302^39
 ;;^UTILITY(U,$J,358.3,30204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30204,1,3,0)
 ;;=3^Dislocation Ant Proximal End of Tibia,Right Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,30204,1,4,0)
 ;;=4^S83.114A
 ;;^UTILITY(U,$J,358.3,30204,2)
 ;;=^5042956
 ;;^UTILITY(U,$J,358.3,30205,0)
 ;;=S83.114D^^86^1302^40
 ;;^UTILITY(U,$J,358.3,30205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30205,1,3,0)
 ;;=3^Dislocation Ant Proximal End of Tibia,Right Knee,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30205,1,4,0)
 ;;=4^S83.114D
 ;;^UTILITY(U,$J,358.3,30205,2)
 ;;=^5042957
 ;;^UTILITY(U,$J,358.3,30206,0)
 ;;=S83.115D^^86^1302^37
 ;;^UTILITY(U,$J,358.3,30206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30206,1,3,0)
 ;;=3^Dislocation Ant Proximal End of Tibia,Left Knee,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30206,1,4,0)
 ;;=4^S83.115D
 ;;^UTILITY(U,$J,358.3,30206,2)
 ;;=^5042960
 ;;^UTILITY(U,$J,358.3,30207,0)
 ;;=S83.115A^^86^1302^38
 ;;^UTILITY(U,$J,358.3,30207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30207,1,3,0)
 ;;=3^Dislocation Ant Proximal End of Tibia,Left Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,30207,1,4,0)
 ;;=4^S83.115A
 ;;^UTILITY(U,$J,358.3,30207,2)
 ;;=^5042959
 ;;^UTILITY(U,$J,358.3,30208,0)
 ;;=S83.124A^^86^1302^51
 ;;^UTILITY(U,$J,358.3,30208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30208,1,3,0)
 ;;=3^Dislocation Post Proximal End of Tibia,Right Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,30208,1,4,0)
 ;;=4^S83.124A
 ;;^UTILITY(U,$J,358.3,30208,2)
 ;;=^5042974
 ;;^UTILITY(U,$J,358.3,30209,0)
 ;;=S83.124D^^86^1302^52
 ;;^UTILITY(U,$J,358.3,30209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30209,1,3,0)
 ;;=3^Dislocation Post Proximal End of Tibia,Right Knee,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30209,1,4,0)
 ;;=4^S83.124D
 ;;^UTILITY(U,$J,358.3,30209,2)
 ;;=^5042975
 ;;^UTILITY(U,$J,358.3,30210,0)
 ;;=S83.125A^^86^1302^53
 ;;^UTILITY(U,$J,358.3,30210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30210,1,3,0)
 ;;=3^Dislocation Post Proximal End of Tibia,Left Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,30210,1,4,0)
 ;;=4^S83.125A
 ;;^UTILITY(U,$J,358.3,30210,2)
 ;;=^5042977
 ;;^UTILITY(U,$J,358.3,30211,0)
 ;;=S83.125D^^86^1302^54
 ;;^UTILITY(U,$J,358.3,30211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30211,1,3,0)
 ;;=3^Dislocation Post Proximal End of Tibia,Left Knee,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30211,1,4,0)
 ;;=4^S83.125D
 ;;^UTILITY(U,$J,358.3,30211,2)
 ;;=^5042978
 ;;^UTILITY(U,$J,358.3,30212,0)
 ;;=S83.134A^^86^1302^49
 ;;^UTILITY(U,$J,358.3,30212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30212,1,3,0)
 ;;=3^Dislocation Med Proximal End of Tibia,Right Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,30212,1,4,0)
 ;;=4^S83.134A
 ;;^UTILITY(U,$J,358.3,30212,2)
 ;;=^5042992
 ;;^UTILITY(U,$J,358.3,30213,0)
 ;;=S83.134D^^86^1302^50
 ;;^UTILITY(U,$J,358.3,30213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30213,1,3,0)
 ;;=3^Dislocation Med Proximal End of Tibia,Right Knee,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30213,1,4,0)
 ;;=4^S83.134D
 ;;^UTILITY(U,$J,358.3,30213,2)
 ;;=^5042993
 ;;^UTILITY(U,$J,358.3,30214,0)
 ;;=S83.135A^^86^1302^47
 ;;^UTILITY(U,$J,358.3,30214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30214,1,3,0)
 ;;=3^Dislocation Med Proximal End of Tibia,Left Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,30214,1,4,0)
 ;;=4^S83.135A
 ;;^UTILITY(U,$J,358.3,30214,2)
 ;;=^5042995
 ;;^UTILITY(U,$J,358.3,30215,0)
 ;;=S83.135D^^86^1302^48
 ;;^UTILITY(U,$J,358.3,30215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30215,1,3,0)
 ;;=3^Dislocation Med Proximal End of Tibia,Left Knee,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30215,1,4,0)
 ;;=4^S83.135D
 ;;^UTILITY(U,$J,358.3,30215,2)
 ;;=^5042996
 ;;^UTILITY(U,$J,358.3,30216,0)
 ;;=S83.144A^^86^1302^43
 ;;^UTILITY(U,$J,358.3,30216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30216,1,3,0)
 ;;=3^Dislocation Lat Proximal End of Tibia,Right Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,30216,1,4,0)
 ;;=4^S83.144A
 ;;^UTILITY(U,$J,358.3,30216,2)
 ;;=^5043010
 ;;^UTILITY(U,$J,358.3,30217,0)
 ;;=S83.144D^^86^1302^44
 ;;^UTILITY(U,$J,358.3,30217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30217,1,3,0)
 ;;=3^Dislocation Lat Proximal End of Tibia,Right Knee,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30217,1,4,0)
 ;;=4^S83.144D
 ;;^UTILITY(U,$J,358.3,30217,2)
 ;;=^5043011
 ;;^UTILITY(U,$J,358.3,30218,0)
 ;;=S83.145A^^86^1302^41
 ;;^UTILITY(U,$J,358.3,30218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30218,1,3,0)
 ;;=3^Dislocation Lat Proximal End of Tibia,Left Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,30218,1,4,0)
 ;;=4^S83.145A
 ;;^UTILITY(U,$J,358.3,30218,2)
 ;;=^5043013
 ;;^UTILITY(U,$J,358.3,30219,0)
 ;;=S83.145D^^86^1302^42
 ;;^UTILITY(U,$J,358.3,30219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30219,1,3,0)
 ;;=3^Dislocation Lat Proximal End of Tibia,Left Knee,Subs Encntr
 ;;^UTILITY(U,$J,358.3,30219,1,4,0)
 ;;=4^S83.145D
 ;;^UTILITY(U,$J,358.3,30219,2)
 ;;=^5043014
 ;;^UTILITY(U,$J,358.3,30220,0)
 ;;=M81.0^^86^1303^1
 ;;^UTILITY(U,$J,358.3,30220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30220,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,30220,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,30220,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,30221,0)
 ;;=L40.50^^86^1303^3
 ;;^UTILITY(U,$J,358.3,30221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30221,1,3,0)
 ;;=3^Arthropathic psoriasis, unspecified
 ;;^UTILITY(U,$J,358.3,30221,1,4,0)
 ;;=4^L40.50
 ;;^UTILITY(U,$J,358.3,30221,2)
 ;;=^5009165
 ;;^UTILITY(U,$J,358.3,30222,0)
 ;;=G90.522^^86^1303^14
 ;;^UTILITY(U,$J,358.3,30222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30222,1,3,0)
 ;;=3^Complex regional pain syndrome I of left lower limb
 ;;^UTILITY(U,$J,358.3,30222,1,4,0)
 ;;=4^G90.522
 ;;^UTILITY(U,$J,358.3,30222,2)
 ;;=^5133371
 ;;^UTILITY(U,$J,358.3,30223,0)
 ;;=G90.512^^86^1303^15
 ;;^UTILITY(U,$J,358.3,30223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30223,1,3,0)
 ;;=3^Complex regional pain syndrome I of left upper limb
 ;;^UTILITY(U,$J,358.3,30223,1,4,0)
 ;;=4^G90.512
 ;;^UTILITY(U,$J,358.3,30223,2)
 ;;=^5004165
 ;;^UTILITY(U,$J,358.3,30224,0)
 ;;=G90.523^^86^1303^16
 ;;^UTILITY(U,$J,358.3,30224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30224,1,3,0)
 ;;=3^Complex regional pain syndrome I of lower limb, bilateral
 ;;^UTILITY(U,$J,358.3,30224,1,4,0)
 ;;=4^G90.523
 ;;^UTILITY(U,$J,358.3,30224,2)
 ;;=^5004169
 ;;^UTILITY(U,$J,358.3,30225,0)
 ;;=G90.521^^86^1303^17
 ;;^UTILITY(U,$J,358.3,30225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30225,1,3,0)
 ;;=3^Complex regional pain syndrome I of right lower limb
 ;;^UTILITY(U,$J,358.3,30225,1,4,0)
 ;;=4^G90.521
 ;;^UTILITY(U,$J,358.3,30225,2)
 ;;=^5004168
 ;;^UTILITY(U,$J,358.3,30226,0)
 ;;=G90.511^^86^1303^18
 ;;^UTILITY(U,$J,358.3,30226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30226,1,3,0)
 ;;=3^Complex regional pain syndrome I of right upper limb
 ;;^UTILITY(U,$J,358.3,30226,1,4,0)
 ;;=4^G90.511
 ;;^UTILITY(U,$J,358.3,30226,2)
 ;;=^5004164
 ;;^UTILITY(U,$J,358.3,30227,0)
 ;;=I96.^^86^1303^20
 ;;^UTILITY(U,$J,358.3,30227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30227,1,3,0)
 ;;=3^Gangrene, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,30227,1,4,0)
 ;;=4^I96.
 ;;^UTILITY(U,$J,358.3,30227,2)
 ;;=^5008081
 ;;^UTILITY(U,$J,358.3,30228,0)
 ;;=M10.9^^86^1303^21
 ;;^UTILITY(U,$J,358.3,30228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30228,1,3,0)
 ;;=3^Gout, unspecified
 ;;^UTILITY(U,$J,358.3,30228,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,30228,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,30229,0)
 ;;=M87.08^^86^1303^22
 ;;^UTILITY(U,$J,358.3,30229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30229,1,3,0)
 ;;=3^Idiopathic aseptic necrosis of bone, other site
 ;;^UTILITY(U,$J,358.3,30229,1,4,0)
 ;;=4^M87.08
 ;;^UTILITY(U,$J,358.3,30229,2)
 ;;=^5014698
 ;;^UTILITY(U,$J,358.3,30230,0)
 ;;=T84.52XA^^86^1303^23
 ;;^UTILITY(U,$J,358.3,30230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30230,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left hip prosth, init
 ;;^UTILITY(U,$J,358.3,30230,1,4,0)
 ;;=4^T84.52XA
 ;;^UTILITY(U,$J,358.3,30230,2)
 ;;=^5055388
 ;;^UTILITY(U,$J,358.3,30231,0)
 ;;=T84.54XA^^86^1303^24
 ;;^UTILITY(U,$J,358.3,30231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30231,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left knee prosth, init
 ;;^UTILITY(U,$J,358.3,30231,1,4,0)
 ;;=4^T84.54XA
 ;;^UTILITY(U,$J,358.3,30231,2)
 ;;=^5055394
 ;;^UTILITY(U,$J,358.3,30232,0)
 ;;=T84.51XA^^86^1303^27
 ;;^UTILITY(U,$J,358.3,30232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30232,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right hip prosth, init
 ;;^UTILITY(U,$J,358.3,30232,1,4,0)
 ;;=4^T84.51XA
 ;;^UTILITY(U,$J,358.3,30232,2)
 ;;=^5055385
 ;;^UTILITY(U,$J,358.3,30233,0)
 ;;=T84.53XA^^86^1303^28
