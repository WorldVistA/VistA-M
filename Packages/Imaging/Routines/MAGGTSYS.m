MAGGTSYS ;WOIFO/GEK/NST - Calls from Imaging windows for System Manager ; 22 Dec 2010 10:51 AM
 ;;3.0;IMAGING;**59,93,117,185,188**;Mar 19, 2002;Build 61;Mar 18, 2018
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
 ; GETS
 ; Called from Image Information Advanced in Clinical Display
 ; NODE:    integer  or "" or  integer^integer  or  "N"_integer
 ; if Integer -  this is IMAGE IEN, we display IMAGE entry for IEN
 ; if ""      - we defalut to Last entry in IMAGE File.
 ; if int^int -  this is FILE^IEN, we display FM Files for FILE IEN
 ; if "N"_int -  this is Patch 185 Call. 
 ;
GETS(MAGRY,NODE,FLAGS) ; USE GETS^DIQ TO GET FIELD VALUES.   
 N MAGWIN,I,CT,Y,NC,MAGOUT,MAGERR,TNC,ZZ,MAGIEN,MAGFILE
 N N0
 S MAGRY=$NA(^TMP("MAGNODE",$J))
 K @MAGRY
 I $L(NODE,"^")>1 D OTH Q  ;
 I NODE'?.1"N"1.N S @MAGRY@(0)="Node IEN "_NODE_" invalid"
 I NODE?1"N"1.N D  Q
 . N MAGVIEN
 . S MAGVIEN=$E(NODE,2,999)
 . D IMGINFO^MAGNVQ03(MAGRY,MAGVIEN)  ; Get P34 report
 . I $G(@MAGRY@(0)) S @MAGRY@(0)="******    Fields for Image IEN: "_MAGVIEN_"    ******" Q
 . Q
 S NODE=+$G(NODE)
 I 'NODE S NODE=$P(^MAG(2005,0),U,3)
 S MAGIEN=NODE
 S MAGFILE=$$FILE^MAGGI11(NODE)
 S MAGWIN=$$BROKER^XWBLIB
 I 'MAGWIN W !,"MAGIEN","  ",MAGIEN
 K @MAGRY
 S @MAGRY@(0)="******    Fields for "_$S(MAGFILE=2005.1:"DELETED ",1:"")_"Image IEN: "_MAGIEN_"    ******"
 S I=0,CT=0
 S FLAGS=$S($L($G(FLAGS)):FLAGS,1:"IERN")
 I MAGFILE'>0 Q  ; problem getting file number
 D GETS^DIQ(MAGFILE,MAGIEN,"*",FLAGS,"MAGOUT","MAGERR")
 D LOAD
 I 'MAGWIN W !,"AFTER LOAD","MAGIEN= ",MAGIEN
 S N0=$G(^MAG(2005,MAGIEN,0))
 S MAGIEN=$P(N0,"^",3) I MAGIEN]"" D  ;
 . S MAGFILE="2005.2"
 . S CT=CT+1,@MAGRY@(CT)=" ====== FULL File(Tier1):  NETWORK LOCATION  "_MAGIEN_"  ======================"
 . D GETS^DIQ(MAGFILE,MAGIEN,"*",FLAGS,"MAGOUT","MAGERR")
 . D LOAD
 S MAGIEN=$P(N0,"^",4) I MAGIEN]"" D  ;
 . S MAGFILE="2005.2"
 . S CT=CT+1,@MAGRY@(CT)=" ====== Abstract(Tier1): NETWORK LOCATION  "_MAGIEN_" ======================"
 . D GETS^DIQ(MAGFILE,MAGIEN,"*",FLAGS,"MAGOUT","MAGERR")
 . D LOAD
 S MAGIEN=$P(N0,"^",5) I MAGIEN]"" D  ;
 . S MAGFILE="2005.2"
 . S CT=CT+1,@MAGRY@(CT)=" ====== JukeBox(Tier2): NETWORK LOCATION  "_MAGIEN_" ======================"
 . D GETS^DIQ(MAGFILE,MAGIEN,"*",FLAGS,"MAGOUT","MAGERR")
 . D LOAD
 Q 
 ;
LOAD ; p188 T3
 S NC=MAGIEN_","
 S I="" F  S I=$O(MAGOUT(MAGFILE,NC,I)) Q:I=""  D
 . S CT=CT+1
 . I $G(MAGOUT(MAGFILE,NC,I,"I"))=$G(MAGOUT(MAGFILE,NC,I,"E")) D  Q
 . . S ZZ=I,$E(ZZ,45,999)=" = "_$G(MAGOUT(MAGFILE,NC,I,"E"))
 . . S @MAGRY@(CT)=ZZ
 . . Q
 . ;
 . S ZZ=I,$E(ZZ,25,999)=" = ("_$G(MAGOUT(MAGFILE,NC,I,"I"))_") "
 . I ($L(ZZ)>44) S ZZ=ZZ_" = "_$G(MAGOUT(MAGFILE,NC,I,"E")) S @MAGRY@(CT)=ZZ Q
 . I ($L(ZZ)<45) S $E(ZZ,45,999)=" = "_$G(MAGOUT(MAGFILE,NC,I,"E")) S @MAGRY@(CT)=ZZ Q
 . Q
 I $P($G(^MAG(MAGFILE,MAGIEN,2)),"^",6)=8925 D
 . K MAGOUT,MAGERR
 . S CT=CT+1,@MAGRY@(CT)="   ***************   TIU    *************** "
 . S CT=CT+1,@MAGRY@(CT)="   **** Field Values for TIUDA: "_$P(^MAG(MAGFILE,MAGIEN,2),"^",7)_"  ****"
 . D GETS^DIQ(8925,$P(^MAG(MAGFILE,MAGIEN,2),"^",7),"*",FLAGS,"MAGOUT","MAGERR")
 . S NC=$P(^MAG(MAGFILE,MAGIEN,2),"^",7)_","
 . S I="" F  S I=$O(MAGOUT(8925,NC,I)) Q:I=""  D
 . . S CT=CT+1
 . . I $G(MAGOUT(8925,NC,I,"I"))=$G(MAGOUT(8925,NC,I,"E")) D  Q
 . . . S ZZ=I,$E(ZZ,45,999)=" = "_$G(MAGOUT(8925,NC,I,"E"))
 . . . S @MAGRY@(CT)=ZZ
 . . . Q
 . . ;
 . . S ZZ=I,$E(ZZ,25,999)=" = ("_$G(MAGOUT(8925,NC,I,"I"))_") "
 . . I ($L(ZZ)>44) S ZZ=ZZ_" = "_$G(MAGOUT(8925,NC,I,"E")) S @MAGRY@(CT)=ZZ Q
 . . I ($L(ZZ)<45) S $E(ZZ,45,999)=" = "_$G(MAGOUT(8925,NC,I,"E")) S @MAGRY@(CT)=ZZ Q
 . . Q
 . Q
 Q
OTH ; Called internally
 ; p188 T3 added extra functionality for the Imaging Info Advanced window.
 N MAGFDA,MAGGLB
 K @MAGRY
 W !,"NODE  ",NODE
 S I=0,CT=0
 S FLAGS=$S($L($G(FLAGS)):FLAGS,1:"IERN")
 S MAGFILE=$P(NODE,"^",1),MAGIEN=$P(NODE,"^",2)
 I MAGIEN="ALL" D  Q  ;
 . S MAGGLB=^DIC(MAGFILE,0,"GL")
 . S MAGGLB=$E(MAGGLB,1,$L(MAGGLB)-1)_")"
 . S CT=CT+1 S @MAGRY@(CT)=" MAGGLB "_MAGGLB
 . S MAGFDA=0 F  S MAGFDA=$O(@MAGGLB@(MAGFDA)) Q:'MAGFDA  D  ;
 . . S MAGIEN=MAGFDA
 . . S CT=CT+1
 . . S @MAGRY@(CT)=" ====== IEN  "_MAGIEN_"  ======================"
 . . D GETS^DIQ(MAGFILE,MAGIEN,"*",FLAGS,"MAGOUT","MAGERR")
 . . D LOAD
 . Q
 I MAGIEN="" D  ;
 . I MAGFILE="2006.1" S MAGIEN=$$DUZ2PLC^MAGBAPIP
 . I MAGFILE="2005.2" S MAGIEN=$O(^MAG(2005.2,0))
 S FLAGS=$S($L($G(FLAGS)):FLAGS,1:"IERN")
 S @MAGRY@(0)="******    Fields for FILE : "_MAGFILE
 D GETS^DIQ(MAGFILE,MAGIEN,"*",FLAGS,"MAGOUT","MAGERR")
 D LOAD
 ;
 Q 
