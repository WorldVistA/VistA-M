GMRCP ;SLC/DLT,DCM - Message audit and status process ;4/19/01  11:52
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,17,22,27,53,55**;DEC 27, 1997;Build 4
 ;Processing action on Generic Requests/Consults from OE/RR
MSG(GMRCDFN,GMRCALRM,GMRCIFN,ORN,GMRCADUZ,FLG) ;send alert notification information to OERR for notification or update
 ;GMRCDFN=patient's DFN           GMRCORFN=OR file # ^OR(100,GMRCORFN
 ;GMRCALRM=alert message to be displayed with alert
 ;GMRCIFN=internal file number of consult in file 123
 ;GMRCADUZ=set in call to EN^GMRCT=array of providers who will be alerted
 ;FLG=1 if need to get list of service's providers, 0 if service dc'd.
 ;ORN=IFN from file ^ORD(100.9, for consult notification action
 N GMRCSS,GMRCORFN
 S GMRCORFN=$P(^GMR(123,+GMRCIFN,0),"^",3)
 S GMRCSS=$P($G(^GMR(123,+GMRCIFN,0)),"^",5)
 I FLG,GMRCSS D EN^GMRCT(GMRCSS)
 I $P($G(^GMR(123,+GMRCIFN,12)),U,5)="P" D
 . Q:ORN=27  ; don't notify requestor if a new order they placed, duh...
 . I DUZ=+$P(^GMR(123,+GMRCIFN,0),U,14) Q  ; don;t alert on own actions
 . S GMRCADUZ(+$P(^GMR(123,+GMRCIFN,0),U,14))=""
 I FLG,$P(^GMR(123,+GMRCIFN,0),"^",11) S GMRCADUZ($P(^(0),"^",11))=""
 S:'$D(GMRCADUZ) GMRCADUZ=""
 N X S X="" F  S X=$O(GMRCADUZ(X)) Q:((X="")!(X=DUZ))  I +X=DUZ K GMRCADUZ(X) ;Don't send alert to user generating alert
 D EN^ORB3(ORN,GMRCDFN,GMRCORFN,.GMRCADUZ,GMRCALRM,GMRCIFN)
 Q
AUDIT ;Build processing activity audit trail multiple.
 S GMRCDT=$$NOW^XLFDT
AUDIT0 ;alternate entry with date already defined
 L +^GMR(123,+GMRCO,40):5 I '$T S GMRCUT=1,GMRCERR=1,GMRCERMS="Activity Trail Not filed - Consult In Use By Another User." L -^GMR(123,+GMRCO,40)  Q
 S:'$D(^GMR(123,+GMRCO,40,0)) ^(0)="^123.02DA^^"
 S DA=$S($P(^GMR(123,+GMRCO,40,0),"^",3):$P(^(0),"^",3)+1,1:1)
 S $P(^GMR(123,+GMRCO,40,0),"^",3,4)=DA_"^"_DA
AUDIT1 ;entry when the DA is not incremented (INCOMPLETE RPT writeovers)
 S GMRCORNP=$G(GMRCORNP) S:'$D(GMRCOM) GMRCOM=0
 S GMRCDEV=$G(GMRCDEV),GMRCFF=$G(GMRCFF),GMRCPA=$G(GMRCPA)
 S GMRCAD=$S('$D(GMRCAD):GMRCDT,1:GMRCAD)
 S GMRCRSLT=$G(GMRCRSLT) ;Added result with GMRC*3.0*4
 S DIE="^GMR(123,"_+GMRCO_",40,",DA(1)=+GMRCO
 I '$D(^GMR(123,DA(1),40,DA,0)) D
 . S DR=".01////^S X=GMRCDT;1////^S X=GMRCA;2////^S X=GMRCAD;3////^S X=GMRCORNP"
 . I GMRCA'=22 S DR=DR_";4////^S X=DUZ" ;if it's a print, pkg did it
 . S DR=DR_";6////^S X=GMRCFF;7////^S X=GMRCPA;9////^S X=GMRCRSLT;8///^S X=GMRCDEV"
 E  D
 . ;DR string on .01 allows write over, rather than forced new entry
 . S DR=".01///^S X=GMRCDT;1////^S X=GMRCA;2////^S X=GMRCAD;3////^S X=GMRCORNP;4////^S X=DUZ;6////^S X=GMRCFF;7////^S X=GMRCPA;9////^S X=GMRCRSLT;8///^S X=GMRCDEV"
 ;Added result to the DR string
 D ^DIE
COMMENT ;Enter comment
 I +$G(GMRCOM) S GMRCOM(0)=DA D
 . W !,"Enter COMMENT..."
 . N DIC,DWPK,DWLW,DIWESUB
 . S DIC=DIE_DA_",1,",DWPK=1,DWLW=74
 . S DIWESUB="COMMENTS" D EN^DIWE
 . I $P($G(^GMR(123.1,+$P(^GMR(123,+GMRCO,40,DA,0),U,2),0)),U)="ADDED COMMENT",'$O(^GMR(123,+GMRCO,40,DA,0)) D  Q
 .. S DA(1)=+GMRCO,DIK="^GMR(123,"_DA(1)_",40," D ^DIK K DIK
 .. Q
 . I $P($G(^GMR(123.1,+$P(^GMR(123,+GMRCO,40,DA,0),U,2),0)),U)="COMPLETE/UPDATE",$P($G(^GMR(123,+GMRCO,40,DA,0)),U,9)="" D
 .. N GMRCMT,GMRCMT1
 .. S (GMRCMT,GMRCMT1)=0
 .. F  S GMRCMT=$O(^GMR(123,+GMRCO,40,DA,1,GMRCMT)) Q:GMRCMT=""  D  Q:GMRCMT1=1
 ... I $TR($G(^GMR(123,+GMRCO,40,DA,1,GMRCMT,0))," ","")'="" S GMRCMT1=1
 .. I 'GMRCMT1 D  G:'GMRCQUIT COMMENT Q
 ... S GMRCQUIT=0
 ... W !!,"A comment is required to complete this request!",!
 ... D WP^DIE(123.02,DA_","_+GMRCO_",",5,,"@")
 ... K DIR
 ... S DIR("A")="Type 'Q' to quit or 'C' to continue entering a comment:"
 ... S DIR("B")="C"
 ... S DIR(0)="S^C:CONTINUE;Q:QUIT"
 ... S DIR("?")="Type 'Q' if you would like to abort completion of this Consult/Procedure."
 ... S DIR("?",1)="Type 'C' or press <RETURN> to re-enter your comments."
 ... D ^DIR K DIR I Y'="C" S GMRCQUIT=1,DA(1)=+GMRCO,DIK="^GMR(123,"_DA(1)_",40," D ^DIK K DIK
 . I '$G(DA) S DA=D0
 . I $D(^GMR(123,+GMRCO,40,DA,0)),$O(^GMR(123,+GMRCO,40,DA,0)) S $P(GMRCOM,"^",2)=1
 . Q
 L -^GMR(123,+GMRCO,40)
 ; if an IFC, call event handler to generate a msg to remote site
 I $D(^GMR(123,GMRCO,12)),$L($P(^(12),U,5)) D
 . Q:'$D(^GMR(123,GMRCO,40,DA)) 
 . D TRIGR^GMRCIEVT(GMRCO,DA)
 ;
 K DIE,DA,DR,GMRCDEV,GMRCFF,GMRCPA,X,% Q
 ;
STATUS ;Update the status for the Request/Consultation File
 K GMRCQUT
 Q:'$D(GMRCSTS)!('$D(GMRCA))
 S DIE=123,DA=+GMRCO
 I $D(GMRCDR),$L(GMRCDR) S DR=GMRCDR
 E  S DR="8////^S X=GMRCSTS;9////^S X=GMRCA"
 L +^GMR(123,GMRCO):2 I '$T S GMRCQUT=1,GMRCERR=1,GMRCERMS="Unable to update status and last action - Consult In Use By Another User." Q
 D ^DIE
 L -^GMR(123,+GMRCO)
 K DIE,DA,DR,GMRCDR
 Q
