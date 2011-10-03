PXKMAIN1 ;ISL/JVS,ISA/Zoltan - Main Routine for Data Capture ;5/6/1999
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**22,73,124,178**;Aug 12, 1996
 ;+This routine is responsible for:
 ;+ - creating new entries in PCE files,
 ;+ - processing modifications to existing entries,
 ;+ - deleting entries,
 ;+ - ensuring all required variables are present,
 ;+ - setting both Audit fields (EDITED FLAG and AUDIT TRAIL),
 ;+ - checking for duplicate entries,
 ;+ - some error reporting.
 ;+
 ;+LOCAL VARIABLE LIST
 ;+ MOST VARIABLES ARE DEFINED AT THE TOP OF  PXKMAIN
 ;+ PXKSEQ   = Sequence number in PXK tmp global
 ;+ PXKCAT   = Category of entry (CPT,MSR,VST...)
 ;+ PXKREF   = Root of temp global
 ;+ PXKPIEN  = IEN of v file
 ;+ PXKAUDIT = data located in the audit field of the v file
 ;+ PXKER    = field data use to build the dr string (eg .04///^S X=$G()
 ;+ PXKFLD   = field number gleened from the file routines
 ;+ PXKNOD   = same as the subscript in a global node
 ;+ PXKPCE   = the piece where the data is found on that node
 ;
 ;
 W !,"This is not an entry point" Q
LOOP ;+Copy delimited strings into sub-arrays.
 F PXKI=1:1:$L(PXKAFT(PXKSUB),"^") I $P(PXKAFT(PXKSUB),"^",PXKI)'="" S PXKAV(PXKSUB,PXKI)=$P(PXKAFT(PXKSUB),"^",PXKI)
 F PXKI=1:1:$L(PXKBEF(PXKSUB),"^") I $P(PXKBEF(PXKSUB),"^",PXKI)'="" S PXKBV(PXKSUB,PXKI)=$P(PXKBEF(PXKSUB),"^",PXKI)
 K PXKI,PXKJ ; Not sure if NEW would be OK.
 I PXKCAT="CPT",PXKSUB=1 D LOOP^PXKMOD
 Q
 ;
ERROR ;+Check for missing required fields
 Q:$G(PXKAV(0,1))["@"!('$D(PXKAV(0,1)))
 S PXKNOD=0,PXKPCE=0
 D EN1^@PXKRTN
 S PXKER=$P(PXKER," * ",1)
 I PXKER="" Q
 F PXJ=1:1:$L(PXKER,",") D
 . S PXJJ=$P(PXKER,",",PXJ)
 . I '$D(PXKAV(PXKNOD,PXJJ)) D
 . . S PXKPCE=PXJJ
 . . D EN2^@PXKRTN
 . . S PXKFLD=$P(PXKFD,"/",1)
 . . S:PXKFLD["*" PXKFLD=$P(PXKFLD," * ",2)
 . . S PXKERROR(PXKCAT,PXKSEQ,0,PXKFLD)="Missing Required Fields"
 K PXK,PXJJ,PXKFLD,PXKFD ; Not sure about use of NEW here.
 Q
 ;
CLEAN ;--Clean out the PXKAV array
 S PXKJ=""
 F  S PXKJ=$O(PXKBV(PXKJ)) Q:PXKJ=""  D
 . S PXKI=""
 . F  S PXKI=$O(PXKBV(PXKJ,PXKI)) Q:PXKI=""  D
 . . I $G(PXKBV(PXKJ,PXKI))=$G(PXKAV(PXKJ,PXKI)) K PXKAV(PXKJ,PXKI)
 K PXKI,PXKJ ; Not sure about NEW here.
 Q
 ;
FILE ;+Create a new entry in file and get IEN
 ;+This is the code that adds new entries to V-files
 ;+and to the Visit file.
 K DD,DO
 S DIC=$P($T(GLOBAL^@PXKRTN),";;",2)_"("
 S DIC(0)=""
 S X=$G(PXKAV(0,1))
 D FILE^DICN
 S (PXKPIEN,DA)=+Y
 S DR=""
 K DIC,Y,X
 Q
 ;
AUD12 ;--Set both audit fields
 S DR=""
 S PXKAUDIT=$P($T(GLOBAL^@PXKRTN),";;",2)_"(DA,801)"
 S PXKAUDIT=$P($G(@PXKAUDIT),"^",2)_PXKSORR_";"
 I $L(PXKAUDIT,";")>5 S $P(PXKAUDIT,";",2,$L(PXKAUDIT,";"))="+;"_$P(PXKAUDIT,";",4,$L(PXKAUDIT,";")) ;PX*1*124   Change 8 to 5
 S PXKNOD=801
 S DR=""
 F PXKPCE=1,2 D EN1^@PXKRTN S DR=DR_PXKER
 S PXKFVDLM=""
 Q
 ;
AUD2 ;--Set second audit fields
 S DR=""
 S PXKAUDIT=$P($T(GLOBAL^@PXKRTN),";;",2)_"(DA,801)"
 S PXKAUDIT=$P($G(@PXKAUDIT),"^",2)_PXKSORR_";"
 I $L(PXKAUDIT,";")>5 S $P(PXKAUDIT,";",2,$L(PXKAUDIT,";"))="+;"_$P(PXKAUDIT,";",4,$L(PXKAUDIT,";")) ;PX*1*124   Change 8 to 5
 S PXKNOD=801
 S DR=""
 S PXKPCE=2
 D EN1^@PXKRTN
 S DR=DR_PXKER
 S PXKFVDLM=""
 Q
 ;
DRDIE ;--Set the DR string and DO DIE
 I PXKCAT="VST" D UPD^PXKFVST Q
 S DIE=$P($T(GLOBAL^@PXKRTN),";;",2)_"(" K PXKPTR
 S PXKLR=$P($T(GLOBAL^@PXKRTN),";;",2)_"(DA)"
 S PXKNOD=""
 F  S PXKNOD=$O(PXKAV(PXKNOD)) Q:PXKNOD=""  D
 . I PXKFGAD=1,PXKNOD=0 S PXKPCE=1 D
 .. Q:PXKCAT'="CPT"
 .. I $G(^TMP("PXK",$J,PXKCAT,PXKSEQ,"IEN"))=PXKPIEN S PXKPCE=3
 . I PXKFGAD=1,PXKNOD'=0 S PXKPCE=0
 . I PXKFGED=1 S PXKPCE=0
 . I PXKCAT="CPT",PXKNOD=1 D  Q
 .. D DIE
 .. I $G(^TMP("PXK",$J,PXKCAT,PXKSEQ,"IEN"))]"" Q
 .. D UPD^PXKMOD
 . F  S PXKPCE=$O(PXKAV(PXKNOD,PXKPCE)) Q:PXKPCE=""  D
 ..D EN1^@PXKRTN
 ..I $G(PXKER)'="" D
 ...I PXKER["~" D
 ....I $P(PXKER,"~",2)["A",PXKFGAD=1 S PXKER=$P(PXKER,"~") Q
 ....I $P(PXKER,"~",2)'["A",PXKFGAD=1 S PXKER="" Q
 ....I $P(PXKER,"~",2)["E",PXKFGED=1 S PXKER=$P(PXKER,"~") Q
 ....I $P(PXKER,"~",2)'["E",PXKFGED=1 S PXKER="" Q
 ...I +PXKER=0 D
 ....I PXKAV(PXKNOD,PXKPCE)=+PXKAV(PXKNOD,PXKPCE) S PXKER=$P(PXKER," * ",2)
 ....I PXKAV(PXKNOD,PXKPCE)'=+PXKAV(PXKNOD,PXKPCE) S PXKER=$P(PXKER," * ",3),PXKPTR(PXKPIEN,PXKNOD,PXKPCE)=""
 ..I $G(PXKER)'="" S DR=DR_PXKER_"PXKAV("_PXKNOD_","_PXKPCE_"));"
 ..I $L(DR)>200 D DIE
 D DIE
 K DIE,PXKLR,DIC(0)
 D ER
 Q
DIE ;+Lock global and invoke FM ^DIE call.
 L +@PXKLR:10
 D ^DIE
 L -@PXKLR
 K DR
 S DR=""
 Q
 ;
DELETE ;+Use FM ^DIK call to delete entry identified by PXKPIEN.
 S DA=PXKPIEN
 S DIK=$P($T(GLOBAL^@PXKRTN),";;",2)_"("
 D ^DIK
 K DIK
 Q
 ;
DUP ;+Code to check for duplicates
 I PXKCAT="VST" Q
 I PXKCAT="CPT" Q
 I PXKCAT="HF" Q
 N PXKRTN
 I '$D(PXKPIEN) N PXKPIEN S PXKPIEN=""
 S PXKNOD=0
 S PXKPCE=0
 S PXKRTN="PXKF"_PXKVCAT
 S PXKVRTN=$P($T(GLOBAL^@PXKRTN),";;",2)
 S PXJJJ=0
 D EN1^@PXKRTN
 I $P(PXKER," * ",3)'=0 D
 .S PXKER=$P(PXKER," * ",2)
 .I PXKER="" Q
 .S (PX,PXFG)=0
 .F  S PX=$O(@PXKVRTN@("AD",PXKVST,PX)) Q:PX=""  D  Q:PXFG=1
 ..S PXJJJ=0
 ..F PXJ=1:1:$L(PXKER,",") S PXJJ=$P(PXKER,",",PXJ) D
 ...I $P($G(@PXKVRTN@(PX,$P(PXJJ,"+",1))),"^",$P(PXJJ,"+",2))=$G(PXKAV($P(PXJJ,"+",1),$P(PXJJ,"+",2))),PX'=PXKPIEN S PXJJJ=PXJJJ+1
 ..I $L(PXKER,",")=PXJJJ S PXFG=1
 ;PXKHLR Is not killed because it is a flag comming from another routine
 Q
 ;
ER ;--PXKERROR MAKING IF NOT POPULATED CORRECTLY
 N PXKRT,PXKMOD,PXKSTR
 S PXKMOD=PXKSEQ#1 I $G(PXKMOD) Q
 S PXKN=""
 F  S PXKN=$O(PXKAV(PXKN)) Q:PXKN=""  D
 . S PXKP=""
 . F  S PXKP=$O(PXKAV(PXKN,PXKP)) Q:PXKP=""  D
 .. S PXKRRT=$P($T(GLOBAL^@PXKRTN),";;",2)_"("_DA_","
 .. I PXKN=1,PXKCAT="CPT" S PXKRRT=PXKRRT_PXKN_","_PXKP_","_0_")"
 .. E  S PXKRRT=PXKRRT_PXKN_")"
 .. I PXKAV(PXKN,PXKP)'=$P($G(@PXKRRT),"^",$S(PXKN=1:1,1:PXKP)) D
 ... Q:PXKAV(PXKN,PXKP)["@"
 ... S PXKNOD=PXKN,PXKPCE=PXKP
 ... I PXKNOD=1,PXKCAT="CPT" S PXKPCE=1
 ... D EN2^@PXKRTN
 ... S PXKFLD=$P(PXKFD,"/",1)
 ... S:PXKFLD["*" PXKFLD=$P(PXKFLD," * ",2)
 ... Q:PXKFLD=1101
 ... S PXKSTR="Not Stored = "_PXKAV(PXKN,PXKP)
 ... I $G(PXKERROR(PXKCAT,PXKSEQ,DA,PXKFLD))]"" D
 .... S PXKSTR=PXKERROR(PXKCAT,PXKSEQ,DA,PXKFLD)_","_PXKAV(PXKN,PXKP)
 ... S PXKERROR(PXKCAT,PXKSEQ,DA,PXKFLD)=PXKSTR
 Q
