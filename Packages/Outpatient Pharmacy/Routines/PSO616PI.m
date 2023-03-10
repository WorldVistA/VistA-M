PSO616PI ;PER/ME-Post-install routine for Patch PSO*7.0*616 ; 04 Jul 2020  2:00 PM
 ;;7.0;OUTPATIENT PHARMACY;**616**;DEC 1997;Build 3
 ;
 Q
POST ; Entry point
 D BMES^XPDUTL("  Starting post-install for PSO*7*616")
 N FOUND,PSOLINE,X1,X2,FOUND
 S PSOLINE=0 K ^TMP("PSO616PI",$J),^XTMP("PSO616PI",$J)
 D SETTXT("This report documents missing file #52 [PRESCRIPTION] Label multiple header")
 D SETTXT("records. Any instance of a Label multiple that has been created without the")
 D SETTXT("appropriate Label multiple header record will automatically be corrected to")
 D SETTXT("have the appropriate Label multiple header record.")
 D SETTXT("===============================================================================")
 D SETTXT("")
 D SETTXT("Prescription#             File #52 IEN")
 D SETTXT("-------------             ------------")
 ;
 S (X1,FOUND)=0
 F  S X1=$O(^PSRX(X1)) Q:'X1  D
 .I $D(^PSRX(X1,"L",1)),'$D(^PSRX(X1,"L",0)) D
 ..S FOUND=FOUND+1
 ..S X2=$O(^PSRX(X1,"L","Z"),-1)
 ..S ^PSRX(X1,"L",0)="^52.032DA^"_X2_"^"_X2
 ..D SETTXT($P(^PSRX(X1,0),U,1)_$J(X1,26+$L(X1)-$L($P(^PSRX(X1,0),U,1))))
 ;
 D SETTXT("")
 I 'FOUND D SETTXT("No Prescriptions were found with a missing Label multiple header.")
 ;
 D MAIL
 ;
 D BMES^XPDUTL("  Mailman message sent.")
 D BMES^XPDUTL("  Finished post-install for PSO*7*616.")
 ;
END ; Exit point
 K ^TMP("PSO616PI",$J),^XTMP("PSO616PI",$J)
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S PSOLINE=$G(PSOLINE)+1,^XTMP("PSO616PI",$J,PSOLINE)=TXT
 Q
 ;
MAIL ; Sends Mailman message
 N II,XMX,XMSUB,XMDUZ,XMTEXT,XMY
 S II=0 F  S II=$O(^XUSEC("PSNMGR",II)) Q:'II  S XMY(II)=""
 S XMY(DUZ)="",XMSUB="PSO*7*616 - Autocorrection Utility"
 S XMDUZ=.5,XMTEXT="^XTMP(""PSO616PI"",$J," N DIFROM D ^XMD
 Q
