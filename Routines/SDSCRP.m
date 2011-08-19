SDSCRP ;ALB/JAM - Restricted Stop Code Nonconforming Clinic Report; 07/24/03
 ;;5.3;Scheduling;**317,547**;Aug 13, 1993;Build 17
 ;
EN ;foreground entry point
 N ZTRTN,ZTDESC,ZTIO,ZTQUEUED,SDPCF,DIR,DIRUT,X,Y
 W @IOF
 S DIR(0)="SO^A:Active Clinics;I:Inactive Clinics;B:Both"
 S DIR("A")="Select Report"
 S DIR("?",1)="Enter an A for Active Clinics, I for Inactive Clinics,"
 S DIR("?")="B for Both Active and Inactive Clinics"
 D ^DIR K DIR I $D(DIRUT) G END
 S SDPCF=Y
 ;device selection
 K IOP,%ZIS,POP,IO("Q")
 S %ZIS("A")="Select Device: ",%ZIS="QM" D ^%ZIS I POP G END
 I $D(IO("Q")) K IO("Q") D  G END
 .S ZTDESC="Non-Conforming Clinics Stop Code Report",ZTSAVE("SDPCF")=""
 .S ZTRTN="PROCESS^SDSCRP",ZTIO=ION D ^%ZTLOAD,HOME^%ZIS K ZTSK
 U IO
 D PROCESS
END D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PROCESS ;background entry point
 ;locate invalid Stop Code in HOSPITAL LOCATION file #44
 N NAM,IDT,RDT,IDAT,STR,ECX,IEN,PSC,SSC,PSCN,SSCN,CNTX,SDPG,SDOUT,SDF,LNS
 N ACF,SDRDT
 S %H=$H D YX^%DTC S SDRDT=Y
 S $P(LNS,"-",80)="",(CNTX,IEN,SDOUT,SDF)=0,SDPG=1
 D HDR
 ;search file #44 for invalid entries
 F  S IEN=$O(^SC(IEN)) Q:'IEN  D  Q:SDOUT  S:SDF CNTX=CNTX+1
 .S ECX=$G(^SC(IEN,0)),PSC=$P(ECX,U,7),SSC=$P(ECX,U,18),SDF=0
 .I $P(ECX,U,3)'="C" Q
 .S NAM=$P(ECX,U),IDAT=$G(^SC(IEN,"I")) I IDAT'="" D
 ..S IDT=$P(IDAT,U),RDT=$P(IDAT,U,2) Q:IDT=""  I RDT="" S NAM="*"_NAM Q
 ..I RDT>IDT S NAM="*"_NAM
 .S ACF=$S($E(NAM)="*":0,1:1)
 .I $S((SDPCF="A")&('ACF):1,(SDPCF="I")&(ACF):1,1:0) Q
 .S PSCN=$S(PSC:$P($G(^DIC(40.7,PSC,0)),U,2),1:"")
 .S SSCN=$S(SSC:$P($G(^DIC(40.7,SSC,0)),U,2),1:"")
 .D  I SDOUT Q
 ..I PSC="" S STR="Missing primary code" D PRN Q
 ..D SCCHK(PSC,"P") I $D(STR) D PRN
 .I SSC'="" D SCCHK(SSC,"S") I $D(STR) D PRN
 W !!,?25,$S(CNTX:CNTX,1:"NO")_" PROBLEM CLINICS FOUND."
 K SCIEN,TYP
 Q
 ;
PRN ;print line
 I ($Y+3)>IOSL D PAGE,HDR I SDOUT Q
 W !,IEN,?8,$E(NAM,1,28),?37,PSCN,?46,SSCN,?57,STR
 S SDF=1
 Q
 ;
SCCHK(SCIEN,TYP) ;check stop code against file 40.7; var INACT added SD*547
 N SCN,RTY,CTY,INACT
 K STR
 S CTY=$S(TYP="P":"^P^E^",1:"^S^E^")
 S SCN=$G(^DIC(40.7,SCIEN,0)),RTY=$P(SCN,U,6),INACT=$P(SCN,U,3),SCN=$P(SCN,U,2)
 I INACT S STR=SCN_" Inactivated "_$$FMTE^XLFDT(INACT,2) Q  ;SD*5.3*547
 I SCN="" D  Q
 .S STR=SCIEN_" Inv "_$S(TYP="P":"prim",1:"2nd")_" pointr"
 I RTY="" S STR=SCN_" No restriction type" Q
 I CTY'[("^"_RTY_"^") D
 .S STR=SCN_" cannot be "_$S(TYP="P":"prim",1:"second")_"ary"
 Q
 ;
HDR ;Header for data from file #44
 W @IOF
 W SDRDT,?73,"Page: ",SDPG,!
 W !,?18,"NON-CONFORMING CLINICS STOP CODE REPORT",!,?32
 W $S(SDPCF="A":"Active",SDPCF="I":"Inactive",1:"All")_" Clinics",!
 W !,"HOSPITAL LOCATION FILE (#44) - (Use Set up a Clinic [SDBUILD]"
 W " menu option to",!,?32,"make corrections)"
 W !!,?37,"PRIMARY",?46,"SECONDARY",?57,"REASON FOR"
 W !?8,$S(SDPCF="B":"CLINIC NAME",1:""),?37,"STOP",?46,"CREDIT",?57,"NON"
 W !,"IEN",?8,$S(SDPCF="B":"(*currently inactive)",1:"CLINIC NAME")
 W ?37,"CODE",?46,"STOP CODE",?57,"CONFORMANCE",!,$E(LNS,1,80)
 S SDPG=SDPG+1
 Q
 ;
PAGE ;
 N SS,JJ,DIR,X,Y
 I $E(IOST,1,2)="C-" D
 . S SS=22-$Y F JJ=1:1:SS W !
 . S DIR(0)="E" W ! D ^DIR K DIR I 'Y S SDOUT=1
 Q
