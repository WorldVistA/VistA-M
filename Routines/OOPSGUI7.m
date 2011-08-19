OOPSGUI7 ;WIOFO/LLH-RPC routines ;10/30/01
 ;;2.0;ASISTS;**2,4,7**;Jun 03, 2002
 ;
ENT(RESULTS,INPUT) ; Non-interactive GUI Entry Point for transmitting data
 ;                 to DOL or NDB
 ;  Input:   INPUT  - Contains the date for the claims to be
 ;                    retransmitted, the queue date and time for the
 ;                    retransmission date to run and either DOL or NDB
 ;                    to indicate which manual transmission should run.
 ;                    The format is TRANSDT^QUEUEDT@TIME^DOL (or NDB)
 ; Output: RESULTS -  is the return array to the client with status
 ;                    message
 N ARR,COMMA,ERR1,ERR2,FIELD,FL,MAILG,CURR,QDATE,QUE,RDATE,RTN,X,Y
 N MAN,WOK,ZTDESC,ZTREQ,ZTRTN
 S RTN=$P($G(INPUT),U,3)
 S MAN=1                       ; force manual xmit flag
 I RTN="DOL" D
 . S MAILG="OOPS DOL XMIT DATA"
 . S QUE="Q-AST.MED.VA.GOV"
 I RTN="NDB" D
 . S MAILG="OOPS XMIT 2162 DATA"
 . S QUE="Q-ASI.MED.VA.GOV"
 ;Check for security keys
 I '$D(^XUSEC(MAILG,DUZ)) D  Q
 .S RESULTS(0)="ERROR"
 .S RESULTS(1)="You do not have the required Security Key."
 ;Assure the Queue has been defined
 S FIELD=.01,FL="X"
 D FIND^DIC(4.2,"",FIELD,FL,QUE,"","","","","ARR")
 I '$D(ARR("DILIST",1)) D  Q
 .S RESULTS(0)="ERROR"
 .S RESULTS(1)="Domain not found in the DOMAIN File,"
 ; Get Retransmit Date from First Piece of Input & Translate into FM
 S X=$P($G(INPUT),U) D ^%DT
 S RDATE=Y
 I RDATE=-1 S ERR1=1
 S %DT="R",X=$P($G(INPUT),U,2) D ^%DT K %DT
 S QDATE=Y
 I QDATE=-1 S ERR2=2
 I $G(ERR1)!($G(ERR2)) D  Q
 . S RESULTS(0)="ERROR",RESULTS(1)="",COMMA=""
 . S:$G(ERR1) RESULTS(1)="Invalid Transmission Date",COMMA=", "
 . S:$G(ERR2) RESULTS(1)=RESULTS(1)_COMMA_"Invalid Queue Date."
 ;
 I RTN="DOL" D
 . S ZTRTN="EN^OOPSDOL",WOK=1,ZTDESC="TRANSMIT DOL CA1/CA2 DATA"
 I RTN="NDB" D
 . S ZTRTN="EN^OOPSNDB",ZTDESC="TRANSMIT NATIONAL DATABASE 2162 DATA"
 ; Make sure Queue date/time is not after current time
 S CURR=$$HTFM^XLFDT(""_$H_"")
 I $$FMDIFF^XLFDT(QDATE,CURR,2)<0 S QDATE=$H
 ; Report will always be Queued from the GUI
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 S ZTDTH=QDATE,ZTIO="",ZTREQ="@",ZTSAVE("ZTREQ")=""
 S ZTSAVE("RDATE")="",ZTSAVE("MAN")=""
 D ^%ZTLOAD
 K ZTSK
 S RESULTS(0)="SUCCESSFULLY QUEUED"
 Q
OWCPCLR(RESULTS,IEN,CALLER,FORM) ; Entry point for clearing supervisor
 ;   fields if OWPC worker has edited them
 ;  Input:     IEN - ien of case to have the fields cleared
 ;          CALLER - menu being called from
 ;            FORM - whether a CA1 or CA2
 ; Output: RESULTS - required results parameter, no data returned
 ;                   from this call
 I $G(IEN)=""!($G(CALLER)="")!($G(FORM)="") Q
 D CLRFLDS^OOPSWCE
SUPFLDS ; Clear Supervisor fields for the CA1, since fields have been changed
 I FORM'="CA1" Q
 N SUP
 S SUP=$$GET1^DIQ(200,DUZ,.01)
 S RESULTS=SUP
 S $P(^OOPS(2260,IEN,"CA1L"),U,3)=""     ;Clear EXCEPTION 
 S $P(^OOPS(2260,IEN,"CA1L"),U,4)=""     ;Clear SUP TITLE
 S $P(^OOPS(2260,IEN,"CA1L"),U,5)=""     ;Clear SUP PHONE
 Q
CONSENT(RESULTS,IEN,UNIREP)     ; Employee consented to union notification,
 ;                 send msg to union
 ; Input
 ;    IEN - Internal record number
 ; UNIREP - IEN from file 200 of the Union Rep - used to send bulletin
 ; Output - RESULTS - String indicating bulletin status.
 D CONSENT^OOPSMBUL(IEN,UNIREP)
 Q
GETFLD(RESULTS,IEN,FLD) ; Send in IEN and Field number to retrieve a single 
 ; data field from the ASISTS Accident Reporting File (#2260)
 ;
 ;  Input:   IEN - Internal record number
 ; Output:   FLD - the file and field number of the data element to be
 ;                 retrieved.  EX. 2260^120
 N FILE,FIELD,DATA
 S RESULTS="No data."
 I '$G(IEN) S RESULTS="No data.  Missing Record Identifier." Q
 S FILE=$P(FLD,U),FIELD=$P(FLD,U,2)
 I $G(FILE)=""!($G(FIELD)="") D  Q
 . S RESULTS="No data.  Missing File or Field information."
 ; This should only get called when OOPS*2.0*7 is 1st released, used
 ; to get hire date if it's blank and personnel status is employee
 I FIELD=336 D  Q
 .N SSN,STR S SSN=$$GET1^DIQ(FILE,IEN,5,"I")
 .D FIND^DIC(450,,"@;.01;30","PS",SSN,"","SSN")
 .S STR=$P(^TMP("DILIST",$J,0),U) I $G(STR)'=1 S RESULTS="No Data." Q
 .S RESULTS=$P($G(^TMP("DILIST",$J,1,0)),U,3)
 .I RESULTS="" S RESULTS="No Data."
 .K ^TMP("DILIST",$J),DIERR
 S DATA=$$GET1^DIQ(FILE,IEN,FIELD)
 I $G(DATA)'="" S RESULTS=DATA
 Q
GETINST(RESULTS)        ; 
 ; RPC Call - Get Institutions from File 4
 ; Output:  RESULTS - global array
 ;
 ; 12/30/03 llh (OOPS*2*4) - this subroutine can only be used
 ; to retrieve data from ^DIC(4).  There is generic code in OOPSGUI3
 ; to obtain data from other 'table files'.
 ;
 N ITEM,ROOT,X,XREF,SFLD,VAL,PTR,PCE,VALID,FIELD
 K ^TMP("OOPSINST",$J)
 S XREF="B",X=0,FIELD=13
 S ROOT="^"_$$GET1^DID(2260,FIELD,"","POINTER")
 S ITEM="" F  S ITEM=$O(@(ROOT_"XREF,ITEM)")) Q:$G(ITEM)']""  D
 .S PTR=0 F  S PTR=$O(@(ROOT_"XREF,ITEM,PTR)")) Q:PTR=""  D
 ..I PTR'>0 Q
 ..S VAL=$P(@(ROOT_PTR_",0)"),U)
 ..S VALID=1,SFLD=ROOT_PTR_",99)"
 ..I $P($G(@SFLD),U,4)=1 S VALID=0
 ..I $P($G(@SFLD),U)'="" S VAL=VAL_" = "_$P($G(@SFLD),U)
 ..I $P(VAL," = ")="" S VALID=0
 ..I VALID S X=X+1,^TMP("OOPSINST",$J,X)=PTR_":"_VAL_$C(10)
 S RESULTS=$NA(^TMP("OOPSINST",$J))
 Q
SENSDATA(RES,SDUZ,EMP) ;Supervisor accessed sensitive data, case not created
 ; Input  EMP String which is the name of the employee accessed.
 ;        DUZ DUZ of the Supervisor accessing the data. 
 N MGRP,MEMS,MSG
 ;Make sure mail group exists
 S MGRP=$$FIND1^DIC(3.8,"","X","OOPS ISO NOTIFICATION")
 I 'MGRP D  G BULL
 .S XMY("G.OOPS WC MESSAGE")=""
 .S XMDUZ="ASISTS Package"
 .S GRP="OOPS WC MESSAGE"
 .S XMSUB="ASISTS ISO NOTIFICATION Mail Group Error"
 .S MSG(1)="The OOPS ISO NOTIFICATION Mail Group does not exist."
 .S XMTEXT="MSG("
 .D ^XMD
 ;Make sure there is someone defined in the mail group
 D LIST^DIC(3.81,","_MGRP_",","","",1,"","","","","","MEMS")
 I '$P(MEMS("DILIST",0),U) D  G BULL
 .S XMY("G.OOPS WC MESSAGE")=""
 .S XMDUZ="ASISTS Package"
 .S GRP="OOPS WC MESSAGE"
 .S XMSUB="ASISTS ISO NOTIFICATION Mail Group Error"
 .S MSG(1)="There are no members in mail group OOPS ISO NOTIFICATION."
 .S XMTEXT="MSG("
 .D ^XMD
 S XMY("G.OOPS ISO NOTIFICATION")=""
BULL S (NAME,XMB)="OOPS SENSITIVE DATA"
 S XMB(1)=$$GET1^DIQ(200,SDUZ,.01)
 S XMB(2)=EMP
 S XMB(3)=$$FMTE^XLFDT($$NOW^XLFDT,1)
 S XMBODY="",XMINSTR("FLAGS")="X"
 D TASKBULL^XMXAPI(DUZ,NAME,.XMB,XMBODY,.XMY,.XMINSTR)
 K NAME,XMB,XMBODY,XMY,XMINSTR
 S RES="BULLETIN SENT"
 Q
