PSJOE1 ;BIR/CML - UD OE FOR COMBINED OE; Oct 14, 2020@10:48
 ;;5.0;INPATIENT MEDICATIONS;**2,7,25,30,47,56,64,179,181,252,281,315,338,373,353,327,319,411,399,448,449**;16 DEC 97;Build 18
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;Reference to ^DICN in ICR #10009
 ;Reference to ^VALM in ICR #10118
 ;Reference to ^TMP("PSODAOC",$J) in ICR #6071
 ;Reference to ^SC in ICR #10040
 ;
 ;*353 Haz Meds cleanup var
 ;
 S PC=0 G AD
 ;
CM ; Ask Clinic - Clinic Medication Order ;*p319
 K DIRUT,PSJCLAPP,DIR,X,Y
 D FULL^VALM1
 W !
 S DIR(0)="PO^44:EMZ",DIR("A")="Visit Location"
 I $G(P("CLIN")) S DIR("B")=$P(^SC(+P("CLIN"),0),"^"),PSJCLAPP=P("CLIN")
 S DIR("S")="I $P($G(^SC(Y,0)),U,3)=""C"",$$ACTLOC^PSJOE1(Y),$$IMOLOC^PSJOE1(Y,$G(PSGP))>-1"
 D ^DIR K DIR
 I +Y<1 S PSJCM01=-1 Q
 S PSJCLAPP=+Y
 D SVST Q:$P(PSJCLAPP,"^",2)  Q:$G(PSGORQF)
 ; Ask for Visit Date/Time ;*p319
 K %DT
 I $G(P("APPT")) S Y=P("APPT") D DD^%DT I Y'="" S %DT("B")=Y
 S %DT("A")="Date/Time of Visit: ",%DT="RAE",%DT("B")=$S($G(%DT("B"))'="":%DT("B"),1:"NOW")
 D ^%DT I Y<0!($D(DTOUT)) S PSJCM01=-1 Q
 S $P(PSJCLAPP,"^",2)=+Y
 K %DT
 Q
SVST ;get scheduled/new visits ;*p319
 N PSJVST,XX,YY,C,DIR,X,Y,X1,X2,APTMIN,APTMAX,STDT,ENDT,PVST,VST
 S APTMIN=$$GET1^DIQ(53.46,+PSJCLAPP,8,"I")
 S APTMAX=$$GET1^DIQ(53.46,+PSJCLAPP,9,"I")
 S X1=DT,X2=$S(APTMIN:-APTMIN,1:-90) D C^%DTC S STDT=X
 S X1=DT,X2=$S(APTMAX:APTMAX,1:365) D C^%DTC S ENDT=X
 D VST^ORWCV(.PSJVST,$G(PSGP),STDT,ENDT,1)
 Q:'$D(PSJVST)
 S (XX,C)=0 F  S XX=$O(PSJVST(XX)) Q:'XX  S YY=PSJVST(XX) I $P($P(YY,"^"),";",3)=+PSJCLAPP D
 .S C=C+1,PSJVIS(C)=$P(YY,"^",3)_"^"_$$FMTE^XLFDT($P(YY,"^",2))_"^"_$P(YY,"^",4)_"^"_$P(YY,"^",2)
 Q:C<1
 S C=C+1,PSJVIS(C)="New Visit"
V1 W !!?4,"Scheduled Clinic Appointment (",$$FMTE^XLFDT(STDT)," thru ",$$FMTE^XLFDT(ENDT),")"
 F I=1:1 S XX=$O(PSJVIS(XX)) Q:'XX  S YY=PSJVIS(XX) W !,I,".  ",$P(YY,"^"),?35,$$FMTE^XLFDT($P(YY,"^",2)),?55,$P(YY,"^",3)
 K DIR S DIR(0)="N^1:"_C
 S DIR("A")="Select Visit" D ^DIR
 I $D(DIRUT) S PSGORQF=1,PSJCM01=-1 Q
 Q:Y=C
 S VST=Y
 I $$FMDIFF^XLFDT($P(PSJVIS(Y),"^",4),DT,1)<0 S PVST=$$PVST() Q:PVST=-1  G:PVST V1
 S $P(PSJCLAPP,"^",2)=$P(PSJVIS(VST),"^",4) W !,"Date/Time of Visit: ",$P(PSJVIS(VST),"^",2)
 Q
PVST() ;ask about past visit
 N DIR
 S DIR(0)="Y"
 S DIR("A")="You currently have a past date selected for this visit. Do you want to select a current date"
 D ^DIR
 I $D(DIRUT) S PSGORQF=1,PSJCM01=-1 Q -1
 Q Y
 ;
EN ;
 S PC=0
 ;
AD ; Ask Drug
 ;PSJOCFG - If defined, it's for new order, renew or copy. ^PSJOCDSD using this flag to not display drug error.
 K PSJOCFG,PSGDUR,PSGRMVT,PSGRMV,PSGRF,ND2P1,ANQX ;*315
 K PSGDRG,PSGDRGN    ;*353
 N PSJACEPT,PSJNORD,PSGORQF,PSGSDX,PSGFDX,PSGNEFDO,PSGEDTOI,PSJOCFG,PSGDREQ S PSJOCFG="NEW UD" S PSJNORD=1 I $D(VALM("TM")) S IOTM=VALM("TM"),IOBM=IOSL W IOSC,@IOSTBM,IORC
 K PSGORQF
 I $D(PSJCMO)!$D(PSJCM01),$G(PSJCMF) D CM I $G(PSJCM01)=-1 G DONE ;*p319
 D ^PSGOE7
 I +$G(PSJCLAPP) S PSJCMF=1 ;p319 Clinic Order - Flag to display
 I $G(PSGORQF) S PSJORQF=1 G DONE
 S PC=1,PSJORQF=0 I X?1"S."1.E D ^PSGOES G AD
 D ^PSGOE4:'$P(PSJSYSP0,"^",12),^PSGOE3:$P(PSJSYSP0,"^",12)
 G:$G(PSGOROE1)=1 AD
 K PSGEFN,PSGOEEF,PSGOEE,PSGOEOS S PSGEFN="1:14" F X=1:1:14 S PSGEFN(X)=""
 I $G(PSJCMO)!$G(PSJCM01) S PSGEFN="1:16" F X=15,16 S PSGEFN(X)="" ;p319
 S PSGPDN=$$OINAME^PSJLMUTL(PSGPDRG),PSGPD=PSGPDRG,PSGOINST="",PSGSDN=$$ENDD^PSGMI(PSGNESD)_U_$$ENDTC^PSGMI(PSGNESD),PSGFDN=$$ENDD^PSGMI(PSGNEFD)_U_$$ENDTC^PSGMI(PSGNEFD)
 S:$D(PSJOCFG) PSGSDN=$$ENDD^PSGMI(PSGNESD)_U_$$ENDTC2^PSGMI(PSGNESD),PSGFDN=$$ENDD^PSGMI(PSGNEFD)_U_$$ENDTC2^PSGMI(PSGNEFD) ;#373
 S PSGAT=PSGS0Y,PSGLIN=$$ENDD^PSGMI(PSGDT)_U_$$ENDTC^PSGMI(PSGDT),PSGLI=PSGDT,PSGEBN=$$ENNPN^PSGMI(DUZ),PSGSTAT=$S(PSGOEAV:"ACTIVE",1:"NON-VERIFIED")
 D CHK^PSGOEV("^^"_PSGMR_"^^^^"_PSGST,PSGPDRG_U_PSGDO,PSGSCH_U_PSGNESD_"^^"_PSGNEFD)
 S PSGSD=PSGNESD,PSGFD=PSGNEFD
 K PSJACEPT S VALMBCK="Q" D:$D(Y) EN^VALM("PSJU LM ACCEPT")
 ;PSJ*5*449 Display 0 Units Per Dose warning
 ;PSGOEAV=1 when Auto-Verify is ON and RNURSE or RPHARM
 I PSGOEAV D
 . D DOSECHK^PSJDOSE
 . I +$G(PSJDSFLG0) D FULL^VALM1,SETVAR0^PSJDOSE,DSPWARN0^PSJDOSE
 I $G(PSJACEPT)=1 D  I $G(ANQX) D DONE G AD
 . D OC
 . ;D:'$G(PSGORQF) IN^PSJOCDS($G(PSGORD),"UD",+$G(PSGDRG))
 ;If intervention is not log then quit
 I $G(PSGORQF)=1 S PSJACEPT=0
 S PSJNOO=-1 I $G(PSJACEPT)=1 S PSJNOO=$$ENNOO^PSJUTL5("N")
 I $G(PSJNOO)<0 D
 . I $$ISCLOZ^PSJCLOZ(,PSGPD) K ^XTMP("PSJ4D-"_$G(DFN)) ;p327
 I $G(PSJNOO)<0 K PSJACEPT,PSJCLAPP W !,"No order created." G AD
 K PSGOEE D ^PSGOETO S PSJORD=PSGORD
 S ^TMP("PSODAOC",$J,"IP IEN")=PSGORD
 I $G(PSODAND) S ^TMP("PSJCOM",$J,+PSGORD,"SAND")=PSODAND
 ;RTC 178746 - Don't store allergy here.
 ;D SETOC^PSJNEWOC(PSGORD)
 I PSGOEAV D  G AD
 .;; START NCC REMEDIATION >> 327*RJS
 .I $$ISCLOZ^PSJCLOZ(,PSGPD) D
 ..N DIE,DA,DR S DIE="^PS(55,"_PSGP_",5,",DA=+$G(PSGORD),DA(1)=PSGP,DR="301////"
 ..I $G(PSGNTDD) S DR=DR_PSGNTDD
 ..E  I $G(PSGETDD) S DR=DR_PSGETDD
 ..E  I $G(PSGCTDD) S DR=DR_PSGCTDD
 ..E  I $D(^TMP($J,"PSGCLOZ",PSGP,+$G(PSGORD),"SAND")) S DR=DR_$G(^TMP($J,"PSGCLOZ",PSGP,+$G(PSGORD),"SAND")) K ^TMP($J,"PSGCLOZ",PSGP,+$G(PSGORD),"SAND")
 ..D ^DIE
 ..D CLOZSND^PSJOE ; SEND OVERRIDE MESSAGE & XTMP TRANSACTION DATA
 .;; END NCC REMEDIATION >> 327*RJS
 . D SETOC^PSJNEWOC(PSGORD) ;RTC 17874
 .I '$D(PSGOEE),+PSJSYSU=3 D EN^PSGPEN(PSGORD)
 S PSGOEEF=0 D GETUD^PSJLMGUD(PSGP,PSGORD),ENSFE^PSGOEE0(PSGP,PSGORD),^PSGOE1,EN^VALM("PSJ LM UD ACTION")
 ;RTC 178746 - store allergy if not verify the newly created order.
 I ($G(PSGORD)["P"),($P($G(^PS(53.1,+PSGORD,0)),U,9)="N"),($G(PSJOCFG)="NEW UD") D SETOC^PSJNEWOC(PSGORD)
 G AD
 Q
OC ;
 NEW PSJDD,PSJALLGY,PSJALGY1
 K PSGORQF
 ;; START NCC REMEDIATION >> 327*RJS
 N CLOZFLG S CLOZFLG=$$ISCLOZ^PSJCLOZ(,PSGPD) I CLOZFLG D  Q:$G(ANQX)
 .S DIR(0)="N^12.5:3000:1",DIR("A")="CLOZAPINE dosage (mg/day) ? " D ^DIR K DIR I $D(DIRUT) S (CHK,ANQX)=1 Q
 .S (PSGNTDD,PSODAND)=X,PSGDN=$P(CLOZFLG,U,2)
 ;; END NCC REMEDIATION >> 327*RJS
 D FULL^VALM1
 S PSJDD=+$$DD53P45^PSJMISC() I 'PSJDD S PSGORQF=1 Q
 I +$G(PSGEDTOI) D
 . S PSJALGY1=1
 . D ENDDC^PSGSICHK($G(PSGP),PSJDD)
 D:'$G(PSGORQF) IN^PSJOCDS($G(PSGORD),"UD",PSJDD)
 Q
EDIT(PROMPT) ;
 ; Edit fields in a UD order.
 ; PROMPT=0 - Select fields to edit by number.
 ; PROMPT=1 - Prompt to select fields for editing.
 ;
 ;* D @$S('PROMPT:"ENEFA2^PSGON",1:"ENEFA^PSGON") Q:'Y  S PSGOEEG=3 D EDIT^PSGOEE ;$S(PSGOEEWF[53.1:3,1:5) D:Y EDIT^PSGOEE
 ; PSJ*5.0*448: CORRECTLY SETTING PSGOEEWF 
 D @$S('PROMPT:"ENEFA2^PSGON",1:"ENEFA^PSGON") Q:'Y  S:$G(PSJNEWOE) PSGOEEWF="^PS(53.1,"_+$G(PSGORD)_"," S PSGOEEG=$S('$D(PSGOEEWF):3,PSGOEEWF[53.1:3,1:5) D EDIT^PSGOEE
 I $G(PSJNEWOE) S PSGOEENO=0,DR="",VALMBCK="R"
 I '$G(PSJNEWOE) D ENNOU^PSGOEE0 I 'PSGOEENO,DR="" S VALMBCK="R" Q
 I 'PSGOEENO,$D(PSGOES) D ENNOU^PSGOEE0  ; only update on order sets
 ;*179 No longer call CKDT^PSGOEE from here.
 ;I 'PSGOEENO,$G(PSGPDNX)=1 D CKDT^PSGOEE
 I $G(PSGOEER)["101^PSGOE8" S PSGEDTOI=1
 K VALMSG I PSGOEENO D
 .S VALMSG="This change will cause a new order to be created." D GTSTATUS^PSGOEE,CHKDD^PSGOEE,CKDT^PSGOEE ;*373
 .S PSGEBN=$$ENNPN^PSGMI(DUZ),PSGLIN=$$ENDD^PSGMI(PSGDT)_U_$$ENDTC^PSGMI(PSGDT),PSGLI=PSGDT
 D CHK^PSGOEV("^^"_PSGMR_"^^^^"_PSGST,PSGPDRG_U_PSGDO,PSGSCH_U_PSGSD_"^^"_PSGFD)
 D INIT^PSJLMUDE(PSGP,$G(PSGORD))
 Q
DONE ;
 K %,DA,DIC,DIE,DR,DRG,DRGN,DRGO,ND,OC,ORIFN,ORIT,ORPK,ORSTOP,ORSTRT,ORSTS,ORTX,PC,PSGDO,PSGMR,PSGMRN,PSGNEDFD,PSGNEFD,PSGNESD,PSGOES,PSGOROE1,PSGORD,PSGS0XT,PSGS0Y,PSGSCH,PSGSI,PSGX,Y,Z
 K PSGEDTOI,PSJOCFG,PSGDUR,PSGRMVT,PSGRMV,PSGRF,ND2,ND2P1 ;*315
 Q
 ;
GDO ;
 W !!,"Drug is not found in Formulary List." F  S %=1 W !,"Would you like to try to search the list again" D YN^DICN Q:%  D TAM
 Q:%<2
FTD ;
 R !!,"Enter FREE TEXT DRUG: ",PSGDRGN:DTIME E  W $C(7) S PSGDRGN="^" Q
 Q:"^"[PSGDRGN  S X=$S(PSGDRGN'?.ANP:"Control character(s)",PSGDRGN["^":"Up-arrow ('^') in text",$L(PSGDRGN)>39:"Response longer than 39 characters",1:"") I X]"" W $C(7),"  ??",!?2,"(",X," not allowed.)" G FTD
 Q:PSGDRGN'?1."?"
 W !!?2,"ENTER DRUG ORDERED (1-39 CHARACTERS).",!?2,"Since the drug cannot be found in the DRUG file, enter the drug name here",!,"exactly as ordered.  Press the RETURN key (or enter an '^') to skip over this",!,"drug, or to again search the"
 W " DRUG file for this one." G FTD
 ;
TAM ; Try Again Message
 W !!,"  Enter a 'Y' to try again to find the drug ordered from the Formulary.  (The",!,"order cannot become active until a Formulary drug has been entered.)  Enter 'N'",!,"to enter the drug ordered as free text for later reference."
 W "  Enter '^' to exit.",! Q
ACTLOC(LOC) ; Function: returns TRUE if active hospital location; p319
 ; IA# 10040.
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
IMOLOC(LOC,PSGP) ; Is it an IMO location; p319
 N PSJY
 I $G(LOC)=""!('+$G(PSGP)) Q -1
 S PSJY=$$SDIMO^SDAMA203(LOC,PSGP)
 I PSJY=-3 D
 .I $P($G(^SC(LOC,0)),U,3)'="C" Q
 .I $D(^SC("AE",1,LOC))=1 S PSJY=1
 .K SDIMO(1)
 Q PSJY
