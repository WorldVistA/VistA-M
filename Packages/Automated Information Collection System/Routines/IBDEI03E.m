IBDEI03E ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1149,1,2,0)
 ;;=2^92561
 ;;^UTILITY(U,$J,358.3,1149,1,3,0)
 ;;=3^Bekesy Audiometry,Diagnostic
 ;;^UTILITY(U,$J,358.3,1150,0)
 ;;=92616^^7^115^20^^^^1
 ;;^UTILITY(U,$J,358.3,1150,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1150,1,2,0)
 ;;=2^92616
 ;;^UTILITY(U,$J,358.3,1150,1,3,0)
 ;;=3^Flex Fbroptic Eval Swal/Laryng Sens Tst-Video
 ;;^UTILITY(U,$J,358.3,1151,0)
 ;;=92617^^7^115^19^^^^1
 ;;^UTILITY(U,$J,358.3,1151,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1151,1,2,0)
 ;;=2^92617
 ;;^UTILITY(U,$J,358.3,1151,1,3,0)
 ;;=3^Flex Fbroptic Eval Laryng Tst-Interp/Rpt
 ;;^UTILITY(U,$J,358.3,1152,0)
 ;;=92516^^7^115^17^^^^1
 ;;^UTILITY(U,$J,358.3,1152,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1152,1,2,0)
 ;;=2^92516
 ;;^UTILITY(U,$J,358.3,1152,1,3,0)
 ;;=3^Facial Nerve Function Test
 ;;^UTILITY(U,$J,358.3,1153,0)
 ;;=92575^^7^115^34^^^^1
 ;;^UTILITY(U,$J,358.3,1153,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1153,1,2,0)
 ;;=2^92575
 ;;^UTILITY(U,$J,358.3,1153,1,3,0)
 ;;=3^Sensorineural Acuity Level Test
 ;;^UTILITY(U,$J,358.3,1154,0)
 ;;=92550^^7^115^44^^^^1
 ;;^UTILITY(U,$J,358.3,1154,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1154,1,2,0)
 ;;=2^92550
 ;;^UTILITY(U,$J,358.3,1154,1,3,0)
 ;;=3^Tympanometry & Reflex Threshold
 ;;^UTILITY(U,$J,358.3,1155,0)
 ;;=92551^^7^115^31^^^^1
 ;;^UTILITY(U,$J,358.3,1155,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1155,1,2,0)
 ;;=2^92551
 ;;^UTILITY(U,$J,358.3,1155,1,3,0)
 ;;=3^Pure Tone Hearing Test,Air
 ;;^UTILITY(U,$J,358.3,1156,0)
 ;;=V5008^^7^116^2^^^^1
 ;;^UTILITY(U,$J,358.3,1156,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1156,1,2,0)
 ;;=2^V5008
 ;;^UTILITY(U,$J,358.3,1156,1,3,0)
 ;;=3^Hearing Screening
 ;;^UTILITY(U,$J,358.3,1157,0)
 ;;=V5010^^7^116^1^^^^1
 ;;^UTILITY(U,$J,358.3,1157,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1157,1,2,0)
 ;;=2^V5010
 ;;^UTILITY(U,$J,358.3,1157,1,3,0)
 ;;=3^Assessment for Hearing Aid
 ;;^UTILITY(U,$J,358.3,1158,0)
 ;;=92601^^7^117^2^^^^1
 ;;^UTILITY(U,$J,358.3,1158,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1158,1,2,0)
 ;;=2^92601
 ;;^UTILITY(U,$J,358.3,1158,1,3,0)
 ;;=3^Diagnostic Analysis Of Cochlear Implant<7Y
 ;;^UTILITY(U,$J,358.3,1159,0)
 ;;=92602^^7^117^3^^^^1
 ;;^UTILITY(U,$J,358.3,1159,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1159,1,2,0)
 ;;=2^92602
 ;;^UTILITY(U,$J,358.3,1159,1,3,0)
 ;;=3^Reprogram Cochlear Implt < 7
 ;;^UTILITY(U,$J,358.3,1160,0)
 ;;=92603^^7^117^4^^^^1
 ;;^UTILITY(U,$J,358.3,1160,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1160,1,2,0)
 ;;=2^92603
 ;;^UTILITY(U,$J,358.3,1160,1,3,0)
 ;;=3^Diagnostic Analysis Of Cochlear Implant 7+Y
 ;;^UTILITY(U,$J,358.3,1161,0)
 ;;=92604^^7^117^5^^^^1
 ;;^UTILITY(U,$J,358.3,1161,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1161,1,2,0)
 ;;=2^92604
 ;;^UTILITY(U,$J,358.3,1161,1,3,0)
 ;;=3^Subsequent Re-Programming 7+Y
 ;;^UTILITY(U,$J,358.3,1162,0)
 ;;=92508^^7^118^2^^^^1
 ;;^UTILITY(U,$J,358.3,1162,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1162,1,2,0)
 ;;=2^92508
 ;;^UTILITY(U,$J,358.3,1162,1,3,0)
 ;;=3^Group Treatment
 ;;^UTILITY(U,$J,358.3,1163,0)
 ;;=95992^^7^118^1^^^^1
 ;;^UTILITY(U,$J,358.3,1163,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1163,1,2,0)
 ;;=2^95992
 ;;^UTILITY(U,$J,358.3,1163,1,3,0)
 ;;=3^Canalith Repositioning
 ;;^UTILITY(U,$J,358.3,1164,0)
 ;;=92700^^7^118^3^^^^1
 ;;^UTILITY(U,$J,358.3,1164,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1164,1,2,0)
 ;;=2^92700
 ;;^UTILITY(U,$J,358.3,1164,1,3,0)
 ;;=3^Unlisted Otorhinolaryngological Service
 ;;^UTILITY(U,$J,358.3,1165,0)
 ;;=V5275^^7^119^3^^^^1
