HLOSRVR3 ;IRMFO/OAK/CJM - Reading messages, sending acks;03/24/2004  14:43 ;08/16/2011
 ;;1.6;HEALTH LEVEL SEVEN;**138,147,157**;Oct 13, 1995;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified.
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
 .D ^%ZTER
 .Q
 ;
 ;single listener should return to the process manager
 Q:$Q "" Q
