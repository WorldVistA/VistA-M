LRAPMRL1 ;DALOI/STAFF - AP MODIFY RELEASED REPORT CONT'D ;11/04/11  10:47
 ;;5.2;LAB SERVICE;**259,317,397,350**;Sep 27, 1994;Build 230
 ;
 Q
RELCHK ; Perform series of checks
 N RPCOMDT
 S LRQUIT=0
 I LRAU,$G(^LR(LRDFN,"AU"))="" D  Q
 . S LRMSG="No information found for this accession in the "
 . S LRMSG=LRMSG_"LAB DATA file (#63)."
 . D EN^DDIOL(LRMSG,"","!!") K LRMSG
 . S LRQUIT=1
 Q:LRQUIT
 K LRREL
 D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,$G(LRI))
 I 'LRREL(1) D
 . Q:'LRAU&($G(LRREL(3)))
 . ;KLL-SKIP THIS MSG IF AU RPT COMP DATE IS SET
 . S RPCOMDT=$$GET1^DIQ(63,LRDFN,13,"I")
 . Q:LRAU&($G(RPCOMDT))
 . S LRMSG=$C(7)_"Report has not been released.  Do not use this "
 . S LRMSG=LRMSG_"option."
 . D EN^DDIOL(LRMSG,"","!!") K LRMSG
 . S LRQUIT=1
 ; Has a supplemental rept been entered, but not yet released? Don't allow modifications until supplemental rept. is released.
 N LRSR,LRSR1,LRSR2
 S LRSR=0,LRSR1=1
 I LRREL(1),'LRAU D 
 . Q:'+$P($G(^LR(LRDFN,LRSS,LRI,1.2,0)),U,4)
 . F  S LRSR=$O(^LR(LRDFN,LRSS,LRI,1.2,LRSR)) Q:LRSR'>0!('LRSR1)  D
 . . S LRSR1=+$P(^LR(LRDFN,LRSS,LRI,1.2,LRSR,0),U,2)
 . . I 'LRSR1 D
 . . . S Y=+$P(^LR(LRDFN,LRSS,LRI,1.2,LRSR,0),U)
 . . . D DD^%DT S LRSR2=Y
 I LRREL(1),LRAU D
 . S RPCOMDT=$$GET1^DIQ(63,LRDFN,13,"I")
 . Q:'RPCOMDT
 . Q:'+$P($G(^LR(LRDFN,84,0)),U,4)
 . F  S LRSR=$O(^LR(LRDFN,84,LRSR)) Q:LRSR'>0!('LRSR1)  D
 . . S LRSR1=+$P(^LR(LRDFN,84,LRSR,0),U,2)
 . . I 'LRSR1 D
 . . . S Y=+$P(^LR(LRDFN,84,LRSR,0),U)
 . . . D DD^%DT S LRSR2=Y
 I 'LRSR1 D
 . S LRQUIT=1
 . W $C(7),!,"Supplementary report "_LRSR2_" has not been released.  "
 . W !,"Cannot modify the report."
 . S Y=0
 Q
 ;
 ;
RELEASE ; Unrelease report
 N LRNTIME,RPCOMDT
 D NOW^%DTC S LRNTIME=%
 K LRFDA
 I 'LRAU D
 . I '$G(LRREL(3)) S LRFDA(LRSF,LRIENS,.15)=LRREL(1)
 . S LRFDA(LRSF,LRIENS,.11)="@"
 . S LRFDA(LRSF,LRIENS,.13)="@"
 . S LRFDA(LRSF,LRIENS,.17)=LRNTIME
 . S LRFDA(LRSF,LRIENS,.171)=DUZ
 I LRAU D
 . S LRFDA(63,LRIENS,14.7)="@"
 . S LRFDA(63,LRIENS,14.8)="@"
 . ;KLL-ONLY IF REPT COMP DATE IS SET,OK TO MARK AS MODIFIED
 . S RPCOMDT=$$GET1^DIQ(63,LRIENS,13,"I")
 . I RPCOMDT D
 . . S LRFDA(63,LRIENS,102)=LRNTIME
 . . S LRFDA(63,LRIENS,102.1)=DUZ
 D FILE^DIE("","LRFDA")
 Q
 ;
 ;
QUEUPD ;Update the final report print queue
 I '$D(^LRO(69.2,LRAA,2,LRAN,0)) D
 . K LRFDA
 . L +^LRO(69.2,LRAA,2):DILOCKTM I '$T D  Q
 . . S MSG(1)="The final reports queue is in use by another person.  "
 . . S MSG(1,"F")="!!"
 . . S MSG(2)="You will need to add this accession to the queue later."
 . . D EN^DDIOL(.MSG) K MSG
 . S LRIENS="+1,"_LRAA_","
 . S LRFDA(69.23,LRIENS,.01)=LRDFN
 . S LRFDA(69.23,LRIENS,1)=LRI
 . S LRFDA(69.23,LRIENS,2)=LRH(0)
 . S LRORIEN(1)=LRAN
 . D UPDATE^DIE("","LRFDA","LRORIEN") K LRORIEN
 . L -^LRO(69.2,LRAA,2)
 Q
 ;
 ;
EDIT ;
 W !
 I 'LRAU S DA=LRI,DA(1)=LRDFN,DIE="^LR("_LRDFN_","""_LRSS_""","
 S:LRAU DIE="^LR(",DA=LRDFN
 D ^DIE
 S:$D(Y) LRQUIT=1
 S:$G(DTOUT) LRQUIT=1
 Q
 ;
 ;
SETDR ; Set the DR string
 I LRAU D
 . K DR
 . S DR="13;13.01///^S X=LRWHO;32.1;99;11;14.1;14.5;14.6;12.1;"
 . S DR=DR_"13.5;13.6;13.8;32;80;"
 . S:LRWM DR=DR_"16:24;26:31;25;31.1;31.4;25.1;25.9"
 . S DR(2,63.2)=".01;I 'LREFPD S Y=4;1;1.5;3;4;5"
 . S DR(3,63.21)=".01",DR(3,63.22)=".01;I 'LREFPD S Y=0;1"
 . S DR(3,63.24)=".01;S:'$P(^LAB(61.5,X,0),U,3) Y=0;.02"
 . S DR(4,63.23)=".01"
 I 'LRAU D
 . S LRV=+$P($G(^LRO(69.2,LRAA,0)),U,10)  ;Ask TC codes?
 . K DR
 . S DR=".08;.07;.011;.012;.013;.014;.015;.016;.1;.02;.021;.99;.97;"
 . S DR=DR_"10;80;.09///^S X=LRWHO;.03"
 . I LRSS="SP" D
 . . S DR(2,63.12)=".01;S LR(8)=$P(^LAB(61,X,0),U,4);S:'LR(8) Y=4;2;4;"
 . . S DR(2,63.12)=DR(2,63.12)_"I 'LREFPD S Y=5;1;1.5;3;5"
 . .S DR(2,63.812)=".01;.06R;.07R"
 . . S DR(3,63.16)=".01;I 'LREFPD S Y=0;1"
 . . S DR(3,63.82)=".01;D R^LRAPD;.02"
 . I LRSS="CY" D
 . . S DR(2,63.902)=".01;.02;.06R;.07R"
 . . S DR(2,63.912)=".01;S LR(8)=$P(^LAB(61,X,0),U,4);S:'LR(8) Y=4;2;4;"
 . . S DR(2,63.912)=DR(2,63.912)_"I 'LREFPD S Y=5;1;1.5;3;5"
 . . S DR(3,63.916)=".01;I 'LREFPD S Y=0;1"
 . . S DR(3,63.982)=".01;D R^LRAPD;.02"
 . I LRSS="EM" D
 . . S DR(2,63.202)=".01;.06R;.07R"
 . . S DR(2,63.212)=".01;S LR(8)=$P(^LAB(61,X,0),U,4);S:'LR(8) Y=4;2;4;"
 . . S DR(2,63.212)=DR(2,63.212)_"I 'LREFPD S Y=5;1;1.5;3;5"
 . . S DR(3,63.216)=".01;I 'LREFPD S Y=0;1"
 . . S DR(3,63.282)=".01;S:'$P(^LAB(61.5,X,0),U,3) Y=0;.02"
 Q
 ;
 ;
CPTCODE ; Enter CPT codes
 K DIR
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Enter CPT CODING"
 D ^DIR
 I Y="^"!(Y<1) S LRQUIT=1 Q
 N LRPRO
 ; SET PROVIDER=CURRENT USER, ALLOW UPDATES
 S LRPRO=DUZ
 D PROVIDR^LRAPUTL
 Q:LRQUIT
 D CPT^LRCAPES(LRAA,LRAD,LRAN,LRPRO)
 Q
