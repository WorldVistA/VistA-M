IBDEI22A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34571,0)
 ;;=99024^^159^1760^1
 ;;^UTILITY(U,$J,358.3,34571,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,34571,1,1,0)
 ;;=1^Post-Op Follow-up Visit
 ;;^UTILITY(U,$J,358.3,34571,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,34572,0)
 ;;=G06.0^^160^1761^14
 ;;^UTILITY(U,$J,358.3,34572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34572,1,3,0)
 ;;=3^Intracranial Abscess and Granuloma
 ;;^UTILITY(U,$J,358.3,34572,1,4,0)
 ;;=4^G06.0
 ;;^UTILITY(U,$J,358.3,34572,2)
 ;;=^5003745
 ;;^UTILITY(U,$J,358.3,34573,0)
 ;;=I66.01^^160^1761^32
 ;;^UTILITY(U,$J,358.3,34573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34573,1,3,0)
 ;;=3^Occlusion and stenosis of right middle cerebral artery
 ;;^UTILITY(U,$J,358.3,34573,1,4,0)
 ;;=4^I66.01
 ;;^UTILITY(U,$J,358.3,34573,2)
 ;;=^5007365
 ;;^UTILITY(U,$J,358.3,34574,0)
 ;;=I66.02^^160^1761^29
 ;;^UTILITY(U,$J,358.3,34574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34574,1,3,0)
 ;;=3^Occlusion and stenosis of left middle cerebral artery
 ;;^UTILITY(U,$J,358.3,34574,1,4,0)
 ;;=4^I66.02
 ;;^UTILITY(U,$J,358.3,34574,2)
 ;;=^5007366
 ;;^UTILITY(U,$J,358.3,34575,0)
 ;;=I66.11^^160^1761^31
 ;;^UTILITY(U,$J,358.3,34575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34575,1,3,0)
 ;;=3^Occlusion and stenosis of right anterior cerebral artery
 ;;^UTILITY(U,$J,358.3,34575,1,4,0)
 ;;=4^I66.11
 ;;^UTILITY(U,$J,358.3,34575,2)
 ;;=^5007369
 ;;^UTILITY(U,$J,358.3,34576,0)
 ;;=I66.12^^160^1761^28
 ;;^UTILITY(U,$J,358.3,34576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34576,1,3,0)
 ;;=3^Occlusion and stenosis of left anterior cerebral artery
 ;;^UTILITY(U,$J,358.3,34576,1,4,0)
 ;;=4^I66.12
 ;;^UTILITY(U,$J,358.3,34576,2)
 ;;=^5007370
 ;;^UTILITY(U,$J,358.3,34577,0)
 ;;=I66.21^^160^1761^33
 ;;^UTILITY(U,$J,358.3,34577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34577,1,3,0)
 ;;=3^Occlusion and stenosis of right posterior cerebral artery
 ;;^UTILITY(U,$J,358.3,34577,1,4,0)
 ;;=4^I66.21
 ;;^UTILITY(U,$J,358.3,34577,2)
 ;;=^5007373
 ;;^UTILITY(U,$J,358.3,34578,0)
 ;;=I66.22^^160^1761^30
 ;;^UTILITY(U,$J,358.3,34578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34578,1,3,0)
 ;;=3^Occlusion and stenosis of left posterior cerebral artery
 ;;^UTILITY(U,$J,358.3,34578,1,4,0)
 ;;=4^I66.22
 ;;^UTILITY(U,$J,358.3,34578,2)
 ;;=^5007374
 ;;^UTILITY(U,$J,358.3,34579,0)
 ;;=I67.1^^160^1761^4
 ;;^UTILITY(U,$J,358.3,34579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34579,1,3,0)
 ;;=3^Cerebral aneurysm, nonruptured
 ;;^UTILITY(U,$J,358.3,34579,1,4,0)
 ;;=4^I67.1
 ;;^UTILITY(U,$J,358.3,34579,2)
 ;;=^269755
 ;;^UTILITY(U,$J,358.3,34580,0)
 ;;=Q28.2^^160^1761^1
 ;;^UTILITY(U,$J,358.3,34580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34580,1,3,0)
 ;;=3^Arteriovenous malformation of cerebral vessels
 ;;^UTILITY(U,$J,358.3,34580,1,4,0)
 ;;=4^Q28.2
 ;;^UTILITY(U,$J,358.3,34580,2)
 ;;=^5018595
 ;;^UTILITY(U,$J,358.3,34581,0)
 ;;=G93.0^^160^1761^5
 ;;^UTILITY(U,$J,358.3,34581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34581,1,3,0)
 ;;=3^Cerebral cysts
 ;;^UTILITY(U,$J,358.3,34581,1,4,0)
 ;;=4^G93.0
 ;;^UTILITY(U,$J,358.3,34581,2)
 ;;=^268481
 ;;^UTILITY(U,$J,358.3,34582,0)
 ;;=G04.90^^160^1761^10
 ;;^UTILITY(U,$J,358.3,34582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34582,1,3,0)
 ;;=3^Encephalitis and encephalomyelitis, unspecified
 ;;^UTILITY(U,$J,358.3,34582,1,4,0)
 ;;=4^G04.90
 ;;^UTILITY(U,$J,358.3,34582,2)
 ;;=^5003741
 ;;^UTILITY(U,$J,358.3,34583,0)
 ;;=G04.91^^160^1761^19
 ;;^UTILITY(U,$J,358.3,34583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34583,1,3,0)
 ;;=3^Myelitis, unspecified
