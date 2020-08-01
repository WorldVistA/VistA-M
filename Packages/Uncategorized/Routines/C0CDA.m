C0CDA ; GPL - CCDA Routines ;9/18/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License Apache 2
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 ;
 Q
 ;
 ; This is the main entry point for the CCDA generation routines
 ;
wsCCDA(OUT,FILTER) ; web service which returns a ccda
 S DUZ=1
 S DUZ(2)=1 ; GPL HACK
 I '$D(DT) N DIQUIET S DIQUIET=1 D DT^DICRW
 S HTTPRSP("mime")="text/xml"
 S DFN=$G(FILTER("patientId"))
 I $G(FILTER("testpat"))'="" S C0TEST=1
 I DFN="" Q  ;
 N PARM
 ;D PRSPARMS(.FILTER,.PARM) ; parse incoming parms and overlay on defaults
 N SEL S SEL=$$FILTERV^C0CDAC0(.FILTER,DFN)
 ;Q:'SEL "no matching visits"
 D LOGARY^C0CDACU("FILTER") ; log the parm array
 N C0LOG S C0LOG=1
 D CCDARPC^C0CDAC0(.OUT,DFN,.FILTER)
 K ^GPL
 M ^GPL=^TMP("CCDA",$J)
 ;S @OUT@(2)="<?xml-stylesheet type=""text/xsl"" href=""http://ccda.vistaewd.net/resources/CDA.xsl""?>"
 ;S @OUT@(2)="<?xml-stylesheet type=""text/xsl"" href=""/resources/css/CDA.xsl""?>"
 S @OUT@(2)="<?xml-stylesheet type=""text/xsl"" href=""/resources/css/CDA.xsl""?>"
 ;D ADDCRLF^VPRJRUT(.OUT)
 D ADDCRLF^%webutils(.OUT)
 Q
 ;
TESTCCDA ;
 K G
 S DEBUG=1
 N PRM
 S PRM("patientId")=1
 S PRM("id")="CCDA-100-1-20050801.xml"
 D wsCCDA(.G,.PRM)
 Q
 ;
CCDARPC(RTN,DFN,PARMS) ; generates a CCDA document for patient DFN
 ; RTN is passed by reference
 ; PARMS are parameters that govern the output of form: parm1:value1^parm2:value2 etc.
 ;   SELECT:LATEST will generate a ccda for the latest encounter
 ;   SELECT:date will generate a ccda for the encounter on the date
 ;
 N C0BCRTL,C0BLDBLD,C0BUILD,C0WRK,C0TBL,C0PARMS,C0LOG,C0LOGLOC
 ;
 ; create a work area for processing and clear it
 ;
 S C0WRK=$NA(^TMP("CCDA",$J)) ; work area root for entire process
 K @C0WRK ; make sure it is clear to begin
 S C0BCTRL=$NA(@C0WRK@("CTRL"))
 S @C0BCTRL@("PARMS")=""
 I $D(PARMS) M @C0BCTRL@("PARMS")=PARMS ; parameters for all processes to use
 S C0LOG=$G(PARMS("LOG")) ; produce a log of the extract: LOG:1
 I C0LOG["YES" S C0LOG=1 ; yes means 1
 S C0LOGLOC=$NA(@C0WRK@("LOG"))
 D:C0LOG  ;
 . D OUTLOG^C0CDACU("DFN: "_DFN_" "_$P(^DPT(DFN,0),"^",1))
 . N II S II=""
 . F  S II=$O(PARMS(II)) Q:II=""  D OUTLOG^C0CDACU("PARMS("_II_")="_PARMS(II))
 S C0BLDBLD=$NA(@C0BCTRL@("BLDBLD")) ; build list of build lists
 S @C0BLDBLD@("DFN")=DFN
 S @C0BLDBLD@("START-TIME")=$$NOW^XLFDT
 ;
 ; build a table of the processing order and routines to call
 ;
 D BTBL(.C0TBL,"BCCDA1^C0CDAC0",.PARMS) ; build the table of what to process
 ;
 ; set up control blocks and work areas for each build component
 ;
 N C0I
 F C0I=1:1:C0TBL(0) D  ;
 . N C0KEY,C0RT
 . S C0KEY=$P(C0TBL(C0I),",",1)
 . S C0RT=$P(C0TBL(C0I),",",2)
 . S C0BUILD=$NA(@C0WRK@("BUILD",C0KEY))
 . S @C0BLDBLD@(C0I)=C0BUILD
 . S @C0BLDBLD@(0)=C0I
 . S @C0BCTRL@("ORDER",C0I)=C0KEY
 . S @C0BCTRL@("ORDER",0)=C0I
 . S @C0BCTRL@(C0KEY,"ROUTINE")=C0RT
 . S @C0BCTRL@(C0KEY,"STATUS")="INIT" ; section is intialized
 . S @C0BCTRL@(C0KEY,"INIT-TIME")=$$NOW^XLFDT
 . S @C0BCTRL@(C0KEY,"BUILD-LIST")=C0BUILD
 . S @C0BCTRL@(C0KEY,"WORK-AREA")=$NA(@C0WRK@(C0KEY))
 D:$G(C0DEBUG) GTREE^KBAIVPR(C0BCTRL)
 ;
 ; the rest of the processing can be done from the C0BLDBLD table,
 ;  which contains the routine to call and the work area that returns
 ;  the result
 ; 
 ; at this point, we can spawn new taskman tasks to extract and build
 ;  all of the components of the document in parallel. in fact, we
 ;  could launch a parent task to spawn all of that work and use this
 ;  routine to monitor progress and return the final result when done. 
 ; 
 ; initially, we are going to process everything sequentially without
 ;  without using taskman
 ;
 F C0I=1:1:@C0BCTRL@("ORDER",0) D  ; for each component to be built
 . N C0KEY,C0BLD,C0RT,C0AREA,C0X,C0REPORT
 . S C0KEY=@C0BCTRL@("ORDER",C0I)
 . S C0BLD=@C0BCTRL@(C0KEY,"BUILD-LIST")
 . S C0RT=@C0BCTRL@(C0KEY,"ROUTINE")
 . S C0REPORT=$NA(@C0BCTRL@(C0KEY))
 . S C0AREA=@C0BCTRL@(C0KEY,"WORK-AREA")
 . S C0X="D "_C0RT_"(C0BLD,DFN,C0AREA,C0REPORT,C0BCTRL)"
 . D:C0LOG OUTLOG^C0CDACU("RUNNING "_C0X)
 . X C0X
 N LAST1 S LAST1=$NA(@C0WRK@("LAST1"))
 D GET^C0CDACU(LAST1,"TLAST1^C0CDAC0")
 N C0BLIST S C0BLIST=$NA(@C0WRK@("BUILD","C0BLIST"))
 D QUEUE^MXMLTMPL(C0BLIST,LAST1,1,@LAST1@(0))
 D ADDTO(C0BLDBLD,C0BLIST)
 D:$G(C0DEBUG) GTREE^KBAIVPR(C0WRK,9)
 D BUILDM(C0BLDBLD,.RTN)
 Q
 ;
BTBL(TBL,INTAG,PARM) ; build table TBL of processing order passed by reference 
 ; INTAG is the name of a tag that stores the table ie. BCCDA1^C0CDAC0
 ; gpl - added the ability to only process one clinical domain by specifying it
 ; in the parameters SECTIONONLY=MEDS for example
 ;;HEADER,HEADER^C0CDAC2
 ;;ALGY,ALLERGY^C0CDAC8
 ;;ENC,ENC^C0CDACV
 ;;SOC,SOC^C0CDAC7
 ;;MEDS,MEDS^C0CDAC4
 ;;PROBLEMS,PROBLEMS^C0CDAC3
 ;;LABS,LABS^C0CDAC5
 ;;VITALS,VITALS^C0CDAC6
 N GTAG,GRT,GI
 S GTAG=$P(INTAG,"^",1)
 S GRT=$P(INTAG,"^",2)
 N GN S GN=1
 F  S GI=GTAG_"+"_GN_"^"_GRT  Q:$T(@GI)'[";;"  D  ;
 . S TBL(GN)=$P($T(@GI),";;",2)
 . S TBL(0)=GN
 . I $G(CCDADEBUG) W !,GN," ",TBL(GN)
 . S GN=GN+1
 I $D(PARM("SECTIONONLY")) D  ;
 . N TTAB,GGI,GSEC S GGI=""
 . S GSEC=PARM("SECTIONONLY")
 . F GGI=1:1:TBL(0) D  ;
 . . I GSEC=$P(TBL(GGI),",",1) S TTAB=TBL(GGI)
 . I $D(TTAB) D  ;
 . . K TBL
 . . S TBL(1)=TTAB
 . . S TBL(0)=1
 Q
 ;
BUILDM(BBLIST,OUTXML) ; process a build list of build lists to generate xml
 ; both BBLIST and OUTXML are passed by name
 ;
 N BIGLIST,C0I,C0J,C0N
 S C0N=0
 F C0I=1:1:@BBLIST@(0) D  ;
 . N BLIST
 . S BLIST=@BBLIST@(C0I) ; build list
 . I '$D(@BLIST) Q  ;
 . F C0J=1:1:@BLIST@(0) D  ;
 . . S C0N=C0N+1
 . . S BIGLIST(C0N)=@BLIST@(C0J)
 . . S BIGLIST(0)=C0N
 S OUTXML=$NA(@C0WRK@("XML"))
 K @OUTXML
 D BUILD^MXMLTMPL("BIGLIST",OUTXML)
 K @OUTXML@(0)
 Q
 ;
ADDTO(DEST,WHAT) ; adds string WHAT to list DEST 
 ; DEST is passed by name
 N GN
 S GN=$O(@DEST@("AAAAAA"),-1)+1
 S @DEST@(GN)=WHAT
 S @DEST@(0)=GN ; count
 Q
 ;
CCDA(DFN,PARMS,sessid) ; extrinsic to create a ccda and return the filename
 ; PARMS is parameter string format: parm1=val1&parm2=val2&parm3=val3
 ; ignore sessid for now
 ;
 I '$D(^DPT(DFN)) Q ""
 I '$D(PARMS) N PARMS S PARMS=""
 N PARM
 ; defaults
 S PARM("DUZ")=135
 S PARM("SELECT")="ALL"
 S PARM("LOG")=1
 S PARM("MEDS")="FILTER1"
 D PRSPARMS(PARMS,.PARM) ; parse incoming parms and overlay on defaults
 N SEL S SEL=$$FILTERV(.PARM,DFN)
 Q:'SEL "no matching visits"
 D LOGARY^C0CDACU("PARM") ; log the parm array
 N C0LOG S C0LOG=1
 D CCDARPC(.CCDA,DFN,.PARM)
 N FN
 S FN=$$OUTCCDA(CCDA) ; 
 ;N C0LOGLOC S C0LOGLOC=$NA(^TMP("CCDA",$J,"LOG"))
 ;D BROWSE^DDBR(C0LOGLOC,"N","PATIENT "_DFN_" "_FN)
 K ^TMP("CCDA","GPL")
 M ^TMP("CCDA","GPL")=^TMP("CCDA",$J,"LOG")
 K ^TMP("CCDA",$J) ; clean up
 K C0BCTRL,C0DATE2,C0LOGLOC,CCDA,CV,GN,ORDIALOG,JJOHDID
 K ^TMP("MXMLDOM",$J)
 Q FN
 ;
PRSPARMS(PSTR,PARY) ; parse parms into array
 I PSTR="" Q  ;
 I PSTR["=" D  ;
 . N P1,P2,P3,P4,P5
 . S P2=$L(PSTR,"&")
 . F P1=1:1:P2 D  ;
 . . S P3=$P(PSTR,"&",P1)
 . . S X=$P(P3,"=",1)
 . . X ^%ZOSF("UPPERCASE")
 . . S P4=Y
 . . S X=$P(P3,"=",2)
 . . X ^%ZOSF("UPPERCASE")
 . . S P5=Y
 . . S PARY(P4)=P5
 D RDCTPRM(.PARM) ; further parse the REDACT parameter
 Q
 ;
RDCTPRM(PARM) ; used by PRSPARMS to further parse the REDACT parameter
 ; which has the format REDACT:uri1,uri2,uri3... Here's the result:
 ;G("REDACT")="1,2,3,4,5,6,7"
 ;G("REDACT",1)=1
 ;G("REDACT",2)=1
 ;G("REDACT",3)=1
 ;G("REDACT",4)=1
 ;G("REDACT",5)=1
 ;G("REDACT",6)=1
 ;G("REDACT",7)=1
 I '$D(PARM("REDACT")) Q  ;
 N Y S Y=PARM("REDACT")
 I Y="" Q
 N X S X=$L(Y,",")
 I X=1 S PARM("REDACT",Y)=1 Q  ;
 N Z
 F Z=1:1:X S PARM("REDACT",$P(Y,",",Z))=1 
 Q
 ;
FILTERV(PARM,DFN) ; modify the Parm array to select the visits to be extracted. 
 ; PARM is passed by ref
 N VIS
 D VISITS^C0CDACV(.VIS,DFN)
 I $O(VIS(""))="" Q 0 ; no matching visits
 N EKEYS ; table of valid select commands (all others are dates)
 S EKEYS("LATEST")=""
 S EKEYS("LATESTOP")=""
 S EKEYS("LATESTIP")=""
 S EKEYS("ALL")=""
 N RSLT S RSLT=0
 ;I $G(PARM("STARTDATERANGE"))'="" D  Q RSLT ;
 I '$D(PARM("SELECT")) S PARM("SELECT")=$G(PARM("select"))
 N SEL S SEL=$G(PARM("SELECT"))
 I SEL="" S SEL="ALL" S PARM("SELECT")="ALL"
 ;S RSLT=$$DODATES^C0CDAC0(.VIS,.PARM) ; establish effective dates for header
 S PARM("date")=$G(VIS(1,"date")) ; best discharge date is the latest visit date
 I '$D(EKEYS(SEL)) D  Q RSLT ;
 . S RSLT=$$DODATES^C0CDAC0(.VIS,.PARM)
 I $G(PARM("SELECT"))="LATEST" D  Q 1 ;
 . M PARM=VIS(1)
 . I $G(VIS(1,"visitType")="inpatient" D EXTENDIP(.VIS,.PARM,1))
 S RSLT=0
 I $G(PARM("SELECT"))="LATESTOP" D  Q RSLT ;
 . N ZI S ZI=""
 . N DONE S DONE=0
 . F  S ZI=$O(VIS(ZI)) Q:DONE  Q:ZI=""  D  ;
 . . I VIS(ZI,"visitType")="outpatient" D  ;
 . . . S RSLT=1
 . . . S DONE=1
 . . . M PARM=VIS(ZI)
 S RSLT=0
 I $G(PARM("SELECT"))="LATESTIP" D  Q RSLT ;
 . N ZI S ZI=""
 . N DONE S DONE=0
 . F  S ZI=$O(VIS(ZI)) Q:DONE  Q:ZI=""  D  ;
 . . I VIS(ZI,"visitType")="inpatient" D  ;
 . . . S RSLT=1
 . . . S DONE=1
 . . . M PARM=VIS(ZI) ; will be used for endDateTime for multi day stays
 . . . D EXTENDIP(.VIS,.PARM,ZI) ; extend the date range to the whole hospital stay
 Q 1
 ;
DODATES(VIS,PARM) ; extrinsic which handles paramaters which include
 ; startDateRange:xxxx
 N RSP S RSP=1
 N SEL S SEL=$G(PARM("SELECT"))
 I SEL="" Q 0
 S PARM("STARTDATERANGE")=$P(SEL,":",1)
 S PARM("ENDDATERANGE")=$P(SEL,":",2)
 I PARM("ENDDATERANGE")="" S PARM("ENDDATERANGE")="T"
 N X
 S X=$$FMDATE($G(PARM("STARTDATERANGE")))
 I X>-1 S PARM("startDateTime")=X
 E  S RSP=0 Q RSP
 S X=$$FMDATE($G(PARM("ENDDATERANGE")))
 I X>-1 S PARM("endDateTime")=$S(X>PARM("startDateTime"):X,1:$$NOW^XLFDT)
 E  D  ;
 . S PARM("endDateTime")=$$NOW^XLFDT
 N ZI,ZV S ZI=""
 F  S ZI=$O(VIS(ZI)) Q:ZI=""  S ZV(VIS(ZI,"date"),ZI)=""
 ;I $D(ZV(PARM("startDateTime"))) S RSP=0 Q RSP
 I $O(ZV(PARM("startDateTime")),-1)="" S RSP=0
 Q RSP
 ;
FMDATE(IDT) ; extrinsic that returns the fileman date. DT is in one of these forms:
 ; YYYYMMDD which is used by CDA documents and our parameters
 ; JAN 12,2011 or any valid fileman date
 N DT S DT=$P(IDT,".") ; date portion
 N DS S DS=$P(IDT,".",2) ; second portion
 N TY S TY=$E(DT,1,4)
 N RTN S RTN=-1
 I ((TY>1700)&(TY<3000)) D  Q RTN
 . N TM S TM=$E(DT,5,6)
 . N TD S TD=$E(DT,7,8)
 . N X,Y,DL
 . S DL=$L(DT) ; LENGTH OF DATE PROVIDED
 . S X=$S(DL=4:DT,DL=6:TM_"/"_TY,1:TM_"/"_TD_"/"_TY)
 . D ^%DT
 . S RTN=Y
 N X S X=DT
 D ^%DT
 S RTN=Y
 Q RTN
 ;
EXTENDIP(VIS,PARM,WHICH) ; extend the extraction date range for inpatient to include
 ; all days of a hospital stay, and optionally the immediately previous ER visit
 ; VIS is the array of visits passed by reference
 ; PARM is the parameter array passed by reference
 ; WHICH is the selected inpatient visit to extend, passed by value
 N STOP S STOP=0
 N ZJ S ZJ=WHICH
 F  S ZJ=$O(VIS(ZJ)) Q:STOP  Q:ZJ=""  D  
 . I $G(VIS(ZJ,"visitType"))'="inpatient" S STOP=1 ; no more inpatient days           
 . E  S PARM("startDateTime")=$G(VIS(ZJ,"startDateTime")) ; include this day          
 ;
 ; now check for whether to include the immediately previous ER visit in the extract
 ;
 I $G(PARM("INCLUDEPREVIOUSERVISIT"))=1 D  ; include previous ER visit                
 . N ZK
 . I ZJ="" S ZK=$O(VIS("AAAAAA"),-1)
 . E  S ZK=ZJ-1
 . I $G(VIS(ZK,"typeName"))="ER-EMERGENCY ROOM VISIT" D  ;                        
 . . S PARM("startDateTime")=$G(VIS(ZK,"startDateTime")) ; new start date  
 Q
 ;
TEST ;
 S DFN=$$PAT()
 N PARMS
 K DIR
 S DIR(0)="FO"
 S DIR("B")="select=latest&meds=filter1&log=1"
 S DUZ("L")="Enter parameters"
 D ^DIR
 ;S PARMS=$TR(Y,",","^")
 S PARMS=Y
 N C0LOG S C0LOG=1
 ;D CCDARPC(.CCDA,DFN,.PARMS)
 N FN
 S FN=$$CCDA(DFN,PARMS) ; 
 W !,FN
 I FN="no matching visits" Q  ;
 N C0LOGLOC S C0LOGLOC=$NA(^TMP("CCDA","GPL"))
 D BROWSE^DDBR(C0LOGLOC,"N","PATIENT "_DFN_" "_FN)
 Q
 ;
OUTCCDA(CCDA) ; write out a ccda xml file to the test directory
 N GF S GF=$$FMDTOUTC^C0CDACU($$NOW^XLFDT)_"-CCDA-"_DFN_".xml"
 S @CCDA@(0)=$O(@CCDA@(""),-1)
 N G2
 D MISSING^MXMLTMPL(CCDA,"G2")
 I $D(G2) D  ;
 . D:$G(C0LOG) OUTLOG^C0CDACU("MISSING VARIABLES")
 . N II S II=""
 . F  S II=$O(G2(II)) Q:II=""  D  ;
 . . D:$G(C0LOG) OUTLOG^C0CDACU(G2(II))
 K @CCDA@(0)
 N RSLT S RSLT=""
 I $$GTF^%ZISH($na(@CCDA@(1)),4,$$TESTDIR^C0CDACZ(),GF) D  ;
 . D:$G(C0LOG) OUTLOG^C0CDACU("CCDA "_GF_" WRITTEN TO: "_$$TESTDIR^C0CDACZ)
 . S RSLT=GF
 Q RSLT
 ;
PAT() ; extrinsic which returns a dfn from the patient selected
 S DIC=2,DIC(0)="AEMQ" D ^DIC
 I Y<1 Q  ; EXIT
 S DFN=$P(Y,U,1) ; SET THE PATIENT
 Q +Y
 ;
BCCDA1(TBL) ; BASIC CCDA - THIS TABLE LOADS ITSELF
 ;;HEADER,HEADER^C0CDAC2
 ;;ALGY,ALLERGY^C0CDAC8
 ;;ENC,ENC^C0CDACV
 ;;SOC,SOC^C0CDAC7
 ;;MEDS,MEDS^C0CDAC4
 ;;PROBLEMS,PROBLEMS^C0CDAC3
 ;;LABS,LABS^C0CDAC5
 ;;VITALS,VITALS^C0CDAC6
 N GTAG,GRT,GI
 S GTAG="BCCDA1"
 S GRT="C0CDAC0"
 N GN S GN=1
 F  S GI=GTAG_"+"_GN_"^"_GRT  Q:$T(@GI)'[";;"  D  ;
 . S TBL(GN)=$P($T(@GI),";;",2)
 . I $G(CCDADEBUG) W !,GN," ",TBL(GN)
 . S GN=GN+1
 Q
 ;
TLAST1 ;
 ;;</structuredBody>
 ;;</component>
 ;;</ClinicalDocument>
 Q
 ;
