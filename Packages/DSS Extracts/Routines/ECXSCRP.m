ECXSCRP ;ALB/JAM - Restricted Stop Code Nonconforming Clinic Report; 07/24/03 ;2/11/14  16:56
 ;;3.0;DSS EXTRACTS;**57,58,120,126,144,149,154**;Dec 22, 1997;Build 13
 ;
EN ;foreground entry point
 N ZTRTN,ZTDESC,ZTIO,ZTQUEUED,DIR,DIRUT,X,Y,ECX,ECXSD,PSC,SSC,ECXPCF,ECXPORT,CNT ;144
 W @IOF
 W !,"This option reviews the Primary and Secondary Stop Codes and any existing Four" ;144
 W !,"Character Codes in the Clinics and Stop Codes file #728.44." ;144
 W !,"It produces a report highlighting any nonconformance reasons that pertain" ;144
 W !,"to the Primary and Secondary Codes, or the Four Character Codes if present." ;144
 W !,"Please contact the responsible party for corrective action." ;144
 S DIR(0)="SO^A:Active Clinics;I:Inactive Clinics;B:Both"
 S DIR("A")="Select Report"
 S DIR("?",1)="Enter an A for Active Clinics, I for Inactive Clinics,"
 S DIR("?")="B for Both Active and Inactive Clinics"
 D ^DIR K DIR I $D(DIRUT) G END
 S ECXPCF=Y
 W !,"Please be patient, this may take a few moments..." ;144
 ;Synch primary & secondary stop codes from file #44 with #728.44
 S ECX=0 F  S ECX=$O(^ECX(728.44,ECX)) Q:'ECX  D FIX^ECXSCLD(ECX)
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I ECXPORT D  Q  ;144
 .K ^TMP($J,"ECXPORT") ;144
 .S ^TMP($J,"ECXPORT",0)="IEN^CLINIC NAME^STOP CODE^CREDIT STOP CODE^CHAR4 CODE^REASON FOR NON-CONFORMANCE" ;144,149;154
 .S CNT=1 ;144
 .D PROCESS ;144
 .D EXPDISP^ECXUTL1 ;144
 ;device selection
 W !!,"** REPORT REQUIRES 132 COLUMNS TO PRINT CORRECTLY **",!! ;144 CVW
 K IOP,%ZIS,POP,IO("Q")
 ;S %ZIS("A")="Select Device: ",%ZIS="QM" D ^%ZIS I POP G END
 S %ZIS="",%ZIS("B")="0;132;99999" D ^%ZIS I POP G END
 I $D(IO("Q")) K IO("Q") D  G END
 .S ZTDESC="Restricted Stop Code Report",ZTSAVE("ECXPCF")="" ;154
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
 N INDT,TYP,ACF,HTYP,CLNF,ECXRDT,NCODE,%H ;144
 S %H=$H D YX^%DTC S ECXRDT=Y
 S $P(LNS,"-",132)="",(CNTX,IEN,ECXOUT,ECXF)=0,ECXPG=1,CLNF=0
 ;search file #728.44 for invalid stop code entries
 D:'$G(ECXPORT) HDR S IEN=0 ;144
 F  S IEN=$O(^ECX(728.44,IEN)) Q:'IEN  D  Q:ECXOUT  S:ECXF CNTX=CNTX+1
 .I $P($G(^SC(IEN,0)),U,3)'="C" Q  ;149 If entry isn't a clinic, don't include it on report
 .S ECX=$G(^ECX(728.44,IEN,0)),PSC=$P(ECX,U,2),SSC=$P(ECX,U,3),CLNF=0
 .S DPC=$P(ECX,U,4),DSC=$P(ECX,U,5),NAM=$$GET1^DIQ(44,$P(ECX,U),.01)
 .S INDT=$P(ECX,U,10),ECXF=0 I INDT'="" S NAM="*"_NAM
 .S ACF=$S($E(NAM)="*":0,1:1),HTYP=$$GET1^DIQ(44,$P(ECX,U),2,"I")
 .S NCODE=$$GET1^DIQ(728.441,$P(ECX,U,8),.01) ;144 cvw 
 .I $S((ECXPCF="A")&('ACF):1,(ECXPCF="I")&(ACF):1,1:0) Q
 .D  I ECXOUT Q
 ..I PSC="" S STR="Missing primary code" D PRN Q
 ..D SCCHK(PSC,"P") I $D(STR) D PRN
 .I SSC'="" D SCCHK(SSC,"S") I $D(STR) D PRN
 .D  I ECXOUT Q 
 ..;I DPC="" S STR="No DSS primary code" D PRN Q ;154
 ..;I DPC'=PSC D SCCHK(DPC,"P") I $D(STR) D PRN
 .;I DSC'="",DSC'=SSC D SCCHK(DSC,"S") I $D(STR) D PRN
 .D  I ECXOUT Q  ;144 cvw
 ..I ($P(ECX,U,8)'="")&(NCODE="") S NCODE=$P(ECX,U,8),STR="CHAR4 Code invalid" D PRN Q  ;144,149 cvw
 ..I $$GET1^DIQ(728.441,$P(ECX,U,8),3)'="" S STR="CHAR4 Code inactive" D PRN Q  ;144,149 cvw 
 I '$G(ECXPORT) W !!,?25,$S(CNTX:CNTX,1:"NO")_" PROBLEM CLINICS FOUND." ;144
 Q
PRN ;print line
 Q:CLNF  I HTYP'="C" S STR="Not a Clinic" S CLNF=1
 I $G(ECXPORT) S ^TMP($J,"ECXPORT",CNT)=IEN_"^"_NAM_"^"_PSC_"^"_SSC_"^"_NCODE_"^"_STR,CNT=CNT+1 Q  ;154
 I ($Y+3)>IOSL D PAGE,HDR I ECXOUT Q
 W !,IEN,?14,$E(NAM,1,24),?48,PSC,?58,SSC,?75,NCODE,?91,STR ;CVW 149
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
 .I INACT>DT S STR=SCIEN_" Inactive in future"
 .E  S STR=SCIEN_" Code is inactive"
 I $P(SCN,U,2)="" S STR="No pointer in file #40.7" Q
 I RTY="" S STR=SCIEN_" No restriction type" Q
 I CTY'[("^"_RTY_"^") D
 .S STR=SCIEN_" Cannot be "_$S(TYP="P":"prim",1:"second")_"ary"
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
 W !,?18,"STOP CODE NON-CONFORMING CLINICS REPORT",!,?32
 W $S(ECXPCF="A":"Active",ECXPCF="I":"Inactive",1:"All")_" Clinics",!
 W !,"CLINICS AND STOP CODES File (#728.44) - (Use 'Enter/Edit DSS "
 W "Stop Codes for",!,?25,"Clinics' [ECXSCEDIT] menu option to "
 W "make corrections)",!! ;CVW 149
 W "IEN #",?14,$S(ECXPCF="B":"(*currently inactive)",1:"CLINIC NAME")
 W ?48,"STOP",?58,"CREDIT",?75,"CHAR4",?91,"REASON FOR NON-"
 W !,?48,"CODE",?58,"STOP CODE",?75,"CODE",?91,"CONFORMANCE"
 W !,$E(LNS,1,132)
 S ECXPG=ECXPG+1
 Q
