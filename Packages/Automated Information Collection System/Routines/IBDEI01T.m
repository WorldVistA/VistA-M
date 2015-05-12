IBDEI01T ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2035,1,3,0)
 ;;=3^Sprain Right Ankle Ligament Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,2035,1,4,0)
 ;;=4^S93.401A
 ;;^UTILITY(U,$J,358.3,2035,2)
 ;;=^5045774
 ;;^UTILITY(U,$J,358.3,2036,0)
 ;;=S63.91XA^^8^91^343
 ;;^UTILITY(U,$J,358.3,2036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2036,1,3,0)
 ;;=3^Sprain Right Wrist/Hand Unspec Part,Init Encntr
 ;;^UTILITY(U,$J,358.3,2036,1,4,0)
 ;;=4^S63.91XA
 ;;^UTILITY(U,$J,358.3,2036,2)
 ;;=^5136046
 ;;^UTILITY(U,$J,358.3,2037,0)
 ;;=C44.92^^8^91^330
 ;;^UTILITY(U,$J,358.3,2037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2037,1,3,0)
 ;;=3^SCC Skin,Unspec
 ;;^UTILITY(U,$J,358.3,2037,1,4,0)
 ;;=4^C44.92
 ;;^UTILITY(U,$J,358.3,2037,2)
 ;;=^5001093
 ;;^UTILITY(U,$J,358.3,2038,0)
 ;;=M65.9^^8^91^348
 ;;^UTILITY(U,$J,358.3,2038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2038,1,3,0)
 ;;=3^Synovitis/Tenosynovitis,Unspec
 ;;^UTILITY(U,$J,358.3,2038,1,4,0)
 ;;=4^M65.9
 ;;^UTILITY(U,$J,358.3,2038,2)
 ;;=^5012816
 ;;^UTILITY(U,$J,358.3,2039,0)
 ;;=M65.322^^8^91^349
 ;;^UTILITY(U,$J,358.3,2039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2039,1,3,0)
 ;;=3^Trigger Finger,Left Index Finger
 ;;^UTILITY(U,$J,358.3,2039,1,4,0)
 ;;=4^M65.322
 ;;^UTILITY(U,$J,358.3,2039,2)
 ;;=^5012781
 ;;^UTILITY(U,$J,358.3,2040,0)
 ;;=M65.352^^8^91^350
 ;;^UTILITY(U,$J,358.3,2040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2040,1,3,0)
 ;;=3^Trigger Finger,Left Little Finger
 ;;^UTILITY(U,$J,358.3,2040,1,4,0)
 ;;=4^M65.352
 ;;^UTILITY(U,$J,358.3,2040,2)
 ;;=^5012790
 ;;^UTILITY(U,$J,358.3,2041,0)
 ;;=M65.332^^8^91^351
 ;;^UTILITY(U,$J,358.3,2041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2041,1,3,0)
 ;;=3^Trigger Finger,Left Middle Finger
 ;;^UTILITY(U,$J,358.3,2041,1,4,0)
 ;;=4^M65.332
 ;;^UTILITY(U,$J,358.3,2041,2)
 ;;=^5012784
 ;;^UTILITY(U,$J,358.3,2042,0)
 ;;=M65.342^^8^91^352
 ;;^UTILITY(U,$J,358.3,2042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2042,1,3,0)
 ;;=3^Trigger Finger,Left Ring Finger
 ;;^UTILITY(U,$J,358.3,2042,1,4,0)
 ;;=4^M65.342
 ;;^UTILITY(U,$J,358.3,2042,2)
 ;;=^5012787
 ;;^UTILITY(U,$J,358.3,2043,0)
 ;;=M65.312^^8^91^353
 ;;^UTILITY(U,$J,358.3,2043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2043,1,3,0)
 ;;=3^Trigger Finger,Left Thumb
 ;;^UTILITY(U,$J,358.3,2043,1,4,0)
 ;;=4^M65.312
 ;;^UTILITY(U,$J,358.3,2043,2)
 ;;=^5012778
 ;;^UTILITY(U,$J,358.3,2044,0)
 ;;=M65.321^^8^91^354
 ;;^UTILITY(U,$J,358.3,2044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2044,1,3,0)
 ;;=3^Trigger Finger,Right Index Finger
 ;;^UTILITY(U,$J,358.3,2044,1,4,0)
 ;;=4^M65.321
 ;;^UTILITY(U,$J,358.3,2044,2)
 ;;=^5012780
 ;;^UTILITY(U,$J,358.3,2045,0)
 ;;=M65.351^^8^91^355
 ;;^UTILITY(U,$J,358.3,2045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2045,1,3,0)
 ;;=3^Trigger Finger,Right Little Finger
 ;;^UTILITY(U,$J,358.3,2045,1,4,0)
 ;;=4^M65.351
 ;;^UTILITY(U,$J,358.3,2045,2)
 ;;=^5012789
 ;;^UTILITY(U,$J,358.3,2046,0)
 ;;=M65.331^^8^91^356
 ;;^UTILITY(U,$J,358.3,2046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2046,1,3,0)
 ;;=3^Trigger Finger,Right Middle Finger
 ;;^UTILITY(U,$J,358.3,2046,1,4,0)
 ;;=4^M65.331
 ;;^UTILITY(U,$J,358.3,2046,2)
 ;;=^5012783
 ;;^UTILITY(U,$J,358.3,2047,0)
 ;;=M65.341^^8^91^357
 ;;^UTILITY(U,$J,358.3,2047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2047,1,3,0)
 ;;=3^Trigger Finger,Right Ring Finger
 ;;^UTILITY(U,$J,358.3,2047,1,4,0)
 ;;=4^M65.341
 ;;^UTILITY(U,$J,358.3,2047,2)
 ;;=^5012786
 ;;^UTILITY(U,$J,358.3,2048,0)
 ;;=M65.311^^8^91^358
 ;;^UTILITY(U,$J,358.3,2048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2048,1,3,0)
 ;;=3^Trigger Finger,Right Thumb
 ;;^UTILITY(U,$J,358.3,2048,1,4,0)
 ;;=4^M65.311
 ;;^UTILITY(U,$J,358.3,2048,2)
 ;;=^5012777
 ;;^UTILITY(U,$J,358.3,2049,0)
 ;;=S53.442A^^8^91^344
 ;;^UTILITY(U,$J,358.3,2049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2049,1,3,0)
 ;;=3^Sprain Ulnar Collateral Ligament Left Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,2049,1,4,0)
 ;;=4^S53.442A
 ;;^UTILITY(U,$J,358.3,2049,2)
 ;;=^5031397
 ;;^UTILITY(U,$J,358.3,2050,0)
 ;;=S53.441A^^8^91^345
 ;;^UTILITY(U,$J,358.3,2050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2050,1,3,0)
 ;;=3^Sprain Ulnar Collateral Ligament Right Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,2050,1,4,0)
 ;;=4^S53.441A
 ;;^UTILITY(U,$J,358.3,2050,2)
 ;;=^5031394
 ;;^UTILITY(U,$J,358.3,2051,0)
 ;;=Q37.9^^8^91^105
 ;;^UTILITY(U,$J,358.3,2051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2051,1,3,0)
 ;;=3^Cleft Palate w/ Unilateral Cleft Lip
 ;;^UTILITY(U,$J,358.3,2051,1,4,0)
 ;;=4^Q37.9
 ;;^UTILITY(U,$J,358.3,2051,2)
 ;;=^5018645
 ;;^UTILITY(U,$J,358.3,2052,0)
 ;;=Q74.9^^8^91^111
 ;;^UTILITY(U,$J,358.3,2052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2052,1,3,0)
 ;;=3^Congenital Limb Malformation
 ;;^UTILITY(U,$J,358.3,2052,1,4,0)
 ;;=4^Q74.9
 ;;^UTILITY(U,$J,358.3,2052,2)
 ;;=^5018995
 ;;^UTILITY(U,$J,358.3,2053,0)
 ;;=S63.251A^^8^91^127
 ;;^UTILITY(U,$J,358.3,2053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2053,1,3,0)
 ;;=3^Dislocation Left Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2053,1,4,0)
 ;;=4^S63.251A
 ;;^UTILITY(U,$J,358.3,2053,2)
 ;;=^5035268
 ;;^UTILITY(U,$J,358.3,2054,0)
 ;;=S63.257A^^8^91^128
 ;;^UTILITY(U,$J,358.3,2054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2054,1,3,0)
 ;;=3^Dislocation Left Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2054,1,4,0)
 ;;=4^S63.257A
 ;;^UTILITY(U,$J,358.3,2054,2)
 ;;=^5035286
 ;;^UTILITY(U,$J,358.3,2055,0)
 ;;=S63.253A^^8^91^129
 ;;^UTILITY(U,$J,358.3,2055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2055,1,3,0)
 ;;=3^Dislocation Left Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2055,1,4,0)
 ;;=4^S63.253A
 ;;^UTILITY(U,$J,358.3,2055,2)
 ;;=^5035274
 ;;^UTILITY(U,$J,358.3,2056,0)
 ;;=S63.255A^^8^91^130
 ;;^UTILITY(U,$J,358.3,2056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2056,1,3,0)
 ;;=3^Dislocation Left Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2056,1,4,0)
 ;;=4^S63.255A
 ;;^UTILITY(U,$J,358.3,2056,2)
 ;;=^5035280
 ;;^UTILITY(U,$J,358.3,2057,0)
 ;;=S63.105A^^8^91^131
 ;;^UTILITY(U,$J,358.3,2057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2057,1,3,0)
 ;;=3^Dislocation Left Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,2057,1,4,0)
 ;;=4^S63.105A
 ;;^UTILITY(U,$J,358.3,2057,2)
 ;;=^5035046
 ;;^UTILITY(U,$J,358.3,2058,0)
 ;;=S63.250A^^8^91^132
 ;;^UTILITY(U,$J,358.3,2058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2058,1,3,0)
 ;;=3^Dislocation Right Index Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2058,1,4,0)
 ;;=4^S63.250A
 ;;^UTILITY(U,$J,358.3,2058,2)
 ;;=^5035265
 ;;^UTILITY(U,$J,358.3,2059,0)
 ;;=S63.256A^^8^91^133
 ;;^UTILITY(U,$J,358.3,2059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2059,1,3,0)
 ;;=3^Dislocation Right Little Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2059,1,4,0)
 ;;=4^S63.256A
 ;;^UTILITY(U,$J,358.3,2059,2)
 ;;=^5035283
 ;;^UTILITY(U,$J,358.3,2060,0)
 ;;=S63.252A^^8^91^134
 ;;^UTILITY(U,$J,358.3,2060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2060,1,3,0)
 ;;=3^Dislocation Right Middle Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2060,1,4,0)
 ;;=4^S63.252A
 ;;^UTILITY(U,$J,358.3,2060,2)
 ;;=^5035271
 ;;^UTILITY(U,$J,358.3,2061,0)
 ;;=S63.254A^^8^91^135
 ;;^UTILITY(U,$J,358.3,2061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2061,1,3,0)
 ;;=3^Dislocation Right Ring Finger,Init Encntr
 ;;^UTILITY(U,$J,358.3,2061,1,4,0)
 ;;=4^S63.254A
 ;;^UTILITY(U,$J,358.3,2061,2)
 ;;=^5035277
 ;;^UTILITY(U,$J,358.3,2062,0)
 ;;=S63.104A^^8^91^136
 ;;^UTILITY(U,$J,358.3,2062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2062,1,3,0)
 ;;=3^Dislocation Right Thumb,Init Encntr
 ;;^UTILITY(U,$J,358.3,2062,1,4,0)
 ;;=4^S63.104A
 ;;^UTILITY(U,$J,358.3,2062,2)
 ;;=^5035043
 ;;^UTILITY(U,$J,358.3,2063,0)
 ;;=H02.105^^8^91^138
 ;;^UTILITY(U,$J,358.3,2063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2063,1,3,0)
 ;;=3^Ectropion Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,2063,1,4,0)
 ;;=4^H02.105
 ;;^UTILITY(U,$J,358.3,2063,2)
 ;;=^5133409
 ;;^UTILITY(U,$J,358.3,2064,0)
 ;;=H02.104^^8^91^139
 ;;^UTILITY(U,$J,358.3,2064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2064,1,3,0)
 ;;=3^Ectropion Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,2064,1,4,0)
 ;;=4^H02.104
 ;;^UTILITY(U,$J,358.3,2064,2)
 ;;=^5004305
 ;;^UTILITY(U,$J,358.3,2065,0)
 ;;=H02.102^^8^91^140
 ;;^UTILITY(U,$J,358.3,2065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2065,1,3,0)
 ;;=3^Ectropion Right Lower Eyelid
 ;;^UTILITY(U,$J,358.3,2065,1,4,0)
 ;;=4^H02.102
 ;;^UTILITY(U,$J,358.3,2065,2)
 ;;=^5133407
 ;;^UTILITY(U,$J,358.3,2066,0)
 ;;=H02.101^^8^91^141
 ;;^UTILITY(U,$J,358.3,2066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2066,1,3,0)
 ;;=3^Ectropion Right Upper Eyelid
 ;;^UTILITY(U,$J,358.3,2066,1,4,0)
 ;;=4^H02.101
 ;;^UTILITY(U,$J,358.3,2066,2)
 ;;=^5004303
 ;;^UTILITY(U,$J,358.3,2067,0)
 ;;=S62.307A^^8^91^147
 ;;^UTILITY(U,$J,358.3,2067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2067,1,3,0)
 ;;=3^Fx Fifth Metacarpal Bone,Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,2067,1,4,0)
 ;;=4^S62.307A
 ;;^UTILITY(U,$J,358.3,2067,2)
 ;;=^5033808
 ;;^UTILITY(U,$J,358.3,2068,0)
 ;;=S62.306A^^8^91^148
 ;;^UTILITY(U,$J,358.3,2068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2068,1,3,0)
 ;;=3^Fx Fifth Metacarpal Bone,Right Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,2068,1,4,0)
 ;;=4^S62.306A
 ;;^UTILITY(U,$J,358.3,2068,2)
 ;;=^5033801
 ;;^UTILITY(U,$J,358.3,2069,0)
 ;;=S62.305A^^8^91^149
 ;;^UTILITY(U,$J,358.3,2069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2069,1,3,0)
 ;;=3^Fx Fourth Metacarpal Bone,Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,2069,1,4,0)
 ;;=4^S62.305A
 ;;^UTILITY(U,$J,358.3,2069,2)
 ;;=^5033794
 ;;^UTILITY(U,$J,358.3,2070,0)
 ;;=S62.304A^^8^91^150
 ;;^UTILITY(U,$J,358.3,2070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2070,1,3,0)
 ;;=3^Fx Fourth Metacarpal Bone,Right Hand,Init Encntr
