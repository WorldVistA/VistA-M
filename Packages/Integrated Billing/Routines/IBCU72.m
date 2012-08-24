IBCU72 ;ALB/CPM - ADD/EDIT/DELETE PROCEDURE DIAGNOSES ;18-JUN-96
 ;;2.0;INTEGRATED BILLING;**62,210,473**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 N J,IBREPACK S IBREPACK=0  ; Added with IB*2.0*473 BI
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
 I IBREPACK D REPACK(IBPROC,IBIFN)  ; Added with IB*2.0*473 BI
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
 ; Changed with IB*2.0*473 BI
 ;I $E(X)="@" D:IBP]"" UPD("@",IBPROMPT+9) W:IBP]"" "   deleted." G ASKEMQ
 I $E(X)="@" D:IBP]"" UPD("@",IBPROMPT+9) W:IBP]"" "   deleted." S IBREPACK=1 G ASKEMQ
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
REPACK(IBPROC,IBIFN)  ; Move associated codes up to avoid gaps
 ;  Added with IB*2.0*473 BI
 N IBADIAG,DA,DIE,DR,IBFIELD,IBX
 N IBWIEN S IBWIEN=IBPROC_","_IBIFN_","
 S IBADIAG(1)=$$GET1^DIQ(399.0304,IBWIEN,10,"I")
 S IBADIAG(2)=$$GET1^DIQ(399.0304,IBWIEN,11,"I")
 S IBADIAG(3)=$$GET1^DIQ(399.0304,IBWIEN,12,"I")
 S IBADIAG(4)=$$GET1^DIQ(399.0304,IBWIEN,13,"I")
 S DIE="^DGCR(399,"_IBIFN_",""CP"",",DA=IBPROC,DA(1)=IBIFN
 S DR="10///@;11///@;12///@;13///@" D ^DIE
 S IBFIELD=9 F IBX=1:1:4 I IBADIAG(IBX)'="" S IBFIELD=IBFIELD+1,DR=IBFIELD_"///"_IBADIAG(IBX) D ^DIE
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
