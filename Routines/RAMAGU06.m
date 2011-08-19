RAMAGU06 ;HCIOFO/SG - ORDERS/EXAMS API (EXAM STATUS UTILS) ; 2/6/09 11:21am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; Exam Status Descriptor
 ; ----------------------
 ;
 ;   ^01: IEN of the status record in the EXAMINATION STATUS
 ;        file (#72).
 ;
 ;   ^02: Status name (value of the NAME field (.01)
 ;        of the file #72.
 ;
 ;   ^03: Status code. Currently, the value of the ORDER field (3)
 ;        of the file #72 is used. As the result, only 0 (cancelled), 
 ;        1 (waiting for exam), and 9 (completed) codes are the same
 ;        at all sites and all imaging types. All others are site
 ;        and/or imaging type specific.
 ;
 ;   ^04: VistARAD category (field 9 of the file #72).
 ;
 ;   ^05: Generic exam status characteristics (can be combined):
 ;          E  'Examined' HL7 message is generated
 ;          R  Report is required
 ;
 ;        These flags have the same meaning at all sites for all
 ;        imaging types.
 ;
 Q
 ;
 ;***** RETURNS A DESCRIPTOR OF THE EXAM STATUS
 ;
 ; STATUS        IEN of the status record in the EXAMINATION STATUS
 ;               file (#72) or the status order number in the 3rd.
 ;               ^-piece.
 ;
 ;               First, the function checks the 1st ^-piece. If it
 ;               is greater than 0, then it is used as IEN of the
 ;               status.
 ;               
 ;               Otherwise, the third piece is checked for a status
 ;               order number (value of the ORDER field (3) of the
 ;               EXAMINATION STATUS file (#72)). The RAIMGTYI
 ;               parameter must reference a valid imaging type in
 ;               this case.
 ;
 ;               Only 0 (cancelled), 1 (waiting for exam), and 9
 ;               (completed) order numbers are the same at all sites
 ;               and all imaging types. All others are site and/or
 ;               imaging type specific.
 ;
 ; [RAIMGTYI]    Imaging type IEN (file #79.2). This parameter is
 ;               required if a status is referenced by the order
 ;               number (see above).
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  Exam status descriptor (see the comment in
 ;           the beginning of this routine)
 ;
EXMSTINF(STATUS,RAIMGTYI) ;
 N IENS,RABUF,RAMSG,RC,TMP
 S RC=0
 ;
 ;=== Search for status record
 I STATUS'>0  D  Q:RC<0 RC
 . N IEN72,RAIMGTY,RANODE
 . I $P(STATUS,U,3)'?1.N  S RC=$$IPVE^RAERR("STATUS")  Q
 . I $G(RAIMGTYI)'>0  S RC=$$IPVE^RAERR("RAIMGTYI")  Q
 . ;--- Get the imaging type name
 . S IENS=+RAIMGTYI_","
 . S RAIMGTY=$$GET1^DIQ(79.2,IENS,.01,,,"RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,70.02,IENS)  Q
 . I RAIMGTY=""  S RC=$$ERROR^RAERR(-19,,70.02,IENS,2)  Q
 . ;--- Search for status record by status order number
 . S RANODE=$NA(^RA(72,"AA",RAIMGTY,+$P(STATUS,U,3)))
 . S IEN72=+$O(@RANODE@(""))
 . I IEN72'>0  S RC=$$IPVE^RAERR("STATUS")  Q
 . ;--- Check if there is another status with the same order number
 . I $O(@RANODE@(IEN72))>0  D  Q
 . . S RC=$$ERROR^RAERR(-14,,"status order number",STATUS)
 . S STATUS=IEN72
 ;
 ;=== Load status properties
 S IENS=+STATUS_","
 D GETS^DIQ(72,IENS,".01;.111;3;8;9","I","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,72,IENS)
 ;
 ;=== Build basic descriptor
 S $P(STATUS,U,2)=$G(RABUF(72,IENS,.01,"I"))  ; STATUS
 S $P(STATUS,U,3)=$G(RABUF(72,IENS,3,"I"))    ; ORDER
 S $P(STATUS,U,4)=$G(RABUF(72,IENS,9,"I"))    ; VISTARAD CATEGORY
 ;
 ;=== Add generic characteristics
 S TMP=""
 ;--- REPORT ENTERED REQUIRED?
 S:$G(RABUF(72,IENS,.111,"I"))="Y" TMP=TMP_"R"
 ;--- GENERATE EXAMINED HL7 MESSAGE
 S:$G(RABUF(72,IENS,8,"I"))="Y" TMP=TMP_"E"
 S $P(STATUS,U,5)=TMP
 ;
 ;===
 Q STATUS
 ;
 ;***** RETURNS REQUIREMENTS FOR THE EXAM STATUS
 ;
 ; EXMSTIEN      IEN of the current status (IEN in the file #72)
 ;
 ; [RAPROCIEN]   Radiology procedure IEN (file #71). This parameter
 ;               is required to determine exact nuclear medicine
 ;               requirements (result pieces from 17 to 25).
 ;
 ;               By default (+$G(RAPROCIEN)=0), this function cannot
 ;               examine the SUPPRESS RADIOPHARM PROMPT field (2) of
 ;               the RAD/NUC MED PROCEDURES file (#71) and might
 ;               indicate that some nuclear medicine data is required 
 ;               even if it is not.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;      ...  Status requirements descriptor
 ;             ^01: TECHNOLOGIST REQUIRED?         {0|1}
 ;             ^02: RESIDENT OR STAFF REQUIRED?    {0|1}
 ;             ^03: DETAILED PROCEDURE REQUIRED?   {0|1}
 ;             ^04: FILM ENTRY REQUIRED?           {0|1}
 ;             ^05: DIAGNOSTIC CODE REQUIRED?      {0|1}
 ;             ^06: CAMERA/EQUIP/RM REQUIRED?      {0|1}
 ;             ^07: reserved
 ;             ^08: reserved
 ;             ^09: reserved
 ;             ^10: reserved
 ;             ^11: REPORT ENTERED REQUIRED?       {0|1}
 ;             ^12: VERIFIED REPORT REQUIRED?      {0|1}
 ;             ^13: PROCEDURE MODIFIERS REQUIRED?  {0|1}
 ;             ^14: CPT MODIFIERS REQUIRED?        {0|1}
 ;             ^15: reserved
 ;             ^16: IMPRESSION REQUIRED?           {0|1}
 ;             ^17: RADIOPHARMS/DOSAGES REQUIRED?  {0|1}
 ;             ^18: reserved
 ;             ^19: ACTIVITY DRAWN REQUIRED?       {0|1}
 ;             ^20: DRAWN DT/TIME/PERSON REQUIRED? {0|1}
 ;             ^21: ADM DT/TIME/PERSON REQUIRED?   {0|1}
 ;             ^22: reserved
 ;             ^23: ROUTE/SITE REQUIRED?           {0|1}
 ;             ^24: LOT NO. REQUIRED?              {0|1}
 ;             ^25: VOLUME/FORM REQUIRED?          {0|1}
 ;
EXMSTREQ(EXMSTIEN,RAPROCIEN) ;
 Q:$D(^RA(72,+EXMSTIEN))<10 $$IPVE^RAERR("EXMSTIEN")
 Q:$G(RAPROCIEN)<0 $$IPVE^RAERR("RAPROCIEN")
 N BUF,I,IENS,RABUF,RAIMGTYI,RAMSG,RC,RESULT,TMP
 S RESULT="",RC=0
 ;
 ;=== General requirements
 S BUF=$G(^RA(72,+EXMSTIEN,.1))
 F I=1:1:6,11:1:14,16  S $P(RESULT,U,I)=($P(BUF,U,I)="Y")
 ;
 ;=== Nuclear Medicine requirements
 S BUF=$G(^RA(72,+EXMSTIEN,.5))
 ;--- If the exam status does not indicate that radiopharmaceuticals
 ;    are required, then there is no need for any further checks.
 ;--- See the EN1^RASTREQN procedure for more details.
 I $P(BUF,U)="Y"  D  Q:RC<0 RC
 . ;--- Get the imaging type IEN from the exam status
 . S IENS=+EXMSTIEN_","
 . S RAIMGTYI=+$$GET1^DIQ(72,IENS,7,"I",,"RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,72,IENS)  Q
 . ;--- If the RADIOPHARMACEUTICALS USED? of the imaging type
 . ;--- is not set to Yes, then requirements are voided.
 . S IENS=RAIMGTYI_","
 . S TMP=$$GET1^DIQ(79.2,IENS,5,"I",,"RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,79.2,IENS)  Q
 . I TMP'="Y"  S BUF=""  Q
 . ;--- If a procedure is passed and its SUPPRESS RADIOPHARM PROMPT
 . ;    field (2) in the RAD/NUC MED PROCEDURES file (#71) stores 1,
 . ;--- then the radiopharmaceutical requirements are voided.
 . I $G(RAPROCIEN)>0  D  Q:RC<0
 . . S IENS=+RAPROCIEN_","
 . . D GETS^DIQ(71,IENS,"2;12","I","RABUF","RAMSG")
 . . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,71,IENS)  Q
 . . I +$G(RABUF(71,IENS,12,"I"))'=RAIMGTYI  D  Q
 . . . S RC=$$ERROR^RAERR(-55)
 . . S:$G(RABUF(71,IENS,2,"I")) BUF=""
 E  S BUF=""
 F I=1,3,4,5,7,8,9  S $P(RESULT,U,16+I)=($P(BUF,U,I)="Y")
 ;
 ;===
 Q RESULT
 ;
 ;***** RETURNS THE STATUS THAT SHOULD BE USED AS "EXAMINED"
 ;
 ; EXMSTIEN      IEN of the current status (IEN in the file #72)
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       ""  Requested exam status cannot be found. The current
 ;           status is already at or past "EXAMINED".
 ;       >0  Exam status descriptor (see the routine comment above)
 ;
 ; This function searches for a status that follows the one defined
 ; by the EXMSTIEN parameter and has "E" (Examined) in the VISTARAD
 ; CATEGORY field (9).
 ;
GETEXMND(EXMSTIEN) ;
 Q $$NXTEXMST(+EXMSTIEN,"E")
 ;
 ;***** RETURNS THE NEXT EXAM STATUS
 ;
 ; EXMSTIEN      IEN of the status record in the EXAMINATION STATUS
 ;               file (#72).
 ;
 ; [VISTARADCAT] Internal value of the required VistA RAD category.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       ""  Requested exam status cannot be found after the status
 ;           referenced by the EXMSTIEN.
 ;       >0  Exam status descriptor (see the routine comment above)
 ;
NXTEXMST(EXMSTIEN,VISTARADCAT) ;
 N IEN72,IENS,ORDER,ORDI,RABUF,RAIMGTY,RAMSG,RC,TMP,X,XREF
 Q:$G(EXMSTIEN)'>0 $$IPVE^RAERR("EXMSTIEN")
 S RC=0
 ;=== Get the order number and type of imaging
 S IENS=+EXMSTIEN_","
 D GETS^DIQ(72,IENS,"3;7",,"RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,72,IENS)
 S ORDER=+$G(RABUF(72,IENS,3))
 S RAIMGTY=$G(RABUF(72,IENS,7))
 K RABUF
 ;=== Search for the next status
 S XREF=$NA(^RA(72,"AA",RAIMGTY))
 I $G(VISTARADCAT)'=""  D
 . S ORDI=""
 . F  S ORDI=$O(@XREF@(ORDI))  Q:ORDI=""  D  Q:RC
 . . S IEN72=""
 . . F  S IEN72=$O(@XREF@(ORDI,IEN72))  Q:IEN72=""  D  Q:RC
 . . . S TMP=$$GET1^DIQ(72,IEN72_",",9,"I",,"RAMSG")
 . . . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,72,IEN72_",")  Q
 . . . S:TMP=VISTARADCAT RC=$$EXMSTINF(IEN72)
 . ;--- If nothing has been found, then "E:Examined" category has
 . ;--- not been assigned to a record of this imaging type yet.
 . I 'RC  S RC=$$ERROR^RAERR(-59,,VISTARADCAT,RAIMGTY)  Q
 . ;--- Check if the new status follows the source one
 . S:$P(RC,U,3)'>ORDER RC=""
 E  D
 . S ORDI=$O(@XREF@(ORDER))     Q:ORDI=""
 . S IEN72=$O(@XREF@(ORDI,""))  Q:IEN72=""
 . S RC=$$EXMSTINF(IEN72)
 ;===
 Q RC
