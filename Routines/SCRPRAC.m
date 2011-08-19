SCRPRAC ;ALB/CMM - Practitioner Demographics ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,52,177**;AUG 13, 1993
 ;
 ;Practitioner Demographics Report
 ;
PROMPTS ;
 ;Prompt for Practioner and Print device
 ;
 K SCUP
 N QTIME,PRNT,VAUTP,Y,VAUTCI,NUMBER
 S QTIME=""
 ;S VAUTPO="" ;only can select one practitioner
 S VAUTNA="" ;all not allowed
 S VAUTT=1 ;all teams
 W ! D PRACT^SCRPU1
 I '$D(VAUTP) G ERR
 D QUE(.VAUTP) Q
 ;
QUE(PRACT) ;queue report
 ;Input: PRACT=array of providers
 N ZTSAVE,II
 F II="PRACT(","PRACT" S ZTSAVE(II)=""
 W ! D EN^XUTMDEVQ("QENTRY^SCRPRAC","Practitioner Demographics",.ZTSAVE)
 Q
 ;
ENTRY2(PRACT,IOP,ZTDTH) ;
 ;Second entry point for GUI to use
 ;Input Parameters:
 ;PRACT - practitioner ien new person file
 ;IOP - print device
 ;ZTDTH - queue time (optional)
 ;
 ;validate parameters
 I '$D(PRACT)!'$D(IOP)!(IOP="") Q
 ;
 N NUMBER
 S IOST=$P(IOP,"^",2),IOP=$P(IOP,"^")
 I IOP?1"Q;".E S IOP=$P(IOP,"Q;",2)
 I IOST?1"C-".E D QENTRY G RET
 I ZTDTH="" S ZTDTH=$H
 S ZTRTN="QENTRY^SCRPRAC"
 S ZTDESC="Practitioner Demographics",ZTIO=IOP
 N II
 F II="PRACT(","PRACT","IOP" S ZTSAVE(II)=""
 D ^%ZTLOAD
RET S NUMBER=0
 I $D(ZTSK) S NUMBER=ZTSK
 D EXIT1
 Q NUMBER
 ;
QENTRY ;
 ;driver entry point
 S TITL="Practitioner Demographics"
 S STORE="^TMP("_$J_",""SCRPRAC"")"
 K @STORE
 S @STORE=0
 D DRIVE
 I $O(@STORE@(0))="" S NODATA=$$NODATA^SCRPU3(TITL)
 I '$D(NODATA) D PRINTIT(STORE,TITL)
 D EXIT2
 Q
 ;
ERR ;
EXIT1 ;
 K ZTDTH,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE,VAUTPO,VAUTT,VAUTP,SCUP,VAUTNA
 Q
 ;
EXIT2 ;
 K @STORE
 K STORE,TITL,IOP,PRACT,NODATA,STOP
 Q
 ;
DRIVE ;
 ;driver module
 N PRAC,INF,ARRY,ERROR
 S ARRY="ARRAY",ERROR="ERR"
 K @ARRY,@ERROR
 S PRAC=0 F  S PRAC=$O(PRACT(PRAC)) Q:PRAC=""  D
 .S INF=$$TPPR^SCAPMC12(PRAC,,,,ARRY,ERROR) ;get practitioner positions
 .I INF=0 Q
 .D GATHER^SCRPRAC2(.ARRY,PRAC)
 .K @ERROR,@ARRY
 Q
 ;
PRINTIT(STORE,TITL) ;
 N PNAME,PIEN,PAGE,STOP,NEW,SCI
 S PNAME="",(NEW,PAGE)=1,STOP=0 W:$E(IOST)="C" @IOF
 F  S PNAME=$O(@STORE@(PNAME)) Q:PNAME=""!(STOP)  S PIEN=0 D
 .F  S PIEN=$O(@STORE@(PNAME,PIEN)) Q:'PIEN!(STOP)  D
 ..I NEW D TITLE^SCRPU3(.PAGE,TITL)
 ..;I 'NEW,$E(IOST)="C" D HOLD^SCRPU3(.PAGE,TITL)
 ..;I 'NEW,$E(IOST)'="C" 
 ..I 'NEW D NEWP1^SCRPU3(.PAGE,TITL)
 ..Q:STOP  S (NEW,SCI)=0
 ..F  S SCI=$O(@STORE@(PNAME,PIEN,SCI)) Q:'SCI!(STOP)  D
 ...I $E(IOST)="C",$Y>(IOSL-3) D HOLD^SCRPU3(.PAGE,TITL) Q:STOP  D CONT
 ...I $E(IOST)'="C",$Y>(IOSL-3) D NEWP1^SCRPU3(.PAGE,TITL) Q:STOP  D CONT
 ...W !,@STORE@(PNAME,PIEN,SCI)
 ...Q
 ..I $E(IOST)="C" N DIR S DIR(0)="E" W ! D ^DIR S STOP=Y'=1
 ..Q
 .Q
 Q
 ;
CONT W !,"Provider '",PNAME,"' continued...",! Q
