GMRVFILE ;HIRMFO/FT-Set V/M File Security ;3/5/97  16:41
 ;;4.0;Vitals/Measurements;;Apr 25, 1997
POST1 ; entry point from package installation
 I $G(XPDQUES("POST1"))'>0 D BMES^XPDUTL("FILE SECURITY NOT UPDATED!!") Q
 D BMES^XPDUTL("Setting Vitals/Measurements file security...")
EN1 ;
 F GMRVTXT=1:1 S GMRVLINE=$P($T(SECURITY+GMRVTXT),";;",2,99) Q:GMRVLINE=""  D
 . S GMRVFL=+$P(GMRVLINE,";")
 . S ^DIC(GMRVFL,0,"DD")=$P(GMRVLINE,";",2)
 . S ^DIC(GMRVFL,0,"RD")=$P(GMRVLINE,";",3)
 . S ^DIC(GMRVFL,0,"WR")=$P(GMRVLINE,";",4)
 . S ^DIC(GMRVFL,0,"DEL")=$P(GMRVLINE,";",5)
 . S ^DIC(GMRVFL,0,"LAYGO")=$P(GMRVLINE,";",6)
 . Q
 K GMRVFL,GMRVLINE,GMRVTXT
 Q
SECURITY ;;FILENO;DD;RD;WR;DEL;LAYGO
 ;;120.5;@;;@;@;@
 ;;120.51;@;;@;@;@
 ;;120.52;@;;@;@;@
 ;;120.53;@;;@;@;@
 ;;120.55;@;;@;@;@
 ;;120.57;@;;@;@;@
 Q
