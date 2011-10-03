EASEZF2 ;ALB/jap - Filing 1010EZ Data to Patient Database ;10/31/00  13:07
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,9,51,57,70**;Mar 15, 2001;Build 26
 ;
F408(EASAPP,EASDFN) ;
 N KEYIEN,FILE,SUBFILE,FLD,DATAKEY,MULTIPLE,MM,SECT,QUES,SUBIEN,ACCEPT,EZDATA,PTDATA,LINK
 N DFN,DGPR12,INCYR,TESTYR,LASTINC,XLINK,EROOT,EAS,ERR,IENS,MSG,X,Y
 Q:'$G(EASDFN)
 ;determine income year for financial data
 S Y=$P($G(^EAS(712,EASAPP,0)),U,6) I Y="" S Y=DT
 S %F=5,X=$$FMTE^XLFDT(Y,%F),X=+$P(X,"/",3)-1,%DT="P" D ^%DT S INCYR=Y
 S YREND=$E(DT,1,3)_"1231"
 ;don't file any 408 data if applicant has income test for current year at this site
 S LASTINC=$$LST^DGMTU(EASDFN,YREND,1) I LASTINC="" S LASTINC=$$LST^DGMTU(EASDFN,YREND,2)
 S TESTYR=$P(LASTINC,U,2)
 Q:($E(TESTYR,1,3)=$E(DT,1,3))&($P(LASTINC,U,5)>1)
 ;
 ;DGPR12("AP") is the Applicant's (veteran's) IEN in file #408.12
 S DGPR12("AP")=""
 ;add Applicant to file #408.12 if not there already;
 ;make this addition even if no other financial data is available;
 I '$D(^DGPR(408.12,"B",EASDFN)) D
 . ;create the file #408.12 record
 . K EAS,ERR,EZIENS
 . S EAS(EASAPP,408.12,"+1,",".01")=EASDFN
 . S EAS(EASAPP,408.12,"+1,",".02")=1
 . S EAS(EASAPP,408.12,"+1,",".03")=EASDFN_";DPT("
 . S EROOT="EAS("_EASAPP_")"
 . D UPDATE^DIE("S",EROOT,"EZIENS","ERR")
 . S DGPR12("AP")=$G(EZIENS(1))
 . Q:DGPR12("AP")=""
 . ;create the subfile #408.1275 record
 . K EAS,ERR,EZIENS
 . ;S KEY=+$$KEY711^EASEZU1("APPLICANT DATE OF BIRTH")
 . ;S DOB=$P($$DATA712^EASEZU1(EASAPP,KEY,1),U,1)
 . ;use DOB from file #2
 . S X=$P($G(^DPT(EASDFN,0)),U,3),%DT="PX" D ^%DT S DOB=Y
 . S EAS(EASAPP,408.1275,"+1,"_DGPR12("AP")_",",".01")=DOB
 . S EAS(EASAPP,408.1275,"+1,"_DGPR12("AP")_",",".02")="YES"
 . D UPDATE^DIE("ES",EROOT,"EZIENS","ERR")
 . ;link 1010EZ data with new record in #408.12
 I DGPR12("AP")="" S DGPR12("AP")=$O(^DGPR(408.12,"B",EASDFN,0))
 ;if no record for Applicant in file #408.12 exists, then don't continue
 Q:DGPR12("AP")=""
 ;
 ;kill local holding arrays
 K AP,SP,CN,FLINK
 ;get data for file #408.12,#408.13,#408.21,#408.22 into local arrays 
 S SECT=""
 F  S SECT=$O(^TMP("EZTEMP",$J,SECT)) Q:SECT=""  S MULTIPLE=0 D
 . F  S MULTIPLE=$O(^TMP("EZTEMP",$J,SECT,MULTIPLE)) Q:MULTIPLE=""  S QUES="" D
 . . F  S QUES=$O(^TMP("EZTEMP",$J,SECT,MULTIPLE,QUES)) Q:QUES=""  D
 . . . S DATAKEY=SECT_";"_QUES
 . . . ;call to suppress may be redundant
 . . . Q:$$SUPPRESS^EASEZU4(EASAPP,DATAKEY,1,EASVRSN)
 . . . S X=^TMP("EZTEMP",$J,SECT,MULTIPLE,QUES)
 . . . S KEYIEN=$P(X,U,1),EZDATA=$P(X,U,2),ACCEPT=$P(X,U,3),SUBIEN=$P(X,U,4),PTDATA=$P(X,U,5)
 . . . S LN=^TMP("EZDATA",$J,KEYIEN),FILE=$P(LN,U,1),SUBFILE=$P(LN,U,2),FLD=$P(LN,U,3)
 . . . Q:($P(FILE,".",1)'=408)
 . . . S LINK=$P($G(^EAS(712,EASAPP,10,SUBIEN,2)),U,2)
 . . . S DATANM=$P($G(^EAS(711,KEYIEN,0)),U,1)
 . . . S MM=MULTIPLE S:DATANM["CHILD(N)" MM=MULTIPLE+1
 . . . I (SECT="IIF")!(SECT="IIG") S MM=MULTIPLE
 . . . S ARR=$S(DATANM["SPOUSE":"SP",DATANM["CHILD":"CN",DATANM["ASSET(N)":"CN",1:"AP")
 . . . S @ARR@(MM,FILE,SUBFILE,FLD)=EZDATA_U_ACCEPT_U_SUBIEN_U_PTDATA_U_LINK
 ;delete any Spouse or Dependent data if #.01 field for file #408.13 does not exist
 I $D(SP(1,408.13,408.13,.01))'=1 K SP
 ;if contributed to spouse, applicant lived with patient = NO
 I +$P($G(AP(1,408.22,408.22,.07)),U,1) D
 . S AP(1,408.22,408.22,.06)="NO^2^^^"_$P(AP(1,408.22,408.22,.07),U,5)
 S MM=0 F  S MM=$O(CN(MM)) Q:'MM  D
 . I $D(CN(MM,408.13,408.13,.01))'=1 K CN(MM) Q
 . ;check for amt contributed to child
 . I +$P($G(CN(MM,408.22,408.22,.19)),U,1) D
 . . S CN(MM,408.22,408.22,.1)="YES^2^^^"_$P(CN(MM,408.22,408.22,.19),U,5)
 . . S CN(MM,408.22,408.22,.06)="NO^2^^^"_$P(CN(MM,408.22,408.22,.19),U,5)
 ;
 ;gather links to VistA for Applicant
 S FLINK("AP",1,408.12)=DGPR12("AP")
 F FILE=408.21,408.22 D
 . S XLINK="",MULTIPLE=1,SUBFILE=FILE,FLD=""
 . F  S FLD=$O(AP(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . S FLINK("AP",1,FILE)=+$P(AP(MULTIPLE,FILE,SUBFILE,FLD),U,5)
 ;gather links to VistA for Spouse
 F FILE=408.12,408.13,408.21,408.22 D
 . S XLINK="",MULTIPLE=1,SUBFILE=FILE,FLD=""
 . F  S FLD=$O(SP(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . S FLINK("SP",MULTIPLE,FILE)=+$P(SP(MULTIPLE,FILE,SUBFILE,FLD),U,5)
 . I FILE=408.12 S SUBFILE=408.1275 F  S FLD=$O(SP(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . S FLINK("SP",MULTIPLE,SUBFILE)=$P($P(SP(MULTIPLE,FILE,SUBFILE,FLD),U,5),";",2)
 . . S FLINK("SP",MULTIPLE,FILE)=$P($P(SP(MULTIPLE,FILE,SUBFILE,FLD),U,5),";",1)
 ;gather links to VistA for Dependents
 S MULTIPLE=0 F  S MULTIPLE=$O(CN(MULTIPLE)) Q:'MULTIPLE  D
 . F FILE=408.13,408.12,408.21,408.22 D
 . . S XLINK="",SUBFILE=FILE,FLD=""
 . . F  S FLD=$O(CN(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . . S FLINK("CN",MULTIPLE,FILE)=+$P(CN(MULTIPLE,FILE,SUBFILE,FLD),U,5)
 . . I FILE=408.12 S SUBFILE=408.1275 F  S FLD=$O(CN(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . . S FLINK("CN",MULTIPLE,SUBFILE)=$P($P(CN(MULTIPLE,FILE,SUBFILE,FLD),U,5),";",2)
 . . . S FLINK("CN",MULTIPLE,FILE)=$P($P(CN(MULTIPLE,FILE,SUBFILE,FLD),U,5),";",1)
 ;
 ;file data
 Q:DGPR12("AP")=""
 S DFN=EASDFN
 D AP
 I $D(FLINK("SP")) D SP^EASEZF3
 I $D(FLINK("CN")) D CN^EASEZF4
 D LINKUP^EASEZF4
 ;
 Q
 ;
AP ;file Applicant data
 N MT,P22,MULTIPLE,FILE,SUBFILE,FLD,XDATA,ACCEPT,SUBIEN,EZDATA,EAS,ERR,KEY
 F FILE=408.21,408.22 D
 . S MULTIPLE=1,SUBFILE=FILE,FLD=""
 . S XLINK=$G(FLINK("AP",1,FILE))
 . ;record in file #408.21 needed for all further data filing
 . Q:(FILE'=408.21)&('$G(FLINK("AP",1,408.21)))
 . ;for data elements with link to database, 
 . ;only file 1010EZ data if accepted by user;
 . ;data in external format
 . I XLINK D
 . . S FLD="" F  S FLD=$O(AP(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . . S XDATA=AP(MULTIPLE,FILE,SUBFILE,FLD),ACCEPT=$P(XDATA,U,2)
 . . . I ACCEPT D LINK(XDATA,FILE,FLD,"AP",MULTIPLE)
 . ;for data elements with no link to database, 
 . ;always create new record(s) to store 1010EZ data;
 . ;use internal data format
 . I 'XLINK D
 . . K EAS,ERR
 . . S FLD="" F  S FLD=$O(AP(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . . S EZDATA=$P(AP(MULTIPLE,FILE,SUBFILE,FLD),U,1)
 . . . S EAS(EASAPP,FILE,"+1,",FLD)=EZDATA
 . . I FILE=408.21 D
 . . . S EAS(EASAPP,FILE,"+1,",".01")=INCYR
 . . . S EAS(EASAPP,FILE,"+1,",".02")=FLINK("AP",1,408.12)
 . . . S EAS(EASAPP,FILE,"+1,","101")=DUZ
 . . . S EAS(EASAPP,FILE,"+1,","102")=DT
 . . . S EAS(EASAPP,FILE,"+1,","103")=DUZ
 . . . S EAS(EASAPP,FILE,"+1,","104")=DT
 . . I FILE=408.22,$G(FLINK("AP",1,408.21)) D
 . . . S EAS(EASAPP,FILE,"+1,",".01")=EASDFN
 . . . S EAS(EASAPP,FILE,"+1,",".02")=FLINK("AP",1,408.21)
 . . . I $G(SP(1,408.13,408.13,.01))'="" S EAS(EASAPP,FILE,"+1,",".05")=1
 . . . I $G(CN(1,408.13,408.13,.01))'="" S EAS(EASAPP,FILE,"+1,",".08")=1
 . . . S X=$G(EAS(EASAPP,FILE,"+1,",".06"))
 . . . S EAS(EASAPP,FILE,"+1,",".06")=$S(X="YES":1,X="NO":0,1:"")
 . . S FLINK("AP",MULTIPLE,FILE)=$$NOLINK(.EAS,"AP",MULTIPLE)
 . . S FLD="" F  S FLD=$O(AP(MULTIPLE,FILE,SUBFILE,FLD)) Q:FLD=""  D
 . . . S SUBIEN=$P(AP(MULTIPLE,FILE,SUBFILE,FLD),U,3)
 . . . ;store link to new record in subfile #712.01
 . . . S $P(AP(MULTIPLE,FILE,SUBFILE,FLD),U,5)=FLINK("AP",1,FILE)
 ;
 Q
 ;
LINK(XDATA,FILE,FLD,GRP,MULTIPLE) ;setup to call FM database server if link to file exists & data accepted
 N MSG,EZDATA,SUBIEN,PTDATA,XLINK
 K EAS,ERR
 S EZDATA=$P(XDATA,U,1),SUBIEN=$P(XDATA,U,3),PTDATA=$P(XDATA,U,4),XLINK=$P(XDATA,U,5)
 S IENS=XLINK_","
 S EROOT="EAS("_EASAPP_")"
 D VAL^DIE(FILE,IENS,FLD,"F",EZDATA,,EROOT,"ERR")
 I $D(ERR) D ERROR(GRP,MULTIPLE,.ERR,"LINK") Q
 ;file to database if input is valid
 I '$D(ERR) D
 . I FILE=408.21 D
 . . S EAS(EASAPP,FILE,IENS,103)=DUZ
 . . S EAS(EASAPP,FILE,IENS,104)=DT
 . D FILE^DIE("S",EROOT,"ERR")
 . ;set any replaced data into subfile #712.01 for audit
 . I SUBIEN S $P(^EAS(712,EASAPP,10,SUBIEN,2),U,1)=PTDATA
 Q
 ;
NOLINK(EAS,GRP,MULTIPLE) ;add new record with accepted data if no link exists;
 ;
 K EZIENS,ERR,LINK
 S EROOT="EAS("_EASAPP_")"
 D UPDATE^DIE("S",EROOT,"EZIENS","ERR")
 ;call to UPDATE should not return ERR since internal data formats are used, but just in case;
 I $D(ERR) D ERROR(GRP,MULTIPLE,.ERR,"NOLINK")
 ;return ien to new record
 S LINK=$G(EZIENS(1))
 Q LINK
 ;
ERROR(GRP,MULTIPLE,ERR,FROM) ;add FM error text to error msg
 N L,LSTLN,ECODE,ENUMBER
 S ECODE="" F  S ECODE=$O(ERR("DIERR","E",ECODE)) Q:ECODE=""  S ENUMBER=0 F  S ENUMBER=$O(ERR("DIERR","E",ECODE,ENUMBER)) Q:'ENUMBER  D
 . S LSTLN=+$O(^TMP("1010EZERROR",$J,""),-1) I 'LSTLN S LSTLN=6
 . S WHO=$S(GRP="SP":"SPOUSE",GRP="CN":"CHILD",1:"APPLICANT")
 . I WHO="CHILD" S WHO=WHO_" #"_MULTIPLE
 . S FIELD=$G(ERR("DIERR",ENUMBER,"PARAM","FIELD")),FILE=$G(ERR("DIERR",ENUMBER,"PARAM","FILE"))
 . I FROM="LINK" D
 . . S LSTLN=LSTLN+1,^TMP("1010EZERROR",$J,LSTLN,0)="1010EZ data for "_WHO_" was not filed to"
 . . S LSTLN=LSTLN+1,^TMP("1010EZERROR",$J,LSTLN,0)="Field #"_FIELD_" of File #"_FILE_" because:"
 . I FROM="NOLINK" D
 . . S LSTLN=LSTLN+1,^TMP("1010EZERROR",$J,LSTLN,0)="A new record for "_WHO_" could not be created in"
 . . S LSTLN=LSTLN+1,^TMP("1010EZERROR",$J,LSTLN,0)="File #"_FILE_" because Field #"_FIELD_" produced an error:"
 . S L=0 F  S L=$O(ERR("DIERR",ENUMBER,"TEXT",L)) Q:'L  D
 . . S LN=ERR("DIERR",ENUMBER,"TEXT",L)
 . . I $L(LN)<50 S LSTLN=LSTLN+1,^TMP("1010EZERROR",$J,LSTLN,0)=LN Q
 . . D WRAP(LN,.LSTLN)
 . S LSTLN=LSTLN+1,^TMP("1010EZERROR",$J,LSTLN,0)=" "
 Q
 ;
WRAP(LN,LSTLN) ;parse a long error text line into several message lines
 N PART,BB
 F  D  Q:$L(LN)<41
 . S PART=""
 . F BB=1:1:99 S PART=PART_$P(LN," ",BB)_" " I $L(PART)>40 D  Q
 . . S LSTLN=LSTLN+1,^TMP("1010EZERROR",$J,LSTLN,0)=PART
 . . S LN=$P(LN," ",BB+1,99)
 S LSTLN=LSTLN+1,^TMP("1010EZERROR",$J,LSTLN,0)=LN
 Q
