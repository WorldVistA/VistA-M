MAGGTIA1 ;WOIFO/GEK/SG - RPC Call to Add Image File entry ; 1/22/09 1:42pm
 ;;3.0;IMAGING;**21,8,59,93**;Dec 02, 2009;Build 163
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
ADD ;Now call Fileman to file the data
 N NEWIEN,MAGGDA,X,Y
 ;~~~ Delete this comment and the following line of code when
 ;    the IMAGE AUDIT file (#2005.1) is completely eliminated.
 ;    Because we delete the Image node on image deletion, we have to 
 ;    check the last entry in Audit File, to see if it is greater
 ;~~~ than the last image in the Image File.
 I ($O(^MAG(2005,"A"),-1)<$O(^MAG(2005.1,"A"),-1)) S $P(^MAG(2005,0),U,3)=$O(^MAG(2005.1,"A"),-1)
 ;   we know that MAGGIEN WILL contain the internal number.
 ;    after the call.
 ;
 I $G(MAGMOD) D  Q  ; WE'LL QUIT AFTER MODIFICATION
 . D UPDATE^DIE("S","MAGGFDA","MAGGIEN","MAGGXE")
 . S MAGRY="1^OK"
 . ; Now, after UPDATE^DIE, we aren't getting the MAGGIEN array., We'll use MAGMOD
 . D ACTION^MAGGTAU("MOD^"_$P(^MAG(2005,+MAGMOD,0),U,7)_"^"_+$G(MAGMOD)) ; This is the Image IEN
 ;
 S (MAGGIEN(1),NEWIEN)=$$NEWIEN^MAGGI12()  ; SG - MAG*3*93
 D UPDATE^DIE("S","MAGGFDA","MAGGIEN","MAGGXE")
 ;
 I '$G(MAGGIEN(1)) D  S MAGRY=MAGERR Q
 . S MAGERR="0^ERROR Creating new Image File Entry "
 . I $D(DIERR) D RTRNERR(.MAGERR)
 . D CLEAN
 ;
 S MAGGDA=MAGGIEN(1)
 ;
 D ACTION^MAGGTAU("CAP^"_MAGGFDA(2005,"+1,",5)_"^"_MAGGDA)
 ;
 ; IF a group, Modify GROUP PARENT in each Group Object and QUIT
 ;   we'll do this by hand, Else it'll take forever.
 ;   we Return the IEN with NO Filename. Groups don't get Filename
 ;
 I MAGGR S MAGRY=MAGGDA_U,Z="" D  G C1
 . F  S Z=$O(MAGGR(Z)) Q:Z=""  S $P(^MAG(2005,Z,0),U,10)=MAGGDA
 . D CLEAN
 ;
 S X=$G(MAGGFDA(2005,"+1,",14)) I +X D
 . ; If here: This image is a member of a Group
 . ;   -Modify the Group Parent, add DA to it's group
 . ;   -Also set 'Series Number' and 'Image Number' if they exist;
 . K MAGGFDA
 . S Y="+2,"_X_","
 . S MAGGFDA(2005.04,Y,.01)=MAGGDA
 . ; GEK 4/4/00 ADDED $L( we were dying on "0"
 . I $L($G(MAGDCMSN)) S MAGGFDA(2005.04,Y,1)=MAGDCMSN
 . I $L($G(MAGDCMIN)) S MAGGFDA(2005.04,Y,2)=MAGDCMIN
 . D UPDATE^DIE("S","MAGGFDA","MAGGIEN","MAGGXE")
 ;
 ; Now get the Image file name. DOS FILE name
 ; The ENTRY in Image File has been made, if any errors from here on
 ;  then we have to delete the image entry.
 I $D(MAGGFDA(2005,"+1,",1)) S MAGGFNM=MAGGFDA(2005,"+1,",1) G C1
 K MAGGFDA
 S X=$$DA2NAME^MAGGTU1(MAGGDA,$G(MAGGEXT)) I 'X D  S MAGRY=MAGERR Q
 . S MAGERR=X
 . S DA=MAGGDA,DIK="^MAG(2005," D ^DIK
 . K DA,DIC,DIK
 . D CLEAN
 S MAGGFNM=$P(X,U,2),Y=MAGGDA_","
 S MAGGFDA(2005,Y,1)=MAGGFNM
 D UPDATE^DIE("","MAGGFDA","","MAGGXE")
 ;   shouldn't have an error just editing one entry, but just in case.
 I $D(DIERR) D  S MAGRY=MAGERR Q
 . D RTRNERR(.MAGERR)
 . S DA=MAGGDA,DIK="^MAG(2005," D ^DIK
 . K DA,DIC,DIK
 . D CLEAN
 ;
C1 ; we jump here if we already had a Filename sent
 K MAGGFDA
 ; New Index Field Check.  If this entry doesn't have the Index fields introduced
 ;   in 3.0.8 then we use the Patch 17 conversion API call to generate default values.
 ;
 ;P59 Now we Auto-Generate the Index Fields, if they don't exist for this entry.
 I '$D(^MAG(2005,MAGGDA,40)) D
 . N INDXD
 . D GENIEN^MAGXCVI(MAGGDA,.INDXD)
 . S ^MAG(2005,MAGGDA,40)=INDXD
 . S ^MAGIXCVT(2006.96,MAGGDA)=2 ; Flag. Says fields were converted Patch 59
 . ; TRKING ID  TRKID =   MAGGFDA(2005,"+1,",108)
 . D ACTION^MAGGTAU("INDEX-ALL^"_$P(^MAG(2005,MAGGDA,0),"^",7)_"^"_MAGGDA) ;_"$$"_MAGGFDA(2005,"+1,",108))
 . D ENTRY^MAGLOG("INDEX-ALL",DUZ,MAGGDA,"P59",$P(^MAG(2005,MAGGDA,0),"^",7),1)
 . Q
 ;P59 If TYPE INDEX is missing we Auto-Generate Index Type and other missing Index Term values.
 I '$P(^MAG(2005,MAGGDA,40),"^",3) D
 . N INDXD,J,OLD40,N40
 . S (N40,OLD40)=^MAG(2005,MAGGDA,40)
 . D GENIEN^MAGXCVI(MAGGDA,.INDXD)
 . ; If Origin doesn't exist in existing, this will put V in. 
 . I $P(INDXD,"^",6)="" S $P(INDXD,"^",6)="V"
 . ; We're not changing existing values of Spec,Proc or Origin 
 . F J=1:1:6 I '$L($P(N40,"^",J)) S $P(N40,"^",J)=$P(INDXD,"^",J)
 . ;Validate the merged Spec and Proc, if  not valid, revert back to old Spec and Proc
 . I '$$VALINDEX^MAGGSIV1(.X,$P(N40,"^",3),$P(N40,"^",5),$P(N40,"^",4)) S $P(N40,"^",4,5)=$P(OLD40,"^",4,5)
 . S ^MAG(2005,MAGGDA,40)=N40
 . D ACTION^MAGGTAU("INDEX-42^"_$P(^MAG(2005,MAGGDA,0),"^",7)_"^"_MAGGDA) ;_"$$"_MAGGFDA(2005,"+1,",108))
 . D ENTRY^MAGLOG("INDEX-42",DUZ,MAGGDA,"P59",$P(^MAG(2005,MAGGDA,0),"^",7),1)
 . Q
 ;** ABS and JB image queues AREN'T SET WHEN ADDING AN IMAGE. 
 ;** IT IS DONE IN A SEPERATE CALL 
 ;** RPC =-> 'MAG ABSJB' after abstract is/isn't created on 
 ;**  the workstation
 ;
 ; Queue it to be copied to Jukebox.
 ;        CREATE ABSTRACT
 ; visn15 ADDED $$DA2PLCA to resolve the Image's current PLACE
 I $G(MAGGABS)="YES" S X=$$ABSTRACT^MAGBAPI(MAGGDA,$$DA2PLC^MAGBAPIP(MAGGDA,"A"))
 ;        RESTORE AFTER GLOBAL SETUP
 I $G(MAGGJB)="YES" S X=$$JUKEBOX^MAGBAPI(MAGGDA,$$DA2PLC^MAGBAPIP(MAGGDA,"F"))
 ;     Code for setting a Queue to Copy BIG to JUKEBOX
 ; 
 ;  We return the IEN ^ DRIVE:DIR ^ FILE.EXT
 ;   example:   487^C:\IMAGE\^DC000487.TIF
 ;  The calling routine is responsible for renaming/naming the file
 ;   to the returned DRIVE:\DIR\FILENAME.EXT
 ;  4/23/98 to include hierarchical directory structure -- PMK
 ;
 I 'MAGGR D
 . S MAGDHASH=$$DIRHASH^MAGFILEB(MAGGFNM,MAGREF)
 . S MAGRY=MAGGDA_U_MAGGDRV_MAGDHASH_U_MAGGFNM
 . ; For now, BIG files are in same directory as FullRes (or PACS) file
 . I $G(MAGBIG) D
 . . S X=$P(MAGGFNM,".",1)_".BIG"
 . . S MAGRY=MAGRY_U_MAGGDRV_MAGDHASH_U_X
 . . Q
 . Q
 ;
CLEAN ;
 D CLEAN^DILF
 L -^MAG(2005,NEWIEN)
 Q
RTRNERR(ETXT) ; There was error from UPDATE^DIE quit with error text
 S ETXT="0^ERROR  "_MAGGXE("DIERR",1,"TEXT",1)
 Q
ERR ; Error trap
 S MAGRY="0^ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q
MAKENAME() ; MAGGFDA exists so get info from that.
 ; We'll make NAME (.01)  with PATIENT NAME   SSN
 ; DOCUMENT Imaging was making name of
 ; $E(PATENT NAME,1,10)' '$E(DESC CATEG,1,9)' 'MM/DD/YY   (DOC DATE)
 N Z,ZT,ZNAME,ZSSN,ZDESC
 ; GEK 10/10/2000
 ; Modifying this procedure to make same name for all Image types
 ;  The name will be (first 18 chars of patient Name) _ SSN
 I $D(MAGGFDA(2005,"+1,",10)) S ZDESC=$E(MAGGFDA(2005,"+1,",10),1,30)
 I $D(MAGGFDA(2005,"+1,",5)) D
 . S X=MAGGFDA(2005,"+1,",5)
 . S ZNAME=$P(^DPT(X,0),U),ZSSN=$P(^DPT(X,0),U,9)
 ;
 ; For all Images the name is first 18 characters of patient name 
 ;  concatenated with SSN.  If No patient name is sent, well make
 ;  the name from the short desc.
 I $D(ZNAME) S Z=$E(ZNAME,1,18)_"   "_ZSSN
 E  S Z=ZDESC
 Q Z
