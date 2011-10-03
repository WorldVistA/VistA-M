ONCSSF1 ;Hines OIFO/GWB - SITE-SPECIFIC FACTOR 1 (165.5,44.1) ;11/20/03
 ;;2.11;ONCOLOGY;**40**;Mar 07, 1995
 ;
 ;SITE-SPECIFIC FACTOR 1 (165.5,44.1)
SSF1IT ;INPUT TRANSFORM
 ;
 S PS=$P($G(^ONCO(165.5,D0,2)),U,1)
 I PS="" K X W "  No PRIMARY SITE defined for this primary" Q
 S MO=$$HIST^ONCFUNC(D0)
 ;
 S SSFIEN=$S($D(^ONCO(164.52,"C",PS_"-1")):$O(^ONCO(164.52,"C",PS_"-1",0)),1:1)
 ;
 ;Malignant Melanoma of Skin, Vulva, Penis, Scrotum
 I $$MELANOMA^ONCOU55(D0) D
 .S MELIEN=$O(^ONCO(164.52,"B","MEASURED THICKNESS (DEPTH), BR",0))
 .I $E(PS,3,4)=44 S SSFIEN=MELIEN S MELIND="Y" Q
 .I $E(PS,3,4)=51 S SSFIEN=MELIEN S MELIND="Y" Q
 .I $E(PS,3,4)=60 S SSFIEN=MELIEN S MELIND="Y" Q
 .I PS=67632 S SSFIEN=MELIEN S MELIND="Y" Q
 .I PS=67690 S SSFIEN=MELIEN S MELIND="Y" Q
 .I PS=67693 S SSFIEN=MELIEN S MELIND="Y" Q
 .I PS=67694 S SSFIEN=MELIEN S MELIND="Y" Q
 I $G(MELIND)="Y",+X>0,+X<989 D  G ITEX
 .I X'?3N D  K X Q
 ..W !,"Code exact measurement in HUNDREDTHS of millimeters."
 ..W !,"Examples:"
 ..W !,"Enter 001 for 0.01 mm"
 ..W !,"Enter 002 for 0.02 mm"
 ..W !,"Enter 010 for 0.10 mm"
 ..W !,"Enter 074 for 0.74 mm"
 ..W !,"Enter 100 for 1.00 mm"
 ..W !,"Enter 105 for 1.05 mm"
 ..W !,"Enter 988 for 9.88 mm"
 .W "  ",$E(X,1),".",$E(X,2,3)," mm"
 ;
 ;Kaposi Sarcoma of All Sites
 ;Hodgkin and Non-Hodgkin Lymphomas of All Sites
 I ($E(MO,1,4)=9140)!($$LYMPHOMA^ONCFUNC(D0)) S SSFIEN=$O(^ONCO(164.52,"B","ASSOCIATED WITH HIV/AIDS",0)) G SSF1I
 ;
 ;Mycosis Fungoides and Sezary Disease of Skin, Vulva, Penis, Scrotum
 I (MO=97003)!(MO=97013) S SSFIEN=$O(^ONCO(164.52,"B","PERIPHERAL BLOOD INVOLVEMENT",0)) G SSF1I
 ;
 ;Hematopoietic, Reticuloendothelial, Immunoproliferative, and
 ;Myeloproliferative Neoplasms
 I (MO'<97310)&(MO'>99899) S SSFIEN=$O(^ONCO(164.52,"B","NOT APPLICABLE FOR THIS SITE",0)) G SSF1I
 ;
 ;Retinoblastoma
 I $E(MO,1,3)=951 S SSFIEN=$O(^ONCO(164.52,"B","EXTENSION EVALUATED AT ENUCLEA",0)) G SSF1I
 ;
 ;Head and neck
 I $P(^ONCO(164.52,SSFIEN,0),U,1)="SIZE OF LYMPH NODES",+X>0,+X<989 D  G ITEX
 .I X'?3N D  K X Q
 ..I X?1N W !!,"     For ",X," enter 00",X
 ..I X?2N W !!,"     For ",X," enter 0",X
 .W "  ",X," mm"
 ;
 ;Prostate
 I PS=67619,+X>1,+X<900 D  G ITEX
 .I X'?3N D  K X Q
 ..W !!,"     Examples:"
 ..W !!,"     Enter 025 for 02.5 ng/ml"
 ..W !,"     Enter 040 for 04.0 ng/ml"
 ..W !,"     Enter 200 for 20.0 ng/ml",!
 .W "  ",$E(X,1,2),".",$E(X,3)," ng/ml"
 ;
SSF1I I '$D(^ONCO(164.52,SSFIEN,1,"B",X)) K X Q
 S SSF=$O(^ONCO(164.52,SSFIEN,1,"B",X,0))
 W "  ",$P(^ONCO(164.52,SSFIEN,1,SSF,0),U,2)
ITEX K PS,SSFIEN,SSF,MO,MELIND Q
 ;
SSF1OT ;OUTPUT TRANSFORM
 ;
 S PS=$P($G(^ONCO(165.5,D0,2)),U,1)
 Q:PS=""
 S MO=$$HIST^ONCFUNC(D0)
 ;
 S SSFIEN=$S($D(^ONCO(164.52,"C",PS_"-1")):$O(^ONCO(164.52,"C",PS_"-1",0)),1:1)
 ;
 ;Malignant Melanoma of Skin, Vulva, Penis, Scrotum
 I $$MELANOMA^ONCOU55(D0) D
 .S MELIEN=$O(^ONCO(164.52,"B","MEASURED THICKNESS (DEPTH), BR",0))
 .I $E(PS,3,4)=44 S SSFIEN=MELIEN S MELIND="Y" Q
 .I $E(PS,3,4)=51 S SSFIEN=MELIEN S MELIND="Y" Q
 .I $E(PS,3,4)=60 S SSFIEN=MELIEN S MELIND="Y" Q
 .I PS=67632 S SSFIEN=MELIEN S MELIND="Y" Q
 .I PS=67690 S SSFIEN=MELIEN S MELIND="Y" Q
 .I PS=67693 S SSFIEN=MELIEN S MELIND="Y" Q
 .I PS=67694 S SSFIEN=MELIEN S MELIND="Y" Q
 I $G(MELIND)="Y",+Y>0,+Y<989 S Y=$E(Y,1)_"."_$E(Y,2,3)_" mm" G OTEX
 ;
 ;Kaposi Sarcoma of All Sites
 ;Hodgkin and Non-Hodgkin Lymphomas of All Sites
 I ($E(MO,1,4)=9140)!($$LYMPHOMA^ONCFUNC(D0)) S SSFIEN=$O(^ONCO(164.52,"B","ASSOCIATED WITH HIV/AIDS",0)) G SSF1O
 ;
 ;Mycosis Fungoides and Sezary Disease of Skin, Vulva, Penis, Scrotum
 I (MO=97003)!(MO=97013) S SSFIEN=$O(^ONCO(164.52,"B","PERIPHERAL BLOOD INVOLVEMENT",0)) G SSF1O
 ;
 ;Hematopoietic, Reticuloendothelial, Immunoproliferative, and
 ;Myeloproliferative Neoplasms
 I (MO'<97310)&(MO'>99899) S SSFIEN=$O(^ONCO(164.52,"B","NOT APPLICABLE FOR THIS SITE",0)) G SSF1O
 ;
 ;Retinoblastoma
 I $E(MO,1,3)=951 S SSFIEN=$O(^ONCO(164.52,"B","EXTENSION EVALUATED AT ENUCLEA",0)) G SSF1O
 ;
 ;Head and neck
 I $P(^ONCO(164.52,SSFIEN,0),U,1)="SIZE OF LYMPH NODES",+Y>0,+Y<989 S Y=Y_" mm" G OTEX
 ;
 ;Prostate
 I PS=67619,+Y>1,+Y<900 S Y=$E(Y,1,2)_"."_$E(Y,3)_" ng/ml" G OTEX
 ;
SSF1O S SSF=$O(^ONCO(164.52,SSFIEN,1,"B",Y,0)) I SSF="" G OTEX
 S Y=$P($G(^ONCO(164.52,SSFIEN,1,SSF,0)),U,2)
OTEX K PS,SSFIEN,SSF,MO,MELIND Q
 ;
SSF1HP ;HELP
 ;
 S PS=$P($G(^ONCO(165.5,D0,2)),U,1)
 Q:PS=""
 S MO=$$HIST^ONCFUNC(D0)
 ;
 S SSFIEN=$S($D(^ONCO(164.52,"C",PS_"-1")):$O(^ONCO(164.52,"C",PS_"-1",0)),1:1)
 ;
 ;Malignant Melanoma of Skin, Vulva, Penis, Scrotum
 I $$MELANOMA^ONCOU55(D0) D
 .S MELIEN=$O(^ONCO(164.52,"B","MEASURED THICKNESS (DEPTH), BR",0))
 .I $E(PS,3,4)=44 S SSFIEN=MELIEN Q
 .I $E(PS,3,4)=51 S SSFIEN=MELIEN Q
 .I $E(PS,3,4)=60 S SSFIEN=MELIEN Q
 .I PS=67632 S SSFIEN=MELIEN Q
 .I PS=67690 S SSFIEN=MELIEN Q
 .I PS=67693 S SSFIEN=MELIEN Q
 .I PS=67694 S SSFIEN=MELIEN Q
 ;
 ;Kaposi Sarcoma of All Sites
 ;Hodgkin and Non-Hodgkin Lymphomas of All Sites
 I ($E(MO,1,4)=9140)!($$LYMPHOMA^ONCFUNC(D0)) S SSFIEN=$O(^ONCO(164.52,"B","ASSOCIATED WITH HIV/AIDS",0))
 ;
 ;Mycosis Fungoides and Sezary Disease of Skin, Vulva, Penis, Scrotum
 I (MO=97003)!(MO=97013) S SSFIEN=$O(^ONCO(164.52,"B","PERIPHERAL BLOOD INVOLVEMENT",0))
 ;
 ;Hematopoietic, Reticuloendothelial, Immunoproliferative, and
 I (MO'<97310)&(MO'>99899) S SSFIEN=$O(^ONCO(164.52,"B","NOT APPLICABLE FOR THIS SITE",0))
 ;
 ;Retinoblastoma
 I $E(MO,1,3)=951 S SSFIEN=$O(^ONCO(164.52,"B","EXTENSION EVALUATED AT ENUCLEA",0))
 ;
 W !," SITE-SPECIFIC FACTOR 1 for " D
 .I MO=97003 W "MYCOSIS FUNGOIDES of ",$P(^ONCO(164,PS,0),U,1)," (",$P(^ONCO(164,PS,0),U,2),")" Q
 .I MO=97013 W "SEZARY SYNDROME of ",$P(^ONCO(164,PS,0),U,1)," (",$P(^ONCO(164,PS,0),U,2),")" Q
 .I $E(MO,1,3)=951 W "RETINOBLASTOMA of ",$P(^ONCO(164,PS,0),U,1)," (",$P(^ONCO(164,PS,0),U,2),")" Q
 .I $$MELANOMA^ONCOU55(D0),($E(PS,3,4)=44)!($E(PS,3,4)=51)!($E(PS,3,4)=60)!(PS=67632)!($E(PS,3,4)=69) W "MALIGNANT MELANOMA of ",$P(^ONCO(164,PS,0),U,1)," (",$P(^ONCO(164,PS,0),U,2),")" Q
 .I $E(MO,1,4)=9140 W "KAPOSI SARCOMA of ALL SITES" Q
 .I $$LYMPHOMA^ONCFUNC(D0) W "HODGKIN AND NON-HODGKIN LYMPHOMAS of ALL SITES" Q
 .I MO'="",(MO'<97310)&(MO'>99899) W $P(^ONCO(169.3,MO,0),U,1)," (",$P(^ONCO(169.3,MO,0),U,2),")" Q
 .W $P(^ONCO(164,PS,0),U,1)," (",$P(^ONCO(164,PS,0),U,2),")"
 W !," ",$P(^ONCO(164.52,SSFIEN,0),U,1)
 ;S SSF=0 F  S SSF=$O(^ONCO(164.52,SSFIEN,1,SSF)) Q:SSF'>0  D
 ;.S TAB=6
 ;.I ($P(^ONCO(164.52,SSFIEN,0),U,1)="SIZE OF LYMPH NODES")!($P(^ONCO(164.52,SSFIEN,0),U,1)="PROSTATIC SPECIFIC ANTIGEN (PSA) LAB VALUE")!($P(^ONCO(164.52,SSFIEN,0),U,1)="MEASURED THICKNESS (DEPTH), BRESLOW'S MEASUREMENT") S TAB=10
 ;.W " ",$P(^ONCO(164.52,SSFIEN,1,SSF,0),U,1),?TAB,$P(^ONCO(164.52,SSFIEN,1,SSF,0),U,2),!
 K PS,SSFIEN,SSF,MO Q
