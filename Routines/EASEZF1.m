EASEZF1 ;ALB/jap,TM - Filing 1010EZ Data to Patient Database ; 3/13/09 5:19pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**1,51,57,62,70,93**;Mar 15, 2001;Build 2
 ;
F2(EASAPP,EASDFN) ;file to Patient record in #2
 ;input EASDFN = ien to #2
 N KEYIEN,FILE,SUBFILE,FLD,DATAKEY,MULTIPLE,SECT,QUES,SUBIEN,ACCEPT,EZDATA,PTDATA,LINK,EROOT,EAS,ERR,IENS,ARRAY,ELIGVER
 N DIC,DIQ,DA,DR,X,Y,EZSTRG
 Q:'$G(EASDFN)
 ;L +^DPT(EASDFN) ;Handling locking in EASEZFM - EAS*1*93
 I '$G(EASVRSN) S EASVRSN=$$VERSION^EASEZU4(EASAPP)
 ;EAS*1.0*70 - Special handling for Foreign Address
 S KEYIEN=+$$KEY711^EASEZU1("APPLICANT COUNTRY")
 S DATAKEY=$P(^TMP("EZDATA",$J,KEYIEN),U,4)
 S SECT=$P(DATAKEY,";"),QUES=$P(DATAKEY,";",2)
 S EZDATA=$P($G(^TMP("EZTEMP",$J,SECT,1,QUES)),U,2)
 I EZDATA="UNITED STATES" S EZSTRG="APPLICANT PROVINCE^APPLICANT POSTAL CODE"
 E  S EZSTRG="APPLICANT COUNTY^APPLICANT STATE^APPLICANT ZIP"
 F X=1:1 S DATANM=$P(EZSTRG,U,X) Q:DATANM=""  D
 . S KEYIEN=+$$KEY711^EASEZU1(DATANM) Q:(KEYIEN=.1)
 . S DATAKEY=$P(^TMP("EZDATA",$J,KEYIEN),U,4)
 . S SECT=$P(DATAKEY,";"),QUES=$P(DATAKEY,";",2)
 . K ^TMP("EZDATA",$J,KEYIEN),^TMP("EZTEMP",$J,SECT,1,QUES)
 ;
 S KEYIEN=0
 F  S KEYIEN=$O(^TMP("EZDATA",$J,KEYIEN)) Q:'KEYIEN  D
 . S LN=^TMP("EZDATA",$J,KEYIEN),FILE=$P(LN,U,1)
 . Q:FILE'=2
 . S SUBFILE=$P(LN,U,2),FLD=$P(LN,U,3),DATAKEY=$P(LN,U,4)
 . S SECT=$P(DATAKEY,";",1),QUES=$P(DATAKEY,";",2)
 . ;call to suppress may be redundant
 . Q:$$SUPPRESS^EASEZU4(EASAPP,DATAKEY,1,EASVRSN)
 . ;in file #2, multiple is always 1
 . S MULTIPLE=1
 . Q:'$D(^TMP("EZDATA",$J,KEYIEN,MULTIPLE,1))
 . S X=$G(^TMP("EZTEMP",$J,SECT,MULTIPLE,QUES))
 . Q:$P(X,U,1)'=KEYIEN
 . S EZDATA=$P(X,U,2),ACCEPT=$P(X,U,3),SUBIEN=$P(X,U,4),PTDATA=$P(X,U,5)
 . Q:EZDATA=""
 . Q:'SUBIEN
 . ;special handling for Designee
 . I FLD=.3405 S EZDATA=$S(EZDATA="NEXT OF KIN":"YES",1:"NO")
 . ;strip off code display from county
 . I SECT="I",QUES="9E." S EZDATA=$P(EZDATA," (",1)
 . ;get file #2 ien; always same as EASDFN
 . S LINK=EASDFN
 . ;don't continue if data item not accepted
 . Q:ACCEPT<1
 . ;process subfile data elsewhere
 . I SUBFILE=2.01 Q
 . I SUBFILE=2.101 Q
 . I SUBFILE=2.02 D F202^EASEZF1(SUBFILE,DATAKEY,EZDATA,SUBIEN,KEYIEN) Q
 . I SUBFILE=2.06 D F206^EASEZF1(SUBFILE,DATAKEY,EZDATA,SUBIEN) Q
 . ;special conversion to file data to field #.328
 . I FLD=.328 D
 . . S X=$$UC^EASEZT1(EZDATA) I X="SSN" D
 . . . ;allow SSN as Service Number only if field #.328 in patient record is null;
 . . . S PTSSN=$$GETANY^EASEZU1(EASAPP,EASDFN,SUBIEN)
 . . . I PTSSN="" S EZDATA="SS" Q
 . . . ;otherwise Applicant SSN must match Patient SSN
 . . . S KK=$$KEY711^EASEZU1("APPLICANT SOCIAL SECURITY NUMBER")
 . . . S EZSSN=$P($G(^TMP("EZDATA",$J,KK,1,1)),U,1),EZSSN=$TR(EZSSN,"-","")
 . . . I EZSSN=PTSSN S EZDATA="SS" Q
 . . . S EZDATA="ssn"
 . . K KK,PTSSN,EZSSN
 . ;special for fields #.092 & #.093
 . I FILE=2,((FLD=.092)!(FLD=.093)) D FPOB(DATAKEY,EZDATA,SUBIEN,PTDATA) Q
 . ;don't need these lines after 672
 . ;special for field #.362
 . ;I FILE=2,FLD=.362,EASVRSN>5.99 I (EZDATA="Y")!(EZDATA="YES") S EZDATA="YES, RECEIVING MILITARY RETIREMENT IN LIEU OF VA COMPENSATION"
 . Q:EZDATA=PTDATA
 . ;repeat check for verified eligibility;
 . ;do not file certain fields if eligibility verified
 . K ARRAY
 . S DA=EASDFN,DIC="^DPT(",DR=".3611;.3613",DIQ(0)="I",DIQ="ARRAY"
 . D EN^DIQ1 K DA,DIC,DIQ,DR
 . I $G(ARRAY(2,EASDFN,.3611,"I"))="V",$G(ARRAY(2,EASDFN,.3613,"I"))="H" S ELIGVER=1
 . I FLD=.313,$G(ARRAY(2,EASDFN,.3611,"I"))="V" Q
 . I $G(ELIGVER),((FLD=.301)!(FLD=.302)!(FLD=.36235)) Q
 . ;special for field #.32102 - Agent Orange Exposure . DATAKEY = I;14F
 . I FLD=.32102 D F32102^EASEZF1A(EASAPP,EASDFN,EZDATA)
 . ;setup to call FM database server using EASDFN as file #2 record
 . K EAS,ERR
 . S IENS=EASDFN_","
 . S EROOT="EAS("_EASAPP_")"
 . D VAL^DIE(2,IENS,FLD,"F",EZDATA,,EROOT,"ERR")
 . ;try to resolve possible invalid input for free text fields due to length
 . I $D(ERR) D RESOLVE
 . I $D(ERR) D ERROR^EASEZF2("AP",MULTIPLE,.ERR,"LINK")
 . ;file to database if input is valid
 . I '$D(ERR) D
 . . ;2/1/2001 - don't attempt to file Name, SSN, DOB; too many complications;
 . . ;  example: if system assigns pseudo-SSN to new patient, user could overwrite;
 . . ;  example: if applicant matched to existing patient, all critical identifying
 . . ;           data could be overwritten; could impact HEC as well
 . . D FILE^DIE("S",EROOT,"ERR")
 . . ;set any replaced data into subfile #712.01 for audit
 . . S ^EAS(712,EASAPP,10,SUBIEN,2)=PTDATA_U_LINK
 ;
 ;L -^DPT(EASDFN) ;Handling locking in EASEZFM - EAS*1*93
 Q
 ;
RESOLVE ;try to resolve invalid input for free text fields only
 ;see if mapped to free text field
 N FDEF,FTYPE,MAX
 I (SUBFILE=FILE)!(SUBFILE="") S FDEF=FILE
 E  S FDEF=SUBFILE
 S FTYPE=$$GET1^DID(FDEF,FLD,"","TYPE")
 Q:FTYPE'="FREE TEXT"
 S MAX=$$GET1^DID(FDEF,FLD,"","FIELD LENGTH")
 S EZDATA=$E(EZDATA,1,MAX)
 K ERR
 D VAL^DIE(2,IENS,FLD,"F",EZDATA,,EROOT,"ERR")
 ;if still sets ERR array then won't be filed to database
 Q
 ;
F202(SUBFILE,DATAKEY,EZDATA,SUBIEN,KEYIEN) ;add or edit subrecord in subfile #2.02
 ;input SUBFILE = 2.02
 ;      DATAKEY = data item identifier, e.g., I;4B.
 ;      EZDATA  = in these cases, either "N(o)" or "Y(es)"
 ;      SUBIEN  = subrecord # for data in #712/#10
 ;      KEYIEN  = record # for data element in #711
 N X,N,DATANM,EROOT,EAS,EIEN,ERR,FLD,IENS,EASARRAY,LINK,OUT,K1,K3
 Q:EZDATA'["Y"
 Q:SUBFILE'=2.02
 ;covert data to corresponding file #10 pointer
 S X=$$KEY711^EASEZU1(DATAKEY)
 S K1=$P(X,U,1),DATANM=$P(X,U,2),K3=$P(X,U,3)
 Q:(DATANM="")
 Q:(K1'=KEYIEN)
 Q:(K3'=DATAKEY)
 S DATANM=$P(DATANM," - ",2),DATANM=$E(DATANM,1,30)
 I DATANM["UNANSWERED" S DATANM="UNKNOWN BY PATIENT"
 S EZDATA=$O(^DIC(10,"B",DATANM,0))
 Q:EZDATA=""
 D I202^EASEZI(EASDFN,.EASARRAY)
 ;if matching race already exists, edit method only
 S OUT=0,N=0 F  S N=$O(EASARRAY(N)) Q:'N  D
 . Q:($P(EASARRAY(N),";",2)'=EZDATA)
 . K EAS,ERR
 . S IENS=EZDATA_","_EASDFN_","
 . S EROOT="EAS("_EASAPP_")"
 . S FLD=.02,EAS(EASAPP,SUBFILE,IENS,FLD)=1
 . D FILE^DIE("S",EROOT,"ERR")
 . S OUT=1
 ;no matching race in patient record, add new subrecord
 I 'OUT D
 . K ERR
 . S EROOT="EAS("_EASAPP_")"
 . S IENS="+1,"_EASDFN_",",EIEN(1)=EZDATA
 . S FLD=.01,EAS(EASAPP,SUBFILE,IENS,FLD)=EZDATA
 . S FLD=.02,EAS(EASAPP,SUBFILE,IENS,FLD)=1
 . D UPDATE^DIE("S",EROOT,"EIEN","ERR")
 . I $D(ERR) D ERROR^EASEZF2("AP",1,.ERR,"LINK") Q
 . S LINK=EASDFN_";"_EZDATA
 . S ^EAS(712,EASAPP,10,SUBIEN,2)=U_LINK
 Q
 ;
F206(SUBFILE,DATAKEY,EZDATA,SUBIEN) ;add subrecord in subfile #2.06 
 ;input SUBFILE = 2.06
 ;      DATAKEY = data item identifier, e.g., I;4A.
 ;      EZDATA  = in these cases, either "N(o)" or "Y(es)"
 N X,EROOT,EAS,EIEN,ERR,FLD,EASARRAY,IENS,LINK,PTDATA
 Q:SUBFILE'=2.06
 D I206^EASEZI(EASDFN,.EASARRAY)
 S LINK=$P($G(EASARRAY(1)),";",2),PTDATA="" I LINK S PTDATA=$P(^DPT(EASDFN,.06,LINK,0),U,1)
 I DATAKEY="I;4A." S EZDATA=$S(EZDATA["Y":"H",$E(EZDATA,1)="N":"N",1:"U") D
 . S EROOT="EAS("_EASAPP_")"
 . S IENS="+1,"_EASDFN_","
 . S FLD=.01,EAS(EASAPP,SUBFILE,IENS,FLD)=EZDATA
 . S FLD=.02,EAS(EASAPP,SUBFILE,IENS,FLD)="SELF IDENTIFICATION"
 . D UPDATE^DIE("ES",EROOT,"EIEN","ERR")
 . S LINK=EASDFN_";"_$G(EIEN(1))
 . S ^EAS(712,EASAPP,10,SUBIEN,2)=PTDATA_U_LINK
 Q
 ;
FPOB(DATAKEY,EZDATA,SUBIEN,PTDATA) ;add or edit pob city & state
 ;input DATAKEY = data item identifier, either, I;8A. or I;8B.
 ;      EZDATA  = free text if city or 
 ;                state abbrv if state
 ;filing for both city & state only done when datakey=I;8A.
 N X,EROOT,EAS,EIEN,ERR,FLD,EASARRAY,IENS,LINK,SECT,QUES,XIEN,XDATA
 Q:(DATAKEY'="I;8A.")
 Q:(EZDATA="")
 Q:(EZDATA=PTDATA)
 ;file pob city
 K EAS,ERR
 S FLD=.092,LINK=EASDFN
 S IENS=EASDFN_","
 S EROOT="EAS("_EASAPP_")"
 D VAL^DIE(2,IENS,FLD,"F",EZDATA,,EROOT,"ERR")
 I $D(ERR) D RESOLVE
 I $D(ERR) D ERROR^EASEZF2("AP",1,.ERR,"LINK") Q
 D FILE^DIE("ES",EROOT,"ERR")
 ;set any replaced data into subfile #712.01 for audit
 S ^EAS(712,EASAPP,10,SUBIEN,2)=PTDATA_U_LINK
 ;file pob state
 S (EZDATA,XDATA)=""
 S DATAKEY="I;8B.",SECT=$P(DATAKEY,";",1),QUES=$P(DATAKEY,";",2)
 S X=$G(^TMP("EZTEMP",$J,SECT,1,QUES)),EZDATA=$P(X,U,2),XIEN=$P(X,U,4),XDATA=$P(X,U,5)
 Q:(EZDATA="")
 Q:(EZDATA=XDATA)
 I (EZDATA["FOREIGN")!(EZDATA="FC")!(EZDATA="FG") S EZDATA="FOREIGN"
 K EAS,ERR
 S FLD=.093
 S IENS=EASDFN_","
 S EROOT="EAS("_EASAPP_")"
 D VAL^DIE(2,IENS,FLD,"F",EZDATA,,EROOT,"ERR")
 I $D(ERR) D ERROR^EASEZF2("AP",1,.ERR,"LINK") Q
 D FILE^DIE("ES",EROOT,"ERR")
 S ^EAS(712,EASAPP,10,XIEN,2)=XDATA_U_LINK
 Q
