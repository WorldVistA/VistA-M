QACI2A ; OAKOIFO/TKW - DATA MIGRATION - BUILD LEGACY DATA TO BE MIGRATED (CONT.) ;10/26/06  16:42
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
PARVISN(PARENT,VISNNAME) ; Get Parent Station Number and VISN Name for a Station
 N I,QACPAR
 ; Get parent institution IEN from QAC SITE PARAMETERS file entry
 S PARENT=$P($G(^QA(740,1,0)),"^"),VISNNAME=""
 Q:'PARENT
 ; Retrieve VISN name
 D PARENT^XUAF4("QACPAR","`"_PARENT,1)
 S I=$O(QACPAR("P",0)) I 'I S PARENT="" Q
 S VISNNAME=$P(QACPAR("P",I),"^")
 ; Get station number for parent station
 S PARENT=$$STA^XUAF4(PARENT) S:PARENT="" VISNNAME=""
 Q
 ;
ASK(FLAG) ; Question Confirming that User want to run this option
 W !!,"This option builds temporary globals used to migrate all legacy data",!,"from the old Patient Representative system to the new Patient Advocate",!,"Tracking System (PATS).",!
 ;I $G(FLAG)="X" D
 ;. W !,"** This is the option to completely restart the migration process . **"
 ;. W !,"If data was migrated in error, the PATS Production Database Manager",!,"should delete the data from PATS prior to running this option.",!
 ;. Q
 N DIR S DIR(0)="YO",DIR("A")="Are you sure",DIR("B")="YES"
 S DIR("?",1)="This option reads through all of the ROCs. ROCs that have already been migrated"
 S DIR("?",2)="to PATS will not be moved to the staging area again. ROCs are checked for"
 S DIR("?",3)="data errors. Any ROCs with errors will not be moved to the staging area, and"
 S DIR("?",4)="will be displayed on an error report at the end of the process."
 S DIR("?",5)=""
 S DIR("?",6)="Once ROCs have been moved to the staging area, they are ready to be migrated"
 S DIR("?")="into PATS."
 D ^DIR
 Q Y
 ;
CEMOCTS ; Build mapping lists for contacting_entity, method_of_contact, treatment_status.
 S MOC("P")=1,MOC("W")=2,MOC("V")=2,MOC("I")=3,MOC("L")=4,MOC("S")=5
 Q:QACI0
 S CE("PA")=1,CE("RE")=2,CE("FR")=3,CE("CO")=4,CE("VH")=5,CE("VO")=6,CE("AT")=7,CE("DI")=8,CE("ST")=9,CE("OT")=10
 S TS("I")=6,TS("O")=7,TS("D")=8,TS("N")=9,TS("L")=10,TS("E")=11,TS("H")=12
 Q
 ;
BLDISS ; Build a list of migrated National Issue Codes.
 K ^XTMP("QACMIGR","ISS","D")
 ; Count of national issue codes to migrate=59
 S ^XTMP("QACMIGR","ISS","D")=59
 N I
 F I=1:1 S X=$P($T(LIST+I),";",3) Q:X=""  S ^XTMP("QACMIGR","ISS","D",X)=""
 Q
 ;
BLDCC(STATION,PATSCNT) ; Build list of all Congressional Contacts to migrate
 N CCIEN,CCCNT,CC0,X,CCDNM
 S CCCNT=0
 F CCIEN=0:0 S CCIEN=$O(^QA(745.4,CCIEN)) Q:'CCIEN  S CC0=$G(^(CCIEN,0)) D
 . S CCNAME=$P(CC0,"^")
 . Q:$D(^XTMP("QACMIGR","CC","D",CCIEN))
 . S CCDNM=$E(CCNAME,1,20) S:$L(CCNAME)>20 CCDNM=CCDNM_"..."
 . I $$TXTERR^QACI2C(CCNAME,60,0,1) D  Q
 .. D ERREF^QACI2C("CC",CCIEN,CCDNM_" - Office or Person Name invalid") Q
 . S X=$P(CC0,"^",2) I X]"",X'=1,X'=0 D  Q
 .. D ERREF^QACI2C("CC",CCIEN,CCDNM_" - 'Inactive' flag is invalid") Q
 . S ^XTMP("QACMIGR","CC","U",CCIEN)=CCIEN_"^"_STATION_"^"_CCNAME_"^"_X
 . S CCCNT=CCCNT+1 Q
 S PATSCNT("CC")=CCCNT
 Q
 ;
BLDFSOS(FSOSIEN,FSOSNAME,QACI0,PATSCNT) ; Check for errors, build data for a single Facility Service or Section
 Q:$D(^XTMP("QACMIGR","FSOS","E",FSOSIEN))
 Q:$D(^XTMP("QACMIGR","FSOS","U",FSOSIEN))
 I $$TXTERR^QACI2C(FSOSNAME,50,0,1) D  Q
 . N Y S Y=$L(FSOSNAME)
 . S FSOSNAME=$E(FSOSNAME,1,30) I Y>30 S FSOSNAME=FSOSNAME_"..."
 . D ERREF^QACI2C("FSOS",FSOSIEN,FSOSNAME_" - Name invalid") Q
 ; Quit if called from ^QACI0 to just print the error report
 Q:QACI0
 ; Quite if fsos has already migrated
 Q:$D(^XTMP("QACMIGR","FSOS","D",FSOSIEN))
 S ^XTMP("QACMIGR","FSOS","U",FSOSIEN)=FSOSIEN_"^"_FSOSNAME
 S PATSCNT("FSOS")=PATSCNT("FSOS")+1
 Q
 ;
ERROC(OLDROC,MSG) ; Record an error on a ROC
 Q:MSG=""
 N ERRCNT S ERRCNT=$O(^XTMP("QACMIGR","ROC","E",OLDROC_" ","A"),-1)+1
 S ^XTMP("QACMIGR","ROC","E",OLDROC_" ",ERRCNT)=MSG
 I ERRCNT=1 D
 . N I S I=$O(^QA(745.1,"B",OLDROC,0)) Q:'I
 . S X=$P($G(^QA(745.1,I,0)),"^",6) Q:'X
 . S X=$P($G(^VA(200,X,0)),"^") Q:X=""
 . S $P(^XTMP("QACMIGR","ROC","E",OLDROC_" ",ERRCNT),"^",2)=X Q
 Q
 ;
LIST ;; List of valid national issue codes
 ;;AC01
 ;;AC02
 ;;AC03
 ;;AC04
 ;;AC05
 ;;AC06
 ;;AC07
 ;;AC08
 ;;AC09
 ;;AC10
 ;;AC11
 ;;AC12
 ;;CO01
 ;;CO02
 ;;CO03
 ;;CO04
 ;;CP01
 ;;ED01
 ;;ED02
 ;;EM01
 ;;EM02
 ;;EM03
 ;;EV01
 ;;EV02
 ;;EV03
 ;;FI01
 ;;IF01
 ;;IF02
 ;;IF04
 ;;IF05
 ;;IF06
 ;;IF07
 ;;IF08
 ;;IF09
 ;;IF10
 ;;LL01
 ;;LL02
 ;;LL03
 ;;LL04
 ;;OP01
 ;;OP02
 ;;PC01
 ;;PC02
 ;;PR01
 ;;PR02
 ;;PR03
 ;;PR04
 ;;RE01
 ;;RG01
 ;;RG02
 ;;RG03
 ;;RI01
 ;;RI02
 ;;RI03
 ;;RI04
 ;;RI05
 ;;SC01
 ;;SC02
 ;;TR01
 ;;
