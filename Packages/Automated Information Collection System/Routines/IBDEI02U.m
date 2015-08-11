IBDEI02U ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,881,0)
 ;;=92516^^9^91^17^^^^1
 ;;^UTILITY(U,$J,358.3,881,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,881,1,2,0)
 ;;=2^92516
 ;;^UTILITY(U,$J,358.3,881,1,3,0)
 ;;=3^Facial Nerve Function Test
 ;;^UTILITY(U,$J,358.3,882,0)
 ;;=92551^^9^92^3^^^^1
 ;;^UTILITY(U,$J,358.3,882,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,882,1,2,0)
 ;;=2^92551
 ;;^UTILITY(U,$J,358.3,882,1,3,0)
 ;;=3^Pure Tone Hearing Test, Air
 ;;^UTILITY(U,$J,358.3,883,0)
 ;;=V5008^^9^92^2^^^^1
 ;;^UTILITY(U,$J,358.3,883,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,883,1,2,0)
 ;;=2^V5008
 ;;^UTILITY(U,$J,358.3,883,1,3,0)
 ;;=3^Hearing Screening
 ;;^UTILITY(U,$J,358.3,884,0)
 ;;=92550^^9^92^4^^^^1
 ;;^UTILITY(U,$J,358.3,884,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,884,1,2,0)
 ;;=2^92550
 ;;^UTILITY(U,$J,358.3,884,1,3,0)
 ;;=3^Tympanometry & Reflex Threshold
 ;;^UTILITY(U,$J,358.3,885,0)
 ;;=V5010^^9^92^1^^^^1
 ;;^UTILITY(U,$J,358.3,885,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,885,1,2,0)
 ;;=2^V5010
 ;;^UTILITY(U,$J,358.3,885,1,3,0)
 ;;=3^Assessment for Hearing Aid
 ;;^UTILITY(U,$J,358.3,886,0)
 ;;=92700^^9^93^2^^^^1
 ;;^UTILITY(U,$J,358.3,886,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,886,1,2,0)
 ;;=2^92700
 ;;^UTILITY(U,$J,358.3,886,1,3,0)
 ;;=3^Unlisted Otorhinolaryngological Service
 ;;^UTILITY(U,$J,358.3,887,0)
 ;;=V5299^^9^93^1^^^^1
 ;;^UTILITY(U,$J,358.3,887,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,887,1,2,0)
 ;;=2^V5299
 ;;^UTILITY(U,$J,358.3,887,1,3,0)
 ;;=3^Hearing Service
 ;;^UTILITY(U,$J,358.3,888,0)
 ;;=92601^^9^94^2^^^^1
 ;;^UTILITY(U,$J,358.3,888,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,888,1,2,0)
 ;;=2^92601
 ;;^UTILITY(U,$J,358.3,888,1,3,0)
 ;;=3^Diagnostic Analysis Of Cochlear Implant<7Y
 ;;^UTILITY(U,$J,358.3,889,0)
 ;;=92602^^9^94^3^^^^1
 ;;^UTILITY(U,$J,358.3,889,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,889,1,2,0)
 ;;=2^92602
 ;;^UTILITY(U,$J,358.3,889,1,3,0)
 ;;=3^Reprogram Cochlear Implt < 7
 ;;^UTILITY(U,$J,358.3,890,0)
 ;;=92603^^9^94^4^^^^1
 ;;^UTILITY(U,$J,358.3,890,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,890,1,2,0)
 ;;=2^92603
 ;;^UTILITY(U,$J,358.3,890,1,3,0)
 ;;=3^Diagnostic Analysis Of Cochlear Implant 7+Y
 ;;^UTILITY(U,$J,358.3,891,0)
 ;;=92604^^9^94^5^^^^1
 ;;^UTILITY(U,$J,358.3,891,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,891,1,2,0)
 ;;=2^92604
 ;;^UTILITY(U,$J,358.3,891,1,3,0)
 ;;=3^Subsequent Re-Programming 7+Y
 ;;^UTILITY(U,$J,358.3,892,0)
 ;;=92508^^9^95^2^^^^1
 ;;^UTILITY(U,$J,358.3,892,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,892,1,2,0)
 ;;=2^92508
 ;;^UTILITY(U,$J,358.3,892,1,3,0)
 ;;=3^Group Treatment
 ;;^UTILITY(U,$J,358.3,893,0)
 ;;=95992^^9^95^1^^^^1
 ;;^UTILITY(U,$J,358.3,893,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,893,1,2,0)
 ;;=2^95992
 ;;^UTILITY(U,$J,358.3,893,1,3,0)
 ;;=3^Canalith Repositioning
 ;;^UTILITY(U,$J,358.3,894,0)
 ;;=V5275^^9^96^3^^^^1
 ;;^UTILITY(U,$J,358.3,894,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,894,1,2,0)
 ;;=2^V5275
 ;;^UTILITY(U,$J,358.3,894,1,3,0)
 ;;=3^Ear Impression, Each
 ;;^UTILITY(U,$J,358.3,895,0)
 ;;=92590^^9^96^7^^^^1
 ;;^UTILITY(U,$J,358.3,895,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,895,1,2,0)
 ;;=2^92590
 ;;^UTILITY(U,$J,358.3,895,1,3,0)
 ;;=3^HA Assessment,Monaural
 ;;^UTILITY(U,$J,358.3,896,0)
 ;;=92591^^9^96^6^^^^1
 ;;^UTILITY(U,$J,358.3,896,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,896,1,2,0)
 ;;=2^92591
 ;;^UTILITY(U,$J,358.3,896,1,3,0)
 ;;=3^HA Assessment,Binaural
 ;;^UTILITY(U,$J,358.3,897,0)
 ;;=92594^^9^96^5^^^^1
 ;;^UTILITY(U,$J,358.3,897,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,897,1,2,0)
 ;;=2^92594
