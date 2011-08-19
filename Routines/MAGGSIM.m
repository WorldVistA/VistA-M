MAGGSIM ;WOIFO/GEK - Call to Modify Image File entry ; [ 12/27/2000 10:49 ]
 ;;3.0;IMAGING;**7,8**;Sep 15, 2004
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
MOD(MAGRY,MAGARRAY) ; RPC Call to UPDATE^DIE to Add an Image File entry
 ;  Parameters : 
 ;    MAGARRAY -  array of field numbers and their entries
 ;             i.e. MAGARRAY(1)=".5^38"  field# .5   data is 38
 ;    If Long Description is included in array (field 11), we create a new
 ;      array to hold the text, and pass that to UPDATE^DIE
 ;    If this entry is an Image Group
 ;      i.e. MAGARRAY(n)="2005.04^344"
 ;      (the field 2005.04 is the OBJECT GROUP MULTIPLE)
 ;      ( 344 is the pointer to the Image File Entry that will be added
 ;      ( as a member of this new/existing Group)
 ;
 ;  Return Variable
 ;       MAGRY is a string;
 ;               "1^success"
 ;               "0^Error message"
 ;
 N MAGGFDA,MAGGDRV,MAGGRP,MAGCHLD,GRPCT,MAGGDA,MAGGFNM
 N MAGGWP,WPCT,MAGGFLD,MAGGDAT,MAGERR
 N MAGREF,MAGDHASH,MAGTEMP
 N MAGVY,MAGACT
 N MAGTEMP,TEMPIEN
 N MAGGIEN,MAGGXE
 N I,J,X,Y,Z
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGSERR"
 ;
 I ($D(MAGARRAY)<10) S MAGRY="0^No input data, Operation CANCELED" Q
 ;
 S MAGRY="0^Creating VistA Image Entry..."
 S MAGERR="",MAGGRP=0,GRPCT=1,WPCT=0
 ;
 ;  Validate the Data, and Action codes in the Input Array
 D VAL^MAGGSIV(.MAGVY,.MAGARRAY) I 'MAGVY(0) S MAGRY=MAGVY(0) Q
 ;
 ;
 ;  Make the FileMan FDA array and the Imaging Action array.
 D MAKEFDA^MAGGSIU2(.MAGGFDA,.MAGARRAY,.MAGACT,.MAGCHLD,.MAGGRP,.MAGGWP)
 ;
 I '$D(MAGACT("IEN")) S MAGRY="0^You Need to send the IEN" Q
 ;
 I '$D(MAGGFDA(2005,"+1,")) S MAGRY="0^No data to file.  Operation CANCELED." Q
 ;
 S TEMPIEN=MAGACT("IEN")_","
 M MAGTEMP(2005,TEMPIEN)=MAGGFDA(2005,"+1,") K MAGGFDA
 M MAGGFDA=MAGTEMP K MAGTEMP
 ;
 D FILE^DIE("S","MAGGFDA","MAGGIEN","MAGGXE")
 ; We shouldn't have errors, because the data was validated before the call
 ; But we'll still check for errors.
 I $D(DIERR) D  S MAGRY=MAGERR Q
 . D RTRNERR(.MAGERR)
 . D CLEAN^DILF
 ;
 ;S MAGRY="1^OK"         
 D ACTION^MAGGTAU("MOD^"_MAGGFDA(2005,"+1,",5)_"^"_$G(MAGACT("IEN")))
 ;
 ;Q
 ;  THE REST OF THIS IS FROM IMAGE ADD, DON'T KNOW YET WHAT
 ;  WE NEED TO CHECK or are going to allow from the GUI.
 ;
 ; IF THE IEN is a group, Modify GROUP PARENT in each Group Object and QUIT
 ;
 I MAGGRP D UPDCHLD(.MAGCHLD,MAGACT("IEN")) S MAGRY="1^OK" Q
 ; 
 I $G(MAGGFDA(2005,"+1,",14)) D  I $L(MAGERR) S MAGRY=MAGERR Q
 . D UPDPAR(.MAGERR,MAGGFDA(2005,"+1,",14),.MAGACT,MAGACT("IEN"))
 Q
UPDPAR(MAGERR,MAGRPDA,MAGACT,MAGGDA) ;
 ; We're here beceause this image is a member of a Group
 ;   so we will modify the Group Parent, adding this to it's group
 ; HERE we will also send the 'Series Number' and 'Image Number' if
 ; they exist;
 N MAGFDA
 S Y="+2,"_MAGRPDA_","
 S MAGFDA(2005.04,Y,.01)=MAGGDA
 ; DICOM SERIES AND IMAGE NUMBER CAN BE ANYTHING, WE CAN'T CHECK FOR +X
 I $L($G(MAGACT("DICOMSN"))) S MAGFDA(2005.04,Y,1)=MAGACT("DICOMSN")
 I $L($G(MAGACT("DICOMIN"))) S MAGFDA(2005.04,Y,2)=MAGACT("DICOMIN")
 D UPDATE^DIE("S","MAGFDA","MAGGIEN","MAGGXE")
 ;   in case of an error
 I $D(DIERR) D RTRNERR(.MAGERR)
 D CLEAN^DILF
 Q
 ;
UPDCHLD(MAGCHLD,MAGGDA) ;
 S Z=""
 F  S Z=$O(MAGCHLD(Z)) Q:Z=""  D
 . S $P(^MAG(2005,Z,0),U,10)=MAGGDA
 . ; TODO;  have to modify the parent global root, ( delete it if 
 . ; this image was assigned as a single to the wrong parent )
 Q
RTRNERR(ETXT) ; There was error from FILE^DIE quit with error text
 S ETXT="0^ERROR  "_MAGGXE("DIERR",1,"TEXT",1)
 Q
