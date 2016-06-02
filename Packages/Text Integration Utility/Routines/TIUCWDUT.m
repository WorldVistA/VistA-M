TIUCWDUT ;SLC/TDP - CWAD POSTINGS AUTO-DEMOTION UTILITY ;10/27/15  15:11
 ;;1.0;TEXT INTEGRATION UTILITIES;**291**;Jun 20, 1997;Build 5
 Q
EN ;
 W @IOF
 N TIUCWAD,TIUNON,TIUNOGO,STRING,POSTTL,RESTRICT
 ;I DUZ(0)'["@" D  Q
 ;. W !,"Because of TIU file #8925.1 security, programmer access with '@' is required for this option to work."
 D GETSCRN(.POSTTL,.RESTRICT)
 S TIUCWAD=$$GETCWAD(.POSTTL) Q:TIUCWAD'>0  W !
 S TIUNOGO=$$INHERIT(TIUCWAD) I TIUNOGO W !,"Okay.  Nothing will be changed." Q
 S TIUNON=$$GETNON(.POSTTL,.RESTRICT) Q:TIUNON'>0
 K POSTTL,RESTRICT
 S STRING="D SILENT^TIUCWD("_TIUCWAD_","_TIUNON_")"
 ;D CHECK Q:PREVPOST]""
 D FILE(TIUCWAD,STRING)
 W !!,"Done.  Post-Signature code has been set (or reset) as follows..."
 W !,"TITLE: "_$$GET1^DIQ(8925.1,TIUCWAD,.01)
 W !,"POST-SIGNATURE ACTION: "_$$GET1^DIQ(8925.1,TIUCWAD,4.9)
 Q
GETSCRN(POSTTL,RESTRICT) ;Set-up arrays used in ^DIC call screen
 N CWD,CWDEXC,CWDIEN,POSTDC,POSTLETT,QUIT,VHATITLE,X
 D GETLST^XPAR(.CWD,"PKG","TIU CWAD EXCLUDED TITLES","I")
 S X=""
 I $D(CWD) D
 . F  S X=$O(CWD(X)) Q:X=""  D
 .. S CWDIEN=+$G(CWD(X))
 .. I CWDIEN>0 D
 ... S CWDEXC(CWDIEN)=""
 . K CWD
 F POSTLETT="C","W","A","D" S POSTDC=$O(^TIU(8925.1,"APOST",POSTLETT,0)) I +POSTDC S POSTDC(POSTDC)=""
 S POSTDC=0
 F  S POSTDC=$O(POSTDC(POSTDC)) Q:'+POSTDC  D
 . S POSTTL=0
 . F  S POSTTL=+$O(^TIU(8925.1,POSTDC,10,"B",POSTTL)) Q:'+POSTTL  D
 .. S VHATITLE=+$P($G(^TIU(8925.1,POSTTL,15)),U,1)
 .. S QUIT=0
 .. I $D(CWDEXC(VHATITLE)) S RESTRICT(POSTTL)="",QUIT=1
 .. I QUIT=0 S POSTTL(POSTTL)=""
 Q
GETCWAD(POSTTL) ;Select CWAD type documents
 N DIC,DLAYGO,DTOUT,DUOUT,X,Y
 S DIC=8925.1,DIC(0)="AEMQ",DIC("A")="Select a CWAD/Postings TITLE for auto-demotion: "
 S DIC("S")="I $D(POSTTL(Y))"
 D ^DIC
 Q +Y
GETNON(POSTTL,RESTRICT) ;Select non-CWAD type documents
 N DIC,DLAYGO,DTOUT,DUOUT,X,Y
 S DIC=8925.1,DIC(0)="AEMQ",DIC("A")="Select a NON-Posting TITLE as the demotion target: "
 S DIC("S")="I ($P($G(^TIU(8925.1,Y,0)),U,4)=""DOC"")&('$D(POSTTL(Y))&('$D(RESTRICT(Y))))"
 D ^DIC
 Q +Y
CHECK ;This subroutine is being orphaned as of 8-28-09
 ;S PREVPOST=$$POSTSIGN^TIULC1(TIUCWAD)
 ;I PREVPOST]"" D
 ;. W !,"The selected CWAD/Postings title already has a TIU POST-SIGNATURE ACTION,"
 ;. W !,"possibly by inheritance."
 ;. W !!,"It is --> ",PREVPOST
 ;. W !,"You will have to set the code manually through programmer-access FileMan."
 ;Q
INHERIT(TIUCWAD) ;Previous Post-Signature Action
 ;Returns a 1 to indicate No-Go, meaning do not proceed
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,PREVPOST,X,Y
 S Y=0
 S PREVPOST=$$POSTSIGN^TIULC1(TIUCWAD)
 Q:PREVPOST']"" 0
 W !,"The selected CWAD/Postings title already has a TIU POST-SIGNATURE ACTION,"
 W !,"possibly by inheritance."
 W !!,"It is --> ",PREVPOST
 W !!,"Do you wish to CONTINUE (and thus OVERWRITE) the Post-Signature Action?"
 W !,"You can also choose to exit, which will make no changes.",!
 S DIR(0)="YA",DIR("A")="Continue/overwrite? (Y/N): "
 D ^DIR
 Q $S(+Y'=1:1,1:0)
FILE(TIUCWAD,STRING) ;Saves new Post-Signature Action
 ;Changing to a direct file save to get past file protections.
 ;N DA,DIDEL,DIE,DR,DTOUT,BKPDUZ0
 ;S DIE=8925.1,DA=TIUCWAD,DR="4.9///^S X=STRING" D ^DIE
 S ^TIU(8925.1,TIUCWAD,4.9)=STRING
 Q
