IBDEI02K ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2108,1,4,0)
 ;;=4^I65.01
 ;;^UTILITY(U,$J,358.3,2108,2)
 ;;=^5007356
 ;;^UTILITY(U,$J,358.3,2109,0)
 ;;=I65.02^^14^166^79
 ;;^UTILITY(U,$J,358.3,2109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2109,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Vertebral Artery
 ;;^UTILITY(U,$J,358.3,2109,1,4,0)
 ;;=4^I65.02
 ;;^UTILITY(U,$J,358.3,2109,2)
 ;;=^5007357
 ;;^UTILITY(U,$J,358.3,2110,0)
 ;;=I65.03^^14^166^77
 ;;^UTILITY(U,$J,358.3,2110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2110,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Vertebral Arteries
 ;;^UTILITY(U,$J,358.3,2110,1,4,0)
 ;;=4^I65.03
 ;;^UTILITY(U,$J,358.3,2110,2)
 ;;=^5007358
 ;;^UTILITY(U,$J,358.3,2111,0)
 ;;=I65.8^^14^166^80
 ;;^UTILITY(U,$J,358.3,2111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2111,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,2111,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,2111,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,2112,0)
 ;;=I63.032^^14^166^55
 ;;^UTILITY(U,$J,358.3,2112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2112,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,2112,1,4,0)
 ;;=4^I63.032
 ;;^UTILITY(U,$J,358.3,2112,2)
 ;;=^5007300
 ;;^UTILITY(U,$J,358.3,2113,0)
 ;;=I63.131^^14^166^54
 ;;^UTILITY(U,$J,358.3,2113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2113,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,2113,1,4,0)
 ;;=4^I63.131
 ;;^UTILITY(U,$J,358.3,2113,2)
 ;;=^5007308
 ;;^UTILITY(U,$J,358.3,2114,0)
 ;;=I63.132^^14^166^53
 ;;^UTILITY(U,$J,358.3,2114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2114,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,2114,1,4,0)
 ;;=4^I63.132
 ;;^UTILITY(U,$J,358.3,2114,2)
 ;;=^5007309
 ;;^UTILITY(U,$J,358.3,2115,0)
 ;;=I63.231^^14^166^57
 ;;^UTILITY(U,$J,358.3,2115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2115,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,2115,1,4,0)
 ;;=4^I63.231
 ;;^UTILITY(U,$J,358.3,2115,2)
 ;;=^5007316
 ;;^UTILITY(U,$J,358.3,2116,0)
 ;;=I63.232^^14^166^58
 ;;^UTILITY(U,$J,358.3,2116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2116,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,2116,1,4,0)
 ;;=4^I63.232
 ;;^UTILITY(U,$J,358.3,2116,2)
 ;;=^5007317
 ;;^UTILITY(U,$J,358.3,2117,0)
 ;;=I63.211^^14^166^59
 ;;^UTILITY(U,$J,358.3,2117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2117,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Right Vertebral Artery
 ;;^UTILITY(U,$J,358.3,2117,1,4,0)
 ;;=4^I63.211
 ;;^UTILITY(U,$J,358.3,2117,2)
 ;;=^5007313
 ;;^UTILITY(U,$J,358.3,2118,0)
 ;;=I63.212^^14^166^60
 ;;^UTILITY(U,$J,358.3,2118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2118,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occlusion/Stenosis of Left Vertebral Artery
 ;;^UTILITY(U,$J,358.3,2118,1,4,0)
 ;;=4^I63.212
 ;;^UTILITY(U,$J,358.3,2118,2)
 ;;=^5007314
 ;;^UTILITY(U,$J,358.3,2119,0)
 ;;=G45.9^^14^166^94
 ;;^UTILITY(U,$J,358.3,2119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2119,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
 ;;^UTILITY(U,$J,358.3,2119,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,2119,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,2120,0)
 ;;=I70.0^^14^166^14
 ;;^UTILITY(U,$J,358.3,2120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2120,1,3,0)
 ;;=3^Atherosclerosis of Aorta
 ;;^UTILITY(U,$J,358.3,2120,1,4,0)
 ;;=4^I70.0
 ;;^UTILITY(U,$J,358.3,2120,2)
 ;;=^269759
 ;;^UTILITY(U,$J,358.3,2121,0)
 ;;=I70.1^^14^166^16
 ;;^UTILITY(U,$J,358.3,2121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2121,1,3,0)
 ;;=3^Atherosclerosis of Renal Artery
 ;;^UTILITY(U,$J,358.3,2121,1,4,0)
 ;;=4^I70.1
 ;;^UTILITY(U,$J,358.3,2121,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,2122,0)
 ;;=I70.211^^14^166^36
 ;;^UTILITY(U,$J,358.3,2122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2122,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,2122,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,2122,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,2123,0)
 ;;=I70.212^^14^166^32
 ;;^UTILITY(U,$J,358.3,2123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2123,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,2123,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,2123,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,2124,0)
 ;;=I70.213^^14^166^28
 ;;^UTILITY(U,$J,358.3,2124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2124,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,2124,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,2124,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,2125,0)
 ;;=I70.221^^14^166^37
 ;;^UTILITY(U,$J,358.3,2125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2125,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,2125,1,4,0)
 ;;=4^I70.221
 ;;^UTILITY(U,$J,358.3,2125,2)
 ;;=^5007583
 ;;^UTILITY(U,$J,358.3,2126,0)
 ;;=I70.222^^14^166^33
 ;;^UTILITY(U,$J,358.3,2126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2126,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,2126,1,4,0)
 ;;=4^I70.222
 ;;^UTILITY(U,$J,358.3,2126,2)
 ;;=^5007584
 ;;^UTILITY(U,$J,358.3,2127,0)
 ;;=I70.223^^14^166^29
 ;;^UTILITY(U,$J,358.3,2127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2127,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,2127,1,4,0)
 ;;=4^I70.223
 ;;^UTILITY(U,$J,358.3,2127,2)
 ;;=^5007585
 ;;^UTILITY(U,$J,358.3,2128,0)
 ;;=I70.231^^14^166^38
 ;;^UTILITY(U,$J,358.3,2128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2128,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Thigh Ulceration
 ;;^UTILITY(U,$J,358.3,2128,1,4,0)
 ;;=4^I70.231
 ;;^UTILITY(U,$J,358.3,2128,2)
 ;;=^5007588
 ;;^UTILITY(U,$J,358.3,2129,0)
 ;;=I70.234^^14^166^39
 ;;^UTILITY(U,$J,358.3,2129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2129,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,2129,1,4,0)
 ;;=4^I70.234
 ;;^UTILITY(U,$J,358.3,2129,2)
 ;;=^5007591
 ;;^UTILITY(U,$J,358.3,2130,0)
 ;;=I70.239^^14^166^40
 ;;^UTILITY(U,$J,358.3,2130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2130,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,2130,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,2130,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,2131,0)
 ;;=I70.241^^14^166^34
 ;;^UTILITY(U,$J,358.3,2131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2131,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Thigh Ulceration
 ;;^UTILITY(U,$J,358.3,2131,1,4,0)
 ;;=4^I70.241
 ;;^UTILITY(U,$J,358.3,2131,2)
 ;;=^5007595
 ;;^UTILITY(U,$J,358.3,2132,0)
 ;;=I70.249^^14^166^35
 ;;^UTILITY(U,$J,358.3,2132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2132,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Ulcer of Unspec Site
 ;;^UTILITY(U,$J,358.3,2132,1,4,0)
 ;;=4^I70.249
 ;;^UTILITY(U,$J,358.3,2132,2)
 ;;=^5007601
 ;;^UTILITY(U,$J,358.3,2133,0)
 ;;=I70.262^^14^166^31
 ;;^UTILITY(U,$J,358.3,2133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2133,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,2133,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,2133,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,2134,0)
 ;;=I70.261^^14^166^41
 ;;^UTILITY(U,$J,358.3,2134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2134,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,2134,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,2134,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,2135,0)
 ;;=I70.263^^14^166^30
