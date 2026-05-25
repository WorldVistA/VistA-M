PSO772PI ;BIRM/KML - PSO*7*772 Post-install routine ;12/4/2024
 ;;7.0;OUTPATIENT PHARMACY;**772**;DEC 1997;Build 105
 ;
EN ; MAIN ENTRY POINT
 K ^TMP("PSO772PI",$J)
 N LINENUM,ERROR,ROUTINES
 S ERROR=0
 S LINENUM=0
 S ROUTINES=$$VALROUTINES()
 I ROUTINES D VERSIONS,PROTOCOL
 D DELROUTINES
 D MAIL("PSO*7*772 Installation is completed.")
 Q
 ;
VERSIONS ; Add new standard versions to the SPMP ASAP RECORD DEFINITION FILE (#58.4)
 N V,S,D,E,L,X,DAVIEN,VERSION,ERR,VERNODE,COMPONENTS,NXT,TAG,NEW
 S V="VER",S="SEG",D="DAT",E="DES",L="VAL"   ;decrease bytes per line by referencing the subscripts
 F NXT=2:1 S COMPONENTS=$T(VERLST+NXT),COMPONENTS=$P(COMPONENTS,";;",2) Q:COMPONENTS=""  D
 . S NEW=0
 . S VERSION=$P(COMPONENTS,"|"),TAG=$P(COMPONENTS,"|",2)
 . S DAVIEN=$$FIND1^DIC(58.4001,",1,","BX",VERSION,"","","ERR")  ; get the ien for version to be added if it exists on installed system 
 . ;if Version needs to be added then get last IEN recorded and add 1 to create new record and update VERSION subfile ien counter
 . S DAVIEN(1)=1 I DAVIEN D REMOVE(.DAVIEN,"^PS(58.4,1,""VER"",")  ; if its on the system already, it will be removed 
 . I 'DAVIEN S VERNODE=^PS(58.4,1,"VER",0),DAVIEN=$P(VERNODE,"^",3)+1,NEW=1
 . D @(TAG_"(V,"_"S,"_"D,"_"E,"_"L,"_DAVIEN_")")
 . I NEW S $P(^PS(58.4,1,"VER",0),"^",3)=DAVIEN
 . S $P(^PS(58.4,1,"VER",0),"^",4)=$P(^PS(58.4,1,"VER",0),"^",4)+1
 . D REPORT("Standard Version "_VERSION_$P(COMPONENTS,"|",3)_" has been installed on the system and has been locked (READ ONLY).","COMPLETE",.LINENUM)
 Q
 ;
 ;
PROTOCOL() ; populate the SCREEN field (#101,24) of the PSO SPMP3 MENU protocol with the M code enhancement
 ; returns back 1 for error state or 0 for successful file
 N PRFDA,PRIEN,PRERROR
 S PRIEN=+$$FIND1^DIC(101,,"X","PSO SPMP3 MENU","B")
 I PRIEN S PRFDA(101,PRIEN_",",24)="I $$ACTIONS^PSOSPML3"
 I $D(PRFDA) D FILE^DIE("E","PRFDA","PRERROR")
 I $D(PRERROR) D REPORT("PSO SPMP3 MENU did not get updated with the necessary M SCREEN.","ERROR",.LINENUM) Q
 D REPORT("Protocol PSO SPMP3 MENU has been updated with the M screen enhancement.","COMPLETE",.LINENUM)
 Q
 ;
MAIL(XMSUB) ;Send mail message
 N X,XMTEXT,XMY,XMDUZ,XMMG,XMSTRIP,XMROU,XMYBLOB,XMZ,XMDUN
 S XMDUZ="PSO*7*772 Install"
 S XMTEXT="^TMP(""PSO772PI"",$J,"
 S XMY("G.PSO SPMP NOTIFICATIONS")=""
 S XMY(DUZ)=""
 N DIFROM D ^XMD
 Q
 ;
REPORT(TEXT,ACTION,LINE) ; report any errors during web service setup
 ; Input -
 ; TEXT - text to report to end-user
 ; ACTION - what was being processed
 ; LINE - line number for the mail message passed in by reference
 D:ACTION="REMOVED" 1
 D:ACTION="ERROR" 2
 D:ACTION="COMPLETE" 1
 Q
1 D BMES^XPDUTL("     "_TEXT)
 S LINE=LINE+1
 S ^TMP("PSO772PI",$J,LINE)="     "_TEXT
 S LINE=LINE+1
 S ^TMP("PSO772PI",$J,LINE)=""
 Q
 ;
2 D BMES^XPDUTL("     "_TEXT_" Please contact product support.")
 S LINE=LINE+1
 S ^TMP("PSO772PI",$J,LINE)="  Please log a SNOW Ticket and refer to this message."
 S LINE=LINE+1
 S ^TMP("PSO772PI",$J,LINE)=""
 Q
 ;
REMOVE(DA,DIK) ; delete an entry from file or sub-file
 ; inputs - 
 ; DA - Entry number in the subfile to delete (or top-file entry)
 ; DA(1) - Entry number at the next higher file level
 ; DIK -  global root of the file from which to delete an entry
 D ^DIK
 Q
 ;
VALROUTINES() ; confirm that the post-install routines exist
 N X,I,VAL
 S VAL=1
 F I=0:1:28 S X="PSO772P"_I X ^%ZOSF("TEST") I '$T S VAL=0
 Q VAL
 ;
DELROUTINES ;  delete post-install routines
 N X,I
 F I=0:1:28 S X="PSO772P"_I X ^%ZOSF("TEST") I $T D MES^XPDUTL("Deleting routine "_X_"...") X ^%ZOSF("DEL")
 Q
 ;
VERLST ; list of versions to be added during install of PSO*7*772
 ;;ASAP VERSION|TAG^ROUTINE|indicates if Zero Report
 ;;4.2A|BUILD42A^PSO772P0|
 ;;4.2AZ|BUILD42AZ^PSO772P5| Zero Report
 ;;4.2B|BUILD42B^PSO772P8|
 ;;4.2BZ|BUILD42BZ^PSO772P13| Zero Report
 ;;5.0|BUILD5^PSO772P17|
 ;;5.0Z|BUILD5Z^PSO772P25| Zero Report
 ;;
