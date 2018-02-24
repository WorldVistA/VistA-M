PSNPPSNF ;HP/MJE-PPSN update NDF data ; 05 Mar 2014  1:20 PM
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;Reference to ^%ZISH supported by DBIA #2320
 ;Reference to ^XUTMOPT supported by DBIA #1472
 ;
 ;This routine is used to locate and move PPSN NDF update host files into Cache for processing
 Q
 ;
MFIND ;Entry point for menu option PSNUPDT for immediate PPS-N updates
 N PSENTER,DIE,DA,DR,ERRCHK,PSIMHERE,PSNLEG,PSNLEGF,PSNHLD2
 I $$GET1^DIQ(57.23,1,10,"I")="Y" D  Q
 .Q:$G(PSNSCJOB)
 .W !!,"A PPS-N/NDF file install is already in progress.  Please try again later."
 .R !!,"Press enter to continue...",PSENTER:120
 ;
 I '$D(^XUSEC("PSN PPS ADMIN",DUZ))&('$G(PSNSCJOB)) D
 .W !!,"You do not have the appropriate security key to use this option"
 .W !,"please contact your ADPAC to resolve this issue.",!
 .S DIR(0)="E",DIR("A")=" Press ENTER to Continue" D ^DIR K DIR
 I '$D(^XUSEC("PSN PPS ADMIN",DUZ)) Q
 S PSNLEGF="",PSNLEGF=$$LEGACY^PSNPPSDL() I PSNLEGF Q
 ;
 D CHKD^PSNPPSDL ;update Unix directory if needed and create it if entry does not exist.
 ;
 I '$G(PSNSCJOB) D  Q:'Y
 .W !!!,"Warning: The NDF update should only be done during off duty hours!"
 .W !,"         Installation may take up to 30 minutes, and the following options"
 .W !,"         will automatically be disabled during installation then enabled"
 .W !,"         once installation has completed."
 .W !!,"           * Print A PMI Sheet      * Patient Prescription Processing"
 .W !,"           * Release Medication     * Reprint an Outpatient Rx Label",!
 .K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N."
 .S DIR("A")="Are you sure you want to immediately begin an NDF Update" W !
 .S DIR("B")="NO"
 .D ^DIR
 .I 'Y Q
 ;
FIND ;Get list of files, quit if flag set to disable update function
 ;I $P(^PS(57.23,1,0),"^",4)=0 Q
 N A1,B1,B2,I,X2,X22,II,XX,QUEST,QUIT2,PSRUNCNT,PSGRP,REJFILE,INSFILE
 K ^TMP("PSN PPSN PARSED",$J)
 N PSNATYP S PSNATYP="",PSNATYP=$P(^PS(59.7,1,10),"^",12)
 S A1("PPS_*")="",(PSNFND,PSNFLG,QUIT2,PSRUNCNT)=0,COMM=1
 I $D(^TMP("PSN PPSN READ",$J)) K ^TMP("PSN PPSN READ",$J)
 S Y=$$LIST^%ZISH($$GETD^PSNFTP(),$NA(A1),$NA(B2))
 S I="" F  S I=$O(B2(I)) Q:I=""  S B1(99999999+(+$P(I,"_",2)))=I
 K B2
CKDIR ;
 G EXIT:'$D(B1)
 I '$G(PSNSCJOB) D QUEST^PSNPPSMS G EXIT:$G(QUIT2)
 ;
 W !,"Please stand-by NDF update processing can take around 30 minutes..."
 S DIE="^PS(57.23,",DA=1,DR="10///Y" D ^DIE K DIE,DA,DR
 ;
 S X2="" F  S X2=$O(B1(X2)) Q:X2=""!(+$G(REJFILE))  S X22=$G(B1(X2)) D  G:COMM=0 EXIT
 .I $P(X22,"_")="PPS"&(+$P(X22,"_",2)=$P(^PS(57.23,1,0),"^",3)) D
 ..S (PSNFND,PSNFLG)=1 S PSNHLD=X22
 ..D READ I +$G(REJFILE) Q
 ..I '$G(PSNSCJOB),'+INSFILE Q
 ..I '$G(PSNSCJOB) D
 ...W !,"Installation completed"_$S($G(ERRCHK):" with errors.  See error mail message",1:"")_".",!
 ...D CTRKDL^PSNPPSMS("Installation completed"_$S($G(ERRCHK):" with errors.  See error mail message",1:"")_".")
 ..I $O(B1(X22))]"",$D(^TMP("PSN PPSN READ",$J)) W:'$G(PSNSCJOB) !,"Purging background work files before starting the next install...",! K ^TMP("PSN PPSN READ",$J),^TMP("PSN PPSN PARSED",$J)
 I 'PSNFND W !,"There were no PPS-N update files to install.",!
 ;I PSNFLG S PSNFLG=0 G CKDIR
EXIT ;
 ;D ENABLE^PSNPPSMS
 K DIE,DA,DR
 S DIE="^PS(57.23,",DA=1,DR="10///N" D ^DIE K DIE,DA,DR
 K A1,B2,B1,^TMP("PSN PPSN READ",$J),^TMP("PSN PPSN PARSED",$J)
 K X2,X22,OLDNDF,COMM,I,I1,PSNFLG,PSNFND,PSNHLD,PSNHLD1,XX,OLDNDF,XPDIDTOT
 K Z11,Z12,Z13,Z14,Z15,Z16,Z17,Z18,Z19,Z191,Z192,Z193,Z194
 K Z21,Z22,Z23,Z24,Z25,Z26,Z27,Z28,Z29,Z291,Z292,Z293,Z294
 K Z31,Z32,Z33,Z34,Z35,Z36,Z37,Z38,Z39,Z391,Z392,Z393,Z394
EXIT2 ;
 Q
 ;
READ ;Read in file
 S (INSFILE,REJFILE)=""
 S REJFILE=$$REJCHK($P(PSNHLD,";")) Q:+REJFILE
 S INSFILE=$$INSTCHK($P(PSNHLD,";"))
 I '+INSFILE,'$G(PSNSCJOB) W !!,$P(PSNHLD,";")_" has not been installed.",! Q
 W:'$G(PSNSCJOB) !!,"Beginning install for "_$P(X22,";"),!
 I PSNATYP="N" I $$NDFK(PSNHLD) D NDFKP^PSNPPSNK  ;purge NDFK file before install
 D XTMP
 N XUMF,XPDGREF,NDFOK
 S (XUMF,XPDGREF,NDFOK)=1
 K CTRLIEN
 S CTRLIEN=$O(^PS(57.23,"B","PPSN",""))
 K FDA
 S (PSNHLD2,FDA(57.231,"+2,"_1_",",.01))=$P(PSNHLD,";")_";"_$P(INSFILE,"^",2)
 D UPDATE^DIE("","FDA")
 K CTRLXIEN
 S CTRLXIEN=$O(^PS(57.23,1,5,"B",$P(PSNHLD,";")_";"_$P(INSFILE,"^",2),""),-1)
 K FDA,%
 D NOW^%DTC
 S FDA(57.231,CTRLXIEN_","_CTRLIEN_",",1)=%
 D UPDATE^DIE("","FDA","CTRLIEN")
 K FDA
 S FDA(57.23,CTRLIEN_",",30)=1
 D FILE^DIE("","FDA")
 K FDA
 ;
 W:'$G(PSNSCJOB) !,"Importing the Update file into VistA...",!
 ;write comm here to send message - file found processing has STARTED
 N PSERRMSG,PSMSGTXT,PSRGP,XMTEXT,XMY,PSNSITET,PSNZISH
 S PSNSITET=$P($G(^PS(59.7,1,10)),"^",12)
 D CTRKDL^PSNPPSMS("Install STARTED message sent to PPS-N")
 I PSNSITET="P" S COMM=$$SEND^PSNPPSNC("STARTED",$P(PSNHLD,";"),"")
 S COMM=1
 ;
 I COMM=0 D  Q
 .D CTRKDL^PSNPPSMS("Communication with PPS-N system is down or the station number is invalid.")
 .S PSERRMSG="Install cannot be completed."
 .S PSMSGTXT="Communication with PPS-N system is down or the station number is invalid."
 .I '$G(PSNSCJOB) W !,PSERRMSG,!,PSMSGTXT,! R !!,"Press enter to continue...",PSENTER:120
 .D MSGTEXT0^PSNFTP($P(PSNHLD,";"),PSERRMSG,.PSMSGTXT)
 .S XMTEXT="PSMSGTXT("
 .S PSGRP="",PSGRP=$$GET1^DIQ(57.23,1,5) I PSGRP'="" S XMY($$MG^PSNPPSMG(PSGRP))=""
 .S PSGRP="",PSGRP=$$GET1^DIQ(57.23,1,6) I PSGRP'="" S XMY($$MG^PSNPPSMG(PSGRP))=""
 .N DIFROM D ^XMD
 ;
 S PSNZISH=$NA(^TMP("PSN PPSN READ",$J,1)) S Y=$$FTG^%ZISH($$GETD^PSNFTP(),X22,PSNZISH,3)
 ;
 D CTRKDL^PSNPPSMS("Parsing data and creating TMP file")
 W:'$G(PSNSCJOB) !,"Parsing the data...",!
MOVE ;Move data to ^TMP for call to update
 ;
 D CTRKDL^PSNPPSMS("Reading update file into TMP('PSN PPSN READ',$J) global.")
 N Z11,Z12,Z13,Z14,Z15,Z16,Z17,Z18,Z19,Z191,Z192,Z193,Z194,Z21,Z22,Z23,Z24,Z25,Z26,Z27,Z28,Z29,Z291,Z292,Z293,Z294,Z31,Z32,Z33,Z34,Z35,Z36,Z37,Z38,Z39,Z391,Z392,Z393,Z394
 S (Z11,Z12,Z13,Z14,Z15,Z16,Z17,Z18,Z19,Z191,Z192,Z193,Z194)=0
 S (Z21,Z22,Z23,Z24,Z25,Z26,Z27,Z28,Z29,Z291,Z292,Z293,Z294)=0
 S (Z31,Z32,Z33,Z34,Z35,Z36,Z37,Z38,Z39,Z391,Z392,Z393,Z394)=0
 D PARSE^PSNPPSNP
 ;
READ2 ;
 ;- THIS IS WHERE THE CALL TO UPDATE IS ADDED
 D CTRKDL^PSNPPSMS("Disabling menu options")
 D DISMNU^PSNPPSMS  ;disable menu options
 D CTRKDL^PSNPPSMS("Storing PMI data")
 W:'$G(PSNSCJOB) !,"Storing PMI data...",!
 D PMIUPDT^PSNPPSNV
 D CTRKDL^PSNPPSMS("PMI data update complete and storing rest of NDF files.")
 W:'$G(PSNSCJOB) !,"Storing data into the rest of the NDF files...",!
REDO ;
 D ^PSNPPSNU
 D CTRKDL^PSNPPSMS("Processing data transactions")
 D DATA^PSNPPSNV
 I PSNFND S $P(^PS(57.23,1,0),"^",3)=+$P(PSNHLD,"_",3)
COMM ;
 N COMM,INSTIEN,COMMCNT,COMMAGN S (ERRCHK,COMM,INSTIEN,COMMCNT,COMMAGN)=""
 S INSTIEN=$O(^PS(57.23,1,5,"B",PSNHLD2,INSTIEN),-1)
 I INSTIEN'="",$D(^PS(57.23,1,5,INSTIEN,2)) S ERRCHK=1
 ;write comm here to send message - COMPLETED processing
 D CTRKDL^PSNPPSMS("Checking for errors and sending install completion message")
 W:'$G(PSNSCJOB) !,"Sending install completion message to PPS-N...",!
COMMAGN ;
 I PSNSITET="Q"!(PSNSITET="P") S COMM=$$SEND^PSNPPSNC("COMPLETED",$P(PSNHLD,";"),""),COMMAGN=COMMAGN+1
 I PSNSITET="T"!(PSNSITET="S")!(PSNSITET="N") S COMM=1
 I 'COMM&(COMMAGN<3) H 3 W !,"Install completion message could not be sent to PPS-N.  Trying again... " G COMMAGN
 I 'COMM W !,"The install completion message was not accepted by PPS-N.  Please contact ",!,"the National Help Desk.",!
 I $G(ERRCHK) D IERRMSG^PSNPPSMG G COMM2
 I (PSNSITET="Q"!(PSNSITET="P"))&($D(^TMP("PSN PPSN ERR",$J))) D  G COMM2
 .D CTRKDL^PSNPPSMS("Install completed but completion message was not accepted by PPS-N. Call the National Help Desk.")
 .W !,?5,"*****************************************************************"
 .W !?5,"ERROR: ",$P(COMM,"^",2)
 .W !?13,"The update file completed installation but the completion"
 .W !?13,"message was not accepted by PPS-N."
 .W !!?13,"Contact the National Help Desk or enter a ticket."
 .D COMMSG^PSNPPSMG
 .W !,?5,"*****************************************************************"
 D SMSG^PSNPPSMG
 D CTRKDL^PSNPPSMS("Installed successfully")
 K ^XTMP("PSN PPS VERIFY",$J,PSNHLD)
 ;
COMM2 ;
 K FDA
 S FDA(57.23,CTRLIEN_",",30)=0
 D FILE^DIE("","FDA")
 K FDA,%
 D NOW^%DTC
 S FDA(57.231,CTRLXIEN_","_CTRLIEN_",",2)=%
 D UPDATE^DIE("","FDA","CTRLIEN")
 K FDA
 K ^TMP("PSN PPSN PARSED",$J)
 ; Restarting options/protocols which were paused
 D CTRKDL^PSNPPSMS("Enabling options/protocols")
 D RESOP^PSNPPSMS
 Q
 ;
NDF ;Entry point for NDFMS
 N PSNPPSNF S PSNPPSNF=1
 D MFIND^PSNPPSNF
 Q
 ;
SCHED ;tasked job entry point
 N PSNSCJOB
 Q:$$GET1^DIQ(57.23,1,10,"I")="Y"
 S PSNSCJOB=1
 G FIND
 Q
 ;
XTMP ; task monitoring job to report error if update not finished within 1 hour
 N PSNOW,PSNOW1,PSNST
 S PSNOW=$$NOW^XLFDT,PSNOW1=$$FMADD^XLFDT(PSNOW,1)
 S ^XTMP("PSN PPS VERIFY",$J,PSNHLD,0)=PSNOW1_"^"_PSNOW_"^PPS-N Monitoring^"_$J_"^"_PSNHLD_"^"_$G(DUZ)
 S PSNST=$$FMADD^XLFDT(PSNOW,0,0,65)
 W " Background monitoring started: "
 D RESCH^XUTMOPT("PSN PPS INSTALL VERIFY",PSNST,,,"L")
 Q
NDFK(PSNHLD) ; flag to proceed with purging NDFK file
 N FLG,NODE,PSI S FLG=1
 S PSI=$O(^PS(57.23,1,5,"B",PSNHLD,""),-1) I PSI D
 . S NODE=$G(^PS(57.23,1,5,PSI)) I '$P(NODE,"^",3) S FLG=0
 Q FLG
 ;
REJCHK(FILE) ; check if the file has been rejected & finalized
 ;LSTD - Last Download version
 ;
 N NFILE,LSTD,PSI
 S (PSI,LSTD)=0
 S PSI=$O(^PS(57.23,1,4,"G",$P(FILE,";"),""),-1) I 'PSI Q "0^0"
 I PSI S LSTD=$G(^PS(57.23,1,4,"G",$P(FILE,";"),PSI)),NFILE=FILE_";"_LSTD
 I $D(^PS(57.23,1,6,"B",NFILE)) D  Q PSI_"^"_LSTD
 .W !!,"WARNING: File has been rejected and finalized. Install is not allowed for it." D
 .W !,?9,"Installation STOPPED"
 Q "0^0"
 ;
INSTCHK(FILE) ; check if the file has been previously installed
 ;LSTD - Last Download version
 ;
 N NFILE,LSTD,PSI,Y
 S (PSI,Y)=0
 S PSI=$O(^PS(57.23,1,4,"G",$P(FILE,";"),""),-1) I 'PSI Q "0^1"
 I PSI S LSTD=$G(^PS(57.23,1,4,"G",$P(FILE,";"),PSI)),NFILE=FILE_";"_LSTD
 I '$D(^PS(57.23,1,5,"B",NFILE)) Q 1_"^"_LSTD
 W !!,"WARNING: File has already been installed."
 K DIRUT,DUOUT,DIR,X,Y S DIR(0)="Y",DIR("?")="Please enter Y or N.",DIR("A")="Do you want to proceed with the installation"
 S DIR("B")="YES" D ^DIR
 Q Y_"^"_LSTD
