PXKMAIN1 ;ISL/JVS,ISA/Zoltan - Main Routine for Data Capture ;Jul 26, 2021@09:35:17
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**22,73,124,178,210,216,211,217**;Aug 12, 1996;Build 134
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
 ;+ PXKSEQ   = Sequence number in PXK TMP global
 ;+ PXKCAT   = Category of entry (CPT,MSR,VST...)
 ;+ PXKREF   = Root of temp global
 ;+ PXKPIEN  = IEN of v file
 ;+ PXKAUDIT = data located in the audit field of the v file
 ;+ PXKER    = field data use to build the DR string (e.g., .04///^S X=$G()
 ;+ PXKFLD   = field number gleaned from the file routines
 ;+ PXKNOD   = same as the subscript in a global node
 ;+ PXKPCE   = the piece where the data is found on that node
 ;
 ;
 W !,"This is not an entry point" Q
LOOP ;+Copy delimited strings into sub-arrays. PXKSUB is the node.
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
 N PXJ,PXKFD,PXKFLD
 F PXJ=1:1:$L(PXKER,",") D
 . S PXJJ=$P(PXKER,",",PXJ)
 . I '$D(PXKAV(PXKNOD,PXJJ)) D
 .. S PXKPCE=PXJJ
 .. D EN2^@PXKRTN
 .. S PXKFLD=$P(PXKFD,"/",1)
 .. S:PXKFLD["*" PXKFLD=$P(PXKFLD," * ",2)
 .. S PXKERROR(PXKCAT,PXKSEQ,0,PXKFLD)="Missing Required Fields"
 Q
 ;
CLEAN ;--Clean out the PXKAV array
 S PXKJ=""
 F  S PXKJ=$O(PXKBV(PXKJ)) Q:PXKJ=""  D
 . I PXKCAT="IMM",PXKJ?1(1"2",1"3",1"11") D CLEAN^PXKIMM(PXKJ) Q
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
 I PXKCAT="IMM",PXKPIEN S PXVNEWIM=PXKPIEN S:$D(PXVNEWDA) PXVNEWDA=PXKPIEN ; PX*1*210
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
 I PXKCAT="IMM" D TMSTAMP
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
 I PXKCAT="IMM" D TMSTAMP
 S PXKFVDLM=""
 Q
 ;
TMSTAMP ; set Timestamp
 S PXKNOW=$$NOW^XLFDT
 S PXKNOD=12
 S PXKPCE=21
 D EN1^@PXKRTN
 S DR=DR_PXKER
 Q
 ;
DRDIE ;--Set the DR string and DO DIE
 I PXKCAT="VST" D UPD^PXKFVST Q
 ;
 S DIE=$P($T(GLOBAL^@PXKRTN),";;",2)_"(" K PXKPTR
 S PXKLR=$P($T(GLOBAL^@PXKRTN),";;",2)_"(DA)"
 ;
 S PXKNOD=""
 F  S PXKNOD=$O(PXKAV(PXKNOD)) Q:PXKNOD=""  D
 . I PXKFGAD=1,PXKNOD=0 S PXKPCE=1 D
 .. Q:PXKCAT'="CPT"
 .. I $G(^TMP("PXK",$J,PXKCAT,PXKSEQ,"IEN"))=PXKPIEN S PXKPCE=3
 . I PXKFGAD=1,PXKNOD'=0 S PXKPCE=0
 . I PXKFGED=1 S PXKPCE=0
 . I PXKCAT="CPT",PXKNOD=1 D  Q
 .. D DIE
 .. ;I $G(^TMP("PXK",$J,PXKCAT,PXKSEQ,"IEN"))]"" Q
 .. D UPD^PXKMOD(PXKPIEN)
 . ;
 . I PXKCAT="IMM",PXKNOD?1(1"2",1"3",1"11") D DIE^PXKIMM Q
 . ;
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
 ;
DIE ;Invoke FM ^DIE call.
 D ^DIE
 K DR
 S DR=""
 Q
 ;
DELETE ;+Use FM ^DIK call to delete entry identified by PXKPIEN.
 ;
 ; Make a copy of entry before deleting it
 I $T(DELGBL^@PXKRTN)'="" D COPYDEL
 ;
 S DA=PXKPIEN
 S DIK=$P($T(GLOBAL^@PXKRTN),";;",2)_"("
 D ^DIK
 K DIK
 Q
 ;
COPYDEL ; Make a copy of entry
 ;
 N DA,DIC,DINUM,DIK,DO,PXDELGBL,PXGBL,PXKPDELIEN,PXTMP,X,Y
 ;
 S PXDELGBL=$P($T(DELGBL^@PXKRTN),";;",2)
 I $E(PXDELGBL,1)'="^" Q
 S PXGBL=$P($T(GLOBAL^@PXKRTN),";;",2)_"("
 ;
 ; add entry to deleted file
 S PXTMP=$G(@(PXGBL_PXKPIEN_",0)"))
 I $P(PXTMP,U,1)="" Q
 S X=$P(PXTMP,U,1)
 S DIC=PXDELGBL
 S DIC(0)=""
 L +@(PXDELGBL_PXKPIEN_")"):DILOCKTM
 ; if possible, try to assign same IEN in deleted file
 I '$D(@(PXDELGBL_PXKPIEN_")")) S DINUM=PXKPIEN
 D FILE^DICN
 L -@(PXDELGBL_PXKPIEN_")")
 ;
 ; Now copy the rest of the data.
 S PXKPDELIEN=$P(Y,U,1)
 I PXKPDELIEN'>0 Q
 L +@(PXDELGBL_PXKPDELIEN_")"):DILOCKTM
 M @(PXDELGBL_PXKPDELIEN_")")=@(PXGBL_PXKPIEN_")")
 S @(PXDELGBL_PXKPDELIEN_",880)")=DUZ_U_$$NOW^XLFDT
 S DIK=PXDELGBL
 S DA=PXKPDELIEN
 D IX1^DIK
 L -@(PXDELGBL_PXKPDELIEN_")")
 ;
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
 ;PXKHLR Is not killed because it is a flag coming from another routine
 Q
 ;
CPTMOD(VCPTIEN,MODIEN) ;
 N IND,VCPTE
 S IND=$O(^AUPNVCPT(VCPTIEN,1,"B",MODIEN,""))
 I IND="" S IND=1
 S VCPTE="^AUPNVCPT("_VCPTIEN_",1,"_IND_",0)"
 Q VCPTE
 ;
ER ;--PXKERROR MAKING IF NOT POPULATED CORRECTLY
 N PXKRT,PXKMOD,PXKSTR
 S PXKMOD=PXKSEQ#1 I $G(PXKMOD) Q
 S PXKN=""
 F  S PXKN=$O(PXKAV(PXKN)) Q:PXKN=""  D
 . I PXKCAT="IMM",PXKN?1(1"2",1"3",1"11") D ER^PXKIMM Q
 . S PXKP=""
 . F  S PXKP=$O(PXKAV(PXKN,PXKP)) Q:PXKP=""  D
 .. S PXKRRT=$P($T(GLOBAL^@PXKRTN),";;",2)_"("_DA_","
 .. I PXKN=1,PXKCAT="CPT" S PXKRRT=$$CPTMOD(PXKPIEN,PXKAV(PXKN,PXKP))
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
 ;
