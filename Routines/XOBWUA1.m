XOBWUA1 ;OAK/KEC - HWSC :: Web Server Lookup Key Manager ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
ADD ; -- add web server lookup key entry
 NEW DIC,Y,XOBY,D
 WRITE !
 SET DIC("A")="Enter name for a new web server lookup key: "
 SET DIC="^XOB(18.13,",DIC(0)="AELQ",D="B" DO IX^DIC KILL DIC
 SET XOBY=Y
 IF +XOBY>0,'$PIECE(XOBY,U,3) DO  GOTO ADDQ
 . DO DISPLAY("",+XOBY)
 . WRITE !!,"This is not a new entry! Please use 'Edit Server' action."
 . DO PAUSE^VALM1
 IF +XOBY>0,$PIECE(XOBY,U,3) DO DOEDIT(+XOBY)
ADDQ ;
 QUIT
 ;
EDIT ; -- edit web server entry
 NEW DA,DR,DIE,XOBI,VALMY
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 IF XOBI>0 DO DOEDIT(+$GET(^TMP("XOB WEB SERVER LOOKUP","IDX",$JOB,XOBI,XOBI)))
EDITQ ;
 QUIT
 ;
DOEDIT(DA) ; -- do actual web server lookup key edit
 NEW DR,DIE
 SET DR="[XOBW WEB SERVER KEY SETUP]",DIE="^XOB(18.13," DO ^DIE
 QUIT
 ;
DEL ; -- delete web server lookup key entry
 NEW XOBI,VALMY,Y,XOBDA
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 ; -- quit if nothing selected
 IF XOBI'>0 GOTO DELQ
 ; -- display entry, ask if 'ok' and delete
 SET XOBDA=+$GET(^TMP("XOB WEB SERVER LOOKUP","IDX",$JOB,XOBI,XOBI))
 DO DISPLAY(XOBI,XOBDA)
 DO
 . NEW DIR
 . SET DIR("A")="Are you sure you want to delete entry"
 . SET DIR("B")="NO",DIR(0)="Y"
 . WRITE !
 . DO ^DIR
 IF '$GET(Y) DO  GOTO DELQ
 . WRITE !!,"Deletion aborted."
 . DO PAUSE^VALM1
 ; -- execute deletion
 DO DODEL(XOBDA)
 WRITE !!,"Entry has been deleted."
 DO PAUSE^VALM1
DELQ ;
 QUIT
 ;
DODEL(DA) ; -- do actual web server lookup key delete
 NEW DIK
 SET DIK="^XOB(18.13," DO ^DIK
 QUIT
 ;
SORT ; -- change sort order
 IF XOBSORT="K" DO
 . SET XOBSORT="S"
 ELSE  DO
 . SET XOBSORT="K"
 QUIT
 ;
KFILTER ; -- specify lookup key filter
 NEW DIR,Y,X,XOBCLR,DTOUT,DUOUT,DIRUT,DIROUT
 SET XOBCLR="<clear filter>"
 SET DIR(0)="FO^1:30"
 SET DIR("A")="Enter lookup key 'starts with' filter text"
 IF $GET(XOBKFILT)]"" SET DIR("B")=XOBCLR
 DO ^DIR
 IF '($DATA(DTOUT)!$DATA(DUOUT)!$DATA(DIRUT)!$DATA(DIROUT)) DO
 . SET XOBKFILT=$SELECT(Y=XOBCLR:"",1:$$UP^XLFSTR(Y))
 QUIT
 ;
SFILTER ; -- specify web server filter
 NEW DIR,Y,X,XOBCLR,DTOUT,DUOUT,DIRUT,DIROUT
 SET XOBCLR="<clear filter>"
 SET DIR(0)="FO^1:30"
 SET DIR("A",1)=""
 SET DIR("A",2)="Specify web server name 'starts with' filter text."
 SET DIR("A",3)="Note: Use <space> to list entries without a web server defined."
 SET DIR("A")="Enter filter text"
 IF $GET(XOBSFILT)]"" SET DIR("B")=XOBCLR
 DO ^DIR
 IF '($DATA(DTOUT)!$DATA(DUOUT)!$DATA(DIRUT)!$DATA(DIROUT)) DO
 . SET XOBSFILT=$SELECT(Y=XOBCLR:"",Y=" ":$$NOTDEF^XOBWUA(),1:$$UP^XLFSTR(Y))
 QUIT
 ;
EXPAND ; -- expand Protocol
 NEW DA,DIC,XOBI,VALMY
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 IF XOBI>0 DO DISPLAY(XOBI,+$GET(^TMP("XOB WEB SERVER LOOKUP","IDX",$JOB,XOBI,XOBI)))
 QUIT
 ;
DISPLAY(XOBI,DA) ; display web server lookup key informaton
 ; input: XOBI == list entry number
 ;        DA   == internal entry number in file 18.12
 NEW DIC,XOBLINE,XOBDASH
 SET $PIECE(XOBLINE,"=",$GET(IOM,80))=""
 SET $PIECE(XOBDASH,"-",$GET(IOM,80))=""
 DO CLEAR^VALM1
 WRITE !,XOBLINE
 IF $GET(XOBI) DO
 . WRITE !,@VALMAR@(XOBI,0)
 . WRITE !,XOBDASH
 SET DIC="^XOB(18.13,"
 DO EN^DIQ
 WRITE XOBLINE
 QUIT
 ;
