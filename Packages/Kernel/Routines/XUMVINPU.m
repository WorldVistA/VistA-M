XUMVINPU ;MVI/DRI - Master Veteran Index New Person Utilities ;3/21/18  10:15
 ;;8.0;KERNEL;**691**;Jul 10, 1995;Build 2
 ;
GET(XURET,XUDUZ,SECID) ;rpc to retrieve new person file data
 ; 
 ; called from rpc: XUS MVI NEW PERSON GET
 ;
 ; Input:
 ;  XUDUZ = NEW PERSON IEN
 ;            or
 ;  SECID = SECURITY ID
 ;
 ; Output:
 ;  Success:
 ;   XURET = ^TMP("XUMVINPU",$J)
 ;    @XURET@(#) = FILE #;FIELD #^FIELD NAME^INTERNAL VALUE^EXTERNAL VALUE
 ;    @XURET@(1)="200;IEN^DUZ^^"
 ;    @XURET@(2)="200;.01^NAME^^"
 ;    @XURET@(3)="200;7^DISUSER^^"
 ;    @XURET@(4)="200;9.2^TERMINATION DATE^^"
 ;    @XURET@(5)="200;9.4^Termination Reason^^"
 ;    @XURET@(6)="200;15^PROHIBITED TIMES FOR SIGN-ON^^"
 ;    @XURET@(7)="200;11.2^DATE VERIFY CODE LAST CHANGED^^"
 ;    @XURET@(8)="200;.111^STREET ADDRESS 1^^"
 ;    @XURET@(9)="200;.132^OFFICE PHONE^^"
 ;    @XURET@(10)="200;.151^EMAIL ADDRESS^^"
 ;    @XURET@(11)="200;30^DATE ENTERED^^"
 ;    @XURET@(12)="200;31^CREATOR^^"
 ;    @XURET@(13)="200;9^SSN^^"
 ;    @XURET@(14)="200;202^LAST SIGN-ON DATE/TIME^^"
 ;    @XURET@(15)="200;202.02^XUS Logon Attempt Count^^"
 ;    @XURET@(16)="200;202.03^XUS Active User^^"
 ;    @XURET@(17)="200;202.04^Entry Last Edit Date^^"
 ;    @XURET@(18)="200;202.05^LOCKOUT USER UNTIL^^"
 ;    @XURET@(19)="200.02;.01^DIVISION^1^^"
 ;    @XURET@(20)="200.02;.01^DIVISION^2
 ;    @XURET@(21)="200;10.1^NAME COMPONENTS^^"
 ;    @XURET@(22)="20;1^FAMILY (LAST) NAME^^"
 ;    @XURET@(23)="20;2^GIVEN (FIRST) NAME^^"
 ;    @XURET@(24)="20;3^MIDDLE NAME^^"
 ;    @XURET@(25)="20;4^PREFIX^^"
 ;    @XURET@(26)="20;5^SUFFIX^^"
 ;    @XURET@(27)="20;6^DEGREE^^"
 ;    @XURET@(28)="200;29^SERVICE/SECTION^^"
 ;    @XURET@(29)="200;201^PRIMARY MENU OPTION^^"
 ;    @XURET@(30)="200.03;.01^SECONDARY MENU OPTIONS^1^^"
 ;    @XURET@(31)="200.03;.01^SECONDARY MENU OPTIONS^2^^"
 ;    @XURET@(32)="200.03;.01^SECONDARY MENU OPTIONS^3^^"
 ;    @XURET@(33)="200;205.1^SECID^^"
 ;    @XURET@(34)="200;205.2^SUBJECT ORGANIZATION^^"
 ;    @XURET@(35)="200;205.3^SUBJECT ORGANIZATION ID^^"
 ;    @XURET@(36)="200;205.4^UNIQUE USER ID^^"
 ;    @XURET@(37)="200;205.5^ADUPN^^"
 ;    @XURET@(38)="200;501.1^NETWORK USERNAME^^"
 ;
 ;  Fail:
 ;   XURET = ^TMP("XUMVINPU",$J)
 ;   @XURET@(1)="-1^Invalid User"
 ;            or
 ;   @XURET@(1)="-1^No Data for User: ######"
 ;
 ; Example calling rpc from VistA:
 ;  >D GET^XUMVINPU(.XURET,12596)
 ;  >ZW XURET
 ;  >XURET="^TMP(""XUMVINPU"",17226)"
 ;
 ;  D ^%G would return:
 ;    ^TMP("XUMVINPU",17226,1)="200;IEN^DUZ^12596^12596"
 ;                          2)="200;.01^NAME^LAST,FIRST^LAST,FIRST"
 ;                          3)="200;7^DISUSER^^"
 ;                          #)=continuation of returned data
 ;
 ; Example calling rpc from MVI:
 ;  D DIRECT^XWB2HL7(.XURET,SITE,"XUS MVI NEW PERSON GET","",$G(XUDUZ),$G(SECID))
 ;
 ;
 K XURET
 N CNT,FILE,FLD,FLDNM,XUARR,XUGBL
 S XUGBL="^TMP("_"""XUMVINPU"""_","_$J_")"
 K @XUGBL
 ;
 S CNT=1,FILE=200
 I $G(SECID)'="" S XUDUZ=$O(^VA(FILE,"ASECID",SECID,0))
 I $G(XUDUZ)="" S @XUGBL@(CNT)="-1^Invalid User" S XURET=$NA(@XUGBL) Q
 I '$D(^VA(FILE,XUDUZ)) S @XUGBL@(CNT)="-1^No Data for User: "_XUDUZ S XURET=$NA(@XUGBL) Q
 ;
 S @XUGBL@(CNT)=FILE_";IEN^DUZ^"_XUDUZ_"^"_XUDUZ S CNT=CNT+1
 ;
 D GETS^DIQ(FILE,+XUDUZ_",",".01;7;9.2;9.4;15;11.2;.111;.132;.151;30;31;9;202;202.02;202.03;202.04;202.05;16*;10.1;29;201;203*;205.1;205.2;205.3;205.4;205.5;501.1","EI","XUARR") ;retrieve data
 ;
 F FLD=.01,7,9.2,9.4,15,11.2,.111,.132,.151,30,31,9,202,202.02,202.03,202.04,202.05,16,10.1,29,201,203,205.1,205.2,205.3,205.4,205.5,501.1 D
 . D FIELD^DID(FILE,FLD,"","LABEL","FLDNM")
 . ;
 . I FLD=16 D  Q  ;division multiple
 . . N IENS,MCNT,SUBFILE,SUBFLD
 . . S MCNT=1,SUBFILE=200.02,SUBFLD=.01
 . . D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 . . I '$D(XUARR(SUBFILE)) S @XUGBL@(CNT)=SUBFILE_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^^" S CNT=CNT+1 Q
 . . S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  S @XUGBL@(CNT)=SUBFILE_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")) S MCNT=MCNT+1,CNT=CNT+1
 . ;
 . I FLD=10.1 D  Q  ;name components
 . . S @XUGBL@(CNT)=FILE_";"_FLD_"^"_(FLDNM("LABEL"))_"^"_$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_"^"_$G(XUARR(FILE,XUDUZ_",",FLD,"E")) S CNT=CNT+1
 . . N NCFILE,NCFLD
 . . S NCFILE=20
 . . D GETS^DIQ(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",","1;2;3;4;5;6","EI","XUARR") ;retrieve name component data
 . . F NCFLD=1,2,3,4,5,6 D
 . . . D FIELD^DID(NCFILE,NCFLD,"","LABEL","FLDNM")
 . . . S @XUGBL@(CNT)=NCFILE_";"_NCFLD_"^"_(FLDNM("LABEL"))_"^"_XUARR(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",",NCFLD,"I")_"^"_XUARR(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",",NCFLD,"E") S CNT=CNT+1
 . ;
 . I FLD=203 D  Q  ;secondary menu options multiple
 . . N IENS,MCNT,SUBFILE,SUBFLD
 . . S MCNT=1,SUBFILE=200.03,SUBFLD=.01
 . . D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 . . I '$D(XUARR(SUBFILE)) S @XUGBL@(CNT)=SUBFILE_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^^" S CNT=CNT+1 Q
 . . S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  S @XUGBL@(CNT)=SUBFILE_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")) S MCNT=MCNT+1,CNT=CNT+1
 . ;
 . S @XUGBL@(CNT)=FILE_";"_FLD_"^"_(FLDNM("LABEL"))_"^"_XUARR(FILE,XUDUZ_",",FLD,"I")_"^"_XUARR(FILE,XUDUZ_",",FLD,"E") S CNT=CNT+1 ;all other fields
 ;
 S XURET=$NA(@XUGBL)
 Q
 ;
 ;
UPDATE(XURET,XUARR) ;rpc to update new person file data
 ;
 ; called from rpc: XUS MVI NEW PERSON UPDATE
 ;
 ; Input:
 ;   XUARR(#) = FILE #;FIELD #^FIELD NAME^INTERNAL VALUE^EXTERNAL VALUE
 ;   XUARR(0)="200;IEN^DUZ^^"
 ;   XUARR(#)="200;.01^NAME^^"
 ;   XUARR(#)="200;205.1^SECID^^"
 ;   XUARR(#)="200;205.2^SUBJECT ORGANIZATION^^"
 ;   XUARR(#)="200;205.3^SUBJECT ORGANIZATION ID^^"
 ;   XUARR(#)="200;205.4^UNIQUE USER ID^^"
 ;   XUARR(#)="200;205.5^ADUPN^^"
 ;
 ;  Success:
 ;   XURET(0) = 1
 ;
 ;  Fail:
 ;   XURET(0) = "-1^No data passed"
 ;   XURET(0) = "-1^Invalid User DUZ (null)"
 ;   XURET(0) = "-1^User '"_XUDUZ_"' does not exist"
 ;   XURET(0) = "-1^Invalid Name Component IEN"
 ;   XURET(0) = "-1^No Data for Name Componet IEN: "_NCIEN
 ;   XURET(0) = "-1^No data to file for record '"_XUDUZ_"' in file 200"
 ;   XURET(0) = "-1^Unable to lock record '"_XUDUZ_"' in file 200" 
 ;   XURET(0) = "-1^"_$G(XUERR("DIERR",1,"TEXT",1))
 ;
 ; Example calling rpc from VistA:
 ;  >D UPDATE^XUMVINPU(.XURET,.XUARR)
 ;  >ZW XURET
 ;  >XURET(0)=1
 ;
 ;
 ; Example calling rpc from MVI:
 ;  D DIRECT^XWB2HL7(.XURET,SITE,"XUS MVI NEW PERSON UPDATE","",.XUARR)
 ;
 ;
 K XURET
 N ARR,FDA,FILENUM,FLDNAM,FLDNUM,IDATA,NCIEN,XUDUZ,XUERR
 ;
 I '$D(XUARR) S XURET(0)="-1^No data passed" Q
 ;
 S ARR="XUARR"
 F  S ARR=$Q(@ARR) Q:ARR=""  S FILENUM=+$P($P(@ARR,"^",1),";",1),FLDNUM=+$P($P(@ARR,"^",1),";",2),FLDNAM=$P(@ARR,"^",2),IDATA=$P(@ARR,"^",3) D  I $G(XURET) Q
 . I FLDNAM="DUZ" D  Q  ;first parameter passed
 . . S XUDUZ=IDATA ;duz ien
 . . I $G(XUDUZ)="" S XURET(0)="-1^Invalid User DUZ (null)" Q
 . . I '$D(^VA(FILENUM,XUDUZ,0)) S XURET(0)="-1^User '"_XUDUZ_"' does not exist"  Q
 . I FLDNAM="NAME COMPONENTS" D  Q
 . . S NCIEN=IDATA ;name component ien
 . . I $G(NCIEN)="" S XURET(0)="-1^Invalid Name Component IEN"
 . . I '$D(^VA(20,NCIEN,0)) S XURET(0)="-1^No Data for Name Componet IEN: "_NCIEN
 . S FDA(FILENUM,$S(FILENUM=200:+$G(XUDUZ),1:+$G(NCIEN))_",",FLDNUM)=IDATA
 ;
 I '$D(FDA) S XURET(0)="-1^No data to file for record '"_XUDUZ_"' in file 200" Q
 ;
 L +^VA(200,XUDUZ):10 I '$T S XURET(0)="-1^Unable to lock record '"_XUDUZ_"' in file 200" Q
 D FILE^DIE(,"FDA","XUERR") I $D(XUERR("DIERR")) S XURET(0)="-1^"_$G(XUERR("DIERR",1,"TEXT",1)) Q
 L -^VA(200,XUDUZ)
 ;
 S XURET(0)=1 ;successfully filed
 Q
 ;
