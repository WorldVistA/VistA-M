RCDPEDS ;ALB/TMK - Display EEOB detail from receipt ;15 Oct 02
 ;;4.5;Accounts Receivable;**173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; IA for call to GETEOB^IBCECSA6 = 4044
 ;
DISP(RCTDA) ; Display EEOB detail/raw data from file 344.4
 ; RCTDA = ien of entry in file 344.4 to display
 ; Returns global ^TMP("$J,"RCDISP")
 ;
 N RCZ,RCZ0,RCCT
 K ^TMP($J,"RCDISP")
 S RCCT=0
 ; 
 D SUM(RCTDA,.RCCT)
 ;
 S RCZ=0 F  S RCZ=$O(^RCY(344.4,RCTDA,1,RCZ)) Q:'RCZ  S RCZ0=$G(^(RCZ,0)) I RCZ0'="" D SEQ(RCTDA,.RCCT,RCZ,RCZ0)
 ;
 Q
 ;
SEQ(RCTDA,RCCT,RC34441,RC0) ;
 ; RCTDA = ien of record in file 344.4
 ; RCCT = line counter, updated if passed by ref
 ; RC34441 = ien of seq # in file 344.41
 ; RC0 = the data on the 0-node of the sequence entry in file 344.41
 ;
 N RCIEN,RCZ,RCDPDATA
 I $P(RC0,U,2) D  ; Get detail from EOB file
 . K ^TMP("PRCA_EOB",$J)
 . S RCIEN=+$P(RC0,U,2)
 . D GETEOB^IBCECSA6(RCIEN,1) ; IA 4044
 . I $O(^IBM(361.1,RCIEN,"ERR",0)) D  ; Add error msgs
 .. D GETERR(RCIEN,+$O(^TMP("PRCA_EOB",$J,RCIEN," "),-1))
 . D SEQHDR(RCTDA,RC34441,.RCCT)
 . S RCZ=0
 . F  S RCZ=$O(^TMP("PRCA_EOB",$J,RCIEN,RCZ)) Q:'RCZ  S RCCT=RCCT+1 S ^TMP($J,"RCDISP",RCCT)=$G(^TMP("PRCA_EOB",$J,RCIEN,RCZ))
 ;
 I '$P(RC0,U,2),$O(^RCY(344.4,RCTDA,1,RC34441,1,0)) D  ; Get detail from raw data in file 344.411
 . K ^TMP($J,"RCOUT"),^TMP($J,"RCRAW")
 . D SEQHDR(RCTDA,RC34441,.RCCT)
 . D DISP^RCDPESR0("^RCY(344.4,"_RCTDA_",1,"_RC34441_",1)","^TMP($J,""RCRAW"")",1,"^TMP($J,""RCOUT"")",75,1)
 . K ^TMP($J,"RCRAW")
 . S RCZ=0
 . F  S RCZ=$O(^TMP($J,"RCOUT",RCZ)) Q:'RCZ  S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)=$G(^TMP($J,"RCOUT",RCZ))
 K ^TMP($J,"RCOUT"),^TMP("PRCA_EOB",$J)
 Q
 ;
SEQHDR(RCTDA,RC34441,RCCT) ; Extract header data from sequence record
 ; RCTDA = ien of record in file 344.4
 ; RC34441 = ien of seq # in file 344.41
 ; RCCT = line counter, updated if passed by ref
 ; Returns line # incremented and ^TMP($J,"RCDISP" array
 ;
 N RCDPDATA,RCINV
 S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)=" "
 D DIQ34441(RCTDA,RC34441,".01:.15")
 S RCCT=RCCT+1
 S RCINV=($G(RCDPDATA(344.41,RC34441,.02,"E"))="")
 S ^TMP($J,"RCDISP",RCCT)=$E("Sequence #: "_$G(RCDPDATA(344.41,RC34441,.01,"E"))_$S(RCINV:" (Not Stored in IB)",1:"")_$J("",32),1,32)
 S ^TMP($J,"RCDISP",RCCT)=^TMP($J,"RCDISP",RCCT)_"Bill Number: "_$S('RCINV:RCDPDATA(344.41,RC34441,.02,"E"),1:$G(RCDPDATA(344.41,RC34441,.05,"E"))_" (Not in AR)")
 I $G(RCDPDATA(344.41,RC34441,.14,"E"))="YES" S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)="  *** REVERSAL ***"
 S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)=$E("Amount "_$S($G(RCDPDATA(344.41,RC34441,.14,"E"))="YES":"Reversed",1:"Paid")_": "_$G(RCDPDATA(344.41,RC34441,.03,"E"))_$J("",32),1,32)_"Ins Co: "_$E($G(RCDPDATA(344.41,RC34441,.04,"E")),1,30)
 I $G(RCDPDATA(344.41,RC34441,.07,"E"))'="" S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)="Error: "_RCDPDATA(344.41,RC34441,.07,"E")_$S($G(RCDPDATA(344.41,RC34441,.08,"E"))'="":" - "_$G(RCDPDATA(344.41,RC34441,.08,"E")),1:"")
 S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)="Worklist Status: "_$G(RCDPDATA(344.41,RC34441,.06,"E"))
 Q
 ;
GETERR(RCIEN,Z) ; Extract error messages from entry RCIEN in file 361.1
 ; Z = the last line # in the ^TMP("PRCA_EOB",$J,RCIEN,n array
 ; Function returns error lines from file #361.1 in the
 ;   ^TMP("PRCA_EOB",$J,RCIEN,n array in subscripts at the end of the
 ;    array
 N Z0,DATA,RCRAW,RCFORM,RCLINE,X
 S Z=Z+1,^TMP("PRCA_EOB",$J,RCIEN,Z)="EEOB FILING ERRORS:"
 S Z0=0 F  S Z0=$O(^IBM(361.1,RCIEN,"ERR",Z0)) Q:'Z0  S X=$G(^(Z0,0)) D
 . I +X S RCLINE=+X_"^RCDPESR9" I $T(@RCLINE)'="" D  Q
 .. S RCRAW(1,0)=X
 .. D DISP^RCDPESR0("RCRAW","RCFORM",1,"RCDATA",80,0)
 .. S X=0 F  S X=$O(RCFORM(X)) Q:'X  S Z=Z+1,^TMP("PRCA_EOB",$J,RCIEN,Z)="  "_RCFORM(X)
 . S Z=Z+1,^TMP("PRCA_EOB",$J,RCIEN,Z)="  "_$G(^IBM(361.1,RCIEN,"ERR",Z0,0))
 Q
 ;
SUM(RCTDA,RCCT) ; Extract pertinent top-level data
 ; RCTDA = ien of record in file 344.4
 ; RCCT = line counter, updated if passed by ref
 ;
 N Z,Z0,CT,CT1,RCDPDATA,RCADJ,RCREV
 D DIQ3444(RCTDA,".02:.11")
 S (Z,CT,RCADJ)=0 F  S Z=$O(^RCY(344.4,RCTDA,2,Z)) Q:'Z  S CT=CT+1,RCADJ=RCADJ+$J($P($G(^(Z,0)),U,3),0,2)
 S (Z,CT1,RCREV)=0 S Z=0 F  S Z0=$O(^RCY(344.4,RCTDA,1,"ATB",1,Z)) Q:'Z  S Z0=$G(^RCY(344.4,RCTDA,1,Z,0)),CT1=CT1+1,RCREV(Z)=$$BILLREF^RCDPESR0(RCTDA,Z)_U_$J($P(Z0,U,3),0,2),RCREV=RCREV+$P(RCREV(Z),U,2)
 S RCCT=RCCT+1,Z="There is data for "_+$G(RCDPDATA(344.4,RCTDA,.11,"E"))_" EEOBs"_$S(CT:", "_CT_" ERA adjustments",1:"")_$S(CT1:", "_CT1_" EEOB reversals",1:"")
 S ^TMP($J,"RCDISP",RCCT)=$J("",(80-$L(Z))\2)_Z
 S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)="TOTAL AMT PAID: "_+$G(RCDPDATA(344.4,RCTDA,.05,"E"))
 I RCADJ D
 . S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)="TOTAL AMT ERA ADJUSTED: "_RCADJ
 . D DISPADJ^RCDPESR8(RCTDA,"RCADJ")
 . S Z=0 F  S Z=$O(RCADJ(Z)) Q:'Z  S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)="  "_RCADJ(Z)
 I RCREV D
 . S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)="TOTAL AMT REVERSED: "_RCREV
 . S Z=0 F  S Z=$O(RCREV(Z)) Q:'Z  S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)=$E("  BILL REFERENCE: "_$P(RCREV(Z),U)_$J("",30),1,30)_"  REVERSAL AMT: "_$P(RCREV,U,2)
 S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)=$E("TRACE #: "_$G(RCDPDATA(344.4,RCTDA,.02,"E"))_$J("",35),1,35)_"RECEIPT #: "_$G(RCDPDATA(344.4,RCTDA,.08,"E"))
 S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)=$E("INS CO ID: "_$G(RCDPDATA(344.4,RCTDA,.03,"E"))_$J("",35),1,35)_"NAME: "_$E($G(RCDPDATA(344.4,RCTDA,.06,"E")),1,29)
 S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)=$E("ERA DATE: "_$G(RCDPDATA(344.4,RCTDA,.04,"E"))_$J("",35),1,35)_"DATE ERA RECEIVED: "_$G(RCDPDATA(344.4,RCTDA,.07,"E"))
 S RCCT=RCCT+1,^TMP($J,"RCDISP",RCCT)="EFT MATCH STATUS: "_$G(RCDPDATA(344.4,RCTDA,.09,"E"))
 Q
 ;
DIQ34441(RCTDA,RC0,DR,ARR) ; DIQ call to retrieve data for DR fields in
 ; file 344.41
 N %I,D0,D1,DA,DIC,DIQ,DIQ2,YY
 I $G(ARR)="" S ARR="RCDPDATA"
 K @ARR@(344.41,RC0)
 S DA=RC0,DA(1)=RCTDA,DIQ(0)="E",DIC="^RCY(344.4,"_DA(1)_",1,",DIQ=ARR D EN^DIQ1
 Q
 ;
DIQ3444(DA,DR,ARR) ; DIQ call to retrieve data for DR fields in file 344.41
 N %I,D0,DIC,DIQ,DIQ2,YY
 I $G(ARR)="" S ARR="RCDPDATA"
 K @ARR@(344.4,DA)
 S DIQ(0)="E",DIC="^RCY(344.4,",DIQ=ARR D EN^DIQ1
 Q
 ;
