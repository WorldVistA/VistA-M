PSNFDAMG ;BIR/DMA - On-Demand FDA Med Guide Display ; 14 Oct 2015  8:26 AM
 ;;4.0;NATIONAL DRUG FILE;**108,263,264,437**; 30 Oct 98;Build 8
 ;Reference to ^PS(59.7 supported by DBIA #2613
 ;
EN(VAPRDIEN) ; Entry point for FDA Med Guide On-Demand Printing
 N FDAMGFN,FDAMGURL,PCURL,STATUS,X,PSNIP
 S FDAMGFN=$$FDAMG^PSNAPIS(VAPRDIEN)
 I FDAMGFN="" D  Q
 . W !!,"There is no FDA Medication Guide associated with this medication.",!
 . D PAUSE
 ;
 W !!,"The following URL provides the link to the FDA Medication Guide associated"
 W !,"with this medication. Thin Client users: copy/paste the URL below into a"
 W !,"browser to access the FDA Medication Guide for this drug:"
 W !!
 ;
 ; Concatenating the Web Server URL to the FDA Med Guide file name
 S FDAMGURL=$$GET1^DIQ(59.7,1,100)_FDAMGFN
 ;
 D PRTURL(FDAMGURL)
 ;
 S PSNIP=$S($G(IO("IP"))'="":IO("IP"),1:"127.0.0.1")
 I $$VERSION^XLFIPV S PSNIP="["_$$CONVERT^XLFIPV(PSNIP)_"]"
 S PCURL="http://"_PSNIP_":8091/viewmg="
 ;
 W !!,"Please wait...",!
 ;
 ;Invoking Kernel HTTP Toolkit
 S STATUS=$$GETURL^XTHC10(PCURL_FDAMGURL)
 ;
 I +STATUS'=200 D
 . W !,"The system is unable to display FDA Med Guide automatically."
 . W !
 . W !,"The FDA Medication Guide will not automatically open on Thin Client and some"
 . W !,"types of encrypted sessions. If you do not believe this is the reason contact"
 . W !,"your local technical support for assistance."
 . W !
 . W !,"You can copy/paste the link above into your browser's address bar to retrieve"
 . W !,"the FDA Medication Guide."
 . W !
 ;
 D PAUSE
 Q
 ;
PAUSE ;
 N DIR
 S DIR("A")="Enter RETURN to continue, '?' for HELP, or '^' to exit",DIR(0)="E"
 S DIR("?")="^D HELP^PSNFDAMG("""_$G(FDAMGURL)_""")" D ^DIR
 Q
 ;
HELP(MGURL) ; Help Text
 N DIR,DIRUT,DIROUT
 W !,"When unable to get the FDA Medication Guide to display, review the following"
 W !,"suggestion(s) for troubleshooting potential problems:"
 W !
 I $G(MGURL)'="" D
 . W !,"1) The browser did not open automatically. This may be due to the following:"
 . W !,"   - You might be connected to VistA via Thin Client or an encrypted session"
 . W !,"     that prevents the FDA Med Guide from automatically displaying. Please"
 . W !,"     copy and paste the URL link below into your browser's address bar to"
 . W !,"     retrieve the FDA Medication Guide:"
 . W !!  D PRTURL(MGURL) W !
 . W !,"   - The computer might not have the required Java software component"
 . W !,"     installed or the software might not be functioning properly. Please,"
 . W !,"     contact technical support for assistance."
 . W !
 . S DIR("A")="Enter RETURN to continue" D PAUSE^VALM1 Q:($G(DIRUT)!$G(DIROUT))
 . ;
 . W !,"2) When doing a copy/paste of the link into the browser's address and an HTTP"
 . W !,"   404 - File Not Found error is received. This may be due to the following:"
 . W !,"   - A common issue exists when the link is displayed in two lines in the"
 . W !,"     terminal screen. When you copy both lines at the same time and paste it"
 . W !,"     into the browser's address, the second line is ignored by the browser"
 . W !,"     resulting in a 'broken' link. To resolve this issue, copy and paste one"
 . W !,"     line at a time from the terminal screen into the browser's address to"
 . W !,"     make sure the complete link is used."
 . W !,"   - The FDA Medication Guide Server may be down at the moment. Please, wait"
 . W !,"     a few minutes and try again. If the problem persists, contact technical"
 . W !,"     support for assistance."
 . ;
 . W !!,"3) The browser opened automatically, however you receive an HTTP 404 - File"
 . W !,"   Not Found error. This may be due to the following:"
 . W !,"   - The FDA Medication Guide Server may be down at the moment. Please, wait"
 . W !,"     a few minutes and try again. If the problem persists, contact technical"
 . W !,"     support for assistance."
 . W !
 E  D
 . W !,"1) If no FDA Medication Guide exists for a product that you believe should"
 . W !,"   have one, confirm that one is required by visiting the FDA website"
 . W !,"   (www.fda.gov). If one is required, log a support ticket to request its"
 . W !,"   addition. Please understand that there may be a delay between the time"
 . W !,"   that a new Medication Guide is posted to the FDA website and when it is"
 . W !,"   made available in VistA through a National Drug File data update patch."
 Q
 ;
PRTURL(FDAMGURL) ; Prints the FDA Med Guide URL
 S X=$G(FDAMGURL) I $$LOW^XLFSTR($E(X,1,7))="http://" S X=$E(X,8,999)
 W $E(X,1,80) I $L(X)>80 D
 . F  Q:$E(X,81,999)=""  S X=$E(X,81,999) W !,$E(X,1,80)
 Q
