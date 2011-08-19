PXRMAPI1 ; SLC/PJH - Reminder Package API's;02/27/2002
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;Return ARRAY ; DBIA #3333
 ;------------------------
PLIST(ORY) ;Build a list of patient list entries.
 N CNT,PATCNT,DATE,IND,FULL,NAME
 ;Build the list in alphabetical order.
 S CNT=0
 S NAME=""
 F  S NAME=$O(^PXRMXP(810.5,"B",NAME)) Q:NAME=""  D
 .S IND=$O(^PXRMXP(810.5,"B",NAME,"")) Q:'IND
 .S FULL=$P($G(^PXRMXP(810.5,IND,0)),U)
 .S DATE=$P($G(^PXRMXP(810.5,IND,0)),U,4)
 .S PATCNT=+$P($G(^PXRMXP(810.5,IND,30,0)),U,4),CNT=CNT+1
 .S ORY(CNT)=IND_U_FULL_U_$$FMTE^XLFDT(DATE,"5Z")_U_PATCNT
 I CNT=0 S ORY(1)="-1^no entries found"
 Q
 ;
PLISTP(ORY,IEN) ;Build a list of patient list patients
 N CNT,DATA,DFN,PNAME,IND,STATION,VADM,VAERR
 ;Build the list in alphabetical order.
 S IND=0,CNT=0
 F  S IND=$O(^PXRMXP(810.5,IEN,30,IND)) Q:'IND  D
 .S DATA=$G(^PXRMXP(810.5,IEN,30,IND,0)) Q:DATA=""
 .S DFN=$P(DATA,U) Q:'DFN
 .D DEM^VADPT S PNAME=$G(VADM(1))
 .S STATION=$P(DATA,U,2)
 .S CNT=CNT+1,ORY(CNT)=DFN_U_PNAME_U_STATION
 I CNT=0 S ORY(1)="-1^no entries found"
 Q
 ;
EPLIST(ORY) ;Build a list of extract parameter entries.
 N CNT,DATE,IND,FULL,NAME,TRANSMIT
 ;Build the list in alphabetical order.
 S CNT=0
 S NAME=""
 F  S NAME=$O(^PXRM(810.2,"B",NAME)) Q:NAME=""  D
 .S IND=$O(^PXRM(810.2,"B",NAME,"")) Q:'IND
 .S FULL=$P($G(^PXRM(810.2,IND,0)),U)
 .S DATE=$P($G(^PXRM(810.2,IND,0)),U,4)
 .S TRANSMIT=""
 .S CNT=CNT+1,ORY(CNT)=IND_U_FULL_U_DATE_U_TRANSMIT
 I CNT=0 S ORY(1)="-1^no entries found"
 Q
 ;
EHLIST(ORY,IEN) ;Build a list of extract summary entries.
 N CNT,IND,NAME,PERIOD,YEAR
 ;Build the list in alphabetical order.
 S YEAR="9999",CNT=0
 F  S YEAR=$O(^PXRMXT(810.3,"D",IEN,YEAR),-1) Q:'YEAR  D
 .S PERIOD=""
 .F  S PERIOD=$O(^PXRMXT(810.3,"D",IEN,YEAR,PERIOD)) Q:'PERIOD  D
 ..S IND=""
 ..F  S IND=$O(^PXRMXT(810.3,"D",IEN,YEAR,PERIOD,IND)) Q:'IND  D
 ...S NAME=$P($G(^PXRMXT(810.3,IND,0)),U) Q:NAME=""
 ...S CNT=CNT+1,ORY(CNT)=IND_U_NAME
 I CNT=0 S ORY(1)="-1^no entries found"
 Q
 ;
ETLIST(ORY,IEN) ;Build a list of extract summary totals.
 N APPL,CNT,DATA,DUE,IND,RIEN,RNAME,SNAME,STATION,TOT
 ;Build the list in alphabetical order.
 S IND=0,CNT=0
 F  S IND=$O(^PXRMXT(810.3,IEN,3,IND)) Q:'IND  D
 .S DATA=$G(^PXRMXT(810.3,IEN,3,IND,0)) Q:DATA=""
 .S RIEN=$P(DATA,U,2) Q:'RIEN
 .S RNAME=$P($G(^PXD(811.9,RIEN,0)),U)
 .S STATION=$P(DATA,U,3),SNAME=STATION
 .S TOT=+$P(DATA,U,5),APPL=+$P(DATA,U,6),DUE=$P(DATA,U,8)
 .S CNT=CNT+1,ORY(CNT)=RNAME_U_SNAME_U_TOT_U_APPL_U_DUE
 I CNT=0 S ORY(1)="-1^no entries found"
 Q
