HDISDSR ;BPFO/DTG - HDI MAILMAN SERVER FOR COLLECTING SDO; Apr 07, 2018@12:42
 ;;1.0;HEALTH DATA & INFORMATICS;**22**;Feb 22, 2005;Build 26
 ;
START ;
 N A,HDISITE,HDIST,HDISUB,HDIXMZ,HDISV,HDER,HDICRLF,HDIJB,HDILEN,HDIMSUBJ,HDIQUIT,HDITXT,HDINODE
 N HDIMAX
 ;
 ; Save incoming server message id for cleanup
 S HDIXMZ=XMZ
 ;
 S HDISV="^TMP($J,""HDIDATA"")",HDER="^TMP($J,""HDIDTERR"")"
 K @HDISV,@HDER
 ; Determine station name and number
 S HDISITE=$$SITE^VASITE,HDISTN=$P(HDISITE,"^",2),HDIST=$P(HDISITE,"^",3)
 I HDIST="" S HDIST="???"
 ;
 S HDISUB=$$UP^XLFSTR(XQSUB)
 ;
 ; The first line of the message tells who requested the action and when
 ; The second line tells when the server is activated and no data can be
 ; gathered from the MailMan message.  This line gets replaced if the
 ; server finds something to do.
 S A="SDO lookup option: "_HDISUB_$J("      ",6)
 S ^TMP($J,"HDIDATA",1)=A
 S A="Was triggered at "_HDISTN_" by "_XMFROM_" on "_XQDATE_$J("      ",6)
 S ^TMP($J,"HDIDATA",2)=A
 S ^TMP($J,"HDIDATA",3)=" "_$J("      ",6)
 S HDIACTON=HDISUB
 S A="This SDO lookup option: "_HDIACTON_$J("      ",6)
 S ^TMP($J,"HDIDATA",4)=A
 S A="Is NOT available at "_HDISTN_$J("      ",6)
 S ^TMP($J,"HDIDATA",5)=A
 S A=""
 ;
 ;
 I HDISUB="LAB" D EN1^HDISDSRL Q
 ;
 ; If subject not understood by server, send a message to the sender
 ;  that the server can't understand their instructions.
 K XMY
 S XMY(XQSND)=""
 ;
EXIT ; If all went well, report that too.
 ; Mail the errors and successes back to the Roll-Up group at Forum.
 N HDINOW
 S HDINOW=$$NOW^XLFDT,A=$$FMTE^XLFDT(HDINOW,5)
 S XMDUN="HDI SDO Server",XMDUZ=".5",XMSUB=HDISTN_" HDI SDO SERVER ("_A_" ["_HDINOW_"])"
 K XMTEXT S XMTEXT="^TMP($J,""HDIDATA"","
 I '$D(XMY) S XMY($G(XQSND))=""
 N DIFROM D ^XMD K DIFROM
 ;
CLEAN ; Cleanup and exit
 I $D(^TMP($J,"HDIDTERR")) D
 . S XMDUN="HDI SDO Order Server",XMDUZ=".5"
 . S XMSUB=HDISTN_" HDI SDO ORDER SERVER ERROR ("_HDINOW_")"
 . S XMTEXT="^TMP($J,""HDIDTERR"","
 . S XMY(XQSND)=""
 . D ^XMD
 ;
 ; Clean up server message in MailMan
 I $G(HDIXMZ)>0 D ZAPSERV^XMXAPI("S.HDISDOSERVER",HDIXMZ)
 ;
 K %,%DT,%H,D,DD,DIC,DIERR,ERROR,FILL,LINE,LOINCDTA,LOINCDTB,LOINCTAS
 K HDIA,HDIAA,HDIACTON,HDIB,HDICLST,HDIDA,HDIERR,HDIFOUND,HDIFOUND1,HDII,HDILINE
 K HDINDE,HDIOUT,HDIPNT,HDIPNTA,HDIPNTB,HDIRDT,HDIRN,HDIROOT,HDIST,HDISTN,HDISUB
 K X,XMDUN,XMDUZ,XMER,XMFROM,XMREC,XMRG,XMSUB,XMTEXT,XMY,XMZ,XQDATE,HDINODE
 K XQSND,XQSUB,Y,ZTQUEUED,ZTSK,HDICRLF,HDIJB,HDILEN,HDIMSUBJ,HDIQUIT,HDITXT
 K HDIMAX
 ;
 K ^TMP($J,"HDIDATA"),^TMP($J,"HDIDTERR")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
