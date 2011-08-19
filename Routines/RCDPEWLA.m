RCDPEWLA ;ALB/TMK - ELECTRONIC EOB MESSAGE WORKLIST ;06-FEB-2003
 ;;4.5;Accounts Receivable;**173,208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ADDLINES(RCSCR) ; Add lines to file 344.49, delete any existing lines
 ; RCSCR = ien of entry in file 344.49
 ;
 N Z,Z0,Q,Q0,Q1,DA,DIK,X,Y,DIE,DO,DD,DR,RC0,RCA,RCA0,RCIFN,RCX,RCADJ,RCDEC,DIC,DLAYGO,RCLINE
 K ^TMP($J,"RCA")
 S Z=0 F  S Z=$O(^RCY(344.49,RCSCR,1,Z)) Q:'Z  S DA(1)=RCSCR,DA=Z,DIK="^RCY(344.49,"_DA(1)_",1," D ^DIK
 ;
 S RC0=$G(^RCY(344.4,RCSCR,0)) ; Entries are DINUMED
 I $P(RC0,U,5)'="" S DR=".03////"_$P(RC0,U,5),DIE="^RCY(344.49,",DA=RCSCR D ^DIE
 ;
 S Z=0 F  S Z=$O(^RCY(344.4,+RC0,1,Z)) Q:'Z  S RCA0=$G(^(Z,0)) I RCA0'="" D  ; Sort the lines to put adjustments with the payments, check sort order
 . ; for 0-pays
 . I $P(RCA0,U,2) S RCIFN=+$G(^IBM(361.1,+$P(RCA0,U,2),0)),RCA=$P($G(^DGCR(399,RCIFN,0)),U) ; IA 4051
 . I '$P(RCA0,U,2) S RCIFN="0;"_Z,RCA=$P(RCA0,U,5)
 . I RCA="" S RCA=RCIFN
 . I $D(^TMP($J,"RCA",RCA,+$P(RCA0,U,14))) D
 .. F Q0=1:1:999 S Q=RCA_";"_$E(1000+Q0,2,4) I '$D(^TMP($J,"RCA",Q,+$P(RCA0,U,14))) S RCA=Q Q
 . S ^TMP($J,"RCA",RCA,+$P(RCA0,U,14))=RCIFN_U_Z
 ;
 S Z=0 F  S Z=$O(^RCY(344.4,+RC0,2,Z)) Q:'Z  S RCA0=$G(^(Z,0)) I RCA0'="" D  ; Extract ERA level adjs
 . S RCIFN=$P(RCA0,U),RCA="**ADJ"_Z
 . S ^TMP($J,"RCA",RCA,1)=RCIFN_U_Z
 ;
 I $P(RC0,U,9)=-1 D  ; Check dec adj or additional receipt line needed
 . S Z=+$O(^RCY(344.31,"AERA",RCSCR,0))
 . Q:'Z
 . I $P($G(^RCY(344.31,Z,0)),U,7)-$P(RC0,U,5) D  Q
 .. S ^TMP($J,"RCA","**ADJ0",1)="TOTALS MISMATCH^^"_($P($G(^RCY(344.31,Z,0)),U,7)-$P(RC0,U,5))
 ;
 S Z="" F  S Z=$O(^TMP($J,"RCA",Z)) Q:Z=""  S Z0="" F  S Z0=$O(^TMP($J,"RCA",Z,Z0)) Q:Z0=""  D
 . S Q=$P(Z,";") ; claim #
 . S Q0=$S($E(Q,1,2)'="**":$G(^RCY(344.4,+RC0,1,+$P(^TMP($J,"RCA",Z,Z0),U,2),0)),Q["ADJ"&($P(Q,"ADJ",2)):$G(^RCY(344.4,+RC0,2,+$P(^TMP($J,"RCA",Z,Z0),U,2),0)),1:$G(^TMP($J,"RCA",Z,Z0)))
 . ;
 . S RCDEC=($P(Q0,U,3)<0) ; is this a decrease
 . I Z0=0 D  Q  ; Add a payment line from the ERA
 .. K DO,DD
 .. S DIC(0)="L",DLAYGO=344.491,DA(1)=RCSCR,DIC="^RCY(344.49,"_DA(1)_",1,"
 .. S DIC("DR")=".02////"_Q_";.05////"_$P(Q0,U,3)_";.06////"_$P(Q0,U,3)_";.09////"_$P(^TMP($J,"RCA",Z,Z0),U,2)_";.13////0"
 .. I $G(^TMP($J,"BATCHES")) D
 ... ; Assign a batch # here
 ... S DIC("DR")=DIC("DR")_";.14////"_$$GETBATCH^RCDPEWLB(Q0)
 .. F X=$O(^RCY(344.49,RCSCR,1,"ASEQ"," "),-1)+1:1 I '$D(^RCY(344.49,RCSCR,"B",X)) Q
 .. S RCLINE=X
 .. D FILE^DICN K DIC,DO,DD
 .. S ^TMP($J,"RCA",Z)=+Y
 .. S DIC(0)="L",DLAYGO=344.491,DA(1)=RCSCR,DIC="^RCY(344.49,"_DA(1)_",1,"
 .. S DIC("DR")=".02////"_Q_";.05////"_$P(Q0,U,3)_";.06////"_$P(Q0,U,3)_$S($P(^TMP($J,"RCA",Z,Z0),U):";.07////"_$P(^TMP($J,"RCA",Z,Z0),U),1:"")
 .. S X=RCLINE+.001
 .. D FILE^DICN K DIC,DO,DD,DA
 .. S $P(^TMP($J,"RCA",Z,0),U,3)=+Y S DA(1)=RCSCR,DA=+^TMP($J,"RCA",Z),DIE="^RCY(344.49,"_DA(1)_",1,",DR=".13////"_+$$VER^RCDPEV(RCSCR,$P(^TMP($J,"RCA",Z,Z0),U),+$P(^TMP($J,"RCA",Z,Z0),U,2)) D ^DIE
 . ;
 . I Z0=1,$P($G(^TMP($J,"RCA",Z,0)),U,3) D  Q  ; rev of claim within this ERA
 .. ; Add adj to line previously added for payment
 .. K DO,DD
 .. S DA(2)=RCSCR,DA(1)=+$P($G(^TMP($J,"RCA",Z,0)),U,3),DIC(0)="L",DIC="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",1,",DLAYGO=344.4911,X=+$O(^RCY(344.49,DA(2),1,DA(1),1," "),-1)+1
 .. S DIC("DR")=".02////"_$S(RCDEC:2,1:4)_";.03////"_$P(Q0,U,3)_";.05////"_$S(RCDEC:"0;.08////1;.06////1",1:"3;.08////0;.06////0")_";.07////"_+Q0_";.13////0"
 .. D FILE^DICN K DIC,DO,DD,DA
 .. S Q1=$G(^RCY(344.49,RCSCR,1,+$P($G(^TMP($J,"RCA",Z,0)),U,3),0))
 .. ; Upd net amt
 .. S DA(1)=RCSCR,DA=+$P($G(^TMP($J,"RCA",Z,0)),U,3),DIE="^RCY(344.49,"_DA(1)_",1,",DR=".06////"_$J($P(Q1,U,6)+$P(Q0,U,3),"",2)_";.08////"_$J($P(Q1,U,8)+$P(Q0,U,3),"",2) D ^DIE
 .. ;Upd seq ref,net in 'parent'
 .. I $G(^TMP($J,"RCA",Z)) D
 ... S DA(1)=RCSCR,DA=+$G(^TMP($J,"RCA",Z)),DIE="^RCY(344.49,"_DA(1)_",1,",DR=".09////"_($P($G(^RCY(344.49,RCSCR,1,DA,0)),U,9)_","_$P(^TMP($J,"RCA",Z,Z0),U,2))_";.06////"_$J($P($G(^RCY(344.49,DA(1),1,DA,0)),U,6)+$P(Q0,U,3),"",2)
 ... D ^DIE
 . ;
 . I Z0=1 D  Q  ; ERA level adj, no payment for claim lev adj or mismatch
 .. ; Add a line
 .. K DO,DD
 .. S RCADJ=$S(Z["**ADJ":1,1:0)
 .. S DIC(0)="L",DLAYGO=344.491,DA(1)=RCSCR,DIC="^RCY(344.49,"_DA(1)_",1,"
 .. S DIC("DR")=$S(Q'=0:".02////"_Q_";",1:"")_".03////0.00;.05////0.00;.13////0"
 .. F X=$O(^RCY(344.49,RCSCR,1,"ASEQ"," "),-1)+1:1 I '$D(^RCY(344.49,RCSCR,"B",X)) L +^RCY(344.49,RCSCR,1,X,0):1 Q:$T
 .. D FILE^DICN K DIC,DO,DD,DA
 .. S RCLINE=+$P(Y,U,2),^TMP($J,"RCA",Z)=+Y
 .. ;
 .. S DIC(0)="L",DLAYGO=344.491,DA(1)=RCSCR,DIC="^RCY(344.49,"_DA(1)_",1,"
 .. S DIC("DR")=$S('RCADJ:".02///"_$P(Z,";")_";",1:"")_".03////0.00;.05////0.00;.06////0.00"_$S($P(^TMP($J,"RCA",Z,Z0),U)&'RCADJ:";.07////"_$P(^TMP($J,"RCA",Z,Z0),U),1:"")
 .. S X=RCLINE+.001
 .. D FILE^DICN K DIC,DO,DD,DA
 .. L -^RCY(344.49,RCSCR,1,RCLINE,0)
 .. S RCLINE=+Y
 .. ; Add adj record
 .. S DIC(0)="L",DLAYGO=344.4911,DA(2)=RCSCR,DA(1)=RCLINE,DIC="^RCY(344.49,"_DA(2)_",1,"_DA(1)_",1,"
 .. S DIC("DR")=".02////"_$S(RCDEC:2+RCADJ,1:4+RCADJ)_";.03////"_$P(Q0,U,3)_";.05////"_$S('RCDEC:"3;.06////0;.08////0",1:"0;.06////1;.08////1")_";.07////"_$S(RCADJ:Z_";.04////"_$P(^TMP($J,"RCA",Z,Z0),U),1:+$P(^TMP($J,"RCA",Z,Z0),U,2))
 .. F RCX=$O(^RCY(344.49,RCSCR,1,RCLINE,1," "),-1)+1:1 I '$D(^RCY(344.49,RCSCR,1,RCLINE,1,X,0)) L +^RCY(344.49,RCSCR,1,RCLINE,1,RCX,0):1 Q:$T
 .. S X=RCX
 .. D FILE^DICN K DIC,DO,DD,DA
 .. L -^RCY(344.49,RCSCR,1,RCLINE,1,RCX,0)
 .. S DA(1)=RCSCR,DA=RCLINE,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".06////"_$P(Q0,U,3)_";.08////"_$P(Q0,U,3) D ^DIE
 .. S Q1=$G(^RCY(344.49,RCSCR,1,RCLINE,0))
 .. ; Upd seq ref,adj,payment in 'parent'
 .. I $G(^TMP($J,"RCA",Z)) D
 ... S DA(1)=RCSCR,DA=+^TMP($J,"RCA",Z),DIE="^RCY(344.49,"_DA(1)_",1,"
 ... S DR=".09////"_$S(RCADJ:$S($P(Z,"**ADJ",2):$P(Z,"**",2),1:"TOTALS MISMATCH"),1:$P(^TMP($J,"RCA",Z,Z0),U,2))_";.06////"_$J($P($G(^RCY(344.49,DA(1),1,DA,0)),U,6)+$P(Q0,U,3),"",2)_";.08////"_$P(Q0,U,3)
 ... D ^DIE
 ;
 K ^TMP($J,"RCA")
 Q
 ;
SELSORT(RCQUIT) ; Function returns selection of sort for worklist entries
 ; RCQUIT returned = 1 if passed by ref and user aborts question
 ; RCSCR is assumed to be the ien of the entry in file 344.49
 N DIR,X,Y,DTOUT,DUOUT,RCLSTORD,RCUSPREF,DA,DIE,DR,RCY
 S RCQUIT=0
 S RCUSPREF=+$O(^RCY(344.49,RCSCR,2,"B",DUZ,0))
 I 'RCUSPREF D  ; Add the user pref record
 . S RCUSPREF=+$$ADDUSER^RCDPEWL5(RCSCR,DUZ)
 S RCLSTORD=$P($G(^RCY(344.49,RCSCR,2,RCUSPREF,0)),U,3)
 S DIR(0)="344.492,.03A",DIR("A")="ORDER OF PAYMENTS: ",DIR("B")=$S(RCLSTORD'="":$$EXTERNAL^DILFD(344.492,.03,"",RCLSTORD),1:$$EXTERNAL^DILFD(344.492,.03,"","N")) W ! D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S RCQUIT=1,Y=""
 S RCY=Y
 I 'RCQUIT D
 . S $P(^TMP($J,"RC_SORTPARM"),U)=RCY
 . S DA(1)=RCSCR,DA=RCUSPREF
 . I DA,$P(^TMP($J,"RC_SORTPARM"),U)'=RCLSTORD S DIE="^RCY(344.49,"_DA(1)_",2,",DR=".03////"_$P($G(^TMP($J,"RC_SORTPARM")),U) D ^DIE ; Update user preferences
 Q RCY
 ;
TOOOLD(RCDEP) ; Check if deposit in ien RCDPE (file 344.1) is too old to use
 N RCOLD,Q,DIR,X,Y
 S Q=$$FMADD^XLFDT(DT,-7),RCOLD=0
 I $P($G(^RCY(344.1,RCDEP,0)),U,3)<Q D
 . S DIR("A",1)="THIS DEPOSIT WAS OPENED MORE THAN ONE WEEK AGO ("_$$FMTE^XLFDT($P($G(^RCY(344.1,RCDEP,0)),U,3),2)_")",DIR("A")="ARE YOU SURE YOU WANT TO USE THIS DEPOSIT?: ",DIR("B")="NO",DIR(0)="YA" W ! D ^DIR K DIR
 . I Y'=1 S RCOLD=1
 Q RCOLD
 ;
