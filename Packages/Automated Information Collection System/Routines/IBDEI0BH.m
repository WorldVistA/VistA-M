IBDEI0BH ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4888,1,3,0)
 ;;=3^Complication of Vascular Prosth Dev/Graft,Init
 ;;^UTILITY(U,$J,358.3,4888,1,4,0)
 ;;=4^T82.898A
 ;;^UTILITY(U,$J,358.3,4888,2)
 ;;=^5054953
 ;;^UTILITY(U,$J,358.3,4889,0)
 ;;=T82.9XXA^^37^323^7
 ;;^UTILITY(U,$J,358.3,4889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4889,1,3,0)
 ;;=3^Complication of Cardiac & Vascular Prosth Dev/Graft,Init,Unspec
 ;;^UTILITY(U,$J,358.3,4889,1,4,0)
 ;;=4^T82.9XXA
 ;;^UTILITY(U,$J,358.3,4889,2)
 ;;=^5054956
 ;;^UTILITY(U,$J,358.3,4890,0)
 ;;=K68.11^^37^323^23
 ;;^UTILITY(U,$J,358.3,4890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4890,1,3,0)
 ;;=3^Postprocedural Retroperitoneal Abscess
 ;;^UTILITY(U,$J,358.3,4890,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,4890,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,4891,0)
 ;;=T81.4XXA^^37^323^16
 ;;^UTILITY(U,$J,358.3,4891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4891,1,3,0)
 ;;=3^Infection following Procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,4891,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,4891,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,4892,0)
 ;;=G89.18^^37^323^22
 ;;^UTILITY(U,$J,358.3,4892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4892,1,3,0)
 ;;=3^Postprocedural Pain,Acute
 ;;^UTILITY(U,$J,358.3,4892,1,4,0)
 ;;=4^G89.18
 ;;^UTILITY(U,$J,358.3,4892,2)
 ;;=^5004154
 ;;^UTILITY(U,$J,358.3,4893,0)
 ;;=A41.51^^37^324^2
 ;;^UTILITY(U,$J,358.3,4893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4893,1,3,0)
 ;;=3^Sepsis d/t Escherichia Coli 
 ;;^UTILITY(U,$J,358.3,4893,1,4,0)
 ;;=4^A41.51
 ;;^UTILITY(U,$J,358.3,4893,2)
 ;;=^5000208
 ;;^UTILITY(U,$J,358.3,4894,0)
 ;;=A41.89^^37^324^3
 ;;^UTILITY(U,$J,358.3,4894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4894,1,3,0)
 ;;=3^Sepsis,Oth Spec
 ;;^UTILITY(U,$J,358.3,4894,1,4,0)
 ;;=4^A41.89
 ;;^UTILITY(U,$J,358.3,4894,2)
 ;;=^5000213
 ;;^UTILITY(U,$J,358.3,4895,0)
 ;;=A41.50^^37^324^1
 ;;^UTILITY(U,$J,358.3,4895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4895,1,3,0)
 ;;=3^Gram-Negative Sepsis,Unspec
 ;;^UTILITY(U,$J,358.3,4895,1,4,0)
 ;;=4^A41.50
 ;;^UTILITY(U,$J,358.3,4895,2)
 ;;=^5000207
 ;;^UTILITY(U,$J,358.3,4896,0)
 ;;=A41.9^^37^324^4
 ;;^UTILITY(U,$J,358.3,4896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4896,1,3,0)
 ;;=3^Sepsis,Unspec Organism
 ;;^UTILITY(U,$J,358.3,4896,1,4,0)
 ;;=4^A41.9
 ;;^UTILITY(U,$J,358.3,4896,2)
 ;;=^5000214
 ;;^UTILITY(U,$J,358.3,4897,0)
 ;;=N17.9^^37^325^2
 ;;^UTILITY(U,$J,358.3,4897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4897,1,3,0)
 ;;=3^Acute Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,4897,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,4897,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,4898,0)
 ;;=I12.9^^37^325^3
 ;;^UTILITY(U,$J,358.3,4898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4898,1,3,0)
 ;;=3^Hypertensive Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,4898,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,4898,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,4899,0)
 ;;=I12.0^^37^325^4
 ;;^UTILITY(U,$J,358.3,4899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4899,1,3,0)
 ;;=3^Hypertensive Chr Kidney Disease w/ Stage 5 Kidney Disease/ESRD
 ;;^UTILITY(U,$J,358.3,4899,1,4,0)
 ;;=4^I12.0
 ;;^UTILITY(U,$J,358.3,4899,2)
 ;;=^5007065
 ;;^UTILITY(U,$J,358.3,4900,0)
 ;;=N17.0^^37^325^1
 ;;^UTILITY(U,$J,358.3,4900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4900,1,3,0)
 ;;=3^Acute Kidney Failure w/ Tubular Necrosis
 ;;^UTILITY(U,$J,358.3,4900,1,4,0)
 ;;=4^N17.0
 ;;^UTILITY(U,$J,358.3,4900,2)
 ;;=^5015598
 ;;^UTILITY(U,$J,358.3,4901,0)
 ;;=N39.0^^37^325^10
 ;;^UTILITY(U,$J,358.3,4901,1,0)
 ;;=^358.31IA^4^2
