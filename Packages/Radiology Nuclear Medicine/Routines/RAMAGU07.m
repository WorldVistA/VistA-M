RAMAGU07 ;HCIOFO/SG - ORDERS/EXAMS API (PATIENT UTILITIES) ; 1/25/08 2:35pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** RETURNS SERVICE, WARD, AND BEDSECTION FOR INPATIENT
 ;
 ; RADFN         Patient IEN (in file #2)
 ;
 ; [.RASERV]     Service is returned via this parameter:
 ;                 ^01: IEN in the SERVICE/SECTION file (#49)
 ;                 ^02: Service name (value of the .01 field)
 ;
 ; [.RABED]      Bedsection is returned via this parameter:
 ;                 ^01: IEN in the SPECIALTY file (#42.4)
 ;                 ^02: Bedsection name (value of the .01 field)
 ;
 ; [.RAWARD]     Ward is returned via this parameter:
 ;                 ^01: IEN in the WARD LOCATION file (#42)
 ;                 ^02: Ward name (value of the .01 field)
 ;
 ; [RADTE]       Date/time to check for inpatient status (FileMan).
 ;               By default ($G(RADATE)'>0), current date/time is
 ;               assumed.
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
RAINP(RADFN,RASERV,RABED,RAWARD,RADTE) ;
 N IENS,RABUF,RAMSG,RC,TMP,VAIP
 S (RABED,RASERV,RAWARD)=""
 ;
 ;=== Get inpatient data
 S:$G(RADTE)>0 VAIP("D")=+RADTE
 S RC=$$VAIN5(.RADFN)  Q:RC<0 RC
 ;
 ;=== Ward
 S:$G(VAIP(5))>0 RAWARD=$P(VAIP(5),U,1,2)
 ;
 ;=== Service and Bedsection
 S IENS=+$G(VAIP(8))_","  ; Treating specialty
 I IENS>0  D
 . D GETS^DIQ(45.7,IENS,"1;2","EI","RABUF","RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,45.7,IENS)  Q
 . ;--- Bedsection
 . S TMP=+$G(RABUF(45.7,IENS,1,"I"))
 . S:TMP>0 RABED=TMP_U_$G(RABUF(45.7,IENS,1,"E"))
 . ;--- Service
 . S TMP=+$G(RABUF(45.7,IENS,2,"I"))
 . S:TMP>0 RASERV=TMP_U_$G(RABUF(45.7,IENS,2,"E"))
 E  I RAWARD>0  D
 . ;--- Get name of the service
 . S IENS=(+RAWARD)_","
 . S TMP=$$GET1^DIQ(42,IENS,.03,,,"RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,42,IENS)  Q
 . ;--- Try to find the name in the SERVICE/SECTION file
 . D FIND^DIC(49,,"@;.01","X",TMP,2,"B",,,"RABUF","RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,49)  Q
 . ;--- Process the search results
 . Q:+$G(RABUF("DILIST",0))'=1
 . S TMP=+$G(RABUF("DILIST",2,1))
 . S:TMP>0 RASERV=TMP_U_$G(RABUF("DILIST","ID",1,.01))
 ;
 ;===
 Q $S(RC<0:RC,1:0)
 ;
 ;***** CALLS THE DEM^VADPT
 ;
 ; DFN           Patient IEN (in file #2)
 ;
 ; [VALIDATE]    Make sure that required fields are not empty
 ; [VAPTYP]      See the DEM^VADPT description
 ; [VAHOW]       See the DEM^VADPT description
 ;
 ; Output variables (see the DEM^VADPT description):
 ;   VA, VADM
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
VADEM(DFN,VALIDATE,VAPTYP,VAHOW) ;
 N A,I,J,K,K1,NC,NF,NQ,T,VAC,VAERR,VAN,VAROOT,VAS,VAV,VAW,VAX,VAZ,X,Y,Z
 Q:$G(DFN)'>0 $$IPVE^RAERR("DFN")
 D DEM^VADPT
 Q:$G(VAERR) $$IPVE^RAERR("DFN")
 ;--- Make sure that required fields are not empty
 D:$G(VALIDATE)
 . S:$G(VADM(1))="" VADM(1)="Unknown ("_DFN_")"
 . S:$G(VA("BID"))="" VA("BID")="UNKN"
 ;--- Success
 Q 0
 ;
 ;***** CALLS THE IN5^VADPT
 ;
 ; DFN           Patient IEN (in file #2)
 ;
 ; [VAHOW]       See the IN5^VADPT description
 ;
 ; Input variables (see the IN5^VADPT description):
 ;   VAIP
 ;
 ; Output variables (see the IN5^VADPT description:
 ;   VAIP
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
VAIN5(DFN,VAHOW) ;
 N A,I,J,K,K1,NC,NF,NQ,T,VAAP,VAC,VACA,VACA0,VADT,VADX,VAERR,VAID,VAMT,VAMV,VAMV0,VAMVT,VAN,VANOW,VAPP,VARM,VAROOT,VAS,VATS,VAV,VAW,VAWD,VAX,VAZ,X,Y
 Q:$G(DFN)'>0 $$IPVE^RAERR("DFN")
 D IN5^VADPT
 Q:$G(VAERR) $$IPVE^RAERR("DFN")
 ;--- Success
 Q 0
