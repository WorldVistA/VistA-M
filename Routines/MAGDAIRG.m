MAGDAIRG ;WOIFO/SG - Automatic Import Reconciliation Workflow ; 29 Jul 2009 7:26 AM
 ;;3.0;IMAGING;**53**;Mar 19, 2002;Build 1719;Apr 28, 2010
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
 ;***** BUILDS THE LIST OF IMAGING TYPES AND "NO CREDIT" LOCATIONS
 ;
 ; .DVITLST      Reference to a local variable where the division,
 ;               imaging type, and "No Credit" imaging locations are
 ;               returned to.
 ;
 ; DVITLST(
 ;   DivIEN,
 ;     TypeIEN,  Number of "No Credit" imaging locations
 ;       LocIEN) ""
 ;
LIST(DVITLST) ;
 N DIVIEN,IEN1,ILIEN,ITIEN,MAGERR,TMP
 K DVITLST
 ;
 ;=== Load the list of imaging types that are referenced by radiology 
 ;    procedures. There is no point in creating outside locations for
 ;=== imaging types that are not used at the site.
 S ITIEN=0
 F  S ITIEN=$O(^RAMIS(71,"AIMG",ITIEN))  Q:ITIEN'>0  D
 . S DVITLST(0,ITIEN)=0
 . Q
 ;
 ;=== Check the Radiology files
 S DIVIEN=0
 F  S DIVIEN=$O(^RA(79,DIVIEN))  Q:DIVIEN'>0  D
 . I '$D(^RA(79,DIVIEN,"L","B")) Q  ; ignore inactivated divisions
 . ;--- Use the same list of imaging types for all divisions
 . M DVITLST(DIVIEN)=DVITLST(0)
 . ;=== Load locations of the division
 . S IEN1=0
 . F  S IEN1=$O(^RA(79,DIVIEN,"L",IEN1))  Q:IEN1'>0  D
 . . ;--- IEN of the imaging location
 . . S ILIEN=$$GET1^DIQ(79.01,IEN1_","_DIVIEN_",",.01,"I",,"MAGERR")
 . . Q:ILIEN'>0
 . . ;--- IEN of the imaging type
 . . S ITIEN=$$GET1^DIQ(79.1,ILIEN_",",6,"I",,"MAGERR")
 . . ;--- Store the association
 . . S:ITIEN>0 DVITLST(DIVIEN,ITIEN,ILIEN)=""
 . . Q
 . ;=== Keep only "No Credit" locations
 . S ITIEN=0
 . F  S ITIEN=$O(DVITLST(DIVIEN,ITIEN))  Q:ITIEN'>0  D
 . . S DVITLST(DIVIEN,ITIEN)=0
 . . S ILIEN=0
 . . F  S ILIEN=$O(DVITLST(DIVIEN,ITIEN,ILIEN))  Q:ILIEN'>0  D
 . . . S TMP=+$$GET1^DIQ(79.1,ILIEN_",",21,"I",,"MAGERR")
 . . . I TMP'=2  K DVITLST(DIVIEN,ITIEN,ILIEN)  Q
 . . . S DVITLST(DIVIEN,ITIEN)=DVITLST(DIVIEN,ITIEN)+1
 . . . Q
 . . Q
 . Q
 ;
 ;=== Cleanup
 K DVITLST(0)
 Q
 ;
 ;##### CHECKS THE OUTSIDE LOCATIONS AND DISPLAYS THEM
 ; 
 ; Input Parameter
 ; ===============
 ; VERBOSE -- 1 output messages (default)
 ;            0 suppress messages
 ;            
 ; Output Parameter
 ; ================
 ; DVITLST ---  described above at beginning of LIST subroutine
 ;            
 ; Return Values
 ; =============
 ;           -2  Required outside locations are not (properly) defined
 ;               in the OUTSIDE IMAGING LOCATION file (#2006.5759)
 ;           -1  Required "No Credit" locations are not (properly)
 ;               defined in the Radiology files.
 ;            0  Ok
 ; Notes
 ; =====
 ;
 ; This entry point can also be called as a procedure:
 ; D DISPLAY^MAGDAIRG() if you do not need its return value.
 ;
DISPLAY(VERBOSE,DVITLST) ;
 N DIVIEN,ERRCNT,IEN,IENS,ILIEN,ITIEN,MAGBUF,MAGERR,MAGLST,TMP
 S VERBOSE=$G(VERBOSE,1) ; default is verbose
 ;
 ;=== Load the list of imaging types and "No Credit" locations
 D LIST(.DVITLST)
 ;
 ;=== Check the Radiology files
 W:VERBOSE !!,"Checking the Radiology files..."
 S (DIVIEN,ERRCNT)=0
 F  S DIVIEN=$O(DVITLST(DIVIEN))  Q:DIVIEN'>0  D
 . W:VERBOSE !,"Division: "_$$DIVNAME(DIVIEN)
 . S ITIEN=0
 . F  S ITIEN=$O(DVITLST(DIVIEN,ITIEN))  Q:ITIEN'>0  D
 . . S MAGLST(DIVIEN,ITIEN)=0
 . . ;--- Check if there is at least one "No Credit" location for
 . . ;--- this imaging type
 . . Q:DVITLST(DIVIEN,ITIEN)>0
 . . ;--- Display the warning message
 . . W:VERBOSE !?2,$$ITNAME(ITIEN),?32," - Define ""No Credit"" Imaging Location!"
 . . S ERRCNT=ERRCNT+1
 . . Q
 . Q
 ;--- Instruct the user to create missing "No Credit" locations
 I ERRCNT>0  D:VERBOSE  Q:$QUIT -1  Q
 . W !!  D MESSAGE("MSG1")  W !
 . Q
 ;
 ;=== Check the OUTSIDE IMAGING LOCATION file (#2006.5759)
 W:VERBOSE !!,"Checking the OUTSIDE IMAGING LOCATION file (#2006.5759)..."
 S IEN=0
 F  S IEN=$O(^MAGD(2006.5759,IEN))  Q:IEN'>0  D
 . S IENS=IEN_","  K MAGBUF
 . D GETS^DIQ(2006.5759,IENS,".01;2;4","I","MAGBUF","MAGERR")
 . S DIVIEN=+$G(MAGBUF(2006.5759,IENS,4,"I"))   ; INSTITUTION
 . S ITIEN=+$G(MAGBUF(2006.5759,IENS,2,"I"))    ; IMAGING TYPE
 . S ILIEN=+$G(MAGBUF(2006.5759,IENS,.01,"I"))  ; IMAGING LOCATION
 . ;--- Check if all required pointers are valid
 . I '$D(DVITLST(DIVIEN,ITIEN,ILIEN))  D:VERBOSE  S ERRCNT=ERRCNT+1 Q
 . . W !,"Invalid record in the file #2006.5759 (IEN="_IEN_")!"
 . . Q
 . ;--- Add the outside location to the list
 . S MAGLST(DIVIEN,ITIEN,ILIEN)=IEN
 . S MAGLST(DIVIEN,ITIEN)=$G(MAGLST(DIVIEN,ITIEN))+1
 . Q
 ;
 ;=== Display the associations for each division and image type
 S (DIVIEN,ERRCNT)=0
 F  S DIVIEN=$O(MAGLST(DIVIEN))  Q:DIVIEN'>0  D
 . W:VERBOSE !!,"Division: "_$$DIVNAME(DIVIEN)
 . S ITIEN=0
 . F  S ITIEN=$O(MAGLST(DIVIEN,ITIEN))  Q:ITIEN'>0  D
 . . W:VERBOSE !?2,$$ITNAME(ITIEN),?32," - "
 . . ;--- No association for this division and image type
 . . I MAGLST(DIVIEN,ITIEN)'>0  D:VERBOSE  S ERRCNT=ERRCNT+1  Q
 . . . W "Create record in file #2006.5759!"
 . . . Q
 . . ;--- Multiple associations for this division and image type
 . . I MAGLST(DIVIEN,ITIEN)>1  D:VERBOSE  S ERRCNT=ERRCNT+1  Q
 . . . W "Delete redundant records in file #2006.5759!"
 . . . S ILIEN=0
 . . . F  S ILIEN=$O(MAGLST(DIVIEN,ITIEN,ILIEN))  Q:ILIEN'>0  D
 . . . . S TMP=$$GET1^DIQ(79.1,ILIEN_",",.01,,,"MAGERR")
 . . . . S:TMP="" TMP="Unknown Imaging Location (IEN="_ILIEN_")"
 . . . . W !?32," - ",TMP
 . . . . Q
 . . . Q
 . . ;--- Valid association for this division and image type
 . . S ILIEN=$O(MAGLST(DIVIEN,ITIEN,0))
 . . S TMP=$$GET1^DIQ(79.1,ILIEN_",",.01,,,"MAGERR")
 . . I TMP="" D
 . . . S TMP="Unknown Imaging Location (IEN="_ILIEN_")"
 . . . S ERRCNT=ERRCNT+1
 . . . Q
 . . W:VERBOSE TMP
 . . Q
 . Q
 ;
 ;=== Instruct the user to fix problems in the OUTSIDE IMAGING LOCATION file
 I ERRCNT>0 D:VERBOSE  Q:$QUIT -2  Q
 . W !!  D MESSAGE("MSG2")  W !
 . Q
 ;
 ;=== Success
 Q:$QUIT 0  Q
 ;
 ;+++++ RETURNS DIVISION NAME
DIVNAME(DIVIEN) ;
 N MAGERR,NAME
 S NAME=$$GET1^DIQ(4,DIVIEN_",",.01,,,"MAGERR")
 Q $S(NAME'="":NAME,1:"Unknown (IEN="_DIVIEN_")")
 ;
 ;+++++ RETURNS NAME OF THE IMAGING TYPE
ITNAME(ITIEN) ;
 N MAGERR,NAME
 S NAME=$$GET1^DIQ(79.2,ITIEN_",",.01,,,"MAGERR")
 Q $S(NAME'="":NAME,1:"Unknown Imaging Type (IEN="_ITIEN_")")
 ;
 ;+++++ FORMATS AND DISPLAYS THE MULTILINE MESSAGE
MESSAGE(TAG) ;
 N DIWF,DIWL,DIWR,MAGI,X
 K ^UTILITY($J,"W")
 S DIWF="W",DIWL=1,DIWR=$G(IOM,80)-1
 F MAGI=1:1  S X=$P($T(@TAG+MAGI),";;",2)  Q:X=""  D ^DIWP
 D ^DIWW
 Q
 ;
 ;+++++ MESSAGES
MSG1 ;
 ;;Please define missing "No Credit" imaging locations for the
 ;;aforementioned divisions and imaging types (using the Location
 ;;Parameter Set-up [RA SYSLOC] and Division Parameter Set-up
 ;;[RA SYSDIV] options of the System Definition Menu ... [RA SYSDEF]
 ;;options) and then run this option again.
MSG2 ;
 ;;Please fix the aforementioned problems in the OUTSIDE IMAGING
 ;;LOCATION file (#2006.5759) and then run this option again.
