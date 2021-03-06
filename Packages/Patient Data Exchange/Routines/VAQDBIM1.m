VAQDBIM1 ;ALB/JRP - MEANS TEST EXTRACTION (SCREEN 1);28-FEB-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
 ; **********
 ; * PARTS OF THIS ROUTINE HAVE BEEN COPIED AND ALTERED FROM THE
 ; * DGMTSC* ROUTINES.  FOR MODULES THIS WAS DONE FOR, A REFERENCE
 ; * TO THE DGMTSC* ROUTINE WILL BE INCLUDE.
 ; **********
 ;
XTRCT1(DFN,ARRAY,OFFSET) ;EXTRACT SCREEN 1
 ;MARITAL STATUS/DEPENDENT INFORMATION
 ;This module is based on DIS^DGMTSC1
 ;
 ;INPUT  : See EXTRACT^VAQDBIM for explanation of parameters.  Input
 ;         also includes all DG* variables required to build screen.
 ;OUTPUT : n - Number of lines in display
 ;         -1^Error_text - Error
 ;
 ;CHECK INPUT
 Q:('$D(DFN)) "-1^Pointer to patient file not passed"
 Q:('$D(ARRAY)) "-1^Reference to output array not passed"
 Q:('$D(OFFSET)) "-1^Starting offset not passed"
 ;DECLARE VARIABLES
 N DGDEP,DGINR,DGREL,DGVIR0,X,TMP,COUNT,LINES
 ;EXTRACT HEADER
 S LINES=OFFSET
 S TMP=$$HEADER^VAQDBIM0(1,ARRAY,OFFSET)
 Q:(TMP<0) TMP
 S OFFSET=LINES+TMP
 ;INITIALIZE MEANS TEST VARIABLES
 D ALL^DGMTU21(DFN,"CS",DGMTDT,"PR")
 S DGVIR0=$G(^DGMT(408.22,DGVIRI,0))
 ;EXTRACT MARITAL STATUS INFORMATION
 S @ARRAY@("DISPLAY",OFFSET,0)=$$INSERT^VAQUTL1("Was marital status married or separated on Dec 31st last year: ","",5)_$$YN^DGMTSCU1($P(DGVIR0,"^",5))
 S OFFSET=OFFSET+1
 S @ARRAY@("DISPLAY",OFFSET,0)=$$INSERT^VAQUTL1("Did you live with your spouse last year: ","",27)_$S($P(DGVIR0,"^",5)=0:"N/A",1:$$YN^DGMTSCU1($P(DGVIR0,"^",6)))
 S OFFSET=OFFSET+1
 S @ARRAY@("DISPLAY",OFFSET,0)=$$INSERT^VAQUTL1("Amount contributed to spouse: ","",38)_$S($P(DGVIR0,"^",5)=0!($P(DGVIR0,"^",6)):"N/A",1:$$AMT^DGMTSCU1($P(DGVIR0,"^",7)))
 S OFFSET=OFFSET+1
 I $P(DGVIR0,"^",5),$D(DGREL("S")) D
 .;SPOUSE'S INFORMATION
 .S @ARRAY@("DISPLAY",OFFSET,0)=""
 .S OFFSET=OFFSET+1
 .S TMP=$$INSERT^VAQUTL1("Spouse's Name: ","",5)_$E($$NAME^DGMTU1(+DGREL("S")),1,15)
 .S X="SSN: "_$$SSN^DGMTU1(+DGREL("S"))
 .S TMP=$$INSERT^VAQUTL1(X,TMP,37)
 .S X="DOB: "_$$DOB^DGMTU1(+DGREL("S"))
 .S TMP=$$INSERT^VAQUTL1(X,TMP,57)
 .S @ARRAY@("DISPLAY",OFFSET,0)=TMP
 .S OFFSET=OFFSET+1
 S @ARRAY@("DISPLAY",OFFSET,0)=""
 S OFFSET=OFFSET+1
 ;EXTRACT DEPENDENT CHILDREN INFORMATION
 S TMP=$$INSERT^VAQUTL1("Dependent Children: ","",5)
 S @ARRAY@("DISPLAY",OFFSET,0)=TMP_$$YN^DGMTSCU1($P(DGVIR0,"^",8))
 S OFFSET=OFFSET+1
 I $P(DGVIR0,"^",8) D
 .;EXTRACT INFORMATION FOR ALL DEPENDENT CHILDREN
 .S @ARRAY@("DISPLAY",OFFSET,0)=""
 .S OFFSET=OFFSET+1
 .;COLUMN HEADINGS
 .S TMP=$$INSERT^VAQUTL1("Child's","",9)
 .S TMP=$$INSERT^VAQUTL1("Incapable of",TMP,22)
 .S TMP=$$INSERT^VAQUTL1("Child lived",TMP,35)
 .S TMP=$$INSERT^VAQUTL1("Child",TMP,47)
 .S TMP=$$INSERT^VAQUTL1("Child's",TMP,58)
 .S TMP=$$INSERT^VAQUTL1("Income",TMP,69)
 .S @ARRAY@("DISPLAY",OFFSET,0)=TMP
 .S OFFSET=OFFSET+1
 .S TMP=$$INSERT^VAQUTL1("First Name","",9)
 .S TMP=$$INSERT^VAQUTL1("Self-support",TMP,22)
 .S TMP=$$INSERT^VAQUTL1("with you",TMP,35)
 .S TMP=$$INSERT^VAQUTL1("Support",TMP,47)
 .S TMP=$$INSERT^VAQUTL1("Income",TMP,58)
 .S TMP=$$INSERT^VAQUTL1("Available",TMP,69)
 .S @ARRAY@("DISPLAY",OFFSET,0)=TMP
 .S OFFSET=OFFSET+1
 .S TMP=""
 .F COUNT=9,22,35,47,58,69 S TMP=$$INSERT^VAQUTL1("----------",TMP,COUNT)
 .S @ARRAY@("DISPLAY",OFFSET,0)=TMP
 .S OFFSET=OFFSET+1
 .;EXTRACT INFORMATION
 .S COUNT=0
 .F  S COUNT=$O(DGREL("C",COUNT)) Q:'COUNT  D CHILD
 .Q
 Q (OFFSET-LINES)
 ;
CHILD ;EXTRACT DATA COLLECTED FOR A DEPENDENT CHILD
 ;This module is based on CHILD^DGMTSC11
 ;DECLARE VARIABLES
 N DGIR0,TMP
 ;INITIALIZE MEANS TEST VARIABLE
 S DGIR0=$G(^DGMT(408.22,+$G(DGINR("C",COUNT)),0))
 ;EXTRACT INFORMATION
 S TMP=$$INSERT^VAQUTL1((COUNT_"."),"",5)
 S TMP=$$INSERT^VAQUTL1($E($P($$NAME^DGMTU1(+DGREL("C",COUNT)),",",2),1,12),TMP,9)
 S TMP=$$INSERT^VAQUTL1($$YN^DGMTSCU1($P(DGIR0,"^",9)),TMP,22)
 S TMP=$$INSERT^VAQUTL1($$YN^DGMTSCU1($P(DGIR0,"^",6)),TMP,35)
 S TMP=$$INSERT^VAQUTL1($S($P(DGIR0,"^",6):"N/A",1:$$YN^DGMTSCU1($P(DGIR0,"^",10))),TMP,47)
 S TMP=$$INSERT^VAQUTL1($$YN^DGMTSCU1($P(DGIR0,"^",11)),TMP,58)
 S TMP=$$INSERT^VAQUTL1($S($P(DGIR0,"^",11)=0:"N/A",1:$$YN^DGMTSCU1($P(DGIR0,"^",12))),TMP,69)
 S @ARRAY@("DISPLAY",OFFSET,0)=TMP
 S OFFSET=OFFSET+1
 Q
