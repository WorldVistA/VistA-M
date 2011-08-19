RCDPEV ;ALB/TMK - EDI LOCKBOX WORKLIST VERIFY PAYMENTS ;28-JAN-04
 ;;4.5;Accounts Receivable;**208,138**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
AUTOVER(RCSCR) ; Entrypoint to auto-verify an ERA worklist
 ; RCSCR = ien of the ERA worklist entry in file 344.49
 N Z,Z0,Z00,RC399,RC430,RC3444,RC36112,X,X1,X2,X12,DA,DR,DIE
 S Z=0 F  S Z=$O(^RCY(344.49,Z)) Q:'Z  S Z0=0 F  S Z0=$O(^RCY(344.49,Z,1,Z0)) Q:'Z0  I $P($G(^(Z0,0)),U,7) S Z00=$G(^(0)) D
 . I $$VER(RCSCR,+$P(Z00,U,7),+$P(Z00,U,9)) S DA(1)=RCSCR,DA=Z0,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".13////1" D ^DIE
 ;
 Q
 ;
VER(RCSCR,RCBILL,RCREF,F1) ; Run verif for WL entry RCSCR in file 344.49
 ;  RCBILL = ien of claim in file 430
 ;  RCREF = the entry referenced in subfile file 344.41
 ;  F1 = flag if set = 1 will return all data, regardless of if it
 ;        matches or not.  If flag is set to 1 and data doesn't match,
 ;        an asterisk (*) will preceed the actual data value in the
 ;        corresponding piece
 ; Function returns the following data:
 ;   '^' piece 1: 1 if verfied OK   0 if not
 ;   '^' piece 2: patient name from VistA if mismatch
 ;   '^' piece 3: patient name from EEOB if mismatch
 ;   '^' piece 4: amt billed from VistA if mismatch
 ;   '^' piece 5: amt billed from EEOB if mismatch
 ;   '^' piece 6: date of service 'from' from VistA if mismatch
 ;   '^' piece 7: date of service 'from' from EEOB if mismatch
 ;   '^' piece 8: date of service 'to' from VistA if mismatch
 ;   '^' piece 9: date of service 'to' from EEOB if mismatch
 ;   '^' piece 10: patient SSN from VistA
 ;
 N RESULT,SETF1,RC430,RC399,RC3444,RC36112,X,X1,X2,X12,NM,NM1,DTOK,SSN,RC43013
 S RESULT=1,SETF1=$S($G(F1):"*",1:"")
 S RC430=$G(^PRCA(430,RCBILL,0)),RC43013=$G(^(13))
 S RC399=$G(^DGCR(399,RCBILL,0))
 S RC3444=$G(^RCY(344.4,RCSCR,1,RCREF,0))
 S RC36112=$G(^IBM(361.1,+$P(RC3444,U,2),2))
 ;
 S NM=$P($G(^DPT(+$P(RC399,U,2),0)),U),X=$E($P(NM,","),1,5) ; Name from VistA
 S SSN=$P($G(^DPT(+$P(RC399,U,2),0)),U,9)
 S NM1=$P(RC3444,U,15),X1=$E($P(NM1,","),1,5) ; from EEOB
 I $G(F1),X1=X S $P(RESULT,U,2)=NM,$P(RESULT,U,3)=NM1
 I X1'=X S $P(RESULT,U)=0,$P(RESULT,U,2)=SETF1_NM,$P(RESULT,U,3)=SETF1_NM1
 ;
 S X=$P(RC430,U,3)+$P(RC43013,U)+$P(RC43013,U,2) ; Amount billed from VistA (including MRA totals)
 S X1=$P(RC36112,U,4) ; from EEOB
 I $G(F1),+X=+X1 S $P(RESULT,U,4)=X,$P(RESULT,U,5)=X1
 I +X'=+X1 S $P(RESULT,U)=0,$P(RESULT,U,4)=SETF1_X,$P(RESULT,U,5)=SETF1_X1
 ;
 S X=$P($G(^DGCR(399,+RCBILL,"U")),U) ; Date of service from VistA
 S X2=$P($G(^DGCR(399,+RCBILL,"U")),U,2)
 S X1=$P($G(^IBM(361.1,+$P(RC3444,U,2),1)),U,10) ; from EEOB
 S X12=$P($G(^IBM(361.1,+$P(RC3444,U,2),1)),U,11)
 ; if no date of service on EEOB, skip the check
 ; Date of svc on EEOB must fall into date range for svc dates in VistA
 S DTOK=0
 I X1 D
 . I X1=X S DTOK=1
 . I 'DTOK,X1>X S:X1'>X2 DTOK=1
 . I 'DTOK,X1<X S:X12'<X DTOK=1
 . I 'DTOK S $P(RESULT,U)=0,$P(RESULT,U,6)=SETF1_X,$P(RESULT,U,7)=SETF1_X1,$P(RESULT,U,8)=SETF1_X2,$P(RESULT,U,9)=SETF1_X12 Q
 I DTOK,$G(F1) S $P(RESULT,U,6)=X,$P(RESULT,U,7)=X1,$P(RESULT,U,8)=X2,$P(RESULT,U,9)=X12
 S $P(RESULT,U,10)=SSN
 ;
VERQ Q RESULT
 ;
MVER(RCERA) ; Manually mark an EEOB as verified
 N A,CT,DA,DIE,DR,DTOUT,DUOUT,Z,Z0,Z1,RCT,RCY,RCY0,RCZ0,RCLINE,RCYNUM,DIR,X,Y,RESULT,SPLIT,Q,Q0,DT1,DT2
 S RCT=0,CT=1
 F Z1=1:1 S Z=$G(^TMP("RCDPE-EOB_WLDX",$J,Z1)) Q:Z=""  Q:CT'<100  S Z0=$G(^RCY(344.49,RCERA,1,+$P(Z,U,2),0)) I Z0'="",'$P(Z0,U,13) S RCT=RCT+1 D  Q:CT'<100
 . S CT=CT+1 I CT<100 D  Q
 .. S:RCT=1 RCT(1)=Z1
 .. S DIR("?",CT)="  "_$G(^TMP("RCDPE-EOB_WL",$J,+Z,0)),CT=CT+1,DIR("?",CT)=$J("",10)_$P(Z0,U,2)
 .. S Q=+Z0
 .. I $O(^RCY(344.49,RCERA,1,"B",Q_".9999"),-1)'=(Q_".001")
 .. I $O(^RCY(344.49,RCERA,1,"B",Q_".9999"),-1)'=(Q_".001") S DIR("?",CT)=DIR("?",CT)_" (LINE HAS BEEN SPLIT)"
 . K DIR("?")
 ;
 I 'RCT D  Q
 . S DIR(0)="EA",DIR("A",1)="ALL EEOBS HAVE ALREADY BEEN VERIFIED IN THIS "_$S($G(^TMP("RCBATCH_SELECTED",$J)):"BATCH",1:"ERA"),DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR
 ;
 I RCT<100 S DIR("?",1)="THE FOLLOWING EEOB LINE(S) "_$S($G(^TMP("RCBATCH_SELECTED",$J)):"IN THIS BATCH ",1:"")_"ARE NOT VERIFIED"
 I RCT'<100 S DIR("?",1)="THERE ARE TOO MANY EEOB ENTRIES NOT VERIFIED TO LIST",DIR("?",2)="PRINT THE UNVERIFIED DISCREPANCY REPORT TO GET A LIST OF POSSIBLE CHOICES"
 S DIR("?")=" "
 S DIR(0)="NA^1:"_($O(^TMP("RCDPE-EOB_WLDX",$J,""),-1)\1),DIR("A")="SELECT AN EEOB LINE TO MARK AS VERIFIED: "
 I RCT=1 S DIR("B")=RCT(1)
 W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT)!(Y="") Q
 I '$D(^TMP("RCDPE-EOB_WLDX",$J,Y)) W !,"THIS LINE DOES NOT EXIST FOR THIS ERA" W ! Q
 S RCY=+$P($G(^TMP("RCDPE-EOB_WLDX",$J,Y)),U,2),RCLINE=+^(Y),RCYNUM=+Y
 S RCY0=$G(^RCY(344.49,RCERA,1,RCY,0))
 I $P(RCY0,U,13) D  Q
 . S DIR(0)="EA",DIR("A",1)="THIS LINE IS ALREADY VERIFIED",DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR
 S RCZ0=$G(^RCY(344.4,RCERA,1,+$P(RCY0,U,9),0))
 I '$P(RCZ0,U,2) D
 . W !!,"THIS LINE DOES NOT REFERENCE A VALID BILL"
 E  D
 . S RESULT=$$VER(RCERA,+$G(^IBM(361.1,+$P(RCZ0,U,2),0)),+$P(RCY0,U,9),1)
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
 S DIR(0)="YA",DIR("A")="DO YOU WANT TO MARK THIS LINE VERIFIED?: ",DIR("B")="NO" W ! D ^DIR K DIR
 I Y'=1 Q
 S DA(1)=RCERA,DA=+RCY,DIE="^RCY(344.49,"_DA(1)_",1,",DR=".13////1" D ^DIE
 S A=$$TOPLINE^RCDPEWL1($G(^RCY(344.49,RCERA,1,+RCY,0)),RCYNUM)
 S ^TMP("RCDPE-EOB_WL",$J,RCLINE,0)=A
 Q
 ;
