MPIFRES ;SF/CMC-LOCAL AND MISSING ICN RESOLUTION ; 7/22/15 1:22pm
 ;;1.0;MASTER PATIENT INDEX VISTA;**1,7,10,15,17,21,26,28,33,35,43,39,52,54,61**;30 Apr 99;Build 3
 ;
 ; Integration Agreements Utilized:
 ;  EXC, START and STOP^RGHLLOG - #2796
 ;  ^DPT("AICNL", ^DPT("AMPIMIS" - #2070
 ;  ^RGHL7(991.1 - #3259
 ;  ^RGSITE - #2746
 ;
BKG ;
 I $D(ZTQUEUED) D GO Q
 S ZTRTN="GO^MPIFRES",ZTDESC="USE HL7 MSGS AND MAIL TO BUILD ICN"
 S ZTIO="",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,1,0)
 I $D(DUZ) S ZTSAVE("DUZ")=DUZ
 D ^%ZTLOAD
 D HOME^%ZIS K IO("Q")
 K ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,%
 Q
 ;
GO ;ENTRY POINT
 N MPIMORE,MPITOT
 L +^XTMP("MPIF RESOLUTION"):3 E  Q
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 K ^TMP("HLS",$J),STOP
 D START^RGHLLOG()
 D HLRDF
 I $D(STOP) K STOP Q  ;patch 7 added to quit if init returned an error
 D LOOP
 I $D(^TMP("HLS",$J)) D SEND
 D STOP^RGHLLOG(0)
 ;**61 Story 173992 (ckn)
 ;Process MPIF EXPLICIT QUEUE
 D PEXQUE
 K MPIIT,MPITOT,HLDT,HLDT1,MPICNT,MPIDNUM,MPIEROR,MPIMIDT,MPIMSH
 K MPIOUT,MPIQRYNM,MPISEQ,QCNT,MPIMCNT,MPIMTX,ENDT,MPIFRES
 L -^XTMP("MPIF RESOLUTION")
 ; mark job completion date/time
 S $P(^RGSITE(991.8,1,0),"^",4)=$$NOW^XLFDT
 Q
 ;
HLRDF ;
 S (MPIOUT,MPIMCNT)=""
 S HL("ECH")="^~\&"
 S HL("FS")="|"
 D INIT^HLFNC2("MPIF ICN-Q02 SERVER",.HL)
 I $O(HL("")) D EXC^RGHLLOG(220,"INIT^HLFNC2 call error returned") S STOP="" Q
 D CREATE^HLTF(.MPIMCNT,.MPIMTX,.HLDT,.HLDT1)
 Q
LOOP ;
 S (MPICNT,MPIDNUM)=1
 D MAKE
 Q
SEND ;ready to send
 D GENERATE^HLMA("MPIF ICN-Q02 SERVER","GB",1,.MPIMTX,.MPIEROR,.MPIMORE)
 I +MPIEROR=0 D EXC^RGHLLOG(220,"GENERATE^HLMA call returned error") Q
 K %,MPIMTX,MPIEROR,MPIMORE
 K ^TMP("HLS",$J)
 Q
MAKE ;
 N LOCAL,MPIIT,TICN,STOP,X,Y,%,%H,%I,TODAY,SITE,XX,SDT,NDT
 S LOCAL="",MPIIT=0,MPIFRES="",SITE=$P($$SITE^VASITE(),"^",3)
 D NOW^%DTC S TODAY=X
 ;local ICNs
 F  S MPIIT=$O(^DPT("AICNL",1,MPIIT)) Q:MPIIT=""  D
 .;**61 - Story 173992 (ckn)
 .;If DFN entry exist in new MPIF EXPLICIT ADD QUEUE, Don't process
 .;this DFN as it will be processed by PEXQUE code
 .I $D(^XTMP("MPIF EXPLICIT QUEUE",MPIIT)) Q
 .; LINE BELOW ADDED FOR PATCH 26 TO CLEANUP AICNL X-REF WHEN LEFT AROUND
 .I $E($$GETICN^MPIF001(MPIIT),1,3)'=SITE S XX=$$SETLOC^MPIF001(MPIIT,0) K ^DPT("AICNL",1,MPIIT) Q
 .;Q:+$G(^DPT("AICNL",1,MPIIT))=1 **39 changing check
 .Q:+$G(^DPT("AICNL",1,MPIIT))=2&($P($G(^DPT("AICNL",1,MPIIT)),"^",2)=TODAY)
 .; ^ check if A28 failed to get ICN back and should now be sent up
 .; DON'T send if is the 2^today **35
 .S SDT=$P($G(^DPT("AICNL",1,MPIIT)),"^",2)
 .N X1,X2 K X S X1=SDT,X2=2 D C^%DTC S NDT=X ;**39 FIGURE 2 DAYS FROM NOW
 .Q:+$G(^DPT("AICNL",1,MPIIT))=1&(SDT=TODAY)
 .; **39 ^ if send up today don't send again
 .Q:+$G(^DPT("AICNL",1,MPIIT))=1&(NDT>TODAY)
 .;**39 ^ only send patient to MPI for Local ICN resolution 1 time UNLESS its day 3 since it was sent
 .;I $D(^RGHL7(991.1,"ADFN",218,MPIIT)) S ^DPT("AICNL",1,MPIIT)="1^"_TODAY Q
 .; ^ checking if potential match exception **43 REMOVE CHECK ON POTENTIAL MATCH EXCEPTIONS
 .D MAKE3
 ;missing ICNs
 S MPIIT=0
 F  S MPIIT=$O(^DPT("AMPIMIS",MPIIT)) Q:MPIIT=""  D
 .K STOP
 .I $D(^DPT(MPIIT,-9)) K ^DPT("AMPIMIS",MPIIT) Q  ;**43 CHECK IF MERGED PATIENT AND CLEANUP CROSS REFERENCE
 .I '$D(^DPT(MPIIT,0)) K ^DPT("AMPIMIS",MPIIT) Q  ;**54 cleanup for x-ref if 0 node doesn't exist
 .S TICN=+$$GETICN^MPIF001(MPIIT)
 .I TICN<0 L +^DPT(MPIIT):5 I '$T Q  ;**35
 .L -^DPT(MPIIT) ;**35 **52 UNLOCK WHAT IS LOCKED ABOVE
 .;**35 If don't have ICN yet, try to lock if can't get lock skip record - still creating patient.
 .I TICN<0,'$D(STOP) D MAKE3
 .K ^DPT("AMPIMIS",MPIIT) ;**54 include cleanup for x-ref here
 Q
MAKE3 ;
 K MPIOUT
 S MPIFRES=""
 S:$G(MPIQRYNM)="" MPIQRYNM="EXACT_MATCH_QUERY" ;**43 changed MPIQRYNM from VTQ_PID_ICN_LOAD_1 to stop automatic add pts on the MPI
 D VTQ1^MPIFVTQ(MPIIT,.MPIOUT,.HL,.MPIQRYNM)
 ;**54 MVI 874 STOP LOGGING EXCEPTION AS WE CORRECTED THE DANGLING X-REF FOR INVALID DFN
 I $P(MPIOUT(0),"^")<0,$P(MPIOUT(0),"^",2)="invalid DFN" Q
 I $P(MPIOUT(0),"^",2)="no encoding characters" D EXC^RGHLLOG(206,"DFN = "_MPIIT_"  Problem with building VTQ was "_$P(MPIOUT(0),"^",2),MPIIT) Q
 ;I $P(MPIOUT(0),"^")<0,$P(MPIOUT(0),"^",2)="Missing Required Field(s)" Q
 ;Q:$P(MPIOUT(0),"^")<0
 S ^DPT("AICNL",1,MPIIT)="1^"_TODAY
 ; ^ mark Local ICN as having been sent to MPI for resolution
 ;call for HL7 header
 S MPIMIDT=MPIMCNT_"-"_MPIDNUM
 D MSH^HLFNC2(.HL,MPIMIDT,.MPIMSH)
 S MPIOUT(1)=MPIMSH
 S ^TMP("HLS",$J,MPICNT)=MPIOUT(1)
 S MPICNT=MPICNT+1
 ;MESSAGE BUILT
 S MPISEQ=0
 ;setup VTQ segment in HL array
 S ^TMP("HLS",$J,MPICNT)=MPIOUT(2)
 S MPICNT=MPICNT+1
 ;setup RDF segment in HL array
 S ^TMP("HLS",$J,MPICNT)=MPIOUT(3)
 ;loop through and add the additional RDF continuations
 N SCNT,Y S Y=3,SCNT=1 F  S Y=$O(MPIOUT(Y)) Q:'Y  D
 .S ^TMP("HLS",$J,MPICNT,SCNT)=MPIOUT(Y),SCNT=SCNT+1
 S MPICNT=MPICNT+1
 S MPIDNUM=MPIDNUM+1
 I MPIDNUM>100 D
 .D SEND
 .S (MPICNT,MPIDNUM)=1
 .D HLRDF
 Q
PEXQUE ;Process MPIF EXPLICIT QUEUE for pending DFNs from Register A Patient option
 N DFN,PATARR,MPIDATA,STNUM
 S STNUM=$P($$SITE^VASITE(),"^",3)
 I '$D(^XTMP("MPIF EXPLICIT QUEUE")) Q
 S $P(^XTMP("MPIF EXPLICIT QUEUE",0),"^",1)=$$FMADD^XLFDT(DT,5)
 S DFN=0 F  S DFN=$O(^XTMP("MPIF EXPLICIT QUEUE",DFN)) Q:+DFN=0  D
 . K PATARR
 . I $P($G(^DPT(DFN,"MPI")),"^")'="",($E($P($G(^DPT(DFN,"MPI")),"^"),1,3)'=STNUM) D  Q
 .. K ^XTMP("MPIF EXPLICIT QUEUE",DFN)
 . D GETPAT(DFN,.PATARR)
 . ;Call webservice for explicit Add
 . D GETICN^MPIFXMLI(.MPIDATA,.PATARR)
 . I $G(MPIDATA("ICN"))<1 D  Q  ;No ICN returned - keep this record in queue
 ..S ^XTMP("MPIF EXPLICIT QUEUE",DFN)=DT_"^"_PATARR("AddType")_"^"_PATARR("mcid")_"^"_$G(MPIDATA("ERRTXT"))
 ..K MPIDATA,PATARR
 . ;Store ICN into Patient file
 . D VIC40^MPIFAPI(DFN,MPIDATA("ICN"))
 . ;cleanup the queue
 . K ^XTMP("MPIF EXPLICIT QUEUE",DFN),MPIDATA,PATARR
 Q
GETPAT(DFN,PATARR) ;Get patient data for DFN
 N NAME,DNM,VAROOT,COUNTRY,STATE,DGDEM,DGOPD,DGADDR,ADDTYP,STOKEN
 S ADDTYP=$P($G(^XTMP("MPIF EXPLICIT QUEUE",DFN)),"^",2) ; Add type
 S STOKEN=$P($G(^XTMP("MPIF EXPLICIT QUEUE",DFN)),"^",3) ;search token
 S VAROOT="DGDEM" D DEM^VADPT ;Patient Demographic data
 S VAROOT="DGOPD" D OPD^VADPT ;Patient Other Pertinent Data
 S VAROOT="DGADDR" D ADD^VADPT ;Patient Address data
 S PATARR("AddType")=$G(ADDTYP),PATARR("mcid")=STOKEN
 ;NAME
 S DNM=$G(DGDEM(1)) I DNM'="" D
 .D STDNAME^XLFNAME(.DNM,"C")
 .S PATARR(1,"FirstName")=DNM("GIVEN"),PATARR(1,"Surname")=DNM("FAMILY")
 .S PATARR(1,"MiddleName")=DNM("MIDDLE"),PATARR(1,"Suffix")=DNM("SUFFIX")
 S PATARR(1,"SSN")=$P($G(DGDEM(2)),"^") ;SSN
 S PATARR(1,"DOB")=$P($G(DGDEM(3)),"^") ;DOB
 S PATARR(1,"Gender")=$P($G(DGDEM(5)),"^") ;Gender
 S PATARR(1,"MMN")=$G(DGOPD(5)) ;Mother's maiden Name
 S PATARR(1,"POBCity")=$G(DGOPD(1)) ;POB City
 S PATARR(1,"POBState")=$P($G(DGOPD(2)),"^") I PATARR(1,"POBState")'="" S PATARR(1,"POBState")=$P($G(^DIC(5,PATARR(1,"POBState"),0)),"^",2) ;POB State
 S PATARR(1,"MBI")=$P($G(^DPT(DFN,"MPIMB")),"^") ;Multiple Birth Indicator
 S PATARR(1,"DOD")=$P($G(DGDEM(6)),"^") ;Date of Death
 ;Address Fields
 S COUNTRY=$P($G(DGADDR(25)),"^")
 I COUNTRY'="",($D(^HL(779.004,COUNTRY,0))) D
 . S PATARR(1,"ResAddL1")=$G(DGADDR(1)),PATARR(1,"ResAddL2")=$G(DGADDR(2))
 . S PATARR(1,"ResAddL3")=$G(DGADDR(3)),PATARR(1,"ResAddCity")=$G(DGADDR(4))
 . S COUNTRY=$P($G(DGADDR(25)),"^"),COUNTRY=$P($G(^HL(779.004,COUNTRY,0)),"^")
 . S PATARR(1,"ResAddCountry")=COUNTRY
 . I COUNTRY="USA" D
 .. S STATE=$P($G(DGADDR(5)),"^") I STATE'="" S PATARR(1,"ResAddState")=$P($G(^DIC(5,STATE,0)),"^",2)
 .. S PATARR(1,"ResAddZip4")=$G(DGADDR(6))
 .I COUNTRY'="USA" D
 .. S PATARR(1,"ResAddProvince")=$G(DGADDR(23))
 .. S PATARR(1,"ResAddPostalCode")=$G(DGADDR(24))
 ; Phone
 S PATARR(1,"ResPhone")=$G(DGADDR(8))
 S PATARR(1,"DFN")=DFN ;DFN of Patient
 Q
