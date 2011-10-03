XQOPED ;SEA/Luke - Option Editor ;04/27/98  12:26
 ;;8.0;KERNEL;**46**;Jul 10, 1995
 ;
IN ;Called from the Pre Action of the XQEDTOPT form
 K ^TMP($J,"XQOPED")
 ;I $D(XQDICNEW) S ^TMP($J,"XQOPED","NEW")=XQDICNEW
 Q
 ;
OUT ;Called from the Post Action of the XQEDTOPT form
 I $D(XQDICNEW),$P(XQDICNEW,U,3) D CMPLT
 I $D(DDSCHANG),DDSCHANG D PUT^DDSVAL(DIE,.DA,3.6,DUZ,"","I")
 ;I $D(DDSCHANG),DDSCHANG S ^TMP($J,"XQOPED","CHANGED")=DA
 K DDSCHANG,XQDICNEW ;,DDSPAGE,DDSPARM
 Q
 ;
CHECK() ;See if this person should have programmer access to the
 ;EXECUTABLES subfile containing the ENTRY ACTION, etc.
 ;
 ;Returns a 1 if the user has a key or an @-sign, 0 if not.
 ;
 ;Called by the branching logic of the EXECUTABLES form-only field
 ;on Page 1 (Main) of the XQEDTOPT ScreenMan form.
 ;
 N XQYES S XQYES=0
 ;
 Q:'$D(DUZ) XQYES
 I $D(^XUSEC("XUMGR",DUZ)) S XQYES=1
 I $D(^XUSEC("XUPROG",DUZ)) S XQYES=1
 ;I $D(^XUSEC("XUPROGMODE",DUZ)) S XQYES=1
 ;I $D(^XUSEC("XQSMDFM",DUZ)) S XQYES=1
 ;
 ;
 Q:'$D(DUZ(0)) XQYES
 I DUZ(0)="@" S XQYES=1
 ;I DUZ(0)="#" S XQYES=1
 ;
 Q XQYES
 ;
 ;
EA ;ENTRY ACTION for the option XQOPED, the screen-based option editor
 K ^TMP($J,"XQOPED")
 I $$CHECK() S DLAYGO=19
 Q
 ;
XA ;EXIT ACTION for the option XQOPED, the screen based Option Editor
 ;Repoint the CREATOR field for the modified options
 ;
 I $D(^TMP($J,"XQOPED","CHANGED")) D
 .N % S %=0
 .F  Q:%=""  D
 ..S %=$O(^TMP($J,"XQOPED","CHANGED")) Q:%=""
 ..I $D(^DIC(19,%,0))#2 S $P(^(0),U,5)=DUZ
 ..Q
 .Q
 K ^TMP($J,"XQOPED")
 Q
 ;
CMPLT ;Check to make sure that the option is complete enough to leave
 ;it in the Option File.
 I $D(XQDICNEW) D
 .N %
 .S %=$P(^DIC(19,+XQDICNEW,0),U,4) ;Check the TYPE field
 .I %']"" S DA=+XQDICNEW,DIK="^DIC(19," D ^DIK K DIK,DA
 .Q
 Q
 ;
 ;This code was graciously provided by David LaLiberte
 ;AUHBHLP
 ;692/DCL-TMT PLAN SCREEN HELP PROCESSOR;OCT 07, 1997@13:34
 ;;1.0;WHITE CITY TMT PLAN PKG;;6-17-97
H(XQIEN) ;Process Help for ScreenMan form
 Q:$G(XQIEN)'>0
 Q:$D(^DIC(19.8,XQIEN,1))'>9
 N XQA,XQI
 F XQI=1:1:5 Q:'$D(^DIC(19.8,XQIEN,1,XQI,0))  S XQA(XQI)=^(0)
 D HLP^DDSUTL(.XQA)
 K XQIEN
 Q
