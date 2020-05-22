IBDEI0G0 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6914,1,3,0)
 ;;=3^Radiculopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,6914,1,4,0)
 ;;=4^M54.17
 ;;^UTILITY(U,$J,358.3,6914,2)
 ;;=^5012302
 ;;^UTILITY(U,$J,358.3,6915,0)
 ;;=M51.46^^56^443^14
 ;;^UTILITY(U,$J,358.3,6915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6915,1,3,0)
 ;;=3^Schmorl's nodes, lumbar region
 ;;^UTILITY(U,$J,358.3,6915,1,4,0)
 ;;=4^M51.46
 ;;^UTILITY(U,$J,358.3,6915,2)
 ;;=^5012257
 ;;^UTILITY(U,$J,358.3,6916,0)
 ;;=M99.03^^56^443^16
 ;;^UTILITY(U,$J,358.3,6916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6916,1,3,0)
 ;;=3^Segmental and somatic dysfunction of lumbar region
 ;;^UTILITY(U,$J,358.3,6916,1,4,0)
 ;;=4^M99.03
 ;;^UTILITY(U,$J,358.3,6916,2)
 ;;=^5015403
 ;;^UTILITY(U,$J,358.3,6917,0)
 ;;=S33.5XXA^^56^443^21
 ;;^UTILITY(U,$J,358.3,6917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6917,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, initial encounter
 ;;^UTILITY(U,$J,358.3,6917,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,6917,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,6918,0)
 ;;=S33.5XXS^^56^443^22
 ;;^UTILITY(U,$J,358.3,6918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6918,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,6918,1,4,0)
 ;;=4^S33.5XXS
 ;;^UTILITY(U,$J,358.3,6918,2)
 ;;=^5025174
 ;;^UTILITY(U,$J,358.3,6919,0)
 ;;=S33.5XXD^^56^443^23
 ;;^UTILITY(U,$J,358.3,6919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6919,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, subsequent encounter
 ;;^UTILITY(U,$J,358.3,6919,1,4,0)
 ;;=4^S33.5XXD
 ;;^UTILITY(U,$J,358.3,6919,2)
 ;;=^5025173
 ;;^UTILITY(U,$J,358.3,6920,0)
 ;;=M43.16^^56^443^20
 ;;^UTILITY(U,$J,358.3,6920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6920,1,3,0)
 ;;=3^Spondylolisthesis, lumbar region
 ;;^UTILITY(U,$J,358.3,6920,1,4,0)
 ;;=4^M43.16
 ;;^UTILITY(U,$J,358.3,6920,2)
 ;;=^5011927
 ;;^UTILITY(U,$J,358.3,6921,0)
 ;;=M51.26^^56^443^7
 ;;^UTILITY(U,$J,358.3,6921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6921,1,3,0)
 ;;=3^Intervrtbrl Disc Displacement,Lumbar
 ;;^UTILITY(U,$J,358.3,6921,1,4,0)
 ;;=4^M51.26
 ;;^UTILITY(U,$J,358.3,6921,2)
 ;;=^5012249
 ;;^UTILITY(U,$J,358.3,6922,0)
 ;;=M51.27^^56^443^8
 ;;^UTILITY(U,$J,358.3,6922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6922,1,3,0)
 ;;=3^Intervrtbrl Disc Displcmnt,Lumbosacral
 ;;^UTILITY(U,$J,358.3,6922,1,4,0)
 ;;=4^M51.27
 ;;^UTILITY(U,$J,358.3,6922,2)
 ;;=^5012250
 ;;^UTILITY(U,$J,358.3,6923,0)
 ;;=M51.47^^56^443^15
 ;;^UTILITY(U,$J,358.3,6923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6923,1,3,0)
 ;;=3^Schmorl's nodes, lumbosacral region
 ;;^UTILITY(U,$J,358.3,6923,1,4,0)
 ;;=4^M51.47
 ;;^UTILITY(U,$J,358.3,6923,2)
 ;;=^5012258
 ;;^UTILITY(U,$J,358.3,6924,0)
 ;;=M48.07^^56^443^19
 ;;^UTILITY(U,$J,358.3,6924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6924,1,3,0)
 ;;=3^Spinal stenosis, lumbosacral region
 ;;^UTILITY(U,$J,358.3,6924,1,4,0)
 ;;=4^M48.07
 ;;^UTILITY(U,$J,358.3,6924,2)
 ;;=^5012094
 ;;^UTILITY(U,$J,358.3,6925,0)
 ;;=M48.061^^56^443^18
 ;;^UTILITY(U,$J,358.3,6925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6925,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,6925,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,6925,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,6926,0)
 ;;=M48.062^^56^443^17
 ;;^UTILITY(U,$J,358.3,6926,1,0)
 ;;=^358.31IA^4^2
