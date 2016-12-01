ORY42306 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*423) ;JUN 29,2016 at 06:15
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**423**;Dec 17,1997;Build 19
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY423ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY42307
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"860.8:",100,39
 ;;D^  ; S OCXGR=OCXGR_","_OCXRUL_",1"
 ;;R^"860.8:",100,40
 ;;D^T+; D SETAP(OCXGR_")","860.712","Relation",OCXREL,.OCXDATA,OCXREL)
 ;;R^"860.8:",100,41
 ;;D^T-; D SETAP(OCXGR_")","860.712",.OCXDATA,OCXREL)
 ;;R^"860.8:",100,42
 ;;D^  ; ;
 ;;R^"860.8:",100,43
 ;;D^  ; S OCXELE=0 F  S OCXELE=$O(^OCXS(860.2,OCXRUL,"C","C",OCXELE)) Q:'OCXELE  D
 ;;R^"860.8:",100,44
 ;;D^  ; .;
 ;;R^"860.8:",100,45
 ;;D^  ; .N OCXGR1
 ;;R^"860.8:",100,46
 ;;D^  ; .S OCXGR1=OCXGR_","_OCXREL_",1"
 ;;R^"860.8:",100,47
 ;;D^  ; .K OCXDATA
 ;;R^"860.8:",100,48
 ;;D^  ; .S OCXDATA(OCXELE,0)=OCXELE
 ;;R^"860.8:",100,49
 ;;D^  ; .S OCXDATA(OCXELE,"TIME")=OCXTIME
 ;;R^"860.8:",100,50
 ;;D^  ; .S OCXDATA(OCXELE,"LOG")=$G(OCXOLOG)
 ;;R^"860.8:",100,51
 ;;D^  ; .S OCXDATA("B",OCXELE,OCXELE)=""
 ;;R^"860.8:",100,52
 ;;D^  ; .K ^OCXD(860.7,OCXDFN,1,OCXRUL,1,OCXREL,1,OCXELE)
 ;;R^"860.8:",100,53
 ;;D^T+; .D SETAP(OCXGR1_")","860.7122P","Element",$P($G(^OCXS(860.3,OCXELE,0)),U,1),.OCXDATA,OCXELE)
 ;;R^"860.8:",100,54
 ;;D^T-; .D SETAP(OCXGR1_")","860.7122P",.OCXDATA,OCXELE)
 ;;R^"860.8:",100,55
 ;;D^  ; .;
 ;;R^"860.8:",100,56
 ;;D^  ; .S OCXDFI=0 F  S OCXDFI=$O(^TMP("OCXCHK",$J,OCXDFN,OCXELE,OCXDFI)) Q:'OCXDFI  D
 ;;R^"860.8:",100,57
 ;;D^  ; ..N OCXGR2
 ;;R^"860.8:",100,58
 ;;D^  ; ..S OCXGR2=OCXGR1_","_OCXELE_",1"
 ;;R^"860.8:",100,59
 ;;D^  ; ..K OCXDATA
 ;;R^"860.8:",100,60
 ;;D^  ; ..S OCXDATA(OCXDFI,0)=OCXDFI
 ;;R^"860.8:",100,61
 ;;D^  ; ..S OCXDATA(OCXDFI,"VAL")=^TMP("OCXCHK",$J,OCXDFN,OCXELE,OCXDFI)
 ;;R^"860.8:",100,62
 ;;D^  ; ..S OCXDATA("B",OCXDFI,OCXDFI)=""
 ;;R^"860.8:",100,63
 ;;D^T+; ..D SETAP(OCXGR2_")","860.71223P","Data Field",$P($G(^OCXS(860.4,OCXDFI,0)),U,1),.OCXDATA,OCXDFI)
 ;;R^"860.8:",100,64
 ;;D^T-; ..D SETAP(OCXGR2_")","860.71223P",.OCXDATA,OCXDFI)
 ;;R^"860.8:",100,65
 ;;D^  ; ;
 ;;R^"860.8:",100,66
 ;;D^  ; Q 1
 ;;R^"860.8:",100,67
 ;;D^  ; ;
 ;;R^"860.8:",100,68
 ;;D^T+;SETAP(ROOT,DD,ITEM,ITEMNAME,DATA,DA) ;  Set Rule Event data
 ;;R^"860.8:",100,69
 ;;D^T-;SETAP(ROOT,DD,DATA,DA) ;  Set Rule Event data
 ;;R^"860.8:",100,70
 ;;D^  ; M @ROOT=DATA
 ;;R^"860.8:",100,71
 ;;D^  ; I +$G(DD) S @ROOT@(0)="^"_($G(DD))_"^"_($P($G(@ROOT@(0)),U,3)+1)_"^"_$G(DA)
 ;;R^"860.8:",100,72
 ;;D^  ; I '$G(DD) S $P(@ROOT@(0),U,3,4)=($P($G(@ROOT@(0)),U,3)+1)_"^"_$G(DA)
 ;;R^"860.8:",100,73
 ;;D^T+; W:$G(OCXTRACE) !,"File Active Data ",$G(ITEM),": ",$G(ITEMNAME)
 ;;R^"860.8:",100,74
 ;;D^  ; ;
 ;;R^"860.8:",100,75
 ;;D^  ; Q
 ;;R^"860.8:",100,76
 ;;D^  ; ;
 ;;R^"860.8:",100,77
 ;;D^  ; ;
 ;;EOR^
 ;;KEY^860.8:^PATIENT LOCATION
 ;;R^"860.8:",.01,"E"
 ;;D^PATIENT LOCATION
 ;;R^"860.8:",.02,"E"
 ;;D^PATLOC
 ;;R^"860.8:",1,1
 ;;D^Returns the Inpatient or Outpatient location for the patient.
 ;;R^"860.8:",1,2
 ;;D^ 
 ;;R^"860.8:",1,3
 ;;D^  Input: DFN
 ;;R^"860.8:",1,4
 ;;D^  Output: Patient Status (I/O) Inpatient/Outpatient
 ;;R^"860.8:",1,5
 ;;D^          Patient Location (Free text name)
 ;;R^"860.8:",100,1
 ;;D^  ;PATLOC(DFN) ;
 ;;R^"860.8:",100,2
 ;;D^  ; ;
 ;;R^"860.8:",100,3
 ;;D^  ; N OCXP1,OCXP2
 ;;R^"860.8:",100,4
 ;;D^  ; S OCXP1=$G(^TMP("OCXSWAP",$J,"OCXODATA","PV1",2))
 ;;R^"860.8:",100,5
 ;;D^  ; S OCXP2=$P($G(^TMP("OCXSWAP",$J,"OCXODATA","PV1",3)),"^",1)
 ;;R^"860.8:",100,6
 ;;D^T+; W:$G(OCXTRACE) !,"OCXP2: ",$G(OCXP1)
 ;;R^"860.8:",100,7
 ;;D^T+; W:$G(OCXTRACE) !,"OCXP2: ",$G(OCXP2)
 ;;R^"860.8:",100,8
 ;;D^  ; I OCXP2 D
 ;;R^"860.8:",100,9
 ;;D^  ; .S OCXP2=$P($G(^SC(+OCXP2,0)),"^",1,2)
 ;;R^"860.8:",100,10
 ;;D^  ; .I $L($P(OCXP2,"^",2)) S OCXP2=$P(OCXP2,"^",2)
 ;;R^"860.8:",100,11
 ;;D^  ; .E  S OCXP2=$P(OCXP2,"^",1)
 ;;R^"860.8:",100,12
 ;;D^  ; .S:'$L(OCXP2) OCXP2="NO LOC"
 ;;R^"860.8:",100,13
 ;;D^  ; I $L(OCXP1),$L(OCXP2) Q OCXP1_"^"_OCXP2
 ;;R^"860.8:",100,14
 ;;D^  ; ;
 ;;R^"860.8:",100,15
 ;;D^  ; S OCXP2=$G(^DPT(+$G(DFN),.1))
 ;;R^"860.8:",100,16
 ;;D^  ; I $L(OCXP2) Q "I^"_OCXP2
 ;;R^"860.8:",100,17
 ;;D^  ; Q "O^OUTPT"
 ;;R^"860.8:",100,18
 ;;D^  ; ;
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
 ;;KEY^860.6:^CPRS ORDER PRESCAN
 ;;R^"860.6:",.01,"E"
 ;;D^CPRS ORDER PRESCAN
 ;;R^"860.6:",.02,"E"
 ;;D^OEPS
 ;;R^"860.6:",1,"E"
 ;;D^DATA DRIVEN
 ;;EOR^
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
 ;;KEY^860.5:^HL7 COMMON ORDER SEGMENT
 ;;R^"860.5:",.01,"E"
 ;;D^HL7 COMMON ORDER SEGMENT
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
 ;;KEY^860.5:^ORDER ENTRY ORDER PRESCAN
 ;;R^"860.5:",.01,"E"
 ;;D^ORDER ENTRY ORDER PRESCAN
 ;1;
 ;
