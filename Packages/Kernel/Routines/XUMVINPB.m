XUMVINPB ;MVI/DRI - Master Veteran Index New Person Bulk Pull RPC ;7/29/20  13:59
 ;;8.0;KERNEL;**710,725,733**;Jul 10, 1995;Build 1
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**710 - STORY_952862  (dri) new routine
 ;**725 - STORY_1238392 (dri) add fields 7, 8, 9.2, 29, 205.1, 205.5, 8910
 ;                      sort by Active, Disuser/Terminate, Visitor or All
 ;**733 - STORY 1291666 (dri) add field 101.13
 ;
 ;Reference to ^XWB2HL7 supported by IA #3144
 ;
 ;
 ; This functionality is called by option 'MPI BULK NEW PERSON DATA PULL'
 ; (^MPINPBLK) on the MPI.
 ;
BULKGET(XURET,XUDUZ,XUTYPE) ;rpc to retrieve bulk pull of new person file data
 ; 
 ; called from rpc: XUS MVI NEW PERSON BULK GET
 ;
 ; Input:
 ;  XUDUZ = NEW PERSON IEN TO BEGIN LOOPING ON
 ;  XUTYPE = TYPE OF EXTRACT ('A'ctive, 'D'isuser/Terminated, 'V'isitor or 'ALL')
 ;
 ; Output:
 ;  Success:
 ;   XURET = ^TMP("XUMVINPB",$J)
 ;    @XURET@(#) = FILE #;FIELD #<;SUBFIELD #><;FILE POINTER>^FIELD NAME^<COUNTER #>^INTERNAL VALUE^EXTERNAL VALUE
 ;      If Counter populated, denotes multiple value <1 to n>.
 ;      If multiple Subfield's, Internal and External Values will be sub-delimited by '~'.
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
 ;    @XURET@(#)="200;7^DISUSER^^^"
 ;    @XURET@(#)="200;8^TITLE^^^"
 ;    @XURET@(#)="200;9^SSN^^^"
 ;    @XURET@(#)="200;9.2^TERMINATION DATE^^^"
 ;    @XURET@(#)="200;16;.01^DIVISION^<1 to n>^^"
 ;    @XURET@(#)="200;10.1^NAME COMPONENTS^^^"
 ;    @XURET@(#)="20;1^FAMILY (LAST) NAME^^^"
 ;    @XURET@(#)="20;2^GIVEN (FIRST) NAME^^^"
 ;    @XURET@(#)="20;3^MIDDLE NAME^^^"
 ;    @XURET@(#)="20;4^PREFIX^^^"
 ;    @XURET@(#)="20;5^SUFFIX^^^"
 ;    @XURET@(#)="20;6^DEGREE^^^"
 ;    @XURET@(#)="200;29^SERVICE/SECTION^^^"
 ;    @XURET@(#)="200;205.1^SECID^^^"
 ;    @XURET@(#)="200;205.2^SUBJECT ORGANIZATION^^^"
 ;    @XURET@(#)="200;205.3^SUBJECT ORGANIZATION ID^^^"
 ;    @XURET@(#)="200;205.4^UNIQUE USER ID^^^"
 ;    @XURET@(#)="200;205.5^ADUPN^^^"
 ;    @XURET@(#)="200;501.1^NETWORK USERNAME^^^"
 ;    @XURET@(#)="200;41.99^NPI^^^"
 ;    @XURET@(#)="200;53.2^DEA#^^^"
 ;    @XURET@(#)="200;747.44^DEA EXPIRATION DATE^^^"
 ;    @XURET@(#)="200;201^PRIMARY MENU OPTION^^^"
 ;    @XURET@(#)="200;203;.01^SECONDARY MENU OPTIONS^<1 to n>^^"
 ;    @XURET@(#)="200;51;.01^KEY^<1 to n>^^"
 ;    @XURET@(#)="200;8910;.01~2^KEY^<1 to n>^~^~"
 ;    @XURET@(#)="200;8910;.01~2^VISITED FROM~DUZ AT HOME SITE^<1 to n)^~^~1"
 ;    @XURET@(#)="200;101.13;.01~.02~.03^CPRS TAB~EFFECTIVE DATE~EXPIRATION DATE^<1 to n>^~~^~~"
 ;
 ;    @XURET@(#)="200;EOF^EOF^" - if end of new person file reached
 ;
 ;  Fail:
 ;   XURET = ^TMP("XUMVINPB",$J)
 ;   @XURET@(1)="-1^No Data to Retrieve"
 ;
 ; Example calling rpc from VistA:
 ;  >D BULKGET^XUMVINPB(.XURET,12595,"A")
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
 ;  D DIRECT^XWB2HL7(.XURET,SITE,"XUS MVI NEW PERSON BULK GET","",$G(XUDUZ),$G(XUTYPE))
 ;
 ;
 K XURET
 N I,CNT,FILE,FLD,FLDS,FLDNM,LINETAG,RETURN,SFILE,SFLD,XUGBL
 ;
 S XUGBL="^TMP("_"""XUMVINPB"""_","_$J_")"
 K @XUGBL
 ;
 I '$D(XUDUZ) S XUDUZ=.9 ;skip over postmaster and shared mail
 S LINETAG=$$LINETAG() ;get line label for type of extract requested
 ;
 ;lets only get the labels once per bulk run
 S FILE=200
 S FLDS=".01;.111;.112;.113;.114;.115;.116;.132;.151;4;5;7;8;9;9.2;16*;10.1;29;205.1;205.2;205.3;205.4;205.5;501.1;41.99;53.2;747.44;201;203*;51*;8910*;101.13*"
 F I=1:1:$L(FLDS,";") S FLD=$P($P(FLDS,";",I),"*") D
 .D FIELD^DID(FILE,FLD,"","LABEL","FLDNM(FILE,FLD)")
 .I FLD=16 S SFILE=200.02,SFLD=.01 D FIELD^DID(SFILE,SFLD,"","LABEL","FLDNM(SFILE,SFLD)") ;division multiple
 .I FLD=10.1 S SFILE=20 F SFLD=1,2,3,4,5,6 D FIELD^DID(SFILE,SFLD,"","LABEL","FLDNM(SFILE,SFLD)") ;name components
 .I FLD=51 S SFILE=200.051,SFLD=.01 D FIELD^DID(SFILE,SFLD,"","LABEL","FLDNM(SFILE,SFLD)") ;keys
 .I FLD=101.13 S SFILE=200.010113 F SFLD=.01,.02,.03 D FIELD^DID(SFILE,SFLD,"","LABEL","FLDNM(SFILE,SFLD)") ;cprs tab multiple
 .I FLD=203 S SFILE=200.03,SFLD=.01 D FIELD^DID(SFILE,SFLD,"","LABEL","FLDNM(SFILE,SFLD)") ;secondary menu options multiple
 .I FLD=8910 S SFILE=200.06 F SFLD=.01,2 D FIELD^DID(SFILE,SFLD,"","LABEL","FLDNM(SFILE,SFLD)") ;visited from multiple
 ;
 S CNT=1
 F  S XUDUZ=$O(^VA(200,XUDUZ)) Q:'XUDUZ  D @(LINETAG_"(.RETURN,"_XUDUZ_")") I RETURN D  Q  ;get next new person for type of extract
 .N XUARR
 .D GETS^DIQ(FILE,+XUDUZ_",",FLDS,"EI","XUARR") ;retrieve data
 .;
 .S @XUGBL@(CNT)=FILE_";IEN^DUZ^^"_XUDUZ_"^"_XUDUZ S CNT=CNT+1
 .;
 .F I=1:1:$L(FLDS,";") S FLD=$P($P(FLDS,";",I),"*") D
 ..I $S(FLD=16:1,FLD=51:1,FLD=203:1,1:0) D  Q  ;division, keys, secondary menu options multiple
 ...N IENS,MCNT,SFILE,SFLD
 ...S MCNT=1,SFILE=$S(FLD=16:200.02,FLD=51:200.051,FLD=203:200.03),SFLD=.01
 ...I '$D(XUARR(SFILE)) S @XUGBL@(CNT)=FILE_";"_FLD_";"_SFLD_"^"_$G(FLDNM(SFILE,SFLD,"LABEL"))_"^"_MCNT_"^^" S CNT=CNT+1 Q
 ...S IENS="" F  S IENS=$O(XUARR(SFILE,IENS)) Q:IENS=""  S @XUGBL@(CNT)=FILE_";"_FLD_";"_SFLD_"^"_$G(FLDNM(SFILE,SFLD,"LABEL"))_"^"_MCNT_"^"_$G(XUARR(SFILE,IENS,SFLD,"I"))_"^"_$G(XUARR(SFILE,IENS,SFLD,"E")) S MCNT=MCNT+1,CNT=CNT+1
 ..;
 ..I FLD=10.1 D  Q  ;name components
 ...S @XUGBL@(CNT)=FILE_";"_FLD_"^"_$G(FLDNM(FILE,FLD,"LABEL"))_"^^"_$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_"^"_$G(XUARR(FILE,XUDUZ_",",FLD,"E")) S CNT=CNT+1
 ...N NCFILE,NCFLD
 ...S NCFILE=20
 ...D GETS^DIQ(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",","1;2;3;4;5;6","EI","XUARR") ;retrieve name component data
 ...F NCFLD=1,2,3,4,5,6 D
 ....S @XUGBL@(CNT)=NCFILE_";"_NCFLD_"^"_$G(FLDNM(NCFILE,NCFLD,"LABEL"))_"^^"_$G(XUARR(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",",NCFLD,"I"))_"^"_$G(XUARR(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",",NCFLD,"E")) S CNT=CNT+1
 ..;
 ..I FLD=101.13 D  Q  ;cprs tab multiple
 ...N IENS,MCNT,SFILE,SFLD,SFLD2,SFLD3
 ...S MCNT=1,SFILE=200.010113,SFLD=.01,SFLD2=.02,SFLD3=.03
 ...I '$D(XUARR(SFILE)) S @XUGBL@(CNT)=FILE_";"_FLD_";"_SFLD_"~"_SFLD2_"~"_SFLD3_"^"_$G(FLDNM(SFILE,SFLD,"LABEL"))_"~"_$G(FLDNM(SFILE,SFLD2,"LABEL"))_"~"_$G(FLDNM(SFILE,SFLD3,"LABEL"))_"^"_MCNT_"^~~^~~",CNT=CNT+1 Q
 ...S IENS="" F  S IENS=$O(XUARR(SFILE,IENS)) Q:IENS=""  D
 ....S @XUGBL@(CNT)=FILE_";"_FLD_";"_SFLD_"~"_SFLD2_"~"_SFLD3_"^"_$G(FLDNM(SFILE,SFLD,"LABEL"))_"~"_$G(FLDNM(SFILE,SFLD2,"LABEL"))_"~"_$G(FLDNM(SFILE,SFLD3,"LABEL"))
 ....S @XUGBL@(CNT)=@XUGBL@(CNT)_"^"_MCNT_"^"_$G(XUARR(SFILE,IENS,SFLD,"I"))_"~"_$G(XUARR(SFILE,IENS,SFLD2,"I"))_"~"_$G(XUARR(SFILE,IENS,SFLD3,"I"))
 ....S @XUGBL@(CNT)=@XUGBL@(CNT)_"^"_$G(XUARR(SFILE,IENS,SFLD,"E"))_"~"_$G(XUARR(SFILE,IENS,SFLD2,"E"))_"~"_$G(XUARR(SFILE,IENS,SFLD3,"E")),MCNT=MCNT+1,CNT=CNT+1
 ..;
 ..I FLD=8910 D  Q  ;visited from multiple
 ...N IENS,MCNT,SFILE,SFLD,SFLD2
 ...S MCNT=1,SFILE=200.06,SFLD=.01,SFLD2=2
 ...I '$D(XUARR(SFILE)) S @XUGBL@(CNT)=FILE_";"_FLD_";"_SFLD_"~"_SFLD2_"^"_$G(FLDNM(SFILE,SFLD,"LABEL"))_"~"_$G(FLDNM(SFILE,SFLD2,"LABEL"))_"^"_MCNT_"^~^~",CNT=CNT+1 Q
 ...S IENS="" F  S IENS=$O(XUARR(SFILE,IENS)) Q:IENS=""  D
 ....S @XUGBL@(CNT)=FILE_";"_FLD_";"_SFLD_"~"_SFLD2_"^"_$G(FLDNM(SFILE,SFLD,"LABEL"))_"~"_$G(FLDNM(SFILE,SFLD2,"LABEL"))
 ....S @XUGBL@(CNT)=@XUGBL@(CNT)_"^"_MCNT_"^"_$G(XUARR(SFILE,IENS,SFLD,"I"))_"~"_$G(XUARR(SFILE,IENS,SFLD2,"I"))_"^"_$G(XUARR(SFILE,IENS,SFLD,"E"))_"~"_$G(XUARR(SFILE,IENS,SFLD2,"E")),MCNT=MCNT+1,CNT=CNT+1
 ..;
 ..S @XUGBL@(CNT)=FILE_";"_FLD_"^"_$G(FLDNM(FILE,FLD,"LABEL"))_"^^"_$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_"^"_$G(XUARR(FILE,XUDUZ_",",FLD,"E")) S CNT=CNT+1 ;all other fields
 ;
 I 'XUDUZ S @XUGBL@(CNT)=FILE_";EOF^EOF^" ;end of file, no more new persons
 I '$D(@XUGBL) S @XUGBL@(CNT)="-1^No Data to Retrieve"
 ;
 S XURET=$NA(@XUGBL)
 Q
 ;
LINETAG() ;return line tag for type of extract requested
 Q $S(XUTYPE="A":"ACTIVE",XUTYPE="D":"DISTERM",XUTYPE="V":"VISITOR",XUTYPE="ALL":"ALL",1:"UNKNOWN")
 ;
ACTIVE(RETURN,XUDUZ) ;person is not disuser'd, not terminated, has primary menu option
 N FILE,FLDS,XUARR
 K RETURN
 S RETURN=0
 S FILE=200,FLDS="7;9.2;201" ;disuser; termination date; primary menu option
 D GETS^DIQ(FILE,+XUDUZ_",",FLDS,"EI","XUARR") ;retrieve data
 I $G(XUARR(FILE,+XUDUZ_",",7,"I"))'=1,($G(XUARR(FILE,+XUDUZ_",",9.2,"I"))=""!($G(XUARR(FILE,+XUDUZ_",",9.2,"I"))>DT)),($G(XUARR(FILE,+XUDUZ_",",201,"I"))'="") S RETURN=1 Q
 Q
 ;
DISTERM(RETURN,XUDUZ) ;person is disuser'd or terminated
 N FILE,FLDS,XUARR
 K RETURN
 S RETURN=0
 S FILE=200,FLDS="7;9.2" ;disuser; termination date
 D GETS^DIQ(FILE,+XUDUZ_",",FLDS,"EI","XUARR") ;retrieve data
 I $S($G(XUARR(FILE,+XUDUZ_",",7,"I"))=1:1,($G(XUARR(FILE,+XUDUZ_",",9.2,"I"))'=""&($G(XUARR(FILE,+XUDUZ_",",9.2,"I"))'>DT)):1,1:0) S RETURN=1 Q
 Q
 ;
VISITOR(RETURN,XUDUZ) ;person has visitor records
 K RETURN
 S RETURN=0
 ;I $O(^VA(200,XUDUZ,8910,0)),$P($G(^VA(200,XUDUZ,201)),"^",1)'="" S RETURN=1 Q  ;must have visitor records and a primary menu option (currently not utilized)
 I $O(^VA(200,XUDUZ,8910,0)) S RETURN=1 Q
 Q
ALL(RETURN,XUDUZ) ;retrieve all persons
 K RETURN
 S RETURN=0
 I XUDUZ S RETURN=1
 Q
 ;
