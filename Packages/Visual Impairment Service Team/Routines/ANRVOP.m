ANRVOP ; HOIFO/CD - Post Init Version Control ; [01-07-2003 12:20]
 ;;4.0;VISUAL IMPAIRMENT SERVICE TEAM;**5**;JUN 03, 2002
EN ; [Procedure] Main entry to update Patient Review Version
 NEW ANRV,ANRVGUI,ANRVLST
 D GETLST^XPAR(.ANRVLST,"SYS","ANRV GUI VERSION")
 F ANRV=0:0 S ANRV=$O(ANRVLST(ANRV)) Q:'ANRV  D
 .D SETPAR("ANRV GUI VERSION",$P(ANRVLST(ANRV),"^",1),0)
 S ANRVGUI="4.0.5.3" D
 .D SETPAR("ANRV GUI VERSION","ANRV.EXE:"_ANRVGUI,1)
 Q
 ;
SETPAR(PAR,INS,VAL) ; [Procedure] Set the Parameter
 ; Input parameters
 ;  1. PAR [Literal/Required] No description
 ;  2. INS [Literal/Required] No description
 ;  3. VAL [Literal/Required] No description
 ;
 D EN^XPAR("SYS",PAR,INS,VAL)
 Q
 ;
