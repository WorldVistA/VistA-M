PSJPDRU1 ;BIR/MV-PADE REPORT UTILITIES ;18 JUN 96 / 2:58 PM
 ;;5.0;INPATIENT MEDICATIONS;**317**;16 DEC 97;Build 130
 ;
 ; Reference to ^%DT is supported by DBIA 10003.
 ; Reference to CLEAR^VALM1 is supported by DBIA 10116.
 ; Reference to ^XLFDT is supported by DBIA 10103.
 ; Reference to ^DPT supported by DBIA 10035
 ; Reference to ^PSDRUG supported by DBIA 2192
 Q
 ;
PATIENT(PSJINP) ; Get list of patients
 N PSJDONE,PATX,PAT,PATXX,PATSSN K PSJPAT,PSJSTOP
 S PSJSTOP=""
 D PATLIST^PSJPDRU1(.PSJINP)
 I $D(^TMP($J,"PSJPTLST","PAT"))<10 D  Q
 .W !!,"Patient: "
 .W !," No patients available for selection..",!
 F  Q:$G(PSJDONE)!$G(PSJSTOP)  D
 .D SELPAT^PSJPDRU1(.PSJINP)
 Q
 ;
PATLIST(PSJINP) ; Build list of patients that may be selected based on transaction date range and PADE Inbound System
 N PSJDEV,PADEV,PSDRG,PSJBDT,PSJEDT,PSJTRDT,TRANS,PSJDONE,PSUNAME,PSJII,PSPTNAME,PSPTLN,PSPTFN,PSPTID,PSPTND3,PATRAWID,PSJHTM,PSJDOTS
 S PSJHTM=$P($H,",",2),PSJDOTS=""     ; If search takes too long, may have to print "Searching..", followed by dots every 2 seconds
 K ^TMP($J,"PSJPTLST")
 K PAT S PSJII=1
 M PSJDEV=PSJINP("PADEV")
 M PSDRG=PSJINP("PSDRG")
 S PSJBDT=$G(PSJINP("PSJBDT"))
 S PSJEDT=$G(PSJINP("PSJEDT"))
 S PAT="" F  S PAT=$O(^PS(58.6,"P",PAT)) Q:PAT=""  D
 .D DISPDOTS^PSJPDRUT(.PSJHTM,.PSJDOTS,1)
 .S PSJTRDT=$$FMADD^XLFDT(PSJBDT,,,,-1),PSJDONE=0
 .F  S PSJTRDT=$O(^PS(58.6,"P",PAT,PSJTRDT)) Q:(PSJTRDT>PSJEDT)!$G(PSJDONE)!(PSJTRDT="")  D
 ..N PSDRG S PSDRG="" F  S PSDRG=$O(^PS(58.6,"P",PAT,PSJTRDT,PSDRG)) Q:PSDRG=""  D
 ...D DISPDOTS^PSJPDRUT(.PSJHTM,.PSJDOTS,1)
 ...S TRANS=0 F  S TRANS=$O(^PS(58.6,"P",PAT,PSJTRDT,PSDRG,TRANS)) Q:'TRANS  D
 ....I $E(PSDRG,1,3)'="zz~" Q:'$D(PSJINP("PSDRG",PSDRG))
 ....I $E(PSDRG,1,3)="zz~" Q:'$D(PSJINP("PSDRG","*"_$E(PSDRG,4,99)))
 ....N CAB,SYS,PSPTID,PATND0,PATSSN
 ....S CAB=$P($G(^PS(58.6,+TRANS,0)),"^",2) I CAB]"" Q:'$D(PSJINP("PADEV",CAB))
 ....S SYS=$P($G(^PS(58.6,+TRANS,1)),"^",3) I SYS]"" Q:SYS'=$G(PSJINP("PSJPSYSE"))
 ....S PATND0=$G(^DPT(+PAT,0)) S PSPTNAME=$P(PATND0,"^"),PATSSN=$P(PATND0,"^",9) I PATSSN S PSPTNAME=PSPTNAME_" ("_$E(PATSSN,$L(PATSSN)-3,$L(PATSSN))_")"
 ....S PSPTND3=$G(^PS(58.6,+TRANS,3)) S PSPTLN=$P(PSPTND3,"^",5),PSPTFN=$P(PSPTND3,"^",6),PATRAWID=$P(PSPTND3,"^",7)
 ....S PSPTID=$S(($G(PAT)):PAT,$G(PATRAWID):PATRAWID,PAT="zz":"-",1:PAT)
 ....S PATSSN=$S($G(PATSSN):PATSSN,1:PSPTID)
 ....I PSPTNAME="" S PSPTNAME=$S((PSPTLN'="")&(PSPTFN'=""):PSPTLN_","_PSPTFN,PSPTLN'="":PSPTLN,PSPTFN'="":PSPTFN,1:"")
 ....I PSPTNAME="" S PSPTNAME=$P(PSPTND3,"^",4)
 ....I PSPTID="-",(PSPTNAME]"") S PSPTID="*",PSPTNAME="UNKNOWN PATIENT" S:'$G(PATSSN) PATSSN="*"
 ....I PSPTNAME="" S PSPTNAME="NO PATIENT"
 ....;
 ....S ^TMP($J,"PSJPTLST","PAT",PSPTID)=PSPTNAME,^TMP($J,"PSJPTLST","PATX",PSPTNAME)=PSPTID
 ....I PATSSN?9N S ^TMP($J,"PSJPTLST","PSPSSN",$E(PATSSN,6,9),PSPTID)=PSPTNAME
 ....I PATSSN'="" S ^TMP($J,"PSJPTLST","PATRAW",PATSSN)=PSPTNAME
 ....I PAT'="zz" S PSJDONE=1
 ....S PSJII=PSJII+1
 Q
 ;
SELPAT(PSJINP) ; Prompt for one patient (or ALL)
 N DIR,X,Y,PATNAME,DUOUT,DTOUT
 N PSJPART,II,PSELMSG,PLSTMSG
 K PSJSTOP S PSJSTOP=""
 W ! D EN^DDIOL(" Enter '^ALL' to select all Patients associated with PADE transactions.") W !
 S PLSTMSG(1)="Transactions matching the entered Date Range and Division "
 S PLSTMSG(2)="exist for the Patients listed below."
 S DIR(0)="FAO^1:30",DIR("?")="^D TMPLIST^PSJPDRU1(""PATRAW"",20)"
 ;
 S DIR("A")="Select Patient: "_$S($D(^TMP($J,"PSJPTLST","SELPAT"))>1:"",1:"^ALL// ")
 D ^DIR I X="" S Y=$S($D(^TMP($J,"PSJPTLST","SELPAT"))<10:"ALL",1:"")
 I $E(X)="^" S Y=$$XALL^PSJPDRIP(X)
 I $G(DUOUT)!$G(DTOUT) S PSJSTOP=1 Q
 I Y="ALL" M ^TMP($J,"PSJPTLST","SELPAT")=^TMP($J,"PSJPTLST","PAT") S ^TMP($J,"PSJPTLST","SELPAT")="ALL",PSJDONE=1 Q
 I Y="" D  Q
 .I $D(^TMP($J,"PSJPTLST","SELPAT"))>1 S PSJDONE=1 Q
 .W !!?2,"Select a single Patient, several Patients or enter ^ALL to select all Patients."
 S PSJY=Y
 I $D(^TMP($J,"PSJPTLST","PSPSSN",PSJY)) D  Q
 .N I,SSN,ID,DIR,LISTDIR,LISTARR,NAME
 .S SSN=PSJY S ID="" F I=1:1 S ID=$O(^TMP($J,"PSJPTLST","PSPSSN",SSN,ID)) Q:ID=""  D
 ..I I=1 D  Q
 ...S LISTDIR="1:"_^TMP($J,"PSJPTLST","PSPSSN",SSN,ID)_"("_SSN_")",LISTARR(1)=ID_"^"_^TMP($J,"PSJPTLST","PSPSSN",SSN,ID)
 ...S DIR("A",1)="1   "_^TMP($J,"PSJPTLST","PSPSSN",SSN,ID)
 ..S LISTDIR=$G(LISTDIR)_";"_I_":"_^TMP($J,"PSJPTLST","PSPSSN",SSN,ID)_"("_SSN_")",LISTARR(I)=ID_"^"_^TMP($J,"PSJPTLST","PSPSSN",SSN,ID)
 ..S DIR("A",I)=I_"   "_^TMP($J,"PSJPTLST","PSPSSN",SSN,ID)
 .I '$O(DIR("A",1)) S Y=1 W "   "_$P(LISTARR(Y),"^",2)
 .I $O(DIR("A",1)) S DIR(0)="SOA^"_LISTDIR,DIR("A")="Select Patient: " D ^DIR
 .I Y S ID=$P(LISTARR(Y),"^"),NAME=$P(LISTARR(Y),"^",2),^TMP($J,"PSJPTLST","SELPAT",ID)=NAME
 I $D(^TMP($J,"PSJPTLST","PAT",PSJY)) D  Q
 .W "  ",^TMP($J,"PSJPTLST","PAT",PSJY) S ^TMP($J,"PSJPTLST","SELPAT",PSJY)=^TMP($J,"PSJPTLST","PAT",PSJY)
 I $D(^TMP($J,"PSJPTLST","PATX",PSJY)) D  Q
 .W "  ",^TMP($J,"PSJPTLST","PATX",PSJY) S ^TMP($J,"PSJPTLST","SELPAT",PSJY)=^TMP($J,"PSJPTLST","PATX",PSJY)
 S PSELMSG="Select a Patient"
 D PARTPT^PSJPDRU1(PSJY)
 Q:$D(^TMP($J,"PSJPTLST","SELPAT"))>1
 W "  ?? (No match found)"
 Q
 ;
TMPLIST(LIST,MAX) ; Write list in LIST(ID1)=ID1
 N II,DRGNAME,NUMBER,TAB,NAME,ID1,ID2,PSCNT,DUOUT,DTOUT,DIR,X,Y
 S $P(TAB," ",80)=""
 S PSCNT=0
 Q:$D(^TMP($J,"PSJPTLST",LIST))<10
 S ID1="" F  S ID1=$O(^TMP($J,"PSJPTLST",LIST,ID1)) Q:ID1=""!$G(DTOUT)!$G(DUOUT)  D
 .I ^TMP($J,"PSJPTLST",LIST,ID1)="" W !,$E(TAB,1,10)_ID1 Q
 .N PSJMARG
 .S PSJMARG=$S($E(ID1)="*":$E(TAB,1,17),1:$E(TAB,1,14-$L(ID1)))
 .W !,PSJMARG_ID1_"    "_$P(^TMP($J,"PSJPTLST",LIST,ID1),"^")_" "_$P(^TMP($J,"PSJPTLST",LIST,ID1),"^",2)
 .S PSCNT=$G(PSCNT)+1
 .I $G(MAX),(PSCNT>$G(MAX)) W !! S DIR(0)="E" D ^DIR S PSCNT=0 W !!
 Q
 ;
PARTPT(PSJY) ; Lookup PSJY in INARRAY
 ; INPUT  - PSJY=Lookup text
 ;        - INARRAY(text)=number - Array of selectable data
 ; OUTPUT - OUTARRAY(text)=number - Entry selected from INARRAY
 ;
 N PSJPART,ITMNAME,II,ITM,ITMX,Y,PSJTMP
 ;
 ;     ^TMP($J,"PSJPTLST","PAT",PSPTID)=PSPTNAME
 ;     ^TMP($J,"PSJPTLST","PATX",PSPTNAME)=PSPTID
 ;     I PATSSN?9N S ^TMP($J,"PSJPTLST","PSPSSN",$E(PATSSN,6,9),PSPTID)=PSPTNAME
 ;     I PATSSN'="" S ^TMP($J,"PSJPTLST","PATRAW",PATSSN)=PSPTNAME
 ;
 K ^TMP($J,"PSJPTLST","ITM"),^TMP($J,"PSJPTLST","ITMX")
 S II=1,ITMID="" F  S ITMID=$O(^TMP($J,"PSJPTLST","PAT",ITMID)) Q:ITMID=""  D
 .Q:ITMID="IEN"!(ITMID="NAME")
 .S ^TMP($J,"PSJPTLST","ITM",ITMID)=$P(^TMP($J,"PSJPTLST","PAT",ITMID),"^")
 .S ^TMP($J,"PSJPTLST","ITMX",^TMP($J,"PSJPTLST","PAT",ITMID))=$P(^TMP($J,"PSJPTLST","PAT",ITMID),"^",2)
 ;
 Q:$D(^TMP($J,"PSJPTLST","ITM"))<10
 F ITM="" F  S ITM=$O(^TMP($J,"PSJPTLST","ITM",ITM)) Q:ITM=""  D
 .I $E(ITM,1,$L(PSJY))=PSJY S PSJPART(II,ITM)=^TMP($J,"PSJPTLST","PAT",ITM) S II=II+1 Q
 .I $E(^TMP($J,"PSJPTLST","ITM",ITM),1,$L(PSJY))=PSJY S PSJPART(II,ITM)=^TMP($J,"PSJPTLST","ITM",ITM) D  Q
 ..S PSJPART(II,ITM)=PSJPART(II,ITM) S II=II+1
 ;
 I $D(PSJPART(1)) D
 .N DIR,STRING,CNT
 .I '$O(PSJPART(1)) S PSJTMP=$O(PSJPART(1,"")) S ^TMP($J,"PSJPTLST","SELPAT",PSJTMP)=PSJPART(1,PSJTMP) D  Q
 ..W !," "_$O(PSJPART(1,"")),?15,PSJPART(1,PSJTMP)
 .S CNT=0 F  S CNT=$O(PSJPART(CNT)) Q:'CNT  D
 ..N ITMID S ITMID=$O(PSJPART(CNT,""))
 ..S STRING=$G(STRING)_CNT_":"_ITMID_";"
 ..S DIR("A",CNT)="   "_CNT_"      "_ITMID_"   "_$P($G(PSJPART(CNT,ITMID)),"^")
 .S DIR("A")="Choose 1-"_+$O(PSJPART(9999999),-1)_": "
 .S DIR(0)="SAO^"_STRING D ^DIR
 .I Y>0 N PSPTSEL S PSPTSEL=$O(PSJPART(+Y,"")),^TMP($J,"PSJPTLST","SELPAT",PSPTSEL)=$G(PSJPART(+Y,PSPTSEL)) D  Q
 ..N ID2 S ID2=$G(PSJPART(+Y,PSPTSEL)) I ID2]"" W "  ",ID2
 .S PSJY=""
 Q
 ;
PTTRFLG(PSJINP)  ; Return patient selection flag
 ; INPUT: PSJINP array of all responses to report prompts
 ; OUTPUT: FLAG indicating    1-All (Patients and Missing, or Blank, Patients), 
 ;                            2-Only Individual Patients (exclude missing pateints),
 ;                            0-Only Missing or Blank patients
 K PATFLG,PSJOB
 S PATFLG=0
 S PSJOB=$S($G(PSJINP("PSJTSK")):+$G(PSJINP("PSJTSK")),1:$J)
 S PATFLG=($G(^TMP(PSJOB,"PSJPAT"))="ALL")                          ; All individual patients PLUS all non-patient transactions
 I 'PATFLG S PATFLG=$O(^TMP(PSJOB,"PSJPAT",0)) D                    ; One or more individual patients
 .I PATFLG!(PATFLG="*") S PATFLG=2
 I PATFLG=2,$D(^TMP(PSJOB,"PSJPAT","-")) S PATFLG=1                 ; One or more individual patients PLUS non-patient transactions
 Q PATFLG
 ;
LIST(LIST,MSG) ; Write list in LIST(ID1)=ID1
 N II,DRGNAME,NUMBER,TAB,NAME,ID1,ID2
 S $P(TAB," ",80)=""
 Q:$D(LIST)<10
 I $L($G(MSG)) W !,MSG,!
 I $D(MSG)>1 D  W !
 .S II=0 F  S II=$O(MSG(II)) Q:'II  W !,MSG(II)
 S ID1="" F  S ID1=$O(LIST(ID1)) Q:ID1=""  D
 .I LIST(ID1)="" W !,$E(TAB,1,10)_ID1 Q
 .W !,$E(TAB,1,14-$L(ID1))_ID1_"    "_$P(LIST(ID1),"^")_" "_$P(LIST(ID1),"^",2)
 Q
 ;
BLDSTR(PSJINP,PSLNOD,PSJCOMM)  ; Build output data string
 ; INPUT:  PSJINP() = array of user report input/selections
 ;         PSLNOD   = header node from PADE INBOUND TRANSACTION file (#58.6), by way of LIST^DIC call output in ^TMP($J,"TSCREEN"
 ; OUTPUT: PSLNDSTR  = string of report output to be stored in ^TMP($J,"PSJPDRTR"
 N PSJPSYS,PSJCAB,PSJDRG,II,PSJCOL,PSJOVR,PSJUID,PSJPAT,PSJQTY,PSJTTYP,PSJPUSR,PSJTYABB,PSAB,PSTMP,PSJTRDT,PSJTRDMO,PSJTYPNM,PSJTYPCD
 N PSJUSRID,PSJWITID
 S PSJPSYS=+PSJINP("PSJPSYS")
 M PSJCAB=PSJINP("PADEV")
 M PSJDRG=PSJINP("PSDRG")
 ;  Format Date to external
 K PSLNDSTR
 S PSLNDSTR=$P(PSLNOD,"^",6,99)
 S PSJTRDT=$TR($P($$FMTE^XLFDT($P(PSLNDSTR,"^"),2),":",1,2),"@"," ")
 S $P(PSJTRDT,"/")=$TR($J($P(PSJTRDT,"/"),2)," ",0)
 S $P(PSLNDSTR,"^")=PSJTRDT
 ;  Format Override; depends on transaction type of the 58.6 entry (e.g., load/unload can't be an override, should be null)
 S PSJTYPNM=$P(PSLNDSTR,"^",2)
 S PSJTYPCD=$$EXTT^PSJPDRUT(PSJTYPNM)
 ;S PSJOVR=$S(PSJTYPCD="V":1,(PSJTYPCD="R"):1,1:"") I PSJOVR S PSJOVR=$S($P(PSLNDSTR,"^",3):"N",1:"Y")
 S PSJOVR=$$PTRNSTYP^PSJPAD7I(PSJTYPCD) S:'PSJOVR PSJOVR=""
 I PSJOVR S PSJOVR=$S($P(PSLNDSTR,"^",3):"N",1:"Y")
 S $P(PSLNDSTR,"^",3)=$S($G(PSJINP("PSJDELM"))="R":" "_PSJOVR,1:PSJOVR)
 ;  Format Patient (Add ID to name - last 4 of SSN)
 S PSJPAT=$P(PSLNDSTR,"^",7) D
 .N PATNAME,PATSSN
 .S PATNAME=$P($G(^DPT(+PSJPAT,0)),"^")
 .I PATNAME="" D  Q
 ..N TRANS S TRANS=+$G(PSLNOD)
 ..S PSJPAT=$P($G(PSLNDSTR),"^",13)
 ..I TRANS S PATSSN=$P($G(^PS(58.6,+TRANS,3)),"^",7) I PATSSN S PSJPAT=PSJPAT_"("_PATSSN_")"
 .S PATSSN=$P($G(^DPT(+PSJPAT,0)),"^",9) Q:$G(PATSSN)=""
 .S PSJPAT=PATNAME_"("_$E(PATSSN,6,9)_")"
 S $P(PSLNDSTR,"^",7)=PSJPAT
 ;  Pull out Comment to PSJCOMM.
 S PSJCOMM=$P(PSLNDSTR,"^",12)
 ;  Add ID's to User and Witness
 S PSJPUSR=""
 S PSJUSRID=$P(PSLNDSTR,"^",8) D
 .Q:PSJUSRID=""  S PSJPUSR=$$PADEUSR^PSJPDRUT(+$G(PSJPSYS),PSJUSRID)
 .I 'PSJPUSR S PSJPUSR=$P(PSJPUSR,"^",3)
 .S PSJUSRID="("_PSJUSRID_")"
 S PSJWITID=$P(PSLNDSTR,"^",10) S:PSJWITID'="" PSJWITID="("_PSJWITID_")"
 F II=4:1:6 S PSTMP=$P(PSLNDSTR,"^",II) I PSTMP["." S PSTMP=$P(PSTMP,".")_"."_$E($P(PSTMP,".",2),1,2),$P(PSLNDSTR,"^",II)=PSTMP
 ; If Expected Balance is null, check for Actual Balance
 N PSABC,PSEBC S PSABC=$P(PSLNOD,"^",23),PSEBC=$P(PSLNDSTR,"^",10)
 S $P(PSLNDSTR,"^",10)=$S(((PSEBC="")&PSABC):PSABC,1:PSEBC)
 S PSLNDSTR=$P(PSLNDSTR,"^",1,7)_"^"_$S($P(PSJPUSR,"^",2)]"":$P(PSJPUSR,"^",2),1:$P(PSLNDSTR,"^",9))_PSJUSRID_"^"_$P(PSLNDSTR,"^",11)_PSJWITID_"^^"
 ;  Transaction Type conversion
 S PSJTTYP=$$TTEX^PSJPDRUT(PSJTYPCD)
 ;
 ;  Signed Quantity as interpreted by PADE inbound based on Transaction Type 
 S PSJQTY=+$P(PSLNDSTR,"^",5) D
 .N TMPARRAY,TSIGN S TMPARRAY(6)=PSJQTY
 .S TMPARRAY(5)=$$EXTT^PSJPDRUT(PSJTTYP)
 .S TSIGN=$$TSIGN^PSJPADIT(.TMPARRAY) S TSIGN=$S(TSIGN="-":"-",1:"")
 .S TMPARRAY(6)=$S(PSJQTY["-":PSJQTY/-1,1:PSJQTY)
 .S PSJQTY=$S($G(TMPARRAY(5))="W":"NA",$G(TMPARRAY(6)):TSIGN_TMPARRAY(6),1:0)
 ;
 I PSJQTY["." S PSJQTY=$P(PSJQTY,".")_"."_$E($P(PSJQTY,".",2),1,2)
 S $P(PSLNDSTR,"^",5)=PSJQTY
 ;
 I PSJTTYP="Count" D
 .N PSENDBAL,PSBEGBAL S PSENDBAL=$P(PSLNDSTR,"^",6) I 'PSENDBAL,$G(PSJQTY) S PSENDBAL=PSJQTY S $P(PSLNDSTR,"^",6)=PSJQTY
 .S PSBEGBAL=$P(PSLNDSTR,"^",4) I 'PSBEGBAL,$G(PSJQTY) S PSBEGBAL=PSJQTY S $P(PSLNDSTR,"^",4)=PSJQTY
 ;  Right Justify Quantities if formatted output
 I $G(PSJINP("PSJDELM"))'="D" F II=4:1:6 S $P(PSLNDSTR,"^",II)=$J($P(PSLNDSTR,"^",II),5)
 S $P(PSLNDSTR,"^",2)=PSJTTYP
 ; If delimited output, make adjustments
 I $G(PSJINP("PSJDELM"))="D" D
 .; If delimited output, add comment to end of string
 .I PSJCOMM'="" S PSLNDSTR=PSLNDSTR_"^"_PSJCOMM
 .; Break out Patient,User, and Witness ID's into separate delimited pieces if delimited output
 .N PIECE F PIECE=7,9,11 D
 ..N NAMID,NAM,ID S NAMID=$P(PSLNDSTR,"^",PIECE)
 ..S NAM=$P(NAMID,"("),ID=$P(NAMID,"(",2),ID=$TR(ID,")")
 ..S PSLNDSTR=$P(PSLNDSTR,"^",1,PIECE-1)_"^"_NAM_"^"_ID_"^"_$P(PSLNDSTR,"^",PIECE+1,99)
 Q PSLNDSTR
 ;
INSYSPAR(PSPARACT)  ; Allow edit of PSJ PADE OE BALANCES parameter.
 ; Input = PSPARACT - Default parameter setting - only prompt if 0(NO). 
 ;                  - If 1(YES), set without prompting - if vendor is activated, system must also be activated
 N DIR,X,Y,PSPARIEN,PSALLOFF,PSPARVAL,PSPARER
 S PSPARIEN=$$FIND1^DIC(8989.51,,,"PSJ PADE OE BALANCES")
 S PSALLOFF=0
 I '$G(PSPARACT) D  Q:'PSALLOFF
 .S DIR(0)="YAO",DIR("B")="Y"
 .S DIR("A")="Completely disable PADE IOE indicators (for ALL vendors)? "
 .S DIR("?",1)=" This sets the ""PSJ PADE OE BALANCES"" system parameter that"
 .S DIR("?",2)=" inactivates all PADE indicators in Inpatient Order Entry,"
 .S DIR("?",3)=" (IOE) for all vendors. To inactivate one specific vendor only,"
 .S DIR("?")=" use the ""DISPLAY PADE INDICATORS IN IOE?"" prompt."
 .D ^DIR
 .S PSALLOFF=$S($G(Y):1,1:0)
 S PSPARVAL=$S($G(PSPARACT):1,1:0)
 D EN^XPAR("SYS",PSPARIEN,,PSPARVAL,"PSPARER")
 I $D(PSPARER)>1 W !,"ERROR - Parameter not set"
 Q
 ;
DEVONOFF(PSJPSYS,OFFON)  ; Set status of all dispensing devices (cabinet) to OFF or ON for system PSJPSYS
 ;
 N DIE,DA,DR,X,Y,PSVAL
 N FDA,PSERR
 N PSICAB  ; Pointer to cabinet in PADE INVENTORY SYSTEM "DEVICE" subfile (not to cabinet ien in DEVICE file #58.63)
 N PSDCAB  ; Pointer to cabinet in PADE DISPENSING DEVICE (#58.63) file
 Q:'$G(PSJPSYS)
 Q:'$D(^PS(58.601,+$G(PSJPSYS),"DEVICE"))
 Q:($G(OFFON)'=1)&($G(OFFON)'=0)   ; must be 1(yes=ACTIVE) or 0(no=INACTIVE)
 S PSICAB=0 F  S PSICAB=$O(^PS(58.601,+$G(PSJPSYS),"DEVICE",PSICAB)) Q:'PSICAB  D
 .S PSDCAB=+$G(^PS(58.601,PSJPSYS,"DEVICE",PSICAB,0))
 .Q:'$G(PSDCAB)  Q:'$D(^PS(58.63,+PSDCAB,0))  ; Device not in device file #58.63
 .S PSVAL=$S(OFFON=1:"A",1:"I")
 .S FDA(58.63,PSDCAB_",",4)=PSVAL
 .D FILE^DIE("","FDA","PSERR")
 Q
 ;
DEVSTCHK(PSJPSYS)  ; Return status of all dispensing devices (cabinet) for system PSJPSYS
 ;  If all devices have a status OFF, return 0; if ANY devices do NOT have a status of INACTIVE, return 1
 N DIE,DA,DR,X,Y,PSTATUS
 N PSICAB  ; Pointer to cabinet in PADE INVENTORY SYSTEM "DEVICE" subfile (not to cabinet ien in DEVICE file #58.63)
 N PSDCAB  ; Pointer to cabinet in PADE DISPENSING DEVICE (#58.63) file
 Q:'$G(PSJPSYS) 0
 Q:'$D(^PS(58.601,+$G(PSJPSYS),"DEVICE")) 0
 S PSTATUS=0
 S PSICAB=0 F  S PSICAB=$O(^PS(58.601,+$G(PSJPSYS),"DEVICE",PSICAB)) Q:'PSICAB!$G(PSTATUS)  D
 .S PSDCAB=+$G(^PS(58.601,PSJPSYS,"DEVICE",PSICAB,0))
 .Q:'$G(PSDCAB)  Q:'$D(^PS(58.63,+PSDCAB,0))  ; Device not in device file #58.63
 .S PSTATUS=$P($G(^PS(58.63,+PSDCAB,0)),"^",4)
 .S PSTATUS=$S(PSTATUS="I":0,1:1)
 Q PSTATUS
 ;
DELBADSY ; Check for and delete "?BAD" entries in PADE INVENTORY SYSTEM file (#58.601)
 ; "?BAD" entry may result when user enters "" new DISPENSING DEVICE (#58.63) file entry, and FileMan creates the "?BAD" KEY index
 N SYS,SYSNAM,BADSYS
 S SYS=0 F  S SYS=$O(^PS(58.601,SYS)) Q:'SYS  D
 .I $G(^PS(58.601,SYS,0))="?BAD",'$D(^PS(58.601,SYS,4)) S BADSYS(SYS)=$P($G(^PS(58.601,SYS,0)),"^")
 Q:'$D(BADSYS)
 S SYS=0 F  S SYS=$O(BADSYS(SYS)) Q:'SYS  D
 .Q:$G(BADSYS(SYS))'="?BAD"
 .N DIK,DA
 .S DIK="^PS(58.601,",DA=+SYS D ^DIK
 Q
 ;
TSIGN(PADATA) ; Determine if the transaction amount needs to be added or subtracted, depending on the transaction type
 N TRNSIGN,II
 S TRNSIGN="" F II="V","B","U","E","D" I PADATA(5)=II S TRNSIGN="-"
 I PADATA(5)="A"&($E(PADATA(6))="-") S TRNSIGN="-"  ; Discrepancies (type="A") may be either + or -
 Q $S(TRNSIGN="-":"-",1:"")
 ;
DEVBAL(PADESYS,PADEDEV,DRUGIEN)  ; Calculate Device BALANCE for PADE device=PADEDEV drug=DRUGIEN
 K DEVBAL S DEVBAL=""                        ; Initialize returned balance
 N DRAWER                                      ; Pocket_subdrawer IEN
 N DRWOUT,DEVOUT                               ; Return array from LIST^DIC
 N DRWDRG
 N PSERR
 N DRWTOT
 ; We need system and device to find device balance
 I '$G(PADESYS)!'$G(PADEDEV) Q ""
 ;
 Q:'DRUGIEN ""
 S DRAWER=0 F  S DRAWER=$O(^PS(58.601,PADESYS,"DEVICE",PADEDEV,"DRAWER",DRAWER)) Q:'DRAWER  D
 .S DRWDRG=0 F  S DRWDRG=$O(^PS(58.601,PADESYS,"DEVICE",PADEDEV,"DRAWER",DRAWER,"DRUG","B",DRWDRG)) Q:'DRWDRG  D
 ..Q:DRWDRG'=DRUGIEN   ; Is this the drug we're looking for?
 ..N DRWDRIEN          ; The IEN of the drug's entry in the drawer
 ..S DRWDRIEN=$O(^PS(58.601,PADESYS,"DEVICE",PADEDEV,"DRAWER",DRAWER,"DRUG","B",DRWDRG,0))
 ..Q:'DRWDRIEN         ; Bad index - this shouldn't happen
 ..S DRWTOT=$P($G(^PS(58.601,PADESYS,"DEVICE",PADEDEV,"DRAWER",DRAWER,"DRUG",DRWDRIEN,0)),"^",2)
 ..S DEVBAL=$G(DEVBAL)+DRWTOT
 Q DEVBAL
