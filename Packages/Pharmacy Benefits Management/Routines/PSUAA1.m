PSUAA1 ;BIR/RDC - ALLERGY/ADVERSE EVENT EXTRACT ; 11/5/08 7:08am
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**10,14**;MARCH, 2005;Build 1
 ;
 ; Reference to file #4          supported by DBIA 10090
 ; Reference to file #2          supported by DBIA 10035 AND 3504
 ; Reference to file #120.8      supported by DBIA 10099, 2422, AND 4562
 ; Reference to file #120.85     supported by DBIA 10099
 ; Reference to file #49         supported by DBIA 432
 ;
EN ;
 N ARTMP,DFN,EDATE,GMRA,GMRACT,GMRAL,GMREC,ICN,K,LINECNT,LINEMAX,LINETOT,MSGCNT,NPTR,OPTR,OREC,PN,PREC,RPTR,RRDT,RREC,SDATE,SSN,STAT5ION,V,VPTR,X,Z
 K PSUMKFLG
 ;
 D INITZ
 D GETRECS
 D ^PSUAA2
 Q
 ;
INITZ ;
 ;  ** new all non-namespaced variables **
 ;
 S SDATE=PSUSDT\1-.0001
 S EDATE=PSUEDT\1+.2359
 ;
 S LINEMAX=$$VAL^PSUTL(4.3,1,8.3)
 S:LINEMAX=""!(LINEMAX>10000) LINEMAX=10000
 S LINECNT=999999
 S LINETOT=0
 ;
 S PSUFAC=PSUSNDR
 ;
 ; ** get station number **
 S X=$$VALI^PSUTL(4.3,1,217)
 S STATION=+$$VAL^PSUTL(4,X,99)
 ;
 ; ** get run date **
 S %H=$H
 D YMD^%DTC
 S $P(^TMP("PSUAA",$J),U,3)=X
 ;
 ;
 Q  ;  ** end of partition initialization **
 ;
GETRECS ;  ;  **  extract reactive data  **
 F  S SDATE=$O(^GMR(120.8,"V",SDATE)) Q:SDATE>EDATE!('SDATE)  D
 . S VPTR=""                       ;*** loop through verified dates  ***
 . F  S VPTR=$O(^GMR(120.8,"V",SDATE,VPTR)) Q:VPTR=""  D
 .. K GMRACT,GMRAL,GMREC
 .. S PSUMKFLG=0
 .. S VREC=^GMR(120.8,VPTR,0)
 .. S DFN=$P(VREC,U)
 .. Q:$G(DFN)=""
 .. Q:$$TESTPAT^VADPT(DFN)=1                  ;test patient
 .. S PREC=$G(^DPT(DFN,0))
 .. S SSN=$P(PREC,U,9)
 .. S GMRA="0^1^111"
 .. D EN1^GMRADPT
 .. Q:'$D(GMRAL(VPTR))
 .. S GMREC=GMRAL(VPTR)
 .. D EN1^GMRAOR2(VPTR,.ARTMP)    ;  ** load multiple variables  **
 .. S Z="$",OREC=""
 .. D STATIC
 .. S V="" F  S V=$O(GMRACT("S",V)) Q:V=""!(V=7)  D
 ... S $P(OREC,Z,13+V)=$G(GMRACT("S",V))               ; * symptoms
 .. S $P(OREC,Z,20)=""
 .. S V="" F  S V=$O(GMRACT("O",V)) Q:V=""!(V=7)  D
 ... S $P(OREC,Z,12)=$P(GMRACT("O",V),U)               ; * event date
 ... S $P(OREC,Z,13)=$P(GMRACT("O",V),U,2)             ; * severity
 ... ;PSU*4*14 add reverse translation.
 ... D MAKE1 S PSUMKFLG=1,OREC=$TR(OREC,"^",Z)
 .. D:'$G(PSUMKFLG) MAKE1                ; **  load ^XTMP with OREC  **
 .. S:$G(MSGCNT) ^XTMP("PSU_"_PSUJOB,"PSUAA","MSGTCNT")=MSGCNT
 .. S:LINECNT=999999 LINECNT=1
 .. S:$G(LINECNT) ^XTMP("PSU_"_PSUJOB,"PSUAA","LINECNT")=LINECNT
 Q
 ;
STATIC ;  ** set static pieces of record into OREC **
 ;
 S $P(OREC,Z,1)=""
 S $P(OREC,Z,2)=STATION_VPTR          ; ** event ID
 S $P(OREC,Z,3)=SSN                   ; ** social security #
 ;
 S ICN=$$GETICN^MPIF001(DFN)           ; **  ICN
 I $E(ICN,1,2)="-1" S ICN=""
 S $P(OREC,Z,4)=ICN
 ;
 S $P(OREC,Z,5)=$P(GMREC,U,2)          ;  ** reactant
 S $P(OREC,Z,6)=$P($P($P(GMREC,U,9),"(",2),",")  ; * reactant file #
 S $P(OREC,Z,7)=$P(GMREC,U,7)          ;  **  allergy type
 S $P(OREC,Z,8)=$P(VREC,U,4)           ;  ** origination date
 ;
 S NPTR=$P(VREC,U,5)                ; * originator's section/service
 I NPTR S OPTR=$P($G(^VA(200,NPTR,5)),U,1)
 I OPTR S $P(OREC,Z,9)=$P(^DIC(49,OPTR,0),U,1)
 ;
 S $P(OREC,Z,10)=$P(VREC,U,6)          ;  ** observed/historical
 S $P(OREC,Z,11)=$P(VREC,U,14)         ;  ** mechanism
 ;
 Q  ;  ** end of static variables for a message **
 ;
MAKE1 ;   ** load one record/message **
 ;
 S OREC=$TR(OREC,"^","'")
 S OREC=$TR(OREC,Z,U)
 ;
 S LINECNT=LINECNT+1
 S LINETOT=LINETOT+1
 I LINECNT>LINEMAX S MSGCNT=$G(MSGCNT)+1,LINECNT=1
 I $L(OREC)<254 S ^XTMP("PSU_"_PSUJOB,"PSUAA",MSGCNT,LINECNT)=OREC Q
 ;PSU*4*14 Add infinate loop safety.
 F K=254:-1:0 Q:$E(OREC,K)="^"
 S ^XTMP("PSU_"_PSUJOB,"PSUAA",MSGCNT,LINECNT)=$E(OREC,1,K)
 S LINECNT=LINECNT+1
 S LINETOT=LINETOT+1
 S ^XTMP("PSU_"_PSUJOB,"PSUAA",MSGCNT,LINECNT)="*"_$E(OREC,K,K+253)
 Q
PRINT ; ALLOW NO PRINTING
 Q
 ;
