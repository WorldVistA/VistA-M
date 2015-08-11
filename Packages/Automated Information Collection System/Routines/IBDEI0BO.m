IBDEI0BO ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5526,1,5,0)
 ;;=5^Hormone replacement therapy
 ;;^UTILITY(U,$J,358.3,5526,2)
 ;;=^295199
 ;;^UTILITY(U,$J,358.3,5527,0)
 ;;=625.6^^41^487^28
 ;;^UTILITY(U,$J,358.3,5527,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5527,1,4,0)
 ;;=4^625.6
 ;;^UTILITY(U,$J,358.3,5527,1,5,0)
 ;;=5^Incontinence, stress
 ;;^UTILITY(U,$J,358.3,5527,2)
 ;;=^114717
 ;;^UTILITY(U,$J,358.3,5528,0)
 ;;=628.9^^41^487^29
 ;;^UTILITY(U,$J,358.3,5528,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5528,1,4,0)
 ;;=4^628.9
 ;;^UTILITY(U,$J,358.3,5528,1,5,0)
 ;;=5^Infertility
 ;;^UTILITY(U,$J,358.3,5528,2)
 ;;=Infertility^62820
 ;;^UTILITY(U,$J,358.3,5529,0)
 ;;=626.4^^41^487^30
 ;;^UTILITY(U,$J,358.3,5529,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5529,1,4,0)
 ;;=4^626.4
 ;;^UTILITY(U,$J,358.3,5529,1,5,0)
 ;;=5^Irregular menstruation
 ;;^UTILITY(U,$J,358.3,5529,2)
 ;;=^270567
 ;;^UTILITY(U,$J,358.3,5530,0)
 ;;=626.2^^41^487^31
 ;;^UTILITY(U,$J,358.3,5530,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5530,1,4,0)
 ;;=4^626.2
 ;;^UTILITY(U,$J,358.3,5530,1,5,0)
 ;;=5^Menometrorrhagia
 ;;^UTILITY(U,$J,358.3,5530,2)
 ;;=Menometrorrhagia^75895
 ;;^UTILITY(U,$J,358.3,5531,0)
 ;;=627.2^^41^487^43
 ;;^UTILITY(U,$J,358.3,5531,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5531,1,4,0)
 ;;=4^627.2
 ;;^UTILITY(U,$J,358.3,5531,1,5,0)
 ;;=5^Perimenopause
 ;;^UTILITY(U,$J,358.3,5531,2)
 ;;=Perimenopause^75863
 ;;^UTILITY(U,$J,358.3,5532,0)
 ;;=611.79^^41^487^33
 ;;^UTILITY(U,$J,358.3,5532,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5532,1,4,0)
 ;;=4^611.79
 ;;^UTILITY(U,$J,358.3,5532,1,5,0)
 ;;=5^Nipple Discharge
 ;;^UTILITY(U,$J,358.3,5532,2)
 ;;=Nipple Discharge^270462
 ;;^UTILITY(U,$J,358.3,5533,0)
 ;;=278.00^^41^487^34
 ;;^UTILITY(U,$J,358.3,5533,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5533,1,4,0)
 ;;=4^278.00
 ;;^UTILITY(U,$J,358.3,5533,1,5,0)
 ;;=5^Obesity
 ;;^UTILITY(U,$J,358.3,5533,2)
 ;;=Obesity^84823
 ;;^UTILITY(U,$J,358.3,5534,0)
 ;;=626.1^^41^487^35
 ;;^UTILITY(U,$J,358.3,5534,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5534,1,4,0)
 ;;=4^626.1
 ;;^UTILITY(U,$J,358.3,5534,1,5,0)
 ;;=5^Oligomenorrhea
 ;;^UTILITY(U,$J,358.3,5534,2)
 ;;=Oligomenorrhea^108125
 ;;^UTILITY(U,$J,358.3,5535,0)
 ;;=733.00^^41^487^36
 ;;^UTILITY(U,$J,358.3,5535,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5535,1,4,0)
 ;;=4^733.00
 ;;^UTILITY(U,$J,358.3,5535,1,5,0)
 ;;=5^Osteoporosis
 ;;^UTILITY(U,$J,358.3,5535,2)
 ;;=Osteoporosis^87159
 ;;^UTILITY(U,$J,358.3,5536,0)
 ;;=626.5^^41^487^38
 ;;^UTILITY(U,$J,358.3,5536,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5536,1,4,0)
 ;;=4^626.5
 ;;^UTILITY(U,$J,358.3,5536,1,5,0)
 ;;=5^Ovulation Bleeding
 ;;^UTILITY(U,$J,358.3,5536,2)
 ;;=Ovulation Bleeding^270570
 ;;^UTILITY(U,$J,358.3,5537,0)
 ;;=625.2^^41^487^39
 ;;^UTILITY(U,$J,358.3,5537,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5537,1,4,0)
 ;;=4^625.2
 ;;^UTILITY(U,$J,358.3,5537,1,5,0)
 ;;=5^Ovulation Pain
 ;;^UTILITY(U,$J,358.3,5537,2)
 ;;=Ovulation Pain^265259
 ;;^UTILITY(U,$J,358.3,5538,0)
 ;;=614.9^^41^487^42
 ;;^UTILITY(U,$J,358.3,5538,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5538,1,4,0)
 ;;=4^614.9
 ;;^UTILITY(U,$J,358.3,5538,1,5,0)
 ;;=5^Pelvic inflammatory disease
 ;;^UTILITY(U,$J,358.3,5538,2)
 ;;=^3537
 ;;^UTILITY(U,$J,358.3,5539,0)
 ;;=789.30^^41^487^40
 ;;^UTILITY(U,$J,358.3,5539,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5539,1,4,0)
 ;;=4^789.30
 ;;^UTILITY(U,$J,358.3,5539,1,5,0)
 ;;=5^Pelvic Mass
 ;;^UTILITY(U,$J,358.3,5539,2)
 ;;=Pelvic Mass^917
 ;;^UTILITY(U,$J,358.3,5540,0)
 ;;=622.7^^41^487^44
 ;;^UTILITY(U,$J,358.3,5540,1,0)
 ;;=^358.31IA^5^2
