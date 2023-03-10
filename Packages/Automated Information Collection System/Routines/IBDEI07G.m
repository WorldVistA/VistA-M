IBDEI07G ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18143,1,3,0)
 ;;=3^Gestational HTN w/o Significant Protein Comp the Puerperium
 ;;^UTILITY(U,$J,358.3,18143,1,4,0)
 ;;=4^O13.5
 ;;^UTILITY(U,$J,358.3,18143,2)
 ;;=^5139013
 ;;^UTILITY(U,$J,358.3,18144,0)
 ;;=O21.0^^62^735^3
 ;;^UTILITY(U,$J,358.3,18144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18144,1,3,0)
 ;;=3^Mild hyperemesis gravidarum
 ;;^UTILITY(U,$J,358.3,18144,1,4,0)
 ;;=4^O21.0
 ;;^UTILITY(U,$J,358.3,18144,2)
 ;;=^5016185
 ;;^UTILITY(U,$J,358.3,18145,0)
 ;;=O21.1^^62^735^1
 ;;^UTILITY(U,$J,358.3,18145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18145,1,3,0)
 ;;=3^Hyperemesis gravidarum with metabolic disturbance
 ;;^UTILITY(U,$J,358.3,18145,1,4,0)
 ;;=4^O21.1
 ;;^UTILITY(U,$J,358.3,18145,2)
 ;;=^270869
 ;;^UTILITY(U,$J,358.3,18146,0)
 ;;=O21.2^^62^735^2
 ;;^UTILITY(U,$J,358.3,18146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18146,1,3,0)
 ;;=3^Late vomiting of pregnancy
 ;;^UTILITY(U,$J,358.3,18146,1,4,0)
 ;;=4^O21.2
 ;;^UTILITY(U,$J,358.3,18146,2)
 ;;=^270873
 ;;^UTILITY(U,$J,358.3,18147,0)
 ;;=O48.0^^62^736^1
 ;;^UTILITY(U,$J,358.3,18147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18147,1,3,0)
 ;;=3^Post-term pregnancy
 ;;^UTILITY(U,$J,358.3,18147,1,4,0)
 ;;=4^O48.0
 ;;^UTILITY(U,$J,358.3,18147,2)
 ;;=^5017495
 ;;^UTILITY(U,$J,358.3,18148,0)
 ;;=O48.1^^62^736^2
 ;;^UTILITY(U,$J,358.3,18148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18148,1,3,0)
 ;;=3^Prolonged pregnancy
 ;;^UTILITY(U,$J,358.3,18148,1,4,0)
 ;;=4^O48.1
 ;;^UTILITY(U,$J,358.3,18148,2)
 ;;=^5017496
 ;;^UTILITY(U,$J,358.3,18149,0)
 ;;=O31.03X0^^62^737^62
 ;;^UTILITY(U,$J,358.3,18149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18149,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, not applicable or unsp
 ;;^UTILITY(U,$J,358.3,18149,1,4,0)
 ;;=4^O31.03X0
 ;;^UTILITY(U,$J,358.3,18149,2)
 ;;=^5016523
 ;;^UTILITY(U,$J,358.3,18150,0)
 ;;=O31.03X1^^62^737^57
 ;;^UTILITY(U,$J,358.3,18150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18150,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 1
 ;;^UTILITY(U,$J,358.3,18150,1,4,0)
 ;;=4^O31.03X1
 ;;^UTILITY(U,$J,358.3,18150,2)
 ;;=^5016524
 ;;^UTILITY(U,$J,358.3,18151,0)
 ;;=O31.03X2^^62^737^58
 ;;^UTILITY(U,$J,358.3,18151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18151,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 2
 ;;^UTILITY(U,$J,358.3,18151,1,4,0)
 ;;=4^O31.03X2
 ;;^UTILITY(U,$J,358.3,18151,2)
 ;;=^5016525
 ;;^UTILITY(U,$J,358.3,18152,0)
 ;;=O31.03X3^^62^737^59
 ;;^UTILITY(U,$J,358.3,18152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18152,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 3
 ;;^UTILITY(U,$J,358.3,18152,1,4,0)
 ;;=4^O31.03X3
 ;;^UTILITY(U,$J,358.3,18152,2)
 ;;=^5016526
 ;;^UTILITY(U,$J,358.3,18153,0)
 ;;=O31.03X4^^62^737^60
 ;;^UTILITY(U,$J,358.3,18153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18153,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 4
 ;;^UTILITY(U,$J,358.3,18153,1,4,0)
 ;;=4^O31.03X4
 ;;^UTILITY(U,$J,358.3,18153,2)
 ;;=^5016527
 ;;^UTILITY(U,$J,358.3,18154,0)
 ;;=O31.03X5^^62^737^61
 ;;^UTILITY(U,$J,358.3,18154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18154,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 5
 ;;^UTILITY(U,$J,358.3,18154,1,4,0)
 ;;=4^O31.03X5
 ;;^UTILITY(U,$J,358.3,18154,2)
 ;;=^5016528
 ;;^UTILITY(U,$J,358.3,18155,0)
 ;;=O31.02X0^^62^737^56
 ;;^UTILITY(U,$J,358.3,18155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18155,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, not applicable or unsp
 ;;^UTILITY(U,$J,358.3,18155,1,4,0)
 ;;=4^O31.02X0
 ;;^UTILITY(U,$J,358.3,18155,2)
 ;;=^5016516
 ;;^UTILITY(U,$J,358.3,18156,0)
 ;;=O31.02X1^^62^737^51
 ;;^UTILITY(U,$J,358.3,18156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18156,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, fetus 1
 ;;^UTILITY(U,$J,358.3,18156,1,4,0)
 ;;=4^O31.02X1
 ;;^UTILITY(U,$J,358.3,18156,2)
 ;;=^5016517
 ;;^UTILITY(U,$J,358.3,18157,0)
 ;;=O31.02X2^^62^737^52
 ;;^UTILITY(U,$J,358.3,18157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18157,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, fetus 2
 ;;^UTILITY(U,$J,358.3,18157,1,4,0)
 ;;=4^O31.02X2
 ;;^UTILITY(U,$J,358.3,18157,2)
 ;;=^5016518
 ;;^UTILITY(U,$J,358.3,18158,0)
 ;;=O31.02X3^^62^737^53
 ;;^UTILITY(U,$J,358.3,18158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18158,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, fetus 3
 ;;^UTILITY(U,$J,358.3,18158,1,4,0)
 ;;=4^O31.02X3
 ;;^UTILITY(U,$J,358.3,18158,2)
 ;;=^5016519
 ;;^UTILITY(U,$J,358.3,18159,0)
 ;;=O31.02X4^^62^737^54
 ;;^UTILITY(U,$J,358.3,18159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18159,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, fetus 4
 ;;^UTILITY(U,$J,358.3,18159,1,4,0)
 ;;=4^O31.02X4
 ;;^UTILITY(U,$J,358.3,18159,2)
 ;;=^5016520
 ;;^UTILITY(U,$J,358.3,18160,0)
 ;;=O31.02X5^^62^737^55
 ;;^UTILITY(U,$J,358.3,18160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18160,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, fetus 5
 ;;^UTILITY(U,$J,358.3,18160,1,4,0)
 ;;=4^O31.02X5
 ;;^UTILITY(U,$J,358.3,18160,2)
 ;;=^5016521
 ;;^UTILITY(U,$J,358.3,18161,0)
 ;;=O31.01X0^^62^737^50
 ;;^UTILITY(U,$J,358.3,18161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18161,1,3,0)
 ;;=3^Papyraceous fetus, first trimester, not applicable or unsp
 ;;^UTILITY(U,$J,358.3,18161,1,4,0)
 ;;=4^O31.01X0
 ;;^UTILITY(U,$J,358.3,18161,2)
 ;;=^5016509
 ;;^UTILITY(U,$J,358.3,18162,0)
 ;;=O31.01X1^^62^737^45
 ;;^UTILITY(U,$J,358.3,18162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18162,1,3,0)
 ;;=3^Papyraceous fetus, first trimester, fetus 1
 ;;^UTILITY(U,$J,358.3,18162,1,4,0)
 ;;=4^O31.01X1
 ;;^UTILITY(U,$J,358.3,18162,2)
 ;;=^5016510
 ;;^UTILITY(U,$J,358.3,18163,0)
 ;;=O31.01X2^^62^737^46
 ;;^UTILITY(U,$J,358.3,18163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18163,1,3,0)
 ;;=3^Papyraceous fetus, first trimester, fetus 2
 ;;^UTILITY(U,$J,358.3,18163,1,4,0)
 ;;=4^O31.01X2
 ;;^UTILITY(U,$J,358.3,18163,2)
 ;;=^5016511
 ;;^UTILITY(U,$J,358.3,18164,0)
 ;;=O31.01X3^^62^737^47
 ;;^UTILITY(U,$J,358.3,18164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18164,1,3,0)
 ;;=3^Papyraceous fetus, first trimester, fetus 3
 ;;^UTILITY(U,$J,358.3,18164,1,4,0)
 ;;=4^O31.01X3
 ;;^UTILITY(U,$J,358.3,18164,2)
 ;;=^5016512
 ;;^UTILITY(U,$J,358.3,18165,0)
 ;;=O31.01X4^^62^737^48
 ;;^UTILITY(U,$J,358.3,18165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18165,1,3,0)
 ;;=3^Papyraceous fetus, first trimester, fetus 4
 ;;^UTILITY(U,$J,358.3,18165,1,4,0)
 ;;=4^O31.01X4
 ;;^UTILITY(U,$J,358.3,18165,2)
 ;;=^5016513
 ;;^UTILITY(U,$J,358.3,18166,0)
 ;;=O31.01X5^^62^737^49
 ;;^UTILITY(U,$J,358.3,18166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18166,1,3,0)
 ;;=3^Papyraceous fetus, first trimester, fetus 5
 ;;^UTILITY(U,$J,358.3,18166,1,4,0)
 ;;=4^O31.01X5
 ;;^UTILITY(U,$J,358.3,18166,2)
 ;;=^5016514
 ;;^UTILITY(U,$J,358.3,18167,0)
 ;;=O12.01^^62^737^32
 ;;^UTILITY(U,$J,358.3,18167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18167,1,3,0)
 ;;=3^Gestational edema, first trimester
 ;;^UTILITY(U,$J,358.3,18167,1,4,0)
 ;;=4^O12.01
 ;;^UTILITY(U,$J,358.3,18167,2)
 ;;=^5016147
 ;;^UTILITY(U,$J,358.3,18168,0)
 ;;=O12.02^^62^737^33
 ;;^UTILITY(U,$J,358.3,18168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18168,1,3,0)
 ;;=3^Gestational edema, second trimester
 ;;^UTILITY(U,$J,358.3,18168,1,4,0)
 ;;=4^O12.02
 ;;^UTILITY(U,$J,358.3,18168,2)
 ;;=^5016148
 ;;^UTILITY(U,$J,358.3,18169,0)
 ;;=O12.03^^62^737^34
 ;;^UTILITY(U,$J,358.3,18169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18169,1,3,0)
 ;;=3^Gestational edema, third trimester
 ;;^UTILITY(U,$J,358.3,18169,1,4,0)
 ;;=4^O12.03
 ;;^UTILITY(U,$J,358.3,18169,2)
 ;;=^5016149
 ;;^UTILITY(U,$J,358.3,18170,0)
 ;;=O12.21^^62^737^29
 ;;^UTILITY(U,$J,358.3,18170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18170,1,3,0)
 ;;=3^Gestational edema with proteinuria, first trimester
 ;;^UTILITY(U,$J,358.3,18170,1,4,0)
 ;;=4^O12.21
 ;;^UTILITY(U,$J,358.3,18170,2)
 ;;=^5016155
 ;;^UTILITY(U,$J,358.3,18171,0)
 ;;=O12.22^^62^737^30
 ;;^UTILITY(U,$J,358.3,18171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18171,1,3,0)
 ;;=3^Gestational edema with proteinuria, second trimester
 ;;^UTILITY(U,$J,358.3,18171,1,4,0)
 ;;=4^O12.22
 ;;^UTILITY(U,$J,358.3,18171,2)
 ;;=^5016156
 ;;^UTILITY(U,$J,358.3,18172,0)
 ;;=O12.23^^62^737^31
 ;;^UTILITY(U,$J,358.3,18172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18172,1,3,0)
 ;;=3^Gestational edema with proteinuria, third trimester
 ;;^UTILITY(U,$J,358.3,18172,1,4,0)
 ;;=4^O12.23
 ;;^UTILITY(U,$J,358.3,18172,2)
 ;;=^5016157
 ;;^UTILITY(U,$J,358.3,18173,0)
 ;;=O26.01^^62^737^20
 ;;^UTILITY(U,$J,358.3,18173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18173,1,3,0)
 ;;=3^Excessive weight gain in pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,18173,1,4,0)
 ;;=4^O26.01
 ;;^UTILITY(U,$J,358.3,18173,2)
 ;;=^5016298
 ;;^UTILITY(U,$J,358.3,18174,0)
 ;;=O26.02^^62^737^21
 ;;^UTILITY(U,$J,358.3,18174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18174,1,3,0)
 ;;=3^Excessive weight gain in pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,18174,1,4,0)
 ;;=4^O26.02
 ;;^UTILITY(U,$J,358.3,18174,2)
 ;;=^5016299
 ;;^UTILITY(U,$J,358.3,18175,0)
 ;;=O26.03^^62^737^22
 ;;^UTILITY(U,$J,358.3,18175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18175,1,3,0)
 ;;=3^Excessive weight gain in pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,18175,1,4,0)
 ;;=4^O26.03
 ;;^UTILITY(U,$J,358.3,18175,2)
 ;;=^5016300
 ;;^UTILITY(U,$J,358.3,18176,0)
 ;;=O26.831^^62^737^79
 ;;^UTILITY(U,$J,358.3,18176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18176,1,3,0)
 ;;=3^Pregnancy related renal disease, first trimester
 ;;^UTILITY(U,$J,358.3,18176,1,4,0)
 ;;=4^O26.831
 ;;^UTILITY(U,$J,358.3,18176,2)
 ;;=^5016341
 ;;^UTILITY(U,$J,358.3,18177,0)
 ;;=O26.832^^62^737^80
 ;;^UTILITY(U,$J,358.3,18177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18177,1,3,0)
 ;;=3^Pregnancy related renal disease, second trimester
 ;;^UTILITY(U,$J,358.3,18177,1,4,0)
 ;;=4^O26.832
 ;;^UTILITY(U,$J,358.3,18177,2)
 ;;=^5016342
 ;;^UTILITY(U,$J,358.3,18178,0)
 ;;=O26.833^^62^737^81
 ;;^UTILITY(U,$J,358.3,18178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18178,1,3,0)
 ;;=3^Pregnancy related renal disease, third trimester
 ;;^UTILITY(U,$J,358.3,18178,1,4,0)
 ;;=4^O26.833
 ;;^UTILITY(U,$J,358.3,18178,2)
 ;;=^5016343
 ;;^UTILITY(U,$J,358.3,18179,0)
 ;;=O26.21^^62^737^73
 ;;^UTILITY(U,$J,358.3,18179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18179,1,3,0)
 ;;=3^Preg care for patient w recurrent preg loss, first trimester
 ;;^UTILITY(U,$J,358.3,18179,1,4,0)
 ;;=4^O26.21
 ;;^UTILITY(U,$J,358.3,18179,2)
 ;;=^5016306
 ;;^UTILITY(U,$J,358.3,18180,0)
 ;;=O26.22^^62^737^74
 ;;^UTILITY(U,$J,358.3,18180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18180,1,3,0)
 ;;=3^Preg care for patient w recurrent preg loss, second trimester
 ;;^UTILITY(U,$J,358.3,18180,1,4,0)
 ;;=4^O26.22
 ;;^UTILITY(U,$J,358.3,18180,2)
 ;;=^5016307
 ;;^UTILITY(U,$J,358.3,18181,0)
 ;;=O26.23^^62^737^75
 ;;^UTILITY(U,$J,358.3,18181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18181,1,3,0)
 ;;=3^Preg care for patient w recurrent preg loss, third trimester
 ;;^UTILITY(U,$J,358.3,18181,1,4,0)
 ;;=4^O26.23
 ;;^UTILITY(U,$J,358.3,18181,2)
 ;;=^5016308
 ;;^UTILITY(U,$J,358.3,18182,0)
 ;;=O26.821^^62^737^76
 ;;^UTILITY(U,$J,358.3,18182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18182,1,3,0)
 ;;=3^Pregnancy related peripheral neuritis, first trimester
 ;;^UTILITY(U,$J,358.3,18182,1,4,0)
 ;;=4^O26.821
 ;;^UTILITY(U,$J,358.3,18182,2)
 ;;=^5016337
 ;;^UTILITY(U,$J,358.3,18183,0)
 ;;=O26.822^^62^737^77
 ;;^UTILITY(U,$J,358.3,18183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18183,1,3,0)
 ;;=3^Pregnancy related peripheral neuritis, second trimester
 ;;^UTILITY(U,$J,358.3,18183,1,4,0)
 ;;=4^O26.822
 ;;^UTILITY(U,$J,358.3,18183,2)
 ;;=^5016338
 ;;^UTILITY(U,$J,358.3,18184,0)
 ;;=O26.823^^62^737^78
 ;;^UTILITY(U,$J,358.3,18184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18184,1,3,0)
 ;;=3^Pregnancy related peripheral neuritis, third trimester
 ;;^UTILITY(U,$J,358.3,18184,1,4,0)
 ;;=4^O26.823
 ;;^UTILITY(U,$J,358.3,18184,2)
 ;;=^5016339
 ;;^UTILITY(U,$J,358.3,18185,0)
 ;;=O86.11^^62^737^7
 ;;^UTILITY(U,$J,358.3,18185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18185,1,3,0)
 ;;=3^Cervicitis following delivery
 ;;^UTILITY(U,$J,358.3,18185,1,4,0)
 ;;=4^O86.11
 ;;^UTILITY(U,$J,358.3,18185,2)
 ;;=^5017755
 ;;^UTILITY(U,$J,358.3,18186,0)
 ;;=O86.13^^62^737^96
 ;;^UTILITY(U,$J,358.3,18186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18186,1,3,0)
 ;;=3^Vaginitis following delivery
 ;;^UTILITY(U,$J,358.3,18186,1,4,0)
 ;;=4^O86.13
 ;;^UTILITY(U,$J,358.3,18186,2)
 ;;=^5017757
 ;;^UTILITY(U,$J,358.3,18187,0)
 ;;=O86.20^^62^737^95
 ;;^UTILITY(U,$J,358.3,18187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18187,1,3,0)
 ;;=3^Urinary tract infection following delivery, unspecified
 ;;^UTILITY(U,$J,358.3,18187,1,4,0)
 ;;=4^O86.20
 ;;^UTILITY(U,$J,358.3,18187,2)
 ;;=^5017759
 ;;^UTILITY(U,$J,358.3,18188,0)
 ;;=O86.21^^62^737^40
 ;;^UTILITY(U,$J,358.3,18188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18188,1,3,0)
 ;;=3^Infection of kidney following delivery
 ;;^UTILITY(U,$J,358.3,18188,1,4,0)
 ;;=4^O86.21
 ;;^UTILITY(U,$J,358.3,18188,2)
 ;;=^5017760
 ;;^UTILITY(U,$J,358.3,18189,0)
 ;;=O86.22^^62^737^39
 ;;^UTILITY(U,$J,358.3,18189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18189,1,3,0)
 ;;=3^Infection of bladder following delivery
 ;;^UTILITY(U,$J,358.3,18189,1,4,0)
 ;;=4^O86.22
 ;;^UTILITY(U,$J,358.3,18189,2)
 ;;=^5017761
 ;;^UTILITY(U,$J,358.3,18190,0)
 ;;=O26.611^^62^737^41
 ;;^UTILITY(U,$J,358.3,18190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18190,1,3,0)
 ;;=3^Liver and biliary tract disord in pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,18190,1,4,0)
 ;;=4^O26.611
 ;;^UTILITY(U,$J,358.3,18190,2)
 ;;=^5016321
 ;;^UTILITY(U,$J,358.3,18191,0)
 ;;=O26.612^^62^737^42
 ;;^UTILITY(U,$J,358.3,18191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18191,1,3,0)
 ;;=3^Liver and biliary tract disord in pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,18191,1,4,0)
 ;;=4^O26.612
 ;;^UTILITY(U,$J,358.3,18191,2)
 ;;=^5016322
 ;;^UTILITY(U,$J,358.3,18192,0)
 ;;=O26.613^^62^737^43
 ;;^UTILITY(U,$J,358.3,18192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18192,1,3,0)
 ;;=3^Liver and biliary tract disord in pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,18192,1,4,0)
 ;;=4^O26.613
 ;;^UTILITY(U,$J,358.3,18192,2)
 ;;=^5016323
 ;;^UTILITY(U,$J,358.3,18193,0)
 ;;=O98.111^^62^737^87
 ;;^UTILITY(U,$J,358.3,18193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18193,1,3,0)
 ;;=3^Syphilis complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,18193,1,4,0)
 ;;=4^O98.111
 ;;^UTILITY(U,$J,358.3,18193,2)
 ;;=^5017863
 ;;^UTILITY(U,$J,358.3,18194,0)
 ;;=O98.112^^62^737^88
 ;;^UTILITY(U,$J,358.3,18194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18194,1,3,0)
 ;;=3^Syphilis complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,18194,1,4,0)
 ;;=4^O98.112
 ;;^UTILITY(U,$J,358.3,18194,2)
 ;;=^5017864
 ;;^UTILITY(U,$J,358.3,18195,0)
 ;;=O98.113^^62^737^89
 ;;^UTILITY(U,$J,358.3,18195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18195,1,3,0)
 ;;=3^Syphilis complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,18195,1,4,0)
 ;;=4^O98.113
 ;;^UTILITY(U,$J,358.3,18195,2)
 ;;=^5017865
 ;;^UTILITY(U,$J,358.3,18196,0)
 ;;=O98.13^^62^737^90
 ;;^UTILITY(U,$J,358.3,18196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18196,1,3,0)
 ;;=3^Syphilis complicating the puerperium
 ;;^UTILITY(U,$J,358.3,18196,1,4,0)
 ;;=4^O98.13
 ;;^UTILITY(U,$J,358.3,18196,2)
 ;;=^5017868
 ;;^UTILITY(U,$J,358.3,18197,0)
 ;;=O98.211^^62^737^35
 ;;^UTILITY(U,$J,358.3,18197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18197,1,3,0)
 ;;=3^Gonorrhea complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,18197,1,4,0)
 ;;=4^O98.211
 ;;^UTILITY(U,$J,358.3,18197,2)
 ;;=^5017869
 ;;^UTILITY(U,$J,358.3,18198,0)
 ;;=O98.212^^62^737^36
 ;;^UTILITY(U,$J,358.3,18198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18198,1,3,0)
 ;;=3^Gonorrhea complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,18198,1,4,0)
 ;;=4^O98.212
 ;;^UTILITY(U,$J,358.3,18198,2)
 ;;=^5017870
 ;;^UTILITY(U,$J,358.3,18199,0)
 ;;=O98.213^^62^737^37
 ;;^UTILITY(U,$J,358.3,18199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18199,1,3,0)
 ;;=3^Gonorrhea complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,18199,1,4,0)
 ;;=4^O98.213
 ;;^UTILITY(U,$J,358.3,18199,2)
 ;;=^5017871
 ;;^UTILITY(U,$J,358.3,18200,0)
 ;;=O98.23^^62^737^38
 ;;^UTILITY(U,$J,358.3,18200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18200,1,3,0)
 ;;=3^Gonorrhea complicating the puerperium
 ;;^UTILITY(U,$J,358.3,18200,1,4,0)
 ;;=4^O98.23
 ;;^UTILITY(U,$J,358.3,18200,2)
 ;;=^5017874
 ;;^UTILITY(U,$J,358.3,18201,0)
 ;;=O98.011^^62^737^91
 ;;^UTILITY(U,$J,358.3,18201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18201,1,3,0)
 ;;=3^Tuberculosis complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,18201,1,4,0)
 ;;=4^O98.011
 ;;^UTILITY(U,$J,358.3,18201,2)
 ;;=^5017857
 ;;^UTILITY(U,$J,358.3,18202,0)
 ;;=O98.012^^62^737^92
 ;;^UTILITY(U,$J,358.3,18202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18202,1,3,0)
 ;;=3^Tuberculosis complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,18202,1,4,0)
 ;;=4^O98.012
 ;;^UTILITY(U,$J,358.3,18202,2)
 ;;=^5017858
 ;;^UTILITY(U,$J,358.3,18203,0)
 ;;=O98.013^^62^737^93
 ;;^UTILITY(U,$J,358.3,18203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18203,1,3,0)
 ;;=3^Tuberculosis complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,18203,1,4,0)
 ;;=4^O98.013
 ;;^UTILITY(U,$J,358.3,18203,2)
 ;;=^5017859
 ;;^UTILITY(U,$J,358.3,18204,0)
 ;;=O98.03^^62^737^94
 ;;^UTILITY(U,$J,358.3,18204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18204,1,3,0)
 ;;=3^Tuberculosis complicating the puerperium
 ;;^UTILITY(U,$J,358.3,18204,1,4,0)
 ;;=4^O98.03
 ;;^UTILITY(U,$J,358.3,18204,2)
 ;;=^5017862
 ;;^UTILITY(U,$J,358.3,18205,0)
 ;;=O98.611^^62^737^82
 ;;^UTILITY(U,$J,358.3,18205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18205,1,3,0)
 ;;=3^Protozoal diseases complicating pregnancy, first trimester
 ;;^UTILITY(U,$J,358.3,18205,1,4,0)
 ;;=4^O98.611
 ;;^UTILITY(U,$J,358.3,18205,2)
 ;;=^5017893
 ;;^UTILITY(U,$J,358.3,18206,0)
 ;;=O98.612^^62^737^83
 ;;^UTILITY(U,$J,358.3,18206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18206,1,3,0)
 ;;=3^Protozoal diseases complicating pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,18206,1,4,0)
 ;;=4^O98.612
 ;;^UTILITY(U,$J,358.3,18206,2)
 ;;=^5017894
 ;;^UTILITY(U,$J,358.3,18207,0)
 ;;=O98.613^^62^737^84
 ;;^UTILITY(U,$J,358.3,18207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18207,1,3,0)
 ;;=3^Protozoal diseases complicating pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,18207,1,4,0)
 ;;=4^O98.613
 ;;^UTILITY(U,$J,358.3,18207,2)
 ;;=^5017895
