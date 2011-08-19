XUMF4L2 ;OIFO-OAK/RAM - Load IMF ;02/21/02
 ;;8.0;KERNEL;**217**;Jul 10, 1995
 ;
 ; $$PARAM^HLCS2 call supported by IA #3552
 ;
LOCAL ; -- status message to site
 ;
 I '$$ADD,'$$DEL,'$$MOD Q
 ;
 N XMSUB,TEXT,XMDUZ,XMY,XMTEXT,I,ZIN
 ;
 S ZIN="NAME^STATION NUMBER^STATUS^FACILITY TYPE^OFFICIAL VA NAME"
 S ZIN=ZIN_"^INACTIVE FACILITY FLAG^STATE^VISN^PARENT FACILITY"
 ;
 S I=0
 ;
 S I=I+1,TEXT(I)="A backgroud job just updated your Institution file"
 S I=I+1,TEXT(I)="with data from the Institution Master File (IMF)"
 S I=I+1,TEXT(I)="on FORUM."
 S I=I+1,TEXT(I)=""
 S I=I+1,TEXT(I)="This job was a special task to insure sites that"
 S I=I+1,TEXT(I)="have already run the cleanup are up-to-date with"
 S I=I+1,TEXT(I)="all updates."
 S I=I+1,TEXT(I)=""
 S I=I+1,TEXT(I)="These updates were broadcast previously, but your"
 S I=I+1,TEXT(I)="site may not have received them due to enabling"
 S I=I+1,TEXT(I)="and/or disabling broadcasting to sites for various"
 S I=I+1,TEXT(I)="reasons."
 S I=I+1,TEXT(I)=""
 S I=I+1,TEXT(I)="This message has three sections (in addition to this"
 S I=I+1,TEXT(I)="initial text.)  The first section lists entries that"
 S I=I+1,TEXT(I)="have been added to your file.  The second section"
 S I=I+1,TEXT(I)="lists existing entries that have modified.  The third"
 S I=I+1,TEXT(I)="section lists entries that have had their STATUS (#11)"
 S I=I+1,TEXT(I)="changed from National to Local and their STATION"
 S I=I+1,TEXT(I)="NUMBER (#99) removed (was never a valid sta #.)"
 S I=I+1,TEXT(I)=""
 S I=I+1,TEXT(I)="The lists are in Station Number order and are up-arrow"
 S I=I+1,TEXT(I)="delimited strings in the HL7 Institution segment"
 S I=I+1,TEXT(I)="format.  The values correspond to the FileMan fields"
 S I=I+1,TEXT(I)=""
 S I=I+1,TEXT(I)=ZIN
 S I=I+1,TEXT(I)=""
 ;
 S I=I+1,TEXT(I)="SECTION ONE"
 S I=I+1,TEXT(I)="The following entries were ADDED:"
 S I=I+1,TEXT(I)=""
 I $$ADD=0 S I=I+1,TEXT(I)="None.",I=I+1,TEXT(I)=""
 I $$ADD D
 .N STA S STA=""
 .F  S STA=$O(^TMP("XUMF ADD",$J,STA)) Q:STA=""  D
 ..S I=I+1,TEXT(I)=$P(^TMP("XUMF ADD",$J,STA),U,2,10)
 ;
 S I=I+1,TEXT(I)=""
 S I=I+1,TEXT(I)="SECTION TWO"
 S I=I+1,TEXT(I)="The following entries were MODIFIED (old/new value):"
 S I=I+1,TEXT(I)=""
 I $$MOD=0 S I=I+1,TEXT(I)="None.",I=I+1,TEXT(I)=""
 I $$MOD D
 .N STA S STA=""
 .F  S STA=$O(^TMP("XUMF MOD",$J,STA)) Q:STA=""  D
 ..S I=I+1,TEXT(I)=^TMP("XUMF MOD",$J,STA,"OLD")
 ..S I=I+1,TEXT(I)=^TMP("XUMF MOD",$J,STA,"NEW")
 ..S I=I+1,TEXT(I)=""
 ;
 S I=I+1,TEXT(I)=""
 S I=I+1,TEXT(I)="SECTION THREE"
 S I=I+1,TEXT(I)="The following STATION NUMBERS were removed:"
 S I=I+1,TEXT(I)=""
 I $$DEL=0 S I=I+1,TEXT(I)="None.",I=I+1,TEXT(I)=""
 I $$DEL D
 .N STA S STA=""
 .F  S STA=$O(^TMP("XUMF DEL",$J,STA)) Q:STA=""  D
 ..S I=I+1,TEXT(I)=" STA: "_STA_" IEN: "_$O(^TMP("XUMF DEL",$J,STA,0))
 .S I=I+1,TEXT(I)=""
 .S I=I+1,TEXT(I)="Note: Just the STATION NUMBER (#99) was removed"
 .S I=I+1,TEXT(I)="and the STATUS (#11) changed to Local.  The entry"
 .S I=I+1,TEXT(I)="itself was NOT deleted."
 ;
 S XMSUB="IFR/cleanup/updates at "_$$SITE
 S XMDUZ=$S(DUZ:DUZ,1:.5)
 S XMTEXT="TEXT("
 S XMY("G.XUMF INSTITUTION")=""
 S:$P($$PARAM^HLCS2,U,3)'="T" XMY("G.XUMF INSTITUTION@FORUM")=""
 D ^XMD
 Q
 ;
NVS ; -- status message to NVS
 ;
 N XMSUB,TEXT,XMDUZ,XMY,XMTEXT
 ;
 S TEXT(1)=$$SITE
 S TEXT(2)=""
 S TEXT(3)="Station numbers added: "_$$ADD
 S TEXT(4)="              deleted: "_$$DEL
 S TEXT(5)="File entries modified: "_$$MOD
 ;
 S XMSUB="IFR/cleanup/status at "_$$SITE
 S XMDUZ=$S(DUZ:DUZ,1:.5)
 S XMTEXT="TEXT("
 S XMY("G.XUMF INSTITUTION")=""
 S:$P($$PARAM^HLCS2,U,3)'="T" XMY("G.XUMF INSTITUTION@FORUM")=""
 D ^XMD
 ;
 Q
 ;
SITE() ; -- facility name and sta # string
 ;
 Q $P($G(^DIC(4,+DUZ(2),0)),U)_" Sta#: "_$P($G(^DIC(4,+DUZ(2),99)),U)
 ;
ADD() ; -- added sta #
 ;
 N STA,CNT
 S STA="",CNT=0
 F  S STA=$O(^TMP("XUMF ADD",$J,STA)) Q:STA=""  S CNT=CNT+1
 Q CNT
 ;
MOD() ; -- modified entries
 ;
 N STA,CNT
 S STA="",CNT=0
 F  S STA=$O(^TMP("XUMF MOD",$J,STA)) Q:STA=""  S CNT=CNT+1
 Q CNT
 ;
DEL() ; -- removed sta #
 ;
 N STA,CNT
 S STA="",CNT=0
 F  S STA=$O(^TMP("XUMF DEL",$J,STA)) Q:STA=""  S CNT=CNT+1
 Q CNT
 ;
