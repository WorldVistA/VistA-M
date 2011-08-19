SDSCNSCP ;ALB/JAM - ASCD NSC Encounters Purge ; 4/24/07 4:29pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;
 ;**Program Description**
 ;  This program will purge encounters with a status of NEW where 
 ;  the Visit SC value equals the ASCD value of "NO" for a specified
 ;  division(s) with and a user defined date range. Users must have 
 ;  the SDSC SUPER key to run this option.
 Q
EN ;  Entry Point
 N ZTQUEUED,POP,ZTRTN,ZTDTH,ZTDESC,ZTSAVE,SDSCDVSL,SDSCDVLN,DIR,X,Y
 N DTOUT,DUOUT
 ;  Get start and end date for encounter list.
 D GETDATE^SDSCOMP I SDSCTDT="" G EXIT
 ;  Ask for division
 D DIV^SDSCUTL
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) G EXIT
 S SDSCDVSL=Y,SDSCDVLN=SCLN
 K SCLN,DIR
 ;  Determine type of user
 D TYPE^SDSCUTL
 I SDTYPE'="S" W !!,"You do not have privileges to run this report." Q
 W !!,"This option will permanently remove the outpatient encounters that are at a"
 W !,"NEW status when both the Encounter SC value and the ASCD value are 'NO' from"
 W !,"the SDSC SERVICE CONNECTED CHANGES file (#409.48).",!
 S DIR(0)="Y",DIR("A")="Are you sure you want to continue",DIR("B")="N"
 S DIR("?")="YES to remove encounters from the Review file, NO to Exit."
 D ^DIR
 I ('Y)!($G(DTOUT))!($G(DUOUT)) G EXIT
 ;
 K %ZIS,IOP,IOC,ZTIO S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="BEG^SDSCNSCP",ZTDTH=$H,ZTDESC="Purge ASCD NSC Encounters"
 . S ZTSAVE("SDSCDVSL")="",ZTSAVE("SDSCDVLN")="",ZTSAVE("SDEDT")=""
 . S ZTSAVE("SDSCTDT")="",ZTIO=ION
 . K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED"
 ;
BEG ; Begin report
 N SDSCDIV,SDSCDNM,SDI,SDGTOT,SDPG
 S SDGTOT=0,SDPG=1
 S SDSCDIV=$S(SDSCDVSL'[SDSCDVLN:SDSCDVSL,1:"")
 I SDSCDIV="" S SDSCDNM="ALL" D FND G EXIT
 I SDSCDIV'="" D
 . F SDI=1:1:$L(SDSCDVSL,",") S SDSCDIV=$P(SDSCDVSL,",",SDI) Q:SDSCDIV=""  D
 .. S SDSCDNM=$P(^DG(40.8,SDSCDIV,0),"^",1)
 .. D FND
 W !!,"Grand total of NSC Records Purged: ",SDGTOT
 G EXIT
 ;
FND ; Find records and delete
 N SDOEDT,SDOE0,SDEDIV,SDOE,SDSCDATA,SDL,SDV0,SDPRV,SCVST,SDCNT,DFN,DIK,DA
 ;
 D HDR
 S SDOEDT=SDSCTDT-1,(SDL,SDCNT)=0
 F  S SDOEDT=$O(^SDSC(409.48,"AE",SDOEDT)) Q:SDOEDT\1>SDEDT!(SDOEDT="")  D
 . S SDOE=""
 . F  S SDOE=$O(^SDSC(409.48,"AE",SDOEDT,SDOE)) Q:SDOE=""  D
 .. S SDOE0=$$GETOE^SDOE(SDOE),SDSCDATA=$G(^SDSC(409.48,SDOE,0))
 .. Q:SDOE0=""  Q:SDSCDATA=""
 .. ; Check if status is NEW
 .. I $P(SDSCDATA,U,5)'="N" Q
 .. S SDEDIV=$P(SDSCDATA,U,12) Q:SDEDIV=""
 .. I SDSCDIV'="" Q:SDEDIV'=SDSCDIV
 .. ; Check for ASCD SC value
 .. I $P(SDSCDATA,U,9)'=0 Q
 .. ; Check for Visit SC value
 .. S SDV0=$P(SDOE0,U,5),SCVST=$$GET1^DIQ(9000010,SDV0_",",80001,"I")
 .. I SCVST'=0 Q
 .. S DFN=$P(SDOE0,U,"2Z") D DEM^VADPT
 .. S SDCNT=SDCNT+1,SDGTOT=SDGTOT+1,SCVST=$S(SCVST:"Y",SCVST=0:"NO",1:"")
 .. S SDPRV=$$GET1^DIQ(200,$$PRIMVPRV^PXUTL1(SDV0)_",",.01,"E"),SDL=SDL+1
 .. W !,$$FMTE^XLFDT(SDOEDT,2),?16,SDOE,?30,$E(VADM(1),1,25),?55,$E(SDPRV,1,19),?75,SCVST
 .. S DIK="^SDSC(409.48,",DA=SDOE D ^DIK
 .. D KVA^VADPT
 .. I $E(IOST,1,2)'="C-",SDL+4>IOSL D HDR
 W !!,"Number of NSC Records Purged: ",SDCNT," for "_SDSCDNM
 Q
 ;
HDR ;  Print report
 N SDHDR,I
 S SDHDR="Purge ASCD NSC Encounters"
 W @IOF
 W SDHDR,?67,"PAGE: ",SDPG
 W !,?5,"For Encounters Dated ",$$FMTE^XLFDT(SDSCTDT,2)," THRU ",$$FMTE^XLFDT(SDEDT,2)," For Division: ",SDSCDNM,!!
 W "Encounter Date",?16,"Encounter No.",?30,"Patient Name",?55,"Provider",?73,"SC Val"
 W ! F I=1:1:79 W "-"
 S SDPG=SDPG+1
 Q
 ;
EXIT ;clean up variables before exiting option
 K SDEDT,SDOPT,SDSCBDT,SDSCCR,SDSCEDT,SDSCTAT,SDSCTDT,SDTYPE
 Q
