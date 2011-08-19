%ZOSVKSE ;OAK/KAK - Automatic INTEGRIT Routine (Cache) ;5/9/07  10:46
 ;;8.0;KERNEL;**90,94,197,268,456**;Jul 26, 2004
 ;
 ; Version for Cache
 ;
 Q
 ;
START(KMPSTEMP) ;-- called by routine CVMS+2^KMPSGE/CWINNT+1^KMPSGE in VAH
 ;
 ; KMPSTEMP... ^ piece 1: SiteNumber
 ;               piece 2: SessionNumber
 ;               piece 3: XTMP Global Location
 ;               piece 4: Current Date/Time
 ;               piece 5: Production UCI
 ;
 N DIRNAM,KMPSDT,KMPSERR,KMPSERR1,KMPSERR2,KMPSERR3,KMPSERR4
 N KMPSLOC,KMPSPROD,KMPSSITE,KMPSVOL,KMPSZU,NUM,X,VERSION,ZV
 ;
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERROR^%ZOSVKSE"
 E  S X="ERROR^%ZOSVKSE",@^%ZOSF("TRAP")
 ;
 S U="^",KMPSSITE=$P(KMPSTEMP,U),NUM=$P(KMPSTEMP,U,2),KMPSLOC=$P(KMPSTEMP,U,3)
 S KMPSDT=$P(KMPSTEMP,U,4),KMPSPROD=$P(KMPSTEMP,U,5),KMPSVOL=$P(KMPSTEMP,U,6)
 K KMPSTEMP
 S KMPSZU=$ZU(5)_","_KMPSVOL
 S ^XTMP("KMPS","START",KMPSVOL,NUM)=$H
 S VERSION=+($TR($E($ZV,38,43)," ",""))
 ;
UCI ;-- code from routine INTEGRIT/Integrity
 ;
 ; DIRNAM = directory name
 S DIRNAM=KMPSVOL
 ;
 S ZV=$E($ZV,1,17)
 I ZV="Cache for Windows" D UC1
 I ZV="Cache for OpenVMS" D UC1VMS
DONE ; normal exit
 C 63
 K ^XTMP("KMPS","START",KMPSVOL)
 Q
 ;
UC1 ;-- entry point for Cache NT
 ;   code from routine INTEGRIT
 ;
 N A,BLK,CUR,DIRSTAT,ERR,G,GLOBAL,J,LEV,LINK,LNB,LNBLK,LNBYTE,LSNP,LTOTBLK,LTOTBYTE
 N N,NB,NBLK,NBYTE,NP,RET,TL,TOTBLK,TOTBYTE
 ;
 ; prevent dismounted database
 S DIRSTAT=$P($ZU(49,DIRNAM),",",1)
 ; either dismounted or does not exist
 I DIRSTAT<0 D ERR G ERROR
 O 63:"^^"_DIRNAM
 D INTEG1
 I $G(GLOBAL(1))="" S ^XTMP("KMPS",KMPSSITE,NUM," NO GLOBALS ",KMPSVOL)="" Q
 D EV1
 Q
 ;
GLOCHK ;
 N GLOINFO,JRNL,PROT,PROTINFO
 ;
 ; these extra logic ideas are from routine %GD
 ; GLO = name ^ type ^ protection ^ growth_area ^ root_block (first pointer block) ^ journal ^ collate
 S PROT=$P(GLO,U,3),PROT(0)="N",PROT(1)="R",PROT(2)="RW",PROT(3)="RWD"
 ; protection - world ^ group ^ owner ^ network
 S PROTINFO=PROT(PROT\16#4)_U_PROT(PROT\4#4)_U_PROT(PROT#4)_U_PROT(PROT\64#4)
 S JRNL=$S($P(GLO,U,6):"Y",1:"N")
 ; global info = jrnl^collating^blank^growth area block^blank^protection:world^group^owner^network^first pointer block
 S GLOINFO=JRNL_U_$P(GLO,U,7)_"^^"_$P(GLO,U,4)_"^^"_PROTINFO_U_$P(GLO,U,5)
 ; end of extra logic ideas
 ;
 S TOTBLK=TOTBLK+1
 S G=$P(GLO,U,2,99),G=$P(G,U,4),LEV=1
 ;
 ; quit if global is implicit - do not process
 I G\256=65535 Q
 ;
 S X="ERRHND^%ZOSVKSE",@^%ZOSF("TRAP")
 S $ZE=""
 ;
B ; LEV(LEV) = root block
 S LEV(LEV)=G
 V G
 S A=$V(2043,0)
 ; find bottom level
 I A=2!(A=6) S G=$V(2,-5),LEV=LEV+1 G B
 ;
 S X="",@^%ZOSF("TRAP")
 ;
 ; W LEV_" Levels in this global"
 S (NBLK,LNBLK,NBYTE,LNBYTE)=0,CUR=1
 ; LEV(1) = first block number
 S ^XTMP("KMPS",KMPSSITE,NUM,KMPSDT,$P(GLO,U),KMPSZU)=LEV(1)_U_GLOINFO
C S BLK=LEV(CUR),RET="RETURN^"_$ZN
 ; W "Level: "_CUR_", "
 ;
 S X="ERRHND^%ZOSVKSE",@^%ZOSF("TRAP")
 ;
 D RESTART^%ZOSVKSS
 ;
 S X="",@^%ZOSF("TRAP")
 ;
 Q:+$G(^XTMP("KMPS","STOP"))
RETURN S TOTBLK=NP+TOTBLK,LTOTBLK=LTOTBLK+LSNP
 S TOTBYTE=TOTBYTE+NB,LTOTBYTE=LTOTBYTE+LNB
 I $ZE="" S CUR=CUR+1 I CUR<LEV G C
 ; W %TIM
 Q
ERRHND ; if there's an error from line tag B or from call
 ; to RESTART^%ZOSVKVSS come here and skip the rest      
 ; of this global
 S X="",@^%ZOSF("TRAP")
 Q
EV1 ;
 N GC,GLO,GS
 ;
 S (TOTBLK,LTOTBLK,TOTBYTE,LTOTBYTE,GC)=0
EV2 S GC=$O(GLOBAL(GC)),GS=1
 ;
 S ^XTMP("KMPS","START",KMPSVOL,NUM)=$H
 ;
 I GC=""!+$G(^XTMP("KMPS","STOP")) G EVL
EV3 S GLO=$P(GLOBAL(GC),",",GS)
 I GLO=""!+$G(^XTMP("KMPS","STOP")) G EVL
 I GLO="*" G EV2
 ; W "Global ^"_$P(GLO,U)
 D GLOCHK
 S GS=GS+1
 G EV3
EVL ; N TBLK
 ; S TBLK=TOTBLK+LTOTBLK
 ; W "Total global blocks in "_DIRNAM_" = "_TBLK
 ; W "Total efficiency = "
 ; I (TBLK) W ((TOTBYTE+LTOTBYTE)*100)\((2036*TOTBLK)+(2048*LTOTBLK))_"%"
 Q
ERR ;
 I DIRSTAT=-1 S KMPSERR1=DIRNAM_" is dismounted"
 I DIRSTAT=-2 S KMPSERR1=DIRNAM_" does not exist"
 ; set the error variable
 S $ZE="<UDIRECTORY>UC1+6^%ZOSVKSE"
 Q
 ;-- end code from routine INTEGRIT
 ;
INTEG1 ;-- code from routine INTEG1
 ;
 ; place global information into local variable GLOBAL array
 ; GLOBAL(1:C) = gbl_info1, gbl_info2, ... * (no '*' on last)
 ;    gbl_info = name ^ type ^ protection ^ growth_area ^ root_block (first pointer block) ^ journal ^ collate
 ;
 N %ST,A,C,END,G,GD,INFO,NAM,P
 ;
 K GLOBAL
 S C=1,GLOBAL(C)=""
 V 1
 D GFS^%ST
 ; obtain global directory (GD) from system table array (%ST)
 S GD=$V(%ST("GFOFFSET")+%ST("gfdir"),0,%ST("szdir")),G=0
B1 V GD
 S END=$V(2046,0,2),NAM="",P=0
 ;
NEXT G D1:END'>P
 ;
C1 ; build name
 S A=$V(P,0),P=P+1
 I A S NAM=NAM_$C(A) G C1
 ;
 ; info = type ^ protection ^ growth_area ^ root_block (first pointer block) ^ journal ^ collate
 S INFO=$V(P,0,"2O")_U_$V(P+2,0)_U_$V(P+3,0,"3O")_U_$V(P+6,0,"3O")_U_$V(P,0)_U_$V(P+1,0)
 ;
 ; one entry
 S GLOBAL=NAM_U_INFO
 I $L(GLOBAL(C))>460 S GLOBAL(C)=GLOBAL(C)_"*",C=C+1,GLOBAL(C)=""
 ;
 S GLOBAL(C)=GLOBAL(C)_GLOBAL_","
 ;
 S G=G+1,P=P+9,NAM="" G NEXT
D1 S GD=$V(2040,0,"3O") I GD G B1
 Q
 ;-- end code from routine INTEG1
 ;
ERROR ; ERROR - Tell all SAGG jobs to STOP collection
 ;
 C 63
 S KMPSERR="Error encountered while running SAGG collection routine for volume set "_$G(KMPSVOL)
 S KMPSERR2="Last global reference = "_$ZR
 S KMPSERR3="Error code = "_$$EC^%ZOSV
 I $D(KMPSERR4) S KMPSERR4="For more information, read text at line tag "_KMPSERR4_" in routine ^%ZOSVKSS"
 ;
 S ^XTMP("KMPS","ERROR",KMPSVOL)="",^XTMP("KMPS","STOP")=1
 K ^XTMP("KMPS","START",KMPSVOL)
 ;
 D ^%ZTER,UNWIND^%ZTER
 ;
 Q
 ;
UC1VMS ;-- entry point for Cache VMS
 ;   code from routine Integrity (Cache v4.1.16)
 ;
 N GLOARRAY,RC
 ;
 ; set up GLOARRAY array indexed by global name
 S RC=$$GETDIRGL^%ZOSVKSD(VERSION)
 ;
 I ('+RC) D ERRVMS G ERROR
 ;
 I '$D(GLOARRAY) S ^XTMP("KMPS",KMPSSITE,NUM," NO GLOBALS ",KMPSVOL)="" Q
 ;
 O 63:"^^"_DIRNAM
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
 .; return collation value for this global (GLO)
 .;S RC=$$GetCollationType^%DM(DIRNAM,GLO,.COLLATE)
 .;
 .; return protection value for this global (GLO)
 .;S RC=$$GetProtectState^%DM(DIRNAM,GLO,.PROTECT)
 .;I +RC D
 ..; protection - world ^ group ^ owner ^ network
 ..;S PROTINFO=PROT(PROTECT\16#4)_U_PROT(PROTECT\4#4)_U_PROT(PROTECT#4)_U_PROT(PROTECT\64#4)
 .;
 .; return top pointer block and first data block for this global (GLO)
 .;S RC=$$GetGlobalPointers^%DM(DIRNAM,GLO,.TPTRBLK,.FBLK)
 .;
 .;-- these extra logic ideas are from routine ^%GD
 .;   this code MUST use %utility($J) to properly work
 .;K ^%utility($J)
 .;
 .; $$Fetch^%GD is NOT a PUBLIC API
 .; <<< PUBLIC API $$GetJournalType^%DM did NOT work >>>
 .;I $$Fetch^%GD(GLO,1,0) D
 ..;S INFO=$G(^%utility($J,U_GLO))
 ..;Q:INFO=""
 ..;
 ..;S GRWBLK=$P(INFO,U,2)
 ..;S JRNL=$S($P(INFO,U,4):"Y",1:"N")
 ..;
 ..;K ^%utility($J)
 ..;-- end of extra logic ideas from routine ^%GD
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
 .; check integrity of a single global
 .; will stop if there are more than 999 errors with this global
 .S RC=$$GLOINTEG^%ZOSVKSD(VERSION)
 .;
 .K MSGLIST
 .D DCMPST^%ZOSVKSD(VERSION)
 .;
 .S (LEV,RC)=1
 .F I=1:1:MSGLIST D
 ..S INFO=MSGLIST(I),BLK=$$BLK(INFO),EFF=$$EFF(INFO)
 ..;
 ..; more than 999 errors reported
 ..I INFO["***Further checking of this global is aborted." S RC=0 D ERRVMS1 Q
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
 I '+RC S KMPSERR1="ERROR: Cannot find global names for "_DIRNAM
 Q
 ;
ERRVMS1 ;
 S $ZE="<ERROR>ALLGLO+50^%ZOSVKSE"
 S KMPSERR1="ERROR: Over 999 integrity errors with ^"_GLO_" in "_DIRNAM
 Q
