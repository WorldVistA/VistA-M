LAXSYMDL ;MLD/ABBOTT/SLC/RAF - ABBOTT AxSYM  'DWNLD' PGM ; 6/12/96 0900;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**11**;Sep 27, 1994
 ;
 Q  ; enter at proper line tag
 ;
 ;                   ** NOTE **
 ; This routine must be invoked ONLY by LAPORT33 (LANM) as it
 ; requires a BI-directional interface with the AxSYM! /mld
 ;
DWNLD ; Download work list to the AxSYM (called by 'LANM' routine)
 D START
 S X="TRAP^"_LANM,@^%ZOSF("TRAP") ; reset error trap
 G @("PH1^"_LANM)
 ;
START ; Call line tag to allow 'NEW' command
 N CNT,I,X,FRM,LAQUIT,LAREAD,LARETRY,READ,TMOUT
 S READ="S LAREAD=$$GETCH^"_LANM ; indirect read using i/f routine
 S (I,LAQUIT,LARETRY)=0,X="ERR^LAXSYMDL",@^%ZOSF("TRAP"),TMOUT=-1
 ;
 L +^LA(INST,NODE) ; begin after obtaining global
 G:'$G(^LA(INST,NODE)) OUT ; nothing to dwnld - get out
 ;
GETACK ; GetACK from AxSYM indicating OK to start dwnld
 D SEND^LAXSYMU(ENQ),READ ; send wakeup ENQ to machine, get reply
 I LAREAD'=ACK S LARETRY=LARETRY+1 G:LARETRY<7 GETACK
 G:LARETRY=7 OUT ; too many attempts - get out
 ;
 F  S I=$O(^LA(INST,NODE,I)) Q:'I  S FRM=^(I) D  Q:LAQUIT
 .S LARETRY=0 ; init counter
AGN .W FRM ; send frame
 .I DEBUG D DEBG^LAXSYMU(FRM,"O")
 .; get ACK response from AxSYM
 .D READ
 .; if machine NAK's, resend (6 times max)
 .I LAREAD=21,LARETRY<7 S LARETRY=LARETRY+1 G AGN
 .I LARETRY=7 S LAQUIT=1 Q  ; reached max retries
 .; if machine timed out go to idle
 .I LAREAD=TMOUT S LAQUIT=1 Q
 .Q
 ;
 G:LAQUIT OUT ; error - don't reset flags
 K ^LA(INST,NODE) ; remove d/l list
 K:NODE="O" ^LA(INST,"Q") ; remove dwnld-ready flag
 ;
OUT ; Exit point for excessive # retries
 D SEND^LAXSYMU(EOT) ; indicate end of transfer
 L -^LA(INST,NODE) ;   release lock
 ;
 QUIT
 ;
READ ; Get machine's reply
 X READ ; READ is set to  'S LAREAD=$$GETCH^LAPORTxx'
 I DEBUG D DEBG^LAXSYMU(LAREAD,"I")
 I LAREAD=EOT S LAREAD=ACK ; treat EOTs as ACK
 I '$F(TMOUT_U_ACK_U_NAK_U_ENQ,LAREAD) S LAREAD=NAK ; Invalid reply=NAK
 Q:LAREAD=TMOUT  ; timed out
 Q:LAREAD=ACK  ; ACK'd if OK
 Q:LAREAD=NAK  ; NAK'd
 G READ ; read until ACK'd, NAK'd or timed out
 ;
ERR ; Error Trap
 D ^LABERR
 K:$G(NODE)="O" ^LA(INST,"Q") ; remove d/l ready flag
 G OUT
