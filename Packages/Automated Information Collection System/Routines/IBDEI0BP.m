IBDEI0BP ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5540,1,4,0)
 ;;=4^622.7
 ;;^UTILITY(U,$J,358.3,5540,1,5,0)
 ;;=5^Polyp of Cervix
 ;;^UTILITY(U,$J,358.3,5540,2)
 ;;=Polyp of Cervix^79612
 ;;^UTILITY(U,$J,358.3,5541,0)
 ;;=627.1^^41^487^45
 ;;^UTILITY(U,$J,358.3,5541,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5541,1,4,0)
 ;;=4^627.1
 ;;^UTILITY(U,$J,358.3,5541,1,5,0)
 ;;=5^Postmenopausal bleeding
 ;;^UTILITY(U,$J,358.3,5541,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,5542,0)
 ;;=V24.2^^41^487^46
 ;;^UTILITY(U,$J,358.3,5542,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5542,1,4,0)
 ;;=4^V24.2
 ;;^UTILITY(U,$J,358.3,5542,1,5,0)
 ;;=5^Postpartum
 ;;^UTILITY(U,$J,358.3,5542,2)
 ;;=Postpartum^114052
 ;;^UTILITY(U,$J,358.3,5543,0)
 ;;=V22.2^^41^487^47
 ;;^UTILITY(U,$J,358.3,5543,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5543,1,4,0)
 ;;=4^V22.2
 ;;^UTILITY(U,$J,358.3,5543,1,5,0)
 ;;=5^Pregnancy Status
 ;;^UTILITY(U,$J,358.3,5543,2)
 ;;=Pregnancy Status^97923
 ;;^UTILITY(U,$J,358.3,5544,0)
 ;;=627.0^^41^487^48
 ;;^UTILITY(U,$J,358.3,5544,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5544,1,4,0)
 ;;=4^627.0
 ;;^UTILITY(U,$J,358.3,5544,1,5,0)
 ;;=5^Premenopausal menorrhagia
 ;;^UTILITY(U,$J,358.3,5544,2)
 ;;=^270575
 ;;^UTILITY(U,$J,358.3,5545,0)
 ;;=625.4^^41^487^49
 ;;^UTILITY(U,$J,358.3,5545,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5545,1,4,0)
 ;;=4^625.4
 ;;^UTILITY(U,$J,358.3,5545,1,5,0)
 ;;=5^Premenstrual tension
 ;;^UTILITY(U,$J,358.3,5545,2)
 ;;=^98014
 ;;^UTILITY(U,$J,358.3,5546,0)
 ;;=302.70^^41^487^51
 ;;^UTILITY(U,$J,358.3,5546,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5546,1,4,0)
 ;;=4^302.70
 ;;^UTILITY(U,$J,358.3,5546,1,5,0)
 ;;=5^Sexual dysfunction, psychosexual
 ;;^UTILITY(U,$J,358.3,5546,2)
 ;;=^100647
 ;;^UTILITY(U,$J,358.3,5547,0)
 ;;=599.0^^41^487^55
 ;;^UTILITY(U,$J,358.3,5547,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5547,1,4,0)
 ;;=4^599.0
 ;;^UTILITY(U,$J,358.3,5547,1,5,0)
 ;;=5^Urinary Tract Infection
 ;;^UTILITY(U,$J,358.3,5547,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,5548,0)
 ;;=218.9^^41^487^56
 ;;^UTILITY(U,$J,358.3,5548,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5548,1,4,0)
 ;;=4^218.9
 ;;^UTILITY(U,$J,358.3,5548,1,5,0)
 ;;=5^Uterine Fibroids
 ;;^UTILITY(U,$J,358.3,5548,2)
 ;;=Uterine Fibroids^68944
 ;;^UTILITY(U,$J,358.3,5549,0)
 ;;=618.1^^41^487^57
 ;;^UTILITY(U,$J,358.3,5549,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5549,1,4,0)
 ;;=4^618.1
 ;;^UTILITY(U,$J,358.3,5549,1,5,0)
 ;;=5^Uterine Prolapse
 ;;^UTILITY(U,$J,358.3,5549,2)
 ;;=Uterine Prolapse^124773
 ;;^UTILITY(U,$J,358.3,5550,0)
 ;;=623.0^^41^487^58
 ;;^UTILITY(U,$J,358.3,5550,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5550,1,4,0)
 ;;=4^623.0
 ;;^UTILITY(U,$J,358.3,5550,1,5,0)
 ;;=5^Vaginal dysplasia
 ;;^UTILITY(U,$J,358.3,5550,2)
 ;;=^270536
 ;;^UTILITY(U,$J,358.3,5551,0)
 ;;=625.1^^41^487^59
 ;;^UTILITY(U,$J,358.3,5551,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5551,1,4,0)
 ;;=4^625.1
 ;;^UTILITY(U,$J,358.3,5551,1,5,0)
 ;;=5^Vaginismus
 ;;^UTILITY(U,$J,358.3,5551,2)
 ;;=Vaginismus^125225
 ;;^UTILITY(U,$J,358.3,5552,0)
 ;;=616.10^^41^487^61
 ;;^UTILITY(U,$J,358.3,5552,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5552,1,4,0)
 ;;=4^616.10
 ;;^UTILITY(U,$J,358.3,5552,1,5,0)
 ;;=5^Vaginitis, unsp cause
 ;;^UTILITY(U,$J,358.3,5552,2)
 ;;=^125233
 ;;^UTILITY(U,$J,358.3,5553,0)
 ;;=112.1^^41^487^67
 ;;^UTILITY(U,$J,358.3,5553,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5553,1,4,0)
 ;;=4^112.1
 ;;^UTILITY(U,$J,358.3,5553,1,5,0)
 ;;=5^Vulvovaginal Candidiasis
 ;;^UTILITY(U,$J,358.3,5553,2)
 ;;=^18615
 ;;^UTILITY(U,$J,358.3,5554,0)
 ;;=131.01^^41^487^60
