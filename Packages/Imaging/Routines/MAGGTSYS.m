MAGGTSYS ;WOIFO/GEK - Calls from Imaging windows for System Manager ; 11/24/08 10:23am
 ;;3.0;IMAGING;**59,93**;Dec 02, 2009;Build 163
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
GETS(MAGRY,NODE,FLAGS) ; USE GETS^DIQ TO GET FIELD VALUES.
 K MAGWIN,I,CT,Y,NC,MAGOUT,MAGERR,TNC,ZZ,MAGIEN
 S MAGRY=$NA(^TMP("MAGNODE",$J))
 S NODE=+$G(NODE)
 I 'NODE S NODE=$P(^MAG(2005,0),U,3)
 S MAGIEN=NODE
 S MAGWIN=$$BROKER^XWBLIB
 I 'MAGWIN W !,"MAGIEN","  ",MAGIEN
 K @MAGRY
 S @MAGRY@(0)="******    Fields for Image IEN: "_MAGIEN_"    ******"
 S I=0,CT=0
 S FLAGS=$S($L($G(FLAGS)):FLAGS,1:"IERN")
 D GETS^DIQ(2005,MAGIEN,"*",FLAGS,"MAGOUT","MAGERR")
 ;D GETS^DIQ(2005,MAGIEN,".01;1;2;2.1;2.2;3;5;6;12","R","MAGOUT","MAGERR")
 S NC=MAGIEN_","
 S I="" F  S I=$O(MAGOUT(2005,NC,I)) Q:I=""  D
 . S CT=CT+1
 . I $G(MAGOUT(2005,NC,I,"I"))=$G(MAGOUT(2005,NC,I,"E")) D  Q
 . . S ZZ=I,$E(ZZ,45,999)=" = "_$G(MAGOUT(2005,NC,I,"E"))
 . . S @MAGRY@(CT)=ZZ
 . . ;S @MAGRY@(CT)=I_" = "_MAGOUT(2005,NC,I,"E") Q
 . . Q
 . ;
 . S ZZ=I,$E(ZZ,25,999)=" = ("_$G(MAGOUT(2005,NC,I,"I"))_") "
 . I ($L(ZZ)>44) S ZZ=ZZ_" = "_$G(MAGOUT(2005,NC,I,"E")) S @MAGRY@(CT)=ZZ Q
 . I ($L(ZZ)<45) S $E(ZZ,45,999)=" = "_$G(MAGOUT(2005,NC,I,"E")) S @MAGRY@(CT)=ZZ Q
 . ;S @MAGRY@(CT)=I_" = ("_$G(MAGOUT(2005,NC,I,"I"))_") = "_$G(MAGOUT(2005,NC,I,"E"))
 . Q
 I $P($G(^MAG(2005,MAGIEN,2)),"^",6)=8925 D
 . K MAGOUT,MAGERR
 . S CT=CT+1,@MAGRY@(CT)="   ***************   TIU    *************** "
 . S CT=CT+1,@MAGRY@(CT)="   **** Field Values for TIUDA: "_$P(^MAG(2005,MAGIEN,2),"^",7)_"  ****"
 . D GETS^DIQ(8925,$P(^MAG(2005,MAGIEN,2),"^",7),"*",FLAGS,"MAGOUT","MAGERR")
 . S NC=$P(^MAG(2005,MAGIEN,2),"^",7)_","
 . S I="" F  S I=$O(MAGOUT(8925,NC,I)) Q:I=""  D
 . . S CT=CT+1
 . . I $G(MAGOUT(8925,NC,I,"I"))=$G(MAGOUT(8925,NC,I,"E")) D  Q
 . . . S ZZ=I,$E(ZZ,45,999)=" = "_$G(MAGOUT(8925,NC,I,"E"))
 . . . S @MAGRY@(CT)=ZZ
 . . . ;S @MAGRY@(CT)=I_" = "_MAGOUT(2005,NC,I,"E") Q
 . . . Q
 . . ;
 . . S ZZ=I,$E(ZZ,25,999)=" = ("_$G(MAGOUT(8925,NC,I,"I"))_") "
 . . I ($L(ZZ)>44) S ZZ=ZZ_" = "_$G(MAGOUT(8925,NC,I,"E")) S @MAGRY@(CT)=ZZ Q
 . . I ($L(ZZ)<45) S $E(ZZ,45,999)=" = "_$G(MAGOUT(8925,NC,I,"E")) S @MAGRY@(CT)=ZZ Q
 . . ;S @MAGRY@(CT)=I_" = ("_$G(MAGOUT(2005,NC,I,"I"))_") = "_$G(MAGOUT(2005,NC,I,"E"))
 . . Q
 . Q
 Q
