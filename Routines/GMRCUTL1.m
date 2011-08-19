GMRCUTL1 ;SLC/DCM,JFR,MA - General Utilities ;10/15/02  11:49
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,12,15,21,17,28**;DEC 27, 1997
 ;
 ; This routine invokes IA #2876,3121
 ; Patch #21 added variable GMRCAUDT and moved line tag PRNTAUDT
 ; to GMRCP5A.
 ;
ACTM ;;Set correct variables to complete, discontinue, etc. a consult
 K GMRCQUT
 S:'+$G(GMRCA) GMRCA=$O(^GMR(123.1,"B",GMRCACTM,""))
 S GMRCACTM=$P($G(^GMR(123.1,+GMRCA,0)),"^")
 S ORSTS=$S(GMRCA:$P(^GMR(123.1,GMRCA,0),"^",2),1:0)
 I 'GMRCA S GMRCQUT=1
 Q
PRNT(SRVCIFN,GMRCO) ;print form 513 to a printer when new consult is entered
 N ORVP,GMRCDEV,GMRCQUED,IOP,%ZIS,POP,ZTDTH,ZTDESC,ZTIO,ZTRTN,ZTSK,GMRCAUDT
 I '$G(SRVCIFN) S SRVCIFN=+$P(^GMR(123,GMRCO,0),U,5)
 Q:'$D(^GMR(123.5,SRVCIFN,123))  Q:'$P(^GMR(123.5,SRVCIFN,123),"^",9)
 S IOP="`"_$P(^GMR(123.5,SRVCIFN,123),"^",9)
 S %ZIS="N" D ^%ZIS I POP S %ZIS=0 D HOME^%ZIS Q
 S GMRCDEV=ION,GMRCQUED=1,GMRCAUDT=1
 S ZTRTN="PRNT^GMRCP5A("_(+GMRCO)_","_(+$G(TIUFLG))_",1,"""_$G(GMRCCPY,"W")_""",0,"_(GMRCAUDT)_")"
 S ZTDESC="CONSULT/REQUEST PACKAGE PRINT FORM 513 FOR NEW CONSULT"
 S ZTIO=GMRCDEV,ZTDTH=$H
 D ^%ZTLOAD
 S %ZIS=0 D HOME^%ZIS
 K GMRCQUED,GMRCDEV1
 Q
END K GMRCDEV,GMRCDEV1,GMRCOREC,GMRCFMT
 Q
PROVDX(OI) ;return PROV DX prompting info from 123.5
 ;    Input:
 ;       OI = ref to file 123.5("#;99CON") or file 123.3 (#;99PRC)
 ;
 ;    Returns:  string  A^B
 ;       A = O (optional), R (required) or S (suppress)
 ;       B = F (free-text) or L (lexicon)
 ;
 N GMRCFIL
 Q:'+$G(OI) "^"
 S GMRCFIL=$S(OI["99PRC":123.3,1:123.5)
 Q:'$D(^GMR(GMRCFIL,+OI)) "^"
 N STRING,NODE
 I GMRCFIL=123.3 S NODE=$P(^GMR(123.3,+OI,0),U,7,8)
 I GMRCFIL=123.5 S NODE=$P($G(^GMR(123.5,+OI,1)),U,1,2)
 I NODE="" Q "O^F" ;values not set
 S $P(STRING,U)=$S($L($P(NODE,U)):$P(NODE,U),1:"O")
 S $P(STRING,U,2)=$S($L($P(NODE,U,2)):$P(NODE,U,2),1:"F")
 Q STRING
ORIFN(GMRC123) ;return ORIFN associated with give record in ^GMR(123,
 ; GMRC123 = ien of consult record in file 123
 Q $P($G(^GMR(123,GMRC123,0)),U,3)
GETDT(PROMPT,DEFAULT) ;prompt and return FM date
 ;Input:
 ;  PROMPT  = text of prompt - DIR("A")          (optional)
 ;  DEFAULT = default date to prompt - DIR("B")  (optional)
 ; 
 ;Output:
 ; FM date/time if successfully answered, "^" if exit or timeout
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="DA^::EPT"
 S DIR("?")="Enter the date/time the activity took place."
 S DIR("A")=$S($D(PROMPT):PROMPT_" ",1:"Actual Date/Time of Activity: ")
 S DIR("B")=$S($D(DEFAULT):DEFAULT,1:"NOW")
 D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S Y="^"
 Q Y
 ;
DCPRNT(IEN,USER) ;reprint SF-513 on DC?
 N SERV,REPR
 S SERV=$P(^GMR(123,IEN,0),U,5) I 'SERV Q 0
 S REPR=$P($G(^GMR(123.5,SERV,1)),U,5)
 I 'REPR Q 1
 I REPR=2 Q 0
 I REPR=1,'$$VALID^GMRCAU(SERV,IEN,USER) Q 1
 Q 0
 ;
PREREQ(GMRCARR,GMRCSRV,GMRCDFN,UNRESOLV) ; return service pre-requisite
 ; pre-requisite stored in 125 nodes in file 123.5 or 123.3
 ; GMRCARR = array to return containing pre-requisite
 ; GMRCSRV = ref to file 123.5 (ien;99CON) or 123.3 (ien;99PRC)
 ; GMRCDFN = patient identifier if to return resolved
 ; UNRESOLV = 1 or 0 ; if UNRESOLV=1 GMRCARR will be returned unresolved
 Q:'+GMRCSRV
 N GMRCFIL
 S GMRCFIL=$S(GMRCSRV["99PRC":123.3,1:123.5)
 Q:'$D(^GMR(GMRCFIL,+GMRCSRV,125))
 I '$D(GMRCDFN)!($G(UNRESOLV)) D  Q
 . M @GMRCARR=^GMR(GMRCFIL,+GMRCSRV,125)
 D BLRPLT^TIUSRVD(,,GMRCDFN,,$NA(^GMR(GMRCFIL,+GMRCSRV,125)))
 I $D(^TMP("TIUBOIL",$J)) M @GMRCARR=^TMP("TIUBOIL",$J)
 K ^TMP("TIUBOIL",$J)
 Q
 ;
LOCKREC(GMRCDA) ;attempt to lock a consult record using order or record
 ; Input:
 ;   GMRCDA  = ien of consult record from file 123
 ;
 ; Output: 
 ;     1 or 0^reason can't be locked  
 ;          1 = successfully locked
 ;          0 = couldn't be locked
 N GMRCORD,GMRCMSG
 S GMRCORD=$P($G(^GMR(123,GMRCDA,0)),U,3)
 I $G(GMRCORD) D  ;an order associated
 . S GMRCMSG=$$LOCK1^ORX2(GMRCORD)
 . ; GMRCMSG=1 if locked  or 0 if couldn't be locked
 I $L($G(GMRCMSG)) Q GMRCMSG
 ; no order = Inter-facility Consult so lock consult record
 L +^GMR(123,GMRCDA):5
 I '$T Q "0^Another user is editing this record" ; couldn't lock it
 Q 1
 ;
UNLKREC(GMRCDA) ;unlock a consult record
 ; Input:
 ;   GMRCDA  = ien of consult record from file 123
 ;
 N GMRCORD
 S GMRCORD=$P($G(^GMR(123,GMRCDA,0)),U,3)
 I $G(GMRCORD) D  Q
 . D UNLK1^ORX2(GMRCORD)
 L -^GMR(123,GMRCDA)
 Q
