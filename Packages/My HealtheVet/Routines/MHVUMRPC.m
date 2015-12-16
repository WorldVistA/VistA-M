MHVUMRPC ;KUM - myHealtheVet Management Utilities ; 6/18/2013
 ;;1.0;My HealtheVet;**11**;June 18, 2013;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
 ;  Integration Agreements:
 ;
 ;                5266 : ^SC(D0
 ;                6013 : ^ECD(D0
 ;                2051 : LIST^DIC
 ;                6009 : ^ECJ(D0
 ;                6009 : ^ECJ("AP"
 ;                6010 : Event Capture API $$ELIG^ECUERPC
 ;                6011 : Event Capture API $$PATCLAST^ECUERPC1
 ;                6016 : Event Capture API $$SRCLST^ECUMRPC1
 ;                2701 : $$GETDFN^MPIF001
 ;                1874 : ^EC(725,D0
 ;                1873 : Read File 721
 ;                2741 : OE/RR Calls to GMPLUTL2
 ;                1995 : CPT Code APIs
 ;                3990 : ICD Code APIs
 ;                6155 : Read access to DMMS Units in NEW PERSON File 
 ;               10004 : $$GET1^DIQ
 ;
 Q
DSSUNT(RESULTS,MHVSTRING) ;
 ;
 ;This broker entry point returns DSS units from file 724
 ;        RPC: MHV GETDSSUNIT
 ;INPUTS         MHVARY - Contains the following subscripted elements
 ;                ACLNIEN   - Associated Clinic IEN (required) and PRVDUZ - Provider
 ;               
 ;OUTPUTS        RESULTS - Array of DSS units. Data pieces as follows:-
 ;               PIECE - Description
 ;                 1     IEN of Location
 ;                 2     Name of Location
 ;                 3     IEN of DSS Unit
 ;                 4     Name of DSS Unit
 ;                 5     Inactive flag (1-Yes/0-No)
 ;                 6     Send to PCE flag
 ;
 N MHVLIEN,MHVLNAM,MHVCIEN,MHVDIEN,MHVDNAM,MHVCNT,MHVDIACT,MHVCHKF,MHVDPCE,MHVR1,MHVR1E,MHVR1C,MHVDIV,MHVDIVN
 S MHVCNT=0
 S MHVDPCE=0
 S MHVCIEN=+$P(MHVSTRING,"^",1)
 S MHVPDUZ=+$P(MHVSTRING,"^",2)
 K ^TMP($J,"MHVDUNT")
 ; Fetch Location IEN and Location Name
 I '$D(^SC(MHVCIEN,0)) S RESULTS(1)="0^DSS1-No clinic for IEN:"_MHVCIEN Q
 S MHVLIEN=$$GET1^DIQ(44,+MHVCIEN,3,"I")
 S MHVLNAM=$$GET1^DIQ(44,+MHVCIEN,3,"E")
 S MHVDIV=$$GET1^DIQ(44,+MHVCIEN,3.5,"I")
 S MHVDIVN=$$GET1^DIQ(44,+MHVCIEN,3.5,"E")
 I +$G(MHVLIEN)=0 S RESULTS(1)="0^DSS1-No Institution found for clinic IEN:"_MHVCIEN Q
 I $G(MHVLNAM)="" S RESULTS(1)="0^DSS1-No Institution found for clinic IEN:"_MHVCIEN Q
 I +$G(MHVDIV)=0 S RESULTS(1)="0^DSS2-No Division found for clinic IEN:"_MHVCIEN Q
 I $G(MHVDIVN)="" S RESULTS(1)="0^DSS2-No Divison found for clinic IEN:"_MHVCIEN Q 
 ; Fetch DSS Unit IEN from file #200
 D LIST^DIC(200.72,","_MHVPDUZ_",","@","QP","","","","","","","MHVR1","MHVR1E")
 I $G(MHVR1("DILIST",0))'>0 S RESULTS(1)="0^DSS3-No DSS Units found in New Person File" Q
 D:$G(MHVR1("DILIST",0))>0
 . S MHVR1C=0
 . F  S MHVR1C=$O(MHVR1("DILIST",MHVR1C))  Q:MHVR1C'>0  D
 . . S MHVDIEN=$G(MHVR1("DILIST",MHVR1C,0))
 . . I +$G(MHVDIEN)'>0 Q
 . . S MHVDNAM=$$GET1^DIQ(724,+MHVDIEN,.01)
 . . S MHVDIACT=$$GET1^DIQ(724,+MHVDIEN,5,"I")
 . . S MHVDPCE=$$GET1^DIQ(724,+MHVDIEN,13,"I")
 . . D MHVCHK
 . . I (+$G(MHVDIACT)=1)!(MHVCHKF=1)!('$D(^ECJ("AP",MHVLIEN,MHVDIEN))) Q 
 . . D MHVRST
 I MHVCNT=0 S RESULTS(1)="0^DSS4-No DSS Units found (Missing Event Code Screen) clinic IEN:"_MHVCIEN Q
 Q
MHVRST ;Populate results array
 S MHVCNT=MHVCNT+1
 S RESULTS(MHVCNT)=$G(MHVLIEN)_"^"_$G(MHVLNAM)_"^"_$G(MHVDIEN)_"^"_$G(MHVDNAM)_"^"_$G(MHVDIACT)_"^"_$G(MHVDPCE)
 Q
MHVCHK ;Check if DSS Unit is already populated in results array
 S MHVCHKF=0
 S MHVI=0 F  S MHVI=$O(^TMP($J,"MHVDUNT",MHVI)) Q:'MHVI!MHVCHKF  D
 . I MHVDIEN=$P(^TMP($J,"MHVDUNT",MHVI),"^",3) S MHVCHKF=1
 Q
PRINTRES ; Print Results
 S I="" F  S I=$O(@RESULTS@(I)) Q:I=""  D
 . W !,"LOCATIONIEN LOCATIONNAME DSSUNITIEN DSSUNITNAME INACTIVE"
 . W !,@RESULTS@(I)
 Q
DSSPROCS(RESULTS,MHVARY) ; Get Procedures from DSS Unit IEN and Locaiton IEN
 ; MHVARY IS DSS UNIT IEN AND LOCATION IEN
 ; RESULTS = Procedure IEN^Procedure 5 digit code and description^synonym^Active flag
 N MHVLOC,MHVECD,MHVCAT,MHVPX,MHVIEN,MHVNODE,MHVPRO,MHVSYN,MHVPN,MHVSTAT,MHVCNT
 S MHVLOC=+$P(MHVARY,"^",1)
 S MHVECD=+$P(MHVARY,"^",2)
 S MHVCNT=0
 S MHVCAT="" F  S MHVCAT=$O(^ECJ("AP",MHVLOC,MHVECD,MHVCAT)) Q:MHVCAT=""  D
 . S MHVPX="" F  S MHVPX=$O(^ECJ("AP",MHVLOC,MHVECD,MHVCAT,MHVPX)) Q:MHVPX=""  S MHVIEN=0 D
 ..F  S MHVIEN=$O(^ECJ("AP",MHVLOC,MHVECD,MHVCAT,MHVPX,MHVIEN)) Q:'MHVIEN  D
 ...S MHVNODE=$G(^ECJ(MHVIEN,0)) I MHVNODE="" Q
 ...S MHVPRO=$G(^ECJ(MHVIEN,"PRO")),MHVSYN=$P(MHVPRO,U,2),MHVPN=$P($P(MHVPRO,U),";")
 ...I $G(MHVPN)="" Q
 ...I $P(MHVPRO,U)["EC" S MHVPN=$G(^EC(725,MHVPN,0)),MHVPRO=$P(MHVPN,U,2)_" "_$P(MHVPN,U)
 ...E  S MHVPN=$$CPT^ICPTCOD(MHVPN) S MHVPRO=$P(MHVPN,U,2)_" "_$P(MHVPN,U,3)
 ...S MHVSTAT=$S($P(MHVNODE,U,2)'="":"No",1:"Yes")
 ...; STATUS (Y-Active/N-Inactive)
 ...I $G(MHVSTAT)="No" Q
 ...S MHVCNT=MHVCNT+1
 ...S RESULTS(MHVCNT)=$G(MHVPX)_U_$P($G(MHVPN),U)_U_$P($G(MHVPN),U,2)_U_$G(MHVSYN)_U_$G(MHVSTAT)
 I MHVCNT=0 S RESULTS(1)="0^No Procedures found for DSS Unit IEN:"_MHVECD_" and Location IEN:"_MHVLOC Q
 Q
PATECLS(RESULTS,MHVSTRING) ; Get Patient eligibility and Classification data
 ; MHVSTRING IS PATIENT ICN, DSS UNIT IEN, PROCEDURE DATE AND TIME IN FILEMAN FORMAT
 ; RESULTS = PATIENT STATUS ^CLASSIFICATION DATA (AGENT ORANCE, IONIZING RADIATION, SC CONDITION, ENVIRONMENTAL CONTAMINANTS, MILITARY SEXUAL TRUMA
 ; RESULTS(1,2...)=PRIMARY/SECONDARY FLAG (1-PRIMARY,0-SECONDARY)^ELIGIBILITY IEN^ELIGIBILITY DESCRIPTION
 N MHVPIEN,MHVECD,MHVPDT,MHVI,MHVCNT,MHVPICN
 ; Get Patient IEN from Patient ICN
 S MHVPICN=+$P(MHVSTRING,"^",1)
 I $G(MHVPICN)'>0 S RESULTS(1)="0^No Patient ICN" Q
 S MHVPIEN=$$GETDFN^MPIF001(MHVPICN)
 I $P($G(MHVPIEN),"^",1)=-1 S RESULTS(1)="0^Patient ICN not in Database" Q
 ;
 S $P(MHVSTRING,"^",1)=MHVPIEN
 S MHVECD=$P(MHVSTRING,"^",2)
 S MHVPDT=$P(MHVSTRING,"^",3)
 ; GET PATIENT ELIGIBILITY
 S ECARY=$G(MHVPIEN)
 D ELIG^ECUERPC(.RESULTS,.ECARY)
 I $G(RESULTS)="" S RESULTS(1)="0^No Eligibility codes found for Patient DFN:"_MHVPIEN Q 
 S MHVCNT=0
 S MHVI="" F  S MHVI=$O(@RESULTS@(MHVI)) Q:MHVI=""  D
 . S MHVCNT=MHVCNT+1
 . S RESULTS(MHVCNT)=@RESULTS@(MHVI)
 I MHVCNT=0 S RESULTS(1)="0^No Eligibility codes found for Patient DFN:"_MHVPIEN Q 
 ; GET PATIENT CLASSIFICATION DATA
 S ECARY=MHVSTRING
 S RESULTS=""
 D PATCLAST^ECUERPC1(.RESULTS,.ECARY)
 S RESULTS(0)=RESULTS
 I RESULTS="" S RESULTS(1)="0^No Classification data found for Patient DFN:"_MHVPIEN Q
 Q
DIAGPL(RESULTS,MHVSTRING) ; Get Patient Diagnosis codes from Patient Probelm list
 ; MHVSTRING IS PATIENT ICN
 ; RESULTS = DIAGNOSIS CODE IEN^DIAGNOSIS CODE^DESCRIPTION
 N MHVPIEN,MHVPICN,MHVCNT
 ; Get Patient IEN from Patient ICN
 S MHVPICN=+$P(MHVSTRING,"^",1)
 I $G(MHVPICN)'>0 S RESULTS(1)="0^No Patient ICN" Q
 S MHVPIEN=$$GETDFN^MPIF001(MHVPICN)
 I $P($G(MHVPIEN),"^",1)=-1 S RESULTS(1)="0^Patient ICN not in Database" Q
 ;
 S $P(MHVSTRING,"^",1)=$G(MHVPIEN)
 K MHVROOT
 D LIST^GMPLUTL2(.MHVROOT,MHVPIEN,"A")
 I $G(MHVROOT(0))<1 S RESULTS(1)="0^No Diagnosis codes found in Patient Problem List" Q
 S MHVCNT=0
 F  S MHVCNT=MHVCNT+1 Q:MHVCNT>$G(MHVROOT(0))  D
 . S MHVDCOD=$P($P(MHVROOT(MHVCNT),"^",4),"/",1)
 . S MHVDIEN=$P($$CODEN^ICDCODE(MHVDCOD,80),"~",1)
 . S RESULTS(MHVCNT)=$G(MHVDIEN)_"^"_$G(MHVDCOD)_"^"_$P(MHVROOT(MHVCNT),"^",3)
 Q
DIAGSRCH(RESULTS,MHVSTRING) ; Get Diagnosis codes and description from Search string
 ; MHVSTRING IS SEARCH STRING AND FILE TO SEARCH
 ; RESULTS = DIAGNOSIS CODE IEN IN FILE 80^DIAGNOSIS CODE^DESCRIPTION
 N MHVSTR,MHVCNT
 K MHVROOT
 ; FILENAME^ICD
 S MHVSTR=$P(MHVSTRING,U)_"^ICD|"_$P(MHVSTRING,U,2)_"|DT^"
 D SRCLST^ECUMRPC1(.MHVROOT,.MHVSTR)
 I $G(MHVROOT)="" S RESULTS(1)="^0^No results found" Q
 S MHVCNT=0
 S I="" F  S I=$O(@MHVROOT@(I)) Q:I=""  D
 . S MHVCNT=MHVCNT+1
 . S RESULTS(I)=@MHVROOT@(I)
 . S RESULTS(I)=$P(RESULTS(I),"^",3)_"^"_$P(RESULTS(I),"^",1)_"^"_$P(RESULTS(I),"^",2)
 I MHVCNT=0 S RESULTS(1)="^0^No results found" Q
 Q
