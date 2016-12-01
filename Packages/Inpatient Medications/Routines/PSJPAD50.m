PSJPAD50 ;BIR/JCH PADE DRUG LOOKUP ;8/25/15
 ;;5.0;INPATIENT MEDICATIONS;**317**;16 DEC 97;Build 130
 ;
 ; Reference to ^VADPT is supported by DBIA 10061.
 ; Reference to EN^DDIOL is supported by DBIA 10142.
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^SC( is supported by DBIA 10040.
 ;
 Q
 ;
READDD(PSJDRG,PSJOI,PSJLOC,PSJORD,PSGORD) ; Get Dispense Drug
 ;  Input :  PSJDRG - (required) Pointer to DRUG file (#50)
 ;           PSJOI  - (optional) Pointer to PHARMACY ORDERABLE ITEM (#50.7) file 
 ;           PSJLOC - (required) Pointer to WARD (#42) file if input value is purely numeric
 ;                               Pointer to Hospital Location (#44) if last character of input value is "C"
 ;           PSJORD - (optional) Inpatient Order number, pointer to NON-VERIFIED ORDERS (#53.1) file or PHARAMCY PATIENT (#55) file
 ;           PSGORD - (optional) Inpatient Order number, pointer to NON-VERIFIED ORDERS (#53.1) file or PHARMACY PATIENT (#55) file
 ;
 N DTOUT,DUOUT,PSII,PSJDONE
 I '$G(PSJLOC)!(($E($G(PSJLOC),$L($G(PSJLOC)))'="W")&($E($G(PSJLOC),$L($G(PSJLOC)))'="C")) D
 .N LOCTYP,CLFLAG
 .S (LOCTYP,CLFLAG)=""
 .I '$G(DFN),$G(PSGP) N DFN S DFN=PSGP
 .I '$G(VAIN(4)),$G(DFN) N VAIN,VAINDT,VAROOT,VAHOW D INP^VADPT
 .I $G(PSJORD) S CLFLAG=$S($E(PSJORD,$L(PSJORD))="U":$G(^PS(55,+$G(DFN),5,+PSJORD,8)),$E(PSJORD,$L(PSJORD))="P":$G(^PS(53.1,+PSJORD,"DSS")),1:"")
 .S LOCTYP=$S($D(^SC(+CLFLAG,0))&$P(CLFLAG,"^",2)?7N1.E:"CL",1:"WD")
 .S PSJLOC=$S((LOCTYP="CL")&CLFLAG:+CLFLAG_"CL",(LOCTYP="WD")&$G(VAIN(4)):+$G(VAIN(4))_"WD",1:"")
 F PSII=1:1:2 Q:$G(DTOUT)!$G(DUOUT)!$G(PSJDONE)  D READLOOP($G(PSJDRG),$G(PSJOI),$G(PSJLOC),$G(PSJORD),$G(PSGORD),PSII,.PSJDONE)
 Q
 ;
READLOOP(PSJDRG,PSJOI,PSJLOC,PSJORD,PSGORD,PSII,PSJDONE)  ; Prompt for dispense drug until intentionally exits
 ;    PSJSRCH - (optional)Partial name search done, drug selected from list, present Drug .01 field for edit
 N PSJDSRCH,NEWDRG,PSJSRCH,PSJDRG
 K PSJDONE
 ;
 S PSJSRCH=""
 S PSJLOC=$S($G(PSJLOC)["C":$G(PSJLOC),1:+$G(PSJLOC))
 F  Q:$G(DTOUT)!$G(NEWDRG)!$G(DUOUT)!$G(PSJDONE)  D
 .S PSJSRCH=""
 .S NEWDRG=$$PROMPT(.PSJDRG,.PSJDSRCH,PSJOI,PSJLOC,PSJORD,.PSJSRCH,PSII)
 ; If user quit, don't file anything into ^PS(53.4502
 Q:$G(DUOUT)!$G(DTOUT)
 ; If something was changed, file the change into ^PS(53.4502
 I $G(NEWDRG) D FILE(.NEWDRG,PSJSRCH)
 Q
 ;
PROMPT(DRGIEN,DRGSRCH,PSJOI,PSJLOC,PSJORD,PSJSRCH,PSII)  ;  Prompt for Dispense Drug
 ; Input: DRGIEN = pointer to DRUG (#50)
 ;        PSJOI  = pointer to pharmacy orderable item (#50.7)
 ;        PSJLOC = Patient ward location or order's clinic location
 ;        PSJORD = Inpatient Order, pointer to file 55 or 53.1
 ;        SELSRCH= Drug was selected from numbered list
 N DRGNAME,DIR,DA,X,Y,NEWDRIEN,DI,DCT,TMPSRCH
 K DRG
 S DIR(0)="FAO^1:30"
 S DRGNAME=""
 S DRGIEN=$G(DRGIEN)
 S DCT=0 F  S DCT=$O(^PS(53.45,PSJSYSP,2,DCT)) Q:'DCT  D
 .N DRGNAME
 .S DRGIEN=+$G(^PS(53.45,PSJSYSP,2,DCT,0))
 .Q:'$G(DRGIEN)
 .S DRGNAME=$P($G(^PSDRUG(+DRGIEN,0)),"^")
 .S DRGIEN(DCT)=DRGIEN_"^^"_DRGNAME,DRGIEN("NAM",DRGNAME,DCT)="",DRGIEN("NUM",+DRGIEN(DCT),DCT)=""
 I 'DRGIEN S DRGIEN=$O(DRGIEN("")),DRGIEN=+$G(DRGIEN(+DRGIEN))
 ;
 I $G(PSII)>1 S DRGIEN=""
 I $G(PSJORD) N PSJLOC S PSJLOC=$$ORDLOC($G(PSJORD),$G(PSGP))
 ;
 S NEWDRIEN=""
 K DRGSRCH
 S DRGNAME=$S($G(DRGIEN):$P($G(^PSDRUG(+DRGIEN,0)),"^"),1:"")
 S DIR("A")="Select DISPENSE DRUG: "_$S(DRGNAME]"":DRGNAME_"//",1:"")
 S DIR("?")="^D SEARCH^PSJPAD50(.DRGIEN,"""",PSJLOC,.NEWDRG,PSJOI,1)"
 ; Quit if default accepted, or user wants out
 D ^DIR I X=""!$G(DUOUT)!$G(DTOUT) D  Q DRGIEN
 .I '$G(DRGIEN) S PSJDONE=1
 ;
 I X="@",$G(DRGIEN) D  Q NEWDRIEN
 .I $G(PSJORD)["U" K X S NEWDRIEN="" D
 ..D EN^DDIOL("Drugs for active orders cannot be deleted, but can be given an INACTIVE DATE")
  .; If Pending renewal, set flag to prevent change to dispense drug, can only be inactivated.
 .N PSJPNDRN I $G(PSGORD) I $E(PSGORD,$L(PSGORD))="P",$P($G(^PS(53.1,+PSGORD,0)),"^",24)="R" K X S NEWDRIEN="" D
 ..D EN^DDIOL("Dispense drugs for renewal orders cannot be deleted, but can be given an INACTIVE DATE.")
 .I $G(X)="" D EN^DDIOL("<NOTHING DELETED>") Q
 .N DIR S DIR(0)="Y",DIR("A")="SURE YOU WANT TO DELETE THE ENTIRE DISPENSE DRUG" D ^DIR
 .S NEWDRIEN=DRGIEN_"^@"
 ; Default not accepted
 S TMPSRCH=X,PSJSRCH=1
 I X]"" D SELSRCH(.DRGIEN,.NEWDRIEN,PSJOI,PSJLOC,TMPSRCH)
 ;
 S:NEWDRIEN<1 NEWDRIEN=""
 I 'NEWDRIEN K DRGSRCH
 Q NEWDRIEN
 ;
SEARCH(DRGIEN,DRGSRCH,PSJLOC,NEWDRG,PSJOI,PSJHELP) ; Search Drug (#50) file using user input
 ; Input:   DRGIEN - Pointer to DRUG file (#50) passed in - default dispense drug
 ;         DRGSRCH - Search value for DRUG file (user input)
 ;          PSJLOC - Location of current order - Patient Ward (inpatient) or Clinic (clinic order)
 ;          NEWDRG - Pointer to DRUG file (#50) selected by user
 ;           PSJOI - Pointer to Pharmacy Orderable Item (#50.7), associated with order
 ;         PSJHELP - Flag indicating search is for 1) display only:      $G(PSJHELP)
 ;                                              or 2) allows selection: '$G(PSJHELP)
 ;
 N PSJSEL,PSJLIST,PSJDCNT,PSJDIEN,PSJCONT
 S PSJCONT=1
 ;
 D DDLIST(.DRGIEN)
 ;
 S PSJLIST="",PSJOSCRN="",DRGSRCH="?"
 S PSJSEL=$$PSDRUG(DRGIEN,DRGSRCH,.PSJLIST,PSJLOC,PSJOI,PSJOSCRN)
 ; If a drug was selected, return in NEWDRG parameter by reference 
 I PSJSEL S NEWDRG=PSJSEL
 Q
 ;
SELECT(PSJLIST,PSJHELP) ; Select a drug from the list PSJLIST
 N CNT,LAST,PSJSEL,PSJOUT,DIR
 S PSJSEL=""
 S LAST=$O(PSJLIST(1,999999),-1) S:'LAST LAST=1
 S CNT=0 F  S CNT=$O(PSJLIST(1,CNT)) Q:'CNT  S PSJOUT(CNT)="  "_CNT_"   "_PSJLIST(1,CNT)
 I '$D(PSJOUT) W:'$G(PSJHELP) " ??" Q ""
 D EN^DDIOL("  Choose from:")
 D EN^DDIOL(.PSJOUT)
 Q:$G(PSJHELP) ""
 S DIR(0)="NOA^1:"_LAST,DIR("A")="CHOOSE 1-"_$G(LAST)_": " D ^DIR
 S:$G(Y) PSJSEL=$G(PSJLIST(2,Y))
 Q PSJSEL
 ;
SELSRCH(DRGIEN,NEWDRIEN,PSJOI,PSJLOC,TMPSRCH,PSJSCRN) ; Select drug 
 ; OR, select drug from Orderable Item screened DRUG file (#50).
 ;
 N PARTNAM,FOUND,PSJLIST,DCT,PSJQSRCH,PSJLOC
 K DIR
 ;
 S PSJLOC=$$ORDLOC($G(PSJORD),$G(PSGP))
 I $L($G(TMPSRCH))>0,$D(DRGIEN)>1 D
 .N I,DRGNAME,PSJLAST,PSJDIR,DIR,Y
 .S DCT=0 F I=0:1 S DCT=$O(DRGIEN(DCT)) Q:'DCT
 .S DCT=$O(DRGIEN(0))
 .I I=1 S DRGNAME=$P($G(^PSDRUG(+DRGIEN(DCT),0)),"^") I $E(DRGNAME,1,$L(TMPSRCH))=TMPSRCH D  Q
 ..S PARTNAM=$E(DRGNAME,$L(TMPSRCH)+1,$L(DRGNAME)) W PARTNAM
 ..S DIR(0)="Y",DIR("B")="Y",DIR("A")="        ...OK" D ^DIR
 ..I Y>0 S NEWDRIEN=+$G(DRGIEN(DCT))
 .N PSJDIR S DCT=0 F I=1:1 S DCT=$O(DRGIEN(DCT)) Q:'DCT  D
 ..N PSJQTY,PSJMSG
 ..S PSJLOC=$$ORDLOC($G(PSJORD),$G(PSGP))
 ..S DRGNAME=$P($G(^PSDRUG(+DRGIEN(DCT),0)),"^")
 ..S PSJDIR=$G(PSJDIR)_I_":"_DRGNAME_";"
 ..S PSJQTY=$$DRGQTY^PSJPADSI(+$G(DRGIEN(DCT)),$S($E(PSJLOC,$L(PSJLOC))="C":"CL",1:"WD"),+PSJLOC)
 ..D GETS^DIQ(50,+$G(DRGIEN(DCT))_",",101,,"PSJMSG")
 ..S DIR("A",I)="  "_I_"     "_DRGNAME_"    PADE:"_PSJQTY_"   "_$G(PSJMSG(50,DRGIEN_",",101))
 .Q:$L(PSJDIR)<4  S PSJLAST=+$O(DRGIEN(999),-1)
 .Q:'PSJLAST
 .S DIR(0)="SAO^"_PSJDIR,DIR("A")="CHOOSE 1-"_PSJLAST_": "
 .D ^DIR Q:Y<1
 .S:$G(DRGIEN(Y)) NEWDRIEN=+$G(DRGIEN(Y))
 ;
 Q:$G(NEWDRIEN) 
 ;
 ; User input not matched to any dispense drugs already filed to order - try to find an exact match; if found, quit and return IEN
 S PSJQSRCH=0
 I '$G(FOUND) D  S:$G(FOUND) NEWDRIEN=DRGIEN(FOUND) I $G(FOUND)!$G(PSJQSRCH) Q
 .N PSJSCR,PSJFIND
 .S PSJSCRN="I $P($G(^(2)),U,3)[""U"",$S('$G(PSJOI):1,1:PSJOI=+$G(^(2))) I ($G(^PSDRUG(+$G(Y)))>($$NOW^XLFDT-1))!'$G(^PSDRUG(+$G(Y),""I""))"
 .S PSJFIND=$$FIND1^DIC(50,,"M",TMPSRCH,,PSJSCRN)
 .; If there's only one exact match, but it's aleady in the order, and user didn't select it, quit, there's nothing else to do
 .I PSJFIND,(+PSJFIND=+$G(DRGIEN)) S PSJQSRCH=1 Q
 .I $G(PSJFIND) D
 ..N DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="  Are you adding '"_$P($G(^PSDRUG(+PSJFIND,0)),"^")_"' as a new DISPENSE DRUG? "
 ..D ^DIR Q:Y<1
 ..S FOUND=+$O(DRGIEN(999),-1)+1,DRGIEN(FOUND)=+PSJFIND_"^^"_$P($G(^PSDRUG(+PSJFIND,0)),"^")
 ; User selected a dispense drug that was already filed with the order - they must want to edit the Units per Dose
 I $G(FOUND) D
 .S PARTNAM=$S('TMPSRCH:$E($P(DRGIEN(FOUND),"^",3),$L(TMPSRCH)+1,99),1:"  "_$P(DRGIEN(FOUND),"^",3)) W PARTNAM
 .N DIR,Y S DIR(0)="Y",DIR("B")="Y",DIR("A")="        ...OK" D ^DIR
 .I Y>0 S NEWDRIEN=+$G(DRGIEN(FOUND))
 Q:$G(NEWDRIEN)  ; User accepted default
 ;
 S PSJLIST="",PSJOSCRN=""
 S FOUND=$$PSDRUG(DRGIEN,TMPSRCH,.PSJLIST,PSJLOC,PSJOI,PSJOSCRN)
 ; If a drug was selected, return in NEWDRIEN parameter by reference
 I FOUND S NEWDRIEN=FOUND
 Q
 ;
FILE(DRGIEN,PSJSRCH) ; File drug into ^PS(53.45
 ;
 N DA,DIC,DIE,DR,DIR,PSDD
 ;
 ; If an existing dispense drug was selected, allow the user to interactively edit the entry and quit
 ;I $D(^PS(53.45,PSJSYSP,2,"B",+$G(DRGIEN))) S PSDD=$O(^PS(53.45,PSJSYSP,2,"B",+DRGIEN,0)) D  Q
 S PSDD=$$CHK5345(+$G(PSJSYSP),+$G(DRGIEN)) I PSDD D  Q
 .; If Pending renewal, set flag to prevent change to dispense drug, can only be inactivated.
 .N PSJPNDRN I $G(PSGORD) I $E(PSGORD,$L(PSGORD))="P",$P($G(^PS(53.1,+PSGORD,0)),"^",24)="R" S PSJPNDRN=1
 .; User wants to delete the dispense drug - delete and quit
 .I $P(DRGIEN,"^",2)="@" D  Q
 ..N DIK,DA S DIK="^PS(53.45,"_+$G(PSJSYSP)_",2,",DA=PSDD,DA(1)=+$G(PSJSYSP)
 ..D ^DIK
 .;
 .; User wants to edit existing dispense drug
 .S DIE="^PS(53.45,"_PSJSYSP_",2,",DA=PSDD,DA(1)=PSJSYSP
 .S DR=$S($G(PSJSRCH):".01;",1:"")
 .S DR=DR_".02"_$S($G(PSJPNDRN):";.03",$E($G(PSJORD),$L(PSJORD))["U":";.03",1:"") D ^DIE
 ;
 ; If a new entry is being added, find the  next available node
 I '$G(PSDD) S PSDD=$O(^PS(53.45,PSJSYSP,2,999),-1)+1
 ;
 S DIE="^PS(53.45,"_PSJSYSP_",2,",DA=PSDD,DA(1)=PSJSYSP,DR=".01////"_+$G(DRGIEN) D ^DIE
 ;
 ; If adding a new entry, allow the user to interactively add the entry
 S DIE="^PS(53.45,"_PSJSYSP_",2,",DA=PSDD,DA(1)=PSJSYSP
 S DR=".01;.02"_$S($G(PSJPNDRN):";.03",$E($L($G(PSJORD)))["U":";.03",1:"") D ^DIE
 Q
 ;
PSDRUG(DRGIEN,DRGSRCH,PSJLIST,PSJLOC,PSJOI,PSJOSCRN)  ; Look for drug in file 50
 ;
 N DIC,D,PSJTABLN,PSJLT
 ; If PSJLOC is appended with "C", flag it as clinic, otherwise, flag as ward
 S PSJLT=$S(PSJLOC["C":"CL",1:"WD")
 ; If not a clinic, and we don't know the ward, try to find from DFN via call to INP^VADPT
 I PSJLT="WD",'$G(PSJLOC) N VAIN,VAINDT,VAROOT,VAHOW D INP^VADPT S PSJLOC=+$G(VAIN(4))
 S PSJLOC=$S(+$G(PSJLOC):PSJLOC,1:+$G(VAIN(4)))
 S DIC="^PSDRUG(",D="B^C^VAPN^VAC^NDC^XATC^ASP"
 S DIC("?")="Select the medication you wish the patient to receive." W:PSJSYSU<3 "  You should consult",!,"with your pharmacy before ordering any non-formulary medication." W !
 S DIC("S")="I $P($G(^(2)),U,3)[""U"",$S('$G(PSJOI):1,1:PSJOI=+$G(^(2))) I ($G(^PSDRUG(+$G(Y),""I""))>($G(PSGDT)))!'$G(^PSDRUG(+$G(Y),""I""))"
 S DIC(0)="QMEZ",X=DRGSRCH
 S $P(PSJTABLN," ",30)=" " S DIC("W")="W $E(PSJTABLN,1,(40-$L($P($G(^PSDRUG(+$G(Y),0)),""^""))))_""  PADE:""_$$DRGQTY^PSJPADSI(+Y,PSJLT,+$G(PSJLOC))_""   ""_$P($G(^PSDRUG(+Y,0)),""^"",10)"
 D MIX^DIC1
 Q Y
 ;
ORDLOC(PSJORD,PSGP) ; Get clinic location from PSJORD order, if it exists
 N PSJLOC
 Q:'$G(PSJORD) ""
 Q:",U,P,"'[(","_$E(PSJORD,$L(PSJORD))_",") ""
 I PSJORD["U" S PSJLOC=$G(^PS(55,+$G(PSGP),5,+$G(PSJORD),8)) D  Q PSJLOC
 .I PSJLOC,$P(PSJLOC,"^",2) S PSJLOC=+PSJLOC_"C"
 .I '$G(PSJLOC) S PSJLOC=+$G(VAIN(4))
 I PSJORD["P" S PSJLOC=$G(^PS(53.1,+$G(PSJORD),"DSS")) D  Q PSJLOC
 .I PSJLOC,$P(PSJLOC,"^",2) S PSJLOC=+PSJLOC_"C"
 .I '$G(PSJLOC) S PSJLOC=+$G(VAIN(4))
 Q ""
 ;
CHKWG(CAB,WARD) ; Return flag indicating WARD is linked to cabinet's WARD GROUPS
 N WG,WD
 S WG=0 F  S WG=$O(^PS(58.63,CAB,3,"B",WG)) Q:'WG  D
 .S WD=0 F  S WD=$O(^PS(57.5,WG,1,"B",WD)) Q:'WD  S WG(WD)=""
 Q $D(WG(+$G(WARD)))
 ;
CHKCG(CAB,CLINIC) ; Return flag indicating CLINIC is linked to cabinet's CLINIC GROUPS
 N CG,CL,CLIEN
 S CG=0 F  S CG=$O(^PS(58.63,CAB,5,"B",CG)) Q:'CG  D
 .S CL=0 F  S CL=$O(^PS(57.8,CG,1,CL)) Q:'CL  D
 ..S CLIEN=$G(^PS(57.8,CG,1,CL,0)) Q:'CLIEN
 ..S CG(CLIEN)=""
 Q $D(CG(+$G(CLINIC)))
 ;
PADEWD(WARD) ; Return flag indicating if WARD is linked to any active PADE ward groups
 Q:'$G(WARD) ""
 N PDWARDS,PWD,WG,PDLINK,PADE
 S PDLINK=0
 S WG=0 F  S WG=$O(^PS(58.63,"WG",WG)) Q:'WG  D
 .S PADE=0 F  S PADE=$O(^PS(58.63,"WG",WG,PADE)) Q:'PADE  D
 ..Q:$P($G(^PS(58.63,PADE,0)),"^",4)="I"
 ..S PWD=0 F  S PWD=$O(^PS(57.5,WG,1,"B",PWD)) Q:'PWD  S PWD(PWD)=""
 I $D(PWD(+WARD)) S PDLINK=1
 I '$G(PDLINK) I $D(^PS(58.63,"WD",+WARD)) D
 .S PADE=0 F  S PADE=$O(^PS(58.63,"WD",+WARD,PADE)) Q:'PADE  D
 ..Q:$P($G(^PS(58.63,PADE,0)),"^",4)="I"
 ..S PDLINK=1
 Q PDLINK
 ;
PADECL(CLINIC) ; Return flag indicating if CLINIC is linked to any PADE devices
 Q:'$G(CLINIC) ""
 N PDCLINS,PCL,CG,PDLINK,PADE,CLINAM,PARTIAL
 S PDLINK=0
 S CG=0 F  S CG=$O(^PS(58.63,"CG",CG)) Q:'CG  D
 .S PADE=0 F  S PADE=$O(^PS(58.63,"CG",CG,PADE)) Q:'PADE  D
 ..Q:$P($G(^PS(58.63,PADE,0)),"^",4)="I"
 ..S PCL=0 F  S PCL=$O(^PS(57.8,"AD",CG,PCL)) Q:'PCL  S PCL(PCL)=""
 I $D(PCL(+CLINIC)) S PDLINK=1
 I '$G(PDLINK) I $D(^PS(58.63,"CL",+CLINIC)) D
 .S PADE=0 F  S PADE=$O(^PS(58.63,"CL",+CLINIC,PADE)) Q:'PADE  D
 ..Q:$P($G(^PS(58.63,PADE,0)),"^",4)="I"
 ..S PDLINK=1
 ; If no match, check PADEs associated with clinic wildcards
 I '$G(PDLINK) D GETS^DIQ(44,+CLINIC,".01",,"CLINAM") D
 .S CLINAM=$G(CLINAM(44,+CLINIC_",",".01")),PARTIAL=$E(CLINAM,1,2)
 .F  S PARTIAL=$O(^PS(58.63,"WC",PARTIAL)) Q:$E(PARTIAL,1,3)'=$E(CLINAM,1,3)!$G(PDLINK)  D
 ..N PADE,STATUS S STATUS=""
 ..S PADE="" F  S PADE=$O(^PS(58.63,"WC",PARTIAL,PADE)) Q:'PADE!$G(PDLINK)  D
 ...S STATUS=$P($G(^PS(58.63,PADE,0)),"^",4)
 ...Q:(STATUS="I")
 ...I $E(CLINAM,1,$L(PARTIAL))=PARTIAL S PDLINK=1
 Q PDLINK
 ;
DDLIST(DRGARRAY)  ; List Drug Array when "?" entered at Dispense Drug prompt
 ;
 ;Select DISPENSE DRUG: ?
 N PSJDDAR,NXTDRG,LNCOUNT
 S LNCOUNT=1
 S PSJDDAR(LNCOUNT)="    Answer with DISPENSE DRUG",LNCOUNT=LNCOUNT+1
 S PSJDDAR(LNCOUNT)="   Choose from:",LNCOUNT=LNCOUNT+1
 S NXTDRG=0 F  S NXTDRG=$O(DRGARRAY(NXTDRG)) Q:'NXTDRG  D
 .N DRGIEN,DRGNAME
 .S DRGIEN=+$G(DRGARRAY(NXTDRG))
 .S DRGNAME=$P($G(^PSDRUG(+DRGIEN,0)),"^")
 .Q:DRGIEN=""  S PSJDDAR(LNCOUNT)="   "_DRGNAME,LNCOUNT=LNCOUNT+1
 S PSJDDAR(LNCOUNT)="",LNCOUNT=LNCOUNT+1
 S PSJDDAR(LNCOUNT)="     You may enter a new DISPENSE DRUG, if you wish",LNCOUNT=LNCOUNT+1
 S PSJDDAR(LNCOUNT)="     Only dispense drugs marked for Unit Dose use.",LNCOUNT=LNCOUNT+1
 S PSJDDR(LNCOUNT)="",LNCOUNT=LNCOUNT+1
 S PSJDDAR(LNCOUNT)="",LNCOUNT=LNCOUNT+1
 D EN^DDIOL(.PSJDDAR)
 Q
 ;
CHK5345(PSJSYSP,DRGIEN) ; Check if file 50 pointer DRGIEN exists in Dispense Drug temp global ^PS(53.45,PSJSYSP,2,n
 ; PSJSYSP=User DUZ
 ; DRGIEN=pointer to drug IEN in file 50
 N DDCOUNT,FOUND
 Q:'$G(DRGIEN) 0
 S FOUND=0
 S DDCOUNT=0 F  S DDCOUNT=$O(^PS(53.45,PSJSYSP,2,DDCOUNT)) Q:'DDCOUNT  I $P($G(^PS(53.45,PSJSYSP,2,DDCOUNT,0)),"^")=+$G(DRGIEN) S FOUND=DDCOUNT
 Q FOUND
