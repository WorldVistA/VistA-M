SPNPRI16 ;SD/WDE/Pre init action for patch 16;11/1/2001
 ;;2.0;Spinal Cord Dysfunction;**16**;01/02/97
EN ;
 ;--------------------------------------------------------------------
154 ;remove data and fields in 154
 W !,"Please stand by while I remove the obsolete data",!," and fields in the SCD (SPINAL CORD) REGISTRY file (#154)."
 S SPNCNT=0
 S SPNDFN=0 F  S SPNDFN=$O(^SPNL(154,SPNDFN))  Q:(SPNDFN="")!('+SPNDFN)  D
 .S SPNCNT=SPNCNT+1 I SPNCNT#40=0 W "."
 .I SPNCNT#610=0 W "Working"
 .F SPNX=8.7,8.5,.04,9,2.3 D
 ..S SPNCHK=$$GET1^DIQ(154,SPNDFN_",",SPNX)
 ..I $L(SPNCHK)>0 S DA=SPNDFN,DIE="^SPNL(154,",DR=SPNX_"///@" D ^DIE
 ..S SPNCHK=""
 ..Q
 .Q
 ;now remove the fields in 154
 K DA,DR,SPNX,DIE,SPNCHK,SPNDFN
 F SPNX=8.7,8.5,.04,9,2.3 D
 .S DA=SPNX,DA(1)=154,DIK="^DD(154," D ^DIK
 K DIK,DA,DR,SPNX,SPNCHK
 ;--------------------------------------------------------------------
1541 ;remove data and fields in 154.1
 W !,"Please stand by while I remove the obsolete data",!," and fields in the OUTCOMES file (#154.1)."
 S SPNIEN=0 F  S SPNIEN=$O(^SPNL(154.1,SPNIEN)) Q:(SPNIEN="")!('+SPNIEN)  D
 .S SPNCNT=SPNCNT+1 I SPNCNT#40=0 W "."
 .I SPNCNT#610=0 W "Working"
 .F SPNX=2.1,2.11,2.12,9 D
 ..S SPNCHK=$$GET1^DIQ(154.1,SPNIEN_",",SPNX)
 ..I $L(SPNCHK)>0 S DA=SPNIEN,DIE="^SPNL(154.1,",DR=SPNX_"///@" D ^DIE
 ..Q
 .Q
 K DA,DR,SPNX,DIE,SPNCHK,SPNIEN
 ;remove the fields now in 154.1
 F SPNX=2.1,2.11,2.12,9 D
 .S DA=SPNX,DA(1)=154.1,DIK="^DD(154.1," D ^DIK
 K DIK,DA,DR,SPNX,SPNCHK
 ;----------------------------------------------------------------------
15491 ;remove data and fields from file 154.91
 W !,"Please stand by while I remove the obsolete data",!," and fields in the SCD SITE PARAMETERS file (#154.91)"
 S SPNIEN=0 F  S SPNIEN=$O(^SPNL(154.91,SPNIEN))  Q:(SPNIEN="")!('+SPNIEN)  D
 .S SPNCNT=SPNCNT+1 I SPNCNT#40=0 W "."
 .I SPNCNT#610=0 W "Working"
 .F SPNX=1,2,3 D
 ..S SPNCHK=$$GET1^DIQ(154.91,SPNIEN_",",SPNX)
 ..I $L(SPNCHK)>0 S DA=SPNIEN,DIE="^SPNL(154.91,",DR=SPNX_"///@" D ^DIE
 ..Q
 K DA,DR,SPNX,DIE,SPNCHK,SPNIEN
 ;remove the fields IN 154.91
 F SPNX=1,2,3 D
 .S DA=SPNX,DA(1)=154.91,DIK="^DD(154.91," D ^DIK
 K DIK,DA,DR,SPNX,SPNCHK,SPNIEN
 ;----------------------------------------------------------------------
15493 ;remove data and fields and file 154.93
 W !,"Please stand by while I remove the obsolete data",!," and the file CURRENT TRANSMISSION CYCLE (#154.93)."
 S DIU="^SPNL(154.93,",DIU(0)="DST" D EN^DIU2
 K DIU
 ;----------------------------------------------------------------------
15494 ;remove data and fields and file 154.94
 W !,"Please stand by while I remove the obsolete data",!," and the file TRANSMISSION CYCLE HISTORY (#154.94)."
 S DIU="^SPNL(154.94,",DIU(0)="DST" D EN^DIU2
 K DIU
 ;----------------------------------------------------------------------
1549 ;remove data and fields and file 154.9
 W !,"Please stand by while I remove the obsolete data",!," and the file PATIENT TRANSMISSION STATUS (#154.9)."
 S DIU="^SPNL(154.9,",DIU(0)="DST" D EN^DIU2
 K DIU
 K DIE,DA,DR,SPNX,SPNIEN,SPNCHK
 Q
