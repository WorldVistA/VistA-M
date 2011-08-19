IVMLINS4 ;ALB/SEK - IVM INSURANCE UPLOAD ACCEPT - IB CALL ; 30 JAN 2009
 ;;2.0;INCOME VERIFICATION MATCH;**14,135**; 21-OCT-94;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine is called by IB to update insurance segments sent
 ; from HEC and stored in the INCOMING SEGMENT multiple of the IVM
 ; PATIENT file (#301.5).  A HL7 message is sent to HEC indicating if
 ; the data is accepted or rejected (including reason for rejection).
 ;
 ; Before this call, IB code allows the user to to review the
 ; insurance policy from HEC stored in IB's insurance module.  When
 ; the user decides to accept or reject the policy, this routine is
 ; called.  If the policy is rejected, this routine allows the user
 ; to pick the reason for rejection.
 ;
UPDATE(DFN,IVMINSST,IVMID,IVMREPTR,IVMSUPPR) ;
 ;
 ; Input:       DFN  --  internal entry number of PATIENT file
 ;         IVMINSST  --  upload status 1-accepted  0-rejected
 ;            IVMID  --  ins. co. name ^ street add[line 1] ^ group #
 ;         IVMREPTR  --  IVM REASONS FOR NOT UPLOADING (#301.91) IEN 
 ;                       (Optional)
 ;         IVMSUPPR  --  Suppress Write and Interactive Lookup when > 0
 ;                       (Optional)
 ;
 ; Output: returns 1 if updated or 0 followed by error if not updated
 ;
 N IVM1INSN,IVM2SA1,IVM3GNU,IVMI,IVMIBERR,IVMJ,IVMDA,IVMDAIN,IVMFOUND
 I '$G(DFN)!('$D(^DPT(+DFN,0))) S IVMIBERR="No patient defined" G EXIT
 I '$D(^IVM(301.5,"B",DFN)) S IVMIBERR="Patient not in IVM PATIENT file" G EXIT
 ;
 I $G(IVMINSST)'=0&($G(IVMINSST)'=1) S IVMIBERR="upload status not accepted or rejected" G EXIT
 ;
 ; - check id fields
 S IVM1INSN=$P(IVMID,"^")
 S IVM2SA1=$P(IVMID,"^",2)
 S IVM3GNU=$P(IVMID,"^",3)
 I IVM1INSN']"" S IVMIBERR="no insurance company name from MCCR insurance module" G EXIT
 I IVM2SA1']"" S IVMIBERR="no street address from MCCR insurance module" G EXIT
 I IVM3GNU']"" S IVMIBERR="no group number from MCCR insurance module" G EXIT
 ;
 S IVMDA=0
 F  S IVMDA=$O(^IVM(301.5,"B",DFN,IVMDA)) Q:'IVMDA  D FIND Q:$G(IVMFOUND)
 G PROCESS
 ;
 ; - find ins. record in IVM PATIENT file
FIND S IVMDAIN=0
 F  S IVMDAIN=$O(^IVM(301.5,IVMDA,"IN",IVMDAIN)) Q:'IVMDAIN  D  Q:$G(IVMFOUND)
 .; - record missing
 .Q:'$D(^IVM(301.5,IVMDA,"IN",IVMDAIN,0))
 .Q:'$D(^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST"))
 .;
 .; - if 2nd piece not null - skip record - insurance record not transferred
 .Q:$P($G(^IVM(301.5,IVMDA,"IN",IVMDAIN,0)),"^",2)]""
 .;
 .; - if 4th piece not null - skip record - already uploaded or rejected
 .Q:$P($G(^IVM(301.5,IVMDA,"IN",IVMDAIN,0)),"^",4)]""
 .;
 .; - check 3 fields in ^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST") if not 3 matches - skip record
 .Q:$P(^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST"),"^",4)'=IVM1INSN
 .Q:$P($P(^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST"),"^",5),"~")'=IVM2SA1
 .Q:$P(^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST"),"^",8)'=IVM3GNU
 .; - if ins record found
 .S IVMFOUND=1
 .Q
 Q
 ;
PROCESS I 'IVMDAIN S IVMIBERR="Insurance data not found in IVM PATIENT file" G EXIT
 ;
 N DA,DTOUT,DUOUT,DR,DIE,Y
 ;
 ; - if the insurance data is accepted do
 I IVMINSST D  G DEL
 .;
 .; - stuff UPLOAD INSURANCE DATA(.04), UPLOADED INSURANCE DATE/TIME(.05)
 .S DA=IVMDAIN,DA(1)=IVMDA
 .S DIE="^IVM(301.5,"_DA(1)_",""IN"","
 .S DR=".04////1;.05///NOW" D ^DIE
 ;
 ; - if the insurance data is rejected and writes/prompts not suppressed
 ;   then ask for reason why
 ;
 D:$G(IVMSUPPR)'>0
 . W !!,"The 'Reject IVM Insurance Policy' action has been selected."
 . W !,"Please select a reason for rejecting the IVM insurance information."
 . S DIC="^IVM(301.91,",DIC("A")="Select reason for rejecting: ",DIC(0)="QEAMZ"
 . D ^DIC K DIC I Y<0!($D(DTOUT))!($D(DUOUT)) S IVMREPTR=0 Q
 . S IVMREPTR=+Y
 ;
 ;If IVMREPTR hasn't been defined, give error message and exit
 I $G(IVMREPTR)'>0 S IVMIBERR="No reason selected" G EXIT
 ;
 ; stuff UPLOAD INSURANCE DATA(.04) and REASON NOT UPLOADING INSURANCE
 ; (.08)
 S DA=IVMDAIN,DA(1)=IVMDA
 S DIE="^IVM(301.5,"_DA(1)_",""IN"","
 S DR=".04////0;.08////^S X=IVMREPTR" D ^DIE
 ;
DEL ; - delete incoming segments strings
 K ^IVM(301.5,DA(1),"IN",DA,"ST"),^("ST1")
 ;
 ; - send HL7 message to IVM Center
 ;
 S IVMI=DA(1),IVMJ=DA
 D HL7^IVMLINS2
 ;
EXIT Q $S($D(IVMIBERR):0,1:1)_"^"_$G(IVMIBERR)
