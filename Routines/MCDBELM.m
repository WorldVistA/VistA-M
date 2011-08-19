MCDBELM ;WISC/DCB-save and load util.  ;8/15/96  09:52
 ;;2.3;Medicine;;09/13/1996
 Q
RTNELM(FILE,REC,FIELDS,EXC,DATA,TYPE,USER,TEMP,ERROR) ;RTN the elements in an array
 N Y,X,BACK,FILES,FLDS,RECS,XFILE,XREC,XFLD,HOLD,FLD,TOTAL
 N COUNT,COUNT2,XTEMP,XTFILE,TMP,TMP1,TMP2 S ERROR=""
 S FILE=$$RTNFILE(FILE,FIELDS) Q:$E(FILE,1)=" " FILE
 F TOTAL=1:1:255 S XFILE=$P(FILE,U,TOTAL),XREC=$P(REC,U,TOTAL),XFLD=$P(FIELDS,U,TOTAL) Q:(XREC_XFLD)=""  S TEMP(TOTAL)=XFILE_U_XREC_U_XFLD
 S TOTAL=TOTAL-1
 F COUNT=1:1:TOTAL Q:ERROR'=""  D
 .S XTEMP=TEMP(COUNT) S:COUNT>1 BACK=TEMP(COUNT-1)
 .S XFILE=+$P(XTEMP,U),XREC=+$P(XTEMP,U,2),XFLD=$P(XTEMP,U,3)
 .I XFILE<1 S ERROR=" 2.1 - (Sub)File is less than 1 or null" Q
 .I XREC<1 S ERROR=" 2.2 - (Sub)Record is less than 1 or null" Q
 .I '$D(^DD(XFILE)) S ERROR=" 2.3 - (Sub)File is not define" Q 
 .I COUNT>1 S HOLD=+$P($G(^DD(+$P(BACK,U,1),+$P(BACK,U,3),0)),U,2) I XFILE'=HOLD S ERROR=" 2.4 - Subfile missing in Data Dictionary" Q
 .F COUNT2=1:1:255 S FLD=$P(XFLD,";",COUNT2) Q:FLD=""!(ERROR'="")  D
 ..I +FLD=0 S ERROR=" 2.5 - (Sub)Field is zero or null"
 ..S:'$D(^DD(XFILE,FLD)) ERROR=" 2.6 - (Sub)Field is not defined in DD"
 ..I COUNT=TOTAL S TEMP("FLD",FLD)=$P(DATA,"|",COUNT2),TEMP("TYP",FLD)=$P(TYPE,U,COUNT2),TEMP("FLDNAME",FLD)=$P(^DD(XFILE,FLD,0),U,1)
 ..S (TEMP("EXC",FLD),X)=$G(EXC(FLD))
 ..D:X ^DIM  S:'$D(X) ERROR=" 2.7 Syntax error in the Execption Code"
 S TEMP("X")=$P(TEMP(TOTAL),U,3)
 S TEMP("XF")=$P(TEMP(TOTAL),U,1)
 S TEMP("USER")=+$G(USER)
 S TEMP("DIC")=$$RTNDIE(.TEMP)
 S BACK=$L(TEMP("DIC"))
 S HOLD=$E(TEMP("DIC"),1,BACK-1)
 S TEMP("GLO")=HOLD_$S($E(TEMP("DIC"),BACK)=",":")",1:"")
 S:$E(TEMP("DIC"),1)=" " ERROR=TEMP("DIC")
 Q
RTNFILE(FILE,FIELDS) ;Get the Subfile -This is used og RTELM-
 N XCOUNT,XFILE,ERROR,XTMP,XFLD,XSFILE,XFLDN,XTFILE,XTMP2
 S (XSFILE,XTFILE)=+FILE,ERROR=""
 F XCOUNT=1:1:255 S XFLD=$P(FIELDS,U,XCOUNT),XTMP2=$P(FIELDS,U,XCOUNT+1) Q:XTMP2=""!(ERROR'="")  D
 .S XTMP=$G(^DD(XTFILE,+XFLD,0)) I XTMP="" S ERORR=" Field not in DD" Q
 .S XTFILE=+$P(XTMP,U,2) I '$D(^DD(XTFILE)) S ERROR=" Undefine (Sub)file"
 .S XSFILE=XSFILE_U_XTFILE
 Q $S(ERROR="":XSFILE,1:ERROR)
RTNDIE(TEMP) ;Return the DIE value
 N XFILE,XLOOP,XNODE,XBACK,ERROR S ERROR=""
 I '$D(TEMP) Q " 0.0 - Require array not define"
 S XFILE=$G(^DIC($P(+$G(TEMP(1)),U,1),0,"GL")),XLOOP=1
 Q:XFILE="" " 3.1 - Global location is not defined"
 F  S XLOOP=+$O(TEMP(XLOOP)) Q:XLOOP=0!(ERROR'="")  D
 .S XBACK=TEMP(XLOOP-1),XFILE=XFILE_$P(XBACK,U,2)_","
 .S XNODE=$G(^DD(+$P(XBACK,U,1),+$P(XBACK,U,3),0))
 .S XNODE=$P($P(XNODE,U,4),";",1)
 .I XNODE="" S ERROR=" 3.2 - The zero node of the DD is undefined" Q
 .I XNODE'=+XNODE S XNODE=""""_XNODE_"""" ; DAD 8-5-96
 .S XFILE=XFILE_XNODE_","
 S:ERROR="" ERROR=$$CHKFILE(XFILE)
 Q $S(ERROR="":XFILE,1:ERROR)
RTNDR(TEMP,TYPE) ;Return The DR value
 N XTYPE,XERROR,XFLD,XDR,XHLD,XDAT
 S TYPE=+$G(TYPE)
 I '$D(TEMP) Q " 0.0 - Require array not define"
 S XTYPE="///",(XERROR,XFLD,XDR)=""
 F  S XFLD=+$O(TEMP("FLD",XFLD)) Q:XFLD=0  D
 .I (TYPE=1),($G(TEMP("EXC",XHOLD))'=""),(ERROR'="") D
 ..S X=TEMP("FLD",FLD) X:X'="" TEMP("EXC",XHOLD)
 ..S:X'="" TEMP("FLD",FLD)=X
 .S XHLD=$G(TEMP("TYP",XFLD)),XHLD=$S(XHLD="":XTYPE,1:XHLD)
 .S XDAT=$G(TEMP("FLD",XFLD)),XDR=XDR_$S(XDR="":"",1:";")
 .S:TYPE=1 XDR=XDR_XFLD_$S(XDAT="":XTYPE,1:XHLD)_XDAT
 .S:TYPE=0 XDR=XDR_XFLD
 Q XDR
RTNDA(TEMP,ARRAY,ERROR) ;Return The DA value
 N HOLD,TOTAL,COUNT S ERROR="",TOTAL=$$TOTAL(.TEMP)
 I '$D(TEMP) Q " 0.0 - Require array not define"
 F COUNT=TOTAL:-1:1 Q:ERROR'=""  D
 .S ARRAY(TOTAL-COUNT)=+$P($G(TEMP(COUNT)),U,2)
 .S:ARRAY(TOTAL-COUNT)<1 ERROR=" 5.1 - Record is less than 1 or null"
 S ARRAY=ARRAY(0) K ARRAY(0)
 Q
STR(XTEMP) ;GET THE DATA VALUE (used by RTNELM)
 N TEMP,LOOP,HOLD
 S TEMP=$P(XTEMP,"/",2,255) F LOOP=1:1:4 Q:$E(TEMP,LOOP)'="/"
 S HOLD=$E(TEMP,LOOP,$L(TEMP))
 Q $S(HOLD="@":"",1:HOLD)
TOTAL(ARRAY) ;Find the total count in an array used by calls)
 N COUNT,TOTAL S (COUNT,TOTAL)=0
 F  S COUNT=+$O(TEMP(COUNT)) S:COUNT'=0 TOTAL=COUNT Q:COUNT=0
 Q TOTAL
CHKFILE(FILE) ;This validates if global reference is a fileMan file & exists
 N X S ERROR=""
 S X="S:'$D("_FILE_"0)) ERROR="" 6.1 (sub)file does not exist"""
 D ^DIM
 I '$D(X)!($E(FILE,1)'["^")!(($E(FILE,$L(FILE))'[",")&($E(FILE,$L(FILE))'["(")) S ERROR=" 7.1 Bad Global name for FileMan"
 Q ERROR
