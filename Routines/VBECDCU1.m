VBECDCU1 ;hoifo/gjc-data conversion & pre-implementation utilities;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to ^%ZTER is supported by IA: 1621
 ;Call to $$GET1^DIQ is supported by IA: 2056
 ;Call to SETUP^XQALERT is supported by IA: 10081
 ;
ATTR() ; select the data family to display
 ; Output: the file that the VistA data resides in as well as the full
 ;         name of the data family -  EX: 61.3^Antigen/Antibody
 ;
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y N VBECFILE,VBECATT
 ;S DIR(0)="S^AA:Antigen/Antibody;BP:Blood Product;BS:Blood Supplier;TR:Transfusion Reaction",DIR("A")="Select the unmapped data attribute to display"
 S DIR(0)="S^AA:Antigen/Antibody;TR:Transfusion Reaction",DIR("A")="Select the unmapped data attribute to display"
 S DIR("?",1)="Enter 'AA' for Antibodies and Antigens (Vista File: Function Field #61.3)"
 ;S DIR("?",2)="Enter 'BP' for Blood Product (Vista File: Blood Product #66)"
 ;S DIR("?",3)="Enter 'BS' for Blood Supplier"
 S DIR("?",2)="Enter 'TR' for Transfusion Reaction (VistA File: Blood Bank Utility"
 S DIR("?")="#65.4)" D ^DIR
 I $D(DIRUT) K DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y S (VBECFILE,VBECATT)=""
 E  S VBECFILE=$S(Y="AA":61.3,1:65.4),VBECATT=Y(0)
 ;E  S VBECFILE=$S(Y="AA":61.3,Y="TR":65.4,Y="BP":66,1:66.01),VBECATT=Y(0)
 Q VBECFILE_"^"_VBECATT
 ;
BRKPNT(LRDFN,DFN) ; check for broken pointers between files 2 & 63.
 ; Check the pointer from the Patient (#2) to the Lab Data (#63)
 ; file against the Parent File (#.02), piece two of LRDATA, and
 ; Name (#.03), piece three of LRDATA, fields on the Lab Data file.
 ; Parent File field value must equal 2 (Pat. file) & Name field
 ; value must equal the DFN of the patient for the pointer to be
 ; correct.
 ;
 ; Input LRDFN: pointer, ien of the Lab Data record in the Patient file
 ;         DFN: DFN of the patient in the Patient file
 ;     Returns: 1 if the link between the files is broken, else 0
 ;
 N LRDATA S LRDATA=$G(^LR(LRDFN,0))
 Q $S($P(LRDATA,U,2)'=2:1,$P(LRDATA,U,3)'=DFN:1,1:0)
 ;
SAVE ; Save off the legacy Blood Bank data into globals, ^TMP(name_space,$J)
 ; and then move data from globals to either VMS files or text files on
 ; a Microsoft machine.
 ;
 ;           global subscript to file name conversion
 ;           ---------------------------------------- 
 ;"VBEC63 PAT"   ->  "VBEC63_PAT"
 ;"VBEC63 ANTIP" ->  "VBEC63_ANTIP"
 ;"VBEC63 ANTIA" ->  "VBEC63_ANTIA"
 ;"VBEC63 AI"    ->  "VBEC63_AI"
 ;"VBEC63 BBC"   ->  "VBEC63_BBC"
 ;"VBEC63 TD"    ->  "VBEC63_TD"
 ;"VBEC63 TRD"   ->  "VBEC63_TRD"
 ;"VBEC63 TC"    ->  "VBEC63_TC"
 ;"VBEC63 TRC"   ->  "VBEC63_TRC"
 ;"VBEC FINIS"   ->  "VBEC_FINIS"
 ;
 N LRDATA,LRNAME,LRNODE,LRC,LRX
 S LRDATA=0 ; if data, flip LRDATA to 1
 S LRDATA=$$DATA($J)
 I 'LRDATA DO ALERT^VBECDCU(DUZ,VBECCNV,0,-1) QUIT
 F VBECI=1:1:7 S VBECI1=$P($T(SUBS+VBECI),";;",2) I '$D(^TMP(VBECI1,$J)) S ^TMP(VBECI1,$J)="" ;RLM 10/28/05
 ;
 ; Set DBCONV.INI file.  This will tell the system where to find the
 ; database on the VBECS system
 S ^TMP("DBCONV.INI",$J,1,0)="[database]"
 S ^TMP("DBCONV.INI",$J,2,0)="database name="_VBECDBN
 S ^TMP("DBCONV.INI",$J,3,0)="[server]"
 S ^TMP("DBCONV.INI",$J,4,0)="server name="_VBECDBN1
 S LRNODE="^TMP(""DBCONV.INI"","_$J_",1,0)"
 S LRFLG=$$GTF^VBECDCU($NA(@LRNODE),3,"DBCONV.INI")
 ;
 ; Set finish global.  This global is used to flag the SQL Server box
 ; that data exists, and that the data can be set into SQL tables.
 ;
 S LRX="VBEC FINI"
 F  S LRX=$O(^TMP(LRX)) Q:LRX=""!(LRX]"VBEC63 zzz")  D
 .S LRNODE="^TMP("""_LRX_""","_$J_",1,0)"
 .S LRNAME=$TR(LRX," ","_")_".TXT"
 .S LRFLG=$$GTF^VBECDCU($NA(@LRNODE),3,LRNAME)
 .Q
 Q
 ;
DATA(Y) ; determine if we've captured data and create empty files if no data found
 ;  Input: Y=$J or process id
 K LRXX N LRZ S LRXX="VBEC FINI",LRZ=0
 F  S LRXX=$O(^TMP(LRXX)) Q:LRXX=""!(LRXX]"VBEC63 zzz")  D
  . I $E(LRXX,1,4)="VBEC",('$D(^TMP(LRXX,Y))\10) S ^TMP(LRXX,Y,1,0)=""
  . Q
 K LRXX Q 1
 ;
ERR ;come here on error, record error in error trap and alert all VBEC mail
 ;group members
 N XQA,XQAMSG
 ;record error & write message
 S XQA(DUZ)="",XQAMSG="Option "_$TR($E($G(XQY0),1,30),"^","")_" has encountered an Error."
 ; IA: 10111 read ^XMB(3.8,DO,0) with FileMan (supported)
 S VBECMG=$$GET1^DIQ(3.8,+$P($G(^VBEC(6000,1,0)),U,7)_",",.01)
 S:VBECMG'="" XQA("G."_VBECMG)=""
 D ^%ZTER,SETUP^XQALERT K VBECMG
 S LRSTOP=-1 ;data conversion/integrity checker must stop processing
 Q
 ;
SUBS ;
 ;;VBEC63 PAT
 ;;VBEC63 ANTIP
 ;;VBEC63 ANTIA
 ;;VBEC63 AI
 ;;VBEC63 BBC
 ;;VBEC63 TRD
 ;;VBEC63 TRC
 ;;VBEC FINIS
FILES ; here are the file names for used for the legacy Blood Bank data
 ;;VBEC63_PAT
 ;;VBEC63_ANTIP
 ;;VBEC63_ANTIA
 ;;VBEC63_AI
 ;;VBEC63_BBC
 ;;VBEC63_TRD
 ;;VBEC63_TRC
 ;;VBEC_FINIS
 ;;
