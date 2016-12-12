%ZOSVKSE ;OAK/KAK/RAK/JML - ZOSVKSOE - Global data (Cache) ;9/1/2015
 ;;8.0;KERNEL;**90,94,197,268,456,568**;Jul 26, 2004;Build 48
 ;
 Q
 ;
START(KMPSTEMP) ;-- called by routine CVMS+2^KMPSGE/CWINNT+1^KMPSGE in VAH
 ;------------------------------------------------------------------------
 ; KMPSTEMP... ^ piece 1: SiteNumber
 ;               piece 2: SessionNumber
 ;               piece 3: XTMP Global Location
 ;               piece 4: Current Date/Time
 ;               piece 5: Production UCI
 ;               piece 6: Volume set
 ;-------------------------------------------------------------------------
 ;
 Q:$G(KMPSTEMP)=""
 ;
 N KMPSDT,KMPSERR,KMPSERR1,KMPSERR2,KMPSERR3,KMPSERR4
 N KMPSLOC,KMPSPROD,KMPSSITE,KMPSVOL,KMPSZU,NUM,X,VERSION,ZV
 ;
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERROR^%ZOSVKSE"
 E  S X="ERROR^%ZOSVKSE",@^%ZOSF("TRAP")
 ;
 S U="^",KMPSSITE=$P(KMPSTEMP,U),NUM=$P(KMPSTEMP,U,2),KMPSLOC=$P(KMPSTEMP,U,3)
 S KMPSDT=$P(KMPSTEMP,U,4),KMPSPROD=$P(KMPSTEMP,U,5),KMPSVOL=$P(KMPSTEMP,U,6)
 K KMPSTEMP
 S KMPSZU=$ZNSPACE_","_KMPSVOL
 S ^XTMP("KMPS","START",KMPSVOL,NUM)=$H
 S VERSION=$$VERSION^%ZOSV ; IA# 10097
 I VERSION<2008 D DONE Q
 ;
 ; version
 S ZV=$P($$VERSION^%ZOSV(1),"/")  ; IA# 10097
 ;
 ; check for accepted operating system
 Q:'$$OSOKAY(ZV)
 ;
 D ALLOS
 ;
DONE ; normal exit
 ;
 K ^XTMP("KMPS","START",KMPSVOL)
 ;
 Q
 ;
ALLOS ;-- entry point now for all OS's
 ;
 N GLOARRAY,RC
 ;
 ; set up GLOARRAY array indexed by global name
 S RC=$$GetDirGlobals^%SYS.DATABASE(KMPSVOL,.GLOARRAY)
 ;
 I ('+RC) D ERRVMS G ERROR
 ;
 I '$D(GLOARRAY) S ^XTMP("KMPS",KMPSSITE,NUM," NO GLOBALS ",KMPSVOL)="" Q
 ;
 D ALLGLO
 ;
 Q
 ;
ALLGLO ;- collect global info
 ;
 N COLLATE,DATASIZE,FBLK,GLO,GLOINFO,GLOTOTBLKS,GLOPNTBLKS,GLOTOTBYTES
 N GLOPNTBYTES,GLOBIGBLKS,GLOBIGBYTES,GLOBIGSTRINGS,GRWBLK
 N I,INFO,JRNL,LEV,MSGLIST,PROT,PROTECT,PROTINFO,RC,TPTRBLK,TRY
 ;
 S GLO="",RC=1
 S PROT(0)="N",PROT(1)="R",PROT(2)="RW",PROT(3)="RWD"
 ;
 F  S GLO=$O(GLOARRAY(GLO)) Q:GLO=""!+$G(^XTMP("KMPS","STOP"))  D  Q:+$G(^XTMP("KMPS","STOP"))!('+RC)
 .;
 .S (COLLATE,FBLK,GRWBLK,JRNL,PROTECT,TPTRBLK)=""
 .S PROTINFO="^^^"
 .;
 .; global info - '^' delimited
 .;         piece 1: first block
 .;         piece 2: jrnl^collate
 .;         piece 3: bits(blank)
 .;         piece 4: growth area block
 .;         piece 5: protection:system(blank)
 .;         piece 6: protection:world
 .;         piece 7: group^owner
 .;         piece 8: network^top (first) pointer block
 .S GLOINFO=FBLK_U_JRNL_U_COLLATE_"^^"_GRWBLK_"^^"_PROTINFO_U_TPTRBLK
 .;
 .S ^XTMP("KMPS",KMPSSITE,NUM,KMPSDT,GLO,KMPSZU)=GLOINFO
 .;
 .; get global total blocks.... GLOTOTBLKS
 .;     global pointer blocks.. GLOPNTBLKS
 .;     global total bytes..... GLOTOTBYTES
 .;     global pointer bytes... GLOPNTBYTE
 .;     global big blocks...... GLOBIGBLKS
 .;     global big bytes....... GLOBIGBYTES
 .;     global big strings..... GLOBIGSTRINGS
 .;     data size.............. DATASIZE
 .; will stop if there are more than 999 errors with this global
 .S RC=$$CheckGlobalIntegrity^%SYS.DATABASE(KMPSVOL,GLO,999,.GLOTOTBLKS,.GLOPNTBLKS,.GLOTOTBYTES,.GLOPNTBYTES,.GLOBIGBLKS,.GLOBIGBYTES,.GLOBIGSTRINGS,.DATASIZE)
 .;
 .K MSGLIST
 .D DecomposeStatus^%SYS.DATABASE(RC,.MSGLIST,0,"")
 .;
 .S (LEV,RC)=1
 .F I=1:1:MSGLIST D
 ..S INFO=MSGLIST(I),BLK=$$BLK(INFO),EFF=$$EFF(INFO)
 ..;
 ..; more than 999 errors reported
 ..I INFO["***Further checking of this global is aborted." S RC=0 D ERRVMS Q
 ..;
 ..I ($P(INFO,":")["Top Pointer Level")!($P(INFO,":")["Top/Bottom Pnt Level") D  Q
 ...S ^XTMP("KMPS",KMPSSITE,NUM,GLO,KMPSZU,KMPSDT,1)=BLK_"^"_EFF_"%^Pointer"
 ..I $P(INFO,":")["Pointer Level" D  Q
 ...S LEV=LEV+1,^XTMP("KMPS",KMPSSITE,NUM,GLO,KMPSZU,KMPSDT,LEV)=BLK_"^"_EFF_"%^Pointer"
 ..I $P(INFO,":")["Bottom Pointer Level" D  Q
 ...S LEV=LEV+1,^XTMP("KMPS",KMPSSITE,NUM,GLO,KMPSZU,KMPSDT,LEV)=BLK_"^"_EFF_"%^Bottom pointer"
 ..I $P(INFO,":")["Data Level" D  Q
 ...S ^XTMP("KMPS",KMPSSITE,NUM,GLO,KMPSZU,KMPSDT,"D")=BLK_"^"_EFF_"%^Data"
 ..I $P(INFO,":")["Big Strings" D  Q
 ...S ^XTMP("KMPS",KMPSSITE,NUM,GLO,KMPSZU,KMPSDT,"L")=BLK_"^"_EFF_"%^LongString"
 ;
 I ('+RC) G ERROR
 ;
 Q
 ;
BLK(STRNG)      ;-- function to obtain number of blocks from input string
 ;
 N BLK
 Q:$G(STRNG)="" ""
 S BLK=$$NOCOMMA($P($P(STRNG,"=",2)," "))
 Q BLK
 ;
EFF(STRNG)      ;-- function to obtain efficiency from input string
 ;
 N EFF
 Q:$G(STRNG)="" ""
 S EFF=$P($P(STRNG,"%"),"(",2)
 Q EFF
 ;
NOCOMMA(IN)     ;-- strip comma from input string
 ;
 Q $TR(IN,",","")
 ;
ERRVMS ;
 S $ZE="<ERROR>UC1VMS+6^%ZOSVKSE"
 I '+RC S KMPSERR1="ERROR: Cannot find global names for "_KMPSVOL
 Q
 ;
OSOKAY(ZV) ;-- extrinsic function - operating system ok for SAGG
 ;---------------------------------------------------------------
 ; ZV - Operating system
 ;
 ; Return: 1 - os is okay for sagg
 ;         "" - os not okay
 ;---------------------------------------------------------------
 ;
 Q:$G(ZV)="" ""
 Q:ZV="Cache for OpenVMS" 1
 Q:$E(ZV,1,14)="Cache for UNIX" 1
 Q:$E(ZV,1,17)="Cache for Windows" 1
 Q ""
 ;
ERROR ; ERROR - Tell all SAGG jobs to STOP collection
 ;
 C 63
 S KMPSERR="Error encountered while running SAGG collection routine for volume set "_$G(KMPSVOL)
 S KMPSERR2="Last global reference = "_$ZR
 S KMPSERR3="Error code = "_$$EC^%ZOSV ; IA# 10097
 I $D(KMPSERR4) S KMPSERR4="For more information, read text at line tag "_KMPSERR4_" in routine ^%ZOSVKSS"
 ;
 S ^XTMP("KMPS","ERROR",KMPSVOL)="",^XTMP("KMPS","STOP")=1
 K ^XTMP("KMPS","START",KMPSVOL)
 ;
 D ^%ZTER,UNWIND^%ZTER
 ;
 Q
