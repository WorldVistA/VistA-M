IBY652E ;AITC/TAZ-Environment Check Routine for Patch 652;10 Jun 19
 ;;2.0;INTEGRATED BILLING;**652**;21-MAR-94;Build 23
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 N DIR,DIROUT,DIRUT,DLAYGO,DR,DTOUT,DUOUT,FILENAME,INSTCMP,IOCSITE,OK,POP,PROD,SITE,SITESYS,X,Y
 ;
 S XPDQUIT=0  ; Default to OK to install
 ;
 S XPDNOQUE=1   ; Do NOT allow Queueing
 ;
 S SITESYS=$P($$SITE^VASITE,U,3)
 ;
 I (DT>3200131) G EXIT                 ;Past the compliance date, no longer processing files.
 ;
 ;If site is Manila, skip environment checking.
 I SITESYS=358 G EXIT
 ;
 S PROD=$$PROD^XUPROD(1)
 S INSTCMP=$$GET1^DIQ(9.7,$O(^XPD(9.7,"B","IB*2.0*652",""),-1)_",",.02,"I")=3
 F SITE=405,515,518,585,662 S IOCSITE(SITE)=""
 ;
 I 'PROD,'$D(IOCSITE(SITESYS)) G EXIT      ;Test account and not an IOC site
 ; Only IOC TEST sites and all PROD sites get here
 I INSTCMP,'$D(IOCSITE(SITESYS)) G EXIT    ;Already installed once and not an IOC site
 ;
 S DIR(0)="FA",DIR("A")="Enter the path to the file you downloaded: "
 S DIR("A",1)="Enter the directory where you placed the downloaded file."
 S DIR("A",2)="Example: /home/directory A/directory B/"
 S DIR("A",3)="Do NOT include the filename."
 S DIR("A",4)=" "
 S DIR("?")="This is the directory where you downloaded the file required for patch IB*2.0*652."
 W ! D ^DIR K DIR I $D(DIRUT)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) S XPDQUIT=1 G EXIT
 S PATH=Y I $E(PATH,$L(PATH))'="/" S PATH=PATH_"/"
 ;
 S FILENAME="va"_SITESYS_".txt"
 ;
 ; Does the file exist & can I read it?
 D OPEN^%ZISH("INPUT",PATH,FILENAME,"R")
 I POP D   G EXIT
 . S XPDQUIT=1  ;Don't load patch
 . W !,"Can't open File. Please check that you have the file in the "
 . W !,"proper directory and re-install the patch."
 U IO R X:5
 I ($P($P(X,":",2),U)'=SITESYS) D
 . S XPDQUIT=1  ;Don't load patch
 . U 0 W !,"File is for a different site.  Retrieve proper file and re-install patch."
 D CLOSE^%ZISH("INPUT")
 I XPDQUIT=1 G EXIT
 W !,"File exists and can be read."
 ;
 S FILENAME="va"_SITESYS_"-results.txt"
 D OPEN^%ZISH("OUTPUT",PATH,FILENAME,"W")
 I POP D
 . S XPDQUIT=1 W !,"Could not create file. Please check that the path has proper settings to write a file then re-install patch." G EXIT
 U IO W "Site:"_SITESYS_"^Results of IB*2.0*652 installed on "_$$FMTE^XLFDT(DT),!
 D CLOSE^%ZISH("OUTPUT")
 ;
EXIT ;End of routine.
 Q
