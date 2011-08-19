GMVDCSAV ;HOIFO/DAD,FT-VITALS COMPONENT: SAVE DATA ; 5/8/08
 ;;5.0;GEN. MED. REC. - VITALS;**9,3,25,23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ;  #4114 - ^PXRMINDX global     (controlled)
 ; #10103 - ^XLFDT calls         (supported)
 ;
 ; This routine supports the following IAs:
 ; #3996 - GMV ADD VM RPC called at EN1  (private)
 ; 
 ; 01/28/2005 KAM GMRV*5*9 Record midnight with 1 second added
 ;                         Stop adding second on multiple patent entry
 ;
EN1(RESULT,GMVDATA) ; GMV ADD VM [RPC entry point]
 ; Saves vitals data
 ; GMVDATA has the following data:
 ; piece1^piece2^piece3^piece4^piece5
 ; where:
 ;   piece1 = date/time in FileMan internal format
 ;   piece2 = patient number from FILE 2 (i.e., DFN)
 ;   piece3 = vital type, a semi-colon, the reading, a semi-colon, and
 ;            oxygen flow rate and percentage values [optional] (e.g.,
 ;            21;99;1 l/min 90%)
 ;   piece4 = hospital location (FILE 44) pointer value
 ;   piece5 = FILE 200 user number (i.e., DUZ), an asterisk, and the 
 ;            qualifier (File 120.52) internal entry numbers separated by
 ;            colons (e.g., 547*50:65)
 ; Example:
 ;  > S GMVDATA="3051011.1635^134^1;120/80;^67^87*2:38:50:75"
 ;  > D EN1^GMVDCSAV(.RESULT,GMVDATA)
 ;
 N GMVCNT,GMVDFN,GMVDTDUN,GMVDTENT,GMVENTBY,GMVFDA,GMVHOSPL
 N GMVLOOP,GMVMSG,GMVQUALS,GMVRES,GMVIEN,GMVVMEAS,GMVVQUAL,GMVVTYP
 D QUALTWO
 Q
QUALTWO ; Add a new entry to FILE 120.5
 K GMVFDA
 S GMVVMEAS=$P(GMVDATA,"*",1)
 S GMVDTDUN=+$P(GMVVMEAS,"^",1) ; Date time
 ;01/28/2005 KAM GMRV*5*9 Added next Line PAL-0105-60940 
 I +$P(GMVDTDUN,".",2)'>0 S GMVDTDUN=$$FMADD^XLFDT(GMVDTDUN,"","","",1)
 I +$P(GMVDTDUN,".",2)=24 S GMVDTDUN=$$FMADD^XLFDT(GMVDTDUN,"","","",1)
 S GMVDFN=+$P(GMVVMEAS,"^",2) ; Patient DFN
 S GMVVTYP=$P(GMVVMEAS,"^",3) ; Vital type
 S GMVDTDUN=$$CHKDT(GMVDTDUN,$P(GMVVTYP,";",1))
 S GMVDTENT=$$NOW^XLFDT ; Current date time
 S GMVHOSPL=+$P(GMVVMEAS,"^",4) ; Hospital
 S GMVENTBY=+$P(GMVVMEAS,"^",5) ; DUZ
 S GMVFDA(120.5,"+1,",.01)=GMVDTDUN ; Date time taken
 S GMVFDA(120.5,"+1,",.02)=GMVDFN   ; Patient
 S GMVFDA(120.5,"+1,",.03)=+$P(GMVVTYP,";",1)   ; Vital Type
 S GMVFDA(120.5,"+1,",.04)=GMVDTENT  ; Date Time entered
 S GMVFDA(120.5,"+1,",.05)=GMVHOSPL  ; Hospital
 S GMVFDA(120.5,"+1,",.06)=GMVENTBY  ; Entered by (DUZ)
 S GMVFDA(120.5,"+1,",1.2)=$P(GMVVTYP,";",2) ; Rate
 S GMVFDA(120.5,"+1,",1.4)=$P(GMVVTYP,";",3) ; Sup 02
 S GMVIEN=""
 D UPDATE^DIE("","GMVFDA","GMVIEN"),FMERROR
 S GMVCNT=1
 S GMVQUALS=$P(GMVDATA,"*",2)
 F GMVLOOP=1:1:$L(GMVQUALS,":")+1 D
 . S GMVVQUAL=$P(GMVQUALS,":",GMVLOOP)
 . Q:GMVVQUAL=""
 . S GMVCNT=GMVCNT+1
 . D ADDQUAL^GMVGETQ(.GMVRES,GMVIEN(1)_"^"_GMVVQUAL)
 . Q
 Q 
 ;
CHKDT(GMVDT,GMVSAV) ;Check if there is a vital entered for that date and time.
 ; If there is then add one second to the date/time until you find a
 ; date/time not used.
 N GMVFLAG
 S GMVFLAG=0
 F  Q:GMVFLAG  D
 .I '$D(^PXRMINDX(120.5,"PI",GMVDFN,GMVSAV,GMVDT)) S GMVFLAG=1 Q
 .S GMVDT=$$FMADD^XLFDT(GMVDT,"","","",1)
 .Q
 Q GMVDT
 ;
MSG(X) ; *** Add a line to the message array ***
 S (GMVMSG,RESULT(-1))=1+$G(RESULT(-1),0)
 S RESULT(GMVMSG)=X
 I $P(X,":")="ERROR" S RESULT(0)="ERROR"
 Q
 ;
FMERROR ;
 I $O(^TMP("DIERR",$J,0))>0 D
 . N GMVER1,GMVER2
 . S GMVER1=0
 . F  S GMVER1=$O(^TMP("DIERR",$J,GMVER1)) Q:GMVER1'>0  D
 .. S GMVER2=0
 .. F  S GMVER2=$O(^TMP("DIERR",$J,GMVER1,"TEXT",GMVER2)) Q:GMVER2'>0  D
 ... D MSG("ERROR: "_$G(^TMP("DIERR",$J,GMVER1,"TEXT",GMVER2)))
 ... Q
 .. Q
 . Q
 D CLEAN^DILF
 Q
