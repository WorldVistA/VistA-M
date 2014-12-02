HDISVAP3 ;BPFO/JRP - Application Programmer API(s);03/07/12  07:56
 ;;1.0;HEALTH DATA & INFORMATICS;**7**;Feb 22, 2005;Build 33
 ;
 ; THIS IS A CONTINUATION OF LABXCPT^HDISVAP1
 ;
ADD(TEXT,TAGNAME,XMLDOC,XMLNODE) ;Add text to XML document
 NEW ESCTEXT
 IF (TAGNAME="") QUIT
 ;Check for NULL data - special denotion in XML
 IF (TEXT="") DO  QUIT
 .SET @XMLDOC@(XMLNODE,0)="<"_TAGNAME_"/>"
 .SET XMLNODE=XMLNODE+1
 .QUIT
 ;Convert reserved XML characters to escape sequences
 SET ESCTEXT=$$CHARCHK^XOBVLIB(TEXT)
 ;Add text
 SET @XMLDOC@(XMLNODE,0)="<"_TAGNAME_">"_ESCTEXT_"</"_TAGNAME_">"
 SET XMLNODE=XMLNODE+1
 QUIT
 ;
ADDBEG(TAGNAME,XMLDOC,XMLNODE) ; Add beginning tag to XML document
 SET @XMLDOC@(XMLNODE,0)="<"_TAGNAME_">"
 SET XMLNODE=XMLNODE+1
 QUIT
 ;
ADDEND(TAGNAME,XMLDOC,XMLNODE) ;Add ending tag to XML document
 SET @XMLDOC@(XMLNODE,0)="</"_TAGNAME_">"
 SET XMLNODE=XMLNODE+1
 QUIT
 ;
SUMADD(TEXT,SUMTXT,SUMNODE) ;Add line of text to summary data
 SET @SUMTXT@(SUMNODE,0)=TEXT
 SET SUMNODE=SUMNODE+1
 QUIT
 ;
SUMADMIN(SUMTXT,XCPTTYPE,DATA,SUMNODE) ;Administrative summary text
 NEW TEXT
 SET TEXT=" "
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT=" Transaction Number: "_$GET(DATA(1))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT="Exception Type Code: "_$GET(XCPTTYPE)
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT="         Time Stamp: "_$GET(DATA(2))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT=" "
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 QUIT
 ;
SUMSNOMD(SUMTXT,DATA,SUMNODE) ;SNOMED summary text
 NEW TEXT
 SET TEXT="ID (Fac#-File#-IEN): "_$GET(DATA(1))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT="          SNOMED CT: "_$GET(DATA(5))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT="     SNOMED CT Term: "_$GET(DATA(6))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT="  Mapping Exception: "_$GET(DATA(7))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT="        Term Status: "_$GET(DATA(11))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT=" "
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 QUIT
 ;
SUMRFLAB(SUMTXT,DATA,SUMNODE) ;Reference lab summary text
 NEW TEXT
 SET TEXT=" Location Type Code: "_$GET(DATA(1))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT="    Location Number: "_$GET(DATA(2))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT="      Location Name: "_$GET(DATA(3))
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 SET TEXT=" "
 DO SUMADD(TEXT,SUMTXT,.SUMNODE)
 QUIT
 ;
SUMID(SUMTXT,SANODE) ;Add ID to list of IDs added to XML document
 NEW TEXT,ARRTYPE,ID
 SET ARRTYPE=$DATA(@SANODE)
 IF ARRTYPE=0 QUIT
 IF ARRTYPE=1 SET ID=$PIECE($GET(@SANODE),"|",1)
 IF ARRTYPE=10 SET ID=$GET(@SANODE@(1))
 SET TEXT=$GET(@SUMTXT@(0))
 SET @SUMTXT@(0)=$SELECT(TEXT="":ID,1:TEXT_", "_ID)
 QUIT
 ;
FILENAME() ;Returns fabricated file name
 NEW TMP,OUT
 SET OUT=$$FACNUM^HDISVF01()
 SET TMP=$$HTE^XLFDT($HOROLOG,"7FS")
 SET OUT=OUT_"-"_$TRANSLATE(TMP," @/:","0-")
 SET OUT=OUT_".XML"
 QUIT OUT
 ;
SENDMSG(MSGTXT,SUBJ) ;Build/send message
 ; Input: MSGTXT - Array containing message text
 ;                 (FULL GLOBAL REFERENCE)
 ;        SUBJ - Message subject (optional)
 ;Output: Message number of generated message (aka XMZ)
 ;        0 is returned if the message could not be generated
 ; Notes: If this is a non-production system the message is sent
 ;        to the current user
 ;
 NEW HDISVTO,HDISVFLG,HDISVXMZ,XTYPE
 ;Default message subject
 SET SUBJ=$GET(SUBJ)
 IF (SUBJ="") DO
 .NEW FACPTR,FACNUM
 .;Get pointer to current location
 .SET:('$$GETFAC^HDISVF07(,.FACPTR)) FACPTR=$$FACPTR^HDISVF01()
 .;Get facility number of current location
 .SET FACNUM=$PIECE($$NS^XUAF4(FACPTR),"^",2)
 .IF (FACNUM="") SET FACNUM=$$FACNUM^HDISVF01()
 .;Build message subject
 .SET SUBJ="LAB EXCEPTION DATA FROM "_FACNUM
 .QUIT
 ;Deliver to mail group on FORUM
 SET HDISVTO("G.HDIS LAB EXCEPTIONS@DOMAIN.EXT")=""
 ;If this is a non-production system send message to current user
 SET:('$$GETTYPE^HDISVF07(,.XTYPE)) XTYPE=$$PROD^XUPROD()
 IF ('XTYPE) DO
 .KILL HDISVTO
 .SET HDISVTO(DUZ)=""
 .QUIT
 ;Unrestricted addressing
 SET HDISVFLG("ADDR FLAGS")="R"
 ;Message is info only
 SET HDISVFLG("FLAGS")="I"
 ;Message sender
 SET HDISVFLG("FROM")="Data Standardization Toolset"
 ;Send message (UUEncoded array is the message text)
 DO SENDMSG^XMXAPI(DUZ,SUBJ,MSGTXT,.HDISVTO,.HDISVFLG,.HDISVXMZ)
 IF $GET(XMERR) DO
 .;Error sending message - log error text
 .DO ERR2XTMP^HDISVU01("HDI-XM","Message sending",$NAME(^TMP("XMERR",$JOB)))
 .KILL XMERR,^TMP("XMERR",$JOB)
 .;Reset generated message number
 .SET HDISVXMZ=0
 .QUIT
 ;Done - return message number
 QUIT HDISVXMZ
 ;
GETTAGS(TAGS) ;Build array of element names
 NEW X,LINE
 KILL @TAGS
 FOR X=1:1 DO  QUIT:('X)
 .SET LINE=$PIECE($TEXT(TAGS+X),";;",2)
 .IF (LINE="") SET X=0 QUIT
 .SET @TAGS@(+$PIECE(LINE,"^",1))=$PIECE(LINE,"^",2)
 .QUIT
 QUIT
 ;
TAGS ;
 ;;1^Lab_Exceptions
 ;;2^Lab_Exception_Data
 ;;3^Administrative_Data
 ;;3.01^Exception_Station_Number
 ;;3.02^Exception_Station_Domain_IP
 ;;3.03^Exception_Station_System_Type
 ;;3.04^Exception_Type_Code
 ;;3.05^Exception_Transaction_Number
 ;;3.06^Exception_Time_Stamp
 ;;3.07^Lab_Package_Exception_Text
 ;;4^Lab_File_SNOMED_Data
 ;;4.01^FacilityNumber_FileNumber_IEN
 ;;4.02^Entry_Name
 ;;4.03^SNOMED_I
 ;;4.04^VUID
 ;;4.05^SNOMED_CT
 ;;4.06^SNOMED_CT_Term
 ;;4.07^Mapping_Exception
 ;;4.08^Related_Specimen
 ;;4.09^Related_Specimen_ID
 ;;4.10^Extract_Version
 ;;4.11^Term_Status
 ;;4.12^STS_Exception
 ;;4.13^STS_Exception_Reason
 ;;5^Mapping_Data_Being_Loaded
 ;;5.01^Mapping_Data_FacilityNumber_FileNumber_IEN
 ;;5.02^Mapping_Data_Entry_Name
 ;;5.03^Mapping_Data_SNOMED_I
 ;;5.04^Mapping_Data_STS_Further_Action
 ;;5.05^Mapping_Data_STS_SCT_ID
 ;;5.06^Mapping_Data_STS_Type_Of_Match
 ;;6^Reference_Lab_Data
 ;;6.01^Reference_Lab_Type_Code
 ;;6.02^Reference_Lab_Station_Number
 ;;6.03^Reference_Lab_Name
 ;;6.04^Reference_Lab_OBX-3
 ;;6.05^Reference_Lab_OBX-5
 ;;
