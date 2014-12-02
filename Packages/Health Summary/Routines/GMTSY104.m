GMTSY104 ;BP/WAT - POST-INSTALL PATCH 104 ;04/19/12  15:25
 ;;2.7;Health Summary;**104**;Oct 20, 1995;Build 38
 ;
 ;WP^DIE ;2053
 ;FIND1^DIC ;2051
 ;B/MES^XPDUTL 10141
 ;
 ; GMTS health check
 N GMTSNAME,I,COUNT,GMTSABRT S GMTSNAME="",COUNT=1,GMTSABRT=""
 D BMES^XPDUTL("CHECKING RECENT ADDITIONS TO HEALTH SUMMARY COMPONENT FILE")
 F I=252:1:256  Q:I>256!(GMTSABRT=2)  D
 .S GMTSNAME=$P(^GMT(142.1,I,0),"^")
 .I GMTSNAME=$P($T(TEXT+COUNT),";;",2) D BMES^XPDUTL(GMTSNAME_": OK") S COUNT=COUNT+1 Q
 .D BMES^XPDUTL("The following Health Summary Component was not found in file 142.1:")
 .D MES^XPDUTL($P($T(TEXT+COUNT),";;",2))
 .D BMES^XPDUTL("Install will not proceed until this issue is resolved.")
 .D MES^XPDUTL("Transport global will remain on the system.")
 .D MES^XPDUTL("Use KIDS option XPD RESTART INSTALL when the issue is resovled.") S GMTSABRT=2
 I +$G(GMTSABRT)=2 S XPDQUIT=2 ;abort and leave global on system
 Q
 ;
TEXT ;HS Names to Check
 ;;Medication Worksheet (Tool #2)
 ;;MAS CONTACTS
 ;;MAS MH CLINIC VISITS FUTURE
 ;;MH HIGH RISK PRF HX
 ;;MH TREATMENT COORDINATOR
 Q
 ;
POST ;post-install
 ;update MHRF component description
 ;WP^DIE(FILE,IENS,FIELD,FLAGS,wp_root,msg_root)
 N GMTSIEN,MSG
 K ^TMP($J,"WP")
 D BMES^XPDUTL("Updating description for Health Summary Component MH HIGH RISK FOR SUICIDE")
 S ^TMP($J,"WP",1,0)="This component displays the assignment status and history for the "
 S ^TMP($J,"WP",2,0)="Category I (National) HIGH RISK FOR SUICIDE Patient Record Flag."
 S ^TMP($J,"WP",3,0)="Any assignment history found for the Category II (Local) High Risk for "
 S ^TMP($J,"WP",4,0)="Suicide flag will also be displayed."
 S GMTSIEN=$$FIND1^DIC(142.1,"","X","MH HIGH RISK PRF HX","B",,"MSG")
 I +$G(GMTSIEN)'>0 K ^TMP($J,"WP") D BMES^XPDUTL("  Error during lookup of MH HIGH RISK PRF HX component.  ") D  Q
 .I $D(MSG)>0 D AWRITE("MSG")
 K MSG
 D WP^DIE(142.1,GMTSIEN_",",3.5,"K","^TMP($J,""WP"")","MSG")
 I $D(MSG)>0 D AWRITE("MSG")
 D:$D(MSG)'>0 BMES^XPDUTL("  Update Successful  ")
 Q
 ;
AWRITE(REF) ;Write all the descendants of the array reference.
 ;REF is the starting array reference, for example A or ^TMP("SOME NAME",$J).
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,GMTSTEXT
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,GMTSTEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 D MES^XPDUTL(.GMTSTEXT)
 Q
 ;
