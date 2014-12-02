IBDEI0IE ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8960,0)
 ;;=209.33^^61^631^3
 ;;^UTILITY(U,$J,358.3,8960,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8960,1,4,0)
 ;;=4^Merkel Cell CA-Upper Limb
 ;;^UTILITY(U,$J,358.3,8960,1,5,0)
 ;;=5^209.33
 ;;^UTILITY(U,$J,358.3,8960,2)
 ;;=^338214
 ;;^UTILITY(U,$J,358.3,8961,0)
 ;;=209.34^^61^631^4
 ;;^UTILITY(U,$J,358.3,8961,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8961,1,4,0)
 ;;=4^Merkel Cell CA-Lower Limb
 ;;^UTILITY(U,$J,358.3,8961,1,5,0)
 ;;=5^209.34
 ;;^UTILITY(U,$J,358.3,8961,2)
 ;;=^338215
 ;;^UTILITY(U,$J,358.3,8962,0)
 ;;=209.35^^61^631^5
 ;;^UTILITY(U,$J,358.3,8962,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8962,1,4,0)
 ;;=4^Merkel Cell-Trunk
 ;;^UTILITY(U,$J,358.3,8962,1,5,0)
 ;;=5^209.35
 ;;^UTILITY(U,$J,358.3,8962,2)
 ;;=^338216
 ;;^UTILITY(U,$J,358.3,8963,0)
 ;;=209.36^^61^631^6
 ;;^UTILITY(U,$J,358.3,8963,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8963,1,4,0)
 ;;=4^Merkel Cell CA-Oth Sites
 ;;^UTILITY(U,$J,358.3,8963,1,5,0)
 ;;=5^209.36
 ;;^UTILITY(U,$J,358.3,8963,2)
 ;;=^338217
 ;;^UTILITY(U,$J,358.3,8964,0)
 ;;=V67.09^^61^632^11
 ;;^UTILITY(U,$J,358.3,8964,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8964,1,4,0)
 ;;=4^F/U exam, Following Surg
 ;;^UTILITY(U,$J,358.3,8964,1,5,0)
 ;;=5^V67.09
 ;;^UTILITY(U,$J,358.3,8964,2)
 ;;=F/U exam, completed treatment^322080
 ;;^UTILITY(U,$J,358.3,8965,0)
 ;;=V58.42^^61^632^1
 ;;^UTILITY(U,$J,358.3,8965,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8965,1,4,0)
 ;;=4^Aftercare after CA surgery
 ;;^UTILITY(U,$J,358.3,8965,1,5,0)
 ;;=5^V58.42
 ;;^UTILITY(U,$J,358.3,8965,2)
 ;;=Aftercare after CA surgery^295530
 ;;^UTILITY(U,$J,358.3,8966,0)
 ;;=V58.73^^61^632^5
 ;;^UTILITY(U,$J,358.3,8966,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8966,1,4,0)
 ;;=4^Aftercare after Vasc Surg
 ;;^UTILITY(U,$J,358.3,8966,1,5,0)
 ;;=5^V58.73
 ;;^UTILITY(U,$J,358.3,8966,2)
 ;;=Aftercare after Vasc Surg^295530
 ;;^UTILITY(U,$J,358.3,8967,0)
 ;;=V58.74^^61^632^3
 ;;^UTILITY(U,$J,358.3,8967,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8967,1,4,0)
 ;;=4^Aftercare after Lung Surg
 ;;^UTILITY(U,$J,358.3,8967,1,5,0)
 ;;=5^V58.74
 ;;^UTILITY(U,$J,358.3,8967,2)
 ;;=Aftercare after Lung Surg^295530
 ;;^UTILITY(U,$J,358.3,8968,0)
 ;;=V58.77^^61^632^4
 ;;^UTILITY(U,$J,358.3,8968,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8968,1,4,0)
 ;;=4^Aftercare after Skin Surg
 ;;^UTILITY(U,$J,358.3,8968,1,5,0)
 ;;=5^V58.77
 ;;^UTILITY(U,$J,358.3,8968,2)
 ;;=Aftercare after Skin Surg^295530
 ;;^UTILITY(U,$J,358.3,8969,0)
 ;;=V58.75^^61^632^2
 ;;^UTILITY(U,$J,358.3,8969,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8969,1,4,0)
 ;;=4^Aftercare after GI Surgery
 ;;^UTILITY(U,$J,358.3,8969,1,5,0)
 ;;=5^V58.75
 ;;^UTILITY(U,$J,358.3,8969,2)
 ;;=Aftercare after GI Surgery^295530
 ;;^UTILITY(U,$J,358.3,8970,0)
 ;;=V58.31^^61^632^12
 ;;^UTILITY(U,$J,358.3,8970,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8970,1,4,0)
 ;;=4^Removal Surg Dressing
 ;;^UTILITY(U,$J,358.3,8970,1,5,0)
 ;;=5^V58.31
 ;;^UTILITY(U,$J,358.3,8970,2)
 ;;=^334216
 ;;^UTILITY(U,$J,358.3,8971,0)
 ;;=V58.30^^61^632^10
 ;;^UTILITY(U,$J,358.3,8971,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8971,1,4,0)
 ;;=4^Change/Remove Dressing
 ;;^UTILITY(U,$J,358.3,8971,1,5,0)
 ;;=5^V58.30
 ;;^UTILITY(U,$J,358.3,8971,2)
 ;;=^334215
 ;;^UTILITY(U,$J,358.3,8972,0)
 ;;=V58.32^^61^632^13
 ;;^UTILITY(U,$J,358.3,8972,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8972,1,4,0)
 ;;=4^Removal Sutures
 ;;^UTILITY(U,$J,358.3,8972,1,5,0)
 ;;=5^V58.32
 ;;^UTILITY(U,$J,358.3,8972,2)
 ;;=^334217
 ;;^UTILITY(U,$J,358.3,8973,0)
 ;;=V58.71^^61^632^9
