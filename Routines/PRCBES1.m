PRCBES1 ;WISC@ALTOONA/CTB-ESIG MAINTENANCE ROUTINE ;1/15/95  12:28
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;ROUTINE FOR MAINTAINING FIELD 12.5 (ELECTRONIC SIGNATURE), FILE 421
DECODE(LEVEL0) ;Extrinsic Function to return hashed electronic sig to readable form.
 ;returns "" if unsuccessful
 NEW RECORD,RECORD4,VERSION,PERSON,SIG,CHECKSUM
 ;get record and check version
 S RECORD=$G(^PRCF(421,LEVEL0,0)) I RECORD="" QUIT ""
 S RECORD4=$G(^PRCF(421,LEVEL0,4))
 S VERSION=$P(RECORD4,"^",11)
 S PERSON=+$P(RECORD,"^",11)
 I VERSION'="",VERSION'=1 Q ""
 S SIG=$P(RECORD,"^",17)
 I VERSION=1 G D1
D ;decode e signature less than version 1
 S X=$$DECODE^PRCUESIG(SIG,LEVEL0,PERSON)
 QUIT X
D1 ;decode e signature for version 1
 S CHECKSUM=$$SUM^PRCUESIG(LEVEL0_"^"_$$STRING(RECORD,RECORD4))
 QUIT $$DECODE^PRCUESIG(SIG,PERSON,CHECKSUM)
ENCODE(LEVEL0,USERNUM,Y) ;Encode e signature for version 1 only
 ;Parameter passing entry point
 NEW RECORD,RECORD4,SIGBLOCK,CHECKSUM,OLDUSER
 ;get record
 S USERNUM=+USERNUM
 I USERNUM=0 S Y=-3 QUIT  ;-3 no user num available
 S SIGBLOCK=$P($G(^VA(200,USERNUM,20)),"^",2)
 I SIGBLOCK="" S Y=-2 QUIT  ;-2 no sigblock in file 200
 S RECORD=$G(^PRCF(421,LEVEL0,0))
 S RECORD4=$G(^PRCF(421,LEVEL0,4))
 I RECORD="" S Y=-1 QUIT  ;-1 no 2237 record
 I $P(RECORD,"^",17)'="" S Y=-4 QUIT  ;-4 cannot re-sign record
 S OLDUSER=+$P(RECORD,"^",11)
 I OLDUSER=0 S $P(RECORD,"^",11)=USERNUM
 I OLDUSER>0 S USERNUM=OLDUSER
 S:$P(RECORD4,"^",13)="" $P(RECORD4,"^",13)=$$NOW^PRCUESIG
 S CHECKSUM=$$SUM^PRCUESIG(LEVEL0_"^"_$$STRING(RECORD,RECORD4))
 S $P(RECORD,"^",17)=$$ENCODE^PRCUESIG(SIGBLOCK,USERNUM,CHECKSUM)
 S $P(RECORD4,"^",11,12)="1^"_$$SUM^PRCUESIG(SIGBLOCK)
 S ^PRCF(421,LEVEL0,0)=RECORD
 S ^PRCF(421,LEVEL0,4)=RECORD4
 S Y=1 QUIT
REMOVE(LEVEL0) ;Entry point to remove e signature from record
 ;NOT an extrinsic function
 NEW I,RECORD,RECORD4
 S RECORD4=$G(^PRCF(421,LEVEL0,4))
 S RECORD=$G(^PRCF(421,LEVEL0,0))
 F I=11,17 S $P(RECORD,"^",I)=""
 S $P(RECORD4,"^",12,13)="^"
 S ^PRCF(421,LEVEL0,1)=RECORD1
 S ^PRCF(421,LEVEL0,4)=RECORD4
 QUIT
VERIFY(LEVEL0)      ;extrinsic function to verify version 1 signature.  Returns 1 if valid, 0 if not valid
 NEW RECORD,RECORD4,VERSION,SIGBLOCK
 ;get record variables
 S RECORD=$G(^PRCF(421,LEVEL0,0))
 S RECORD4=$G(^PRCF(421,LEVEL0,4))
 S VERSION=$P(RECORD4,"^",11),SIGBLOCK=$P(RECORD4,"^",12)
 I VERSION_SIGBLOCK="" QUIT 1
 QUIT ($$SUM^PRCUESIG($$DECODE(LEVEL0))=SIGBLOCK)
STRING(X,X4)          ;Build String of critical fields
 Q $P(X,"^",1,2)_"^"_$P(X,"^",4,10)_$P(X,"^",18)_"^"_$P(X4,"^",13)
