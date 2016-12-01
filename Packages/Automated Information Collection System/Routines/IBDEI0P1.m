IBDEI0P1 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31742,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,31742,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,31743,0)
 ;;=S06.9X1A^^94^1399^12
 ;;^UTILITY(U,$J,358.3,31743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31743,1,3,0)
 ;;=3^Intcrn inj w LOC of 30 minutes or less, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31743,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,31743,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,31744,0)
 ;;=S06.9X2A^^94^1399^13
 ;;^UTILITY(U,$J,358.3,31744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31744,1,3,0)
 ;;=3^Intcrn inj w LOC of 31-59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31744,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,31744,2)
 ;;=^5021212
 ;;^UTILITY(U,$J,358.3,31745,0)
 ;;=S06.9X4A^^94^1399^14
 ;;^UTILITY(U,$J,358.3,31745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31745,1,3,0)
 ;;=3^Intcrn inj w LOC of 6 hours to 24 hours, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31745,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,31745,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,31746,0)
 ;;=S06.9X9A^^94^1399^15
 ;;^UTILITY(U,$J,358.3,31746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31746,1,3,0)
 ;;=3^Intcrn inj w LOC of unsp duration, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31746,1,4,0)
 ;;=4^S06.9X9A
 ;;^UTILITY(U,$J,358.3,31746,2)
 ;;=^5021233
 ;;^UTILITY(U,$J,358.3,31747,0)
 ;;=S06.9X0A^^94^1399^17
 ;;^UTILITY(U,$J,358.3,31747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31747,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,31747,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,31747,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,31748,0)
 ;;=S78.019S^^94^1400^4
 ;;^UTILITY(U,$J,358.3,31748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31748,1,3,0)
 ;;=3^Complete traumatic amputation at unsp hip joint, sequela
 ;;^UTILITY(U,$J,358.3,31748,1,4,0)
 ;;=4^S78.019S
 ;;^UTILITY(U,$J,358.3,31748,2)
 ;;=^5039710
 ;;^UTILITY(U,$J,358.3,31749,0)
 ;;=S68.419S^^94^1400^1
 ;;^UTILITY(U,$J,358.3,31749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31749,1,3,0)
 ;;=3^Complete traumatic amp of unsp hand at wrist level, sequela
 ;;^UTILITY(U,$J,358.3,31749,1,4,0)
 ;;=4^S68.419S
 ;;^UTILITY(U,$J,358.3,31749,2)
 ;;=^5036707
 ;;^UTILITY(U,$J,358.3,31750,0)
 ;;=S88.919S^^94^1400^2
 ;;^UTILITY(U,$J,358.3,31750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31750,1,3,0)
 ;;=3^Complete traumatic amp of unsp low leg, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,31750,1,4,0)
 ;;=4^S88.919S
 ;;^UTILITY(U,$J,358.3,31750,2)
 ;;=^5137219
 ;;^UTILITY(U,$J,358.3,31751,0)
 ;;=S48.919S^^94^1400^3
 ;;^UTILITY(U,$J,358.3,31751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31751,1,3,0)
 ;;=3^Complete traumatic amp of unsp shldr/up arm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,31751,1,4,0)
 ;;=4^S48.919S
 ;;^UTILITY(U,$J,358.3,31751,2)
 ;;=^5028331
 ;;^UTILITY(U,$J,358.3,31752,0)
 ;;=S14.2XXS^^94^1400^6
 ;;^UTILITY(U,$J,358.3,31752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31752,1,3,0)
 ;;=3^Injury of nerve root of cervical spine, sequela
 ;;^UTILITY(U,$J,358.3,31752,1,4,0)
 ;;=4^S14.2XXS
 ;;^UTILITY(U,$J,358.3,31752,2)
 ;;=^5022204
 ;;^UTILITY(U,$J,358.3,31753,0)
 ;;=S34.21XS^^94^1400^7
 ;;^UTILITY(U,$J,358.3,31753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31753,1,3,0)
 ;;=3^Injury of nerve root of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,31753,1,4,0)
 ;;=4^S34.21XS
 ;;^UTILITY(U,$J,358.3,31753,2)
 ;;=^5025252
 ;;^UTILITY(U,$J,358.3,31754,0)
 ;;=S34.22XS^^94^1400^8
 ;;^UTILITY(U,$J,358.3,31754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31754,1,3,0)
 ;;=3^Injury of nerve root of sacral spine, sequela
 ;;^UTILITY(U,$J,358.3,31754,1,4,0)
 ;;=4^S34.22XS
 ;;^UTILITY(U,$J,358.3,31754,2)
 ;;=^5025255
 ;;^UTILITY(U,$J,358.3,31755,0)
 ;;=S24.2XXS^^94^1400^9
 ;;^UTILITY(U,$J,358.3,31755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31755,1,3,0)
 ;;=3^Injury of nerve root of thoracic spine, sequela
 ;;^UTILITY(U,$J,358.3,31755,1,4,0)
 ;;=4^S24.2XXS
 ;;^UTILITY(U,$J,358.3,31755,2)
 ;;=^5023347
 ;;^UTILITY(U,$J,358.3,31756,0)
 ;;=S04.9XXS^^94^1400^11
 ;;^UTILITY(U,$J,358.3,31756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31756,1,3,0)
 ;;=3^Injury of unspec cranial nerve, sequela
 ;;^UTILITY(U,$J,358.3,31756,1,4,0)
 ;;=4^S04.9XXS
 ;;^UTILITY(U,$J,358.3,31756,2)
 ;;=^5020575
 ;;^UTILITY(U,$J,358.3,31757,0)
 ;;=S24.9XXS^^94^1400^12
 ;;^UTILITY(U,$J,358.3,31757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31757,1,3,0)
 ;;=3^Injury of unspec nerve of thorax, sequela
 ;;^UTILITY(U,$J,358.3,31757,1,4,0)
 ;;=4^S24.9XXS
 ;;^UTILITY(U,$J,358.3,31757,2)
 ;;=^5023359
 ;;^UTILITY(U,$J,358.3,31758,0)
 ;;=S34.9XXS^^94^1400^18
 ;;^UTILITY(U,$J,358.3,31758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31758,1,3,0)
 ;;=3^Injury to unspec nerves at abd/low back/pelvis level, sequela
 ;;^UTILITY(U,$J,358.3,31758,1,4,0)
 ;;=4^S34.9XXS
 ;;^UTILITY(U,$J,358.3,31758,2)
 ;;=^5025273
 ;;^UTILITY(U,$J,358.3,31759,0)
 ;;=S14.9XXS^^94^1400^13
 ;;^UTILITY(U,$J,358.3,31759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31759,1,3,0)
 ;;=3^Injury of unspec nerves of neck, sequela
 ;;^UTILITY(U,$J,358.3,31759,1,4,0)
 ;;=4^S14.9XXS
 ;;^UTILITY(U,$J,358.3,31759,2)
 ;;=^5022219
 ;;^UTILITY(U,$J,358.3,31760,0)
 ;;=S58.922S^^94^1400^20
 ;;^UTILITY(U,$J,358.3,31760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31760,1,3,0)
 ;;=3^Partial traumatic amp of l forearm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,31760,1,4,0)
 ;;=4^S58.922S
 ;;^UTILITY(U,$J,358.3,31760,2)
 ;;=^5031957
 ;;^UTILITY(U,$J,358.3,31761,0)
 ;;=S14.109S^^94^1400^15
 ;;^UTILITY(U,$J,358.3,31761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31761,1,3,0)
 ;;=3^Injury to unsp level of cervical spinal cord unspec, sequela
 ;;^UTILITY(U,$J,358.3,31761,1,4,0)
 ;;=4^S14.109S
 ;;^UTILITY(U,$J,358.3,31761,2)
 ;;=^5134243
 ;;^UTILITY(U,$J,358.3,31762,0)
 ;;=S24.109S^^94^1400^17
 ;;^UTILITY(U,$J,358.3,31762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31762,1,3,0)
 ;;=3^Injury to unsp level of thoracic spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,31762,1,4,0)
 ;;=4^S24.109S
 ;;^UTILITY(U,$J,358.3,31762,2)
 ;;=^5134384
 ;;^UTILITY(U,$J,358.3,31763,0)
 ;;=S34.139S^^94^1400^14
 ;;^UTILITY(U,$J,358.3,31763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31763,1,3,0)
 ;;=3^Injury to sacral spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,31763,1,4,0)
 ;;=4^S34.139S
 ;;^UTILITY(U,$J,358.3,31763,2)
 ;;=^5025249
 ;;^UTILITY(U,$J,358.3,31764,0)
 ;;=S34.109S^^94^1400^16
 ;;^UTILITY(U,$J,358.3,31764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31764,1,3,0)
 ;;=3^Injury to unsp level of lumbar spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,31764,1,4,0)
 ;;=4^S34.109S
 ;;^UTILITY(U,$J,358.3,31764,2)
 ;;=^5134570
 ;;^UTILITY(U,$J,358.3,31765,0)
 ;;=S06.9X9S^^94^1400^19
 ;;^UTILITY(U,$J,358.3,31765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31765,1,3,0)
 ;;=3^Intracranial injury w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,31765,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,31765,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,31766,0)
 ;;=S15.002A^^94^1400^5
 ;;^UTILITY(U,$J,358.3,31766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31766,1,3,0)
 ;;=3^Injury of left carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,31766,1,4,0)
 ;;=4^S15.002A
 ;;^UTILITY(U,$J,358.3,31766,2)
 ;;=^5022223
 ;;^UTILITY(U,$J,358.3,31767,0)
 ;;=S15.001A^^94^1400^10
 ;;^UTILITY(U,$J,358.3,31767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31767,1,3,0)
 ;;=3^Injury of right carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,31767,1,4,0)
 ;;=4^S15.001A
 ;;^UTILITY(U,$J,358.3,31767,2)
 ;;=^5022220
 ;;^UTILITY(U,$J,358.3,31768,0)
 ;;=I69.91^^94^1401^2
 ;;^UTILITY(U,$J,358.3,31768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31768,1,3,0)
 ;;=3^Cognitive deficits following unsp cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,31768,1,4,0)
 ;;=4^I69.91
 ;;^UTILITY(U,$J,358.3,31768,2)
 ;;=^5007552
 ;;^UTILITY(U,$J,358.3,31769,0)
 ;;=I69.952^^94^1401^3
 ;;^UTILITY(U,$J,358.3,31769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31769,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff left dominant side
 ;;^UTILITY(U,$J,358.3,31769,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,31769,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,31770,0)
 ;;=I69.954^^94^1401^4
 ;;^UTILITY(U,$J,358.3,31770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31770,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff left nondom side
 ;;^UTILITY(U,$J,358.3,31770,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,31770,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,31771,0)
 ;;=I69.951^^94^1401^5
 ;;^UTILITY(U,$J,358.3,31771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31771,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff right dominant side
 ;;^UTILITY(U,$J,358.3,31771,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,31771,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,31772,0)
 ;;=I69.953^^94^1401^6
 ;;^UTILITY(U,$J,358.3,31772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31772,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff right nondom side
 ;;^UTILITY(U,$J,358.3,31772,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,31772,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,31773,0)
 ;;=I69.942^^94^1401^7
 ;;^UTILITY(U,$J,358.3,31773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31773,1,3,0)
 ;;=3^Monoplg low lmb fol unsp cerebvasc dis aff left dom side
 ;;^UTILITY(U,$J,358.3,31773,1,4,0)
 ;;=4^I69.942
 ;;^UTILITY(U,$J,358.3,31773,2)
 ;;=^5133582
 ;;^UTILITY(U,$J,358.3,31774,0)
 ;;=I69.944^^94^1401^8
 ;;^UTILITY(U,$J,358.3,31774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31774,1,3,0)
 ;;=3^Monoplg low lmb fol unsp cerebvasc dis aff left nondom side
 ;;^UTILITY(U,$J,358.3,31774,1,4,0)
 ;;=4^I69.944
 ;;^UTILITY(U,$J,358.3,31774,2)
 ;;=^5133585
 ;;^UTILITY(U,$J,358.3,31775,0)
 ;;=I69.941^^94^1401^9
 ;;^UTILITY(U,$J,358.3,31775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31775,1,3,0)
 ;;=3^Monoplg low lmb fol unsp cerebvasc dis aff right dom side
