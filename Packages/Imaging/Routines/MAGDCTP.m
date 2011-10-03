MAGDCTP ;WIRMFO/JHC CT-PARAMETERS RPC ; 27 July 2006  10:05 AM
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
RPCIN(MAGGRY,PARAMS) ; RPC: MAGD CT PARAMS
 ;PARAMS: SLOC--Location code of interest
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGDCTP"
 N DATE,DATIEN,DIQUIET,GLOC,LOCIEN,MAGLST,MANIEN,MANUF,MODEL,MODIEN,REC,REPLY,SLOC
 S SLOC=$P(PARAMS,U)
 S MAGLST="MAGDRPC" K MAGGRY S MAGGRY=$NA(^TMP($J,MAGLST)) K @MAGGRY
 N CT S CT=0
 S DIQUIET=1 D DT^DICRW
 I 'SLOC S REPLY="Invalid parameter passed to MAGD CT PARAMS call ("_SLOC_")." G RPCINZ
 S LOCIEN=$O(^MAG(2006.621,"B",SLOC,""))
 I 'LOCIEN S REPLY="No Location data defined in CT Parameter file ("_SLOC_")." G RPCINZ
 S GLOC=$NA(^MAG(2006.621,LOCIEN)),MANIEN=0
 F  S MANIEN=$O(@GLOC@(1,MANIEN)) Q:'MANIEN  S MANUF=^(MANIEN,0),MODIEN=0 D
 . F  S MODIEN=$O(@GLOC@(1,MANIEN,1,MODIEN)) Q:'MODIEN  S MODEL=^(MODIEN,0),DATE=0 D
 . . F  S DATE=$O(@GLOC@(1,MANIEN,1,MODIEN,1,"B",DATE)) Q:'DATE  S DATIEN=$O(^(DATE,"")) D
 . . . S X=$G(@GLOC@(1,MANIEN,1,MODIEN,1,DATIEN,0)) Q:X=""
 . . . S REC=SLOC_"|"_MANUF_"|"_MODEL_"|"_$$DATE(DATE)_"|"_$P(X,U,2)
 . . . S CT=CT+1,@MAGGRY@(CT)=REC
 S REPLY=CT_" records returned"
 ;
RPCINZ S @MAGGRY@(0)=CT_U_REPLY
 Q
 ;
DATE(X) ; convert Fman date to DD-mon-YYYY format
 N Y,M,D,T S T=""
 I X?7N,("123"[$E(X)) D
 . S Y=$E(X),Y=$S(Y=3:20,Y=2:19,1:18)_$E(X,2,3)
 . S M=+$E(X,4,5),M=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,M)
 . I '(M?3U) Q
 . S D=+$E(X,6,7) I 'D Q
 . S T=D_"-"_M_"-"_Y,X=T
 Q:$Q T Q
 ;
EECT ;
 W @IOF,!!?10,"** Enter/Edit MAG CT PARAMETER data **",!!
 N MAGIEN
 K DIC S (DIC,DLAYGO)=2006.621,DIC(0)="ALMEQN"
 D ^DIC I Y=-1 K DIC,DIE,DR,DLAYGO Q
 S DIE=2006.621,DA=+Y
 S DR=".01;1;",DR(2,2006.6211)=".01;1;",DR(3,2006.62111)=".01;1;",DR(4,2006.621111)=".01;1;"
 S MAGIEN=DA
 D ^DIE I '$D(DA) G EECT
 G EECT
 Q
 ;
INCT ;
 W @IOF,!!?10,"** Inquire MAG CT PARAMETER data **",!!
 N BY,FR,TO,LOC,II,T
 S DIC=2006.621,DIC(0)="AMEQ"
 D ^DIC I Y=-1 K DIC Q
 S DA=+Y,(FR,TO)=$P(Y,U,2),L=0
 S LOC=$P(Y,U,2)
 W ! D RPCIN^MAGDCTP(.T,LOC)
 F I=1:1:$G(^TMP($J,"MAGDRPC",0)) S X=^(I) W ! S T=$L(X,"|") F II=1:1:T W $P(X,"|",II) W:(II'=T) " | "
 R !!,"Enter RETURN to continue: ",X:DTIME W !
 G INCT
 Q
 ;
 ;
END ;
