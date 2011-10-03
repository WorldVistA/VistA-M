DG17204 ;BHM/RGY,ALS-Edit mapping entries ;FEB 20, 1998
 ;;5.3;Registration;**172**;Aug 13, 1993
EDIT(TYPE) ;
 NEW DA,DIE,DR,L,TO,FR,DIC,FLDS,BY
 F X=0:0 S X=$O(^XTMP("DGTMP",390.2,X)) Q:'X  I $P(^(X,0),"^",2)=TYPE,'$P(^(0),"^",3) Q
 I 'X W !!,"*** No mapping necessary! ***",! K X Q
 W !! D MESS($S(TYPE=11:"MARITAL",1:"RELIGION")) W !
 S L=0,DIC="^XTMP(""DGTMP"",390.2,",(TO,FR)="",(BY,FLDS)="[DG172 "_$S(TYPE=11:"MARITAL",1:"RELIGION")_" MAPPING]"
 D EN1^DIP
START ;
 S DIC("A")="Select Non-Standard "_$S(TYPE=11:"Marital Status: ",1:"Religion: "),DIC="^XTMP(""DGTMP"",390.2,",DIC(0)="QEAM",DIC("S")="I '$P(^(0),U,3),$P(^(0),U,2)="_TYPE D ^DIC Q:Y<0  S DA=+Y
 S DIE="^XTMP(""DGTMP"",390.2,",DR=$S(TYPE=11:.07,1:.06)
 D ^DIE
 K Y
 W ! G START
BROAD ;
 NEW D0,DG172,TASK,XMY,XMDUZ,XMTEXT,XMSUB,N0,COUNT,TYPE
 S XMDUZ="Religion/Marital Status Conversion",XMSUB="Conversion Finished"
 S XMY(DUZ)="",XMTEXT="DG172(1,"
 F TASK=0:0 S TASK=$O(^XTMP("DGTMP",390.1,TASK)) Q:'TASK  D
   .I $P(^XTMP("DGTMP",390.1,TASK,0),"^",9)="" S XMSUB="Conversion *NOT* Finished"
   .Q
 I XMSUB["NOT" D  Q
   .S DG172(1,1)="The conversion process appears to have been stopped."
   .S DG172(1,2)="To finish the conversion process, restart by using"
   .S DG172(1,3)="the 'Begin Religion/Marital Status Conversion' option"
   .S DG172(1,4)="on the CIRN Pre-Implementation Menu."
   .D ^XMD
   .Q
 S COUNT=1
 F TYPE=11,13 D
   .S DG172(1,COUNT)=$S(TYPE=11:"Marital Status",1:"Religion")_" File Non-Standard Entries:",COUNT=COUNT+1
   .S DG172(1,COUNT)="=========================================",COUNT=COUNT+1
   .F D0=0:0 S D0=$O(^XTMP("DGTMP",390.2,D0)) Q:'D0  D
     ..S N0=$G(^XTMP("DGTMP",390.2,D0,0))
     ..I $P(N0,"^",2)'=TYPE Q
     ..I '$P(N0,"^",3) S DG172(1,COUNT)=$$DESC(N0)_" (# Converted: "_(+$P(N0,"^",9))_")"
     ..S COUNT=COUNT+1
     ..Q
   .S DG172(1,COUNT)=" ",COUNT=COUNT+1
   .Q
 S DG172(1,COUNT)=" ",COUNT=COUNT+1
 S DG172(1,COUNT)="All non-standard entries listed above have been removed",COUNT=COUNT+1
 S DG172(1,COUNT)="from their respective files.",COUNT=COUNT+1
 D ^XMD
 Q
DESC(N0) ;
 NEW TYPE
 S TYPE=$P(N0,"^",2)
 I TYPE=13 Q "Entry: "_$P($G(^DIC(13,+$P(N0,"^",4),0)),"^")_" repointed to: "_$P($G(^DIC(13,+$P(N0,"^",6),0)),"^")
 I TYPE=11 Q "Entry: "_$P($G(^DIC(11,+$P(N0,"^",5),0)),"^")_" repointed to: "_$P($G(^DIC(11,+$P(N0,"^",7),0)),"^")
 Q ""
MESS(M) ;Show message
 NEW C
 F C=1:1 Q:$P($T(@M+C),";;",2)=""  W !,$P($T(@M+C),";;",2)
 Q
MARITAL ;
 ;;This option will identify non-standard MARITAL STATUS file (#11) entries
 ;;and then allows the user to designate, for each non-standard entry,
 ;;a standard entry which this utility will re-point with associated patients.
 ;;For example, you will be able to map all patients with a marital status
 ;;of SINGLE to NEVER MARRIED.
 ;; 
 ;;This mapping will be used during the re-pointing and file clean-up  
 ;;process, the Begin Religion/Marital Status Conversion [DG172 PRE-IMP
 ;;START CONVERSION] option.
 ;; 
 ;;The option (1) provides a list of non-standard MARITAL STATUS
 ;;file entries to the screen or a printer, (2) prompts the user for
 ;;a non-standard entry, and (3) then prompts for the standard
 ;;entry which the utility will re-point with associated patients.
 ;;
RELIGION ;
 ;;This option will identify non-standard RELIGION file (#13) entries and
 ;;then allows the user to designate, for each non-standard entry, a
 ;;standard entry which this utility will re-point associated patients.
 ;;For example, you will be able to map all patients with a religion of
 ;;XXXXXX to UNKNOWN/NO PREFERENCE.
 ;; 
 ;;This linking will be used during the mapping and file clean-up  
 ;;process, Begin Religion/Marital Status Conversion [DG172 PRE-IMP
 ;;START CONVERSION] option.
 ;; 
 ;;The option (1) provides a list of non-standard RELIGION file
 ;;entries to the screen or a printer, (2) prompts the user for
 ;;a non-standard entry, and (3) then prompts for the standard
 ;;entry which the utility will re-point with associated patients.
 ;;
CONV ;
 ;;After the linking of non-standard entries is complete, this conversion
 ;;process is run in order to actually re-point patient records from
 ;;non-standard entries to the specified standard entries.
 ;;
