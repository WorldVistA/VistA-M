QAQAHOC5 ;WCIOFO/ERC-Continuation of QAQAHOC3 ;7/22/98
 ;;1.7;QM Integration Module;**5**;07/25/1995
 ;
EDITMAC ;if the macro is not valid, display message explaining that user
 ;should enter the macro again, then either use the same name to
 ;replace the old macro with the current, valid one, or to use a
 ;new name.
 W !!,"Your macro is no longer valid.  Re-enter the macro now, and"
 W !,"when finished enter '[S' to save it at the prompt for the next"
 W !,"field.  Enter the old macro name if you want to replace it with"
 W !,"the new criteria, or enter a completely new name."
 S DIR(0)="E" D ^DIR K DIR
 S Y=0
 Q
STRIP ;if there are qualifiers on QAQFLD,strip them off
 N X
 S QAQFLD1=""
 F X=1:1:$L(QAQFLD) I "'!@#&+-"[$E(QAQFLD) S QAQFLD1=QAQFLD1_$E(QAQFLD),QAQFLD=$E(QAQFLD,2,999)
 Q
STRIP2 ;if there are qualifiers on QAQPF, strip them out before comparing
 ;to QAQPM
 N QAQFIRST,QAQLAST,QAQLNTH,QAQPFQUL,X
 S QAQPFQUL=""
 S (QAQCC,QAQFIRST)=0
 S QAQPFX=QAQPF
 F X=1:1:$L(QAQPFX) S:"'!@#&+-"[$E(QAQPFX) QAQLNTH(X)=X,QAQPFQUL=QAQPFQUL_$E(QAQPF,X) S QAQPFX=$E(QAQPFX,2,999)
 S QAQPM=$TR(QAQPM,"~")
 I $G(QAQPFQUL)]"" D
 . F  S QAQCC=$O(QAQLNTH(QAQCC)) Q:QAQCC'>0  S:$G(QAQFIRST)<1 QAQFIRST=QAQCC S QAQLAST=QAQCC
 . I $G(QAQFIRST)>0 D
 . . S QAQPF1=$E(QAQPF,1,QAQFIRST-1)
 . . S QAQPF2=$E(QAQPF,QAQLAST+1,999)
 . . I $G(QAQPM)'=($G(QAQPF1)_$G(QAQPF2)) S QAQPF1=$G(QAQPM1),QAQPF2=$G(QAQPM2)
 . . S QAQPFALL=$G(QAQPF1)_$G(QAQPFQUL)_$G(QAQPF2)
 . . I $G(QAQPFEND)]"" S QAQPFALL=$G(QAQPFALL)_";"_$G(QAQPFEND)
 I $G(QAQPFQUL)']"" D
 . I $G(QAQPF)'=$G(QAQPM) S QAQPF=$G(QAQPM)
 . S QAQPFALL=$G(QAQPF)_$S($G(QAQPFEND)]"":";"_QAQPFEND,1:"")
 S $P(^QA(740.1,QAQD0,"FLD",QAQEE,0),U,2)=$G(QAQPFALL)
 Q
