RTT12 ;ISC-ALBANY/PKE-repoint request to new record ; 12/30/02 12:28pm
 ;;2.0;Record Tracking;**31**;10/22/91 
 D EN K X,P,Z,RDT,RTV0,RTWND Q
 ;
EN I '$D(RT)!('$D(RTPAR))!('RT)!('RTPAR) Q
 S RTRD(1)="Yes^transfer Requests to Record/Volume "_RTVOL
 S RTRD(2)="No^not change the Record/Volume(s)  Requested."
 S:'$D(RTRD("A")) RTRD("A")="Pending Requests can be transferred to last Record/Volume just created. "_$C(13,10)_"        Transfer Requests to volume '"_RTVOL_"' ? "
 S RTRD(0)="S",RTRD("B")=2 D SET^RTRD K RTRD S X=$E(X) S:X["^" RTESC="" I X'="Y" Q
 ;get pend cut
 Q:'$D(RTTY)  D PND^RTRPT Q:'$D(RTWND(+RTTY))
 ;get requests
GET ;
 N RTCNT
 F RTV0=0:0 S RTV0=$O(^RT("P",RTPAR,RTV0)) Q:'RTV0  I RTV0'=RT D FIND
 S RTV0=RTPAR Q:RTV0=RT
 ;z=da
FIND F Z=0:0 S Z=$O(^RTV(190.1,"B",RTV0,Z)) Q:'Z  D REC L -^RTV(190.1,Z)
 QUIT
 ;
REC I $D(^RTV(190.1,Z,0)),$D(^RT(+^RTV(190.1,Z,0))) L +^RTV(190.1,Z):1 I '$T G REC
 N RTMVMNT0
 I '$D(^RTV(190.1,Z,0))!('$D(^RT(+^RTV(190.1,Z,0)))) L -^RTV(190.1,Z) Q
 ;only requests,pending
 S RTMVMNT0=^RTV(190.1,Z,0) ;zero node of the entry in 190.1
 S RDT=+$P(RTMVMNT0,U,4) Q:'RDT  I $P(RDT,".")<RTWND(+RTTY) Q
 I $P(RTMVMNT0,U,6)'="r" D  Q
 . S RTCNT=$G(RTCNT)+1
 . I $G(RTCNT)=1 W !!,"The following request(s) cannot be transferred due to Request Status:"
 . W !?2,"Request for "_$E($$EXTRNL(4,4),1,12)_" for "_$E($$EXTRNL(5,5),1,25)_" - Status is "_$$EXTRNL(6,6)
 S $P(^RTV(190.1,Z,0),"^",1)=RT,^RTV(190.1,"B",RT,Z)="" K ^RTV(190.1,"B",RTV0,Z) ;W " ." R X:0
 ;date/time needed
DAT I RDT,$D(^RTV(190.1,"AC",RTV0,$P(RDT,"."),Z)) S ^RTV(190.1,"AC",RT,$P(RDT,"."),Z)="" K ^RTV(190.1,"AC",RTV0,$P(RDT,"."),Z)
 ;
 ;pull list
PUL S P=+$P(^RTV(190.1,Z,0),"^",10)
 I P,$D(^RTV(190.1,"AP1",P,RTV0,Z)) S ^RTV(190.1,"AP1",P,RT,Z)="" K ^RTV(190.1,"AP1",P,RTV0,Z)
 L -^RTV(190.1,Z) Q
EXTRNL(RTPIECE,RTFIELD) ;get external values for fields to be displayed
 ; RTPIECE is piece of zero node, 190.1
 ; RTFIELD is FM field number
 S Y=$P(RTMVMNT0,U,RTPIECE)
 S C=$P(^DD(190.1,RTFIELD,0),U,2)
 D Y^DIQ
 Q Y
