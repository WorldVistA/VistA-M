BPSRES1 ;AITC/MRD - ECME SCREEN RESUBMIT W/EDITS ;10/23/17
 ;;1.0;E CLAIMS MGMT ENGINE;**23,24,32**;JUN 2004;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
ADDLFLDS(BPS02,BPS59,BPSADDLFLDS,BPSDOS) ; Add fields to a claim.
 ; This function allows the user to add to claim fields not on payer
 ; sheet.  It is used by the RED/Resubmit with Edits Action on the
 ; ECME User Screen and by the PRO Option (Process Secondary/TRICARE
 ; Rx to ECME).
 ; Input: BPS02 = Pointer to BPS CLAIMS
 ;        BPS59 = Pointer to BSP TRANSACTION
 ;        BPSDOS = Date of Service; if passed in, then display
 ;                 when listing fields to be added to claim
 ; This function will return:
 ;     1 - If user entered additional fields.
 ;     0 - If user added no fields.
 ;    -1 - If user exited out via "^".
 ; This function will also set up the array BPSADDFLDS if the user
 ; chooses to add any fields to the claim.
 ;    BPSADDLFLDS(Field IEN) = Value to Send
 ;
 N BPS,BPSFIELD,BPSGETCODE,BPSPAYER,BPSQ,BPSSEGMENT
 N DIC,MEDN,TRANLIST,X,Y
 ;
 ; Prompt user whether to enter additional fields.  If user enters
 ; "No", display the Date of Service, if it exists, then Quit with 0.
 ; If user enters "^", Quit with -1.
 ;
 W !
 S BPSQ=$$YESNO^BPSSCRRS("Submit NCPDP Field Not on Payer Sheet (Y/N)","N")
 I BPSQ=0,$G(BPSDOS)'="" W !!,"Fields entered to transmit:",!,?4,"Date of Service: ",$$FMTE^XLFDT(BPSDOS,"5D")
 I BPSQ'=1 Q BPSQ
 ;
 ; Kill array that will contain list of fields to be added.
 ;
 K BPSADDLFLDS
 ;
 ; Build an array listing the fields already on the payer sheet and an
 ; array listing all segments on the payer sheet.  Include all segments,
 ; though some may be excluded later.
 ;
 D ARRAYS(BPS02,.BPSPAYER,.BPSSEGMENT)
 I 'BPSPAYER Q 0
 ;
 ; Build BPS array.  While each field in the file BPS NCPDP FIELD DEFS
 ; has Get Code (executable M code) for pulling the data value, the way
 ; this has been implemented is that first the subroutine $$BPS^BPSOSCB
 ; pulls many fields of data, building the BPS array, and then the
 ; Get Code for each field puts into BPS("X") a value from the BPS
 ; array.  Because the system needs to display to the user the value
 ; that would be sent with a field being added to the claim, we need to
 ; build the entire BPS array, which will be used by the Get Code for
 ; any fields selected by the user.  TRANLIST is an array listing all
 ; BPS Transactions in this batch of claims.  However, the VA does not
 ; ever batch claims, so there is always only one transaction in that
 ; list.  BPS(9002313.0201) must be set to 1.  It should never return a
 ; value other than 0, but if it does, Quit.
 ;
 S TRANLIST(BPS59)=""
 S BPS(9002313.0201)=1
 S X=$$BPS^BPSOSCB
 I X W !,$P(X,U,2),".",!,"Fields may not be added at this time." Q 0
 ;
 ; Display help text.
 ;
 W !!,"Enter a valid NCPDP Field name or number.  Enter '??' for"
 W !,"a list of possible choices.  Fields already on the payer sheet"
 W !,"are excluded from the list of possible choices.  Also excluded"
 W !,"are any fields that do not have logic to pull data from VistA"
 W !,"(i.e. fields that will always be <blank>)."
 ;
A1 ; Prompt user for an NCPDP field to add to the claim.
 ;
 K DIC
 ;
 S DIC=9002313.91
 S DIC(0)="AEMQ"
 S DIC("A")="NCPDP Field Name or Number:  "
 S DIC("S")="I $$CHECK^BPSRES1(Y,.BPSPAYER,.BPSSEGMENT)"
 S DIC("T")=""
 ;
 W !
 D ^DIC
 ;
 ; When the user just hits <return>, skip down to A2.
 ;
 I X="" G A2
 ;
 I Y=-1 Q -1
 S BPSFIELD=+Y
 ;
 ; Disallow a field already added.
 ;
 I $D(BPSADDLFLDS(BPSFIELD)) W !,?4,"This field has already been added to the claim.",*7 G A1
 ;
 ; Display to the user the value to be sent with this field.
 ;
 S BPS("X")=""
 S MEDN=1  ; Required for some GET codes.
 S BPSGETCODE=0
 F  S BPSGETCODE=$O(^BPSF(9002313.91,BPSFIELD,10,BPSGETCODE)) Q:'BPSGETCODE  X $G(^BPSF(9002313.91,BPSFIELD,10,BPSGETCODE,0))
 W !,?4,"Value to transmit: ",BPS("X")
 S BPSQ=$$YESNO^BPSSCRRS("Transmit with claim (Y/N)","Y")
 I BPSQ=0 G A1
 I BPSQ=-1 K BPSADDLFLDS Q -1
 ;
 ; Add selected field to array (Y=internal field #).
 ;
 S BPSADDLFLDS(BPSFIELD)=BPS("X")
 ;
 G A1
 ;
A2 ; User is done selecting fields to add.
 ;
 ; If user added no fields, Quit with 0.
 ;
 I '$D(BPSADDLFLDS),'$G(BPSDOS) Q 0
 ;
 ; Display to the user the list of fields being added to the claim.
 ;
 W !!,"Fields entered to transmit:"
 I $G(BPSDOS)'="" W !,?4,"Date of Service: ",$$FMTE^XLFDT(BPSDOS,"5D")
 S BPSFIELD=""
 F  S BPSFIELD=$O(BPSADDLFLDS(BPSFIELD)) Q:'BPSFIELD  D
 . W !,?4,$$GET1^DIQ(9002313.91,BPSFIELD,.01),"-"
 . W $$GET1^DIQ(9002313.91,BPSFIELD,.06)," "
 . W $$GET1^DIQ(9002313.91,BPSFIELD,.03),": "
 . W BPSADDLFLDS(BPSFIELD)
 . Q
 ;
 Q 1
 ;
ARRAYS(BPS02,BPSPAYER,BPSSEGMENT)  ; Build BPSPAYER array and BPSSEGMENT array.
 ;
 ; Build an array listing the fields already on the payer sheet and
 ; an array listing all segments on the payer sheet.  Include all
 ; segments, though some may be excluded later.
 ;
 N BPSFIELD,BPSORDER
 ;
 S BPSPAYER=$$GET1^DIQ(9002313.02,BPS02,.02,"I")  ; Payer Sheet.
 I 'BPSPAYER Q
 F BPSSEGMENT=100:10:300 D
 . I '$D(^BPSF(9002313.92,BPSPAYER,BPSSEGMENT)) Q
 . S BPSSEGMENT(BPSSEGMENT)=""
 . S BPSORDER=0
 . F  S BPSORDER=$O(^BPSF(9002313.92,BPSPAYER,BPSSEGMENT,BPSORDER)) Q:'BPSORDER  D
 . . S BPSFIELD=$P($G(^BPSF(9002313.92,BPSPAYER,BPSSEGMENT,BPSORDER,0)),"^",2)  ; Field IEN
 . . I BPSFIELD'="" S BPSPAYER(BPSFIELD)=""
 . . Q
 . Q
 ;
 Q
 ;
CHECK(BPSY,BPSPAYER,BPSSEGMENT) ; Screen for BPS NCPDP FIELD DEFS lookup.  See ADDLFLDS above.
 ; This function is called for a given entry in the file BPS
 ; NCPDP FIELD DEFS, where +Y will be the IEN.  If this function
 ; returns a 1, then this entry is a valid choice.  If this
 ; function returns a 0, then this entry will not be displayed to
 ; the user when listing possible choices and this entry will not
 ; be a valid choice for the user.
 ;
 ; Disallow if already on the payer sheet.
 ;
 I $D(BPSPAYER(+BPSY)) Q 0
 ;
 ; Disallow if this field is not on a request segment or if this
 ; field is on a segment not on the payer sheet.
 ;
 S BPSSEGMENT=$P($G(^BPSF(9002313.91,+BPSY,5)),"^",4)  ; Request Segment.
 S BPSSEGMENT=$P($G(^BPSF(9002313.9,+BPSSEGMENT,0)),"^",2)
 I BPSSEGMENT="" Q 0
 I '$D(BPSSEGMENT(BPSSEGMENT)) Q 0
 ;
 ; There are many segments the VA does not send, even if that
 ; segment is on a payer sheet.  Disallow any fields that are
 ; on one of those segments.
 ;
 I ",140,170,200,210,220,230,240,250,260,270,280,290,300,"[(","_BPSSEGMENT_",") Q 0
 ;
 ; Disallow if Get Code is simply Setting BPS("X") to "".
 ;
 I $G(^BPSF(9002313.91,+BPSY,10,1,0))["S BPS(""X"")=""""" Q 0
 ;
 Q 1
 ;
SAVE(BPSACTION,BPS59,BPSADDLFLDS,BPSOVRIEN) ; Save into BPS NCPDP OVERRIDES (#9002313.511)
 ;
 ; If the user chooses to add any fields to the claim, each field
 ; will be listed as BPSADDLFLDS(Field IEN).
 ;
 ; Input:  BPSACTION = Action selected by user (e.g. RED, PRO)
 ;         BPS59 = Pointer to BPS TRANSACTIONS
 ;         BPSADDLFLDS = Passed by reference, array listing the
 ;            NCPDP fields to be added to the claim.
 ;            BPSADDLFLDS(NCPDP Field) = ""
 ;         BPSOVRIEN = Passed by reference, ien of entry in the
 ;            file BPS NCPDP OVERRIDE
 ;
 N BPSFDA,BPSFIELD,BPSMSG,BPSCNT,BPSFIELD
 ;
 S BPSFDA(9002313.511,"+1,",.01)=BPS59
 D NOW^%DTC
 S BPSFDA(9002313.511,"+1,",.02)=%
 ;
 ; Store the fields for which the user was prompted.
 ;
 S BPSCNT=1
 I BPSACTION="RED" D
 . S BPSFIELD=$O(^BPSF(9002313.91,"B",303,"")) I BPSFIELD]"" S BPSFDA(9002313.5111,"+2,+1,",.01)=BPSFIELD,BPSFDA(9002313.5111,"+2,+1,",.02)=BPPSNCD
 . S BPSFIELD=$O(^BPSF(9002313.91,"B",306,"")) I BPSFIELD]"" S BPSFDA(9002313.5111,"+3,+1,",.01)=BPSFIELD,BPSFDA(9002313.5111,"+3,+1,",.02)=BPRELCD
 . S BPSFIELD=$O(^BPSF(9002313.91,"B",462,"")) I BPSFIELD]"" S BPSFDA(9002313.5111,"+4,+1,",.01)=BPSFIELD,BPSFDA(9002313.5111,"+4,+1,",.02)=BPPREAUT
 . S BPSFIELD=$O(^BPSF(9002313.91,"B",461,"")) I BPSFIELD]"" S BPSFDA(9002313.5111,"+5,+1,",.01)=BPSFIELD,BPSFDA(9002313.5111,"+5,+1,",.02)=BPPRETYP
 . S BPSFIELD=$O(^BPSF(9002313.91,"B",420,"")) I BPSFIELD]"" S BPSFDA(9002313.5111,"+6,+1,",.01)=BPSFIELD,BPSFDA(9002313.5111,"+6,+1,",.02)=BPCLCD1_"~"_$G(BPCLCD2)_"~"_$G(BPCLCD3)
 . S BPSFIELD=$O(^BPSF(9002313.91,"B",384,"")) I BPSFIELD]"" S BPSFDA(9002313.5111,"+7,+1,",.01)=BPSFIELD,BPSFDA(9002313.5111,"+7,+1,",.02)=BPPTRES
 . S BPSFIELD=$O(^BPSF(9002313.91,"B",147,"")) I BPSFIELD]"" S BPSFDA(9002313.5111,"+8,+1,",.01)=BPSFIELD,BPSFDA(9002313.5111,"+8,+1,",.02)=BPPHSRV
 . S BPSFIELD=$O(^BPSF(9002313.91,"B",357,"")) I BPSFIELD]"" S BPSFDA(9002313.5111,"+9,+1,",.01)=BPSFIELD,BPSFDA(9002313.5111,"+9,+1,",.02)=BPDLYRS
 . S BPSFIELD=$O(^BPSF(9002313.91,"B",305,"")) I BPSFIELD]"" S BPSFDA(9002313.5111,"+10,+1,",.01)=BPSFIELD,BPSFDA(9002313.5111,"+10,+1,",.02)=BPGENDER
 . S BPSCNT=10
 . Q
 ;
 ; Store additional NCPDP fields which the user chose to add to the
 ; the resubmitted claim.
 ;
 S BPSFIELD=0
 F  S BPSFIELD=$O(BPSADDLFLDS(BPSFIELD)) Q:'BPSFIELD  D
 . S BPSCNT=BPSCNT+1
 . S BPSFDA(9002313.5112,"+"_BPSCNT_",+1,",.01)=BPSFIELD  ; Field#
 . S BPSFDA(9002313.5112,"+"_BPSCNT_",+1,",.02)=$$GET1^DIQ(9002313.91,BPSFIELD,2,"I")  ; Segment#
 . Q
 ;
 D UPDATE^DIE("","BPSFDA","BPSOVRIEN","BPSMSG")
 ;
 I $D(BPSMSG("DIERR")) D  Q -1
 . W !!,"Could not save override information into BPS NCPDP OVERRIDE file.",!
 . N DIR
 . S DIR(0)="E"
 . S DIR("A")="Press Return to continue."
 . D ^DIR
 . Q
 ;
 Q 1
 ;
