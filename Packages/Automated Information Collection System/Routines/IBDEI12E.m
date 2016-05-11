IBDEI12E ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18098,1,2,0)
 ;;=2^Vertebroplasty,Ea Addl Inj
 ;;^UTILITY(U,$J,358.3,18098,1,4,0)
 ;;=4^22512
 ;;^UTILITY(U,$J,358.3,18099,0)
 ;;=22511^^77^867^2^^^^1
 ;;^UTILITY(U,$J,358.3,18099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18099,1,2,0)
 ;;=2^Vertebroplasty Lumbosacral
 ;;^UTILITY(U,$J,358.3,18099,1,4,0)
 ;;=4^22511
 ;;^UTILITY(U,$J,358.3,18100,0)
 ;;=32998^^77^868^6^^^^1
 ;;^UTILITY(U,$J,358.3,18100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18100,1,2,0)
 ;;=2^RFA Pulm Tumor Incl Pleura/Chest Wall Percut
 ;;^UTILITY(U,$J,358.3,18100,1,4,0)
 ;;=4^32998
 ;;^UTILITY(U,$J,358.3,18101,0)
 ;;=20982^^77^868^4^^^^1
 ;;^UTILITY(U,$J,358.3,18101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18101,1,2,0)
 ;;=2^RFA 1 or More Bone Tumors Percut
 ;;^UTILITY(U,$J,358.3,18101,1,4,0)
 ;;=4^20982
 ;;^UTILITY(U,$J,358.3,18102,0)
 ;;=47382^^77^868^5^^^^1
 ;;^UTILITY(U,$J,358.3,18102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18102,1,2,0)
 ;;=2^RFA 1 or More Liver Tumors Percut
 ;;^UTILITY(U,$J,358.3,18102,1,4,0)
 ;;=4^47382
 ;;^UTILITY(U,$J,358.3,18103,0)
 ;;=50593^^77^868^1^^^^1
 ;;^UTILITY(U,$J,358.3,18103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18103,1,2,0)
 ;;=2^Ablation Renal Tumor,Unilat,Percut
 ;;^UTILITY(U,$J,358.3,18103,1,4,0)
 ;;=4^50593
 ;;^UTILITY(U,$J,358.3,18104,0)
 ;;=76940^^77^868^7^^^^1
 ;;^UTILITY(U,$J,358.3,18104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18104,1,2,0)
 ;;=2^US Guide/Monitor,Parenchymal Tissue Abl
 ;;^UTILITY(U,$J,358.3,18104,1,4,0)
 ;;=4^76940
 ;;^UTILITY(U,$J,358.3,18105,0)
 ;;=77013^^77^868^2^^^^1
 ;;^UTILITY(U,$J,358.3,18105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18105,1,2,0)
 ;;=2^CT Guide/Monitor,Parenchymal Tissue Abl
 ;;^UTILITY(U,$J,358.3,18105,1,4,0)
 ;;=4^77013
 ;;^UTILITY(U,$J,358.3,18106,0)
 ;;=77022^^77^868^3^^^^1
 ;;^UTILITY(U,$J,358.3,18106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18106,1,2,0)
 ;;=2^MRI Guide/Monitor,Parenchymal Tissue Abl
 ;;^UTILITY(U,$J,358.3,18106,1,4,0)
 ;;=4^77022
 ;;^UTILITY(U,$J,358.3,18107,0)
 ;;=36246^^77^869^1^^^^1
 ;;^UTILITY(U,$J,358.3,18107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18107,1,2,0)
 ;;=2^Sel Cath Plcmt,Int 2nd Order,Abd/Pel/Low Ext
 ;;^UTILITY(U,$J,358.3,18107,1,4,0)
 ;;=4^36246
 ;;^UTILITY(U,$J,358.3,18108,0)
 ;;=36248^^77^869^2^^^^1
 ;;^UTILITY(U,$J,358.3,18108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18108,1,2,0)
 ;;=2^Sel Cath Plcmt,Addl 2nd Order
 ;;^UTILITY(U,$J,358.3,18108,1,4,0)
 ;;=4^36248
 ;;^UTILITY(U,$J,358.3,18109,0)
 ;;=75774^^77^869^4^^^^1
 ;;^UTILITY(U,$J,358.3,18109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18109,1,2,0)
 ;;=2^Angio,Sel,Ea Addl Vessel
 ;;^UTILITY(U,$J,358.3,18109,1,4,0)
 ;;=4^75774
 ;;^UTILITY(U,$J,358.3,18110,0)
 ;;=75894^^77^869^3^^^^1
 ;;^UTILITY(U,$J,358.3,18110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18110,1,2,0)
 ;;=2^Transcath Tx,Emobolization,Any Method S&I
 ;;^UTILITY(U,$J,358.3,18110,1,4,0)
 ;;=4^75894
 ;;^UTILITY(U,$J,358.3,18111,0)
 ;;=77778^^77^870^5^^^^1
 ;;^UTILITY(U,$J,358.3,18111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18111,1,2,0)
 ;;=2^Interstitial Radiation Source App;Complex
 ;;^UTILITY(U,$J,358.3,18111,1,4,0)
 ;;=4^77778
 ;;^UTILITY(U,$J,358.3,18112,0)
 ;;=79445^^77^870^8^^^^1
 ;;^UTILITY(U,$J,358.3,18112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18112,1,2,0)
 ;;=2^Radiopharm Tx,Intra-Articular Admin
 ;;^UTILITY(U,$J,358.3,18112,1,4,0)
 ;;=4^79445
 ;;^UTILITY(U,$J,358.3,18113,0)
 ;;=77300^^77^870^1^^^^1
 ;;^UTILITY(U,$J,358.3,18113,1,0)
 ;;=^358.31IA^4^2
