VBECA1A ;HIOFO/REL - Verify Patient ; 7/5/01 6:50am
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to ^DIC supported by IA #10006
 ; Reference to $$LRDFN^LR7OR1 supported by IA #2503
 ;
 QUIT
 ;
PAT ; Verify Patient
 N NUM,ERR,X,Y,DIC,ROOT K VBECERR S NUM=0
 I $G(PATID)="" S ERR=1 D ERR
 I $G(PATNAM)="" S ERR=2 D ERR
 I $G(PATDOB)="" S ERR=3 D ERR
 S:$G(PARENT)="" PARENT=2 I PARENT'=2&(PARENT'=67) S ERR=7 D ERR G DONE
 G:$G(PATID)="" DONE
 S DIC=PARENT,DIC(0)="XMZN",X=PATID D ^DIC
 ;                       ^  ADDED "N" TO DIC(0) 
 ;                          TO ALLOW NUMERIC LOOKUP. RLM
 I Y<1 S ERR=4 D ERR G DONE
 S IFN=+Y,FILEROOT=$S(PARENT=2:"DPT(",PARENT=67:"LRT(67,",1:"")
 S LRDFN=$$LRDFN^LR7OR1(IFN,FILEROOT)
 I $G(PATNAM)'="",PATNAM'=$P(Y(0),"^",1) S ERR=5 D ERR
 I $G(PATDOB)'="",PATDOB'=$P(Y(0),"^",3) S ERR=6 D ERR
DONE S:NUM LRDFN="" Q
 ;
ERR ; Set Error
 I '$D(VBECERR(0)) S VBECERR(0)=$G(PATID)_"^"_$G(PATNAM)_"^"_$G(PATDOB)_"^"_$G(PARENT)
 S NUM=NUM+1,VBECERR(NUM)=ERR_"^"_$P($T(ERRTX+ERR),";;",2)
 Q
ERRTX ;; Error Text
 ;;No Patient ID supplied
 ;;No Patient Name supplied
 ;;No Patient Date of Birth supplied
 ;;No patient record found to match the PATID supplied
 ;;Patient Name (PATNAM) supplied does not match the patient ID (PATID) record
 ;;Patient Date of Birth (PATDOB) does not match the patient ID (PATID) record
 ;;Unsupported Parent File (PARENT) supplied
