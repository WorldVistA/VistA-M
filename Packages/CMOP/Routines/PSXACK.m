PSXACK ;BIR/BAB-Process MSA Segment after Msg Transmits ; [ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
EN ;This routine processes an MSA segment and returns PSXPOP=1
 ;if there was a problem.
 ;Requires PSXQN = message entry number
SLAVE ;wait to enter slave mode to receive ACK message
 R *X:PSXDLTD  E  D
 E  D ACK1 G ERROR
 I X'=ENQ D ACK5 G ERROR
 R *X:PSXDLTA
 I ('$T)!(X'=TERM) D ACK4 G ERROR
 W *ACK,0,*TERM
 S BFLAG=0
 S BHST=0
MSG R *X:PSXDLTD E  D ACK1 G ERROR
 I X=STX G READ
 I X=EOT R *X:PSXDLTA I X=TERM G TST
 D ACK5 ;unexpected character received
ERROR D FLUSH1^PSXUTL
 D LOG^PSXUTL
 S PSXPOP=1
 K PSXHEX,PSXACK,PSXREJ,LOG,PSXSUM
 QUIT
READ S PSXACK=""
 S PSXTMD=$P($H,",",2)
GETMSG S AA=0 F %=1:1 D  Q:'%
 .R *X:PSXDLTA E  D ACK6,LOG^PSXUTL S %=0,X="" Q
 .D CHKD^PSXUTL I PSXTMOUT D ACK6,LOG^PSXUTL S %=0,X="" Q
 .I %>240 D ACK7,LOG^PSXUTL S %=0,X="" Q
 .S PSXACK=PSXACK_$C(X)
 .I (X=ETX)!(X=ETB) S %=0
 I X=ETX S AA=1 G TEST
 I X=ETB S AA=2 G TEST
 I X=EOT R *X:PSXDLTA G:X=TERM TST
 I (X'=ETX)!(X'=ETB)!(X'=EOT) D ACK8 G ERROR
 I PSXACK="" D ACK9 G ERROR
 Q
TEST R *X:PSXDLTA E  D ACK10 G ERROR
 I "0123456789ABCDEF"'[$C(X) D ACK11 G ERROR
 S PSXSUM=$C(X)
CHKSUM R *X:PSXDLTA E  D ACK10 G ERROR
 I "0123456789ABCDEF"'[$C(X) D ACK11 G ERROR
 S PSXSUM=PSXSUM_$C(X)
 S X=PSXACK X ^%ZOSF("LPC") S PSXHEX=Y D HEX^PSXUTL
 R *X:1 I X'=TERM D ACK5
 I PSXHEX'=PSXSUM D ACK12 G ERROR
 I PSXHEX=PSXSUM D FLUSH1^PSXUTL
 ;S:$P(PSXACK,"|",1)["BHS" BHST=1,BFLAG=1,PSXBHS=1
 S:$P(PSXACK,"|",1)["BHS" BHST=1,BFLAG=1
 I (BFLAG=1)&($P(PSXACK,"|",1)["BHS") S PSXMSH=$G(PSXMSH)_"+"_$E(PSXACK,7,$L(PSXACK)-2)
 I (BFLAG=1)&($P(PSXACK,"|",1)["MSA") S PSXMSA=$G(PSXMSA)_"+"_$E(PSXACK,7,$L(PSXACK)-2),BFLAG=0,PSXBHS=1 S:$G(PSXMSA)["|AR|" PSXBHS=0 K:$G(PSXBHS)'>0 PSXMSH,PSXMSA
 I $E(PSXACK,7,10)["MSH|" S TACK=$E(PSXACK,7,$L(PSXACK)-2)
 W *ACK,$S(AA=1:2,AA=2:1,1:""),*TERM D:$P(PSXACK,"|",1)["MSA" FILE G MSG
 Q
FILE Q:$G(BHST)=1
 I $P($P(PSXACK,"MSA",2),"|",3)'=PSXMSGID D ACK15 G ERROR
 S XXX=$P($P(PSXACK,"MSA",2),"|",3),REC=$O(^PSX(552.2,"B",XXX,""))
 S REC=$G(PSXQN)
 Q:$G(REC)=""
 S ^PSX(552.2,REC,"ACK")=TACK_$E(PSXACK,7,$L(PSXACK)-2)
 S (PSXPOP,PSXREJ)=0
 I (PSXACK["AR") S PSXREJ=1 D ACK13,LOG^PSXUTL
 L +^PSX(552.2,REC):DTIME I $T S DIE="^PSX(552.2,",DA=REC,DR="1///"_$S(PSXREJ:99,'PSXREJ:3,1:0)_";3///^S X=$H" D ^DIE K DIE,DA L -^PSX(552.2,REC)
 K XXX,REC,PSXREJ,PSXACK,TACK
 Q
TST D FLUSH1^PSXUTL
 K PSXHEX,PSXACK,PSXREJ,LOG,PSXSUM
 Q
ACK1 K LOG S LOG(1)="ACK1 ACK message never received for order #"_$P($G(^PSX(552.2,PSXQN,0)),"^",1) Q
ACK2 K LOG S LOG(1)="ACK2 EOT received with no terminator while waiting for ACK message" Q
ACK3 K LOG S LOG(1)="ACK3 EOT received while waiting for ACK message" Q
ACK4 K LOG S LOG(1)="ACK4 ENQ received with no terminator while waiting for ACK message" Q
ACK5 K LOG S LOG(1)="ACK5 Unexpected character received: "_$S(X>31:$C(X),1:"")_" ("_X_") while waiting for ACK message" Q
ACK6 K LOG S LOG(1)="ACK6 Timeout Timer D reading ACK message" Q
ACK7 K LOG S LOG(1)="ACK7 ACK message longer than 240 characters" Q
ACK8 K LOG S LOG(1)="ACK8 ACK message did not end with ETX" Q
ACK9 K LOG S LOG(1)="ACK9 ACK was null" Q
ACK10 K LOG S LOG(1)="ACK10 Timeout reading ACK checksum" Q
ACK11 K LOG S LOG(1)="ACK11 ACK checksum contained an invalid hex digit ("_X_")" Q
ACK12 K LOG S LOG(1)="ACK12 ACK checksum does not match" Q
ACK13 K LOG S LOG(1)="ACK13 Order #"_$P($G(^PSX(552.2,PSXQN,0)),"^",1)_" was rejected by CMOP" Q
ACK14 K LOG S LOG(1)="ACK14 ENQ received with no terminator" Q
ACK15 K LOG S LOG(1)="ACK15 MSA order # did not match "_$P($G(^PSX(552.2,PSXQN,0)),"^",1)_" # expected" Q
