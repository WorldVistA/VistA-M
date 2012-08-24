LRHYU ;DALOI/HOAK - HOWDY UTILITY CALLS 08/28/2005 ;12/1/10 11:29am
 ;;5.2;LAB SERVICE;**405**;Sep 27, 1994;Build 93
 ; 
 ; Reference to DUZ^XUP supported by DBIA #4129
 ;
 ; This routine is looking for anomilies related to the specimen
DUP ; from LRHYPH2 are there any duplicate tests
 S LRDUPT=0
 Q:+LRSN'>0  D
 .  S LRHT1=0
 .  F  S LRHT1=$O(^LRO(69,LRODT,1,LRSN,2,"B",LRHT1)) Q:+LRHT1'>0  D
 ..  I $D(^TMP("LRHYDY",$J,"LRHYDY",$J,LRDFN,LRORD,LRHT1)) S LRDUPT=1 QUIT
 QUIT
EDIT ;
 ; Enable editing of Howdy site file
 S (DIB,DIE)=69.86 D EN^DIB
 QUIT
D1 ;
 ; Check for specimen containing tests not to be accessioned.
 S LRHT1=0
 F  S LRHT1=$O(^LRO(69,LRODT,1,LRSN,2,"B",LRHT1)) Q:+LRHT1'>0  D
 .  S ^TMP("LRHYDY",$J,"LRHYDY",$J,LRDFN,LRORD,LRHT1)=""
 QUIT
NINE ;
 S DIR(0)="FUO^9:9"
 S DIR("A")="Please scan your ID badge"
 D ^DIR
 QUIT
XTMP ;
 N X,X1,X2
 S X1=DT,X2=365 D C^%DTC
 ;   ^XTMP(namespaced- subscript,0)=purge date^create date^optional 
 S ^XTMP("LRHY LABELS",0)=X_U_DT
 K ^TMP("LRHYDY",$J)
 K ^TMP("LRHYHOW1",$J)
 K ^TMP("LRHY ASH",$J)
 K ^TMP("LRHY3TST",$J)
 QUIT
USER ;
 I '$G(LRHYSITE) S DIC=69.86,DIC(0)="AEMQZ" D ^DIC S LRHYSITE=+Y
 I '$G(LRHYSITE) W !,"SITE NOT SELECTED" H 2 QUIT
 K LRHYUSER S LRHYUSER=DUZ
 IF '$D(^LRHY(69.86,LRHYSITE,56)) W !,"NO HOWDY USER DEFINED. PERSON SIGNED ON WILL BE USED." QUIT
 IF $D(^LRHY(69.86,LRHYSITE,56)) N LRX S LRX=$G(^LRHY(69.86,LRHYSITE,56))
 IF $G(LRX) D DUZ^XUP(LRX)
 W !,$P(^VA(200,DUZ,0),U)," IS THE HOWDY USER."
 QUIT
BAKUSER ;
 QUIT
 IF $G(LRHYUSER) D DUZ^XUP(LRHYUSER)
 K LRHYUSER
