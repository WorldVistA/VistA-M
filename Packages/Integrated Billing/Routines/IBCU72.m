IBCU72 ;ALB/CPM - ADD/EDIT/DELETE PROCEDURE DIAGNOSES ;18-JUN-96
 ;;2.0;INTEGRATED BILLING;**62,210,473,461,592,650**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
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
 . W !?2,IBX,".",?6,$P(IBY,U),?18,$E($P(IBY,U,3),1,54),?74,$S($P(IBZ,U,2)<1000:"("_$P(IBZ,U,2)_")",1:"")
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
 ;
ORAL ; JWS;IB*2.0*592;dental produce line level dental fields
 N ODA,I1,QUIT,IBUNIT,X1,DEN1
 S IBUNIT=1
 ;IA# 3820
 S X1=0 F  S X1=$O(^DGCR(399,DA(1),"RC",X1)) Q:X1'=+X1  I $P($G(^(X1,0)),"^",11)=DA S IBUNIT=$P($G(^(0)),"^",3)
 S IBPOPOUT=0
 F I=1:1:5 D  Q:$G(IBPOPOUT)  I X="" Q
 . S DR="90.0"_I_"Oral Cavity Designation ("_I_"): "
 . ;IA# 10018
 . D ^DIE
 . I $D(Y) S IBPOPOUT=1
 I $G(IBPOPOUT) Q
 ;IA# 10018
 S DR="90.06Prosthesis/Crown/Inlay Code: " D ^DIE I $D(Y) S IBPOPOUT=1 Q
 S DR="90.07Prior Placement Date Qualifier: " D ^DIE I $D(Y) S IBPOPOUT=1 Q
ORAL2 ;check for conditional required field
 ;IA# 2056
 I $$GET1^DIQ(399.0304,DA_","_DA(1),90.06,"I")="R",$$GET1^DIQ(399.0304,DA_","_DA(1),90.07)="" D  Q:$G(IBPOPOUT)  G ORAL2
 . W *7,!," ** Prior Placement Date Qualifier and Date need to be present when Prosthesis/Crown/Inlay Code equals 'R'"
 . ;IA# 10018
 . S DR="90.06Prosthesis/Crown/Inlay Code: ;90.07Prior Placement Date Qualifier: " D ^DIE I $D(Y) S IBPOPOUT=1
 . Q
 ;IA# 2056; IA# 10018
 I $$GET1^DIQ(399.0304,DA_","_DA(1),90.07)'="" S DR="90.08Prior Placement Date: " D ^DIE
 I $D(Y) S IBPOPOUT=1 Q
 ;JWS;IB*2.0*650;8/5/20 - if no Prior Placement Date Qualifier (it was deleted), then delete the Prior Placement Date
 I $$GET1^DIQ(399.0304,DA_","_DA(1),90.07)="",$$GET1^DIQ(399.0304,DA_","_DA(1),90.08)'="" D
 . S DR="90.08///@" D ^DIE
 ;
ORAL1 ; check for conditional required field
 I $$GET1^DIQ(399.0304,DA_","_DA(1),90.07,"I")=441,$$GET1^DIQ(399.0304,DA_","_DA(1),90.08)="" D  Q:$G(IBPOPOUT)  G ORAL1
 . W *7,!," ** Prior Placement Date is required when Prior Placement Date Qualifier equals 441 (Prior Placement Date)"
 . S DR="90.07Prior Placement Date Qualifier: ;90.08Prior Placement Date: " D ^DIE S:$D(Y) IBPOPOUT=1
 M ODA=DA K DA
 S IBPIEN=ODA
 S DA(1)=IBIFN,DA=IBPIEN,IBUPOUT=0
T1 ;
 S IBTOO=$$SELTOO(IBIFN,IBPIEN)
 I IBTOO=-1 G T2
 I IBTOO=-2 S IBPOPOUT=1 G TEXIT
 S DIE="^DGCR(399,"_IBIFN_",""CP"","_IBPIEN_",""DEN1"","
 S DA(2)=IBIFN,DA(1)=IBPIEN,DA=IBTOO
 ;I '$G(IBNEW) S DR=".01Tooth Code("_IBTOO_"): " D ^DIE
 ;IA# 10018
 I '$G(IBNEW) S DR=".01Tooth Code: " D ^DIE
 I '$G(IBNEW),'$D(DA) G T1  ;TEXIT  ;Deleted Tooth Code
 I $G(Y)="^" S IBPOPOUT=1 G TEXIT
 ;IA# 3820
 S DEN1=$G(^DGCR(399,IBIFN,"CP",IBPIEN,"DEN1",DA,0))
 F I1=2:1:6 D  Q:$G(IBPOPOUT)  I X="",$P(DEN1,"^",I1+1)="" Q
 . ;S DR=".0"_I1_"Tooth Surface Code("_DA_"): " D ^DIE
 . ;IA# 10018
 . S DR=".0"_I1_"Tooth Surface Code("_(I1-1)_"): " D ^DIE
 . I $G(Y)="^" S IBPOPOUT=1
 I $G(IBPOPOUT) G TEXIT
 G T1
 ;
T2 ;
 K DA M DA=ODA K ODA
 K DR
 S DR="90.09Orthodontic Banding Date: ;90.1Orthodontic Banding Replacement Date: ;90.11Treatment Start Date: ;90.12Treatment Completion Date: "
 S DIE="^DGCR(399,"_IBIFN_",""CP"","
 ;IA# 10018
 D ^DIE
 I $G(Y)="^" S IBPOPOUT=1
 Q
TEXIT ;abort out
 K DA M DA=ODA
 Q
 ;
SELTOO(IBIFN,IBPIEN) ;
 ; Provides the user with a quick view of currently entered Service Line Tooth
 ; Information multiples and allows them to select one to edit or enter a new
 ; one.
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN   - Service Line Multiple IEN
 ; Returns: Value of the .01 field of the multiple to edit
 ;          "" if creating a new multiple, -2 to exit multiple
 ;          IBNEW=1 when creating a new entry
 N CNT,ENTNUM,TDATA,IEN,H1,H2,IEN,IENS,L1,L2,MAX,RETIEN,SECT,TIDATA,TTYPE,X,XX,Y,YY
 S IBNEW=0,SECT="Tooth Information"
 ; First check for an empty Additional Patient Information Line to delete
 D DELSTI(IBIFN,IBPIEN)
 ;
 ; Next create an array of all current PROCEDURE Line Tooth Information Lines
 S XX=+$P($G(^DGCR(399,IBIFN,"CP",IBPIEN,"DEN1",0)),"^",4)  ; Total # of multiples
 S MAX=$S(XX<32:"",1:"Tooth Information Lines")
 S IEN=0,CNT=0
 F  D  Q:+IEN=0  I CNT=1,IBUNIT'=1 Q
 . S IEN=$O(^DGCR(399,IBIFN,"CP",IBPIEN,"DEN1",IEN))
 . Q:+IEN=0
 . S CNT=CNT+1
 . S XX="  "_$$LJ^XLFSTR(CNT,4)                 ; Selection #
 . S IENS=IEN_","_IBPIEN_","_IBIFN_","
 . S YY=$$GET1^DIQ(399.30491,IENS,.01,"I")      ; Tooth Code (External)
 . S YY=$$GET1^DIQ(356.022,YY_",",.01)          ; Tooth Code
 . S XX=XX_$$LJ^XLFSTR(YY,7)
 . S YY=$$GET1^DIQ(399.30491,IENS,.02)          ; Tooth Surface #1
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S YY=$$GET1^DIQ(399.30491,IENS,.03)          ; Tooth Surface #2
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S YY=$$GET1^DIQ(399.30491,IENS,.04)          ; Tooth Surface #3
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S YY=$$GET1^DIQ(399.30491,IENS,.05)          ; Tooth Surface #4
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S YY=$$GET1^DIQ(399.30491,IENS,.06)          ; Tooth Surface #5
 . S XX=XX_$$LJ^XLFSTR(YY,12)
 . S TIDATA(CNT)=IEN_"^"_XX
 ;
 I 'CNT D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . ;W !!,"  No Tooth Information is currently on file.",!
 . ;S XX=$$ASKNEW^IBTRH5D("  Add Tooth Information")
 . ;Q:XX<0
 . S TTYPE=$$TTYPE(IBIFN,IBPIEN)                ; Get the .01 value
 . I $G(IBPOPOUT) Q
 . I TTYPE="" S XX=-1 Q                         ; None entered
 . S IBNEW=1,XX=TTYPE
 . S FDA(399.30491,"+1,"_IBPIEN_","_IBIFN_",",.01)=TTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 ;
 ; Next display all of the current Tooth Information lines and let the user select one
 S H1="  #   Tooth  Surface #1  Surface #2  Surface #3  Surface #4  Surface #5"
 S H2="  --  -----  ----------  ----------  ----------  ----------  ----------"
 S L1="  The following Tooth Information Lines are currently on file."
 S L2="  Enter # to edit, N to add new, D# to delete or Enter to continue."
 S XX=$$SELENT^IBTRH5D(.TIDATA,H1,H2,L1,L2,MAX,1,SECT)
 I XX?1"D".N D  Q -3
 . S (XX,ENTNUM)=$P(XX,"D",2)
 . S XX=$P(TIDATA(XX),"^",1)
 . D DELSTI(IBIFN,IBPIEN,XX)
 . W !,"Entry #",ENTNUM," has been deleted."
 I XX<0 Q XX
 I XX=0 D  Q $S($O(RETIEN(0)):RETIEN($O(RETIEN(0))),1:XX)
 . S TTYPE=$$TTYPE(IBIFN,IBPIEN)                ; Get the .01 value
 . I $G(IBPOPOUT) Q
 . I TTYPE="" S XX=-1 Q                         ; None entered
 . S IBNEW=1
 . S XX=TTYPE
 . S FDA(399.30491,"+1,"_IBPIEN_","_IBIFN_",",.01)=TTYPE
 . D UPDATE^DIE("","FDA","RETIEN")              ; File the new line
 Q $P(TIDATA(XX),"^",1)
 ;
DELSTI(IBIFN,IBPIEN,IEN) ; Checks to see if the user entered 'NEW' to create a new 
 ; Tooth Information Line and didn't enter any data for it OR selected a line
 ; to be deleted.  If so, the Additional Tooth Information line with no data 
 ; (or selected) is deleted
 ; Input:   IBTRIEN - IEN of the 356.22 entry being edited
 ;          SIEN    - IEN of the Service Line being edited
 ; Output:  Empty (or selected) Tooth Information line is deleted (Potentially)
 N DA,DIK,TIIEN,X,XX,Y
 S:'$D(IEN) IEN=""
 I IEN'="" D  Q
 . S DA(2)=IBIFN,DA(1)=IBPIEN,DA=IEN
 . S DIK="^DGCR(399,DA(2),""CP"",DA(1),""DEN1"","
 . D ^DIK  ; Delete the multiple
 ;
 S TIIEN=+$P($G(^DGCR(399,IBIFN,"CP",IBPIEN,"DEN1",0)),"^",3)  ; Last Multiple IEN
 Q:'TIIEN
 S XX=$G(^DGCR(399,IBIFN,"CP",IBPIEN,"DEN1",TIIEN,0))
 ;JWS;IB*2.0*592 6/12/19 - allow for just a tooth entry without a surface.
 I $P(XX,"^")'="" Q    ;allow for just a tooth entry
 S $P(XX,"^")=""       ; Remove .01 field
 Q:$TR(XX,"^","")'=""  ; 0 node data exists
 S DA(2)=IBIFN,DA(1)=IBPIEN,DA=TIIEN
 S DIK="^DGCR(399,DA(2),""CP"",DA(1),""DEN1"","
 D ^DIK  ; Delete the multiple
 Q
 ;
TTYPE(IBIFN,IBPIEN) ; Prompts the user to enter the .01 (Tooth) field of the
 ; Tooth Information multiple
 ; Input:   IBIFN - IEN of the 356.22 entry being edited
 ;          IBPIEN    - IEN of the Service Line
 ; Returns: IEN of the selected Tooth Type or "" of not entered
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DA(2)=IBIFN,DA(1)=IBPIEN
 S DIR(0)="399.30491,.01",DIR("A")="    Tooth Code"
 D ^DIR
 I $G(Y)="^" S IBPOPOUT=1
 Q:$D(DIRUT) ""
 Q $P(Y,"^",1)
 ;
