TIULMED ; SLC/JM,JH,AJB - Active/Recent Med Objects Routine ; 12/18/07
 ;;1.0;TEXT INTEGRATION UTILITIES;**38,73,92,94,183,193,197,198,202,213,238**;Jun 20, 1997;Build 6
 Q
LIST(DFN,TARGET,ACTVONLY,DETAILED,ALLMEDS,ONELIST,CLASSORT,SUPPLIES) ;
 ; This is the TIU Medication objects API.  Optional parameters not
 ; provided default to 0 (with the exception of SUPPLIES).
 ;Required Parameters:
 ;  DFN       Patient identifier
 ;  TARGET    Where the medication data will be stored
 ;Optional Parameters:
 ;  ACTVONLY  0 - Active and recently expired meds
 ;            1 - Active meds only
 ;            2 - Recently expired meds only
 ;  DETAILED  0 - One line per med only
 ;            1 - Detailed information on each med
 ;  ALLMEDS   0 - Specifies Inpatient Meds if patient is an
 ;                Inpatient, or Outpatient Meds if patient
 ;                is an Outpatient
 ;            1 - Specifies both Inpatient and Outpatient
 ;            2 or "I" - Specifies Inpatient only
 ;            3 or "O" - Specifies Outpatient only
 ;  ONELIST   0 - Separates Active, Pending and Inactive
 ;                medications into separate lists
 ;            1 - Combines Active, Pending and Inactive
 ;                medications into the same list
 ;  CLASSORT  0 - Sort meds alphabetically
 ;            1 - Sort meds by drug class, and within the
 ;                same drug class, sort alphabetically
 ;            2 - Same as #1, but show drug class in header
 ;  SUPPLIES  0 - Supplies are excluded
 ;            1 - Supplies are included (Default)
 N NEXTLINE,EMPTY,INDEX,NODE,ISINP,KEEPMED,STATUS,ASTATS,PSTATS,OK
 N STATIDX,INPTYPE,OUTPTYPE,TYPE,MEDTYPE,MED,IDATE,XSTR,LLEN
 N SPACE60,DASH73,LINE,TAB,HEADER
 N DRUGCLAS,DRUGIDX,UNKNOWNS
 N NVATYPE,NVAMED,NVASTR,TIUXSTAT
 N %,%H,STOP,LSTFD ;Clean up after external calls...
 S (NEXTLINE,TAB,HEADER,UNKNOWNS)=0,LLEN=47
 S $P(SPACE60," ",60)=" ",$P(DASH73,"=",73)="="
 K @TARGET,^TMP("PS",$J)
 ; Check for Pharmacy Package and required patches
 I '$$PATCHSOK^TIULMED3 G LISTX ;P213
 I '+$G(ACTVONLY) S ACTVONLY=0
 I '+$G(DETAILED) S DETAILED=0
 I +$D(ALLMEDS) D
 .I ALLMEDS="I" S ALLMEDS=2
 .E  I ALLMEDS="O" S ALLMEDS=3
 I '+$G(ALLMEDS) S ALLMEDS=0
 I '+$G(ONELIST) S ONELIST=0
 I '+$G(CLASSORT) S CLASSORT=0
 I $G(SUPPLIES)'="0" S SUPPLIES=1
 S (EMPTY,HEADER)=1
 I ONELIST,'ALLMEDS,'DETAILED,'CLASSORT S HEADER=0
 I 'DETAILED S LLEN=60
 S ASTATS="^ACTIVE^REFILL^HOLD^PROVIDER HOLD^ON CALL^ACTIVE (S)^"
 S PSTATS="^NON-VERIFIED^DRUG INTERACTIONS^INCOMPLETE^PENDING^"
 S ISINP=($G(^DPT(DFN,.1))'="") ; Is this an inpatient? IA 10035
 I ISINP S INPTYPE=1,OUTPTYPE=2
 E  S INPTYPE=2,OUTPTYPE=1
 S NVATYPE=3
 D ADDTITLE^TIULMED1
 ;
 ; *** Scan medication data and skip unwanted meds ***
 ; Changes for *238 required by PSO*7*294
 D
 . I $$PATCH^XPDUTL("PSO*7.0*294"),+$D(TIUDATE) S TIUDATE=$$FMADD^XLFDT(DT,-$G(TIUDATE)) D OCL^PSOQ0496(DFN,TIUDATE,"") Q  ; IA 2400
 . D OCL^PSOORRL(DFN,"","") ; IA 2400
 ;
 S INDEX=0
 F  S INDEX=$O(^TMP("PS",$J,INDEX))  Q:INDEX'>0  D
 .S NODE=$G(^TMP("PS",$J,INDEX,0))
 .S KEEPMED=($L($P(NODE,U,2))>0) ;Discard Blank Meds
 .I KEEPMED D
 ..S STATUS=$P(NODE,U,9)
 ..I STATUS="ACTIVE/SUSP" S STATUS="ACTIVE (S)"
 ..I $F(ASTATS,"^"_STATUS_"^")>0 S STATIDX=1
 ..E  I ($F(PSTATS,"^"_STATUS_"^")>0) S STATIDX=2
 ..E  S STATIDX=3
 ..S TIUXSTAT=STATUS
 ..I ACTVONLY=1 S KEEPMED=(STATIDX<3)
 ..I ACTVONLY=2 S KEEPMED=(STATIDX=3)
 ..I +ONELIST S STATIDX=1
 ..; Changes for *238 required by PSO*7*294
 ..I $$PATCH^XPDUTL("PSO*7.0*294"),+$D(TIUDATE),STATUS["DISCONTINUED" S KEEPMED=0
 .I KEEPMED D
 ..S TYPE=$P($P(NODE,U),";",2)
 ..S TYPE=$S(TYPE="O":"OP",TYPE="I":"UD",1:"")
 ..S NVAMED=$P($P(NODE,U),";")
 ..S NVAMED=$E(NVAMED,$L(NVAMED))
 ..S KEEPMED=(TYPE'="")
 .I KEEPMED D
 ..I $O(^TMP("PS",$J,INDEX,"A",0))>0 S TYPE="IV"
 ..E  I $O(^TMP("PS",$J,INDEX,"B",0))>0 S TYPE="IV"
 ..I TYPE="OP" S MEDTYPE=OUTPTYPE
 ..E  S MEDTYPE=INPTYPE
 ..I NVAMED="N" S MEDTYPE=NVATYPE
 ..I ALLMEDS=0 D  I 1
 ...I MEDTYPE=INPTYPE S KEEPMED=ISINP
 ...E  S KEEPMED='ISINP
 ..E  I ALLMEDS=2 S KEEPMED=(MEDTYPE=INPTYPE)
 ..E  I ALLMEDS=3 S KEEPMED=(MEDTYPE=OUTPTYPE!(MEDTYPE=NVATYPE))
 .S DRUGCLAS=" "
 .S MED=$P(NODE,U,2)
 .I KEEPMED,(CLASSORT!('SUPPLIES)) D
 ..S DRUGIDX=$$IENNAME^TIULMED2(MED)
 ..D GETCLASS
 .. ; If DRUGIDX="" (MED not in Drug File 50), get info
 .. ; via Orderable Item instead.
 ..I KEEPMED,+DRUGIDX=0 D
 ...N IDX,ID,ORDIDX,TMPCLASS,CDONE,SDONE,TMPIDX,TMPNODE,ISSUPPLY
 ...S ID=$P(NODE,U),IDX=+ID,ID=$E(ID,$L(IDX)+1,$L(ID))
 ...S (DRUGIDX,ORDIDX)=0
 ...K ^TMP($J,"TIULMED")
 ...; IDX is Order #; ID indicates what file.  See IA 2400
 ...; R;O MED will always be in Drug File (Unless Drug File entry was
 ...;     changed after ordering.
 ...I ID="R;O" D  ;R;O = prescription (file #52). P213
 ....D RX^PSO52API(DFN,"TIULMED",IDX,"","0,O") ; IA 4820
 ....S DRUGIDX=+$G(^TMP($J,"TIULMED",DFN,IDX,6))
 ....S ORDIDX=+$G(^TMP($J,"TIULMED",DFN,IDX,"OI"))
 ...;
 ...I ID="P;O" D  ;P;O = pending outpatient order (file #52.41). P213
 ....D PEN^PSO5241(DFN,"TIULMED",IDX) ; IA 4821
 ....S DRUGIDX=+$G(^TMP($J,"TIULMED",DFN,IDX,11))
 ....S ORDIDX=+$G(^TMP($J,"TIULMED",DFN,IDX,8))
 ...;
 ...I ID="P;I" D  ;P;I = pending inpatient order (file #53.1)
 ....I $P($G(^PS(53.1,IDX,1,0)),U,4)=1 D  ; IA 2907
 .....S TMPIDX=$O(^PS(53.1,IDX,1,0)) I +TMPIDX D
 ......S DRUGIDX=$P($G(^PS(53.1,IDX,1,TMPIDX,0)),U)
 ....S ORDIDX=+$P($G(^PS(53.1,IDX,.2)),U)
 ...;
 ...I ID="U;I" D  ;U;I = unit dose order (file #55, subfile 55.06) P213
 ....D PSS431^PSS55(DFN,IDX,"","","TIULMED") ; IA 4826
 ....I +$G(^TMP($J,"TIULMED",IDX,"DDRUG",0))=1 D
 .....S TMPIDX=$O(^TMP($J,"TIULMED",IDX,"DDRUG",0)) Q:TMPIDX'>0
 .....S DRUGIDX=+$G(^TMP($J,"TIULMED",IDX,"DDRUG",TMPIDX,.01))
 .....S ORDIDX=+$G(^TMP($J,"TIULMED",IDX,108))
 ...;
 ...I ID="V;I" D  ;V;I = IV order (file #55, subfile 55.01). P213
 ....D PSS436^PSS55(DFN,IDX,"TIULMED") ; IA 4826
 ....; Get ORDIDX before DRUGIDX since global is not there after DRUGIDX
 ....S ORDIDX=+$G(^TMP($J,"TIULMED",IDX,130))
 ....I ^TMP($J,"TIULMED",IDX,"ADD",0)=1 D
 .....S TMPIDX=$O(^TMP($J,"TIULMED",IDX,"ADD",0)) I +TMPIDX D
 ......S TMPIDX=+$G(^TMP($J,"TIULMED",IDX,"ADD",TMPIDX,.01))
 ......I +TMPIDX S DRUGIDX=$$DRGIEN^TIULMED2(TMPIDX) ; IA 4662
 ...;
 ...S DRUGCLAS=""
 ...D GETCLASS
 ...I KEEPMED,+DRUGIDX=0,+ORDIDX,DRUGCLAS="" D
 ....S IDX=0,ISSUPPLY=2,CDONE='CLASSORT,SDONE=+SUPPLIES
 ....N LIST S LIST="TIULMED" K ^TMP($J,LIST)
 ....D DRGIEN^PSS50P7(ORDIDX,"",LIST) ; IA 4662
 ....F  S IDX=$O(^TMP($J,LIST,IDX)) Q:'IDX  D  Q:(CDONE&SDONE)
 .....S TMPCLASS=$$DRGCLASS^TIULMED2(IDX)
 .....S TMPNODE=U_TMPCLASS_U_$$DEA^TIULMED2(IDX)
 .....I 'CDONE,TMPCLASS="" S CDONE=1,DRUGCLAS=""
 .....I 'CDONE D
 ......I DRUGCLAS="" S DRUGCLAS=TMPCLASS
 ......E  I DRUGCLAS'=TMPCLASS S CDONE=1,DRUGCLAS=""
 .....I 'SDONE D
 ......S ISSUPPLY=(($E(TMPCLASS,1,2)="XA")&($P(TMPNODE,U,3)["S"))
 ......I 'ISSUPPLY S SDONE=1
 ....I 'SUPPLIES,(ISSUPPLY=1) S KEEPMED=0
 ..I (DRUGCLAS="")!('CLASSORT) S DRUGCLAS=" "
 .;
 .; *** Save wanted meds in "B" temp xref, removing duplicates ***
 .;
 .I KEEPMED D
 ..D ADDMED^TIULMED1(1) ; Get XSTR to check for duplicates
 ..;VMP OIFO BAY PINES;ELR;TIU*1.0*198;ADDED TIUXSTAT TO TMP GLOBAL
 ..S IDATE=$P(NODE,U,15)
 ..S OK='$D(@TARGET@("B",MED,XSTR,TIUXSTAT))
 ..I 'OK,(IDATE>@TARGET@("B",MED,XSTR,TIUXSTAT)) S OK=1
 ..I OK D
 ...S @TARGET@("B",MED,XSTR,TIUXSTAT)=IDATE_U_INDEX_U_MEDTYPE_STATIDX_U_TYPE_U_DRUGCLAS
 ...S EMPTY=0
 ...I DRUGCLAS=" " S UNKNOWNS=1
 ;
 D SORTSAVE^TIULMED3 K @TARGET@("B"),@TARGET@("C") ;P213
LISTX K ^TMP("PS",$J),^TMP($J,"TIULMED"),TIUDATE ; K TIUDATE added for PSO*7*294
 Q "~@"_$NA(@TARGET)
 ;
GETCLASS ;
 D GETCLASS^TIULMED3
 Q
