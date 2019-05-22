DGPFLMA5 ;SLC/SS - PRF ASSIGNMENT LM PROTOCOL ACTIONS CONT. ; 01/24/18
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;
 ;no direct entry
 Q
 ;
TR ; Entry point for DGPF TRANSFER FLAG action protocol.
 N DGDFN     ; Pointer to patient in PATIENT (#2) file
 N DGIEN     ; Assignment ien
 N DGPFA     ; Assignment array
 N SEL       ; User selection (list item)
 N REASON    ; reason for the request
 N RES       ; Result of request attempt
 N DIV       ; sign-on division name ^ sign-on division station #
 N OWNER     ; current flag owner
 N Z
 ;
 ; Set screen to full scroll region
 D FULL^VALM1
 S VALMBCK="R"
 ; Quit if selected action is not appropriate
 I '$D(@VALMAR@("IDX")) D DISPMSG("0^0^^Action not permitted - "_$S('$G(DGDFN):"Patient has not been selected.",1:"Patient has no record flag assignments.")) Q
 ; Quit if user's DUZ(2) is not an enabled division for PRF ASSIGNMENT OWNERSHIP
 I '$D(^DG(40.8,"APRF",+DUZ(2))) D DISPMSG("0^0^^Action not permitted - You are signed into a division which is not PRF enabled, the FT action cannot be used to request PRF transfer to this division") Q
 ; Quit if user's DUZ(2) is neither parent facility, nor a division in an integrated site
 I '$$CHKINT() D DISPMSG("0^0^^Action not permitted - You are signed into a division which is neither a parent facility, nor a VAMC type division in an integrated site.") Q
 ; Allow user to select a single flag assignment
 S DGIEN="" D EN^VALM2($G(XQORNOD(0)),"S")
 ; Process user selection
 S SEL=$O(VALMY("")) I 'SEL Q
 S DGIEN=$P($G(@VALMAR@("IDX",SEL,SEL)),U)
 S DGDFN=$P($G(@VALMAR@("IDX",SEL,SEL)),U,2)
 S DIV=$$NS^XUAF4(+DUZ(2))
 ; Attempt to obtain lock on assignment record
 I '$$LOCK^DGPFAA3(DGIEN) D DISPMSG("0^0^^Record flag assignment currently in use.") Q
 ; Get assignment into DGPFA array
 I '$$GETASGN^DGPFAA(DGIEN,.DGPFA) D DISPMSG("0^0^^Unable to retrieve the record flag assignment selected.") G TRX
 ; Check who is the current owner
 S Z=$$PARENT^DGPFUT1($P($G(DGPFA("OWNER")),U))
 S OWNER=$P(Z,U) I OWNER=0!($P(Z,U,3)="") S OWNER=$P($G(DGPFA("OWNER")),U)
 I OWNER=+DUZ(2)!(OWNER=$P($$PARENT^DGPFUT1(+DUZ(2)),U)) D DISPMSG("0^0^^Your division/facility is the current owner of this record flag assignment.") G TRX
 ;
 I DGPFA("FLAG")'["26.15" D DISPMSG("0^0^^Only ownership of national (Cat I) flag assignments can be transferred.") G TRX
 ; prompt for request reason
 S REASON=$$ASKRSN^DGPFTR1(0,1) I REASON="" G TRX
 ;
 W !!,"You're about to request ownership transfer of the following"
 W !,"record flag assignment to division "_$P(DIV,U)_" (station #"_$P(DIV,U,2)_"):"
 W !!,"Patient:         ",$P($G(DGPFA("DFN")),U,2)
 W !,"PRF flag:        ",$P($G(DGPFA("FLAG")),U,2)
 W !,"PRF flag status: ",$P($G(DGPFA("STATUS")),U,2)
 W !,"Current owner:   ",$P($G(DGPFA("OWNER")),U,2)
 W !,"Request reason:  ",REASON
 I '$$ASKCONT() G TRX
 ;
 S RES=$$SEND^DGPFHLT(DGDFN,$P($P($G(DGPFA("FLAG")),U),";"),OWNER,REASON)
 ;
 D DISPMSG(RES)
 ; rebuild list of flag assignments for this patient
 D BLDLIST^DGPFLMU(DGDFN)
TRX ; exit point
 ; Release lock on assignment record
 D UNLOCK^DGPFAA3(DGIEN)
 Q
 ;
ASKCONT() ; Asks user if they wish to continue
 ; Returns 1 if response is "YES", 0 otherwise
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("A")="Do you wish to send this request",DIR("B")="NO"
 D ^DIR
 Q +Y
 ;
DISPMSG(MSG) ; Display message to the user
 ; status^HL7 message id^error code^error description^error source
 N ERRSTR,HL7OK,Z
 S ERRSTR="the following error has occurred:"
 S HL7OK="Transfer request sent successfully."
 I +MSG W !!,HL7OK
 I '+MSG D
 .I +$P(MSG,U,5)=0 W !!,"Unable to proceed, ",ERRSTR
 .I +$P(MSG,U,5)=1 W !!,"Unable to send transfer request, ",ERRSTR
 .I +$P(MSG,U,5)=2 W !!,HL7OK,!,"...but error occurred while filing log entry:"
 .W !
 .S Z=$P(MSG,U,2) I +Z W !?2,"HL7 Message ID: ",Z
 .S Z=$P(MSG,U,3) I +Z W !?2,"Error Code: ",Z
 .S Z=$P(MSG,U,4) I Z'="" W !?2,"Error Text: ",!,Z
 .Q
 D PAUSE^VALM1
 Q
 ;
CHKINT() ; check for integrated site divisions
 ; only ingrated site divisions are allowed to use FT action
 ;
 ; returns 1 if division is allowed to use FT, 0 otherwise
 ;
 N DIV,DIVST,EXCLUDE,FDATA,INTFCLTY,PARENT,PRNTIEN,PRNTST,RES
 ;
 S INTFCLTY="^528^589^636^657^" ; list of int. site parent facilities (station #s)
 S EXCLUDE="^636A4^636A5^" ; list of divisions excluded from transfers (special case for VISN 23)
 S DIV=+DUZ(2) ; sign-on division ien
 S RES=0
 S PARENT=$$PARENT^DGPFUT1(DIV),DIVST=$$STA^XUAF4(DIV),PRNTIEN=$P(PARENT,U),PRNTST=$P(PARENT,U,3)
 I PRNTIEN=0!(PRNTST="")!(PRNTIEN=DIV) S RES=1 ; it's a parent facility
 I 'RES,EXCLUDE'[(U_DIVST_U) D
 .; not on excluded divisions list
 .I INTFCLTY[(U_PRNTST_U) D
 ..; division's parent is on integrated facility list
 ..D F4^XUAF4(DIVST,.FDATA)
 ..I $G(FDATA("TYPE"))="VAMC" S RES=1 ; division's facility type is VAMC
 ..Q
 .Q
 Q RES
