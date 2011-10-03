KMPSUTL ;OAK/KAK - SAGG Utilities ;5/1/07  10:30
 ;;2.0;SAGG;;Jul 02, 2007
 ;
CURSTAT(STAT)   ;-- current status
 ;---------------------------------------------------------------------
 ; input:  STAT (optional) = data from $$TSKSTAT^KMPSUTL1
 ; output: See codes below
 ;---------------------------------------------------------------------
 ;
 N RESULT,SITNUM,STRTDT
 ;
 S RESULT="",SITNUM=^DD("SITE",1),STRTDT=$G(^XTMP("KMPS",SITNUM,0))
 ;
 I $D(^XTMP("KMPS","ERROR")) Q "6^ERRORS RECORDED"
 I $D(^XTMP("KMPS","STOP")) Q "7^STOPPING"
 I $D(^XTMP("KMPS","START")) L +^XTMP("KMPS"):0 I $T L -^XTMP("KMPS") Q "5^DID NOT COMPLETE"
 I +STRTDT I +$H-STRTDT>2 Q "5^DID NOT COMPLETE"
 I +STRTDT I +$H-STRTDT>1 Q "4^RUNNING TOO LONG"
 I $D(^XTMP("KMPS","START")) Q "0^RUNNING"
 I $D(STAT) Q $P(STAT,U,1,2)
 E  Q "3^NOT RUNNING"
 Q "9^UNKNOWN"
 ;
STOP ;-- stop SAGG collection routines
 ;
 N DIR,X,Y
 ;
 I '$D(^XTMP("KMPS","START")) D  Q
 .W !!,?5,"The SAGG Project collection routines are not running.",!
 E  W !!,"Current status of SAGG is ",$P($$CURSTAT(),U,2),!
 S DIR("A")="Do you wish to manually STOP the SAGG Project collection routines (Y/N)",DIR("B")="N",DIR(0)="Y"
 D ^DIR W !
 I Y D
 .S ^XTMP("KMPS","STOP")=1
 .W !,?5,"The SAGG Project collection routines have been notified to begin an"
 .W !,?5,"orderly shut-down process.",!
 Q
 ;
FILE ;-- modifies data in the SAGG PROJECT file #8970.1
 ;
 N DA,DIC,DIE,DLAYGO,DR,PLTFRM,X
 ;
 S PLTFRM=$$MPLTF^KMPSUTL1
 W !!,"Specify the Directories"
 W " which hold your VistA production globals.",!!,"For example:",!!,?5
 I PLTFRM="CWINNT" W "Cache for Windows NT =>  W:\VAA, W:\VBB, W:\VCC ... V:\Vxx"
 I PLTFRM="CVMS" W "Cache for OpenVMS =>  _$1$DKAn:[CACHSYS.VAA] ... _$1$DKAx:[CACHSYS.Vxx]"
 I PLTFRM="UNK" W "Specify all locations of VistA globals"
 W !!,"Do NOT specify 'test/training' Directories, (i.e., UTL,TST, etc.).",!
 S DIE="^KMPS(8970.1,",DA=1,DR=.03
 S:PLTFRM'="DSM" DR(2,8970.11)=.01
 D ^DIE
 ;
 Q
 ;
HELP ;-- extended help for SAGG PROJECT file VOLUME SET TO MONITOR (.01) field
 ;
 N PLTFRM
 ;
 S PLTFRM=$$MPLTF^KMPSUTL1 Q:PLTFRM="UNK"
 W !," This field will contain the name of the Directories that the site wants"
 W !," to monitor with the SAGG Project collection routines. The site should"
 W !," specify only the Directories which hold their VistA production globals:"
 W !!
 W " For example:",!!
 I PLTFRM="CWINNT" W "    Cache for Windows NT =>  W:\VAA, W:\VBB, W:\VCC ... V:\Vxx",!!
 I PLTFRM="CVMS" W "    Cache for OpenVMS =>  _$1$DKAn:[CACHSYS.VAA] ... _$1$DKAx:[CACHSYS.Vxx]",!!
 W " Do NOT specify 'test/training' Directories (e.g., UTL, TST, etc.).",!
 Q
 ;
VERSION() ;-- extrinsic - return current version.
 Q $P($T(+2^KMPSUTL),";",3)_"^"_$P($T(+2^KMPSUTL),";",5)
 ;
PTCHINFO        ; -- patch information: routine name ^ current version ^ current patch(es) ^ package namespace
 ;;KMPSGE^2.0^^KMPS
 ;;KMPSLK^2.0^^KMPS
 ;;KMPSUTL^2.0^^KMPS
 ;;KMPSUTL1^2.0^^KMPS
 ;;%ZOSVKSD^8.0^**121,197,268,456**^XU
 ;;%ZOSVKSE^8.0^**90,94,197,268,456**^XU
 ;;%ZOSVKSS^8.0^**90,94,197,268,456**^XU
