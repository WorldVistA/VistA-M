ONCOU ;Hines OIFO/GWB - ONCOLOGY UTILITY CALLS ;06/06/00
 ;;2.11;ONCOLOGY;**5,25,26,43**;Mar 07, 1995
 ;
ASKNUM(TXT,RNG,DFLT) ;ask for a number - expects RNG as NNN:NNN
 N DIR,Y S DIR(0)="N^"_RNG,DIR("A")=TXT S:$D(DFLT) DIR("B")=DFLT D ^DIR Q Y
ASKY(TXT) ;ask a Y/N question, default YES, returns 1 for Y, 0 for N
 N DIR,Y S DIR("A")=TXT,DIR(0)="Y",DIR("B")="Yes" D ^DIR S:Y=U Y=-1 Q Y
LOOKUP(FL,NTR,UIO,Y) ;look up entry NTR in File FL with user options UIO, return Y array if parameter passed
 N DIC,Y S DIC=FL,DIC(0)=$G(UIO),X=NTR D ^DIC Q +Y
GETVAL(FN,DA,DR,SE,SF) ;get value of field DR in entry DA in file FN - if DR is a multiple then get subfield SF in subentry SE
 N DI,DIC,DIQ,OQ,OX,D0 S DIC=FN,DIQ="OQ",OX=+$P(^DD(FN,DR,0),U,2) S:OX DA(OX)=SE,DR(OX)=SF D EN^DIQ1 Q $S(OX:OQ(OX,SE,SF),1:OQ(FN,DA,DR))
VERSION(PKG) ;get version # for pkg
 N PNU,Y S PNU=+$O(^DIC(9.4,"B",PKG,"")),Y=$G(^DIC(9.4,PNU,"VERSION")) Q Y
VERCHK(PKG,VER,PATNO) ;verify version for a patch
 N INST,OK S OK=0 ;    assume the worst
 W !!,"This routine will install ",PKG," Version ",VER," Patch ",PATNO,".",!!
 S INST=$$VERSION(PKG)
 I INST="" W *7,"But the ",PKG," package doesn't seem to be installed on this system!"
 E  I INST'=VER W *7,"But Version ",VER," of the ",PKG," package doesn't seem to be installed!" W:INST !,"(Current installed version:  ",INST,")"
 E  S OK=1
 Q OK
SITEPAR(MSG) ;Are ONCOCOLOGY SITE PARAMETERS defined?
 N OK
 S OK=$O(^ONCO(160.1,"C",DUZ(2),0))
 I OK="" S OK=$O(^ONCO(160.1,0))
 I 'OK,$G(MSG)="ERRMSG" W !!,"The ONCOLOGY SITE PARAMETERS have not been set up.",!,"Use the ""Define Tumor Registry Parameters"" Option.",!!
 Q OK
LTS(DA,NOTTHIS) ;Invoked by AC cross-reference of TUMOR STATUS CODE sub-field (#.02) of TUMOR STATUS field (#73) of ONCOLOGY PRIMARY file (#165.5), sets value into LAST TUMOR STATUS field (#95)
 ;NOTTHIS is defined in the KILL logic - we want to skip the current TUMOR STATUS
 N OX,DIE,DR,NTS,OTS
 S NTS="" ;    new tumor status defaults to null
 S OX=$O(^ONCO(165.5,DA,"TS","AA","")) I OX,$D(NOTTHIS),$D(^ONCO(165.5,DA,"TS","AA",OX,NOTTHIS)) S OX=$O(^ONCO(165.5,DA,"TS","AA","")) ;    get IEN of last status - skip the current node on the kill
 S:OX OX=$O(^(OX,"")) S:OX NTS=$P($G(^ONCO(165.5,DA,"TS",OX,0)),U,2) S OTS=$P($G(^ONCO(165.5,DA,7)),U,6),$P(^(7),U,6)=NTS ;get old data, set new data
 K:$L(OTS) ^ONCO(165.5,"ACS",OTS,DA) S:$L(NTS) ^ONCO(165.5,"ACS",NTS,DA)="" ;kill old xref, set new xref
 Q
 ;
KILLNAT(FILE,SWS) ;Kill national fields only for a file
 ;Valid switches in SWS:/DOTS prints a dot every 10
 N DOTS,DA,DIK,KT
 S DOTS=(SWS["/DOTS") ;print dots?
 S DA(1)=FILE
 I $D(^DD(FILE)) S DIK="^DD("_FILE_",",DA=0 F KT=1:1 S DA=$O(^DD(FILE,DA)) Q:'DA!(DA'<10000)  D ^DIK I DOTS W:KT#10=0 "." ;if file exists, kill national fields only
 Q +$G(KT)
 ;
CLNNOSUS ;Delete ONCOLOGY PATIENT (160) entries with no primaries/no suspense
 N TOTKT,CLNKT
 W @IOF
 W !
 W !,"   This option will purge ONCOLOGY PATIENT records"
 W !,"   with no suspense records and no primaries."
 W !
 L +^ONCO(160):5
 I  D
 .K ^TMP($J,"NOSUS")
 .D COUNT
 .I CLNKT=0 W "   No records to purge" W ! K DIR S DIR(0)="E" D ^DIR
 .I CLNKT>0,$$CLNOK D PURGE
 .L -^ONCO(160)
 E  W !!,"The ONCOLOGY PATIENT file is in use... try again later!",*7,!!
 Q
 ;
COUNT ;Count the number of entries to delete
 N OI S OI=0
 S (TOTKT,CLNKT)=0
 F  S OI=$O(^ONCO(160,OI)) Q:OI'=+OI  D CHK
 W !,"   Total ONCOLOGY PATIENT records:    ",TOTKT
 W !,"   Total records marked for deletion: ",CLNKT,!
 I CLNKT>0 W !,"   Patients to be deleted:" S IEN=0 F  S IEN=$O(^TMP($J,"NOSUS",IEN)) Q:IEN'>0  D
 .W !,?3,$$GET1^DIQ(160,IEN,60,"E"),"  ",$$GET1^DIQ(160,IEN,.01,"E")
 W !
 Q
 ;
CHK S TOTKT=TOTKT+1
 S SUSDT=$O(^ONCO(160,OI,"SUS","B","")) I SUSDT'="" Q
 I $D(^ONCO(165.5,"C",OI)) Q
 I '$D(^ONCO(160,OI,0)) K ^ONCO(160,OI) Q
 S CLNKT=CLNKT+1
 S ^TMP($J,"NOSUS",OI)=""
 Q
 ;
CLNOK() ;Confirm that it's OK to purge
 N DIR
 S DIR("A")="   Proceed with purge",DIR("B")="No",DIR(0)="Y"
 D ^DIR
 Q Y
 ;
PURGE ;Delete entries
 N DIK S DIK="^ONCO(160,"
 N DA S DA=0
 F  S DA=$O(^TMP($J,"NOSUS",DA)) Q:DA'=+DA  D ^DIK W "."
 W "   DONE"
 W ! K DIR S DIR(0)="E" D ^DIR
 Q
 ;
LCASE(ONCOSTR) ;Convert string to upper/lowercase
 N ONCO F ONCO=2:1:$L(ONCOSTR) I $E(ONCOSTR,ONCO)?1U,$E(ONCOSTR,ONCO-1)?1A S ONCOSTR=$E(ONCOSTR,0,ONCO-1)_$C($A(ONCOSTR,ONCO)+32)_$E(ONCOSTR,ONCO+1,999)
 Q ONCOSTR
UCASE ;Convert string to uppercase
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
