IBCCPT ;ALB/LDB - MCCR OUTPATIENT VISITS LISTING CONT. ;29 MAY 90
 ;;2.0;INTEGRATED BILLING;**55,62,52,91,106,125,51,148,174,182,245,266,260,339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRCPT
 ;
EN1(IBQUERY,IBHLP) ;
 K DIR
EN D:$D(DIR) HLP W @IOF S DGU=0 K DGCPT,^UTILITY($J) D VST(.IBQUERY)
 D CHDR,WRNO
 N ICPTVDT S ICPTVDT=$$BDATE^IBACSV($G(IBIFN)) ; Code Text Version
 S (DGCNT,DGCNT1)=0 F  S DGCNT=$O(^UTILITY($J,"CPT-CNT",DGCNT)) Q:'DGCNT  S DGNOD=^(DGCNT),DGCPT=+DGNOD,DGDAT=$P(DGNOD,"^",2),DGBIL=$P(DGNOD,"^",3),DGASC=$P(DGNOD,"^",4),DGDIV=$P(DGNOD,"^",5),DGCNT1=DGCNT1+1 D CPRT I DGU="^" S DGCNT=DGCNT-1 Q
 I DGU'="^" F Y=$Y:1:IOSL-6 W !
OK1 K Y Q:'$D(^UTILITY($J,"CPT-CNT"))!($D(DIR))!($G(IBHLP))
OK S DIR(0)="LAO^1:"_DGCNT1_"^K:X[""."" X",DIR("?")="^N DIR D EN1^IBCCPT(.IBQUERY,1)",DIR("A")="SELECT CPT CODE(S) TO INCLUDE IN THIS BILL: "
 D ^DIR K DIR I 'Y D Q1^IBCOPV1 Q
 S IBFT=+$P(^DGCR(399,IBIFN,0),"^",19)
OK2 W !,"YOU HAVE SELECTED CPT CODE(S) NUMBERED-",$E(Y,1,$L(Y)-1),!,"IS THIS CORRECT" S %=1 D YN^DICN I %=-1 S IBOUT=1 D Q^IBCOPV1 Q
 I +Y,'% W !,"Respond 'Y'es to include these codes in the bill.",!,"Respond 'N'o to reselect." G OK2
 I +Y,%=2 G OK
 ;
FILE S DGCPT1=Y,(DGCNT,DGCNT2)=0
 S DIE="^DGCR(399,",DA=IBIFN,DR=".09///5" D ^DIE K DR,DA,DIE
 F I9=1:1 S I1=$P(DGCPT1,",",I9) Q:'I1  I $D(^UTILITY($J,"CPT-CNT",I1)) S DGNOD=^(I1),DGNOD("DX")=$G(^(I1,"DX")) D FILE1
 D Q1^IBCOPV1 Q
 ;
FILE1 ;  file procedures, if BASC, only for 1 visit date
 K DGNOADD S (X,DINUM)=$P(DGNOD,"^",2) D VFILE1^IBCOPV1 K DINUM,X
 N IBCPTNM S IBCPTNM=$$CPT^ICPTCOD(+DGNOD,+$P(DGNOD,U,2))
 I $D(DGNOADD) W !?10,"Can't add Amb. Surg. ",$P(IBCPTNM,U,2)," without visit date!" Q  ;don't add cpt for date that can't go on bill
 I IBFT'=2,+$P(DGNOD,"^",4),$$TOMANY($P(DGNOD,"^",2)) W !?10,"Can't add Billable Amb. Surg. ",$P(IBCPTNM,U,2)," when more than one visit date!",*7 Q
 D DSPPRC(IBCPTNM,DGNOD,$G(DGNOD("DX")))
 ;
 S:'$D(^DGCR(399,IBIFN,"CP",0)) DIC("P")=$$GETSPEC^IBEFUNC(399,304)
 S DLAYGO=399,DA(1)=IBIFN,DIC="^DGCR(399,"_DA(1)_",""CP"",",DIC(0)="L",X=+DGNOD_";ICPT(" K DD,DO D FILE^DICN S (DA,IBPROCP)=+Y K DO,DD,DLAYGO,DIC("P")
 ;
 S DR="1///"_$P(DGNOD,"^",2)
 I +$P(DGNOD,"^",8) S DR=DR_";18///`"_+$P(DGNOD,"^",8)
 I +$P(DGNOD,"^",9) S DR=DR_";6///`"_+$P(DGNOD,"^",9)
 I +$P(DGNOD,"^",5) S DR=DR_";5////"_+$P(DGNOD,"^",5)
 I +$P(DGNOD,"^",11) S DR=DR_";20////"_+$P(DGNOD,"^",11)
 ;
 ; file assoc dx if exists from pce
 D:$G(DGNOD("DX")) ADDDX^IBCCPT1(IBIFN,IBPROCP,DGNOD("DX"),.DR)
 ;
 S DIE=DIC D ^DIE
 D:$P(DGNOD,U,10)'="" ADDMOD(IBIFN,IBPROCP,$P(DGNOD,U,10))
 ;
 S DR="16"
 I '$P(DGNOD,"^",8) S DR=DR_";18"
 I '$P(DGNOD,"^",9) S DR=DR_";6"
 I '$P(DGNOD,"^",5) S DR=DR_";5"
 S:IBFT=2 DR=DR_";8;9;17//NO"
 S DIE=DIC D ^DIE
 ;
 S DR=$$SPCUNIT^IBCU7(IBIFN,IBPROCP) I DR'="" D ^DIE ; miles/minutes/hours
 ;
 ; DSS QuadraMed Interface: CPT Sequence and Diagnosis Linkage for Single CPT
 I $$QMED^IBCU1("DX^VEJDIBE1",IBIFN) D DX^VEJDIBE1(IBIFN,IBPROCP)
 ;
 Q:$D(Y)
 D DX^IBCU72(IBIFN,IBPROCP):IBFT=2
 I IBFT=2 S X=$$ADDTNL^IBCU7(IBIFN,.DA)
 L ^DGCR(399,IBIFN):1
 K DIE,DIC,DR,DA,IBPROCP
 Q
 ;
CPRT D:$Y+6>IOSL SCR Q:DGU="^"
 N IBCPTNM,IBNBM,IBMODS,J,IBZ,IBDATE
 S IBDATE=$$BDATE^IBACSV($G(IBIFN))
 S IBNBM="",IBCPTNM=$$CPT^ICPTCOD(DGCPT,IBDATE) Q:IBCPTNM'>0
 W !,DGCNT,")",?5,$P(IBCPTNM,U,2),?13,$E($P(IBCPTNM,U,3),1,24),?39,$E($P($G(^SC(+$P(DGNOD,U,9),0)),U,1),1,15),?56,$$FMTE^XLFDT(DGDAT,2)
 I +DGBIL,+$P($G(DGNOD),U,6) S IBNBM="  *ON BILL/"_$E($P(DGNOD,U,7),1,4)_"*"
 I IBNBM="",DGBIL S IBNBM="  *ON THIS BILL*"
 I IBNBM="",+$P($G(DGNOD),U,6) S IBNBM="  "_$E($P(DGNOD,U,7),1,12)
 W ?64,IBNBM
 ;
 S IBMODS=$P($G(DGNOD),U,10) F J=1:1 S IBZ=$P(IBMODS,",",J) Q:IBZ=""  S IBZ=$$MOD^ICPTMOD(IBZ,"I",IBDATE) W !,?13,$P(IBZ,U,2),?18,$P(IBZ,U,3)
 Q
CHDR W @IOF,!,?15,"<<CURRENT PROCEDURAL TERMINOLOGY CODES>>",!!,?10,"LISTING FROM VISIT DATES WITH ASSOCIATED CPT CODES",!,?22,"IN OUTPT ENCOUNTERS FILE",!
 K ^TMP("IBVIS",$J)
 S L="",$P(L,"=",80)="" W !,L,!,"NO.",?5,"CODE",?13,"SHORT NAME",?39,"CLINIC",?56,"DATE",!,L,! K L
 Q
ADDMOD(IBIFN,IBY,IBMOD) ; Add modifier(s) from PCE procedure to CPT code mult
 N DIE,DR,DIC,DA,DO,DD,IBS,IBM
 F IBS=1:1:$L(IBMOD,",") S DA(2)=IBIFN,DA(1)=IBY,X=$O(^DGCR(399,DA(2),"CP",DA(1),"MOD","B",""),-1)+1 S IBM=$P(IBMOD,",",IBS) I IBM'="" D
 . S:'$D(^DGCR(399,DA(2),"CP",DA(1),"MOD")) DIC("P")=$$GETSPEC^IBEFUNC(399.0304,16)
 . S DIC(0)="L",DIC="^DGCR(399,"_IBIFN_",""CP"","_IBY_",""MOD"",",DLAYGO=399.30416,DIC("DR")=".02////"_IBM
 . D FILE^DICN K DIC,DO,DD
 Q
 ;
DSPPRC(CPTNM,NOD,DX) ; display summary of procedure being added
 N IBI,IBL,IBMODS,IBMOD,IBPRVTYP,IBPRV,IBDATE,IBP,IBDXT
 I $G(CPTNM)=""!($G(NOD)="") Q
 S IBMODS=$P(NOD,U,10),IBPRVTYP="",IBPRV=""
 I +$P(NOD,U,8) S IBPRV=$P($G(^VA(200,+$P(NOD,U,8),0)),U,1),IBPRVTYP=$P($$PRVTYP^IBCRU6(+$P(NOD,U,8)),U,3) S IBL=$S(($L(IBPRVTYP)+$L(IBPRV))>32:"",1:" - ")
 ;
 W !!?4,"Adding CPT Procedure: ",$P(CPTNM,U,2),?34,$P(CPTNM,U,3)
 S IBDATE=$$BDATE^IBACSV($G(IBIFN))
 I IBMODS'="" F IBI=1:1 S IBMOD=$P(IBMODS,",",IBI) Q:'IBMOD  S IBMOD=$$MOD^ICPTMOD(IBMOD,"I",IBDATE) W !,?34,$P(IBMOD,U,2)," - ",$E($P(IBMOD,U,3),1,40)
 W !,?34,"Visit: ",$$FMTE^XLFDT(+$P(NOD,U,2),2),", ",$E($P($G(^SC(+$P(NOD,U,9),0)),U,1),1,29)
 I IBPRV'="" W !,?34,"Provider: ",$E(IBPRV,1,35) I IBPRVTYP'="" W:IBL="" !,?44 W IBL,IBPRVTYP
 I DX F IBP=1:1 Q:'$P(DX,"^",IBP)  S IBDXT=$$ICD9^IBACSV($P(DX,"^",IBP),+$P(NOD,U,2)) W !,?34,"Assoc Dx: ",$E($P(IBDXT,"^")_" "_$P(IBDXT,"^",3),1,35)
 W !
 Q
 ;
VST(IBQUERY) ;Procedures for outpatient visits ... If IBQUERY is defined
 ;  on entry, the QUERY OBJECT defined by this value will be used for
 ;  loop to extract procedures for visits, otherwise, a new QUERY will be opened
 ;  If passed by reference, IBQUERY will be ret'd as the new QUERY ref #
 S DGCNT=0 I $O(^DGCR(399,IBIFN,"OP",0)) F V=0:0 S V=$O(^DGCR(399,IBIFN,"OP",V)) Q:'V  S (IBOPV1,IBOPV2)=V D PROC(.IBQUERY)
 I $O(^DGCR(399,IBIFN,"OP",0)) K ^TMP("IBVIS",$J) G VSTQ
 S IBOPV1=$P(^DGCR(399,IBIFN,"U"),"^"),IBOPV2=$P(^("U"),"^",2)
 D PROC(.IBQUERY) K ^TMP("IBVIS",$J)
VSTQ Q
 ;
WRNO W:'$O(^UTILITY($J,"CPT-CNT",0)) !,"NO CPT CODES ON FILE FOR THE ",$S($O(^DGCR(399,IBIFN,"OP",0)):"VISIT DATES ON THIS BILL",1:"PERIOD THAT THIS STATEMENT COVERS")
 Q
SCR Q:DGU="^"  I $E(IOST,1,2)["C-",$Y+6>IOSL F Y=$Y:1:IOSL-5 W !
 I  R !,"Press return to continue or ""^"" to exit display ",DGU:DTIME D:DGU'="^" CHDR
 Q
HLP W !!,"Enter a number between 1 and ",DGCNT1," or a range of numbers separated with commas",!,"or dashes, e.g., 1,3,5 or 2-4,8"
 W !,"The number(s) must appear as a selectable number in the sequential list." R H:5 K H Q
CPT S DA(1)=IBIFN,IBCCPTZ=$P(^DGCR(399,DA(1),0),U,9),IBCCPTX=$S($D(^DGCR(399,DA(1),"C"))&IBCCPTZ:1,1:0)
 K DIK,DGTE,I1 Q
 ;
PROC(IBQUERY) ;  -find outpatient procedures, flag if billable
 ;  -  ^utility($j,cpt-cnt,count)=code^date^on bill^is BASC^divis^nb^nb mess^provider^clinic^mod,mod^Opt Enc Ptr
 ;  -  ^utility($j,cpt-cnt,count,"dx")=assoc dx(1)^assoc dx(2)^assoc dx(3)^assoc dx(4)
 N IBVAL,IBCBK,IBFILTER
 S IBVAL("DFN")=DFN,IBVAL("BDT")=IBOPV1,IBVAL("EDT")=(IBOPV2+.99)
 ; Must be a billable appt type and outpt enctr status of CHECKED OUT
 S IBFILTER=""
 S IBCBK="I '$P(Y0,U,6),$P(Y0,U,7),$$DSP^IBEFUNC($P(Y0,U,10),+Y0),'$D(^TMP(""IBVIS"",$J,+$P(Y0,U,5))) S ^TMP(""IBVIS"",$J,+$P(Y0,U,5))="""" D EXTPROC^IBCCPT(IBIFN,Y,Y0,.DGCNT)"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,IBCBK,0,.IBQUERY) K ^TMP("DIERR",$J)
 ;
 Q
EXTPROC(IBIFN,IBOE,IBOE0,IBCNT) ; Extract procedures for an encounter
 ; IBIFN = the ien of the bill
 ; IBOE0 = 0-node of the outpatient encounter file entry IBOE
 ; IBCNT  extracted entry counter
 N I2,I7,IBCPT,IBCPTS,IBDIV,IBOED,IBZERR,Z,IBCPTDAT,IBCPTPRV,IBCLINIC,IBZ,IBONBILL,IBMODS,IBARR,IBDT,DFN,IBEX,IBDX,IBOEDP
 ; make sure i have this variable
 S:$G(IBOE0)="" IBOE0=$$SCE^IBSDU(+IBOE)
 D GETCPT^SDOE(IBOE,"IBCPTS","IBZERR")
 Q:'$O(IBCPTS(0))  ;No procedures for this encounter
 I '$$BDSRC^IBEFUNC3($P($G(IBOE0),U,5)) Q  ; non-billable visit data source
 S IBOED=$$NBOE^IBCU81(IBOE,IBOE0)
 S I7=IBOE0\1,IBDIV=$P(IBOE0,U,11)
 S IBCLINIC="" I +$P(IBOE0,U,4),+$$CLNSCRN^IBCU(I7,+$P(IBOE0,U,4)) S IBCLINIC=+$P(IBOE0,U,4)
 S I2=0 F  S I2=$O(IBCPTS(I2)) Q:'I2  D
 . S IBCPT=$P(IBCPTS(I2),U)
 . S IBCPTPRV=$P($G(IBCPTS(I2,12)),U,4)
 . S IBONBILL=0 S IBZ=0 F  S IBZ=$O(^DGCR(399,IBIFN,"CP","B",IBCPT_";ICPT(",IBZ)) Q:'IBZ  I $P($G(^DGCR(399,IBIFN,"CP",IBZ,0)),U,2)=I7 S IBONBILL=1
 . S IBMODS="",IBZ=0 F  S IBZ=$O(IBCPTS(I2,1,IBZ)) Q:'IBZ  S IBMODS=IBMODS_$S(IBMODS="":"",1:",")_+$G(IBCPTS(I2,1,IBZ,0))
 . ;
 . ; look up of a procedure is non-billable and get assoc dx
 . S IBOEDP=IBOED I IBOEDP="" S IBOEDP=$$NBOEP^IBCCPT1(IBOE0,IBCPT,.IBDX) I IBOEDP'="" S IBOEDP=4_U_IBOEDP
 . S IBCPTDAT=IBCPT_U_I7_U_IBONBILL_U_0_U_IBDIV_U_$P(IBOEDP,U,1)_U_$P(IBOEDP,U,2)_U_IBCPTPRV_U_IBCLINIC_U_IBMODS_U_IBOE
 . F Z=1:1:$P(IBCPTS(I2),U,16) S IBCNT=IBCNT+1,^UTILITY($J,"CPT-CNT",IBCNT)=IBCPTDAT,^UTILITY($J,"CPT-CNT",IBCNT,"DX")=$G(IBDX)
 . K IBDX
 I $O(IBARR("CPT",0)),'$D(^UTILITY($J,"CPT",+IBOE0,0)) S ^(0)="Y"
 Q
 ;
TOMANY(DATE) ;  - returns 1 if more than 1 visit date on bill (for basc)
 G TOMANYQ:'$D(DATE)
 S DGVCNT=+$P($G(^DGCR(399,IBIFN,"OP",0)),"^",4)
 I DGVCNT>1!(DGVCNT=1&('$D(^DGCR(399,IBIFN,"OP",DATE)))) K DGVCNT Q 1
TOMANYQ Q 0
 ;
