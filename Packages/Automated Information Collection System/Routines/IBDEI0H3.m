IBDEI0H3 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17163,1,3,0)
 ;;=3^Upper resp infect, acute, unspec
 ;;^UTILITY(U,$J,358.3,17163,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,17163,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,17164,0)
 ;;=B35.3^^73^869^7
 ;;^UTILITY(U,$J,358.3,17164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17164,1,3,0)
 ;;=3^Tinea pedis
 ;;^UTILITY(U,$J,358.3,17164,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,17164,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,17165,0)
 ;;=H93.11^^73^869^10
 ;;^UTILITY(U,$J,358.3,17165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17165,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,17165,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,17165,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,17166,0)
 ;;=H93.12^^73^869^9
 ;;^UTILITY(U,$J,358.3,17166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17166,1,3,0)
 ;;=3^Tinnitus, left ear
 ;;^UTILITY(U,$J,358.3,17166,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,17166,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,17167,0)
 ;;=H93.13^^73^869^8
 ;;^UTILITY(U,$J,358.3,17167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17167,1,3,0)
 ;;=3^Tinnitus, bilateral
 ;;^UTILITY(U,$J,358.3,17167,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,17167,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,17168,0)
 ;;=K26.9^^73^869^11
 ;;^UTILITY(U,$J,358.3,17168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17168,1,3,0)
 ;;=3^Ulcer,Duodenal w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,17168,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,17168,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,17169,0)
 ;;=K25.9^^73^869^12
 ;;^UTILITY(U,$J,358.3,17169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17169,1,3,0)
 ;;=3^Ulcer,Gastric w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,17169,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,17169,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,17170,0)
 ;;=K27.9^^73^869^13
 ;;^UTILITY(U,$J,358.3,17170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17170,1,3,0)
 ;;=3^Ulcer,Peptic w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,17170,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,17170,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,17171,0)
 ;;=N34.1^^73^869^15
 ;;^UTILITY(U,$J,358.3,17171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17171,1,3,0)
 ;;=3^Urethritis, nonspec
 ;;^UTILITY(U,$J,358.3,17171,1,4,0)
 ;;=4^N34.1
 ;;^UTILITY(U,$J,358.3,17171,2)
 ;;=^5015655
 ;;^UTILITY(U,$J,358.3,17172,0)
 ;;=R33.9^^73^869^17
 ;;^UTILITY(U,$J,358.3,17172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17172,1,3,0)
 ;;=3^Urinary Retention,Unspec
 ;;^UTILITY(U,$J,358.3,17172,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,17172,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,17173,0)
 ;;=N34.2^^73^869^16
 ;;^UTILITY(U,$J,358.3,17173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17173,1,3,0)
 ;;=3^Urethritis, other
 ;;^UTILITY(U,$J,358.3,17173,1,4,0)
 ;;=4^N34.2
 ;;^UTILITY(U,$J,358.3,17173,2)
 ;;=^88231
 ;;^UTILITY(U,$J,358.3,17174,0)
 ;;=R32.^^73^869^18
 ;;^UTILITY(U,$J,358.3,17174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17174,1,3,0)
 ;;=3^Urinary incontinence, unspec
 ;;^UTILITY(U,$J,358.3,17174,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,17174,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,17175,0)
 ;;=K08.8^^73^869^2
 ;;^UTILITY(U,$J,358.3,17175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17175,1,3,0)
 ;;=3^Teeth/Supporting Structure DO (Toothache)
 ;;^UTILITY(U,$J,358.3,17175,1,4,0)
 ;;=4^K08.8
 ;;^UTILITY(U,$J,358.3,17175,2)
 ;;=^5008467
 ;;^UTILITY(U,$J,358.3,17176,0)
 ;;=N39.0^^73^869^19
 ;;^UTILITY(U,$J,358.3,17176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17176,1,3,0)
 ;;=3^Urinary tract infect, site not specified
 ;;^UTILITY(U,$J,358.3,17176,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,17176,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,17177,0)
 ;;=B35.6^^73^869^6
 ;;^UTILITY(U,$J,358.3,17177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17177,1,3,0)
 ;;=3^Tinea Cruris
 ;;^UTILITY(U,$J,358.3,17177,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,17177,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,17178,0)
 ;;=R00.0^^73^869^1
 ;;^UTILITY(U,$J,358.3,17178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17178,1,3,0)
 ;;=3^Tachycardia,Unspec
 ;;^UTILITY(U,$J,358.3,17178,1,4,0)
 ;;=4^R00.0
 ;;^UTILITY(U,$J,358.3,17178,2)
 ;;=^5019163
 ;;^UTILITY(U,$J,358.3,17179,0)
 ;;=I83.91^^73^870^5
 ;;^UTILITY(U,$J,358.3,17179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17179,1,3,0)
 ;;=3^Varicose veins, asympt, of rt lwr extr
 ;;^UTILITY(U,$J,358.3,17179,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,17179,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,17180,0)
 ;;=I83.92^^73^870^4
 ;;^UTILITY(U,$J,358.3,17180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17180,1,3,0)
 ;;=3^Varicose veins, asympt, of lft lwr extr
 ;;^UTILITY(U,$J,358.3,17180,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,17180,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,17181,0)
 ;;=I83.93^^73^870^3
 ;;^UTILITY(U,$J,358.3,17181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17181,1,3,0)
 ;;=3^Varicose veins, asympt, of biltrl lwr extre
 ;;^UTILITY(U,$J,358.3,17181,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,17181,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,17182,0)
 ;;=H54.7^^73^870^7
 ;;^UTILITY(U,$J,358.3,17182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17182,1,3,0)
 ;;=3^Visual loss, unspec
 ;;^UTILITY(U,$J,358.3,17182,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,17182,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,17183,0)
 ;;=R53.1^^73^870^8
 ;;^UTILITY(U,$J,358.3,17183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17183,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,17183,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,17183,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,17184,0)
 ;;=R63.4^^73^870^10
 ;;^UTILITY(U,$J,358.3,17184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17184,1,3,0)
 ;;=3^Weight loss, abnl
 ;;^UTILITY(U,$J,358.3,17184,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,17184,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,17185,0)
 ;;=B97.89^^73^870^6
 ;;^UTILITY(U,$J,358.3,17185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17185,1,3,0)
 ;;=3^Viral agents as cause of disease, oth, classd elswhr
 ;;^UTILITY(U,$J,358.3,17185,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,17185,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,17186,0)
 ;;=I83.029^^73^870^1
 ;;^UTILITY(U,$J,358.3,17186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17186,1,3,0)
 ;;=3^Varicose Veins Left Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,17186,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,17186,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,17187,0)
 ;;=I83.019^^73^870^2
 ;;^UTILITY(U,$J,358.3,17187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17187,1,3,0)
 ;;=3^Varicose Veins Right Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,17187,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,17187,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,17188,0)
 ;;=R63.5^^73^870^9
 ;;^UTILITY(U,$J,358.3,17188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17188,1,3,0)
 ;;=3^Weight Gain,Abnormal
 ;;^UTILITY(U,$J,358.3,17188,1,4,0)
 ;;=4^R63.5
 ;;^UTILITY(U,$J,358.3,17188,2)
 ;;=^5019543
 ;;^UTILITY(U,$J,358.3,17189,0)
 ;;=F50.02^^73^871^1
 ;;^UTILITY(U,$J,358.3,17189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17189,1,3,0)
 ;;=3^Anorexia nervosa, binge eating/purging type
 ;;^UTILITY(U,$J,358.3,17189,1,4,0)
 ;;=4^F50.02
 ;;^UTILITY(U,$J,358.3,17189,2)
 ;;=^5003599
 ;;^UTILITY(U,$J,358.3,17190,0)
 ;;=F50.01^^73^871^2
 ;;^UTILITY(U,$J,358.3,17190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17190,1,3,0)
 ;;=3^Anorexia nervosa, restricting type
 ;;^UTILITY(U,$J,358.3,17190,1,4,0)
 ;;=4^F50.01
 ;;^UTILITY(U,$J,358.3,17190,2)
 ;;=^5003598
 ;;^UTILITY(U,$J,358.3,17191,0)
 ;;=F50.00^^73^871^3
 ;;^UTILITY(U,$J,358.3,17191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17191,1,3,0)
 ;;=3^Anorexia nervosa, unspec
 ;;^UTILITY(U,$J,358.3,17191,1,4,0)
 ;;=4^F50.00
