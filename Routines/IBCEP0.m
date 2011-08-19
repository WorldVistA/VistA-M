IBCEP0 ;ALB/TMP - Functions for PROVIDER ID MAINTENANCE ;13-DEC-99
 ;;2.0;INTEGRATED BILLING;**137,191,239,232,320,348,349,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point for IBCE PRV INS ID
 N IBINS,IBDSP,IBSORT,IBPRV ; Variables should be available throughout actions
 K IBFASTXT
 D FULL^VALM1
 D EN^VALM("IBCE PRVINS ID")
 Q
 ;
EN1(IBINS) ; Entrypoint from insurance co maintenance
 N IBDSP,IBSORT ; Variables should be available throughout actions
 D FULL^VALM1
 D EN^VALM("IBCE PRVINS ID FROM INS MAINT")
 Q
 ;
HDR ; -- header code
 N Z,Z0,Z1,IBCT,IBPPTYP,IBEMCTYP
 S IBCT=1
 K VALMHDR
 I $G(IBINS) D
 . N PCF,PCDISP
 . S PCF=$P($G(^DIC(36,+IBINS,3)),U,13)
 . S PCDISP=$S(PCF="C":"(Child)",PCF="P":"(Parent)",1:"")
 . S VALMHDR(1)="Insurance Co: "_$P($G(^DIC(36,+IBINS,0)),U)_" "_PCDISP
 . ; Get performing provider id type for insurance co
 . S IBPPTYP=$$PPTYP(IBINS)
 . ; Get ien of EMC ID from file 355.97
 . S IBEMCTYP=+$$EMCID^IBCEP()
 . I $G(IBSORT)="ALL"!($G(IBDSP)="I")!($G(IBSORT)=IBPPTYP)!($G(IBSORT)=IBEMCTYP) D
 .. ; Look for care unit in either of these id types - if there, report on line 2 of header
 .. I $G(IBSORT)=IBPPTYP S IBEMCTYP=0
 .. I $G(IBSORT)=IBEMCTYP S IBPPTYP=0
 .. F Z0=IBPPTYP_"P",IBEMCTYP_"E" S Z1="" F  S Z1=$O(^IBA(355.96,"D",+IBINS,+Z0,Z1)) Q:Z1=""  I Z1'="*N/A*" S Z($E(Z0,$L(Z0)))=1 Q
 .. I $D(Z("P"))!$D(Z("E")) D
 ... S IBCT=IBCT+1
 ... S VALMHDR(IBCT)="  "_$S($D(Z("P")):"PERFORMING PROV ID"_$S($D(Z("E")):" AND ",1:""),1:"")_$S($D(Z("E")):"EMC PROV ID",1:"")_" MAY REQUIRE CARE UNIT"
 . I $D(Z("P"))!$D(Z("E")) S IBCT=IBCT+1,VALMHDR(IBCT)=" "
 . S IBCT=IBCT+1,VALMHDR(IBCT)="     PROVIDER "_$S($G(IBDSP)="I":"ID TYPE",1:"NAME   ")_$J("",6)_"FORM   CARE TYPE    CARE UNIT       ID#"
 Q
 ;
INIT ; Initialization
 K ^TMP("IB_EDITED_IDS",$J)  ; This will be to keep track of ID's edited during this session
 D INSID(.IBINS,.IBDSP,.IBSORT)
 I $G(IBDSP)="I",$G(IBSORT) S IBPRV=IBSORT
 I '$G(IBINS) S VALMQUIT=1
 Q
 ;
INSID(IBINS,IBDSP,IBSORT) ;
 N DIC,DIR,DA,X,Y,IBOK,DTOUT,DUOUT
 S IBOK=1
 I '$G(IBINS) D
 . S DIC(0)="AEMQ",DIC="^DIC(36," D ^DIC
 . I Y'>0 S IBOK=0 Q
 . S IBINS=+Y
 I '$G(IBINS) S IBOK=0
 I 'IBOK G INSIDQ
 ;
 S DIR(0)="SA^D:INSURANCE CO DEFAULT IDS;I:INDIVIDUAL PROVIDER IDS FURNISHED BY THE INS CO;A:ALL IDS FURNISHED BY THE INS CO BY PROVIDER TYPE"
 S DIR("A")="SELECT DISPLAY CONTENT: ",DIR("B")="A"
 S DIR("?",1)="(D) DISPLAY CONTAINS ONLY THOSE IDS ASSIGNED AS DEFAULTS TO THE FACILITY BY",DIR("?",2)="    THE INSURANCE COMPANY"
 S DIR("?",3)="(I) DISPLAY CONTAINS ONLY THOSE IDS ASSIGNED TO INDIVIDUAL PROVIDERS BY THE",DIR("?",4)="    INSURANCE COMPANY"
 S DIR("?",5)="(A) DISPLAY CONTAINS ALL IDS ASSIGNED BY THE INSURANCE COMPANY FOR ONE OR ALL",DIR("?")="    PROVIDER ID TYPES"
 W ! D ^DIR K DIR W !
 I $D(DTOUT)!$D(DUOUT)!("DIA"'[Y) S IBOK=0 G INSIDQ
 S IBDSP=Y,IBSORT=""
 I IBDSP="A"!(IBDSP="I") F  D  Q:'IBOK!(IBSORT'="")
 . ;
 . I IBDSP="A" D
 .. S DIR("A")="Display only IDs with a specific ID Qualifier?: "
 .. S DIR("?",1)="Answer Yes to select a specific ID Qualifier by which to display IDs."
 .. S DIR("?")="Answer No to display all IDs."
 .. Q
 . ;
 . I IBDSP="I" D
 .. S DIR("A")="Display IDs for a specific Provider?: "
 .. S DIR("?",1)="Answer Yes to select a specific Provider."
 .. S DIR("?")="Answer No to display all Providers."
 .. Q
 . ;
 . S DIR("B")="NO",DIR(0)="YA"
 . W ! D ^DIR K DIR W !
 . I $D(DTOUT)!$D(DUOUT) S IBOK=0 Q
 . I Y'=1 S IBSORT="ALL" Q
 . ;
 . I IBDSP="A" D  Q
 .. S DIC(0)="AEMQ",DIC="^IBE(355.97,",DIC("S")="I $S('$P(^(0),U,2):1,1:$P(^(0),U,2)=3)"
 .. S DIC("A")="Select type of ID Qualifier: "
 .. D ^DIC K DIC
 .. I Y>0 S IBSORT=+Y Q
 .. I $D(DTOUT)!$D(DUOUT) S IBOK=0
 . ;
 . I IBDSP="I" D  Q
 .. N DA
 .. S DIR(0)="399.0222,.02A",DIR("A")="SELECT PROVIDER: "
 .. W ! D ^DIR K DIR W !
 .. I Y>0 S IBSORT=Y Q
 .. I $D(DTOUT)!$D(DUOUT) S IBOK=0 Q
 . S IBOK=0 Q
 ;
 G:'IBOK INSIDQ
 D BLD(IBINS,IBDSP,IBSORT)
INSIDQ I 'IBOK S VALMQUIT=1
 Q
 ;
BLD(IBINS,IBDSP,IBSORT) ; Build display for Insurance co level provider ID's
 N IB,IBENT,IBLCT,IBCT,IBPRV,IBSRT1,IBSRT2,IBOSRT1,IBOSRT2,CU,FT,PT,CT,Z,Z0
 K ^TMP("IBPRV_INS_ID",$J),^TMP("IBPRV_INS_SORT",$J)
 ;
 S (IBENT,IBCT,IBLCT)=0
 ;
 I "DA"[$G(IBDSP) D
 . S CU="" F  S CU=$O(^IBA(355.91,"AUNIQ",IBINS,CU)) Q:CU=""  S FT="" F  S FT=$O(^IBA(355.91,"AUNIQ",IBINS,CU,FT)) Q:FT=""  D
 .. S CT="" F  S CT=$O(^IBA(355.91,"AUNIQ",IBINS,CU,FT,CT)) Q:CT=""  S PT=0 F  S PT=$S(IBDSP="A"&IBSORT:IBSORT,1:$O(^IBA(355.91,"AUNIQ",IBINS,CU,FT,CT,PT))) Q:'PT  D  Q:IBDSP="A"&IBSORT
 ... S Z=0 F  S Z=$O(^IBA(355.91,"AUNIQ",IBINS,CU,FT,CT,PT,Z)) Q:'Z  S IB=$G(^IBA(355.91,Z,0)) S ^TMP("IBPRV_INS_SORT",$J,PT,"^<<INS CO DEFAULT>>",FT,CT,CU,Z)=$P(IB,U,7)_U
 ;
 I "IA"[$G(IBDSP) D
 . S IBPRV=""
 . N IB1,IB2
 . F  S IBPRV=$O(^IBA(355.9,"AE",IBINS,IBPRV)) Q:'IBPRV  S Z=0 F  S Z=$O(^IBA(355.9,"AE",IBINS,IBPRV,Z)) Q:'Z  S IB=$G(^IBA(355.9,Z,0)) D
 .. Q:$P(IB,U,4)=""!($P(IB,U,5)="")!($P(IB,U,6)="")!($P(IB,U,16)="")
 .. I IBSORT,$S(IBDSP="I":IBPRV'=IBSORT,1:$P(IB,U,6)'=IBSORT) Q
 .. S IB1=$S(IBDSP="A":$P(IB,U,6),1:U_$$EXPAND^IBTRE(355.9,.01,IBPRV)_U_IBPRV)
 .. S IB2=$S(IBDSP="I":$P(IB,U,6),1:U_$$EXPAND^IBTRE(355.9,.01,IBPRV)_U_IBPRV)
 .. S ^TMP("IBPRV_INS_SORT",$J,IB1,IB2,$P(IB,U,4),$P(IB,U,5),$P(IB,U,16),Z)=$P(IB,U,7)_U_IBPRV
 ;
 S IBOSRT1=""
 S IBSRT1="" F  S IBSRT1=$O(^TMP("IBPRV_INS_SORT",$J,IBSRT1)) Q:IBSRT1=""  D
 . S IBSRT2="",IBOSRT2=""
 . F  S IBSRT2=$O(^TMP("IBPRV_INS_SORT",$J,IBSRT1,IBSRT2)) Q:IBSRT2=""  D
 .. I IBOSRT1'=IBSRT1 D
 ... I IBOSRT1'="" S IBLCT=IBLCT+1 D SET^VALM10(IBLCT," ",IBCT+1)
 ... S IBLCT=IBLCT+1 D SET^VALM10(IBLCT,$S(IBDSP'="I":"ID Qualifier",1:"Provider")_": "_$S(IBDSP'="I":$$EXPAND^IBTRE(355.91,.06,IBSRT1),1:$P(IBSRT1,U,2_$S($P(IBSRT2,U,3)["VA(200":" (VA)",1:"(NON-VA)"))),IBCT+1)
 ... S IBOSRT1=IBSRT1
 .. ;
 .. S FT="" F  S FT=$O(^TMP("IBPRV_INS_SORT",$J,IBSRT1,IBSRT2,FT)) Q:FT=""  S CT="" F  S CT=$O(^TMP("IBPRV_INS_SORT",$J,IBSRT1,IBSRT2,FT,CT)) Q:CT=""  D
 ... S CU="" F  S CU=$O(^TMP("IBPRV_INS_SORT",$J,IBSRT1,IBSRT2,FT,CT,CU)) Q:CU=""  S Z=0 F  S Z=$O(^TMP("IBPRV_INS_SORT",$J,IBSRT1,IBSRT2,FT,CT,CU,Z)) Q:'Z  S IB=$G(^(Z)) D
 .... S IBLCT=IBLCT+1,IBCT=IBCT+1
 .... S Z0=$E(IBCT_$J("",4),1,4)_" "
 .... I IBDSP'="I" S Z0=Z0_$E($S(IBOSRT2'=IBSRT2:$P(IBSRT2,U,2),1:"")_$J("",20),1,20)
 .... I IBDSP="I" S Z0=Z0_$E($S(IBOSRT2'=IBSRT2:$$EXPAND^IBTRE(355.9,.06,IBSRT2),1:"")_$J("",20),1,20)
 .... S IBOSRT2=IBSRT2
 .... S Z0=Z0_"  "_$S(FT=1:"UB-04",FT=2:"1500 ",1:"BOTH ")_"  "_$E($S(CT=3:"RX",CT=1:"INPT",CT=2:"OUTPT",1:"INPT/OUTPT")_$J("",11),1,11)_"  "_$E($S(CU'="*N/A*":$P($G(^IBA(355.95,+$P($G(^IBA(355.96,+CU,0)),U),0)),U),1:"")_$J("",15),1,15)
 .... D SET^VALM10(IBLCT,Z0_" "_$P(IB,U),IBCT)
 .... S ^TMP("IBPRV_INS_ID",$J,"ZIDX",IBCT)=Z,^(IBCT,"PRV")=$P(IB,U,2)
 .... I '$D(^TMP("IBPRV_INS_ID",$J,$S(IBDSP="I":"ZXPRV",1:"ZXPTYP"),IBSRT1)) S ^(IBSRT1)=IBLCT-1
 K ^TMP("IBPRV_INS_SORT",$J)
 ;
 I IBLCT=0 D  G BLDQ ; No entries found
 . D SET^VALM10(1," ")
 . S Z="  No "_$S(IBDSP="D":"default ",1:"")
 . S Z=Z_"ID's found for "_$S(IBDSP="I":"provider "_$S(IBSORT:"("_$$EXPAND^IBTRE(355.9,.01,IBSORT)_") ",1:"")_"and ",IBDSP="A":"provider type "_$S(IBSORT:"("_$$EXPAND^IBTRE(355.9,.06,IBSORT)_") ",1:"")_"and ",1:"")_"insurance co"
 . D SET^VALM10(2,Z)
 . S IBLCT=2
 ;
BLDQ S VALMCNT=IBLCT,VALMBG=1
 Q
 ;
EXPND ;
 Q
 ;
HELP ;
 Q
 ;
EXIT ;
 K IBFASTXT
 D COPYPROV^IBCEP5A(IBINS)
 K ^TMP("IBPRV_INS_ID",$J)
 D CLEAN^VALM10
 Q
 ;
SEL(IBDA,MANY) ; Select from provider id list
 ; IBDA is passed by reference and IBDA(1) returned containing
 ;  ien's of the provider id records selected (file 355.9).
 ; If > 1 entry can be selected, MANY is set to 1
 N Z
 S IBDA=0
 D EN^VALM2($G(XQORNOD(0)),$S($G(MANY):"",1:"S"))
 S Z=0 F  S Z=$O(VALMY(Z)) Q:'Z  S IBDA=IBDA+1,IBDA(IBDA)=+$G(^TMP("IBPRV_INS_ID",$J,"ZIDX",Z))_U_$G(^(Z,"PRV"))
 Q
 ;
ENX(IBINS1) ; Insurance co level defaults for all providers or
 ; for all providers by care unit
 N DIC,DIE,DR,DA,X,Y,DLAYGO
 I '$G(IBINS1) D  G:'$G(IBINS1) ENQ
 . S DIC="^IBA(355.91,",DIC(0)="AELMQ",DLAYGO=355.91 D ^DIC
 . I Y>0 S IBINS1=+Y
 S DIE="^IBA(355.91,",DA=IBINS1,DR=".01;.06;.04;.05;.03;.07" D ^DIE
 ;
ENQ Q
 ;
PPTYP(IBINS) ; Returns the ien of the default performing provider type for 
 ;  insurance company IBINS (ien file 36)
 Q +$G(^DIC(36,+IBINS,4))
 ;
SCREEN(WHICH) ; This screen is used the menu protocol to screen out the ID functions if it is a child ins co
 Q:'$G(DA) 0
 Q:'$G(DA(1)) 0
 N FILE,IENS,FIELD,FLAG,TARGET
 S FILE=101.01,IENS=DA_","_DA(1),FIELD=".01",FLAG="I"
 D GETS^DIQ(FILE,IENS,FIELD,FLAG,"TARGET")
 Q:'$D(TARGET) 0
 N IEN
 S IEN=$G(TARGET(FILE,IENS_",",FIELD,FLAG))
 Q:'+IEN 0
 S FILE=101,FIELD=1,FLAG="E"
 K TARGET
 D GETS^DIQ(FILE,IEN,FIELD,FLAG,"TARGET")
 Q:'$D(TARGET) 0
 I $G(TARGET(FILE,IEN_",",FIELD,FLAG))'[WHICH Q 1
 Q:'$G(IBINS) 0
 N PCF
 S PCF=$P($G(^DIC(36,+IBINS,3)),U,13)
 I PCF="C" Q 0
 Q 1
