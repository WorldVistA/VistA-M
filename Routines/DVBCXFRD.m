DVBCXFRD ;ALB/GTS-557/THM-MISCELLANOUS TRANSFER BULLETINS ; 4/17/91  10:59 AM
 ;;2.7;AMIE;**18**;Apr 10, 1995
 ;
BULL1 S FREAS="Addition of C&P request record at target site failed." K MCP D PAR Q
 ;
BULL2 ;  ** Adding exams failed & request deleted **
 N FREAS,FREAS1
 S FREAS="Addition of C&P exams for request record at target site failed."
 S FREAS1="Therefore, the C&P request record was deleted."
 K MCP D PAR
 Q
 ;
BULL3 S FREAS="Addition of veteran in Patient file at target site failed." K MCP,DVBCNEW D PAR Q
 ;
BULL4 S FREAS="Missing C&P request for transfer in - pointer="_REQDA_".",MCP=1 D PAR Q
 ;
BULL5 S FREAS="Missing C&P exams for transfer in",MCP=1 D PAR Q
 ;
BULL6 S FREAS="Local unload of MailMan message failed." K MCP D PAR Q
 ;
BULL7 ;  **  Bulletin for failed address edit  **
 S FREAS="Edit of veteran address in patient file at target site failed."
 K MCP D PAR
 Q
 ;
BULL8 ;  ** Target site has no primary division **
 N FREAS,FREAS1
 S FREAS="Addition of C&P request record at target site failed."
 S FREAS1="Could not determine primary medical center division."
 D PAR
 Q
 ;
BULL9 ;  ** Duplicate SSNs exist or other problem in file #2 **
 N ERR,FREAS,FREAS1
 S FREAS="Update of patient data at target site failed."
 ;if duplicate ssn, then send in error msg
 I $D(DVBCERR("DIERR","E",299)) D
 .S ERR=$O(DVBCERR("DIERR","E",299,0)) I ERR S FREAS1=DVBCERR("DIERR",ERR,"TEXT",1)
 ;if other problem, then just send the first error msg available
 I '$D(DVBCERR("DIERR","E",299)) D
 .S FREAS1=DVBCERR("DIERR",1,"TEXT",1)
 D PAR
 Q
 ;
BULL10 ;  ** Same SSN but possibly different patient in file #2 **
 N FREAS,FREAS1,FREAS2,FREAS3
 S FREAS="Update of patient data at target site failed for SSN "_SSN_"."
 ;if error returned from fm, just send the first error msg available
 I $D(DVBCERR("DIERR")) S FREAS1=DVBCERR("DIERR",1,"TEXT",1)
 ;if name or dob didn't match, then send back that info
 I $D(DVBCERR(1)) S FREAS1=DVBCERR(1),FREAS2="At target site --",FREAS3=DVBCERR(2)
 D PAR
 Q
 ;
BULL11 ;  ** Regional office station# doesn't exist or not unique **
 N FREAS,FREAS1,FREAS2
 S FREAS="Addition of C&P request record at target site failed."
 I RO="" S FREAS1="Your Regional Office station # ("_RONAM_") is not unique"
 I RO=0 S FREAS1="Your Regional Office station # ("_RONAM_") could not be found"
 S FREAS2="in the Institution file of the target site."
 D PAR
 Q
 ;
PAR K ^TMP("DVBC","BULL",$J) S XMSUB="C&P Request Transfer Failure",XMDUZ=.5,XMTEXT="^TMP(""DVBC"",""BULL"",$J,",L=0 I $D(MCP) S USR=$S($D(^DVB(396.3,REQDA,4)):$P(^(4),U,2),1:0) I USR>0 S XMY(USR)="" G PAR1
 S XMY(USER_"@"_SITE1)=SITE
 ;
PAR1 S XMY(XMDUZ)="",L=1,^TMP("DVBC","BULL",$J,L,0)="The transfer of a C&P request "_$S($D(MCP):"from ",1:"to ")_$P(^DVB(396.1,1,0),U,1),L=L+1
 K MCP S ^TMP("DVBC","BULL",$J,L,0)="for the following veteran has failed:",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="   ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="   Name: "_PNAM_"   SSN: "_SSN_"   "_"C-Number: "_CNUM,L=L+1
 S Y=DOB X ^DD("DD") S DOB2=Y
 S ^TMP("DVBC","BULL",$J,L,0)="   DOB: "_DOB2,L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="Reason for failure: ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  "_FREAS,L=L+1
 I $D(FREAS1) S ^TMP("DVBC","BULL",$J,L,0)="  "_FREAS1,L=L+1
 I $D(FREAS2) S ^TMP("DVBC","BULL",$J,L,0)="  "_FREAS2,L=L+1
 I $D(FREAS3) S ^TMP("DVBC","BULL",$J,L,0)="  "_FREAS3,L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="Original sender: "_USER_" at "_SITE1,L=L+1
 S ^TMP("DVBC","BULL",$J,L,0)="  ",L=L+1
 D ^XMD
 Q
