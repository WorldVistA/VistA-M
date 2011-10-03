LRVERA ;DALOI/JMC - READ ACCESSION/UID ;2/7/91  14:49
 ;;5.2;LAB SERVICE;**153,271,286**;Sep 27, 1994
 ;
 ;
ACC ; Prompt for accession selection
 D EN^LRWU4
 Q
 ;
 ;
UID ; Prompt for UID selection
 ;
 N LRQUIT,LRX,LRY
 ;
 W !
 S (LRQUIT,LRY)=0
 F  D  Q:LRQUIT
 . S LRX=$$UID^LRWU4("Unique Identifier",$G(LRUID))
 . I LRX=0 S LRUID="",(LRAA,LRAD,LRAN)=-1,LRQUIT=1 Q
 . S LRY=$$CHECKUID^LRWU4(LRX)
 . I LRY S LRQUIT=1 Q
 . W !,"No accession on file for this UID."
 . S LRUID=""
 ;
 ; If good UID then update variables if user selected a different UID
 ; Display accession.
 I LRY D
 . I $G(LRUID)'=LRX S LRUID=LRX,LRAA=$P(LRY,"^",2),LRAD=$P(LRY,"^",3),LRAN=$P(LRY,"^",4)
 . W "   (",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^"),")"
 Q
 ;
 ;
SELPL(LR4) ; Select the performing laboratory to store with test results.
 ; Call with LR4 = default institution, usually value of DUZ(2)
 ;
 ; Returns LR4 = ien of file #4 institution selected
 ;
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DIC(4,",DIC(0)="AEMOQ"
 S DIC("A")="Select Performing Laboratory: "
 I $G(LR4)>0 S DIC("B")=$$GET1^DIQ(4,LR4_",",.01)
 S DIC("S")="I $$SCRNPL^LRVERA"
 D ^DIC
 I Y<1 S LR4=0
 E  S LR4=$P(Y,"^")
 ;
 Q LR4
 ;
 ;
SCRNPL() ; Screen performing laboratory
 ; Called by DIC("S") lookup above when selecting performing laboratory
 N OK,LRX
 S OK=0
 I Y=DUZ(2) S OK=1
 E  I $D(^LAHM(62.9,"CH",DUZ(2),Y)) S OK=1
 Q OK
 ;
 ;
PLOK(LRX,LRY,LRZ,LR60) ; Check if user is editing results that appear to have
 ; been performed by a lab different from the one they selected and.
 ; ask if changing performing lab is ok.
 ;
 ; Call with LRX = file #4 ien of performing lab on record
 ;           LRY = file #4 ien of performing lab user selected
 ;           LRZ = user's current division - DUZ(2)
 ;          LR60 = file #60 ien of test selected
 ;
 ; Returns 1=YES, 0=NO
 ;
 N DIR,DIRUT,DTOUT,DUOUT,OK,X,Y
 S OK=1
 I LRX D
 . I LRY,LRX=LRY Q
 . I LRX=LRZ Q
 . S DIR("A",1)="The performing lab recorded for test "_$$GET1^DIQ(60,LR60_",",.01)_" is: "_$$GET1^DIQ(4,LRX_",",.01)
 . S DIR("A",2)="You indicated the performing lab is: "_$$GET1^DIQ(4,$S(LRY:LRY,1:LRZ)_",",.01)
 . S DIR("A")="Do you want to continue",DIR("B")="NO"
 . S DIR(0)="YO",OK=0
 . W ! D ^DIR
 . I Y=1 S OK=1
 Q OK
 ;
 ;
RFLAG(FLAG) ; Ask user for referral high/low/critical flag in case they
 ; don't have values to calculate.
 ; Call with FLAG = current abnormal flag if any
 ;
 ; Returns NULL=no selection  0=Calculate from entered values
 ;            1=Abnormal Low  2=Critical Low
 ;            3=Abnormal High 4=Critical High
 ;
 N DIR,DIROUT,DIRUT,DTOUT,X,Y
 S DIR(0)="SOA^0:Calculate from entered values;1:Abnormal Low;2:Critical Low;3:Abnormal High;4:Critical High"
 S DIR("A")="Result's Abnormality: "
 S DIR("B")="Calculate from entered values"
 I $G(FLAG)'="" S DIR("B")=$S(FLAG="L":"Abnormal Low",FLAG="L*":"Critical Low",FLAG="H":"Abnormal High",FLAG="H*":"Critical High",1:DIR("B"))
 S DIR("?")="Select the abnormality if it cannot be calculated from reference values."
 D ^DIR
 I $D(DIRUT) S Y=""
 Q Y
 ;
 ;
DCOM ; From above and LRVR4 - display comments
 ;
 ; Quit if no current or previous comments
 I '$O(^LR(LRDFN,LRSS,LRIDT,1,0)),'$O(^LR(LRDFN,LRSS,+$G(LRLDT),1,0)) Q
 ;
 N DA
 ;
 ; Display previous comments.
 I $G(LRCMTDSP),$G(LRLDT)>0,$O(^LR(LRDFN,LRSS,LRLDT,1,0)) D
 . W !,"*** Comments for Previous Accession "_$P($G(Z2),"^",6)_" ***"
 . S DA=LRLDT D DSPCMT
 ;
 ; Display current comments
 I $O(^LR(LRDFN,LRSS,LRIDT,1,0)) D
 . I $G(LRCMTDSP),$G(LRLDT)>0,$O(^LR(LRDFN,LRSS,LRLDT,1,0)) D
 . . W !,"*** Comments for Current Accession "_$G(LRACC)_" ***"
 . . S LRLCT=LRLCT+1
 . S DA=LRIDT D DSPCMT
 Q
 ;
 ;
CMTDSP ; Determine if display of previous results should include associated comments.
 ;
 N ERR,I
 ;
 ; Get stored list of tests from parameter tool
 K ^TMP("LRXPAR",$J),^TMP("LR",$J,"DCMT")
 D GETLST^XPAR("^TMP(""LRXPAR"",$J)","USR","LR VER DISPLAY PREV COMMENT","Q",.ERR,1)
 I '$G(^TMP("LRXPAR",$J)) Q
 ; Create list based in file #60 ien - makes checking easier
 S I=0
 F  S I=$O(^TMP("LRXPAR",$J,I)) Q:'I  I $P(^(I),"^",2) S ^TMP("LR",$J,"DCMT",+^TMP("LRXPAR",$J,I))=""
 K ^TMP("LRXPAR",$J)
 Q
 ;
 ;
CHKCDSP() ; Check if previous comment should display when test on user's list 
 ; is present on test profile selected for this accession.
 ;
 N I,OK
 S OK=0
 I $G(LRLDT)>0,$D(^TMP("LR",$J,"DCMT")) D
 . S I=0
 . F  S I=$O(LRM(I)) Q:'I  D  Q:OK
 . . I $D(^TMP("LR",$J,"DCMT",+LRM(I))) S OK=1 Q
 . . I $G(LRM(I,"P")),$D(^TMP("LR",$J,"DCMT",+LRM(I,"P"))) S OK=1 Q
 Q OK
 ;
 ;
DSPCMT ; Display comments stored in file #63
 N DIR,DIRUT,DTOUT,DUOUT,I,X,Y
 S I=0
 F  S I=$O(^LR(LRDFN,LRSS,DA,1,I)) Q:'I  D  Q:$D(DIRUT)
 . S LRLCT=LRLCT+1
 . W !,"COMMENTS: ",$P(^LR(LRDFN,LRSS,DA,1,I,0),"^")
 . I LRLCT>21,$E(IOST,1,2)="C-" D  Q:$D(DIRUT)
 . . S DIR(0)="E" D ^DIR
 . . S LRLCT=0
 W ! S LRLCT=LRLCT+1
 Q
