MAGGSFL1 ;WOIFO/GEK/SG - Image list Filters utilities ; 3/9/09 12:51pm
 ;;3.0;IMAGING;**8,93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ;***** UPDATES/CREATES THE IMAGE FILTER DEFINITION
 ; RPC: MAG4 FILTER SAVE
 ;
 ; .MAGRY        Reference to a local variable where the result
 ;               is returned to.
 ;
 ; .MAGGZ        Reference to a local array that stores the filter
 ;               data and related parameters.
 ;
 ; MAGZ(i)       Data item
 ;                 ^01: Field number
 ;                 ^02: Field value
 ;
 ;               The following special names can be used in place of
 ;               field numbers:
 ;
 ;                 FLAGS - Value contains flags that control the
 ;                         execution (can be combined):
 ;
 ;                           S  Selective save. If this flag is
 ;                              provided, then only the fields listed
 ;                              in the MAGZ array are updated; other
 ;                              filter properties are not changed.
 ;
 ;                              By default, all filter properties,
 ;                              which do not have new values in the
 ;                              MAGZ array, are cleared.
 ;
 ;                 IEN   - Value is the Internal Entry Number of the
 ;                         filter that has to be modified.
 ;
 ;                 USER  - Value is the IEN of the user who this
 ;                         filter is saved for.
 ; 
 ; Return Values
 ; =============
 ;
 ; In case of an error, the first ^-piece of the MAGRY contains 0, and
 ; the second one - the error message.
 ;
 ; Otherwise, IEN of the filter is returned in 1st ^-piece, and the
 ; filter name (value of the .01 field) - in the second one.
 ;
SET(MAGRY,MAGGZ) ;RPC [MAG4 FILTER SAVE]
 N $ETRAP,$ESTACK,FLAGS,FLTIEN,FLTUSER,MAGGDA,MAGGDAT,MAGGFDA,MAGGFLD,MAGOK,MAGGXE,RES,Z
 K MAGRY  S (FLTIEN,FLTUSER)=0,MAGOK=1,FLAGS=""
 S MAGRY="0^Starting: Saving Filter..."
 S $ETRAP="D ERR^"_$T(+0)
 I $D(MAGGZ)<10  S MAGRY="0^No input data, Operation CANCELED"  Q
 ;
 ;--- Parse the parameters
 S Z=""
 F  S Z=$O(MAGGZ(Z))  Q:Z=""  D  Q:'MAGOK
 . S MAGGFLD=$P(MAGGZ(Z),U),MAGGDAT=$P(MAGGZ(Z),U,2,99)
 . I MAGGFLD=""!(MAGGDAT="")  D  Q
 . . S MAGOK="0^Field and Value are Required"
 . . Q
 . I MAGGFLD="FLAGS"  S FLAGS=MAGGDAT  Q
 . I MAGGFLD="IEN"  S FLTIEN=+MAGGDAT  D  Q
 . . I FLTIEN>0,$D(^MAG(2005.87,FLTIEN))  Q
 . . S MAGOK="0^Invalid Filter IEN: "_FLTIEN
 . . Q
 . I MAGGFLD="USER"  S FLTUSER=+MAGGDAT,MAGGFLD=20
 . I '$$VALID^MAGGSIV1(2005.87,MAGGFLD,.MAGGDAT,.RES)  D  Q
 . . S MAGOK="0^"_RES
 . . Q
 . S MAGGFDA(2005.87,"+1,",MAGGFLD)=MAGGDAT
 . Q
 I 'MAGOK  S MAGRY=MAGOK  Q
 ;
 ;--- Lock the file header
 L +^MAG(2005.87,0):10  E  D  Q
 . S MAGRY="0^The File Image List Filters is locked."
 . S MAGRY=MAGRY_"  Operation canceled"
 . Q
 ;
 I FLTIEN>0  D
 . N IENS
 . S IENS=FLTIEN_","
 . ;--- Clear the old values if not requested otherwise.
 . I FLAGS'["S"  F Z=1:1:16,20,21  S MAGGFDA(2005.87,IENS,Z)="@"
 . M MAGGFDA(2005.87,IENS)=MAGGFDA(2005.87,"+1,")
 . K MAGGFDA(2005.87,"+1,")
 . ;--- Update the filter
 . D FILE^DIE("","MAGGFDA","MAGGXE")
 . I $D(DIERR)  D RTRNERR(.MAGRY)  Q
 . S MAGRY=FLTIEN_U_$P(^MAG(2005.87,FLTIEN,0),U)
 . Q
 E  D
 . N MAGGIEN
 . S MAGGFDA(2005.87,"+1,",22)=DUZ
 . ;--- Store the new filter
 . D UPDATE^DIE("S","MAGGFDA","MAGGIEN","MAGGXE")
 . I $D(DIERR)  D RTRNERR(.MAGRY)  Q
 . S MAGRY=MAGGIEN(1)_U_MAGGFDA(2005.87,"+1,",.01)
 . Q
 ;
 ;--- Cleanup
 L -^MAG(2005.87,0)
 D CLEAN^DILF
 Q
 ;
 ;+++++ RETURNS THE TEXT OF THE FILEMAN ERROR MESSAGE
RTRNERR(ETXT) ;
 N MAGRESA
 D MSG^DIALOG("A",.MAGRESA,245,5,"MAGGXE")
 S ETXT="0^"_MAGRESA(1)
 D CLEAN^DILF
 Q
 ;
 ;+++++ ERROR HANDLER
ERR ;
 N ERR
 L -^MAG(2005.87,0)
 S ERR=$$EC^%ZOSV
 S (MAGRY,MAGOK)="0^Error Filter Add/Edit: "_ERR
 D LOGERR^MAGGTERR(ERR)
 D @^%ZOSF("ERRTN")
 D CLEAN^DILF
 Q
