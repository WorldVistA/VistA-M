GMRCAFRD ;SLC/DLT,DCM,JFR - LM FORWARD ACTION ;7/11/03 14:02
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,10,12,15,22,35,39,64**;DEC 27, 1997;Build 20
 ;
 ; This routine invokes IA #2395
 ;
FR(GMRCO) ;Forward Request to a new service
 N ORVP,GMRCLCK,DFN,GMRCACT,GMRCSEQ,GMRCDOC
 W !!,"Forward Request To Another Service For Action."
 W !,"Select the service to send the consult to.",!
 S:$D(GMRCSS) GMRCSSS=GMRCSS
 N GMRCPL,GMRCPR,GMRCURG,GMRCDG,GMRCFF,GMRCORNP,GMRCAD,GMRCTO,GMRCADUZ,GMRCATTN,NEWATTN,GMRCPA
 K GMRCQUT,GMRCSEL,GMRCSSS
 I '$L($G(GMRCO)) D SELECT^GMRCA2(.GMRCO) I $D(GMRCQUT) D END Q
 I '+$G(GMRCO) D END S GMRCQUT=1 Q
 I $P($G(^GMR(123,GMRCO,12)),U,5)="P" D  Q
 . N DIR
 . W !,"The requesting facility may not take this action on an "
 . W "inter-facility consult."
 . S DIR(0)="E" D ^DIR
 . D END
 . S GMRCQUT=1
 I '$$LOCK^GMRCA1(GMRCO) D END S GMRCQUT=1 Q
 S GMRCLCK=1
 ;
 I $P(^GMR(123,GMRCO,0),"^",12)<3 S GMRCMSG="NO ACTION POSSIBLE. This Consult Has Already Been Completed Or Discontinued." D EXAC^GMRCADC(GMRCMSG),END S GMRCQUT=1 Q
 I $P(^GMR(123,GMRCO,0),"^",12)=13 S GMRCMSG="NO ACTION POSSIBLE. This Consult Has Already Been Cancelled." D EXAC^GMRCADC(GMRCMSG),END S GMRCQUT=1 Q
 I $P(^GMR(123,GMRCO,0),"^",12)=9 D  Q:+$G(GMRCQUT)
 .S GMRCMSG="Invalid action. This consult has partial results."
 .S GMRCMSG(1)="Remove the associated results before forwarding."
 .D EXAC^GMRCADC(.GMRCMSG),END S GMRCQUT=1 Q
 S GMRCSEQ=0,GMRCDOC="" F  S GMRCSEQ=$O(^GMR(123,+GMRCO,50,GMRCSEQ)) Q:GMRCSEQ=""  D  Q:+$G(GMRCQUT)
 . I $P($G(^GMR(123,+GMRCO,50,GMRCSEQ,0)),";",2)="TIU(8925," S GMRCDOC=$P(^GMR(123,+GMRCO,50,GMRCSEQ,0),";",1)
 . I $G(GMRCDOC)="" Q
 . I $P($G(^TIU(8925,GMRCDOC,0)),U,5)=5 D
 . . S GMRCMSG="Invalid Action. This consult has an unsigned note."
 . . D EXAC^GMRCADC(.GMRCMSG),END S GMRCQUT=1 Q
 . I $P($G(^TIU(8925,GMRCDOC,0)),U,5)=6 D
 . . S GMRCMSG="Invalid Action. This consult has an uncosigned note."
 . . D EXAC^GMRCADC(.GMRCMSG),END S GMRCQUT=1 Q
 Q:+$G(GMRCQUT)  S GMRCSEQ=0,GMRCDOC="" F  S GMRCSEQ=$O(^GMR(123,+GMRCO,40,GMRCSEQ)) Q:GMRCSEQ=""  D  Q:+$G(GMRCQUT)
 . I $P($P($G(^GMR(123,+GMRCO,40,GMRCSEQ,0)),U,9),";",2)="TIU(8925," S GMRCDOC=$P($P($G(^GMR(123,+GMRCO,40,GMRCSEQ,0)),U,9),";",1)
 . I $G(GMRCDOC)="" Q
 . I $P($G(^TIU(8925,GMRCDOC,0)),U,5)=5 D
 . . S GMRCMSG="Invalid Action. This consult has an unsigned note."
 . . D EXAC^GMRCADC(.GMRCMSG),END S GMRCQUT=1 Q
 . I $P($G(^TIU(8925,GMRCDOC,0)),U,5)=6 D
 . . S GMRCMSG="Invalid Action. This consult has an uncosigned note."
 . . D EXAC^GMRCADC(.GMRCMSG),END S GMRCQUT=1 Q
 Q:+$G(GMRCQUT)
 ;
 I $D(IOBM),$D(IOTM),$D(IOSTBM) D FULL^VALM1
 I $P(^GMR(123,GMRCO,0),"^",16) W !!,"This is a SERVICE ENTERED order stub.  Please send the written consult to the",!,"Service, in addition to the automated forwarding!"
 S DFN=+$P(^GMR(123,GMRCO,0),"^",2)
 S GMRCTO=1,GMRCASV="Forward Consult To Which Service/Specialty: "
 D ASRV^GMRCASV K GMRCASV I $S($D(DTOUT):1,$D(DIROUT):1,$D(GMRCQUT):1,1:0) D END Q
 I 'GMRCDG S GMRCMSG="No Service Was Selected. Consult Was Not Forwarded To Any Service!" D EXAC^GMRCADC(GMRCMSG),END S GMRCQUT=1 Q
 S GMRCFF=$P(^GMR(123,GMRCO,0),"^",5) I GMRCFF=+GMRCDG S GMRCMSG="The Forwarding Service Cannot Forward A Consult To Itself!" D EXAC^GMRCADC(GMRCMSG),END S GMRCQUT=1 Q
 S GMRCATTN=$P($G(^GMR(123,GMRCO,0)),"^",11)
 N DIE,DR
 S DIE="^GMR(123,",DA=GMRCO,DR="7//"_$S($G(GMRCATTN)'="":GMRCATTN,1:"")
 D ^DIE
 S NEWATTN=$P($G(^GMR(123,+GMRCO,0)),"^",11)
 I NEWATTN'=GMRCATTN S GMRCPA=$G(GMRCATTN)
 S GETPROV="Who is responsible for Forwarding the Consult?"
FRGTPRV D GETPROV^GMRCAU I '$D(GMRCORNP) D END S GMRCQUT=1 Q
 S GMRCACT=$$PROVIDER^XUSER(GMRCORNP) I $P(GMRCACT,U)'=1 D  G FRGTPRV
 .W !!,"***User account is TERMINATED please choose another responsible user.***"
 S GMRCAD=$$GETDT^GMRCUTL1 I GMRCAD="^" D END S GMRCQUT=1 Q
 I '$G(GMRCAD) S GMRCAD=$$NOW^XLFDT
 N GMRCSS,GMRCSSNM,GMRCA,GMRCMSG,GMRCIROL,GMRCINM,GMRCIROU,ORSTS
 D DEFAULT
 S GMRCSS=+GMRCDG
 I +GMRCSS,'$D(^GMR(123.5,+GMRCSS,0)) S GMRCMSG="Error in Service Chosen - SERVICE Does Not Exist!" D EXAC^GMRCADC(GMRCMSG),END S GMRCQUT=1 Q
 S GMRCSSNM=$S($L($G(^GMR(123.5,+GMRCSS,.1))):^(.1),1:$P($G(^GMR(123.5,+GMRCSS,0)),U,1))
 D URG I $D(GMRCEND),GMRCEND D END S GMRCQUT=1 Q
 S GMRCA=17,DR=""
 I $D(^GMR(123.5,+GMRCSS,"IFC")) D  ; if fwd to IFC serv, get extra flds
 . S GMRCIROU=$P(^GMR(123.5,+GMRCSS,"IFC"),U) Q:GMRCIROU=""  ;no rout fac
 . S GMRCINM=$P(^GMR(123.5,+GMRCSS,"IFC"),U,2) Q:GMRCINM=""  ;no serv nm
 . S GMRCA=25,GMRCIROL="P"
 . S DR=".07////^S X=GMRCIROU;.125////^S X=GMRCIROL;.131///^S X=GMRCINM;"
 S DIE="^GMR(123,",DA=GMRCO,ORSTS=5
 S DR=DR_"1////^S X=GMRCSS;5////^S X=GMRCURGI;8////^S X=ORSTS;9////^S X=GMRCA;.1///@"
 L +^GMR(123,GMRCO):2 I '$T K DIE,DA,DR S GMRCMSG="Another User Is Accessing This Record. UPDATE WAS UNSUCCESSFUL.",GMRCMSG(1)="Try Again Later." D EXAC^GMRCADC(.GMRCMSG),END S GMRCQUT=1 Q
 D ^DIE L -^GMR(123,GMRCO) K DIE,DA,DR
 S GMRCOM=1 D AUDIT^GMRCP ;GMRCORNP is the responsible provider here
 ;
 I $G(GMRCLCK) D UNLOCK^GMRCA1(GMRCO) ;unlk before FWD changes order #
 ;
FRMSG ; Common logic used by GUI and List Manager to process the HL7 message
 ; to update the order in OE/RR and then forward an alert to recipients
 ; is passed in as the DUZ instead of the responsible provider
 D EN^GMRCHL7(DFN,GMRCO,$G(GMRCTYPE),$G(GMRCRB),"XX^FORWARD",$G(DUZ),$G(VISIT),.GMRCOM,,$G(GMRCAD))
 S GMRCADUZ=""
 S GMRCORNP=$P(^GMR(123,GMRCO,0),"^",14) ;This is the original provider that ordered the consult
 I +$G(GMRCORNP) S GMRCADUZ(+GMRCORNP)="" ;alert original provider of forward
 S GMRCORTX="Forwarded consult "_$$ORTX^GMRCAU(+GMRCO)_" ("_GMRCURG_")"
 D MSG^GMRCP(DFN,GMRCORTX,+GMRCO,27,.GMRCADUZ,1) ;GMRCO=IEN of consult from file 123; 27 is notification entry from file ORD(100.9
 K GMRCOM
 S GMRCDEV=$P($G(^GMR(123.5,GMRCSS,123)),"^",9)
 I GMRCDEV D PRNT^GMRCUTL1(GMRCSS,+GMRCO)
 D END
 Q
URG ;Get the default urgency
 N X,Y,XQORM,DIROUT,DTOUT,DIRUT,DUOUT
 I $P(^GMR(123,+GMRCO,0),"^",18)["I" D
 .I GMRCTYPE="GMRCOR CONSULT" S X="GMRCURGENCYM CSLT - INPATIENT"
 .S X="GMRCURGENCYM REQ - INPATIENT"
 E  S X="GMRCURGENCYM - OUTPATIENT"
 I '$D(GMRCURG) S GMRCURGI=$O(^ORD(101,"B","GMRCURGENCY - ROUTINE","")) S:+GMRCURGI GMRCURG=$P($G(^ORD(101,+GMRCURGI,0)),"^",2)
 S Y=$O(^ORD(101,"B",X,""))
 S XQORM=+Y_";ORD(101,",XQORM(0)="1A\",XQORM("A")="Urgency: ",XQORM("NO^^")=""
 S:$L(GMRCURG) XQORM("B")=GMRCURG D EN^XQORM I X="^"!($D(DIROUT)) K XQORM S GMRCEND=1 Q
 K XQORM(0),XQORM("A"),XQORM("B"),XQORM("NO^^") S XQORM=""
 I '$D(Y) S GMRCEND=1 Q
 I $D(Y(1)) S GMRCURG=$P(Y(1),"^",3),GMRCURGI=$P(Y(1),"^",2)
 Q
DEFAULT ;Set up defaults for editing to be equal to the existing data.
 D DEM^GMRCU
 N GMRC,GMRCDIC,GMRCPLI,GMRCPRI
 Q:'$D(GMRCO)  S (GMRCSS,GMRCSSNM,GMRCPL,GMRCPR,GMRCPRI,GMRCURG)=""
 S GMRCOM=0,GMRC(0)=$S($D(^GMR(123,+GMRCO,0)):^(0),1:"")
 S GMRCSS=$P(GMRC(0),"^",5) I +GMRCSS,$D(^GMR(123.5,+GMRCSS,0)) S GMRCSSNM=$S($L($P($G(^GMR(123.5,+GMRCSS,0)),U,1)):$P(^(0),U,1),1:"")
 S GMRCPLI=$P(GMRC(0),"^",10) I GMRCPLI S GMRCPL=$P($G(^ORD(101,GMRCPLI,0)),"^",2)
 S GMRCURGI=$P(GMRC(0),"^",9) I GMRCURGI S GMRCURG=$P($G(^ORD(101,GMRCURGI,0)),"^",2)
 S GMRCPRI=$P(GMRC(0),"^",8) I GMRCPRI["ORD(101" D
 . S GMRCPR=$$GET1^DIQ(101,+GMRCPRI,1)
 I $L(GMRCPRI),GMRCPRI'["ORD(101" D  ;ZPROC
 . S GMRCPR=$$GET1^DIQ(123.3,+GMRCPRI,.01)
TYPE ;This entry point is used when the only default needed is the GMRCTYPE
 ;Called by GMRCGUIA to get variables ready for FRMSG call.
 S GMRCTYPE=$$GET1^DIQ(123,+GMRCO,13,"I") ;ZPROC (P or C)
 Q
END ;Kill off variables and exit
 I $G(GMRCLCK) D UNLOCK^GMRCA1(GMRCO)
 K GETPROV,GMRCDG,GMRCDEV,GMRCEND,GMRCFF,GMRCOM,GMRCIFN,GMRCO,GMRCORNP
 K GMRCTYPE,GMRCORTX,GMRCPL,GMRCPR,GMRCSEL,GMRCURG,GMRCADUZ,Y
 K DTOUT,DIROUT,DUOUT,GMRCURGI
 S:$D(^TMP("GMRC",$J,"CURRENT","MENU")) XQORM("HIJACK")=^("MENU")
 Q
