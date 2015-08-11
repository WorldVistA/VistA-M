RCDPAYER ;ALB/PJH - TPJI Utility ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**269,276,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Integration Agreement 5549
 ;
 Q
 ;
EN(IB3611) ;Called from IBJTTC
 ; IB3611 = ien of EXPLANATION OF BENEFITS file (361.1)
 ; gathers payer contact data from file 361.1 and 344.4
 ; returns the data to IBJTTC for display on COMMENT HISTORY screen of TPJI
 N AR3444,CONTACTS,ERA3,FOUND,I,IBTEXT,IB25,STR,WEB,NAME
 ;
 S CONTACTS="",STR="",FOUND=0,WEB="",NAME=""
 ;
 ;Retrieve contacts from EOB file
 S IB25=$P($G(^IBM(361.1,IB3611,25)),U,1,7) ;IA 4051
 S:$TR(IB25,U,"")]"" FOUND=1,STR=IB25
 ;
 ;Get ERA reference
 S AR3444=$O(^RCY(344.4,"ADET",IB3611,""))
 ;
 ;If no contact in EOB retrieve contacts from ERA file
 I AR3444,'FOUND D
 .S ERA3=$P($G(^RCY(344.4,AR3444,3)),U,1,7)
 .S:$TR(ERA3,U,"")]"" FOUND=1,STR=ERA3
 ;
 ;Retrieve Payer Web Address from ERA file
 I AR3444 S WEB=$P($G(^RCY(344.4,AR3444,5)),U) S:WEB]"" FOUND=1
 ;
 ;Get Payer Contact Name
 S NAME=$P(STR,U) S:NAME]"" FOUND=1
 ;
 ;Format contacts
 I STR]"" D
 .N I,CTYP,CPOS
 .F I=2,4,6 D:$P(STR,U,I)]""
 ..;Validate contact type
 ..S CTYP=$P(STR,U,I+1)
 ..S CPOS=$S(CTYP="TE":1,CTYP="FX":2,CTYP="EM":3,CTYP="EX":4,1:0)
 ..Q:'CPOS
 ..;Save only first occurance of each type of contact
 ..S:$P(CONTACTS,U,CPOS)="" $P(CONTACTS,U,CPOS)=$P(STR,U,I)
 ;
 ;Allow for misfiled legacy contact data
 I FOUND,NAME="",WEB="",CONTACTS="" S FOUND=0
 ;Return found_web_phone_fax_email
 Q FOUND_U_NAME_U_WEB_U_CONTACTS
 ;
ADD(PRCABN) ;Update AR Transaction file #433 with comment type transaction
 ;PRCABN = Bill/Claim IEN for file #399.
 ;called only if 'ERA Contact Information' type comment is not found
 ;serves as a notice to the user that the contact data came from the 835 ERA. Called from IBJTTC
 ;
 ;Note; PJH 8/11/2010 - see ADJUST^RCJIBFN3 (called by ARCA^IBJTA1)
 ;
 N AUTHDT,IBIFN,MRADT,STATUS
 S IBIFN=PRCABN
 S STATUS=$P($G(^DGCR(399,IBIFN,0)),U,13)
 S AUTHDT=$P($G(^DGCR(399,IBIFN,"S")),U,10)
 S MRADT=$P($G(^DGCR(399,IBIFN,"S")),U,7)
 ;
 ;If claim status is "NOT REVIEWED" or claim status is "CANCELLED"
 ;with neither MRA request date nor Authorization date present
 ;comment may not be added
 I STATUS=1!(STATUS=7&(MRADT="")&(AUTHDT="")) Q
 ;
 ;If claim status is "REQUEST MRA" or claim status is "CANCELLED"
 ;with MRA request date present, but no Authorization date comment
 ;cannot be added
 I STATUS=2!(STATUS=7&(MRADT'="")&(AUTHDT="")) Q
 ;
 ;Ignore bill cancelled in IB
 I '$D(^PRCA(430,PRCABN,2,0)) Q
 ;
 ;Ignore Archived bill
 I $P($G(^PRCA(430,PRCABN,0)),"^",8)=49 Q
 ;
 ;Build AR Transaction
 ;
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY
 ;
 ;Create stub record in 433
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 ;
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 ;
 ;Direct update of [PRCA COMMENT] edit template fields 
 ;(excluding Date of Contact, Extended Comments and Follow-up Date)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////"_PRCABN ;Bill Number
 S DR=DR_";3////0" ;Calm Code Done
 S DR=DR_";12////"_$O(^PRCA(430.3,"AC",17,0)) ;Transaction Type
 S DR=DR_";15////0" ;Transaction Amount
 S DR=DR_";42////.5" ;Processed by POSTMASTER
 S DR=DR_";11////"_DT ;Transaction date
 S DR=DR_";4////2" ;Transaction status (complete)
 S DR=DR_";5.02////ERA Payer Contact Information" D ^DIE
 ;
 ;Leave validation checks in place
 I $P($G(^PRCA(433,PRCAEN,5)),"^",2)=""!'$P(^PRCA(433,PRCAEN,1),"^") S PRCACOMM="TRANSACTION INCOMPLETE" D DELETE^PRCAWO1 K PRCACOMM Q
 ;
 I '$D(PRCAD("DELETE")) S RCASK=1 D TRANUP^PRCAUTL,UPPRIN^PRCADJ
 ;
 I $P($G(^RCD(340,+$P(^PRCA(430,PRCABN,0),"^",9),0)),"^")[";DPT(" D
 .;Ensure comment does not appear on patient statement
 .S $P(^PRCA(433,PRCAEN,0),"^",10)=1
 Q
 ;
 ;Audit Comment from EOB Move/Copy
AUDIT(ORIG,TEXT,MODE) ;
 ; ORIG = ien of entry in 361.1
 ; TEXT = move/copy reason
 ; MODE = is this a move or a copy event
 ;
 ;Translate EOB ien  to claim number IA 4051
 N PRCABN
 S PRCABN=$P($G(^IBM(361.1,ORIG,0)),U) Q:'PRCABN
 ;Build AR Transaction
 ;
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY
 ;
 ;Create stub record in 433
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 ;
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 ;
 N MTEXT,INIT
 S INIT=$$GET1^DIQ(200,DUZ,1)
 S:INIT="" INIT="USER UNK."
 S MTEXT="EEOB MOVED BY "_INIT
 I MODE="C" S MTEXT="EEOB COPIED BY "_INIT
 I MODE="R" S MTEXT="EEOB REMOVED BY "_INIT
 I MODE="W" S MTEXT="EEOB MOVE/COPY IN SPLIT/EDIT"
 ;Direct update of [PRCA COMMENT] edit template fields 
 ;(excluding Date of Contact, Extended Comments and Follow-up Date)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////"_PRCABN ;Bill Number
 S DR=DR_";3////0" ;Calm Code Done
 S DR=DR_";12////"_$O(^PRCA(430.3,"AC",17,0)) ;Transaction Type
 S DR=DR_";15////0" ;Transaction Amount
 S DR=DR_";42////"_DUZ ;Processed by  ; kl - 8/23/11 move/copy needs to have the actual user not postmaster
 S DR=DR_";11////"_DT ;Transaction date
 S DR=DR_";4////2" ;Transaction status (complete)
 S DR=DR_";5.02////"_MTEXT ;Brief comment
 D ^DIE
 ;Store justification text in comment field
 N DA,DIC,DLAYGO,DR,X
 S DA(1)=PRCAEN
 S DIC="^PRCA(433,"_DA(1)_",7,",DIC(0)="L",X=$P(TEXT,U)
 D FILE^DICN
 ;Store auto generated text from stand alone option in comment field
 I $P(TEXT,U,2)]"" D
 .N DA,DIC,DLAYGO,DR,X
 .S DA(1)=PRCAEN
 .S DIC="^PRCA(433,"_DA(1)_",7,",DIC(0)="L",X="- "_$P(TEXT,U,2)
 .D FILE^DICN
 Q
