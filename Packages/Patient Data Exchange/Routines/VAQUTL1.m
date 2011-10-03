VAQUTL1 ;ALB/JRP - UTILITY ROUTINES;30-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
REPEAT(CHAR,TIMES) ;REPEAT A STRING
 ;INPUT  : CHAR - Character to repeat
 ;         TIMES - Number of times to repeat CHAR
 ;OUTPUT : s - String of CHAR that is TIMES long
 ;         "" - Error (bad input)
 ;
 ;CHECK INPUT
 Q:($G(CHAR)="") ""
 Q:((+$G(TIMES))=0) ""
 ;RETURN STRING
 Q $TR($J("",TIMES)," ",CHAR)
INSERT(INSTR,OUTSTR,COLUMN,LENGTH) ;INSERT A STRING INTO ANOTHER
 ;INPUT  : INSTR - String to insert
 ;         OUTSTR - String to insert into
 ;         COLUMN - Where to begin insertion (defaults to end of OUTSTR)
 ;         LENGTH - Number of characters to clear from OUTSTR
 ;                  (defaults to length of INSTR)
 ;OUTPUT : s - INSTR will be placed into OUTSTR starting at COLUMN
 ;             using LENGTH characters
 ;         "" - Error (bad input)
 ;
 ;NOTE : This module is based on $$SETSTR^VALM1
 ;
 ;CHECK INPUT
 Q:('$D(INSTR)) ""
 Q:('$D(OUTSTR)) ""
 S:('$D(COLUMN)) COLUMN=$L(OUTSTR)+1
 S:('$D(LENGTH)) LENGTH=$L(INSTR)
 ;DECLARE VARIABLES
 N FRONT,END
 S FRONT=$E((OUTSTR_$J("",COLUMN-1)),1,(COLUMN-1))
 S END=$E(OUTSTR,(COLUMN+LENGTH),$L(OUTSTR))
 ;INSERT STRING
 Q FRONT_$E((INSTR_$J("",LENGTH)),1,LENGTH)_END
KILLARR(ARRAY,NODE,START,END) ;KILL NODES OF AN ARRAY
 ;INPUT  : ARRAY - Array to kill nodes in (full global reference)
 ;         NODE - Subscript to kill (optional)
 ;         START - Subscript to start killing at (default to first)
 ;         END - Subscript to stop killing at (default to all)
 ;OUTPUT : 0 - Success
 ;        -1 - Error
 ;
 ;NOTES:
 ;  If NODE is passed KILLing takes place at
 ;     @ARRAY@(NODE,x)
 ;  If NODE is not passed KILLing takes place at
 ;     @ARRAY@(x)
 ;
 ;  If START is passed KILLing starts at
 ;     @ARRAY@([NODE,]START)
 ;  If START is not passed KILLing starts on first node after
 ;     @ARRAY@([NODE,],"")
 ;
 ;  If END is passed KILLing ends on first node after
 ;     @ARRAR@([NODE,],END)
 ;  If END is not passed KILLing ends on first node after
 ;     @ARRAY@([NODE])
 ;CHECK INPUT
 Q:($G(ARRAY)="") -1
 S NODE=$G(NODE)
 S START=$G(START)
 S END=$G(END)
 ;DECLARE VARIABLES
 N LOOP,SUBSCRPT
 ;KILL STARTING SUBSCRIPT
 I (START'="")&(NODE'="") K @ARRAY@(NODE,START)
 I (START'="")&(NODE="") K @ARRAY@(START)
 ;KILL NODES
 F LOOP=0:0 D  Q:(SUBSCRPT="")
 .I (NODE="") S SUBSCRPT=$O(@ARRAY@(START))
 .I (NODE'="") S SUBSCRPT=$O(@ARRAY@(NODE,START))
 .Q:(SUBSCRPT="")
 .I (NODE="") K @ARRAY@(SUBSCRPT)
 .I (NODE'="") K @ARRAY@(NODE,SUBSCRPT)
 .S:(SUBSCRPT=END) SUBSCRPT=""
 Q 0
PATINFO(DFN) ;RETURNS PATIENT NAME, SSN, DOB, PATIENT ID
 ;INPUT  : DFN - Pointer to patient in PATIENT file
 ;OUTPUT : Name^SSN^DOB^PID - Success
 ;        -1^Error_Text - Error
 ;NOTES  : SSN returned without dashes
 ;         DOB returned in external format
 ;
 ;CHECK INPUT
 S DFN=+$G(DFN)
 Q:('DFN) "-1^Pointer to PATIENT file not passed"
 ;DECLARE VARIABLES
 N VAPTYP,VAHOW,VAROOT,VAERR,VA,TMP,Y,%DT
 S VAHOW=2
 K ^UTILITY("VADM",$J)
 D DEM^VADPT
 Q:(VAERR) "-1^Unable to gather patient information"
 S TMP=^UTILITY("VADM",$J,1)
 S $P(TMP,"^",2)=$P(^UTILITY("VADM",$J,2),"^",1)
 S Y=+^UTILITY("VADM",$J,3) D DD^%DT S $P(TMP,"^",3)=Y
 S $P(TMP,"^",4)=VA("PID")
 K ^UTILITY("VADM",$J)
 Q TMP
 ;
PDXVER() ;RETURN VERSION OF PDX IN USE
 ;INPUT  : None
 ;OUTPUT : N - Version of PDX in use at facility
 ;        -1^Error_Text - Error
 ;
 ;DECLARE VARIABLES
 N X,Y
 S X=+$G(^DD(394.61,0,"VR"))
 S Y=$D(^DD(394))
 ;NOT INSTALLED
 Q:(('X)&('Y)) "-1^PDX has not been installed"
 ;VERSION 1.0
 Q:(('X)&(Y)) "1.0"
 ;VERSION 1.5 AND UP
 Q X
 ;
APDX ;CONTINUATION OF APDX X-REF ON *PDX TRANSACTION FILE (# 394)
 ;  THIS IS LEFT OVER FROM VERSION 1.0 - INCLUDED TO PASS %INDEX
 S:($P(^VAT(394,DA,0),U,12)=VAQ15)!($P(^(0),U,12)=VAQ16) ^VAT(394,"APDX",$P(^(0),U,4),X,(9999999.999999-$P(^(0),U,1)),DA)=""
 K:VAQTMP=1 VAQ15,VAQ16 K VAQTMP
 Q
