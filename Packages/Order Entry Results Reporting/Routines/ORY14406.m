ORY14406 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*144) ;JUN 12,2002 at 12:20
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**144**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY144ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY14407
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"860.8:",100,54
 ;;D^  ; ..N OCXGR2
 ;;R^"860.8:",100,55
 ;;D^  ; ..S OCXGR2=OCXGR1_","_OCXELE_",1"
 ;;R^"860.8:",100,56
 ;;D^  ; ..K OCXDATA
 ;;R^"860.8:",100,57
 ;;D^  ; ..S OCXDATA(OCXDFI,0)=OCXDFI
 ;;R^"860.8:",100,58
 ;;D^  ; ..S OCXDATA(OCXDFI,"VAL")=^TMP("OCXCHK",$J,OCXDFN,OCXELE,OCXDFI)
 ;;R^"860.8:",100,59
 ;;D^  ; ..S OCXDATA("B",OCXDFI,OCXDFI)=""
 ;;R^"860.8:",100,60
 ;;D^T+; ..D SETAP(OCXGR2_")","860.71223P","Data Field",$P($G(^OCXS(860.4,OCXDFI,0)),U,1),.OCXDATA,OCXDFI)
 ;;R^"860.8:",100,61
 ;;D^T-; ..D SETAP(OCXGR2_")","860.71223P",.OCXDATA,OCXDFI)
 ;;R^"860.8:",100,62
 ;;D^  ; ;
 ;;R^"860.8:",100,63
 ;;D^  ; Q 1
 ;;R^"860.8:",100,64
 ;;D^  ; ;
 ;;R^"860.8:",100,65
 ;;D^T+;SETAP(ROOT,DD,ITEM,ITEMNAME,DATA,DA) ;  Set Rule Event data
 ;;R^"860.8:",100,66
 ;;D^T-;SETAP(ROOT,DD,DATA,DA) ;  Set Rule Event data
 ;;R^"860.8:",100,67
 ;;D^  ; M @ROOT=DATA
 ;;R^"860.8:",100,68
 ;;D^  ; I +$G(DD) S @ROOT@(0)="^"_($G(DD))_"^"_($P($G(@ROOT@(0)),U,3)+1)_"^"_$G(DA)
 ;;R^"860.8:",100,69
 ;;D^  ; I '$G(DD) S $P(@ROOT@(0),U,3,4)=($P($G(@ROOT@(0)),U,3)+1)_"^"_$G(DA)
 ;;R^"860.8:",100,70
 ;;D^T+; W:$G(OCXTRACE) !,"File Active Data ",$G(ITEM),": ",$G(ITEMNAME)
 ;;R^"860.8:",100,71
 ;;D^  ; ;
 ;;R^"860.8:",100,72
 ;;D^  ; Q
 ;;R^"860.8:",100,73
 ;;D^  ; ;
 ;;R^"860.8:",100,74
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^ORDERABLE ITEM
 ;;R^"860.8:",.01,"E"
 ;;D^ORDERABLE ITEM
 ;;R^"860.8:",.02,"E"
 ;;D^OI
 ;;R^"860.8:",1,1
 ;;D^Extrinsic function returns the orderable item for an order number.
 ;;R^"860.8:",100,1
 ;;D^    ;OI(OCXOR) ;func rtns orderable item for an order number (OCXOR)
 ;;R^"860.8:",100,2
 ;;D^    ; Q:+$G(OCXOR)<1 ""
 ;;R^"860.8:",100,3
 ;;D^    ; N OCXOI S OCXOI=""
 ;;R^"860.8:",100,4
 ;;D^    ; S OCXOI=+$G(^OR(100,+$G(OCXOR),.1,1,0))
 ;;R^"860.8:",100,5
 ;;D^    ; Q OCXOI
 ;;R^"860.8:",100,6
 ;;D^    ; ;
 ;;EOR^
 ;;KEY^860.8:^RECENT CREATININE LAB PROCEDURE
 ;;R^"860.8:",.01,"E"
 ;;D^RECENT CREATININE LAB PROCEDURE
 ;;R^"860.8:",.02,"E"
 ;;D^RECCREAT
 ;;R^"860.8:",100,1
 ;;D^   ;RECCREAT(ORDFN,ORDAYS)  ;extrinsic function to return most recent 
 ;;R^"860.8:",100,2
 ;;D^   ; ;SERUM CREATININE within <ORDAYS> in format:
 ;;R^"860.8:",100,3
 ;;D^   ; ; test id^result units flag ref range collection d/t
 ;;R^"860.8:",100,4
 ;;D^   ; N BDT,CDT,ORY,ORX,ORZ,X,ORI,ORJ,CREARSLT,LABFILE,SPECFILE
 ;;R^"860.8:",100,5
 ;;D^   ; Q:'$L($G(ORDFN)) "0^"
 ;;R^"860.8:",100,6
 ;;D^   ; Q:'$L($G(ORDAYS)) "0^"
 ;;R^"860.8:",100,7
 ;;D^   ; D NOW^%DTC
 ;;R^"860.8:",100,8
 ;;D^   ; S BDT=$$FMADD^XLFDT(%,"-"_ORDAYS,"","","")
 ;;R^"860.8:",100,9
 ;;D^   ; K %
 ;;R^"860.8:",100,10
 ;;D^   ; Q:'$L($G(BDT)) "0^"
 ;;R^"860.8:",100,11
 ;;D^   ; S LABFILE=$$TERMLKUP("SERUM CREATININE",.ORY)
 ;;R^"860.8:",100,12
 ;;D^   ; Q:$G(LABFILE)'=60 "0^"
 ;;R^"860.8:",100,13
 ;;D^   ; Q:+$D(ORY)<1 "0^"
 ;;R^"860.8:",100,14
 ;;D^   ; S SPECFILE=$$TERMLKUP("SERUM SPECIMEN",.ORX)
 ;;R^"860.8:",100,15
 ;;D^   ; Q:$G(SPECFILE)'=61 "0^"
 ;;R^"860.8:",100,16
 ;;D^   ; Q:+$D(ORX)<1 "0^"
 ;;R^"860.8:",100,17
 ;;D^   ; S ORI=0 F  S ORI=$O(ORY(ORI)) Q:'ORI  I +$G(CREARSLT)<1 D
 ;;R^"860.8:",100,18
 ;;D^   ; .S ORJ=0 F  S ORJ=$O(ORX(ORJ)) Q:'ORJ  I +$G(CREARSLT)<1 D
 ;;R^"860.8:",100,19
 ;;D^   ; ..S ORZ=$$LOCL^ORQQLR1(ORDFN,ORI,ORJ)
 ;;R^"860.8:",100,20
 ;;D^   ; ..Q:'$L($G(ORZ))
 ;;R^"860.8:",100,21
 ;;D^   ; ..S CDT=$P(ORZ,U,7)
 ;;R^"860.8:",100,22
 ;;D^   ; ..I CDT'<BDT S CREARSLT=1
 ;;R^"860.8:",100,23
 ;;D^   ; Q:+$G(CREARSLT)<1 "0^"
 ;;R^"860.8:",100,24
 ;;D^   ; Q $P(ORZ,U)_U_$P(ORZ,U,3)_" "_$P(ORZ,U,4)_" "_$P(ORZ,U,5)_" ("_$P(ORZ,U,6)_")  "_$$FMTE^XLFDT(CDT,"2P")_U_$P(ORZ,U,3)
 ;;EOR^
 ;;KEY^860.8:^RETURN POINTED TO VALUE
 ;;R^"860.8:",.01,"E"
 ;;D^RETURN POINTED TO VALUE
 ;;R^"860.8:",.02,"E"
 ;;D^POINTER
 ;;R^"860.8:",1,1
 ;;D^  ;POINTER(OCXFILE,D0) ;    This Local Extrinsic Function gets the value of the name field
 ;;R^"860.8:",1,2
 ;;D^  ; ;  of record D0 in file OCXFILE
 ;;R^"860.8:",100,1
 ;;D^  ;POINTER(OCXFILE,D0) ;    This Local Extrinsic Function gets the value of the name field
 ;;R^"860.8:",100,2
 ;;D^  ; ;  of record D0 in file OCXFILE
 ;;R^"860.8:",100,3
 ;;D^T+; I $G(OCXTRACE) W !,"%%%%",?20,"   FILE: ",$G(OCXFILE),"  D0: ",$G(D0)
 ;;R^"860.8:",100,4
 ;;D^  ; Q:'$G(D0) "" Q:'$L($G(OCXFILE)) ""
 ;;R^"860.8:",100,5
 ;;D^  ; N GLREF
 ;;R^"860.8:",100,6
 ;;D^  ; I '(OCXFILE=(+OCXFILE)) S GLREF=U_OCXFILE
 ;;R^"860.8:",100,7
 ;;D^  ; E  S GLREF=$$FILE^OCXBDTD(+OCXFILE,"GLOBAL NAME") Q:'$L(GLREF) ""
 ;;R^"860.8:",100,8
 ;;D^T+; I $G(OCXTRACE) W !,"%%%%",?20," GLREF: ",GLREF,"  RESOLVES TO: ",$P($G(@(GLREF_(+D0)_",0)")),U,1)
 ;;R^"860.8:",100,9
 ;;D^  ; Q $P($G(@(GLREF_(+D0)_",0)")),U,1)
 ;;R^"860.8:",100,10
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^STRING CONTAINS ONE OF A LIST OF VALUES
 ;;R^"860.8:",.01,"E"
 ;;D^STRING CONTAINS ONE OF A LIST OF VALUES
 ;;R^"860.8:",.02,"E"
 ;;D^CLIST
 ;;R^"860.8:",100,1
 ;;D^  ;CLIST(DATA,LIST) ;   DOES THE DATA FIELD CONTAIN AN ELEMENT IN THE LIST
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^T+; W:$G(OCXTRACE) !!,"$$CLIST(",DATA,",""",LIST,""")"
 ;;R^"860.8:",100,4
 ;;D^  ; N PC F PC=1:1:$L(LIST,","),0 I PC,$L($P(LIST,",",PC)),(DATA[$P(LIST,",",PC)) Q
 ;;R^"860.8:",100,5
 ;;D^  ; Q ''PC
 ;;EOR^
 ;;EOF^OCXS(860.8)^1
 ;;SOF^860.6  ORDER CHECK DATA CONTEXT
 ;;KEY^860.6:^CPRS ORDER PROTOCOL
 ;;R^"860.6:",.01,"E"
 ;;D^CPRS ORDER PROTOCOL
 ;;R^"860.6:",.02,"E"
 ;;D^OERR
 ;;R^"860.6:",1,"E"
 ;;D^DATA DRIVEN
 ;;EOR^
 ;;KEY^860.6:^DATABASE LOOKUP
 ;;R^"860.6:",.01,"E"
 ;;D^DATABASE LOOKUP
 ;;R^"860.6:",.02,"E"
 ;;D^DL
 ;;R^"860.6:",1,"E"
 ;;D^PACKAGE LOOKUP
 ;;EOR^
 ;;KEY^860.6:^GENERIC HL7 MESSAGE ARRAY
 ;;R^"860.6:",.01,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;R^"860.6:",.02,"E"
 ;;D^HL7
 ;;R^"860.6:",1,"E"
 ;;D^DATA DRIVEN
 ;;EOR^
 ;;EOF^OCXS(860.6)^1
 ;;SOF^860.5  ORDER CHECK DATA SOURCE
 ;;KEY^860.5:^DATABASE LOOKUP
 ;;R^"860.5:",.01,"E"
 ;;D^DATABASE LOOKUP
 ;;R^"860.5:",.02,"E"
 ;;D^DATABASE LOOKUP
 ;;EOR^
 ;;KEY^860.5:^HL7 OBSERVATION/RESULT SEGMENT
 ;;R^"860.5:",.01,"E"
 ;;D^HL7 OBSERVATION/RESULT SEGMENT
 ;;R^"860.5:",.02,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;EOR^
 ;;KEY^860.5:^HL7 PATIENT ID SEGMENT
 ;;R^"860.5:",.01,"E"
 ;;D^HL7 PATIENT ID SEGMENT
 ;;R^"860.5:",.02,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;EOR^
 ;;KEY^860.5:^OERR ORDER EVENT FLAG PROTOCOL
 ;;R^"860.5:",.01,"E"
 ;;D^OERR ORDER EVENT FLAG PROTOCOL
 ;;R^"860.5:",.02,"E"
 ;;D^CPRS ORDER PROTOCOL
 ;;EOR^
 ;;EOF^OCXS(860.5)^1
 ;;SOF^860.4  ORDER CHECK DATA FIELD
 ;;KEY^860.4:^LAB SPECIMEN ID
 ;;R^"860.4:",.01,"E"
 ;;D^LAB SPECIMEN ID
 ;;R^"860.4:",1,"E"
 ;;D^LAB SPEC ID
 ;;R^"860.4:",101,"E"
 ;;D^NUMERIC
 ;;R^"860.4:","860.41:GENERIC HL7 MESSAGE ARRAY^860.6",.01,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;R^"860.4:","860.41:GENERIC HL7 MESSAGE ARRAY^860.6",.02,"E"
 ;;D^HL7 OBSERVATION/RESULT SEGMENT
 ;;R^"860.4:","860.41:GENERIC HL7 MESSAGE ARRAY^860.6",1,"E"
 ;;D^PATIENT.LAB_SPECIMEN_ID
 ;;EOR^
 ;;KEY^860.4:^LAB SPECIMEN NAME
 ;;R^"860.4:",.01,"E"
 ;1;
 ;
