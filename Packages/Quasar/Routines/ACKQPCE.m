ACKQPCE ;HCIOFO/AG - Quasar PCE Interface; August 1999.
 ;;3.0;QUASAR;;Feb 11, 2000
 ;;
 ; this routine contains the entry points for sending a Quasar visit
 ;  to PCE, and deleting a Quasar visit from PCE.
 ; the entry points are :-
 ;   SENDPCE(ACKVIEN,ACKPKG,ACKSRC,ACKDATE) ; send a visit
 ; & KILLPCE(ACKVIEN) ; kill a visit from PCE
 ;
SENDPCE(ACKVIEN,ACKPKG,ACKSRC) ; send a visit to pce
 ; requires :-
 ;   ACKVIEN - Quasar visit ien (from 509850.6) (reqd)
 ;   ACKPKG  - package number for Quasar from package file (9.4) (opt)
 ;   ACKSRC  - source name (free text) (opt)
 ; returns :-
 ;     1  -  visit processed ok (no errors)
 ;     0  -  visit not processed (errors found)
 ; briefly, this routine does the following :-
 ;   (code for this function is in ^ACKQPCE1)
 ;  .lock the visit
 ;  .retrieve all the visit data
 ;  .if the visit already exists in PCE...
 ;  ..remove all workload from the PCE visit
 ;  ..if workload not removed ok...
 ;  ...record error on Qsr Visit file
 ;  ...unlock visit
 ;  ...end processing - return 0
 ;  .create temp file containing visit data in format reqd by
 ;    PCE api DATA2PCE^PXAPI
 ;  .call the PCE api to update the PCE Visit file
 ;  .if PCE api returned an error...
 ;  ..record error on Qsr Visit file
 ;  ..unlock visit
 ;  ..end processing - return 0
 ;  .update visit fields
 ;  .unlock visit
 ;  .end processing - return 1
 I +$G(ACKVIEN)=0 Q 0
 I $G(ACKPKG)="" S ACKPKG=$$PKG
 I $G(ACKSRC)="" S ACKSRC=$$SRC
 Q $$SENDPCE^ACKQPCE1(ACKVIEN,ACKPKG,ACKSRC)
 ;
KILLPCE(ACKVIEN) ; remove a Quasar Visit from PCE
 ; requires:-
 ;    ACKVIEN - Quasar Visit ien (from 509850.6) (reqd)
 ; returns:-
 ;    0 - unable to process, error returned by PCE
 ;    1 - visit deleted successfully
 ; this routine does the following :-
 ;   .get the PCE ien for the visit
 ;   .if no PCE ien then exit (return 1)
 ;   .lock the visit
 ;   .call the PCE API DELVFILE^PXAPI to delete the visit
 ;   .if error returned by PCE...
 ;   ..record error on Qsr Visit file
 ;   ..file Last Edited in Qsr date (to create Exception entry)
 ;   ..end processing - return 0
 ;   .update visit fields
 ;   .unlock visit
 ;   .end processing - return 1
 I +$G(ACKVIEN)=0 Q 0
 Q $$KILLPCE^ACKQPCE3(ACKVIEN)
 ;
PKG() ; determine Quasar package number
 N ACKTGT
 D FIND^DIC(9.4,"",.01,"X","QUASAR",1,"B","","","ACKTGT","")
 Q +$G(ACKTGT("DILIST",2,1))
 ;
SRC() ; return default source string for quasar/pce interface
 Q "QUASAR"
 ;
CLEAR(ACKVIEN) ; clear the PCE Error multiple for a Quasar visit
 N ACKTGT,ACKI,ACKARR
 ; get all the current sub file entries
 D LIST^DIC(509850.65,","_ACKVIEN_",",.01,"","*","","","","","","ACKTGT","")
 ; transfer them to an FDA format array for update
 F ACKI=1:1 Q:'$D(ACKTGT("DILIST",2,ACKI))  D
 . S ACKSUB=ACKTGT("DILIST",2,ACKI)
 . S ACKARR(509850.65,ACKSUB_","_ACKVIEN_",",.01)="@"
 ; now update the file
 D FILE^DIE("","ACKARR","")
 ; done
 Q
 ;
FILERSN(ACKVIEN,ACKRSN) ; file PCE Errors on Quasar visit file 509850.6
 ; requires :- ACKVIEN - quasar visit number
 ;             ACKRSN  - array containing the errors
 N ACKI,ACKARR
 F ACKI=1:1:ACKRSN D
 . S ACKARR(509850.65,"+"_ACKI_","_ACKVIEN_",",.01)=ACKI
 . S ACKARR(509850.65,"+"_ACKI_","_ACKVIEN_",",.02)=$P(ACKRSN(ACKI,0),U,2)
 . S ACKARR(509850.65,"+"_ACKI_","_ACKVIEN_",",.03)=$P(ACKRSN(ACKI,0),U,3)
 . S ACKARR(509850.65,"+"_ACKI_","_ACKVIEN_",",.04)=$P(ACKRSN(ACKI,0),U,4)
 . S ACKARR(509850.65,"+"_ACKI_","_ACKVIEN_",",1)=ACKRSN(ACKI,1)
 D UPDATE^DIE("","ACKARR","","")
 ; done
 Q
 ;
