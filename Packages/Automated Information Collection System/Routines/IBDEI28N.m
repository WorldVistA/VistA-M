IBDEI28N ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35739,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/o Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,35739,1,4,0)
 ;;=4^M48.061
 ;;^UTILITY(U,$J,358.3,35739,2)
 ;;=^5151513
 ;;^UTILITY(U,$J,358.3,35740,0)
 ;;=M48.062^^139^1821^46
 ;;^UTILITY(U,$J,358.3,35740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35740,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region w/ Neurogenic Claudication
 ;;^UTILITY(U,$J,358.3,35740,1,4,0)
 ;;=4^M48.062
 ;;^UTILITY(U,$J,358.3,35740,2)
 ;;=^5151514
 ;;^UTILITY(U,$J,358.3,35741,0)
 ;;=M41.9^^139^1821^38
 ;;^UTILITY(U,$J,358.3,35741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35741,1,3,0)
 ;;=3^Scoliosis,Idiopathic
 ;;^UTILITY(U,$J,358.3,35741,1,4,0)
 ;;=4^M41.9
 ;;^UTILITY(U,$J,358.3,35741,2)
 ;;=^5011889
 ;;^UTILITY(U,$J,358.3,35742,0)
 ;;=R47.01^^139^1822^1
 ;;^UTILITY(U,$J,358.3,35742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35742,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,35742,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,35742,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,35743,0)
 ;;=I69.920^^139^1822^2
 ;;^UTILITY(U,$J,358.3,35743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35743,1,3,0)
 ;;=3^Aphasia after unspec cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,35743,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,35743,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,35744,0)
 ;;=I69.991^^139^1822^4
 ;;^UTILITY(U,$J,358.3,35744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35744,1,3,0)
 ;;=3^Dysphagia after unspec cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,35744,1,4,0)
 ;;=4^I69.991
 ;;^UTILITY(U,$J,358.3,35744,2)
 ;;=^5007569
 ;;^UTILITY(U,$J,358.3,35745,0)
 ;;=G11.1^^139^1822^5
 ;;^UTILITY(U,$J,358.3,35745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35745,1,3,0)
 ;;=3^Early-onset cerebellar ataxia
 ;;^UTILITY(U,$J,358.3,35745,1,4,0)
 ;;=4^G11.1
 ;;^UTILITY(U,$J,358.3,35745,2)
 ;;=^5003753
 ;;^UTILITY(U,$J,358.3,35746,0)
 ;;=I69.952^^139^1822^10
 ;;^UTILITY(U,$J,358.3,35746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35746,1,3,0)
 ;;=3^Hemiplegia after Unsp Crbvasc Dis,Left Dominant Side
 ;;^UTILITY(U,$J,358.3,35746,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,35746,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,35747,0)
 ;;=I69.954^^139^1822^11
 ;;^UTILITY(U,$J,358.3,35747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35747,1,3,0)
 ;;=3^Hemiplegia after Unsp Crbvasc Dis,Left Nondominant Side
 ;;^UTILITY(U,$J,358.3,35747,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,35747,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,35748,0)
 ;;=I69.951^^139^1822^12
 ;;^UTILITY(U,$J,358.3,35748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35748,1,3,0)
 ;;=3^Hemiplegia after Unsp Crbvasc Dis,Right Dominant Side
 ;;^UTILITY(U,$J,358.3,35748,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,35748,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,35749,0)
 ;;=I69.953^^139^1822^13
 ;;^UTILITY(U,$J,358.3,35749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35749,1,3,0)
 ;;=3^Hemiplegia after Unsp Crbvasc Dis,Right Nondominant Side
 ;;^UTILITY(U,$J,358.3,35749,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,35749,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,35750,0)
 ;;=G81.92^^139^1822^6
 ;;^UTILITY(U,$J,358.3,35750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35750,1,3,0)
 ;;=3^Hemiplegia,Unspec Affecting Left Dominant Side
 ;;^UTILITY(U,$J,358.3,35750,1,4,0)
 ;;=4^G81.92
 ;;^UTILITY(U,$J,358.3,35750,2)
 ;;=^5004122
 ;;^UTILITY(U,$J,358.3,35751,0)
 ;;=G81.94^^139^1822^7
