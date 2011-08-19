XWBM2MS ;OIFO-Oakland/REM - M to M Broker Server  ;3/21/02
 ;;1.1;RPC BROKER;**28**;Mar 28, 1997
 ;
 QUIT   ;No entry from top.
 ;
RPC(XWBDATA) ;
 IF XWBDATA("URI")="XUS SIGNON SETUP" DO
 .SET XWBTDEV="",XWBTIP="",XWBVER="1.1"
 ;
 QUIT
 ;
CLOSE ;
 DO RESPONSE^XWBVL()
 Q
 ;
