RCDPEWL1 ;ALB/TMK - ELECTRONIC EOB WORKLIST SCREEN ;26-NOV-02
 ;;4.5;Accounts Receivable;**173,208,222**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; IA for read access to ^IBM(361.1 = 4051
 ; IA for call to ^DGENA = 3812
 Q
 ;
BLD(RCSORT) ; Build the detail display record for the WL scratch pad record
 ; Assume RCSCR = ien from file 344.49
 ; RCSORT = "" or 'N' for no sort  'F' for 0-pays first, 'L' for last
 ;
 N A,A0,B,B0,Q,Q0,Q1,QQ,V1,X,Y,Z,Z0,Z3,ZZ,ZZ1,RCT,RCZ,RCZ0,RCZZ0,RCSA,RCAZ,RCAZ0,RCSCT,RCS1,RCLI1,RCY34441,RCZERO,RCTS,RCTL
 S RCSORT=$P($G(RCSORT),U),RCSORT=$S(RCSORT="":"N",1:RCSORT),RCTS=0
 K ^TMP("RCDPE-EOB_WL",$J),^TMP("RCDPE-EOB_WLDX",$J),^TMP($J,"RCS"),^TMP("RC_BILL",$J)
 ;
 S VALMCNT=0
 S Z=0 F  S Z=$O(^RCY(344.49,RCSCR,1,"B",Z)) Q:'Z  I Z#1=0 S ZZ=+$O(^RCY(344.49,RCSCR,1,"B",Z,0)) I ZZ D
 . S RCZ=ZZ,RCZ0=$G(^RCY(344.49,RCSCR,1,ZZ,0)),RCS1=$P(RCZ0,U,6)
 . Q:$S('$G(^TMP("RCBATCH_SELECTED",$J)):0,1:$P(RCZ0,U,14)'=+^TMP("RCBATCH_SELECTED",$J))  ; Must be entire ERA or match the selected batch to continue
 . S RCZERO=$S($P(RCZ0,U,2)["**ADJ":"-1",RCSORT="N":1,RCSORT="F":+RCS1'=0,1:+RCS1=0)
 . ;
 . ; This is a top-level entry - find the sublines
 . S Z0=Z F  S Z0=$O(^RCY(344.49,RCSCR,1,"B",Z0)) Q:((Z0\1)'=(Z\1))  S Z=Z0,ZZ1=+$O(^RCY(344.49,RCSCR,1,"B",Z0,0)) I ZZ1 D
 .. S ^TMP($J,"RCS",RCZERO,ZZ,ZZ1)=""
 . S ^TMP($J,"RCS",RCZERO,ZZ)=""
 ;
 S RCZERO="",RCTS=0 F  S RCZERO=$O(^TMP($J,"RCS",RCZERO)) Q:RCZERO=""  S ZZ=0 F  S ZZ=$O(^TMP($J,"RCS",RCZERO,ZZ)) Q:'ZZ  D
 . N A
 . S RCZ0=$G(^RCY(344.49,RCSCR,1,ZZ,0)),RCS1=$P(RCZ0,U,6),RCTS=RCTS+1,RCY34441=$G(^RCY(344.4,RCSCR,1,+$P(RCZ0,U,9),0))
 . S A=$$TOPLINE(RCZ0,RCTS)
 . D SET(A,RCTS,RCTS,ZZ)
 . I $P(RCY34441,U,11) D
 .. D SET("EEOB TRANSFERRED TO "_$E($P($G(^DIC(4,+$P(RCY34441,U,11),0)),U),1,20)_" "_$$FMTE^XLFDT($P(RCY34441,U,12),"2D")_" STATUS: "_$$EXTERNAL^DILFD(344.41,.1,"",+$P(RCY34441,U,10)),RCTS,RCTS,ZZ)
 . ;
 . S RCT=RCTS
 . S ZZ1=0 F  S ZZ1=$O(^TMP($J,"RCS",RCZERO,ZZ,ZZ1)) Q:'ZZ1  D
 .. S RCT=RCT+.001
 .. S RCTL=$L(RCT)
 .. S RCZZ0=$G(^RCY(344.49,RCSCR,1,ZZ1,0))
 .. S V1=$S($P(RCZ0,U,2)'["**ADJ":"",$P($P(RCZ0,U,2),"ADJ",2):"***ADJUSTMENT AT ERA LEVEL",1:"*** ADJUSTMENT LINE FOR TOTALS MISMATCH")
 .. S RCLI1=$S(V1="":" Claim #: "_$P(RCZZ0,U,2)_" Patient/Last 4: "_$S($P(RCZZ0,U,7):$$PNM4("","",$P(RCZZ0,U,7)),'$P($G(^RCY(344.49,RCSCR,1,ZZ1,2)),U,3):$$PNM4(+$G(^RCY(344.49,RCSCR,0)),RCZ),1:"??"),1:V1)
 .. D SET($J("",4)_$P("   ^(V)",U,$P(RCZZ0,U,13)+1)_RCT_RCLI1,RCTS,RCT,ZZ1)
 .. I '$P(RCZZ0,U,7),$P(RCZ0,U,2)'["**ADJ" D SET($J("",4+RCTL)_"***CLAIM NOT FOUND IN YOUR AR ***",RCTS,RCT,ZZ1)
 .. I $P(RCZZ0,U,7) D
 ... N A,RCX,Q
 ... S A("OA")=$$ORI^PRCAFN(+$P(RCZZ0,U,7)),A("SDT")=$P($G(^DGCR(399,+$P(RCZZ0,U,7),"U")),U),A("DFN")=+$P($G(^(0)),U,2),A("ENRPR")=""
 ... ; Find Rx copay status
 ... S A("RXCP")=$S('A("SDT"):"",1:$$RXST^IBARXEU(A("DFN"),A("SDT"))),A("RXCP")=$S($P(A("RXCP"),U)'="":$P(A("RXCP"),U,2),1:"UNKNOWN") ;IA #10147
 ... ; Find M/T status
 ... S RCX=$$LST^DGMTU(A("DFN"),A("SDT")),A("M/T")=$P(RCX,U,4)
 ... S A("M/T")=$S('RCX:"??",A("M/T")="P":"PEN",A("M/T")="C":"YES",A("M/T")="G":"GMT",A("M/T")="R":"REQ",1:"NO")
 ... ;
 ... S QQ="   Billed Amt: "_$J(A("OA"),"",2)_"   Amt To Post: "_$J(+$P(RCZZ0,U,3),"",2)
 ... D SET($J("",4+RCTL)_"Claim Bal: "_$J(+$P($$BILL^RCJIBFN2(+$P(RCZZ0,U,7)),U,3),"",2)_QQ,RCTS,RCT,ZZ1)
 ... S ^TMP("RC_BILL",$J,$P(RCZZ0,U,7),RCT)=QQ
 ... S Z3=$J("",4+RCTL)_"Svc Dt: "_$S(A("SDT")'="":$$FMTE^XLFDT(A("SDT"),2),1:"UNKNOWN")
 ... S Z3=Z3_"  COB: "_$S($D(^DGCR(399,+$P(RCZZ0,U,7),"I"_($$COBN(+$P(RCZZ0,U,7))+1))):"YES",1:"NO ")
 ... D SET(Z3_"  Rx Copay: "_$E(A("RXCP"),1,17)_"  Means Tst: "_A("M/T"),RCTS,RCT,ZZ1)
 .. ;
 .. D SET($J("",4+RCTL)_"Payment Amt: "_$J(+$P(RCZZ0,U,5),"",2)_"   Total Adjustments: "_$J(+$P(RCZZ0,U,8),"",2)_"  Net: "_$J($P(RCZZ0,U,5)+$P(RCZZ0,U,8),"",2),RCTS,RCT,ZZ1)
 .. I $P(RCZZ0,U,10)'="" D SET($J("",9)_"Receipt Comment: "_$P(RCZZ0,U,10),RCTS,RCT,ZZ1)
 .. I $O(^RCY(344.49,RCSCR,1,ZZ1,1,0)) D
 ... S Z3=""
 ... D SET($J("",4+RCTL)_"ADJUSTMENTS:",RCTS,RCT,ZZ1)
 ... S RCAZ=0 F  S RCAZ=$O(^RCY(344.49,RCSCR,1,ZZ1,1,RCAZ)) Q:'RCAZ  S RCAZ0=$G(^(RCAZ,0)) D
 .... S Z3=$J("",6+RCTL)_+RCAZ0_".  ",Q=$L(Z3)
 .... ;
 .... I $P(RCAZ0,U,2)=0 S Z3=Z3_"Distributed adj dec for retraction "_$P(RCAZ0,U,4)_": "_$P(RCAZ0,U,3)
 .... I $P(RCAZ0,U,2)=1 S Z3=Z3_"Adjustment distribution to balance receipt: "_$P(RCAZ0,U,3)
 .... ;
 .... I $P(RCAZ0,U,2)=2!($P(RCAZ0,U,2)=4) D
 ..... S Z3=Z3_"ERA payment adjusted from "_$J($P(RCZZ0,U,5)-$P(RCZZ0,U,6),"",2)_" to "_$J(+$P(RCZZ0,U,5),"",2)_"  NET: "_$J($P(RCZZ0,U,5)+$P(RCAZ0,U,3),"",2)
 .... I $P(RCAZ0,U,2)=5 S Z3=Z3_"Non-specific payment (ref# "_$P(RCAZ0,U,4)_"): "_$P(RCAZ0,U,3)
 .... I $P(RCAZ0,U,2)=3 S Z3=Z3_"Non-specific retraction (ref# "_$P(RCAZ0,U,4)_"): "_$P(RCAZ0,U,3)
 .... D SET(Z3,RCTS,RCT,ZZ1)
 .... I $P(RCAZ0,U,9)'="" D SET($J("",Q)_$P(RCAZ0,U,9),RCTS,RCT,ZZ1)
 .. ;
 .. I $P($G(^TMP($J,"RC_SORTPARM")),U,2) D
 ... S A=$J("",10)_"REVIEW STATUS: ("_$S($P(RCZ0,U,11)="I":"REVIEW IN PROCESS",$P(RCZ0,U,11)=1:"REVIEWED",1:"NOT REVIEWED")
 ... I $P(RCZ0,U,12) S A=A_"   SET BY: "_$E($P($G(^VA(200,$P(RCZ0,U,12),0)),U),1,20)
 ... D SET(A_")",+RCTS,RCT,ZZ1)
 ... S A=0 F  S A=$O(^RCY(344.49,RCSCR,1,ZZ,4,A)) Q:'A  S A0=$G(^(A,0)) D
 .... D SET($J("",12)_$$FMTE^XLFDT($P(A0,U),2)_"  "_$P($G(^VA(200,+$P(A0,U,2),0)),U)_$S($P(A0,U,4):"  LAST EDIT: "_$$FMTE^XLFDT($P(A0,U,4),2),1:""),RCTS,RCT,ZZ1)
 .... S B=0 F  S B=$O(^RCY(344.49,RCSCR,1,ZZ,4,A,1,B)) Q:'B  S B0=$G(^(B,0)) D
 ..... I $L(B0)>64 D SET($J("",15)_$E(B0,1,64),RCTS,RCT,ZZ1) S B0="  "_$E(B0,65,$L(B0)) ; Split line if > 64 characters in comment line
 ..... D SET($J("",15)_B0,RCTS,RCT,ZZ1)
 .. S A="",$P(A,".",79)="" D SET(A,RCTS,RCT,ZZ1)
 ;
 I VALMCNT=0,$G(^TMP("RCBATCH_SELECTED",$J)) D SET("THERE ARE NO EEOBs ASSIGNED TO THIS BATCH")
 K ^TMP($J,"RCS")
 Q
 ;
TOPLINE(RCZ0,RCTS) ; Function returns the top line of the EEOB display
 ; RCZ0 = the 0-node of the whole number entry line for the EEOB
 ; RCTS = the selectable line #
 N A
 S A=" "_$S($P(RCZ0,U,13):"(V)",1:"   ")_"EEOB Seq #"_$S($P(RCZ0,U,9)[",":"'s",1:"")_" On ERA: "_$S($P(RCZ0,U,9)'="":$P(RCZ0,U,9),1:"None")_"   Net Payment Amt: "_$J(+$P(RCZ0,U,6),"",2)
 I $P($G(^TMP($J,"RC_SORTPARM")),U,2) S A=A_"  Reviewed?: "_$S($P(RCZ0,U,11)="":"NO",1:$$EXTERNAL^DILFD(344.491,.11,,$P(RCZ0,U,11)))
 S A=$E(RCTS_$J("",4),1,4)_A
 Q A
 ;
INIT ;
 S VALMBG=$G(^TMP($J,"RC_VALMBG"))
 Q
 ;
HDR ;
 D HDR^RCDPEWL
 Q
 ;
FNL ; -- Clean up list
 K RCFASTXT
 Q
 ;
SET(X,RCSEQ,RCSEQ1,RCZ9) ; -- set arrays
 ; X = the data to set into the global
 ; RCSEQ = the selectable line #
 ; RCSEQ1 = the sub line #
 ; RCZ9 = reference to the line(s) in file 344.41 or to the subline in
 ;        file 344.49 for RCSEQ having a decimal
 S VALMCNT=VALMCNT+1,^TMP("RCDPE-EOB_WL",$J,VALMCNT,0)=X
 I $G(RCSEQ) S ^TMP("RCDPE-EOB_WL",$J,"IDX",VALMCNT,RCSEQ)=""
 I $G(RCSEQ1),'$D(^TMP("RCDPE-EOB_WLDX",$J,RCSEQ1)) S ^TMP("RCDPE-EOB_WLDX",$J,RCSEQ1)=VALMCNT_U_$G(RCZ9)
 Q
 ;
PNM4(RCIFN,RCDA,RC) ; Returns either the patient name or patient name/last 4
 ; RCIFN = ien of file 344.4
 ; RCDA = ien of file 344.41
 ; RC = the ien of file 430
 N Z,Z0,Q
 S Z=""
 I $G(RCIFN)'="" D
 . S Z0=$G(^RCY(344.4,RCIFN,1,RCDA,0)),Z=""
 . I $P(Z0,U,2) S Q=+$P($G(^DGCR(399,+$G(^IBM(361.1,+$P(Z0,U,2),0)),0)),U,2),Z=$P($G(^DPT(Q,0)),U)_"/"_$E($P($G(^(0)),U,9),6,9) ; IA 4051
 . I $TR(Z,"/")="" S Z=$P(Z0,U,15)
 I $G(RC)'="" D
 . S Q=+$P($G(^PRCA(430,RC,0)),U,7)
 . I Q S Z=$P($G(^DPT(Q,0)),U)_"/"_$E($P($G(^(0)),U,9),6,9)
 Q Z
 ;
COBN(RC,A) ; Return seq # of selected payer
 ; A = 'PST' or null to get current bill payer seq #
 I $G(A)="" S A=$P($G(^DGCR(399,RC,0)),U,21) S:A="" A="P" S:"PST"'[A A="P"
 I 'A S A=$F("PST",A)-1 S:A<1 A=1
 Q A
 ;
COPAY(RCIFN)       ; Returns 1 if any not cancelled 1st party bills exist for
 ; a 3rd party bill or any bills related to this 3rd party bill
 ; RCIFN = the 3rd party bill #
 N FIRST,RCTP0,RCTP1,RCTP2
 K ^TMP("IBRBF",$J),^TMP($J,"IBRBF")
 D RELBILL^IBRFN(RCIFN) ; DBIA 3124
 S RCTP0=0 F  S RCTP0=$O(^TMP("IBRBF",$J,RCIFN,RCTP0)) Q:RCTP0=""  S RCTP1=$G(^(RCTP0)) D
 . I $P(RCTP1,U,3) K ^TMP("IBRBF",$J,RCIFN,RCTP0) Q  ; IB cancelled
 . S RCTP2=$O(^PRCA(430,"B",+$P(RCTP1,U,4),0)) I $P($G(^PRCA(430,+RCTP2,0)),U,8)=39 K ^TMP("IBRBF",$J,RCIFN,RCTP0) ; AR cancelled
 S FIRST=$S($O(^TMP("IBRBF",$J,RCIFN,0)):1,1:0)
 K ^TMP("IBRBF",$J),^TMP($J,"IBRBF")
 Q FIRST
 ;
