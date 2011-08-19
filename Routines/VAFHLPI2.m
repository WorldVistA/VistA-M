VAFHLPI2 ;ALB/BWF - EXTENSION OF PID SEGMENT BUILDER ;23-APR-2003
 ;;5.3;Registration;**508**;Aug 13, 1993
 ;
 Q
 ;
SEQ11(TYPE,HLQ) ;Patient Address (seq #11)
 ;
 ;Input  : TYPE - Qualifiers denoting which type of address to return
 ;                P = Include permanent address
 ;                C = Include confidential address
 ;               "" = Only return permanent address (default)
 ;         HLQ - HL7 null designation
 ;Assumed: VAPA() - Output of call to ADD^VADPT
 ;Output : None - sets nodes in array VAFY
 ;         VAFY(11,1,1..X) = Primary address
 ;         VAFY(11,2..X,1..X) = Confidential Address
 ;Notes  : Validity and existance of input is assumed
 ;       : Assumes no individual component is greater than 245
 ;         characters long
 ;       : If TYPE = "", line 3 of the permanent address will be added
 ;         to the end of line 2 (instead of being returned separately)
 ;
 ;Declare variables
 N NODE
 K VAFY(11)
 I '$D(HLQ) S HLQ=$C(34,34)
 S TYPE=$G(TYPE)
 I (TYPE'["P"),(TYPE'["C") S TYPE=""
 S NODE=1
 I TYPE="" D PERMADD
 I (TYPE["P") D PERMADD
 I (TYPE["C") D CONFADD
 Q
 ;
PERMADD ; Put permanent address into output array
 N X
 S VAFY(11,NODE,1)=$S(VAPA(1)'="":VAPA(1),1:HLQ)
 S VAFY(11,NODE,2)=$S(VAPA(2)'="":VAPA(2),1:HLQ)
 I TYPE'["P" S X=VAPA(2)_" "_VAPA(3),VAFY(11,NODE,2)=$S(X'=" ":X,1:HLQ)
 S VAFY(11,NODE,3)=$S(VAPA(4)'="":VAPA(4),1:HLQ)
 S X=$P($G(^DIC(5,+VAPA(5),0)),"^",2)
 S VAFY(11,NODE,4)=$S(X'="":X,1:HLQ)
 S VAFY(11,NODE,5)=$S($P(VAPA(6),U,1)'="":$P(VAPA(6),U,1),1:HLQ)
 I TYPE["P" D
 .S VAFY(11,NODE,6)=""
 .S VAFY(11,NODE,7)="P"
 .S VAFY(11,NODE,8)=$S(VAPA(3)'="":VAPA(3),1:HLQ)
 .S X=$P($G(^DIC(5,+VAPA(5),1,+VAPA(7),0)),"^",3)
 .S VAFY(11,NODE,9)=$S(X'="":X,1:HLQ)
 S NODE=NODE+1
 Q
CONFADD ;Put confidential address into output array
 N LOOP,ADDTYPE,CSTATE,CCOUNTY,CSTDATE,CENDATE
 S CSTATE=$P($G(^DIC(5,+VAPA(17),0)),"^",2)
 S CCOUNTY=$P($G(^DIC(5,+VAPA(17),1,+VAPA(19),0)),"^",3)
 S CSTDATE=$$HLDATE^HLFNC($P(VAPA(20),"^",1))
 S CENDATE=$$HLDATE^HLFNC($P(VAPA(21),"^",1))
 F ADDTYPE=1:1:5 D
 .I +VAPA(12) I $P($G(VAPA(22,ADDTYPE)),"^",3)="Y" D CONFACT Q
 .D CONFIN
 Q
CONFACT ;Active confidential address type
 S VAFY(11,NODE,1)=$S(VAPA(13)'="":VAPA(13),1:HLQ)
 S VAFY(11,NODE,2)=$S(VAPA(14)'="":VAPA(14),1:HLQ)
 S VAFY(11,NODE,3)=$S(VAPA(16)'="":VAPA(16),1:HLQ)
 S VAFY(11,NODE,4)=$S(CSTATE'="":CSTATE,1:HLQ)
 S X=$P(VAPA(18),"^",1),VAFY(11,NODE,5)=$S(X'="":X,1:HLQ)
 S VAFY(11,NODE,6)=""
 S VAFY(11,NODE,7)=$S(ADDTYPE=1:"VACAE",ADDTYPE=2:"VACAA",ADDTYPE=3:"VACAC",ADDTYPE=4:"VACAM",ADDTYPE=5:"VACAO",1:HLQ)
 S VAFY(11,NODE,8)=$S(VAPA(15)'="":VAPA(15),1:HLQ)
 S VAFY(11,NODE,9)=$S(CCOUNTY'="":CCOUNTY,1:HLQ)
 S VAFY(11,NODE,10)=""
 S VAFY(11,NODE,11)=""
 S VAFY(11,NODE,12,1)=$S(CSTDATE'="":CSTDATE,1:HLQ)
 S VAFY(11,NODE,12,2)=$S(CENDATE'="":CENDATE,1:HLQ)
 S NODE=NODE+1
 Q
CONFIN ;Inactive confidential address type
 N X
 F X=1,2,3,4,5,8,9 S VAFY(11,NODE,X)=HLQ
 F X=6,10,11 S VAFY(11,NODE,X)=""
 S VAFY(11,NODE,7)=$S(ADDTYPE=1:"VACAE",ADDTYPE=2:"VACAA",ADDTYPE=3:"VACAC",ADDTYPE=4:"VACAM",ADDTYPE=5:"VACAO",1:HLQ)
 S VAFY(11,NODE,12,1)=HLQ
 S VAFY(11,NODE,12,2)=HLQ
 S NODE=NODE+1
 Q
