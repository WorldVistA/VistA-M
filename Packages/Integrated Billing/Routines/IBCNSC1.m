IBCNSC1 ;ALB/NLR - IBCNS INSURANCE COMPANY ;23-MAR-93
 ;;2.0;INTEGRATED BILLING;**62,137,232,291,320,348,349,371,400,519,516,547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
% G EN^IBCNSC
 ;
AI ; -- (In)Activate Company
 D FULL^VALM1 W !!
 I '$D(^XUSEC("IB INSURANCE SUPERVISOR",DUZ)) D SORRY G EXIT
 D ^IBCNSC2
 G EXIT
CC ; -- Change Insurance Company
 D FULL^VALM1 W !!
 S IBCNS1=IBCNS K IBCNS D INSCO^IBCNSC
 I '$D(IBCNS) S IBCNS=IBCNS1
 K IBCNS1,VALMQUIT
 G EXIT
EA ; -- Billing,Claims,Appeals,Inquiry,Telephone,Main,Remarks,Synonyms
 D FULL^VALM1
 ;
 ; IB*2*320 - check key for associate company action
 I $G(IBY)=",13,",'$$KCHK^XUSRB("IB EDI INSURANCE EDIT") D  G EXIT
 . W !!?5,"You must hold the IB EDI INSURANCE EDIT key to access this option."
 . D PAUSE^VALM1
 . Q
 ;
 W !!
 D MAIN
 ;
 ; -- was company deleted
 I '$D(^DIC(36,IBCNS)) W !!,"<DELETED>",!! S VALMQUIT="" Q
 ;
EXIT ;
 D HDR^IBCNSC,BLD^IBCNSC
 S VALMBCK="R"
 Q
MAIN ; -- Call edit template
 N IBEDIKEY,Z
 L +^DIC(36,+IBCNS):5 I '$T D LOCKED^IBTRCD1 G MAINQ
 I $G(IBY)=",12," D FACID
 F Z=1,2,4,9,13,14 S IBEDIKEY(Z)=$P($G(^DIC(36,+IBCNS,3)),U,Z)   ; save EDI data fields
 F Z=1:1:8 S IBEDIKEY(Z,6)=$P($G(^DIC(36,+IBCNS,6)),U,Z)   ; save EDI data fields
 I $G(IBY)'=",12," N DIE,DA,DR S DIE="^DIC(36,",(DA,Y)=IBCNS,DR="[IBEDIT INS CO1]" D ^DIE K DIE S:$D(Y) IB("^")=1 D:$TR($P($G(^DIC(36,IBCNS,6)),U,1,8),U)]"" CUIDS(IBCNS)
 I $G(IBY)=",12," D EDITID^IBCEP(+IBCNS)
 I $F(",6,1,",$G(IBY)) D CLEANIDS^IBCNSC(+IBCNS)   ;clean up any errant nodes on alternate payert IDS
 I $F(",6,13,",$G(IBY)) D PARENT^IBCNSC02(+IBCNS)   ; parent/child management
 L -^DIC(36,+IBCNS)
 ; IB*2.0*519:  If field 3.02 or 3.04 has changed, trigger HL7 to update the NIF
 I (IBEDIKEY(2)'=$P($G(^DIC(36,+IBCNS,3)),U,2))!(IBEDIKEY(4)'=$P($G(^DIC(36,+IBCNS,3)),U,4)) D EXR^IBCNHUT1(IBCNS),SEND^IBCNHHLO(IBCNS)
MAINQ Q
 ;
FACID ; -- Edit facility ids
 D FACID^IBCEP2B(+IBCNS,"E")
 Q
 ;
SORRY ; -- can't inactivate, don't have key
 W !!,"You do not have access to Inactivate entries.  See your application coordinator.",! D PAUSE^VALM1
 Q
PRESCR ;
 N OFFSET,START,IBCNS18,IBADD
 ;
 ;WCJ;IB*2.0*547;Call New API
 ;S IBCNS18=$$ADDRESS^IBCNSC0(IBCNS,.18,11)
 S IBCNS18=$$ADD2^IBCNSC0(IBCNS,.18,11)
 ;
 ;WCJ;IB*2.0*547
 ;S START=41,OFFSET=2
 S START=42+(2*$G(IBACMAX)),OFFSET=2
 D SET^IBCNSP(START,OFFSET+19," Prescription Claims Office Information ",IORVON,IORVOFF)
 D SET^IBCNSP(START+1,OFFSET," Company Name: "_$P($G(^DIC(36,+$P(IBCNS18,"^",7),0)),"^",1))
 D SET^IBCNSP(START+2,OFFSET,"       Street: "_$P(IBCNS18,"^",1))
 D SET^IBCNSP(START+3,OFFSET,"     Street 2: "_$P(IBCNS18,"^",2))
 ; D SET^IBCNSP(START+4,OFFSET,"Claim Off. ID: "_$P(IBCNS18,"^",11))
 N OFFSET S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET,"     Street 3: "_$P(IBCNS18,"^",3)) S IBADD=1
 D SET^IBCNSP(START+1+IBADD,OFFSET,"   City/State: "_$E($P(IBCNS18,"^",4),1,15)_$S($P(IBCNS18,"^",4)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCNS18,"^",5),0)),"^",2)_" "_$E($P(IBCNS18,"^",6),1,5))
 D SET^IBCNSP(START+2+IBADD,OFFSET,"        Phone: "_$P(IBCNS18,"^",8))
 D SET^IBCNSP(START+3+IBADD,OFFSET,"          Fax: "_$P(IBCNS18,"^",9))
 Q
 ;
PROVID N OFFSET,START,IBCNS4,IBCNS3,IBDISP,Z,LINE
 S START=$O(^TMP("IBCNSC",$J,""),-1)+1
 S (IB1ST("PROVID"),LINE)=START
 S OFFSET=2,IBCNS4=$G(^DIC(36,IBCNS,4)),IBCNS3=$G(^(3))
 ;       
 D SET^IBCNSP(LINE,OFFSET+25,"Provider IDs",IORVON,IORVOFF)
 N OFFSET
 S LINE=LINE+1,OFFSET=1
 D SET^IBCNSP(LINE,OFFSET,"Billing Provider Secondary ID")
 ;
 N Z,Z0,Z1,IBS,I,DIV,FT,CU,CUF,DIVISION,FORMTYPE,PIDT
 S Z=0 F  S Z=$O(^IBA(355.92,"B",+IBCNS,Z)) Q:'Z  D
 . S Z0=$G(^IBA(355.92,Z,0))
 . Q:'$P(Z0,U,6)!($P(Z0,U,7)="")  ; Quit if no provider id or id type
 . Q:'($P(Z0,U,8)="E")
 . S IBS(+$P(Z0,U,5),+$P(Z0,U,3),+$P(Z0,U,4))=$P(Z0,U,6)_U_$P(Z0,U,7)
 ;
 S DIV="" F  S DIV=$O(IBS(DIV)) Q:DIV=""  D
 . S DIVISION=$$DIV^IBCEP7(DIV)
 . S CU="",CUF=0 F  S CU=$O(IBS(DIV,CU)) Q:CU=""  D
 .. S FT="" F  S FT=$O(IBS(DIV,CU,FT)) Q:FT=""  D
 ... S FORMTYPE=$S(FT=1:"UB-04",FT=2:"1500",1:"UNKNOWN")
 ... S LINE=LINE+1
 ... I 'CUF,+CU S CUF=1 S TEXT=$P(DIVISION,"/")_" Care Units :",OFFSET=5 D SET^IBCNSP(LINE,OFFSET,TEXT) S LINE=LINE+1
 ... I CU=0 S TEXT=DIVISION_"/"_FORMTYPE_": "_$$GET1^DIQ(355.97,$P(IBS(DIV,CU,FT),U),.03,"E")_" "_$P(IBS(DIV,CU,FT),U,2),OFFSET=2
 ... I +CU S TEXT=$$EXPAND^IBTRE(355.92,.03,CU)_"/"_FORMTYPE_": "_$$GET1^DIQ(355.97,$P(IBS(DIV,CU,FT),U),.03,"E")_" "_$P(IBS(DIV,CU,FT),U,2),OFFSET=5
 ... D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 S LINE=LINE+1 D SET^IBCNSP(LINE,2," ")
 ;
 K IBS
 S OFFSET=1,LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,"Additional Billing Provider Secondary IDs")
 S Z=0 F  S Z=$O(^IBA(355.92,"B",+IBCNS,Z)) Q:'Z  D
 . S Z0=$G(^IBA(355.92,Z,0))
 . Q:'$P(Z0,U,6)!($P(Z0,U,7)="")  ; Quit if no provider id or id type
 . Q:'($P(Z0,U,8)="A")
 . ; IBS(DIVISION,FORMTYPE,IDTYPE)=ID
 . S IBS(+$P(Z0,U,5),+$P(Z0,U,4),+$P(Z0,U,6))=$P(Z0,U,7)
 ;
 S DIVISION=$$DIV^IBCEP7(0)
 S DIV="" F  S DIV=$O(IBS(DIV)) Q:DIV=""  D
 . S FT="" F  S FT=$O(IBS(DIV,FT)) Q:FT=""  D
 .. S FORMTYPE=$S(FT=1:"UB-04",FT=2:"1500",1:"UNKNOWN")
 .. S TEXT=DIVISION_"/"_FORMTYPE_": "
 .. S LINE=LINE+1,OFFSET=2
 .. D SET^IBCNSP(LINE,OFFSET,TEXT)
 .. S PIDT="" F  S PIDT=$O(IBS(DIV,FT,PIDT)) Q:PIDT=""  D
 ... S LINE=LINE+1
 ... S TEXT=$$GET1^DIQ(355.97,PIDT,.03,"E")_" "_IBS(DIV,FT,PIDT),OFFSET=5
 ... D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 S LINE=LINE+1 D SET^IBCNSP(LINE,2," ")
 ;
 K IBS
 S OFFSET=1,LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,"VA-Laboratory or Facility Secondary IDs")
 S Z=0 F  S Z=$O(^IBA(355.92,"B",+IBCNS,Z)) Q:'Z  D
 . S Z0=$G(^IBA(355.92,Z,0))
 . Q:'$P(Z0,U,6)!($P(Z0,U,7)="")  ; Quit if no provider id or id type
 . Q:'($P(Z0,U,8)="LF")
 . ; IBS(DIVISION,FORMTYPE,IDTYPE)=ID
 . S IBS(+$P(Z0,U,5),+$P(Z0,U,4),+$P(Z0,U,6))=$P(Z0,U,7)
 ;
 S DIVISION=$$DIV^IBCEP7(0)
 S DIV="" F  S DIV=$O(IBS(DIV)) Q:DIV=""  D
 . S FT="" F  S FT=$O(IBS(DIV,FT)) Q:FT=""  D
 .. S FORMTYPE=$S(FT=1:"UB-04",FT=2:"1500",1:"UNKNOWN")
 .. S TEXT=DIVISION_"/"_FORMTYPE_": "
 .. S LINE=LINE+1,OFFSET=2
 .. D SET^IBCNSP(LINE,OFFSET,TEXT)
 .. S PIDT="" F  S PIDT=$O(IBS(DIV,FT,PIDT)) Q:PIDT=""  D
 ... S LINE=LINE+1
 ... ;S TEXT=$$EXPAND^IBTRE(355.92,.06,PIDT)_" "_IBS(DIV,FT,PIDT),OFFSET=5
 ... S TEXT=$$GET1^DIQ(355.97,PIDT,.03,"E")_" "_IBS(DIV,FT,PIDT),OFFSET=5
 ... D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 ;
 S LINE=LINE+1 D SET^IBCNSP(LINE,2," ")
 S LINE=LINE+1 D SET^IBCNSP(LINE,2," ")
 S OFFSET=2
 S LINE=LINE+1 D SET^IBCNSP(LINE,OFFSET+25,"ID Parameters",IORVON,IORVOFF)
 ;
 S IBCNS4=$G(^DIC(36,IBCNS,4)),IBCNS3=$G(^(3)),OFFSET=1
 S TEXT="Attending/Rendering Provider Secondary ID Qualifier (1500): "_$$EXPAND^IBTRE(36,4.01,+$P(IBCNS4,U))
 S LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 S TEXT="Attending/Rendering Provider Secondary ID Qualifier (UB-04): "_$$EXPAND^IBTRE(36,4.02,+$P(IBCNS4,U,2))
 S LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 S TEXT="Attending/Rendering Secondary ID Requirement: "_$$EXPAND^IBTRE(36,4.03,+$P(IBCNS4,U,3))
 S LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 S TEXT="Referring Provider Secondary ID Qualifier (1500): "_$$EXPAND^IBTRE(36,4.04,+$P(IBCNS4,U,4))
 S LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 S TEXT="Referring Provider Secondary ID Requirement: "_$$EXPAND^IBTRE(36,4.05,+$P(IBCNS4,U,5))
 S LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 S TEXT="Use Att/Rend ID as Billing Provider Sec. ID (1500): "_$$EXPAND^IBTRE(36,4.06,+$P(IBCNS4,U,6))
 S LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 S TEXT="Use Att/Rend ID as Billing Provider Sec. ID (UB-04): "_$$EXPAND^IBTRE(36,4.08,+$P(IBCNS4,U,8))
 S LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 ; MRD;IB*2.0*516 - Marked fields 4.07, 4.11, 4.12 and 4.13 for
 ; deletion and removed all references to them.
 ;S TEXT="Always use main VAMC as Billing Provider (1500)?: "_$$EXPAND^IBTRE(36,4.11,+$P(IBCNS4,U,11))
 ;S LINE=LINE+1
 ;D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 ;S TEXT="Always use main VAMC as Billing Provider (UB-04)?: "_$$EXPAND^IBTRE(36,4.12,+$P(IBCNS4,U,12))
 ;S LINE=LINE+1
 ;D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 ;I $P(IBCNS4,U,11)!($P(IBCNS4,U,12)) D
 ;.S TEXT="Send VA Lab/Facility IDs or Facility Data for VAMC?: "_$$EXPAND^IBTRE(36,4.07,+$P(IBCNS4,U,7))
 ;.S LINE=LINE+1
 ;.D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;.;
 ;.S TEXT="Use the Billing Provider (VAMC) Name and Street Address?: "_$$EXPAND^IBTRE(36,4.13,+$P(IBCNS4,U,13))
 ;.S LINE=LINE+1
 ;.D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;.Q
 ;
 S TEXT="Transmit no Billing Provider Sec. ID for the Electronic Plan Types: "
 S LINE=LINE+1
 D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 N TAR,ERR,IBCT
 D LIST^DIC(36.013,","_IBCNS_",",".01",,10,,,,,,"TAR","ERR")
 F IBCT=1:1:+$G(TAR("DILIST",0)) D
 . S TEXT=TAR("DILIST",1,IBCT)
 . S LINE=LINE+1
 . D SET^IBCNSP(LINE,OFFSET,TEXT)
 ;
 S LINE=LINE+1 D SET^IBCNSP(LINE,2," ")
 S LINE=LINE+1 D SET^IBCNSP(LINE,2," ")
 Q
 ;       
INSDEF(IBINS,IBPTYP) ; Returns the default id # for an ins co, if possible
 N X
 S X=""
 I IBINS,IBPTYP S X=$P($G(^IBA(355.91,+$O(^IBA(355.91,"AC",IBINS,IBPTYP,"*N/A*","")),0)),U,7)
 Q X
 ;
CUIDS(IBCNS) ;
 N DIE,DA,DR,PIECE,DAT6,Y
 S DAT6=$P(^DIC(36,IBCNS,6),U,1,8) ; get the Payer IDs
 ;
 ; Make sure each qualifier has an ID and vice versa
 F PIECE=1,3,5,7 D
 . I $TR($P(DAT6,U,PIECE,PIECE+1),U)="" Q  ; both blank
 . I $P(DAT6,U,PIECE)]"",$P(DAT6,U,PIECE+1)]"" Q  ; both have data
 . S DIE="^DIC(36,",(DA,Y)=IBCNS,DR="6.0"_$S($P(DAT6,U,PIECE)]"":PIECE,1:PIECE+1)_"////@"
 . D ^DIE K DIE
 ;
 S DAT6=$P($G(^DIC(36,IBCNS,6)),U,1,8) ; get the Payer IDs again since they may have changed above.
 ;
 ; Make sure the first pair of ID/Qual are populated if the 2nd pair is.  If not, move em over.
 ; This is done for institutional then professional
 F PIECE=1,5 D
 . I $P(DAT6,U,PIECE)]"" Q  ; already has set one
 . I $P(DAT6,U,PIECE+2)="" Q  ; has no second set
 . S DIE="^DIC(36,",(DA,Y)=IBCNS
 . ; deleting the qualifier triggers deletion of the ID
 . S DR="6.0"_PIECE_"////"_$P(DAT6,U,PIECE+2)_";6.0"_(PIECE+1)_"////"_$P(DAT6,U,PIECE+3)_";6.0"_(PIECE+2)_"////@"
 . D ^DIE K DIE
 Q
