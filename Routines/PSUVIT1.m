PSUVIT1 ;BIR/RDC - VITALS & IMMUNIZATION EXTRACT; 24 DEC 2003 ; 1/12/09 12:07pm
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**11,15**;MARCH, 2005;Build 2
 ;
 ;DBIA's
 ;References to file #4       - the INSTITUTION file
 ;  DBIA 10090 for: the STATION field  - #99
 ;
 ;References to file #120.5    - the GMRV VITAL MEASUREMENT file
 ;  DBIA 1381 for:   the DATE/TIME VITALS TAKEN field - #.01
 ;                   the VITAL TYPE field #.03
 ;                   the RATE field #1.2
 ;                   the QUALIFIER field #5
 ;
 ;References to file #120.51- the GMRV VITAL TYPE file
 ;       DBIA 1382 for: the NAME field - #.01
 ;
 ;References to file #120.52 - the GMRV VITAL QUALIFIER file
 ;       DBIA 4504 for: the QUALIFIER field #.01
 ;
 ;References to file #9000010.11 - the V IMMUNIZATION file
 ;       DBIA 4567 for: the EVENT DATE AND TIME field #1202
 ;                      the IMMUNIZATION field #.01
 ;
 ;References to file #2   - the PATIENT file
 ;       DBIA 10035 for:  the SOCIAL SECURITY NUMBER field #.09
 ;       DBIA 3504 for: the TEST PATIENT INDICATOR field #.6
 ;
 ;References to file #9999999.14 - the IMMUNIZATION file
 ;       DBIA 2454 for: the NAME field #.01
 ;
EN ;ENtry POINT - Routine control module
 ;
 N SDATE,EDATE,PSUFAC,PSUIDATE,PSUQCNT,PSUQNUM
 N MAXLINE,LINECNT,MSGCNT,I,J,K,Z,LINETOT
 S PSUVTMP(0)="TEMP ARRAY FOR PSUVIT1 PROCESSING"
 D SETUP
 D VITALS
 D VITALS2
 D IMMUNS
 D MAILIT
 Q          ;  **  end of routine control module **
 ; 
SETUP ; SET UP PARTITION FOR VITALS/IMMUNIZATION EXTRACT
 ;
 S LINEMAX=$$VAL^PSUTL(4.3,1,8.3)       ; ** get maximum line length **
 S:LINEMAX=""!(LINEMAX>10000) LINEMAX=10000
 ;
 ; SET EXTRACT DATE
 S %H=$H
 D YMD^%DTC
 S $P(^TMP("PSUVI",$J),U,3)=X
 ;
 ; GET TIME WINDOW
 S SDATE=PSUSDT\1-.0001
 S EDATE=PSUEDT\1+.2359
 ;
 ; GET FACILITY
 S PSUFAC=PSUSNDR
 ; 
 ; SET VARIABLES
 I $G(^XTMP("PSU_"_PSUJOB,"PSUPSUFLAG"))=1 D  ;AUTOJOBED
 . S PSUOPTS="1,2,3,4,5,6,7,8,9,10,11,12,13"
 . S PSUAUTO=1
 S LINECNT=999999
 S LINETOT=0
 ;
 Q                         ;  ** end of SETUP  **
 ;
VITALS ; EXTRACT VITAL DATA
 ; 
 N PSUDATE,PSUV,PSUQ,PSUVREC,PSUPTREC,PSUPTPTR,PSUVPTR,PSUQPTR
 N PSURTYPE,PSUSSN,PSUICN,PSUVTYPE,PSUVRATE,PSUVUNIT
 N Z,QQ,PSUVQ1,PSUVQ2,PSUVQ3,PSUVQ4,PSUVLIST,PSUVMSG
 N PSULN,PSUTXT
 ;
 S PSUVLIST="""BLOOD PRESSURE"",""HEIGHT"",""WEIGHT"",""PAIN"",""PULSE"",""PULSE OXIMETRY"""
 ;
 ;                          ** Loop through date index for valid dates **
 S PSUDATE=SDATE
 ;PSU*4*11 Added null ptr notification.
 S PSUTXT(1)="The following IEN(s) have a null pointer in the PATIENT (#2) field of"
 S PSUTXT(2)="the GMRV VITAL MEASUREMENT file (#120.5).  Please notify your IRM and"
 S PSUTXT(3)="submit a remedy ticket for help in evaluating the record."
 S PSULN=3
 F  S PSUDATE=$O(^GMR(120.5,"B",PSUDATE)) Q:PSUDATE>EDATE!('PSUDATE)  D
 . S PSUV=""                      ; ** loop thru vitals for each date **
 . F  S PSUV=$O(^GMR(120.5,"B",PSUDATE,PSUV)) Q:PSUV=""  D
 .. Q:$P($D(^GMR(120.5,PSUV,2)),U)  ;** quit if vital entered in error **
 .. S PSUVREC=$G(^GMR(120.5,PSUV,0)) Q:'PSUVREC
 .. S PSUPTPTR=$P(PSUVREC,U,2)    ; ** point to PATIENT **
 .. I PSUPTPTR="" D  Q            ; ** quit if no patient pointer **
 ... S PSULN=PSULN+1
 ... S PSUTXT(PSULN)=PSUV
 .. Q:$G(^DPT(PSUPTPTR,0))=""     ; ** quit if no patient record **
 .. S PSUPTREC=^DPT(PSUPTPTR,0)   ; ** get patient record **
 .. S PSUSSN=$P(PSUPTREC,U,9)     ; ** get SSN
 .. ;PSU*4*15
 .. Q:'PSUSSN                     ; ** Quit if no SSN **
 .. Q:$E(PSUSSN,1,5)="00000"      ; ** quit if invalid patient **
 .. Q:$P(PSUPTREC,U,21)=1
 .. Q:$P(PSUVREC,U,3)=""          ; ** quit if no pointer **
 .. S PSUVPTR=$P(PSUVREC,U,3)     ; ** point to VITAL  **
 .. S PSUVTYPE=$P(^GMRD(120.51,PSUVPTR,0),U)  ; ** get VITAL TYPE **
 .. Q:PSUVLIST'[PSUVTYPE         ; ** screen out invalid vital types **
 .. S PSURTYPE="V"                ; ** set record type **
 .. S PSUICN=$$GETICN^MPIF001(PSUPTPTR)  ; ** get ICN **
 .. I $P(PSUICN,U)="-1" S PSUICN=""
 .. S PSUVRATE=$P(PSUVREC,U,8)
 .. S PSUVUNIT=""                 ; ** set vital unit rate **
 .. S:PSUVTYPE="PULSE OXIMETRY" PSUVUNIT="%"
 .. S:PSUVTYPE="WEIGHT" PSUVUNIT="LBS"
 .. S:PSUVTYPE="HEIGHT" PSUVUNIT="IN"
 .. S (PSUVQ1,PSUVQ2,PSUVQ3,PSUVQ4)=""
 .. D:$D(^GMR(120.5,PSUV,5,0))    ; ** get qualifiers **
 ... S (PSUQNUM,PSUQCNT)=0
 ... F  S PSUQNUM=$O(^GMR(120.5,PSUV,5,PSUQNUM)) Q:'+PSUQNUM  D
 .... S PSUQPTR=^GMR(120.5,PSUV,5,PSUQNUM,0)
 .... S PSUQCNT=PSUQCNT+1
 .... S QQ="PSUVQ"_PSUQCNT
 .... S @QQ=$P(^GMRD(120.52,PSUQPTR,0),U)
 .. S Z="$"
 .. S PSUVMSG=Z_PSUFAC_Z_PSUDATE_Z_PSURTYPE_Z_PSUSSN_Z_PSUICN_Z_""_Z_PSUVTYPE_Z_PSUVRATE_Z_PSUVUNIT_Z_PSUVQ1_Z_PSUVQ2_Z_PSUVQ3_Z_PSUVQ4_Z
 .. S PSUVMSG=$TR(PSUVMSG,"^","'")
 .. S PSUVMSG=$TR(PSUVMSG,Z,U)
 .. ; ** S PSUVTMP(PSUSSN,PSUVTYPE)=PSUVMSG
 .. S ^XTMP("PSU_"_PSUJOB,"PSUVI","TMP",PSUSSN,PSUVTYPE)=PSUVMSG
 ;PSU*4*11 Send null ptr notifications to PBM group.
 I PSULN>3 D
 . S XMTEXT="PSUTXT(",XMY("G.PSU PBM")=""
 . S XMSUB="** PBM vitals extract detected null patient pointer(s) **"
 . S XMDUZ="Pharmacy Benefits Management Package"
 . N DIFROM D ^XMD
 Q
 ;               ** end of vital extract **
VITALS2 ; LOAD SORTED ARRAY INTO ^XTMP
 ;
 N VPT,VPTV
 S VPT=""
 ; ** F  S VPT=$O(PSUVTMP(VPT)) Q:VPT=""  D
 F  S VPT=$O(^XTMP("PSU_"_PSUJOB,"PSUVI","TMP",VPT)) Q:VPT=""  D
 . S VPTV=""
 . ; **F  S VPTV=$O(PSUVTMP(VPT,VPTV)) Q:VPTV=""  D
 . F  S VPTV=$O(^XTMP("PSU_"_PSUJOB,"PSUVI","TMP",VPT,VPTV)) Q:VPTV=""  D
 .. ; ** S X=PSUVTMP(VPT,VPT                     ; * LOAD VITAL RECORD
 .. S X=^XTMP("PSU_"_PSUJOB,"PSUVI","TMP",VPT,VPTV)
 .. S LINECNT=LINECNT+1
 .. S LINETOT=LINETOT+1
 .. I LINECNT>LINEMAX S MSGCNT=$G(MSGCNT)+1,LINECNT=1
 .. I $L(X)<254 S ^XTMP("PSU_"_PSUJOB,"PSUVI",MSGCNT,LINECNT)=X Q  ; load
 .. F J=254:-1 Q:$E(X,J)="^"
 .. S ^XTMP("PSU_"_PSUJOB,"PSUVI",MSGCNT,LINECNT)=$E(X,1,J)
 .. S LINECNT=LINECNT+1
 .. S LINETOT=LINETOT+1
 .. S ^XTMP("PSU_"_PSUJOB,"PSUVI",MSGCNT,LINECNT)="*"_$E(X,J,J+253)
 Q
 ;
IMMUNS ;
 N PSUDATE,ICNT,PSUINUM,PSUIREC,PSUPTPTR,PSUPTREC,PSUSSN,PSUIMPTR
 N PSUIMM,PSUICN,PSURTYPE,PSUIMSG
 ;
 S (PSUMCNT,PSUINUM)=0
 F  S PSUINUM=$O(^AUPNVIMM(PSUINUM)) Q:'PSUINUM  D
 . S PSUIDATE=$P($G(^AUPNVIMM(PSUINUM,12)),"U")  ; ** get IMM date **
 . Q:$P(PSUIDATE,U)=""               ; ** quit if date is null **
 . Q:PSUIDATE<SDATE!(PSUIDATE>EDATE)  ; ** quit if date out of range **
 . S PSUIREC=^AUPNVIMM(PSUINUM,0)    ; ** get IMM record **
 . S PSUPTPTR=$P(PSUIREC,U,2)        ; ** pointer to PAT file **
 . S PSUPTREC=^DPT(PSUPTPTR,0)       ; ** get patient record **
 . S PSUSSN=$P(PSUPTREC,U,9)
 . Q:$E(PSUSSN,1,5)="00000"          ; ** quit if invalid patient **
 . I $P(PSUPTREC,U,21)=1 Q
 . S PSUIMPTR=$P(PSUIREC,U)         ; ** point to IMM file **
 . S PSUIMM=$P(^AUTTIMM(PSUIMPTR,0),U)  ; ** get IMM name **
 . S PSUICN=$$GETICN^MPIF001(PSUPTPTR)  ; ** set ICN **
 . I $P(PSUICN,U)="-1" S PSUICN=""
 . S PSURTYPE="I"                    ; ** set record type **
 . S Z="$"
 . S PSUIMSG=Z_PSUFAC_Z_PSUIDATE_Z_PSURTYPE_Z_PSUSSN_Z_PSUICN_Z_PSUIMM_Z_""_Z_""_Z_""_Z_""_Z_""_Z_""_Z_""_Z_""_Z
 . S PSUIMSG=$TR(PSUIMSG,"^","'")
 . S X=$TR(PSUIMSG,Z,U)
 . ;   *** load ^XTMP  ***
 . S LINECNT=LINECNT+1
 . S LINETOT=LINETOT+1
 . I LINECNT>LINEMAX S MSGCNT=$G(MSGCNT)+1,LINECNT=1
 . I $L(X)<254 S ^XTMP("PSU_"_PSUJOB,"PSUVI",MSGCNT,LINECNT)=X Q  ; load
 . F K=254:-1 Q:$E(X,K)="^"
 . S ^XTMP("PSU_"_PSUJOB,"PSUVI",MSGCNT,LINECNT)=$E(X,1,K)
 . S LINECNT=LINECNT+1
 . S LINETOT=LINETOT+1
 . S ^XTMP("PSU_"_PSUJOB,"PSUVI",MSGCNT,LINECNT)="*"_$E(X,K,K+253)
 ;                                           *** save message count  ***
 S:$G(MSGCNT) ^XTMP("PSU_"_PSUJOB,"PSUVI","MSGTCNT")=MSGCNT
 S ^XTMP("PSU_"_PSUJOB,"PSUVI","LINECNT")=LINETOT
 Q                                                ; ** quit IMMUNS **
 ;
MAILIT ; MAIL VITAL & IMMUNIZATION EXTRACT MESSAGES
 ;
 D ^PSUVIT2
 Q                         ;  **  quit for MAILIT  **
 ;
