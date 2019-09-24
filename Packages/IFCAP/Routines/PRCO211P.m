PRCO211P ;MNTVBB/RGB/File 2100.1 Vendor (VR) docs set to (A)ccepted ; 04 Mar 2019
V ;;5.1;IFCAP;**211**;Oct 20, 2000;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;;
 ;PRC*5.1*211 Status update to VR documents found in ^GECS(2100.1
 ;             flipped from 'T'ransmitted to 'A'ccepted
 Q
EN ;VR document status set from (T)ransmitted to (A)ccepted
 S U="^",GECSID="VR-0",GECST=0,GECSTAT="A",DT=$$DT^XLFDT
 K ^XTMP("PRCO211P")
 S ^XTMP("PRCO211P",0)=$$FMADD^XLFDT(DT,90)_"^"_DT,TT=0
 D NOW^%DTC S ^XTMP("PRCO211P",$J,"ZZASTART")=%
1 ;Find/flip all VR docs (vendor updates) from status 'T' to 'A'
 F  S GECSID=$O(^GECS(2100.1,"B",GECSID)),GECSIEN=0 Q:GECSID'["VR"  D
 . F  S GECSIEN=$O(^GECS(2100.1,"B",GECSID,GECSIEN)) Q:'GECSIEN  D
 . . S GECSR0=$G(^GECS(2100.1,GECSIEN,0)) I GECSR0=""!(GECSR0'["VR-") Q
 . . I $P(GECSR0,U,4)="T" D
 . . . S ^XTMP("PRCO211P",$J,GECSIEN,0)=GECSR0,GECST=GECST+1
 . . . S DA=GECSIEN,DIE="^GECS(2100.1,",DR="3///^S X=GECSTAT" D ^DIE
 D NOW^%DTC S ^XTMP("PRCO211P",$J,"ZZBEND")=%
 S ^XTMP("PRCO211P",$J,"ZZTOTALS")=GECST
 Q
