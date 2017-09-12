WV3PRE ;HCIOFO/FT-Patch Pre-Installation Routine ;12/14/98  16:03
 ;;1.0;WOMEN'S HEALTH;**3**;Sep 30, 1998
 ;
PAT3 ; Entry point for WV*1*3
 D PATCH
 Q
PATCH ; Delete erroneous patch references in Package file (#9.4)
 D FIND^DIC(9.4,"","","X","WV","","C","","","WVIEN","WVERR")
 S WVDA=+$G(WVIEN("DILIST",2,1))
 Q:'WVDA
 K WVIEN,WVERR
 D FIND^DIC(9.49,","_WVDA_",","","X","1.0","","","","","WVIEN","WVERR")
 S WVDA1=+$G(WVIEN("DILIST",2,1))
 Q:'WVDA1
 F WVDA2=99,100,101,102 D
 .K WVIEN,WVERR
 .D FIND^DIC(9.4901,","_WVDA1_","_WVDA_",","","X",WVDA2,"","B","","","WVIEN","WVERR")
 .S WVDA2=+$G(WVIEN("DILIST",2,1))
 .Q:'WVDA2
 .S DA=WVDA2,DA(1)=WVDA1,DA(2)=WVDA
 .S DIK="^DIC(9.4,"_WVDA_",22,"_WVDA1_",""PAH"","
 .D ^DIK
 .Q
 K WVDA,WVDA1,WVIEN,WVERR
 Q
