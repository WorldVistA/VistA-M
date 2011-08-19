MAGDCRP ;WIRMFO/JHC CR-PARAMETERS RPC ; 27 July 2006  10:05 AM
 ;;3.0;IMAGING;**65**;Jul 27, 2006;Build 28
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
ERR N ERR S ERR=$$EC^%ZOSV S @MAGGRY@(0)="0^4~"_ERR
 D @^%ZOSF("ERRTN")
 Q:$Q 1  Q
 ;
RPCIN(MAGGRY,PARAMS) ; RPC: MAGD CR PARAMS
 ;PARAMS: SLOC--Location code of interest
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGDCRP"
 N DIQUIET,GLOC,LOCIEN,MAGLST,MANIEN,MANUF,MODEL,MODIEN,REC,REPLY,SLOC,VERSION,VERIEN
 S SLOC=$P(PARAMS,U)
 S MAGLST="MAGDRPC" K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 N CT S CT=0
 S DIQUIET=1 D DT^DICRW
 I 'SLOC S REPLY="Invalid parameter passed to MAGD CR PARAMS call ("_SLOC_")." G RPCINZ
 S LOCIEN=$O(^MAG(2006.623,"B",SLOC,""))
 I 'LOCIEN S REPLY="No Location data defined in CR Parameter file ("_SLOC_")." G RPCINZ
 S GLOC=$NA(^MAG(2006.623,LOCIEN)),MANIEN=0
 F  S MANIEN=$O(@GLOC@(1,MANIEN)) Q:'MANIEN  S MANUF=^(MANIEN,0),MODIEN=0 D
 . F  S MODIEN=$O(@GLOC@(1,MANIEN,1,MODIEN)) Q:'MODIEN  S MODEL=^(MODIEN,0),VERSION=0 D
 . . F  S VERSION=$O(@GLOC@(1,MANIEN,1,MODIEN,1,"B",VERSION)) Q:VERSION=""  S VERIEN=$O(^(VERSION,"")) D
 . . . S X=$G(@GLOC@(1,MANIEN,1,MODIEN,1,VERIEN,0)) Q:X=""
 . . . S REC=SLOC_"|"_MANUF_"|"_MODEL_"|"_VERSION_"|"_+$P(X,U,2)
 . . . S CT=CT+1,@MAGGRY@(CT)=REC
 S REPLY=CT_" records returned"
 ;
RPCINZ S @MAGGRY@(0)=CT_U_REPLY
 Q
 ;
EECR ;
 W @IOF,!!?10,"** Enter/Edit MAG CR PARAMETER data **",!!
 N MAGIEN
 K DIC S (DIC,DLAYGO)=2006.623,DIC(0)="ALMEQN"
 D ^DIC I Y=-1 K DIC,DIE,DR,DLAYGO Q
 S DIE=2006.623,DA=+Y
 S DR=".01;1;",DR(2,2006.6231)=".01;1;",DR(3,2006.62311)=".01;1;",DR(4,2006.623111)=".01;1;"
 S MAGIEN=DA
 D ^DIE I '$D(DA) G EECR
 G EECR
 Q
 ;
INCR ;
 W @IOF,!!?10,"** Inquire MAG CR PARAMETER data **",!!
 N MAGIEN,BY,FR,TO
 S DIC=2006.623,DIC(0)="AMEQ"
 D ^DIC I Y=-1 K DIC Q
 S DA=+Y,(FR,TO)=$P(Y,U,2),MAGIEN=DA,L=0
 S BY="#.01",FLDS="[MAGD CR PARAM LIST]",DIS(0)="I D0=MAGIEN"
 D EN1^DIP
 R !,"Enter RETURN to continue: ",X:DTIME W !
 G INCR
 Q
 ;
 ;
END ;
