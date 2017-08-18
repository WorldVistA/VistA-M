SDECIDX ;ALB/SAT - VISTA SCHEDULING RPCS ;JUN 21, 2017
 ;;5.3;Scheduling;**627,642,658,665**;Aug 13, 1993;Build 14
 ;
 ; The following entry point causes the ^XTMP("SDEC","IDX" global
 ; to be rebuilt based on the scheduling of the SDEC BUILD IDX option.
ENTRY ; When executed, the following actions will occur:
 ; - purge existing ^XTMP("SDEC","IDX" data
 ; - Loop through files 123, 403.5, 409.3, and 409.85 and placing content
 ;   into the XTMP global for retrieval by the SDECIDX GET RPC call.
 ;
 D PURGE
 D BUILD
 Q
 ;
PURGE ;EP- Delete the content of the global and set zero node
 ;
 K ^XTMP("SDEC","IDX")
 S ^XTMP("SDEC",0)=$$FMADD^XLFDT(DT,7)_U_$$DT^XLFDT
 Q
 ;
BUILD ;EP- Generate content
 ;
 N FILE,CNT,DLM
 S CNT=0  ;alb/sat 658
 S DLM="|"
 F LP=123,403.5,409.3,409.85 D
 .D BLD(LP)
 D SETNODEC(CNT)
 Q
 ;
BLD(FIL) ;EP-
 I FIL=123 D  Q
 .D BLD123
 E  I FIL=403.5 D  Q
 .D BLD4035
 E  I FIL=409.3 D  Q
 .D BLD4093
 E  I FIL=409.85 D  Q
 .D BLD40985
 Q
 ;
BLD123 ;EP- REQUEST/CONSULTATION (C)
 Q:'$$TEST("REQGET^SDEC51")
 ;Key stored in 4Oth piece
 ;SVCCONN - 27th piece
 ;SVCCONNP - 28th piece
 ;WLSVCCON - no value use ""
 ;Desired DATE - no value use 0
 ;Origination Date - ORIGDT - 2nd piece
 ;Priority Group (PRIGRP header)- 24th piece
 N LP,NOD,NODRMG,GBL,SDSUB,SVCP
 N SDECY,SDECY1,SDBEG,SDEND,MAXREC,LASTSUB,SORTSTR
 S GBL="~GMR(123,"
 D RMG^SDECRMG(.SDECY,9999999,,"REQUESTTYPE^C|WAITTIME^>=90|ALL^C",,,200)
 S LP=0 F  S LP=$O(@SDECY@(LP)) Q:LP'>0  D
 .S NODRMG=@SDECY@(LP)
 .D REQGET^SDEC(.SDECY1,,,,,$P(NODRMG,U,2))
 .D SETNODEP(GBL,$G(@SDECY1@(0)))
 .S NOD=@SDECY1@(1)
 .S SORTSTR=$P(NODRMG,U,3)
 .D SETNODE(SORTSTR,GBL_DLM_$$PC(NOD,1)_DLM_"C",NOD,40)
 .I $P(NOD,U,8)'="" D
 ..K SDSUB
 ..S SDSUB($P(NOD,U,8))=""
 ..D SETXREF("C","E",.SDSUB,$P(NOD,U,1))
 .K @SDECY1
 K @SDECY
 Q
BLD4035 ;EP- RECALL REMINDERS (R)
 Q:'$$TEST("RECGET^SDEC52")
 ;Key stored in 42nd piece
 ;SVCCONN - 28th piece
 ;SVCCONNP - 29th piece
 ;WLSVCCON - no value use ""
 ;Desired DATE - 19th piece - External format
 ;Origination Date - ORIGDT - 32nd piece
 ;Priority Group (PRIGRP header)- 25th piece
 N LP,NOD,NODRMG,GBL,SVCP,SORTSTR
 N SDECY,SDECY1,DFN,SDBEG,SDEND,MAXREC,LASTSUB
 S GBL="~SD(403.5,"
 D RMG^SDECRMG(.SDECY,9999999,,"REQUESTTYPE^R|WAITTIME^>=90",,,200)
 S LP=0 F  S LP=$O(@SDECY@(LP)) Q:LP'>0  D
 .S NODRMG=@SDECY@(LP)
 .D RECGET^SDEC(.SDECY1,,,,,,$P(NODRMG,U,2))
 .D SETNODEP(GBL,@SDECY1@(0))
 .S NOD=@SDECY1@(1)
 .S SORTSTR=$P(NODRMG,U,3)
 .D SETNODE(SORTSTR,GBL_DLM_$$PC(NOD,1)_DLM_"R",NOD,42)
 .K @SDECY1
 K @SDECY
 Q
BLD4093 ;EP- SD WAIT LIST (E)
 Q:'$$TEST("WLGET^SDECWL1")
 ;Key stored in 56th piece
 ;SVCCONN - 36th piece
 ;SVCCONNP - 37th piece
 ;Desired DATE - 24th piece
 ;Origination Date - ORIGDT - 8th piece
 ;Enrollment Priority Group (PRIGRP header) - 33rd piece
 ;WLSVCCON - 44th piece
 N LP,NOD,NODRMG,GBL,SCPRI,SVCP
 N SDECY,SDECY1,MAXREC,SDBEG,SDEND,DFN,LASTSUB,SORTSTR
 S GBL="~SDWL(409.3,"
 D RMG^SDECRMG(.SDECY,9999999,,"REQUESTTYPE^E|WAITTIME^>=90",,,200)
 S LP=0 F  S LP=$O(@SDECY@(LP)) Q:LP'>0  D
 .S NODRMG=@SDECY@(LP)
 .D WLGET^SDEC(.SDECY1,$P(NODRMG,U,2))
 .D SETNODEP(GBL,$G(@SDECY1@(0)))
 .S NOD=@SDECY1@(1)
 .S SORTSTR=$P(NODRMG,U,3)
 .D SETNODE(SORTSTR,GBL_DLM_$$PC(NOD,7)_DLM_"E",NOD,56)
 .K @SDECY1
 K @SDECY
 Q
BLD40985 ;EP- SDEC APPT REQUEST (A)
 Q:'$$TEST("ARGET^SDECAR1")
 ;Key stored in 56th piece
 ;SVCCONN - 29th piece
 ;SVCCONNP - 30th piece
 ;Desired DATE - 20th piece
 ;Origination Date - ORIGDT - 8th piece
 ;Priority Group (PRIGRP header) - 26th piece
 ;WLSVCCON = 37th piece
 N LP,NOD,NODRMG,GBL,SVCP,SORTSTR
 N SDECY,SDECY1,DFN,MAXREC,LASTSUB,ARIEN1,SDBEG,SDEND
 S GBL="~SDEC(409.85,"
 D RMG^SDECRMG(.SDECY,9999999,,"REQUESTTYPE^A|WAITTIME^>=90",,,200)
 S LP=0 F  S LP=$O(@SDECY@(LP)) Q:LP'>0  D
 .S NODRMG=@SDECY@(LP)
 .D ARGET^SDEC(.SDECY1,$P(NODRMG,U,2))
 .D SETNODEP(GBL,$G(@SDECY1@(0)))
 .S NOD=@SDECY1@(1)
 .S SORTSTR=$P(NODRMG,U,3)
 .D SETNODE(SORTSTR,GBL_DLM_$$PC(NOD,7)_DLM_"A",NOD,56)
 .K @SDECY1
 K @SDECY
 Q
 ;
SETNODE(S1,S3,VAL,KEYP) ;EP-
 ; S1   - Sort String
 ; S2   - not used
 ; S3   - GBL | IEN | <request type> ACER
 ; VAL  -
 ; KEYP -
 Q:'$L($D(S1))!'$L($D(S3))
 N KEY
 S KEY=S1_DLM_S3
 S CNT=$G(CNT)+1
 S VAL=$P(VAL,$C(30))
 S:$G(KEYP) $P(VAL,U,KEYP)=KEY
 S ^XTMP("SDEC","IDX","XREF1",S1,0,S3)=CNT
 S ^XTMP("SDEC","IDX","DATA",CNT)=$G(VAL)
 S ^XTMP("SDEC","IDX","XREF2",KEY)=CNT
 Q
 ;
SETXREF(S4,S5,DX,DA,VAL) ;request type specific xref for 1 entry
 ;  S4  = request type A C E or R
 ;  S5  = xref subscript
 ; .DX  = array of subscripts
 ;  DA  = pointer to request type
 ; VAL  = value to set xref to; default to ""
 N SDI,SDSUB
 S VAL=$G(VAL)
 S SDSUB=""
 S SDI="" F  S SDI=$O(DX(SDI)) Q:SDI=""  D
 .S SDSUB=$S(SDSUB'="":SDSUB_",",1:"")_SDI
 S ^XTMP("SDEC","IDX","XREF"_S4,S5,SDSUB,DA)=VAL
 Q
 ;
SETNODEC(CNT) ;EP-
 S ^XTMP("SDEC","IDX","COUNT")=$G(CNT)
 Q
 ;
SETNODEP(GBL,VAL) ;EP-
 Q:'$L($D(GBL))
 S ^XTMP("SDEC","IDX","PATTERNS",GBL)=$P($G(VAL),$C(30))
 Q
 ;
PC(VAL,PIECE,DLM) ;EP-
 S DLM=$G(DLM,U)
 Q $P($G(VAL),DLM,+$G(PIECE))
 ;
 ; Test for tag/routine
TEST(X) ;EP
 N Z
 S:X[U Z=$P(X,U),X=$P(X,U,2)
 Q:'$L(X)!(X'?.1"%"1.AN) 0
 X ^%ZOSF("TEST")
 Q $S('$T:0,$G(Z)="":1,Z'?.1"%"1.AN:0,1:$T(@Z^@X)'="")
 ;
 ; The GETREC entry point is called by the SDECIDX GETREC RPC.
 ; Input: LASTREC - (optional) holds the key to the last call and when passed
 ;                             the next bolus of data will start with the
 ;                             following record.
 ;        MAXREC - (optional) returns 25 records by default
 ;        STYLE -  (optional) (D)ata (default) or (R)ecord pointer.
 ;                  (D)ata returns data in the format specific to the file
 ;                  (R)ecord returns the Type^IEN of the Type file
 ;
GETREC(DATA,LASTREC,MAXREC,STYLE) ;EP-
 N LP,REC,IDX,CNT,DLM
 S DLM="|"
 S DATA=$$TMPGBL
 S LASTREC=$G(LASTREC,"")
 S MAXREC=$G(MAXREC,25)
 S STYLE=$G(STYLE,"D")
 S CNT=0
 I STYLE="D" D
 .S LP=LASTREC F  S LP=$O(^XTMP("SDEC","IDX","XREF2",LP)) Q:LP=""  D  Q:((CNT\2)=MAXREC)
 ..S REC=^(LP)
 ..I $$PC(LP,8,DLM)="R",'$D(^SD(403.5,$$PC(LP,7,DLM),0)) Q    ;record has been moved to RECALL REMINDERS REMOVED
 ..S REC=$P(^XTMP("SDEC","IDX","DATA",REC),$C(30))
 ..S CNT=CNT+1
 ..S @DATA@(CNT)=$G(^XTMP("SDEC","IDX","PATTERNS",$P(LP,DLM,6)))_$C(30)
 ..S CNT=CNT+1
 ..S @DATA@(CNT)=REC_$C(30)
 E  I STYLE="R" D
 .S @DATA@(0)="T00030TYPE^T00030IEN^T00030KEY"_$C(30)
 .S LP=LASTREC F  S LP=$O(^XTMP("SDEC","IDX","XREF2",LP)) Q:LP=""  D  Q:(CNT=MAXREC)
 ..I $$PC(LP,8,DLM)="R",'$D(^SD(403.5,$$PC(LP,7,DLM),0)) Q    ;record has been moved to RECALL REMINDERS REMOVED
 ..I $$PC(LP,8,DLM)="C",$$REQCHK^SDEC51("",$$PC(LP,7,DLM)) Q    ;record has an activity scheduled or has been cancelled
 ..I $$PC(LP,8,DLM)="E",$$GET1^DIQ(409.3,$$PC(LP,7,DLM),23,"I")="C" Q  ;alb/sat 665 - record is closed
 ..I $$PC(LP,8,DLM)="A",$$GET1^DIQ(409.85,$$PC(LP,7,DLM),23,"I")="C" Q  ;alb/sat 665 - record is closed
 ..S CNT=CNT+1
 ..S @DATA@(CNT)=$$PC(LP,8,DLM)_U_$$PC(LP,7,DLM)_U_LP_$C(30)
 S @DATA@(CNT)=$P(@DATA@(CNT),$C(30))_$C(30,31)
 Q
 ;
TMPGBL() ;EP-
 K ^TMP("SDECIDX",$J) Q $NA(^($J))
 ; Convert external dates to FileMan format
CVTDT(VAL) ;EP-
 D DT^DILF(,VAL,.VAL)
 Q VAL
 ; Returns inverse date value
INVDT(VAL) ;EP-
 Q:(VAL<1) VAL
 Q (9999999.9999-VAL)
RECCNT(DATA) ;EP-
 S DATA=+$G(^XTMP("SDEC","IDX","COUNT"))
 Q
