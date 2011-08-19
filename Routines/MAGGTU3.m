MAGGTU3 ;WOIFO/GEK/SG - Silent calls for Imaging ; 1/22/09 1:50pm
 ;;3.0;IMAGING;**7,8,48,45,20,46,59,93**;Dec 02, 2009;Build 163
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
IMAGEINF(MAGRY,IEN,NOCHK) ;RPC [MAGG IMAGE INFO] Call to return information for 1 image;
 ; IEN   =       Image IEN  ^MAG(2005,IEN
 ; NOCHK =    1|""   if 1 then do not run QA check on this image.
 ; 
 N ERR,MAGFILE,Y,Z,MAGNOCHK
 ;--- Check if the image is deleted
 I $$ISDEL^MAGGI11(IEN,.ERR)  D  Q
 . S Y=$$NODE^MAGGI11(IEN)  S:Y'="" Y=$G(@Y@(2))
 . S MAGRY(0)="0^Image : """_$P(Y,U,4)_""" has been deleted."
 . Q
 ;--- Check for errors. Ignore the problem if there are 2 records
 ;    with the same IEN in files #2005 and #2005.1. After the file
 ;--- #2005.1 is completeley eliminated, ",+ERR'=-43" can be deleted.
 I ERR<0,+ERR'=-43  S MAGRY(0)="0^INVALID Image number "_IEN  Q
 ;--- MAGGTII queries the variable MAGNOCHK to run QA check or not.
 S MAGNOCHK=+$G(NOCHK)
 ;S MAGXX=IEN D INFO^MAGGTII ; this'll give us the  MAGFILE variable
 S MAGXX=IEN,MAGFILE=$$INFO^MAGGAII(MAGXX,"E")
 S Z=$P(^MAG(2005,IEN,0),U,7)
 I '$D(^DPT(Z)) S Z="1^Invalid patient pointer"
 E  S Z=Z_U_$P(^DPT(Z,0),U)
 S MAGRY(0)="1^"_MAGFILE
 S MAGRY(1)=Z ; dfn^name
 Q
USERINF2(MAGRY,MAGWRKID) ;RPC [MAGGUSER2] Return user info.
 ; MAGRY(1) = DUZ ^ FULL NAME  ^ INITIALS
 ; MAGRY(2) = Network UserName ^ PassWord.
 ; MAGRY(3) = MUSE Site number. ( default = 1)
 ; Node 4 is data from IMAGING SITE PARAMATERS File #2006.1 and INSTITUTION File #4
 ; MAGRY(4)= PLACE IEN  ^ SITE CODE ^ DUZ(2) ^ INSTITUTION NAME (.01) ^ $$CONSOLID ^ User's local STATION NUMBER (99)
 ; MAGRY(5) = +<CP Version>|0 ^ Version of CP installed on Server
 ; MAGRY(6) = Warning message if we can't resolve which Site Parameter entry to use.
 ; MAGRY(7) = Warning message  <reserved for future>
 ; MAGRY(8) = 1|0  1 = Production account    0 = Test Account (or couldn't determine) ;Patch 41
 ; MAGRY(9) = Vista Site Service PHYSICAL REFERENCE from Network Location File.
 ; MAGRY(10)=Domain Name
 ; MAGRY(11)=Primary Division IEN
 ; MAGRY(12)=Primary Division STATION NUMBER
 ;  
 N J,K,Y,MAGPLC,MAGWARN,MAGWARN1,VSRV,PHYREF,X ; DBI - SEB 9/20/2002
 S MAGPLC=0
 I $D(DUZ(2)) S MAGPLC=+$$PLACE^MAGBAPI(DUZ(2)) ; DBI - SEB 9/20/2002
 ;
 ; SET THE PARTITION VARIABLE MAGSYS   i.e.'IGK_Garrett's Desk'
 S MAGSYS=$G(MAGWRKID,"")
 I +$G(DUZ)=0 S MAGRY(0)="0^DUZ Undefined, Null or Zero" Q
 I 'MAGPLC D
 . S MAGWARN="Can't resolve Site Param, DUZ(2): "_$S($D(DUZ(2)):DUZ(2),1:"NULL")_" DUZ: "_DUZ
 . S MAGPLC=$$DUZ2PLC^MAGBAPIP(.MAGWARN1) ; DBI - SEB 9/20/2002
 . Q
 S MAGRY(0)="1^"
 ;          DUZ     FULL NAME                INITIALS
 S MAGRY(1)=DUZ_U_$$GET1^DIQ(200,DUZ_",",.01)_U_$$GET1^DIQ(200,DUZ_",",1)
 ; NOW NET STUFF
 I 'MAGPLC Q 
 ; From IMAGING SITE PARAMETERS File
 ;   get the Network UserName and PassWord.
 S MAGRY(2)=$P($G(^MAG(2006.1,MAGPLC,"NET")),U,1,2)
 ;   get the default MUSE Site number.
 S MAGRY(3)=+$P($G(^MAG(2006.1,MAGPLC,"USERPREF")),U,2)
 ;   default to 1 if nothing is entered in Site Parameters File
 I MAGRY(3)=0 S MAGRY(3)=1
 ; This SITEIEN^SITECODE^USER INSTITUTION IEN^INSTITUTION NAME^CONSOLIDATED^User's local STATION NUMBER
 ;  is  used by Display to determine location of Workstation
 ;  and used by Capture to determine the Write Location.
 S MAGRY(4)=MAGPLC_U_$$GET1^DIQ(2006.1,MAGPLC,.09)_U_$G(DUZ(2))_U_$$GET1^DIQ(2006.1,MAGPLC,.01,"E")
 S MAGJOB("PLC")=MAGPLC
 S MAGJOB("PLCODE")=$$GET1^DIQ(2006.1,MAGPLC,.09)
 S MAGRY(4)=MAGRY(4)_U_$$CONSOLID^MAGBAPI_U_$$GET1^DIQ(4,DUZ(2),99,"E")
 ; is CP not installed at this site, the Client will hide options
 ;  related to CP.
 S X=$$VERSION^XPDUTL("CLINICAL PROCEDURES")
 S MAGRY(5)=+X_U_X
 S MAGRY(6)=$G(MAGWARN)
 S MAGRY(7)=$G(MAGWARN1)
 S MAGRY(8)=$S($L($T(PROD^XUPROD)):+$$PROD^XUPROD,1:0)
 S VSRV=$P($G(^MAG(2006.1,MAGPLC,"NET")),"^",5)
 I VSRV I +$P($G(^MAG(2005.2,VSRV,0)),"^",6) S PHYREF=$P($G(^MAG(2005.2,VSRV,0)),"^",2)
 S MAGRY(9)=$G(PHYREF)
 S MAGRY(10)=$$KSP^XUPARAM("WHERE")
 S MAGRY(11)=$P($$SITE^VASITE(),"^")
 S MAGRY(12)=$P($$SITE^VASITE(),"^",3)
 Q
 ;
CATEGORY(MAGRY) ; RPC [MAGGDESCCAT] Call to return Mag Descriptive Categories in array
 ; for listing in a list box.
 N I,K,CT,Y
 S I=0,CT=0
 I '$D(^MAG(2005.81)) D  Q
 . S MAGRY(0)="0^ERROR Mag Descriptive Category File doesn't exist"
 F  S I=$O(^MAG(2005.81,"B",I)) Q:I=""  D
 . ;Next line adds ADMIN, CLIN 3rd piece of the data returned
 . S K=$O(^MAG(2005.81,"B",I,"")),CT=CT+1
 . S MAGRY(CT)=I_U_K_U_$P(^MAG(2005.81,K,0),U,2)
 S MAGRY(0)=CT_"^Categories on file"
 Q
USERKEYS(MAGKEY) ; RPC [MAGGUSERKEYS]
 ; Call to return an array of IMAGING Security Keys
 D USERKEYS^MAGGTU31(.MAGKEY)
 Q
MAIL(MAGRY,MAGFILE,MAGIEN) ;RPC [MAGG OFFLINE IMAGE ACCESSED]
 ;   Called to log an Offline Image accessed.
 ;   ^MAGQUEUE(2006.033,0) = OFFLINE IMAGES
 ;   User must edit 2006.033 by hand to mark images as OFFLINE.
 ;
 N FILEREF,PLATTER,A
 S MAGRY="0^Error : logging access to Off-Line Image"
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 S FILEREF=$$UP^XLFSTR($P(MAGFILE,"\",$L(MAGFILE,"\")))
 S PLATTER=$O(^MAGQUEUE(2006.033,"B",FILEREF,""))
 S PLATTER=$P(^MAGQUEUE(2006.033,PLATTER,0),U,2)
 I MAGFILE[".ABS" Q
 N XMDUZ,XMSUB,XMTEXT,XMY
 S XMDUZ=$S($D(DUZ):DUZ,1:.5)
 S XMSUB="Offline Image Request"
 S XMTEXT="A("
 S A(1)="Patient   : "_$P(^DPT($P($G(^MAG(2005,+MAGIEN,0)),U,7),0),U,1)
 S A(2)="FileName  : "_MAGFILE_"  "_MAGIEN
 S A(3)="Desc      : "_$P($G(^MAG(2005,MAGIEN,2)),U,4)
 S A(4)="Procedure : "_$P($G(^MAG(2005,MAGIEN,0)),U,8)
 S A(5)="Platter   : "_PLATTER
 S A(6)="User      : "_$$GET1^DIQ(200,DUZ_",",.01)_"("_$G(DUZ)_")"
 S XMY("G.OFFLINE IMAGE TRACKERS")="" D ^XMD
 S MAGRY="1^Message sent :  Offline Image Accessed"
 Q
LOGERROR(MAGRY,TEXT) ;RPC [MAGG LOG ERROR TEXT]
 ; Call to stuff error information from Delphi app into the Session file.
 Q:($P($G(MAGJOB("VERSION")),".",1,2))<"3.0"
 D LOGERR^MAGGTERR("---- New Error ----")
 S I="" F  S I=$O(TEXT(I)) Q:I=""  D LOGERR^MAGGTERR(TEXT(I))
 S MAGRY="1^Error text saved to Session file"
 Q
RSLVABS(MAGIEN,FILENAME) ;Resolve Abstract into the Default Bitmap 
 ; Return the default bitmap, If the image file extension resolves into a default bitmap
 ; MAGIEN        : Image internal entry number
 ; FILENAME      : ""  or Relative Path and Default Bitmap. ie ('.\BMP\magavi.bmp')
 N FTIEN,EXT ; 
 S FILENAME=""
 I '$D(^MAG(2005.021)) Q  ; IMAGE FILE TYPES doesn't exist on this system.
 S EXT=$P($P(^MAG(2005,MAGIEN,0),"^",2),".",2) ; image file extension   JPG, TGA, etc.
 Q:EXT=""  ;
 S FTIEN=$O(^MAG(2005.021,"B",EXT,""))
 Q:'FTIEN  ; No extension in IMAGE FILE TYPES file.
 ; stop dependency on "c:\program files"
 I '+$P(^MAG(2005.021,FTIEN,0),"^",5) S FILENAME=".\BMP\"_$P(^MAG(2005.021,FTIEN,0),"^",4)
 Q
GETINFO(MAGRY,IEN) ; RPC [MAG4 GET IMAGE INFO]
 ; Call (3.0p8) to get information on 1 image 
 ; and Display in the Image Information Window
 D GETINFO^MAGGTU31(.MAGRY,IEN)
 Q
