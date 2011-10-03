HLOPRSR3 ;ALB/CJM - Visual Parser 12 JUN 1997 10:00 am ;08/29/2008
 ;;1.6;HEALTH LEVEL SEVEN;**138**;Oct 13, 1995;Build 34
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
SETUP(PARMS,MSG,POS,SEG) ;
 N I,TMP,TOP,BOT,QUIT
 S TMP=$G(PARMS("ARY"))
 Q:'$L(TMP) 0
 S TOP=$G(PARMS("TOP"))
 Q:'TOP 0
 S BOT=$G(PARMS("BOT"))
 Q:'BOT 0
 D PREP^XGF
 ;D TEST^XGKB
 D ENS^%ZISS
 D  I QUIT W !,"Sorry, your terminal is not configured to support this option!",!,"If working from a PC, you might try selecting a VT-series device type" D PAUSE^VALM1 Q 0
 .S QUIT=1
 .Q:'$L(IOXY)
 .Q:'$$TEST^DDBRT
 .S QUIT=0
 S IOTM=1,IOBM=IOSL-11
 I (BOT-TOP)<100 D
 .S MSG="MSG"
 E  D
 .S MSG=$NA(^TMP($J,"HLO MSG"))
 F I=TOP:1:BOT S @MSG@(I-TOP+1)=$G(@TMP@(I,0)) ;get msg from ListManager array
 ;GET DELIMITERS
 S FLD=$E($G(@MSG@(1)),4)
 S DELIM=$P($G(@MSG@(1)),FLD,2)
 S COMP=$E(DELIM,1)
 S REP=$E(DELIM,2)
 S ESC=$E(DELIM,3)
 S SUB=$E(DELIM,4)
 S DELIM=FLD_COMP_REP_SUB
 S SEGTYPE=$E($G(@MSG@(1)),1,3)
 ;get version id
 D
 .N HDR,FS,CS,SUBCOMP,ESCAPE
 .S FS=FLD,CS=COMP,SUBCOMP=SUB,ESCAPE=ESC
 .S I=0
 .F  S I=$O(@MSG@(I)) Q:'I  Q:$G(SEGLINE(I))>1  S HDR(I)=$G(@MSG@(I))
 .D SPLITHDR^HLOSRVR1(.HDR)
 .S VERSION=$$DESCAPE^HLOPRS($P($P(HDR(2),FLD,7),COMP))
 S I=0
 F  S I=$O(PARMS(I)) Q:'I  S SEG(I)=PARMS(I)-TOP+1,SEGLINE(SEG(I))=I
 I $$LINE(1),$$X(1),$$SEG(1)
 D:$$FLD(0)  D:$$REP(0)  D:$$COMP(0)  D:$$SUB(0)
 .;
 S POS("TOP")=1
 S POS("CURRENT DELIMITER")="1^0"
 S POS("NEXT DELIMITER")="1^4"
 S I=0 F  S I=$O(@MSG@(I)) Q:'I  Q:(I>IOBM)  D WRITELN^HLOPRSR1(I,I)
 D IOXY(IOBM+1,1)
 W IORVON,"          Q:quit   ?:help   [Up/Down/Left/Right Arrow]:navigation              ",IORVOFF
 W @IOSTBM
 D DESCRIBE
 D HILITE^HLOPRSR2(1,1,1,3)
 S LASTPART(1)=1,LASTPART(1,1)=1,LASTPART(1,1,1)=1
 S LASTPART(2)=1,LASTPART(2,1)=1,LASTPART(2,1,1)=1
 Q 1
 ;
DESCRIBE ;
 N I,MSG2,VAL
 S DESCRIBE=$S($G(DESCRIBE)="MSG1":"MSG2",1:"MSG1")
 K @DESCRIBE
 S OLD=$S(DESCRIBE="MSG1":"MSG2",1:"MSG1")
 I $L(SEGTYPE) D
 .I $$GETSEG(.VAL,SEGTYPE,$G(VERSION))
 .S @DESCRIBE@(1)=IOINHI_"Segment"_IOINORM_":   #"_$$SEG_"    "_SEGTYPE_"      "_$$LJ(VAL("NAME"),50)
 .Q:$$FLD<1
 .I (SEGTYPE="MSH")!(SEGTYPE="BHS"),($$FLD=1)!($$FLD=2) D
 ..S @DESCRIBE@(2)="  Field Separator:         "_FLD
 ..S @DESCRIBE@(3)="  Component Separator:     "_COMP
 ..S @DESCRIBE@(4)="  Repetition Separator:    "_REP
 ..S @DESCRIBE@(5)="  Escape Character:        "_ESC
 ..S @DESCRIBE@(6)="  Subcomponent Separator:  "_SUB
 .E  D
 ..N REPEAPT
 ..I $$GETFLD(.VAL,SEGTYPE,$G(VERSION),$$FLD)
 ..S @DESCRIBE@(2)=IOINHI_"  Field"_IOINORM_":   #"_$$LJ($$FLD,3)_"  "_$$LJ(VAL("NAME"),47)_$$LJ(" Repetition: #"_$$REP,7)
 ..S REPEAT=VAL("REPETITION")
 ..S REPEAT=$S(REPEAT="False":"no",REPEAT="True":"yes",1:REPEAT)
 ..S @DESCRIBE@(3)="        Repeating: "_$$LJ(REPEAT,4)_"     MaxLength: "_$$LJ(VAL("MAX LENGTH"),5)_"          Item #: "_$$LJ(VAL("ID"),6)
 ..;remove 'optionality' for now, put it back in a future patch
 ..;S @DESCRIBE@(4)="         DataType: "_$$LJ(VAL("DATA TYPE"),3)_"    Optionality: "_$$LJ($$OPTIONAL(VAL("OPTIONALITY")),11)_"     Table:  "_$$LJ(VAL("TABLE"),4)
 ..S @DESCRIBE@(4)="         DataType: "_$$LJ(VAL("DATA TYPE"),3)_"      Table:  "_$$LJ(VAL("TABLE"),4)
 ..D
 ...N NEXT
 ...S NEXT=$E($G(@MSG@(+POS("NEXT DELIMITER"))),$P(POS("NEXT DELIMITER"),"^",2))
 ...I '$$GETCOMP(.VAL,SEGTYPE,$G(VERSION),$$FLD,$$COMP),$$COMP=1,NEXT'=SUB,NEXT'=COMP Q
 ...S @DESCRIBE@(5)=IOINHI_"    Comp"_IOINORM_":  #"_$$LJ($$COMP,4)_" "_$$LJ(VAL("NAME"),50)
 ...;remove 'optionality' for now - put it back in a future patch
 ...;S @DESCRIBE@(6)="         DataType: "_$$LJ(VAL("DATA TYPE"),3)_"    Optionality: "_$$LJ($$OPTIONAL(VAL("OPTIONALITY")),11)_"     Table:  "_$$LJ(VAL("TABLE"),4)
 ...S @DESCRIBE@(6)="         DataType: "_$$LJ(VAL("DATA TYPE"),3)_"     Table:  "_$$LJ(VAL("TABLE"),4)
 ...D
 ....I '$$GETSUB(.VAL,SEGTYPE,$G(VERSION),$$FLD,$$COMP,$$SUB),$$SUB=1,$E($G(@MSG@(+POS("NEXT DELIMITER"))),$P(POS("NEXT DELIMITER"),"^",2))'=SUB Q
 ....S @DESCRIBE@(7)=IOINHI_"      Sub"_IOINORM_": #"_$$LJ($$SUB,21)_" "_$$LJ(VAL("NAME"),50)
 ....;remove 'optionality for now, put it back in a future patch
 ....;S @DESCRIBE@(8)="         DataType: "_$$LJ(VAL("DATA TYPE"),3)_"    Optionality: "_$$LJ($$OPTIONAL(VAL("OPTIONALITY")),11)_"     Table:  "_$$LJ(VAL("TABLE"),4)
 ....S @DESCRIBE@(8)="         DataType: "_$$LJ(VAL("DATA TYPE"),3)_"     Table:  "_$$LJ(VAL("TABLE"),4)
 ..I $$FLD D
 ...N VAL
 ...S VAL=$$DESCAPE^HLOPRS1(VALUE,FLD,COMP,SUB,REP,ESC)
 ...S @DESCRIBE@(10)=IOINHI_"Value"_IOINORM_": "_$S(VAL="""""":"""""  (NULL value)",1:$$LJ(VAL,73))
 E  D
 .F I=1:1:10 S @DESCRIBE@(I)=""
 F I=1:1:10 I ($G(@DESCRIBE@(I))="")!$G(@DESCRIBE@(I))'=$G(@OLD@(I)) D IOXY(IOBM+I+1,1) W $$LJ($G(@DESCRIBE@(I)),80)
 K @OLD
 Q
LJ(STRING,LENGTH) ;
 Q $$LJ^XLFSTR(STRING,LENGTH)
 ;
GETSEG(VALUE,SEG,VERSION) ;
 N NODE
 S VALUE("NAME")=""
 S SEGIEN=""
 S:$L($G(VERSION)) SEGIEN=$O(^HLD(779.5,"C",SEG,VERSION,0))
 S:'SEGIEN SEGIEN=$O(^HLD(779.5,"B",SEG,999999),-1)
 Q:'SEGIEN 0
 S NODE=$G(^HLD(779.5,SEGIEN,0))
 S VALUE("NAME")=$P(NODE,"^",2)
 Q 1
GETFLD(VALUE,SEG,VERSION,FLD) ;
 K VALUES
 N NODE,SEGIEN,FLDIEN
 F NODE="NAME","DATA TYPE","MAX LENGTH","REPETITION","OPTIONALITY","TABLE","ID" S VALUE(NODE)=""
 S SEGIEN=""
 S:$L($G(VERSION)) SEGIEN=$O(^HLD(779.5,"C",SEG,VERSION,0))
 S:'SEGIEN SEGIEN=$O(^HLD(779.5,"B",SEG,999999),-1)
 Q:'SEGIEN 0
 S FLDIEN=$O(^HLD(779.5,SEGIEN,1,"B",FLD,0))
 Q:'FLDIEN 0
 S NODE=$G(^HLD(779.5,SEGIEN,1,FLDIEN,0))
 S VALUE("NAME")=$P(NODE,"^",2)
 S VALUE("MAX LENGTH")=$P(NODE,"^",3)
 S VALUE("DATA TYPE")=$P(NODE,"^",4)
 S VALUE("OPTIONALITY")=$P(NODE,"^",5)
 S VALUE("REPETITION")=$P(NODE,"^",6)
 S VALUE("TABLE")=$P(NODE,"^",7)
 S VALUE("ID")=$P(NODE,"^",8)
 Q 1
GETCOMP(VALUE,SEG,VERSION,FLD,COMP) ;
 K VALUES
 N NODE,SEGIEN,FLDIEN,COMPIEN
 F NODE="NAME","DATA TYPE","OPTIONALITY","TABLE" S VALUE(NODE)=""
 S SEGIEN=""
 S:$L($G(VERSION)) SEGIEN=$O(^HLD(779.5,"C",SEG,VERSION,0))
 S:'SEGIEN SEGIEN=$O(^HLD(779.5,"B",SEG,999999),-1)
 Q:'SEGIEN 0
 S FLDIEN=$O(^HLD(779.5,SEGIEN,1,"B",FLD,0))
 Q:'FLDIEN 0
 S COMPIEN=$O(^HLD(779.5,SEGIEN,1,FLDIEN,2,"B",COMP,0))
 Q:'COMPIEN 0
 S NODE=$G(^HLD(779.5,SEGIEN,1,FLDIEN,2,COMPIEN,0))
 S VALUE("NAME")=$P(NODE,"^",2)
 S VALUE("DATA TYPE")=$P(NODE,"^",3)
 S VALUE("OPTIONALITY")=$P(NODE,"^",4)
 S VALUE("TABLE")=$P(NODE,"^",7)
 Q 1
GETSUB(VALUE,SEG,VERSION,FLD,COMP,SUB) ;
 K VALUES
 N NODE,SEGIEN,FLDIEN,COMPIEN,SUBIEN
 F NODE="NAME","DATA TYPE","OPTIONALITY","TABLE" S VALUE(NODE)=""
 S SEGIEN=""
 S:$L($G(VERSION)) SEGIEN=$O(^HLD(779.5,"C",SEG,VERSION,0))
 S:'SEGIEN SEGIEN=$O(^HLD(779.5,"B",SEG,999999),-1)
 Q:'SEGIEN 0
 S FLDIEN=$O(^HLD(779.5,SEGIEN,1,"B",FLD,0))
 Q:'FLDIEN 0
 S COMPIEN=$O(^HLD(779.5,SEGIEN,1,FLDIEN,2,"B",COMP,0))
 Q:'COMPIEN 0
 S SUBIEN=$O(^HLD(779.5,SEGIEN,1,FLDIEN,2,COMPIEN,3,"B",SUB,0))
 Q:'SUBIEN 0
 S NODE=$G(^HLD(779.5,SEGIEN,1,FLDIEN,2,COMPIEN,3,SUBIEN,0))
 S VALUE("NAME")=$P(NODE,"^",2)
 S VALUE("DATA TYPE")=$P(NODE,"^",3)
 S VALUE("OPTIONALITY")=$P(NODE,"^",4)
 S VALUE("TABLE")=$P(NODE,"^",7)
 Q 1
HELP ;
 N I
 S DESCRIBE="MSG1"
 K MSG1,MSG2
 S MSG1(1)="Navigation Keys"
 S MSG(2)=""
 S MSG1(3)=IOINHI_"[Left Arrow] [Right Arrow]"_IOINORM_"  : move left and right through a segment"
 S MSG1(4)=IOINHI_"[Up Arrow] [Down Arrow]"_IOINORM_"     : move up and down through the segments"
 S MSG1(5)=IOINHI_"[Q]"_IOINORM_"                         : quit the parser"
 S MSG1(6)=IOINHI_"[?]"_IOINORM_"                         : help for navigation keys"
 F I=1:1:10 D IOXY(IOBM+I+1,1) W $$LJ($G(MSG1(I)),80)
 D IOXY($$Y(+POS("CURRENT DELIMITER")),$$X($P(POS("CURRENT DELIMITER"),"^",2)))
 Q
 ;
LINE(TO,INC) ;msg line
 Q $$LINE^HLOPRSR1(.TO,.INC)
 ;
X(TO,INC) ;current position within the line
 ;
  Q $$X^HLOPRSR1(.TO,.INC)
Y(LINE) ;screen line of msg line = LINE
 Q $$Y^HLOPRSR1(.LINE)
SEG(INC) ;returns the current segement #
 Q $$SEG^HLOPRSR1(.INC)
FLD(SET) ;returns the currrent field #
 Q $$FLD^HLOPRSR1(.SET)
REP(SET) ;returns the current repetition #
 Q $$REP^HLOPRSR1(.SET)
COMP(SET) ;returns the current component #
 Q $$COMP^HLOPRSR1(.SET)
 ;
SUB(SET) ;returns the current sub-component #
 Q $$SUB^HLOPRSR1(.SET)
 ;
SEGSTART(SEGMENT) ;
 Q $$SEGSTART^HLOPRSR1(.SEGMENT)
 ;
IOXY(Y,X) ; moves to screen position line=Y, col=X
 D IOXY^HLOPRSR1(.Y,.X)
 Q
OPTIONAL(CODE) ;
 ;changes the code into text
 Q:CODE="" ""
 Q:CODE="O" "optional"
 Q:CODE="R" "required"
 Q:CODE="C" "conditional"
 Q:CODE="B" "obsolete"
 Q:CODE="X" "N/A"
 Q ""
