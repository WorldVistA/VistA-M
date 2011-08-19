VBECDC02 ;hoifo/gjc-data conversion & pre-implementation;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to FILE^DIE is supported by IA: 2053
 ;Call to UPDATE^DIE is supported by IA: 2053
 ;
UP6001F(VBECIEN,LRFINI) ; file the date/time the process finished running for
 ; a record in the VBECS DATA INTEGRITY/CONVERSION STATISTICS (#6001)
 ; file.
 ; input: VBECIEN-the IEN of the record being updated
 ;        LRFINI-the date/time the process completed
 K LRFDA S LRFDA(6001,VBECIEN_",",.03)=LRFINI
 D FILE^DIE("","LRFDA","") K LRFDA
 Q
 ;
UP6001P(VBECIEN) ; delete a VBECS DATA INTEGRITY/CONVERSION STATISTICS
 ; file (#6001) record
 ; input: VBECIEN-the IEN of the record (file: 6001) being deleted
 K LRFDA S LRFDA(6001,VBECIEN_",",.01)="@"
 D FILE^DIE("","LRFDA","") K LRFDA
 Q
 ;
LOGEXC(VBECIEN,LRARY) ; log the error the error and relevant data
 ; Input: VBECIEN-IEN ('D0') of record in file 6001 (top-level)
 ;        LRARY-local array subscripted by...
 ;        .01-file navigated from
 ;        .02-the internal entry number of the file navigated from
 ;        .03-file navigated to
 ;        .04-the internal entry number of the file navigated from
 ;        .05-Lab Data patient identifier (1st of a possible two)
 ;        .06-Lab Data patient identifier (2nd of a possible two)
 ;        .07-duplicated component (blood product)
 ;        .08-duplicated component id (unit id)
 ;        .09-error message code (see ERRMSG subroutine)
 ;
 ; Fields .05-.08 identify the condition where the same patient or
 ; different patients have the same component/component id data
 ; associated with a transfusion record
 ;
 K LRD1,LRIEN,LROOT S LRX=0
 S LRD1=$O(^VBEC(6001,VBECIEN,"ERR",$C(32)),-1)
 S:LRD1="" LRD1=1 ;first instance of anomaly
 S LRIEN="+"_LRD1_","_VBECIEN_","
 F  S LRX=$O(LRARY(LRX)) Q:'LRX  S LROOT(1,6001.01,LRIEN,LRX)=LRARY(LRX)
 D UPDATE^DIE("","LROOT(1)","")
 K LRD1,LRIEN,LROOT,LRX
 Q
 ;
UP6001S(LRSTRT,LRPROC,LRWHO) ; Update the VBECS DATA INTEGRITY/CONVERSION
 ; STATISTICS (#6001) file.
 ;  input: LRSTRT=timestamp of when the process started
 ;         LRPROC=identify the process, 1 for data conversion
 ;                0 for data validation
 ;         LRWHO=user who is responsible for the process
 ; output: LRY(1)=ien of the newly created record in file 6001
 ;
 K LRFDA N LRY
 S LRFDA(1,6001,"+1,",.01)=LRSTRT,LRFDA(1,6001,"+1,",.02)=LRPROC,LRFDA(1,6001,"+1,",.04)=LRWHO
 D UPDATE^DIE("","LRFDA(1)","LRY") K LRFDA
 Q $G(LRY(1))
 ;
ERRMSG ; standard error messages
 ;;1;Laboratory Reference (#63) field, Patient (#2) file data corruption
 ;;2;Patient mismatch between files: Patient (#2) & Lab Data (#63)
 ;;3;Duplicate Patient Merge indicated in Patient Name
 ;;;
