KMPSLK ;OAK/KAK - Thru The Looking Glass ;5/1/07  10:29
 ;;2.0;SAGG;;Jul 02, 2007
 ;
EN(SESSNUM,SITENUM) ;
 ;---------------------------------------------------------------------
 ; SESSNUM..  +$Horolog number of session
 ; SITENUM..  site number
 ;---------------------------------------------------------------------
 ;
ZER ;-- collect zeroth node information
 ;
 N FNUM,GNAM
 ;
 S ^XTMP("KMPS",SITENUM,SESSNUM,"@ZER",0)=$P(^DIC(0),U)_U_$P(^DIC(0),U,4)_"^DIC(^"
 S ^XTMP("KMPS",SITENUM,SESSNUM,"@ZER","TM")=$S($D(^%ZTSK(-1)):^(-1),1:^%ZTSK(0))
 S FNUM=0 F  S FNUM=$O(^DIC(FNUM)) Q:'+FNUM  D
 .Q:$G(^DIC(FNUM,0))=""
 .Q:'$D(^DIC(FNUM,0,"GL"))
 .S GNAM=$G(^DIC(FNUM,0,"GL")) Q:GNAM=""
 .;
 .; file# = ^ piece 1: file_name
 .;                 2: # of entries
 .;                 3: global_name
 .;                 4: file_version
 .;                 5: last id number
 .;                 6: global_name (GNAM) has embedded '^' - no extra 'U' needed
 .S ^XTMP("KMPS",SITENUM,SESSNUM,"@ZER",FNUM)=$P(^DIC(FNUM,0),U)_U_$P($G(@(GNAM_"0)")),U,4)_GNAM_U_$G(^DD(+$P(^DIC(FNUM,0),U,2),0,"VR"))_U_$P($G(@(GNAM_"0)")),U,3)
 ;
PKG ;-- collect package file information
 ;
 N PKNUM
 ;
 S PKNUM=0
 F  S PKNUM=$O(^DIC(9.4,PKNUM)) Q:'+PKNUM  I $D(^DIC(9.4,PKNUM,0)) S KMPSD=$P($G(^DIC(9.4,PKNUM,0)),U,2) D
 .I $E(KMPSD)="A" I ($A($E(KMPSD,2))>64)&($A($E(KMPSD,2))<88) I (($A($E(KMPSD,3))>64)&($A($E(KMPSD,3))<89)) Q
 .S KMPSV=0,(KMPSVL,KMPSD)=""
 .F  S KMPSV=$O(^DIC(9.4,PKNUM,22,KMPSV)) Q:'+KMPSV  S KMPSVL=KMPSV
 .I +KMPSVL S KMPSV=$G(^DIC(9.4,PKNUM,22,KMPSVL,0)),KMPSD=$P(KMPSV,U,3),KMPSV=$P(KMPSV,U)
 .;
 .; pkg_name = pkg_prefix^current version^last version^install date
 .S ^XTMP("KMPS",SITENUM,SESSNUM,"@PKG",$P(^DIC(9.4,PKNUM,0),U))=$P($G(^DIC(9.4,PKNUM,0)),U,2)_U_$G(^("VERSION"))_U_KMPSV_U_KMPSD
 ;
SYS ;  Collect volume set (@VOL) and system (@SYS) information
 ;
 D EN^%ZOSVKSD(SITENUM,SESSNUM,.KMPSVOLS,OS),@OS
 ;
 K KMPSD,KMPSNM,KMPSV,KMPSVL
 Q
 ;
CVMS ;-- for Cache for VMS platform
 S ^XTMP("KMPS",SITENUM,SESSNUM,"@SYS")=$ZV_U
 Q
 ;
CWINNT ;-- for Cache for NT platform
 S ^XTMP("KMPS",SITENUM,SESSNUM,"@SYS")=$ZV_U_$S($ZU(100)=0:"Windows NT",$ZU(100)=1:"Windows 95",1:$ZU(100))
 Q
 ;        
OUT(NOWDT,OS,SESSNUM,SITENUM,XMZSENT,TEXT)     ;
 ;---------------------------------------------------------------------
 ;   Create 'successful' end-game message text
 ; NOWDT....   FM date and time that SAGG started
 ; OS.......   type of operating system
 ; SESSNUM..   +$Horolog number of session
 ; SITENUM..   site number
 ; XMZSENT..   mailman message number created by SAGG
 ;---------------------------------------------------------------------
 ;
 N DOW,GBL,I,J,JEND,UCIVOL,VOLS,X
 ;
 ; check to see if SAGG not started over weekend (Fri - Sun)
 S DOW=$$DOW^XLFDT(NOWDT,1)
 I (DOW>0)&(DOW<5) D
 .S TEXT(1)=" *** It is STRONGLY recommended that the 'SAGG Master Background Task' ***"
 .S TEXT(2)=" *** [KMPS SAGG REPORT] be rescheduled to run over the weekend hours.  ***"
 .S TEXT(3)=""
 ;
 S TEXT(4)=" The SAGG Project collection routines monitored the following:"
 S TEXT(5)=""
 K VOLS
 S GBL=""
 F  S GBL=$O(^XTMP("KMPS",SITENUM,SESSNUM,NOWDT,GBL)) Q:GBL=""  D
 .S UCIVOL=""
 .F  S UCIVOL=$O(^XTMP("KMPS",SITENUM,SESSNUM,NOWDT,GBL,UCIVOL)) Q:UCIVOL=""  S VOLS(UCIVOL)=""
 S X=0,UCIVOL="",JEND=$S(OS="CVMS":2,OS="CWINNT":4,1:5)
 F I=6:1 Q:X  D
 .S TEXT(I)="          "
 .F J=1:1:JEND S UCIVOL=$O(VOLS(UCIVOL)) S:UCIVOL="" X=1 Q:UCIVOL=""  S TEXT(I)=TEXT(I)_UCIVOL_"   "
 S TEXT(I)=""
 S TEXT(I+1)=" Please ensure that this list concurs with your present volume set"
 S TEXT(I+2)=" configuration.",TEXT(I+3)=""
 S TEXT(I+4)=" A local e-mail message #"_XMZSENT_" was created by the collection"
 S TEXT(I+5)=" routines.  Check the FO-ALBANY.MED.VA.GOV NetMail Queue to ensure"
 S TEXT(I+6)=" transmission delivery."
 ;
 Q ""
 ;
MSG(STRTDT,SESSNUM,TEXT,COMPDT)       ;-- send e-mail message to local KMP-CAPMAN mailgroup
 ;---------------------------------------------------------------------
 ; Send e-mail message to local KMP-CAPMAN mailgroup
 ;
 ; STRTDT...  SAGG start date and time
 ; SESSNUM..  +$Horolog number of session
 ; TEXT.....  text of message
 ; COMPDT...  (optional) SAGG completion date and time
 ;---------------------------------------------------------------------
 N XMSUB,XMTEXT,XMY
 ;
 S COMPDT=+$G(COMPDT)
 ;
 S:'$D(XMDUZ) XMDUZ=.5
 S:'$D(DUZ) DUZ=.5 S U="^"
 ;
 S TEXT(.1)=" SAGG Session: "_SESSNUM
 S TEXT(.2)=" Started:      "_$$FMTE^XLFDT(STRTDT,"P")_" ("_$$DOW^XLFDT(STRTDT)_")"
 S:+COMPDT TEXT(.3)=" Completed:    "_$$FMTE^XLFDT(COMPDT,"P")_" ("_$$DOW^XLFDT(COMPDT)_")"
 S TEXT(.4)=""
 S XMSUB="SAGG Project Message (Session #"_SESSNUM_")",XMTEXT="TEXT("
 I $D(^XMB(3.8,"B","KMP-CAPMAN")) S XMY("G.KMP-CAPMAN")=""
 D:$D(XMY) ^XMD
 Q
 ;
END ;
 K ^XTMP("KMPS",SITENUM),^XTMP("KMPS","ERROR")
 K ^XTMP("KMPS","START"),^XTMP("KMPS","STOP"),^XTMP("KMPS",0)
 K X,XMDUZ
 S ZTREQ="@"
 L -^XTMP("KMPS")
 Q
