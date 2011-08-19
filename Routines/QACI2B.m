QACI2B ; OAKOIFO/TKW - DATA MIGRATION - BUILD SUPPORTING TABLE DATA ;4/10/06  12:06
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
 ;
PTDATA(STATION,DFN,QACI0,PATSERR,PATSCNT) ; Put patient data into ^XTMP global for migration
 S PATSERR=0
 Q:$D(^XTMP("QACMIGR","PT","D",DFN))
 Q:$D(^XTMP("QACMIGR","PT","U",DFN))
 I $D(^XTMP("QACMIGR","PT","E",DFN)) S PATSERR=1 Q
 N PATX,I,X,Y,VAN,VAX,VAV,VADM,VAEL,DSPNAME,PTICN,PTNAME,PATSDATA,PATSDAT2,PATSENRL,GENDER,DOB,RACE,ETH
 S (PATSDATA,PATSDAT2)=""
 ; Get Patient Demographics, load name into variable. (IA #10061)
 D DEM^VADPT
 S DSPNAME=$G(VADM(1)) I $L(DSPNAME)>30 S DSPNAME=$E(DSPNAME,1,30)_"..."
 ; Get Patient's Integration Control Number (ICN) (IA #2701)
 S PTICN=$P($$GETICN^MPIF001(DFN),"^")
 I PTICN]"",PTICN'=-1,PTICN'?1.12N1"V"1.6N S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - ICN invalid")
 ; Load Parent Station number, Patients IEN (DFN) and ICN into output (node 1)
 I 'QACI0 S PATSDATA="1^"_STATION_"^"_DFN_"^"_PTICN_"^"
 ; Get enrollment priority for current enrollment from file 27.11 (IA #2918)
 S PATSENRL=$$GETENRL^QACVDEM(DFN)
 ; Get Patient Name Components and load into output. (IA #3065)
 S PTNAME("FILE")=2,PTNAME("FIELD")=.01,PTNAME("IENS")=DFN
 S PTNAME=$$HLNAME^XLFNAME(.PTNAME)
 D
 . N NMERR S NMERR=0
 . I PTNAME'?.ANP S NMERR=1
 . S X=$P(PTNAME,"^") I $$TXTERR^QACI2C(X,35,0,1) S NMERR=1
 . S X=$P(PTNAME,"^",2) I $$TXTERR^QACI2C(X,25,0,1) S NMERR=1
 . S X=$P(PTNAME,"^",3) I $$TXTERR^QACI2C(X,25) S NMERR=1
 . F I=4:1:6 I $$TXTERR^QACI2C($P(PTNAME,"^",I),10) S NMERR=1 Q
 . I NMERR=1 S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Name invalid")
 . Q
 I 'QACI0 S PATSDATA=PATSDATA_PTNAME
 ; Load Gender, date of birth and SSN into output
 S GENDER=$P(VADM(5),"^") I GENDER'="M",GENDER'="F" D
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Gender invalid") Q
 S DOB=$$CONVDATE($P(VADM(3),"^")) D:'DOB
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Date of Birth invalid") Q
 S X=$E(VADM(2),1,9) I X]"",X'?9N D
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - SSN invalid") Q
 I 'QACI0 S $P(PATSDATA,"^",11,14)=GENDER_"^"_DOB_"^"_X_"^0"
 S PATX=$E(VADM(2),10) I PATX="P",'QACI0 S $P(PATSDATA,"^",14)=1
 ; Get eligibility data, load eligibility code and enrollment priority
 ; period of service, is service connected, svc.connected %
 ; and category into output  (IA #10061)
 D ELIG^VADPT
 S X=$P(VAEL(1),"^",2)
 I $P(VAEL(1),"^"),X="" D
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Primary Eligibility Code pointer invalid") Q
 I $$TXTERR^QACI2C(X,30) D
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Primary Eligibility Code invalid") Q
 I 'QACI0 S $P(PATSDATA,"^",15,16)=X_"^"_PATSENRL
 ; Load period of service, is service connected, svc.connected %
 ; and category into output node 2.
 S X=$P(VAEL(2),"^",2)
 I $P(VAEL(2),"^"),X="" D
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Period of Service pointer invalid") Q
 I $$TXTERR^QACI2C(X,25) D
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Period of Service invalid") Q
 I 'QACI0 S PATSDAT2="2^"_X
 S X=$P(VAEL(3),"^") I X'=1,X'=0 D
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Is Service Connected Flag invalid") Q
 I 'QACI0 S $P(PATSDAT2,"^",3)=X
 S X=$P(VAEL(3),"^",2) D:X]""
 . I X'?1.3N!(X<0)!(X>100) S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Service Connected % invalid")
 . Q
 I 'QACI0 S $P(PATSDAT2,"^",4)=X
 ; Add CATEGORY (Current Means Test Status)
 S X=$P($G(^DPT(DFN,0)),"^",14) I X,'$D(^DG(408.32,X,0)) D
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Current Means Test Status pointer invalid") Q
 S X=$P(VAEL(9),"^",2)
 I X]"",$L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E)!(X'?.ANP) D
 . S PATSERR=1 D ERREF^QACI2C("PT",DFN,DSPNAME_" - Current Means Test Status invalid") Q
 I 'QACI0 S $P(PATSDAT2,"^",5)=X
 ; Add Ethnicity and Race information to output (IA #3799)
 D RACETH^QACVDEM(.VADM,.RACE,.ETH)
 I ETH]"" S $P(PATSDAT2,"^",6)=ETH
 S X=6
 F I=0:0 S I=$O(RACE(I)) Q:'I  D
 . S X=X+1
 . S $P(PATSDAT2,"^",X)=RACE(I)
 . Q
 ; Quit if any errors occurred
 I PATSERR=1 Q
 ; Put data into table for output.
 S ^XTMP("QACMIGR","PT","U",DFN)=PATSDATA
 S ^XTMP("QACMIGR","PT","U",DFN,"cont")=PATSDAT2
 S PATSCNT("PT")=PATSCNT("PT")+1
 Q
 ;
ELIGCAT(ELIGSTAT,CATEGORY,ROC0) ; Get Patient Eligibility Status and Category from ROC
 S ELIGSTAT=$P(ROC0,"^",4) D:ELIGSTAT]""
 . I $$TXTERR^QACI2C(ELIGSTAT,30) D ERROC^QACI2A(OLDROC,"ELIGIBILITY STATUS is invalid")
 . Q
 S CATEGORY=$P(ROC0,"^",5) D:CATEGORY]""
 . I $$TXTERR^QACI2C(CATEGORY,30) D ERROC^QACI2A(OLDROC,"CATEGORY (current means test) is invalid")
 . Q
 Q
 ;
USERDATA(STATION,IEN,USERTYPE,QACI0,PATSERR,PATSCNT) ; Load pats_user data for migration
 S PATSERR=0
 N UTYPE S UTYPE=$S(USERTYPE="U":"USER",1:"EMPINV")
 Q:$D(^XTMP("QACMIGR",UTYPE,"D",IEN))
 Q:$D(^XTMP("QACMIGR",UTYPE,"U",IEN))
 I $D(^XTMP("QACMIGR",UTYPE,"E",IEN)) S PATSERR=1 Q
 N IENS,EMPDATA,DSPNAME,NAMECOMP,NAMEJ,TITLE,MAILCODE,NMERR
 S IENS=IEN_",",EMPDATA=""
 S DSPNAME=$P($G(^VA(200,+$G(IEN),0)),"^")
 I $L(DSPNAME)>30 S DSPNAME=$E(DSPNAME,1,30)_"..."
 ; Get user name, pointer to name componentents, title and mail code (IA #10060)
 I USERTYPE="E" D
 . D GETS^DIQ(200,IENS,"8;28","IE","EMPDATA")
 . S X=$P($G(^VA(200,IEN,0)),"^",9) I X,'$D(^DIC(3.1,X,0)) D
 .. S PATSERR=1 D ERREF^QACI2C("EMPINV",IEN,DSPNAME_" - Title pointer invalid")
 . S TITLE=$E($G(EMPDATA(200,IENS,8,"E")),1,30)
 . S MAILCODE=$E($G(EMPDATA(200,IENS,28,"E")),1,10)
 . I $$TXTERR^QACI2C(TITLE) S PATSERR=1 D ERREF^QACI2C("EMPINV",IEN,DSPNAME_" - Title invalid")
 . I $$TXTERR^QACI2C(MAILCODE) S PATSERR=1 D ERREF^QACI2C("EMPINV",IEN,DSPNAME_" - Mail Code invalid")
 . Q
 ; Load User IEN and station number into output
 I 'QACI0 S EMPDATA=IEN_"^"_STATION_"^"
 ; Get name components (IA #3065)
 S NAMECOMP("FILE")=200,NAMECOMP("FIELD")=.01,NAMECOMP("IENS")=IENS
 S NAMECOMP=$$HLNAME^XLFNAME(.NAMECOMP)
 S NMERR=0
 F NAMEJ=1:1:6 D
 . S X=$P(NAMECOMP,"^",NAMEJ) I NAMEJ>2,X="" Q
 . I X'?.ANP S NMERR=1 Q
 . I NAMEJ=1,$$TXTERR^QACI2C(X,35,0,1) S NMERR=1 Q
 . I NAMEJ=2,$$TXTERR^QACI2C(X,25,0,1) S NMERR=1 Q
 . I NAMEJ=3,$$TXTERR^QACI2C(X,25) S NMERR=1 Q
 . I NAMEJ>3,$$TXTERR^QACI2C(X,10) S NMERR=1 Q
 . I 'QACI0 S $P(EMPDATA,"^",NAMEJ+2)=X
 . Q
 I NMERR=1 D NAMERR
 Q:PATSERR=1
 I 'QACI0,USERTYPE="E" S $P(EMPDATA,"^",9)=TITLE,$P(EMPDATA,"^",10)=MAILCODE
 S ^XTMP("QACMIGR",UTYPE,"U",IEN)=EMPDATA
 S PATSCNT(UTYPE)=PATSCNT(UTYPE)+1
 Q
 ;
CONVDATE(OLDDATE) ; Convert data to MM/DD/YYYY format
 N MM,DD S MM=$E(OLDDATE,4,5),DD=$E(OLDDATE,6,7)
 S:MM="00" MM="01"
 S:DD="00" DD="01"
 S OLDDATE=$E(OLDDATE,1,3)_MM_DD
 Q $$FMTE^XLFDT(OLDDATE,5)
 ;
NAMERR ;
 N X S X="Name invalid"
 I $G(DSPNAME)]"" S X=DSPNAME_" - "_X
 S PATSERR=1 D ERREF^QACI2C(UTYPE,IEN,X)
 Q
 ;
