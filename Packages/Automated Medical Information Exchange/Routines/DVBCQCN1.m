DVBCQCN1 ;;ALB-CIOFO/ECF - CENTRAL NERVOUS SYSTEM AND NEUROMUSCULAR QUESTIONNAIRE ; 5/10/2010
 ;;2.7;AMIE;**174**;Apr 10, 1995;Build 2
 ;
EN ;
 D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 S DVBAX="Central Nervous System and Neuromuscular Diseases",TT=40-($L(DVBAX)\2),PG=1
 W ?TT,DVBAX,!
 S DVBAX="(except Traumatic Brain Injury, Amyotrophic Lateral Sclerosis,",TT=40-($L(DVBAX)\2)
 W ?TT,DVBAX,!
 S DVBAX="Parkinson's Disease, Multiple Sclerosis, Headaches, TMJ Conditions,",TT=40-($L(DVBAX)\2)
 W ?TT,DVBAX,!
 S DVBAX="Epilepsy, Narcolepsy, Peripheral Neuropathy, Sleep Apnea,",TT=40-($L(DVBAX)\2)
 W ?TT,DVBAX,!
 S DVBAX="Cranial Nerve Disorders, Fibromyalgia, and Chronic",TT=40-($L(DVBAX)\2)
 W ?TT,DVBAX,!
 S DVBAX="Fatigue Syndrome",TT=40-($L(DVBAX)\2)
 W ?TT,DVBAX,!
 W ?40-($L("Disability Benefits Questionnaire")\2),"Disability Benefits Questionnaire",!!
 W !?1,"Name of patient/Veteran: ",$S($G(NAME)]"":NAME,1:"_______________________")
 W ?45,"   SSN: ",$S($G(SSN)]"":SSN,1:"________________"),!!
 S DIF="^TMP($J,""DVBAW"",",XCNP=0
 K ^TMP($J,"DVBAW")
 F ROU="DVBCQCN2","DVBCQCN3" S X=ROU X ^%ZOSF("LOAD")
 K DIF,XCNP,ROU
 N LP,TEXT
 S LP=0,STOP=0
 F  S LP=$O(^TMP($J,"DVBAW",LP)) Q:(LP="")!(STOP)  D
 .S TEXT=^TMP($J,"DVBAW",LP,0)
 .I (TEXT'[";;")!(TEXT[";AMIE;")!(TEXT["CIOFO/") Q
 .I TEXT["^TOF^" D HD2
 .I TEXT["^END^" S STOP=1 Q
 .W:TEXT'["^TOF^" $P(TEXT,";;",2),! I $Y>56 D HD2
 K ^TMP($J,"DVBAW"),DVBY,TEXT,STOP,LP,PG,DVBAX,X
 Q
 ;
HD2 ;
 S DVBY=$O(^TMP($J,"DVBAW",LP))
 Q:DVBY=""
 Q:$G(^TMP($J,"DVBAW",DVBY,0))["^END^"
 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Disability Benefits Questionnaire for ",$G(NAME),!
 W "Central Nervous System and Neuromuscular Diseases",!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
