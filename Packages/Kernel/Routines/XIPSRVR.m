XIPSRVR ;SFISC/SO- SERVER TO UPDATE THE POSTAL CODE(#5.12) FILE ;7:03 AM  12 Apr 2007
 ;;8.0;KERNEL;**449**;Jul 10, 1995;Build 24
 Q
 ;
E1 ;
 N LN,ESC,XIPSEED,ACNT,ECNT,ICNT,LCNT,TREC,NECNT
 S (LN,ESC,ACNT,ECNT,ICNT,TREC,NECNT)=0,LCNT=9
 K ^TMP("XIP DATA",$J)
 S ^TMP("XIP DATA",$J)=""
 S ^TMP("XIP DATA",$J,LCNT)=" ",LCNT=LCNT+1
 S ^TMP("XIP DATA",$J,LCNT)="     **Detail Changes**",LCNT=LCNT+1
 S ^TMP("XIP DATA",$J,LCNT)="IEN^MAIL CODE^CITY^COUNTY^STATE^INACTIVE DATE^CITY KEY^PREFERRED CITY KEY^CITY ABBREVIATION^UNIQUE KEY (VA)^FLAG",LCNT=LCNT+1
 S XIPSEED=1 ; XIPSEED set to prevent "AD" from being set
 ;
 ; XQMSG is passed via the Server option
 ; See Kernel Programmer, Page: 19-1
 ; "Key Variables When a Server Option is Running"
 ;
 F  S LN=$O(^XMB(3.9,XQMSG,2,LN)) Q:'LN  D  Q:ESC
 . I LN<1 Q
 . N DATA,IEN,LKUP
 . S DATA=^XMB(3.9,XQMSG,2,LN,0)
 . I LN=1,DATA'="$$DATA$$" S ESC=1 Q
 . I DATA="$$EOD$$" S TREC=$O(^XMB(3.9,XQMSG,2," "),-1),TREC=TREC-2,ESC=1 Q
 . I DATA="$$DATA$$" Q
 . I DATA="$$EOD$$" Q
 . ;
 . S LKUP=$P(DATA,U,9) ; UNIQUE KEY
 . S IEN=+$O(^XIP(5.12,"E",LKUP,0))
ADD . ;
 . I 'IEN D  Q  ; New ZIP Code
 .. N FIPSPTR,STPTR,Y
 .. S FIPSPTR=0,STPTR=0
 .. S FIPSPTR=+$O(^XIP(5.13,"B",$P(DATA,U,3),0))
 .. I 'FIPSPTR Q  ;Broken FIPS
 .. S STPTR=+$O(^DIC(5,"B",$P(DATA,U,4),0))
 .. I 'STPTR Q  ;Broken STATE
 .. N DO,DIC,X
 .. S DIC="^XIP(5.12,",DIC(0)="Z",X=$P(DATA,U,1) D FILE^DICN
 .. I Y<1 Q
 .. N DA,DIE,DR
 .. S DA=+Y,DIE=DIC
 .. S DR="1///^S X=$P(DATA,U,2);2///^S X=""`""_FIPSPTR;3///^S X=""`""_STPTR;"
 .. S DR=DR_"5///^S X=$P(DATA,U,6);6///^S X=$P(DATA,U,7);7///^S X=$P(DATA,U,8)"
 .. F  L +^XIP(5.12,DA,0):$S($D(DILOCKTM):DILOCKTM,1:3) Q:$T  H $S($D(DILOCKTM):DILOCKTM,1:3)
 .. D ^DIE
 .. L -^XIP(5.12,DA,0)
 .. S ACNT=ACNT+1
 .. S ^TMP("XIP DATA",$J,LCNT)=DA_U_DATA_U_"New",LCNT=LCNT+1
 .. Q
INACT . ;
 . I $P(DATA,U,5)'="" D  Q  ; INACTIVE DATE
 .. I $P(^XIP(5.12,IEN,0),U,5)'="" S NECNT=NECNT+1 Q  ;Already has Inactive Date
 .. N DIE,DA,DR
 .. S DIE="^XIP(5.12,",DA=IEN,DR="4///^S X=$P(DATA,U,5)"
 .. F  L +^XIP(5.12,DA,0):$S($D(DILOCKTM):DILOCKTM,1:3) Q:$T  H $S($D(DILOCKTM):DILOCKTM,1:3)
 .. D ^DIE
 .. L -^XIP(5.12,DA,0)
 .. S ICNT=ICNT+1
 .. S ^TMP("XIP DATA",$J,LCNT)=DA_U_DATA_U_"Inactivated",LCNT=LCNT+1
 .. Q
EDIT . ;
 . D  Q  ; Edited Entry
 .. N FIPSPTR,STPTR,FDATA
 .. S FIPSPTR=0,STPTR=0
 .. S FIPSPTR=+$O(^XIP(5.13,"B",$P(DATA,U,3),0))
 .. I 'FIPSPTR Q  ;Broken FIPS
 .. S STPTR=+$O(^DIC(5,"B",$P(DATA,U,4),0))
 .. I 'STPTR Q  ;Broken STATE
 .. S FDATA=^XIP(5.12,IEN,0)
 .. S $P(FDATA,U,3)=$P(^XIP(5.13,$P(FDATA,U,3),0),U) ;Resolve COUNTY CODE
 .. S $P(FDATA,U,4)=$P(^DIC(5,$P(FDATA,U,4),0),U) ;Resolve STATE
 .. I DATA=FDATA S NECNT=NECNT+1 Q  ;Already been edited
 .. N DA,DIE,DR
 .. S DA=IEN,DIE="^XIP(5.12,"
 .. S DR="1///^S X=$P(DATA,U,2);2///^S X=""`""_FIPSPTR;3///^S X=""`""_STPTR;"
 .. S DR=DR_"5///^S X=$P(DATA,U,6);6///^S X=$P(DATA,U,7);7///^S X=$P(DATA,U,8)"
 .. F  L +^XIP(5.12,DA,0):$S($D(DILOCKTM):DILOCKTM,1:3) Q:$T  H $S($D(DILOCKTM):DILOCKTM,1:3)
 .. D ^DIE
 .. L -^XIP(5.12,DA,0)
 .. S ECNT=ECNT+1
 .. S ^TMP("XIP DATA",$J,LCNT)=DA_U_DATA_U_"Edited",LCNT=LCNT+1
 .. Q
 . Q
 ;
END ;
 N TOT S TOT=ACNT+ICNT+ECNT
 I 'TOT K ^TMP("XIP DATA",$J)
 S LCNT=1
 S ^TMP("XIP DATA",$J,LCNT)=" ",LCNT=LCNT+1
 S ^TMP("XIP DATA",$J,LCNT)="*Summary for this Update*",LCNT=LCNT+1
 S ^TMP("XIP DATA",$J,LCNT)="Total Data Records: "_TREC,LCNT=LCNT+1
 S ^TMP("XIP DATA",$J,LCNT)="Unedited Records: "_NECNT,LCNT=LCNT+1
 S ^TMP("XIP DATA",$J,LCNT)="New ZIP Codes: "_ACNT,LCNT=LCNT+1
 S ^TMP("XIP DATA",$J,LCNT)="Inactivated ZIP Codes: "_ICNT,LCNT=LCNT+1
 S ^TMP("XIP DATA",$J,LCNT)="Edited ZIP Codes: "_ECNT,LCNT=LCNT+1
 S ^TMP("XIP DATA",$J,LCNT)="Total Changes: "_TOT,LCNT=LCNT+1
 I 'TOT D
 . S ^TMP("XIP DATA",$J,LCNT)="**Your POSTAL CODE(#5.12) file is current with the Master",LCNT=LCNT+1
 . S ^TMP("XIP DATA",$J,LCNT)="  POSTAL CODE(#5.12) file.",LCNT=LCNT+1
 . Q
 ;
SEND ; Send 'Results' message If & Only If there are MEMBERS
 I $$GOTLOCAL^XMXAPIG("XIP POSTAL CODE UPDATE") D
 . N MSGSBJ,ODUZ,MSG,WHO
 . S MSG=$NA(^TMP("XIP DATA",$J))
 . I DUZ<.5 S ODUZ=DUZ,DUZ=.5 ;** Change user to POSTMASTER **
 . S MSGSBJ="POSTAL CODE(#5.12) File Update Results"
 . S WHO("G.XIP POSTAL CODE UPDATE")=""
 . D SENDMSG^XMXAPI(DUZ,MSGSBJ,.MSG,.WHO)
 . I $G(ODUZ)'="" S DUZ=ODUZ ;** Change POSTMASTER back to current user **
 . K ^TMP("XIPDATA",$J)
 . Q
 Q
