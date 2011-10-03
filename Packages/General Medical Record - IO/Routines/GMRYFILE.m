GMRYFILE ;HIRMFO/FT-Set I/O File Security ;3/5/97  16:41
 ;;4.0;Intake/Output;;Apr 25, 1997
POST1 ; entry point from package installation
 I $G(XPDQUES("POST1"))'>0 D BMES^XPDUTL("FILE SECURITY NOT UPDATED!!") Q
 D BMES^XPDUTL("Setting Intake/Output file security...")
EN1 ;
 F GMRYTXT=1:1 S GMRYLINE=$P($T(SECURITY+GMRYTXT),";;",2,99) Q:GMRYLINE=""  D
 . S GMRYFL=+$P(GMRYLINE,";")
 . S ^DIC(GMRYFL,0,"DD")=$P(GMRYLINE,";",2)
 . S ^DIC(GMRYFL,0,"RD")=$P(GMRYLINE,";",3)
 . S ^DIC(GMRYFL,0,"WR")=$P(GMRYLINE,";",4)
 . S ^DIC(GMRYFL,0,"DEL")=$P(GMRYLINE,";",5)
 . S ^DIC(GMRYFL,0,"LAYGO")=$P(GMRYLINE,";",6)
 . Q
 K GMRYFL,GMRYLINE,GMRYTXT
 Q
SECURITY ;;FILENO;DD;RD;WR;DEL;LAYGO
 ;;126;@;;@;@;@
 ;;126.56;@;;@;@;@
 ;;126.58;@;;@;@;@
 ;;126.6;@;;@;@;@
 ;;126.7;@;;@;@;@
 ;;126.72;@;;@;@;@
 ;;126.74;@;;@;@;@
 ;;126.76;@;;@;@;@
 ;;126.8;@;;@;@;@
 ;;126.9;@;;@;@;@
 ;;126.95;@;;@;@;@
 Q
