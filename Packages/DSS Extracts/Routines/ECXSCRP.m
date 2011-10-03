ECXSCRP ;ALB/JAM - Restricted Stop Code Nonconforming Clinic Report; 07/24/03 ; 9/24/09 10:57am
 ;;3.0;DSS EXTRACTS;**57,58,120,126**;Dec 22, 1997;Build 7
 ;
EN ;foreground entry point
 N ZTRTN,ZTDESC,ZTIO,ZTQUEUED,DIR,DIRUT,X,Y,ECX,ECXSD,PSC,SSC,ECXPCF
 W @IOF
 W !,"This option synchronizes the Primary and Secondary Stop Codes in the Clinics"
 W !,"and Stop Codes File #728.44 with those in the Hospital Location File #44."
 W !,"It produces a report highlighting any non conformance reasons that pertain"
 W !,"to the Primary and Secondary Codes. Please contact the responsible party"
 W !,"for corrective action."
 S DIR(0)="SO^A:Active Clinics;I:Inactive Clinics;B:Both"
 S DIR("A")="Select Report"
 S DIR("?",1)="Enter an A for Active Clinics, I for Inactive Clinics,"
 S DIR("?")="B for Both Active and Inactive Clinics"
 D ^DIR K DIR I $D(DIRUT) G END
 S ECXPCF=Y
 W ".  Please be patient, this may take a few moments..."
 ;Synch primary & secondary stop codes from file #44 with #728.44
 S ECX=0 F  S ECX=$O(^ECX(728.44,ECX)) Q:'ECX  D FIX^ECXSCLD(ECX)
 ;device selection
 K IOP,%ZIS,POP,IO("Q")
 S %ZIS("A")="Select Device: ",%ZIS="QM" D ^%ZIS I POP G END
 I $D(IO("Q")) K IO("Q") D  G END
 .S ZTDESC="Restricted Stop Code/DSS Identifier Report",ZTSAVE("ECXPCF")=""
 .S ZTRTN="PROCESS^ECXSCRP",ZTIO=ION D ^%ZTLOAD,HOME^%ZIS K ZTSK
 U IO
 D PROCESS
END D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PROCESS ;background entry point
 ;locate invalid Stop Code in HOSPITAL LOCATION file #44 & CLINICS
 ;AND STOP CODES file #728.44
 N ECX,NAM,STR,IEN,PSC,SSC,CNTX,ECXPG,ECXOUT,LNS,DPC,DSC,SCIEN,ECXF
 N INDT,TYP,ACF,HTYP,CLNF,ECXRDT
 S %H=$H D YX^%DTC S ECXRDT=Y
 S $P(LNS,"-",80)="",(CNTX,IEN,ECXOUT,ECXF)=0,ECXPG=1,CLNF=0
 ;search file #728.44 for invalid stop code entries
 D HDR S IEN=0
 F  S IEN=$O(^ECX(728.44,IEN)) Q:'IEN  D  Q:ECXOUT  S:ECXF CNTX=CNTX+1
 .S ECX=$G(^ECX(728.44,IEN,0)),PSC=$P(ECX,U,2),SSC=$P(ECX,U,3),CLNF=0
 .S DPC=$P(ECX,U,4),DSC=$P(ECX,U,5),NAM=$$GET1^DIQ(44,$P(ECX,U),.01)
 .S INDT=$P(ECX,U,10),ECXF=0 I INDT'="" S NAM="*"_NAM
 .S ACF=$S($E(NAM)="*":0,1:1),HTYP=$$GET1^DIQ(44,$P(ECX,U),2,"I")
 .I $S((ECXPCF="A")&('ACF):1,(ECXPCF="I")&(ACF):1,1:0) Q
 .D  I ECXOUT Q
 ..I PSC="" S STR="Missing primary code" D PRN Q
 ..D SCCHK(PSC,"P") I $D(STR) D PRN
 .I SSC'="" D SCCHK(SSC,"S") I $D(STR) D PRN
 .D  I ECXOUT Q 
 ..I DPC="" S STR="No DSS primary code" D PRN Q
 ..I DPC'=PSC D SCCHK(DPC,"P") I $D(STR) D PRN
 .I DSC'="",DSC'=SSC D SCCHK(DSC,"S") I $D(STR) D PRN
 W !!,?25,$S(CNTX:CNTX,1:"NO")_" PROBLEM CLINICS FOUND."
 Q
PRN ;print line
 Q:CLNF  I HTYP'="C" S STR="Not a Clinic" S CLNF=1
 I ($Y+3)>IOSL D PAGE,HDR I ECXOUT Q
 W !,IEN,?8,$E(NAM,1,24),?33,PSC,?38,SSC,?45,DPC,?50,DSC,?57,STR
 S ECXF=1
 Q
 ;
SCCHK(SCIEN,TYP) ;check stop code against file 40.7
 N SCN,RTY,CTY,SCI,INACT,ARRY,I,FLG
 K STR
 S CTY=$S(TYP="P":"^P^E^",1:"^S^E^")
 D SCIEN(SCIEN) I SCI="" D  Q
 .;S SCI=$$SCIEN(SCIEN) I SCI="" D  Q
 .I TYP="S" Q:SSC=PSC  Q:DSC=DPC
 .S STR=SCIEN_" Invalid Stop Code"
 S SCN=$G(^DIC(40.7,SCI,0)),RTY=$P(SCN,U,6),INACT=$P(SCN,U,3)
 I INACT D  Q
 .I INACT>DT S STR=SCIEN_" inactive in future"
 .E  S STR=SCIEN_" code is inactive"
 I $P(SCN,U,2)="" S STR="No pointer in file #40.7" Q
 I RTY="" S STR=SCIEN_" No restriction type" Q
 I CTY'[("^"_RTY_"^") D
 .S STR=SCIEN_" cannot be "_$S(TYP="P":"prim",1:"second")_"ary"
 Q
PAGE ;
 N SS,JJ,DIR,X,Y
 I $E(IOST,1,2)="C-" D
 . S SS=22-$Y F JJ=1:1:SS W !
 . S DIR(0)="E" W ! D ^DIR K DIR I 'Y S ECXOUT=1
 Q
 ;
SCIEN(SCIEN) ;Get stop code IEN
 I SCIEN="" Q ""
 ;S SCIEN=$O(^DIC(40.7,"C",SCIEN,0))
 ;Q SCIEN
 ;find active code if one
 S SCI=$O(^DIC(40.7,"C",SCIEN,0))
 I $O(^DIC(40.7,"C",SCIEN,SCI))'>0 Q
 ;must be some duplicates so find the best one
 S I=""
 F  S I=$O(^DIC(40.7,"C",SCIEN,I)) Q:'I  D
 . Q:'$D(^DIC(40.7,I,0))
 . S INACT=$P(^DIC(40.7,I,0),"^",3),FLG="A" D
 . . I INACT,((DT>INACT)!(DT=INACT)) S FLG="I"
 . S ARRY(FLG,I)=""
 I $D(ARRY("A")) S SCI=$O(ARRY("A",0))
 Q SCIEN
 ;
HDR ;header for data from file #728.44
 W @IOF
 W ECXRDT,?73,"Page: ",ECXPG,!
 W !,?18,"DSS IDENTIFIER NON-CONFORMING CLINICS REPORT",!,?32
 W $S(ECXPCF="A":"Active",ECXPCF="I":"Inactive",1:"All")_" Clinics",!
 W !,"CLINICS AND STOP CODES File (#728.44) - (Use 'Enter/Edit DSS "
 W "Stop Codes for",!,?25,"Clinics' [ECXSCEDIT] menu option to "
 W "make corrections)",!!,?45,"DSS",?50,"DSS"
 W !,?33,"PRIM",?38,"2NDARY",?45,"PRIM",?50,"2NDARY"
 W !,?8,$S(ECXPCF="B":"CLINIC NAME",1:""),?33,"STOP",?38,"CREDIT"
 W ?45,"STOP",?50,"CREDIT",?57,"REASON FOR NON-",!
 W "IEN #",?8,$S(ECXPCF="B":"(*currently inactive)",1:"CLINIC NAME")
 W ?33,"CODE",?38,"CODE",?45,"CODE",?50,"CODE",?57,"CONFORMANCE"
 W !,$E(LNS,1,80)
 S ECXPG=ECXPG+1
 Q
