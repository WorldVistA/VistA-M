PXVRPC2 ;BPFO/LMT - PCE RPCs for IMM Source, Route, Site ;02/16/16  13:00
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**215**;Aug 12, 1996;Build 10
 ;
 ; Reference to ^DIA(920.X,"C") supported by ICR #2602
 ;
 ;************************************************************************
 ;
 ;Input:
 ;  PXVRSLT - (Required) Return value
 ;  PXVFLTR - (Optional; Defaults to "S:B") Filter. Possible values are:
 ;               R:XXX - Return entry with IEN XXX.
 ;               H:XXX - Return entry with HL7 Code XXX.
 ;               N:XXX - Return entry with #.01 field equal to XXX
 ;               S:X   - Return all entries with a status of X.
 ;                       Possible values of X:
 ;                         A - Active Entries
 ;                         I - Inactive Entries
 ;                         B - Both active and inactive entries
 ;
 ;Returns:
 ; PXVRSLT(0)=Count of elements returned (0 if nothing found)
 ; PXVRSLT(n)=IEN^Name^HL7 Code^Status (1:Active, 0:Inactive)
 ;
 ; For the IMMROUTE tag, see additional input and return values documented below.
 ;
 ; When filtering based off IEN, HL7 Code, or #.01 field, only one entry will be returned
 ; in PXVRSLT(1).
 ;
 ; When filtering based off status, multiple entries can be returned. The first entry will be
 ; returned in subscript 1, and subscripts will be incremented by 1 for further entries.
 ; Entries will be sorted alphabetically.
 ;
 ; If no entries are found based off the filtering criteria, PXVRSLT(0) will equal 0,
 ; and there will be no data returned in the subsequent subscripts.
 ;
 ;******************************************************************************
 ;
IMMSRC(PXVRSLT,PXVFLTR) ;
 D GETDATA(.PXVRSLT,920.1,$G(PXVFLTR),"")
 Q
 ;
IMMROUTE(PXVRSLT,PXVFLTR,PXVSITES) ;
 ; The following additional Input and Return values are available for IMMROUTE:
 ;   Input:
 ;      PXVSITES - (Optional) Controls if the available sites for a give route are returned
 ;   Returns:
 ;      If PXVSITES=1, the sites for a given route will be returned.
 ;       o if If only a subset of sites are selectable for a route,
 ;         that list will be returned in
 ;           PXVRSLT(n+1)=SITE^Site IEN 1
 ;           PXVRSLT(n+2)=SITE^Site IEN 2
 ;           PXVRSLT(n+x)=SITE^Site IEN x
 ;       o if all sites are selectable for a route, the RPC will return:
 ;           PXVRSLT(n+1)=SITE^ALL
 ;       o If no sites are selectable for a route, the RPC will return:
 ;           PXVRSLT(n+1)=SITE^NONE
 ;
 D GETDATA(.PXVRSLT,920.2,$G(PXVFLTR),$G(PXVSITES))
 Q
 ;
IMMSITE(PXVRSLT,PXVFLTR,PXVDATE) ;
 D GETDATA(.PXVRSLT,920.3,$G(PXVFLTR),"")
 Q
 ;
 ;************************************************************************
 ;
GETDATA(PXVRSLT,PXFILE,PXVFLTR,PXVSITES) ;
 ;
 N PXCNT,PXIEN,PXHL7,PXFKTRSTAT,PXFLTRTYP,PXFLTRVAL,PXFLTRSTAT,PXNAME,PXFLDS,PXSTAT
 S PXCNT=0
 S PXIEN=""
 S PXHL7=""
 S PXFLTRTYP="S"
 S PXFLTRSTAT="B"
 D CHKCACHE(PXFILE)
 ;
 I $G(PXVFLTR)'="" D
 . S PXFLTRTYP=$P(PXVFLTR,":",1)
 . S PXFLTRVAL=$P(PXVFLTR,":",2)
 ;
 I PXFLTRTYP="R" D  S PXVRSLT(0)=PXCNT Q
 . S PXIEN=PXFLTRVAL
 . I 'PXIEN Q
 . I '$D(^PXV(PXFILE,PXIEN)) Q
 . D ADDENTRY(.PXVRSLT,.PXFILE,.PXIEN,$G(PXVSITES),"",.PXCNT)
 ;
 I PXFLTRTYP="H" D  S PXVRSLT(0)=PXCNT Q
 . N PXINDEX
 . S PXHL7=PXFLTRVAL
 . I PXHL7="" Q
 . S PXINDEX="H"
 . I PXFILE=920.3 S PXINDEX="B"
 . S PXIEN=$O(^PXV(PXFILE,PXINDEX,PXHL7,0))
 . D ADDENTRY(.PXVRSLT,.PXFILE,.PXIEN,$G(PXVSITES),"",.PXCNT)
 ;
 I PXFLTRTYP="N" D  S PXVRSLT(0)=PXCNT Q
 . S PXNAME=PXFLTRVAL
 . I PXNAME="" Q
 . S PXIEN=$O(^PXV(PXFILE,"B",PXNAME,0))
 . D ADDENTRY(.PXVRSLT,.PXFILE,.PXIEN,$G(PXVSITES),"",.PXCNT)
 ;
 ; I PXFLTRTYP="S" D
 I $G(PXFLTRVAL)?1(1"A",1"I",1"B") S PXFLTRSTAT=PXFLTRVAL
 S PXNAME=""
 F  S PXNAME=$O(^PXV(PXFILE,"B",PXNAME)) Q:PXNAME=""  D
 . S PXIEN=0
 . F  S PXIEN=$O(^PXV(PXFILE,"B",PXNAME,PXIEN)) Q:'PXIEN  D
 . . I PXFILE=920.3,$G(^PXV(PXFILE,"B",PXNAME,PXIEN))=1 Q  ; cross-ref is on HL7 code - not .01
 . . D ADDENTRY(.PXVRSLT,.PXFILE,.PXIEN,$G(PXVSITES),PXFLTRSTAT,.PXCNT)
 ;
 S PXVRSLT(0)=PXCNT
 ;
 Q
 ;
ADDENTRY(PXVRSLT,PXFILE,PXIEN,PXVSITES,PXFLTRSTAT,PXCNT) ; Adds entry to PXVRSLT
 ;
 N PXFLDS,PXSTAT
 ;
 I 'PXIEN Q
 ;
 S PXFLDS=$$GETFLDS(PXFILE,PXIEN)
 S PXSTAT=$P(PXFLDS,U,4)
 ;
 I $G(PXFLTRSTAT)="A",'PXSTAT Q
 I $G(PXFLTRSTAT)="I",PXSTAT Q
 ;
 S PXCNT=PXCNT+1
 S PXVRSLT(PXCNT)=PXFLDS
 I PXFILE=920.2,$G(PXVSITES) D ADDSITES(.PXVRSLT,.PXCNT,.PXIEN)
 ;
 Q
 ;
GETFLDS(PXFILE,PXIEN) ; Returns field values
 ;
 N PXNAME,PXHL7,PXVRSLT,PXSTAT
 ;
 S PXNAME=$P($G(^PXV(PXFILE,PXIEN,0)),U,1)
 S PXHL7=$P($G(^PXV(PXFILE,PXIEN,0)),U,2)
 S PXSTAT=$$GETSTAT(PXFILE,PXIEN)
 ;
 S PXVRSLT=PXIEN_U_PXNAME_U_PXHL7_U_PXSTAT
 ;
 Q PXVRSLT
 ;
ADDSITES(PXVRSLT,PXCNT,PXROUTE) ; Add Sites to PXVRSLT
 ;
 N PXSITE,PXSITES
 ;
 D SITES^PXAPIIM(.PXSITES,PXROUTE,"R")
 ;
 S PXSITE=""
 F  S PXSITE=$O(PXSITES(PXSITE)) Q:PXSITE=""  D
 . S PXCNT=PXCNT+1
 . S PXVRSLT(PXCNT)="SITE^"_PXSITE
 ;
 Q
 ;
GETSTAT(PXFILE,PXIEN) ;
 ;
 N PXSTAT
 ;
 I PXFILE?1(1"920.1",1"920.4") D  Q PXSTAT
 . S PXSTAT='$P($G(^PXV(PXFILE,PXIEN,0)),U,3)
 ;
 S PXSTAT=$G(^XTMP("PXVCACHE-"_PXFILE,PXIEN))
 I PXSTAT="" S PXSTAT=$P($$GETSTAT^XTID(PXFILE,"",PXIEN_","),U,1)
 I PXSTAT="" S PXSTAT=1
 Q PXSTAT
 ;
CHKCACHE(PXFILE) ; Check Cache - see if we need to update
 ;
 N PXCACHEDT,PXLASTEDITDT
 ;
 I PXFILE?1(1"920.1",1"920.4") Q
 ;
 S PXLASTEDITDT=$O(^DIA(PXFILE,"C",""),-1)   ;ICR #2602
 S PXCACHEDT=$P($G(^XTMP("PXVCACHE-"_PXFILE,0)),U,2)
 I PXCACHEDT,PXCACHEDT>PXLASTEDITDT Q
 D UPDCACHE(PXFILE)
 ;
 Q
 ;
UPDCACHE(PXFILE) ;
 ;
 N PXIEN,PXSTAT
 ;
 K ^XTMP("PXVCACHE-"_PXFILE)
 S ^XTMP("PXVCACHE-"_PXFILE,0)=$$FMADD^XLFDT(DT,730)_U_$$NOW^XLFDT()_U_"Cache status for file #"_PXFILE
 S PXIEN=0
 F  S PXIEN=$O(^PXV(PXFILE,PXIEN)) Q:'PXIEN  D
 . S PXSTAT=$P($$GETSTAT^XTID(PXFILE,"",PXIEN_","),U,1)
 . I PXSTAT="" S PXSTAT=1
 . S ^XTMP("PXVCACHE-"_PXFILE,PXIEN)=PXSTAT
 ;
 Q
