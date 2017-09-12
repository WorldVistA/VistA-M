ANRV4P6 ; HOIFO/CD - Post Init Version Control ; 8/5/03 2:55pm
 ;;4.0;VISUAL IMPAIRMENT SERVICE TEAM;**6**;JUN 03, 2002
EN ; [Procedure] Main entry to update Patient Review Version
 NEW ANRV,ANRVGUI,ANRVLST
 D GETLST^XPAR(.ANRVLST,"SYS","ANRV GUI VERSION")
 F ANRV=0:0 S ANRV=$O(ANRVLST(ANRV)) Q:'ANRV  D
 .D SETPAR("ANRV GUI VERSION",$P(ANRVLST(ANRV),"^",1),0)
 S ANRVGUI="4.0.6.0" D
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
