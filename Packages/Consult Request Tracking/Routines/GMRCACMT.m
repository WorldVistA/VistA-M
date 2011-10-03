GMRCACMT ;SLC/DLT,DCM,MA,JFR - Comment Action and alerting ;8/19/03 07:27
 ;;3.0;CONSULT/REQUEST TRACKING;**4,14,18,20,22,29,35,47,55**;DEC 27, 1997;Build 4
 ; This routine invokes IA #10060
 ;
COMMENT(GMRCO) ;Add a comment without changing the status
 K GMRCQIT,GMRCQUT N GMRCA
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 S GMRCNOW=$$NOW^XLFDT,GMRCAD=GMRCNOW
 S GMRCOM=1,GMRCA=20,GMRCPROV=$P(^GMR(123,GMRCO,0),"^",14) D AUDIT^GMRCP
 ; GMRCOM=1 defined the variable and tells AUDIT^GMRCP that the 
 ; word-processing logic should be executed. If an actual comment is 
 ; added, $P(GMRCOM,"^",2)=1 (send alert), if not GMRCOM=1 and no '^' 
 ; exists (do not send alert)
 I $G(GMRCERR)=1 S GMRCMSG=GMRCERMS D EXAC^GMRCADC(GMRCMSG),END Q
 ;continue if no lock problems occurred
 I $P(GMRCOM,"^",2) D
 . I $P($G(^GMR(123,GMRCO,12)),U,5)="F" D
 .. W !!,"The ordering provider for this inter-facility consult will"
 .. W " automatically be ",!,"notified.",!
 . D PROCALRT("",1,20,GMRCO)
 . ;update LAST ACTION field even though no status change
 . N GMRCDR,GMRCSTS
 . S GMRCSTS="",GMRCDR="9////20"
 . D STATUS^GMRCP
 D END
 Q
 ;
PROCALRT(GMRCORTX,GMRCDELR,ACTION,GMRCO) ;Process alert for comments
 ;If GMRCDELR=1, the ordering provider can be deleted from the list.
 N GMRCADUZ,GMRCANS,NOTIF,GMRCQIT,GMRCTM
 ;S GMRCANS=$$READ("Y","Do You Wish To Send An Alert With This Comment","N","Enter Y to continue with recipient prompts. Otherwise, enter N.",1)
 ;I (GMRCANS[U)!(GMRCANS=0) D END Q
 ;
 D WHOTO
 ;I $G(GMRCQIT) D END Q  ;User "^" at requesting provider.
 ;
 N GMRCALT
 S NOTIF=$S(ACTION=20:63,ACTION=8:63,1:23)
 ;
 D SENDMSG(NOTIF,+GMRCO,$G(GMRCTM))
 Q
 ;
SENDMSG(NOTIF,GMRCO,GMRCATM) ;Send the alert
 N GMRCDFN
 I '$D(GMRCADUZ) S GMRCADUZ=""
 W !,"Processing Alerts..."
 S GMRCDFN=$P($G(^GMR(123,+GMRCO,0)),"^",2)
 I '$L(GMRCORTX) D
 . N TXT
 . S TXT="Comment Added to "
 . I $P($G(^GMR(123,GMRCO,12)),U,5)'="P" S GMRCORTX=TXT_"consult " Q
 . S GMRCORTX=TXT_"remote consult "
 S GMRCORTX=GMRCORTX_$$ORTX^GMRCAU(+GMRCO)
 D MSG^GMRCP(GMRCDFN,GMRCORTX,+GMRCO,NOTIF,.GMRCADUZ,$G(GMRCATM))
 Q
 ;
END ;kill off variables and exit
 K GMRC,GMRCA,GMRCMSG,GMRCOM,GMRCO,GMRCORTX,GMRCERR,GMRCERMS,GMRCQUT,GMRCUT
 I $D(DTOUT)!$D(DIROUT) S GMRCQIT=""
 K DTOUT,DIROUT,DUOUT,DIRUT
 S:$D(^TMP("GMRC",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 Q
 ;
WHOTO ;Get the users who should receive an alert
 ;Asks about requesting provider first, then prompts for additional users
 ;Returns GMRCADUZ array of users to send an alert to and GMRCQIT if "^"
 N GMRCRP,GMRCANS,GMRCUPD
 S GMRCRP=+$P($G(^GMR(123,+GMRCO,0)),U,14) ;requesting provider entry
 S GMRCUPD=$$VALID^GMRCAU($P(^GMR(123,+GMRCO,0),U,5),GMRCO,DUZ)
 I GMRCRP=DUZ D  ;alert team if ord. prov. takes the action
 . S GMRCTM=1
 . W !,"Service update users will be notified.",!
 I +GMRCUPD>1,GMRCRP'=DUZ D  ; alert ord. prov if update users takes action
 . S GMRCADUZ(GMRCRP)=""
 . W !,"Requesting provider will be notified.",!
 I '$G(GMRCTM),+GMRCUPD<2 D  ;alert both if not ord. prov or update user
 . S GMRCTM=1,GMRCADUZ(GMRCRP)=""
 . W !,"Requesting provider and service update users will be notified.",!
 ;
 ;
ANDTO ;Ask for additional recipients
 D NAMELIST("Additional alert recipients: ",.GMRCADUZ,GMRCDELR)
 Q
 ;
NAMELIST(GMRCP,GMRCOLD,GMRCDELR) ;manage the list of recipients
 ;
 ; GMRCP - Prompt
 ; GMRCOLD - Original list with ordering provider.
 ; GMRCDELR - 1 means the original list may have names deleted
 ; Returns final list in GMRCOLD array
 ;
 N GMRCNEW,GMRCNT,GMRCDUZ,GMRCUSER,GMRCQ,GMRCADD,DIC,X,Y
 ;
 M GMRCNEW=GMRCOLD
 I GMRCDELR=1 K GMRCOLD S GMRCOLD="" ;Remove mandatory users from GMRCOLD
 S GMRCNT=0 F  D  Q:(GMRCUSER[U)
 .S GMRCUSER=$$READ("FAO;3;46",$S(GMRCNT:"And ",1:"")_GMRCP,"","^D NAMEHELP^GMRCACMT")
 .S:'$L(GMRCUSER) GMRCUSER=U Q:(GMRCUSER[U)
 .I ($E(GMRCUSER,1)="-") S GMRCADD=0,GMRCUSER=$E(GMRCUSER,2,$L(GMRCUSER))
 .E  S GMRCADD=1
 .;
 .S X=GMRCUSER,DIC=200,DIC(0)="EMQ" D ^DIC
 .;
 .I (Y>0) D  I 1
 ..;W $E($P(Y,U,2),$L(GMRCUSER)+1,$L($P(Y,U,2)))
 ..;
 ..I GMRCADD D
 ...I $D(GMRCNEW(+Y)) W " already in the list." Q
 ...S GMRCNEW(+Y)="" W " added to the list." S GMRCNT=GMRCNT+1
 ..;
 ..I 'GMRCADD D
 ...I $D(GMRCOLD(+Y)) W " can't delete this name from the list." Q
 ...I '$D(GMRCNEW(+Y)) W " not currently in the list." Q
 ...K GMRCNEW(+Y) S GMRCNT=GMRCNT-1 W " deleted from the list."
 .;
 .E  I $L(GMRCUSER) W "  Name not found."
 ;
 M GMRCOLD=GMRCNEW
 Q
 ;
READ(GMRC0,GMRCA,GMRCB,GMRCH,GMRCL) ;read logic
 ;
 ;  GMRC0 -> DIR(0) --- Type of read
 ;  GMRCA -> DIR("A") - Prompt
 ;  GMRCB -> DIR("B") - Default Answer
 ;  GMRCH -> DIR("?") - Help text or ^Execute code
 ;  GMRCL -> Number of blank lines to put before Prompt
 ;
 ;  Returns "^" or answer
 ;
 N GMRCLINE,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q:'$L($G(GMRC0)) U
 S DIR(0)=GMRC0
 S:$L($G(GMRCA)) DIR("A")=GMRCA
 S:$L($G(GMRCB)) DIR("B")=GMRCB
 S:$L($G(GMRCH)) DIR("?")=GMRCH
 F GMRCLINE=1:1:($G(GMRCL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
 ;
NAMEHELP ;Help for the recipient list logic
 N GMRCDUZ
 W !,"Enter the name of the user to send the alert to,"
 W !," or put a '-' in front of a name to delete from the list."
 W !
 W !,"  Example:"
 W !,"     SMITH,FRED  ->  to add Fred to the list."
 W !,"     -SMITH,FRED ->  to delete Fred from the list."
 W !,"Already selected: "
 W !
 S GMRCDUZ=0 F  S GMRCDUZ=$O(GMRCNEW(GMRCDUZ)) Q:'GMRCDUZ  D
 .W !,?5,$P(^VA(200,GMRCDUZ,0),U,1)
 .W:$D(GMRCOLD(GMRCDUZ)) "  <mandatory>"
 W !
 Q
 ;
