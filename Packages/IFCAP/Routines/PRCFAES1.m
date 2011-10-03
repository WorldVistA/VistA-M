PRCFAES1 ;WISC/LEM-ESIG MAINTENANCE ROUTINE ;5/20/93  9:27 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ROUTINE FOR MAINTAINING FIELD 5.5 (ELECTRONIC SIGNATURE) FILE 421.2
DECODE(LEVEL0) ;Extrinsic Function to return hashed electronic sig to readable form.
 ;returns "" if unsuccessful
 NEW RECORD,RECORD05,VERSION,PERSON,SIG,CHECKSUM
 ;get record and check version
 S RECORD=$G(^PRCF(421.2,LEVEL0,0)) I RECORD="" QUIT ""
 S RECORD05=$G(^PRCF(421.2,LEVEL0,.5))
 S VERSION=$P(RECORD05,"^",1)
 S PERSON=+$P(RECORD,"^",5)
 I VERSION'="",VERSION'=1 Q ""
 S SIG=$P(RECORD,"^",6)
D1 ;decode e signature for version 1
 S RECORD=$G(^PRCF(421.2,LEVEL0,0))
 S CHECKSUM=$$SUM^PRCUESIG(LEVEL0_"^"_$$STRING(RECORD))
 QUIT $$DECODE^PRCUESIG(SIG,PERSON,CHECKSUM)
ENCODE(LEVEL0,USERNUM,Y) ;Encode e signature for version 1 only
 ;Parameter passing entry point
 NEW RECORD,RECORD05,SIGBLOCK,CHECKSUM,OLDUSER
 ;get record
 S USERNUM=+USERNUM
 S RECORD=$G(^PRCF(421.2,LEVEL0,0))
 S RECORD05=$G(^PRCF(421.2,LEVEL0,.5))
 I RECORD="" S Y=-1 QUIT  ;-1 no transaction record
 S OLDUSER=+$P(RECORD,"^",5)
 I OLDUSER>0,+$P(RECORD05,"^",1)<1,$P(RECORD,"^",6)'="" S Y=-4 QUIT  ;-4 cannot re-sign record with version <1
 I OLDUSER>0 S USERNUM=OLDUSER
 I USERNUM=0 S Y=-3 QUIT  ;-3 no usernumber for filing
 S SIGBLOCK=$P(RECORD05,"^",2)
 I SIGBLOCK="" S SIGBLOCK=$P($G(^VA(200,USERNUM,20)),"^",2)
 I SIGBLOCK="" S Y=-2 QUIT  ;-2 = no signature block in file 200
 I OLDUSER=0 S $P(RECORD,"^",5)=USERNUM
 S:$P(RECORD,"^",10)="" $P(RECORD,"^",10)=$$NOW^PRCUESIG
 S CHECKSUM=$$SUM^PRCUESIG(LEVEL0_"^"_$$STRING(RECORD))
 S $P(RECORD,"^",6)=$$ENCODE^PRCUESIG(SIGBLOCK,USERNUM,CHECKSUM)
 S $P(RECORD05,"^",1,2)="1^"_SIGBLOCK
 S ^PRCF(421.2,LEVEL0,0)=RECORD
 S ^PRCF(421.2,LEVEL0,.5)=RECORD05
 S Y=1 QUIT
REMOVE(LEVEL0) ;Entry point to remove e signature from record
 ;NOT an extrinsic function
 NEW RECORD,RECORD05
 S RECORD=$G(^PRCF(421.2,LEVEL0,0))
 S RECORD05=$G(^PRCF(421.2,LEVEL0,.5))
 S $P(RECORD,"^",5,6)="^"
 S $P(RECORD,"^",10)=""
 S $P(RECORD05,"^",2)=""
 S ^PRCF(421.2,LEVEL0,0)=RECORD
 S ^PRCF(421.2,LEVEL0,.5)=RECORD05
 QUIT
VERIFY(LEVEL0)      ;extrinsic function to verify version 1 signature.  Returns 1 if valid, 0 if not valid
 NEW RECORD05,VERSION,SIGBLOCK
 ;get record variables
 S RECORD05=$G(^PRCF(421.2,LEVEL0,.5))
 S VERSION=$P(RECORD05,"^",1),SIGBLOCK=$P(RECORD05,"^",2)
 I VERSION_SIGBLOCK="" QUIT 1
 QUIT ($$DECODE(LEVEL0,TRANS)=SIGBLOCK)
STRING(X)          ;Build String of critical fields
 NEW RECORD
 Q $P(X,"^",1)_"^"_$P(X,"^",10)
