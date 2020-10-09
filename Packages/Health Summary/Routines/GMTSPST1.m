GMTSPST1 ;BIR/RMS - MED RECON TOOL #1 (MED REC PROFILE) ;May 14, 2018@20:50
 ;;2.7;Health Summary;**94,127,131,135**;Oct 20, 1995;Build 2
 ;Reference to COVER^ORWPS supported by IA 4926
 ;References to ^ORRDI1 supported by IA 4659
 ;Reference to ^XTMP("ORRDI","PSOO" supported by IA 4660
 ;Reference to ^XTMP("ORRDI","OUTAGE INFO" supported by IA 5440
 ;Reference to ^PSOHCSUM supported by IA 330
 ;Reference to $$ISCLIN^ORUTL1 supported by IA 5691
 ;Reference to ^PS(51 supported by IA 1980
 ;Reference to file 53.1 supported by IA 534
 ;Reference to TEXT^ORQ12 supported by IA 4202
 ;Reference to $$PKGID^ORX8 supported by IA 3071
 ;Reference to BCMALG^PSJUTL2 supported by IA 5057
TOOL1 ;ENTRY POINT FOR HEALTH SUMMARY
 N ALPHA,DRUGNM,EXPDAYS,IND1,LIST,ORDER,PSNUM,RPC,RPCT,RPCNODE,SAVE,SAVERD
 D ADD^GMTSPSTR("GMTSPST1")
 S IND1=7,EXPDAYS=90
 D COVER^ORWPS(.RPC,DFN)
 S RPCT=0 F  S RPCT=$O(RPC(RPCT)) Q:'+RPCT  D
 . S RPCNODE=RPC(RPCT)
 . S PSNUM=$P(RPCNODE,U)
 . S DRUGNM=$$UP^XLFSTR($P(RPCNODE,U,2))
 . S ORDER=+$P(RPCNODE,U,3)
 . Q:DRUGNM']""!(ORDER=0)!(PSNUM']"")
 . S SAVERD=9999999-$$LRD(+$G(^OR(100,ORDER,4)))
 . S SAVE(DRUGNM,SAVERD,ORDER,PSNUM)=""
 . Q:("ACTIVE^ACTIVE/SUSP^ACTIVE/PARKED^HOLD^PENDING^ON CALL"'[$P(RPCNODE,U,4))&($P(PSNUM,";")["N")
 . S ALPHA(1,DRUGNM,ORDER,PSNUM)=$P(RPCNODE,U,4)
 D ADDREM
 D HEADER
 S LIST=1 D OUTPUT
 D CKP Q:$D(GMTSQIT)  W !
 D CKP Q:$D(GMTSQIT)  W !,$$REPEAT^XLFSTR("-",IOM-8)
 D CKP Q:$D(GMTSQIT)  W !,$$CJ^XLFSTR("SUPPLIES",IOM-8)
 D CKP Q:$D(GMTSQIT)  W !,$$REPEAT^XLFSTR("-",IOM-8)
 D CKP Q:$D(GMTSQIT)  W !
 S LIST=2 D OUTPUT
 D FOOTER
 Q
 ;
ADDREM ;USES RDI - REMOTE DATA INTEROPERABILITY TO INCORPORATE OUTSIDE MEDS
 N DOWN,MED,RDI,RNAM,RNUM,STAT,ISSUE
 Q:'$$HAVEHDR^ORRDI1
 D  Q:$G(DOWN)  ;Check for outage of RDI
 . I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) H $$GET^XPAR("ALL","ORRDI PING FREQ")/2
 . I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) S DOWN=1 D  Q:$D(GMTSQIT)
 .. D CKP Q:$D(GMTSQIT)
 .. W !,"WARNING: Connection to Remote Data Currently Down",!
 .. D CKP
 Q:$D(GMTSQIT)
 ;Get data for HFS file structure
 D SAVDEV^%ZISUTL("GMTSHFS")
 S RDI=$$GET^ORRDI1(DFN,"PSOO")
 D USE^%ZISUTL("GMTSHFS")
 D RMDEV^%ZISUTL("GMTSHFS")
 ;
 H 1 ;One extra second to allow ^XTMP replication across nodes
 I +RDI=-1 D  Q:$D(GMTSQIT)
 . D CKP Q:$D(GMTSQIT)
 . W !,"WARNING: Connection to Remote Data Not Available",!
 . D CKP
 Q:'$D(^XTMP("ORRDI","PSOO",DFN))
 S MED=0 F  S MED=$O(^XTMP("ORRDI","PSOO",DFN,MED)) Q:'+MED  D
 . S STAT=$G(^XTMP("ORRDI","PSOO",DFN,MED,5,0))
 . Q:STAT']""
 . Q:"ACTIVE^SUSPENDED^HOLD"'[STAT
 . ;GMTS*2.7*135 Commented out the next line
 . ;Q:$G(^XTMP("ORRDI","PSOO",DFN,MED,7,0))']""  ;DoD:quit if there is no exp. date
 . D  Q:ISSUE<$$FMADD^XLFDT(DT,-366)  ;DoD: quit if ISSUE DATE > 1Y ago
 .. N %DT,X,Y
 .. S X=$G(^XTMP("ORRDI","PSOO",DFN,MED,8,0))
 .. D ^%DT
 .. S ISSUE=+Y
 . S RNAM=$G(^XTMP("ORRDI","PSOO",DFN,MED,2,0),"Unknown Drug")
 . S RNUM=$G(^XTMP("ORRDI","PSOO",DFN,MED,4,0))
 . Q:RNAM']""!(RNUM']"")
 . S ALPHA(1,RNAM,RNUM,MED_"X;R")=""
 Q
HEADER ;
 N NVADT,REPEAT
 S NVADT=$$NVADT
 D TEXTPRNT("HEADTXT1")
 D CKP Q:$D(GMTSQIT)
 W !,"Non-VA Meds Last Documented On: "
 W $S(+NVADT:$$FMTE^XLFDT(NVADT,"D"),1:"** Data not found **")
 D CKP Q:$D(GMTSQIT)
 W !,$$REPEAT^XLFSTR("*",IOM-8)
 D CKP Q:$D(GMTSQIT)  W !
 D CKP Q:$D(GMTSQIT)
 D TEXTPRNT("HEADTXT2")
 F REPEAT=1,2 D CKP Q:$D(GMTSQIT)  W !
 D CKP Q:$D(GMTSQIT)
 W !,$$REPEAT^XLFSTR("-",IOM-8)
 D CKP Q:$D(GMTSQIT)
 Q
TEXTPRNT(TEXTLOC) ;PRINT LINES OF TEXT FROM A LINE LABEL, ENDS WITH $$END
 N LINE,TLINE,LINETEXT
 S LINE=0 F  S LINE=LINE+1,TLINE=TEXTLOC_"+"_LINE S:TEXTLOC="FOOTER1" TLINE=TLINE_"^GMTSGLOS" S LINETEXT=$T(@TLINE) S LINETEXT=$E(LINETEXT,4,$L(LINETEXT)) Q:LINETEXT="$$END"  D
 . D CKP Q:$D(GMTSQIT)
 . W !,LINETEXT
 Q
OUTPUT N DRUGNM,ORDER,PSNUM
 N PACK,PACKREF,SIGLINE,ORDNUM
 N LASTACT,OTLINE
 S DRUGNM="" F  S DRUGNM=$O(ALPHA(LIST,DRUGNM)) Q:DRUGNM']""  D  K SAVE(DRUGNM) Q:$D(GMTSQIT)
 . S ORDER="" F  S ORDER=$O(ALPHA(LIST,DRUGNM,ORDER)) Q:ORDER']""  D  Q:$D(GMTSQIT)
 .. S PSNUM="" F  S PSNUM=$O(ALPHA(LIST,DRUGNM,ORDER,PSNUM)) Q:PSNUM']""  D  Q:$D(GMTSQIT)
 ... S PACK=$P(PSNUM,";",2),ORDNUM=$P(PSNUM,";")
 ... I $$ISSUPPLY(,DRUGNM) S ALPHA(2,DRUGNM,ORDER,PSNUM)=ALPHA(LIST,DRUGNM,ORDER,PSNUM) Q
 ... I PACK="I" D INPDISP W ! Q:$D(GMTSQIT)
 ... I PACK="O" D OPTDISP W ! Q:$D(GMTSQIT)
 ... I PACK="R" D RDIDISP W ! Q:$D(GMTSQIT)
 Q
INPDISP ;Display an Inpatient or Clinic Meds Entry
 N GMTSPST1,OALINE,ORIG,ORVP,PSIFN,WLINE,DIWL,DIWR,DIWF,TYPE,X,LASTBCMA,STATUS
 N DDNUM,DRUGDISP,ORY
 K ^UTILITY($J,"W")
 D CKP Q:$D(GMTSQIT)
 S STATUS=$G(ALPHA(LIST,DRUGNM,ORDER,PSNUM))
 S STATUS=$S(STATUS["ACTIVE":"Active",STATUS["HOLD":"On Hold",STATUS["PENDING":"Pending",STATUS["DISCONTINUED":"Discontinued",1:STATUS)
 ;W !,$S($$ISCLIN^ORUTL1(ORDER):"CLIN ",1:"INPT ")_DRUGNM_" (Status="_STATUS_")"
 D DRUGDSP^GMTSPSTN
 D IMOOD^ORIMO(.ORY,ORDER)
 W !,$S(ORY:"CLIN ",1:"INPT ")_DRUGDISP_" (Status="_STATUS_")"
 D CKP Q:$D(GMTSQIT)
 D DRGDSP2^GMTSPSTN
 D TEXT^ORQ12(.GMTSPST1,ORDER,80)
 S DIWL=IND1,DIWR=60,ORIG=$S(PSNUM["U":2,$$GET1^DIQ(53.1,+PSNUM,4,"I")="U":2,1:1)
 D:$E(GMTSPST1(1),1,7)="Change "
 . F OALINE=2:1:$O(GMTSPST1(":"),-1) I $E(GMTSPST1(OALINE),1,3)="to " S ORIG=OALINE,$E(GMTSPST1(OALINE),1,3)="" Q
 F OALINE=ORIG:1:$O(GMTSPST1(":"),-1) D
 . S X=$$LSIG($G(GMTSPST1(OALINE)))
 .; S X=$G(GMTSPST1(OALINE))
 . D ^DIWP
 S WLINE=0 F  S WLINE=$O(^UTILITY($J,"W",DIWL,WLINE)) Q:'+WLINE  D  Q:$D(GMTSQIT)
 . W !?DIWL,$G(^UTILITY($J,"W",DIWL,WLINE,0))
 . D CKP
 Q:$D(GMTSQIT)
 S LASTBCMA=$$BCMALG^PSJUTL2(DFN,ORDNUM)
 I LASTBCMA'="" W !?IND1,$$BCMALG^PSJUTL2(DFN,ORDNUM) D CKP Q:$D(GMTSQIT)
 Q
 ;
OPTDISP ;Display an Outpatient Prescription Entry
 N EXPDT,REFILLS,STATUS,DIWL,DIWR,PENDMED,GMTSPSTP,ORQLN,CANCELDT
 N ORDTYP,ORIGRX,QDFLAG
 K ^TMP($J,"GMTSPST1"),^UTILITY($J,"W")
 S PACKREF=$$PKGID^ORX8(ORDER)
 I PACKREF["S" D  Q
 . D PEN^PSO5241(DFN,"GMTSPST1",+PACKREF,ORDER)
 . D CKP Q:$D(GMTSQIT)
 . W !,"OUTPT "_DRUGNM_" (Status = Pending)"
 . D CKP Q:$D(GMTSQIT)
 . D TEXT^ORQ12(.GMTSPSTP,ORDER,60)
 . ;p127 mwa stopped previous instructions from showing, stopped subscript error, and leading space error
 . S ORQLN=1 F  S ORQLN=$O(GMTSPSTP(ORQLN)) Q:'+ORQLN  Q:$E(GMTSPSTP(ORQLN),1,3+$L($P(DRUGNM," ")))=("to "_$P(DRUGNM," ")) 
 . S:ORQLN="" ORQLN=1
 . F  S ORQLN=$O(GMTSPSTP(ORQLN)) Q:'+ORQLN  Q:(GMTSPSTP(ORQLN)?." "1"Quantity: ".E)  D
 .. W !?IND1,GMTSPSTP(ORQLN)
 .. D CKP Q:$D(GMTSQIT)
 . S ORIGRX=$P($G(^TMP($J,"GMTSPST1",DFN,+PACKREF,22.1)),U,2)
 . S ORDTYP=$P($G(^TMP($J,"GMTSPST1",DFN,+PACKREF,2)),U,1)
 . S QDFLAG=0 I ORIGRX]"",ORDTYP="RNW" D
 .. W !?10,"Renewed from Rx# "_ORIGRX
 .. D CKP Q:$D(GMTSQIT)
 .. W ?50,"Qty/Days Supply: "_$G(^TMP($J,"GMTSPST1",DFN,+PACKREF,12))_"/"_$G(^TMP($J,"GMTSPST1",DFN,+PACKREF,101))
 .. S QDFLAG=1
 . D CKP Q:$D(GMTSQIT)
 . W !?10,"Login Date: "_$$FMTE^XLFDT(+$G(^TMP($J,"GMTSPST1",DFN,+PACKREF,15)),"2D")
 . D CKP Q:$D(GMTSQIT)
 . I 'QDFLAG D
 .. W ?50,"Qty/Days Supply: "_$G(^TMP($J,"GMTSPST1",DFN,+PACKREF,12))_"/"_$G(^TMP($J,"GMTSPST1",DFN,+PACKREF,101))
 .. D CKP Q:$D(GMTSQIT)
 . W:'QDFLAG ! W ?50,"Refills Ordered: "_$G(^TMP($J,"GMTSPST1",DFN,+PACKREF,13))
 . D CKP Q:$D(GMTSQIT)
 D RX^PSO52API(DFN,"GMTSPST1",PACKREF)
 S EXPDT=$G(^TMP($J,"GMTSPST1",DFN,PACKREF,26))
 S CANCELDT=$G(^TMP($J,"GMTSPST1",DFN,PACKREF,26.1))
 S REFILLS=$G(^TMP($J,"GMTSPST1",DFN,PACKREF,9))-$S($G(^TMP($J,"GMTSPST1",DFN,PACKREF,"RF",0))>0:$G(^TMP($J,"GMTSPST1",DFN,PACKREF,"RF",0)),1:0)  ;need to make sure this is as accurate as the previous method in PSOQ0076
 S LASTREL=$$LRD(PACKREF)
 I $P(PSNUM,";")["N" G NVADISP
 I EXPDT Q:$$FMDIFF^XLFDT(DT,$P(EXPDT,U))>EXPDAYS
 I CANCELDT Q:$$FMDIFF^XLFDT(DT,$P(CANCELDT,U))>EXPDAYS
 S STATUS=$P($G(^TMP($J,"GMTSPST1",DFN,PACKREF,100)),U,2)
 S STATUS=$S(STATUS["ACTIVE":"Active",STATUS["SUSPENDED":"Active/Suspended",STATUS["HOLD":"On Hold",STATUS["DISCONTINUED":"Discontinued",1:STATUS)
 D CKP Q:$D(GMTSQIT)
 W !,"OUTPT "_DRUGNM_" (Status = "_STATUS_")"
 S DIWL=IND1,DIWR=72
 S SIGLINE=0 F  S SIGLINE=$O(^TMP($J,"GMTSPST1",DFN,PACKREF,"M",SIGLINE)) Q:'+SIGLINE  D  Q:$D(GMTSQIT)
 . S X=$G(^TMP($J,"GMTSPST1",DFN,PACKREF,"M",SIGLINE,0))
 . D ^DIWP
 S WLINE=0 F  S WLINE=$O(^UTILITY($J,"W",DIWL,WLINE)) Q:'+WLINE!($D(GMTSQIT))  D  Q:$D(GMTSQIT)
 . W !?DIWL,$G(^UTILITY($J,"W",DIWL,WLINE,0))
 . D CKP
 Q:$D(GMTSQIT)
 W !?10,"Rx# "_$G(^TMP($J,"GMTSPST1",DFN,PACKREF,.01))_" Last Released: "_$$FMTE^XLFDT(LASTREL,"2D"),?50,"Qty/Days Supply: "_$G(^TMP($J,"GMTSPST1",DFN,PACKREF,7))_"/"_$G(^TMP($J,"GMTSPST1",DFN,PACKREF,8)) D CKP Q:$D(GMTSQIT)
 W !?10,"Rx Expiration Date: ",$$FMTE^XLFDT(EXPDT,"2D"),?50,"Refills Remaining: ",REFILLS D CKP Q:$D(GMTSQIT)
 W ! D CKP
 Q
 ;
ISSUPPLY(DRUG,DRUGNAME) ;
 ; Function returns '1' if drug is a SUPPLY, '0' otherwise
 Q:LIST=2 0 ;Only check during regular med list, not in supply list
 N VACLASS,DEAHDLG
 K ^TMP($J,"GMTSPST1D")
 I +$G(DRUG) D DATA^PSS50(DRUG,,,,,"GMTSPST1D")
 E  D DATA^PSS50(,DRUGNAME,,,,"GMTSPST1D") S DRUG=$O(^TMP($J,"GMTSPST1D",0))
 I 'DRUG Q 0
 S VACLASS=$G(^TMP($J,"GMTSPST1D",DRUG,2))
 S DEAHDLG=$G(^TMP($J,"GMTSPST1D",DRUG,3))
 Q:$E(VACLASS,1,2)="XA" 1
 Q:$E(VACLASS,1,2)="XX" 1
 Q:(VACLASS="DX900")&(DEAHDLG["S") 1
 Q 0
 ;
RDIDISP ;Display a Remote Meds Entry
 D CKP Q:$D(GMTSQIT)
 W !,"Remote ",?IND1,DRUGNM D CKP Q:$D(GMTSQIT)
 N STATUS,DIWL,DIWR,DIWF,X,WLINE
 K ^UTILITY($J,"W")
 S X=$G(^XTMP("ORRDI","PSOO",DFN,+ORDNUM,14,0)),DIWL=IND1,DIWR=60
 D ^DIWP
 S WLINE=0 F  S WLINE=$O(^UTILITY($J,"W",DIWL,WLINE)) Q:'+WLINE  D  Q:$D(GMTSQIT)
 . D CKP Q:$D(GMTSQIT)
 . W !?DIWL,$G(^UTILITY($J,"W",DIWL,WLINE,0))
 D CKP Q:$D(GMTSQIT)
 S STATUS=$G(^XTMP("ORRDI","PSOO",DFN,+ORDNUM,5,0))
 S STATUS=$S(STATUS["ACTIVE":"Active",STATUS["SUSPENDED":"Active/Suspended",STATUS["HOLD":"Hold",1:"Unknown")
 W !?10,"Last Filled: "_$G(^XTMP("ORRDI","PSOO",DFN,+ORDNUM,9,0))_" ("_STATUS_" at "_$G(^XTMP("ORRDI","PSOO",DFN,+ORDNUM,1,0))_") "
 W !?10,"Rx Expiration Date: ",$G(^XTMP("ORRDI","PSOO",DFN,+ORDNUM,7,0)),?55,"Days Supply: "_$P($P($G(^XTMP("ORRDI","PSOO",DFN,+ORDNUM,6,0)),";",2),"D",2)
 Q
 ;
NVADISP ;Display a Non-VA Medication Entry
 N GMTSPST1,OALINE,ORIG,WLINE,DIWL,DIWR,DIWF,X
 K ^UTILITY($J,"W")
 D CKP Q:$D(GMTSQIT)
 W !,"Non-VA "_DRUGNM D CKP Q:$D(GMTSQIT)
 D TEXT^ORQ12(.GMTSPST1,ORDER,80)
 S DIWL=IND1,DIWR=60,ORIG=2
 D:$E(GMTSPST1(1),1,7)="Change "
 . F OALINE=2:1:$O(GMTSPST1(":"),-1) I $E(GMTSPST1(OALINE),1,3)="to " S ORIG=OALINE+1 Q
 F OALINE=ORIG:1:$O(GMTSPST1(":"),-1) D
 . S X=$$LSIG($G(GMTSPST1(OALINE)))
 . D ^DIWP
 S WLINE=0 F  S WLINE=$O(^UTILITY($J,"W",DIWL,WLINE)) Q:'+WLINE  D  Q:$D(GMTSQIT)
 . W !?DIWL,$G(^UTILITY($J,"W",DIWL,WLINE,0))
 . D CKP
 W ! D CKP Q:$D(GMTSQIT)
 Q
FOOTER ;Report footer for older medication entries
 D CKP Q:$D(GMTSQIT)  W !
 D TEXTPRNT("FOOTER1")
 Q
OPTFOOT ;Actual display for outpatient footer
 N LASTREL,FOOTTXT,DAYSSUPP,STATUS
 K ^TMP($J,"GMTSPST1")
 S PACKREF=$$PKGID^ORX8(ORDER)
 S LASTREL=$$LRD(PACKREF)
 Q:LASTREL<$$FMADD^XLFDT(DT,-365)
 Q:$P(PSNUM,";")["N"
 D CKP Q:$D(GMTSQIT)
 W !,"OPT "_DRUGNM D CKP Q:$D(GMTSQIT)
 D RX^PSO52API(DFN,"GMTSPST1",PACKREF)
 S STATUS=$P($G(^TMP($J,"GMTSPST1",DFN,PACKREF,100)),U,2)
 S DAYSSUPP=$G(^TMP($J,"GMTSPST1",DFN,PACKREF,8))
 S FOOTTXT="("_STATUS_"/"_DAYSSUPP_" Days Supply Last Released: "_$$FMTE^XLFDT(LASTREL,"2D")_")"
 W $$RJ^XLFSTR(FOOTTXT,74) D CKP Q:$D(GMTSQIT)
 S SIGLINE=0 F  S SIGLINE=$O(^TMP($J,"GMTSPST1",DFN,PACKREF,"M",SIGLINE)) Q:'+SIGLINE  D  Q:$D(GMTSQIT)
 . W !?IND1,$G(^TMP($J,"GMTSPST1",DFN,PACKREF,"M",SIGLINE,0))
 . D CKP
 D CKP
 Q
NVADT() ;Replaces call previously in ^PSOQCF04
 N NVAL,NVARR
 D ^PSOHCSUM
 Q:'$D(^TMP("PSOO",$J,"NVA")) ""
 S NVAL=0 F  S NVAL=$O(^TMP("PSOO",$J,"NVA",NVAL)) Q:'+NVAL  D
 . S NVADT=9999999-$P($G(^TMP("PSOO",$J,"NVA",NVAL,0)),"^",5)
 . S NVARR(NVADT)=""
 S NVADT=$O(NVARR(0)) Q:NVADT=9999999 ""
 Q 9999999-NVADT
LSIG(SIG) ;Expand a SIG
 N P,SGY,X
 S SGY="" F P=1:1:$L(SIG," ") S X=$P(SIG," ",P) D:X]""  ;
 .I $D(^PS(51,"A",X)) S %=^(X),X=$P(%,"^") I $P(%,"^",2)]"" S Y=$P(SIG," ",P-1),Y=$E(Y,$L(Y)) S:Y>1 X=$P(%,"^",2)
 .S SGY=SGY_X_" "
 Q SGY
LRD(PACKREF) ;Calculate LAST RELEASE DATE as latest of original + refill relDates
 N RELDT,REFDT,CTR,ANS
 K ^TMP($J,"GMTSLRD")
 S ANS=""
 D RX^PSO52API(DFN,"GMTSLRD",PACKREF,,"3,R")
 S RELDT=$G(^TMP($J,"GMTSLRD",DFN,PACKREF,31))
 S ANS=RELDT
 S CTR=0 F  S CTR=$O(^TMP($J,"GMTSLRD",DFN,PACKREF,"RF",CTR)) Q:'+CTR  D  ;
 . S REFDT=$G(^TMP($J,"GMTSLRD",DFN,PACKREF,"RF",CTR,17))
 . I REFDT>ANS S ANS=REFDT
 K ^TMP($J,"GMTSLRD")
 Q ANS
 ;
CKP D CKP^GMTSUP Q
 ;
HEADTXT1 ;;
 ;;INCLUDED IN THIS LIST:  Alphabetical list of active outpatient
 ;;prescriptions dispensed from this VA (local) and dispensed from another
 ;;VA or DoD facility (remote) as well as inpatient orders (local pending and
 ;;active), local clinic medications, locally documented non-VA medications,
 ;;and local prescriptions that have expired or been discontinued in the past
 ;;90 days.
 ;;
 ;;$$END
HEADTXT2 ;;
 ;;***NOTE*** The display of VA prescriptions dispensed from another VA or
 ;;DoD facility (remote) is limited to active outpatient prescription entries
 ;;matched to National Drug File at the originating site and may not include
 ;;some items such as investigational drugs, compounds, etc.
 ;;
 ;;NOT INCLUDED IN THIS LIST: Medications self-entered by the patient into
 ;;personal health records (i.e. My HealtheVet) are NOT included in this
 ;;list. Non-VA medications documented outside this VA, remote inpatient
 ;;orders (regardless of status) and remote clinic medications are NOT
 ;;included in this list. The patient and provider must always discuss
 ;;medications the patient is taking, regardless of where the medication was
 ;;dispensed or obtained.
 ;;$$END
