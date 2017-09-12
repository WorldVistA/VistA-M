ENXMIPS ;WIRMFO/SAB- POST INIT ;7/9/96
 ;;7.0;ENGINEERING;**32**;Aug 17, 1993
 N ENIRL,ENDA,ENFDA
 F ENIRL="ENNX","ENPM" D
 . S ENDA=$O(^PRCT(446.4,"C",ENIRL,0))
 . I 'ENDA W !,"Barcode Program ",ENIRL," not found. Can't update it." Q
 . W !,"  Updating Engineering BARCODE PROGRAM '",ENIRL,"'"
 . K ENFDA
 . S ENFDA(446.4,ENDA_",",.09)="JANUS2020"
 . D FILE^DIE("E","ENFDA") D MSG^DIALOG()
 Q
 ;ENXMIPS
