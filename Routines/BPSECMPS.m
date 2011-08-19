BPSECMPS ;BHAM ISC/FCS/DRS - Parse Claim Response ;3/10/08  12:31
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5,6,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PARSE(RREC,CLAIMIEN,RESPIEN) ;
 N GS,FS,SS,FILE,ROOT,TRANSACT,TRANSCNT
 N FDATA,FDAIEN,FDAIEN03
 ;
 ;Make sure input variables are defined
 Q:$G(RREC)=""
 Q:$G(CLAIMIEN)=""
 ;
 ;group and field separator characters
 S GS="\X1D\",FS="\X1C\",SS="\X1E\"
 S FILE="9002313.03"
 S ROOT="FDATA(9002313.03)"
 D TRANSMSN            ;process the transmission level data
 D TRANSACT            ;process the transaction level data
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
 .D PROCOTH^BPSECMP2
 .D PROCDUR^BPSECMP2
 .S RESPIEN=FDAIEN(TRANSACT)
 .D IBSEND^BPSECMP2(CLAIMIEN,RESPIEN,"","")
 D RAW(RESPIEN,RREC)
 Q
 ;
TRANSMSN ;This subroutine will work through the transmission level information
 ;
 N RTRANM,RHEADER,SEG,SEGMENT,SEGID
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
 . I $E(SEGID,1,2)="AM" D                ;segment identification
 .. S SEGFID=$E(SEGID,3,4)
 .. D:(SEGFID=20)!(SEGFID=25) PARSETM
 ;
 Q
 ;
TRANSACT ;This subroutine will work through the transaction level information
 ;
 N RTRAN,SEG,SEGMENT,MEDN,GRP
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
PARSEH ; The header record is required on all responses, and is fixed
 ; length.  It is the only record that is fixed length.
 ;
 N FIELD,%,%H,%I
 S FIELD=".01" D FDA^DILF(FILE,"+1",FIELD,"",CLAIMIEN,ROOT)
 D NOW^%DTC
 S FIELD=".02" D FDA^DILF(FILE,"+1",FIELD,"",%,ROOT)
 S FIELD=".03" D FDA^DILF(FILE,"+1",FIELD,"",$H,ROOT)
 S FIELD=102 D FDA^DILF(FILE,"+1",FIELD,"",$E(RHEADER,33,34),ROOT)    ;version/release number
 S FIELD=103 D FDA^DILF(FILE,"+1",FIELD,"",$E(RHEADER,35,36),ROOT)    ;transaction code
 S FIELD=109 D FDA^DILF(FILE,"+1",FIELD,"",$E(RHEADER,37,37),ROOT)    ;transaction count
 S TRANSCNT=$E(RHEADER,37,37)
 S FIELD=501 D FDA^DILF(FILE,"+1",FIELD,"",$E(RHEADER,38,38),ROOT)    ;response status header
 S FIELD=202 D FDA^DILF(FILE,"+1",FIELD,"",$E(RHEADER,39,40),ROOT)    ;service provider id qualifier
 S FIELD=201 D FDA^DILF(FILE,"+1",FIELD,"",$E(RHEADER,41,55),ROOT)    ;service provider id
 S FIELD=401 D FDA^DILF(FILE,"+1",FIELD,"",$E(RHEADER,56,63),ROOT)    ;date of service
 Q
 ;
PARSETM ; This subroutine will parse the variable portions of the transmission
 ;
 N FIELD,PC,FLDNUM
 ;
 F PC=3:1 D  Q:FIELD=""        ;skip the seg id -already know its value
 . S FIELD=$P(SEGMENT,FS,PC)   ;piece through the record
 . Q:FIELD=""                  ;stop - we hit the end
 . S FLDNUM=$$GETNUM(FIELD)    ;get the field number used for storage
 . Q:FLDNUM=""                 ;shouldn't happen - but lets skip
 . S FIELD=$E(FIELD,3,999)
 . D FDA^DILF(FILE,"+1",FLDNUM,"",FIELD,ROOT)
 Q
 ;
PARSETN ; This subroutine will parse the transaction level segments. For
 ;
 ; Possible values of the SEGFID field:
 ;  21 = Response Status Segment
 ;  22 = Response Claim Segment
 ;  23 = Response Pricing Segment
 ;  24 = Response DUR/PPS Segment
 ;  26 = Response Prior Authorization Segment
 ;
 N FIELD,PC,FLDNUM,RPTFLD,RCNT,REPEAT
 N SEGID,SEGFID,CKRPT
 ;
 S RPTFLD=""
 S SEGID=$P(SEGMENT,FS,2)           ;this should be the segment id
 Q:SEGID=""                         ;don't process without a Seg id
 Q:$E(SEGID,1,2)'="AM"              ;don't know what we have - skip
 ;
 S SEGFID=$E(SEGID,3,4)             ;this should be the field ID
 ;
 ; setup the repeating flds based on the segment
 I SEGFID=21 D               ;status segment
 . S RPTFLD=",548,511,546,"
 . S (RCNT(548),RCNT(511),RCNT(546))=0
 ;
 I SEGFID=22 D                 ;claim segment
 . S RPTFLD=",552,553,554,555,556,"
 . S (RCNT(552),RCNT(553),RCNT(554),RCNT(555),RCNT(556))=0
 ;
 I SEGFID=23 D                ;pricing segment
 . S RPTFLD=",564,565,"
 . S (RCNT(564),RCNT(565))=0
 ;
 I SEGFID=24 D                ;DUR/PPS segment
 . S RPTFLD=",439,528,529,530,531,532,533,9002313,544,567,"
 . S (RCNT(439),RCNT(528),RCNT(529),RCNT(530),RCNT(531))=0
 . S (RCNT(532),RCNT(533),RCNT(9002313),RCNT(567))=0,RCNT(544)=0
 ;
 ; now lets parse out the fields
 ;
 F PC=3:1 D  Q:FIELD=""        ;skip the seg id -jump to the other flds
 . S FIELD=$P(SEGMENT,FS,PC)   ;piece through the record
 . Q:FIELD=""                  ;stop - we hit the end
 . S FLDNUM=$$GETNUM(FIELD)    ;get the field number used for storage
 . Q:FLDNUM=""                 ;shouldn't happen - but lets skip
 . S REPEAT=0                  ;for this segment, lets figure
 . S CKRPT=","_FLDNUM_","      ;out if the field is a repeating
 . S:RPTFLD[CKRPT REPEAT=1     ;field
 . ;
 . I REPEAT D                  ;if rptg, store with a counter
 .. S RCNT(FLDNUM)=$G(RCNT(FLDNUM))+1
 .. S FDATA(MEDN,FLDNUM,RCNT(FLDNUM))=$E(FIELD,3,$L(FIELD))
 . ;
 . I 'REPEAT D                 ;not rptg, store without counter
 .. S FDATA(MEDN,FLDNUM)=$E(FIELD,3,$L(FIELD))
 Q
 ;
GETNUM(FIELD) ; This routine will translate the field ID into a field number.
 ; We will use the NCPDP field Defs files, cross ref "D" to
 ; perform this translation.  (The field number is needed to store
 ; the data in the correct field within the response file.)
 ;
 N FLDID,FLDIEN,FLDNUM
 S (FLDID,FLDNUM)=""
 S FLDIEN=0
 ;
 S FLDID=$E(FIELD,1,2)       ;field identifier
 Q:FLDID=""
 ;
 I FLDID'="" D
 . S FLDIEN=$O(^BPSF(9002313.91,"D",FLDID,FLDIEN))  ;internal fld #
 . S:FLDIEN FLDNUM=$P($G(^BPSF(9002313.91,FLDIEN,0)),U) ;fld number
 Q FLDNUM
 ;
PROCRESP ;
 N FILE,ROOT,FDATA03,FLDNUM,FIELD
 S FILE="9002313.0301"
 S ROOT="FDATA03(9002313.0301)"
 K FDATA03
 I '$D(FDATA(TRANSACT,501)) S FDATA(TRANSACT,501)=FDATA(TRANSACT,112)
 I '$D(FDATA(TRANSACT,112)) S FDATA(TRANSACT,112)=FDATA(TRANSACT,501)
 S FLDNUM=".01" D FDA^DILF(FILE,"+1,"_FDAIEN(TRANSACT),FLDNUM,"",TRANSACT,ROOT)
 S FIELD=""
 F  S FIELD=$O(FDATA(TRANSACT,FIELD)) Q:FIELD=""  D   ;set all the non-repeating fields for 9002313.0301
 .I $G(FDATA(TRANSACT,FIELD))'=""  D
 ..I FIELD=402 S FDATA(TRANSACT,FIELD)=$TR(FDATA(TRANSACT,FIELD),"\","") ;REMOVE EXTRANEOUS "\"
 ..D FDA^DILF(FILE,"+"_TRANSACT_","_FDAIEN(TRANSACT),FIELD,"",FDATA(TRANSACT,FIELD),ROOT)
 .E  D
 ..;
 D UPDATE^DIE("S","FDATA03(9002313.0301)","FDAIEN03")
 Q
 ;
PROCREJ ;
 Q:$G(FDATA(TRANSACT,510))=""
 N FILE,ROOT,FLDNUM,FDAT3511,NUMREJS,NNDX
 S FILE="9002313.03511"
 S ROOT="FDAT3511(9002313.03511)"
 S NUMREJS=FDATA(TRANSACT,510)
 S NNDX=""
 F  S NNDX=$O(FDATA(TRANSACT,511,NNDX)) Q:NNDX=""  D   ;set all the non-repeating fields for 9002313.3511 rejections
 .S FDATA(TRANSACT,511,NNDX)=$TR(FDATA(TRANSACT,511,NNDX),"\","")
 .S FLDNUM=".01" D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",FDATA(TRANSACT,511,NNDX),ROOT)
 D UPDATE^DIE("S","FDAT3511(9002313.03511)")
 Q
 ;
PROCAPP ;
 Q:$G(FDATA(TRANSACT,548,1))=""
 N FILE,ROOT,FLDNUM,FDAT1548,NNDX
 S FILE="9002313.301548"
 S ROOT="FDAT1548(9002313.0301548)"
 S NNDX=""
 F  S NNDX=$O(FDATA(FDAIEN(TRANSACT),548,NNDX)) Q:NNDX=""  D
 .S FLDNUM=".01" D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",FDATA(TRANSACT,548,NNDX),ROOT)
 D UPDATE^DIE("S","FDAT1548(9002313.301548)")
 Q
 ;
PROCPPR ;
 Q:$G(FDATA(TRANSACT,551.01,1))=""
 N FILE,ROOT,FLDNUM,FDAT1301,NNDX
 S FILE="9002313.1301"
 S ROOT="FDAT1301(9002313.1301)"
 S NNDX=""
 F  S NNDX=$O(FDATA(FDAIEN(TRANSACT),551.01,NNDX)) Q:NNDX=""  D
 .S FLDNUM=".01" D FDA^DILF(FILE,"+"_NNDX_","_FDAIEN03(TRANSACT)_","_FDAIEN(TRANSACT),FLDNUM,"",FDATA(TRANSACT,551.01,NNDX),ROOT)
 D UPDATE^DIE("S","FDAT1301(9002313.1301)")
 Q
 ;
RAW(RESPIEN,RREC) ; store raw data received from the payer
 ; pass in the response IEN (9002313.03) and the raw data to be stored.
 N X,DIWL,DIWR,DIWF
 K ^UTILITY($J,"W")
 S X=RREC,DIWL=1,DIWR=79,DIWF="|" D ^DIWP
 S ^BPSR(RESPIEN,"M",0)=U_U_$G(^UTILITY($J,"W",1))_U_$G(^UTILITY($J,"W",1))_U_DT
 S X=0 F  S X=$O(^UTILITY($J,"W",1,X)) Q:'X  S:$L($G(^UTILITY($J,"W",1,X,0))) ^BPSR(RESPIEN,"M",X,0)=^UTILITY($J,"W",1,X,0)
 K ^UTILITY($J,"W")
 Q
