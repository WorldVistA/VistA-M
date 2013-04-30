LRAPRES1 ;DALOI/STAFF - AP ESIG RELEASE REPORT/ALERT ;02/08/12  15:31
 ;;5.2;LAB SERVICE;**259,336,369,365,397,413,350**;Sep 27, 1994;Build 230
 ;
 ; Reference to FILE^TIUSRVP supported by ICR #3540
 ; Reference to ^TIULQ supported by ICR #2693
 ; Reference to LAB^ORB3LAB supported by ICR #4287
 ;
MAIN(LRDFN,LRSS,LRI,LRSF,LRP,LRAC) ;Main subroutine
 Q:'$D(LRDFN)!('$D(LRSS))!('$D(LRP))!('$D(LRAC))
 ;
 N DIR,DIRUT,DTOUT,DUOUT,LRDOCS,LRMSG,LRC,LRNUM,LRADL,LRMORE,LRQUIT,LRXQA,X,Y,DIC,XQA,XQAMSG
 ;
 S LRQUIT=0
 ;
 ; CPRS alerts only sent for "patients" related to PATIENT file (#2)
 I $P($G(^LR(LRDFN,0)),"^",2)'=2 Q
 ;
 D DOCS,MORE
 I LRMORE D LOOKUP
 D ALERT
 Q
 ;
 ;
DOCS ; Get ordering provider and PCP/attending to send alert
 N LRNUM,LRMSG
 S:$G(LRSF)="" LRSF=63
 D GETDOCS^LRAPUTL(.LRDOCS,LRDFN,LRSS,$G(LRI),LRSF)
 S (LRNUM,LRQUIT)=1,LRC=0
 F  S LRC=$O(LRDOCS(LRC)) Q:LRC<1  D
 . I $D(LRXQA(+LRDOCS(LRC))) S LRXQA(+LRDOCS(LRC))=LRXQA(+LRDOCS(LRC))_"/"_$P(LRDOCS(LRC),"^",3) Q
 . S LRXQA(+LRDOCS(LRC))=$P(LRDOCS(LRC),"^",3),LRQUIT=0
 ;
 I 'LRQUIT D
 . S LRC=0,LRMSG(LRNUM)="Mandatory Alert will be sent to: ",LRMSG(LRNUM,"F")="!!"
 . F  S LRC=$O(LRDOCS(LRC)) Q:LRC<1  D
 . . S LRNUM=LRNUM+1,LRMSG(LRNUM)=$P(LRDOCS(LRC),"^",2)_"  ["_$P(LRDOCS(LRC),"^",3)_"]"
 . . S LRMSG(LRNUM,"F")=$S(LRNUM>2:"!",1:"")_"?33"
 I LRQUIT S LRMSG(LRNUM)="No Ordering Provider or PCP selected for alert",LRMSG(LRNUM,"F")="!!",LRQUIT=0
 D EN^DDIOL(.LRMSG)
 Q
 ;
 ;
MORE ; Add names or mail groups to the lookup list?
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S LRMORE=1
 S DIR(0)="Y"
 S DIR("A")="Send the alert to additional recipients and/or mail groups"
 S X=$$GET^XPAR("USR^DIV^PKG","LRAPRES1 AP ALERT",1,"Q")
 S DIR("B")=$S(X=1:"YES",1:"NO")
 S DIR("?")="^D AHELP^LRAPRES1"
 D ^DIR
 I Y=0 S LRMORE=0 Q
 I $D(DUOUT)!($D(DTOUT)) S LRQUIT=1
 Q
 ;
 ;
LOOKUP ; Add additional names or mail groups to alert list.
 N DIC,DIR,DIRUT,DTOUT,DUOUT,LRADL,LRDELETE,X,Y
 S LRQUIT=0
 F  D  Q:LRQUIT
 . W !
 . K DIR
 . S LRDELETE=0
 . S DIR(0)="FO^3:30^I X["".""&(X'?1""G."".E) K X"
 . S DIR("A")="Enter name or mail group"
 . S DIR("?",1)="Prefix selection with '-' to delete a recipient"
 . S DIR("?",2)="Enter lastname,firstname OR G.mailgroup OR ^ to exit"
 . S DIR("?")="Enter '??' for additional help and listing of currently selected recipients."
 . S DIR("??")="^D AHELP2^LRAPRES1"
 . S DIR("PRE")="I '$D(DTOUT),$E(X)=""-"" S X=$E(X,2,9999),LRDELETE=1"
 . D ^DIR
 . I $D(DIRUT) S LRQUIT=1 Q
 . S LRADL="",Y=$$UP^XLFSTR(Y)
 . I Y["." S LRADL=$P(Y,"."),X=$P(Y,".",2)
 . K DIC
 . S DIC(0)="QEZ"
 . S DIC=$S(LRADL="G":3.8,1:200)
 . D ^DIC
 . Q:Y=-1
 . I LRDELETE D
 . . I LRADL="" K XQA($P(Y,"^")) Q
 . . I LRADL="G" K XQA("G."_$P(Y,"^",2))
 . E  D
 . . I LRADL="",'$D(XQA($P(Y,"^"))) S XQA($P(Y,"^"))="Additional User" Q
 . . I LRADL="G" S XQA("G."_$P(Y,"^",2))="Additional Mail Group"
 . K LRMSG
 . S LRMSG=$S(LRADL="G":"Mail group ",1:"User ")_$P(Y,"^",2)_$S(LRDELETE:" deleted from",1:" added to")_" alert list."
 . D EN^DDIOL(LRMSG,"","!!")
 Q
 ;
 ;
ALERT ; Send the alert
 ;
 M XQA=LRXQA
 I '$D(XQA) D EN^DDIOL("Alerts NOT sent - no alert recipients identified!","","!!") Q
 ;
 D LAB^ORB3LAB(DFN,LRDFN,LRI,$G(LRA),LRSS,.XQA)
 ;
 D EN^DDIOL("Alerts have been sent.","","!!")
 Q
 ;
 ;
AHELP ; Help Frame
 N LRI,LRJ,LRMSG
 S LRMSG(1)="Enter either 'Y' or 'N'."
 S LRMSG(2)="If answered 'Yes', you will also have the opportunity to send alerts",LRMSG(2,"F")="!!"
 S LRMSG(3)="to additional recipients and/or mail groups."
 S LRMSG(4)="A mandatory alert is sent to the ordering provider/surgeon and the primary care",LRMSG(4,"F")="!!"
 S LRMSG(5)="provider/attending that this report has been electronically signed and is now"
 S LRMSG(6)="available for viewing."
 S LRJ=6
 D CHELP
 Q
 ;
AHELP2 ; Help frame entry point for additional recipients selection
 ;
 N LRI,LRJ,LRMSG
 S LRMSG(1)="A mandatory alert is sent to the ordering provider/surgeon and the primary care",LRMSG(4,"F")="!!"
 S LRMSG(2)="provider/attending that this report has been electronically signed and is now"
 S LRMSG(3)="available for viewing."
 S LRJ=3
 D CHELP
 Q
 ;
 ;
CHELP ; Display common help
 ;
 I '$D(LRXQA) S LRJ=LRJ+1,LRMSG(LRJ)="No mandatory recipients listed",LRMSG(LRJ,"F")="!!"
 E  D
 . S LRI=0,LRJ=LRJ+1,LRMSG(LRJ)="The current mandatory recipients will be:",LRMSG(LRJ,"F")="!!"
 . F  S LRI=$O(LRXQA(LRI)) Q:LRI<1  S LRJ=LRJ+1,LRMSG(LRJ)=$$NAME^XUSER(LRI,"F")_"  ["_LRXQA(LRI)_"]"
 ;
 I '$D(XQA) S LRJ=LRJ+1,LRMSG(LRJ)="No additional recipients listed",LRMSG(LRJ,"F")="!!"
 E  D
 . S LRI="",LRJ=LRJ+1,LRMSG(LRJ)="The current additional recipients will be:",LRMSG(LRJ,"F")="!!"
 . F  S LRI=$O(XQA(LRI)) Q:LRI=""  S LRJ=LRJ+1,LRMSG(LRJ)=$S(LRI:$$NAME^XUSER(LRI,"F"),1:LRI)_"  ["_XQA(LRI)_"]"
 ;
 D EN^DDIOL(.LRMSG)
 Q
 ;
 ;
RETRACT(LRDFN,LRSS,LRI,LRTIUPTR) ;
 ; Change prior TIU versions of report to RETRACTED status
 N LRROOT,LRIENS,LRFILE,LRTIUP,LRTIUAR,LRERR,LRSTAT,LRTIUX,LREXRR
 I LRSS=""!("AUSPEMCY"'[LRSS) S LRPTR=0 Q
 I LRSS="AU" D
 . S LRROOT="^LR(LRDFN,101,""C""",LRIENS=LRDFN_","
 . S LRFILE=63.101
 I LRSS'="AU" D
 . S LRROOT="^LR(LRDFN,LRSS,LRI,.05,""C"""
 . S LRIENS=LRI_","_LRDFN_","
 . S LRFILE=$S(LRSS="SP":63.19,LRSS="CY":63.47,LRSS="EM":63.49,1:"")
 Q:'$D(@(LRROOT_")"))
 S LRTIUP=0,LRTIUX(.05)=15
 F  S LRTIUP=$O(@(LRROOT_",LRTIUP)"))  Q:LRTIUP'>0!(LRTIUP=LRTIUPTR)  D
 . K LRTIUAR S (LRSTAT,LRERR)=0
 . D EXTRACT^TIULQ(LRTIUP,"LRTIUAR",.LRERR,".05",,,"I")
 . Q:+LRERR
 . M LRSTAT=LRTIUAR(LRTIUP,.05,"I")
 . Q:LRSTAT'=7  ;Quit if current status is not COMPLETED
 . D FILE^TIUSRVP(.LREXRR,LRTIUP,.LRTIUX)
 . ; Update new TIU version of report with previous TIU pointer value
 . N LREXRR,LRTIUX
 . S LRTIUX(1406)=LRTIUP
 . D FILE^TIUSRVP(.LREXRR,LRTIUPTR,.LRTIUX)
 Q
 ;
 ;
CLSSCHK(DUZ,LREND) ; Determine if user has the proper class settings and PROVIDER key
 ;
 N LRMSG,LRPRCLSS,LRPCEXP,LRVCDE,LRPCSTR,LRMTCH
 ; First, check for PROVIDER key
 I '$D(^XUSEC("PROVIDER",DUZ)) D  Q
 . D EN^DDIOL($C(7)_"Electronic signature not authorized.  Missing PROVIDER key.","","!!")
 . S LREND=1
 ; Next, check the provider class
 ; PROVIDER CL must contain PHYSICIAN, or CYTOTECH only for CY section
 ; or DENTIST for ORAL AND MAXILLOFACIAL PATHOLOGY
 S LRPRCLSS=$$GET1^DIQ(200,DUZ_",",53.5)
 S LRMTCH=0
 I LRPRCLSS'["PHYSICIAN",LRPRCLSS'["DENTIST" D
 . I LRPRCLSS'["CYTOTECH" S LRMTCH=1
 . I LRSS'="CY" S LRMTCH=1
 I LRMTCH=1 D  Q
 . N LRMSG
 . S LRMSG(1)=$C(7)_"You are not authorized to electronically sign reports.",LRMSG(1,"F")="!!"
 . S LRMSG(2)="PROVIDER CLASS must include PHYSICIAN,"
 . S LRMSG(3)=" or CYTOTECHNOLOGIST for CY SECTIONS ONLY,"
 . S LRMSG(4)=" or DENTIST for ORAL AND MAXILLOFACIAL PATHOLOGY."
 . D EN^DDIOL(.LRMSG)
 . S LREND=1
 ;
 ; Finally, check the person class
 S LRPCSTR=$$GET^XUA4A72(DUZ)
 I LRPCSTR<0 D  Q
 . D EN^DDIOL("PERSON CLASS is inactive or undefined.  Electronic signature is not authorized.","","!!")
 . S LREND=1
 S LRPCEXP=+$P(LRPCSTR,"^",6)
 I LRPCEXP,LRPCEXP<DT D  Q
 . D EN^DDIOL("PERSON CLASS has expired.  Electronic signature is not authorized.","","!!")
 . S LREND=1
 S LRVCDE=$P(LRPCSTR,"^",7),LRMTCH=0
 ;
 ; Correct PERSON Class should match PROVIDER Class
 I LRPRCLSS["PHYSICIAN" D
 . I $E(LRVCDE,1,6)="V11370","123568"[+$E(LRVCDE,7) S LRMTCH=1 Q
 . I $E(LRVCDE,1,6)="V11371","03"[+$E(LRVCDE,7) S LRMTCH=1 Q
 . I $E(LRVCDE,1,6)="V18240","124579"[+$E(LRVCDE,7) S LRMTCH=1 Q
 . I LRVCDE="V182413" S LRMTCH=1
 ;
 I LRPRCLSS["CYTOTECH",LRVCDE="V150113" S LRMTCH=1
 I LRPRCLSS["DENTIST",LRVCDE="V030503" S LRMTCH=1
 ;
 I 'LRMTCH D
 . D EN^DDIOL("Invalid PERSON CLASS.  Electronic Signature is not authorized.","","!!")
 . S LREND=1
 Q
