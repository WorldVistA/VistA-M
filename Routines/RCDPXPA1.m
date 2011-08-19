RCDPXPA1 ;WISC/RFJ-server, utilities for transmission file 344.2 ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,150**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ADDTRAN(DATE) ;  if the transmission date is not entered, add it
 ;  already in file
 I $D(^RCY(344.2,+DATE,0)) Q 1
 ;
 ;  add it
 N %DT,D0,DA,DD,DI,DIC,DIE,DINUM,DLAYGO,DO,DQ,DR,X,Y
 S DIC="^RCY(344.2,",DIC(0)="L",DLAYGO=344.2
 ;  .02 = total sequences (set to 0) .03 = total dollars (set to 0)
 ;  .04 = status (set to receiving)  .06 = checksum (set to 0)
 S DIC("DR")=".02////0;.03////0;.04////r;.05///TODAY;.06////0"
 S (X,DINUM)=DATE
 D FILE^DICN
 I Y>0 Q 1
 Q 0
 ;
 ;
TRANDOLL(DA,SEQUENCE,DOLLARS) ;  store the total sequences and total dollars
 I '$D(^RCY(344.2,+DA,0)) Q
 N D,D0,DI,DIC,DIE,DQ,DR,X
 S (DIC,DIE)="^RCY(344.2,"
 S DR=""
 ;  only store total sequence and dollars if not zero, otherwise it
 ;  may reset the values to zero
 I SEQUENCE S DR=".02////"_SEQUENCE_";"
 I DOLLARS S DR=DR_".03////"_DOLLARS_";"
 I DR="" Q
 D ^DIE
 Q
 ;
 ;
TRANCSUM(TRANSDA,SEQUENCE,CHECKSUM) ;  store the transmissions checksum
 N D,D0,DA,DI,DIC,DIE,DQ,DR,X
 S (DIC,DIE)="^RCY(344.2,"_TRANSDA_",1,"
 S DA(1)=TRANSDA,DA=SEQUENCE
 S DR=".05///"_CHECKSUM_";"
 D ^DIE
 Q
 ;
 ;
TRANSTAT(DA,STATUS) ;  store the transmissions status
 I '$D(^RCY(344.2,+DA,0)) Q
 N %,%DT,D,D0,DDER,DI,DIC,DIE,DQ,DR,X
 S (DIC,DIE)="^RCY(344.2,"
 S DR=".04///"_STATUS_";.05///TODAY;"
 D ^DIE
 Q
 ;
 ;
TRANERR(DA,RCDPXMZ,ERROR) ;  store the error message
 I '$D(^RCY(344.2,+DA,0)) Q
 N DA1
 S DA1=$P($G(^RCY(344.2,DA,2,0)),"^",3)+1
 S ^RCY(344.2,DA,2,DA1,0)="Message: "_RCDPXMZ_", Error: "_ERROR
 S ^RCY(344.2,DA,2,0)="^^"_DA1_"^"_DA1_"^"_DT_"^"
 Q
 ;
 ;
ADDSEQ(TRANSDA,SEQUENCE) ;  add sequence for transmission (in transda)
 I 'SEQUENCE Q 0
 I '$D(^RCY(344.2,+TRANSDA,0)) Q 0
 I $D(^RCY(344.2,TRANSDA,1,SEQUENCE,0)) Q SEQUENCE
 I '$D(^RCY(344.2,TRANSDA,1,0)) S ^(0)="^344.21^"
 N D0,DA,DI,DIC,DIE,DINUM,DLAYGO,DO,DQ,DR,X,Y
 ;
 S (DINUM,X)=+SEQUENCE
 S DA(1)=TRANSDA
 S DIC="^RCY(344.2,"_TRANSDA_",1,",DIC(0)="L",DLAYGO=344.21
 S DIC("DR")=".12////"_DUZ_";.06///TODAY;"
 D FILE^DICN
 Q +Y
 ;
 ;
SEQUDOLL(TRANSDA,SEQUENCE,COUNT,DOLLARS,MAILMESS) ;  store the total
 ;  transactions (in count), dollars (in dollars), and mail message
 ;  number for the transmission sequence
 N D,D0,DA,DI,DIC,DIE,DQ,DR,X
 S (DIC,DIE)="^RCY(344.2,"_TRANSDA_",1,"
 S DA(1)=TRANSDA,DA=SEQUENCE
 S DR=".02///"_COUNT_";.03///"_DOLLARS_";"
 I MAILMESS S DR=DR_".04////"_MAILMESS_";"
 D ^DIE
 Q
 ;
 ;
DELETRAN(DA) ;  delete the transmission from the file
 I '$D(^RCY(344.2,+DA,0)) Q
 N %,DIC,DIK
 S DIK="^RCY(344.2,"
 D ^DIK
 Q
