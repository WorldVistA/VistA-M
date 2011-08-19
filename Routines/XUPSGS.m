XUPSGS ;ALB/CMC - GET, COMPARE/SET FOR FILE 200;DEC 31 2008
 ;;8.0;KERNEL;**551**;Jul 10, 1995;Build 2
 ;
 Q
GET(EN,ARRAY) ;GET DATA FROM FILE 200 AND SET INTO ARRAY
 ;EN is the internal entry for the person in file 200
 ;returned is 0 or -1^error message
 ;if returned value is 0 then ARRAY will also be defined with the data values
 N CNT,COR,NAME2,NAME
 I 'EN S ERROR="-1^Invalid parameter - no correlation ien passed." Q ERROR
 M COR(EN)=^VA(200,EN)
 I '$D(COR(EN)) S ERROR="-1^Correlation doesn't exist." Q ERROR
 S ARRAY("SourceSystemIEN")=$P($$SITE^VASITE(),"^") ;facility ien
 S ARRAY("SourceSystemID")=$P($$SITE^VASITE(),"^",3) ;facility station number
 S ARRAY("SourceID")=EN ;duz
 S NAME2=$P(COR(EN,0),"^")
 S NAME=$$HLNAME^XLFNAME(.NAME2,"","^")
 S ARRAY("Surname")=$P(NAME,"^") ;surname
 S ARRAY("FirstName")=$P(NAME,"^",2) ;first name
 S ARRAY("MiddleName")=$P(NAME,"^",3) ;middle name
 S ARRAY("Prefix")=$$GET1^DIQ(200,EN,"NAME COMPONENTS:PREFIX") ;prefix NOT PART OF .01, get from components file
 S ARRAY("Suffix")=$P(NAME,"^",4) ;suffix
 S ARRAY("DOB")=$P($G(COR(EN,1)),"^",3) ;dob
 S ARRAY("Gender")=$P($G(COR(EN,1)),"^",2) ;gender
 S ARRAY("SSN")=$P($G(COR(EN,1)),"^",9) ;ssn
 S ARRAY("ResAddL1")=$P($G(COR(EN,.11)),"^") ;street line 1
 S ARRAY("ResAddL2")=$P($G(COR(EN,.11)),"^",2) ;street line 2
 S ARRAY("ResAddL3")=$P($G(COR(EN,.11)),"^",3) ;street line 3
 S ARRAY("ResAddCity")=$P($G(COR(EN,.11)),"^",4) ;city
 S ARRAY("ResAddState")=$P($G(^DIC(5,+$P($G(COR(EN,.11)),"^",5),0)),"^",2) ;state
 S ARRAY("ResAddZip4")=$P($G(COR(EN,.11)),"^",6) ;zip
 S ARRAY("ResPhone")=$P($G(COR(EN,.13)),"^") ;HOME phone number
 S ARRAY("NPI")=$P($G(^VA(200,EN,"NPI")),"^") ;NPI
 S ARRAY("PAID")=$P($G(^VA(200,EN,450)),"^") ;PAID FILE IEN
 S ARRAY("EnumerateStart")=$P($G(^VA(200,EN,"MPI")),"^") ;Enumeration Initiated
 S ARRAY("EnumerateComp")=$P($G(^VA(200,EN,"MPI")),"^",2) ;Enumeration Completed
 Q 0
 ;
UPD(EN,ARRAY,ERROR) ;update New Person entry EN
 ;  Input: EN is the IEN in file 200 to be updated
 ;  ARRAY is an array with the values to be updated
 ;  ERROR is an array that will return any error messages for any field that fails to update
 ;  Returns:  -1^error text if unsuccessful
 ;            0 if OK - doesn't mean ERROR isn't defined
 ;
 N CNT,COR,ECNT,FDA,FLDCNT,IDCNT,IEN,MIEN,NAMEDIT,MPIERR,RET,TFUPDATE
 K ERROR ;clean up in case someone passed it in
 I 'EN S ERROR="-1^Invalid parameter - no ien passed." Q ERROR
 ;
 L +^VA(200,EN):600 ;lock New Person file entry
 ;
 M COR(EN)=^VA(200,EN) ;get current New Person file data
 ;
 D BLDFDA(.ARRAY,.COR,.FDA) ;build the fda array to update NEW PERSON file entry
 ;
 I $D(FDA) D FILE^DIE("E","FDA","XUERR") I $D(XUERR("DIERR")) D LOGERR(.XUERR)
 ;file correlation data and capture any text of errors
 I $G(ECNT),(ECNT=FLDCNT) S ERROR="-1^Unable to begin updating field(s) in correlation for ien # "_IEN_"." L -^VA(200,EN) Q ERROR ;if no edits occurred then return error condition
 ;
 L -^VA(200,EN) ;unlock New Person file entry
 ;
 Q 0 ;no problems updating New Person file entry
 ;
LOGERR(XUERR) ;build error array from fileman's error array
 N ECNT,E
 S ECNT=1,E=0
 F  S E=$O(XUERR("DIERR",E)) Q:'E  I $D(XUERR("DIERR",1,"TEXT",1)) S ECNT=ECNT+1,ERROR(ECNT)=$G(XUERR("DIERR",E,"TEXT",1)) ;capture text of errors
 Q
 ;
BLDFDA(NEWCOR,COR,FDA)   ;build the FDA array to create the correlation
 ;will only create FDA if existing data is different from updated data
 K FDA
 ;
 I $G(NEWCOR("Surname")) S NEWCOR("NAME")=$G(NEWCOR("Surname"))_","_$G(NEWCOR("FirstName"))_" "_$G(NEWCOR("MiddleName"))_" "_$G(NEWCOR("Suffix")) D
 .I $G(NEWCOR("NAME"))'="",$G(NEWCOR("NAME"))'=$P($G(COR(EN,0)),"^") S FDA(200,EN_",",.01)=NEWCOR("NAME")
 ;
 I $G(NEWCOR("DOB"))'="",(NEWCOR("DOB")'=$P($G(COR(EN,1)),"^",3)),$S(NEWCOR("DOB")="@"&($P($G(COR(EN,1)),"^",3)=""):0,1:1) D
 .S FDA(200,EN_",",5)=$$FMTE^XLFDT(NEWCOR("DOB")) ;dob
 ;
 I $G(NEWCOR("Gender"))'="",(NEWCOR("Gender")'=$P($G(COR(EN,1)),"^",2)),$S(NEWCOR("Gender")="@"&($P($G(COR(EN,1)),"^",2)=""):0,1:1) D
 .S FDA(200,EN_",",4)=NEWCOR("Gender") ;gender
 ;
 I $G(NEWCOR("SSN"))'="",(NEWCOR("SSN")'=$P($G(COR(EN,1)),"^",9)),$S(NEWCOR("SSN")="@"&($P($G(COR(EN,1)),"^",9)=""):0,1:1) D
 .S FDA(200,EN_",",9)=NEWCOR("SSN") ;ssn
 ;
 I $G(NEWCOR("ResAddL1"))'="",(NEWCOR("ResAddL1")'=$P($G(COR(EN,.11)),"^")),$S(NEWCOR("ResAddL1")="@"&($P($G(COR(EN,.11)),"^")=""):0,1:1) D
 .S FDA(200,EN_",",.111)=NEWCOR("ResAddL1") ;street line 1
 I $G(NEWCOR("ResAddL2"))'="",(NEWCOR("ResAddL2")'=$P($G(COR(EN,.11)),"^",2)),$S(NEWCOR("ResAddL2")="@"&($P($G(COR(EN,.11)),"^",2)=""):0,1:1) D
 .S FDA(200,EN_",",.112)=NEWCOR("ResAddL2") ;street line 2
 I $G(NEWCOR("ResAddL3"))'="",(NEWCOR("ResAddL3")'=$P($G(COR(EN,.11)),"^",3)),$S(NEWCOR("ResAddL3")="@"&($P($G(COR(EN,.11)),"^",3)=""):0,1:1) D
 .S FDA(200,IEN_",",.113)=NEWCOR("ResAddL3") ;street line 3
 I $G(NEWCOR("ResAddCity"))'="",(NEWCOR("ResAddCity")'=$P($G(COR(EN,.11)),"^",4)),$S(NEWCOR("ResAddCity")="@"&($P($G(COR(EN,.11)),"^",4)=""):0,1:1) D
 .S FDA(200,EN_",",.114)=NEWCOR("ResAddCity") ;city
 I $G(NEWCOR("ResAddState"))'="",(NEWCOR("ResAddState")'=$P($G(^DIC(5,+$P($G(COR(EN,.11)),"^",5),0)),"^",2)),$S(NEWCOR("ResAddState")="@"&($P($G(COR(EN,.11)),"^",5)=""):0,1:1) D
 .N RESSTIEN S RESSTIEN=NEWCOR("ResAddState"),RESSTIEN=$S(RESSTIEN="@":"@",RESSTIEN="FG":$O(^DIC(5,"B","FOREIGN COUNTRY",0)),RESSTIEN="OT":$O(^DIC(5,"B","OTHER",0)),RESSTIEN="EU":$O(^DIC(5,"B","EUROPE",0)),1:$O(^DIC(5,"C",RESSTIEN,0)))
 .S FDA(200,EN_",",.115)=$S(RESSTIEN="@":"@",1:"`"_RESSTIEN) ;state
 I $G(NEWCOR("ResAddZip4"))'="",(NEWCOR("ResAddZip4")'=$P($G(COR(EN,.11)),"^",6)),$S(NEWCOR("ResAddZip4")="@"&($P($G(COR(EN,.11)),"^",6)=""):0,1:1) D
 .S FDA(200,EN_",",.116)=NEWCOR("ResAddZip4") ;zip
 ;
 I $G(NEWCOR("ResPhone"))'="",(NEWCOR("ResPhone")'=$P($G(COR(EN,.13)),"^")),$S(NEWCOR("ResPhone")="@"&($P($G(COR(EN,.13)),"^")=""):0,1:1) D
 .S FDA(200,EN_",",.131)=NEWCOR("ResPhone") ;phone number
 Q
