LA7QRY2 ;DALOI/JMC - Lab HL7 Query Utility ;Nov 3, 2006
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,69,68**;Sep 27, 1994;Build 56
 ;
 ; Reference to ^AUPNPAT("D") global supported by DBIA #4814
 ;
 Q
 ;
PATID ; Resolve patient id and establish patient environment
 ;
 N LA7X
 ;
 S (DFN,LRDFN)="",LA7PTYP=0
 S LA7PTID("TYPE")=$P(LA7PTID,"^",2),LA7PTID=$P(LA7PTID,"^")
 ;
 ; SSN passed as patient identifier
 ; Identifier type will be checked in subsequent patch once subscribers
 ; have updated their API call.
 ; I LA7PTID("TYPE")="SS" D
 I LA7PTID?9N.1A D
 . S LA7PTYP=1
 . S LA7X=$O(^DPT("SSN",LA7PTID,0))
 . I LA7X>0 D SETDFN(LA7X)
 ;
 ; MPI/ICN (integration control number) passed as patient identifier
 ; Identifier type will be checked in subsequent patch once subscribers have updated their API call.
 ; I LA7PTID("TYPE")="PI" D
 I LA7PTID?10N1"V"6N D
 . S LA7PTYP=2
 . S LA7X=$$GETDFN^MPIF001(LA7PTID)
 . I LA7X<0 S LA7QERR(5)=$P(LA7X,"^",2) Q
 . I LA7PTID'=$$GETICN^MPIF001(LA7X) S LA7QERR(1)="Invalid patient identifier passed" Q
 . D SETDFN(LA7X)
 ;
 ; Use HRN (health record number) cross reference of file PATIENT/IHS (#9000001).
 I LA7PTID("TYPE")="MR" D
 . S LA7PTYP=3
 . S LA7X=$O(^AUPNPAT("D",LA7PTID,0))
 . D SETDFN(LA7X)
 ;
 ; If no patient identified/no laboratory record - return exception message
 I 'LA7PTYP S LA7QERR(1)="Invalid patient identifier passed"
 I 'DFN S LA7QERR(2)="No patient found with requested identifier"
 I DFN,'LRDFN S LA7QERR(3)="No laboratory record for requested patient"
 I LRDFN,'$D(^LR(LRDFN)) S LA7QERR(4)="Database error - missing laboratory record for requested patient"
 Q
 ;
 ;
BCD ; Search by specimen collection date.
 ;
 N LA763,LA7QUIT
 ;
 S (LA7SDT(0),LA7EDT(0))=0
 I LA7SDT S LA7SDT(0)=9999999-LA7SDT
 I LA7EDT S LA7EDT(0)=9999999-LA7EDT
 ;
 S LRSS=""
 F  S LRSS=$O(LRSSLST(LRSS))  Q:LRSS=""  D
 . S (LA7QUIT,LRIDT)=0
 . I LA7EDT(0) S LRIDT=$O(^LR(LRDFN,LRSS,LA7EDT(0)),-1)
 . F  S LRIDT=$O(^LR(LRDFN,LRSS,LRIDT)) Q:LA7QUIT  D
 . . ; Quit if reached end of data or outside date criteria
 . . I 'LRIDT!(LRIDT>LA7SDT(0)) S LA7QUIT=1 Q
 . . D SEARCH
 ;
 Q
 ;
 ;
BRAD ; Search by results available date (completion date).
 ; Assumes cross-references still exist for dates in LRO(69) global.
 ; Collects specimen date/time values for a given LRDFN and completion date.
 ; Cross-reference is by date only, time stripped from start date.
 ; Uses cross-reference ^LRO(69,DT,1,"AN",'LOCATION',LRDFN,LRIDT)=""
 ;
 N LA763,LA7DT,LA7ROOT,LA7SRC,LA7X,X
 ;
 ; Check if orders still exist in file #69 for search range.
 ; If also searching any AP (SP,CY,EM,AU) subscripts then use long search as these do not always have orders in file #69.
 S LA7SDT(1)=(LA7SDT\1)-.0000000001,LA7EDT(1)=(LA7EDT\1)+.24,LA7SRC=0
 S X=$O(^LRO(69,LA7SDT(1)))
 I X,X<LA7EDT(1) D
 . S LA7SRC=1
 . F I="AU","CY","EM","SP" I $D(LRSSLST(I)) S LA7SRC=2 Q
 ;
 ; Search "AN" cross-reference in file #69.
 I LA7SRC D
 . S LA7DT=LA7SDT(1)
 . F  S LA7DT=$O(^LRO(69,LA7DT)) Q:'LA7DT!(LA7DT>LA7EDT(1))  D
 . . S LA7ROOT="^LRO(69,LA7DT,1,""AN"")"
 . . F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7ROOT=""!($QS(LA7ROOT,2)'=LA7DT)!($QS(LA7ROOT,4)'="AN")  D
 . . . I $QS(LA7ROOT,6)'=LRDFN Q
 . . . S LRIDT=$QS(LA7ROOT,7),LRSS=""
 . . . F  S LRSS=$O(LRSSLST(LRSS))  Q:LRSS=""  D SEARCH
 ;
 ; If no orders in #69 then do long search through file #63.
 ; Or if searching AP subscripts.
 ; If MI subscript then check each section of specimen for release date.
 I 'LA7SRC!(LA7SRC=2) D
 . S LRSS=""
 . F  S LRSS=$O(LRSSLST(LRSS))  Q:LRSS=""  D
 . . I LA7SRC=2,"AUCYEMSP"'[LRSS Q
 . . S LRIDT=0
 . . F  S LRIDT=$O(^LR(LRDFN,LRSS,LRIDT)) Q:'LRIDT  D
 . . . S LA763(0)=$G(^LR(LRDFN,LRSS,LRIDT,0))
 . . . I LRSS="MI" D SEARCH
 . . . S LA7X=$S("SPCYEM"[LRSS:$P(LA763(0),"^",11),1:$P(LA763(0),"^",3))
 . . . I LA7X>LA7SDT(1),LA7X<LA7EDT(1) D SEARCH
 ;
 Q
 ;
 ;
SEARCH ; Search subscript for a specific collection date/time
 ;
 K LA763
 S LA763(0)=$G(^LR(LRDFN,LRSS,LRIDT,0))
 ; Skip if CH, SP, CY, or EM subscript and no complete date
 I "CHSPCYEM"[LRSS,'$P(LA763(0),"^",3) Q
 ; Skip if SP, CY, or EM subscript and no release date
 I "SPCYEM"[LRSS,'$P(LA763(0),"^",11) Q
 ;
 ; Only CH, MI, and BB subscripts store pointer to file #61 in 5th piece of zeroth node.
 ; Quit if specific specimen codes and they do not match
 I "CHMIBB"[LRSS S LA761=+$P(LA763(0),"^",5)
 E  S LA761=0
 I LA761,$D(^TMP("LA7-61",$J)),'$D(^TMP("LA7-61",$J,LA761)) Q
 ;
 ; --- Chemistry
 I LRSS="CH" D CHSS Q
 ; --- Microbiology
 I LRSS="MI" D MISS Q
 ; --- Surgical pathology
 I LRSS="SP" D APSS Q
 ; --- Cytology
 I LRSS="CY" D APSS Q
 ; --- Electron Microscopy
 I LRSS="EM" D APSS Q
 ; --- Autopsy
 I LRSS="AU" D APSS Q
 ; --- Blood Bank
 I LRSS="BB" D BBSS Q
 Q
 ;
 ;
CHSS ; Search "CH" datanames for matching codes
 ;
 N LA7X,LRSB
 ;
 S LRSB=1
 F  S LRSB=$O(^LR(LRDFN,LRSS,LRIDT,LRSB)) Q:'LRSB  D
 . S LA7X=$G(^LR(LRDFN,LRSS,LRIDT,LRSB))
 . S LA7CODE=$$DEFCODE^LA7VHLU5(LRSS,LRSB,$P(LA7X,"^",3),LA761)
 . D CHECK
 Q
 ;
 ;
MISS ; Search "MI" subscripts for matching codes
 ;
 N LA7ND,LA7X,LRSB
 ;
 S LA7ND=0
 F LA7ND=1,5,8,11,16 I $D(^LR(LRDFN,LRSS,LRIDT,LA7ND)) D
 . S LA7X=$P(^LR(LRDFN,LRSS,LRIDT,LA7ND),"^")
 . ; If no rpt date approved do not include
 . I LA7X="" Q
 . I $P(LA7SDT,"^",2)="RAD",((LA7X<LA7SDT(1))!(LA7X>LA7EDT(1))) Q
 . S LRSB=$S(LA7ND=1:11,LA7ND=5:14,LA7ND=8:18,LA7ND=11:22,LA7ND=16:33,1:11)
 . S LA7CODE=$$DEFCODE^LA7VHLU5(LRSS,LRSB,"",LA761)
 . D CHECK
 Q
 ;
 ;
APSS ; Search AP subscripts for matching codes
 ; AP results are currently not coded - use defaults
 ;
 N LA7CODE,LRSB
 ;
 ; *** Autopsy subscript currently not supported ***
 I LRSS="AU" Q
 ;
 S LRSB=.012
 S LA7CODE=$$DEFCODE^LA7VHLU5(LRSS,LRSB,"","")
 D CHECK
 ;
 Q
 ;
 ;
BBSS ; Search BB subscript for matching codes
 ; *** This subscript currently not supported ***
 Q
 ;
 ;
CHECK ; Check NLT order/result and LOINC codes.
 ;
 N LA7I,LA7QUIT,LA7X
 ;
 ; If wildcard then store
 ; Otherwise check for specific NLT order/result and LOINC codes
 ; If searching for suffix "0000" then check for other than "0000" coded result NLT code suffixes
 I $P(LA7SCDE,"^")="*" D STORE Q
 S LA7QUIT=0
 F LA7I=1:1:3 D  Q:LA7QUIT
 . ; If no test code then skip
 . I $P(LA7CODE,"!",LA7I)="" Q
 . ; If test code matches a search code then store
 . I $D(^TMP($S(LA7I=3:"LA7-LN",1:"LA7-NLT"),$J,$P(LA7CODE,"!",LA7I))) D  Q
 . . D STORE
 . . S LA7QUIT=1
 . I LA7I=2,$P($P(LA7CODE,"!",LA7I),".",2)'="0000" D
 . . S LA7X=$P($P(LA7CODE,"!",LA7I),".",1)_".0000"
 . . I $D(^TMP("LA7-NLT",$J,LA7X)) D STORE S LA7QUIT=1 Q
 ;
 Q
 ;
 ;
STORE ; Store entry for building in HL7 message
 ;
 S ^TMP("LA7-QRY",$J,LRDFN,LRIDT,LRSS,$P(LA7CODE,"!"),LRSB)=""
 Q
 ;
 ;
SETDFN(LA7X) ; Setup DFN and other lab variables.
 ;
 S DFN=LA7X,LRDFN=$P($G(^DPT(DFN,"LR")),"^")
 Q
 ;
 ;
SCLIST(SCLST,LA7SLST) ; Setup subscript search list
 ; Call with   SCLST = list of subscripts to search, "," delimited
 ;           LA7SLST = array reference to return parsed subscript array
 ;
 ;   Returns LA7SLST =  parsed array of subscripts (passed by reference)
 ;
 N I,RC,SCALL,TMP
 ;
 ; Search all supported subscripts
 I SCLST="*" F I="AU","BB","CH","CY","EM","MI","SP" S LA7SLST(I)=""
 ;
 ; Search only requested valid subscripts
 I SCLST'="*" D
 . S SCALL=",AU,BB,CH,CY,EM,MI,SP,",SCLST=$$UP^XLFSTR($TR(SCLST," "))
 . F I=1:1:$L(SCLST,",") D  Q:$D(LA7QERR)
 . . S TMP=$P(SCLST,",",I) Q:TMP=""
 . . I SCALL[(","_TMP_",")  S LA7SLST(TMP)="" Q
 . . S LA7QERR(7)="Invalid list of subscripts: '"_SCLST_"'"
 Q
