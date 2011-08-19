DVBCHLUT ;ALB/JLU-Utility routine for the HL7 interface ;1/28/93
 ;;2.7;AMIE;;Apr 10, 1995
 ;
OBR ;sets up the OBR segment
 ;called by DVBCHLQ and DVBCHLOR
 S $P(DVBC1,HLFS,23)=""
 S $P(DVBC1,HLFS,1)="OBR"
 S $P(DVBC1,HLFS,5)=DVBCRDFN_$E(HLECH)_DVBCEXAM_$E(HLECH)_"L" ;ifn of request^ifn of exam^L
 S $P(DVBC1,HLFS,8)=$$HLDATE^HLFNC(DVBCRQDT) ;request date
 S $P(DVBC1,HLFS,9)=HLQ ;unused required
 S $P(DVBC1,HLFS,10)=HLQ ;unused required
 S $P(DVBC1,HLFS,15)=HLQ ;unused required
 S $P(DVBC1,HLFS,$S($D(DVBCPLCR):19,1:21))=DVBCEXTY ;exam type
 S $P(DVBC1,HLFS,23)=HLDT1 ;time results reported
 S HLSDATA(DVBCSEG)=DVBC1
 S DVBCSEG=DVBCSEG+1
 K DVBC1
 Q
 ;
PID ;setting up PID segment
 ;called by DVBCHLQ and DVBCHLOR
 S $P(DVBC1,HLFS,20)=""
 S $P(DVBC1,HLFS,1)="PID"
 S $P(DVBC1,HLFS,4)=$$M10^HLFNC(DVBCPDFN) ;internal patient id
 S $P(DVBC1,HLFS,6)=$$HLNAME^HLFNC(VADM(1)) ;patient name
 S $P(DVBC1,HLFS,8)=$$HLDATE^HLFNC(VADM(3)) ;dob
 S $P(DVBC1,HLFS,9)=$S(VADM(5)]"":$P(VADM(5),U,1),1:"U") ;sex
 S $P(DVBC1,HLFS,11)=$S(+VADM(8)=1!(+VADM(8)=2):"H",+VADM(8)=3:"A",+VADM(8)=4:"B",+VADM(8)=5:"R",+VADM(8)=6:"C",1:HLQ) ;setting ethnic group
 S $P(DVBC1,HLFS,20)=$P(VADM(2),U,1) ;ssn
 S HLSDATA(DVBCSEG)=DVBC1
 S DVBCSEG=DVBCSEG+1
 K DVBC1
 Q
 ;
ORC ;builds the ORC segment
 S $P(DVBC1,HLFS,10)=""
 S $P(DVBC1,HLFS,1)="ORC"
 S $P(DVBC1,HLFS,2)=DVBCOC ;control order for new orders
 S $P(DVBC1,HLFS,10)=HLDT1
 S HLSDATA(DVBCSEG)=DVBC1
 S DVBCSEG=DVBCSEG+1
 K DVBC1
 Q
 ;
LOCK(A,B) ;
 ;this function tries to lock the 396.3 and 396.4 records
 L +^DVB(396.3,A):2
 I '$T S HLERR="Record currently accessed by another user" D UNLOCK(A,B) Q 0
 L +^DVB(396.4,B):2
 I '$T S HLERR="Exam currently being accessed by another user" D UNLOCK(A,B) Q 0
 Q 1
 ;
UNLOCK(A,B) ;
 ;this subroutine unlocks the 396.3 and 396.4 records
 L -^DVB(396.3,A)
 L -^DVB(396.4,B)
 Q
 ;
HASH ;hashes the electronic signature code
 Q:'$D(HLESIG)
 N X,X1,X2
 S X=HLESIG,X1=HLDUZ,X2=DVBCUEX
 D EN^XUSHSHP
 S DVBCELCT=X
 Q
 ;
