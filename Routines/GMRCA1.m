GMRCA1 ;SLC/DLT,DCM - Actions taken from Review Screens ; 7/11/03 14:05
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,10,12,18,35**;DEC 27, 1997
 ; Patch 18 addS the option to Edit/Resubmit a canceled consult
 ; This routine invokes IA #867,#2424
 ;
DC(GMRCO,GMRCA) ;Discontinue/Cancel(Deny) logic
 ;GMRCO = File 123 IEN of consult
 ;GMRCA = Action to take: 6=DISCONTINUED, 19=CANCELLED
 ;GMRCOM=comments array
 I '$G(GMRCA) D  Q
 . S GMRCMSG="This Action not defined!"
 . D EXAC^GMRCADC(GMRCMSG)
 . D END
 . S GMRCQUT=1
 K GMRCQUT,GMRCQIT
 D DC^GMRCADC(GMRCO,GMRCA)
 D END
 Q
 ;
COMMENT(GMRCO) ;Add a comment without changing the status
 N GMRCA,GMRCLCK
 K GMRCQUT,GMRCQIT
 I '+$G(GMRCO) D SELECT^GMRCA2(.GMRCO) I $D(GMRCQUT) D END Q
 I '+$G(GMRCO) D END S GMRCQUT=1 Q
 I '$$LOCK(GMRCO) D END S GMRCQUT=1 Q
 S GMRCLCK=1
 D COMMENT^GMRCACMT(+GMRCO)
 D END
 Q
 ;
EDTSUB(GMRCO) ;Patch 18 Edit/Resubmit a canceled consult
 N GMRCA,GMRCLCK,GMRCDFN,GMRCMSG
 K GMRCQUT,GMRCQIT
 S XQORM("M")=3
 I '+$G(GMRCO) D SELECT^GMRCA2(.GMRCO) I $D(GMRCQUT) D END Q
 I '+$G(GMRCO) D END S GMRCQUT=1 Q
 ;
 ; Check to see if Provider or Update user is doing Edit/Resubmit
 I '$$VALPROV^GMRCEDIT(GMRCO) D
 .S GMRCMSG="0^You are not the provider of this Consult or a Update User"
 I $P(^GMR(123,GMRCO,0),"^",12)'=13 D     ; If not a canceled Consult
 . S GMRCMSG="0^This consult is no longer editable."
 I $D(GMRCMSG) D EXAC^GMRCADC($P(GMRCMSG,"^",2)) D END S GMRCQUT=1 Q
 I '$$LOCK(GMRCO) D END S GMRCQUT=1 Q
 S GMRCLCK=1
 S GMRCDFN=$P(^GMR(123,GMRCO,0),"^",2) ; Get patient DFN
 I $D(GMRCQUT) Q
 D EN^GMRCEDIT(GMRCO,","_+GMRCDFN)  ; Bring up Edit & Resubmit screen.
 D END
 Q
 ;
RC(GMRCO,GMRCSCH) ;Service tracking request received or scheduled
 ; GMRCSCH=1  - schedule action
 K GMRCQUT,GMRCQIT,GMRCSEL,GMRCAGN
 I '+$G(GMRCO) D SELECT^GMRCA2(.GMRCO) I $D(GMRCQUT) D END Q
 I '+$G(GMRCO) D END S GMRCQUT=1 Q
 I $P($G(^GMR(123,GMRCO,12)),U,5)="P" D  Q
 . N DIR
 . W !,"The requesting facility may not take this action on an "
 . W "inter-facility consult."
 . S DIR(0)="E" D ^DIR
 . D END
 . S GMRCQUT=1
 I '$$LOCK(GMRCO) D END S GMRCQUT=1 Q
 ;
 N GMRCDA,GMRCIFN,GMRCLCK,GMRCAD
 S GMRCLCK=1
 S GMRC(0)=^GMR(123,GMRCO,0)
 S DFN=$P(GMRC(0),"^",2)
 I $S($P(GMRC(0),"^",12)=2:1,$P(^(0),"^",12)=1:1,$P(^(0),"^",12)=13:1,1:0) D  S GMRCQUT=1 D END Q
 .S GMRCMSG="This consult has already been "_$S($P(GMRC(0),"^",12)=2:"Completed",$P(^(0),"^",12)=13:"Cancelled",1:"Discontinued")_"."
 .S GMRCMSG(1)=" This action may not be taken now."
 .D EXAC^GMRCADC(GMRCMSG)
 .K GMRCMSG
 .Q
 ;I $P(^GMR(123.5,$P(GMRC(0),"^",5),0),"^",2)=9 S GMRCMSG=$P(^(0),"^",1)_" is an INACTIVE service. No Receive action is possible",GMRCMSG(1)="for this consult on this Service!" D EXAC^GMRCADC(.GMRCMSG),END S GMRCQUT=1 Q
 I '$G(GMRCSCH),$P(GMRC(0),"^",12)'=5 D  Q
 . S GMRCMSG="The receive action may only be taken when the consult"
 . S GMRCMSG=GMRCMSG_" has a pending status."
 . D EXAC^GMRCADC(GMRCMSG),END
 . S GMRCQUT=1
 I $G(GMRCSCH),"56"'[$P(GMRC(0),"^",12) D  Q
 . S GMRCMSG="This consult may not be scheduled with the current status"
 . D EXAC^GMRCADC(GMRCMSG),END
 . S GMRCQUT=1
 ;
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 N GETPROV
 S GETPROV=$S($G(GMRCSCH):"Who scheduled it?",1:"Who received it?")
 D GETPROV^GMRCAU K GETPROV I $D(GMRCQIT) D END S GMRCQIT="Q",GMRCQUT=1 Q
 I '$G(GMRCSCH) S GMRCAD=$$GETDT^GMRCUTL1("Date/Time Actually Received")
 I $G(GMRCSCH) S GMRCAD=$$NOW^XLFDT
 I GMRCAD="^" D  Q
 . W !,$C(7) D EXAC^GMRCADC("Consult not updated with Received action.")
 . D END
 . S GMRCQUT=1
 ;The activity date is stored in GMRCAD
 I '$G(GMRCSCH) D
 . S GMRCA=21 ;for "Received"
 . I $P(GMRC(0),"^",12)=5 S GMRCSTS=6,$P(GMRC(0),"^",12)=GMRCSTS
 . E  S GMRCSTS=$P(GMRC(0),"^",12)
 I $G(GMRCSCH) S GMRCA=8,GMRCSTS=8
 D STATUS^GMRCP
 S GMRCOM=1 D AUDIT^GMRCP
 D EN^GMRCHL7(DFN,GMRCO,$G(GMRCTYPE),$G(GMRCWARD),"SC",GMRCORNP,$G(GMRCVSIT),.GMRCOM,,$G(GMRCAD))
 I $G(GMRCSCH),$P(GMRCOM,U,2)=1 D
 . N TXT S TXT="Scheduled Consult: "
 . D PROCALRT^GMRCACMT(TXT,"",20,GMRCO)
 D END
 Q
 ;
RT(GMRCO) ;Results Display logic
 K GMRCQUT,GMRCQIT
 I '+$G(GMRCO) D SELECT^GMRCA2(.GMRCO) I $D(GMRCQUT) D END Q
 I '+$G(GMRCO) D END S GMRCQUT=1 Q
 D RT^GMRCART(GMRCO)
 D END
 Q
 ;
PS(GMRCO) ;Print Service Copy (CPRS entry point)
 K GMRCQUT,GMRCQIT,GMRCSEL
 I '+$G(GMRCO) D SELECT^GMRCA2(.GMRCO) I $D(GMRCQUT) D END Q
 I '+$G(GMRCO) D END S GMRCQUT=1 Q
 S GMRC(0)=^GMR(123,GMRCO,0)
 D EN^GMRCP5(GMRCO)
 D END
 Q
 ;
END ;kill off variables and exit
 I $G(GMRCLCK) D UNLOCK(GMRCO)
 I '$D(GMRC("NMBR")) K GMRCSEL,GMRCO
 K GMRC(0),GMRCA,GMRCACTM,GMRCAGN,GMRCDFN,GMRCENTR,GMRCFL,GMRCIEN,GMRCMSG,GMRCOM,GMRCO,GMRCORFN,GMRCORN,GMRCORTX,GMRCRTFL,GMRCSEL,GMRCSTS,GMRCTRLC,GMRCEND,GMRCSA,GMRCSR,GMRCBM,GMRCTM,GMRCADUZ,ORIFN,OREND,SF,STS
 I $D(DTOUT)!$D(DIROUT) S GMRCQIT=""
 K DTOUT,DIROUT,DUOUT
 S:$D(^TMP("GMRC",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 Q
LOCK(GMRCIFN) ;;lock a consult record using OE/RR order number
 N GMRCORD,GMRCLOCK
 S GMRCORD=$P($G(^GMR(123,GMRCIFN,0)),U,3) Q:'GMRCORD 1
 S GMRCLOCK=$$LOCK1^ORX2(GMRCORD) I +GMRCLOCK Q 1
 ;Q:$G(GMRCGUI)
 D EXAC^GMRCADC($P(GMRCLOCK,U,2))
 Q 0
UNLOCK(GMRCIFN) ;unlock a consult record using OE/RR order number
 N GMRCORD
 S GMRCORD=$P($G(^GMR(123,GMRCIFN,0)),U,3) Q:'GMRCORD
 D UNLK1^ORX2(GMRCORD)
 Q
