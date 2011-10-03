IBDF18E2 ;ALB/AAS - AICS Error Logging Routine ;27-JAN-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25,51**;APR 24, 1997
 ;
LOGERR(ERRNO,FORMID,DATANO,VALUE,PI,QLFR,TYPEDTA,TXT) ;
 ; -- log aics scanning processing error
 N TEXT,IBDERR
 S TEXT(1)=$$NOW^XLFDT
 S TEXT(2)=$P($G(^IBD(357.96,+$G(FORMID),0)),"^",2) I 'TEXT(2) S TEXT(2)=$G(DFN) ; -- dfn
 S TEXT(3)=$G(FORMID("APPT")) ; -- encounter date/time
 S TEXT(4)=$P($G(^IBD(357.96,+$G(FORMID),0)),"^",4) ; -- pointer to 357.95
 S TEXT(5)=$G(FORMID) S:+TEXT(5) TEXT(5)=+TEXT(5) ; -- pointer to 357.96
 S:$G(DATANO)'="" TEXT(6)=$G(DATANO) ; -- number of bubble or hand print field (ie BUBBLE(1)
 S:$G(VALUE)'="" TEXT(7)=$G(VALUE) ; -- value of bubble or hand print field
 S TEXT(8)=$G(FORMID("SOURCE"))
 S TEXT(9)=$P($G(^IBD(357.95,+$P($G(^IBD(357.96,+$G(FORMID),0)),"^",4),0)),"^",21) ; -- form name
 S:$G(PI)'="" TEXT(10)=$G(PI) ; -- package interface
 S:$G(QLFR)'="" TEXT(11)=$G(QLFR) ; -- name of qualifier
 S:$G(TXT)'="" TEXT(12)=$G(TXT) ; -- Text appearing on the form
 S TEXT(13)=$G(DUZ) ; -- user
 S:$G(TYPEDTA)'="" TEXT(14)=$P($G(^IBE(359.1,+TYPEDTA,0)),"^")
 S:$G(XQY0)'="" TEXT(15)=$P(XQY0,"^") ; -- option name
 S TEXT(16)=$G(ERRNO) ; -- entry in dialog file
 S:$G(FORMID("PAGE")) TEXT(17)=$G(FORMID("PAGE"))
 S:$G(FORMID("WSID"))'="" TEXT(18)=$G(FORMID("WSID"))
 ;
 ; -- Build Error Message from Dialog file
 D BLD^DIALOG(ERRNO,.TEXT,.IBDOUT,"IBDERR","S")
 ;D ERRMSG(ERRNO,.TEXT)
 ;
 ; -- file error in aics error log file
 D ERRFIL(ERRNO,.TEXT,.IBDERR)
 Q:ERRNO=3570001!(ERRNO=3570004)
 ;
 ; -- set error in pxca(aics error) array to pass back to workstation
 S CNT=$G(PXCA("AICS ERROR"))+1
 S PXCA("AICS ERROR")=CNT
 S PXCA("AICS ERROR",1,1,1,CNT)=$P($G(IBDERR(1)),": ",2,99)
 Q
 ;
ERRMSG(ERRNO,TEXT) ;
 ; -- Build Error Message from Dialog file
 D BLD^DIALOG(ERRNO,.TEXT,.IBDOUT,"IBDERR","S")
 Q
 ;
ERRFIL(ERRNO,TEXT,IBDERR) ;
 ; -- file error in aics error log file
 N FDAROOT,FDAIEN
 ;
 Q:$G(TEXT(1))=""
 S FDAROOT(359.3,"+1,",.01)=$G(TEXT(1))
 S:$G(TEXT(2))'="" FDAROOT(359.3,"+1,",.02)=$G(TEXT(2))
 S:$G(TEXT(3))'="" FDAROOT(359.3,"+1,",.03)=$G(TEXT(3))
 S:$G(TEXT(4))'="" FDAROOT(359.3,"+1,",.04)=$G(TEXT(4))
 S:$G(TEXT(5))'="" FDAROOT(359.3,"+1,",.05)=$G(TEXT(5))
 S:$G(TEXT(6))'="" FDAROOT(359.3,"+1,",.06)=$G(TEXT(6))
 S:$G(TEXT(7))'="" FDAROOT(359.3,"+1,",.07)=$G(TEXT(7))
 S:$G(TEXT(8))'="" FDAROOT(359.3,"+1,",.08)=$G(TEXT(8))
 S:$G(TEXT(9))'="" FDAROOT(359.3,"+1,",.09)=$G(TEXT(9))
 S:$G(TEXT(10))'="" FDAROOT(359.3,"+1,",.1)=$G(TEXT(10))
 S:$G(TEXT(11))'="" FDAROOT(359.3,"+1,",.11)=$G(TEXT(11))
 S:$G(TEXT(12))'="" FDAROOT(359.3,"+1,",.12)=$G(TEXT(12))
 S:$G(TEXT(13))'="" FDAROOT(359.3,"+1,",.13)=$G(TEXT(13))
 S:$G(TEXT(16))'="" FDAROOT(359.3,"+1,",.16)=$G(TEXT(16))
 S:$G(TEXT(15))'="" FDAROOT(359.3,"+1,",1.01)=$G(TEXT(15))
 S:$G(TEXT(17))'="" FDAROOT(359.3,"+1,",.17)=$G(TEXT(17))
 S:$G(TEXT(18))'="" FDAROOT(359.3,"+1,",.18)=$G(TEXT(18))
 ;
 S CNT=2
 I ERRNO=3570001 D EW^IBDFBK2(.IBDERR,.PXCA,.CNT,1)
 ;
 D UPDATE^DIE("","FDAROOT","FDAIEN")
 D WP^DIE(359.3,FDAIEN(1)_",",10,"KA","IBDERR")
 Q
 ;
PRT ; -- print error listing
 ;
 W !,?4,"** This option is OUT OF ORDER **" QUIT   ;Code set Versioning
 ;
 I '$D(IOF) D HOME^%ZIS
 W @IOF,?10,"Print List of Scanning Errors and Warnings",!!!
 ;
 S DIC="^IBD(359.3,",L=0,FR="?,?,?,?",TO="?,?,?,?"
 S BY="[IBD LIST ERRORS]"
 S FLDS="[IBD LIST ERRORS]"
 ;
 ;S DISUPNO=1 ; -- print No records found if not set, don't uncomment this line
 S DIPCRIT=1 ; -- print sort criteria on first page.
 S DIS(0)="I '$P($G(^IBD(359.3,D0,1)),U,2)"
 D EN1^DIP
PRTQ K DIC,L,FLDS,DIOEND,FR,TO,BY,DHD,X,Y,DUOUT,DIRUT
 Q
 ;
NOAPP ; -- print no appointment listing
 I '$D(IOF) D HOME^%ZIS
 S IBDCNT=0
 W @IOF,?10,"Print List Patients with Data from Encounter Forms and No appointemnts",!!!
 ;
 S DIC="^IBD(357.96,",L=0,FR="?,?,?,T-1",TO="?,?,?,T-1"
 S BY="[IBD NO APPOINTMENT LIST]"
 S FLDS="[IBD NO APPOINTMENT LIST]"
 ;
 ;S DIPCRIT=1 ; -- print sort criteria on first page.
 S DIS(0)="I 1 S IBDCNT=IBDCNT+1"
 S IOP="HOME"
 D EN1^DIP
NOAPPQ K DIC,L,FLDS,DIOEND,FR,TO,BY,DHD,X,Y,DUOUT,DIRUT,IBDCNT
 Q
NOAPP1 ; -- print no appointment listing
 I '$D(IOF) D HOME^%ZIS
 S IBDCNT=0
 W @IOF,?10,"Print List Patients with Data from Encounter Forms and No appointemnts",!!!
 ;
 S DIC="^IBD(357.96,",L=0,FR="?,?,?,T-1",TO="?,?,?,T-1"
 S BY="[IBD NO APPOINTMENT1]"
 S FLDS="[IBD NO APPOINTMENT LIST]"
 ;
 ;S DIPCRIT=1 ; -- print sort criteria on first page.
 S DIS(0)="I 1 S IBDCNT=IBDCNT+1"
 S IOP="HOME"
 D EN1^DIP
NOAPP1Q K DIC,L,FLDS,DIOEND,FR,TO,BY,DHD,X,Y,DUOUT,DIRUT,IBDCNT
 Q
