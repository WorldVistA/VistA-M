SCRPITP ;ALB/CMM - Individual Team Profile ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,52,177,520**;AUG 13, 1993;Build 26
 ;
 ;Individual Team Profile
 ;
PROMPTS ;
 ;Prompt for Institution, Team, and Print device
 ;
 N QTIME,PRNT,VAUTD,VAUTT,Y,NUMBER
 K VAUTD,VAUTT,SCUP
 S QTIME=""
 W ! D INST^SCRPU1 I Y=-1 G ERR
 W ! K Y D PRMTT^SCRPU1 I '$D(VAUTT) G ERR
 W !!,"This report requires 132 column output!"
 D QUE(.VAUTD,.VAUTT) Q
 ;
QUE(INST,TEAM) ;queue report
 ;Input Parameters: 
 ;INST - institutions selected (variable and array) 
 ;TEAM - teams selected (variable and array)
 N ZTSAVE,II
 F II="INST","TEAM","INST(","TEAM(" S ZTSAVE(II)=""
 W ! D EN^XUTMDEVQ("QENTRY^SCRPITP","Individual Team Profile",.ZTSAVE)
 Q
 ;
ENTRY2(INST,TEAM,IOP,ZTDTH) ;
 ;Second entry point for GUI to use
 ;Input Parameters:
 ;INST - institutions selected (variable and array)
 ;TEAM - teams selected (variable and array)
 ;IOP - print device
 ;ZTDTH - queue time (optional)
 ;
 ;validate parameters
 I '$D(INST)!'$D(TEAM)!'$D(IOP)!(IOP="") Q
 ;
 N NUMBER
 S IOST=$P(IOP,"^",2),IOP=$P(IOP,"^")
 I IOP?1"Q;".E S IOP=$P(IOP,"Q;",2)
 I IOST?1"C-".E D QENTRY G RET
 I ZTDTH="" S ZTDTH=$H
 S ZTRTN="QENTRY^SCRPITP"
 S ZTDESC="iIndividual Team Profile",ZTIO=IOP
 N II
 F II="INST","TEAM","INST(","TEAM(","IOP" S ZTSAVE(II)=""
 D ^%ZTLOAD
RET S NUMBER=0
 I $D(ZTSK) S NUMBER=ZTSK
 D EXIT1
 Q NUMBER
 ;
QENTRY ;
 ;driver entry point
 S TITL="Individual Team Profile"
 S STORE="^TMP("_$J_",""SCRPITP"")"
 K @STORE
 S @STORE=0
 I TEAM=1 D TALL^SCRPPAT3 S TEAM=0
 D FIND
 I $O(@STORE@(0))="" S NODATA=$$NODATA^SCRPU3(TITL)
 I '$D(NODATA) D PRINTIT(STORE,TITL)
 D EXIT2
 Q
 ;
ERR ;
EXIT1 ;
 K ZTDTH,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTSAVE
 Q
 ;
EXIT2 ;
 K @STORE
 K STOP,STORE,TITL,IOP,TEAM,INST,NODATA
 Q
 ;
FIND ;
 N TM,EN,NODE,TMP,TPNAME
 S TM="" K ^TMP("SCRATCH",$J)
 F  S TM=$O(^SCTM(404.57,"C",TM)) Q:TM=""  D
 .;$O through team position file
 .I '$D(TEAM(TM))&(TEAM'=1) Q
 .;Q above, not a selected team
 .;selected team
 .S EN=""
 .F  S EN=$O(^SCTM(404.57,"C",TM,EN)) Q:EN=""  D
 ..I '$D(^SCTM(404.57,EN,0)) Q
 ..S NODE=$G(^SCTM(404.57,EN,0))
 ..Q:NODE=""
 ..;active or inactive position
 ..S TMP=$$DATES^SCAPMCU1(404.59,EN,DT)
 ..S TPNAME=$P(NODE,U) S:'$L(TPNAME) TPNAME="~~~"
 ..S ^TMP("SCRATCH",$J,TPNAME,EN)=NODE
 ..I +TMP S ^TMP("SCRATCH",$J,TM,TPNAME,EN)=NODE
 ..Q
 .Q
 S TM=""
 F  S TM=$O(^TMP("SCRATCH",$J,TM)) Q:TM=""  S TPNAME="" D
 .F  S TPNAME=$O(^TMP("SCRATCH",$J,TM,TPNAME)) Q:TPNAME=""  S EN="" D
 ..F  S EN=$O(^TMP("SCRATCH",$J,TM,TPNAME,EN)) Q:EN=""  D
 ...S NODE=^TMP("SCRATCH",$J,TM,TPNAME,EN)
 ...D KEEP^SCRPITP2(NODE,EN,TM)
 ...Q
 ..Q
 .Q
 Q
 ;
PRINTIT(STORE,TITL) ;
 N INST,EINST,ETEAM,TEM,NEW,PAGE,TNAME,TIEN,EN,SUB,POS,CIEN,INF,ACL
 S (INST,EINST)="",STOP=0,(PAGE,NEW)=1 W:$E(IOST)="C" @IOF
 D FORHEAD^SCRPITP2
 F  S EINST=$O(@STORE@("I",EINST)) Q:EINST=""!(STOP)  D
 .S INST=$O(@STORE@("I",EINST,""))
 .I INST="" Q
 .I STOP Q
 .;write team info
 .S TNAME=""
 .F  S TNAME=$O(@STORE@("T",INST,TNAME)) Q:TNAME=""!(STOP)  D
 ..D:NEW TITLE^SCRPU3(.PAGE,TITL,132)
 ..I 'NEW,$E(IOST)'="C" D NEWP1^SCRPU3(.PAGE,TITL,132)
 ..I 'NEW,$E(IOST)="C" D HOLD^SCRPU3(.PAGE,TITL,132)
 ..W !,$G(@STORE@(INST)),! S NEW=""
 ..S TIEN=$O(@STORE@("T",INST,TNAME,""))
 ..I TIEN="" Q
 ..F SUB="TI","D" D
 ...Q:STOP
 ...I '$D(@STORE@(INST,TIEN,SUB)) Q
 ...S EN=""
 ...F  S EN=$O(@STORE@(INST,TIEN,SUB,EN)) Q:EN=""!(STOP)  D
 ....I IOST'?1"C-".E,$Y>(IOSL-5) D NEWP1^SCRPU3(.PAGE,TITL,132)
 ....I IOST?1"C-".E,$Y>(IOSL-5) D HOLD^SCRPU3(.PAGE,TITL,132)
 ....I STOP Q
 ....I '$D(NEW) W !,$G(@STORE@(INST)),!,$G(@STORE@(INST,TIEN)),!
 ....W !,$G(@STORE@(INST,TIEN,SUB,EN))
 ...W !
 ..;write position info
 ..S POS=""
 ..I $Y<IOSL-10 D COLUMN^SCRPITP2
 ..F  S POS=$O(@STORE@(INST,TIEN,"P",POS)) Q:POS=""!(STOP)  D
 ...W !,$G(@STORE@(INST,TIEN,"P",POS))
 ...S ACL=""
 ...F  S ACL=$O(@STORE@(INST,TIEN,"P",POS,ACL)) Q:ACL=""!(STOP)  D
 ....W !,$G(@STORE@(INST,TIEN,"P",POS,ACL))
 ....I IOST'?1"C-".E,$Y>(IOSL-5) D NEWP1^SCRPU3(.PAGE,TITL,132) Q:STOP  D CONT^SCRPITP2
 ....I IOST?1"C-".E,$Y>(IOSL-5) D HOLD^SCRPU3(.PAGE,TITL,132) Q:STOP  D CONT^SCRPITP2
 ....I STOP Q
 ...;W !,$G(@STORE@(INST,TIEN,"P",POS))
 ...;W !,$G(@STORE@(INST,TIEN,"P",POS,ACL))
 ...W !
 I 'STOP,$E(IOST)="C" N DIR S DIR(0)="E" W ! D ^DIR
 Q
