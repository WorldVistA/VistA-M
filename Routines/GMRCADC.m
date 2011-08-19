GMRCADC ;SLC/DLT/DCM - DC taken from List Manager ; 7/11/05 1:40pm
 ;;3.0;CONSULT/REQUEST TRACKING;**1,5,10,12,35,39,47**;DEC 27, 1997
EXAC(MSG) ;Exit message asking for user to press <ENTER>; EXAC=Exit Action
 N ND,X
 W $C(7),!,MSG I $O(MSG(0)) S ND=0 F  S ND=$O(MSG(ND)) Q:ND=""  D
 . W !,MSG(ND)
 W !,"Press <RETURN> to continue: " R X:DTIME W !!
 Q
DC(GMRCO,GMRCA) ;Discontinue a consult logic from DC^GMRCA1
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 N GMRCDA,GMRCACTM,GMRCADUZ,GMRCSERV,GMRCAD,GMRC
 K GMRCQUT,GMRCQIT
 I '+$G(GMRCO) D SELECT^GMRCA2(.GMRCO) I $D(GMRCQUT) Q
 I '+$G(GMRCO) S GMRCQUT=1 Q
 I $P($G(^GMR(123,GMRCO,12)),U,5)="P" D  Q
 . N DIR
 . W !,"The requesting facility may not take this action on an "
 . W "inter-facility consult."
 . S DIR(0)="E" D ^DIR
 . S GMRCQUT=1
 I '$$LOCK^GMRCA1(GMRCO) S GMRCQUT=1 Q
 ;
 S GMRC(0)=^GMR(123,GMRCO,0),GMRCDA=GMRCO
 S (GMRCDFN,DFN)=$P(GMRC(0),"^",2)
 I $D(GMRCA),+GMRCA S GMRCACTM=$S(GMRCA=6:"Discontinued",GMRCA=19:"Cancelled",1:$P($G(^GMR(123.1,+GMRCA,0)),"^",1))
 ;
 D PROC I $D(GMRCQUT) D UNLOCK^GMRCA1(GMRCO) S GMRCQUT=1 Q
 ;send 513 back to service printer if request DC'd or Cancelled
 I GMRCA=6,$$DCPRNT^GMRCUTL1(+GMRCO,DUZ) D
 . D PRNT^GMRCUTL1(+$P(GMRC(0),U,5),+GMRCO)
 S GMRCTRLC=$S(GMRCA=19:"OC",1:"OD")
 D EN^GMRCHL7(DFN,GMRCO,$G(GMRCTYPE),$G(GMRCRB),GMRCTRLC,GMRCORNP,$G(GMRCVSIT),.GMRCOM,,$G(GMRCAD))
 D UNLOCK^GMRCA1(GMRCO)
 Q
 ;
PROC ;Check validity of action and if valid process the discontinue action
 N DIROUT,DTOUT,DUOUT,GMRCMSG,GMRCFL,GMRCACT
 I $P(GMRC(0),"^",12)=1 S GMRCMSG="This consult has already been discontinued!" D EXAC(GMRCMSG) S GMRCQUT=1 Q
 I $P(GMRC(0),"^",12)=2 S GMRCMSG="This consult has already been completed!" D EXAC(GMRCMSG) S GMRCQUT=1 Q
 I $P(GMRC(0),"^",12)=9 S GMRCMSG="Action invalid. This consult has partial results!",GMRCMSG(1)="Remove the associated results and then discontinue." D EXAC(.GMRCMSG) S GMRCQUT=1 Q
 I $P(GMRC(0),"^",12)=13 S GMRCMSG="This consult has already been cancelled!" D EXAC(GMRCMSG) S GMRCQUT=1 Q
 ;
 S GMRCORVP=GMRCDFN_";DPT("
 N GETPROV
FRGTPRV D GETPROV^GMRCAU I $D(DIROUT)!$D(DTOUT)!$D(DUOUT) S GMRCQUT=1 Q
 S GMRCACT=$$PROVIDER^XUSER(GMRCORNP) I $P(GMRCACT,U)'=1 D  G FRGTPRV
 .W !!,"***User account is TERMINATED please choose another responsible user.***"
 S GMRCAD=$$GETDT^GMRCUTL1 ;Returns GMRCAD as the entered date
 I GMRCAD="^" S GMRCQUT=1 Q
 S GMRCSTS=$S(GMRCA=6:1,1:13),$P(GMRC(0),"^",12)=GMRCSTS
 S GMRCOM=1
 D STATUS^GMRCP
 D AUDIT^GMRCP
 ;
 S GMRCORTX=$S($L($G(GMRCACTM)):GMRCACTM,+GMRCA:$P(^GMR(123.1,GMRCA,0),U,1),1:"ACTION UNKNOWN FOR")_" consult "_$$ORTX^GMRCAU(+GMRCO)
 S GMRCADUZ="",GMRCFL=0
 I +$P($G(^GMR(123,+GMRCO,0)),"^",14),+$P(^(0),"^",14)'=DUZ S GMRCADUZ($P(^(0),"^",14))=""
 ;I +$P($G(^GMR(123,+GMRCO,0)),"^",14)=DUZ S GMRCFL=1
 I GMRCA=6 S GMRCFL=$$DCNOTE(GMRCO,DUZ) ;check NOTIFY SERVICE ON DC
 ;I GMRCA=19 S GMRCFL=1
 ;send notification info to routine to be sent to OERR
 N NOTYPE S NOTYPE=$S(GMRCA=6:23,1:30)
 D MSG^GMRCP(GMRCDFN,GMRCORTX,+GMRCO,NOTYPE,.GMRCADUZ,GMRCFL)
 Q
DCNOTE(IEN,USER) ;determine if service users receive alerts based on 1.04
 N SERV,DCFLG
 S SERV=$P(^GMR(123,IEN,0),U,5)
 S DCFLG=$P($G(^GMR(123.5,SERV,1)),U,4)
 I 'DCFLG Q 1
 I DCFLG=2 Q 0
 I DCFLG=1,'$$VALID^GMRCAU(SERV,IEN,USER) Q 1
 Q 0
