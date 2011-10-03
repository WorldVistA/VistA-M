RABWORD2 ;HOIFO/KAR - Radiology Billing Awareness ;12/20/04  3:55pm
 ;;5.0;Radiology/Nuclear Medicine;**41,70**;Mar 16, 1998;Build 7
 ;
 ; Rtn invokes IA #1300-A, #2083, #4419
 Q
ORDER ; List Exam Orders to select to copy ICD-9 SC/EC Indicator values from
 D HDR S (RAXIT,RACOPY)=0
 N RALP,RA751,DIROUT,DIRUT,DTOUT,DUOUT S (RALP,RAXIT)=0
 F  S RALP=$O(^RAO(75.1,"B",RADFN,RALP)) Q:RALP'>0!(RAXIT)  D
 .S RA751(0)=$G(^RAO(75.1,RALP,0)),RA751(2)=$P(RA751(0),U,2)
 .Q:RA751(2)=""
 .S RA751(16)=$P(RA751(0),U,16),RA751(20)=$P(RA751(0),U,20)
 .S RA751(5)=+$P(RA751(0),U,5) Q:RA751(5)=1
 .S Y=RA751(2),C=$P($G(^DD(75.1,2,0)),U,2) D Y^DIQ S RA751(2)=Y
 .S Y=RA751(20),C=$P($G(^DD(75.1,20,0)),U,2) D Y^DIQ S RA751(20)=Y
 .S RACOPY=RACOPY+1,RACOPY(RACOPY)=RALP
 .W !,RACOPY,?10,$E(RA751(2),1,28),?39
 .W $S(RA751(16)]"":$$FMTE^XLFDT(RA751(16),"2D"),1:"")
 .W ?52,$E(RA751(20),1,12) ; prints 'SUBMIT REQUEST TO' data
 .I $E(IOST,1,2)="C-",($Y>(IOSL-4)) D
 ..K DIR S DIR(0)="E" D ^DIR K DIR S:'+Y RAXIT=1
 ..I 'RAXIT W @IOF D HDR
 Q
HDR ; Header
 D HOME^%ZIS W:$D(RAOPT("ORDEREXAM"))#2 @IOF
 W !!,"#",?10,"Last Procedures/New Orders",?39,"Order Date",?52,"Imaging Loc."
 W !,"------",?10,"----------------------------",?39,"------------",?52,"------------"
 Q
PREV ;Prompt for Copying a previous Order's DX/SC/EC values.
 Q:'$D(^XUSEC("PROVIDER",DUZ))  ;user provider key check
 Q:'$$CIDC^IBBAPI(RADFN)  ;patient insurance & CIDC switch check
 N RAPREV S RAPREV=0 K DIR
 I $P($G(VAEL(3)),"^") D
 .S DIR("B")="NO",DIR("A")="Copy a previous order's ICD codes and SC/EI values",DIR(0)="YO"
 .S DIR("?")="Answer 'Y' if you plan to copy ICD-9 Diagnosis codes and Service Connected/Environmental Indicator values to this order." D ^DIR
 I '$P($G(VAEL(3)),"^") D
 .S DIR("B")="NO",DIR("A")="Copy a previous order's ICD codes",DIR(0)="YO"
 .S DIR("?")="Answer 'Y' if you plan to copy ICD-9 Diagnosis codes to this order." D ^DIR
 I Y D 
 .N RACOPY D ORDER
 .K DIR S DIR("A")="Select Order # to copy",DIR(0)="NO" D ^DIR
 .I '$D(RACOPY(+Y)) W !,"*Invalid selection" S RAPREV=1 Q
 .I +Y>0 D
 ..I '$D(^RAO(75.1,RACOPY(+Y),"BA")) W !,"*No Previous ICD codes entered for this order" Q
 ..S ^TMP("RACOPY",$J,"BA")=^RAO(75.1,RACOPY(+Y),"BA")
 ..N RABASEC S RABASEC=0 F  S RABASEC=$O(^RAO(75.1,RACOPY(+Y),"BAS",RABASEC)) Q:RABASEC<1  D
 ...S ^TMP("RACOPY",$J,"BA",$P(^RAO(75.1,RACOPY(+Y),"BAS",RABASEC,0),U,1))=^RAO(75.1,RACOPY(+Y),"BAS",RABASEC,0)
 G:RAPREV PREV
 Q
ELIG ;List the Service Connected ratios for the patient
 N RAY,RAELIG,RASC,RAPERC,RAAO,RAIR,RAEC,RASHAD
 D DEM^VADPT,ELIG^VADPT,SVC^VADPT
 S RAELIG=$P(VAEL(1),"^",2),RASC=$P(VAEL(3),"^"),RASC=$S(RASC:"YES",RASC=0:"NO",1:""),RAPERC=$P(VAEL(3),"^",2)
 S RAAO=$S(VASV(2):"YES",1:"NO"),RAIR=$S(VASV(3):"YES",1:"NO"),RASHAD=$S($G(VASV(11)):"YES",1:"NO")
 S DIC=2,DA=RADFN,DR=".322013",DIQ="RAY",DIQ(0)="I" D EN^DIQ1 K DA,DIC,DIQ,DR
 S RAEC=RAY(2,RADFN,.322013,"I"),RAEC=$S(RAEC="Y":"YES",1:"NO")
 W @IOF,!,VADM(1)_"  ("_VA("PID")_")       ",$P(VAEL(6),"^",2),!!,"   * * * Eligibility Information and Service Connected Conditions * * *"
 W !!,?5,"Primary Eligibility: "_RAELIG,!,?5,"A/O Exp.: "_RAAO,?22,"ION Rad.: "_RAIR,?40,"SWAC: "_RAEC,?57,"SHAD: "_RASHAD,!
 Q
ADDEXAM ;Add DX/SC/EI data to new order when adding order to Last Visit
 Q:'$D(^XUSEC("PROVIDER",DUZ))  ;user provider key check
 Q:'$$CIDC^IBBAPI(RADFN)  ;patient insurance & CIDC switch check
 N RAOIEN,RACOPY,RABASEC
 S RAOIEN=$P(^RADPT(RADFN,"DT",RAVLEDTI,"P",RAVLECNI,0),U,11)
 Q:'$D(^RAO(75.1,RAOIEN,"BA"))
 S ^TMP("RACOPY",$J,"BA")=^RAO(75.1,RAOIEN,"BA")
 S RABASEC=0 F  S RABASEC=$O(^RAO(75.1,RAOIEN,"BAS",RABASEC)) Q:RABASEC<1  D
 .S ^TMP("RACOPY",$J,"BA",$P(^RAO(75.1,RAOIEN,"BAS",RABASEC,0),U,1))=^RAO(75.1,RAOIEN,"BAS",RABASEC,0)
 Q
