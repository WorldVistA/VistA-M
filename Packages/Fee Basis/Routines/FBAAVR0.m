FBAAVR0 ;AISC/GRR,SAB - REJECT ITEMS ;3/26/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
VCHNH ; set DATE FINALIZED for batch type B9 line items
 F J=0:0 S J=$O(^FBAAI("AC",B,J)) Q:J'>0  I '$D(^FBAAI(J,"FBREJ")),$D(^FBAAI(J,0)) S DA=J,DIE="^FBAAI(",DR="19////^S X=DT" D ^DIE
 K DIE,DA
 Q
 ;
DELC ; specify local rejects for batch type B9
 N FBIENS
 ; select patient
 S FBDFN=$$ASKVET^FBAAUTL1("I $D(^FBAAI(""AE"",B,+Y))")
 Q:'FBDFN
 K QQ
 S (QQ,FBAAOUT)=0 W @IOF D HEDC^FBAACCB1 F I=0:0 S I=$O(^FBAAI("AE",B,FBDFN,I)) Q:I'>0!(FBAAOUT)  I $D(^FBAAI(I,0)) S Z(0)=^(0),FBI=I D WRITC
 ;
RL S DIR(0)="Y",DIR("A")="Want all line items rejected for this patient",DIR("B")="YES" D ^DIR K DIR G DELC:$D(DIRUT),LOOP:Y
RL1 S DIR(0)="NO^1:"_QQ,DIR("A")="Reject which line item" D ^DIR K DIR G DELC:X=""!$D(DIRUT) S HX=X
 I '$D(QQ(HX)) W !,*7,"You already rejected that one!!" G RL1
RJT S DIR(0)="Y",DIR("A")="Are you sure you want to reject item number: "_HX,DIR("B")="NO" D ^DIR K DIR G RL1:$D(DIRUT)!'Y
RDR1 S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) RDR1 S FBRR=X
 S FBIENS=QQ(HX)_"," D REJLN
RDMORE S DIR(0)="Y",DIR("A")="Item rejected.  Want to reject another",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G RL1:Y
 Q
 ;
WRITC S QQ=QQ+1,QQ(QQ)=I D CMORE^FBAACCB1
 Q
 ;
LOOP S DIR(0)="F^2:40",DIR("A")="Reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) LOOP S FBRR=X
 F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S FBIENS=QQ(HX)_"," D REJLN
 W !,"...DONE!"
 G DELC
 ;
REJLN ; flag line item as rejected
 ; input
 ;   FBN    - batch IEN
 ;   FBTYPE - batch type
 ;   FZ     - zero node of batch (file 161.7)
 ;   FBIENS - iens of line item
 ;   FBRR   - reject reason
 ;   FBAARA - accumulated dollar amount to be posted to 1358 by batch
 ;   QQ(    - (optional) array of line items
 ;   HX     - (optional) line number selected from QQ( array
 ; output
 ;   FZ      - may be updated
 ;   FBAARA  - may be updated
 ;   QQ(HX)  - may be deleted
 ;   FBRFLAG - will be set =1 if 1358 needs to be posted by batch
 ;
 N FBX
 ; flag line as rejected
 S FBX=$$SETREJ^FBAAVR4(FBN,FBTYPE,FBIENS,"",FBRR)
 ;
 ; if problem
 I 'FBX D
 . W !,"Error rejecting line with IENS "_FBIENS
 . W !,"  "_$P(FBX,"^",2)
 ;
 ; if success
 I FBX D
 . N FBPBYINV
 . I $G(HX)'="" K QQ(HX) ; remove from list
 . ; determine if 1358 posted by invoice or batch
 . S FBPBYINV=0
 . I FBTYPE="B9",$$GET1^DIQ(162.5,FBIENS,4,"I")'["FB583" S FBPBYINV=1
 . ;
 . ; if by batch then accumulate amount for later posting
 . I 'FBPBYINV S FBAARA=FBAARA+$P(FBX,"^",3),FBRFLAG=1
 . ;
 . ; if by B9 invoice then post it now
 . I FBPBYINV D
 . . N FBX1
 . . S FBX1=$$POSTINV^FB1358(FBN,+FBIENS,"R")
 . . I 'FBX1 D
 . . . W !,"Error posting invoice "_+FBIENS_" to 1358"
 . . . W !,"  "_$P(FBX1,"^",2)
 ;
 ; update variable FZ with current batch counts and totals
 S FZ=^FBAA(161.7,FBN,0)
 ;
 Q
