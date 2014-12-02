IBDEI09L ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4434,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4434,1,4,0)
 ;;=4^Merkel Cell CA-Face
 ;;^UTILITY(U,$J,358.3,4434,1,5,0)
 ;;=5^209.31
 ;;^UTILITY(U,$J,358.3,4434,2)
 ;;=^338212
 ;;^UTILITY(U,$J,358.3,4435,0)
 ;;=209.32^^37^340^2
 ;;^UTILITY(U,$J,358.3,4435,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4435,1,4,0)
 ;;=4^Merkel Cell CA-Sclp/Neck
 ;;^UTILITY(U,$J,358.3,4435,1,5,0)
 ;;=5^209.32
 ;;^UTILITY(U,$J,358.3,4435,2)
 ;;=^338213
 ;;^UTILITY(U,$J,358.3,4436,0)
 ;;=209.33^^37^340^3
 ;;^UTILITY(U,$J,358.3,4436,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4436,1,4,0)
 ;;=4^Merkel Cell CA-Upper Limb
 ;;^UTILITY(U,$J,358.3,4436,1,5,0)
 ;;=5^209.33
 ;;^UTILITY(U,$J,358.3,4436,2)
 ;;=^338214
 ;;^UTILITY(U,$J,358.3,4437,0)
 ;;=209.34^^37^340^4
 ;;^UTILITY(U,$J,358.3,4437,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4437,1,4,0)
 ;;=4^Merkel Cell CA-Lower Limb
 ;;^UTILITY(U,$J,358.3,4437,1,5,0)
 ;;=5^209.34
 ;;^UTILITY(U,$J,358.3,4437,2)
 ;;=^338215
 ;;^UTILITY(U,$J,358.3,4438,0)
 ;;=209.35^^37^340^5
 ;;^UTILITY(U,$J,358.3,4438,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4438,1,4,0)
 ;;=4^Merkel Cell-Trunk
 ;;^UTILITY(U,$J,358.3,4438,1,5,0)
 ;;=5^209.35
 ;;^UTILITY(U,$J,358.3,4438,2)
 ;;=^338216
 ;;^UTILITY(U,$J,358.3,4439,0)
 ;;=209.36^^37^340^6
 ;;^UTILITY(U,$J,358.3,4439,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4439,1,4,0)
 ;;=4^Merkel Cell CA-Oth Sites
 ;;^UTILITY(U,$J,358.3,4439,1,5,0)
 ;;=5^209.36
 ;;^UTILITY(U,$J,358.3,4439,2)
 ;;=^338217
 ;;^UTILITY(U,$J,358.3,4440,0)
 ;;=V67.09^^37^341^11
 ;;^UTILITY(U,$J,358.3,4440,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4440,1,4,0)
 ;;=4^F/U exam, Following Surg
 ;;^UTILITY(U,$J,358.3,4440,1,5,0)
 ;;=5^V67.09
 ;;^UTILITY(U,$J,358.3,4440,2)
 ;;=F/U exam, completed treatment^322080
 ;;^UTILITY(U,$J,358.3,4441,0)
 ;;=V58.42^^37^341^1
 ;;^UTILITY(U,$J,358.3,4441,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4441,1,4,0)
 ;;=4^Aftercare after CA surgery
 ;;^UTILITY(U,$J,358.3,4441,1,5,0)
 ;;=5^V58.42
 ;;^UTILITY(U,$J,358.3,4441,2)
 ;;=Aftercare after CA surgery^295530
 ;;^UTILITY(U,$J,358.3,4442,0)
 ;;=V58.73^^37^341^5
 ;;^UTILITY(U,$J,358.3,4442,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4442,1,4,0)
 ;;=4^Aftercare after Vasc Surg
 ;;^UTILITY(U,$J,358.3,4442,1,5,0)
 ;;=5^V58.73
 ;;^UTILITY(U,$J,358.3,4442,2)
 ;;=Aftercare after Vasc Surg^295530
 ;;^UTILITY(U,$J,358.3,4443,0)
 ;;=V58.74^^37^341^3
 ;;^UTILITY(U,$J,358.3,4443,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4443,1,4,0)
 ;;=4^Aftercare after Lung Surg
 ;;^UTILITY(U,$J,358.3,4443,1,5,0)
 ;;=5^V58.74
 ;;^UTILITY(U,$J,358.3,4443,2)
 ;;=Aftercare after Lung Surg^295530
 ;;^UTILITY(U,$J,358.3,4444,0)
 ;;=V58.77^^37^341^4
 ;;^UTILITY(U,$J,358.3,4444,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4444,1,4,0)
 ;;=4^Aftercare after Skin Surg
 ;;^UTILITY(U,$J,358.3,4444,1,5,0)
 ;;=5^V58.77
 ;;^UTILITY(U,$J,358.3,4444,2)
 ;;=Aftercare after Skin Surg^295530
 ;;^UTILITY(U,$J,358.3,4445,0)
 ;;=V58.75^^37^341^2
 ;;^UTILITY(U,$J,358.3,4445,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4445,1,4,0)
 ;;=4^Aftercare after GI Surgery
 ;;^UTILITY(U,$J,358.3,4445,1,5,0)
 ;;=5^V58.75
 ;;^UTILITY(U,$J,358.3,4445,2)
 ;;=Aftercare after GI Surgery^295530
 ;;^UTILITY(U,$J,358.3,4446,0)
 ;;=V58.31^^37^341^12
 ;;^UTILITY(U,$J,358.3,4446,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4446,1,4,0)
 ;;=4^Removal Surg Dressing
 ;;^UTILITY(U,$J,358.3,4446,1,5,0)
 ;;=5^V58.31
 ;;^UTILITY(U,$J,358.3,4446,2)
 ;;=^334216
 ;;^UTILITY(U,$J,358.3,4447,0)
 ;;=V58.30^^37^341^10
 ;;^UTILITY(U,$J,358.3,4447,1,0)
 ;;=^358.31IA^5^2
