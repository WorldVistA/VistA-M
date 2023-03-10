IBDEI08B ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20272,2)
 ;;=^5020693
 ;;^UTILITY(U,$J,358.3,20273,0)
 ;;=S06.0X0A^^68^838^3
 ;;^UTILITY(U,$J,358.3,20273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20273,1,3,0)
 ;;=3^Concussion w/o LOC, initial encounter
 ;;^UTILITY(U,$J,358.3,20273,1,4,0)
 ;;=4^S06.0X0A
 ;;^UTILITY(U,$J,358.3,20273,2)
 ;;=^5020666
 ;;^UTILITY(U,$J,358.3,20274,0)
 ;;=Z13.850^^68^838^14
 ;;^UTILITY(U,$J,358.3,20274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20274,1,3,0)
 ;;=3^TBI Screening
 ;;^UTILITY(U,$J,358.3,20274,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,20274,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,20275,0)
 ;;=Z87.820^^68^838^13
 ;;^UTILITY(U,$J,358.3,20275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20275,1,3,0)
 ;;=3^Personal history of traumatic brain injury
 ;;^UTILITY(U,$J,358.3,20275,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,20275,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,20276,0)
 ;;=S06.890A^^68^838^11
 ;;^UTILITY(U,$J,358.3,20276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20276,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr
 ;;^UTILITY(U,$J,358.3,20276,1,4,0)
 ;;=4^S06.890A
 ;;^UTILITY(U,$J,358.3,20276,2)
 ;;=^5021176
 ;;^UTILITY(U,$J,358.3,20277,0)
 ;;=S06.1X5A^^68^838^15
 ;;^UTILITY(U,$J,358.3,20277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20277,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,20277,1,4,0)
 ;;=4^S06.1X5A
 ;;^UTILITY(U,$J,358.3,20277,2)
 ;;=^5020711
 ;;^UTILITY(U,$J,358.3,20278,0)
 ;;=S06.1X6A^^68^838^16
 ;;^UTILITY(U,$J,358.3,20278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20278,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,20278,1,4,0)
 ;;=4^S06.1X6A
 ;;^UTILITY(U,$J,358.3,20278,2)
 ;;=^5020714
 ;;^UTILITY(U,$J,358.3,20279,0)
 ;;=S06.1X3A^^68^838^17
 ;;^UTILITY(U,$J,358.3,20279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20279,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,20279,1,4,0)
 ;;=4^S06.1X3A
 ;;^UTILITY(U,$J,358.3,20279,2)
 ;;=^5020705
 ;;^UTILITY(U,$J,358.3,20280,0)
 ;;=S06.1X1A^^68^838^18
 ;;^UTILITY(U,$J,358.3,20280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20280,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,20280,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,20280,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,20281,0)
 ;;=S06.1X2A^^68^838^19
 ;;^UTILITY(U,$J,358.3,20281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20281,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,20281,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,20281,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,20282,0)
 ;;=S06.1X4A^^68^838^20
 ;;^UTILITY(U,$J,358.3,20282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20282,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,20282,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,20282,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,20283,0)
 ;;=S06.1X7A^^68^838^22
 ;;^UTILITY(U,$J,358.3,20283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20283,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,20283,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,20283,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,20284,0)
 ;;=S06.1X8A^^68^838^23
 ;;^UTILITY(U,$J,358.3,20284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20284,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,20284,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,20284,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,20285,0)
 ;;=S06.1X9A^^68^838^21
 ;;^UTILITY(U,$J,358.3,20285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20285,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,20285,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,20285,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,20286,0)
 ;;=S06.1X0A^^68^838^24
 ;;^UTILITY(U,$J,358.3,20286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20286,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, init
 ;;^UTILITY(U,$J,358.3,20286,1,4,0)
 ;;=4^S06.1X0A
 ;;^UTILITY(U,$J,358.3,20286,2)
 ;;=^5020696
 ;;^UTILITY(U,$J,358.3,20287,0)
 ;;=S06.9X5A^^68^838^4
 ;;^UTILITY(U,$J,358.3,20287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20287,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w ret consc lev, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,20287,1,4,0)
 ;;=4^S06.9X5A
 ;;^UTILITY(U,$J,358.3,20287,2)
 ;;=^5021221
 ;;^UTILITY(U,$J,358.3,20288,0)
 ;;=S06.9X6A^^68^838^5
 ;;^UTILITY(U,$J,358.3,20288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20288,1,3,0)
 ;;=3^Intcrn inj w LOC >24 hr w/o ret consc w surv, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,20288,1,4,0)
 ;;=4^S06.9X6A
 ;;^UTILITY(U,$J,358.3,20288,2)
 ;;=^5021224
 ;;^UTILITY(U,$J,358.3,20289,0)
 ;;=S06.9X3A^^68^838^6
 ;;^UTILITY(U,$J,358.3,20289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20289,1,3,0)
 ;;=3^Intcrn inj w LOC of 1-5 hrs 59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,20289,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,20289,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,20290,0)
 ;;=S06.9X1A^^68^838^7
 ;;^UTILITY(U,$J,358.3,20290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20290,1,3,0)
 ;;=3^Intcrn inj w LOC of 30 minutes or less, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,20290,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,20290,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,20291,0)
 ;;=S06.9X2A^^68^838^8
 ;;^UTILITY(U,$J,358.3,20291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20291,1,3,0)
 ;;=3^Intcrn inj w LOC of 31-59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,20291,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,20291,2)
 ;;=^5021212
 ;;^UTILITY(U,$J,358.3,20292,0)
 ;;=S06.9X4A^^68^838^9
 ;;^UTILITY(U,$J,358.3,20292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20292,1,3,0)
 ;;=3^Intcrn inj w LOC of 6 hours to 24 hours, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,20292,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,20292,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,20293,0)
 ;;=S06.9X9A^^68^838^10
 ;;^UTILITY(U,$J,358.3,20293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20293,1,3,0)
 ;;=3^Intcrn inj w LOC of unsp duration, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,20293,1,4,0)
 ;;=4^S06.9X9A
 ;;^UTILITY(U,$J,358.3,20293,2)
 ;;=^5021233
 ;;^UTILITY(U,$J,358.3,20294,0)
 ;;=S06.9X0A^^68^838^12
 ;;^UTILITY(U,$J,358.3,20294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20294,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,20294,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,20294,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,20295,0)
 ;;=S78.019S^^68^839^4
 ;;^UTILITY(U,$J,358.3,20295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20295,1,3,0)
 ;;=3^Complete traumatic amputation at unsp hip joint, sequela
 ;;^UTILITY(U,$J,358.3,20295,1,4,0)
 ;;=4^S78.019S
 ;;^UTILITY(U,$J,358.3,20295,2)
 ;;=^5039710
 ;;^UTILITY(U,$J,358.3,20296,0)
 ;;=S68.419S^^68^839^1
 ;;^UTILITY(U,$J,358.3,20296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20296,1,3,0)
 ;;=3^Complete traumatic amp of unsp hand at wrist level, sequela
 ;;^UTILITY(U,$J,358.3,20296,1,4,0)
 ;;=4^S68.419S
 ;;^UTILITY(U,$J,358.3,20296,2)
 ;;=^5036707
 ;;^UTILITY(U,$J,358.3,20297,0)
 ;;=S88.919S^^68^839^2
 ;;^UTILITY(U,$J,358.3,20297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20297,1,3,0)
 ;;=3^Complete traumatic amp of unsp low leg, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,20297,1,4,0)
 ;;=4^S88.919S
 ;;^UTILITY(U,$J,358.3,20297,2)
 ;;=^5137219
 ;;^UTILITY(U,$J,358.3,20298,0)
 ;;=S48.919S^^68^839^3
 ;;^UTILITY(U,$J,358.3,20298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20298,1,3,0)
 ;;=3^Complete traumatic amp of unsp shldr/up arm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,20298,1,4,0)
 ;;=4^S48.919S
 ;;^UTILITY(U,$J,358.3,20298,2)
 ;;=^5028331
 ;;^UTILITY(U,$J,358.3,20299,0)
 ;;=S14.2XXS^^68^839^6
 ;;^UTILITY(U,$J,358.3,20299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20299,1,3,0)
 ;;=3^Injury of nerve root of cervical spine, sequela
 ;;^UTILITY(U,$J,358.3,20299,1,4,0)
 ;;=4^S14.2XXS
 ;;^UTILITY(U,$J,358.3,20299,2)
 ;;=^5022204
 ;;^UTILITY(U,$J,358.3,20300,0)
 ;;=S34.21XS^^68^839^7
 ;;^UTILITY(U,$J,358.3,20300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20300,1,3,0)
 ;;=3^Injury of nerve root of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,20300,1,4,0)
 ;;=4^S34.21XS
 ;;^UTILITY(U,$J,358.3,20300,2)
 ;;=^5025252
 ;;^UTILITY(U,$J,358.3,20301,0)
 ;;=S34.22XS^^68^839^8
 ;;^UTILITY(U,$J,358.3,20301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20301,1,3,0)
 ;;=3^Injury of nerve root of sacral spine, sequela
 ;;^UTILITY(U,$J,358.3,20301,1,4,0)
 ;;=4^S34.22XS
 ;;^UTILITY(U,$J,358.3,20301,2)
 ;;=^5025255
 ;;^UTILITY(U,$J,358.3,20302,0)
 ;;=S24.2XXS^^68^839^9
 ;;^UTILITY(U,$J,358.3,20302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20302,1,3,0)
 ;;=3^Injury of nerve root of thoracic spine, sequela
 ;;^UTILITY(U,$J,358.3,20302,1,4,0)
 ;;=4^S24.2XXS
 ;;^UTILITY(U,$J,358.3,20302,2)
 ;;=^5023347
 ;;^UTILITY(U,$J,358.3,20303,0)
 ;;=S04.9XXS^^68^839^11
 ;;^UTILITY(U,$J,358.3,20303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20303,1,3,0)
 ;;=3^Injury of unspec cranial nerve, sequela
 ;;^UTILITY(U,$J,358.3,20303,1,4,0)
 ;;=4^S04.9XXS
 ;;^UTILITY(U,$J,358.3,20303,2)
 ;;=^5020575
 ;;^UTILITY(U,$J,358.3,20304,0)
 ;;=S24.9XXS^^68^839^12
 ;;^UTILITY(U,$J,358.3,20304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20304,1,3,0)
 ;;=3^Injury of unspec nerve of thorax, sequela
 ;;^UTILITY(U,$J,358.3,20304,1,4,0)
 ;;=4^S24.9XXS
 ;;^UTILITY(U,$J,358.3,20304,2)
 ;;=^5023359
 ;;^UTILITY(U,$J,358.3,20305,0)
 ;;=S34.9XXS^^68^839^18
 ;;^UTILITY(U,$J,358.3,20305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20305,1,3,0)
 ;;=3^Injury to unspec nerves at abd/low back/pelvis level, sequela
 ;;^UTILITY(U,$J,358.3,20305,1,4,0)
 ;;=4^S34.9XXS
 ;;^UTILITY(U,$J,358.3,20305,2)
 ;;=^5025273
 ;;^UTILITY(U,$J,358.3,20306,0)
 ;;=S14.9XXS^^68^839^13
 ;;^UTILITY(U,$J,358.3,20306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20306,1,3,0)
 ;;=3^Injury of unspec nerves of neck, sequela
 ;;^UTILITY(U,$J,358.3,20306,1,4,0)
 ;;=4^S14.9XXS
 ;;^UTILITY(U,$J,358.3,20306,2)
 ;;=^5022219
 ;;^UTILITY(U,$J,358.3,20307,0)
 ;;=S58.922S^^68^839^20
 ;;^UTILITY(U,$J,358.3,20307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20307,1,3,0)
 ;;=3^Partial traumatic amp of l forearm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,20307,1,4,0)
 ;;=4^S58.922S
 ;;^UTILITY(U,$J,358.3,20307,2)
 ;;=^5031957
 ;;^UTILITY(U,$J,358.3,20308,0)
 ;;=S14.109S^^68^839^15
 ;;^UTILITY(U,$J,358.3,20308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20308,1,3,0)
 ;;=3^Injury to unsp level of cervical spinal cord unspec, sequela
 ;;^UTILITY(U,$J,358.3,20308,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,20308,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,20309,0)
 ;;=S24.109S^^68^839^17
 ;;^UTILITY(U,$J,358.3,20309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20309,1,3,0)
 ;;=3^Injury to unsp level of thoracic spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,20309,1,4,0)
 ;;=4^S24.109S
 ;;^UTILITY(U,$J,358.3,20309,2)
 ;;=^5134384
 ;;^UTILITY(U,$J,358.3,20310,0)
 ;;=S34.139S^^68^839^14
 ;;^UTILITY(U,$J,358.3,20310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20310,1,3,0)
 ;;=3^Injury to sacral spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,20310,1,4,0)
 ;;=4^S34.139S
 ;;^UTILITY(U,$J,358.3,20310,2)
 ;;=^5025249
 ;;^UTILITY(U,$J,358.3,20311,0)
 ;;=S34.109S^^68^839^16
 ;;^UTILITY(U,$J,358.3,20311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20311,1,3,0)
 ;;=3^Injury to unsp level of lumbar spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,20311,1,4,0)
 ;;=4^S34.109S
 ;;^UTILITY(U,$J,358.3,20311,2)
 ;;=^5134570
 ;;^UTILITY(U,$J,358.3,20312,0)
 ;;=S06.9X9S^^68^839^19
 ;;^UTILITY(U,$J,358.3,20312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20312,1,3,0)
 ;;=3^Intracranial injury w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,20312,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,20312,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,20313,0)
 ;;=S15.002A^^68^839^5
 ;;^UTILITY(U,$J,358.3,20313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20313,1,3,0)
 ;;=3^Injury of left carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,20313,1,4,0)
 ;;=4^S15.002A
 ;;^UTILITY(U,$J,358.3,20313,2)
 ;;=^5022223
 ;;^UTILITY(U,$J,358.3,20314,0)
 ;;=S15.001A^^68^839^10
 ;;^UTILITY(U,$J,358.3,20314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20314,1,3,0)
 ;;=3^Injury of right carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,20314,1,4,0)
 ;;=4^S15.001A
 ;;^UTILITY(U,$J,358.3,20314,2)
 ;;=^5022220
 ;;^UTILITY(U,$J,358.3,20315,0)
 ;;=I69.952^^68^840^12
 ;;^UTILITY(U,$J,358.3,20315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20315,1,3,0)
 ;;=3^Hemiplagia,Left Dominant Side
 ;;^UTILITY(U,$J,358.3,20315,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,20315,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,20316,0)
 ;;=I69.954^^68^840^13
 ;;^UTILITY(U,$J,358.3,20316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20316,1,3,0)
 ;;=3^Hemiplegia,Left Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,20316,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,20316,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,20317,0)
 ;;=I69.951^^68^840^14
 ;;^UTILITY(U,$J,358.3,20317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20317,1,3,0)
 ;;=3^Hemiplegia,Right Dominant Side
 ;;^UTILITY(U,$J,358.3,20317,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,20317,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,20318,0)
 ;;=I69.953^^68^840^15
 ;;^UTILITY(U,$J,358.3,20318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20318,1,3,0)
 ;;=3^Hemiplegia,Right Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,20318,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,20318,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,20319,0)
 ;;=I69.920^^68^840^1
 ;;^UTILITY(U,$J,358.3,20319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20319,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,20319,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,20319,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,20320,0)
 ;;=I69.90^^68^840^30
 ;;^UTILITY(U,$J,358.3,20320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20320,1,3,0)
 ;;=3^Unspec Sequela of Unspec CVA
 ;;^UTILITY(U,$J,358.3,20320,1,4,0)
 ;;=4^I69.90
 ;;^UTILITY(U,$J,358.3,20320,2)
 ;;=^5007551
 ;;^UTILITY(U,$J,358.3,20321,0)
 ;;=I69.910^^68^840^4
 ;;^UTILITY(U,$J,358.3,20321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20321,1,3,0)
 ;;=3^Attention & Concentration Deficit
 ;;^UTILITY(U,$J,358.3,20321,1,4,0)
 ;;=4^I69.910
 ;;^UTILITY(U,$J,358.3,20321,2)
 ;;=^5138660
 ;;^UTILITY(U,$J,358.3,20322,0)
 ;;=I69.911^^68^840^16
 ;;^UTILITY(U,$J,358.3,20322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20322,1,3,0)
 ;;=3^Memory Deficit
 ;;^UTILITY(U,$J,358.3,20322,1,4,0)
 ;;=4^I69.911
 ;;^UTILITY(U,$J,358.3,20322,2)
 ;;=^5138661
 ;;^UTILITY(U,$J,358.3,20323,0)
 ;;=I69.912^^68^840^31
 ;;^UTILITY(U,$J,358.3,20323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20323,1,3,0)
 ;;=3^Visuspatial Deficit & Spatial Neglect
 ;;^UTILITY(U,$J,358.3,20323,1,4,0)
 ;;=4^I69.912
 ;;^UTILITY(U,$J,358.3,20323,2)
 ;;=^5138662
 ;;^UTILITY(U,$J,358.3,20324,0)
 ;;=I69.913^^68^840^27
 ;;^UTILITY(U,$J,358.3,20324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20324,1,3,0)
 ;;=3^Psychomotor Deficit
 ;;^UTILITY(U,$J,358.3,20324,1,4,0)
 ;;=4^I69.913
 ;;^UTILITY(U,$J,358.3,20324,2)
 ;;=^5138663
 ;;^UTILITY(U,$J,358.3,20325,0)
 ;;=I69.914^^68^840^11
 ;;^UTILITY(U,$J,358.3,20325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20325,1,3,0)
 ;;=3^Frontal Lobe & Executive Function Deficit
 ;;^UTILITY(U,$J,358.3,20325,1,4,0)
 ;;=4^I69.914
 ;;^UTILITY(U,$J,358.3,20325,2)
 ;;=^5138664
 ;;^UTILITY(U,$J,358.3,20326,0)
 ;;=I69.915^^68^840^5
 ;;^UTILITY(U,$J,358.3,20326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20326,1,3,0)
 ;;=3^Cognitive Social/Emotional Deficit
 ;;^UTILITY(U,$J,358.3,20326,1,4,0)
 ;;=4^I69.915
 ;;^UTILITY(U,$J,358.3,20326,2)
 ;;=^5138665
 ;;^UTILITY(U,$J,358.3,20327,0)
 ;;=I69.918^^68^840^29
 ;;^UTILITY(U,$J,358.3,20327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20327,1,3,0)
 ;;=3^Symptoms/Signs Involving Cognitive Functions,Other
 ;;^UTILITY(U,$J,358.3,20327,1,4,0)
 ;;=4^I69.918
 ;;^UTILITY(U,$J,358.3,20327,2)
 ;;=^5138666
 ;;^UTILITY(U,$J,358.3,20328,0)
 ;;=I69.921^^68^840^8
 ;;^UTILITY(U,$J,358.3,20328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20328,1,3,0)
 ;;=3^Dysphasia
 ;;^UTILITY(U,$J,358.3,20328,1,4,0)
 ;;=4^I69.921
 ;;^UTILITY(U,$J,358.3,20328,2)
 ;;=^5007554
 ;;^UTILITY(U,$J,358.3,20329,0)
 ;;=I69.922^^68^840^6
 ;;^UTILITY(U,$J,358.3,20329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20329,1,3,0)
 ;;=3^Dysarthria
 ;;^UTILITY(U,$J,358.3,20329,1,4,0)
 ;;=4^I69.922
 ;;^UTILITY(U,$J,358.3,20329,2)
 ;;=^5007555
 ;;^UTILITY(U,$J,358.3,20330,0)
 ;;=I69.923^^68^840^10
 ;;^UTILITY(U,$J,358.3,20330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20330,1,3,0)
 ;;=3^Fluency Disorder
 ;;^UTILITY(U,$J,358.3,20330,1,4,0)
 ;;=4^I69.923
 ;;^UTILITY(U,$J,358.3,20330,2)
 ;;=^5007556
 ;;^UTILITY(U,$J,358.3,20331,0)
 ;;=I69.928^^68^840^28
 ;;^UTILITY(U,$J,358.3,20331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20331,1,3,0)
 ;;=3^Speech/Language Deficits,Other
 ;;^UTILITY(U,$J,358.3,20331,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,20331,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,20332,0)
 ;;=I69.961^^68^840^25
 ;;^UTILITY(U,$J,358.3,20332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20332,1,3,0)
 ;;=3^Paralytic Syndrome,Right Dominant Side
 ;;^UTILITY(U,$J,358.3,20332,1,4,0)
 ;;=4^I69.961
 ;;^UTILITY(U,$J,358.3,20332,2)
 ;;=^5007564
 ;;^UTILITY(U,$J,358.3,20333,0)
 ;;=I69.962^^68^840^23
 ;;^UTILITY(U,$J,358.3,20333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20333,1,3,0)
 ;;=3^Paralytic Syndrome,Left Dominant Side
 ;;^UTILITY(U,$J,358.3,20333,1,4,0)
 ;;=4^I69.962
 ;;^UTILITY(U,$J,358.3,20333,2)
 ;;=^5133588
 ;;^UTILITY(U,$J,358.3,20334,0)
 ;;=I69.963^^68^840^26
 ;;^UTILITY(U,$J,358.3,20334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20334,1,3,0)
 ;;=3^Paralytic Syndrome,Right Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,20334,1,4,0)
 ;;=4^I69.963
 ;;^UTILITY(U,$J,358.3,20334,2)
 ;;=^5007565
 ;;^UTILITY(U,$J,358.3,20335,0)
 ;;=I69.964^^68^840^24
 ;;^UTILITY(U,$J,358.3,20335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20335,1,3,0)
 ;;=3^Paralytic Syndrome,Left Non-Dominant Side
 ;;^UTILITY(U,$J,358.3,20335,1,4,0)
 ;;=4^I69.964
 ;;^UTILITY(U,$J,358.3,20335,2)
 ;;=^5133589
 ;;^UTILITY(U,$J,358.3,20336,0)
 ;;=I69.965^^68^840^22
 ;;^UTILITY(U,$J,358.3,20336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20336,1,3,0)
 ;;=3^Paralytic Syndrome,Bilateral
 ;;^UTILITY(U,$J,358.3,20336,1,4,0)
 ;;=4^I69.965
 ;;^UTILITY(U,$J,358.3,20336,2)
 ;;=^5007566
 ;;^UTILITY(U,$J,358.3,20337,0)
 ;;=I69.990^^68^840^2
 ;;^UTILITY(U,$J,358.3,20337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20337,1,3,0)
 ;;=3^Apraxia
 ;;^UTILITY(U,$J,358.3,20337,1,4,0)
 ;;=4^I69.990
 ;;^UTILITY(U,$J,358.3,20337,2)
 ;;=^5007568
 ;;^UTILITY(U,$J,358.3,20338,0)
 ;;=I69.991^^68^840^7
