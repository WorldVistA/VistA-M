DGRRLU6 ;alb/aas - DG Replacement and Rehosting RPC for VADPT ; Jan-7-2003  ; 9/2/08 2:11pm
 ;;5.3;Registration;**538,786**;Aug 13, 1993;Build 21
 ;
 ; CALLED BY DGRRLU LINE:
 ; IF (SEARCH="NAME"),($G(PARAMS("VERSION 2"))'="") DO BYNAME^DGRRLU6 ; sgg 05/06/04
 ;
 ;
 ;
BYNAME ; (VALUE)
 NEW FULLCNT,DGRRPCNT,DGRR,NODE,DFN,XREF,DIERR
 ;
 IF SEARCH="NAME" SET XREF="B" IF VALUE[", " SET VALUE=$P(VALUE,", ")_","_$P(VALUE,", ",2) ;REMOVE FIRST SPACE
 IF SEARCH="SSN" SET XREF="SSN",VALUE=$TR(VALUE," -","") ; REMOVE DASHES AND SPACES
 IF SEARCH="SSN4" SET XREF="BS5" IF $L(VALUE)>5 SET VALUE=$E(VALUE,1,5) ; can't exceed 5 characters, if P for psuedo on end take it off.
 IF SEARCH="ICN" SET XREF="AICN" SET VALUE=$P(VALUE,"V",1)
 ;
 NEW SGGCOUNT,IEN,QUITFLG,PP,CNTLINE,OVERMAX,MAXMSG,RCLINE,LIMIT,GLOB
 ;
 IF VALUE="" DO  QUIT
 . DO ADD("<record count='0'>")
 . DO ADD("<maximum message=''></maximum>")
 . DO ADD("<error message='Not Enough Information Provided to Search for Patients.  Search Type = """_SEARCH_"""  Search For = """_VALUE_"""'></error>")
 ;
 SET DGRRLINE=DGRRLINE+1,RCLINE=DGRRLINE
 S SGGCOUNT=0,PP=$O(^DPT("B",VALUE),-1),IEN=""
 S LIMIT=MAXSIZE,OVERMAX=0
 SET QUITFLG=0
 F  S PP=$O(^DPT("B",PP)) Q:PP=""  DO  QUIT:QUITFLG
 .IF ($E(PP,1,$L(VALUE))'=VALUE) SET QUITFLG=1 QUIT
 .IF ((LIMIT'="")&(SGGCOUNT+1>LIMIT)) SET QUITFLG=1,OVERMAX=1 QUIT
 .IF $D(^XTMP("DGRRLU",JOB,1)) S QUITFLG=1,CANCEL=1  ; ****
 .IF ($$STOP^XOBVLIB()) SET QUITFLG=1 QUIT
 .F  S IEN=$O(^DPT("B",PP,IEN)) Q:IEN=""  D
 ..S GLOB(0)=$G(^DPT(IEN,0))
 ..;S ^TMP($J,"NAME",IEN)=$P(^DPT(IEN,0),"^",1)
 ..D PTDATA(IEN,SGGCOUNT)
 ..S SGGCOUNT=SGGCOUNT+1
 IF CANCEL=1 QUIT  ; ****
 ;
 SET MAXMSG="" IF +$G(OVERMAX) SET MAXMSG="Too many patients found (more than "_LIMIT_").  Please Limit Search."
 DO ADD("<maximum message='"_MAXMSG_"'></maximum>")
 DO ADD("<error message=''></error>")
 ;
 SET @DGRRESLT@(RCLINE)=("<record count='"_SGGCOUNT_"'>")
 QUIT
 ;
PTDATA(DFN,DGRRPCNT) ;
 NEW I,DONE,LINE,ALIAS,NAME,PTNAME,DOB,SSN,TYPE,GENDER,ICN,PRIM,SC,SCPER,VET,WARD,ROOMBED,SENSITIV,DGEMP,PCPIEN,PCPVPID,PCPNAME,PATSPCP
 IF DGRRPCNT>(MAXSIZE-1) DO MAXOUT QUIT
 ;IF (MSCREEN'="") X MSCREEN I '$T Q
 SET DGRRPCNT=DGRRPCNT+1
 SET LINE="<patient number='"_DGRRPCNT_"' dfn='"_DFN_"'"
 ;
 SET PTNAME=$P(^DPT(DFN,0),"^",1)
 IF SEARCH="NAME",FILTER="" IF $E(PTNAME,1,$L(VALUE))'=VALUE DO
 . SET (I,DONE)=0
 . SET ALIAS=""
 . FOR  S I=$O(^DPT(DFN,.01,I)) Q:I<1  Q:DONE  DO
 .. SET ALIAS=$P($G(^DPT(DFN,.01,I,0)),"^",1)
 .. IF $E(ALIAS,1,$L(VALUE))=VALUE SET PTNAME="("_ALIAS_")  "_PTNAME,DONE=1
 . IF DONE=0 SET PTNAME="(Unknown Alias)  "_PTNAME
 ; -- REQUIRED COMPONENTS
 ;SENSITIV will be set to true to block the display of the SSN and DOB 
 ;if patient is marked as sensitive in DG Security Log (#38.1) file or 
 ;has an employee eligibility code
 SET SENSITIV=$S($P($G(^DGSL(38.1,DFN,0)),"^",2)=1:"true",1:"false")
 I SENSITIV="false" D
 .S DGEMP=$$EMPL^DGSEC4(DFN)
 .I DGEMP=1 S SENSITIV="true"
 SET NAME=$$CHARCHK^DGRRUTL(PTNAME)
 SET DOB=$$CHARCHK^DGRRUTL($P($G(^DPT(DFN,0)),"^",3))
 SET SSN=$$CHARCHK^DGRRUTL($P($G(^DPT(DFN,0)),"^",9))
 SET LINE=LINE_" sensitive='"_SENSITIV_"' name='"_NAME_"' dob='"_DOB_"' ssn='"_SSN_"' "
 ; -- OPTIONAL COMPONENTS
 ;Patient Type (391)
 SET TYPE=$$CHARCHK^DGRRUTL($P($G(^DG(391,+$G(^DPT(DFN,"TYPE")),0)),"^",1))
 ;
 ;gender
 SET GENDER=$$CHARCHK^DGRRUTL($P($G(^DPT(DFN,0)),"^",2))
 ;
 ;icn
 SET ICN=$$ICNLC^MPIF001(DFN)
 ;
 ;Primary Eligibility(.361)
 SET PRIM=$$PRIM(DFN)
 ;
 SET SC=$P($G(^DPT(DFN,.3)),"^",1,2) ;Is Service Connected (.301) %=.302
 SET SCPER=$P(SC,"^",2)
 IF $P(SC,"^",1)="Y" SET SC="true"
 IF $P(SC,"^",1)="N" SET SC="false"
 ;
 SET VET=$P($G(^DPT(DFN,"VET")),"^",1) ;Veteran Status (1901)
 IF VET="Y" SET VET="true"
 IF VET="N" SET VET="false"
 ;
 SET WARD=$$CHARCHK^DGRRUTL($E($G(^DPT(DFN,.1)),1,30))
 SET ROOMBED=$$CHARCHK^DGRRUTL($P($G(^DPT(DFN,.101)),"^",1))
 ;
 ; get the PCP's IEN and convert to VPID (primary care physician)  sgg 06/17/04
 SET PATSPCP=$$NMPCPR^SCAPMCU2(DFN,DT,1)
 SET PCPIEN=$P(PATSPCP,"^",1)
 SET PCPNAME=$$CHARCHK^DGRRUTL($P(PATSPCP,"^",2)) ;786
 SET PCPVPID=$$VPID^XUPS(+PCPIEN)
 ;
 SET LINE=LINE_" type='"_TYPE_"' primaryeligibility='"_PRIM_"' serviceconnected='"_SC_"' scpercent='"_SCPER_"'"
 SET LINE=LINE_" gender='"_GENDER_"' icn='"_ICN_"' veteran='"_VET_"' ward='"_WARD_"' roombed='"_ROOMBED_"'"
 SET LINE=LINE_" pcpien='"_PCPIEN_"' pcpvpid='"_PCPVPID_"' pcpname='"_PCPNAME_"'></patient>"
 ;
 DO ADD(LINE)
 DO NAMECOMP^DGRRLU0(DFN,DGRRPCNT)
 ;
 QUIT
 ;
MAXOUT ;
 IF $G(MAXSIZRE)<1 DO ADD("<maximum message='Too many patients found (more than "_MAXSIZE_").  Please Limit Search.'></maximum>")
 SET MAXSIZRE=1
 QUIT
 ;
PRIM(DFN) ; -- returns print name from file 8.1
 NEW PRIM1
 SET PRIM1=$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),"^",9) ; station entry
 Q $$CHARCHK^DGRRUTL($P($G(^DIC(8.1,+PRIM1,0)),"^",6)) ; mas entry
 ;
ADD(STR) ; -- add string to array
 SET DGRRLINE=DGRRLINE+1
 SET @DGRRESLT@(DGRRLINE)=STR
 QUIT
 ;
TEST(XSTRING,XNUMBER,DISPLAY) ;
 ; ZL DGRRLU6 D TEST("SMITH",100,1)
 ; DO THE OLD CODE
 N RESULT,PARAMS,AAA,BBB
 SET PARAMS("SEARCH_VALUE")=XSTRING
 SET PARAMS("SEARCH_TYPE")="NAME"
 SET PARAMS("MAX_PATIENTS")=+XNUMBER
 SET PARAMS("VERSION 1")="OLD CODE"
 D SEARCH^DGRRLU(.RESULT,.PARAMS)
 D RESTOT(.RESULT,.AAA)
 IF +$G(DISPLAY) D DISPLAY(.RESULT)
 ; DO THE NEW CODE
 N RESULT,PARAMS
 K PARAMS
 SET PARAMS("SEARCH_VALUE")=XSTRING
 SET PARAMS("SEARCH_TYPE")="NAME"
 SET PARAMS("MAX_PATIENTS")=+XNUMBER
 D SEARCH^DGRRLU(.RESULT,.PARAMS)
 IF +$G(DISPLAY) D DISPLAY(.RESULT)
 D RESTOT(.RESULT,.BBB)
 ;
 ;IF AAA=BBB W !!!,"NO MISMATCH"
 ;IF AAA'=BBB W !!!,"RESULT MISMATCH" DO
 ;.W !!!,"AAA>",AAA
 ;.W !!!,"BBB>",BBB
 ;.F I=1:1 Q:($E(AAA,I,I+4)="[EOF]")  I $E(AAA,I)'=$E(BBB,I) W !,I,"[A",I,"] ",$E(AAA,I),?10,"[B",I,"] ",$E(BBB,I)
 ;
 QUIT
 ;
DISPLAY(RESULT) ;
 NEW I
 S I=-1 FOR  SET I=$O(@RESULT@(I)) Q:I<1  W !!,@RESULT@(I)
 QUIT
 ;
RESTOT(RESULT,OUT) ;
 NEW I
 S OUT="",I=-1 FOR  SET I=$O(@RESULT@(I)) Q:I<1  S OUT(I)=@RESULT@(I)
 QUIT
