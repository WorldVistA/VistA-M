IBDEI07X ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19300,0)
 ;;=99080^^64^789^38^^^^1
 ;;^UTILITY(U,$J,358.3,19300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19300,1,2,0)
 ;;=2^Special Reports or Forms
 ;;^UTILITY(U,$J,358.3,19300,1,3,0)
 ;;=3^99080
 ;;^UTILITY(U,$J,358.3,19301,0)
 ;;=29105^^64^789^3^^^^1
 ;;^UTILITY(U,$J,358.3,19301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19301,1,2,0)
 ;;=2^Apply Long Arm Splint,Static
 ;;^UTILITY(U,$J,358.3,19301,1,3,0)
 ;;=3^29105
 ;;^UTILITY(U,$J,358.3,19302,0)
 ;;=29125^^64^789^6^^^^1
 ;;^UTILITY(U,$J,358.3,19302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19302,1,2,0)
 ;;=2^Apply Short Arm Splint,Static
 ;;^UTILITY(U,$J,358.3,19302,1,3,0)
 ;;=3^29125
 ;;^UTILITY(U,$J,358.3,19303,0)
 ;;=29126^^64^789^5^^^^1
 ;;^UTILITY(U,$J,358.3,19303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19303,1,2,0)
 ;;=2^Apply Short Arm Splint,Dynamic
 ;;^UTILITY(U,$J,358.3,19303,1,3,0)
 ;;=3^29126
 ;;^UTILITY(U,$J,358.3,19304,0)
 ;;=29130^^64^789^2^^^^1
 ;;^UTILITY(U,$J,358.3,19304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19304,1,2,0)
 ;;=2^Apply Finger Splint,Static
 ;;^UTILITY(U,$J,358.3,19304,1,3,0)
 ;;=3^29130
 ;;^UTILITY(U,$J,358.3,19305,0)
 ;;=29131^^64^789^1^^^^1
 ;;^UTILITY(U,$J,358.3,19305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19305,1,2,0)
 ;;=2^Apply Finger Splint,Dynamic
 ;;^UTILITY(U,$J,358.3,19305,1,3,0)
 ;;=3^29131
 ;;^UTILITY(U,$J,358.3,19306,0)
 ;;=S9451^^64^789^19^^^^1
 ;;^UTILITY(U,$J,358.3,19306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19306,1,2,0)
 ;;=2^Exercise Class per Session
 ;;^UTILITY(U,$J,358.3,19306,1,3,0)
 ;;=3^S9451
 ;;^UTILITY(U,$J,358.3,19307,0)
 ;;=97129^^64^789^45^^^^1
 ;;^UTILITY(U,$J,358.3,19307,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19307,1,2,0)
 ;;=2^Therapy Intrvn Cognitive Func,1st 15 min
 ;;^UTILITY(U,$J,358.3,19307,1,3,0)
 ;;=3^97129
 ;;^UTILITY(U,$J,358.3,19308,0)
 ;;=97130^^64^789^46^^^^1
 ;;^UTILITY(U,$J,358.3,19308,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19308,1,2,0)
 ;;=2^Therapy Intrvn Cognitive Func,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,19308,1,3,0)
 ;;=3^97130
 ;;^UTILITY(U,$J,358.3,19309,0)
 ;;=90912^^64^789^9^^^^1
 ;;^UTILITY(U,$J,358.3,19309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19309,1,2,0)
 ;;=2^Biofdbk Trng Peri/Uro/Rectal,1st 15 min
 ;;^UTILITY(U,$J,358.3,19309,1,3,0)
 ;;=3^90912
 ;;^UTILITY(U,$J,358.3,19310,0)
 ;;=90913^^64^789^10^^^^1
 ;;^UTILITY(U,$J,358.3,19310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19310,1,2,0)
 ;;=2^Biofdbk Trng Peri/Uro/Rectal,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,19310,1,3,0)
 ;;=3^90913
 ;;^UTILITY(U,$J,358.3,19311,0)
 ;;=S06.0X1A^^65^790^1
 ;;^UTILITY(U,$J,358.3,19311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19311,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,19311,1,4,0)
 ;;=4^S06.0X1A
 ;;^UTILITY(U,$J,358.3,19311,2)
 ;;=^5020669
 ;;^UTILITY(U,$J,358.3,19312,0)
 ;;=S06.0X9A^^65^790^2
 ;;^UTILITY(U,$J,358.3,19312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19312,1,3,0)
 ;;=3^Concussion w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,19312,1,4,0)
 ;;=4^S06.0X9A
 ;;^UTILITY(U,$J,358.3,19312,2)
 ;;=^5020693
 ;;^UTILITY(U,$J,358.3,19313,0)
 ;;=S06.0X0A^^65^790^3
 ;;^UTILITY(U,$J,358.3,19313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19313,1,3,0)
 ;;=3^Concussion w/o LOC, initial encounter
 ;;^UTILITY(U,$J,358.3,19313,1,4,0)
 ;;=4^S06.0X0A
 ;;^UTILITY(U,$J,358.3,19313,2)
 ;;=^5020666
 ;;^UTILITY(U,$J,358.3,19314,0)
 ;;=Z13.850^^65^790^14
 ;;^UTILITY(U,$J,358.3,19314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19314,1,3,0)
 ;;=3^TBI Screening
 ;;^UTILITY(U,$J,358.3,19314,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,19314,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,19315,0)
 ;;=Z87.820^^65^790^13
 ;;^UTILITY(U,$J,358.3,19315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19315,1,3,0)
 ;;=3^Personal history of traumatic brain injury
 ;;^UTILITY(U,$J,358.3,19315,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,19315,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,19316,0)
 ;;=S06.890A^^65^790^11
 ;;^UTILITY(U,$J,358.3,19316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19316,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,19316,1,4,0)
 ;;=4^S06.890A
 ;;^UTILITY(U,$J,358.3,19316,2)
 ;;=^5021176
 ;;^UTILITY(U,$J,358.3,19317,0)
 ;;=S06.1X5A^^65^790^15
 ;;^UTILITY(U,$J,358.3,19317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19317,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,19317,1,4,0)
 ;;=4^S06.1X5A
 ;;^UTILITY(U,$J,358.3,19317,2)
 ;;=^5020711
 ;;^UTILITY(U,$J,358.3,19318,0)
 ;;=S06.1X6A^^65^790^16
 ;;^UTILITY(U,$J,358.3,19318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19318,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,19318,1,4,0)
 ;;=4^S06.1X6A
 ;;^UTILITY(U,$J,358.3,19318,2)
 ;;=^5020714
 ;;^UTILITY(U,$J,358.3,19319,0)
 ;;=S06.1X3A^^65^790^17
 ;;^UTILITY(U,$J,358.3,19319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19319,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,19319,1,4,0)
 ;;=4^S06.1X3A
 ;;^UTILITY(U,$J,358.3,19319,2)
 ;;=^5020705
 ;;^UTILITY(U,$J,358.3,19320,0)
 ;;=S06.1X1A^^65^790^18
 ;;^UTILITY(U,$J,358.3,19320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19320,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,19320,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,19320,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,19321,0)
 ;;=S06.1X2A^^65^790^19
 ;;^UTILITY(U,$J,358.3,19321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19321,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,19321,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,19321,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,19322,0)
 ;;=S06.1X4A^^65^790^20
 ;;^UTILITY(U,$J,358.3,19322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19322,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,19322,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,19322,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,19323,0)
 ;;=S06.1X7A^^65^790^22
 ;;^UTILITY(U,$J,358.3,19323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19323,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,19323,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,19323,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,19324,0)
 ;;=S06.1X8A^^65^790^23
 ;;^UTILITY(U,$J,358.3,19324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19324,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,19324,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,19324,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,19325,0)
 ;;=S06.1X9A^^65^790^21
 ;;^UTILITY(U,$J,358.3,19325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19325,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,19325,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,19325,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,19326,0)
 ;;=S06.1X0A^^65^790^24
 ;;^UTILITY(U,$J,358.3,19326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19326,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,19326,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,19326,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,19327,0)
 ;;=S06.9X5A^^65^790^4
 ;;^UTILITY(U,$J,358.3,19327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19327,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w ret consc lev, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,19327,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,19327,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,19328,0)
 ;;=S06.9X6A^^65^790^5
 ;;^UTILITY(U,$J,358.3,19328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19328,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w/o ret consc w surv, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,19328,1,4,0)
 ;;=4^S06.9X6A
 ;;^UTILITY(U,$J,358.3,19328,2)
 ;;=^5021224
 ;;^UTILITY(U,$J,358.3,19329,0)
 ;;=S06.9X3A^^65^790^6
 ;;^UTILITY(U,$J,358.3,19329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19329,1,3,0)
 ;;=3^Intcrn inj w LOC of 1-5 hrs 59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,19329,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,19329,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,19330,0)
 ;;=S06.9X1A^^65^790^7
 ;;^UTILITY(U,$J,358.3,19330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19330,1,3,0)
 ;;=3^Intcrn inj w LOC of 30 minutes or less, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,19330,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,19330,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,19331,0)
 ;;=S06.9X2A^^65^790^8
 ;;^UTILITY(U,$J,358.3,19331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19331,1,3,0)
 ;;=3^Intcrn inj w LOC of 31-59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,19331,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,19331,2)
 ;;=^5021212
 ;;^UTILITY(U,$J,358.3,19332,0)
 ;;=S06.9X4A^^65^790^9
 ;;^UTILITY(U,$J,358.3,19332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19332,1,3,0)
 ;;=3^Intcrn inj w LOC of 6 hours to 24 hours, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,19332,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,19332,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,19333,0)
 ;;=S06.9X9A^^65^790^10
 ;;^UTILITY(U,$J,358.3,19333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19333,1,3,0)
 ;;=3^Intcrn inj w LOC of unsp duration, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,19333,1,4,0)
 ;;=4^S06.9X9A
 ;;^UTILITY(U,$J,358.3,19333,2)
 ;;=^5021233
 ;;^UTILITY(U,$J,358.3,19334,0)
 ;;=S06.9X0A^^65^790^12
 ;;^UTILITY(U,$J,358.3,19334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19334,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,19334,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,19334,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,19335,0)
 ;;=S78.019S^^65^791^4
 ;;^UTILITY(U,$J,358.3,19335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19335,1,3,0)
 ;;=3^Complete traumatic amputation at unsp hip joint, sequela
 ;;^UTILITY(U,$J,358.3,19335,1,4,0)
 ;;=4^S78.019S
 ;;^UTILITY(U,$J,358.3,19335,2)
 ;;=^5039710
 ;;^UTILITY(U,$J,358.3,19336,0)
 ;;=S68.419S^^65^791^1
 ;;^UTILITY(U,$J,358.3,19336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19336,1,3,0)
 ;;=3^Complete traumatic amp of unsp hand at wrist level, sequela
 ;;^UTILITY(U,$J,358.3,19336,1,4,0)
 ;;=4^S68.419S
 ;;^UTILITY(U,$J,358.3,19336,2)
 ;;=^5036707
 ;;^UTILITY(U,$J,358.3,19337,0)
 ;;=S88.919S^^65^791^2
 ;;^UTILITY(U,$J,358.3,19337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19337,1,3,0)
 ;;=3^Complete traumatic amp of unsp low leg, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,19337,1,4,0)
 ;;=4^S88.919S
 ;;^UTILITY(U,$J,358.3,19337,2)
 ;;=^5137219
 ;;^UTILITY(U,$J,358.3,19338,0)
 ;;=S48.919S^^65^791^3
 ;;^UTILITY(U,$J,358.3,19338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19338,1,3,0)
 ;;=3^Complete traumatic amp of unsp shldr/up arm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,19338,1,4,0)
 ;;=4^S48.919S
 ;;^UTILITY(U,$J,358.3,19338,2)
 ;;=^5028331
 ;;^UTILITY(U,$J,358.3,19339,0)
 ;;=S14.2XXS^^65^791^6
 ;;^UTILITY(U,$J,358.3,19339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19339,1,3,0)
 ;;=3^Injury of nerve root of cervical spine, sequela
 ;;^UTILITY(U,$J,358.3,19339,1,4,0)
 ;;=4^S14.2XXS
 ;;^UTILITY(U,$J,358.3,19339,2)
 ;;=^5022204
 ;;^UTILITY(U,$J,358.3,19340,0)
 ;;=S34.21XS^^65^791^7
 ;;^UTILITY(U,$J,358.3,19340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19340,1,3,0)
 ;;=3^Injury of nerve root of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,19340,1,4,0)
 ;;=4^S34.21XS
 ;;^UTILITY(U,$J,358.3,19340,2)
 ;;=^5025252
 ;;^UTILITY(U,$J,358.3,19341,0)
 ;;=S34.22XS^^65^791^8
 ;;^UTILITY(U,$J,358.3,19341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19341,1,3,0)
 ;;=3^Injury of nerve root of sacral spine, sequela
 ;;^UTILITY(U,$J,358.3,19341,1,4,0)
 ;;=4^S34.22XS
 ;;^UTILITY(U,$J,358.3,19341,2)
 ;;=^5025255
 ;;^UTILITY(U,$J,358.3,19342,0)
 ;;=S24.2XXS^^65^791^9
 ;;^UTILITY(U,$J,358.3,19342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19342,1,3,0)
 ;;=3^Injury of nerve root of thoracic spine, sequela
 ;;^UTILITY(U,$J,358.3,19342,1,4,0)
 ;;=4^S24.2XXS
 ;;^UTILITY(U,$J,358.3,19342,2)
 ;;=^5023347
 ;;^UTILITY(U,$J,358.3,19343,0)
 ;;=S04.9XXS^^65^791^11
 ;;^UTILITY(U,$J,358.3,19343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19343,1,3,0)
 ;;=3^Injury of unspec cranial nerve, sequela
 ;;^UTILITY(U,$J,358.3,19343,1,4,0)
 ;;=4^S04.9XXS
 ;;^UTILITY(U,$J,358.3,19343,2)
 ;;=^5020575
 ;;^UTILITY(U,$J,358.3,19344,0)
 ;;=S24.9XXS^^65^791^12
 ;;^UTILITY(U,$J,358.3,19344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19344,1,3,0)
 ;;=3^Injury of unspec nerve of thorax, sequela
 ;;^UTILITY(U,$J,358.3,19344,1,4,0)
 ;;=4^S24.9XXS
 ;;^UTILITY(U,$J,358.3,19344,2)
 ;;=^5023359
 ;;^UTILITY(U,$J,358.3,19345,0)
 ;;=S34.9XXS^^65^791^18
 ;;^UTILITY(U,$J,358.3,19345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19345,1,3,0)
 ;;=3^Injury to unspec nerves at abd/low back/pelvis level, sequela
 ;;^UTILITY(U,$J,358.3,19345,1,4,0)
 ;;=4^S34.9XXS
 ;;^UTILITY(U,$J,358.3,19345,2)
 ;;=^5025273
 ;;^UTILITY(U,$J,358.3,19346,0)
 ;;=S14.9XXS^^65^791^13
 ;;^UTILITY(U,$J,358.3,19346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19346,1,3,0)
 ;;=3^Injury of unspec nerves of neck, sequela
 ;;^UTILITY(U,$J,358.3,19346,1,4,0)
 ;;=4^S14.9XXS
 ;;^UTILITY(U,$J,358.3,19346,2)
 ;;=^5022219
 ;;^UTILITY(U,$J,358.3,19347,0)
 ;;=S58.922S^^65^791^20
 ;;^UTILITY(U,$J,358.3,19347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19347,1,3,0)
 ;;=3^Partial traumatic amp of l forearm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,19347,1,4,0)
 ;;=4^S58.922S
 ;;^UTILITY(U,$J,358.3,19347,2)
 ;;=^5031957
 ;;^UTILITY(U,$J,358.3,19348,0)
 ;;=S14.109S^^65^791^15
 ;;^UTILITY(U,$J,358.3,19348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19348,1,3,0)
 ;;=3^Injury to unsp level of cervical spinal cord unspec, sequela
 ;;^UTILITY(U,$J,358.3,19348,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,19348,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,19349,0)
 ;;=S24.109S^^65^791^17
 ;;^UTILITY(U,$J,358.3,19349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19349,1,3,0)
 ;;=3^Injury to unsp level of thoracic spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,19349,1,4,0)
 ;;=4^S24.109S
 ;;^UTILITY(U,$J,358.3,19349,2)
 ;;=^5134384
 ;;^UTILITY(U,$J,358.3,19350,0)
 ;;=S34.139S^^65^791^14
 ;;^UTILITY(U,$J,358.3,19350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19350,1,3,0)
 ;;=3^Injury to sacral spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,19350,1,4,0)
 ;;=4^S34.139S
 ;;^UTILITY(U,$J,358.3,19350,2)
 ;;=^5025249
 ;;^UTILITY(U,$J,358.3,19351,0)
 ;;=S34.109S^^65^791^16
 ;;^UTILITY(U,$J,358.3,19351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19351,1,3,0)
 ;;=3^Injury to unsp level of lumbar spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,19351,1,4,0)
 ;;=4^S34.109S
 ;;^UTILITY(U,$J,358.3,19351,2)
 ;;=^5134570
 ;;^UTILITY(U,$J,358.3,19352,0)
 ;;=S06.9X9S^^65^791^19
 ;;^UTILITY(U,$J,358.3,19352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19352,1,3,0)
 ;;=3^Intracranial injury w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19352,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,19352,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,19353,0)
 ;;=S15.002A^^65^791^5
 ;;^UTILITY(U,$J,358.3,19353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19353,1,3,0)
 ;;=3^Injury of left carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,19353,1,4,0)
 ;;=4^S15.002A
 ;;^UTILITY(U,$J,358.3,19353,2)
 ;;=^5022223
 ;;^UTILITY(U,$J,358.3,19354,0)
 ;;=S15.001A^^65^791^10
 ;;^UTILITY(U,$J,358.3,19354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19354,1,3,0)
 ;;=3^Injury of right carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,19354,1,4,0)
 ;;=4^S15.001A
 ;;^UTILITY(U,$J,358.3,19354,2)
 ;;=^5022220
 ;;^UTILITY(U,$J,358.3,19355,0)
 ;;=I69.952^^65^792^12
 ;;^UTILITY(U,$J,358.3,19355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19355,1,3,0)
 ;;=3^Hemiplagia,Left Dominant Side
 ;;^UTILITY(U,$J,358.3,19355,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,19355,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,19356,0)
 ;;=I69.954^^65^792^13
 ;;^UTILITY(U,$J,358.3,19356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19356,1,3,0)
 ;;=3^Hemiplegia,Left Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,19356,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,19356,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,19357,0)
 ;;=I69.951^^65^792^14
 ;;^UTILITY(U,$J,358.3,19357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19357,1,3,0)
 ;;=3^Hemiplegia,Right Dominant Side
 ;;^UTILITY(U,$J,358.3,19357,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,19357,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,19358,0)
 ;;=I69.953^^65^792^15
 ;;^UTILITY(U,$J,358.3,19358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19358,1,3,0)
 ;;=3^Hemiplegia,Right Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,19358,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,19358,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,19359,0)
 ;;=I69.920^^65^792^1
 ;;^UTILITY(U,$J,358.3,19359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19359,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,19359,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,19359,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,19360,0)
 ;;=I69.90^^65^792^30
 ;;^UTILITY(U,$J,358.3,19360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19360,1,3,0)
 ;;=3^Unspec Sequela of Unspec CVA
 ;;^UTILITY(U,$J,358.3,19360,1,4,0)
 ;;=4^I69.90
 ;;^UTILITY(U,$J,358.3,19360,2)
 ;;=^5007551
 ;;^UTILITY(U,$J,358.3,19361,0)
 ;;=I69.910^^65^792^4
 ;;^UTILITY(U,$J,358.3,19361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19361,1,3,0)
 ;;=3^Attention & Concentration Deficit
 ;;^UTILITY(U,$J,358.3,19361,1,4,0)
 ;;=4^I69.910
 ;;^UTILITY(U,$J,358.3,19361,2)
 ;;=^5138660
 ;;^UTILITY(U,$J,358.3,19362,0)
 ;;=I69.911^^65^792^16
 ;;^UTILITY(U,$J,358.3,19362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19362,1,3,0)
 ;;=3^Memory Deficit
 ;;^UTILITY(U,$J,358.3,19362,1,4,0)
 ;;=4^I69.911
 ;;^UTILITY(U,$J,358.3,19362,2)
 ;;=^5138661
 ;;^UTILITY(U,$J,358.3,19363,0)
 ;;=I69.912^^65^792^31
 ;;^UTILITY(U,$J,358.3,19363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19363,1,3,0)
 ;;=3^Visuspatial Deficit & Spatial Neglect
 ;;^UTILITY(U,$J,358.3,19363,1,4,0)
 ;;=4^I69.912
 ;;^UTILITY(U,$J,358.3,19363,2)
 ;;=^5138662
 ;;^UTILITY(U,$J,358.3,19364,0)
 ;;=I69.913^^65^792^27
 ;;^UTILITY(U,$J,358.3,19364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19364,1,3,0)
 ;;=3^Psychomotor Deficit
 ;;^UTILITY(U,$J,358.3,19364,1,4,0)
 ;;=4^I69.913
 ;;^UTILITY(U,$J,358.3,19364,2)
 ;;=^5138663
 ;;^UTILITY(U,$J,358.3,19365,0)
 ;;=I69.914^^65^792^11
 ;;^UTILITY(U,$J,358.3,19365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19365,1,3,0)
 ;;=3^Frontal Lobe & Executive Function Deficit
 ;;^UTILITY(U,$J,358.3,19365,1,4,0)
 ;;=4^I69.914
 ;;^UTILITY(U,$J,358.3,19365,2)
 ;;=^5138664
 ;;^UTILITY(U,$J,358.3,19366,0)
 ;;=I69.915^^65^792^5
 ;;^UTILITY(U,$J,358.3,19366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19366,1,3,0)
 ;;=3^Cognitive Social/Emotional Deficit
 ;;^UTILITY(U,$J,358.3,19366,1,4,0)
 ;;=4^I69.915
 ;;^UTILITY(U,$J,358.3,19366,2)
 ;;=^5138665
