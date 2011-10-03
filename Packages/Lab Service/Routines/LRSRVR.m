LRSRVR ;DALOI/RLM/JMC - LAB DATA SERVER ; Aug 17, 2006
 ;;5.2;LAB SERVICE;**232,303,346**;Sep 27, 1994;Build 10
 ; Reference to ^%ZOSF supported by IA #10096
 ; Reference to $$SITE^VASITE supported by IA #10112
 ;
START ;
 N LRSITE,LRST,LRSUB,LRXMZ
 ;
 ; Save incoming server message id for cleanup
 S LRXMZ=XMZ
 ;
 K ^TMP($J,"LRDATA"),^TMP($J,"LRDTERR")
 ; Determine station name and number
 S LRSITE=$$SITE^VASITE,LRSTN=$P(LRSITE,"^",2),LRST=$P(LRSITE,"^",3)
 I LRST="" S LRST="???"
 ;
 S LRSUB=$$UP^XLFSTR(XQSUB)
 ;
 ; The first line of the message tells who requested the action and when
 ; The second line tells when the server is activated and no data can be
 ; gathered from the MailMan message.  This line gets replaced if the
 ; server finds something to do.
 S ^TMP($J,"LRDATA",1)=LRSUB_" triggered at "_LRSTN_" by "_XMFROM_" on "_XQDATE
 S LRACTION=$S(LRSUB["CHECKSUM":"Checksums Generated",1:LRSUB)
 S ^TMP($J,"LRDATA",2)="I don't know how to "_LRACTION_" at "_LRSTN
 ;
 ;
 ; If the subject contains "CHECKSUM" send a report of the current checksums to the LABTEAM group on RDMAIL
 I LRSUB["CHECKSUM" D CSUM Q
 ;
 ; If the subject contains "LIST" send a report based on the list of routines in the body of the message back to the original sender.
 I LRSUB["LIST" D SUMLST Q
 ;
 ; If the subject equals "LOINC" send the local LOINC data to the national list.
 I LRSUB="LOINC" D LOINC^LRSRVR1 Q
 ;
 ; If the subject contains "LOCAL REPORT" send the local LOINC data to the sender.
 I LRSUB="LOCAL REPORT" D LOINCL^LRSRVR1 Q
 I LRSUB="LOCAL REPORT DELIMIT" D LOINCLD^LRSRVR3 Q
 ;
 ; Send RELMA mapper formatted message
 I LRSUB="RELMA" D SERVER^LRSRVR2 Q
 ; Process RELMA mapper Packman global message
 ;I LRSUB="RELMA MAPPING" D RMAP^LRSRVR5 Q
 ;
 ; Send SNOMED mapping formatted message
 I LRSUB="SNOMED" D SERVER^LRSRVR6 Q
 ;
 ; Send NLT/CPT mapping formatted message
 I LRSUB="NLT/CPT" D SERVER^LRSRVR7 Q
 ;
 ; If subject not understood by server, send a message to the sender
 ;  that the server can't understand their instructions.
 K XMY
 S XMY(XQSND)=""
 ;
EXIT ; If all went well, report that too.
 ; Mail the errors and successes back to the Roll-Up group at Forum.
 N LRNOW
 S LRNOW=$$NOW^XLFDT
 S XMDUN="Lab Server",XMDUZ=".5",XMSUB=LRSTN_" LAB SERVER ("_LRNOW_")"
 S XMTEXT="^TMP($J,""LRDATA"","
 I '$D(XMY) S XMY("G.LABTEAM@ISC-DALLAS.VA.GOV")=""
 D ^XMD
 ;
CLEAN ; Cleanup and exit
 I $D(^TMP($J,"LRDTERR")) D
 . S XMDUN="Lab Server",XMDUZ=".5"
 . S XMSUB=LRSTN_" LAB SERVER ERROR ("_LRNOW_")"
 . S XMTEXT="^TMP($J,""LRDTERR"","
 . S XMY("G.LABTEAM@ISC-DALLAS.VA.GOV")="",XMY(XQSND)=""
 . D ^XMD
 ;
 ; Clean up server message in MailMan
 I $G(LRXMZ)>0 D ZAPSERV^XMXAPI("S.LRLABSERVER",LRXMZ)
 ;
 K %,%DT,%H,D,DD,DIC,DIERR,ERROR,FILL,LINE,LOINCDTA,LOINCDTB,LOINCTAS
 K LRA,LRAA,LRACTION,LRB,LRCLST,LRDA,LRERR,LRFOUND,LRFOUND1,LRI,LRLINE
 K LRNDE,LROUT,LRPNT,LRPNTA,LRPNTB,LRRDT,LRRN,LRROOT,LRST,LRSTN,LRSUB
 K X,XMDUN,XMDUZ,XMER,XMFROM,XMREC,XMRG,XMSUB,XMTEXT,XMY,XMZ,XQDATE
 K XQSND,XQSUB,Y,ZTQUEUED,ZTSK
 ;
 K ^TMP($J,"LRDATA"),^TMP($J,"LRDTERR")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
 ;
CSUM ;Calculate checksum for routines and transmit errors to LABTEAM group
 S X=$T(+0) X ^%ZOSF("RSUM") S ^TMP($J,"LRDATA",2)=X_" at "_LRSTN_" = "_Y
 S LRI=0
 F  S LRI=$O(^LAB(69.91,1,"ROU",LRI)) Q:'LRI  D
 . S X=$P(^LAB(69.91,1,"ROU",LRI,0),"^")
 . S LRA=$P(^LAB(69.91,1,"ROU",LRI,0),"^",4)
 . X ^%ZOSF("TEST") I '$T S ^TMP($J,"LRDATA",LRI+3)=X_" is missing." Q
 . X ^%ZOSF("RSUM") I +$G(Y)'=LRA S ^TMP($J,"LRDATA",LRI+3)=X_" should be "_LRA_" is "_+$G(Y)
 S XMSUB="Lab Checksum data at "_LRSTN_" run on "_XQDATE
 D EXIT
 Q
 ;
 ;
SUMLST ;Calculate checksum for routines and transmit to requestor
 K ^TMP($J,"LRDATA"),^TMP($J,"LRDTERR")
 S LRCLST=$P($$SITE^VASITE,"^",2),LINE=2,LINR=1,$P(FILL," ",8)=""
 S ^TMP($J,"LRDATA",1)="Lab Server triggered at "_LRCLST_" by "_XMFROM_" on "_XQDATE
 ;
 ; Check for a plus sign in front of the routine name.  Bypass the
 ; Test to see if the routine exists if it's there.
 ; DSM won't check %routines to make sure they exist, Cache will.
 F  X XMREC Q:XMER<0  S X=XMRG D
  . I X'?1"+".E X ^%ZOSF("TEST") I '$T S ^TMP($J,"LRDATA",LINE)=X_$E(FILL,$L(X),8)_" is missing.",LINE=LINE+1 Q
  . ;Strip off the plus sign so that the checksum routine can find it.
  . S X=$TR(X,"+","")
  . X ^%ZOSF("RSUM") S ^TMP($J,"LRDATA",LINE)=X_$E(FILL,$L(X),8)_" is "_Y,LINE=LINE+1
 S XMSUB="Checksum data at "_LRCLST_" run on "_XQDATE
 S XMY(XQSND)=""
 D EXIT
 Q
