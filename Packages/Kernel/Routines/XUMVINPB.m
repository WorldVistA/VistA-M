XUMVINPB ;MVI/DRI - Master Veteran Index New Person Bulk Pull RPC ;9/4/19  11:44
 ;;8.0;KERNEL;**710**;Jul 10, 1995;Build 2
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**710 - STORY_952862 (dri) new routine
 ;
 ;Reference to ^XWB2HL7 supported by IA #3144
 ;
BULKGET(XURET,XUDUZ) ;rpc to retrieve bulk pull of new person file data
 ; 
 ; called from rpc: XUS MVI NEW PERSON BULK GET
 ;
 ; Input:
 ;  XUDUZ = NEW PERSON IEN TO BEGIN LOOPING
 ;
 ; Output:
 ;  Success:
 ;   XURET = ^TMP("XUMVINPB",$J)
 ;    @XURET@(#) = FILE #;FIELD #<;SUBFIELD #><;FILE POINTER>^FIELD NAME^<COUNTER #>^INTERNAL VALUE^EXTERNAL VALUE
 ;      If Counter populated, denotes multiple value <1 to n>.
 ;    @XURET@(#)="200;IEN^DUZ^^^"
 ;    @XURET@(#)="200;.01^NAME^^^"
 ;    @XURET@(#)="200;.111^STREET ADDRESS 1^^^"
 ;    @XURET@(#)="200;.112^STREET ADDRESS 2^^^"
 ;    @XURET@(#)="200;.113^STREET ADDRESS 3^^^"
 ;    @XURET@(#)="200;.114^CITY^^^"
 ;    @XURET@(#)="200;.115^STATE^^^"
 ;    @XURET@(#)="200;.116^ZIP CODE^^^"
 ;    @XURET@(#)="200;.132^OFFICE PHONE^^^"
 ;    @XURET@(#)="200;.151^EMAIL ADDRESS^^^"
 ;    @XURET@(#)="200;4^SEX^^^"
 ;    @XURET@(#)="200;5^DOB^^^"
 ;    @XURET@(#)="200;9^SSN^^^"
 ;    @XURET@(#)="200;16;.01^DIVISION^<1 to n>^^"
 ;    @XURET@(#)="200;10.1^NAME COMPONENTS^^^"
 ;    @XURET@(#)="20;1^FAMILY (LAST) NAME^^^"
 ;    @XURET@(#)="20;2^GIVEN (FIRST) NAME^^^"
 ;    @XURET@(#)="20;3^MIDDLE NAME^^^"
 ;    @XURET@(#)="20;4^PREFIX^^^"
 ;    @XURET@(#)="20;5^SUFFIX^^^"
 ;    @XURET@(#)="20;6^DEGREE^^^"
 ;    @XURET@(#)="200;205.2^SUBJECT ORGANIZATION^^^"
 ;    @XURET@(#)="200;205.3^SUBJECT ORGANIZATION ID^^^"
 ;    @XURET@(#)="200;205.4^UNIQUE USER ID^^^"
 ;    @XURET@(#)="200;501.1^NETWORK USERNAME^^^"
 ;    @XURET@(#)="200;41.99^NPI^^^"
 ;    @XURET@(#)="200;53.2^DEA#^^^"
 ;    @XURET@(#)="200;747.44^DEA EXPIRATION DATE^^^"
 ;    @XURET@(#)="200;201^PRIMARY MENU OPTION^^^"
 ;    @XURET@(#)="200;203;.01^SECONDARY MENU OPTIONS^<1 to n>^^"
 ;    @XURET@(#)="200;51;.01^KEY^<1 to n>^^"
 ;
 ;    @XURET@(#)="200;EOF^EOF^" - if end of new person file reached
 ;
 ;  Fail:
 ;   XURET = ^TMP("XUMVINPB",$J)
 ;   @XURET@(1)="-1^No Data to Retrieve"
 ;
 ; Example calling rpc from VistA:
 ;  >D BULKGET^XUMVINPB(.XURET,12595)
 ;  >ZW XURET
 ;  >XURET="^TMP(""XUMVINPB"",17226)"
 ;
 ;  D ^%G would return:
 ;    ^TMP("XUMVINPB",17226,1)="200;IEN^DUZ^12596^12596"
 ;                          2)="200;.01^NAME^LAST,FIRST MIDDLE SUFFIX^LAST,FIRST MIDDLE SUFFIX"
 ;                          3)="200;.111^STREET ADDRESS 1^^STREET ADDRESS 1^STREET ADDRESS 1"
 ;                          4)="200;.112^STREET ADDRESS 2^^STREET ADDRESS 2^STREET ADDRESS 2"
 ;                          #)=continuation of returned data
 ;
 ; Example calling rpc from MVI:
 ;  D DIRECT^XWB2HL7(.XURET,SITE,"XUS MVI NEW PERSON BULK GET","",$G(XUDUZ))
 ;
 ;
 K XURET
 N I,CNT,FILE,FLD,FLDS,FLDNM,SUBFILE,SUBFLD,XUGBL
 ;
 S XUGBL="^TMP("_"""XUMVINPB"""_","_$J_")"
 K @XUGBL
 ;
 I '$D(XUDUZ) S XUDUZ=.5 ;skip over postmaster
 ;
 ;lets only get the labels once per bulk run
 S FILE=200
 S FLDS=".01;.111;.112;.113;.114;.115;.116;.132;.151;4;5;9;16*;10.1;205.2;205.3;205.4;501.1;41.99;53.2;747.44;201;203*;51*"
 F I=1:1:$L(FLDS,";") S FLD=$P($P(FLDS,";",I),"*") D
 .D FIELD^DID(FILE,FLD,"","LABEL","FLDNM(FILE,FLD)")
 .I FLD=16 S SUBFILE=200.02,SUBFLD=.01 D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM(SUBFILE,SUBFLD)") ;division multiple
 .I FLD=10.1 S SUBFILE=20 F SUBFLD=1,2,3,4,5,6 D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM(SUBFILE,SUBFLD)") ;name components
 .I FLD=51 S SUBFILE=200.051,SUBFLD=.01 D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM(SUBFILE,SUBFLD)") ;keys
 .I FLD=203 S SUBFILE=200.03,SUBFLD=.01 D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM(SUBFILE,SUBFLD)") ;secondary menu options multiple
 ;
 S CNT=1
 F  S XUDUZ=$O(^VA(200,XUDUZ)) Q:'XUDUZ  I $$ACTIVE(XUDUZ) D  Q  ;get next active new person
 .N XUARR
 .D GETS^DIQ(FILE,+XUDUZ_",",FLDS,"EI","XUARR") ;retrieve data
 .;
 .S @XUGBL@(CNT)=FILE_";IEN^DUZ^^"_XUDUZ_"^"_XUDUZ S CNT=CNT+1
 .;
 .F I=1:1:$L(FLDS,";") S FLD=$P($P(FLDS,";",I),"*") D
 ..I FLD=16 D  Q  ;division multiple
 ...N IENS,MCNT,SUBFILE,SUBFLD
 ...S MCNT=1,SUBFILE=200.02,SUBFLD=.01
 ...I '$D(XUARR(SUBFILE)) S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM(SUBFILE,SUBFLD,"LABEL"))_"^"_MCNT_"^^" S CNT=CNT+1 Q
 ...S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM(SUBFILE,SUBFLD,"LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")) S MCNT=MCNT+1,CNT=CNT+1
 ..;
 ..I FLD=10.1 D  Q  ;name components
 ...S @XUGBL@(CNT)=FILE_";"_FLD_"^"_(FLDNM(FILE,FLD,"LABEL"))_"^^"_$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_"^"_$G(XUARR(FILE,XUDUZ_",",FLD,"E")) S CNT=CNT+1
 ...N NCFILE,NCFLD
 ...S NCFILE=20
 ...D GETS^DIQ(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",","1;2;3;4;5;6","EI","XUARR") ;retrieve name component data
 ...F NCFLD=1,2,3,4,5,6 D
 ....S @XUGBL@(CNT)=NCFILE_";"_NCFLD_"^"_(FLDNM(NCFILE,NCFLD,"LABEL"))_"^^"_$G(XUARR(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",",NCFLD,"I"))_"^"_$G(XUARR(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",",NCFLD,"E")) S CNT=CNT+1
 ..;
 ..I FLD=51 D  Q  ;KEYS multiple
 ...N IENS,MCNT,SUBFILE,SUBFLD
 ...S MCNT=1,SUBFILE=200.051,SUBFLD=.01
 ...I '$D(XUARR(SUBFILE)) S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM(SUBFILE,SUBFLD,"LABEL"))_"^"_MCNT_"^^",CNT=CNT+1 Q
 ...S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM(SUBFILE,SUBFLD,"LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")),MCNT=MCNT+1,CNT=CNT+1
 ..;
 ..I FLD=203 D  Q  ;secondary menu options multiple
 ...N IENS,MCNT,SUBFILE,SUBFLD
 ...S MCNT=1,SUBFILE=200.03,SUBFLD=.01
 ...I '$D(XUARR(SUBFILE)) S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM(SUBFILE,SUBFLD,"LABEL"))_"^"_MCNT_"^^" S CNT=CNT+1 Q
 ...S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM(SUBFILE,SUBFLD,"LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")) S MCNT=MCNT+1,CNT=CNT+1
 ..;
 ..S @XUGBL@(CNT)=FILE_";"_FLD_"^"_(FLDNM(FILE,FLD,"LABEL"))_"^^"_$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_"^"_$G(XUARR(FILE,XUDUZ_",",FLD,"E")) S CNT=CNT+1 ;all other fields
 ;
 I 'XUDUZ S @XUGBL@(CNT)=FILE_";EOF^EOF^" ;end of file, no more new persons
 I '$D(@XUGBL) S @XUGBL@(CNT)="-1^No Data to Retrieve"
 ;
 S XURET=$NA(@XUGBL)
 Q
 ;
ACTIVE(XUDUZ) ;active person
 N FILE,FLDS,XUARR
 S FILE=200,FLDS="7;9.2;201" ;disuser; termination date; primary menu option
 D GETS^DIQ(FILE,+XUDUZ_",",FLDS,"EI","XUARR") ;retrieve data
 I $G(XUARR(FILE,+XUDUZ_",",7,"I"))'=1,($G(XUARR(FILE,+XUDUZ_",",9.2,"I"))=""!($G(XUARR(FILE,+XUDUZ_",",9.2,"I"))>DT)),($G(XUARR(FILE,+XUDUZ_",",201,"I"))'="") Q 1
 Q 0
 ;
