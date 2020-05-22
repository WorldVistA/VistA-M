IBDEI05G ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13193,1,3,0)
 ;;=3^Thombophlb & Phlbts Deep Vessels Right Lower Extrem
 ;;^UTILITY(U,$J,358.3,13193,1,4,0)
 ;;=4^I80.201
 ;;^UTILITY(U,$J,358.3,13193,2)
 ;;=^5007828
 ;;^UTILITY(U,$J,358.3,13194,0)
 ;;=I80.202^^57^653^4
 ;;^UTILITY(U,$J,358.3,13194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13194,1,3,0)
 ;;=3^Thombophlb & Phlbts Deep Vessels Left Lower Extrem
 ;;^UTILITY(U,$J,358.3,13194,1,4,0)
 ;;=4^I80.202
 ;;^UTILITY(U,$J,358.3,13194,2)
 ;;=^5007829
 ;;^UTILITY(U,$J,358.3,13195,0)
 ;;=I80.203^^57^653^3
 ;;^UTILITY(U,$J,358.3,13195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13195,1,3,0)
 ;;=3^Thombophlb & Phlbts Deep Vessels Bilateral Lower Extrem
 ;;^UTILITY(U,$J,358.3,13195,1,4,0)
 ;;=4^I80.203
 ;;^UTILITY(U,$J,358.3,13195,2)
 ;;=^5007830
 ;;^UTILITY(U,$J,358.3,13196,0)
 ;;=J06.9^^57^653^14
 ;;^UTILITY(U,$J,358.3,13196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13196,1,3,0)
 ;;=3^Upper resp infect, acute, unspec
 ;;^UTILITY(U,$J,358.3,13196,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,13196,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,13197,0)
 ;;=B35.3^^57^653^7
 ;;^UTILITY(U,$J,358.3,13197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13197,1,3,0)
 ;;=3^Tinea pedis
 ;;^UTILITY(U,$J,358.3,13197,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,13197,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,13198,0)
 ;;=H93.11^^57^653^10
 ;;^UTILITY(U,$J,358.3,13198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13198,1,3,0)
 ;;=3^Tinnitus, right ear
 ;;^UTILITY(U,$J,358.3,13198,1,4,0)
 ;;=4^H93.11
 ;;^UTILITY(U,$J,358.3,13198,2)
 ;;=^5006964
 ;;^UTILITY(U,$J,358.3,13199,0)
 ;;=H93.12^^57^653^9
 ;;^UTILITY(U,$J,358.3,13199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13199,1,3,0)
 ;;=3^Tinnitus, left ear
 ;;^UTILITY(U,$J,358.3,13199,1,4,0)
 ;;=4^H93.12
 ;;^UTILITY(U,$J,358.3,13199,2)
 ;;=^5006965
 ;;^UTILITY(U,$J,358.3,13200,0)
 ;;=H93.13^^57^653^8
 ;;^UTILITY(U,$J,358.3,13200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13200,1,3,0)
 ;;=3^Tinnitus, bilateral
 ;;^UTILITY(U,$J,358.3,13200,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,13200,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,13201,0)
 ;;=K26.9^^57^653^11
 ;;^UTILITY(U,$J,358.3,13201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13201,1,3,0)
 ;;=3^Ulcer,Duodenal w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,13201,1,4,0)
 ;;=4^K26.9
 ;;^UTILITY(U,$J,358.3,13201,2)
 ;;=^5008527
 ;;^UTILITY(U,$J,358.3,13202,0)
 ;;=K25.9^^57^653^12
 ;;^UTILITY(U,$J,358.3,13202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13202,1,3,0)
 ;;=3^Ulcer,Gastric w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,13202,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,13202,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,13203,0)
 ;;=K27.9^^57^653^13
 ;;^UTILITY(U,$J,358.3,13203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13203,1,3,0)
 ;;=3^Ulcer,Peptic w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,13203,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,13203,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,13204,0)
 ;;=N34.1^^57^653^15
 ;;^UTILITY(U,$J,358.3,13204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13204,1,3,0)
 ;;=3^Urethritis, nonspec
 ;;^UTILITY(U,$J,358.3,13204,1,4,0)
 ;;=4^N34.1
 ;;^UTILITY(U,$J,358.3,13204,2)
 ;;=^5015655
 ;;^UTILITY(U,$J,358.3,13205,0)
 ;;=R33.9^^57^653^17
 ;;^UTILITY(U,$J,358.3,13205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13205,1,3,0)
 ;;=3^Urinary Retention,Unspec
 ;;^UTILITY(U,$J,358.3,13205,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,13205,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,13206,0)
 ;;=N34.2^^57^653^16
 ;;^UTILITY(U,$J,358.3,13206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13206,1,3,0)
 ;;=3^Urethritis, other
 ;;^UTILITY(U,$J,358.3,13206,1,4,0)
 ;;=4^N34.2
 ;;^UTILITY(U,$J,358.3,13206,2)
 ;;=^88231
 ;;^UTILITY(U,$J,358.3,13207,0)
 ;;=R32.^^57^653^18
 ;;^UTILITY(U,$J,358.3,13207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13207,1,3,0)
 ;;=3^Urinary incontinence, unspec
 ;;^UTILITY(U,$J,358.3,13207,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,13207,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,13208,0)
 ;;=N39.0^^57^653^19
 ;;^UTILITY(U,$J,358.3,13208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13208,1,3,0)
 ;;=3^Urinary tract infect, site not specified
 ;;^UTILITY(U,$J,358.3,13208,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,13208,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,13209,0)
 ;;=B35.6^^57^653^6
 ;;^UTILITY(U,$J,358.3,13209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13209,1,3,0)
 ;;=3^Tinea Cruris
 ;;^UTILITY(U,$J,358.3,13209,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,13209,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,13210,0)
 ;;=R00.0^^57^653^1
 ;;^UTILITY(U,$J,358.3,13210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13210,1,3,0)
 ;;=3^Tachycardia,Unspec
 ;;^UTILITY(U,$J,358.3,13210,1,4,0)
 ;;=4^R00.0
 ;;^UTILITY(U,$J,358.3,13210,2)
 ;;=^5019163
 ;;^UTILITY(U,$J,358.3,13211,0)
 ;;=K08.89^^57^653^2
 ;;^UTILITY(U,$J,358.3,13211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13211,1,3,0)
 ;;=3^Teeth & Supporting Structure Disorders (Toothache)
 ;;^UTILITY(U,$J,358.3,13211,1,4,0)
 ;;=4^K08.89
 ;;^UTILITY(U,$J,358.3,13211,2)
 ;;=^5008467
 ;;^UTILITY(U,$J,358.3,13212,0)
 ;;=I83.91^^57^654^5
 ;;^UTILITY(U,$J,358.3,13212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13212,1,3,0)
 ;;=3^Varicose veins, asympt, of rt lwr extr
 ;;^UTILITY(U,$J,358.3,13212,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,13212,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,13213,0)
 ;;=I83.92^^57^654^4
 ;;^UTILITY(U,$J,358.3,13213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13213,1,3,0)
 ;;=3^Varicose veins, asympt, of lft lwr extr
 ;;^UTILITY(U,$J,358.3,13213,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,13213,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,13214,0)
 ;;=I83.93^^57^654^3
 ;;^UTILITY(U,$J,358.3,13214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13214,1,3,0)
 ;;=3^Varicose veins, asympt, of biltrl lwr extre
 ;;^UTILITY(U,$J,358.3,13214,1,4,0)
 ;;=4^I83.93
 ;;^UTILITY(U,$J,358.3,13214,2)
 ;;=^5008022
 ;;^UTILITY(U,$J,358.3,13215,0)
 ;;=H54.7^^57^654^7
 ;;^UTILITY(U,$J,358.3,13215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13215,1,3,0)
 ;;=3^Visual loss, unspec
 ;;^UTILITY(U,$J,358.3,13215,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,13215,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,13216,0)
 ;;=R53.1^^57^654^8
 ;;^UTILITY(U,$J,358.3,13216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13216,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,13216,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,13216,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,13217,0)
 ;;=R63.4^^57^654^10
 ;;^UTILITY(U,$J,358.3,13217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13217,1,3,0)
 ;;=3^Weight loss, abnl
 ;;^UTILITY(U,$J,358.3,13217,1,4,0)
 ;;=4^R63.4
 ;;^UTILITY(U,$J,358.3,13217,2)
 ;;=^5019542
 ;;^UTILITY(U,$J,358.3,13218,0)
 ;;=B97.89^^57^654^6
 ;;^UTILITY(U,$J,358.3,13218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13218,1,3,0)
 ;;=3^Viral agents as cause of disease, oth, classd elswhr
 ;;^UTILITY(U,$J,358.3,13218,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,13218,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,13219,0)
 ;;=I83.029^^57^654^1
 ;;^UTILITY(U,$J,358.3,13219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13219,1,3,0)
 ;;=3^Varicose Veins Left Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,13219,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,13219,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,13220,0)
 ;;=I83.019^^57^654^2
 ;;^UTILITY(U,$J,358.3,13220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13220,1,3,0)
 ;;=3^Varicose Veins Right Lower Extremity w/ Ulcer,Site Unspec
 ;;^UTILITY(U,$J,358.3,13220,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,13220,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,13221,0)
 ;;=R63.5^^57^654^9
 ;;^UTILITY(U,$J,358.3,13221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13221,1,3,0)
 ;;=3^Weight Gain,Abnormal
 ;;^UTILITY(U,$J,358.3,13221,1,4,0)
 ;;=4^R63.5
 ;;^UTILITY(U,$J,358.3,13221,2)
 ;;=^5019543
 ;;^UTILITY(U,$J,358.3,13222,0)
 ;;=F50.02^^57^655^1
 ;;^UTILITY(U,$J,358.3,13222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13222,1,3,0)
 ;;=3^Anorexia nervosa, binge eating/purging type
 ;;^UTILITY(U,$J,358.3,13222,1,4,0)
 ;;=4^F50.02
 ;;^UTILITY(U,$J,358.3,13222,2)
 ;;=^5003599
 ;;^UTILITY(U,$J,358.3,13223,0)
 ;;=F50.01^^57^655^2
 ;;^UTILITY(U,$J,358.3,13223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13223,1,3,0)
 ;;=3^Anorexia nervosa, restricting type
 ;;^UTILITY(U,$J,358.3,13223,1,4,0)
 ;;=4^F50.01
 ;;^UTILITY(U,$J,358.3,13223,2)
 ;;=^5003598
 ;;^UTILITY(U,$J,358.3,13224,0)
 ;;=F50.00^^57^655^3
 ;;^UTILITY(U,$J,358.3,13224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13224,1,3,0)
 ;;=3^Anorexia nervosa, unspec
 ;;^UTILITY(U,$J,358.3,13224,1,4,0)
 ;;=4^F50.00
 ;;^UTILITY(U,$J,358.3,13224,2)
 ;;=^5003597
 ;;^UTILITY(U,$J,358.3,13225,0)
 ;;=F90.9^^57^655^4
 ;;^UTILITY(U,$J,358.3,13225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13225,1,3,0)
 ;;=3^Attention-deficit hyperact dsordr, unspec type
 ;;^UTILITY(U,$J,358.3,13225,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,13225,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,13226,0)
 ;;=F50.2^^57^655^5
 ;;^UTILITY(U,$J,358.3,13226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13226,1,3,0)
 ;;=3^Bulimia nervosa
 ;;^UTILITY(U,$J,358.3,13226,1,4,0)
 ;;=4^F50.2
 ;;^UTILITY(U,$J,358.3,13226,2)
 ;;=^5003600
 ;;^UTILITY(U,$J,358.3,13227,0)
 ;;=F44.9^^57^655^6
 ;;^UTILITY(U,$J,358.3,13227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13227,1,3,0)
 ;;=3^Dissociative & conversion disorder, unspec
 ;;^UTILITY(U,$J,358.3,13227,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,13227,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,13228,0)
 ;;=F50.9^^57^655^7
 ;;^UTILITY(U,$J,358.3,13228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13228,1,3,0)
 ;;=3^Eating disorder, unspec
 ;;^UTILITY(U,$J,358.3,13228,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,13228,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,13229,0)
 ;;=F64.1^^57^655^9
 ;;^UTILITY(U,$J,358.3,13229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13229,1,3,0)
 ;;=3^Gender ident disorder in adlscnc & adlthd
 ;;^UTILITY(U,$J,358.3,13229,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,13229,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,13230,0)
 ;;=F06.30^^57^655^11
 ;;^UTILITY(U,$J,358.3,13230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13230,1,3,0)
 ;;=3^Mood disorder d/t known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,13230,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,13230,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,13231,0)
 ;;=F23.^^57^655^15
 ;;^UTILITY(U,$J,358.3,13231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13231,1,3,0)
 ;;=3^Psychotic disorder, brief
 ;;^UTILITY(U,$J,358.3,13231,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,13231,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,13232,0)
 ;;=F06.2^^57^655^14
 ;;^UTILITY(U,$J,358.3,13232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13232,1,3,0)
 ;;=3^Psychotic disorder w/ delusns d/t known physiol cond
 ;;^UTILITY(U,$J,358.3,13232,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,13232,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,13233,0)
 ;;=F29.^^57^655^13
 ;;^UTILITY(U,$J,358.3,13233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13233,1,3,0)
 ;;=3^Psychosis not d/t a subst or known physiol cond, unsp
 ;;^UTILITY(U,$J,358.3,13233,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,13233,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,13234,0)
 ;;=F45.9^^57^655^16
 ;;^UTILITY(U,$J,358.3,13234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13234,1,3,0)
 ;;=3^Somatoform disorder, unspec
 ;;^UTILITY(U,$J,358.3,13234,1,4,0)
 ;;=4^F45.9
 ;;^UTILITY(U,$J,358.3,13234,2)
 ;;=^5003592
 ;;^UTILITY(U,$J,358.3,13235,0)
 ;;=Z00.00^^57^655^10
 ;;^UTILITY(U,$J,358.3,13235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13235,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnl Fndgs
 ;;^UTILITY(U,$J,358.3,13235,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,13235,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,13236,0)
 ;;=Z51.5^^57^655^12
 ;;^UTILITY(U,$J,358.3,13236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13236,1,3,0)
 ;;=3^Palliative care 
 ;;^UTILITY(U,$J,358.3,13236,1,4,0)
 ;;=4^Z51.5
 ;;^UTILITY(U,$J,358.3,13236,2)
 ;;=^5063063
 ;;^UTILITY(U,$J,358.3,13237,0)
 ;;=Z09.^^57^655^8
 ;;^UTILITY(U,$J,358.3,13237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13237,1,3,0)
 ;;=3^Follow-up Exam,Compltd TX,Oth Than Cancer
 ;;^UTILITY(U,$J,358.3,13237,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,13237,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,13238,0)
 ;;=Z63.32^^57^656^2
 ;;^UTILITY(U,$J,358.3,13238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13238,1,3,0)
 ;;=3^Absence of family member, oth
 ;;^UTILITY(U,$J,358.3,13238,1,4,0)
 ;;=4^Z63.32
 ;;^UTILITY(U,$J,358.3,13238,2)
 ;;=^5063167
 ;;^UTILITY(U,$J,358.3,13239,0)
 ;;=Z71.41^^57^656^3
 ;;^UTILITY(U,$J,358.3,13239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13239,1,3,0)
 ;;=3^Alcohol abuse counslng & surveil of alcoholic
 ;;^UTILITY(U,$J,358.3,13239,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,13239,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,13240,0)
 ;;=Z71.89^^57^656^4
 ;;^UTILITY(U,$J,358.3,13240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13240,1,3,0)
 ;;=3^Counseling, oth, spec
 ;;^UTILITY(U,$J,358.3,13240,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,13240,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,13241,0)
 ;;=Z71.9^^57^656^5
 ;;^UTILITY(U,$J,358.3,13241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13241,1,3,0)
 ;;=3^Counseling, unspec
 ;;^UTILITY(U,$J,358.3,13241,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,13241,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,13242,0)
 ;;=Z63.4^^57^656^8
 ;;^UTILITY(U,$J,358.3,13242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13242,1,3,0)
 ;;=3^Disappearance & death of family member
 ;;^UTILITY(U,$J,358.3,13242,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,13242,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,13243,0)
 ;;=Z73.82^^57^656^9
 ;;^UTILITY(U,$J,358.3,13243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13243,1,3,0)
 ;;=3^Dual sensory impairment
 ;;^UTILITY(U,$J,358.3,13243,1,4,0)
 ;;=4^Z73.82
 ;;^UTILITY(U,$J,358.3,13243,2)
 ;;=^5063279
 ;;^UTILITY(U,$J,358.3,13244,0)
 ;;=Z04.41^^57^656^10
 ;;^UTILITY(U,$J,358.3,13244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13244,1,3,0)
 ;;=3^Encntr for exam & obs folwng alleged adlt rape
 ;;^UTILITY(U,$J,358.3,13244,1,4,0)
 ;;=4^Z04.41
 ;;^UTILITY(U,$J,358.3,13244,2)
 ;;=^5062660
 ;;^UTILITY(U,$J,358.3,13245,0)
 ;;=Z76.0^^57^656^11
 ;;^UTILITY(U,$J,358.3,13245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13245,1,3,0)
 ;;=3^Encntr for issue of repeat prescription
 ;;^UTILITY(U,$J,358.3,13245,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,13245,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,13246,0)
 ;;=Z69.12^^57^656^13
 ;;^UTILITY(U,$J,358.3,13246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13246,1,3,0)
 ;;=3^Encntr for mntl hlth serv for perp of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,13246,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,13246,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,13247,0)
 ;;=Z69.010^^57^656^14
 ;;^UTILITY(U,$J,358.3,13247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13247,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of prntl child abuse
 ;;^UTILITY(U,$J,358.3,13247,1,4,0)
 ;;=4^Z69.010
 ;;^UTILITY(U,$J,358.3,13247,2)
 ;;=^5063228
 ;;^UTILITY(U,$J,358.3,13248,0)
 ;;=Z69.11^^57^656^15
 ;;^UTILITY(U,$J,358.3,13248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13248,1,3,0)
 ;;=3^Encntr for mntl hlth serv for vctm of spous or prtnr abuse
 ;;^UTILITY(U,$J,358.3,13248,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,13248,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,13249,0)
 ;;=Z65.5^^57^656^16
 ;;^UTILITY(U,$J,358.3,13249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13249,1,3,0)
 ;;=3^Expsr to disaster, war & oth hostilities
 ;;^UTILITY(U,$J,358.3,13249,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,13249,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,13250,0)
 ;;=Z59.0^^57^656^18
 ;;^UTILITY(U,$J,358.3,13250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13250,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,13250,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,13250,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,13251,0)
 ;;=Z59.5^^57^656^17
 ;;^UTILITY(U,$J,358.3,13251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13251,1,3,0)
 ;;=3^Extreme poverty
 ;;^UTILITY(U,$J,358.3,13251,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,13251,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,13252,0)
 ;;=Z71.7^^57^656^19
 ;;^UTILITY(U,$J,358.3,13252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13252,1,3,0)
 ;;=3^Human immunodeficiency virus [HIV] counseling
 ;;^UTILITY(U,$J,358.3,13252,1,4,0)
 ;;=4^Z71.7
 ;;^UTILITY(U,$J,358.3,13252,2)
 ;;=^5063251
 ;;^UTILITY(U,$J,358.3,13253,0)
 ;;=Z73.4^^57^656^20
 ;;^UTILITY(U,$J,358.3,13253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13253,1,3,0)
 ;;=3^Inadqute social skills, not elswhr classified
 ;;^UTILITY(U,$J,358.3,13253,1,4,0)
 ;;=4^Z73.4
 ;;^UTILITY(U,$J,358.3,13253,2)
 ;;=^5063272
 ;;^UTILITY(U,$J,358.3,13254,0)
 ;;=Z79.2^^57^656^22
 ;;^UTILITY(U,$J,358.3,13254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13254,1,3,0)
 ;;=3^Long term (current) use of antibiotics
 ;;^UTILITY(U,$J,358.3,13254,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,13254,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,13255,0)
 ;;=Z79.01^^57^656^23
 ;;^UTILITY(U,$J,358.3,13255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13255,1,3,0)
 ;;=3^Long term (current) use of anticoagulants
 ;;^UTILITY(U,$J,358.3,13255,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,13255,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,13256,0)
 ;;=Z79.02^^57^656^24
 ;;^UTILITY(U,$J,358.3,13256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13256,1,3,0)
 ;;=3^Long term (current) use of antithrombtc/antipltlts
 ;;^UTILITY(U,$J,358.3,13256,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,13256,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,13257,0)
 ;;=Z79.82^^57^656^25
 ;;^UTILITY(U,$J,358.3,13257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13257,1,3,0)
 ;;=3^Long term (current) use of aspirin
 ;;^UTILITY(U,$J,358.3,13257,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,13257,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,13258,0)
 ;;=Z79.899^^57^656^21
 ;;^UTILITY(U,$J,358.3,13258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13258,1,3,0)
 ;;=3^Long term (current) drug therapy, oth
 ;;^UTILITY(U,$J,358.3,13258,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,13258,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,13259,0)
 ;;=Z79.51^^57^656^26
 ;;^UTILITY(U,$J,358.3,13259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13259,1,3,0)
 ;;=3^Long term (current) use of inhaled steroids
 ;;^UTILITY(U,$J,358.3,13259,1,4,0)
 ;;=4^Z79.51
 ;;^UTILITY(U,$J,358.3,13259,2)
 ;;=^5063335
 ;;^UTILITY(U,$J,358.3,13260,0)
 ;;=Z79.4^^57^656^27
 ;;^UTILITY(U,$J,358.3,13260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13260,1,3,0)
 ;;=3^Long term (current) use of insulin
 ;;^UTILITY(U,$J,358.3,13260,1,4,0)
 ;;=4^Z79.4
 ;;^UTILITY(U,$J,358.3,13260,2)
 ;;=^5063334
 ;;^UTILITY(U,$J,358.3,13261,0)
 ;;=Z79.1^^57^656^28
 ;;^UTILITY(U,$J,358.3,13261,1,0)
 ;;=^358.31IA^4^2
