SCDXSUP ;RENO/KEITH ALB/SCK - Consistency checker for Ambulatory Care Reporting Project (ACRP); 02/26/97
 ;;5.3;Scheduling;**99**;Aug 13, 1993
 ;
CQ ;Queue re-calculation of OUTPATIENT ENCOUNTER checkout status
 ;
 ;  Variable List
 ;     SCBDT   - Beginning date for search in Outpatient Encounter file
 ;     SCDT    - Outpatient Encounter date
 ;     SCE0    - Zero node of the outpatient encounter
 ;     OEIN    - IEN of the outpatient encounter
 ;     SCLINE  - Dashed line for report
 ;     SCPNOW  - External date
 ;     SCEDT   - Ending date for search in Outpatient Encounter file
 ;     PAGE    - Number of pages
 ;     SCCT    - Count of entries processed
 ;
 W !!,"This option will check outpatient encouters with a status of 'CHECKED OUT'"
 W !,"for a entry in the TRANSMITTED OUTPATIENT ENCOUNTER file."
 W !,"If no entry exists, and the encounter is for a COUNT Clinic, then "
 W !,"a transmission entry will be added."
 W !!,"This may take a while, please queue to a printer!",!
 ;
 N SCBDT,SCEDT,SCPFLG
 S SCBDT=$$ASKDT("Beginning")
 Q:SCBDT<0
CQ1 S SCEDT=$$ASKDT("Ending")
 Q:SCEDT<0
 I SCEDT<SCBDT D  G CQ1
 . W !!,"Ending date cannot be earlier than the Beginning date!",!
 ;
 S SCPFLG=1
 N ZTSAVE,%ZIS
 S %ZIS=0,ZTSAVE("SCBDT")="",ZTSAVE("SCEDT")="",ZTSAVE("SCPFLG")=""
 D EN^XUTMDEVQ("CALC^SCDXSUP","Update Checkout Status",.ZTSAVE,.%ZIS)
 Q
 ;
CQAPI(SCBG,SCED,SCPFLG) ;  API entry point for re-calculation of OUTPATIENT ENCOUNTER checkout status
 ;  INPUT:
 ;     SCBG   - Beginning date, if passed in, use it
 ;     SCED   - Ending date, if passed in, use it
 ;     SCPFLG - Print Report flag
 ;                1 - Print report
 ;                0 - Do not print report
 ;
 S SCBDT=$G(SCBG)
 S SCEDT=$G(SCED)
 ;
CALC ;Update Checkout Status
 ;
 N SCDT,OEIN,SCPNOW,SCLINE,SCE0,SCCT,SCABRT
 ;
 K ^TMP("SCMSC",$J)
 ;
 ; ** Order through the Outpatatient Encounter file, if the encounter is the parent, evaluate it.
 S SCDT=SCBDT-.1
 F  S SCDT=$O(^SCE("B",SCDT)) Q:'SCDT!(SCDT>(SCEDT+.99999))  D
 . S OEIN=0 F  S OEIN=$O(^SCE("B",SCDT,OEIN)) Q:'OEIN  D
 .. S SCE0=$G(^SCE(OEIN,0))
 .. ; ** The following code removes any extraneous 'B' xrefs found that do not
 .. ;    point to a valid entry
 .. I SCE0']"" D  Q
 ... K ^SCE("B",SCDT,OEIN)
 .. I '$P(SCE0,U,6) D EVAL(SCE0,OEIN,SCDT)
 ;
 G:'$G(SCPFLG) EXIT
 ;
 ; ** Prepare report output
 S SCLINE="",$P(SCLINE,"-",(IOM+1))=""
 S SCPNOW=$P($$FMTE^XLFDT($$NOW^XLFDT()),":",1,2)
 S SCBDT=$$FMTE^XLFDT(SCBDT)
 S SCEDT=$$FMTE^XLFDT(SCEDT)
 S PAGE=1,SCCT=0
 ;
CRTX ;
 S SCHD="MISSING TRANSMISSION RECORDS CREATED"
 D HDR
 I '$D(^TMP("SCMSC",$J,2)) D  G NEXT1
 . W !!,"No encounters with missing transmission records found."
 ;
 S (SCDT,SCCT)=0
 F  S SCDT=$O(^TMP("SCMSC",$J,2,SCDT)) Q:'SCDT  D  Q:$G(SCABRT)
 . S OEIN=0 F  S OEIN=$O(^TMP("SCMSC",$J,2,SCDT,OEIN)) Q:'OEIN  D  Q:$G(SCABRT)
 .. S SCE0=^TMP("SCMSC",$J,2,SCDT,OEIN) D PRT(SCE0)
 ;
 I $Y>(IOSL-5) D:$$NEWPAGE HDR
 W !!,SCCT," transmission record",$S(SCCT=1:"",1:"s")," created."
 ;
NEXT1 ;
 S SCHD="COUNT CLINIC ENCOUNTERS SET FOR RETRANSMIT"
 S X=$$NEWPAGE Q:$G(SCABRT)
 S PAGE=1
 W:'(IOST?1"C-".E) @IOF
 D HDR
 I '$D(^TMP("SCMSC",$J,3)) D  G EXIT
 . W !!,"No Count Clinic encounters found needing retransmission."
 ;
 S (SCDT,SCCT)=0
 F  S SCDT=$O(^TMP("SCMSC",$J,3,SCDT)) Q:'SCDT  D  Q:$G(SCABRT)
 . S OEIN=0 F  S OEIN=$O(^TMP("SCMSC",$J,3,SCDT,OEIN)) Q:'OEIN  D  Q:$G(SCABRT)
 .. S SCE0=^TMP("SCMSC",$J,3,SCDT,OEIN) D PRT(SCE0)
 ;
 D:$Y>(IOSL-5) HDR W !!,SCCT," Count clinic encounters marked for retransmission."
 ;
EXIT ;
 K %ZIS,SCHD,PAGE,SCEDT,SCBDT,SCPT0
 K ^TMP("SCMSC",$J)
 Q
 ;
EVAL(SC0,OEIN,SDT) ;Evaluate checkout status
 ; ** If the encounter appt. status is CHECKED OUT, and the check out process is
 ;    completed, but there is no entry for the encounter in the Transmitted
 ;    Outpatient Encounter file, then process the encounter into the Transmitted
 ;    Outpatient Encounter File, #409.73
 ;
 ;    If clinic is NON-COUNT and Checked out, then change STATUS field, #.12, from
 ;    CHECKED OUT to NON-COUNT and exit.
 ;
 ;    Input:
 ;       SC0  - 0 node of the Outpatient encounter
 ;       OEIN - IEN of the Outpatient encounter
 ;       SDT  - Date of the Outpatient encounter
 ;    
 ;    Output
 ;       ^TMP("SCMSC",$J,n,SDT,OEIN)=SC0
 ;
 ;    Variables
 ;       SCTOE - IEN of entry created in the Transmitted Outpatient Encounter file
 ;               -1 if unable to create entry
 ;
 N SCTOE
 I $P(SC0,U,12)=2,$P(SC0,U,7),'$D(^SD(409.73,"AENC",OEIN)) D  Q
 . I $P($G(^SC(+$P(SC0,U,4),0)),U,17)="Y" D  Q
 .. S DA=OEIN,DR=".12////12",DIE="^SCE("
 .. D ^DIE K DIE,DR
 . S SCTOE=$$CRTXMIT^SCDXFU01(OEIN)
 . I SCTOE>0 D STREEVNT^SCDXFU01(SCTOE,1),XMITFLAG^SCDXFU01(SCTOE,0) S ^TMP("SCMSC",$J,2,SDT,OEIN)=SC0
 ;
 I $P(SC0,U,12)=12,$P(SC0,U,7) D
 . I $P($G(^SC(+$P(SC0,U,4),0)),U,17)="Y" Q
 . S DA=OEIN,DR=".12////2",DIE="^SCE("
 . D ^DIE K DIE,DR
 . S SCTOE=+$O(^SD(409.73,"AENC",OEIN,0))
 . I 'SCTOE D
 .. S SCTOE=$$CRTXMIT^SCDXFU01(OEIN)
 . I SCTOE>0 D STREEVNT^SCDXFU01(SCTOE,1),XMITFLAG^SCDXFU01(SCTOE,0) S ^TMP("SCMSC",$J,3,SDT,OEIN)=SC0
 ;
 Q
 ;
HDR ;  Header
 W:PAGE>1 @IOF
 W !,SCLINE,!,?(IOM-($L(SCHD)+10)\2),"<*>  ",SCHD,"  <*>",!,SCLINE
 W !,"For date range ",SCBDT," to ",SCEDT
 W !,"Date printed: ",SCPNOW,?(IOM-7-$L(PAGE)),"Page: ",PAGE,!
 ;
 W !,"Patient",?21,"SSN",?33,"Appointment",?56,"Clinic",!,SCLINE
 S PAGE=PAGE+1
 ;
 Q
 ;
PRT(SC0) ;Print appointment
 ;
 I $Y>(IOSL-5) D:$$NEWPAGE HDR Q:$G(SCABRT)
 S SCCT=SCCT+1,SCPT0=^DPT($P(SC0,U,2),0)
 W !,$E($P(SCPT0,U),1,18),?21,$P(SCPT0,U,9)
 W ?33,$P($$FMTE^XLFDT($P(SC0,U)),":",1,2)
 W ?56,$E($P($G(^SC(+$P(SC0,U,4),0)),U),1,(IOM-56))
 Q
 ;
ASKDT(TXT) ; Enter beginning date for searching outpatient encounter file
 S DIR(0)="DA^::EXP",DIR("A")="Enter "_TXT_" date for search: "
 S DIR("?")="^D HELP^%DTC"
 S DIR("B")=$$FMTE^XLFDT($$DT^XLFDT())
 D ^DIR K DIR
 S:$D(DIRUT) Y=-1
 K DIRUT
 Q Y
 ;
NEWPAGE() ; Check device and display prompt for terminals
 N DIR,SCOK
 I IOST?1"C-".E D
 . W !
 . S DIR(0)="E" D ^DIR S SCABRT='$G(Y)
 . I 'SCABRT S SCOK=1 W @IOF
 Q +$G(SCOK)
