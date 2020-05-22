IBDEI0HY ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7818,1,4,0)
 ;;=4^K91.31
 ;;^UTILITY(U,$J,358.3,7818,2)
 ;;=^5151428
 ;;^UTILITY(U,$J,358.3,7819,0)
 ;;=K91.32^^63^503^25
 ;;^UTILITY(U,$J,358.3,7819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7819,1,3,0)
 ;;=3^Postprocedural Intestinal Obstruction,Complete
 ;;^UTILITY(U,$J,358.3,7819,1,4,0)
 ;;=4^K91.32
 ;;^UTILITY(U,$J,358.3,7819,2)
 ;;=^5151429
 ;;^UTILITY(U,$J,358.3,7820,0)
 ;;=J95.2^^63^503^31
 ;;^UTILITY(U,$J,358.3,7820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7820,1,3,0)
 ;;=3^Pulmonary Insufficiency,Acute,Following Nonthoracic Surgery
 ;;^UTILITY(U,$J,358.3,7820,1,4,0)
 ;;=4^J95.2
 ;;^UTILITY(U,$J,358.3,7820,2)
 ;;=^5008328
 ;;^UTILITY(U,$J,358.3,7821,0)
 ;;=J95.1^^63^503^32
 ;;^UTILITY(U,$J,358.3,7821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7821,1,3,0)
 ;;=3^Pulmonary Insufficiency,Acute,Following Thoracic Surgery
 ;;^UTILITY(U,$J,358.3,7821,1,4,0)
 ;;=4^J95.1
 ;;^UTILITY(U,$J,358.3,7821,2)
 ;;=^5008327
 ;;^UTILITY(U,$J,358.3,7822,0)
 ;;=T81.41XA^^63^503^19
 ;;^UTILITY(U,$J,358.3,7822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7822,1,3,0)
 ;;=3^Infection Following Proc,Superficial Incis Surg Site,Init Enc
 ;;^UTILITY(U,$J,358.3,7822,1,4,0)
 ;;=4^T81.41XA
 ;;^UTILITY(U,$J,358.3,7822,2)
 ;;=^5157587
 ;;^UTILITY(U,$J,358.3,7823,0)
 ;;=T81.42XA^^63^503^16
 ;;^UTILITY(U,$J,358.3,7823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7823,1,3,0)
 ;;=3^Infection Following Proc,Deep Incis Surg Site,Init Enc
 ;;^UTILITY(U,$J,358.3,7823,1,4,0)
 ;;=4^T81.42XA
 ;;^UTILITY(U,$J,358.3,7823,2)
 ;;=^5157590
 ;;^UTILITY(U,$J,358.3,7824,0)
 ;;=T81.43XA^^63^503^17
 ;;^UTILITY(U,$J,358.3,7824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7824,1,3,0)
 ;;=3^Infection Following Proc,Organ/Space Surg Site,Init Enc
 ;;^UTILITY(U,$J,358.3,7824,1,4,0)
 ;;=4^T81.43XA
 ;;^UTILITY(U,$J,358.3,7824,2)
 ;;=^5157593
 ;;^UTILITY(U,$J,358.3,7825,0)
 ;;=T81.49XA^^63^503^18
 ;;^UTILITY(U,$J,358.3,7825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7825,1,3,0)
 ;;=3^Infection Following Proc,Other Surg Site,Init Enc
 ;;^UTILITY(U,$J,358.3,7825,1,4,0)
 ;;=4^T81.49XA
 ;;^UTILITY(U,$J,358.3,7825,2)
 ;;=^5157599
 ;;^UTILITY(U,$J,358.3,7826,0)
 ;;=T81.44XA^^63^503^33
 ;;^UTILITY(U,$J,358.3,7826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7826,1,3,0)
 ;;=3^Sepsis Following Proc,Init Enc
 ;;^UTILITY(U,$J,358.3,7826,1,4,0)
 ;;=4^T81.44XA
 ;;^UTILITY(U,$J,358.3,7826,2)
 ;;=^5157596
 ;;^UTILITY(U,$J,358.3,7827,0)
 ;;=A41.51^^63^504^3
 ;;^UTILITY(U,$J,358.3,7827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7827,1,3,0)
 ;;=3^Sepsis d/t Escherichia Coli 
 ;;^UTILITY(U,$J,358.3,7827,1,4,0)
 ;;=4^A41.51
 ;;^UTILITY(U,$J,358.3,7827,2)
 ;;=^5000208
 ;;^UTILITY(U,$J,358.3,7828,0)
 ;;=A41.89^^63^504^4
 ;;^UTILITY(U,$J,358.3,7828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7828,1,3,0)
 ;;=3^Sepsis,Oth Spec
 ;;^UTILITY(U,$J,358.3,7828,1,4,0)
 ;;=4^A41.89
 ;;^UTILITY(U,$J,358.3,7828,2)
 ;;=^5000213
 ;;^UTILITY(U,$J,358.3,7829,0)
 ;;=A41.50^^63^504^1
 ;;^UTILITY(U,$J,358.3,7829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7829,1,3,0)
 ;;=3^Gram-Negative Sepsis,Unspec
 ;;^UTILITY(U,$J,358.3,7829,1,4,0)
 ;;=4^A41.50
 ;;^UTILITY(U,$J,358.3,7829,2)
 ;;=^5000207
 ;;^UTILITY(U,$J,358.3,7830,0)
 ;;=A41.9^^63^504^5
 ;;^UTILITY(U,$J,358.3,7830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7830,1,3,0)
 ;;=3^Sepsis,Unspec Organism
