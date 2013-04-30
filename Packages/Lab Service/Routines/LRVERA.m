LRVERA ;DALOI/JMC - READ ACCESSION/UID ;06/01/10  11:50
 ;;5.2;LAB SERVICE;**153,271,286,350**;Sep 27, 1994;Build 230
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
ACC ; Prompt for accession selection
 D EN^LRWU4
 Q
 ;
 ;
UID ; Prompt for UID selection
 ;
 ;ZEXCEPT: LRAA,LRAD,LRAN,LRUID
 ;
 N LRQUIT,LRX,LRY
 ;
 W !
 S (LRQUIT,LRY)=0
 F  D  Q:LRQUIT
 . S LRX=$$UID^LRWU4("Unique Identifier",$G(LRUID))
 . I LRX=0 S LRUID="",(LRAA,LRAD,LRAN)=-1,LRQUIT=1 Q
 . S LRY=$$CHECKUID^LRWU4(LRX,"")
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
SELPL(LR4,LRFLAG) ; Select the performing laboratory to store with test results.
 ; Call with LR4 = default institution, usually value of DUZ(2)
 ;        LRFLAG = 0 (host lab only) / 1 (allow selection of collecting or host lab)
 ;
 ; Returns LR4 = ien of file #4 institution selected
 ;
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DIC(4,",DIC(0)="AEMOQ",LRFLAG=+$G(LRFLAG)
 S DIC("A")="Select Performing Laboratory: "
 I $G(LR4)>0 S DIC("B")=$$GET1^DIQ(4,LR4_",",.01)
 S DIC("S")="I $$SCRNPL^LRVERA(LRFLAG)"
 D ^DIC
 I Y<1 S LR4=0
 E  S LR4=$P(Y,"^")
 ;
 Q LR4
 ;
 ;
SCRNPL(LRFLAG) ; Screen performing laboratory
 ; Called by DIC("S") lookup above when selecting performing laboratory
 ; Call with LRFLAG = allow selection of collecting or host lab
 ;
 ;ZEXCEPT: Y
 ;
 N OK
 S OK=0
 I Y=DUZ(2) S OK=1
 I 'OK D
 . I $D(^LAHM(62.9,"CH",DUZ(2),Y)) S OK=1 Q
 . I LRFLAG,$D(^LAHM(62.9,"CH",Y,DUZ(2))) S OK=1
 ;
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
SETRL(LRDFN,LRSS,LRIDT,LR4) ; Set reporting laboratory for entry in file #63
 ; Call with  LRDFN = File #63 IEN
 ;             LRSS = file #63 subscript
 ;            LRIDT = inverse date/time of specimen ("AU" should pass 0)
 ;              LR4 = file #4 IEN to store as reporting laboratory
 ;
 N FDA,LRDIE,LRFILE
 ;
 I LRSS'="AU",(LRDFN*LRIDT*LR4)<1 Q
 I LRSS'="AU",LR4=+$G(^LR(LRDFN,LRSS,LRIDT,"RF")) Q
 I LRSS="AU",LR4=$P($G(^LR(LRDFN,"AU")),"^",18) Q
 ;
 S LRFILE=$S(LRSS="CH":63.04,LRSS="MI":63.05,LRSS="SP":63.08,LRSS="CY":63.09,LRSS="EM":63.02,LRSS="AU":63,1:0)
 I LRFILE<1 Q
 ;
 I LRSS'="AU" S FDA(1,LRFILE,LRIDT_","_LRDFN_",",.345)=LR4
 E  S FDA(1,LRFILE,LRDFN_",",14.91)=LR4
 D FILE^DIE("","FDA(1)","LRDIE(1)")
 ;
 Q
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
 ;ZEXCEPT: LRACC,LRCMTDSP,LRDFN,LRIDT,LRLCT,LRLDT,LRSS,Z2
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
 ;ZEXCEPT: LRLDT,LRM
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
 ;
 ;ZEXCEPT: DA,IOST,LRDFN,LRLCT,LRSS
 ;
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
 ;
 ;
DSPHW(LRDFN,LRY) ; Display patient's height and weight
 ; Call with LRDFN = file #63 ien
 ;             LRY = array to return values, pass by value
 ;
 ; Returns array LRY with height and weight
 ;
 N DFN,GMRVSTR,LRDPF,LREND,LRROOT,X
 S X=$G(^LR(+LRDFN,0)),LRDPF=$P(X,"^",2),DFN=$P(X,"^",3),LREND=0
 I LRDPF'=2 Q
 K ^UTILITY($J,"GMRVD")
 S GMRVSTR(0)="^^1^",GMRVSTR="HT;WT" D EN1^GMRVUT0
 ;
 ; -- Height = Ht.^value^in^metric^cm^^^[*]^Q1;..;Qn
 ; -- Weight = Wt.^value^lb^metric^kg^BodyMassIndex^^[*]^Q1;..;Qn
 ;
 S LRROOT="^UTILITY($J,""GMRVD"")"
 F  S LRROOT=$Q(@LRROOT) Q:LRROOT=""  D  Q:LREND
 . I $QS(LRROOT,1)'=$J!($QS(LRROOT,2)'="GMRVD") S LREND=1 Q
 . S X=@LRROOT
 . I $QS(LRROOT,3)="HT" S LRY("HT")="Ht.^"_$P(X,"^",8)_"^in^"_$P(X,"^",13)_"^cm^^"_$P(X,"^")_"^"_$P(X,"^",12)_"^"_$P(X,"^",17)
 . I $QS(LRROOT,3)="WT" S LRY("WT")="Wt.^"_$P(X,"^",8)_"^lb^"_$P(X,"^",13)_"^kg^"_$P(X,"^",14)_"^"_$P(X,"^")_"^"_$P(X,U,12)_"^"_$P(X,"^",17)
 ;
 K ^UTILITY($J,"GMRVD")
 Q
 ;
 ;
XDELTACK ; Execute delta check in a controlled environment ("sand box")
 ;
 ;ZEXCEPT: LRDEL,LRDFN,LRIDT,LRLDT,LRSB,LRSPEC,LRSS
 ;
 N LR60,LRDB,LRI,LROK,LRSBSAV
 ;
 ; Check for "delta check days back" (LRDB) cutoff on test/specimen
 ; Don't execute delta check if past test/specimen's "days back".
 ; If no value for "days back" then execute delta check.
 ; ^TMP("LR",543187985,"TMP",291) = 901
 S LR60=+$G(^TMP("LR",$J,"TMP",LRSB)),LRDB=""
 I LR60,$G(LRSPEC) S LRDB=$P($G(^LAB(60,LR60,1,LRSPEC,.1)),"^",2)
 I LRDB'="" D  Q:LROK=0
 . I LRLDT<1 S LROK=0 Q
 . N LRDATE
 . S LROK=1,LRDATE(1)=$P(^LR(LRDFN,LRSS,LRIDT,0),"^"),LRDATE(2)=$P(^LR(LRDFN,LRSS,LRLDT,0),"^")
 . I $$FMDIFF^XLFDT(LRDATE(1),LRDATE(2),1)>LRDB S LROK=0
 ;
 ; Save LRSB array
 M LRSBSAV=LRSB
 ;
 ; Execute delta check, protect LRSBSAV array by NEWing
 D
 . N LRSBSAV
 . X LRDEL
 ;
 ; Compare/restore LRSB array with LRSBSAV array to protect data in LRSB that may
 ; have been altered inappropriately in the delta check.
 S LRI=0
 F  S LRI=$O(LRSBSAV(LRI)) Q:'LRI  D
 . I $D(LRSB(LRI)) S $P(LRSBSAV(LRI),"^")=$P(LRSB(LRI),"^")
 ;
 ; Merge LRSBSAV back into LRSB.
 ; Do not kill LRSB array in case new nodes created in LRSB by delta check
 M LRSB=LRSBSAV
 ;
 Q
