EASEZT1 ;ALB/jap - Data Transformation Logic for 1010EZ Processing ;10/12/00  13:08
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**51,70**;Mar 15, 2001;Build 26
 ;
 ;
NAME(EASAPP,TYPE,MULTIPLE) ;get full name for person of interest
 ;input  EASAPP = application ien in file #712
 ;         TYPE = "APPLICANT", "SPOUSE", "CHILD1", "CHILD(N)", "NEXT-OF-KIN", "E-CONTACT"
 ;     MULTIPLE = default to 1, unless TYPE="CHILD(N)"
 ;output  NAME   =  LAST,FIRST MIDDLE SUFFIX
 ;
 ;sets entire name in Vista format;
 ;places result in the first data element associated with name;
 ;nulls unneeded ^TMP("EZDATA" nodes to avoid use in SORT^EASEZC3
 N RTR,KEY,NAME,LAST,FIRST,MDL,SUFF,T
 S NAME=""
 S KEY=+$$KEY711^EASEZU1(TYPE_" LAST NAME") I KEY D
 .S LAST=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1)
 S KEY=+$$KEY711^EASEZU1(TYPE_" FIRST NAME") I KEY D
 .S FIRST=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1)
 .F T=1,2 S ^TMP("EZDATA",$J,KEY,MULTIPLE,T)=""
 S KEY=+$$KEY711^EASEZU1(TYPE_" MIDDLE NAME") I KEY D
 .S MDL=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1)
 .F T=1,2 S ^TMP("EZDATA",$J,KEY,MULTIPLE,T)=""
 S KEY=+$$KEY711^EASEZU1(TYPE_" SUFFIX NAME") I KEY D
 .S SUFF=$P($$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE),U,1)
 .F T=1,2 S ^TMP("EZDATA",$J,KEY,MULTIPLE,T)=""
 I (LAST="")!(FIRST="") Q NAME
 S NAME=LAST_","_FIRST
 I $L(NAME)+$L(MDL)>45 S MDL=$E(MDL,1)
 I MDL'="" S NAME=NAME_" "_MDL
 I SUFF'="" S NAME=NAME_" "_SUFF
 S NAME=$$UC^EASEZT1($E(NAME,1,45))
 Q NAME
 ;
SSNOUT(EASSSN) ;format ssn for output to display or print
 ; input  EASSSN = 9 digit OR 9-digit+P ssn
 ; output    SSN = nnn-nn-nnnn OR nnn-nn-nnnnP
 N SSN,P,X1,X2,X3
 I EASSSN="--" Q ""
 I $L(EASSSN)'=9 Q EASSSN
 S X1=$E(EASSSN,1,3),X2=$E(EASSSN,4,5),X3=$E(EASSSN,6,9),P=$E(EASSSN,10)
 S SSN=X1_"-"_X2_"-"_X3 I P="P" S SSN=SSN_P
 Q SSN
 ;
UC(STRING) ;convert to uppercase
 ;input  STRING = alpha character string; mixed-case
 ;output      X = alpha character string; uppercase
 ;
 N %,X
 S X=STRING
 F %=1:1:$L(X) S:$E(X,%)?1L X=$E(X,0,%-1)_$C($A(X,%)-32)_$E(X,%+1,999)
 Q X
 ;
XDATE(XDATE) ;check date
 ;input  XDATE = external date mm/dd/yyyy where
 ;               mm, dd, and /or yyyy may be null
 ;output    XD = FM external date or null
 ;
 N X,XD,X1,X2,X3,Y,%DT
 I XDATE="//" Q ""
 S X1=$P(XDATE,"/",1),X2=$P(XDATE,"/",2),X3=$P(XDATE,"/",3)
 ;remove invalid portions
 I $L(X3)'=4 S X3=""
 I X1="" S X2=""
 I X3="" S X1="",X2=""
 ;if no month, day, year, then null
 I X1="",X2="",X3="" Q ""
 S X="" S:X1 X=X_X1_" " S:X2 X=X_X2_" " S X=X_X3
 ;convert to FM external format
 S %DT="P" D ^%DT
 D DD^%DT
 S XD=Y
 I XD=1699 S XD=""
 Q XD
 ;
YN(XDATA) ;
 N X
 I $L(XDATA)>1 Q XDATA
 S X=$S(XDATA="Y":"YES",XDATA="N":"NO",1:"")
 Q X
 ;
SEX(XDATA) ;
 N X
 I $L(XDATA)>1 Q XDATA
 S X=$S(XDATA="M":"MALE",XDATA="F":"FEMALE",1:"UNKNOWN")
 Q X
 ;
STATE(XDATA) ;
 N X,XI
 I $L(XDATA)'=2 Q XDATA
 I XDATA="AS" Q "AMERICAN SAMOA"
 I XDATA="DC" Q "DISTRICT OF COLUMBIA"
 I XDATA="FM" Q "FEDERATED STATES OF MICRONESIA"
 I XDATA="GU" Q "GUAM"
 I XDATA="MH" Q "MARSHALL ISLANDS"
 I XDATA="MP" Q "NORTHERN MARIANA ISLANDS"
 I XDATA="PW" Q "PALAU (TRUST TERRITORY)"
 I XDATA="PR" Q "PUERTO RICO"
 I XDATA="VI" Q "VIRGIN ISLANDS"
 I XDATA="FG" Q "FOREIGN COUNTRY"
 S XI=$O(^DIC(5,"C",XDATA,0)) I 'XI Q XDATA
 S X=$P($G(^DIC(5,XI,0)),U,1)
 Q X
 ;
COUNTY(EASAPP,XDATA) ;include county code
 ;this transform can only be used for APPLICANT COUNTY
 N X,ABBR,STATE,SIEN,CIEN,CCODE
 I XDATA="" Q XDATA
 S KEY=+$$KEY711^EASEZU1("APPLICANT STATE")
 I 'KEY Q XDATA
 S ABBR="",STATE="",SIEN="",CIEN="",CCODE=""
 I KEY D
 .S ABBR=$P($$DATA712^EASEZU1(EASAPP,KEY,1),U,1)
 .I ABBR'="" S STATE=$$STATE^EASEZT1(ABBR)
 .I STATE'="" S SIEN=$O(^DIC(5,"B",STATE,0))
 .I SIEN'="" S CIEN=$O(^DIC(5,SIEN,1,"B",XDATA,0))
 .I CIEN'="" S CCODE=$P($G(^DIC(5,SIEN,1,CIEN,0)),U,3)
 I CCODE'="" S XDATA=XDATA_" ("_CCODE_")"
 Q XDATA
 ;
ETHNIC(XDATA) ;
 N X
 I ($L(XDATA)>1)!(XDATA="") Q XDATA
 S X=$S(XDATA="Y":"YES",XDATA="N":"NO",XDATA="U":"UNKNOWN",1:"")
 I X'="" S X=X_" (S)"
 Q X
 ;
RACE(XDATA) ;
 N X
 I $L(XDATA)>1 Q XDATA
 S X=$S(XDATA="Y":"YES (S)",1:"")
 Q X
 ;
LAST(XDATA) ; return LAST NAME, first middle
 Q $$UC($P($G(XDATA),","))
 ;
COUNTRY(XDATA)  ;
 ;   Input:  3 character COUNTRY CODE (from file # 779.004)
 ;   Output: POSTAL NAME, if it exists
 ;           DESCRIPTION, if POSTAL NAME="<NULL>"
 ;           -1, if invalid
 N RSLT
 S RSLT=$$COUNTRY^DGADDUTL(XDATA)
 Q $S(RSLT=-1:"",1:RSLT)
 ;
