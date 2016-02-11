XM47PT ;ALB/JAM - UPDATE XM DOMAIN ADDED ENTRY IN THE BULLETIN FILE ;May 7, 2015
 ;;8.0;MailMan;**47**;Jun 28, 2002;Build 6
 ;
 Q
 ;
 ;
EN ;Validate user and initialize variables
 I '$D(DUZ) D BMES^XPDUTL("*** PROGRAMMER NOT DEFINED ***") Q
 N XMIEN,XMTL,XMSTR,XMUP,XMDL,XMDSTR
XMESSUPD ;Update the MESSAGE(#10) field of XM DOMAIN
 D BMES^XPDUTL("** Updating the BULLETIN(#3.6) file **")
 S XMIEN=$O(^XMB(3.6,"B","XM DOMAIN ADDED",""))_","
 F XMTL=1:1 S XMSTR=$P($T(MESSBULL+XMTL),";;",2) Q:XMSTR="QUIT"  D
 .S ^TMP($J,"WP",XMTL)=XMSTR
 .Q
 D WP^DIE(3.6,XMIEN,10,"K","^TMP($J,""WP"")","XMUP(""ERR"")")
 I $D(XMUP("ERR")) D XMUERR K ^TMP($J,"WP") Q
XMDESUPD ;Update the DESCRIPTION(#6) field of XM DOMAIN
 F XMDL=1:1 S XMDSTR=$P($T(DESCBULL+XMDL),";;",2) Q:XMDSTR="QUIT"  D
 .S ^TMP($J,"WPD",XMDL)=XMDSTR
 .Q
 D WP^DIE(3.6,XMIEN,6,"K","^TMP($J,""WPD"")","XMUP(""DERR"")")
 I $D(XMUP("DERR")) D XMUERR K ^TMP($J,"WPD"),^TMP($J,"WP") Q
 D BMES^XPDUTL("** The BULLETIN(#3.6) file has been successfully updated. **")
 K ^TMP($J,"WP"),^TMP($J,"WPD")
 Q
XMUERR ;Message to the user that an error occurred
 D BMES^XPDUTL("*** AN ERROR OCCURRED WHEN ATTEMPTING TO UPDATE THE XM DOMAIN ADDED ENTRY. PLEASE CONTACT YOUR IRM ***")
 Q
MESSBULL ;Message contents of the XM DOMAIN bulletin
 ;;This site has just received an incoming transmission from  
 ;;'|2|'. Since we have no record of this domain 
 ;;in the DOMAIN file 4.2, and did not find '|1|' in the 
 ;;INTERNET SUFFIX file 4.2996, we have added '|1|' to the 
 ;;DOMAIN file.
 ;;
 ;;If you think this domain should be added to file 4.2996, 
 ;;please enter a trouble ticket. Only internationally recognized internet 
 ;;suffixes should be added to file 4.2996, and then only via 
 ;;a MailMan patch. 
 ;;
 ;;If you think this domain may be a poorly named VHA domain, 
 ;;please enter a trouble ticket. All new VHA domains should end in 
 ;;'.DOMAIN.EXT'.
 ;;QUIT
DESCBULL ;Description contents of the XM DOMAIN bulletin
 ;;This bulletin is sent to alert IRM to the new domain. This shouldn't happen 
 ;;very often, and if it does, the domain name should be investigated. 
 ;;
 ;;If you think that it is a bad name, enter a trouble ticket so it can be investigated. 
 ;;
 ;;If this new top-level domain is a valid internet suffix, it should be
 ;;deleted from the DOMAIN file and added to file 4.2996, INTERNET SUFFIX,
 ;;and a trouble ticket should be entered for MailMan, so that a patch can be sent
 ;;out to add this top-level domain to file 4.2996 at every site.
 ;;QUIT
 Q
