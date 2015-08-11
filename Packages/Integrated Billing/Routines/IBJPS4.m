IBJPS4 ;BP/YMG - IB Site Parameters, Pay-To Provider Associations ;06-Nov-2008
 ;;2.0;INTEGRATED BILLING;**400,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MRD;IB*2.0*516 - Added logic pertaining to TRICARE-Specific Pay-To
 ; Providers, which entailed adding the parameter IBTCFLAG to many
 ; procedures here and in ^IBJPS3.
 ;
EN(IBTCFLAG) ; -- main entry point for IBJP IB PAY-TO ASSOCIATIONS
 ; select pay-to provider
 D EN^VALM("IBJP IB "_$S(IBTCFLAG:"TRICARE PAY-TO ASSOCS",1:"PAY-TO ASSOCIATIONS"))
 S VALMBCK="R"
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=""
 Q
 ;
INIT(IBTCFLAG) ; -- init variables and list array
 N DFLT,HASDIVS,IBCNT,IBLN,IBSTR,IEN4,PIEN,PROVS
 S DFLT=$$GETDFLT^IBJPS3(IBTCFLAG) D BLD(DFLT,.PROVS,IBTCFLAG)
 I $D(PROVS) D
 .; create listman array
 .S (IBCNT,IBLN)=0 S PIEN="" F  S PIEN=$O(PROVS(PIEN)) Q:PIEN=""  D
 ..S IBLN=IBLN+1
 ..S IBSTR=$$SETSTR^VALM1(PROVS(PIEN)_$S($$ISDFLT^IBJPS3(PIEN,IBTCFLAG):"  (Default)",1:""),"",2,75)
 ..D SET^VALM10(IBLN,IBSTR)
 ..S HASDIVS=0,IEN4="" F  S IEN4=$O(PROVS(PIEN,IEN4)) Q:IEN4=""  D
 ...S IBLN=IBLN+1,IBCNT=IBCNT+1 S:'HASDIVS HASDIVS=1
 ...S IBSTR=$$SETSTR^VALM1(IBCNT,"",8,4)
 ...S IBSTR=$$SETSTR^VALM1($P(PROVS(PIEN,IEN4),U,2),IBSTR,14,8)
 ...S IBSTR=$$SETSTR^VALM1($P(PROVS(PIEN,IEN4),U),IBSTR,24,55)
 ...D SET^VALM10(IBLN,IBSTR)
 ...S @VALMAR@("ZIDX",IBCNT,IEN4)=""
 ...Q
 ..I 'HASDIVS S IBSTR=$$SETSTR^VALM1("No Divisions found.","",8,45) S IBLN=IBLN+1 D SET^VALM10(IBLN,IBSTR)
 ..S IBLN=IBLN+1 D SET^VALM10(IBLN,"")
 ..Q
 .Q
 I 'DFLT S IBLN=$$SET^IBJPS3(0,$$SETSTR^VALM1("No Default "_$S(IBTCFLAG:"TRICARE ",1:"")_"Pay-To Provider found.","",11,42))
 I DFLT,'$D(PROVS) S IBLN=$$SET^IBJPS3(0,$$SETSTR^VALM1("No "_$S(IBTCFLAG:"TRICARE ",1:"")_"Pay-To Providers found.","",15,35))
 S VALMCNT=IBLN,VALMBG=1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD(DFLT,PROVS,IBTCFLAG) ; build array of pay-to providers and divisions
 N ALLDIVS,DIEN,DIVDATA,I,IB0,IEN4,PIEN,IBNODE
 I DFLT'>0 Q
 S IBNODE=$$NODE(IBTCFLAG)
 ;
 ; create list of all pay-to providers
 S I=0 F  S I=$O(^IBE(350.9,1,IBNODE,I)) Q:'I  D
 .S IB0=$G(^IBE(350.9,1,IBNODE,I,0)) I 'IB0 Q
 .I $P(IB0,U,5)="" S PROVS(I)=$P(IB0,U,2)
 .Q
 I $D(PROVS) D
 .; add divisions to the list
 .D LIST^DIC(40.8,,"@;.01;.07I","PQ",,,,,,,"ALLDIVS")
 .I $D(ALLDIVS) S I=0 F  S I=$O(ALLDIVS("DILIST",I)) Q:I=""  D
 ..; make sure that we have a file 4 ien to work with
 ..S DIVDATA=$G(ALLDIVS("DILIST",I,0)),IEN4=$P(DIVDATA,U,3) I IEN4="" Q
 ..S DIEN=$O(^IBE(350.9,1,IBNODE,"B",IEN4,""))
 ..; if there is an entry in 350.9 for this division, get corresponding pay-to provider
 ..; otherwise, use default pay-to provider 
 ..S PIEN=$S(DIEN:$$GETPROV(DIEN,IBTCFLAG),1:DFLT)
 ..; add this division to the list as division name ^ station number
 ..S PROVS(PIEN,IEN4)=$P(DIVDATA,U,2)_U_$$GET1^DIQ(4,IEN4,99)
 ..Q
 .Q
 D CLEAN^DILF
 Q
 ;
SEL() ; select division
 ; returns ien of selected division, or 0 if nothing is selected
 N DIR,IEN,MAX,X,Y
 S IEN=0,MAX=+$O(@VALMAR@("ZIDX",""),-1)
 I MAX>0 D
 .S:MAX=1 Y=1 I MAX>1 S DIR("A")="Select Division (1-"_MAX_"): ",DIR(0)="NA^"_1_":"_MAX_":0" D ^DIR
 .S:+Y>0 IEN=$O(@VALMAR@("ZIDX",Y,""))
 .Q
 Q +IEN
 ;
DIVADD(IBTCFLAG) ; associate division with a pay-to provider
 N DA,DFLT,DIC,DIE,DIEN,DIR,DNAME,DR,IEN4,IEN19,Y,IBNODE
 S IBNODE=$$NODE(IBTCFLAG)
 ;
 D FULL^VALM1
 S VALMBCK="R"
 S IEN4=$$SEL I IEN4>0 D
 .S IEN19=$O(^IBE(350.9,1,IBNODE,"B",IEN4,"")) I IEN19="" D
 ..; create a new entry in 350.9
 ..S DIEN=$$FIND1^DIC(40.8,,"QX",IEN4,"AD") I 'DIEN Q
 ..S DNAME=$$GET1^DIQ(40.8,DIEN,.01),DFLT=$$GETDFLT^IBJPS3(IBTCFLAG) I 'DFLT Q
 ..I IEN4=+$G(^IBE(350.9,1,IBNODE,DFLT,0)) D ERR Q
 ..S DIC="^IBE(350.9,1,"_IBNODE_",",DIC(0)="L",DIC("DR")=".02////"_DNAME_";.05////"_DFLT,X=IEN4,DLAYGO=350.9,DA(1)=1
 ..K DD,DO D FILE^DICN I +Y>0 S IEN19=+Y
 ..K DIC,DD,DO,DLAYGO
 ..Q
 .I +IEN19>0 D
 ..I $P($G(^IBE(350.9,1,IBNODE,IEN19,0)),U,5)="" D ERR Q
 ..S DIR(0)="P^IBE(350.9,1,"_IBNODE_",:M",DIR("S")="I $P(^(0),U,5)="""""
 ..S DA(1)=1,DIR("A")="Select "_$S(IBTCFLAG:"TRICARE ",1:"")_"Pay-To Provider"
 ..D ^DIR
 ..I +Y>0 S DIE="^IBE(350.9,1,"_IBNODE_",",DA=IEN19,DA(1)=1,DR=".05////"_+Y D ^DIE
 .Q
 D CLEAN^VALM10,CLEAN^DILF,INIT(IBTCFLAG)
 Q
 ;
ERR ;
 N DIR
 S DIR("A",1)="A division used as a Pay-to Provider can not be associated"
 S DIR("A",2)="with another Pay-to Provider."
 S DIR("A")="Press RETURN to continue: "
 S DIR(0)="EA" D ^DIR
 Q
 ;
GETPROV(PIEN,IBTCFLAG) ; return pay-to provider ien for a given division, or 0 if provider can't be found
 ; PIEN has to be a valid ien in pay-to providers sub-file
 ;
 N PRVZ,NXTPIEN,OUT,IBNODE
 S PRVZ(PIEN)="" ; this array holds ien's to prevent infinite chain
 S IBNODE=$$NODE(IBTCFLAG)
 S OUT=0 F  S NXTPIEN=+$P($G(^IBE(350.9,1,IBNODE,PIEN,0)),U,5) D  Q:OUT  ;
 .I 'NXTPIEN S OUT=1 Q  ; no parent - this is pay-to provider
 .I $D(PRVZ(NXTPIEN)) S PIEN=0,OUT=1 Q  ; we are in an infinite loop, so get out
 .S PIEN=NXTPIEN,PRVZ(NXTPIEN)="" ; parent exists, so continue the loop
 .Q
 Q PIEN
 ;
GETDIVS(PIEN,DIVS,IBTCFLAG) ; return array of divisions associated with pay-to provider PIEN
 N I,DIV,PPROV,IBNODE
 S IBNODE=$$NODE(IBTCFLAG)
 S I="" F  S I=$O(^IBE(350.9,1,IBNODE,"B",I)) Q:I=""  D
 .S DIV=$O(^IBE(350.9,1,IBNODE,"B",I,""))
 .Q:+DIV'>0  S PPROV=$$GETPROV(DIV,IBTCFLAG)
 .I PPROV=PIEN,DIV'=PIEN S DIVS(DIV)=$P($G(^IBE(350.9,1,IBNODE,DIV,0)),U,2)
 .Q
 Q
 ;
NODE(IBTCFLAG) ; Determine appropriate pay-to provide node within ^IBE(350.9).
 ; '29' for TRICARE, otherwise '19'.
 Q $S(IBTCFLAG:29,1:19)
 ;
SCRN4(IEN) ; Screen for INSTITUTION(#4) file
 N DIERR,IENS,FIELDS,Z,ZERR
 S IENS=+IEN_",",FIELDS="11;13;101"
 D GETS^DIQ(4,IENS,FIELDS,"IE","Z","ZERR")
 I $D(DIERR) Q 0
 ;Check to see if National
 I Z(4,IENS,11,"I")'="N" Q 0
 ;Check to see if Inactive
 I Z(4,IENS,101,"I") Q 0
 ;Check to see if Pharmacy
 I "^PHARM^CMOP^MSN^"[(U_Z(4,IENS,13,"E")_U) Q 0
 ;Default
 Q 1
 ;
TRICARE(IBIFN) ; Determine whether this bill/claim is TRICARE or not.
 ; Return '1' if TRICARE, '0' if not.  There are two rate types that
 ; should return '1': TRICARE and TRICARE REIMB. INS.
 ;
 I '$G(IBIFN) Q 0
 N IBRATE
 S IBRATE=$P(^DGCR(399,IBIFN,0),U,7)
 I 'IBRATE Q 0
 I $P($G(^DGCR(399.3,IBRATE,0)),U)'["TRICARE" Q 0
 ;
 ; At this point, the claim has a rate type of TRICARE or TRICARE
 ; REIMB. INS.  However, quit with a '1' only if a default TRICARE-
 ; specific pay-to provider is defined. Otherwise, quit with a '0'.
 ;
 I $$GETDFLT^IBJPS3(1) Q 1
 Q 0
