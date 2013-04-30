LRAPDSR ;DALOI/STAFF - AP SUPPLEMENTARY REPORT ENTRY;Dec 17, 2008
 ;;5.2;LAB SERVICE;**248,259,295,317,350**;Sep 27, 1994;Build 230
 ;
 N LRYTMP,LRWPROOT,LRRLS,LRRLS1,LRRLS2,LRX,LRIENS,LRFILE1,LRFILE,LRA
 N LRIENS1,LRXTMP,LRFDA,LRNOW,LRIENS2,LRFIELD,LRORIEN,LRFLG,LRDA,LRQUIT,LRSRDA
 ;
MAIN ; Main Subroutine
 D RELEAS1
 D GETRPT
 Q:LRQUIT
 D RELEAS2
 Q:LRQUIT
 D:LRRLS COPY
 Q:LRQUIT
 D RPT
 ;
 ; Ask for performing laboratory assignment
 D EDIT^LRRPLU(LRDFN,LRSS,LRI)
 ;
 ; Add supp report to the PRELIMINARY print queue
 D QUESP
 Q:LRQUIT
 D COMPARE
 Q:LRQUIT
 ;
 ; If supp report is already released (LRRLS1) unrelease it only if the E-Sign Switch is ON (LRESSW)
 N LRESSW
 D GETDATA^LRAPESON(.LRESSW)
 I LRRLS1,LRESSW D UNRELEAS
 D UPDATE
 Q:LRQUIT
 D STORE
 Q
 ;
 ;
RELEAS1 ; Is the ENTIRE report already released?
 S (LRRLS,LRRLS1,LRQUIT)=0
 I LRSS="AU" D  Q
 . S LRX=$P($G(^LR(LRDFN,LRSS)),"^",15)
 . Q:'LRX  ; Report has not been released so no audit will occur.
 . W !!,$C(7),"This AUTOPSY has been released.  Supplementary report additions/modifications"
 . W !,"will create an audit trail.",!
 . S LRRLS=1    ; Report has been released so auditing will occur.
 S LRX=$P($G(^LR(LRDFN,LRSS,LRI,0)),"^",11)
 ;
 I LRX D
 . W $C(7),!!,"This "_$G(LRAA(1))_" report has been released."
 . W !,"Supplementary report additions/modifications will create an audit trail.",!
 . S LRRLS=1
 Q
 ;
 ;
GETRPT ; First, select the report
 ;
 N DA,DIC,DO,DIR,DIRUT,DTOUT,DUOUT,LRLAST,LRSFN,LRX,X,Y
 ;
 S (X,Y)=0
 I LRSS'="AU" D
 . F  S X=$O(^LR(LRDFN,LRSS,LRI,1.2,X)) Q:'X  D
 . . S X(0)=^LR(LRDFN,LRSS,LRI,1.2,X,0),Y=Y+1
 . . S DIR("A",Y)=Y_" - "_$$FMTE^XLFDT($P(X(0),"^"),"1M")
 . . S LRSFN=$S(LRSS="SP":63.817,LRSS="CY":63.907,LRSS="EM":63.207,1:"")
 . . I $P(X(0),"^",2)'="" S DIR("A",Y)=DIR("A",Y)_"  Released: "_$$EXTERNAL^DILFD(LRSFN,.02,"",$P(X(0),"^",2))
 . . I $P(X(0),"^",3)'="" S DIR("A",Y)=DIR("A",Y)_"  Report Modified: "_$$EXTERNAL^DILFD(LRSFN,.03,"",$P(X(0),"^",3))
 . . S LRX(Y)=X
 ;
 I LRSS="AU" D
 . F  S X=$O(^LR(LRDFN,84,X)) Q:'X  D
 . . S X(0)=^LR(LRDFN,84,X,0),Y=Y+1
 . . S DIR("A",Y)=Y_" - "_$$FMTE^XLFDT($P(X(0),"^"),"1M")
 . . I $P(X(0),"^",2)'="" S DIR("A",Y)=DIR("A",Y)_"  Released: "_$$EXTERNAL^DILFD(63.324,.02,"",$P(X(0),"^",2))
 . . I $P(X(0),"^",3)'="" S DIR("A",Y)=DIR("A",Y)_"  Report Modified: "_$$EXTERNAL^DILFD(63.324,.03,"",$P(X(0),"^",3))
 . . S LRX(Y)=X
 ;
 S LRLAST=Y+1
 I LRLAST>1 D  Q:LRQUIT
 . S DIR("A",LRLAST)=LRLAST_" - Add a new SUPPLEMENTARY REPORT"
 . S DIR("A")="Select SUPPLEMENTARY REPORT"
 . S DIR("?",1)="Enter a number from 1 to "_LRLAST
 . S DIR("?")="Select the number of the supplementary report to edit"
 . S DIR(0)="NO:1:"_LRLAST_":0"
 . D ^DIR
 . I Y<1 S LRQUIT=1 Q
 ;
 ; Selected existing report
 I LRLAST>1,Y<LRLAST S LRSRDA=LRX(Y) Q
 ;
 ; Adding new report - ask for new date/time
 K DIR,DIRUT,DTOUT,DUOUT,X,Y
 I LRLAST=1 W !,"Adding a new SUPPLEMENTARY REPORT"
 S DIR(0)=$S(LRSS="SP":63.817,LRSS="CY":63.907,LRSS="AU":63.324,LRSS="EM":63.207,1:"")_",.01"
 D ^DIR
 I Y<1 S LRQUIT=1 Q
 ;
 K DA,DO,DIC
 I LRSS'="AU" S DIC="^LR(LRDFN,LRSS,LRI,1.2,",DA(1)=LRDFN,DA=LRI
 E  S DIC="^LR(LRDFN,84,",DA=LRDFN
 S DIC(0)="EF",X=+Y,DIC("DR")=".02////0"
 D FILE^DICN
 I Y<1 S LRQUIT=1
 S LRSRDA=+Y
 ;
 Q
 ;
 ;
RELEAS2 ; Is the supplementary report already released?
 ;
 I LRSS'="AU" S LRX=$G(^LR(LRDFN,LRSS,LRI,1.2,LRSRDA,0))
 E  S LRX=$G(^LR(LRDFN,84,LRSRDA,0))
 S LRRLS2=+$P(LRX,"^",2)
 I LRRLS2 D
 . N DIR,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="YO",DIR("B")="NO"
 . S DIR("A",1)=$C(7)
 . S DIR("A",2)="This supplementary report has been released."
 . S DIR("A",3)="Additions/modifications will create an audit trail."
 . S DIR("A")="Sure you want to update this record"
 . D ^DIR
 . I Y=1 S LRRLS1=1
 . E  S LRQUIT=1
 Q
 ;
 ;
COPY ; Make a copy of the current report.
 K ^TMP("DIQ1",$J)
 S LRIENS=LRSRDA_","_$S(LRSS'="AU":LRI_",",1:"")_LRDFN_","
 S LRFILE1=$S(LRSS="SP":63.817,LRSS="CY":63.907,LRSS="EM":63.207,1:"")
 S:LRFILE1="" LRFILE1=$S(LRSS="AU":63.324,1:"")
 I LRFILE1="" S LRQUIT=1 Q
 D GETS^DIQ(LRFILE1,LRIENS,"**","Z","^TMP(""DIQ1"",$J)")
 Q
 ;
 ;
RPT ;
 N DIE,DA,DR
 ;S DIE=DIC K DIC
 S DIE=$S(LRSS="AU":"^LR(LRDFN,84,",1:"^LR(LRDFN,LRSS,LRI,1.2,")
 S (LRDA,DA)=LRSRDA
 S:LRSS="AU" DA(1)=LRDFN
 S:LRSS'="AU" DA(1)=LRI,DA(2)=LRDFN
 S DR=".01;1" D ^DIE
 I 'LRRLS S LRQUIT=1
 Q
 ;
 ;
QUESP ; Update the preliminary report print queue
 N LRIENS
 I '$D(^LRO(69.2,LRAA,1,LRAN,0)) D
 . K LRFDA
 . L +^LRO(69.2,LRAA,1):DILOCKTM
 . I '$T D  Q
 . . S MSG(1)="The preliminary reports queue is in use.",MSG(1,"F")="!!"
 . . S MSG(2)="You will need to add this accession to the queue later."
 . . D EN^DDIOL(.MSG) K MSG
 . S LRIENS="+1,"_LRAA_","
 . S LRFDA(69.21,LRIENS,.01)=LRDFN
 . S LRFDA(69.21,LRIENS,1)=LRI
 . S LRFDA(69.21,LRIENS,2)=LRH(0)
 . S LRORIEN(1)=LRAN
 . D UPDATE^DIE("","LRFDA","LRORIEN")
 . L -^LRO(69.2,LRAA,1)
 Q
 ;
 ;
COMPARE ; Compare reports
 I '$D(^TMP("DIQ1",$J)) S LRQUIT=1 Q
 S:LRSS'="AU" LRFILE="^LR(LRDFN,LRSS,LRI,1.2,LRDA,1,"
 S:LRSS="AU" LRFILE="^LR(LRDFN,84,LRDA,1,"
 I '$D(@(LRFILE_"0)")) D  Q
 . D:LRRLS1 UNRELEAS
 . S LRQUIT=1
 S LRA=0,LRFLG=1
 F  S LRA=$O(@(LRFILE_"LRA)")) Q:'LRA  D
 . S LRXTMP=@(LRFILE_"LRA,0)")
 . S:'$D(^TMP("DIQ1",$J,LRFILE1,LRIENS,1,LRA,0)) LRFLG=0
 . Q:'LRFLG
 . S LRYTMP=^TMP("DIQ1",$J,LRFILE1,LRIENS,1,LRA,0)
 . I LRXTMP'=LRYTMP S LRFLG=0
 I LRFLG D
 . S LRA=0
 . F  S LRA=$O(^TMP("DIQ1",$J,LRFILE1,LRIENS,1,LRA)) Q:'LRA  D
 . . I '$D(@(LRFILE_"LRA,0)")) S LRFLG=0
 I LRFLG D
 . W $C(7),!!,"No changes were made to the supplementary report."
 . K ^TMP("DIQ1",$J)
 . S LRQUIT=1
 Q
 ;
 ;
UNRELEAS ; Unrelease the supplementary report.
 K LRFDA
 S LRFDA(1,LRFILE1,LRIENS,.02)="@"
 D UPDATE^DIE("","LRFDA(1)")
 Q
 ;
 ;
UPDATE ; File changes
 ; First, store the date of the change and user ID
 D UPDATE^LRPXRM(LRDFN,LRSS,+$G(LRI))
 K LRFDA
 S X="NOW",%DT="T" D ^%DT S LRNOW=Y
 S LRIENS1="+1,"_LRIENS
 S LRFILE=$S(LRSS="SP":63.8172,LRSS="CY":63.9072,LRSS="EM":63.2072,1:"")
 S:LRFILE="" LRFILE=$S(LRSS="AU":63.3242,1:"")
 I LRFILE="" S LRQUIT=1 Q
 S LRFDA(1,LRFILE,LRIENS1,.01)=LRNOW
 S LRFDA(1,LRFILE,LRIENS1,.02)=DUZ,LRFIELD=1
 D UPDATE^DIE("","LRFDA(1)","LRORIEN")
 ;If E-Sign switch OFF,set 3rd piece .03 SUPP REPORT MODIFIED to 1
 ;  to flag the supp report so it can be released via RS
 I 'LRESSW D
 . S:LRSS'="AU" $P(^LR(LRDFN,LRSS,LRI,1.2,LRDA,0),"^",3)=1
 . S:LRSS="AU" $P(^LR(LRDFN,84,LRDA,0),"^",3)=1
 Q
 ;
 ;
STORE ; Second, store the original report
 S LRIENS2=LRORIEN(1)_","_LRIENS
 S LRWPROOT="^TMP(""DIQ1"",$J,LRFILE1,LRIENS,1)"
 D WP^DIE(LRFILE,LRIENS2,LRFIELD,"",LRWPROOT)
 K ^TMP("DIQ1",$J)
 Q
