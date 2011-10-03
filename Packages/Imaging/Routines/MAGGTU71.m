MAGGTU71 ;WOIFO/GEK - Silent calls for Queing functions from GUI, cont ;  [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;**46,59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ABSJB(MAGRY,DATA) ;RPC [MAG ABSJB] SET ABSTRACT AND/OR JUKEBOX QUEUES
 ;
 ;       DATA
 ;   DESCRIPTION:  '^' delimited String:
 ;   Piece 1 = the IEN of the image that needs an abstract created.
 ;   Piece 2 = the IEN of the image that needs copied to the jukebox
 ;
 ;       MAGRY = "1^Successful"
 ;             = "0^error message"
 ;             
 N MAGIENAB,MAGIENJB,MAGERR,X,QMSG
 S MAGERR=0
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 S MAGRY="0^ERROR: Setting Queue for Abstract or JukeBox copy"
 S MAGIENAB=+$P(DATA,"^",1),MAGIENJB=+$P(DATA,"^",2)
 I MAGIENAB Q:((+$P($G(^MAG(2005,MAGIENAB,0)),U,11))!(+$P($G(^MAG(2005,MAGIENAB,0)),U,12))) "0^Image integrity"
 I MAGIENJB Q:((+$P($G(^MAG(2005,MAGIENJB,0)),U,11))!(+$P($G(^MAG(2005,MAGIENJB,0)),U,12))) "0^Image integrity"
 S QMSG=$S(MAGIENAB:"Setting Abstract Queue",1:"")
 I MAGIENJB S QMSG=$S(QMSG="":"Setting JukeBox Queue",1:" and JukeBox Queue")
 L +(^MAGQUEUE(2006.03,0),^MAGQUEUE(2006.031)):10 E  D QERR Q
 I MAGIENAB S X=$$ABSTRACT^MAGBAPI(MAGIENAB,$$DA2PLC^MAGBAPIP(MAGIENAB,"F"))
 I MAGIENJB S X=$$JUKEBOX^MAGBAPI(MAGIENJB,$$DA2PLC^MAGBAPIP(MAGIENJB,"F"))
 L -(^MAGQUEUE(2006.03,0),^MAGQUEUE(2006.031))
 S MAGRY="1^SUCCESSFUL"
 Q
ERR ;
 L -(^MAGQUEUE(2006.03,0),^MAGQUEUE(2006.031))
 N ERR S ERR=$$EC^%ZOSV
 S MAGRY="0^Timed out trying to set JukeBox/Abstract Queue.  Not Fatal.  'Save' will continue..."
 D LOGERR^MAGGTERR(ERR)
 D @^%ZOSF("ERRTN")
 Q
QERR ;
 N MAGTXT,EMSG
 S MAGTXT="Failed "_QMSG
 ;ENTRY(MAGIMT,MAGDUZ,MAGO,MAGPACK,MAGDFN,MAGCT,MAGAD)
 D ENTRY^MAGLOG("QFAIL",$G(DUZ),MAGIENJB,"","","",MAGTXT)
 D ACTION^MAGGTAU(MAGTXT,1)
 S EMSG="Timed out trying to Lock Queue File"
 D ACTION^MAGGTAU(EMSG,1)
 S MAGRY="1^"_MAGTXT_"  Message was sent to IRM.  Not Fatal.  'Save' will continue..."
 N XMSUB,XMY,XMTEXT,XMK,XMDUZ
 S XMTEXT="^TMP($J,""MAGQ"","
 S XMSUB=MAGTXT
 K ^TMP($J,"MAGQ")
 S ^TMP($J,"MAGQ",1)=MAGTXT
 S ^TMP($J,"MAGQ",2)=EMSG
 S ^TMP($J,"MAGQ",3)=" for Image IEN: "_MAGIENJB
 S ^TMP($J,"MAGQ",4)="You need to run the Verifier for this Image IEN"
 S XMY("G.IMAGING DEVELOPMENT@FORUM.DOMAIN.EXT")=""
 D ^XMD
 S XMDUZ=DUZ D KLQ^XMA1B
 K ^TMP($J,"MAGQ")
 Q
