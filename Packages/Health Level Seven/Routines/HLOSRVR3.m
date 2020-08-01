HLOSRVR3 ;IRMFO/OAK/CJM - Reading messages, sending acks;Apr 03, 2020@14:50
 ;;1.6;HEALTH LEVEL SEVEN;**138,147,157,10001**;Oct 13, 1995;Build 3
 ; Original code in the public domain by Dept of Veterans Affairs.
 ; Changes **10001** by Sam Habiel (c) 2020.
 ; Changes indicated inline.
 ; Licensed under Apache 2.0.
 ;
ERROR ;error trap
 ;
 S $ETRAP="Q:$QUIT """" Q"
 D END^HLOSRVR
 ;
 I ($ECODE["TOOMANYFILES")!($ECODE["EDITED") Q:$QUIT "" Q
 ;
 ;multi-listener should stop execution, only a single server may continue
 I $P($G(HLCSTATE("LINK","SERVER")),"^",2)'="S" D  Q:$QUIT "" Q
 .;don't log these errors unless logging is turned on
 .I $G(^HLTMP("LOG ALL ERRORS")) D ^%ZTER Q
 .I ($ECODE["READ")!($ECODE["NOTOPEN")!($ECODE["DEVNOTOPN")!($ECODE["WRITE")!($ECODE["OPENERR")!($ECODE["DSCON") Q
 .I ($ECODE["150373082")!($ECODE["150381546")!($ECODE["150373090") Q  ; *10001* for GT.M
 .D ^%ZTER
 .Q
 ;
 ;single listener should return to the process manager
 Q:$Q "" Q
