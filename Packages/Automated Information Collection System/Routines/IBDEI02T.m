IBDEI02T ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,927,1,2,0)
 ;;=2^V5010
 ;;^UTILITY(U,$J,358.3,927,1,3,0)
 ;;=3^Assessment for Hearing Aid
 ;;^UTILITY(U,$J,358.3,928,0)
 ;;=92700^^12^101^3^^^^1
 ;;^UTILITY(U,$J,358.3,928,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,928,1,2,0)
 ;;=2^92700
 ;;^UTILITY(U,$J,358.3,928,1,3,0)
 ;;=3^Video-Otoscopy, Diagnostic
 ;;^UTILITY(U,$J,358.3,929,0)
 ;;=92601^^12^102^2^^^^1
 ;;^UTILITY(U,$J,358.3,929,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,929,1,2,0)
 ;;=2^92601
 ;;^UTILITY(U,$J,358.3,929,1,3,0)
 ;;=3^Diagnostic Analysis Of Cochlear Implant<7Y
 ;;^UTILITY(U,$J,358.3,930,0)
 ;;=92602^^12^102^3^^^^1
 ;;^UTILITY(U,$J,358.3,930,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,930,1,2,0)
 ;;=2^92602
 ;;^UTILITY(U,$J,358.3,930,1,3,0)
 ;;=3^Reprogram Cochlear Implt < 7
 ;;^UTILITY(U,$J,358.3,931,0)
 ;;=92603^^12^102^4^^^^1
 ;;^UTILITY(U,$J,358.3,931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,931,1,2,0)
 ;;=2^92603
 ;;^UTILITY(U,$J,358.3,931,1,3,0)
 ;;=3^Diagnostic Analysis Of Cochlear Implant 7+Y
 ;;^UTILITY(U,$J,358.3,932,0)
 ;;=92604^^12^102^5^^^^1
 ;;^UTILITY(U,$J,358.3,932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,932,1,2,0)
 ;;=2^92604
 ;;^UTILITY(U,$J,358.3,932,1,3,0)
 ;;=3^Subsequent Re-Programming 7+Y
 ;;^UTILITY(U,$J,358.3,933,0)
 ;;=92700^^12^103^1^^^^1
 ;;^UTILITY(U,$J,358.3,933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,933,1,2,0)
 ;;=2^92700
 ;;^UTILITY(U,$J,358.3,933,1,3,0)
 ;;=3^Support Group
 ;;^UTILITY(U,$J,358.3,934,0)
 ;;=97112^^12^103^2^^^^1
 ;;^UTILITY(U,$J,358.3,934,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,934,1,2,0)
 ;;=2^97112
 ;;^UTILITY(U,$J,358.3,934,1,3,0)
 ;;=3^Vestibuar Rehab, Each 15 Min
 ;;^UTILITY(U,$J,358.3,935,0)
 ;;=92508^^12^103^3^^^^1
 ;;^UTILITY(U,$J,358.3,935,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,935,1,2,0)
 ;;=2^92508
 ;;^UTILITY(U,$J,358.3,935,1,3,0)
 ;;=3^Group Treatment
 ;;^UTILITY(U,$J,358.3,936,0)
 ;;=95992^^12^103^5^^^^1
 ;;^UTILITY(U,$J,358.3,936,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,936,1,2,0)
 ;;=2^95992
 ;;^UTILITY(U,$J,358.3,936,1,3,0)
 ;;=3^Canalith Repositioning
 ;;^UTILITY(U,$J,358.3,937,0)
 ;;=V5275^^12^104^3^^^^1
 ;;^UTILITY(U,$J,358.3,937,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,937,1,2,0)
 ;;=2^V5275
 ;;^UTILITY(U,$J,358.3,937,1,3,0)
 ;;=3^Ear Impression, Each
 ;;^UTILITY(U,$J,358.3,938,0)
 ;;=92590^^12^104^7^^^^1
 ;;^UTILITY(U,$J,358.3,938,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,938,1,2,0)
 ;;=2^92590
 ;;^UTILITY(U,$J,358.3,938,1,3,0)
 ;;=3^HA Assessment,Monaural
 ;;^UTILITY(U,$J,358.3,939,0)
 ;;=92591^^12^104^6^^^^1
 ;;^UTILITY(U,$J,358.3,939,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,939,1,2,0)
 ;;=2^92591
 ;;^UTILITY(U,$J,358.3,939,1,3,0)
 ;;=3^HA Assessment,Binaural
 ;;^UTILITY(U,$J,358.3,940,0)
 ;;=92594^^12^104^5^^^^1
 ;;^UTILITY(U,$J,358.3,940,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,940,1,2,0)
 ;;=2^92594
 ;;^UTILITY(U,$J,358.3,940,1,3,0)
 ;;=3^Electroacoustic Eval for HA,Monaural
 ;;^UTILITY(U,$J,358.3,941,0)
 ;;=92595^^12^104^4^^^^1
 ;;^UTILITY(U,$J,358.3,941,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,941,1,2,0)
 ;;=2^92595
 ;;^UTILITY(U,$J,358.3,941,1,3,0)
 ;;=3^Electroacoustic Eval for HA,Binaural
 ;;^UTILITY(U,$J,358.3,942,0)
 ;;=92592^^12^104^9^^^^1
 ;;^UTILITY(U,$J,358.3,942,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,942,1,2,0)
 ;;=2^92592
 ;;^UTILITY(U,$J,358.3,942,1,3,0)
 ;;=3^HA Check,Monaural
 ;;^UTILITY(U,$J,358.3,943,0)
 ;;=92593^^12^104^8^^^^1
 ;;^UTILITY(U,$J,358.3,943,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,943,1,2,0)
 ;;=2^92593
 ;;^UTILITY(U,$J,358.3,943,1,3,0)
 ;;=3^HA Check,Binaural
