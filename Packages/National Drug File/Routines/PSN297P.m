PSN297P ;BIR/MR-Post install routine to fix Quinolones Drug Class issue ; 17 Jan 2012  3:18 PM
 ;;4.0;NATIONAL DRUG FILE;**297**; 30 Oct 98;Build 9
 ;Reference to UPDATE^GMRAUTL2 supported by DBIA #4667
 ;
 S XPDIDTOT=17
 N VAPRDIEN,VAGENCNT,VAGENIEN,CLASS,X,DONOTKIL,VAPRD,MSG
 K ^TMP("PSNMSG",$J),^TMP("PSN297P",$J)
 S ^TMP("PSNMSG",$J,1,0)="Number of Patient Allergy entries by class:"
 S ^TMP("PSNMSG",$J,2,0)=" "
 S ^TMP("PSNMSG",$J,3,0)="Before update:"
 S ^TMP("PSNMSG",$J,4,0)="AM900 - ANTI-INFECTIVES,OTHER: "_$$CNT("AM900")
 S ^TMP("PSNMSG",$J,5,0)="AM400 - QUINOLONES           : "_$$CNT("AM400")
 ; 
 S (VAPRDIEN,VAGENCNT)=0
 F  S VAPRDIEN=$O(^PSNDF(50.68,VAPRDIEN)) Q:'VAPRDIEN  D
 . I +$G(^PSNDF(50.68,VAPRDIEN,3))'=640 Q
 . S VAGENIEN=$P(^PSNDF(50.68,VAPRDIEN,0),"^",2)
 . I $D(^TMP("PSN297P",$J,VAGENIEN)) Q
 . S CLASS("D",26)=""
 . S CLASS("A",640)=""
 . S X=VAGENIEN_";PSNDF(50.6,^"_$P(^PSNDF(50.6,VAGENIEN,0),"^")
 . S DONOTKIL=0,VAPRD=0
 . F  S VAPRD=$O(^PSNDF(50.6,"APRO",VAGENIEN,VAPRD)) Q:'VAPRD  D
 . . I $P(^PSNDF(50.68,VAPRD,3),"^")=26 S DONOTKIL=1
 . I DONOTKIL K CLASS("D")
 . S VAGENCNT=VAGENCNT+1
 . D BMES^XPDUTL("Updating Patient Allergies for "_$P(^PSNDF(50.6,VAGENIEN,0),"^")_" ("_VAGENCNT_" of 17)...")
 . I $T(UPDATE^GMRAUTL2)]"" D UPDATE^GMRAUTL2(X,,.CLASS)
 . S ^TMP("PSN297P",$J,VAGENIEN)=""
 . D UPDATE^XPDID(VAGENCNT)
 K ^TMP("PSN297P",$J)
 ;
 S ^TMP("PSNMSG",$J,6,0)=" "
 S ^TMP("PSNMSG",$J,7,0)="After update:"
 S ^TMP("PSNMSG",$J,8,0)="AM900 - ANTI-INFECTIVES,OTHER: "_$$CNT("AM900")
 S ^TMP("PSNMSG",$J,9,0)="AM400 - QUINOLONES           : "_$$CNT("AM400")
 ; 
 N XMY,USR,XMDUZ,XMTEXT,XMSUB,DIFROM
 S XMY(DUZ)="",XMY("G.NDF DATA@"_^XMB("NETNAME"))=""
 S USR=0 F  S USR=$O(^XUSEC("PSNMGR",USR)) Q:'USR  S XMY(USR)=""
 S XMDUZ="NDF MANAGER",XMSUB="Post-install results from patch PSN*4*297"
 S XMTEXT="^TMP(""PSNMSG"",$J,"
 D ^XMD
 Q
 ;
CNT(CLASS) ; Count the number of Patient Allergy entries for a specific class
 N A,B,C,CNT
 S (A,B,C,CNT)=0
 F  S A=$O(^GMR(120.8,"APC",A)) Q:'A  D
 . F  S B=$O(^GMR(120.8,"APC",A,CLASS,B)) Q:'B  D
 . . F  S C=$O(^GMR(120.8,"APC",A,CLASS,B,C)) Q:'C  D
 . . . S CNT=CNT+1
 Q CNT
