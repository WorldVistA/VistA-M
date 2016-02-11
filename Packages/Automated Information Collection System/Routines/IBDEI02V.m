IBDEI02V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,579,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,579,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,580,0)
 ;;=E11.622^^6^69^67
 ;;^UTILITY(U,$J,358.3,580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,580,1,3,0)
 ;;=3^Diabetes Type 2 w/ Skin Ulcer
 ;;^UTILITY(U,$J,358.3,580,1,4,0)
 ;;=4^E11.622
 ;;^UTILITY(U,$J,358.3,580,2)
 ;;=^5002657
 ;;^UTILITY(U,$J,358.3,581,0)
 ;;=E11.628^^6^69^66
 ;;^UTILITY(U,$J,358.3,581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,581,1,3,0)
 ;;=3^Diabetes Type 2 w/ Skin Complications
 ;;^UTILITY(U,$J,358.3,581,1,4,0)
 ;;=4^E11.628
 ;;^UTILITY(U,$J,358.3,581,2)
 ;;=^5002658
 ;;^UTILITY(U,$J,358.3,582,0)
 ;;=E11.630^^6^69^61
 ;;^UTILITY(U,$J,358.3,582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,582,1,3,0)
 ;;=3^Diabetes Type 2 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,582,1,4,0)
 ;;=4^E11.630
 ;;^UTILITY(U,$J,358.3,582,2)
 ;;=^5002659
 ;;^UTILITY(U,$J,358.3,583,0)
 ;;=E11.638^^6^69^60
 ;;^UTILITY(U,$J,358.3,583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,583,1,3,0)
 ;;=3^Diabetes Type 2 w/ Oral Complications
 ;;^UTILITY(U,$J,358.3,583,1,4,0)
 ;;=4^E11.638
 ;;^UTILITY(U,$J,358.3,583,2)
 ;;=^5002660
 ;;^UTILITY(U,$J,358.3,584,0)
 ;;=E11.69^^6^69^68
 ;;^UTILITY(U,$J,358.3,584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,584,1,3,0)
 ;;=3^Diabetes Type 2 w/ Specified Complication
 ;;^UTILITY(U,$J,358.3,584,1,4,0)
 ;;=4^E11.69
 ;;^UTILITY(U,$J,358.3,584,2)
 ;;=^5002664
 ;;^UTILITY(U,$J,358.3,585,0)
 ;;=E11.8^^6^69^69
 ;;^UTILITY(U,$J,358.3,585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,585,1,3,0)
 ;;=3^Diabetes Type 2 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,585,1,4,0)
 ;;=4^E11.8
 ;;^UTILITY(U,$J,358.3,585,2)
 ;;=^5002665
 ;;^UTILITY(U,$J,358.3,586,0)
 ;;=H54.8^^6^70^2
 ;;^UTILITY(U,$J,358.3,586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,586,1,3,0)
 ;;=3^Legal Blindness (Defined in USA)
 ;;^UTILITY(U,$J,358.3,586,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,586,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,587,0)
 ;;=H91.90^^6^70^1
 ;;^UTILITY(U,$J,358.3,587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,587,1,3,0)
 ;;=3^Hearing Loss,Unspec
 ;;^UTILITY(U,$J,358.3,587,1,4,0)
 ;;=4^H91.90
 ;;^UTILITY(U,$J,358.3,587,2)
 ;;=^5006943
 ;;^UTILITY(U,$J,358.3,588,0)
 ;;=G23.8^^6^71^3
 ;;^UTILITY(U,$J,358.3,588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,588,1,3,0)
 ;;=3^Basal Ganglia Degenerative Diseases,Other Spec
 ;;^UTILITY(U,$J,358.3,588,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,588,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,589,0)
 ;;=F04.^^6^71^1
 ;;^UTILITY(U,$J,358.3,589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,589,1,3,0)
 ;;=3^Amnestic Disorder d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,589,1,4,0)
 ;;=4^F04.
 ;;^UTILITY(U,$J,358.3,589,2)
 ;;=^5003051
 ;;^UTILITY(U,$J,358.3,590,0)
 ;;=F05.^^6^71^4
 ;;^UTILITY(U,$J,358.3,590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,590,1,3,0)
 ;;=3^Delirium d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,590,1,4,0)
 ;;=4^F05.
 ;;^UTILITY(U,$J,358.3,590,2)
 ;;=^5003052
 ;;^UTILITY(U,$J,358.3,591,0)
 ;;=F06.8^^6^71^6
 ;;^UTILITY(U,$J,358.3,591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,591,1,3,0)
 ;;=3^Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,591,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,591,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,592,0)
 ;;=F32.9^^6^71^5
 ;;^UTILITY(U,$J,358.3,592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,592,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,592,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,592,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,593,0)
 ;;=F41.9^^6^71^2
