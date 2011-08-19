PRCSC4 ;WISC/LEM-ESIG MAINTENANCE ROUTINE ;5/20/93  9:13 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ROUTINE FOR MAINTAINING FIELD 63 (LOG CODE CODE SHEETS ELEC.SIG.), FILE 410
DECODE(LEVEL0) ;Extrinsic Function to return hashed electronic sig to readable form.
 ;returns "" if unsuccessful
 NEW RECORD,RECRD100,VERSION,PERSON,SIG,CHECKSUM
 ;get record and check version
 S RECORD=$G(^PRCS(410,LEVEL0,0)) I RECORD="" QUIT ""
 S RECRD100=$G(^PRCS(410,LEVEL0,100))
 S VERSION=$P(RECRD100,"^",9)
 S PERSON=+$P(RECRD100,"^",4)
 I VERSION'="",VERSION'=1 Q ""
 S SIG=$P(RECRD100,"^",5)
D1 ;decode e signature for version 1
 S CHECKSUM=$$SUM^PRCUESIG(LEVEL0_"^"_$$STRING(RECRD100))
 QUIT $$DECODE^PRCUESIG(SIG,PERSON,CHECKSUM)
ENCODE(LEVEL0,USERNUM,Y) ;Encode e signature for version 1 only
 ;Parameter passing entry point
 NEW RECORD,RECRD100,SIGBLOCK,CHECKSUM,OLDUSER
 ;get record
 S USERNUM=+USERNUM
 I USERNUM=0 S Y=-3 QUIT  ;-3 no user num available
 S SIGBLOCK=$P($G(^VA(200,USERNUM,20)),"^",2)
 I SIGBLOCK="" S Y=-2 QUIT  ;-2 no sigblock in file 200
 S RECORD=$G(^PRCS(410,LEVEL0,0))
 S RECRD100=$G(^PRCS(410,LEVEL0,100))
 I RECORD="" S Y=-1 QUIT  ;-1 no transaction record
 I $P(RECRD100,"^",5)'="" S Y=-4 QUIT  ;-4 cannot re-sign record
 S OLDUSER=+$P(RECRD100,"^",4)
 I OLDUSER=0 S $P(RECRD100,"^",4)=USERNUM
 I OLDUSER>0 S USERNUM=OLDUSER
 S:$P(RECRD100,"^",6)="" $P(RECRD100,"^",6)=$$NOW^PRCUESIG
 S CHECKSUM=$$SUM^PRCUESIG(LEVEL0_"^"_$$STRING(RECRD100))
 S $P(RECRD100,"^",5)=$$ENCODE^PRCUESIG(SIGBLOCK,USERNUM,CHECKSUM)
 S $P(RECRD100,"^",9,10)="1^"_$$SUM^PRCUESIG(SIGBLOCK)
 S ^PRCS(410,LEVEL0,100)=RECRD100
 S Y=1 QUIT
REMOVE(LEVEL0) ;Entry point to remove e signature from record
 ;NOT an extrinsic function
 NEW RECRD100
 S RECRD100=$G(^PRCS(410,LEVEL0,100))
 S $P(RECRD100,"^",4,6)="^^"
 S $P(RECRD100,"^",10)=""
 S ^PRCS(410,LEVEL0,100)=RECRD100
 QUIT
VERIFY(LEVEL0)      ;extrinsic function to verify version 1 signature.  Returns 1 if valid, 0 if not valid
 NEW RECRD100,VERSION,SIGBLOCK
 ;get record variables
 S RECRD100=$G(^PRCS(410,LEVEL0,100))
 S VERSION=$P(RECRD100,"^",9),SIGBLOCK=$P(RECRD100,"^",10)
 I VERSION_SIGBLOCK="" QUIT 1
 QUIT ($$SUM^PRCUESIG($$DECODE(LEVEL0))=SIGBLOCK)
STRING(X100)          ;Build String of critical fields
 NEW RECRD100,SIGBLOCK,CHECKSUM,OLDUSER
 Q $P(X100,"^",6)_"^"_$P(X100,"^",7)_"^"_$P(X100,"^",8)
