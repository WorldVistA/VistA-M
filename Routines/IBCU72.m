IBCU72 ;ALB/CPM - ADD/EDIT/DELETE PROCEDURE DIAGNOSES ;18-JUN-96
 ;;2.0;INTEGRATED BILLING;**62,210**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DX(IBIFN,IBPROC) ; Add/edit/delete procedure diagnoses.
 ; Input:  IBIFN  --  Pointer to the claim in file #399
 ;        IBPROC  --  Pointer to the claim procedure in file #399.0304
 ;
 I '$G(IBIFN) G DXQ
 I '$G(IBPROC) G DXQ
 ;
 N DIE,DA ; need to preserve these variables for IBCU7.
 ;
 N IBPROCD,IBDX,IBDXSCR,IBLINE,IBI,IBDEF,IBQUIT,IBPROMPT
 S IBPROCD=$G(^DGCR(399,IBIFN,"CP",IBPROC,0))
 I 'IBPROCD G DXQ
 ;
 ; - get diagnoses and display.
 D SET^IBCSC4D(IBIFN,.IBDXSCR,.IBDX),DISP(.IBDX)
 I '$O(IBDX(0)) W "There are no diagnoses associated with this bill." G DXQ
 ;
 ; - build workable array; determine default values
 S IBI=0 F  S IBI=$O(IBDX(IBI)) Q:'IBI  S IBDX(IBI)=IBDXSCR(+IBDX(IBI))_U_$P($$ICD9^IBACSV(+IBDX(IBI)),U)
 S IBDEF="" F I=11:1:14 S X=$P(IBPROCD,U,I) I X D
 . S J=0 F  S J=$O(IBDX(J)) Q:'J  I +IBDX(J)=X S IBDEF=IBDEF_J_":"_$P(IBDX(J),U,2)_"," Q
 I IBDEF]"" S IBDEF=$E(IBDEF,1,$L(IBDEF)-1)
 ;
 ; - display instructions and default values
 W !," *** Please select procedure diagnoses by number to left of diagnosis code ***"
 I IBDEF]"" W !,"Current Values:  " F I=1:1:$L(IBDEF,",") S X=$P(IBDEF,",",I) I X]"" W "Dx ",I,": ",+X," - ",$P(X,":",2),"   "
 ;
 ; - prompt for the four associated dx prompts
 W ! S IBQUIT=0 F IBPROMPT=1:1:4 D ASKEM Q:IBQUIT
 ;
DXQ Q
 ;
 ;
 ;
DISP(X) ; Display of existing dx's for a bill.
 N IBX,IBY,IBZ,IBDATE
 S IBDATE=$$BDATE^IBACSV($G(IBIFN))
 W !!,?5,"-----------------  Existing Diagnoses for Bill  -----------------",!
 S IBX=0 F  S IBX=$O(X(IBX)) Q:'IBX  S IBZ=X(IBX),IBY=$$ICD9^IBACSV(+IBZ,IBDATE) D
 . W !?5,IBX,".",?12,$P(IBY,U),?26,$P(IBY,U,3),?60,$S($P(IBZ,U,2)<1000:"("_$P(IBZ,U,2)_")",1:"")
 W !
 Q
 ;
ASKEM ; Allow entry of the procedure diagnoses.
 N IBP
 S IBP=$P(IBDEF,",",IBPROMPT)
 W !,"Associated Diagnosis (",IBPROMPT,"): ",$S(IBP]"":+IBP_" - "_$P(IBP,":",2)_" // ",1:"")
 R X:DTIME
 I $E(X)="^" S IBQUIT=1 G ASKEMQ
 I $E(X)="@" D:IBP]"" UPD("@",IBPROMPT+9) W:IBP]"" "   deleted." G ASKEMQ
 I $E(X)="?" D HELP1 G ASKEM
 I X="" S:'$$NEXT() IBQUIT=1 G ASKEMQ
 I '$D(IBDX(X)) D HELP1 G ASKEM
 W "   ",$P(IBDX(X),"^",2)
 I +IBP'=X D UPD("/"_+IBDX(X),IBPROMPT+9)
ASKEMQ Q
 ;
UPD(IBVALUE,IBFIELD) ; Update an associated diagnosis.
 S DIE="^DGCR(399,"_IBIFN_",""CP"",",DA=IBPROC,DA(1)=IBIFN
 S DR=IBFIELD_"///"_IBVALUE D ^DIE K DA,DIE,DR
 Q
 ;
HELP1 ; Help for entering associated diagnoses.
 N X
 W !!,"Please enter one of the following billing diagnoses by number at left of code:"
 S X=0 F  S X=$O(IBDX(X)) Q:'X  W:X#4=1 ! W ?((X-1)#4*18),X,".",$J($P(IBDX(X),"^",2),9)
 W !!,"You may also enter '^' to exit, '@' to delete a procedure diagnosis, or"
 W !,"<CR> to accept a current value or skip a prompt.",!
 Q
 ;
NEXT() ; Advance to the next prompt?
 N I,X S X=0
 I IBPROMPT=4 G NEXTQ
 I IBP]"" S X=1 G NEXTQ
 F I=(IBPROMPT+1):1:4 I $P(IBDEF,",",I)]"" S X=1 Q
NEXTQ Q X
