FBAADD1 ;WOIFO/SAB - REPROCESS OVERDUE BATCH ;4/19/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; ICRs
 ;  #2053  FILE^DIE
 ;  #2054  CLEAN^DILF
 ;  #10004 EN^DIQ
 ;  #10006 ^DIC
 ;  #10026 ^DIR
 ;  #10103 $$DOW^XLFDT, $$FMADD^XLFDT
 ;
 W !,"This option is used to reprocess an overdue payment batch."
 W !,"A batch is considered overdue if the Payment Batch Result message"
 W !,"has not been received by the 3rd weekday after the batch was"
 W !,"transmitted to Central Fee."
 W !
 W !,"The National Service Desk Austin should be contacted to determine"
 W !,"the status of the batch before using this option.  If Central Fee"
 W !,"already has the batch, you should request that Central Fee resend"
 W !,"the Payment Batch Result message.  If Central Fee does not have"
 W !,"the batch then use this option to reprocess it.",!
 ;
 N DA,DIC,DIR,DIRUT,DR,DTOUT,DUOUT,FBACT,FBDT,FBN,X,Y
 ;
 ; determine date that is 3 weekdays prior to the current date
 S FBDT=$$CALCDT(3,DT)
 ;
BT ; select batch
 S DIC="^FBAA(161.7,",DIC(0)="AEQ"
 ; status = TRANSMITTED and DATE TRANSMITTED not after FBDT
 S DIC("S")="I ($G(^(""ST""))=""T"")&($P($G(^(0)),""^"",14)'>"_FBDT_")"
 D ^DIC K DIC G END:Y<0
 L +^FBAA(161.7,+Y):$G(DILOCKTM,3)
 I '$T W !,"Another user is editing this batch.  Try again later." G BT
 S FBN=+Y
 ;
 ; display batch
 S DIC="^FBAA(161.7,",DA=FBN,DR="0:1;ST" W !! D EN^DIQ
 ;
 ; confirm help desk was contacted
 S DIR(0)="Y"
 S DIR("A")="Have you confirmed the batch is not in Central Fee"
 W !
 D ^DIR K DIR G:$D(DIRUT) END
 I 'Y W !,"Please contact the National Service Desk Austin to determine the batch status." G END
 ;
ASKACT ; ask action
 S DIR(0)="S^R:RETRANSMIT BY RESETTING BATCH STATUS;F:FLAG ENTIRE BATCH AS REJECTED"
 S DIR("A")="What action should be taken to reprocess this batch"
 D ^DIR K DIR G:$D(DIRUT) END
 S FBACT=Y
 ;
 ; confirm action
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to "_$S(FBACT="R":"retransmit",1:"reject")_" this batch"
 D ^DIR K DIR G:$D(DIRUT) END G:'Y ASKACT
 ;
 ; perform selected action
 I FBACT="R" D ACTR
 I FBACT="F" D ACTF
 ;
 ; display batch
 S DIC="^FBAA(161.7,",DA=FBN,DR="0:1;ST" W !! D EN^DIQ
 ;
END ;
 I $G(FBN) L -^FBAA(161.7,FBN)
 Q
 ;
CALCDT(FBN,FBDT) ; Calculate Date
 ; input
 ;   FBN  - (optional) integer, default 3
 ;   FBDT - (optional) date in FileMan internal format, default today
 ; returns date that is FBN workdays before the FBDT
 N FBC,FBI,FBPDT,FBRET,FBWKDAY
 S (FBDT,FBRET)=$G(FBDT,DT)
 S FBN=$G(FBN,3)
 S FBWKDAY="^Monday^Tuesday^Wednesday^Thursday^Friday^"
 S FBC=0
 I FBN>0 F FBI=-1:-1 D  I FBC'<FBN S FBRET=FBPDT Q
 . S FBPDT=$$FMADD^XLFDT(FBDT,FBI)
 . I FBWKDAY[("^"_$$DOW^XLFDT(FBPDT)_"^") S FBC=FBC+1
 Q FBRET
 ;
ACTR ; action R (retransmit)
 N FBFDA,FBSTAT,FZ
 S FZ=$G(^FBAA(161.7,FBN,0))
 ;
 ; determine status immediately prior to T (TRANSMITTED)
 S FBSTAT="S" ; init as S
 ; change to R for civil hospital batch that is not pricer exempt
 I $P(FZ,U,3)="B9",$P(FZ,U,15)="Y",$P(FZ,U,18)'="Y" S FBSTAT="R"
 ;
 ; update batch
 S FBFDA(161.7,FBN_",",11)=FBSTAT ; STATUS
 S FBFDA(161.7,FBN_",",12)="@" ; DATE TRANSMITTED
 S FBFDA(161.7,FBN_",",23)=DUZ ; STATUS SET TO RETRANSMIT BY
 S FBFDA(161.7,FBN_",",24)=DT ; STATUS SET TO RETRANSMIT DATE 
 D FILE^DIE("","FBFDA")
 I $D(DIERR) W !,"Error updating batch file."
 E  W !,"Batch status was updated. It will be included with the next transmission."
 D CLEAN^DILF
 Q
 ;
ACTF ; action F (flag as rejected)
 N FBAAB,FBAAOB,FBAAON,FBEMPTY,FBTYPE,FBX,FZ
 ;
 S FZ=$G(^FBAA(161.7,FBN,0))
 S FBAAB=$P(FZ,"^"),FBTYPE=$P(FZ,"^",3)
 S FBAAON=$P(FZ,"^",2),FBAAOB=$P(FZ,"^",8)_"-"_FBAAON
 ;
 ; verify that 1358 is avaiable for posting
 S FBX=$$CHK1358^FB1358(FBAAOB)
 I 'FBX W !,"Batch was not rejected.",!,$P(FBX,U,2) Q
 ;
 ; flag all line items as rejected
 D
 . N B,FBAARA,FBIENS,FBRFLAG,FBRR,J,K,L,M
 . S B=FBN
 . S FBRR="Rejected by Reprocess Overdue Batch"
 . S (FBRFLAG,FBAARA)=0
 . I FBTYPE="B2" D ALLT^FBAADD
 . I FBTYPE="B3" D ALLM^FBAADD
 . I FBTYPE="B5" D ALLP^FBAADD
 . I FBTYPE="B9" D ALLC^FBAADD
 . ;
 . ; update obligation for rejected lines that are posted by batch
 . I FBRFLAG D
 . . N FBX
 . . S FBRFLAG=0
 . . Q:FBAARA'>0
 . . S FBX=$$POSTBAT^FB1358(FBN,FBAARA,"R")
 . . I 'FBX D
 . . . W !,"Error posting $"_$FN(FBAARA,",",2)_" to 1358 for batch "_FBAAB
 . . . W !,"  "_$P(FBX,"^",2)
 ;
 ; check if batch is empty
 S FBEMPTY=1
 I FBTYPE="B2",$O(^FBAAC("AD",FBN,0)) S FBEMPTY=0
 I FBTYPE="B3",$O(^FBAAC("AC",FBN,0)) S FBEMPTY=0
 I FBTYPE="B5",$O(^FBAA(162.1,"AE",FBN,0)) S FBEMPTY=0
 I FBTYPE="B9",$O(^FBAAI("AC",FBN,0)) S FBEMPTY=0
 ;
 I 'FBEMPTY D
 . W !,"Batch was not completely rejected."
 . W !,"There are still payment line items in the batch."
 ;
 I FBEMPTY D
 . ; update batch
 . S FBFDA(161.7,FBN_",",11)="V" ; STATUS
 . S FBFDA(161.7,FBN_",",13)=DT ; DATE FINALIZED
 . S FBFDA(161.7,FBN_",",14)=DUZ ; PERSON WHO COMPLETED
 . S FBFDA(161.7,FBN_",",25)=1 ; TRANSMITTED BATCH WAS REJECTED
 . D FILE^DIE("","FBFDA")
 . I $D(DIERR) W !,"Error updating batch file."
 . E  W !,"Batch was rejected."
 . D CLEAN^DILF
 ;
 Q
 ;FBAADD1
