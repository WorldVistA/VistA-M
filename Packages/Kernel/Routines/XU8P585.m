XU8P585 ;ISF/CJM- Patch XU-585 Post init ;09/11/2012
 ;;8.0;KERNEL;**585**;;Build 22
 ;
ENVIR ;Environment check for XU*8.0*585
 I '$$CHECKDIR D
 .S XPDQUIT=2
 .W !,"The directory for the print files does not exist or the permissions were",!,"not correctly established"
 Q
POST ;
 N ERROR,OS
 D PATCH^ZTMGRSET(585)
 S OS=$$OS^%ZOSV()
 I OS'["VMS",OS'["UNIX" Q
 I $G(ERROR)<0 D BMES^XPDUTL("Failed to schedule the 'XU PURGE PRINT QUEUE HFS FILES' option! Please do so manually.")
 N IEN,DATA,OPTION
 S OPTION=$O(^DIC(19,"B","XU PURGE PRINT QUEUE HFS FILES",0))
 I 'OPTION D BMES^XPDUTL("Failed to schedule the XU PURGE PRINT QUEUE HFS FILES option!")
 I OPTION D
 .S IEN=$O(^DIC(19.2,"B",OPTION,0))
 .S DATA(.01)=OPTION
 .S DATA(2)=$$FMADD^XLFDT($$NOW^XLFDT,,1)
 .S DATA(6)="1H"
 .I IEN D
 ..I '$$UPD^HLOASUB1(19.2,IEN,.DATA) D BMES^XPDUTL("Failed to schedule the XU PURGE PRINT QUEUE HFS FILES option!")
 .E  D
 ..I '$$ADD^HLOASUB1(19.2,,.DATA) D BMES^XPDUTL("Failed to schedule the XU PURGE PRINT QUEUE HFS FILES option!")
 Q
 ;
CNVRT ;convert HFS type devices that call NVSPRTU to PQ type devices
 N DEVICE,NOW
 S NOW=$$DT^XLFDT()
 S DEVICE=0
 ;
 ;K ^XTMP("%ZIS HFS TO PQ") ;overlay old list if it exists
 ;
 S ^XTMP("%ZIS HFS TO PQ",0)=$$FMADD^XLFDT(NOW,180)_"^"_NOW
 F  S DEVICE=$O(^%ZIS(1,DEVICE)) Q:'DEVICE  D
 .I $P($G(^%ZIS(1,DEVICE,"TYPE")),"^")="HFS" D
 ..N SUBTYPE
 ..S SUBTYPE=$P($G(^%ZIS(1,DEVICE,"SUBTYPE")),"^")
 ..Q:'SUBTYPE
 ..I $G(^%ZIS(2,SUBTYPE,3))["CLOSE^NVSPRTU" D
 ...N DATA
 ...S DATA(2)="PQ"
 ...S ^XTMP("%ZIS HFS TO PQ",DEVICE)=""
 ...D UPD^ZISFM(3.5,DEVICE,.DATA)
 Q
 ;
UNDO ;undo the changes made by CNVRT conversion routine
 N DEVICE
 S DEVICE=0
 F  S DEVICE=$O(^XTMP("%ZIS HFS TO PQ",DEVICE)) Q:'DEVICE  D
 .N DATA
 .S DATA(2)="HFS"
 .D UPD^ZISFM(3.5,DEVICE,.DATA)
 Q
 ;
 ;
CHECKDIR() ;tests if the print_queues directory has been created properly
 ;
 ;if production and VMS or Linux the test is not needed
 N OS
 Q:'$$PROD^XUPROD() 1
 S OS=$$OS^%ZOSV()
 I OS'["VMS",OS'["UNIX" Q 1
 ;
 N DIR,FILE,IO,POP,HANDLE
 S DIR=$$DIR
 S FILE="TEST_"_$J
 S HANDLE="ZUHANDLE"
 ;
 I $$FEXIST(DIR_FILE) Q 1
 D OPEN^%ZISH(HANDLE,DIR,FILE,"W")
 Q:POP 0
 D CLOSE^%ZISH(HANDLE)
 D FDELETE(DIR_FILE)
 Q 1
 ;
 ;
DIR() ;get directory for printer queues, a subdirectory of host file directory
 N DIR,CODE
 S CODE=$$PRI^%ZOSV
 S DIR=$$CHKNM^%ZISF($P($G(^XTV(8989.3,1,"DEV")),"^",CODE))
 I $$OS^%ZOSV()["VMS" D
 .S DIR=$P(DIR,"]")_".print_queues]"
 E  D
 .S DIR=DIR_"print_queues/"
 Q DIR
 ;
FEXIST(FILE) ;
 ;returns 1 if the file exists, 0 otherwise
 ;
 N OS S OS=$$OS^%ZOSV()
 I OS["UNIX" Q $$LFEXIST(FILE)
 E  I OS["VMS" Q $$VFEXIST(FILE)
 Q 0
 ;
VFEXIST(FILE) ;
 ;checks file's existance - VMS
 N CMD,RET
 S CMD="PIPE F = F$SEARCH("""_FILE_""")"
 S CMD=CMD_" ; IF F$LENGTH(F) .EQ. 0 THEN DEFINE/JOB ZIS$VAL 0 ; IF F$LENGTH(F) .GT. 0 THEN DEFINE/JOB ZIS$VAL 1 "
 I $ZF(-1,CMD)
 S RET=$ZF("TRNLNM","ZIS$VAL","LNM$JOB")
 I $ZF(-1,"DEASSIGN/JOB ZIS$VAL")
 Q +$G(RET)
 ;
LFEXIST(FILE) ;
 ;checks file's existance - Linux,Unix
 N CMD
 S CMD="[ -f "_$$REPLACE(FILE,"$","'$'")_" ]"
 Q '$ZF(-1,CMD)
 ;
FDELETE(FILE) ;
 ;delete file
 N OS S OS=$$OS^%ZOSV()
 I OS["UNIX" D LFDELETE(FILE)
 E  I OS["VMS" D VFDELETE(FILE)
 Q
 ;
VFDELETE(FILE) ;
 ;delete file - VMS
 N CMD
 I FILE'[";" S FILE=FILE_";*"
 S CMD="DELETE "_FILE
 I $ZF(-1,CMD)
 ;
LFDELETE(FILE) ;
 ;delete file - Linux,Unix
 N CMD
 S CMD="rm -f "_$$REPLACE(FILE,"$","'$'")
 I $ZF(-1,CMD)
 ;
REPLACE(STRING,SUB1,SUB2) ;
 ;
 N REPLACE
 S REPLACE(SUB1)=SUB2
 Q $$REPLACE^XLFSTR(STRING,.REPLACE)
 ;
 ;
 ;
 ;
