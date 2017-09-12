WV4PST ;HCIOFO/FT-WV*1*4 Post-Installation Routine ;1/4/99  16:36
 ;;1.0;WOMEN'S HEALTH;**4**;Sep 30, 1998
 ;
PAT4 ; Entry point for WV*1*4
 S ZTDTH=$$HADD^XLFDT($H,"","","",120)
 S ZTDESC="WV*1*4 data repair"
 S ZTRTN="QUEUE^WV4PST",ZTIO=""
 D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTIO,ZTRTN
 Q
QUEUE ;
 D PATCH
 D KILL
 Q
PATCH ; Find WV entry in Package file. If none, create WV entry.
 D FIND^DIC(9.4,"","","X","WV","","C","","","WVIEN","WVERR")
 S WVDA=+$G(WVIEN("DILIST",2,1)) ;get File 9.4 ien
 K WVIEN,WVERR
 Q:WVDA  ;quit if WV entry exists in Package file, fix not needed.
 D PF ;create package file entry
 D FIND^DIC(9.4,"","","X","WV","","C","","","WVIEN","WVERR")
 S WVDA=+$G(WVIEN("DILIST",2,1)) ;get File 9.4 ien
 K WVIEN,WVERR
 Q:'WVDA
 D BF ;Build file (#9.6) repair
 D IF ;Install file (#9.7) repair
 D VER ;create version multiple for WV entry
 D BWGET ; Get Patch Application History (PAH) data values from
 ;         File 9.4 BW entry for WV*1*3 & 4.
 D BWDEL ; Kill PAH entry in File 9.4 BW entry for WV*1*3 & 4
 Q
PF ; Create Package File entry for WV
 K WV94
 S WV94(9.4,"+1,",.01)="WOMEN'S HEALTH"
 S WV94(9.4,"+1,",1)="WV"
 S WV94(9.4,"+1,",2)="Tracks health issues specific to female patients."
 S WV94(9.4,"+1,",13)="1.0"
 D UPDATE^DIE("","WV94")
 K WV94
 Q
BF ; Fix package file link for WV*1*3 & 4 in BUILD file (#9.6)
 ; (i.e., change pointer to WV entry).
 N WVBFIEN,WV96NAME
 F WV96NAME="WV*1.0*3","WV*1.0*4" D
 .D FIND^DIC(9.6,"","","X",WV96NAME,"","B","","","WVIEN","WVERR")
 .S WVBFIEN=+$G(WVIEN("DILIST",2,1))
 .K WVIEN,WVERR
 .Q:'WVBFIEN
 .K WVBF
 .S WVBF(9.6,WVBFIEN_",",1)=WVDA ;Field #1 - Package File Link
 .D UPDATE^DIE("","WVBF")
 .K WVBF
 .Q
 Q
IF ; Fix package file link for WV*1*3 & 4 in INSTALL file (#9.7)
 ; (i.e., change pointer to WV entry).
 F WV97NAME="WV*1.0*3","WV*1.0*4" D
 .D FIND^DIC(9.7,"","","X",WV97NAME,"","B","","","WVIEN","WVERR")
 .S WVIFIEN=+$G(WVIEN("DILIST",2,1))
 .K WVIEN,WVERR
 .Q:'WVIFIEN
 .K WVIF
 .S WVIF(9.7,WVIFIEN_",",1)=WVDA ;Field #1 - Package File Link
 .D UPDATE^DIE("","WVIF")
 .K WVIF
 .Q
 Q
VER ; Create VERSION multiple for WV entry
 D FIND^DIC(9.7,"","","X","WOMEN'S HEALTH 1.0","","B","","","WVIEN","WVERR")
 S WVIFIEN=+$G(WVIEN("DILIST",2,1))
 K WVIEN,WVERR
 S WVIB=$$GET1^DIQ(9.7,WVIFIEN,9,"I") ;Installed By
 S WVICT=$$GET1^DIQ(9.7,WVIFIEN,17,"I") ;Install Complete Time
 S:WVICT WVICT=$P(WVICT,".") ;date only
 K WV94
 S WV94(9.49,"+1,"_WVDA_",",.01)="1.0" ;version #
 S WV94(9.49,"+1,"_WVDA_",",1)=2980928 ;date distributed
 S WV94(9.49,"+1,"_WVDA_",",2)=WVICT   ;install complete time
 S WV94(9.49,"+1,"_WVDA_",",3)=WVIB    ;installed by
 D UPDATE^DIE("","WV94")
 K WV94
 Q
BWGET ; Get WV*1*3 & 4 PAH entry in Package file (#9.4) for BW
 D FIND^DIC(9.4,"","","X","BW","","C","","","WVIEN","WVERR")
 S WVBW=+$G(WVIEN("DILIST",2,1))
 Q:'WVBW
 K WVIEN,WVERR
 D FIND^DIC(9.49,","_WVBW_",","","X","1.0","","","","","WVIEN","WVERR")
 S WVBW1=+$G(WVIEN("DILIST",2,1))
 Q:'WVBW1
 F WVBW2=3,4 D
 .S WVDA2=WVBW2
 .K WVIEN,WVERR
 .D FIND^DIC(9.4901,","_WVBW1_","_WVBW_",","","X",WVBW2,"","B","","","WVIEN","WVERR")
 .S WVBW2=+$G(WVIEN("DILIST",2,1))
 .Q:'WVBW2
 .K WVPAH
 .D GETS^DIQ(9.4901,WVBW2_","_WVBW1_","_WVBW_",","*","I","WVPAH","WVERR")
 .D WVPAH
 .Q
 Q
WVPAH ; Create a PAH entry in File 9.4 WV entry for WV*1*3 & 4
 ; Use values from BW entry.
 S WVIENS=$O(WVPAH(9.4901,"")) Q:WVIENS=""  ;no WV*1*3/4 entry for BW
 D FIND^DIC(9.49,","_WVDA_",","","X","1.0","","","","","WVIEN","WVERR")
 S WVDA1=+$G(WVIEN("DILIST",2,1))
 Q:'WVDA1
 K WVIEN,WVERR
 D FIND^DIC(9.4901,","_WVDA1_","_WVDA_",","","X",WVDA2,"","B","","","WVIEN","WVERR")
 Q:+$G(WVIEN("DILIST",2,1))  ;PAH entry already exists
 K WVPAT3
 S WVPAT3(9.4901,"+1,"_WVDA1_","_WVDA_",",.01)=WVDA2
 S WVPAT3(9.4901,"+1,"_WVDA1_","_WVDA_",",.02)=$G(WVPAH(9.4901,WVIENS,.02,"I"))
 S WVPAT3(9.4901,"+1,"_WVDA1_","_WVDA_",",.03)=$G(WVPAH(9.4901,WVIENS,.03,"I"))
 D UPDATE^DIE("","WVPAT3")
 K WVPAT3
 Q
BWDEL ; Delete erroneous BW version entry in Package file (#9.4).
 Q:'$G(WVBW1)!'$G(WVBW)
 N DA,DIK
 S DA=WVBW1,DA(1)=WVBW
 S DIK="^DIC(9.4,"_WVBW_",22,"
 D ^DIK
 Q
KILL ; Kill variables
 K WV94,WV96NAME,WV97NAME,WVBF,WVBFIEN,WVBW,WVBW1,WVBW2,WVDA,WVDA1,WVDA2
 K WVERR,WVIB,WVICT,WVIEN,WVIENS,WVIF,WVIFIEN,WVPAH,WVPAT3
 Q
