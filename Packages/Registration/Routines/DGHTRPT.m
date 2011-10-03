DGHTRPT ;ALB/JRC - Home Telehealth Transmissions Report ; 1/9/06 9:22am
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;
EN ;entry point from option
 ;Declare variable(s) and arrays
 N DGSD,DGED,I,SCANARR,MSGSTAT,FLAG
 N ZTDESC,ZTIO,ZTSAVE
 S FLAG=""
 ;Prompt for starting and ending date
 D GETDATES^DGHTRPT1 Q:FLAG
 ;Get ACK status
 D GETSTAT Q:FLAG
 ;Get coordinator(s)
 D GETCOOR Q:FLAG
 ;Queue Report
 S ZTIO=""
 S ZTDESC="Home Telehealth Transmission Report"
 F I="DGSD","DGED","SCANARR","MSGSTAT" S ZTSAVE(I)=""
 D EN^XUTMDEVQ("EN1^DGHTRPT",ZTDESC,.ZTSAVE)
 Q
 ;
EN1 ;Tasked entry point
 ;Input : DGSD  -  FM format report start date
 ;        DGED   -  FM format report end date
 ;
 ;Output : None
 ;
 ;Declare variables
 N DGSD1,DGED1,STOP,CNT,LN,PAGENUM,SCRNARR
 S DGED1=DGED+.9999,DGSD1=DGSD-.0001,(CNT,PAGENUM,STOP)=0
 S SCRNARR="^TMP(""DGHT"",$J,""SCRNARR"")"
 K @SCRNARR
 M @SCRNARR@("PROVIDERS")=SCANARR
 D HEADER
 D GETDATA
 I 'CNT D  Q
 .W !
 .W !,"***********************************************"
 .W !,"*  NOTHING TO REPORT FOR SELECTED TIME FRAME  *"
 .W !,"***********************************************"
 .D WAIT
 D DETAIL I STOP D EXIT Q
 D TOTAL
 D EXIT
 Q
 ;
GETSTAT ;Prompt for message status to report
 N DIR,X,Y
 S DIR(0)="SC^1:ALL;2:ACCEPTED;3:REJECTED"
 S DIR("A")="Select message status for report"
 D ^DIR
 I $D(DIRUT) S FLAG=1 Q
 S MSGSTAT=Y
 Q
 ;
GETCOOR ;Prompt for coordinator(s)
 N DIC,VAUTSTR,VAUTVB,VAUTNI,Y
 ;Get provider selection
 S DIC="^VA(200,"
 S VAUTSTR="CARE COORDINATOR"
 S VAUTVB="SCANARR"
 S VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 S FLAG=1 Q
 Q
 ;
GETDATA ;Get data
 ;Declare variables
 N PATIENT,SSN,VENDOR,COORD,CONSULT,DATE,MSGID,ACKDATE,STATUS,REJECT
 N MSGTYPE,STATUS,DGDA0,DGDA1,DG0,DG1
 F  S DGSD1=$O(^DGHT(391.31,"C",DGSD1)) Q:(DGSD1>DGED1)!('DGSD1)  D
 .S DGDA0=0
 .F  S DGDA0=$O(^DGHT(391.31,"C",DGSD1,DGDA0)) Q:'DGDA0  D
 ..S DGDA1=0
 ..F  S DGDA1=$O(^DGHT(391.31,"C",DGSD1,DGDA0,DGDA1)) Q:'DGDA1  D
 ...;Get data node and increment conunter
 ...S DG0=$G(^DGHT(391.31,DGDA0,0))
 ...Q:DG0=""
 ...S DG1=$G(^DGHT(391.31,DGDA0,"TRAN",DGDA1,0))
 ...Q:DG1=""
 ...S PATIENT=$P(DG0,U,2),VENDOR=$P(DG0,U,3),CONSULT=$P(DG0,U,4)
 ...S COORD=$P(DG0,U,5),DATE=$P(DG1,U,1),MSGID=$P(DG1,U,2)
 ...S ACKDATE=$P(DG1,U,6),STATUS=$P(DG1,U,7),REJECT=$P(DG1,U,8)
 ...S MSGTYPE=$P(DG1,U,4)
 ...;Check Screens
 ...Q:MSGSTAT'=1&(MSGSTAT'=$S(STATUS="A":2,STATUS="R":3,1:""))
 ...Q:'@SCRNARR@("PROVIDERS")&'$D(@SCRNARR@("PROVIDERS",COORD))
 ...;Resolve external values for PATIENT
 ...S SSN=$E($$GET1^DIQ(2,PATIENT,.09,"I"),6,9)
 ...S PATIENT=$$GET1^DIQ(2,PATIENT,.01,"E")
 ...;Resolve external value for VENDOR
 ...S VENDOR=$$GET1^DIQ(4,VENDOR,.01,"E")
 ...;Resolve external value for COORD
 ...S COORD=$$GET1^DIQ(200,COORD,.01,"E")
 ...;Increment counter and save for later
 ...S CNT=CNT+1
 ...S ^TMP("DGHT",$J,CNT)=PATIENT_U_SSN_U_VENDOR_U_COORD_U_CONSULT_U_DATE_U_MSGID_U_ACKDATE_U_STATUS_U_REJECT_U_MSGTYPE
 Q
HEADER ;print header
 S PAGENUM=PAGENUM+1
 S $P(LN,"-",80)=""
 W @IOF
 W !,"Home Telehealth ",$S(MSGSTAT=1:"All",MSGSTAT=2:"Accepted",MSGSTAT=3:"Rejected",1:"")_" Transmissions Report ",?65,"Page: ",PAGENUM
 W !!,"Report for ",$$FMTE^XLFDT(DGSD)," thru ",$$FMTE^XLFDT(DGED)
 W !!,?1,"Patient",?22,"SSN",?28,"HT Vendor",?50,"Care Coordinator",?68,"Consult #"
 W !?3,"Event/Trans Date",?28,"Message ID",?50,"ACK Date/Time",?69,"Status"
 W !?3,"Message Type",?28,"Reject Message",?50,"Retransmitted"
 W !?1,LN
 Q
 ;
DETAIL ;Print detailed line
 ;Input  :  ^TMP("DGHT",$J) full global reference
 ;          PATIENT   -   HTH Patient
 ;          SSN       -   Patient SSN's last four
 ;          VENDOR    -   HTH Vendor Server
 ;          COORD     -   Care Coordinator
 ;          CONSULT   -   CONSULT # file 123
 ;          DATE      -   Event/Transmission Date
 ;          MSGID     -   Message ID
 ;          ACK DATE  -   ACK Date and Time
 ;          STATUS    -   Registration Status
 ;          REJECT    -   Reject message
 ;          MSGTYPE   -   Message Type
 ;Output  : None
 ;Set acknowledgement status
 N RECORD,NODE,MSGID,ACKSTAT
 S (MSGID,ACKSTAT,NODE)="",RECORD=0
 F  S RECORD=$O(^TMP("DGHT",$J,RECORD)) Q:'RECORD  D  Q:STOP
 .S NODE=^TMP("DGHT",$J,RECORD)
 .S MSGID=$P(NODE,U,7),ACKSTAT=+$$MSGSTAT^HLUTIL(MSGID)
 .W !,?1,$E($P(NODE,U,1),1,20),?22,$P(NODE,U,2),?28,$E($P(NODE,U,3),1,20),?50,$E($P(NODE,U,4),1,16),?68,$P(NODE,U,5)
 .W !?3,$E($$FMTE^XLFDT($P(NODE,U,6),"1"),1,18),?28,$P(NODE,U,7),?47,$E($$FMTE^XLFDT($P(NODE,U,8),"1"),1,18),?69,$S($P(NODE,U,9)="A":"Accepted",$P(NODE,U,9)="R":"Rejected",ACKSTAT=1:"Pending TR",ACKSTAT=2:"Awaiting AA",1:"Unknown")
 .W !,?3,$S($P(NODE,U,11)="A":"Activation",$P(NODE,U,11)="I":"Inactivation",1:""),?28,$P(NODE,U,10)
 .;if there is data in the "HTHNOACK" node resolve number of retries
 .I $O(^DGHT(391.31,"HTHNOACK",$S(MSGID'="":MSGID,1:0),0)) D
 ..N RECORD,TRANS,RETRANS
 ..S (RECORD,TRANS,RETRANS)=0
 ..S RECORD=$O(^DGHT(391.31,"HTHNOACK",MSGID,0)),TRANS=$O(^DGHT(391.31,"HTHNOACK",MSGID,RECORD,0)),RETRANS=$P($G(^DGHT(391.31,"HTHNOACK",MSGID,RECORD,TRANS)),U,1)
 ..W ?50,RETRANS
 .W !
 .I $Y>(IOSL-5) D WAIT Q:STOP  D HEADER
 Q
 ;
TOTAL ;Report totals
 W !!?1,"Total Number of Home Telehealth Records: ",?23,CNT
 Q
 ;
WAIT ;End of page logic
 ;Input   ; None
 ;Output  ; STOP - Flag inidcating if printing should continue
 ;                 1 = Stop     0 = Continue
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;CRT - Prompt for continue
 I $E(IOST,1,2)="C-"&(IOSL'>24) D  Q
 .F  Q:$Y>(IOSL-3)  W !
 .S DIR(0)="E"
 .D ^DIR
 .S STOP=$S(Y'=1:1,1:0)
 ;Background task - check taskman
 S STOP=$$S^%ZTLOAD()
 I STOP D
 .W !,"*********************************************"
 .W !,"*  PRINTING OF REPORT STOPPED AS REQUESTED  *"
 .W !,"*********************************************"
 Q
EXIT ;Kill temp global
 K ^TMP("DGHT",$J)
 Q
