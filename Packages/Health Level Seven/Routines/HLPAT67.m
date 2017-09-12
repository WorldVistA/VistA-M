HLPAT67 ;SFCIOFO/JIC POSTINIT ;12/07/2000  16:10
 ;;1.6;HEALTH LEVEL SEVEN;**67**;JUL 17, 1995
ENTER ; For Cache/NT sites which have patch HL*1.6*39 installed,
 ; for every TCP link to a VA site, set the SAY HELO field to YES
 D BMES^XPDUTL("Checking to see if the post-init should run:")
 I ^%ZOSF("OS")'["OpenM" D  Q
 . D MES^XPDUTL("This is not a Cache/NT site.  Post-init not needed.")
 E  D
 . D MES^XPDUTL("This is a Cache/NT site.  Post-init needed.")
 I '$$PATCH^XPDUTL("HL*1.6*39") D  Q
 . D MES^XPDUTL("HL*1.6*39 is not installed.  Post-init will not run.")
 . D MES^XPDUTL("You will have to manually identify TCP VA links and")
 . D MES^XPDUTL("set their SAY HELO field to YES.")
 E  D
 . D MES^XPDUTL("HL*1.6*39 is installed.  Post-init will run.")
 D BMES^XPDUTL("Post-init will identify all TCP links to VA sites (name starts with 'VA')")
 D MES^XPDUTL("and set the SAY HELO field to YES:")
 N HLTCP,HLL,HLNAME
 S HLTCP=$O(^HLCS(869.1,"B","TCP",0)) Q:'HLTCP
 S HLL=0
 F  S HLL=$O(^HLCS(870,"ALLP",HLTCP,HLL)) Q:'HLL  D
 . S HLNAME=$P($G(^HLCS(870,HLL,0)),U,1)
 . I $E(HLNAME,1,2)'="VA",HLNAME'="MPIVA" Q  ; must be link to VA site
 . D MES^XPDUTL("ien="_HLL_", name="_$P(^HLCS(870,HLL,0),U,1))
 . S $P(^HLCS(870,HLL,400),U,7)="Y"
 D BMES^XPDUTL("The SAY HELO field was set to YES for the above TCP Links.")
 D MES^XPDUTL("Please review this.  If any is not a VA site, set its SAY HELO field to NO.")
 Q
