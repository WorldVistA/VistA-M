RAIENV ;HIRMFO/GJC-Environment Check routine (cleanup build) ;5/29/97  09:08
VERSION ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ; Developer Note:  This environment check will allow the user
 ; to load the 'Radiology/Nuclear Medicine Cleanup' build without
 ; installing.  We never want to load & install 'Radiology/Nuclear
 ; Medicine Cleanup' by itself.  It is a queued job, fired off by
 ; the last post-install routine of Radiology/Nuclear Medicine v5.0.
 ;
 W !!?3,"This build will be queued to run from the RADIOLOGY/NUCLEAR"
 W " MEDICINE",!?3,$P($T(+2),";",3)_" build.  ",XPDNM," cannot be run"
 W !?3,"independently.",! S XPDABORT=2 Q
