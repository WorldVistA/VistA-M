IBDEI06V ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3019,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3019,1,4,0)
 ;;=4^Aftercare after CA surgery
 ;;^UTILITY(U,$J,358.3,3019,1,5,0)
 ;;=5^V58.42
 ;;^UTILITY(U,$J,358.3,3019,2)
 ;;=Aftercare after CA surgery^295530
 ;;^UTILITY(U,$J,358.3,3020,0)
 ;;=V58.73^^26^246^5
 ;;^UTILITY(U,$J,358.3,3020,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3020,1,4,0)
 ;;=4^Aftercare after Vasc Surg
 ;;^UTILITY(U,$J,358.3,3020,1,5,0)
 ;;=5^V58.73
 ;;^UTILITY(U,$J,358.3,3020,2)
 ;;=Aftercare after Vasc Surg^295530
 ;;^UTILITY(U,$J,358.3,3021,0)
 ;;=V58.74^^26^246^3
 ;;^UTILITY(U,$J,358.3,3021,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3021,1,4,0)
 ;;=4^Aftercare after Lung Surg
 ;;^UTILITY(U,$J,358.3,3021,1,5,0)
 ;;=5^V58.74
 ;;^UTILITY(U,$J,358.3,3021,2)
 ;;=Aftercare after Lung Surg^295530
 ;;^UTILITY(U,$J,358.3,3022,0)
 ;;=V58.77^^26^246^4
 ;;^UTILITY(U,$J,358.3,3022,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3022,1,4,0)
 ;;=4^Aftercare after Skin Surg
 ;;^UTILITY(U,$J,358.3,3022,1,5,0)
 ;;=5^V58.77
 ;;^UTILITY(U,$J,358.3,3022,2)
 ;;=Aftercare after Skin Surg^295530
 ;;^UTILITY(U,$J,358.3,3023,0)
 ;;=V58.75^^26^246^2
 ;;^UTILITY(U,$J,358.3,3023,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3023,1,4,0)
 ;;=4^Aftercare after GI Surgery
 ;;^UTILITY(U,$J,358.3,3023,1,5,0)
 ;;=5^V58.75
 ;;^UTILITY(U,$J,358.3,3023,2)
 ;;=Aftercare after GI Surgery^295530
 ;;^UTILITY(U,$J,358.3,3024,0)
 ;;=V58.31^^26^246^12
 ;;^UTILITY(U,$J,358.3,3024,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3024,1,4,0)
 ;;=4^Removal Surg Dressing
 ;;^UTILITY(U,$J,358.3,3024,1,5,0)
 ;;=5^V58.31
 ;;^UTILITY(U,$J,358.3,3024,2)
 ;;=^334216
 ;;^UTILITY(U,$J,358.3,3025,0)
 ;;=V58.30^^26^246^10
 ;;^UTILITY(U,$J,358.3,3025,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3025,1,4,0)
 ;;=4^Change/Remove Dressing
 ;;^UTILITY(U,$J,358.3,3025,1,5,0)
 ;;=5^V58.30
 ;;^UTILITY(U,$J,358.3,3025,2)
 ;;=^334215
 ;;^UTILITY(U,$J,358.3,3026,0)
 ;;=V58.32^^26^246^13
 ;;^UTILITY(U,$J,358.3,3026,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3026,1,4,0)
 ;;=4^Removal Sutures
 ;;^UTILITY(U,$J,358.3,3026,1,5,0)
 ;;=5^V58.32
 ;;^UTILITY(U,$J,358.3,3026,2)
 ;;=^334217
 ;;^UTILITY(U,$J,358.3,3027,0)
 ;;=V58.71^^26^246^9
 ;;^UTILITY(U,$J,358.3,3027,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3027,1,4,0)
 ;;=4^Aftercare,Sense Organ Surg
 ;;^UTILITY(U,$J,358.3,3027,1,5,0)
 ;;=5^V58.71
 ;;^UTILITY(U,$J,358.3,3027,2)
 ;;=^328689
 ;;^UTILITY(U,$J,358.3,3028,0)
 ;;=V58.72^^26^246^8
 ;;^UTILITY(U,$J,358.3,3028,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3028,1,4,0)
 ;;=4^Aftercare,Nervous Sys Surg
 ;;^UTILITY(U,$J,358.3,3028,1,5,0)
 ;;=5^V58.72
 ;;^UTILITY(U,$J,358.3,3028,2)
 ;;=^328690
 ;;^UTILITY(U,$J,358.3,3029,0)
 ;;=V58.76^^26^246^6
 ;;^UTILITY(U,$J,358.3,3029,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3029,1,4,0)
 ;;=4^Aftercare,GU Surg
 ;;^UTILITY(U,$J,358.3,3029,1,5,0)
 ;;=5^V58.76
 ;;^UTILITY(U,$J,358.3,3029,2)
 ;;=^328694
 ;;^UTILITY(U,$J,358.3,3030,0)
 ;;=V58.78^^26^246^7
 ;;^UTILITY(U,$J,358.3,3030,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3030,1,4,0)
 ;;=4^Aftercare,Musculos Surg
 ;;^UTILITY(U,$J,358.3,3030,1,5,0)
 ;;=5^V58.78
 ;;^UTILITY(U,$J,358.3,3030,2)
 ;;=^328696
 ;;^UTILITY(U,$J,358.3,3031,0)
 ;;=443.9^^26^247^16
 ;;^UTILITY(U,$J,358.3,3031,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3031,1,4,0)
 ;;=4^PVD
 ;;^UTILITY(U,$J,358.3,3031,1,5,0)
 ;;=5^443.9
 ;;^UTILITY(U,$J,358.3,3031,2)
 ;;=PVD^184182
 ;;^UTILITY(U,$J,358.3,3032,0)
 ;;=441.4^^26^247^3
 ;;^UTILITY(U,$J,358.3,3032,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3032,1,4,0)
 ;;=4^Aneurysm,Abdom Aortic
