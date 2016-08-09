RCDPEAA3 ;ALB/KML - APAR Screen - callable entry points ;Nov 24, 2014@23:32:24
 ;;4.5;Accounts Receivable;**298,304**;Mar 20, 1995;Build 104
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
SPLIT(RCIENS) ; Split EEOB in APAR
 ;  
 ;    Input - RCIENS = ien of entry in file 344.49^ien of 344.491^selectable line item from listman screen
 N DIR,L,X,RCQUIT
 S RCQUIT=0
 D FULL^VALM1
 S L=0 F  S L=$O(^RCY(344.49,$P(RCIENS,U),1,$P(RCIENS,U,2),1,L)) Q:'L  D
 . I "01"[$P($G(^(L,0)),U,2) S DIR(0)="EA",DIR("A",1)="THIS EEOB IS NOT AVAILABLE TO EDIT/SPLIT",DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR G SPLITQ
 I $P($G(^RCY(344.49,$P(RCIENS,U),1,$P(RCIENS,U,2),0)),U,13) D  G:RCQUIT SPLITQ
 . S DIR("A",1)="WARNING!  THIS LINE HAS ALREADY BEEN VERIFIED",DIR("A")="ARE YOU SURE YOU WANT TO CONTINUE?: ",DIR(0)="YA",DIR("B")="NO" W ! D ^DIR K DIR
 . I Y'=1 S RCQUIT=1
 K ^TMP("RCDPE_SPLIT_REBLD",$J)
 S X=+$O(^TMP("RCDPE-EOB_WLDX",$J,""),-1)
 D SPLIT^RCDPEWL3($P(RCIENS,U),X)
 I $G(^TMP("RCDPE_SPLIT_REBLD",$J)) K ^TMP("RCDPE_SPLIT_REBLD",$J) D INIT^RCDPEAA2(RCIENS)
 ;
SPLITQ S VALMBCK="R"
 Q
 ;
REFRESH(RCIENS) ; Refresh the entry in file 344.49 to remove all user adjustments
 ;  
 ;    Input - RCIENS = ien of entry in file 344.49^ien of 344.491^selectable line item from listman screen
 N DIR,X,Y,Z,Z0,DA,DIK
 D FULL^VALM1
 S DIR(0)="YA"
 S DIR("A",1)="THIS ACTION WILL DELETE AND REBUILD THIS EEOB WORKLIST SCRATCH PAD ENTRY",DIR("A",2)="ALL EDITS/SPLITS/DISTRIBUTE ADJUSTMENTS ENTERED FOR THIS ERA WILL BE ERASED"
 S DIR("A",3)="AND ALL ENTRIES MARKED AS MANUALLY VERIFIED WILL BE UNMARKED",DIR("A",4)=" "
 S DIR("A")="ARE YOU SURE YOU WANT TO DO THIS?: "
 W ! D ^DIR K DIR
 I Y'=1 G REFQ
 D ADDLINES^RCDPEWLA($P(RCIENS,U))
 D INIT^RCDPEAA2(RCIENS)
REFQ S VALMBG=1,VALMBCK="R"
 Q
 ;
RESEARCH ; Invoke the research menu off APAR
 ;
 K ^TMP($J,"RC_VALMBG")
 S ^TMP($J,"RC_VALMBG")=$G(VALMBG)
 D FULL^VALM1
 D EN^VALM("RCDPE APAR EEOB RESEARCH")
RQ K ^TMP($J,"RC_VALMBG")
 Q
 ;
VRECPT(RCIENS) ;
 ;  
 ;    Input - RCIENS = ien of entry in file 344.49^ien of 344.491^selectable line item from listman screen
 ;
 D VR^RCDPEWLP($P(RCIENS,U))
 Q
REVIEW(RCIENS) ; Enter review information on worklist and turn review display on/off
 ;  
 ;    Input - RCIENS = ien of entry in file 344.49^ien of 344.491^selectable line item from listman screen
 ;
 ;
 N Z,RC,RCDA,RCZ,DIC,DA,DIE,DR,X,Y,DIR,REVCHG,RCUSPREF,RCLSTREV,RCREV
 D FULL^VALM1
 ;
 S REVCHG=""
 S DIR(0)="YA",RC=+$G(^TMP($J,"RC_REVIEW"))
 S DIR("A",1)="REVIEW DATA DISPLAY IS CURRENTLY TURNED "_$P("OFF^ON",U,RC+1),DIR("A")="DO YOU WANT TO TURN IT "_$P("ON^OFF",U,RC+1)_"?: ",DIR("B")=$S('RC:"YES",1:"NO") W ! D ^DIR K DIR
 I Y=1 S ^TMP($J,"RC_REVIEW")=((RC+1)#2),REVCHG=1
 S RCUSPREF=+$O(^RCY(344.49,$P(RCIENS,U),2,"B",DUZ,0))
 ;
 I 'RCUSPREF D  ; Add the user pref record
 . S RCUSPREF=+$$ADDUSER($P(RCIENS,U),DUZ)
 S RCLSTREV=+$P($G(^RCY(344.49,$P(RCIENS,U),2,RCUSPREF,0)),U,2)
 S DA(1)=$P(RCIENS,U),DA=RCUSPREF
 I DA,RCLSTREV'=$G(^TMP($J,"RC_REVIEW")) D  ; Update user pref
 . S DIE="^RCY(344.49,"_DA(1)_",2,",DR=".02////"_+$G(^TMP($J,"RC_REVIEW")) D ^DIE
 W !
 I '$G(^TMP($J,"RC_REVIEW")) G REVIEWQ
 ;
 D SEL^RCDPEWL(.RCDA)
 S RCZ=+$O(RCDA(0)),RCZ=+$G(RCDA(RCZ)) G:'RCZ REVIEWQ
 ;
 S RCREV=0
 I '$O(^RCY(344.49,$P(RCIENS,U),1,"AC",DUZ,RCZ,0)) D
 . S RCREV=$$NEWREV($P(RCIENS,U),RCZ,DUZ)
 E  D
 . N DIR,X,Y
 . S DIR("A")="(A)DD or (E)DIT A REVIEW COMMENT?: ",DIR("B")="ADD",DIR(0)="SA^A:ADD;E:EDIT" W ! D ^DIR K DIR
 . I $D(DUOUT)!$D(DTOUT) Q
 . ;
 . I Y="E" D  Q  ; Edit a review entry entered by same user
 .. N DA,DR,DIE,X,Y
 .. S DA(1)=$P(RCIENS,U),DA=RCZ,DIC="^RCY(344.49,"_DA(1)_",1,"_DA_",4,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,2)=DUZ" D ^DIC
 .. S RCREV=$S(Y>0:+Y,1:0)
 .. I RCREV S DA(2)=$P(RCIENS,U),DA(1)=RCZ,DA=RCREV,DIE="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",4,",DR=".03;.04////^S X=$$NOW^XLFDT()" D ^DIE
 . ;
 . S RCREV=$$NEWREV($P(RCIENS,U),RCZ,DUZ)
 ;
 I RCREV S DIE("NO^")="",DA(1)=$P(RCIENS,U),DA=RCZ,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".11R;I X=0 S Y=""@10"";.12////^S X=DUZ;S Y=""@20"";@10;.12///@;@20" D ^DIE K DIE
 D INIT^RCDPEAA2(RCIENS)
 S REVCHG=""
 ;
REVIEWQ I $G(REVCHG) D INIT^RCDPEAA2(RCIENS)
 S VALMBCK="R"
 Q
 ;
NEWREV(RCSCR,RCZ,RCDUZ) ; Enter a new review comment
 ; RCSCR = ien of entry in file 344.49
 ; RCZ = ien of the EEOB (seq #)
 ; RCDUZ =DUZ of user entering the comment
 ; Function returns 0 if no new comment, ien of comment if added
 N DA,X,Y,DIC,DIK,DLAYGO,DO,DD,RCREV,RCNOW
 S RCNOW=$$NOW^XLFDT() W !!,"REVIEW DATE/TIME: "_$$FMTE^XLFDT(RCNOW,"2")
 S DA(2)=RCSCR,DA(1)=RCZ,X=RCNOW,DIC("DR")=".02////"_RCDUZ_";.03",DLAYGO=344.492,DIC(0)="L"
 S DIC="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",4,"
 K DO,DD
 D FILE^DICN K DO,DD,DIC,DLAYGO
 S RCREV=+Y
 I RCREV'>0 S RCREV=0 G NEWREVQ
 I '$O(^RCY(344.49,DA(2),1,DA(1),4,RCREV,0)) S DIK="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",4,",DA=RCREV D ^DIK S RCREV=0 ; No comment - delete entry
 ;
NEWREVQ Q RCREV
 ;
ADDUSER(RCSCR,RCDUZ) ; Add user record to user preferences multiple in file 344.49 and initialize all preferences
 ; RCSCR = ien of entry in file 344.49
 ; RCDUZ  = the ien of the user
 N DIC,DA,X,Y,DLAYGO,DO,DD
 S Y=+$O(^RCY(344.49,RCSCR,2,"B",RCDUZ,0))
 I Y G ADDUQ
 S DLAYGO=344.492,DA(1)=RCSCR,DIC(0)="L",X=RCDUZ,DIC="^RCY(344.49,"_DA(1)_",2,",DIC("DR")=".02////0;.03////N"
 D FILE^DICN K DIC,DLAYGO
ADDUQ Q $S(Y>0:Y,1:0)
 ;
PREOB(RCIENS) ; Print/View EOB detail
 N RCDA,RCDAZ,Z,Z0
 D FULL^VALM1
 S RCDA=$P($G(^RCY(344.49,$P(RCIENS,U),1,$P(RCIENS,U,2),0)),U,9)
 F RCDAZ=1:1:$L(RCDA,",") S RCDAZ(RCDAZ)=$P(RCDA,",",RCDAZ)
 S Z=0 F  S Z=$O(RCDAZ(Z)) Q:'Z  D
 . ;
 . S Z0=RCDAZ(Z)
 . I $E(Z0,1,3)="ADJ" D  Q
 .. I $G(^RCY(344.4,RCSCR,2,+$P(Z0,"ADJ",2),0))'="" S RCDAZ(Z)="ADJ^"_+$P(Z0,"ADJ",2)
 . ;
 . S Z0=$G(^RCY(344.4,$P(RCIENS,U),1,+Z0,0))
 . S RCDAZ(Z)=+Z0_U_$S($P(Z0,U,2):$P(Z0,U,2),1:-1) Q
 ;
 D VP^RCDPEWL2($P(RCIENS,U),.RCDAZ)
 ;
 S VALMBCK="R"
 Q
 ;
VERIF(RCIENS) ; Entry point to verification options on APAR worklist
 ; RCDPE APAR VERIFY protocol
 ;    Input - RCIENS = ien of entry in file 344.49^ien of 344.491^selectable line item from listman screen
 N DIR,X,Y,RCQUIT,DTOUT,DUOUT
 D FULL^VALM1
 ;
 W !!!!
 S RCQUIT=0
 F  D  Q:RCQUIT
 . S DIR(0)="SAO^1:MANUAL VERIFICATION;2:REPORT UNVERIFIED DISCREPANCIES;3:QUIT"
 . S DIR("A",1)="VERIFY EEOBs:"
 . S DIR("A",2)="   1 MANUALLY MARK AS VERIFIED"
 . S DIR("A",3)="   2 REPORT OF UNVERIFIED WITH DISCREPANCIES"
 . S DIR("A",4)="   3 QUIT AND RETURN TO WORKLIST"
 . S DIR("A")="Select Action: ",DIR("B")="QUIT" W ! D ^DIR K DIR
 . I Y=3!(Y="")!$D(DUOUT)!$D(DTOUT) S RCQUIT=1 Q
 . ;
 . I Y=1 D MVER($P(RCIENS,U)) W !! Q
 . ;
 . I Y=2 D RPT^RCDPEV0($P(RCIENS,U)) W !! Q
 ;
 S VALMBCK="R"
 Q
 ;
MVER(RCERA) ; Manually mark an EEOB as verified within APAR
 ; subroutine cloned from the process that VERIFIES EEOBs off the standard worklist (MVER^RCDPEV)
 ; but with specific changes to support APAR
 ; this subroutine only needs to VERIFY one EEOB rather than a list of EEOBs
 N A,CT,DA,DIE,DR,DTOUT,DUOUT,Z,Z0,Z1,RCT,RCY,RCY0,RCZ0,RCLINE,RCYNUM,DIR,X,Y,RESULT,SPLIT,Q,Q0,DT1,DT2
 N VERIFIED
 S (VERIFIED,RCT)=0,CT=1,Z0=""
 ; get the EEOB entry ien to determine if already it's already been verified 
 S Z1=$O(^TMP("RCDPE-EOB_WLDX",$J,"")) I Z1 S Z=^TMP("RCDPE-EOB_WLDX",$J,Z1)
 ; grab the data belonging to the EEOB
 I Z]"" S Z0=$G(^RCY(344.49,RCERA,1,+$P(Z,U,2),0))
 ; get VERIFY data
 I Z0'="",$P(Z0,U,13) S VERIFIED=1
 I VERIFIED D  Q
 . S DIR(0)="EA",DIR("A",1)="THIS EEOB IS ALREADY VERIFIED",DIR("A")="PRESS RETURN TO CONTINUE: " W ! D ^DIR K DIR
 S RCY=+$P($G(^TMP("RCDPE-EOB_WLDX",$J,Z1)),U,2),RCLINE=+^(Z1),RCYNUM=Z1
 S RCY0=$G(^RCY(344.49,RCERA,1,RCY,0))
 S RCZ0=$G(^RCY(344.4,RCERA,1,+$P(RCY0,U,9),0))
 I '$P(RCZ0,U,2) D
 . W !!,"THIS LINE DOES NOT REFERENCE A VALID BILL"
 E  D
 . S RESULT=$$VER^RCDPEV(RCERA,+$G(^IBM(361.1,+$P(RCZ0,U,2),0)),+$P(RCY0,U,9),1)
 . F Z=2:1:9 I $E($P(RESULT,U,Z))="*" S Q=$P(RESULT,U,Z),$E(Q,1)="",$P(RESULT,U,Z)=Q
 . S SPLIT=$O(^RCY(344.49,RCERA,1,"B",+RCY0_".9999"),-1)'=(+RCY0_".0001")
 . S Z=$S(SPLIT:"CLAIM #'s: ",1:"  CLAIM #: ")
 . S Z=Z_$P(RCY0,U,2)_$S('SPLIT:"",1:" (ORIGINAL ERA DATA)")
 . I SPLIT D
 .. S Q=+RCY0 F  S Q=$O(^RCY(344.49,RCERA,1,"B",Q)) Q:(Q\1)'=+RCY0  S Q0=+$O(^RCY(344.49,RCERA,1,"B",Q,0)),Q0=$G(^RCY(344.49,RCERA,1,Q0,0)) I $P(Q0,U,2)'="" S Z=Z_" "_$P(Q0,U,2)
 . W !!!,Z
 . W !,?13,"PATIENT NAME"_$J("",18)_"  SUBMITTED AMT    SVC DATE(S)"
 . W !,?13,"------------------------------  ---------------  -----------------"
 . S DT1=$E($S($P(RESULT,U,7):$$FMTE^XLFDT($P(RESULT,U,7),"2D"),1:"NOTFOUND")_$J("",8),1,8)
 . S DT2=$E($S($P(RESULT,U,9):"-"_$$FMTE^XLFDT($P(RESULT,U,9),"2D"),1:"-NOTFOUND")_$J("",9),1,9)
 . W !,"   ERA DATA: ",$E($P(RESULT,U,3)_$J("",30),1,30),"  ",$E($J($P(RESULT,U,5),"",2)_$J("",15),1,15)_"  "_DT1_DT2
 . W !,?15,$P($G(^RCY(344,RCERA,0)),U,6)
 . S DT1=$E($S($P(RESULT,U,6):$$FMTE^XLFDT($P(RESULT,U,6),"2D"),1:"NOTFOUND")_$J("",8),1,8)
 . S DT2=$E($S($P(RESULT,U,8):"-"_$$FMTE^XLFDT($P(RESULT,U,8),"2D"),1:"-NOTFOUND")_$J("",9),1,9)
 . W !,"  BILL DATA: "_$E($P(RESULT,U,2)_$J("",30),1,30)_"  "_$E($J($P(RESULT,U,4),"",2)_$J("",15),1,15)_"  "_DT1_DT2
 . W !,?15,$P($G(^DIC(36,+$P(RCZ0,U,4),0)),U),!
 S DIR(0)="YA",DIR("A")="DO YOU WANT TO MARK THIS LINE VERIFIED? ",DIR("B")="NO" W ! D ^DIR K DIR
 ;
 I Y'=1 Q
 S DA(1)=RCERA,DA=+RCY,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".13////1" D ^DIE
 S A=$$TOPLINE^RCDPEWL1($G(^RCY(344.49,RCERA,1,+RCY,0)),RCYNUM)
 S ^TMP("RCDPE-EOB_WL",$J,RCLINE,0)=A
 Q
 ;
 ;PRCA*4.5*304 - add a claim comment to the ERA detail line from APAR
COMNT ;
 N IEN,SEQ,DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT,ZDA,ZBILL,RCOMMENT,TCOMM
 S RCOMMENT=0
 S IEN=+$P(RCIENS,U,1)
 ; Validate the selection
 I IEN=0 D  G COMQ
 . W !,"Cannot comment, no record in file ELECTRONIC REMITTANCE ADVICE file selected." D WAIT^VALM1
 S SEQ=$P(^RCY(344.49,IEN,1,+$P(RCIENS,U,2),0),U,9) ; Just grab the first sequence number for the comment.
 I $G(SEQ)="" D  G COMQ
 . W !,"Cannot comment, no ERA detail record selected." D WAIT^VALM1
 I $G(^RCY(344.4,IEN,1,SEQ,0))']"" D  G COMQ
 . W !,"Cannot comment, ERA detail record selected not found." D WAIT^VALM1
 ;
 ; Allow user to put comment on this ERA Detail record
 S ZDA=SEQ,ZDA(1)=IEN,ZBILL=$P($$GETBILL^RCDPESR0(.ZDA),"-",2)
 W !,"Enter a comment on ERA #"_IEN_"  ERA Detail Seq #",SEQ,"  Bill #",ZBILL,!
 S DIE="^RCY(344.4,"_IEN_",1,",DA=SEQ,DA(1)=IEN,DR="4Comment" D ^DIE G:$D(DTOUT)!$D(Y) COMQ
 ; Now file user (DUZ) and DATE
 K DR
 ; If DA is not defined then the user deleted the comment with an @,
 ; Delete the user and date too.
 S TCOMM=$$GET1^DIQ(344.41,SEQ_","_IEN_",",4,"E")
 I TCOMM="" S DA=SEQ,DA(1)=IEN,DR="4.01////@;4.02////@;"
 E  S DR="4.01////"_$$DT^XLFDT_";4.02////"_$G(DUZ)_";"
 D ^DIE
 S RCOMMENT=1
 D WAIT^VALM1
 ;
COMQ I RCOMMENT D INIT^RCDPEAA2(RCIENS) ; 
 S VALMBCK="R"
 Q
