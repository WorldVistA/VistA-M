ONCTEXT ;Hines OIFO/GWB - ONCOLOGY TEXT EDITS ;09/29/00
 ;;2.11;ONCOLOGY;**27**;Mar 07, 1995
 ;
 ;Maximum NAACCR length text edit
 S FIELD=$P(^DD(165.5,FLDNUM,0),U,1)
 S (LENGTH,WPIEN)=0
 F  S WPIEN=$O(^ONCO(165.5,D0,NODE,WPIEN)) Q:WPIEN'>0  D
 .S LENGTH=LENGTH+$L(^ONCO(165.5,D0,NODE,WPIEN,0))
 I LENGTH>LIMIT D
 .W !,*7
 .W !," WARNING: ",FIELD," too long: ",LENGTH," characters"
 .W !?10,"Text should not exceed NAACCR length of ",LIMIT," characters"
 .W !
 .N DIR,X S SAVEY=Y
 .S DIR("A")=" Do you want to re-edit this field"
 .S DIR(0)="Y",DIR("B")="No" D ^DIR
 .I (Y=0)!(Y="") S Y=SAVEY Q
 .I Y[U S Y="@0" Q
 .S Y=FLDNUM
 K FIELD,FLDNUM,LENGTH,LIMIT,NODE,SAVEY,WPIEN
 Q
