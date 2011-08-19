XOBWUS1 ;ALB/MJK - HWSC :: Web Service Manager ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
ADD ; -- add web service entry
 NEW DIC,Y,XOBY,D
 WRITE !
 SET DIC="^XOB(18.02,",DIC(0)="AELQ",D="B" DO IX^DIC KILL DIC
 SET XOBY=Y
 IF +XOBY>0,'$PIECE(XOBY,U,3) DO  GOTO ADDQ
 . DO DISPLAY("",+XOBY)
 . WRITE !!,"This is not a new entry! Please use 'Edit Service' action."
 . DO PAUSE^VALM1
 IF +XOBY>0,$PIECE(XOBY,U,3) DO DOEDIT(+XOBY)
 DO POSTEDIT(+XOBY)
ADDQ ;
 QUIT
 ;
EDIT ; -- edit web service entry
 NEW XOBDA,XOBI,VALMY
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 IF XOBI>0 DO 
 . SET XOBDA=+$GET(^TMP("XOB WEBSERVICES","IDX",$JOB,XOBI,XOBI))
 . DO DISPLAY(XOBI,XOBDA)
 . DO DOEDIT(XOBDA)
 . DO POSTEDIT(XOBDA)
EDITQ ;
 QUIT
 ;
DOEDIT(DA) ; -- do actual web service edit
 NEW DR,DIE
 SET DR="[XOBW WEB SERVICE EDIT]",DIE="^XOB(18.02," DO ^DIE
 QUIT
 ;
POSTEDIT(XOBDA) ; -- warning checks after 'add' or 'edit'
 NEW XOBCLASS,XOBSTAT,XOBISSUE
 SET XOBSTAT=$$CLSVAL(XOBDA,.XOBCLASS,.XOBISSUE)
 IF 'XOBSTAT DO
 . IF $GET(XOBISSUE)=1 WRITE !!,"Warning: No class name specified"
 . IF $GET(XOBISSUE)=2 WRITE !!,"Warning: Class name of '",$GET(XOBCLASS),"' is not a defined class!"
 . IF $GET(XOBISSUE)=3 WRITE !!,"Warning: Class '",$GET(XOBCLASS),"' does not extend %SOAP.WebClient!"
 . DO PAUSE^VALM1
 QUIT
 ;
CLSCHK(XOBDA) ; -- class check warning message
 NEW XOBCLASS,XOBSTAT,XOBISSUE,XOBMSG
 SET XOBMSG=""
 SET XOBSTAT=$$CLSVAL(XOBDA,.XOBCLASS,.XOBISSUE)
 IF 'XOBSTAT DO
 . IF $GET(XOBISSUE)=1 SET XOBMSG=" o  Class name not specified" QUIT
 . IF $GET(XOBISSUE)=2 SET XOBMSG=" o  Class is not a defined class" QUIT
 . IF $GET(XOBISSUE)=3 SET XOBMSG=" o  Class does not extend %SOAP.WebClient" QUIT
 QUIT XOBMSG
 ;
CLSVAL(XOBDA,XOBCLASS,XOBISSUE) ; -- do actual validation check
 NEW XOBWCDEF,XOBDA0,XOBOK
 SET XOBOK=0,XOBISSUE=0
 SET XOBDA0=$GET(^XOB(18.02,+XOBDA,0))
 ; -- no need to do check for REST-type [2]; quit w/ok
 IF $PIECE(XOBDA0,"^",2)=2 SET XOBOK=1 GOTO CLSVALQ
 ; -- do checks for SOAP-type [1] 
 SET XOBCLASS=$PIECE($GET(^XOB(18.02,+XOBDA,100)),"^")
 ; -- no class name defined
 IF XOBCLASS="" SET XOBOK=0,XOBISSUE=1 GOTO CLSVALQ
 SET XOBWCDEF=##class(%Dictionary.ClassDefinition).%OpenId(XOBCLASS)
 ; -- not a class
 IF XOBWCDEF="" SET XOBOK=0,XOBISSUE=2 GOTO CLSVALQ
 ; -- not a SOAP client class
 IF XOBWCDEF.Super'="%SOAP.WebClient" SET XOBOK=0,XOBISSUE=3 GOTO CLSVALQ
 SET XOBOK=1,XOBISSUE=0
CLSVALQ ;
 QUIT XOBOK
 ;
DEL ; -- delete web service entry
 NEW XOBI,VALMY,Y,XOBDA
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 ; -- quit if nothing selected
 IF XOBI'>0 GOTO DELQ
 ; -- display entry, ask if 'ok' and delete
 SET XOBDA=+$GET(^TMP("XOB WEBSERVICES","IDX",$JOB,XOBI,XOBI))
 DO DISPLAY(XOBI,XOBDA)
 IF $ORDER(^XOB(18.12,"AB",XOBDA,""))]"" DO
 . WRITE *7
 . WRITE !,"    ***************************************************"
 . WRITE !,"    * ATTENTION: This web service is still authorized *"
 . WRITE !,"    *            to 1 or more servers.                *"
 . WRITE !,"    ***************************************************"
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
 DO UNREG^XOBWLIB($P(^XOB(18.02,XOBDA,0),"^"))
 WRITE !!,"Entry has been deleted."
 DO PAUSE^VALM1
DELQ ;
 QUIT
 ;
DISPLAY(XOBI,DA) ; display web service informaton
 ; input: XOBI == list entry number
 ;        DA   == internal entry number in file 18.02
 NEW X,DIQ,XOBY,DR,DIC,XOBLINE,XOBDASH,XOBTYPE,XOBCMSG,XOBSRVDA,XOBMULDA
 SET $PIECE(XOBLINE,"=",$GET(IOM,80))=""
 SET $PIECE(XOBDASH,"-",$GET(IOM,80))=""
 DO CLEAR^VALM1
 WRITE !,XOBLINE
 IF $GET(XOBI) DO
 . WRITE !,@VALMAR@(XOBI,0)
 . WRITE !,XOBDASH
 SET DIC="^XOB(18.02,"
 SET DIQ="XOBY("
 SET DIQ(0)="E"
 SET DR=".01;.02;.03;100;200;201;"
 DO EN^DIQ1
 SET XOBTYPE=$GET(XOBY(18.02,DA,.02,"E"))
 WRITE !?5,"                Name: ",$GET(XOBY(18.02,DA,.01,"E"))
 WRITE !?5,"                Type: ",$GET(XOBY(18.02,DA,.02,"E"))
 WRITE !?5,"Registered Date/Time: ",$GET(XOBY(18.02,DA,.03,"E"))
 IF XOBTYPE="SOAP" DO
 . WRITE !?5,"    Proxy Class Name: ",$GET(XOBY(18.02,DA,100,"E"))
 . SET XOBCMSG=$$CLSCHK(DA)
 . IF XOBCMSG]"" WRITE !?5,"                      ",XOBCMSG
 WRITE !?5,"        Context Root: ",$GET(XOBY(18.02,DA,200,"E"))
 WRITE !?4,"Availability Resource: "_$GET(XOBY(18.02,DA,201,"E"))
 SET X="----------- Web servers '"_$GET(XOBY(18.02,DA,.01,"E"))_"' is authorized to: "
 WRITE !!,X_$EXTRACT(XOBDASH,$L(X)+1,999)
 IF $ORDER(^XOB(18.12,"AB",DA,""))']"" DO
 . WRITE !!,"        <<<none>>>"
 ELSE  DO
 . WRITE ! SET XOBSRVDA=0,XOBMULDA=0
 . FOR  SET XOBSRVDA=$ORDER(^XOB(18.12,"AB",DA,XOBSRVDA)) Q:XOBSRVDA']""  DO
 . . FOR  SET XOBMULDA=$ORDER(^XOB(18.12,"AB",DA,XOBSRVDA,XOBMULDA)) Q:XOBMULDA']""  DO
 . . . W !," - ",$PIECE($GET(^XOB(18.12,XOBSRVDA,0)),U)
 WRITE !!,XOBDASH,!
 QUIT
 ;
EXPAND ; -- expand Protocol
 NEW XOBI,XOBY,VALMY
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 IF $GET(XOBI) DO
 . SET XOBY("HEADER",1)=""
 . SET XOBY("HEADER",2)=@VALMAR@(XOBI,0)
 . SET XOBY("TITLE")="Web Service Metadata Display"
 . SET XOBY("BUILD CALLBACK")="DO BUILD^XOBWUS1("_+$GET(^TMP("XOB WEBSERVICES","IDX",$JOB,XOBI,XOBI))_")"
 . D EN^XOBWUS2(.XOBY)
 QUIT
 ;
BUILD(XOBDA) ; -- build display array with WSDL content (callback)
 NEW DIQ,XOBY,DR,DIC,DA,XOBJ,XOBWSDL,XOBDOTS,X,XOBTYPE,XOBCMSG,XOBSRVDA,XOBMULDA
 SET $PIECE(XOBDOTS,".",$GET(IOM,80))="."
 DO CLEAN^VALM10
 SET DIC="^XOB(18.02,"
 SET DIQ="XOBY("
 SET DIQ(0)="E"
 SET DR=".01;.02;.03;100;200;201;300"
 SET DA=$GET(XOBDA)
 DO EN^DIQ1
 SET VALMCNT=0
 SET XOBTYPE=$GET(XOBY(18.02,DA,.02,"E"))
 DO ADDLN("                     Name: "_$GET(XOBY(18.02,DA,.01,"E")))
 DO ADDLN("             Service Type: "_$GET(XOBY(18.02,DA,.02,"E")))
 DO ADDLN("     Registered Date/Time: "_$GET(XOBY(18.02,DA,.03,"E")))
 IF XOBTYPE="SOAP" DO
 . DO ADDLN("         Proxy Class Name: "_$GET(XOBY(18.02,DA,100,"E")))
 . SET XOBCMSG=$$CLSCHK(DA)
 . IF XOBCMSG]"" DO ADDLN("                           "_XOBCMSG)
 DO ADDLN("             Context Root: "_$GET(XOBY(18.02,DA,200,"E")))
 DO ADDLN("    Availability Resource: "_$GET(XOBY(18.02,DA,201,"E")))
 SET X="............Web servers '"_$GET(XOBY(18.02,DA,.01,"E"))_"' authorized to:"
 DO ADDLN(" "),ADDLN(X_$EXTRACT(XOBDOTS,$L(X)+1,999))
 IF $ORDER(^XOB(18.12,"AB",XOBDA,""))']"" DO
 . DO ADDLN(" "),ADDLN("        <<<none>>>")
 ELSE  DO
 . DO ADDLN(" ") SET XOBSRVDA=0,XOBMULDA=0
 . FOR  SET XOBSRVDA=$ORDER(^XOB(18.12,"AB",XOBDA,XOBSRVDA)) Q:XOBSRVDA']""  DO
 . . FOR  SET XOBMULDA=$ORDER(^XOB(18.12,"AB",XOBDA,XOBSRVDA,XOBMULDA)) Q:XOBMULDA']""  DO
 . . . DO ADDLN(" - "_$PIECE($GET(^XOB(18.12,XOBSRVDA,0)),U))
 DO ADDLN(" ")
 ;
 ; -- no need to do WSDL display info for REST services
 IF XOBTYPE="REST" GOTO BUILDQ
 ;
 ; -- build WSDL lines
 SET X="............WSDL Document:"
 DO ADDLN(X_$EXTRACT(XOBDOTS,$L(X)+1,999))
 SET XOBJ=0
 FOR  SET XOBJ=$ORDER(XOBY(18.02,DA,300,XOBJ)) QUIT:XOBJ=""  DO
 . DO ADDLN($GET(XOBY(18.02,DA,300,XOBJ)))
 . SET XOBWSDL=1
 ;
 IF '$GET(XOBWSDL) DO
 . DO ADDLN("")
 . DO ADDLN("        <<< No WSDL document available for this web service! >>>")
 . DO ADDLN("")
BUILDQ ;
 DO ADDLN(XOBDOTS)
 QUIT
 ;
ADDLN(XOBTEXT) ; -- add line utility
 SET VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,XOBTEXT)
 QUIT
 ;
