NURSFILE ;HIRMFO/FT-Set Nursing File Security ;3/19/98  15:05
 ;;4.0;NURSING SERVICE;**9**;Apr 25, 1997
POST1 ; entry point from package installation
 I $G(XPDQUES("POST1"))'>0 D BMES^XPDUTL("FILE SECURITY NOT UPDATED!!") Q
 D BMES^XPDUTL("Setting Nursing file security...")
EN1 ;
 F NURSTXT=1:1 S NURSLINE=$P($T(SECURITY+NURSTXT),";;",2,99) Q:NURSLINE=""  D
 . S NURSFL=+$P(NURSLINE,";")
 . S ^DIC(NURSFL,0,"DD")=$P(NURSLINE,";",2)
 . S ^DIC(NURSFL,0,"RD")=$P(NURSLINE,";",3)
 . S ^DIC(NURSFL,0,"WR")=$P(NURSLINE,";",4)
 . S ^DIC(NURSFL,0,"DEL")=$P(NURSLINE,";",5)
 . S ^DIC(NURSFL,0,"LAYGO")=$P(NURSLINE,";",6)
 . Q
 K NURSFL,NURSLINE,NURSTXT
 Q
SECURITY ;;FILENO;DD;RD;WR;DEL;LAYGO
 ;;210;@;;@;@;@
 ;;211.1;@;;@;@;@
 ;;211.2;@;;@;@;@
 ;;211.3;@;;@;@;@
 ;;211.4;@;;@;@;@
 ;;211.5;@;;@;@;@
 ;;211.6;@;;@;@;@
 ;;211.7;@;;@;@;@
 ;;211.8;@;;@;@;@
 ;;211.9;@;;@;@;@
 ;;212.1;@;;@;@;@
 ;;212.2;@;;@;@;@
 ;;212.3;@;;@;@;@
 ;;212.4;@;;@;@;@
 ;;212.42;@;;@;@;@
 ;;212.6;@;;@;@;@
 ;;212.7;@;;@;@;@
 ;;213.2;@;;@;@;@
 ;;213.3;@;;@;@;@
 ;;213.4;@;;@;@;@
 ;;213.5;@;;@;@;@
 ;;213.9;@;;@;@;@
 ;;214;@;;@;@;@
 ;;214.6;@;;@;@;@
 ;;214.7;@;;@;@;@
 ;;216.8;@;;@;@;@
 ;;217;@;;@;@;@
 ;;217.1;@;;@;@;@
 ;;217.2;@;;@;@;@
 ;;217.3;@;;@;@;@
 ;;219.7;@;;@;@;@
 Q
