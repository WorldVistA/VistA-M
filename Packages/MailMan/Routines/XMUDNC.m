XMUDNC ;ISC-SF/GMB-Domain Name Change ;04/17/2002  11:48
 ;;8.0;MailMan;;Jun 28, 2002
 ; A domain name change happens in two steps, in two patches:
 ; 1. The first patch adds the new name as a synonym to the site's
 ;    DOMAIN file entry at all sites.  (Entry SYNONYM)
 ; 2. When all sites have added the synonym, the second patch switches
 ;    the names in the DOMAIN file at all sites.  The synonym becomes
 ;    the domain name, and old domain name becomes the synonym.
 ;    The domain name is changed in each TCP/IP script, too.
 ;    The domain name is changed in the Postmaster's basket.
 ;    The site's name is changed in file 4.3 MAILMAN SITE PARAMETERS.
 ;    (Entry CHANGE)
SYNONYM ;
 D BMES^XPDUTL("Add <new site name> as synonym for <current site name> in DOMAIN file.")
 D REINDEX
 N XMB,XMI,XMDOM,XMSUBDOM,XMSYN
 ;D INIT("S") Q:'$D(^DOPT("XMSYN",$J))
 S (XMB,XMI)=""
 F  S XMB=$O(^DIC(4.2,"B",XMB)) Q:XMB=""  D
 . F  S XMI=$O(^DIC(4.2,"B",XMB,XMI)) Q:XMI=""  D
 . . N DIC,X,Y
 . . S (X,XMDOM)=$P(^DIC(4.2,XMI,0),U,1)
 . . S XMSUBDOM=""
 . . S DIC="^DOPT(""XMSYN"",$J,"
 . . S DIC(0)="XZ"
 . . F  D ^DIC Q:Y>0!($L(X,".")<4)  D
 . . . S XMSUBDOM=XMSUBDOM_$P(X,".")_"."
 . . . S X=$P(X,".",2,99)
 . . Q:Y<0  ; Quit if (sub) domain is not in the table
 . . D BMES^XPDUTL("Domain: "_XMDOM)
 . . S XMSYN=$P(Y(0),U,2)
 . . I XMSYN="" S XMSYN=$P(XMDOM,".",1,$L(XMDOM,".")-2)_".MED.VA.GOV"
 . . E  S XMSYN=XMSUBDOM_XMSYN
 . . D CHKSYN(XMI,XMSYN)
 K ^DOPT("XMSYN",$J)
 Q
INIT(XMENTRY) ; Load table into global
 ; XMENTRY - An entry point in a pre-init (for synonyms) or post-init
 ;           (for changes).
 N DIK,I,X
 K ^DOPT("XMSYN",$J)
 F I=1:1 S X=$T(@XMENTRY+I) Q:X=" ;;"  S ^DOPT("XMSYN",$J,I,0)=$E(X,4,255)
 Q:'$D(^DOPT("XMSYN",$J))
 S ^DOPT("XMSYN",$J,0)="Domain Synonyms^1N^"
 S DIK="^DOPT(""XMSYN"",$J,"
 D IXALL^DIK
 Q
CHKSYN(XMDIEN,XMSYN) ;
 N XMSIEN
 D MES^XPDUTL("Lookup Synonym: "_XMSYN)
 S XMSIEN=$$FIND1^DIC(4.2,"","MQX",XMSYN,"B^C")
 I $D(DIERR) D  Q
 . N XMI
 . D MES^XPDUTL("*** Error on look up!")
 . D MES^XPDUTL("*** Usually means more than one occurence.")
 . I $D(^DIC(4.2,"B",XMSYN)) D MES^XPDUTL("*** Synonym is also a domain!")
 . S XMI=0
 . F  S XMI=$O(^DIC(4.2,"C",XMSYN,XMI)) Q:'XMI  D
 . . D MES^XPDUTL("*** Synonym is for domain IEN "_XMI_", name "_$P(^DIC(4.2,XMI,0),U,1))
 . D MES^XPDUTL("*** No action taken.  Please investigate and fix.")
 I XMSIEN=XMDIEN D MES^XPDUTL("Already there.") Q
 I XMSIEN D  Q
 . I $D(^DIC(4.2,"B",XMSYN)) D MES^XPDUTL("*** Synonym is also a domain!")
 . E  D MES^XPDUTL("*** Synonym is for domain IEN "_XMSIEN_", name "_$P(^DIC(4.2,XMSIEN,0),U,1))
 . D MES^XPDUTL("*** No action taken.  Please investigate and fix.")
 D MES^XPDUTL("Not found.  Adding it.")
 S XMFDA(4.23,"+1,"_XMDIEN_",",.01)=XMSYN
 D UPDATE^DIE("","XMFDA")
 I $D(DIERR) D MES^XPDUTL("*** Error adding it!")
 Q
CHANGE ;
 D BMES^XPDUTL("Change <current site name> to <new site name> in DOMAIN file.")
 D REINDEX
 N XMB,XMI,XMDOM,XMSUBDOM,XMSYN
 ;D INIT("C") Q:'$D(^DOPT("XMSYN",$J))
 K ^TMP("XM",$J)
 S (XMB,XMI)=""
 F  S XMB=$O(^DIC(4.2,"B",XMB)) Q:XMB=""  D
 . F  S XMI=$O(^DIC(4.2,"B",XMB,XMI)) Q:XMI=""  D
 . . N DIC,X,Y,XMSTAT
 . . S (X,XMDOM)=$P(^DIC(4.2,XMI,0),U,1)
 . . S XMSUBDOM=""
 . . S DIC="^DOPT(""XMSYN"",$J,"
 . . S DIC(0)="XZ"
 . . F  D ^DIC Q:Y>0!($L(X,".")<4)  D
 . . . S XMSUBDOM=XMSUBDOM_$P(X,".")_"."
 . . . S X=$P(X,".",2,99)
 . . Q:Y<0  ; Quit if (sub) domain is not in the table
 . . D BMES^XPDUTL("Domain: "_XMDOM)
 . . S XMSYN=$P(Y(0),U,2)
 . . I XMSYN="" S XMSYN=$P(XMDOM,".",1,$L(XMDOM,".")-2)_".MED.VA.GOV"
 . . E  S XMSYN=XMSUBDOM_XMSYN
 . . D CHKNAME(XMI,XMDOM,XMSYN,.XMSTAT)
 . . S ^TMP("XM",$J,XMDOM)=XMSYN_U_$G(XMSTAT,"ERROR")
 I $G(^XMB("NUM"))'=$P(^XMB(1,1,0),U,1) S ^XMB("NUM")=$P(^XMB(1,1,0),U,1)
 I ^XMB("NETNAME")'=$P(^DIC(4.2,^XMB("NUM"),0),U,1) D
 . S (^XMB("NETNAME"),^XMB("NETNAME"))=$P(^DIC(4.2,^XMB("NUM"),0),U,1)
 . D BMES^XPDUTL("The name of this site has been changed to "_^XMB("NETNAME"))
 D CSUMM
 Q
CHKNAME(XMDIEN,XMDOM,XMSYN,XMSTAT) ;
 N XMSIEN
 D MES^XPDUTL("Lookup Synonym: "_XMSYN)
 S XMSIEN=$$FIND1^DIC(4.2,"","MQX",XMSYN,"B^C")
 I $D(DIERR) D  Q
 . N XMI
 . D MES^XPDUTL("*** Error on look up!")
 . D MES^XPDUTL("*** Usually means more than one occurence.")
 . I $D(^DIC(4.2,"B",XMSYN)) D MES^XPDUTL("*** Synonym is also a domain!")
 . S XMI=0
 . F  S XMI=$O(^DIC(4.2,"C",XMSYN,XMI)) Q:'XMI  D
 . . D MES^XPDUTL("*** Synonym is for domain IEN "_XMI_", name "_$P(^DIC(4.2,XMI,0),U,1))
 . D MES^XPDUTL("*** No action taken.  Please investigate and fix.")
 I XMSIEN=XMDIEN D  Q
 . D MES^XPDUTL("Already there.  Reversing domain/synonym:")
 . D REVERSE(XMDIEN,XMDOM,XMSYN,.XMSTAT)
 I XMSIEN D  Q
 . I $D(^DIC(4.2,"B",XMSYN)) D MES^XPDUTL("*** Synonym is also a domain!")
 . E  D MES^XPDUTL("*** Synonym is for domain IEN "_XMSIEN_", name "_$P(^DIC(4.2,XMSIEN,0),U,1))
 . D MES^XPDUTL("*** No action taken.  Please investigate and fix.")
 D MES^XPDUTL("Not found.  Adding it.")
 S XMFDA(4.23,"+1,"_XMDIEN_",",.01)=XMSYN
 D UPDATE^DIE("","XMFDA")
 I $D(DIERR) D MES^XPDUTL("*** Error adding it!") Q
 D MES^XPDUTL("Reversing domain/synonym:")
 D REVERSE(XMDIEN,XMDOM,XMSYN,.XMSTAT)
 Q
REVERSE(XMDIEN,XMOLDNAM,XMNEWNAM,XMSTAT) ;
 I '$D(^DIC(4.2,"C",XMOLDNAM,XMDIEN)) D  Q:$D(DIERR)
 . D MES^XPDUTL(XMOLDNAM_" is not yet a synonym of itself.  Adding it.")
 . S XMFDA(4.23,"+1,"_XMDIEN_",",.01)=XMOLDNAM
 . D UPDATE^DIE("","XMFDA")
 . I $D(DIERR) D MES^XPDUTL("*** Error adding it!")
 E  D MES^XPDUTL(XMOLDNAM_" is already a synonym of itself.")
 D MES^XPDUTL("Change the domain name in the transmission scripts.")
 N XMI,XMJ,XMTEXT
 S XMI=0
 F  S XMI=$O(^DIC(4.2,XMDIEN,1,XMI)) Q:'XMI  D
 . S XMJ=0
 . F  S XMJ=$O(^DIC(4.2,XMDIEN,1,XMI,1,XMJ)) Q:'XMJ  D
 . . Q:^DIC(4.2,XMDIEN,1,XMI,1,XMJ,0)'[XMOLDNAM
 . . S XMTEXT=^DIC(4.2,XMDIEN,1,XMI,1,XMJ,0)
 . . S ^DIC(4.2,XMDIEN,1,XMI,1,XMJ,0)=$P(XMTEXT,XMOLDNAM,1)_XMNEWNAM_$P(XMTEXT,XMOLDNAM,2)
 I $D(^XMB(3.7,.5,2,1000+XMDIEN,0)) D
 . D MES^XPDUTL("Change the transmission queue name to "_XMNEWNAM_".")
 . S XMFDA(3.701,1000+XMDIEN_",.5,",.01)=$E(XMNEWNAM,1,30)
 . D FILE^DIE("","XMFDA")
 . I $D(DIERR) D MES^XPDUTL("*** Error changing it!")
 E  D MES^XPDUTL("There is no transmission queue for this domain.  That's OK.")
 D MES^XPDUTL("Change the domain name to "_XMNEWNAM_".")
 S XMFDA(4.2,XMDIEN_",",.01)=XMNEWNAM
 D FILE^DIE("","XMFDA")
 I $D(DIERR) D MES^XPDUTL("*** Error changing it!") Q
 S XMSTAT="DONE"
 Q
CSUMM ;
 N XMI,XMREC,XMOLD,XMNEW,XMCHK
 S XMI=0
 F  S XMI=$O(^DOPT("XMSYN",$J,XMI)) Q:'XMI  S XMREC=^(XMI,0) D
 . S XMOLD=$P(XMREC,U,1)
 . Q:$D(^TMP("XM",$J,XMOLD))
 . S (XMNEW,XMCHK)=$P(XMREC,U,2) I XMNEW="" S XMNEW="xxx.MED.VA.GOV",XMCHK=$P(XMOLD,".",1,$L(XMOLD,".")-2)_".MED.VA.GOV"
 . S ^TMP("XM",$J,XMOLD)=XMNEW_U_$S($D(^DIC(4.2,"B",XMCHK)):"OK",1:"???")
 D BMES^XPDUTL("Summary for Domain Name Change")
 D MES^XPDUTL("Status key:")
 D MES^XPDUTL("  OK:    Already changed, did not check further.")
 D MES^XPDUTL("  DONE:  Name changed during this install.")
 D MES^XPDUTL("  ERROR: Error noted.  See listing above and fix.")
 D MES^XPDUTL("  ???:   Not in your DOMAIN file.  Consider adding it.")
 D BMES^XPDUTL($$LJ^XLFSTR("Old Name",34)_" "_$$LJ^XLFSTR("New Name",37)_" Status")
 D MES^XPDUTL($$LJ^XLFSTR("",34,"-")_" "_$$LJ^XLFSTR("",37,"-")_" ------")
 S XMOLD=""
 F  S XMOLD=$O(^TMP("XM",$J,XMOLD)) Q:XMOLD=""  S XMREC=^(XMOLD) D
 . D MES^XPDUTL($$LJ^XLFSTR($E(XMOLD,1,34),35)_$$LJ^XLFSTR($E($P(XMREC,U,1),1,37),38)_$E($P(XMREC,U,2),1,6))
 K ^DOPT("XMSYN",$J),^TMP("XM",$J)
 Q
REINDEX ;
 D MES^XPDUTL("First, let's reindex the B and C xrefs.")
 N DIK,DA,XMI
 K ^DIC(4.2,"B"),^DIC(4.2,"C")
 S DIK="^DIC(4.2,",DIK(1)=".01^B" D ENALL^DIK
 S XMI=0
 F  S XMI=$O(^DIC(4.2,XMI)) Q:'XMI  D
 . N DIK,DA
 . Q:'$O(^DIC(4.2,XMI,2,0))
 . S DA(1)=XMI,DIK="^DIC(4.2,"_DA(1)_",2,",DIK(1)=".01^C" D ENALL^DIK
 D MES^XPDUTL("Done reindexing.  Let's get down to business...")
 Q
S ;;current site name^new site name (Add synonyms)
 ;;ISC-SF.VA.GOV^FO-OAKLAND.MED.VA.GOV
 ;;
C ;;current site name^new site name (Change the names)
 ;;ISC-SF.VA.GOV^FO-OAKLAND.MED.VA.GOV
 ;;
