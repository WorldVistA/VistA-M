IBCNSC0 ;ALB/NLR - INSURANCE COMPANY EDIT - ; 12-MAR-1993
 ;;2.0;INTEGRATED BILLING;**371,547,592,702**;21-MAR-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
CLAIMS1 ; display Inpatient Claims information
 N OFFSET,START,IBCNS12,IBADD
 ;WCJ;IB*2.0*547
 ;S START=27,OFFSET=2
 S START=28+(2*$G(IBACMAX)),OFFSET=2
CLMS1AD ; KDM US2487 IB*2.0*592  call in tag from IBCNSI 
 D SET^IBCNSP(START,OFFSET+20," Inpatient Claims Office Information ",IORVON,IORVOFF)
 ;
 ;WCJ;IB*2.0*547;Call New API
 ;S IBCNS12=$$ADDRESS(IBCNS,.12,5)
 S IBCNS12=$$ADD2(IBCNS,.12,5)
 ;
 D SET^IBCNSP(START+1,OFFSET," Company Name: "_$P($G(^DIC(36,+$P(IBCNS12,"^",7),0)),"^",1))
 D SET^IBCNSP(START+2,OFFSET,"       Street: "_$P(IBCNS12,"^",1))
 D SET^IBCNSP(START+3,OFFSET,"     Street 2: "_$P(IBCNS12,"^",2))
 N OFFSET S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET,"     Street 3: "_$P(IBCNS12,"^",3)) S IBADD=1
 D SET^IBCNSP(START+1+IBADD,OFFSET,"   City/State: "_$E($P(IBCNS12,"^",4),1,15)_$S($P(IBCNS12,"^",4)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCNS12,"^",5),0)),"^",2)_" "_$E($P(IBCNS12,"^",6),1,5))
 D SET^IBCNSP(START+2+IBADD,OFFSET,"        Phone: "_$P(IBCNS12,"^",8))
 D SET^IBCNSP(START+3+IBADD,OFFSET,"          Fax: "_$P(IBCNS12,"^",9))
 Q
 ;
R1Q Q
CLAIMS2 ; display Outpatient Claims information
 ;
 N OFFSET,START,IBCNS16,IBADD
 ;WCJ;IB*2.0*547
 ;S START=34,OFFSET=2
 S START=35+(2*$G(IBACMAX)),OFFSET=2
CLMS2AD ; KDM US2487 IB*2.0*592  call in tag from IBCNSI
 D SET^IBCNSP(START,OFFSET+20," Outpatient Claims Office Information ",IORVON,IORVOFF)
 ;
 ;WCJ;IB*2.0*547;Call New API
 ;S IBCNS16=$$ADDRESS(IBCNS,.16,6)
 S IBCNS16=$$ADD2(IBCNS,.16,6)
 ;
 D SET^IBCNSP(START+1,OFFSET," Company Name: "_$P($G(^DIC(36,+$P(IBCNS16,"^",7),0)),"^",1))
 D SET^IBCNSP(START+2,OFFSET,"       Street: "_$P(IBCNS16,"^",1))
 D SET^IBCNSP(START+3,OFFSET,"     Street 2: "_$P(IBCNS16,"^",2))
 N OFFSET S OFFSET=45
 D SET^IBCNSP(START+1,OFFSET,"     Street 3: "_$P(IBCNS16,"^",3)) S IBADD=1
 D SET^IBCNSP(START+1+IBADD,OFFSET,"   City/State: "_$E($P(IBCNS16,"^",4),1,15)_$S($P(IBCNS16,"^",4)="":"",1:", ")_$P($G(^DIC(5,+$P(IBCNS16,"^",5),0)),"^",2)_" "_$E($P(IBCNS16,"^",6),1,5))
 D SET^IBCNSP(START+2+IBADD,OFFSET,"        Phone: "_$P(IBCNS16,"^",8))
 D SET^IBCNSP(START+3+IBADD,OFFSET,"          Fax: "_$P(IBCNS16,"^",9))
 Q
 ;
 ; Only adding comments on patch 547.  Changes are on the ADD2 tag below.
 ; This tag is called from the Output formatter.
 ; It returns a "complete" address
 ; It judges an address complete if it has a state (don't ask why, I am just adding the comments)
 ; If the address it wants is not complete, it returns the main address.
 ; These addresses go out on claims and claims (X12 837) don't like partial addresses.
ADDRESS(INS,NODE,PH) ; -- generic find address
 ;
 N IBX,INSSAVE,IBPH,IBFX,IBCNT,IBA
 S IBX="" ;S IBPH="",IBFX="",IBA=""
 ;
REDO ; gather insurance carrier's main address information 
 S IBX=$G(^DIC(36,+INS,.11)),IBPH=$P($G(^DIC(36,+INS,.13)),"^",1),IBFX=$P(IBX,"^",9)
 ;S IBCNT=$G(IBCNT)+1
 ;
 ; -- if process the same co. more than once you are in an infinite loop
 ;I $D(IBCNT(IBCNS)) G ADDREQ
 ;S IBCNT(IBCNS)=""
 ;
 ; -- gather address information from specific office (Claims, Appeals, Inquiry, Dental)
 ;JWS;IB*2.0*592;Changed below for DENTAL insurance mailing address
 ;IA #5292
 I $P($G(^DIC(36,+INS,+NODE)),"^",5) D
 . S IBX=$G(^DIC(36,+INS,+NODE))
 . I +NODE=.19 S IBPH=$P(IBX,"^",PH)
 . E  S IBPH=$P($G(^DIC(36,+INS,.13)),"^",PH)
 . S IBFX=$P($G(IBX),"^",9)
 I $P($G(^DIC(36,+INS,+NODE)),"^",7) S INSSAVE=INS,INS=$P($G(^DIC(36,+INS,+NODE)),"^",7) I INSSAVE'=INS G REDO
 ;
ADDRESQ ; concatenate company name, address, phone and fax 
 S $P(IBA,"^",1,6)=$P($G(IBX),"^",1,6)
 S $P(IBA,"^",7)=INS
 S $P(IBA,"^",8)=IBPH
 S $P(IBA,"^",9)=IBFX
ADDREQ Q IBA
 ;
 ; WCJ;IB*2.0*547;
 ; This is a new tag which is just called from the insurance company editor screens.
 ; The billers/insurance verifiers want to see what data is actually in the insurance company file.
 ; They don't care if it's complete.  Heck, a phone number may be enough.
 ; This will just return what is in the file for the ins company that handles that type of claims.
 ; Input: INS - IREN to file 36
 ;        NODE - Node in File 36 (corresponds to Claims, Appeals, Inquiry...)
 ;        PH - Location of Phone number in node .13
ADD2(INS,NODE,PH) ;
 N IBX,INSSAVE,IBFX,IBPH,IBA
 F  S IBX=$G(^DIC(36,+INS,+NODE)) Q:'$P(IBX,U,7)  S INSSAVE=INS,INS=$P(IBX,U,7) Q:INSSAVE=INS
 ; concatenate company name, address, phone and fax  
 S IBPH=$P($G(^DIC(36,+INS,.13)),U,PH),IBFX=$P(IBX,U,9)
 ;JWS;IB*2.0*592;Dental mailing address
 ;IA# 5292
 I +NODE=.19 S IBPH=$P($G(^DIC(36,+INS,.19)),U,11)
 S $P(IBA,U,1,6)=$P(IBX,U,1,6),$P(IBA,U,7)=INS,$P(IBA,U,8)=IBPH,$P(IBA,U,9)=IBFX
 Q IBA
 ;
 ;IB*2.0*702/ckb - the following code is called by the Input Template, IBEDIT
 ;  INS CO1. It will prompt for 3 Filing Time Frame (FTF) fields that are stored
 ;  in File #36. The fields are .12 FILING TIME FRAME, .18 STANDARD FTF and
 ;  .19 STANDARD FTF VALUE
 ;
FTF(IBIEN,IBEXIT) ; Edit Filing Time Frame fields
 ; Input:  IBIEN - IEN of the entry being checked
 ;        IBEXIT - 0 default value from input template
 ; Returns: 1 - if user entered '^' to exit for any of the FTF fields
 N DELETE,DIC,DIR,DIRUT,IB12,IB12PRE,IB18,IB18PE,IB18PRE,IB19,IB19PRE
 N IBFLG12,IBFLG18,IBFLG19,IBGARR,IBGCT,IBIENS,IBSKIP,U,X,Y
 ;
 S IBIENS=IBIEN_","
 ;
 ; Capture the value of the FTF fields before any edits
 S IB18PE=$$GET1^DIQ(36,IBIENS,.18),IB18PRE=$$GET1^DIQ(36,IBIENS,.18,"I")
 S IB19PRE=$$GET1^DIQ(36,IBIENS,.19)
 S IB12PRE=$$GET1^DIQ(36,IBIENS,.12)
 ;
 S (IBFLG18,IBFLG19,IBFLG12,IBSKIP)=0
 S (IB18,IB19,IB12)=""
 ;
 ;Prompt for field .18
 D PFLD18
 I X="^" S IBEXIT=1 G CHECK
 ; If field .18 was deleted or has no value (IBSKIP=1),
 ; DO NOT prompt for field .19, go to prompt for field .12
 I IBSKIP=1 G P12
 ;
 ;Prompt for field .19
 D PFLD19
 I X="^" S IBEXIT=1 G CHECK
 ;
P12 ;Prompt for field .12
 D PFLD12
 I X="^" S IBEXIT=1 G CHECK
 ;
CHECK ;
 ; If NONE of the 3 fields were updated, quit
 I 'IBFLG12&'IBFLG18&'IBFLG19 G QUIT
 ;
 ; Add updated FTF fields to Insurance Co in File #36
 D UPDINS
 ; Get count of all Active group plans, if none were found quit
 D GETGRP
 I IBGCT=0 G QUIT  ; in no active grps don't continue with 'Are you sure' prompts
 ;
 ;Ask user if they want to change the FTF fields for all ACTIVE group plans
 ; default is NO
 W !
 K DIR,DIRUT,X,Y
 S DIR(0)="Y"
 S DIR("A",1)="Do you want to change the Filing Time Frame for all"
 S DIR("A")="ACTIVE group plans ("_IBGCT_" Groups)"
 S DIR("B")="NO"
 S DIR("?",1)="Answering YES will change the Filing Time Frame for all ACTIVE"
 S DIR("?",2)="group plans for this insurance company. This does not affect"
 S DIR("?",3)="individual plans. Inaccurate Filing Time Frames can negatively"
 S DIR("?",4)="impact billing. Answering NO will not affect the current values"
 S DIR("?")="of the Filing Time Frame for any group plans."
 D ^DIR
 I X="^" S IBEXIT=1 G QUIT
 I $D(DIRUT)!(Y=0) G QUIT
 ;
 ;If YES above, display values of FTF fields and prompt "Are you sure....?"
 ; default is NO
 W !!,"The Filing Time Frame for all ACTIVE group plans will be changed to:"
 W !,"      STANDARD FILING TIME FRAME: ",$S(IB18="@":"<deleted>",1:$$GET1^DIQ(36,IBIENS,.18))
 W !,"STANDARD FILING TIME FRAME VALUE: ",$S(IB19="@":"<deleted>",1:$$GET1^DIQ(36,IBIENS,.19))
 W !,"               FILING TIME FRAME: ",$S(IB12="@":"<deleted>",1:$$GET1^DIQ(36,IBIENS,.12))
 W !
 K DIR,DIRUT,X,Y
 S DIR(0)="Y"
 S DIR("A",1)="Are you sure you would like to change the Filing Time"
 S DIR("A")="Frame for all ACTIVE group plans"
 S DIR("B")="NO"
 S DIR("?",1)="Answering YES will change the Filing Time Frame for all ACTIVE"
 S DIR("?",2)="group plans for this insurance company. This does not affect"
 S DIR("?",3)="individual plans. Inaccurate Filing Time Frames can negatively"
 S DIR("?",4)="impact billing. Answering NO will not affect the current values"
 S DIR("?")="of the Filing Time Frame for any group plans."
 D ^DIR
 I X="^" S IBEXIT=1 G QUIT
 I $D(DIRUT)!(Y=0) G QUIT
 ;
 ;Update all ACTIVE group plans
 D UPDGRP
 W !
 ;
QUIT ;
 Q IBEXIT
 ;
 ;
UPDINS ; Update Insurance Co FTF fields  (added with IB*702)
 N INSERR,INSUPD
 S INSUPD(36,IBIENS,.18)=IB18  ; STANDARD FTF
 S INSUPD(36,IBIENS,.19)=IB19  ; STANDARD FTF VALUE
 S INSUPD(36,IBIENS,.12)=IB12  ; FILING TIME FRAME
 D FILE^DIE("I","INSUPD","INSERR")  ; currently not evaluating INSERR
 Q
 ;
GETGRP ; Get count of all Active group plans  (added with IB*702)
 N IBAGP,IBGIEN,IBGIENS,IBINACT
 S IBGCT=0
 S IBGIEN=0 F  S IBGIEN=$O(^IBA(355.3,"B",IBIEN,IBGIEN)) Q:('IBGIEN)!(IBGIEN="")  D
 . S IBGIENS=IBGIEN_","
 . S IBINACT=$$GET1^DIQ(355.3,IBGIENS,.11,"I") ;INACTIVE
 . I IBINACT Q                                 ; The Plan is Inactive
 . S IBAGP=$$GET1^DIQ(355.3,IBGIENS,.02,"I")    ;IS THIS A GROUP POLICY?
 . I IBAGP=0 Q               ; Not a Group Plan (skips individual plans)
 . S IBGCT=IBGCT+1
 . S IBGARR(IBGIEN)=""
 Q
 ;
UPDGRP ; Update all Active group plans with ALL Insurance Co FTF fields (added with IB*702)
 N GRPERR,GRPUPD,IBG
 S IBG=0 F  S IBG=$O(IBGARR(IBG)) Q:'IBG  D
 . S GRPUPD(355.3,IBG_",",.16)=IB18  ;PLAN STANDARD FTF
 . S GRPUPD(355.3,IBG_",",.17)=IB19  ;PLAN STANDARD FTF VALUE
 . S GRPUPD(355.3,IBG_",",.13)=IB12  ;PLAN FILING TIME FRAME
 . D FILE^DIE("I","GRPUPD","GRPERR")  ; currently not evaluating GRPERR
 Q
 ;
PFLD18 ; Prompt for field .18 STANDARD FTF  (added with IB*702)
 K DIR,X,Y
 S DELETE=""
 S DIR(0)="PO^355.13:AEMQ"
 S DIR("A")="STANDARD FILING TIME FRAME"
 S DIR("B")=IB18PE
 ;The user should not be presented with the 'replace'..'with' when the filing time
 ; frame "external" value stored is greater than 19
 I $L(IB18PE)>19 D
 . S DIR("A",1)="STANDARD FILING TIME FRAME: "_IB18PE
 . S DIR("A")="       "
 . S DIR("B")=""
 D ^DIR I X="^" Q
 S IB18=X I +Y>0 S IB18=+Y
 ;
 ;If the user didn't change the default value (they hit enter), no change was
 ; made. If IB18=7 or IB18=8 DO NOT prompt for field .19 (IBSKIP)
 I IB18="",IB18PRE'="" S:(IB18PRE=7)!(IB18PRE=8) IBSKIP=1 Q
 I IB18=IB18PRE S:(IB18=7)!(IB18=8) IBSKIP=1 Q
 D EVFLD18
 Q
 ;
EVFLD18 ;Evaluate field .18. Determine if field .18 should be updated (IBFLG18=1) and
 ; if the user should be prompted to enter STANDARD FTF VALUE field .19
 ;
 ;If user deletes field .18, field .19 will also be deleted.
 ; DO NOT prompt for .19 (IBSKIP=1). Both fields have been updated (IBFLG18,IBFLG19)
 I IB18="@" D  I 'DELETE W " <NOTHING DELETED>" G PFLD18
 . S DELETE=$$DELETE()
 . I DELETE D
 . . S (IBSKIP,IBFLG18)=1
 ;If the user DID NOT enter 7-END OF FOLLOWING YEAR or 8-NO FILING TIME FRAME, update field .18
 ; (IBFLG18=1) and prompt user for field .19
 I IB18'=7,IB18'=8 S IBFLG18=1
 ;If the user entered 7-END OF FOLLOWING YEAR and 8-NO FILING TIME FRAME, update field .18 (IBFLG18).
 ; DO NOT prompt user for field .19 (IBSKIP=1). If there is data in field .19 delete it and 
 ; update field .19 (IBFLG19)
 I (IB18=7)!(IB18=8) S IBSKIP=1,IBFLG18=1
 ;If field .18 is changed/deleted, delete field .19
 I IBFLG18 I IB19PRE'="" S IB19PRE="",IB19="@",IBFLG19=1
 Q
 ;
PFLD19 ; Prompt for field .19 STANDARD FTF VALUE  (added with IB*702)
 K DIR,DIRUT,X,Y
 S DELETE=""
 S DIR(0)="NAO^0:999999:1"
 S DIR("A")="STANDARD FILING TIME FRAME VALUE: "
 ;Only display the default if there was an existing value for field .19
 I IB19PRE'="" S DIR("B")=IB19PRE
 S DIR("?")=" Type a Number between 0 and 999999, 1 Decimal Digit"
 D ^DIR I X="^" Q
 S IB19=X
 ;If user hit enter to accept the default, no change was made, quit
 I IB19=IB19PRE Q
 ;If user entered '@', ask "Are you sure?", if 'NO' Prompt user again
 I IB19="@" D  I 'DELETE W " <NOTHING DELETED>" G PFLD19
 . S DELETE=$$DELETE()
 . I DELETE S IBFLG19=1
 ;User changed the value, set IBFLG19
 I IB19PRE'=IB19 S IBFLG19=1
 Q
 ;
PFLD12 ; Prompt for field .12 FILING TIME FRAME  (added with IB*702)
 K DIR,DIRUT,X,Y
 S DELETE=""
 S DIR(0)="FO^3:30"
 S DIR("A")="FILING TIME FRAME"
 ;Only display the default if there was an existing value for field .12
 I IB12PRE'="" S DIR("B")=IB12PRE
 S DIR("?",1)=" Enter maximum amount of time from date of service that the insurance"
 S DIR("?",2)=" company allows for submitting claims. Answer must be 3-30 characters in"
 S DIR("?")=" length."
 D ^DIR I X="^" Q
 S IB12=X
 ;If user hit enter to accept the default, no change was made, quit
 I IB12=IB12PRE Q
 ;If user entered '@', ask "Are you sure?", if 'NO' Prompt user again
 I IB12="@" D  I 'DELETE W " <NOTHING DELETED>" G PFLD12
 . S DELETE=$$DELETE()
 . I DELETE S IBFLG12=1
 ;User changed the value, set IBFLG12
 I IB12PRE'=IB12 S IBFLG12=1
 Q
 ;
DELETE() ; Confirm Deletion  (added with IB*702)
 ; Returns:  1 - YES
 ;           0 - NO or user entered "^"
 K DIR,DIRUT,X,Y
 S DIR(0)="Y"
 S DIR("A")="  SURE YOU WANT TO DELETE"
 S DIR("B")="Yes"
 D ^DIR
 I $D(DIRUT) Q 0
 Q Y
