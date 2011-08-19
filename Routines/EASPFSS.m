EASPFSS ;OAK/ELZ - PFSS SUPPORT FOR INBOUND LTC STATUS MESSAGE; 10/6/05
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**67**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
MSG ; receives HL7 message from COTS product
 N EASMSG,EASHEAD,EASICN,EASDFN,EASSSN,EASVACLM,EASALIAS,EASSTAT,EASD,EAST,EASRESLT,EASDT,EASLOS,EASCODE,SEG,EASX
 ;
 ;parse message
 S EASSTAT=$$STARTMSG^HLPRS(.EASMSG,HLMTIENS,.EASHEAD)
 I 'EASSTAT S HLERR="Unable to start parse of message" G MSGQ
 ;
 F  Q:'$$NEXTSEG^HLPRS(.EASMSG,.SEG)  D
 . F EAST=3:1 S EASD=$P($T(HL7DATA+EAST),";",4) Q:EASD=""  D
 . . I $P(EASD,"^",2)=SEG("SEGMENT TYPE") D
 . . . S @$P(EASD,"^")=$$GET^HLOPRS(.SEG,$P(EASD,"^",3),$P(EASD,"^",4),$P(EASD,"^",5),$P(EASD,"^",6))
 . . . S EASCODE=$P(EASD,"^",7,99)
 . . . I $L(EASCODE),$L(@$P(EASD,"^")) S X=@$P(EASD,"^") X EASCODE S @$P(EASD,"^")=X
 ;
 ;check out data received from message
 S DFN=$$PATIENT($G(EASICN),$G(EASDFN),$G(EASSSN),$G(EASVACLM),$G(EASALIAS)) I 'DFN S HLERR="Unable to validate the patient" G MSGQ
 ;
 ;data for $$copay^easeccal call
 ;  input:  Patient's DFN, Date of Care, Length of stay
 ; output:  exemption flag ^ exemption reason (714.1 pointer) ^ <181 $ amount ^ >180 $ amount ^ opt $ amount
 ; 
 S EASX=$$FILE(DFN,EASDT,EASLOS,$$COPAY^EASECCAL(DFN,EASDT,EASLOS)) I EASX<1 S HLERR="Unable to create 714.5 record" G MSGQ
 ;
 S EASX=$$QUEUE^VDEFQM("ADT^A08","SUBTYPE=LTUPI^IEN="_EASX,,"PFSS OUTBOUND") I 'EASX S HLERR="Unable to queue to VDEF"
 ;
MSGQ ;
 S HLA("HLA",1)="MSA"_HL("FS")_$S('$D(HLERR):"AA",1:"AE")_HL("FS")_HL("MID")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.EASRESLT)
 ;
 Q
 ;
FILE(DFN,EASDT,EASLOS,EASDAT) ; creates a new entry in 714.5 and returns ien
 ;
 N DIC,DO,X,Y
 S DIC="^EASPFS(714.5,",DIC(0)="",X=DFN
 S DIC("DR")=".02////^S X=EASDT;.03////^S X=EASLOS;.04////^S X=+EASDAT;.06////^S X=+$P(EASDAT,""^"",3);.07////^S X=+$P(EASDAT,""^"",4);.08////^S X=+$P(EASDAT,""^"",5)"
 S:$P(EASDAT,"^",2) DIC("DR")=DIC("DR")_";.05////^S X=$P(EASDAT,""^"",2)"
 D FILE^DICN
 Q +Y
 ;
PATIENT(EASICN,EASDFN,EASSSN,EASVACLM,EASALIAS) ; this function will receive
 ; several patient data elements and validate them.  Assuming the data
 ; meets expected requirements, the function will return the patient's
 ; DFN.  The requirement is ICN is a must, the patient must also match
 ; at least 2 other data elements.
 ;
 N DFN,EASMATCH,EASX
 S (EASMATCH,EASX)=0
 S DFN=$$DFN(EASICN) I 'DFN G PATQ
 I DFN=EASDFN S EASMATCH=1
 I $P($G(^DPT(DFN,0)),"^",9)=EASSSN S EASMATCH=EASMATCH+1 I EASMATCH>1 G PATQ
 I $P($G(^DPT(DFN,.31)),"^",3)=EASVACLM S EASMATCH=EASMATCH+1 I EASMATCH>1 G PATQ
 F  S EASX=$O(^DPT(DFN,.01,EASX)) Q:'EASX!(EASMATCH>1)  I $P($G(^DPT(DFN,.01,EASX,0)),"^",2)=EASALIAS S EASMATCH=EASMATCH+1 Q
 I EASMATCH<2 S DFN=0
PATQ ;
 Q DFN
 ;
DFN(EASICN) ; returns dfn for icn ia #2701
 N DFN ; check to see if mpi software installed
 S DFN=$S($L($T(GETDFN^MPIF001)):+$$GETDFN^MPIF001(+EASICN),1:0)
 Q $S(DFN>0:DFN,1:0)
 ;
HL7DATA ; hl7 data mapping
 ; format:  description ; EAS Variable ^ segment ^ seq ^ comp ^ subcomp ^
 ;          extract code
 ;;patient icn;EASICN^PID^3^1^1^1
 ;;patient dfn;EASDFN^PID^3^1^1^2^S X=$E(X,4,99)
 ;;patient ssn;EASSSN^PID^3^1^1^3
 ;;patient va claim;EASVACLM^PID^3^1^1^4
 ;;patient alias ssn;EASALIAS^PID^3^1^1^5
 ;;last month date;EASDT^OBX^14^1^^^S X=$$FMDATE^HLFNC(X)
 ;;ltc los;EASLOS^OBX^5
 ;;
 ;
