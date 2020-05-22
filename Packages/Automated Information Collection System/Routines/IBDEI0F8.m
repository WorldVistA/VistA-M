IBDEI0F8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6557,0)
 ;;=I72.6^^53^417^10
 ;;^UTILITY(U,$J,358.3,6557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6557,1,3,0)
 ;;=3^Aneurysm of Vertebral Artery
 ;;^UTILITY(U,$J,358.3,6557,1,4,0)
 ;;=4^I72.6
 ;;^UTILITY(U,$J,358.3,6557,2)
 ;;=^5138669
 ;;^UTILITY(U,$J,358.3,6558,0)
 ;;=I63.133^^53^417^54
 ;;^UTILITY(U,$J,358.3,6558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6558,1,3,0)
 ;;=3^Cerebral Infarction d/t Embolism of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,6558,1,4,0)
 ;;=4^I63.133
 ;;^UTILITY(U,$J,358.3,6558,2)
 ;;=^5138605
 ;;^UTILITY(U,$J,358.3,6559,0)
 ;;=I63.033^^53^417^57
 ;;^UTILITY(U,$J,358.3,6559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6559,1,3,0)
 ;;=3^Cerebral Infarction d/t Thrombosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,6559,1,4,0)
 ;;=4^I63.033
 ;;^UTILITY(U,$J,358.3,6559,2)
 ;;=^5138603
 ;;^UTILITY(U,$J,358.3,6560,0)
 ;;=I63.213^^53^417^65
 ;;^UTILITY(U,$J,358.3,6560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6560,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occl/Stenosis of Bilateral Vertebral Artery
 ;;^UTILITY(U,$J,358.3,6560,1,4,0)
 ;;=4^I63.213
 ;;^UTILITY(U,$J,358.3,6560,2)
 ;;=^5138606
 ;;^UTILITY(U,$J,358.3,6561,0)
 ;;=I77.77^^53^417^69
 ;;^UTILITY(U,$J,358.3,6561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6561,1,3,0)
 ;;=3^Dissection of Artery of Lower Extremity
 ;;^UTILITY(U,$J,358.3,6561,1,4,0)
 ;;=4^I77.77
 ;;^UTILITY(U,$J,358.3,6561,2)
 ;;=^5138672
 ;;^UTILITY(U,$J,358.3,6562,0)
 ;;=I77.76^^53^417^70
 ;;^UTILITY(U,$J,358.3,6562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6562,1,3,0)
 ;;=3^Dissection of Artery of Upper Extremity
 ;;^UTILITY(U,$J,358.3,6562,1,4,0)
 ;;=4^I77.76
 ;;^UTILITY(U,$J,358.3,6562,2)
 ;;=^8292560
 ;;^UTILITY(U,$J,358.3,6563,0)
 ;;=I77.75^^53^417^71
 ;;^UTILITY(U,$J,358.3,6563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6563,1,3,0)
 ;;=3^Dissection of Other Precerebral Arteries
 ;;^UTILITY(U,$J,358.3,6563,1,4,0)
 ;;=4^I77.75
 ;;^UTILITY(U,$J,358.3,6563,2)
 ;;=^5138671
 ;;^UTILITY(U,$J,358.3,6564,0)
 ;;=I77.79^^53^417^74
 ;;^UTILITY(U,$J,358.3,6564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6564,1,3,0)
 ;;=3^Dissection of Unspec Artery
 ;;^UTILITY(U,$J,358.3,6564,1,4,0)
 ;;=4^I77.79
 ;;^UTILITY(U,$J,358.3,6564,2)
 ;;=^328513
 ;;^UTILITY(U,$J,358.3,6565,0)
 ;;=T82.855A^^53^417^96
 ;;^UTILITY(U,$J,358.3,6565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6565,1,3,0)
 ;;=3^Stenosis/Restenosis of Coronary Artery Stent,Init Encntr
 ;;^UTILITY(U,$J,358.3,6565,1,4,0)
 ;;=4^T82.855A
 ;;^UTILITY(U,$J,358.3,6565,2)
 ;;=^5140030
 ;;^UTILITY(U,$J,358.3,6566,0)
 ;;=T82.856A^^53^417^97
 ;;^UTILITY(U,$J,358.3,6566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6566,1,3,0)
 ;;=3^Stenosis/Restenosis of Periph Vascular Stent,Init Encntr
 ;;^UTILITY(U,$J,358.3,6566,1,4,0)
 ;;=4^T82.856A
 ;;^UTILITY(U,$J,358.3,6566,2)
 ;;=^5140033
 ;;^UTILITY(U,$J,358.3,6567,0)
 ;;=I63.233^^53^417^66
 ;;^UTILITY(U,$J,358.3,6567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6567,1,3,0)
 ;;=3^Cerebral Infarction d/t Unspec Occl/Stenosis of Bilateral Carotid Artery
 ;;^UTILITY(U,$J,358.3,6567,1,4,0)
 ;;=4^I63.233
 ;;^UTILITY(U,$J,358.3,6567,2)
 ;;=^5138607
 ;;^UTILITY(U,$J,358.3,6568,0)
 ;;=I08.0^^53^418^5
 ;;^UTILITY(U,$J,358.3,6568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6568,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral and Aortic Valves
