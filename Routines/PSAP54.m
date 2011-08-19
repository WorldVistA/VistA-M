PSAP54 ;VMP/RJS BUILD XTMP("PSAVSN" FROM A FLAT FILE ; 14MAR06
 ;;3.0;DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**54**;10/24/97
 ;  Reference to %ZISH supported by DBIA # 2320
 ;  Reference to XPDUTL supported by DBIA #10141
 ;  
 W:$D(IOF) @IOF
 W !," Build McKesson VSN to Dispense Units Per Order Unit and Drug Description Data"
 W !!,"This Utility is used to build the ^XTMP(""PSAVSN"" global with then McKesson VSN,",!,"DUOU & Description. Please follow these steps prior to running this utility:",!
 W !,"1) Retrieve the MCKESSON_UPDATE.DAT in ASCII format directly from one of these",!,?5,"FTP servers:"
 W !,?5,"Albany          ftp.fo-albany.med.va.gov",!,?5,"Hines           ftp.fo-hines.med.va.gov",!,?5,"Salt Lake City  ftp.fo-slc.med.va.gov"
 W !," The preferred FTP server retrieve the file from   download.vista.med.va.gov",!," which will transmit the files from the first available FTP server."
 W !!,"2) At the HOST DIRECTORY: prompt enter the name of the directory that you",!,"   placed the file in.  i.e. USER$:[TEMP]"
 W !!,?5,"If you enter an invalid directory this utility will return you to the",!,?5,"HOST DIRECTORY: prompt:     Enter ^ to Quit:",!!
 N DUOUT,X,Y
DIR S DIR(0)="F^3:30",DIR("A")="HOST DIRECTORY" D ^DIR Q:$D(DUOUT)  K DIR
 S PSADIR=X
 S DIR(0)="F^3:30",DIR("A")="HOST FILENAME",DIR("B")="MCKESSON_UPDATE.DAT" D ^DIR Q:$D(DUOUT)  K DIR
 S PSAFILE=X
 S Y=$$FTG^%ZISH(PSADIR,PSAFILE,$NA(^TMP("PSAVSN",1,0)),2)
 I Y'>0 W !,?5,"INVALID DIRECTORY NAME OR FILE DOES NOT EXIST",!,?5,"PLEASE ENTER THE DIRECTORY AGAIN" G DIR
 S PSADATA=$G(^TMP("PSAVSN",1,0))
 G:$L(PSADATA)>100 ERRMSG
 S PSAFLDT=$P(PSADATA,"^",5),PSADESC=$P(PSADATA,"^",4)
 I $G(^XTMP("PSAVSN",0)),$P(^XTMP("PSAVSN",0),"^",4)=PSAFLDT W !,"The McKesson Update for ",PSAFLDT," has already been installed",!,"Please try downloading the file again."  K ^TMP("PSAVSN") G END
 W !!,"PROCESSING PLEASE WAIT "
EN S PSADT=$$FMADD^XLFDT(DT,360)
 S ^XTMP("PSAVSN",0)=PSADT_"^"_DT_"^"_PSADESC_"^"_PSAFLDT
 S PSAREC=1,PSACNTR=0
 F  S PSAREC=$O(^TMP("PSAVSN",PSAREC)) Q:PSAREC=""  D
 .S PSACNTR=PSACNTR+1
 .I '$D(XPDQUES),PSACNTR=1000 S PSACNTR=0 W "."
 .S PSADATA=$G(^TMP("PSAVSN",PSAREC,0))
 .Q:PSADATA=""
 .S PSAVSN=$P(PSADATA,"^",1),PSADUOU=$P(PSADATA,"^",2),PSADESC=$P(PSADATA,"^",3)
 .S ^XTMP("PSAVSN",PSAVSN)=PSADUOU_"~"_PSADESC
 I '$D(XPDQUES) W !!,"PROCESSING COMPLETE.    The ^XTMP(""PSAVSN"" global has been updated"
END K ^TMP("PSAVSN"),PSAREC,PSADATA,PSAVSN,PSADUOU,PSADESC,PSACNTR,PSADT,PSADIR,PSAFILE,PSAFLDT
 Q
 ;
ERRMSG ; ERROR MESSAGE IF FILE WAS DOWNLOAD IN BINARY FORMAT
 K ^TMP("PSAVSN"),PSAREC,PSADATA,PSAVSN,PSADUOU,PSADESC,PSACNTR,PSADT,PSADIR,PSAFILE,PSAFLDT
 W !!,?10,"There was a problem with the input file."
 W !,?9,"It may have been downloaded in BINARY mode."
 W !,?6,"Please try downloading it again using ASCII mode.",!!
 Q
 ;
POSINIT ; PATCH POST INSTALL 
 S PSADIR=XPDQUES("POSPSADIR"),PSAFILE=XPDQUES("POSPSAFILE")
 S Y=$$FTG^%ZISH(PSADIR,PSAFILE,$NA(^TMP("PSAVSN",1,0)),2)
 I Y'>0 G POSERR1
 S PSADATA=$G(^TMP("PSAVSN",1,0))
 G:$L(PSADATA)>100 POSERR3
 S PSAFLDT=$P(PSADATA,"^",5),PSADESC=$P(PSADATA,"^",4)
 I $G(^XTMP("PSAVSN",0)),$P(^XTMP("PSAVSN",0),"^",4)=PSAFLDT G POSERR2
 G:$L($G(^TMP("PSAVSN",1,0)))>100 POSERR3
 D MES^XPDUTL("PROCESSING PLEASE WAIT")
 D EN
 D MES^XPDUTL("PROCESSING COMPLETE.    The ^XTMP(""PSAVSN"" global has been updated")
 Q
 ;
POSERR1 ; ERROR MESSAGE IF FILE COULD NOT BE OPENED
 S MSG="DIRECTORY = "_PSADIR_" FILENAME = "_PSAFILE
 D BMES^XPDUTL(MSG)
 D MES^XPDUTL("INVALID DIRECTORY NAME/FILENAME OR FILE DOES NOT EXIST")
 D MES^XPDUTL("Please verify that the DIRECTORY is correct and that the")
 D MES^XPDUTL("MCKESSON_UPDATE.DAT file is present")
 D BMES^XPDUTL("Once you have verified that the DIRECTORY name is correct and/or")
 D MES^XPDUTL("the file is present, Please run ^PSAP54 from the programmers prompt.")
 K PSADIR,PSAFILE
 Q
 ;
POSERR2 ; ERROR MESSAGE IF FILE WAS FUOUND BUT HAS ALREADY BEEN INSTALLED
 S MSG="The McKesson Update for "_PSAFLDT_" has already been installed"
 D BMES^XPDUTL(MSG)
 D MES^XPDUTL("Please try downloading the file again.")
 D MES^XPDUTL("Then run ^PSAP54 from the programmers prompt.")
 K ^TMP("PSAVSN"),MSG,PSADIR,PSAFILE
 Q
 ;
POSERR3 ; ERROR MESSAGE IF THE FLAT FILE WAS DOWNLOADED IN BINARY FORMAT
 D BMES^XPDUTL("There was a problem with the MCKESSON_UPDATE.DAT file")
 D MES^XPDUTL("Please download it again using ASCII format and")
 D MES^XPDUTL("run ^PSAP54 from the programmers prompt")
 K ^TMP("PSAVSN"),PSADIR,PSAFILE
 Q
