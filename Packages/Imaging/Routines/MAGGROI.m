MAGGROI ;WOIFO/BNT/NST - Multiple image print ; 12 Oct 2010 9:55 AM
 ;;3.0;IMAGING;**117**;Mar 19, 2002;Build 2238;Jul 15, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;***** Log multiple images printed for a patient in the 
 ;      MULTI IMAGE PRINT file (#2006.961)
 ;
 ; RPC: MAGG MULTI IMAGE PRINT
 ;
 ; Input Parameters
 ; ================
 ; 
 ; DATA     "^" delimited string containing data inserted
 ;          into the MULTI IMAGE PRINT file #2006.961.
 ;          
 ;          ^01: PATIENT DFN  
 ;          ^02: REASON FOR PRINT
 ;
 ; e.g.: 123456^Authorized release of medical records or health information (ROI)
 ;
 ; IMGARR   An array of "^" delimited string of values for each image printed
 ; 
 ;          ^01: IEN for the image (Note: This may be a url for a remote image)
 ;          ^02: Local/remote indicator (0=local, 1=remote)
 ;          ^03: IMAGE PRINT STATUS 
 ;               (Note: The image information displayed to the user
 ;                in the client application.)
 ;
 ; e.g.: IMGARR(0)=^1^SLC-DIABETIC TELERETINAL IMAGING CONSULT REPORT
 ;                    -NOTE-04/13/2009 11:31: Image type not printable
 ;       IMGARR(1)=123456^0^SLC-AU 01 2-LAB-08/21/2001: Image printed
 ;
 ; Return Values
 ; =============
 ;     
 ; MAGRY = if error   "0^Error message"
 ;         if success "1^Printed Images Logged"
 ;
LOGPRNT(MAGRY,DATA,IMGARR) ;RPC [MAGG MULTI IMAGE PRINT]    
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 S MAGRY=$$ENTRY($P(DATA,U),$P(DATA,U,2),$G(DUZ),.IMGARR)
 ;
 Q
 ;
 ; Call With:
 ; MAGDFN = Patient IEN
 ; MAGREASN = Reason For Print
 ; MAGDUZ = User IEN
 ; MAGARR = Array of Multiple Images that have been printed
 ; 
 ; The Date/Time images printed is derived from current system time
ENTRY(MAGDFN,MAGREASN,MAGDUZ,MAGARR) ;
 N MAGX,MAGY,SFN,FN,NOW,MAGIENS,MAGIEN,MAGREM,MAGFDA
 N MAGERR,MAGRESA,MAGRY
 ; Initialize file number, image subfile number, date/time and return value
 S FN=2006.961
 S SFN=2006.9613
 S NOW=$$NOW^XLFDT()
 S MAGIEN="+1,"
 ;
 ; Set up FDA array
 S MAGFDA(FN,MAGIEN,.01)=MAGDFN  ; Patient
 S MAGFDA(FN,MAGIEN,1)=NOW       ; Print Date/Time
 S MAGFDA(FN,MAGIEN,2)=MAGDUZ    ; User
 S MAGFDA(FN,MAGIEN,3)=MAGREASN  ; Reason for Print
 S MAGX="",MAGY=1,MAGERR=0
 F  S MAGX=$O(MAGARR(MAGX)) Q:MAGX=""  D  Q:MAGERR
 . ; Patient mismatch check was done during the selection of images
 . S MAGY=MAGY+1,MAGIENS=MAGY_","_MAGIEN
 . ; Is Image Local or Remote? MAGREM = 1 for Remote, 0 for Local
 . S MAGREM=$P(MAGARR(MAGX),U,2)
 . S MAGFDA(SFN,"+"_MAGIENS,.01)=MAGX+1                        ; Image ID
 . I 'MAGREM S MAGFDA(SFN,"+"_MAGIENS,1)=$P(MAGARR(MAGX),U,1)  ; Local Image IEN
 . I MAGREM S MAGFDA(SFN,"+"_MAGIENS,3)=$P(MAGARR(MAGX),U,1)   ; Remote Image
 . S MAGFDA(SFN,"+"_MAGIENS,2)=$P(MAGARR(MAGX),U,3)            ; Image Print Status
 . Q
 I MAGERR Q MAGRY
 ; File data in MULTI IMAGE PRINT file
 D UPDATE^DIE("","MAGFDA","","MAGERR")
 I $D(MAGERR("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGERR")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 Q "1^Printed Images Logged"
