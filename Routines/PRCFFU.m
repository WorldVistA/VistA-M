PRCFFU ;WISC/SJG-CONTINUATION OF OBLIGATION PROCESSING ;7/21/93  13:51
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT
 ; No top level entry point
OKAY ;
 S DIR(0)="Y",DIR("A",1)="The information listed above is recorded on this "_PRCFA("IDES")_"."
 S DIR("A")="Is the above information correct",DIR("B")="YES"
 S DIR("?")="Enter 'NO' or 'N' to edit the Cost Center or BOC."
 S DIR("?",1)="Enter '^' to exit this option."
 S DIR("?",2)="Enter 'YES' or 'Y' or 'RETURN' to continue processing this obligation."
 D ^DIR K DIR
 QUIT
 ;
OKAY2 ;
 S DIR(0)="Y",DIR("A")="OK to Continue",DIR("B")="YES"
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit this option."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to continue processing this obligation."
 D ^DIR K DIR
 QUIT
 ;
EDIT ; Set up PRCFMO array to indicate required FMS fields
 S PARAM1="^"_PRC("SITE")_"^"_+$P(PO(0),U,3)_"^"_PRC("FY")_"^"_PRCFA("BBFY")
 ; build PRCFMO array to use when creating LIN string of FMS transaction
 ; PARAM1=^STATION^FCP^FY^BBFY
 ; SPE means spending documents
 D DOCREQ^PRC0C(PARAM1,"SPE","PRCFMO")
 S PRCFMO("G/N")=$P(PRCFMO,U,12)
 QUIT
 ;
GO ; Prompt user for final go-ahead for the document creation
 S PRCFA("FDES")=$S(PRCFA("TT")="MO":"Miscellaneous Order (MO)",PRCFA("TT")="SO":"Service (SO) Order",PRCFA("TT")="AR":"Receiver Accrual (AR)")
 N POSIT S POSIT=$F(PRCFA("FDES"),"(")
 S PRCFA("TYPE")=$E(PRCFA("FDES"),POSIT,POSIT+1)
 S DIR(0)="Y"
 S DIR("A")="Transmit this Document to FMS"
 S DIR("B")="YES"
 S DIR("A",1)=" "
 S DIR("A",2)="This "_PRCFA("IDES")_" will now generate the "
 S DIR("A",3)=$P(PRCFA("MOD"),U,3)_" "_PRCFA("FDES")_" Document.  The "_PRCFA("TYPE")_" Document"
 S DIR("A",4)="will be marked for transmission to FMS."
 S DIR("A",5)=" "
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit this option."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to transmit this Document."
 D ^DIR K DIR
 QUIT
 ;
STACK(MOD) ; Create entry in GECS Stack File
 I $D(PRCFA("CONVS")),PRCFA("CONVS")=1 G STACK1
 I $D(PRCFA("CONVG")),PRCFA("CONVG")=1 G STACK1
 W !!,"...now generating the FMS "
 W $S(PRCFA("TT")="MO":"Miscellaneous Order (MO) Document",PRCFA("TT")="SO":"Service Order (SO) Document",PRCFA("TT")="AR":"Receiver Accrual (AR) Document",1:"Document")
 W "...",! D WAIT^DICD
STACK1 N FMSSYS,FMSSTA,FMSDOC,FMSTRA,FMSSEC,FMSMOD,FMSFCP,FMSDES
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 Q
 K GECSUFMS("DA") ; delete current ien to get new ien
 S FMSDES=PRCFA("IDES")
 S FMSDOC=PRCFA("REF")
 S FMSMOD=MOD
 I PRCFA("TT")="AR" D
 . S FMSDOC=FMSDOC_12
 . S FMSMOD=1
 S FMSSEC=$$SEC1^PRC0C(PRC("SITE"))
 S FMSSTA=PRC("SITE")
 S FMSSYS="I"
 S FMSTRA=PRCFA("TT")
 D CONTROL^GECSUFMS(FMSSYS,FMSSTA,FMSDOC,FMSTRA,FMSSEC,FMSMOD,"Y",FMSDES)
 QUIT
 ;
OKAM ; Reader for prompt to approve amendment
 S DIR(0)="Y"
 S DIR("A",1)="The information listed above is recorded on this Purchase Order amendment."
 S DIR("A")="Are you ready to approve and obligate this amendment"
 S DIR("B")="YES"
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit this option."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to continue processing this amendment obligation."
 D ^DIR K DIR
 QUIT
 ;
OKAPP ; Reader for prompt that amendment has already been approved
 S DIR(0)="Y"
 S DIR("A",1)="This amendment has already been approved by Fiscal."
 S DIR("A")="Are you sure that you wish to continue"
 S DIR("B")="NO"
 S DIR("?")="Enter 'YES' or 'Y' to continue."
 S DIR("?",1)="Enter 'NO' or 'N' or '^' or 'RETURN' to exit this option."
 D ^DIR K DIR
 QUIT
 ;
OKPRT ; Reader to prompt user to print the amendment
 S DIR(0)="Y"
 S DIR("A")="Would you like to print this amendment"
 S DIR("B")="YES"
 S DIR("?")="Enter 'YES' or 'Y' or 'RETURN' to print this amendment."
 S DIR("?",1)="Enter 'NO' or 'N' or '^' if printing in not desired."
 D ^DIR K DIR
 QUIT
 ;
REVIEW ; Reader to prompt user to review the PO before obligation
 N LABEL S LABEL=$S((PRCFA("MP")=1)!(PRCFA("MP")=2):"Purchase Order",PRCFA("MP")=8:"Requisition",1:"Purchase Order")
 S DIR(0)="Y"
 S DIR("A")="Would you like to review the entire "_LABEL
 S DIR("B")="YES"
 S DIR("?")="Enter 'NO' or 'N' or '^' if the "_LABEL_" review is not necessary."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to display the "_LABEL_"."
 D ^DIR K DIR
 Q
 ;
 ; PO is the ien of the 443.6 file
 ; AMNUM is the amendment number
CHKAMEN(PO,AMNUM) ; checks PO completeness, looks for missing data 
 N CNT,J,INUM,CHNG,STARTFLG,TYPAM,MSG,PRPAYFLG
 S CNT=0
 S STARTFLG=0
 S PRPAYFLG=0
 F CHNG=0:0 S CHNG=$O(^PRC(443.6,+PO,6,AMNUM,3,CHNG)) Q:CHNG'>0  D
 . S CHNG=^(CHNG,0)
 . ;
 . ;Has the data in any of the following fields been deleted?
 . ;Ship To Address, Inv. Address, Prompt Pay. Terms, or F.O.B.Point.
 . S TYPAM=$P($G(CHNG),U,2)
 . I TYPAM=20,$P(^PRC(443.6,+PO,1),U,3)="" D
 . . S MSG="Ship To Address."
 . . S $P(^PRC(443.6,+PO,1),U,3)=$P(^PRC(442,+PO,1),U,3)
 . I TYPAM=25,$P(^PRC(443.6,+PO,12),U,6)="" D
 . . S MSG="Invoice Address."
 . . S $P(^PRC(443.6,+PO,12),U,6)=$P(^PRC(442,+PO,12),U,6)
 . I TYPAM=33,^PRC(443.6,+PO,5,0)="" D
 . . S MSG="Prompt Payment Terms."
 . . S ^PRC(443.6,+PO,5,0)=^PRC(442,+PO,5,0)
 . . S I=0 F J=0:0 S I=$O(^PRC(443.6,+PO,5,I)) Q:I=""  S ^PRC(443.6,+PO,5,I,0)=^PRC(442,+PO,5,I,0)
 . . Q
 . I TYPAM=35,$P(^PRC(443.6,+PO,1),U,6)="" D
 . . S MSG="F.O.B. Point."
 . . S $P(^PRC(443.6,+PO,1),U,6)=$P(^PRC(442,+PO,1),U,6)
 . I $G(MSG)]"" D
 . . I TYPAM=33&'PRPAYFLG!(TYPAM'=33) W !?10,"This amendment is missing it's ",MSG,"!" K MSG
 . . I TYPAM=33 S PRPAYFLG=1
 . . S STARTFLG=1
 . Q
 . ;
 . I $P($P(CHNG,U,3),":",2)=40,($P($P(CHNG,U,3),";"))=1 S INUM=$P(CHNG,U,4) I $G(INUM)]"" D
 . . ; for each item , check description
 . . S J=0 S J=$O(^PRC(443.6,+PO,2,INUM,1,J)) I J>0&(^(J,0)="") D
 . . . I CNT>22 N DIR S DIR(0)="E" D ^DIR S CNT=0
 . . . W !,?10,"Line item ",INUM," is missing it's description!"
 . . . S CNT=CNT+2,STARTFLG=1
 . . . Q
 . . Q
 . Q
 Q STARTFLG
