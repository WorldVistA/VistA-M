HBHCPS15 ; LR VAMC(IRMS)/MJT-HBHC Patch 15 Post-installation conversion routine, Unlimited CPT Codes, Convert 10 CPT Code fields in node 1, to multiple, then kill node 1 ; 9907
 ;;1.0;HOSPITAL BASED HOME CARE;**15**;NOV 01, 1993
 ; Loop thru HBHC(632, move CPT codes from node 1 to multiple, then kill node 1
 S HBHCIEN=0 F  S HBHCIEN=$O(^HBHC(632,HBHCIEN)) Q:HBHCIEN'>0  S HBHCINFO=$G(^HBHC(632,HBHCIEN,1)) I HBHCINFO]"" F HBHCI=1:1:10 Q:$P(HBHCINFO,U,HBHCI)=""  D SET K ^HBHC(632,HBHCIEN,1)
 S DIK="^DD(632,",DA(1)=632 F DA=21:1:30 D ^DIK
EXIT ; Exit module
 K DA,DD,DIC,DO,HBHCI,HBHCIEN,HBHCINFO,X
 Q
SET ; Set CPT multiple
 K DD,DO
 S DA(1)=HBHCIEN,DIC="^HBHC(632,DA(1),2,",DIC(0)="L",DIC("P")=$P(^DD(632,32,0),U,2),X=$P(HBHCINFO,U,HBHCI) D FILE^DICN
 Q
