GMRCDRFR ;SLC/JFR - DEFAULT REASON FOR REQUEST UTILS ; 11/12/00 12:00
 ;;3.0;CONSULT/REQUEST TRACKING;**12,15**;DEC 27, 1997
 ;
 ; This routine invokes IA #2876
 ;
EN ; -- main entry point for GMRC DEFAULT REASON
 N GMRCSV,GMRCDFN,DIR,X,Y,DUOUT,DTOUT,DIROUT,DIRUT
 S DIR(0)="SOA^S:service;P:procedure"
 S DIR("A")="Test default for service or procedure? "
 D ^DIR I $D(DIRUT) Q
 I Y="S" D SELSS Q:'$D(GMRCSV)
 I Y="P" D SELPROC Q:'$D(GMRCPROC)
 D SELPT Q:'$D(GMRCPAT)
 D INIT
 D EN^VALM("GMRC DEFAULT REASON")
 Q
 ;
SELPT ;get new patient 
 N DIR,X,Y,DIRUT,DUOUT,DTOUT
 D FULL^VALM1
 S DIR(0)="PO^2:EQM" D ^DIR
 I $D(DIRUT) Q
 S GMRCPAT=+Y
 K ^TMP("GMRCRFR",$J)
 Q
 ;
SELSS ; get new service
 N DIR,X,Y,DIRUT,DUOUT,DTOUT
 D FULL^VALM1
 K GMRCSV,GMRCPROC
 S DIR(0)="PO^123.5:EMQ",DIR("A")="Select Service"
 D ^DIR
 I $D(DIRUT) Q
 S GMRCSV=+Y_";99CON"
 K ^TMP("GMRCRFR",$J)
 Q
 ;
SELPROC ; get a new procedure
 ;
 N DIR,X,Y,DIRUT,DUOUT,DTOUT
 D FULL^VALM1
 K GMRCSV,GMRCPROC
 S DIR(0)="PO^123.3:EMQ",DIR("A")="Select Procedure"
 D ^DIR
 I $D(DIRUT) Q
 S GMRCPROC=+Y_";99PRC"
 K ^TMP("GMRCRFR",$J)
 Q
 ;
HDR ; -- header code
 I $D(GMRCPROC) S VALMHDR(1)="Procedure: "_$P(^GMR(123.3,+GMRCPROC,0),U)
 I $D(GMRCSV) S VALMHDR(1)="Service: "_$P(^GMR(123.5,+GMRCSV,0),U)
 S VALMHDR(2)="Patient: "_$$GET1^DIQ(2,+GMRCPAT,.01)
 Q
 ;
INIT ; -- init variables and list array
 Q:$D(^TMP("GMRCRFR",$J))
 D GETDEF($NA(^TMP("GMRCRFR",$J)),$S($D(GMRCSV):GMRCSV,1:GMRCPROC),GMRCPAT,1)
 I '$D(^TMP("GMRCRFR",$J)) D
 . S ^TMP("GMRCRFR",$J,1,0)="No default Reason for Request exists for the selected item."
 S VALMCNT=$O(^TMP("GMRCRFR",$J,999999),-1)
 S VALMBG=1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K GMRCSV,GMRCPAT,GMRCPROC
 Q
 ;
EXPND ; -- expand code
 Q
 ;
GETDEF(GMRCARR,GMRCSRV,GMRCDFN,RESOLV) ; return default reason for request
 ; GMRCARR = array to return containing default RFR
 ; GMRCSRV = reference to file 123.5 (#;99CON) or file 123.3 (#;99PRC)
 ; GMRCDFN = patient identifier if to return resolved
 ; RESOLV = 1 or 0 ; if RESOLV=1 GMRCARR will be returned resolved 
 Q:'+GMRCSRV
 N GMRCFIL
 S GMRCFIL=$S(GMRCSRV[";99PRC":123.3,1:123.5)
 Q:'$D(^GMR(GMRCFIL,+GMRCSRV,124))
 I '$D(GMRCDFN)!('$G(RESOLV)) D  Q
 . M @GMRCARR=^GMR(GMRCFIL,+GMRCSRV,124)
 D BLRPLT^TIUSRVD(,,GMRCDFN,,$NA(^GMR(GMRCFIL,+GMRCSRV,124)))
 I $D(^TMP("TIUBOIL",$J)) M @GMRCARR=^TMP("TIUBOIL",$J)
 K ^TMP("TIUBOIL",$J)
 Q
REAF(GMRCOI) ;return value of RESTRICT DEFAULT REASON EDIT field to CPRS
 ;Input:
 ;  GMRCOI - ref to file 123.5 (ien;99CON) or file 123.3 (ien;99PRC)
 ;Output:
 ; Integer    0 - unrestricted
 ;            1 - ask on edit only
 ;            2 - no editing
 ;
 N FILE
 S FILE=$S(GMRCOI["99PRC":123.3,1:123.5)
 I '$O(^GMR(FILE,+GMRCOI,124,0)) Q 0
 I FILE=123.5 Q +$P($G(^GMR(FILE,+GMRCOI,1)),U,3) ;cslt service
 Q +$P($G(^GMR(FILE,+GMRCOI,0)),U,9) ;procedure
