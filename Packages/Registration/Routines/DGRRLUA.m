DGRRLUA ;alb/aas - Person Service Lookup gather patient data;2/15/2005 ; 9/2/08 12:09pm
 ;;5.3;Registration;**538,786**;Aug 13, 1993;Build 21
 ;
 ;DGRRLUA created when DGRRLU exceeded maximum routine size
 ;
PTDATA(DFN,DGRRPCNT)    ;
 NEW I,DONE,LINE,ALIAS,NAME,PTNAME,DOB,SSN,TYPE,GENDER,ICN,PRIM,SC,SCPER,VET,WARD,ROOMBED,SENSITIV,DGEMP,PATSPCP,PCPIEN,PCPVPID,PCPNAME
 IF DGRRPCNT>(MAXSIZE-1) DO MAXOUT QUIT
 ;IF (MSCREEN'="") X MSCREEN I '$T Q
 SET DGRRPCNT=DGRRPCNT+1
 SET LINE="<patient number='"_DGRRPCNT_"' dfn='"_DFN_"'"
 ;
 SET PTNAME=$P(^DPT(DFN,0),"^",1)
 IF SEARCH="NAME",FILTER="" IF $P($G(DGRRCA),"^")=1 DO
 .I $O(^DPT(DFN,.01,0)) D
 .. SET (I,DONE)=0
 .. SET ALIAS=""
 .. FOR  S I=$O(^DPT(DFN,.01,I)) Q:I<1  Q:DONE  DO
 ... SET ALIAS=$P($G(^DPT(DFN,.01,I,0)),"^",1)
 ... IF ALIAS=$P(DGRRCA,"^",2) SET PTNAME="("_ALIAS_")  "_PTNAME,DONE=1
 .. IF DONE=0 SET PTNAME="(Unknown Alias)  "_PTNAME
 ;
 ;IF SEARCH="NAME",FILTER="" IF $E(PTNAME,1,$L(VALUE))'=VALUE DO
 ;. SET (I,DONE)=0
 ;. SET ALIAS=""
 ;. FOR  S I=$O(^DPT(DFN,.01,I)) Q:I<1  Q:DONE  DO
 ;.. SET ALIAS=$P($G(^DPT(DFN,.01,I,0)),"^",1)
 ;.. IF $E(ALIAS,1,$L(VALUE))=VALUE SET PTNAME="("_ALIAS_")  "_PTNAME,DONE=1
 ;. IF DONE=0 SET PTNAME="(Unknown Alias)  "_PTNAME
 ;
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
 ;
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
 SET PCPNAME=$$CHARCHK^DGRRUTL($P(PATSPCP,"^",2))
 SET PCPVPID=$$VPID^XUPS(+PCPIEN)
 ;
 SET LINE=LINE_" type='"_TYPE_"' primaryeligibility='"_PRIM_"' serviceconnected='"_SC_"' scpercent='"_SCPER_"'"
 SET LINE=LINE_" gender='"_GENDER_"' icn='"_ICN_"' veteran='"_VET_"' ward='"_WARD_"' roombed='"_ROOMBED_"'"
 SET LINE=LINE_" pcpien='"_PCPIEN_"' pcpvpid='"_PCPVPID_"' pcpname='"_PCPNAME_"'>"
 I +$G(DGRRAPTS)=0 S LINE=LINE_"</patient>"
 ;
 DO ADD^DGRRUTL(LINE)
 ;
 DO NAMECOMP^DGRRLU0(DFN,DGRRPCNT)
 ;
 QUIT
 ;
MAXOUT  ;
 IF $G(MAXSIZRE)<1 DO ADD^DGRRUTL("<maximum message='Too many patients found (more than "_MAXSIZE_").  Please Limit Search.'></maximum>")
 SET MAXSIZRE=1
 QUIT
 ;
PRIM(DFN)       ; -- returns print name from file 8.1
 NEW PRIM1
 SET PRIM1=$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),"^",9) ; station entry
 Q $$CHARCHK^DGRRUTL($P($G(^DIC(8.1,+PRIM1,0)),"^",6)) ; mas entry
