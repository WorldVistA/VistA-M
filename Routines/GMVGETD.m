GMVGETD ;HOIFO/YH,FT-EXTRACTS WARD/ROOM-BED/PT AND PT VITALS ;5/10/07
 ;;5.0;GEN. MED. REC. - VITALS;**3,22,23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ; #1380  - ^DG(405.4 references   (controlled)
 ; #1377  - ^DIC(42 references     (controlled)
 ; #4290  - ^PXRMINDX global       (controlled)
 ; #10035 - FILE 2 references      (supported)
 ; #10039 - FILE 42 references     (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ; #10104 - ^XLFSTR calls          (supported)
 ;
 ; This routine supports the following IAs:
 ; #4416 - GMV EXTRACT REC RPC is called at GETVM  (private)
 ; #4358 - GMV LATEST VM RPC is called at GETLAT (private)
 ;
GETVM(RESULT,GMRVDATA) ;GMV EXTRACT REC [RPC entry point]
 ; Returns data particular patient and date/time range in RESULT
 ; GMRVDATA = DFN^END DATE VITAL TAKEN^VITAL TYPE (OPTIONAL)^START DATE VITAL TAKEN
 N DFN,GMVEND,GMVSTART,GMVTYPE
 S DFN=+$P(GMRVDATA,U,1),GMVEND=+$P(GMRVDATA,U,2),GMVSTART=$P(GMRVDATA,U,4),GMVTYPE=$P(GMRVDATA,U,3)
 K ^TMP($J,"GRPC")
 S:GMVEND="" GMVEND=$$NOW^XLFDT()
 I $P(GMVEND,".",2)'>0 S GMVEND=$P(GMVEND,".",1)_".235959"
 I GMVSTART="" S GMVSTART=0
 S:GMVTYPE'="" GMVTYPE(1)=$P(^GMRD(120.51,$O(^GMRD(120.51,"C",GMVTYPE,0)),0),"^")
 D EN1^GMVGETD1
 I '$D(^TMP($J,"GRPC")) S ^TMP($J,"GRPC",1)="0^NO "_$S(GMVTYPE'="":GMVTYPE(1),1:"VITALS/MEASUREMENTS ")_" ENTERED WITHIN THIS PERIOD"
 S RESULT=$NA(^TMP($J,"GRPC"))
 K GMRDT,GMRVARY,GMRVITY,GMRVX,GMRZZ
 Q
GETLAT(RESULT,GMRDFN) ;GMV LATEST VM [RPC entry point]
 ; RETURNS THE LATEST VITALS/MEASUREMENTS FOR A GIVEN PATIENT(GMRDFN)
 ; IN RESULT ARRAY.
 K ^TMP($J,"GRPC") D EN1^GMVLAT0(GMRDFN)
 S RESULT=$NA(^TMP($J,"GRPC"))
 Q
WARDLOC(RESULT,DUMMY) ;GMV WARD LOCATION [RPC entry point]
 ;RETURNS MAS WARD LOCATIONS IN RESULT ARRAY
 K ^TMP($J,"GWARD"),^TMP($J,"GMRV") N GMRWARD,GINDEX,GN,GMR
 S DUMMY=$G(DUMMY)
 S DUMMY=$$UP^XLFSTR(DUMMY)
 S DUMMY=$S(DUMMY="P":"P",1:"A")
 D LIST^DIC(42,"","","","*","","","","I '$$INACT42^GMVUT2(+Y)",,"^TMP($J,""GMRV"")")
 S GINDEX=+$P($G(^TMP($J,"GMRV","DILIST",0)),"^")
 I GINDEX>0 D
 . S (GMR,GN)=0 F  S GN=$O(^TMP($J,"GMRV","DILIST",1,GN)) Q:GN'>0  D
 . . S GMRWARD(1)=^TMP($J,"GMRV","DILIST",1,GN),GMRWARD=+^TMP($J,"GMRV","DILIST",2,GN)
 . . I DUMMY="P" D  Q
 . . . I $O(^DPT("CN",GMRWARD(1),0))>0 S GMR=GMR+1,^TMP($J,"GWARD",GMR)=GMRWARD_"^"_GMRWARD(1)_U_^DIC(42,GMRWARD,44)
 . . I DUMMY="A" D
 . . . S GMR=GMR+1,^TMP($J,"GWARD",GMR)=GMRWARD_"^"_GMRWARD(1)_U_^DIC(42,GMRWARD,44)
 K ^TMP($J,"GMRV") S RESULT=$NA(^TMP($J,"GWARD"))
 Q
WARDPT(RESULT,GMRWARD) ;GMV WARD PT [RPC entry point]
 ;RETURNS A LIST OF PATIENTS ADMITTED TO A GIVEN MAS WARD(GMRWARD) IN RESULT ARRAY.
 Q:'$D(^DPT("CN",GMRWARD))
 N OUT,GN,DFN,DFN1,GMVPAT
 K ^TMP($J,"GMRPT")
 S (GN,DFN)=0 F  S DFN=$O(^DPT("CN",GMRWARD,DFN)) Q:DFN'>0  D
 . I $D(^DPT(DFN,0)) D
 . . S GMVPAT=""
 . . D PTINFO^GMVUTL3(.GMVPAT,DFN)
 . . S OUT($P(^DPT(DFN,0),"^"),DFN)=DFN_"^"_$P(^DPT(DFN,0),"^")_"^"_GMVPAT
 I '$D(OUT) Q
 S DFN=""
 F  S DFN=$O(OUT(DFN)) Q:DFN=""  D
 .S DFN1=0
 .F  S DFN1=$O(OUT(DFN,DFN1)) Q:'DFN1  D
 ..S GN=GN+1,^TMP($J,"GMRPT",GN)=OUT(DFN,DFN1)
 ..Q
 .Q
 S RESULT=$NA(^TMP($J,"GMRPT"))
 Q
ROOMBED(RESULT,GMRWARD) ;GMV ROOM/BED [RPC entry point]
 ;RETURNS A LIST OF ROOMS/BEDS FOR A GIVEN MAS WARD(GMRWARD) IN RESULT ARRAY.
 Q:'$D(^DIC(42,"B",GMRWARD))
 N GN,GROOM,GWARD,GMVTMP K ^TMP($J,"GROOM")
 S (GN,GROOM)=0,GWARD=$O(^DIC(42,"B",GMRWARD,0)) I GWARD'>0 S ^TMP($J,"GROOM",1)="NO ROOM" G QUIT
 F  S GROOM=$O(^DG(405.4,"W",GWARD,GROOM)) Q:GROOM'>0  I $D(^DG(405.4,GROOM)) D 
 . S GMVTMP($P($P(^DG(405.4,GROOM,0),"^"),"-",1))=GROOM
 . ;S GN=GN+1,^TMP($J,"GROOM",GN)=GROOM_"^"_$P(^DG(405.4,GROOM,0),"^")
 . Q
 S GROOM="",GN=0
 F  S GROOM=$O(GMVTMP(GROOM)) Q:GROOM=""  D
 . S GN=GN+1,^TMP($J,"GROOM",GN)=GMVTMP(GROOM)_"^"_GROOM
 . Q
QUIT S RESULT=$NA(^TMP($J,"GROOM"))
 Q
CLOSEST(RESULT,GMVDFN,GMVDT,GMVT,GMVFLAG) ; GMV CLOSEST READING [RPC entry point]
 ; Get nearest reading to date(/time) provided
 ;  Input:  GMVDFN - DFN (required)
 ;           GMVDT - FileMan date/time (optional)
 ;                   Default is NOW
 ;            GMVT - Vital Type abbreviation, FILE 120.51, Field 1 (required)
 ;         GMVFLAG - Where to look (optional)
 ;                   0 = either before or after GMVDT  (default)
 ;                   1 = before GMVDT
 ;                   2 = after GMVDT
 ; Output: RESULT - piece1^piece2
 ;          where piece1 = date/time of reading (FileMan internal format)
 ;                piece2 = reading
 ; If no records found piece 1 = -2
 ;                 and piece 2 = message text                     
 ; If an error was encountered piece1 = -1
 ;                         and piece2 = error message
 ;
 N GMVADIFF,GMVADT,GMVAVAL,GMVBDIFF,GMVBDT,GMVBVAL,GMVDATA,GMVTI
 S GMVDFN=+$G(GMVDFN),GMVDT=+$G(GMVDT),GMVT=$G(GMVT),GMVFLAG=+$G(GMVFLAG)
 S GMVFLAG=$S(GMVFLAG=2:2,GMVFLAG=1:1,1:0)
 I 'GMVDFN S RESULT="-1^DFN not defined" Q
 I '$D(^PXRMINDX(120.5,"PI",GMVDFN)) S RESULT="-2^Patient has no Vitals data on file" Q
 I 'GMVDT S GMVDT=$$NOW^XLFDT()
 I GMVT="" S RESULT="-1^Vital Type not defined" Q
 S GMVTI=$$GETIEN^GMVGETVT(GMVT,2)
 I 'GMVTI S RESULT="-1^Vital Type not found" Q
 I '$D(^PXRMINDX(120.5,"PI",GMVDFN,GMVTI)) S RESULT="-2^Patient has no data on file for this type" Q
 S (GMVADT,GMVAVAL,GMVBDT,GMVBVAL,GMVDATA)=""
 I GMVFLAG=0!(GMVFLAG=1) D
 .S GMVDATA=$$FIND(GMVDFN,GMVTI,GMVDT,0,-1)
 .S GMVBDT=$P(GMVDATA,U,1),GMVBVAL=$P(GMVDATA,U,2)
 S GMVDATA=""
 I GMVFLAG=0!(GMVFLAG=2) D
 .S GMVDATA=$$FIND(GMVDFN,GMVTI,GMVDT,0,1)
 .S GMVADT=$P(GMVDATA,U,1),GMVAVAL=$P(GMVDATA,U,2)
 I GMVFLAG=1 D
 .I GMVBDT'>0 S RESULT="-2^Before date not found" Q
 .I GMVBVAL="" S RESULT="-2^Before value not found" Q
 .S RESULT=GMVBDT_U_GMVBVAL
 I GMVFLAG=2 D
 .I GMVADT'>0 S RESULT="-2^After date not found" Q
 .I GMVAVAL="" S RESULT="-2^After value not found" Q
 .S RESULT=GMVADT_U_GMVAVAL
 I GMVFLAG=0 D
 .I GMVADT'>0,GMVBDT'>0 D  Q
 ..S RESULT="-2^No records found"
 .I GMVADT'>0,GMVBDT>0 D  Q
 ..S:GMVBVAL]"" RESULT=GMVBDT_U_GMVBVAL
 ..S:GMVBVAL="" RESULT="-2^No records found"
 .I GMVADT>0,GMVBDT'>0 D  Q
 ..S:GMVAVAL]"" RESULT=GMVADT_U_GMVAVAL
 ..S:GMVAVAL="" RESULT="-2^No records found"
 .I GMVADT>0,GMVBDT>0 D
 ..S GMVBDIFF=+$$FMDIFF^XLFDT(GMVDT,GMVBDT,2)
 ..S GMVADIFF=+$$FMDIFF^XLFDT(GMVADT,GMVDT,2)
 ..I GMVBDIFF<GMVADIFF S RESULT=GMVBDT_U_GMVBVAL
 ..I GMVADIFF<GMVBDIFF S RESULT=GMVADT_U_GMVAVAL
 ..I GMVADIFF=GMVBDIFF S RESULT=GMVADT_U_GMVAVAL
 Q
FIND(GMVDFN,GMVTI,GMVSDT,GMVX,GMVDIR) ; Get nearest record from GMVSDT date/time
 ;  Input:  GMVDFN - DFN (required)
 ;           GMVTI - Vital Type (120.51) IEN (required)
 ;          GMVSDT - FileMan date/time (optional)
 ;                   Default is NOW
 ;            GMVX - Return numeric values only or all values including
 ;                   text (optional)
 ;                   0 = numeric values only (default)
 ;                   1 = all values including text
 ;          GMVDIR - direction of search (required)
 ;                   -1 = look before GMVSDT
 ;                    1 = look after GMVSDT
 ; Output:    GMVY - piece1^piece2
 ;                   where piece1 = date/time of reading (FileMan internal format)
 ;                piece2 = reading
 ; If an error was encountered piece1 = -1
 ;                         and piece2 = error message
 ;
 N GMVARR,GMVFLAG,GMVIEN,GMVY
 S GMVDFN=+$G(GMVDFN),GMVTI=+$G(GMVTI),GMVSDT=+$G(GMVSDT),GMVX=+$G(GMVX),GMVDIR=$G(GMVDIR)
 S GMVDIR=$S(GMVDIR=-1:-1,GMVDIR=1:1,1:"")
 I GMVDIR="" Q "-1^Direction of search not defined"
 I 'GMVTI Q "-1^Vital Type not defined"
 S GMVX=$S(GMVX=1:1,1:0)
 I 'GMVDFN Q "-1^Patient not defined"
 I '$D(^PXRMINDX(120.5,"PI",GMVDFN)) Q "-1^Patient has no Vitals data on file"
 I 'GMVSDT S GMVSDT=$$NOW^XLFDT()
 S (GMVFLAG,GMVIEN)=0,GMVY=""
 F  S GMVSDT=$O(^PXRMINDX(120.5,"PI",GMVDFN,GMVTI,GMVSDT),GMVDIR) Q:'GMVSDT!(GMVFLAG)  D
 .S GMVIEN=0
 .F  S GMVIEN=$O(^PXRMINDX(120.5,"PI",GMVDFN,GMVTI,GMVSDT,GMVIEN)) Q:$L(GMVIEN)'>0!(GMVFLAG)  D
 ..I GMVIEN=+GMVIEN D
 ...D F1205^GMVUTL(.GMVARR,GMVIEN,0)
 ..I GMVIEN'=+GMVIEN D
 ...D CLIO^GMVUTL(.GMVARR,GMVIEN)
 ..S GMVARR(0)=$G(GMVARR(0))
 ..Q:$P(GMVARR(0),U,8)=""
 ..Q:$P(GMVARR(0),U,1)'>0
 ..I GMVX=1 D
 ...S GMVY=$P(GMVARR(0),U,1)_U_$P(GMVARR(0),U,8),GMVFLAG=1
 ..I 'GMVX D
 ...I "UNAVAILABLEPASSREFUSED"[$$UP^XLFSTR($P(GMVARR(0),U,8)) Q
 ...S GMVY=$P(GMVARR(0),U,1)_U_$P(GMVARR(0),U,8),GMVFLAG=1
 I GMVY="" S GMVY="-1^No record found"
 Q GMVY
 ;
