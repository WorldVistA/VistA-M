LAPORT33 ;MLD/ABBOTT/SLC/RAF - AxSYM BIDRECTIONAL INTERFACE ; 6/12/96 0900
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**11,19**;Sep 27, 1994
 ;
 ; This routine LOOSELY follows the LAPORTXX template.  However, this
 ; routine works ONLY for Abbott's AxSYM machine, and should comply
 ; with ASTM communication protocols.  This pgm will run continuously
 ; as a background job until the system is taken down OR ^LA("STOP",INST)
 ; global flag is set.  /mld
 ;
 N LARETRY,LATOUT,LATEMP,LAFRAME,LAFRAM,LAEND,LACS,LAFRNUM,LADEV
 N LAFRNM,LALINK,LACRLF,LACRETX,LANOCTL1,LANOCTL2,LADATA,LANM
 N I,J,T,X,Y,INST,DEB,HOME,BASE,OUT,TOUT,PAR,TSK,NODE,OK,DEBUG,CNT
 N NUL,SOH,STX,ETX,EOT,ENQ,ACK,NAK,ETB,LF,CR ; *control chars*
 ;
 S LANM=$T(+0),(HOME,T)=+$E(LANM,7,8) Q:+T<1  Q:$D(^LA("LOCK","D"_T))
 ; init req'd params
 D INIT^LAXSYMU I 'OK QUIT  ; chk ^LA(INST,"ERR",$H) for err msg
 ;
PH1 ; PHase1 - idle/establish link (wait for AxSYM to send data)
 S LADATA=$$GETCH I DEBUG D DEBG^LAXSYMU(LADATA,"I")
 I LADATA=-1 G @($$CHK) ; idle - chk flags
 I LADATA'=ENQ G PH1 ; read until ENQ rec'd
 ; AxSYM ready to send data so init vars, ACK and drop to PH2
 S LAFRAME="",LARETRY=0,LATOUT=15,LAFRNM=0,LALINK=1
 D SEND^LAXSYMU(ACK)
 ;
PH2 ; PHase2 - transfer data (build frame)
 S LADATA=$$GETCH
 I LADATA=-1 D SET G PH1 ; timed out - goto idle
 S LAFRAME=LAFRAME_$C(LADATA) ; build frame
 I $L(LAFRAME)>247 D NAK^LAXSYMU("SIZE") G:LARETRY<7 PH2 D SET G PH1
 I LADATA=LF G PH3 ; LF=complete frame
 I LADATA=EOT G PH3 ; no more data
 G PH2
 ;
PH3 ; PHase3 (validate frame)
 D:DEBUG DEBG^LAXSYMU(LAFRAME,"I") ; debug
 S X=LAFRAME
 I $F(X,$C(EOT)) D SET G PH1 ; EOT not allowed in txt
 I $A(X)'=STX D SET G PH1 ; 1st char must be STX
 ; txt must end w/ ETX or ETB
 S LAEND=$S($F(X,$C(ETX)):$F(X,$C(ETX)),1:$F(X,$C(ETB)))
 I 'LAEND D NAK^LAXSYMU("LAEND") G PH2:LARETRY<7 D SET G PH1
 ;
 S LAFRAM=$E(X,2,LAEND-1) ; get msg txt
 ; chk frame numbering sequence
 S LAFRNUM=+LAFRAM,LAFRNM=$S(LAFRNM<7:LAFRNM+1,1:0)
 I LAFRNM'=LAFRNUM D NAK^LAXSYMU("NUMSQNC") G PH2:LARETRY<7 D SET G PH1
 I LAFRNUM'=(LAFRNUM#8) D NAK^LAXSYMU("FRNUM") G PH2:LARETRY<7 D SET G PH1
 ; chk restricted control chars in txt
 I LAFRAM'=$TR(LAFRAM,LANOCTL2) D NAK^LAXSYMU("CTL") G PH2:LARETRY<7 D SET G PH1
 ; sent checksum must = received checksum
 S LACS=$E(X,LAEND,LAEND+1) ; get passed cksum
 I LACS'=$$CKSUM^LAXSYMU(LAFRAM) D NAK^LAXSYMU("CKSUM") G PH2:LARETRY<7 D SET G PH1
 ; chk for CR_LF terminating chars - timeout if NULL, NAK for all others
 I $P(X,(LACRETX_LACS),2)="" D SET G PH1
 I $P(X,(LACRETX_LACS),2)'=LACRLF D NAK^LAXSYMU("LACRLF") G PH2
 ;
 D UPDT^LAXSYMU,SEND^LAXSYMU(ACK) ; frame OK - save & ACK
 G PH2 ; get nxt frame
 ;
GETCH() ; read 1 char at a time. Returns Ascii value of terminating char
 S ^LA(INST,"R")=$H
 R *LATEMP:LATOUT
 S DEBUG=$D(^LA(DEB,0)) ; debug on? (def=off)
 Q LATEMP
 ;
CHK() ; Chk flags - Returns LINE TAG to branch to
 S ^LA(INST,"R")=$H,LATOUT=30 ; update run-time flag
 I $D(^LA(INST,"HQ")) S NODE="HQ" Q "DWNLD^LAXSYMDL" ; host query
 I $D(^LA(INST,"Q")) S NODE="O" Q "DWNLD^LAXSYMDL" ; d/l l/w list
 I '$D(^LA("STOP",INST)) Q "PH1" ; continue
 Q "OUT" ; STOP = shutdown
 ;
SET ; Re-init vars
 H 5 ; allow LAXSYM to catch up
 K LAFRAM,X,LALINK,LAFRNM
 S LATOUT=5,LAFRAME=""
 Q:$$CHK["HQ"
 H 13 ; force timeout & return to idle
 Q
 ;
OUT ; Main Exit - remove flags, close port
 K ^LA("STOP",INST),^LA(INST),^LA("LOCK","D"_INST)
 D ^%ZISC
 Q
 ;
TRAP ; Error Trap
 D ^LABERR S T=TSK
 D SET^LAB G PH1
 Q
 ;
DQ ;Entry point to task job
 S LANM=$T(+0),HOME=$E(LANM,7,8) Q:HOME=""!(HOME>99)
 I $D(^LAB(62.4,HOME,0)),$L($P(^(0),"^",2)) S ZTIO=$P(^(0),"^",2),ZTRTN=LANM,ZTDTH=$H,ZTDESC="START LAB DIRECT CONNECT PORT "_HOME K ^LA("LOCK","D"_HOME) D ^%ZTLOAD
 Q
