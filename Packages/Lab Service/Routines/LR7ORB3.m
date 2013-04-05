LR7ORB3 ;DALOI/JMC - Lab CPRS Notification Utility ;05/28/12  16:11
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; Reference to EN^ORB3 supported by ICR #1362
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
SETUP(LRDFN,LRSS,LRIDT,LRUID) ; Setup a CPRS notification
 ;  Call with LRDFN = file #63 IEN
 ;             LRSS = file #63 subscript
 ;            LRIDT = inverse d/t of entry in file #63
 ;            LRUID = accession's UID
 ;
 ; Only supports CH and MI. AP subscript handled by separate API.
 ;
 N DFN,DIC,DIR,DIRUT,DTOUT,DUOUT,LRC,LRDOCS,LRMORE,LRQUIT,LRTST,LRTYPE,LRX,LRXQA,LRY,X,Y
 ;
 S (LRTYPE,LRXQA,LRY)=""
 ;
 ; Select test to alert
 S LRY=$$SELTEST(LRUID)
 I 'LRY Q LRY
 S LRTST=$P(LRY,"^",2)
 ;
 ; Ask user type of CPRS notification to send
 S DIR(0)="SO^1:Lab results available;2:Abnormal lab results;3:Critical lab results"
 D ^DIR
 I $D(DIRUT) Q "0^User aborted"
 E  S LRTYPE=$S(Y=1:3,Y=2:14,1:57)
 ;
 ; Ask user for recipients.
 D GETDOCS(.LRDOCS,LRDFN,LRSS,LRIDT)
 S (LRC,LRXQA)=0
 F  S LRC=$O(LRDOCS(LRC)) Q:LRC<1  S LRXQA(+LRDOCS(LRC))=$P(LRDOCS(LRC),"^",3)
 I $O(LRXQA("")) D
 . N LRJ,LRMSG
 . D CURREC,EN^DDIOL(.LRMSG)
 ;
 S LRMORE=0 D MORE
 I LRMORE D LOOKUP
 I $O(LRXQA(""))'="" S LRXQA=1
 E  S LRY="0^No recipients selected"
 ;
 ; If everything OK then send alert
 I LRTYPE,LRXQA D
 . N LRJ,LRMSG
 . D CURREC,EN^DDIOL(.LRMSG)
 . K DIR
 . S DIR(0)="Y",DIR("A")="Send Alert",DIR("B")="YES"
 . D ^DIR
 . I Y'=1 S LRY="0^Alert Sending Aborted" Q
 . S LRY=$$OR(LRTYPE,LRDFN,LRSS,LRIDT,LRUID,.LRXQA,LRTST)
 ;
 Q LRY
 ;
 ;
 ;
GETDOCS(LRDOCS,LRDFN,LRSS,LRIDT) ; Return PCP(inpatient PC/attending/outpt PC/outpt assoc PC/outpt attending) and ordering provider
 ;
 N DFN,LRDPF,LRX,X
 ;
 S LRDOCS=0
 I LRSS'?1(1"CH",1"MI") Q
 ;
 S LRX=$P($G(^LR(LRDFN,LRSS,LRIDT,0)),"^",$S(LRSS="CH":10,1:7))
 I LRX>0 S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=LRX_"^"_$$NAME^XUSER(LRX,"F")_"^"_"Ordering Provider"
 ;
 S LRDPF=$P($G(^LR(LRDFN,0)),"^",2),DFN=$P($G(^LR(LRDFN,0)),"^",3)
 I LRDPF=2 D
 . N LRDT,LRPCP,VADMVT,VAINDT
 . S LRPCP=0
 . S LRDT=$P($G(^LR(LRDFN,LRSS,LRIDT,0)),"^")
 . I LRDT<1 S LRDT=DT
 . S VAINDT=LRDT D ADM^VADPT2
 . I VADMVT D  Q
 . . N VAHOW,VAIN,VAROOT
 . . D INP^VADPT
 . . I VAIN(2) S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=VAIN(2)_"^"_"Inpatient Primary Care Provider",LRPCP=1 Q
 . . I VAIN(11) S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=VAIN(11)_"^"_"Inpatient Attending Provider",LRPCP=1
 . S LRX=$$OUTPTPR^SDUTL3(DFN,LRDT,1)
 . I LRX>0 S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=LRX_"^"_"Outpatient Primary Care Provider",LRPCP=1 Q
 . S LRX=$$OUTPTPR^SDUTL3(DFN,LRDT,2)
 . I LRX>0 S LRDOCS=LRDOCS+1,LRDOCS(LRDOCS)=LRX_"^"_"Outpatient Attending Provider",LRPCP=1
 Q
 ;
 ;
MORE ; Add names or mail groups to the lookup list?
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;ZEXCEPT: LRMORE,LRQUIT
 ;
 W !
 S LRMORE=1
 S DIR(0)="Y"
 S DIR("A")="Send the alert to additional recipients and/or mail groups"
 S X=$$GET^XPAR("USR^DIV^PKG","LRAPRES1 AP ALERT",1,"Q")
 S DIR("B")=$S(X=1:"YES",1:"NO")
 S DIR("?")="^D AHELP^LR7ORB3"
 D ^DIR
 I Y=0 S LRMORE=0 Q
 I $D(DUOUT)!($D(DTOUT)) S LRQUIT=1
 Q
 ;
 ;
LOOKUP ; Add additional names or mail groups to alert list.
 N DIC,DIR,DIRUT,DTOUT,DUOUT,LRADL,LRDELETE,LRMSG,X,Y
 ;
 ;ZEXCEPT: LRQUIT,LRXQA
 ;
 S LRQUIT=0
 F  D  Q:LRQUIT
 . W !
 . K DIR
 . S LRDELETE=0
 . S DIR(0)="FO^3:30^I X["".""&(X'?1(1""G."",1""g."")1.E) K X"
 . S DIR("A")="Enter name or mail group"
 . S DIR("?",1)="Prefix selection with '-' to delete a recipient"
 . S DIR("?",2)="Enter lastname,firstname OR G.mailgroup OR ^ to exit"
 . S DIR("?")="Enter '??' for additional help and listing of currently selected recipients."
 . S DIR("??")="^D AHELP^LR7ORB3"
 . S DIR("PRE")="I '$D(DTOUT),$E(X)=""-"" S X=$E(X,2,9999),LRDELETE=1"
 . D ^DIR
 . I $D(DIRUT) S LRQUIT=1 Q
 . S LRADL=""
 . I Y?1(1"G.",1"g.")1.E S LRADL="G",X=$P(Y,".",2)
 . K DIC
 . S DIC(0)="EMQZ",DIC=$S(LRADL="G":3.8,1:200)
 . I LRADL="G" S DIC("S")="N LRX S LRX=^(0) I $S($P(LRX,U,2)=""PU"":1,$P($G(^XMB(3.8,+Y,3)),U)=DUZ:1,+$P(LRX,U,6):0,$D(^XMB(3.8,+Y,1,""B"",DUZ)):1,1:0)"
 . D ^DIC
 . Q:Y=-1
 . I LRDELETE D
 . . I LRADL="" K LRXQA($P(Y,"^")) Q
 . . I LRADL="G" K LRXQA("G."_$P(Y,"^",2))
 . E  D
 . . I LRADL="" S LRXQA($P(Y,"^"))="" Q
 . . I LRADL="G" S LRXQA("G."_$P(Y,"^",2))=""
 . K LRMSG
 . S LRMSG=$S(LRADL="G":"Mail group ",1:"User ")_$P(Y,"^",2)_$S(LRDELETE:" deleted from",1:" added to")_" alert list."
 . D EN^DDIOL(LRMSG,"","!!")
 Q
 ;
 ;
AHELP ; Help Frame
 N LRI,LRMSG
 ;
 S LRMSG(1)="Enter either 'Y' or 'N'."
 S LRMSG(2)="If answered 'Yes', you will also have the opportunity to send alerts",LRMSG(2,"F")="!!"
 S LRMSG(3)="to additional recipients and/or mail groups."
 ;
 ; Get list of current recipients
 D CURREC
 ;
 D EN^DDIOL(.LRMSG)
 Q
 ;
 ;
CURREC ; Build list of current recipients.
 ;
 N LRI,LRJ
 ;
 ;ZEXCEPT: LRMSG,LRXQA
 ;
 S LRJ=$O(LRMSG(""),-1)
 ;
 I '$D(LRXQA) S LRJ=LRJ+1,LRMSG(LRJ)="No recipients listed",LRMSG(LRJ,"F")="!!" Q
 ;
 S LRI="",LRJ=LRJ+1,LRMSG(LRJ)="The current recipients will be:",LRMSG(LRJ,"F")="!!"
 F  S LRI=$O(LRXQA(LRI)) Q:LRI=""  D
 . S LRJ=LRJ+1,LRMSG(LRJ)=$S(LRI:$$NAME^XUSER(LRI,"F"),1:LRI)
 . I LRXQA(LRI)'="" S LRMSG(LRJ)=LRMSG(LRJ)_"  ["_LRXQA(LRI)_"]"
 ;
 Q
 ;
 ;
OR(LRTYPE,LRDFN,LRSS,LRIDT,LRUID,LRXQA,LRTST) ; Send OR notification
 ;
 N DFN,LRIENS,LRMSG,LRODT,LROE,LROIFN,LRPREFIX,LRSN,LRX,LRY
 ;
 ; Call with LRTYPE = type OERR notification (currently supports 3, 14, 57)
 ;            LRDFN = file #63 IEN
 ;             LRSS = file #63 subscript
 ;            LRIDT = inverse d/t of entry in file #63
 ;            LRUID = accession's UID
 ;            LRXQA = recipient array
 ;            LRTST = test name being alerted
 ;
 ; Only supports CH and MI. AP subscript handled by separate API.
 ;
 I LRSS'?1(1"CH",1"MI") Q "0^Lab Subscript not supported"
 ;
 S DFN=$P(^LR(LRDFN,0),"^",3)
 ;
 S LRPREFIX=$S(LRTYPE=3:"",LRTYPE=14:"Abnormal ",LRTYPE=57:"Critical ",1:"")
 ;
 S LRX=$$CHECKUID^LRWU4(LRUID,LRSS)
 I LRX<1 Q "0^Accession's UID not valid"
 S LRY=$G(^LRO(68,$P(LRX,"^",2),1,$P(LRX,"^",3),1,$P(LRX,"^",4),0))
 S LRODT=+$P(LRY,"^",4),LRSN=+$P(LRY,"^",5),(LROE,LROIFN)=""
 I LRODT,LRSN D
 . S LROIFN=$P($G(^LRO(69,LRODT,1,LRSN,0)),"^",11)
 . S LROE=$P($G(^LRO(69,LRODT,1,LRSN,.1)),"^")
 ;
 S LRIENS=LROIFN_"@OR|"_LROE_";"_LRODT_";"_LRSN_";"_LRSS_";"_LRIDT_"@LRCH"
 ;
 I LRSS="CH" D
 . I LRTYPE=14!(LRTYPE=57) S LRMSG=LRPREFIX_"lab results:"
 . E  S LRMSG="Lab results:"
 ;
 I LRSS="MI" D
 . I LRTYPE=14!(LRTYPE=57) S LRMSG=LRPREFIX_"microbiology results:"
 . E  S LRMSG="Microbiology results:"
 ;
 S LRMSG=LRMSG_" - ["_LRTST_"]"
 ;
 ; OERR parameters:
 ;          ORN: notification id (#100.9 ien)
 ;          |      ORBDFN: patient id (#2 ien)
 ;          |      |   ORNUM: order number (#100 ien)
 ;          |      |   |       ORBADUZ: recipient array
 ;          |      |   |       |     ORBPMSG: message text
 ;          |      |   |       |     |     ORBPDATA lab result reference
 ;          |      |   |       |     |     |
 D EN^ORB3(LRTYPE,DFN,LROIFN,.LRXQA,LRMSG,LRIENS)
 ;
 Q "1^Alert Sent"
 ;
 ;
SELTEST(LRUID) ; Select test on accession for alert messsage - screen out workload tests
 ;
 ; Call with LRUID = accession's UID
 ; Returns     LRY = 1^test names for alert message
 ;                   0^error message
 ;
 N DIC,DIR,DIROUT,DIRUT,DUOUT,LRAA,LRAD,LRADO,LRAN,LRI,LRJ,LRTEST,LRX,LRY,X,Y
 ;
 S LRY=1
 ; Resolve UID to global subscripts.
 S LRX=$$CHECKUID^LRWU4(LRUID)
 I LRX S LRAA=$P(LRX,"^",2),LRAD=$P(LRX,"^",3),LRAN=$P(LRX,"^",4)
 E  S LRY="0^Invalid Accession UID"
 I 'LRY Q LRY
 ;
 ; Build list of tests on accession
 ;  - if accession has rolled over then also check original accession
 S LRADO=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),"^",3)
 F LRJ=1,2 D
 . I LRJ=2,LRAD=LRADO Q
 . I LRJ=2 S LRAD=LRADO
 . S LRI=0
 . F  S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI)) Q:'LRI  I $P(^LAB(60,LRI,0),"^",4)'="WK" S LRTEST(LRI)=""
 ;
 I '$D(LRTEST) S LRY="O^No tests on accession"
 ;
 I 'LRY Q LRY
 ;
 S DIC="^LAB(60,",DIC(0)="AEMQZ"
 S DIC("A")="Select TEST: ",DIC("S")="I $D(LRTEST(Y))"
 D ^DIC
 I Y<1 S LRY="0^User aborted"
 E  S LRY="1^"_Y(0,0)
 ;
 Q LRY
 ;
 ;
ASKXQA(LRDFN,LRSS,LRIDT,LRUID,LRDEFAULT) ; Ask if user wants to send a CPRS notification/alert for this accession.
 ;  Call with LRDFN = file #63 IEN
 ;             LRSS = file #63 subscript
 ;            LRIDT = inverse d/t of entry in file #63
 ;            LRUID = accession's UID
 ;        LRDEFAULT = default answer for DIR call (1-NO,2-YES)
 ;
 N DIR,DIRUT,DTOUT,DUOUT,LRY,X,Y
 ;
 S LRDEFAULT=$G(LRDEFAULT)
 S DIR(0)="Y",DIR("A")="Send a CPRS Alert/Notification"
 S DIR("B")=$S(LRDEFAULT=2:"YES",1:"NO")
 D ^DIR
 I Y<1 Q
 ;
 S LRY=$$SETUP(LRDFN,LRSS,LRIDT,LRUID)
 W " ...",$P(LRY,"^",2)
 ;
 Q
 ;
 ;
SENDOR ; Send a CPRS alert for an accession.
 ;  - User is prompted to select the accession and tests.
 ;
 N %ZIS,DIC,DIR,DIROUT,DIRUT,DUOUT,LRAA,LRACC,LRAD,LRAN,LRDFN,LRDPF,LREND,LRIDT,LRLAB,LRSS,LRSTOP,LRUID,LRVBY,LRY,X,Y
 ;
 F  D  Q:LREND!LRSTOP
 . S (LREND,LRSTOP,LRVBY)=0
 . S LRACC="" D ^LRWU4
 . I LRAN<1 S LREND=1 Q
 . I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W !,"Doesn't exist." Q
 . K DIC,LRDFN,LRDPF,LRIDT,LRSS
 . S LRSS=$P(^LRO(68,LRAA,0),"^",2),LRDFN=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),"^"),LRIDT=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5)
 . S LRDPF=$P(^LR(LRDFN,0),"^",2)
 . I LRDPF'=2 W !,"CPRS Alerts only support patients from the PATIENT file (#2)" Q
 . S LRUID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^")
 . I LRUID="" W !,"Accession missing associated UID" Q
 . I LRSS=""!(LRIDT<1)!(LRDFN<1) W !,"Incomplete accession - unable to identify results." Q
 . I LRSS'?1(1"CH",1"MI") D  Q
 . . W !,"This option only supports CH and MI subscripted accessions."
 . . W !,"Use option 'Send an AP Alert' [LRAP ALERT] to send AP alerts"
 . I '$$OK2SEND^LA7SRR W !,"This accession has not been released." Q
 . S LRY=$$SETUP(LRDFN,LRSS,LRIDT,LRUID)
 . W " ...",$P(LRY,"^",2)
 ;
 Q
