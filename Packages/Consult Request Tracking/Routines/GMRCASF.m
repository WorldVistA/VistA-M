GMRCASF ;SLC/DLT - Significant Findings Action ;7/11/03 13:28
 ;;3.0;CONSULT/REQUEST TRACKING;**4,10,14,22,29,35**;DEC 27, 1997
SF(GMRCO) ;Evaluate Significant Findings and update accordingly
 ;GMRCO is the selected consult
 N GMRCQIT,GMRCLCK
 I '$L($G(GMRCO)) D SELECT^GMRCA2(.GMRCO)  I $D(GMRCQUT) D END Q
 I '+($G(GMRCO)) D END Q
 I $P($G(^GMR(123,GMRCO,12)),U,5)="P" D  Q
 . N DIR
 . W !,"The requesting facility may not take this action on an "
 . W "inter-facility consult."
 . S DIR(0)="E" D ^DIR
 . D END
 I '$$LOCK^GMRCA1(GMRCO) D END Q
 S GMRCLCK=1
 ;
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 N GMRC,GMRCSTS,GMRCSF,GMRCSFO,GMRCORTX,GMRCDR
 S GMRC(0)=$G(^GMR(123,+GMRCO,0)) Q:GMRC(0)=""
 ;
 S GMRCSFO=$P(GMRC(0),"^",19)
 W !!,"Current Significant Findings = "_$S(GMRCSFO="U":"Unknown",GMRCSFO="Y":"Yes",GMRCSFO="N":"No",1:"not entered yet"),!!
 S GMRCSF=$$GETSIGF(GMRCSFO)
 I GMRCSF=0 D END Q
 ; If no change in old and new value ask if should continue
 I GMRCSF=GMRCSFO D  I 'Y D END Q
 . W !,"The old and new Significant Findings are the same."
 . N DIR,DA,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR("A")="Do you want to proceed with this action"
 . S DIR(0)="Y"
 . S DIR("B")="NO"
 . D ^DIR
 . I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S Y=0 Q
 . I Y=0 Q
 ;
 ;Update last action and sig findings but don't change the status
 S GMRCSTS=$P(GMRC(0),"^",12),GMRCA=4
 S GMRCDR="8////^S X=GMRCSTS;9////^S X=GMRCA;15////^S X=GMRCSF"
 D STATUS^GMRCP
 I $G(GMRCERR)=1 S GMRCMSG=GMRCERMS D EXAC^GMRCADC(GMRCMSG),END Q
 ;
 ;GMRCOM=1 tells AUDIT^GMRCP to do the word-processing logic
 ;If an actual comment is added, $P(GMRCOM,"^",2)=1 (send alert),
 ; if not GMRCOM=1 and no '^' exists (do not send alert)
 S GMRCOM=1 D AUDIT^GMRCP
 I $G(GMRCERR)=1 S GMRCMSG=GMRCERMS D EXAC^GMRCADC(GMRCMSG),END Q
 ;
 I GMRCSTS=2 D EN^GMRCHL7($P(^GMR(123,GMRCO,0),U,2),GMRCO,$G(GMRCTYPE),$G(GMRCRB),"RE",GMRCORNP,$G(GMRCVSIT),,,$G(GMRCAD))
 D SETORTX
 I GMRCSTS=2 D SENDALRT(GMRCORTX) Q
 I +$P(GMRCOM,"^",2) D
 . W !,"An alert with the following text will be sent if recipients are selected: "
 . W !,"     "_GMRCORTX_$$ORTX^GMRCAU(+GMRCO)
 . W !
 . I GMRCSTS'=2 W !,"or the alert will be sent when the order is completed.",!
 . I $P($G(^GMR(123,GMRCO,12)),U,5)="F" D
 . W !!,"The ordering provider for this inter-facility consult will "
 . W "automatically be ",!,"notified.",!
 . D PROCALRT^GMRCACMT(GMRCORTX,1,4,GMRCO)
 . ;For consults not completed, the original provider may be deleted from
 . ;the recipient list for the alert.
 D END
 Q
 ;
SETORTX ;Set prefix text for the alert
 S GMRCORTX=$S(GMRCSF="N":"No ",GMRCSF="Y":"",1:"Unknown ")
 S GMRCORTX=GMRCORTX_"Sig Findings for "_$P($G(^ORD(100.01,+GMRCSTS,0)),"^",2)_" consult " Q
 Q
 ;
SENDALRT(GMRCORTX) ;Send to the requesting provider
 N GMRCRP,GMRCADUZ,GMRCDELR
 S GMRCRP=$P($G(^GMR(123,+GMRCO,0)),U,14) ;requesting clinician
 I +GMRCRP S GMRCADUZ(+GMRCRP)=""
 W !,"Alert will be sent to Requesting Provider: "_$P($G(^VA(200,+GMRCRP,0)),U,1)
 S GMRCDELR=0
 D ANDTO^GMRCACMT
 D SENDMSG^GMRCACMT(23,+GMRCO)
 ;Sig Findings uses the CONSULT/REQUEST RESOLUTION (23) notification
 Q
 ;
GETSIGF(GMRCSFO) ;Get the significant findings
 ;GMRCSFO is the old significant findings value
 N DIR,DA,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="123,15"
 S DIR("B")=GMRCSFO
 S:DIR("B")="" DIR("B")="unknown"
 S DIR("A")="Are there significant findings? (Y/N/U)"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q 0
 Q Y
 ;
END ;cleanup variables
 I $G(GMRCLCK) D UNLOCK^GMRCA1(GMRCO)
 K GMRCO,GMRCA,GMRCMSG,GMRCOM,GMRCSEL,GMRCERR,GMRCERMS
 I $D(DTOUT)!$D(DIROUT) S GMRCQIT=""
 S:$D(^TMP("GMRC",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 Q
