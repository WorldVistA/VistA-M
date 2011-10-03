FBUCUPD(FBUCP,FBUCPA,FBUCA,FBUCAA,FBDA,FBACT,FBUCDISR) ;ALBISC/TET - UPDATE AFTER EVENT ;11/15/01
 ;;3.5;FEE BASIS;**8,27,38**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
UPDATE ;update if before and after values differ
 ;INPUT:  FBUCP - zero node of 162.7, prior
 ;        FBUCPA- 'A' (appeal)  node of 162.7, prior
 ;        FBUCA - zero node of 162.7, after
 ;        FBUCAA- 'A' (appeal) node of 162.7, after
 ;        FBDA    - IEN of 162.7
 ;        FBACT - action type
 ;        FBUCDISR - (option) exists if disapp.
 ;           1 = denial reasons for gr to be same as prim
 ;           0 = ask denial reason for each claim in gr
 ;VARIABLES:
 ;        FBSTATUS - 0 if no change, or status ien to 162.92
 ;        FBORDER  - order number of status in 162.92
 ;        FBLET    - = 1 if status or disp. changed (letter should be printed)
 ;        FBDISP   - flag if disp. changed to approved from other
 ;                    than approved.  1 to delete disap. reasons
 ;                                    0 no action
 ;        FBDISPDT - date disp. changed, 0 if no change, "@" to delete
 ;        FBEXP    - exp. date, 0 if no change, "@" to delete
 ;                    or new date in internal format
 ;        FBVALID  - valid date claim rec., 0 if no change, "@" to delete
 ;                    or today's date in internal format
 ;        FBORIG   - date of original disp. or "@" to delete
 ;                    to approve.  1 is to set in file 161, 0 is to delete.
 I $S('+$G(FBDA):1,$G(FBACT)']"":1,$G(FBUCA)']"":1,1:0) G END
AUTH ;determine if auth. needs to be updated, based upon disp.
 ;returns variable FBAUTH, may returne FBOUT
 D AUTH^FBUCUPD1(FBUCP,FBUCA,FBDA,FBACT)
 ;
Q ;enter code to task remainder of update here
 ;S ZTRTN="DQ^FBUCUPD",ZTDESC="UPDATE UNAUTH CLAIM",ZTDTH=$H,ZTIO="",ZTSAVE("FBUCP")="",ZTSAVE("FBUCPA")="",ZTSAVE("FBUCA")="",ZTSAVE("FBUCAA")="",ZTSAVE("FBDA")="" S:$D(FBAUTH) ZTSAVE("FBAUTH")=""
 ;D ^%ZTLOAD G END
 ;
DQ ;de-queue tasked job here
 D:$D(XRTL) T0^%ZOSV ;start monitor
 N FBD1,FBD2,FBDISP,FBDISPDT,FBEXP,FBLET,FBORDER,FBORIG,FBST,FBSTATUS,FBUC,FBVALID S (FBDISP,FBDISPDT,FBEXP,FBLET,FBORDER,FBORIG,FBSTATUS,FBVALID)=0,FBUC=$$FBUC^FBUCUTL2(1)
 ;
STATUS ;determine status of claim
 ;FBST=status of claim prior to update;updated to most current
 S FBST=$$ORDER^FBUCUTL(+$P(FBUCA,U,24)) I FBST<40 S FBST=$S($$PEND^FBUCUTL(FBDA):10,$P(FBUC,U,7)&(FBACT="ENT"):5,1:30)
 ;
DISP ;dispostion change
 I $P(FBUCP,U,11)'=$P(FBUCA,U,11),$P(FBUCA,U,11) D
 .S FBST=$S($P(FBUCAA,U,6):90,$P(FBUCAA,U,4):70,1:40)
 .S FBDISPDT=DT,FBORIG=$S('$P(FBUCP,U,11)&(FBST=40):DT,1:0)
 I $P(FBUCP,U,11)'=$P(FBUCA,U,11),'$P(FBUCA,U,11) D
 .N FBO S FBO=$$ORDER^FBUCUTL(+$P(FBUCP,U,24))
 .I FBO=90 S FBST=$S($P(FBUCAA,U,5):80,1:70)
 .I FBO=70 S FBST=$S($P(FBUCAA,U,3):60,$P(FBUCAA,U,2):55,$P(FBUCAA,U):50,1:40)
 .I FBO=40 S FBST=$S($$PEND^FBUCUTL(FBDA):10,1:30)
 .S FBDISPDT="@",FBORIG=$S($$ORDER^FBUCUTL($P(FBUCP,U,24))=40:"@",1:0)
 I $P(FBUCP,U,11)'=$P(FBUCA,U,11) S FBLET=1 S FBD1=$P(FBUCP,U,11),FBD2=$P(FBUCA,U,11) I "^2^3^5^"[FBD1,"^1^4^"[FBD2 S FBDISP=1
 I $P(FBUCP,U,11)=$P(FBUCA,U,11),FBUCPA=FBUCAA S FBST=$S($P(FBUCA,U,11):40,1:FBST)
 ;
APPEAL ;appeal change - check if disposition remains unchanged
 I FBUCAA]""!(FBUCPA'=FBUCAA) D
 .I $P(FBUCAA,U,2)&($P(FBUCA,U,11)=5) S FBST=70 Q
 .S FBST=$S('$P(FBUCAA,U):40,'$P(FBUCAA,U,2):50,'$P(FBUCAA,U,3):55,'$P(FBUCAA,U,4):60,'$P(FBUCAA,U,5):70,'$P(FBUCAA,U,6):80,$P(FBUCAA,U,6):90,$P(FBUCAA,U,5):80,$P(FBUCAA,U,4):70,$P(FBUCAA,U,3):60,$P(FBUCAA,U,2):55,$P(FBUCAA,U):50,1:FBST)
 ;
 S FBORDER=FBST,FBSTATUS=$$STATUS^FBUCUTL(FBORDER) S:FBORIG]"" $P(FBUCA,U,22)=$S(FBORIG="@":"",FBORIG=0:"",1:FBORIG)
 I FBSTATUS,FBSTATUS'=$P(FBUCA,U,24)!(FBUCP']"")!((FBORDER=10)&("^ENT^REQ^"[FBACT)) D
 .S FBLET=$S(FBORDER=10:1,FBORDER=40&(FBACT="ENT"):1,FBORDER=$$ORDER^FBUCUTL(+$P(FBUCA,U,24)):0,1:1) I FBLET S FBLET=$S($$LETTER^FBUCUTL2(FBORDER):1,1:0)
 .S FBVALID=$S(FBORDER>20&('$P(FBUCA,U,8))&('$$PEND^FBUCUTL(FBDA)):DT,FBORDER<20&($P(FBUCA,U,8)):"@",1:0)
 I FBACT="REC" N FBEXPD27 S FBEXPD27=$S(+$P(FBUCA,U,26)>0:0,+$P(FBUCA,U,19)>0:+$P(FBUCA,U,19),1:0)
 S:'FBLET FBEXP=$$EXPIRE^FBUCUTL8(FBDA,$S(FBORDER>$$ORDER^FBUCUTL(+$P(FBUCA,U,24)):$S('$P(FBUCA,U,25):DT,1:+$P(FBUCA,U,25)),FBACT="REC":$S($D(FBEXPD27):FBEXPD27,1:0),FBORDER=55:+$P(FBUCAA,U,2),1:DT),FBUCA,FBORDER)
 ;
DIE ;die update
 I $S(FBSTATUS:1,FBVALID'=0:1,FBEXP'=0:1,FBLET:1,FBORIG'=0:1,FBDISPDT'=0:1,1:0) S DA=FBDA,DIE="^FB583(",DR="[FB UNAUTHORIZED UPDATE]" D
 .D LOCK^FBUCUTL(DIE,DA,1) I FBLOCK D ^DIE D  L -^FB583(FBDA)
 ..I FBUCP'=FBUCA!(FBUCPA'=FBUCAA) S DR="27////^S X=DUZ;28///^S X=DT" D
 ...I $P(FBUCAA,U,2)&($P(FBUCA,U,11)=5) S DR=DR_";53///^S X=DT"
 ...D ^DIE
 .K DIE,DA,DR,DQ,FBLOCK
 .D:FBDISP DELDAP^FBUCUTL3(FBDA)
 .I $G(FBUCDISR)=0!($P($G(FBUCDISR),U)=1) D DISAPR^FBUCUTL8
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ;stop monitor
 ;
LETTER ;letter denoting change of status or disposition
 N FBLETDT I FBLET,"^1^4^"'[(U_$P(FBUCA,U,11)_U) D AUTO^FBUCLET(FBDA,FBORDER,FBUCA,FBUC) ;print letter/update fields if letter prints
END ;kill variables and quit
 K FBAUTH,FBLOCK,FBUCAA,FBUCP,FBUCPA,XRT0,XRTN,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE Q
