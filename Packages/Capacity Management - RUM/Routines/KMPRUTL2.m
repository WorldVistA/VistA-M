KMPRUTL2 ;OAK/RAK - RUM Data for All Nodes (Graph) ;5/28/03  09:15
 ;;2.0;CAPACITY MANAGEMENT - RUM;;May 28, 2003
 ;
ELEMDATA(KMPRELMT,KMPRST,KMPREN,KMPRNODE,KMPRARRY,KMPRQIET) ;-- elements
 ; compile rum element stats.
 ;-----------------------------------------------------------------------
 ; KMPRELMT... Element.  This represents the ^piece of where the 
 ;             element data is located in file 8971.1.
 ;             Example: 5 would be piece 5 of node 1 - M COMMANDS (PT)
 ;                              or piece 5 of node 2 - M COMMANDS (NP)
 ; KMPRST..... Start date in internal fileman format.
 ; KMPREN..... End date in internal fileman format.
 ; KMPRNODE... Array (passed by reference) containing name of nodes to
 ;             process in format:  KMPRNODE("NODENAME")="" 
 ; KMPRARRY... Array (passed by value) that will contain results of 
 ;             search in format:
 ;             KMPRARRY(KMPRNODE,DATE)=element/per second
 ;             where DATE will be in internal filemat format.
 ; KMPRQIET... Output date/dots during search.
 ;             0 - not quiet.
 ;             1 - quiet.
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPRELMT)
 Q:'$G(KMPRST)
 Q:'$G(KMPREN)
 Q:'$D(KMPRNODE)
 Q:$G(KMPRARRY)=""
 S KMPRQIET=+$G(KMPRQIET)
 ;
 K @KMPRARRY
 ;
 N DATE,DATA,DCOUNT,END,IEN,NODE,OCCURR,OPTION,START
 ;
 ; DATE.... Current date being processed.
 ; END..... Ending date.
 ; NODE.... Computer node.
 ; OCCURR.. # of Occurrences
 ; OPTION.. Option name.
 ; START... Starting date.
 ;
 S END=KMPREN,START=KMPRST
 S DATE=START-.1,OCCURR=0
 F  S DATE=$O(^KMPR(8971.1,"B",DATE)) Q:'DATE!(DATE>END)  D 
 .I 'KMPRQIET W:$X>68 !?23 W $$FMTE^XLFDT(DATE,5),"."
 .S IEN=0
 .F  S IEN=$O(^KMPR(8971.1,"B",DATE,IEN)) Q:'IEN  D 
 ..I 'KMPRQIET&('(IEN#1000)) W:$X>78 !?23 W "."
 ..Q:'$D(^KMPR(8971.1,IEN,0))  S DATA(0)=^(0),DATA(1)=$G(^(1)),DATA(2)=$G(^(2))
 ..S NODE=$P(DATA(0),U,3) Q:NODE=""
 ..Q:'$D(KMPRNODE(NODE))
 ..S @KMPRARRY@(NODE,DATE)=$G(@KMPRARRY@(NODE,DATE))+$P(DATA(1),U,+KMPRELMT)
 ..S @KMPRARRY@(NODE,DATE)=$G(@KMPRARRY@(NODE,DATE))+$P(DATA(2),U,+KMPRELMT)
 ..; count occurrences.
 ..S OCCURR=OCCURR+$P(DATA(1),U,8)+$P(DATA(2),U,8)
 ;
 ; calculate element per second or per occurrence.
 S NODE=""
 F  S NODE=$O(@KMPRARRY@(NODE)) Q:NODE=""  S DATE="" D 
 .F  S DATE=$O(@KMPRARRY@(NODE,DATE)) Q:'DATE  D 
 ..; elements 1 and 7 are per Occurrence.
 ..I KMPRELMT=1!(KMPRELMT=7) D 
 ...S @KMPRARRY@(NODE,DATE)=$FN(@KMPRARRY@(NODE,DATE)/(OCCURR),"",2)
 ..; all other elements are per second.
 ..E  S @KMPRARRY@(NODE,DATE)=$FN(@KMPRARRY@(NODE,DATE)/(24*3600),"",2)
 ;
 Q
 ;
PKGDATA(KMPRPKG,KMPRSTR,KMPREND,KMPRARRY,KMPRQIET) ;-- package data.
 ;-----------------------------------------------------------------------
 ; KMPRPKG... Package name (case sensitive, free text).
 ; KMPRSTR... Start date in internal fileman format.
 ; KMPREND... End date in internal fileman format.
 ; KMPRARRY.. Array to hold data (by value).
 ; KMPRQIET.. Output date/dots during search.
 ;            0 - not quiet.
 ;            1 - quiet.
 ;-----------------------------------------------------------------------
 ;
 Q:$G(KMPRPKG)=""!($G(KMPRPKG)="^")
 Q:'$G(KMPRSTR)
 Q:'$G(KMPREND)
 Q:$G(KMPRARRY)=""
 S KMPRQIET=+$G(KMPRQIET)
 ;
 N DATE,DESIG,HL7,I,IEN,NODE,OPTION,PROTOCOL,RPC,TOTALS,TYP
 ;
 S DATE=KMPRSTR-.1
 F  S DATE=$O(^KMPR(8971.1,"B",DATE)) Q:'DATE!(DATE>KMPREND)  S IEN=0 D 
 .I 'KMPRQIET W:$X>68 !?23 W $$FMTE^XLFDT(DATE,5),"."
 .F  S IEN=$O(^KMPR(8971.1,"B",DATE,IEN)) Q:'IEN  D 
 ..I 'KMPRQIET&('(IEN#1000)) W:$X>78 !?23 W "."
 ..Q:'$D(^KMPR(8971.1,IEN,0))  S DATA(0)=^(0),DATA(1)=$G(^(1)),DATA(2)=$G(^(2))
 ..S NODE=$P(DATA(0),U,3) S:NODE="" NODE="N/A"
 ..S OPTION=$P(DATA(0),U,4) S:OPTION="" OPTION="N/A"
 ..S PROTOCOL=$P(DATA(0),U,5)
 ..S RPC=$P(DATA(0),U,7)
 ..S HL7=$P(DATA(0),U,9)
 ..; rum designation: 1 - TASKMAN
 ..;                  2 - USER
 ..;                  3 - BROKER
 ..;                  4 - HL7
 ..;                  5 OTHER
 ..S DESIG=$P(DATA(0),U,8)
 ..;
 ..; TYP: KMPRPKG. options within namespace
 ..;      HL7..... hl7 within namespace.
 ..;      RPC..... rpc within namespace
 ..;      PRTCL... protocol within namespace
 ..;      TASK.... tasked option within namespace
 ..;      OTH..... all other options/protocols
 ..;
 ..S TYP="OTH"
 ..; if option is in namespace.
 ..I $E(OPTION,1,$L(KMPRPKG))=KMPRPKG S TYP=KMPRPKG
 ..; if option in namespace and protocol was called.
 ..I TYP=KMPRPKG I PROTOCOL]"" S TYP="PRTCL"
 ..; if option in namespace and tasked.
 ..I TYP=KMPRPKG&(DESIG=1)&($E(OPTION,1,$L(KMPRPKG))=KMPRPKG) S TYP="TASK"
 ..; if broker and in namespace.
 ..I DESIG=3&($E(RPC,1,$L(KMPRPKG))=KMPRPKG) S TYP="RPC"
 ..; if hl7 and in namespace.
 ..I DESIG=4&($E(HL7,1,$L(KMPRPKG))=KMPRPKG) S TYP="HL7"
 ..; get current totals (if any).
 ..S TOTALS=$G(@KMPRARRY@(NODE,TYP))
 ..; add prime time and non-prime time totals
 ..F I=1:1:8 D 
 ...S $P(@KMPRARRY@(NODE,TYP),U,I)=$P($G(@KMPRARRY@(NODE,TYP)),U,I)+$P(DATA(1),U,I)
 ...S $P(@KMPRARRY@(NODE,TYP),U,I)=$P($G(@KMPRARRY@(NODE,TYP)),U,I)+$P(DATA(2),U,I)
 ...S $P(@KMPRARRY@(NODE,"TOTALS"),U,I)=$P($G(@KMPRARRY@(NODE,"TOTALS")),U,I)+$P(DATA(1),U,I)
 ...S $P(@KMPRARRY@(NODE,"TOTALS"),U,I)=$P($G(@KMPRARRY@(NODE,"TOTALS")),U,I)+$P(DATA(2),U,I)
 ;
 Q
