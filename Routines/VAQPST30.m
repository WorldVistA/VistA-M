VAQPST30 ;JRP/ALB - INSTALL EXPORTED ROUTINES;24-AUG-93
 ;;1.5;PATIENT DATA EXCHANGE;**1**;NOV 17, 1993
EXPORT ;MAIN ENTRY POINT
 ;INPUT  : None
 ;OUTPUT : None
 ;NOTES  : The following routines will be installed
 ;           GMTSPDX - Extracts Health Summary components
 ;           IBAPDX  -+
 ;           IBAPDX0  |- Extract/Display Integrated Billing info
 ;           IBAPDX1 -+
 ;
 ;DECLARE VARIABLES
 N OFFSET,EXPORT,INSTALL,VERSION,PATCHES,TEXT,EXIST,TMP
 N INSVER,INSPAT,INSLN2,SPOT
 W !!!,?2,">>> Exported routines will now be loaded",!
 ;LOOP THROUGH EXPORTED ROUTINES
 F OFFSET=1:1 S TEXT=$T(RTN+OFFSET) S TEXT=$P(TEXT,";;",2,$L(TEXT,";;")) Q:(TEXT="")  D
 .S EXPORT=$P(TEXT,";",1)
 .S INSTALL=$P(TEXT,";",2)
 .S VERSION=$P(TEXT,";",3)
 .S PATCHES=$P(TEXT,";",4)
 .Q:((EXPORT="")!(INSTALL=""))
 .;MAKE SURE EXPORTED ROUTINE EXISTS
 .I ('$$EXIST^VAQPST31(EXPORT)) D  Q
 ..W !,?5,$C(7),"** Exported routine ",EXPORT," does not exist"
 .;CHECK FOR EXISTANCE OF NEW ROUTINE
 .S EXIST=$$EXIST^VAQPST31(INSTALL)
 .;NEW ROUTINE DOES NOT EXIST
 .I ('EXIST) D  Q
 ..W !,?5,"Copying routine ",EXPORT," into ",INSTALL
 ..S TMP=$$COPY^VAQPST31(EXPORT,INSTALL,3)
 ..W ?50,$S('TMP:"Done",1:$C(7)_"** Error")
 .;GET LINE 2 OF EXISTING ROUTINE
 .S INSLN2=$$SECOND^VAQPST31(INSTALL,1)
 .;DETERMINE VERSION OF EXISTING ROUTINE (STRIP LEADING/LEADING ALPHAS)
 .S INSVER=$P(INSLN2,";",1)
 .S INSVER=$TR(INSVER," ","")
 .F SPOT=1:1:$L(INSVER) S TMP=$E(INSVER,SPOT) Q:((TMP?1N)!(TMP=""))
 .S INSVER=+$E(INSVER,SPOT,$L(INSVER))
 .S:((INSVER'?1.N1"."1.N)&(INSVER'?1.N)&(INSVER'?1"."1.N)) INSVER=""
 .I (INSVER="") D  Q
 ..W !,?5,$C(7),"** Could not determine if ",INSTALL," should be overwritten with ",EXPORT
 .;CHECK EXISTING VERSION AGAINST EXPORTED VERSION
 .I (INSVER>VERSION) D  Q
 ..W !,?5,"Copying of ",EXPORT," into ",INSTALL," not required"
 .I (INSVER<VERSION) D  Q
 ..W !,?5,"Copying routine ",EXPORT," into ",INSTALL
 ..S TMP=$$COPY^VAQPST31(EXPORT,INSTALL,3)
 ..W ?50,$S('TMP:"Done",1:$C(7)_"** Error")
 .;DETERMINE PATCHES APPLIED TO EXISTING ROUTINE (STRIP SPACES AND STARS)
 .S INSPAT=$P(INSLN2,";",3)
 .S INSPAT=$TR(INSPAT,"*","")
 .S INSPAT=$TR(INSPAT," ","")
 .;CHECK FOR PATCH INSTALLATIONS
 .S EXIST=0
 .I ((INSPAT'="")&(PATCHES'="")) D
 ..S PATCHES=","_PATCHES_","
 ..F SPOT=1:1:$L(INSPAT,",") D  Q:(EXIST)
 ...S TMP=$P(INSPAT,",",SPOT)
 ...Q:(TMP="")
 ...S TMP=","_TMP_","
 ...S:(PATCHES[TMP) EXIST=1
 ..S PATCHES=$P(PATCHES,",",2,($L(PATCHES,",")-1))
 .S:((INSPAT="")&(PATCHES="")) EXIST=1
 .I (EXIST) D  Q
 ..W !,?5,"Copying of ",EXPORT," into ",INSTALL," not required"
 .W !,?5,"Copying routine ",EXPORT," into ",INSTALL
 .S TMP=$$COPY^VAQPST31(EXPORT,INSTALL,3)
 .W ?50,$S('TMP:"Done",1:$C(7)_"** Error")
 W !!,?2,"Done",!!!
 Q
 ;
RTN ;ROUTINES TO INSTALL
 ;;VAQPSE01;GMTSPDX;2.5;8
 ;;VAQPSE02;IBAPDX;1.5;15
 ;;VAQPSE03;IBAPDX0;1.5;15
 ;;VAQPSE04;IBAPDX1;1.5;15
 ;;
 ;;
 ;FORMAT OF TEXT LINES
 ;  ;;EXPORT;INSTALL;VERSION;PATCHES
 ;
 ;   EXPORT - Routine name exported as (ex: VAQGMTS)
 ;   INSTALL - Routine name to install as (ex: GMTSPDX)
 ;   VERSION - Version number of exported routine (ex: 1.5)
 ;   PATCHES - List of patches that may have been applied
 ;             (ex: 1,2,3) (ex: 1)
 ;
 ;  Routine is installed if one of the following conditions is TRUE
 ;   1) The routine INSTALL does not exist
 ;   2) The routine INSTALL exists and
 ;      a) VERSION is greater or equal to version of existing routine
 ;      b) Patches to INSTALL do not include entries in PATCHES
 ;
