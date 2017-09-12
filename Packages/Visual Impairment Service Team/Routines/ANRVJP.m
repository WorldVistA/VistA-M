ANRVJP ; CED/HOIFO - Post Init Version Control ; [09-24-2004]
 ;;5.0;BLIND REHABILITATION;;Jun 02, 2006;Build 4
 ;;
EN ;
 N ANRV,ANRVGUI,ANRVLST
 D GETLST^XPAR(.ANRVLST,"SYS","ANRV GUI VERSION")
 F ANRV=0:0 S ANRV=$O(ANRVLST(ANRV)) Q:'ANRV  D
 .D SETPAR("ANRV GUI VERSION",$P(ANRVLST(ANRV),"^",1),0)
 S ANRVGUI="5.0.1.4" D
 .D SETPAR("ANRV GUI VERSION","ANRV.EXE:"_ANRVGUI,1)
 D SETPROX("ANRVAPPLICATION,PROXY USER")
 D ADDOPT
 Q
 ;
SETPAR(PAR,INS,VAL)     ; [Procedure] Set the Parameter
 ; Input parameters
 ;  1. PAR [Literal/Required] No description
 ;  2. INS [Literal/Required] No description
 ;  3. VAL [Literal/Required] No description
 ;
 D EN^XPAR("SYS",PAR,INS,VAL)
 Q
 ;
SETPROX(PROX)
 ;
 D ADDPROXY(PROX)
 ;
ADDPROXY(XOBANAME) ; add application proxy if not present
 ; depends on XU*8*361
 NEW XOBID,XOBMSG,XOBSUBER,XOBSUBTX,XOBLINE,ANRVOPT
 ;
 ; if already present don't add
 QUIT:(+$$APFIND^XUSAP(XOBANAME))>0
 ; add menus
 S ANRVOPT("ANRVJ_BLINDREHAB")=""
 S ANRVOPT("DGRR PATIENT SERVICE QUERY")=""
 ;
 SET XOBID=$$CREATE^XUSAP(XOBANAME,"",.ANRVOPT,"")
 ;
 IF (+XOBID)>0 DO
 . SET XOBMSG(1)="Added new Application Proxy User '"_XOBANAME_"'."
 . DO BMES^XPDUTL(.XOBMSG)
 IF (+XOBID)=0 DO
 . ; already checked if user present, should never get 0 back
 . SET XOBMSG(1)=">>> Error: Could not add Application Proxy User '"_XOBANAME_"' -- Already exists."
 . DO BMES^XPDUTL(.XOBMSG)
 IF (+XOBID)<0 DO
 . SET XOBMSG(1)=">>> Error: Could not add Application Proxy User '"_XOBANAME_"'."
 . SET XOBMSG(2)="    DIERR nodes: <start of error(s)>"
 . SET XOBLINE=3,XOBSUBER=0 FOR  SET XOBSUBER=$O(^TMP("DIERR",$J,XOBSUBER)) QUIT:(+XOBSUBER)'>0  DO
 . . SET XOBMSG(XOBLINE)="    "_^TMP("DIERR",$J,XOBSUBER),XOBLINE=XOBLINE+1
 . . SET XOBSUBTX=0 FOR  SET XOBSUBTX=$O(^TMP("DIERR",$J,XOBSUBER,"TEXT",XOBSUBTX)) QUIT:(+XOBSUBTX)'>0  DO
 . . . SET XOBMSG(XOBLINE)="    "_^TMP("DIERR",$J,XOBSUBER,"TEXT",XOBSUBTX),XOBLINE=XOBLINE+1
 . SET XOBMSG(XOBLINE+1)="    <end of error(s)>"
 . DO BMES^XPDUTL(.XOBMSG)
 . K ^TMP("DIERR",$J)
 ;
 QUIT
 ;
ADDOPT
 ; this is being icluded to add foundations to the 
 N ANRVOPT,ANRVFDA,ANRVIEN,ANRVERR,ANRVMSG,I,J,K
 S ANRVOPT=$$FIND1^DIC(19,,"QX","ANRVJ_BLINDREHAB","B")
 S ANRVFDA(19.01,"?+2,"_ANRVOPT_",",.01)="DGRR GUI PATIENT LOOKUP"
 S ANRVFDA(19.01,"?+3,"_ANRVOPT_",",.01)="DGRR PATIENT SERVICE QUERY"
 D UPDATE^DIE("E","ANRVFDA","ANRVIEN","ANRVERR")
 I $D(ANRVERR) D
 . S I=0
 . F J=0:0 S J=$O(ANRVERR("DIERR",J)) Q:'J  F K=0:0 S K=$O(ANRVERR("DIERR",J,"TEXT",K)) Q:'K  D
 . . S I=I+1,ANRVMSG(I)=ANRVERR("DIERR",J,"TEXT",K)
 . . Q
 . S I=I+1,ANRVMSG(I)=" "
 . S ANRVMSG(I+1)="The Patient Services Broker Type Options DGRR GUI PATIENT LOOKUP"
 . S ANRVMSG(I+2)="and DGRR PATIENT SERVICE QUERY could not be added to the"
 . S ANRVMSG(I+3)="ANRV Option ANRVJ_BLINDREHAB."
 . S ANRVMSG(I+4)=" "
 . S ANRVMSG(I+5)="Users of the Blind Rehabilitation application will not be able to look up"
 . S ANRVMSG(I+6)="patients until this is resolved."
 . D MES^XPDUTL(.ANRVMSG)
 . Q
 Q
 ;
 ;
