PRPFSIG1 ;WISC@ALTOONA/CTB-ESIG MAINTENANCE ROUTINE ;11/22/96  4:45 PM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
 ;ROUTINE FOR MAINTAINING FIELD 14 (ELECTRONIC SIGNATURE CIDE), FILE 470.1
DECODE(LEVEL0) ;Extrinsic Function to return hashed electronic sig to readable form.
 ;returns "" if unsuccessful
 NEW RECORD,VERSION,PERSON,SIG,CHECKSUM
 ;get record and check version
 S RECORD=$G(^PRPF(470.1,LEVEL0,0)) I RECORD="" QUIT ""
 S VERSION=$P(RECORD,"^",22)
 S PERSON=+$P(RECORD,"^",14)
 I VERSION'="",VERSION'=1 Q ""
 S SIG=$P(RECORD,"^",15)
 I VERSION=1 G D1
D ;decode e signature less than version 1
 S X=$$DECODE^PRPFSIG(SIG,LEVEL0,PERSON)
 QUIT X
D1 ;decode e signature for version 1
 S CHECKSUM=$$SUM^PRPFSIG(LEVEL0_"^"_$$STRING(RECORD))
 QUIT $$DECODE^PRPFSIG(SIG,PERSON,CHECKSUM)
ENCODE(LEVEL0,USERNUM,Y) ;Encode e signature for version 1 only
 ;Parameter passing entry point
 NEW RECORD,RECORD4,SIGBLOCK,CHECKSUM,OLDUSER
 ;get record
 S RECORD=$G(^PRPF(470.1,LEVEL0,0))
 I RECORD="" S Y=-1 QUIT  ;-1 no master record
 S OLDUSER=+$P(RECORD,"^",14)
 I OLDUSER=0 S $P(RECORD,"^",14)=USERNUM
 I OLDUSER>0 S USERNUM=OLDUSER
 S USERNUM=+USERNUM
 I USERNUM=0 S Y=-3 QUIT  ;-3 no user num available
 S SIGBLOCK=$P($G(^VA(200,USERNUM,20)),"^",2)
 I SIGBLOCK="" S Y=-2 QUIT  ;-2 no sigblock in file 200
 I $P(RECORD,"^",15)'="" S Y=-4 QUIT  ;-4 cannot re-sign record
 S:$P(RECORD,"^",23)="" $P(RECORD,"^",23)=$$NOW^PRPFSIG
 S CHECKSUM=$$SUM^PRPFSIG(LEVEL0_"^"_$$STRING(RECORD))
 S $P(RECORD,"^",15)=$$ENCODE^PRPFSIG(SIGBLOCK,USERNUM,CHECKSUM)
 S $P(RECORD,"^",22)=1,$P(RECORD,"^",17)=$$SUM^PRPFSIG(SIGBLOCK)
 S ^PRPF(470.1,LEVEL0,0)=RECORD
 S Y=1 QUIT
REMOVE(LEVEL0) ;Entry point to remove e signature from record
 ;NOT an extrinsic function
 NEW I,RECORD
 S RECORD=$G(^PRPF(470.1,LEVEL0,0))
 F I=14,15,17,22,23 S $P(RECORD,"^",I)=""
 S ^PRPF(470.1,LEVEL0,0)=RECORD
 QUIT
VERIFY(LEVEL0)      ;extrinsic function to verify version 1 signature.  Returns 1 if valid, 0 if not valid
 NEW RECORD,VERSION,VALCODE
 ;get record variables
 S RECORD=$G(^PRPF(470.1,LEVEL0,0))
 S VERSION=$P(RECORD,"^",22),VALCODE=$P(RECORD,"^",17)
 I VERSION_VALCODE="" QUIT 1
 QUIT ($$SUM^PRPFSIG($$DECODE(LEVEL0))=VALCODE)
STRING(X)  ;Build String of critical fields
 Q $P(X,"^",1,13)_"^"_$P(X,"^",16)
