IBCU7 ;ALB/AAS - INTERCEPT SCREEN INPUT OF PROCEDURE CODES ;29-OCT-91
 ;;2.0;INTEGRATED BILLING;**62,52,106,125,51,137,210,245,228,260,348,371,432,447,488,461,516,522**;21-MAR-94;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRU7
 ;
CHKX ;  -interception of input x from Additional Procedure input
 G:X=" " CHKXQ
 I $$INPAT^IBCEF(DA(1)),'$P($G(^IBE(350.9,1,1)),"^",15),X'?1A1.2N D  G CHKXQ
 . K X
 . D EN^DDIOL("Site param does not allow entry of non-PTF procedures") ;Fileman error here will be: The previous error occurred when performing an action specified in a Pre-lookup transform (7.5 node).
 G:'$D(^UTILITY($J,"IB")) CHKXQ
 ;S M=($A($E(X,1))-64),S=+$E(X,2) Q:'$G(^UTILITY($J,"IB",M,S))  S X="`"_+^(S)
 S M=0 I X?1A1.2N S N=$G(^UTILITY($J,"IB","B",X)) S M=+N,S=+$P(N,U,2),P=X S S=$G(^UTILITY($J,"IB",M,S)) I +S S X="`"_+S I $P(N,U,3)="N" S X=""""_X_"""" S $P(^UTILITY($J,"IB","B",P),U,3)="Y"
 I +M,$D(DGPROCDT),DGPROCDT'=$P($G(^UTILITY($J,"IB",M,1)),"^",2) S DGPROCDT=$P(^(1),"^",2) W !!,"Procedure Date: " S Y=DGPROCDT X ^DD("DD") W Y,!
CHKXQ Q
 ;
CODMUL ;Date oriented entry of procedure
DELASK I $D(IBZ20),IBZ20,IBZ20'=$P(^DGCR(399,IBIFN,0),U,9) S %=2 W !,"SINCE THE PROCEDURE CODING METHOD HAS BEEN CHANGED, DO YOU WANT TO DELETE ALL",!,"PROCEDURE CODES IN THIS BILL"
 I  D YN^DICN Q:%=-1  D:%=1 DELADD I %Y?1."?" W !!,"If you answer 'Yes', all procedure codes will be DELETED from this bill.",! G DELASK
 K %,%Y,DA,IBZ20,DIK ;W !,"Procedure Entry:"
 ;
CODDT I $D(IBIFN),$D(^DGCR(399,IBIFN,0)),$P(^(0),U,9) S DIC("V")=$S($P(^(0),U,9)=9:"I +Y(0)=80.1",$P(^(0),U,9)=4!($P(^(0),U,9)=5):"I +Y(0)=81",1:"")
 I $P($G(^DGCR(399,IBIFN,0)),"^",5)<3 S IBZTYPE=1 I $P($G(^UTILITY($J,"IB",1,1)),"^",2) S DGPROCDT=$P(^(1),"^",2) D ASKCOD
 S X=$$PRCDIV^IBCU71(IBIFN) I +X W !!,$P(X,U,2),!
 N Z,Z0 S Z=$G(^DGCR(399,IBIFN,"U")),Z0=$$FMTE^XLFDT($P(Z,U),"2D")_"-"_$$FMTE^XLFDT($P(Z,U,2),"2D")
 W !,"Select PROCEDURE DATE"_$S($TR(Z0,"-")'="":" ("_Z0_")",1:"")_": " R X:DTIME G:'$T!("^"[X) CODQ D:X["?" CODHLP
 S IBEX=0 D  ; Get procedure date
 . I X=" ",$D(DGPROCDT),DGPROCDT?7N S Y=DGPROCDT D D^DIQ W "   (",Y,")" Q
 . I X=" ",+$P($G(^DGCR(399,IBIFN,"OP",0)),"^",4) S (DGPROCDT,Y)=$O(^DGCR(399,IBIFN,"OP",0)) D D^DIQ W "   (",Y,")" Q
 . S %DT="EXP",%DT(0)=-DT D ^%DT K %DT I Y<1 S IBEX=1 Q
 . I '$$OPV2^IBCU41(Y,IBIFN,1) S IBEX=1 Q
 . S:'$G(IBZTYPE) X=$$OPV^IBCU41(Y,IBIFN) S DGPROCDT=Y
 I 'IBEX D ASKCOD,ADDCPT^IBCU71:$D(DGCPT)
 K IBEX
 G CODDT
 ;
ASKCOD N Z,Z0,DA,IBACT,IBQUIT,IBLNPRV  ;WCJ;2.0*432
 N IBPOPOUT  S IBPOPOUT=0  ; IB*2.0*447 BI
 K DGCPT
 S DGCPT=0,DGCPTUP=$P($G(^IBE(350.9,1,1)),"^",19),DGADDVST=0,IBFT=$P($G(^DGCR(399,IBIFN,0)),"^",19)
 I '$D(^DGCR(399,IBIFN,"CP",0)) S ^DGCR(399,IBIFN,"CP",0)=U_$$GETSPEC^IBEFUNC(399,304)
 ;
 F  S IBQUIT=0 D  Q:IBQUIT
 . S IBPOPOUT=0
 . D DICV ; restrict code type to PCM
 . S DIC("A")="   Select PROCEDURE: "
 . S DIC="^DGCR(399,"_IBIFN_",""CP"","
 . S DIC(0)="AEQMNL"
 . S DIC("S")="I '$D(DIV(""S""))&($P(^(0),U,2)=DGPROCDT)"
 . S DIC("DR")="1///^S X=DGPROCDT"
 . S DA(1)=IBIFN,DLAYGO=399
 . W ! D ^DIC I Y<1 S IBQUIT=1 Q
 . S IBPROCP=+Y
 . ; If we just added inactive code - it must be deleted.
 . S IBACT=0 ; Active flag
 . I Y["ICD0" S IBACT=$$ICD0ACT^IBACSV(+$P(Y,U,2),$$BDATE^IBACSV(IBIFN))
 . I Y["ICPT" S IBACT=$$CPTACT^IBACSV(+$P(Y,U,2),DGPROCDT)
 . S DGCPTNEW=$P(Y,"^",3) ;Was the procedure just added?
 . I DGCPTNEW,'IBACT D DELPROC Q
 . I 'IBACT W !,*7,"Warning:  Procedure code is inactive on this date",!
 . I DGCPTNEW,$D(^UTILITY($J,"IB")),$$INPAT^IBCEF(IBIFN),Y["ICPT(" D DATA^IBCU74(Y,.IBLNPRV)
 . S DGADDVST=$S(DGCPTNEW:1,$D(DGADDVST):DGADDVST,1:0)
 . N IBPRV,IBPRVO,IBPRVN
 . ;
 . ; Line level provider function by form type.
 . ;     CMS-1500 (FORM TYPE=2)
 . ;              RENDERING PROVIDER, REFERRING PROVIDER,
 . ;              and SUPERVISING PROVIDER.
 . ;     UB-04 (FORM TYPE=3)
 . ;              RENDERING PROVIDER, REFERRING PROVIDER,
 . ;              OPERATING PROVIDER, and OTHER OPERATING
 . ;              PROVIDER.
 . ;
 . ; Removed: Call to $$MAINPRV^IBCEU(IBIFN) is for claim
 . ;          level provider defaults.
 . ;     1. For new line level providers we don't need
 . ;        or want default claim level provider
 . ;        (requirement).
 . ;     2. We don't want to default claim level to
 . ;        line level provider (requirement).
 . ;
 . K DIC("V")  ; DEM;432 - KILL DIC("V") because this was for previous variable pointer use.
 . ;
 . N IBPROCSV  ; DEM;432 - Variable IBPROCSV is variable to preserve value of 'Y', which is procedure code info returned by call to ^DIC.
 . S IBPROCSV=Y  ; DEM;432 - Preserve value of Y for after calls to FileMan (Y = procedure code info returned by call to ^DIC).
 . K DR   ;WCJ;IB*2.0*432
 . ;
 . I IBPROCSV["ICD0" S DR=".01",DIE=DIC,(IBPROCP,DA)=+Y D ^DIE Q:'$D(DA)!($D(Y))  K DR ; IB*2.0*461
 . I IBPROCSV["ICPT" S DR=".01;16",DIE=DIC,(IBPROCP,DA)=+Y D ^DIE Q:'$D(DA)!($D(Y))  K DR ; IB*2.0*447 BI
 . ;
 . S DR=""
 . ;
 . ; MRD;IB*2.0*516 - Added line level PROCEDURE DESCRIPTION field,
 . ; asked only if the procedure is an "NOC".
 . I IBPROCSV["ICPT",$$NOCPROC(IBPROCSV) D
 . . S DA=$P(IBPROCSV,"^")  ; The line# on the bill/claim.
 . . S DR=51                ; Field# for PROCEDURE DESCRIPTION
 . . D ^DIE
 . . Q
 . ;
 . D EN^IBCU7B ; DEM;432 - Call to line level provider user input.
 . S Y=IBPROCSV  ; DEM;432 - Restore value of Y after calls to FileMan
 . K IBPROCSV
 . K DR   ;WCJ;IB*2.0*432
 . I IBPOPOUT Q   ; IB*2.0*447 BI
 . S DR="" I Y["ICPT" S DR="6;5//"_$$DEFDIV(IBIFN)_";"
 . S DR=DR_$S(IBFT=2:"8;9;17//NO;",1:"")_3,DIE=DIC,(IBPROCP,DA)=+Y D ^DIE Q:'$D(DA)!($E($G(Y))=U)
 . K DR   ;WCJ;IB*2.0*432
 . ;
 . ; MRD;IB*2.0*516 - Allow user to add an NDC and Units.  Ask only if
 . ; coding system is not ICD and this is not a prescription claim. If
 . ; an NDC is entered, prompt for Units.
 . I $P($G(^DGCR(399,IBIFN,0)),U,9)'=9,'$$RXLINK^IBCSC5C(IBIFN,IBPROCP) D
 . . K DA
 . . S DA=IBPROCP,DA(1)=IBIFN,DIE="^DGCR(399,"_IBIFN_",""CP"","
 . . S DR="53NDC NUMBER;I X="""" S Y="""";54//1"
 . . D ^DIE
 . . Q
 . ;
 . I IBFT=3 D:'$$INPAT^IBCEF(IBIFN) ATTACH  ; DEM;432 - Prompt for Attachment Control Number.
 . ; DEM;432 - Add Additional OB Minutes to DR string for call to DIE.
 . S DR=$$SPCUNIT(IBIFN,IBPROCP) S:DR["15;" DR=DR_"74Additional OB Minutes" D ^DIE ; miles/minutes/hours
 . ;
 . I IBFT=2 D
 .. D DX^IBCU72(IBIFN,IBPROCP)
 .. S X=$$ADDTNL(IBIFN,.DA)
 . Q:$$INPAT^IBCEF(IBIFN)  ;only outpatient bills
 . ;add procedures to array for download to PCE: dgcpt(assoc clinic,cpt,'provider^first dx^modifiers',cnt)=""
 . S DGPROC=$G(^DGCR(399,IBIFN,"CP",+DA,0))
 . S X=$P(DGPROC,U,18)_U_+$G(^IBA(362.3,+$P(DGPROC,U,11),0))_U_$P(DGPROC,U,15)
 . I 'DGCPTNEW,$P(DGPROC,"^",7)="" S DGCPTNEW=2
 . I DGCPTUP,DGCPTNEW S DGCPT=DGCPT+1 I $P(DGPROC,"^",7) S DGCPT($P(DGPROC,"^",7),+DGPROC,X,DGCPT)=""
 . ; add visit date to bill
 . I DGADDVST S (X,DINUM)=DGPROCDT D VFILE1^IBCOPV1 K DINUM,X,DGNOADD,DGADDVST
 ; Delete modifiers with only a sequence #, no code
 S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"CP",Z)) Q:'Z  S Z0=0 F  S Z0=$O(^DGCR(399,IBIFN,"CP",Z,"MOD",Z0)) Q:'Z0  I $P($G(^(Z0,0)),U,2)="" S DA(2)=IBIFN,DA(1)=Z,DA=Z0,DIK="^DGCR(399,"_DA(2)_",""CP"","_DA(1)_",""MOD""," D ^DIK
 Q
CODQ K %DT,DGPROC,DIC,DIE,DR,DGPROCDT,IBPROCP,DLAYGO
 K IBFT,DGNOADD,DGADDVST,DGCPT,DGCPTUP,IBZTYPE,DGCPTNEW
 Q
 ;
DELPROC ; Remove the selected procedure, because of inactive status (cancel selection)
 W !!,*7,"The Procedure code is inactive on ",$$DAT1^IBOUTL(DGPROCDT),"."
 W !,"Please select another Procedure."
 S DA(1)=IBIFN,DA=+Y,DIK="^DGCR(399,"_IBIFN_",""CP"","
 D ^DIK
 Q
 ;
DELADD N Z,Z0,DA,DIK,X,Y
 S DA(1)=IBIFN
 ;Delete references to proc on rev codes
 S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"RC",Z)) Q:'Z  S Z0=$G(^(Z,0)) I Z0'="",$P(Z0,U,15)!$S($P(Z0,U,10)=3:$P(Z0,U,11),1:0) S DIE="^DGCR(399,"_DA(1)_",""RC"",",DA=Z,DR=".11///@;.15///@"_$S($P(Z0,U,8):"",1:";.08////1") D ^DIE
 S DIK="^DGCR(399,"_DA(1)_",""CP""," F DA=0:0 S DA=$O(^DGCR(399,DA(1),"CP",DA)) Q:'DA  D ^DIK
 S DGRVRCAL=1
 Q
 ;
DTMES ;Message if procedure date not in date range
 Q:'$D(IBIFN)  Q:'$D(^DGCR(399,IBIFN,"U"))  S DGNODUU=^("U")
 G:X'<$P(DGNODUU,"^")&(X'>$P(DGNODUU,"^",2)) DTMESQ
 W *7,!!?3,"Date must be within STATEMENT COVERS FROM and STATEMENT COVERS TO period."
 S Y=$P(DGNODUU,"^") X ^DD("DD")
 W !?3,"Enter a date between ",Y," and " S Y=$P(DGNODUU,"^",2) X ^DD("DD") W Y,!
 K X,Y
DTMESQ K DGNODUU Q
 ;
CODHLP ;Display Additional Procedure codes
 N I,J,Y,IBMOD
 I '$O(^DGCR(399,IBIFN,"CP",0)) W !!?5,"No Codes Entered!",! Q
 W ! F I=0:0 S I=$O(^DGCR(399,IBIFN,"CP",I)) Q:'I  S Y=$G(^(I,0)) S Z=$$PRCNM^IBCSCH1($P(Y,"^",1),$P(Y,"^",2)) W !?5,$E($P(Z,"^",2),1,33),?40,"- ",$P(Z,"^") D
 . N IBY
 . S IBY=$P(Y,U,2)
 . S IBMOD=$$GETMOD^IBEFUNC(IBIFN,I,1)
 . I IBMOD'="" S IBMOD="/"_IBMOD W IBMOD
 . W ?60,"Date: " S Y=IBY D DT^DIQ
 W !
 ;
 K Z Q
 ;
DICV I $D(IBIFN),$D(^DGCR(399,IBIFN,0)),$P(^(0),U,9) S DIC("V")=$S($P(^(0),U,9)=9:"I +Y(0)=80.1",$P(^(0),U,9)=4!($P(^(0),U,9)=5):"I +Y(0)=81",1:"")
 Q
 ;
DEFDIV(IBIFN) ; Find default division for bill IBIFN
 Q $P($G(^DG(40.8,+$P($G(^DGCR(399,IBIFN,0)),U,22),0)),U)
 ;
ADDTNL(IBIFN,DA) ;
 N DR,IBOK,X,Y,DIR
 S IBOK=1
 S DR="19T;50.09T;50.08T" D ^DIE  ; WCJ;IB*2.0*488 Added Ts
 ;I '($$FT^IBCEF(IBIFN)'=3&($$INPAT^IBCEF(IBIFN))) D ATTACH  ; DEM;432 - Prompt for Attachment Control Number.
 I '($$FT^IBCEF(IBIFN)=3&($$INPAT^IBCEF(IBIFN))) D ATTACH  ; DEM;432 - Prompt for Attachment Control Number.
 I $D(Y) S IBOK=0 G ADDTNLQ
 ;/Beginning of IB*2.0*488 (vd)
 ;S DIR("B")="NO",DIR("A")="EDIT CMS-1500 SPECIAL PROGRAM FIELDS and BOX 19?: ",DIR("A",1)=" ",DIR(0)="YA"
 ;S DIR("?",1)="Respond YES only if you need to add/edit data for chiropractic visits,"
 ;S DIR("?")="EPSDT care, or if billing for HOSPICE and attending is not a hospice employee."
 ;D ^DIR K DIR
 ;I Y'=1 S IBOK=0 G ADDTNLQ
 ;S DR="W !,""  <<EPSDT>>"";50.07;W !!,""  <<HOSPICE>>"";50.03"
 S DR="50.07T;50.03T"   ;WCJ;IB*2.0*488 added Ts
 ;/End of IB*2.0*488 (vd)
 D ^DIE
 W !
ADDTNLQ Q IBOK
 ;
XTRA1(Y) ;
 K Y
 Q
 ;
SPCUNIT(IBIFN,DA) ; return fields for special units if applicable, in DR form
 N IB0,IBCPT,IBDR,IBCT,IBFT,DFN S IBDR=""
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBCT=$P(IB0,U,27),IBFT=$P(IB0,U,19),DFN=$P(IB0,U,2)
 S IBCPT=$G(^DGCR(399,+$G(IBIFN),"CP",+$G(DA),0)) I IBCPT'["ICPT" G SPCUNTQ
 I +$$ITMUNIT^IBCRU4(+IBCPT,5,IBCT) S IBDR="15;" D SROMIN^IBCU74(IBIFN,DA) G SPCUNTQ ; minutes
 I +$$ITMUNIT^IBCRU4(+IBCPT,4,IBCT) S IBDR="21;" G SPCUNTQ ; miles
 I +$$ITMUNIT^IBCRU4(+IBCPT,6,IBCT) S IBDR="22//"_$$OBSHOUR^IBCU74(DFN,$P(IBCPT,U,2))_";" G SPCUNTQ ; hours
 I +IBFT=2,$P($G(^IBE(353.2,+$P(IBCPT,U,10),0)),U,2)="ANESTHESIA" S IBDR="15;" ; minutes
SPCUNTQ Q IBDR
 ;
ATTACH ; DEM;432 - Attachment control number.
 ; Ask if user wants to enter Attachment Control Number.
 N DIR,X,Y,DA,DIE,DR
 S DIR("A")="Enter Attachment Control Number"
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR
 Q:'Y
 ; User chose to enter Attachment Control Number.
 ; User enters Attachment Control fields.
 S DA(1)=IBIFN,DA=IBPROCP
 S DIE="^DGCR(399,"_DA(1)_",""CP"","
 S DR="71Report Type;72Report Transmission Method;70Attachment Control Number"
 D ^DIE
 Q
 ;
NOCPROC(IBPROCSV) ; MRD;IB*2.0*516 - Function to determine if procedure is an
 ; "NOC".  Returns '1' if "NOC" procedure, otherwise '0'.
 ;
 N IBNOC,IBPROCEX,IBPROCIN,IBPROCNM,IBX
 S IBNOC=0
 I $G(IBPROCSV)="" G NOCPROCQ
 S IBPROCIN=$P($P(IBPROCSV,U,2),";")
 I IBPROCIN="" G NOCPROCQ
 ;
 ; If procedure code ends in '99', quit with a '1'.
 ;
 S IBPROCEX=$P($G(^ICPT(IBPROCIN,0)),U,1)
 I $E(IBPROCEX,$L(IBPROCEX)-1,$L(IBPROCEX))=99 S IBNOC=1 G NOCPROCQ
 ;
 ; Pull procedure name, then check to see if it contains one of the
 ; specified strings.
 ;
 S IBPROCNM=$P($G(^ICPT(IBPROCIN,0)),U,2)
 I IBPROCNM'="",$$NOC(IBPROCNM) S IBNOC=1 G NOCPROCQ
 ;
 S IBX=0
 F  S IBX=$O(^ICPT(IBPROCIN,"D",IBX)) Q:'IBX  D  I IBNOC=1 Q
 . S IBTEXT=$G(^ICPT(IBPROCIN,"D",IBX,0))
 . I $G(^ICPT(IBPROCIN,"D",IBX+1,0))'="" S IBTEXT=IBTEXT_" "_$G(^ICPT(IBPROCIN,"D",IBX+1,0))
 . S IBNOC=$$NOC(IBTEXT)
 . Q
 ;
NOCPROCQ ; Quit out.
 Q IBNOC
 ;
NOC(IBTEXT) ; Quit with '1' if IBTEXT contains one of the specified strings.
 ;
 S IBTEXT=$TR(IBTEXT,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
 I IBTEXT["NOT OTHERWISE" Q 1
 I IBTEXT["NOT ELSEWHERE" Q 1
 I IBTEXT["NOT LISTED" Q 1
 I IBTEXT["UNLISTED" Q 1
 I IBTEXT["UNSPECIFIED" Q 1
 I IBTEXT["UNCLASSIFIED" Q 1
 I IBTEXT["NON-SPECIFIED" Q 1
 I IBTEXT["NOS " Q 1
 I IBTEXT["NOS;" Q 1
 I IBTEXT["NOS." Q 1
 I IBTEXT["NOS," Q 1
 I IBTEXT["NOS/" Q 1
 I IBTEXT["(NOS)" Q 1
 I IBTEXT["NOC " Q 1
 I IBTEXT["NOC;" Q 1
 I IBTEXT["NOC." Q 1
 I IBTEXT["NOC," Q 1
 I IBTEXT["NOC/" Q 1
 I IBTEXT["(NOC)" Q 1
 ;
 ; Check if last three charcters are 'NOC' or 'NOS'.
 ;
 S IBTEXT=$E(IBTEXT,$L(IBTEXT)-2,$L(IBTEXT))
 I IBTEXT="NOC" Q 1
 I IBTEXT="NOS" Q 1
 ;
 Q 0
 ;
