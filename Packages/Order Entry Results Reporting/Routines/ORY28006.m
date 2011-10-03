ORY28006 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*280) ;MAR 3,2010 at 07:20
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**280**;Dec 17,1997;Build 85
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY280ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY28007
 ;
 Q
 ;
DATA ;
 ;
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
 ;;KEY^860.8:^OPIOID MEDICATIONS
 ;;R^"860.8:",.01,"E"
 ;;D^OPIOID MEDICATIONS
 ;;R^"860.8:",.02,"E"
 ;;D^OPIOID
 ;;R^"860.8:",1,1
 ;;D^If the patient is currently receiving "active" medications in the opioid 
 ;;R^"860.8:",1,2
 ;;D^VA drug classes CN101 or CN102, this function returns a "1" and list of 
 ;;R^"860.8:",1,3
 ;;D^the opioid medications in the following format:
 ;;R^"860.8:",1,4
 ;;D^ 
 ;;R^"860.8:",1,5
 ;;D^  1^drug order text 1, drug order text 2, drug order text 3, ...
 ;;R^"860.8:",1,6
 ;;D^ 
 ;;R^"860.8:",1,7
 ;;D^[Note: The drug order text is truncated to the first 25 characters.]
 ;;R^"860.8:",1,8
 ;;D^ 
 ;;R^"860.8:",1,9
 ;;D^If the patient is not currently receiving opioid medications, a zero (0)
 ;;R^"860.8:",1,10
 ;;D^is returned.
 ;;R^"860.8:",100,1
 ;;D^   ;OPIOID(ORPT) ;determine if pat is receiving opioid med
 ;;R^"860.8:",100,2
 ;;D^   ; ; rtn 1^opioid drug 1, opioid drug 2, opioid drug3, ...
 ;;R^"860.8:",100,3
 ;;D^   ; N ORDG,ORTN,ORNUM,ORDI,ORDCLAS,ORDERS,ORTEXT,DUP,DUPI,DUPJ,DUPLEN
 ;;R^"860.8:",100,4
 ;;D^   ; S ORDG=0,ORTN=0,DUPI=0,DUPLEN=20
 ;;R^"860.8:",100,5
 ;;D^   ; K ^TMP("ORR",$J)
 ;;R^"860.8:",100,6
 ;;D^   ; S ORDG=$O(^ORD(100.98,"B","RX",ORDG))
 ;;R^"860.8:",100,7
 ;;D^   ; D EN^ORQ1(ORPT_";DPT(",ORDG,2,"","","",0,0)
 ;;R^"860.8:",100,8
 ;;D^   ; N J,HOR,SEQ,X S J=1,HOR=0,SEQ=0
 ;;R^"860.8:",100,9
 ;;D^   ; S HOR=$O(^TMP("ORR",$J,HOR)) Q:+HOR<1 ORTN
 ;;R^"860.8:",100,10
 ;;D^   ; F  S SEQ=$O(^TMP("ORR",$J,HOR,SEQ)) Q:+SEQ<1  D
 ;;R^"860.8:",100,11
 ;;D^   ; .S X=^TMP("ORR",$J,HOR,SEQ)
 ;;R^"860.8:",100,12
 ;;D^   ; .S ORNUM=+$P(X,";")
 ;;R^"860.8:",100,13
 ;;D^   ; .Q:ORNUM=+$G(ORIFN)  ;quit if dup med order # = current order #
 ;;R^"860.8:",100,14
 ;;D^   ; .S ORDI=$$VALUE^ORCSAVE2(ORNUM,"DRUG")
 ;;R^"860.8:",100,15
 ;;D^   ; .I +$G(ORDI)>0 D
 ;;R^"860.8:",100,16
 ;;D^   ; ..S ORDCLAS=$P(^PSDRUG(ORDI,0),U,2)  ;va drug class
 ;;R^"860.8:",100,17
 ;;D^   ; ..I ($G(ORDCLAS)="CN101")!($G(ORDCLAS)="CN102") D  ;opioid classes
 ;;R^"860.8:",100,18
 ;;D^   ; ...S ORTEXT=$$FULLTEXT^ORQOR1(ORNUM)
 ;;R^"860.8:",100,19
 ;;D^   ; ...S ORTEXT=$P(ORTEXT,U)_" ["_$P(ORTEXT,U,2)_"]"
 ;;R^"860.8:",100,20
 ;;D^   ; ...S DUPI=DUPI+1,DUP(DUPI)=" ["_DUPI_"] "_ORTEXT
 ;;R^"860.8:",100,21
 ;;D^   ; ...S ORTN=1
 ;;R^"860.8:",100,22
 ;;D^   ; I DUPI>0 D
 ;;R^"860.8:",100,23
 ;;D^   ; .;S DUPLEN=$P(215/DUPI,".")
 ;;R^"860.8:",100,24
 ;;D^   ; .S DUPLEN=500
 ;;R^"860.8:",100,25
 ;;D^   ; .F DUPJ=1:1:DUPI D
 ;;R^"860.8:",100,26
 ;;D^   ; ..I DUPJ=1 S ORDERS=$E(DUP(DUPJ),1,DUPLEN)
 ;;R^"860.8:",100,27
 ;;D^   ; ..E  S ORDERS=ORDERS_", "_$E(DUP(DUPJ),1,DUPLEN)
 ;;R^"860.8:",100,28
 ;;D^   ; K ^TMP("ORR",$J)
 ;;R^"860.8:",100,29
 ;;D^   ; Q ORTN_U_$G(ORDERS)
 ;;R^"860.8:",100,30
 ;;D^   ; ;
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
 ;1;
 ;
