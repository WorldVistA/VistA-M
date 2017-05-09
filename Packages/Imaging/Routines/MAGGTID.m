MAGGTID ;WOIFO/SRR/RED/SAF/GEK/SG/JSL/NST - Deletion of Images and Pointers ;
 ;;3.0;IMAGING;**8,59,93,118,150,138,167**;Mar 19, 2002;Build 30;Dec 19, 2016
 ;;
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
IMAGEDEL(MAGGRY,MAGIEN,MAGGRPDF,REASON) ;RPC [MAGG IMAGE DELETE]
 ; Call to Delete Image entry from Image file ^MAG(2005
 ; MAGIEN   Image IEN ^ SYSDEL flag
 ; MAGGRPDF   group delete flag   1 = group delete allowed
 ; SYSDEL    Flag that forces delete, even if no KEY
 ; 
 N IEN,Y,RY
 ; 1 in 3rd piece means : DELETE the Image File Also.
 S MAGGRPDF=+$G(MAGGRPDF),REASON=$G(REASON),IEN=+MAGIEN
 L +^MAG(2005,IEN):4
 E  S MAGGRY(0)="Image ID# "_IEN_" is Locked. Delete is Canceled" Q
 D DELETE(.MAGGRY,MAGIEN,1,MAGGRPDF,REASON)
 L -^MAG(2005,IEN)
 Q
DELETE(RY,MAGIEN,DF,GRPDF,REASON) ;RPC [MAGQ DIK] Entry point for silent call
 ;RY=Return Array RY(0)="1^SUCCESS" 
 ;                RY(0)="0^reason for failure"
 ;                ;NOT RETURNING LIST AT THIS TIME
 ;                ( RY(1)..RY(n)= IEN's of deleted images.)
 ;MAGIEN=Image entry number to be deleted
 ; if MAGIEN has a 2nd piece = 1 then we force delete, don't test 
 ; for MAG DELETE KEY
 ; if MAGIEN has a 3rd piece,  it's an Xtra PRocessing Flag ;P150
 ; Patch 129 Capture and Patch 135 Import API Now send this flag.  ;P150
 ;DF=Delete file flag - 1=delete the Image file
 ;                    - 0=don't delete the image file
 ;
 S REASON=$G(REASON) I REASON="" S REASON="Unknown reason"
 S RY(0)="0^Image Delete Failed, reason unknown."
 I '$D(MAGSYS) D
 . N Y
 . D GETENV^%ZOSV  ; IA # 10097 
 . S MAGSYS=$P(Y,"^",2)
 . Q
 N MAGERR,SYSDEL,Z,GRPDEL,MAGACN
 N XPRC,NOIMG ; P150
 S XPRC=$$UP^XLFSTR($P(MAGIEN,U,3)) ;P150 The new $p(,,3) says there is XtraPRocessing.
 S SYSDEL=+$P(MAGIEN,U,2),MAGIEN=+MAGIEN
 S NOIMG=$S(XPRC="NOIMAGE":1,1:0) ; P150
 I NOIMG D NOIMAGE(MAGIEN) ;P150
 ; Check the business rules for deleting an image
 I 'NOIMG D DELETE^MAGSIMBR(.RY,MAGIEN,SYSDEL) I +RY(0)=0 Q  ;150 put 'NOIMG
 ;  a couple tests of privilege and valid IEN
 I '$D(^MAG(2005,MAGIEN,0)) D  Q
 . S RY(0)="0^Image entry doesn't exist in image file"
 I +$O(^MAG(2005,MAGIEN,1,0)),+$G(GRPDF)=0 D  Q
 . S RY(0)="0^Deleting a Group is not allowed."
 I +$O(^MAG(2005,MAGIEN,1,0)),+$G(GRPDF)'=0 D  Q
 . N MAGGRP S MAGGRP=MAGIEN N MAGIEN,MAGX,MAGOK,MAGFAIL
 . S MAGX=0,MAGOK=0,MAGFAIL=0
 . S GRPDEL=1  ; we are deleting a group - used in DELGRP entry
 . F  S MAGX=$O(^MAG(2005,MAGGRP,1,MAGX)) Q:'MAGX  D
 . . S MAGIEN=$P($G(^MAG(2005,MAGGRP,1,MAGX,0)),"^") D DEL1IMG
 . . I +RY(0) S Z=+$O(RY(""),-1),RY(Z)=RY(Z)_"^"_RY(0),MAGOK=MAGOK+1
 . . E  S Z=+$O(RY(""),-1)+1,RY(Z)=MAGIEN_"^"_RY(0),MAGFAIL=MAGFAIL+1
 . . Q
 . I +MAGFAIL=0 S RY(0)="1^Deletion of Group #"_MAGGRP_" was successful.^"_MAGOK_"^0"
 . E  S RY(0)="0^Error deleting child image(s). Group Not Deleted.^"_MAGOK_"^"_MAGFAIL
 . I (+MAGFAIL=0),$G(MAGACN)'="" D  ; No errors and Accession number exists
 . . N SSEP,OUT
 . . S SSEP=$$STATSEP^MAGVRS41
 . . D DELNEW^MAGVD008(.OUT,MAGACN,REASON)  ; Delete studies in P34 data structure by accession number
 . . I OUT<0 S RY(0)="0^Deletion of Group #"_MAGGRP_" was successful but failed in New: "_$P(OUT,SSEP,2)
 . . Q
 . Q
 ; Ok lets start
 ; lets delete the parent pointers first.
DEL1IMG ;
 N DELMSG,Z,MAGDFN
 D DELPAR^MAGSDEL2
 I $G(MAGERR) S RY(0)="0^Error: Deleting Specialty Pointers. Image Not Deleted. "_DELMSG Q
 ;
 ; Now delete image record & xref's
 ; if this Image is member of group DELGRP will delete those pointers
 ; and delete the Group, if this is only image in it.
 S MAGDFN=$P($G(^MAG(2005,MAGIEN,0)),"^",7) ; Moved here from below. DELGRP needs MAGDFN now.
 D DELGRP
 I $G(MAGERR) S RY(0)="0^Error deleting Group Pointers." Q
 ;
 ; write the deleted by, delete reason, and delete date to the file.
 ; P150   If NOIMAGE,  SetDel was already called.
 I 'NOIMG D SETDEL(MAGIEN,REASON) ;P150 NOIMG
 ;
 ; save the Image record to the archive before we delete it.
 D ARCHIVE(MAGIEN)
 ;
 ; Now let's set the Queue to delete the Image File, if Flag is set
 I $G(DF) D DELFILE
 ; 
 ; we're having "APPXDT" crossref left around, lets delete it first.
 S X=MAGDFN,DA=MAGIEN D KILPPXD^MAGUXRF
 ;
 ; now lets delete the image.
 K DIK,DA,DA(1),DA(2),DIC,DR,DIE,DIR S DIK="^MAG(2005,",DA=MAGIEN
 D ^DIK
 S Z=+$O(RY(""),-1)+1,RY(Z)=MAGIEN
 ; we were having problems with "AC" so lets check to make sure.
 I $D(^MAG(2005,"AC",MAGDFN,MAGIEN)) K ^MAG(2005,"AC",MAGDFN,MAGIEN)
 ; log it.
 S X=$S(NOIMG:"NOIMAGE",1:"DELETE") ; P150 NOIMG
 D ENTRY^MAGLOG(X,$G(DUZ),$G(MAGIEN),"PARENT:"_$G(MAGSTORE),$G(MAGDFN),1) ;P150
 S X=$S(NOIMG:"NOIMAGE^",1:"DEL^") ; 150 NOIMG
 S X=X_$G(MAGDFN)_"^"_$G(MAGIEN) ; 150 use X instead of "DEL^"
 D ACTION^MAGGTAU(X,"1")
 ; The 140 cross reference of 2005.1 has set the Status to 12,  here we change it to 13 ;P150
 I NOIMG D SETSTAT(MAGIEN,13) ;P150
 S RY(0)="1^Deletion of Image was Successful." ;P150 
 ; P150 Put above line back in.  Code below is new for 118.
 I '$G(GRPDEL),$G(MAGACN)'="" D  ; If we delete a single image in a group and ACN is defined
 . N SSEP,OUT
 . S SSEP=$$STATSEP^MAGVRS41
 . D DELNEW^MAGVD008(.OUT,MAGACN,REASON)  ; Delete studies in P34 data structure by accession number
 . I OUT<0 S RY(0)="0^Deletion of Image in Legacy was Successful but failed in New: "_$P(OUT,SSEP,2)
 . E  S RY(0)="1^Deletion of Image was Successful."
 . Q
 Q
NOIMAGE(MAGNOT) ; P150 Whole function is new. This is called when No Image exists.
 ; Clear the Fields #2,  #2.1 and 102 This is the Abstract, Full and BIG
 ;   pointers to the Image Share (Image Network Drive) ( Tier1 ) 
 ; Set Status and Status Reason
 ; Set SysDel and GrpDel Flags to allow deleting in all instances.
 N MAGNFDA,MAGGXE,MAGERR,REASDESC,REASDA,MAGDA
 S REASDESC="Image Never Existed"
 S REASDA=$O(^MAG(2005.88,"B",REASDESC,""))
 D SETDEL(MAGNOT,REASDESC) ; Set the Delete Fields. 
 ;
 S MAGDA=MAGNOT
 S MAGNOT=MAGNOT_","
 S MAGNFDA(2005,MAGNOT,2)="@" ;
 S MAGNFDA(2005,MAGNOT,2.1)="@"
 S MAGNFDA(2005,MAGNOT,102)="@"
 S MAGNFDA(2005,MAGNOT,113)=13
 S MAGNFDA(2005,MAGNOT,113.3)=REASDA
 ;;;;;;;
 D UPDATE^DIE("","MAGNFDA","","MAGGXE")
 ;  ? ? If Error during UPdate..  Delete the entry.
 I $D(DIERR) D  S RY=MAGERR Q
 . D RTRNERR(.MAGERR)
 . S DA=MAGDA,DIK="^MAG(2005," D ^DIK
 . K DA,DIC,DIK
 . D CLEAN^DILF
 Q
RTRNERR(ETXT) ; There was error from UPDATE^DIE quit with error text
 ; P150 this function put in to keep NOIMAGE same
 S ETXT="0^ERROR  "_MAGGXE("DIERR",1,"TEXT",1)
 Q
DELGRP ;del grp ptrs and check to see if this is the last image in the group
 N MAGGRP,MAGX,MAGQUIT,MAGIFNS,Z
 S MAGGRP=$P($G(^MAG(2005,MAGIEN,0)),"^",10)
 Q:'$G(MAGGRP)
 K DIK,DA,DA(1),DA(2),DIC,DR,DIE,DIR
 S MAGX=0,MAGQUIT=0
 F  S MAGX=$O(^MAG(2005,MAGGRP,1,MAGX)) Q:'MAGX  D  Q:MAGQUIT
 . I +^MAG(2005,MAGGRP,1,MAGX,0)=MAGIEN D
 . . S DIK="^MAG(2005,MAGGRP,1,",DA(1)=MAGGRP,DA=MAGX D ^DIK S MAGQUIT=1
 . . ;added DA(1) needed for xref deletion of dicom series 
 . I $O(^MAG(2005,MAGGRP,1,0))="" D
 . . I $P($G(^MAG(2005,MAGGRP,2)),"^",6) D
 . . . ;report is on group - need to delete it
 . . . S MAGIFNS=MAGIEN,MAGIEN=MAGGRP
 . . . D DELPAR^MAGSDEL2
 . . . S MAGIEN=MAGIFNS
 . . I '$D(MAGERR) D
 . . . I $T(^MAGVD003)'="" D  ; This check needs to be removed after release of patch 118
 . . . . N OUT
 . . . . D GETACN^MAGVD003(.OUT,MAGGRP)  ; Get accession number for this group first
 . . . . S MAGACN=$S($$ISOK^MAGVAF02(OUT):$$GETVAL^MAGVAF02(OUT),1:"")
 . . . . Q
 . . . D SETDEL(MAGGRP,REASON),ARCHIVE(MAGGRP) S DIK="^MAG(2005,",DA=MAGGRP D ^DIK
 . . . ; Log the Deletion of The Group Header to  ^MAG(2006.95, and ^MAG(2006.82 
 . . . D ENTRY^MAGLOG("DELETE",$G(DUZ),$G(MAGGRP),"PARENT:"_$G(MAGSTORE),$G(MAGDFN),1,"Group Header deleted")
 . . . S X="DEL^"_$G(MAGDFN)_"^"_$G(MAGGRP)
 . . . D ACTION^MAGGTAU(X,"1")
 . . . S Z=+$O(RY(""),-1)+1,RY(Z)=MAGGRP_"^1^Deletion of Group was Successful."
 . . . Q
 . . Q
 . Q
 Q
SETDEL(MAGIEN,REASON) ; set deletion fields
 N DA,DR,DIE,X
 ;N %H
 ;S %H=$H D YMD^%DTC
 S X=$$NOW^XLFDT
 ;  gek - changed 3 slash to 4 slash. to stop FM question marks. ??
 S DR="30////"_DUZ_";30.1////"_X_";30.2////"_REASON
 S DIE="2005",DA=MAGIEN D ^DIE
 Q
 ;
SETSTAT(MAGIEN,STAT) ; p150 new function.  Set STATUS fields
 N DA,DR,DIE
 ; 4 slash. to stop FM question marks. ??
 S DR="113////"_STAT
 S DIE="2005.1",DA=MAGIEN D ^DIE
 Q
ARCHIVE(MAGARCIE) ;save image data before deletion
 N DA,DIK,MAGCNT,MAGLAST,SUB,TMP,%X,%Y
 S MAGCNT=$P(^MAG(2005.1,0),U,4)+1
 S %X="^MAG(2005,"_MAGARCIE_",",%Y="^MAG(2005.1,"_MAGARCIE_","
 D %XY^%RCR
 ;--- GEK 9/29/00 Fix the 3rd piece to be last IEN in file.
 S MAGLAST=$O(^MAG(2005.1,"A"),-1)
 S $P(^MAG(2005.1,0),U,4)=MAGCNT
 I '($P(^MAG(2005.1,0),U,3)=MAGLAST) S $P(^MAG(2005.1,0),U,3)=MAGLAST
 ;
 ;--- Fix subfile numbers in the headers of the multiples (MAG*3*93).
 ;    IF DEFINITIONS OF MULTIPLES OF THE IMAGE AUDIT FILE (#2005.1)
 ;    CHANGE OR NEW MULTIPLES ARE ADDED, THE FOLLOWING CODE MUST BE
 ;--- CHECKED AND UPDATED IF NECESSARY!
 ;
 F SUB="1^2005.14P","4^2005.1106DA","5^2005.11PA","6^2005.1111A","99^2005.199D"  D
 . S TMP=$P(SUB,U)  Q:'($D(^MAG(2005.1,MAGARCIE,TMP,0))#2)
 . S $P(^MAG(2005.1,MAGARCIE,TMP,0),U,2)=$P(SUB,U,2)
 . Q
 ;
 ;--- Create cross-reference entries for the entry
 S DA=MAGARCIE
 S DIK="^MAG(2005.1," D IX1^DIK
 Q
DELFILE ;Delete image file on server if exists 
 ;gek 3/21/2003  Changed to stop using FullRes Path for Abs,Big
 ;   and only Delete .TXT and Alternates if Full is being deleted.
 N X0,X1,X2,ALTEXT,ALTPATH,MAGXX,XBIG,MAGFILE2
 N MAGPLC ; DBI - SEB 9/20/2002
 ; MAGIEN IS ASSUMED TO BE DEFINED.
 ; MAGXX         - This is IEN in ^MAG(2005, MAGFILEB Expects this to be defined.
 ; MAGPLC        - "Place" of Full Res Image.  
 ; ALTEXT        - Extension of the Alternate image file.
 ; ALTPATH       - Full path of Alternate image file.
 S X0=^MAG(2005,MAGIEN,0)
 ;delete Full Res if one exists on Magnetic
 I $P(X0,U,3) D
 . S MAGXX=MAGIEN
 . S MAGPLC=$$DA2PLC^MAGBAPIP(MAGIEN,"F")
 . D VSTNOCP^MAGFILEB
 . S X=$$DELETE^MAGBAPI(MAGFILE2,MAGPLC)
 . ;Delete any other ALTernate files. ( TXT) 
 . ;gek 3/31/03  Since ALT files are (for now) always on same server as Full
 . ;    We only attempt to delete them here  (If we have a path to FullRes on Magnetic)
 . S X2=0
 . F  S X2=$O(^MAG(2006.1,MAGPLC,2,X2)) Q:'X2  D
 . . S ALTEXT=$P(^MAG(2006.1,MAGPLC,2,X2,0),"^",1)             ;CR1023
 . . S ALTPATH=MAGFILE2,$P(ALTPATH,".",$L(ALTPATH,"."))=ALTEXT ;CR1023 for FQDN issue
 . . S X=$$DELETE^MAGBAPI(ALTPATH,MAGPLC)
 . Q
 ;
 ;delete image abstract if one exists on Magnetic
 I $P(X0,U,4) D
 . S MAGXX=MAGIEN
 . D ABSNOCP^MAGFILEB
 . S X=$$DELETE^MAGBAPI(MAGFILE2,$$DA2PLC^MAGBAPIP(MAGIEN,"A")) ; DBI - SEB 9/20/2002
 ;
 ;delete the big file if one exists on Magnetic
 S XBIG=$G(^MAG(2005,MAGIEN,"FBIG"))
 I $P(XBIG,U) D 
 . S MAGXX=MAGIEN
 . D BIGNOCP^MAGFILEB
 . S X=$$DELETE^MAGBAPI(MAGFILE2,$$DA2PLC^MAGBAPIP(MAGIEN,"B")) ; DBI - SEB 9/20/2002
 Q
