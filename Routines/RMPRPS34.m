RMPRPS34 ;HISC/RVD/HNC -Check 661.1 and Save Inventory flag ;9/2/04  12:13
 ;;3.0;PROSTHETICS;**34,39,48,58,64,69,76,84,91,154**;FEB 09,1996;Build 6
 ;RVD patch #76 - 2003 HCPCS update
 ;                replace inactive CPT Code in #660, starting 1/1/03
 ;
 ;AAC Patch #84 - 2004 HCPCS Update
 ;                Replace all CPT Codes with pointer 104840 - code A9900 1/1/04
 ;                Update all Modifier codes with null
 ;
 ;HNC Patch #91 - 2004 HCPCS Update - 6/2004
 ;                Convert R10 to R10 A
 Q
EN ;entry point
 S U="^",RMEXIT=0
 ;Check on 2907, shipping and null 2804 (patch 48)
 ;Check on 2972, shipping and null 2973 (patch 58)
 ;Check on 3475, shipping and null 3476 (patch 69)
 ;Check on 3915 for patch 84.
 ;check for the last entry and next available entry.
 ;
 ;Patch 76
 ;Wheelchair HCPCS not grouped together prior to calculation flag update.
 ;hnc/April 2003
 ;Wheelchair HCPCS list under HLST
 ;
 S RM661=$P($G(^RMPR(661.1,0)),U,3) D:RM661'=3915!($D(^RMPR(661.1,3916)))  G:$G(RMEXIT) EXIT
 . W !,"*********************************************************"
 . W !,"* Your RMPR(661.1 global is CORRUPTED,  DO NOT INSTALL  *"
 . W !,"* the new RMPR(661.1 global.  Please, contact           *"
 . W !,"* National IRM Help Desk at 1-888-596-4357 for HELP!!!! *"
 . W !,"*********************************************************",!
 . H 1 S RMEXIT=1
 . Q
 ;
 ; Continue with post init...
SAVE W !,"Saving Inventory Data ...."
 K RM0
 K ^RMPR("INV")
 S BDC=0
 F  S BDC=$O(^RMPR(661.1,BDC)) Q:'+BDC  D
 . S RM0=$P(^RMPR(661.1,BDC,0),U,9)
 . Q:RM0=""
 . S ^RMPR("INV",BDC)=1
 . Q
 W !,"Done Saving Inventory Data, please load the ^RMPR(661.1) global now"
 W !,"File RMPR_3_84.GBL",!
 K RM661,RMEXIT,RM0,BDC
 Q
 ;
RESET W !,"Start Reset of the Inventory flag...."
 S U="^"
 S BDC=0
 F  S BDC=$O(^RMPR("INV",BDC)) Q:BDC'>0  D
 . S $P(^RMPR(661.1,BDC,0),U,9)=1
 . Q
 W !!,"End Reset of the Inventory flag.",!
 ;
 ; Patch 58 - call utilities to merge duplicate HCPCS and replace
 ;            DVG specified old HCPCS with new HCPCS
 ; ********** Remove or update this call for the next HCPCS update
 ;D PATCH58^RMPRPS35
 ; Patch 69 - replace specified deactivated HCPCS with new HCPCS.
 ;
 ;conversion for site with patch #61
 I $D(^RMPR(661.6)),$D(^RMPR(661.7)),$D(^RMPR(661.9)) D CONV^RMPRPS36
 ;conversion for site without patch #61
 I '$D(^RMPR(661.6)),'$D(^RMPR(661.7)),'$D(^RMPR(661.9)) D PAT76^RMPRPS35
 ;
UPCPT ;update Inactive CPT code starting 4/1/02
 W !,"Start Converting Inactive CPT code....",!
 K RMUPD
 S U="^"
 F ROI=3031231:0 S ROI=$O(^RMPR(660,"B",ROI)) Q:ROI'>0  F ROJ=0:0 S ROJ=$O(^RMPR(660,"B",ROI,ROJ)) Q:ROJ'>0  S RM0=$G(^RMPR(660,ROJ,0)) D 
 .S RMCPI=$P(RM0,U,22)
 .Q:'$G(RMCPI)
 .S RM60=ROJ
 .S RMCPT="104840"
 .S RMUPD(660,RM60_",",4.1)=RMCPT
 .D FILE^DIE("","RMUPD","")
 K RMUPD,ROI,ROJ,RMCPT,RMCPI,RM0,RM60
 W !,"Done Converting Inactive CPT code....",!
 ;
DUP ;repoint duplicate HCPCS (660, 664, 664.1, 665, 661.2, 661.3 
 ;and delete from file 661.1
 ;D HCPCD^RMPRPS35(113,952)
 ;convert amis grouper for entries w/ wheelchair hcpcs.
 ;D WHUP
 ;
KILLB ;kill & set 'B' cross reference in 661.1.
 K ^RMPR(661.1,"B"),DIK
 S DIK="^RMPR(661.1,",DIK(1)=".01^B" D ENALL^DIK
 ;
 ;
KILLC ;kill & set 'C' cross reference in 661.1.
 K ^RMPR(661.1,"C"),DIK
 S DIK="^RMPR(661.1,",DIK(1)=".02^C" D ENALL^DIK
 ;
KILLE ;kill & set 'E' cross reference in 661.1.
 K ^RMPR(661.1,"E"),DIK
 ; Line below commented out for Patch 84 - Multi-index Lookup for "A9900"
 ; S DIK="^RMPR(661.1,",DIK(1)="2^E" D ENALL^DIK K DIK
 ;
 W !,"Done with Installation of Patch RMPR*3*84"
 ;
EXIT ;EXIT
 K ^RMPR("INV"),^RMPR(661.1,"RMPR"),I,RMEXIT,RM661,BDC
 Q
 ; Patch 64 Fixes to HCPCS file
PAT64 N RMPR,RMPRFME,RMPRI,RMPR11,I
 ;
 ; Change NPPD NEW CODE
 S RMPR11("D5924")=""
 S RMPR11("D5934")=""
 S RMPR11("L8500")=""
 S RMPR11("L8501")=""
 S RMPR11("L8614")=""
 S RMPR11("L8619")=""
 S I="" F  S I=$O(RMPR11(I)) Q:I=""  D
 .S RMPRI=$O(^RMPR(661.1,"B",I,""))
 .Q:RMPRI=""
 .S RMPRI=RMPRI_","
 .S RMPR(661.1,RMPRI,6)="960 A"
 .D FILE^DIE("","RMPR","RMPRFME")
 .W !,"HCPCS ",I," updated"
 W !!,"Done HCPCS update!!!"
 W !!,"Start Reindexing the 'B' cross reference of file #661.1 ..."
 K ^RMPR(661.1,"B")
 S DIK="^RMPR(661.1,",DIK(1)=".01^B" D ENALL^DIK
 W !!,"Done Reindexing file #661.1!!!",!!
PAT64X Q
WHUP ;Wheelchair Update Record with new Grouper Number
 ;
 Q  ;DO NOT RUN
 N RMPRI,RMPR,RMPRFME,RMPRY,RMPRPH,RMPRPHE,RMPRPHL,RMPRG,RMPRSTN,RMPRSITE
 ;loop H xref PSAS HCPCS
 S RMPRPH=0
 F  S RMPRPH=$O(^RMPR(660,"H",RMPRPH)) Q:RMPRPH'>0  D
 .S RMPRPHE=$P($G(^RMPR(661.1,RMPRPH,0)),U,1)
 .;RMPRPHE external psas hcpcs file 660
 .Q:RMPRPHE=""
 .S RMPRI=""
 .F RMPRI=1:1:58 S RMPRY=$P($T(HLST+RMPRI),";",3) D
 ..Q:RMPRY=""
 ..;RMPRY is wheelchair hcpcs
 ..Q:RMPRY'=RMPRPHE
 ..;hcpcs to update records
 ..S RMPRPHL=0
 ..F  S RMPRPHL=$O(^RMPR(660,"H",RMPRPH,RMPRPHL)) Q:RMPRPHL'>0  D
 ...;record level
 ...;need site param and grouper number
 ...;field 8 station p4 translate to 699.9 rmprsite
 ...Q:'$D(^RMPR(660,RMPRPHL,0))
 ...S RMPRSTN=$P(^RMPR(660,RMPRPHL,0),U,10)
 ...Q:RMPRSTN=""
 ...S RMPRSITE=0
 ...S RMPRSITE=$O(^RMPR(669.9,"C",RMPRSTN,RMPRSITE))
 ...Q:RMPRSITE=""
 ...L +^RMPR(669.9,RMPRSITE,0):9999 I $T=0 S RMPRG=8822
 ...S RMPRG=$P(^RMPR(669.9,RMPRSITE,0),U,7),RMPRG=RMPRG-1,$P(^RMPR(669.9,RMPRSITE,0),U,7)=RMPRG L -^RMPR(669.9,RMPRSITE,0)
 ...S RMPRPHLL=RMPRPHL_","
 ...S RMPR(660,RMPRPHLL,68)=RMPRG
 ...D FILE^DIE("","RMPR","RMPRFME")
 Q
KILLNDS ;
 F L=0:0 S PD=$O(^RMPR(661.1,L)) W !,PD,"   ",L Q:L=""
 Q
P91 ;Patch 91
 S RMPRI=""
 F RMPRI=1:1:56 S RMPRY=$P($T(HLST+RMPRI),";",3) D
 .S $P(^RMPR(661.1,RMPRY,0),U,6)="R10 A"
 S $P(^RMPR(661.1,2763,0),U,6)="R10 B"
 S $P(^RMPR(661.1,2770,0),U,6)="R10 B"
 S $P(^RMPR(661.1,2864,0),U,7)="960 D"
 W !,"ALL DONE"
 K RMPRI,RMPRY
 Q
HLST ;Wheelchair IEN to update to R10 A
 ;;245
 ;;246
 ;;249
 ;;252
 ;;254
 ;;340
 ;;341
 ;;342
 ;;344
 ;;346
 ;;348
 ;;351
 ;;354
 ;;359
 ;;360
 ;;363
 ;;364
 ;;365
 ;;366
 ;;367
 ;;368
 ;;369
 ;;370
 ;;371
 ;;372
 ;;373
 ;;374
 ;;386
 ;;387
 ;;392
 ;;393
 ;;395
 ;;396
 ;;400
 ;;401
 ;;417
 ;;418
 ;;426
 ;;427
 ;;438
 ;;439
 ;;445
 ;;447
 ;;453
 ;;2095
 ;;2096
 ;;2097
 ;;2099
 ;;2100
 ;;2101
 ;;2102
 ;;2103
 ;;2104
 ;;2790
 ;;2791
 ;;3591
 ;end
