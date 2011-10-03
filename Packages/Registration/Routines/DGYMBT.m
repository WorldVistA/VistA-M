DGYMBT ;ALB/REW - DGBT(392,B) X-REF CLEANUP - 12/9/94
 ;;5.3;Registration;**35**;Aug 13, 1993
EN ;  remove corrupt pointers from B x-REF OF DGBT(392,
 ;
 ; Optional input:
 ; DGNOKILL - If set to 1 will show corrupt nodes w/o deleting
 ;            this is killed at end of routine
 ;
 N DGBTFL,DGBTIEN,DGBT
 W !,"Searching for corrupt 'B' cross-reference entries ...",!
 S DGBTFL=0
 S DGBT="" F  S DGBT=$O(^DGBT(392,"B",DGBT)) Q:DGBT=+DGBT  D CLEAN
 S DGBT=9999999.9999 F  S DGBT=$O(^DGBT(392,"B",DGBT)) Q:DGBT=""  D CLEAN
 W:'DGBTFL !!?5,"...None found."
 W !!,"Done."
 K DGNOKILL
 Q
CLEAN ;
 S DGBTFL=1
 S DGBTIEN=$O(^DGBT(392,"B",DGBT,""))
 W !,?5,"Bad cross-reference: ^DGBT(392,""B"",",DGBT,",",DGBTIEN,")"
 I DGBTIEN'=DGBT!(DGBT=+DGBT)!(DGBT'>0) D
 .W !?5,"Non-standard corruption.  Please review above record and remove manually."
 E  D
 .Q:$G(DGNOKILL)
 .K ^DGBT(392,DGBT)
 .K ^DGBT(392,"B",DGBT)
 .W ?50,"...deleted."
 Q
