TIULMED1 ; SLC/JM - Active/Recent Med Objects Routine ;2/7/2000
 ;;1.0;TEXT INTEGRATION UTILITIES;**38,73,92,94,202,226**;Jun 20, 1997;Build 1
 ;
 ; All routines here are part of the LIST entry point of TIULMED
 ;
ADD(TXT) ; Saves TXT in TARGET
 S NEXTLINE=NEXTLINE+1
 I TAB S TXT="  "_TXT
 I TAB,HEADER S TXT="     "_TXT
 S @TARGET@(NEXTLINE,0)=TXT
 Q
ADDLNUM(TXT) ; Add text with Line Number added to front of string
 S TAB=0
 I HEADER D ADD($E(COUNT_")     ",1,5)_TXT) I 1
 E  D ADD(TXT)
 S TAB=1
 Q
ADDL(TXT) ; Add with ADDLNUM on FIRST
 I FIRST D  I 1
 .D ADDLNUM(TXT)
 .S FIRST=0
 E  D ADD(TXT)
 Q
ADDMED(XMODE) ; if XMODE creates XSTR, if not add med to TARGET
 N DATA,FIRST,XSUM,XCOUNT,TOPLINE,WSTATUS
 S FIRST=1
 I XMODE S (XSUM,XCOUNT)=0,XSTR=""
 E  D
 .S TOPLINE=NEXTLINE+1,DATA="",WSTATUS=0
 .D ADDP(2)
 I TYPE="UD" D  I 1 ; Unit Dose Meds
 .I 'XMODE D
 ..I DETAILED D FLUSH S DATA="Give:"
 ..S DATA=DATA_" "
 .I $$PL(6) D ADDP(6) I 1
 .E  I $$PL(7) D ADDP(7) I 1
 .E  D ADDM("SIG")
 .D ADDM("MDR"),ADDM("SCH")
 .I DETAILED D FLUSH
 .D ADDM("SIO")
 E  I TYPE="OP" D  I 1 ; Outpatient Meds
 .I 'XMODE,DETAILED D
 ..I $$PL(12) D
 ...S DATA=DATA_"  Qty:"
 ...D ADDP(12)
 ..I $$PL(11) D
 ...S DATA=$$STRIP(DATA_" for")
 ...D ADDP(11)
 ...S DATA=$$STRIP(DATA_" days")
 ..D WRAP
 .I $$ML("SIG") D  I 1
 ..I 'XMODE,DETAILED S DATA=$$STRIP(DATA_"  Sig:")
 ..D ADDM("SIG")
 .E  D ADDM("SIO"),ADDM("MDR"),ADDM("SCH")
 E  I TYPE="IV" D  ; IV meds
 .I DETAILED D FLUSH
 .D ADDM("A")
 .I $$ML("B") D
 ..I 'XMODE S DATA=$$STRIP(DATA_" in")
 ..D ADDM("B")
 .D ADDP(3)
 .I DETAILED D FLUSH
 .;ELR/VMP patch 226 add route and schedule to IV's
 .D ADDM("SIO"),ADDM("MDR"),ADDM("SCH")
 .D FLUSH
 .I 'XMODE D
 ..N I
 ..F I=TOPLINE:1:NEXTLINE S @TARGET@(I,0)=$TR(@TARGET@(I,0),U," ")
 I XMODE D  I 1
 .I XSTR="" S XSTR="_"
 .E  I $L(XSTR)>80 S XSTR=$E(XCOUNT_"_"_XSUM_"_"_XSTR,1,80)
 E  D
 .D FLUSH
 .S WSTATUS=1
 .D ADDP(9)
 .S WSTATUS=0
 .I DETAILED D
 ..D ADDDATE(TOPLINE,$S(MEDTYPE=OUTPTYPE:"Issu",1:"Strt"),15)
 ..I MEDTYPE=OUTPTYPE D  I 1
 ...N I
 ...I TOPLINE=NEXTLINE S I=TOPLINE+1
 ...E  I $L(@TARGET@(TOPLINE+1,0))<48 S I=TOPLINE+1
 ...E  S I=TOPLINE+2
 ...F  Q:(I'>NEXTLINE)  D ADD(" ")
 ...S @TARGET@(I,0)=$E(@TARGET@(I,0)_SPACE60,1,47)_"Refills: "_+$P(NODE,U,5)
 ...D ADDDATE(TOPLINE+1,"Last",10)
 ...D ADDDATE(TOPLINE+2,"Expr",4)
 ..E  D
 ...D ADDDATE(TOPLINE+1,"Stop",4)
 Q
FDT(PNUM) ;Returns formatted date from piece number
 N X,Y
 S Y=$P(NODE,U,PNUM)
 S X=$E(Y,4,5)_"-"_$E(Y,6,7)_"-"_$E($E(Y,1,3)+1700,3,4)
 Q X
ADDDATE(LINENUM,TXT,PNUM) ;Add date to TARGET
 I $$PL(PNUM) D
 .F  Q:(LINENUM'>NEXTLINE)  D ADD(" ")
 .S @TARGET@(LINENUM,0)=$E(@TARGET@(LINENUM,0)_SPACE60,1,60)_TXT_":"_$$FDT(PNUM)
 Q
XSUMS(STR,NOADD) ; XSUMs a string
 N IDX,LEN
 S LEN=$L(STR) I LEN'>0 Q
 I '$G(NOADD),$L(XSTR)<99 S XSTR=XSTR_STR
 F IDX=1:1:LEN S XCOUNT=XCOUNT+1,XSUM=XSUM+($A(STR,IDX)*XCOUNT)
 Q
WRAP ; Wraps DATA to the output
 I XMODE Q
 N IDX,LEN,MAX,DATA1,DONE
 S DONE=0
 F  Q:DONE  D
 .I WSTATUS S MAX=13
 .E  D
 ..I FIRST S MAX=41
 ..E  S MAX=39
 ..I 'HEADER S MAX=MAX+5
 ..I 'DETAILED S MAX=MAX+13
 .S LEN=$L(DATA)
 .I 'WSTATUS,LEN<MAX S DONE=1 Q
 .I LEN<MAX S IDX=LEN
 .E  F IDX=MAX:-1:2 Q:$E(DATA,IDX)=" "
 .I IDX<3 S IDX=MAX-1
 .S DATA1=$$STRIP($E(DATA,1,IDX))
 .I WSTATUS D  I 1
 ..S @TARGET@(TOPLINE,0)=$E(@TARGET@(TOPLINE,0)_SPACE60,1,LLEN)_DATA1
 .E  D ADDL(DATA1)
 .S DATA=$$STRIP($E(DATA,IDX+1,999))
 .I WSTATUS D
 ..S DONE=1,WSTATUS=0
 ..I $L(DATA)>0 D
 ...I TOPLINE'<NEXTLINE D ADD(" ")
 ...S @TARGET@(TOPLINE+1,0)=$E(@TARGET@(TOPLINE+1,0)_SPACE60,1,LLEN)_DATA
 ...S DATA=""
 Q
STRIP(X) ; Removes Leading and Trialing Spaces
 F  Q:$E(X)'=" "  S X=$E(X,2,999)
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,$L(X)-1)
 Q X
ADDP(PNUM) ; Adds or XSUMs a piece of NODE
 I XMODE D  I 1
 .D XSUMS(PNUM,1)
 .D XSUMS($P(NODE,U,PNUM))
 E  D
 .N VALUE
 .S VALUE=$P(NODE,U,PNUM)
 .I PNUM=9,VALUE="ACTIVE/SUSP" S VALUE="ACTIVE (S)"
 .S DATA=$$STRIP(DATA_" "_VALUE)
 .D WRAP
 Q
ADDM(SUB,FORCE) ; Adds or XSUMs Multiple
 N IDX
 S IDX=0
 I XMODE D  I 1
 .D XSUMS(SUB,1)
 .F  S IDX=$O(^TMP("PS",$J,INDEX,SUB,IDX)) Q:IDX=""  D
 ..D XSUMS(^TMP("PS",$J,INDEX,SUB,IDX,0))
 E  D
 .I $G(FORCE),DETAILED  D FLUSH
 .F  S IDX=$O(^TMP("PS",$J,INDEX,SUB,IDX)) Q:IDX=""  D
 ..S DATA=$$STRIP(DATA_" "_^TMP("PS",$J,INDEX,SUB,IDX,0))
 ..D WRAP
 Q
FLUSH ; Flush the DATA buffer
 I 'XMODE,DATA'="" D
 .D WRAP
 .I DATA'="" D ADDL(DATA) S DATA=""
 Q
PL(PNUM) ;Retuns length of peice
 Q $L($P(NODE,U,PNUM))
ML(SUB) ;Returns true if multiple exists and contains data
 N IDX,ML
 S (IDX,ML)=0
 F  S IDX=$O(^TMP("PS",$J,INDEX,SUB,IDX)) Q:(IDX="")!ML  D
 .I $L(^TMP("PS",$J,INDEX,SUB,IDX,0)) S ML=1
 Q ML
ADDTITLE ;Adds a title line indicating which meds are in the list
 N MSG,ALL,SUP,SUPFX
 I ACTVONLY<2 S MSG="Active"
 E  S MSG=""
 I '+ACTVONLY S MSG=MSG_" and "
 I ACTVONLY'=1 S MSG=MSG_"Recently Expired"
 S ALL=ALLMEDS
 I ALL=0 D
 .I ISINP S ALL=2
 .E  S ALL=3
 S MSG=MSG_" "
 I ALL'=3 S MSG=MSG_"Inpatient"
 I ALL=1 S MSG=MSG_" and "
 I ALL'=2 S MSG=MSG_"Outpatient"
 S MSG=MSG_" Medications"
 I SUPPLIES S SUPFX="in"
 E  S SUPFX="ex"
 S SUPFX="("_SUPFX_"cluding Supplies):"
 I $L(MSG)>51 D  I 1
 .D ADD(MSG)
 .D ADD(SUPFX)
 E  D
 .S MSG=MSG_" "_SUPFX
 .D ADD(MSG)
 D ADD(" ")
 Q
WARNING ;Inserts warning about CLASSORT if needed
 I CLASSORT D
 .N MSG
 .D ADD("* *  WARNING  * * Sorting by drug class may not be accurate!")
 .D ADD("Medications belonging to multiple drug classes will only be listed")
 .S MSG="under a single drug class."
 .I UNKNOWNS S MSG=MSG_"  In addition, the system is not able to"
 .D ADD(MSG)
 .I UNKNOWNS D ADD("determine the drug class of some medications.")
 Q
