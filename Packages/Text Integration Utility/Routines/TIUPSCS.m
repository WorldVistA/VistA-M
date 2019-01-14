TIUPSCS ;BPOIFO/EL/CR - TIU DOCUMENT POST-SIGNATURE ALERT SETUP ;10/29/17 8:15am
 ;;1.0;TEXT INTEGRATION UTILITIES;**305**;JUN 20, 1997;Build 27
 ;
 ; External Reference DBIA#:
 ; -------------------------
 ; #2056  - $$GET1^DIQ call (Supported)
 ; #6811  - Reference to file #100.21 (Private)
 ; #10006 - DIC call (Supported)
 ; #10026 - DIR call (Supported) 
 ; #10060 - Reference to file 200 (Supported)
 ; #10111 - Reference to file 3.8 (Supported)
 Q
 ;
BUILD ;
 ; allow a CAC to setup the title for post-signature alerts - a controlled situation
 S ^TIU(8925.1,TIUIEN,4.9)=TIUDR
 W !!,"The Post-Signature code for '"_$$GET1^DIQ(TIUFLE,TIUIEN,.01)_"' has been updated as follows..."
 W !,"POST-SIGNATURE CODE: "_$$GET1^DIQ(TIUFLE,TIUIEN,4.9)
 Q
 ;
CONFIRM ;
 S (TIUDR,Y)=""
 I TIUXQA=+TIUXQA S TIUDR="D EN^TIUPSCA("_TIUXQA_","""_$G(TIUSPEC)_""","""_$G(TIUDEV)_""")"
 E  S TIUDR="D EN^TIUPSCA("""_TIUXQA_""","""_$G(TIUSPEC)_""","""_$G(TIUDEV)_""")"
 W !!,"The Post-Signature code for '"_TIUNAME_"' will be set as follows..."
 W !,"POST-SIGNATURE CODE: "_TIUDR,!
 S DIR("T")=TIUWAIT
 S DIR(0)="Y"
 S DIR("A")="Do you want to update Post-Signature Code into '"_TIUNAME_"'"
 S DIR("B")="NO"
 D ^DIR K DIR
 I $D(DIRUT)!'$G(Y) D  S TIUGO=0 Q
 . W !!,"No action has been taken!!"
 Q
 ;
DEL ; use to clean up an existing setup
 S DIR("T")=TIUWAIT
 S DIR(0)="Y"
 S DIR("A")="Do you want to delete Post-Signature Code from '"_TIUNAME_"'"
 S DIR("B")="NO"
 D ^DIR K DIR
 I $D(DIRUT)!'$G(Y) D  S TIUGO=0 Q
 . W !!,"No action has been taken!!"
 ; allow a CAC to delete a setup when needed - a controlled situation
 S ^TIU(8925.1,TIUIEN,4.9)=""
 W !,"... Deleted ..."
 H 1
 Q
 ;
DEVICE ;
 W !
 S (TIUDEV,Y)=""
 S DIC=3.5,DIC(0)="AEMQ",DIC("A")="DEVICE NAME (Optional) for Paper Alert: "
 D ^DIC K DIC
 I $D(DUOUT)!$D(DTOUT) D  S TIUGO=0 G DEVQ
 . W !!,"ABORT DEVICE - No action is taken."
 I $G(Y)>0 S TIUDEV=$P(Y,U,2)
DEVQ ;
 Q
 ;
EN ; entry point for the option [TIUFPC CREATE POST-SIGNATURE] 
 N DA,DIROUT,DIRUT,DR,DTOUT,DUOUT
 N H1,H2,I,J,STOP,TIUDEV,TIUFILE,TIUFLD,TIUFLE,TIUGO,TIUIE,TIUIEN
 N TIUNAME,TIUPREV,TIURTN,TIUSPEC,TIUST,TIUWAIT,TIUWHO,TIUXQA
 N X,Y,Z,Z1,Z2,ZZ,ZZIEN
 ;
 S TIUWAIT=30
 I $G(DTIME)'="" S TIUWAIT=DTIME
 S TIUFLE=8925.1
 S STOP=0,TIUGO=1
 I '$D(U) S U="^"
 ;
EN10 ;
 I $G(STOP)=1 Q
 D INTRO
 W ! D GETTITLE Q:$G(STOP)=1  I $G(TIUGO)=0 D STOP G EN10
 W ! D WHO I $G(TIUGO)=0 D STOP G EN10
 W ! D SUBROUT I $G(TIUGO)=0 D STOP G EN10
 W ! D DEVICE I $G(TIUGO)=0 D STOP G EN10
 W ! D CONFIRM I $G(TIUGO)=0 D STOP G EN10
 W ! D BUILD D STOP
 G EN10
 ;
GETFLD(TIUFLE,TIUIEN,TIUFLD,TIUIE) ; Get field value
 K ZZ S (Z,ZZIEN)=""
 S ZZIEN=TIUIEN_","
 D GETS^DIQ(TIUFLE,ZZIEN,TIUFLD,TIUIE,"ZZ")
 S Z=$G(ZZ(TIUFLE,ZZIEN,TIUFLD,TIUIE))
 Q $G(Z)
 ;
GETTITLE ;
 S (TIUIEN,TIUNAME,Y)=""
 S TIUGO=1
 S DIC=TIUFLE,DIC(0)="AEMQ"
 D ^DIC K DIC
 I $G(Y)'>0!$D(DTOUT)!$D(DUOUT) S TIUGO=0,STOP=1 Q
 S TIUIEN=+$G(Y),TIUNAME=$P(Y,U,2)
 ; lock the title to be updated, the lock is released at the end the setup at tag STOP
 L +^TIU(TIUFLE,TIUIEN):1 E  W !!,"Someone else is editing this record, try again later.",! S STOP=1 Q 
 ; Check Class
 S (TIUFLD,TIUIE,Z)=""
 S TIUGO=1
 S TIUFLD=.13,TIUIE="I"
 S Z=$$GETFLD(TIUFLE,TIUIEN,TIUFLD,TIUIE)
 I +$G(Z)>0 D  S TIUGO=0 Q
 . W !!,"NATIONAL STANDARD Document Type cannot be edited."
 S TIUFLD=.04,TIUIE="I"
 S Z=$$GETFLD(TIUFLE,TIUIEN,TIUFLD,TIUIE)
 I $G(Z)'="DOC" D  S TIUGO=0 Q
 . W !!,"Only Document Title is allowed to be edited."
 ;
 ; Check Inherit
 S (TIUPREV)=""
 S TIUGO=1
 S TIUPREV=$$POSTSIGN^TIULC1(TIUIEN)
 I $G(TIUPREV)="" G STATUS
 ; once the title has been set up for the post-sig alert, get the closing ')'
 ; at the end of the parameters list
 I $E(TIUPREV,$L(TIUPREV))'=")" D  S TIUGO=0 Q
 .  W !!,"This application cannot alter more than one alert call at a time."
 .  W !,"It is --> ",TIUPREV
 I $P(TIUPREV,"(")="D EN^TIUPSCA" D  G STATUS
 .  W !!,"The POST-SIGNATURE Code in '"_TIUNAME_"' was created by this option."
 .  W !,"It is --> ",TIUPREV
 .  S DIR("A")="Do you want to change the Code? (YES or NO)"
 .  S DIR("T")=TIUWAIT
 .  S DIR(0)="Y"
 .  S DIR("B")="NO"
 .  W ! D ^DIR K DIR
 .  I $D(DIRUT)!($D(DTOUT))!('$G(Y)) S TIUGO=0
 I $G(TIUPREV)]"" D  S TIUGO=0 G STATUS
 . W !!,"The POST-SIGNATURE Code in '"_TIUNAME_"' was already set by another option."
 . W !,"It is --> ",TIUPREV
 . W !,"This Post-Signature Code cannot be altered in this option."
 . W !,"To change the code, please contact your local IT Support Programmer."
 . W !,"'Document Definitions (Manager) / Edit Document' option can be used."
 ;
STATUS ; Check
 I TIUGO=0 Q
 S (TIUFLD,TIUIE,TIUST,Y,Z)=""
 S TIUFLD=.07,TIUIE="I"
 S Z=$$GETFLD(TIUFLE,TIUIEN,TIUFLD,TIUIE),TIUST=$G(Z)
 I $G(Z)=11 Q
 S TIUIE="E",Z=$$GETFLD(TIUFLE,TIUIEN,TIUFLD,TIUIE),TIUST=$G(Z)
 W !!,"The STATUS of this Document Definition Title is '"_TIUST_"'."
 S DIR("A")="Do you want to continue with this title: '"_TIUNAME_"'"
 S DIR("T")=TIUWAIT
 S DIR(0)="Y"
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I $D(DIRUT)!('$G(Y)) S TIUGO=0 Q
 Q
 ;
INTRO ;
 W @IOF
 W !,"This option will setup 'Post-Signature Code Alerts' for PROGRESS NOTES."
 W !,"Please select a choice of RECIPIENTS, and a choice of ROUTINE,"
 W !,"and DEVICE (optional) to receive a printed alert upon note signature."
 W !!,"If both RECIPIENTS and ROUTINE are N/A, a choice of"
 W !,"DELETION or CANCELLATION for the Code Alert setting will be provided.",!!
 S (DA,DIC,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT)=""
 S (H1,H2,I,J,STOP,TIUDEV,TIUFILE,TIUFLD,TIUGO,TIUIE,TIUIEN)=""
 S (TIUNAME,TIUPREV,TIURTN,TIUSPEC,TIUST,TIUWHO,TIUXQA)=""
 S (X,Y,Z,Z1,Z2,ZZ,ZZIEN)=""
 ;
HD ; Header for Enter Post-Signature Code
 S STOP=0,TIUGO=1
 S (H1,H2,I)=""
 S H1="Enter Post-Signature Code for Alert"
 F I=1:1:$L(H1) S H2=H2_"="
 I $G(IOM)="" S IOM=76
 S X=(IOM-$L(H1))/2
 W ! F I=1:1:X W " "
 W H1,! F I=1:1:X W " "
 W H2
 Q
 ;
STOP ; Check Continue
 S X="",STOP=0
 S X="Enter <RETURN> for another TIU Document Definition Name or "
 S X=X_"'^' to exit: "
 W !!,X R Y:TIUWAIT S:'$T Y=U
 I $G(Y)=U S STOP=1,TIUGO=0
 L -^TIU(TIUFLE,TIUIEN)
 Q
 ;
SUBROUT ;
 K TIUARY,TIURTN
 S (I,J,TIUARY,TIURTN,TIUSPEC,Y,Z,Z1,Z2)=""
 S DIR("T")=TIUWAIT
 S DIR("A")="Choose an alert ROUTINE from the above listing"
 S TIUARY=$$GETRTN^TIUPSCA(.TIUARY)
 F I=1:1 Q:$G(TIUARY(I))=""  D  S DIR("A",I)=I_") "_TIURTN(I)
 . S Z="",Z=TIUARY(I)
 . S (J,Z1,Z2)=""
 . S Z1=$P(Z,"-"),Z2=$P(Z,"-",2) F J=1:1:9-$L(Z1) ; S Z1=Z1_" "
 . S TIURTN(I)=Z1_"- "_Z2
 S DIR("A",I)="",J=I-1
 S DIR(0)="NO^1:"_J
 D ^DIR K DIR
 I $D(DIRUT) D  S TIUGO=0 G SUBQ
 . W !!,"ABORT alert ROUTINE - No action is taken."
 I $G(Y)="" W !!,"This is a required response. OR Enter '^' to exit",! H 1 G SUBROUT
 I $G(Y)=1 S TIUSPEC=""
 E  S Z=$G(TIUARY(Y)),TIUSPEC=$P(Z,"-")
 I $G(TIUXQA)="",$G(TIUSPEC)="",$G(TIUPREV)="" D  S TIUGO=0 G SUBQ
 . W !!,"Without RECIPIENT and ROUTINE, alert code setting is cancelled." H 1
 I $G(TIUXQA)="",$G(TIUSPEC)="",$G(TIUPREV)'="" D  G SUBQ
 . S DIR("A")="W/O RECIPIENT and ROUTINE, ALERT CODE will be deleted? (YES or NO)"
 . S DIR("T")=TIUWAIT
 . S DIR(0)="Y"
 . S DIR("B")="NO"
 . W ! D ^DIR K DIR
 . I $D(DIRUT)!'$G(Y) D  S TIUGO=0 Q
 . .  W !!,"No action has been taken!!" S TIUGO=0
 . S TIUGO=0 D DEL Q
SUBQ Q
 ;
WHO ; Select Alert Recipient
 S (TIUWHO,Y)=""
 S DIR(0)="S^N:N/A;I:INDIVIDUAL USER;G:MAILGROUP;T:TEAM LIST (OE/RR with Queued Alert)"
 S DIR("A")="Choose RECIPIENTS to receive the alert (N/I/G/T) or '^' to exit"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S TIUGO=0 Q  ;G STOP
 S TIUWHO=$G(Y)
 ; XQA set up
 S (TIUFILE,TIUXQA,Y)=""
 S TIUFILE=$S(TIUWHO="I":200,TIUWHO="G":3.8,TIUWHO="T":100.21,1:"")
 S DIC=TIUFILE
 S DIC(0)="AEMQ"
 D ^DIC K DIC
 I $G(Y)'>0 S TIUXQA=""
 E  S TIUXQA=$S(TIUWHO="I":+Y,1:TIUWHO_"."_$$GET1^DIQ(TIUFILE,+Y,.01))
 Q
