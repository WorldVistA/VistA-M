BPSECMPS ;BHAM ISC/FCS/DRS - Parse Claim Response ;3/10/08  12:31
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5,6,7,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; references to UPDATE^DIE and WP^DIE supported by DBIA 2053
 ; reference to FDA^DILF  supported by DBIA 2054
 ;
PARSE(RREC,CLAIMIEN,RESPIEN) ;
 ;
 N FDAIEN,FDAIEN03,FDATA,FILE,FS,GS,ROOT,SS,TRANSACT,TRANSCNT
 ;
 ; RREC and CLAIMIEN are required
 Q:$G(RREC)=""
 Q:$G(CLAIMIEN)=""
 ;
 ;group and field separator characters
 S GS="\X1D\",FS="\X1C\",SS="\X1E\"
 S FILE="9002313.03",ROOT="FDATA(9002313.03)"
 D TRANSMSN  ; process transmission level data, transaction count in TRANSCNT (from PARSEH)
 D TRANSACT  ; process transaction level data
 ;
 ; If test system and test active, call the override routine
 ; IEN59 and TRANTYPE are set in BPSECMC2
 ;
 I $$CHECK^BPSTEST D SETOVER^BPSTEST(IEN59,TRANTYPE,.FDATA)
 D UPDATE^DIE("S","FDATA(9002313.03)","FDAIEN")
 F TRANSACT=1:1:TRANSCNT  D
 .D PROCRESP
 .D PROCREJ
 .D PROCAPP
 .D PROCPPR
 .D PROCCOB
 .D PROCOTH^BPSECMP2
 .D PROCBEN^BPSECMP2
 .D PROCADM^BPSECMP2
 .D PROCDUR^BPSECMP2
 S RESPIEN=FDAIEN(1)
 ; This should be called for each transaction but the IBSEND is not
 ;  setup correctly so currently it is only called for each claim/response
 ; If we ever bundle claims, we will need to fix IBSEND and move this code
 ;  to the FOR loop above.
 D IBSEND^BPSECMP2(CLAIMIEN,RESPIEN,"","")
 D RAW(RESPIEN,RREC)
 ;
 Q
 ;
TRANSMSN ;This subroutine will work through the transmission level information
 ;
 N RHEADER,RTRANM,SEG,SEGID,SEGMENT
 ;
 ;Parse response transmission level from ascii record
 S RTRANM=$P(RREC,GS,1)
 ;
 ; get just the header segment
 S RHEADER=$P(RTRANM,SS,1)    ;header- required/fixed length
 D PARSEH
 ;
 ; There are 2 optional segments on the transmission level - message
 ; and insurance.  We'll check for both and parse what we find.
 F SEG=2:1:3 D
 . S SEGMENT=$P(RTRANM,SS,SEG)
 . Q:SEGMENT=""
 . S SEGID=$P(SEGMENT,FS,2)
 . I $E(SEGID,1,2)="AM" D  ; segment identification
 .. S SEGFID=$E(SEGID,3,4)
 .. D:(SEGFID=20)!(SEGFID=25) PARSETM
 ;
 Q
 ;
TRANSACT ;This subroutine will work through the transaction level information
 ;
 N GRP,MEDN,RTRAN,SEG,SEGMENT
 S MEDN=0
 ;
 F GRP=2:1 D  Q:RTRAN=""
 . S RTRAN=$P(RREC,GS,GRP)     ;get the next transaction (could be 4)
 . Q:RTRAN=""                  ;we're done if it's empty
 . S MEDN=MEDN+1               ;transaction counter
 . ;
 . F SEG=2:1 D  Q:SEGMENT=""   ;break the record down by segments
 .. S SEGMENT=$P(RTRAN,SS,SEG) ;get the segment
 .. Q:SEGMENT=""
 .. D PARSETN                  ;get the fields
 Q
 ;
PARSEH ; parse the header record, required on all responses, and is fixed length
 ; It's the only record that is fixed length.
 ;
 D FDA^DILF(FILE,"+1",.01,"",CLAIMIEN,ROOT)  ; CLAIM ID
 D FDA^DILF(FILE,"+1",.02,"",$$NOWFM^BPSOSU1,ROOT)  ; DATE RESPONSE RECEIVED
 D FDA^DILF(FILE,"+1",102,"",$E(RHEADER,33,34),ROOT)  ; VERSION RELEASE NUMBER
 D FDA^DILF(FILE,"+1",103,"",$E(RHEADER,35,36),ROOT)  ; TRANSACTION CODE
 D FDA^DILF(FILE,"+1",109,"",$E(RHEADER,37,37),ROOT)  ; TRANSACTION COUNT
 S TRANSCNT=$E(RHEADER,37,37)
 D FDA^DILF(FILE,"+1",501,"",$E(RHEADER,38,38),ROOT)  ; response status header
 D FDA^DILF(FILE,"+1",202,"",$E(RHEADER,39,40),ROOT)  ; SERVICE PROVIDER ID Qualifier
 D FDA^DILF(FILE,"+1",201,"",$E(RHEADER,41,55),ROOT)  ; SERVICE PROVIDER ID
 D FDA^DILF(FILE,"+1",401,"",$E(RHEADER,56,63),ROOT)  ; DATE OF SERVICE
 ;
 Q
 ;
PARSETM ; parse the variable portions of the transmission
 ;
 N FIELD,FLDNUM,PC
 ;
 F PC=3:1 D  Q:FIELD=""        ;skip the seg id -already know its value
 . S FIELD=$P(SEGMENT,FS,PC)   ;piece through the record
 . Q:FIELD=""                  ;stop - we hit the end
 . S FLDNUM=$$GETNUM(FIELD)    ;get the field number used for storage
 . Q:FLDNUM=""                 ;shouldn't happen - but let's skip
 . S FIELD=$E(FIELD,3,999)
 . D FDA^DILF(FILE,"+1",FLDNUM,"",FIELD,ROOT)
 Q
 ;
PARSETN ; parse the transaction level segments
 ;
 ; Possible values of the SEGFID field:
 ;  21 = Response Status Segment
 ;  22 = Response Claim Segment
 ;  23 = Response Pricing Segment
 ;  24 = Response DUR/PPS Segment
 ;  26 = Response Prior Authorization Segment
 ;  28 = Response Coordination of Benefits/Other Payers Segment
 ;
 N CKRPT,FIELD,FLDNUM,PC,RCNT,REPEAT,RPTFLD,SEGFID,SEGID,GRPCNT,GRPFLDS
 ;
 S RPTFLD=""
 S SEGID=$P(SEGMENT,FS,2)  ; this should be the segment id
 Q:SEGID=""                ; don't process without a Seg id
 Q:$E(SEGID,1,2)'="AM"     ; don't know what we have - skip
 ;
 S SEGFID=$E(SEGID,3,4)    ; this should be the field ID
 S GRPCNT=0,GRPFLDS=""
 ;
 ; setup the repeating flds based on the segment
 I SEGFID=21 D                 ;status segment
 . S RPTFLD=",548,511,546,132,526,131,"
 . S (RCNT(548),RCNT(511),RCNT(546),RCNT(132),RCNT(526),RCNT(131))=0
 . S GRPCNT=0
 . S GRPFLDS=",511,548,132,"
 ;
 I SEGFID=22 D                 ;claim segment
 . S RPTFLD=",552,553,554,555,556,"
 . S (RCNT(552),RCNT(553),RCNT(554),RCNT(555),RCNT(556))=0
 . S GRPCNT=0
 . S GRPFLDS=",552,"
 ;
 I SEGFID=23 D                ;pricing segment
 . S RPTFLD=",564,565,393,394,"
 . S (RCNT(564),RCNT(565),RCNT(393),RCNT(394))=0
 . S GRPCNT=0
 . S GRPFLDS=",564,393,"
 ;
 I SEGFID=24 D                ;DUR/PPS segment
 . S RPTFLD=",439,528,529,530,531,532,533,544,567,570"
 . S (RCNT(439),RCNT(528),RCNT(529),RCNT(530),RCNT(531))=0
 . S (RCNT(532),RCNT(533),RCNT(567),RCNT(544),RCNT(570))=0
 . S GRPCNT=0
 . S GRPFLDS=",567,"
 ;
 I SEGFID=28 D                ;COB/Other Payers segment
 . S RPTFLD=",127,142,143,144,145,338,339,340,356,991,992,"
 . S (RCNT(127),RCNT(142),RCNT(143),RCNT(144),RCNT(145),RCNT(338))=0
 . S (RCNT(339),RCNT(340),RCNT(356),RCNT(991),RCNT(992))=0
 . S GRPCNT=0
 . S GRPFLDS=",338,"
 ;
 ; now let's parse out the fields
 ;
 F PC=3:1 D  Q:FIELD=""        ;skip the seg id -jump to the other flds
 . S FIELD=$P(SEGMENT,FS,PC)   ;piece through the record
 . Q:FIELD=""                  ;stop - we hit the end
 . S FLDNUM=$$GETNUM(FIELD)    ;get the field number used for storage
 . Q:FLDNUM=""                 ;shouldn't happen - but let's skip
 . S REPEAT=0                  ;for this segment, let's figure
 . S CKRPT=","_FLDNUM_","      ;out if the field is a repeating
 . S:RPTFLD[CKRPT REPEAT=1     ;field
 . ; Increment the group counter if first field of group.
 . S:GRPFLDS[CKRPT GRPCNT=GRPCNT+1
 . ; if rptg, store with a group counter
 . S:REPEAT FDATA(MEDN,FLDNUM,GRPCNT)=$E(FIELD,3,$L(FIELD))
 . ; not rptg, store without counter
 . S:'REPEAT FDATA(MEDN,FLDNUM)=$E(FIELD,3,$L(FIELD))
 ;
 Q
 ;
GETNUM(FIELD) ; function, return field number for a field I
 ; use BPS NCPDP FIELD DEFS (#9002313.91) "D" cross ref for lookup
 ; field number is used to store the data in the correct field in BPS RESPONSES (#9002313.03)
 ;
 N FLDID,FLDIEN,FLDNUM
 S FLDID=$E(FIELD,1,2),FLDNUM=""
 Q:FLDID="" FLDNUM  ; FLDID = field identifier
 ; 
 S FLDIEN=$O(^BPSF(9002313.91,"D",FLDID,0))  ; ien for fld #
 S:FLDIEN FLDNUM=$P($G(^BPSF(9002313.91,FLDIEN,0)),U) ;fld number
 Q FLDNUM
 ;
PROCRESP ; add data to RESPONSES SUB-FIELD (#9002313.0301)
 ;
 N FDATA03,FIELD,FILE,FLDNUM,ROOT
 ;
 S FILE=9002313.0301,ROOT="FDATA03(9002313.0301)"
 ; field 501 is HEADER RESPONSE STATUS, 112 is TRANSACTION RESPONSE STATUS
 I '$D(FDATA(TRANSACT,501)) S FDATA(TRANSACT,501)=FDATA(TRANSACT,112)
 I '$D(FDATA(TRANSACT,112)) S FDATA(TRANSACT,112)=FDATA(TRANSACT,501)
 ;
 S FLDNUM=".01" D FDA^DILF(FILE,"+1,"_FDAIEN(TRANSACT),FLDNUM,"",TRANSACT,ROOT)
 S FIELD=""
 F  S FIELD=$O(FDATA(TRANSACT,FIELD)) Q:FIELD=""  D   ;set all the non-repeating fields for 9002313.0301
 .Q:$G(FDATA(TRANSACT,FIELD))=""  ; no data to process
 .; field 402 is PRESCRIPTION/SERVICE REF. NO.
 .I FIELD=402 S FDATA(TRANSACT,FIELD)=$TR(FDATA(TRANSACT,FIELD),"\","") ;REMOVE EXTRANEOUS "\"
 .D FDA^DILF(FILE,"+"_TRANSACT_","_FDAIEN(TRANSACT),FIELD,"",FDATA(TRANSACT,FIELD),ROOT)
 ;
 D UPDATE^DIE("S","FDATA03(9002313.0301)","FDAIEN03")
 ;
 Q
 ;
PROCREJ ; add data to REJECT CODE SUB-FIELD (#9002313.03511)
 Q:$G(FDATA(TRANSACT,510))=""
 ;
 N FDAT3511,FILE,FLDNUM,NNDX,NUMREJS,ROOT,REJCODE
 ;
 S FILE="9002313.03511",ROOT="FDAT3511(9002313.03511)",NUMREJS=FDATA(TRANSACT,510),NNDX=""
 F  S NNDX=$O(FDATA(TRANSACT,511,NNDX)) Q:NNDX=""  D   ;set all the non-repeating fields for 9002313.03511 rejections
 .S REJCODE=$$TRIM^XLFSTR(FDATA(TRANSACT,511,NNDX),"R")
 .S REJCODE=$TR(REJCODE,"\","")  Q:REJCODE']""
 .S FLDNUM=".01" D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",REJCODE,ROOT)
 D UPDATE^DIE("S","FDAT3511(9002313.03511)")
 ;
 Q
 ;
PROCAPP ; APPROVED MESSAGE CODE SUB-FIELD (#9002313.301548)
 Q:$O(FDATA(TRANSACT,548,0))=""
 ;
 N FDAT1548,FILE,FLDNUM,NNDX,ROOT
 ;
 S FILE="9002313.301548",ROOT="FDAT1548(9002313.301548)",NNDX=""
 F  S NNDX=$O(FDATA(TRANSACT,548,NNDX)) Q:NNDX=""  D
 .S FLDNUM=".01" D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",FDATA(TRANSACT,548,NNDX),ROOT)
 D UPDATE^DIE("S","FDAT1548(9002313.301548)")
 ;
 Q
 ;
PROCPPR ; PREFERRED PRODUCT REPEATING SUB-FIELD (#9002313.1301)
 ;
 Q:$O(FDATA(TRANSACT,552,0))=""
 ;
 N FDAT1301,FILE,FLDNUM,NNDX,ROOT
 ;
 S FILE="9002313.1301",ROOT="FDAT1301(9002313.1301)",NNDX=""
 F  S NNDX=$O(FDATA(TRANSACT,552,NNDX)) Q:NNDX=""  D
 .S FLDNUM=".01" D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",NNDX,ROOT)
 .F FLDNUM=552,553,554,555,556 I $D(FDATA(TRANSACT,FLDNUM,NNDX)) D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",$G(FDATA(TRANSACT,FLDNUM,NNDX)),ROOT)
 D UPDATE^DIE("S","FDAT1301(9002313.1301)")
 ;
 Q
PROCCOB ; OTHER PAYER ID MLTPL SUB-FIELD (#9002313.035501)
 ;
 Q:$O(FDATA(TRANSACT,338,0))=""
 ;
 N FDAT35501,FILE,FLDNUM,NNDX,ROOT
 ;
 S FILE="9002313.035501",ROOT="FDAT35501(9002313.035501)",NNDX=""
 F  S NNDX=$O(FDATA(TRANSACT,338,NNDX)) Q:NNDX=""  D
 .S FLDNUM=".01" D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",NNDX,ROOT)
 .F FLDNUM=127,142,143,144,145,338,339,340,356,991,992 I $D(FDATA(TRANSACT,FLDNUM,NNDX)) D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",$G(FDATA(TRANSACT,FLDNUM,NNDX)),ROOT)
 D UPDATE^DIE("S","FDAT35501(9002313.035501)")
 ;
 Q
 ;
RAW(RESPIEN,RREC) ; store raw data received from the payer
 ; pass in the response IEN (9002313.03) and the raw data to be stored.
 N X,CNT
 K ^TMP($J,"WP")
 S CNT=0 F X=1:79:$L(RREC) S CNT=CNT+1 S ^TMP($J,"WP",CNT,0)=$E(RREC,X,X+78)
 D WP^DIE(9002313.03,RESPIEN_",",9999,"K","^TMP($J,""WP"")")
 K ^TMP($J,"WP")
 Q
 ;
