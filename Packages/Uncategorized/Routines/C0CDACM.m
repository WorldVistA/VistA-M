C0CDACM ; GPL - Patient Portal - CCDA Mapping Routines ;11/22/13  17:05
 ;;0.1;JJOHPP;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 Q
 ;
MAPG() ; 
 Q "^C0CDAcodeMap" ; mapping global
 ;
GETMAP(RTN,MAP,VALUE,DEFAULT) ; extrinsic returns array of mapped values
 ; RTN is passed by reference MAP and VALUE are passed by value
 ; if DEFAULT is 1, a default value will be returned on VALUE not found
 ; calling with no MAP and no VALUE will return a list of maps
 ; calling with MAP but no VALUE will return the entire map .
 I '$D(@$$MAPG) D INIT
 I $G(MAP)="" D  Q 1 ; return a list of all maps
 . N ZI S ZI=""
 . N GM S GM=$$MAPG
 . F  S ZI=$O(@GM@(ZI)) Q:ZI=""  D  ;
 . . S RTN(ZI)=""
 I $G(VALUE)="" I $D(@$$MAPG@(MAP)) D  Q 1 ; map exists, no value - return entire map
 . M RTN=@$$MAPG@(MAP)
 I $G(VALUE)="" Q 0 ; map doesn't exist.. fail
 I $D(@$$MAPG@(MAP,VALUE)) D  Q 1 ; value found
 . M RTN=@$$MAPG@(MAP,VALUE) 
 I $G(DEFAULT)'=1 Q 0 ; default not requested
 I $D(@$$MAPG@(MAP,"DEFAULT")) D  Q 1 ; default found
 . M RTN=@$$MAPG@(MAP,"DEFAULT")
 Q 0 
 ;
INIT ; initialize maps
 D SETLOCM
 Q
 ;
SETLOCM ; set location map
 N MAP S MAP="getLocationCode"
 K @$$MAPG@(MAP)
 S @$$MAPG@(MAP,"IMP","code")="1060-1"
 S @$$MAPG@(MAP,"IMP","text")="Inpatient medical ward"
 S @$$MAPG@(MAP,"AMB","code")="1141-1"
 S @$$MAPG@(MAP,"AMB","text")="Provider's office"
 S @$$MAPG@(MAP,"DEFAULT","code")="1141-1"
 S @$$MAPG@(MAP,"DEFAULT","text")="Provider's office"
 Q
 ;
REACTION ; import Allergy Reactions mapping table
 N ZDIR,ZFNAME
 I '$$GETDIR(.ZDIR) Q  ;
 I '$$GETFN(.ZFNAME,"allergy-reactions-VA-SNOMED-mapping-table-R40.csv") Q  ;
 W !,"DIR ",ZDIR," FNAME ",ZFNAME
 N GN S GN=$NA(^XTMP("KBAIREAC","CSV"))
 K @GN ; CLEAR THE AREA
 N GN1 S GN1=$NA(@GN@(1)) ; PLACE TO PUT THE CSV FILE
 W !,"READING IN FILE ",ZFNAME," FROM DIRECTORY ",ZDIR
 Q:$$FTG^%ZISH(ZDIR,ZFNAME,GN1,3)=""
 N ZI S ZI=1
 N GMAP S GMAP=$$MAPG() ; global maap
 K @GMAP@("reaction")
 S @GMAP@("B","reaction","reaction")=""
 F  S ZI=$O(@GN@(ZI)) Q:ZI=""  D  ;
 . N GR,VUID,VNAME,SNOMED,SNOTXT,PREF,ZV
 . S ZV=@GN@(ZI)
 . S VUID=$P(ZV,"|",1)
 . S VNAME=$P(ZV,"|",2)
 . W:$G(DEBUG) !,"VISTA NAME: ",VNAME
 . S SNOMED=$P(ZV,"|",3)
 . S SNOTXT=$P(ZV,"|",4)
 . S PREF=$P(ZV,"|",5)
 . I $L(ZV,"|")'=5 D  B  ;
 . . W !,"ERROR, MALFORMED ENTRY",!,ZV
 . I VNAME["|" D  B  ;
 . . W !,"ERROR, MALFORMED ENTRY",!,ZV," ",VNAME
 . Q:VNAME=""
 . S GR("vuid")=VUID
 . S GR("vname")=VNAME
 . S GR("snomedCode")=SNOMED
 . S GR("snomedText")=SNOTXT
 . S GR("preferred")=PREF
 . ;I VNAME["ITCHING," ZWR GR
 . M @GMAP@("reaction",VNAME)=GR
 . S @GMAP@("reaction","VUID",VUID,VNAME)=""
 . S @GMAP@("reaction","B",VNAME,VNAME)=""
 Q
 ;
IMPORTVS ; import HL7 valuesets
 N ZDIR,ZFNAME
 I '$$GETDIR(.ZDIR) Q  ;
 I '$$GETFN(.ZFNAME,"index.csv") Q  ;
 W !,"DIR ",ZDIR," FNAME ",ZFNAME
 N GN S GN=$NA(^XTMP("KBAIVADS","INDEX"))
 K @GN ; CLEAR THE AREA
 N GN1 S GN1=$NA(@GN@(1)) ; PLACE TO PUT THE XML FILE
 W !,"READING IN FILE ",ZFNAME," FROM DIRECTORY ",ZDIR
 Q:$$FTG^%ZISH(ZDIR,ZFNAME,GN1,3)=""
 N ZI S ZI=1
 F  S ZI=$O(@GN@(ZI)) Q:ZI=""  D  ;
 . N NAME,OID,VSVER,VSDT,VSFN
 . S NAME=$P(@GN@(ZI),"~",1)
 . S OID=$P(@GN@(ZI),"~",2)
 . S VSVER=$P(@GN@(ZI),"~",3)
 . S VSDT=$P(@GN@(ZI),"~",4)
 . S VSFN=$P(@GN@(ZI),"~",5)
 . D IMPONE(NAME,OID,ZDIR,VSFN)
 Q
 ;
IMPONE(NAME,OID,ZDIR,VSFN) ; import one valueset
 N MAP S MAP=$$MAPG()
 N GTMP S GTMP=$NA(^TMP("KBAIVADS",$J))
 K @GTMP
 N GTMP1 S GTMP1=$NA(@GTMP@(1))
 W !,"READING IN FILE ",VSFN," FROM DIRECTORY ",ZDIR
 Q:$$FTG^%ZISH(ZDIR,VSFN,GTMP1,3)=""
 K @MAP@(OID)
 N ZZI S ZZI=1
 F  S ZZI=$O(@GTMP@(ZZI)) Q:ZZI=""  D  ;
 . N VSNAME,VSOID,VSVER,CODE,CODENAME,PREFNAME,ALTCODE,HL7ID,SYSOID,SYSNAME,VSDT
 . S VSNAME=$P(@GTMP@(ZZI),"~",1)
 . S VSOID=$P(@GTMP@(ZZI),"~",2)
 . S VSVER=$P(@GTMP@(ZZI),"~",3)
 . S CODE=$P(@GTMP@(ZZI),"~",4)
 . S CODENAME=$P(@GTMP@(ZZI),"~",5)
 . S PREFNAME=$P(@GTMP@(ZZI),"~",6)
 . S ALTCODE=$P(@GTMP@(ZZI),"~",7)
 . S HL7ID=$P(@GTMP@(ZZI),"~",8)
 . S SYSOID=$P(@GTMP@(ZZI),"~",9)
 . S SYSNAME=$P(@GTMP@(ZZI),"~",10)
 . S VSDT=$P(@GTMP@(ZZI),"~",11)
 . W:$G(DEBUG) !,"VSNAME ",VSNAME," VSOID ",VSOID," VSVER ",VSVER," CODE ",CODE," CODENAME ",CODENAME," PREFNAME ",PREFNAME," ALTCODE ",ALTCODE," HL7ID ",HL7ID," SYSOID ",SYSOID," SYSNAME ",SYSNAME," VSDT ",VSDT
 . ;W !,@GTMP@(ZZI)
 . N GR
 . S GR("vsName")=VSNAME
 . S GR("oid")=VSOID
 . S GR("vsVersion")=VSVER
 . S GR("code")=CODE
 . S GR("name")=CODENAME
 . S GR("prefName")=PREFNAME
 . S GR("altCode")=ALTCODE
 . S GR("hl7id")=HL7ID
 . S GR("sysOid")=SYSOID
 . S GR("sysName")=SYSNAME
 . S GR("vsDate")=VSDT
 . M @MAP@(OID,CODE)=GR
 . S @MAP@("B",VSNAME,OID)=""
 . S @MAP@(OID,"B",$E(CODENAME,1,30),CODE)=""
 . D FILE(.GR) ; update the fileman file
 Q
 ;
CODEFN() ; EXTRINSIC RETURNS THE CODE FILE FILE NUMBER
 Q 8402116.101
 ;
SUBFN() ; code subfile number
 Q 8402116.1011
 ;
FILE(GR) ; file a code
 N JJOHFDA,FN,SFN
 S FN=$$CODEFN()
 S SFN=$$SUBFN()
 S JJOHFDA(FN,"?+1,",.01)=GR("vsName")
 S JJOHFDA(FN,"?+1,",.02)=GR("oid")
 S JJOHFDA(FN,"?+1,",.1)=GR("vsVersion")
 S JJOHFDA(FN,"?+1,",.2)=GR("vsDate")
 S JJOHFDA(SFN,"?+2,?+1,",.01)=GR("code")
 S JJOHFDA(SFN,"?+2,?+1,",.02)=$TR(GR("name"),"^")
 S JJOHFDA(SFN,"?+2,?+1,",.03)=$TR(GR("prefName"),"^")
 S JJOHFDA(SFN,"?+2,?+1,",.04)=GR("altCode")
 S JJOHFDA(SFN,"?+2,?+1,",.05)=GR("hl7id")
 S JJOHFDA(SFN,"?+2,?+1,",.06)=GR("sysOid")
 S JJOHFDA(SFN,"?+2,?+1,",.07)=GR("sysName")
 D UPDIE(.JJOHFDA) ; 
 ;;   File fields:
 ;;  .01          VALUE SET NAME
 ;;  .02          OID
 ;;  .1           VERSION
 ;;  .2           DATE
 ;;  1            CODE  (multiple)
 ;;   Code Subfile fields:
 ;;  .01          CODE VALUE
 ;;  .02          CODE NAME
 ;;  .03          PREFERED NAME
 ;;  .04          ALT CODE
 ;;  .05          HL7 ID
 ;;  .06          CODE SYSTEM OID
 ;;  .07          CODE SYSTEM NAME
 Q
 ;         
GETDIR(KBAIDIR,KBAIDEF) ; EXTRINSIC WHICH PROMPTS FOR DIRECTORY
 ; RETURNS TRUE IF THE USER GAVE VALUES
 S DIR(0)="F^3:240"
 S DIR("A")="FILE DIRECTORY"
 I '$D(KBAIDEF) S KBAIDEF="/home/vista/ccda/trunk/oids/"
 S DIR("B")=KBAIDEF
 D ^DIR
 I Y="^" Q 0 ;
 S KBAIDIR=Y
 Q 1
 ;
GETFN(KBAIFN,KBAIDEF) ; EXTRINSIC WHICH PROMPTS FOR FILENAME
 ; RETURNS TRUE IF THE USER GAVE VALUES
 S DIR(0)="F^3:240"
 S DIR("A")="FILE NAME"
 I '$D(KBAIDEF) S KBAIDEF="index.csv"
 S DIR("B")=KBAIDEF
 D ^DIR
 I Y="" Q 0 ;
 I Y="^" Q 0 ;
 S KBAIFN=Y
 Q 1
 ;
I2S ; 
 ; here is an example of one record in the NLM ICD to Snomed mapping file:
 ;;ICD_CODE   427.31
 ;;ICD_NAME   Atrial fibrillation
 ;;IS_CURRENT_ICD   1
 ;;IP_USAGE   1.89778
 ;;OP_USAGE   3.20644
 ;;AVG_USAGE   2.55211
 ;;IS_NEC   0
 ;;SNOMED_CID   49436004
 ;;SNOMED_FSN   Atrial fibrillation (disorder)
 ;;IS_1-1MAP   1
 ;;CORE_USAGE   0.4746
 ;;IN_CORE   1
 Q
 ;
FILEI2S ; file ICD9 to Snomed mapping in file 8402116.201
 N GF S GF=8402116.201 ; fileman file number
 N GFS S GFS=8402116.211 ; multiple subfile number
 N MAP S MAP=$NA(^XTMP("JJOH","MAP")) ; location of the map
 N ZI S ZI=""
 F  S ZI=$O(@MAP@(ZI)) Q:ZI=""  D  ;
 . K JJOHFDA
 . S JJOHFDA(GF,"?+1,",.01)=@MAP@(ZI,1,"ICD_CODE")
 . S JJOHFDA(GF,"?+1,",.02)=@MAP@(ZI,1,"ICD_NAME")
 . S JJOHFDA(GF,"?+1,",5)=@MAP@(ZI,1,"IS_1-1MAP")
 . N IS1TO1 S IS1TO1=@MAP@(ZI,1,"IS_1-1MAP")
 . S:IS1TO1 JJOHFDA(GF,"?+1,",1)=@MAP@(ZI,1,"SNOMED_CID")
 . S:IS1TO1 JJOHFDA(GF,"?+1,",1.1)=@MAP@(ZI,1,"SNOMED_FSN")
 . S:IS1TO1 JJOHFDA(GF,"?+1,",1.2)=@MAP@(ZI,1,"IN_CORE")
 . S JJOHFDA(GF,"?+1,",9.1)=@MAP@(ZI,1,"IS_CURRENT_ICD")
 . S JJOHFDA(GF,"?+1,",9.2)=@MAP@(ZI,1,"IP_USAGE")
 . S JJOHFDA(GF,"?+1,",9.3)=@MAP@(ZI,1,"OP_USAGE")
 . S JJOHFDA(GF,"?+1,",9.4)=@MAP@(ZI,1,"AVG_USAGE")
 . S JJOHFDA(GF,"?+1,",9.5)=@MAP@(ZI,1,"IS_NEC")
 . I $D(@MAP@(ZI,2)) D  ; is a multiple
 . . S JJOHFDA(GF,"?+1,",2)=@MAP@(ZI,1,"SNOMED_CID")
 . . S JJOHFDA(GF,"?+1,",2.1)=$TR(@MAP@(ZI,1,"SNOMED_FSN"),"^") 
 . . S JJOHFDA(GF,"?+1,",1.2)=@MAP@(ZI,1,"IN_CORE")
 . . N ZJ S ZJ=""
 . . F  S ZJ=$O(@MAP@(ZI,ZJ)) Q:ZJ=""  D  ;
 . . . N ZK S ZK=ZJ+1
 . . . S JJOHFDA(GFS,"?+"_ZK_",?+1,",.01)=@MAP@(ZI,ZJ,"SNOMED_CID")
 . . . S JJOHFDA(GFS,"?+"_ZK_",?+1,",.02)=$TR(@MAP@(ZI,ZJ,"SNOMED_FSN"),"^")
 . . . S JJOHFDA(GFS,"?+"_ZK_",?+1,",1)=@MAP@(ZI,ZJ,"IN_CORE")
 . D UPDIE(.JJOHFDA)
 Q
 ;
XFORM() ;
 N GN S GN=$NA(^XTMP("JJOH"))
 N SRC1,SRCM,MAP
 S SRC1=$NA(@GN@("ICDMAP121"))
 S SRCM=$NA(@GN@("ICDMAP12M"))
 S MAP=$NA(@GN@("MAP"))
 K @MAP
 N SRC
 F SRC=SRC1,SRCM D  ;
 . N ZN S ZN=$O(@SRC@(""),-1)
 . N ZH S ZH=@SRC@(1)
 . N I,ZT
 . F I=1:1:ZN D  ;
 . . N J
 . . F J=1:1:12 D  ;
 . . . S ZT($P(ZH,"~",J))=$P(@SRC@(I),"~",J)
 . . ;W !,ZN ZWR ZT
 . . N ICD S ICD=ZT("ICD_CODE")
 . . N ZI S ZI=1
 . . I $D(@MAP@(ICD)) D  ;
 . . . S ZI=$O(@MAP@(ICD,""),-1)+1
 . . M @MAP@(ICD,ZI)=ZT
 . . K ZT
 Q
 ;
FINI2S() ; read in the NLM ICD9 to Snomed mapping files
 ; extrinsic returns true if successful
 N FILE1,FILE2,DIR
 Q:'$$GETDIR(.DIR,"/home/vista/ccda/trunk/map/") 0
 W !,"Please enter ICD9 to Snomed 1 to 1 map file name"
 Q:'$$GETFN(.FILE1,"icd9toSnomed_1to1.txt") 0
 W !,"Please enter ICD9 to Snomed 1 to Many map file name"
 Q:'$$GETFN(.FILE2,"icd9toSnomed_1toM.txt") 0
 N GN  S GN=$NA(^XTMP("JJOH","ICDMAP121"))
 N GN1 S GN1=$NA(@GN@(1))
 K @GN
 Q:$$FTG^%ZISH(DIR,FILE1,GN1,3)="" 0
 S GN=$NA(^XTMP("JJOH","ICDMAP12M"))
 S GN1=$NA(@GN@(1))
 K @GN
 Q:$$FTG^%ZISH(DIR,FILE2,GN1,3)="" 0
 Q 1
 ;
UPDIE(ZFDA,ZIEN) ; INTERNAL ROUTINE TO CALL UPDATE^DIE AND CHECK FOR ERRORS
 ; ZFDA IS PASSED BY REFERENCE
 ; ZIEN IS PASSED BY REFERENCE
 D:$G(DEBUG)
 . ZWRITE ZFDA
 . B
 K ZERR
 D CLEAN^DILF
 D UPDATE^DIE("K","ZFDA","ZIEN","ZERR")
 I '$G(TRUST) I $D(ZERR) S ZZERR=ZZERR ; ZZERR DOESN'T EXIST,
 ; INVOKE THE ERROR TRAP IF TASKED
 ;. W "ERROR",!
 ;. ZWR ZERR
 ;. B
 K ZFDA
 Q
 ;
