RORREP01 ;HOIFO/BH - REGISTRY COMPARISON REPORT ; 12/21/05 11:55am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ;--------------------------------------------------------------------
 ; Registry: [VA HIV]
 ;--------------------------------------------------------------------
 ;
 Q
 ;
BEGIN ;
 I '$$VFILE^DILFD(158)  D  Q
 . W !,"ICR v2.1 is not installed in this account!",!
 I '$D(^XUSEC("IMRA",DUZ)) S IMRLOC="RORREP01" D ACESSERR^IMRERR,H^XUS K IMRLOC
 ;
 W !,?10,"####################################################"
 W !,?10,"#",?20,"Local ICR Version Comparison Report      #",?61
 W !,?10,"####################################################"
 ;
 ;
DEV D IMRDEV^IMREDIT
 G:POP KILL
 I '$D(IO("Q")) W @IOF D REP Q
 I $D(IO("Q")) D  G KILL
 . S ZTRTN="REP^RORREP01",ZTDESC="Local ICR Version Comparison Report"
 . S ZTSAVE("*")="",ZTIO=ION_";"_IOM_";"_IOSL
 . D ^%ZTLOAD K ZTRTN,ZTDESC,ZTSAVE,ZTSK
 . Q
 ;
REP ; Get Data
 U IO
 D EN1
 K CNT
 ;
 D PRNT^RORREP02
CLOSE D ^%ZISC K %ZIS,IOP
 S:$D(ZTQUEUED) ZTREQ="@"
 ;
 ;
KILL D ^%ZISC
 K ^TMP("RORREP01",$J)
 K DTOUT,VAROOT,VAERR,A,DIRUT,I,J,POP,X,X0,X1,Y,Z,D,IMRDTE,IMRFLG,IMRHED,IMRRPG,%I,DISYS,IMRPG
 D HOME^%ZIS
 Q
 ;
 ; ---------------------------------------------------------------------
EN1 ;
 K ^TMP("RORREP01",$J)
 S CNT=0
 D VTHREE
 D VTWO
 ;
 D INTWO
 D INTHREE
 Q
 ;
VTHREE ; Make array of version 3 patients 
 N ICN,IDSC,NAME,RC,PAT
 K VTHREE
 S RC=$$PATITER^RORAPI01(.IDSC,"VA HIV")
 I RC<0 Q
 F  S RC=$$NEXTPAT^RORAPI01(.IDSC)  Q:RC'>0  D
 . S PAT=+RC
 . S ^TMP("RORREP01",$J,"VTHREE",PAT)=""
 . S ICN=$$GETICN^MPIF001(PAT)
 . Q:$L(ICN)'=9
 . S NAME=$P(^DPT(PAT,0),"^",1)
 . S ^TMP("RORREP01",$J,"ICN",NAME,PAT)=""
 Q
 ;
 ;
VTWO ; Make array of version 2.1 patients
 N ENCODE,PAT,IMRIEN
 S IMRIEN=0
 F  S IMRIEN=$O(^IMR(158,IMRIEN)) Q:'IMRIEN  D
 . S ENCODE=$P(^IMR(158,IMRIEN,0),U)
 . I ENCODE="" D  Q
 . . S CNT=CNT+1
 . . S ^TMP("RORREP01",$J,"ERROR","ENCODE",CNT)="Entry "_IMRIEN_" in file #158 does not have .01 field." Q
 . S PAT=$$XOR^RORUTL03(ENCODE)
 . I PAT=0!(PAT="") D  Q
 . . S CNT=CNT+1
 . . S ^TMP("RORREP01",$J,"ERROR","ENCODE",CNT)="Could not decode .01 field "_ENCODE_" of file #158."
 . ;
 . I $D(^DPT(PAT,-9)) D  Q
 . . N NEWIEN
 . . S NEWIEN=^DPT(PAT,-9)
 . . I NEWIEN="" Q
 . . I $D(^TMP("RORREP01",$J,"PROC",NEWIEN)) Q
 . . S ^TMP("RORREP01",$J,"MERGE",NEWIEN)=ENCODE
 . ;
 . I $$GET1^DIQ(2,PAT,.01)="" D  Q
 . . S CNT=CNT+1
 . . S ^TMP("RORREP01",$J,"ERROR","ENCODE",CNT)="Could not get patient name from patient file IEN "_PAT Q
 . ;
 . D VTWO1(PAT,ENCODE)
 ;
 I $D(^TMP("RORREP01",$J,"MERGE")) D
 . N ENC,SUB4 S SUB4=0
 . F  S SUB4=$O(^TMP("RORREP01",$J,"MERGE",SUB4)) Q:SUB4=""  D
 . . S ENC=^TMP("RORREP01",$J,"MERGE",SUB4)
 . . D VTWO1(SUB4,ENC)
 ;
 K ^TMP("RORREP01",$J,"PROC"),^TMP("RORREP01",$J,"MERGE")
 Q
 ;
VTWO1(PAT,ENCODE) ;
 N ICN,SSN
 I $$GET1^DIQ(2,PAT,.01)="" D  Q
 . S CNT=CNT+1
 . S ^TMP("RORREP01",$J,"ERROR","ENCODE",CNT)="Could not get file #2 entry for entry "_ENCODE_" of file #158."
 ;
 S ^TMP("RORREP01",$J,"PROC",PAT)=""
 S ^TMP("RORREP01",$J,"VTWO",PAT)=ENCODE
 I PAT=7202138 W ENCODE_"***"
 S ICN=$$GETICN^MPIF001(PAT)
 Q:$L(ICN)'=9
 S NAME=$P(^DPT(PAT,0),"^",1)
 S SSN=$$GET1^DIQ(2,PAT,.09),SSN=$E(SSN,6,9)
 S ^TMP("RORREP01",$J,"ICN",NAME,PAT)=SSN
 Q
 ;
INTWO ; Patients in version 2.1 and not in three or in both
 N IEN,NAME,DATE21,RULE,SSN S IEN=0
 F  S IEN=$O(^TMP("RORREP01",$J,"VTWO",IEN)) Q:IEN=""  D
 . S NAME=$$GET1^DIQ(2,IEN,.01)
 . S SSN=$$GET1^DIQ(2,IEN,.09),SSN=$E(SSN,6,9)
 . S DATE21=$$DATE21(^TMP("RORREP01",$J,"VTWO",IEN))
 . I '$D(^TMP("RORREP01",$J,"VTHREE",IEN)) D  Q
 . . S ^TMP("RORREP01",$J,"INTWO",NAME)=DATE21_"^"_SSN
 . S RULE=$$RULE(IEN) I RULE=0 Q
 . S ^TMP("RORREP01",$J,"INBOTH",NAME)=RULE_"^"_DATE21_"^"_SSN
 Q
 ;
 ;
INTHREE ; Patients in version 3.0 and not in two OR in both
 N DATE21,RULE,IEN,PENDING,NAME,SSN S IEN=0
 F  S IEN=$O(^TMP("RORREP01",$J,"VTHREE",IEN)) Q:IEN=""  D
 . S NAME=$$GET1^DIQ(2,IEN,.01)
 . S SSN=$$GET1^DIQ(2,IEN,.09),SSN=$E(SSN,6,9)
 . I NAME="" S CNT=CNT+1,^TMP("RORREP01",$J,"ERROR","ROR",CNT)="Can't find Name from patient (#2) file IEN "_IEN_"." Q
 . ;
 . S RULE=$$RULE(IEN) I RULE=0 Q
 . I '$D(^TMP("RORREP01",$J,"VTWO",IEN)) D  Q
 . . S PENDING=$$PEND(IEN)
 . . S ^TMP("RORREP01",$J,"INTHREE",NAME)=RULE_"^"_PENDING_"^"_SSN
 . S DATE21=$$DATE21(^TMP("RORREP01",$J,"VTWO",IEN))
 . S ^TMP("RORREP01",$J,"INBOTH",NAME)=RULE_"^"_DATE21_"^"_SSN
 Q
 ;
 ;
DATE21(ENCODE) ; Get date added to ICR 2.1
 N IMRCAT1,IMRCAT2,IMRCAT3,IMRCAT4,IMRNODE,IMRIEN,IMRDTE,IMRARR
 S IMRIEN=0
 S IMRIEN=$O(^IMR(158,"B",ENCODE,IMRIEN))
 S IMRNODE=^IMR(158,IMRIEN,0)
 S IMRCAT1=$P(IMRNODE,"^",36) I IMRCAT1'="" S IMRARR(IMRCAT1)=""
 S IMRCAT2=$P(IMRNODE,"^",44) I IMRCAT2'="" S IMRARR(IMRCAT2)=""
 S IMRCAT3=$P(IMRNODE,"^",35) I IMRCAT3'="" S IMRARR(IMRCAT3)=""
 S IMRCAT4=$P(IMRNODE,"^",23) I IMRCAT4'="" S IMRARR(IMRCAT4)=""
 I '$D(IMRARR) Q "No Cat. Date"
 S IMRDTE=""
 S IMRDTE=$O(IMRARR(IMRDTE))
 S Y=IMRDTE D DD^%DT S IMRDTE=Y
 Q IMRDTE
 ;
 ;
PEND(IEN) ;
 N RORIEN,PEND
 S RORIEN="",PEND="YES"
 S RORIEN=$O(^RORDATA(798,"KEY",IEN,2,RORIEN))
 S RES=$P(^RORDATA(798,RORIEN,0),"^",5)
 I RES'=4 S PEND="NO"
 Q PEND
 ;
 ;
RULE(IEN) ; Get earliest selction rule 
 N RORIEN
 S RORIEN=""
 S RORIEN=$O(^RORDATA(798,"KEY",IEN,2,RORIEN))
 I 'RORIEN D  Q 0
 . S CNT=CNT+1
 . S ^TMP("RORREP01",$J,"ERROR","ROR",CNT)="Can't find IEN of file #798 record that has a #.01 field of "_IEN_"." Q
 ;
 N RULE1,DATE1,SELARR,RORSRIEN,SELDATE,DATA,RULE
 S RORSRIEN=0
 F  S RORSRIEN=$O(^RORDATA(798,RORIEN,1,RORSRIEN)) Q:'RORSRIEN  D
 . S DATA=^RORDATA(798,RORIEN,1,RORSRIEN,0)
 . S RULE=$P(DATA,"^",1)
 . S RULE=$$GET1^DIQ(798.2,RULE,.01,"E")
 . S SELDATE=$P(DATA,"^",2)
 . S SELARR(SELDATE)=RULE
 ;
 I '$D(SELARR) D  Q 0
 . S CNT=CNT+1
 . N BUFF,EVID,NME
 . S NME=$$GET1^DIQ(798,RORIEN,.01,"E")
 . ;
 . S EVID=$P(^RORDATA(798,RORIEN,0),U,14)
 . I 'EVID D
 . . S BUFF=NME_" is in ROR Local Registry file (#798) but has no selection rules."
 . . S ^TMP("RORREP01",$J,"ERROR",IEN)=BUFF
 . I EVID D
 . . S ^TMP("RORREP01",$J,"ISSUE","EVID",IEN)=NME
 S DATE1="" S DATE1=$O(SELARR(DATE1))
 S RULE1=SELARR(DATE1)
 S Y=DATE1 D DD^%DT S DATE1=Y
 Q DATE1_"^"_RULE1
 ;
 ;
