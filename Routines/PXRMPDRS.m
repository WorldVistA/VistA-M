PXRMPDRS ;SLC/PKR - Patient List Demographic Report data selection. ;10/02/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12,17**;Feb 04, 2005;Build 102
 ;
ADDSEL(DATA,SUB) ;Let the user select the address information they want.
 N ADDLIST,LIST
 S ADDLIST("A",1)=" 1 - CURRENT ADDRESS",DATA(SUB,1,1)="STREET ADDRESS #1"_U_1
 S DATA(SUB,1,2)="STREET ADDRESS #2"_U_1,DATA(SUB,1,3)="STREET ADDRESS #3"_U_1
 S DATA(SUB,1,4)="CITY"_U_1,DATA(SUB,1,5)="STATE"_U_2,DATA(SUB,1,6)="ZIP"_U_1
 S DATA(SUB,1,7)="COUNTY"_U_2
 S DATA(SUB,1,23)="ADD TYPE"_U_1
 S ADDLIST("A",2)=" 2 - PHONE NUMBER",DATA(SUB,2,8)="PHONE NUMBER"_U_1
 S ADDLIST("A")="Enter your selection(s)"
 S ADDLIST("?")="^D HELP^PXRMPDRS"
 W !!,"Select from the following address items:"
 S LIST=$$SEL^PXRMPDRS(.ADDLIST,2)
 I $D(DTOUT)!$D(DUOUT) Q
 S DATA(SUB)=LIST
 S DATA(SUB,"LEN")=$L(LIST,",")-1
 I DATA(SUB)["1," D GCATYPE(.DATA,SUB)
 Q
 ;
APPERR ;
 N ECODE
 I $D(ZTQUEUED) D  Q
 . N MGIEN,MGROUP,NL,TIME,TO
 . S TIME=$$NOW^XLFDT
 . S TIME=$$FMTE^XLFDT(TIME)
 . K ^TMP("PXRMXMZ",$J)
 . S ^TMP("PXRMXMZ",$J,1,0)="The Patient Demographic Report requested by "_$$GET1^DIQ(200,DBDUZ,.01)_" on "
 . S ^TMP("PXRMXMZ",$J,2,0)=TIME_" was supposed to include appointment data."
 . S ^TMP("PXRMXMZ",$J,3,0)="Appointment data could not be obtained from the Scheduling database due to the"
 . S ^TMP("PXRMXMZ",$J,4,0)="following error(s):"
 . S ECODE=0,NL=4
 . F  S ECODE=$O(^TMP($J,"SDAMA301",ECODE)) Q:ECODE=""  D
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "_^TMP($J,"SDAMA301",ECODE)
 . S TO(DBDUZ)=""
 . S MGIEN=$G(^PXRM(800,1,"MGFE"))
 . I MGIEN'="" D
 .. S MGROUP="G."_$$GET1^DIQ(3.8,MGIEN,.01)
 .. S TO(MGROUP)=""
 . D SEND^PXRMMSG("PXRMXMZ","Scheduling database error(s)",.TO)
 . S ZTSTOP=1
 ;
 I '$D(ZTQUEUED) D  Q
 . W @IOF
 . W !,"Appointment data could not be obtained from the Scheduling database due to the"
 . W !,"following error(s):"
 . S ECODE=0
 . F  S ECODE=$O(^TMP($J,"SDAMA301",ECODE)) Q:ECODE=""  D
 .. W !," ",^TMP($J,"SDAMA301",ECODE)
 Q
 ;
APPSEL(DATA,SUB) ;Let the user select the appointment information they want.
 ;The first subscript of APPDATA is the selection number and the
 ;the second subscript is the subscript where the data is returned
 ;in VAPA. The first piece of APPDATA is the name of the data and the
 ;second piece is the piece of VAPA this is displayed.
 N APPLIST,LIST,MAX
 S APPLIST("A",1)=" 1 - APPOINTMENT DATE",DATA(SUB,1,1)="APPOINTMENT DATE"_U_1
 S APPLIST("A",2)=" 2 - CLINIC",DATA(SUB,2,2)="CLINIC"_U_2
 S APPLIST("A")="Enter your selection(s)"
 S APPLIST("?")="^D HELP^PXRMPDRS"
 W !!,"Select from the following future appointment items:"
 S LIST=$$SEL^PXRMPDRS(.APPLIST,2)
 I $D(DTOUT)!$D(DUOUT) Q
 S DATA(SUB)=LIST
 S DATA(SUB,"LEN")=$L(LIST,",")-1
 I DATA(SUB,"LEN")=0 Q
 S DATA(SUB,"MAX")=$$ASKNUM^PXRMEUT("Maximum number of appointments to display",1,25)
 Q
 ;
DATASEL(LISTIEN,DATA,SUB) ; Build a list of data that is availble for
 ;this patient list and let the user select what they want.
 N IND,DATALIST,DTYPE
 S DTYPE="",IND=0
 F  S DTYPE=$O(^PXRMXP(810.5,LISTIEN,35,"B",DTYPE)) Q:DTYPE=""  D
 . S IND=IND+1,DATALIST("A",IND)=" "_IND_" - "_DTYPE
 . S DATA(SUB,IND,IND)=DTYPE
 ;If there is no data quit.
 I IND=0 S DATA(SUB,"LEN")=0 Q
 S DATALIST("A")="Enter your selections(s)"
 S DATALIST("?")="^D HELP^PXRMPDRS"
 W !!,"Select from the following patient data:"
 S LIST=$$SEL^PXRMPDRS(.DATALIST,IND)
 I $D(DTOUT)!$D(DUOUT) Q
 S DATA(SUB)=LIST
 S DATA(SUB,"LEN")=$L(LIST,",")-1
 Q
 ;
DEMSEL(DATA,SUB) ;Let the user select the demographic information they want.
 ;The first subscript of DATA is the selection number and the
 ;the second subscript is the subscript where the data is returned
 ;in VADM. The first piece of DEMDATA is the name of the data and the
 ;second piece is the piece of VADM this is displayed.
 N DEMLIST,DTOUT,DUOUT,IND,ITEM,JND,KND,LIST,TEMP
 S DEMLIST("A",1)=" 1 - SSN",DATA(SUB,1,2)="SSN"_U_2
 S DEMLIST("A",2)=" 2 - DATE OF BIRTH",DATA(SUB,2,3)="DOB"_U_2
 S DEMLIST("A",3)=" 3 - AGE",DATA(SUB,3,4)="AGE"_U_1
 S DEMLIST("A",4)=" 4 - SEX",DATA(SUB,4,5)="SEX"_U_2
 S DEMLIST("A",5)=" 5 - DATE OF DEATH",DATA(SUB,5,6)="DOD"_U_2
 S DEMLIST("A",6)=" 6 - REMARKS",DATA(SUB,6,7)="REMARKS"_U_1
 S DEMLIST("A",7)=" 7 - HISTORIC RACE",DATA(SUB,7,8)="HISTORIC RACE"_U_2
 S DEMLIST("A",8)=" 8 - RELIGION",DATA(SUB,8,9)="RELIGION"_U_2
 S DEMLIST("A",9)=" 9 - MARITAL STATUS",DATA(SUB,9,10)="MARTIAL STATUS"_U_2
 S DEMLIST("A",10)="10 - ETHNICITY",DATA(SUB,10,11)="ETHNICITY"_U_2
 S DEMLIST("A",11)="11 - RACE",DATA(SUB,11,12)="RACE"_U_2
 S DEMLIST("A")="Enter your selection(s)"
 S DEMLIST("?")="^D HELP^PXRMPDRS"
DSEL W !!,"Select from the following demographic items:"
 S LIST=$$SEL^PXRMPDRS(.DEMLIST,11)
 I $D(DTOUT)!$D(DUOUT) Q
 S DATA(SUB)=LIST
 S DATA(SUB,"LEN")=$L(LIST,",")-1
 F IND=1:1:DATA(SUB,"LEN") D
 . S JND=$P(LIST,",",IND)
 . S KND=$O(DATA(SUB,JND,""))
 . S TEMP=$P(DATA(SUB,JND,KND),U,1)
 . I TEMP="SSN" D
 .. N FULLSSN
 .. D SSN^PXRMXSD(.FULLSSN)
 .. S DATA(SUB,"FULLSSN")=$S($G(FULLSSN)="Y":1,1:0)
 . I $D(DTOUT)!$D(DUOUT) S IND=DATA(SUB,"LEN")+1 Q
 . I TEMP="ETHNICITY" S $P(DATA(SUB,10,11),U,3)=$$ASKNUM^PXRMEUT("Maximum number of ethnicity entries to display",1,10)
 . I TEMP="RACE" S $P(DATA(SUB,11,12),U,3)=$$ASKNUM^PXRMEUT("Maximum number of race entries to display",1,10)
 I $D(DTOUT)!$D(DUOUT) K DTOUT,DUOUT G DSEL
 Q
 ;
ELIGSEL(DATA,SUB) ;Let the user select the eligibility data they want.
 ;The first subscript of ELIGDATA is the selection number and the
 ;the second subscript is the subscript where the data is returned
 ;in VAEL. The first piece of ELIGDATA is the name of the data and the
 ;second piece is the piece of VAEL this is displayed.
 N ELIGLIST,ITEM,LIST
 S ELIGLIST("A",1)=" 1 - PRIMARY ELGIBILITY CODE",DATA(SUB,1,1)="PRIMARY ELGIBILITY CODE"_U_2
 S ELIGLIST("A",2)=" 2 - PERIOD OF SERVICE",DATA(SUB,2,2)="PERIOD OF SERVICE"_U_2
 S ELIGLIST("A",3)=" 3 - % SERVICE CONNECTED",DATA(SUB,3,3)="% SERVICE CONNECTED"_U_2
 S ELIGLIST("A",4)=" 4 - VETERAN",DATA(SUB,4,4)="VETERAN"_U_1
 S ELIGLIST("A",5)=" 5 - TYPE",DATA(SUB,5,6)="TYPE"_U_2
 S ELIGLIST("A",6)=" 6 - ELIGIBILITY STATUS",DATA(SUB,6,8)="ELIGIBILITY STATUS"_U_2
 S ELIGLIST("A",7)=" 7 - CURRENT MEANS TEST",DATA(SUB,7,9)="CURRENT MEANS TEST"_U_2
 S ELIGLIST("A")="Enter your selection(s)"
 S ELIGLIST("?")="^D HELP^PXRMPDRS"
 W !!,"Select from the following eligibility items:"
 S LIST=$$SEL^PXRMPDRS(.ELIGLIST,7)
 I $D(DTOUT)!$D(DUOUT) Q
 S DATA(SUB)=LIST
 S DATA(SUB,"LEN")=$L(LIST,",")-1
 Q
 ;
GCATYPE(DATA,SUB) ;Get the type of confidential addresses to use.
 N CATLIST,IND,JND,LIST,MSG
 D HELP^DIE(2.141,"",.01,"S","MSG")
 W !!,"If the patient has an active confidential address, which of the following"
 W !,"confidential address categories are appropriate to use?",!
 S CATLIST("A")="If no selection is made the default is 2 and 4, enter your selection(s)"
 S JND=0
 F IND=2:1:MSG("DIHELP") D
 . S JND=JND+1
 . S CATLIST("A",JND)="  "_MSG("DIHELP",IND)
 S LIST=$$SEL^PXRMPDRS(.CATLIST,JND)
 I LIST="" S LIST="2,4,"
 S DATA(SUB,22,"LEN")=$L(LIST,",")-1
 S DATA(SUB,22,"LIST")=LIST
 Q
 ;
HELP ; -- help code.
 W !!,"You can choose any combination of numbers i.e., 1-4 or 1,3-5"
 W !!,"See the Clinical Reminders Managers manual for detailed explanations of each"
 W !,"of the selection items."
 Q
 ;
INPSEL(DATA,SUB) ;Let the user select the inpatient information they want.
 ;The first subscript of INPDATA is the selection number and the
 ;the second subscript is the subscript where the data is returned
 ;in VAIN. The first piece of INPDATA is the name of the data and the
 ;second piece is the piece of VAIN this is displayed.
 N INPLIST,ITEM,LIST
 S INPLIST("A",1)=" 1 - WARD LOCATION",DATA(SUB,1,4)="WARD"_U_2
 S INPLIST("A",2)=" 2 - ROOM-BED",DATA(SUB,2,5)="ROOM-BED"_U_1
 S INPLIST("A",3)=" 3 - ADMISSION DATE/TIME",DATA(SUB,3,7)="ADMISSION DATE/TIME"_U_2
 S INPLIST("A",4)=" 4 - ATTENDING PHYSICIAN",DATA(SUB,4,11)="ATTENDING"_U_2
 S INPLIST("A")="Enter your selection(s)"
 S INPLIST("?")="^D HELP^PXRMPDRS"
 W !!,"Select from the following inpatient items:"
 S LIST=$$SEL^PXRMPDRS(.INPLIST,4)
 I $D(DTOUT)!$D(DUOUT) Q
 S DATA(SUB)=LIST
 S DATA(SUB,"LEN")=$L(LIST,",")-1
 Q
 ;
REMSEL(PLIEN,DATA,SUB) ;If the list was generated from a reminder report
 ;let the user select the reminder data they want.
 I '$P(^PXRMXP(810.5,PLIEN,0),U,9) S DATA(SUB,"LEN")=0 Q
 N IEN,IND,REMLIST,RNAME
 S (IEN,IND)=0
 F  S IEN=$O(^PXRMXP(810.5,PLIEN,45,"B",IEN)) Q:IEN=""  D
 . S RNAME=$P(^PXD(811.9,IEN,0),U,3)
 . I RNAME="" S RNAME=$P(^PXD(811.9,IEN,0),U,1)
 . S IND=IND+1
 . S DATA(SUB,"RNAME",IND)=RNAME
 . S DATA(SUB,"IEN",IND)=IEN
 . S REMLIST("A",IND)=" "_IND_" - "_RNAME
 S REMLIST("A")="Enter your selection(s)"
 S REMLIST("?")="^D HELP^PXRMPDRS"
 W !!,"Include due status information for the following reminder(s):"
 S LIST=$$SEL^PXRMPDRS(.REMLIST,IND)
 I $D(DTOUT)!$D(DUOUT) Q
 S DATA(SUB)=LIST
 S DATA(SUB,"LEN")=$L(LIST,",")-1
 Q
 ;
SEL(SELLIST,LEN) ;Select global list
 N DIR,X,Y
 M DIR=SELLIST
 S DIR(0)="LO^1:"_LEN
 D ^DIR
 Q Y
 ;
