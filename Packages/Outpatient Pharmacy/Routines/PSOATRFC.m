PSOATRFC ;BIR/MHA - Automate CPRS Refill request ;12/15/08 1:39pm
 ;;7.0;OUTPATIENT PHARMACY;**305**;DEC 1997;Build 8
 ;Reference to ^PSSLOCK supported by DBIA 2789
 ;Reference ^PSDRUG supported by DBIA 221
 ;Reference ^PS(55 supported by DBIA 2228
 ;
REF(PSORXN,PSOITMG) ;process refill request
 N DFN,PSODFN,PSODTCUT,PSOITNS,PSOITDD,PSOITNF,PSOITF,DIV
 N PSOITP,PSOITR,PSOINST,PSOPAR,PSOPINST,PSOPRPAS,PSOPAR7,PSOPTPST
 N PSOSITE,PSOSNM,PSOSYS,PSORFN,PSOREA,PSOSTAT,PSOD,PSOS,DRG,DIVN
 N PSXSYS,RX,RX0,RXN,VA,ZZ,LC,XMY,PSORXN0,PSORXN2,PSORXN3,PSORXNS
 ;
 S (DIV,PSOSITE)=$P(^PSRX(PSORXN,2),"^",9)
 S (SITE,DA)=$P(^XMB(1,1,"XUS"),U,17),DIC="4",DIQ(0)="IE",DR=".01;99",DIQ="PSOUTIL" D EN^DIQ1
 S PSOINST=$G(PSOUTIL(4,SITE,99,"I"))
 S PSOPAR=$G(^PS(59,DIV,1)),PSORFN=$G(^PS(59,DIV,"RF")),PSOITNF=0
 S PSXSYS=+$O(^PSX(550,"C",""))_"^"_$G(PSOINST)_"^"_$G(PSOUTIL(4,SITE,.01,"E"))
 I $G(PSXSYS) D
 . K:($P($G(^PSX(550,+PSXSYS,0)),"^",2)'="A") PSXSYS
 . I $$VERSION^XPDUTL("PSO")<7.0 K PSXSYS
 S PSOSYS=$G(^PS(59.7,1,40.1))
 ;
 I '$D(^PSRX(PSORXN,0))!($P(^(0),U)="")!('$D(^(2)))!($P(^("STA"),U)=13) D  Q
 . D ERR("Rx IEN "_PSORXN_" not in file (#52)/Incomplete/Deleted")
 S PSORXN0=^PSRX(PSORXN,0),PSORXN2=^(2),PSORXN3=^(3),PSORXNS=^("STA")
 S (DFN,PSODFN)=$P(PSORXN0,U,2),RXN=$P(PSORXN0,U),DRG=$P(PSORXN0,U,6)
 D GET^PSOPTPST
 I $G(PSOPTPST(2,PSODFN,.351))]"" D  Q
 . D ERR("Patient Died on "_PSOPTPST(2,PSODFN,.351))
 D ICN^PSODPT(DFN)
 S PSOLOUD=1 D:$P($G(^PS(55,DFN,0)),U,6)'=2 EN^PSOHLUP(DFN) K PSOLOUD
 I '$P(PSOPAR,U,11),$G(^PSDRUG(DRG,"I"))]"",DT>$G(^("I")) D  Q
 . D ERR("Drug is inactive for Rx # "_RXN_" cannot be refilled")
 I $G(PSOPTPST(2,PSODFN,.1))]"",'PSORFN D  Q
 . D ERR("Patient is an Inpatient on Ward "_PSOPTPST(2,PSODFN,.1))
 I $G(PSOPTPST(2,PSODFN,148))="YES",'$P(PSORFN,U,2) D  Q
 . D ERR("Patient is in a Contract Nursing Home")
 D CHKRF Q:PSOITNF           ;Quit if RX not refillable
 ;
 ;more checks
 I $O(^PS(52.5,"B",PSORXN,0)),'$G(^PS(52.5,+$O(^PS(52.5,"B",PSORXN,0)),"P")) D  Q
 . D ERR("Rx is in suspense and cannot be refilled")
 S PSOY=1+$$LSTRFL^PSOBPSU1(PSORXN)
 I PSOY>$P(PSORXN0,U,9) D  Q
 . D ERR("Can't refill, no refills remaining")
 S (PSOITF,PSOX("NUMBER"))=PSOY
 S PSOX("RX0")=PSORXN0,PSOX("RX2")=PSORXN2,PSOX("RX3")=PSORXN3,PSOX("STA")=PSORXNS
 S DRG=$P(PSORXN0,U,6)
 N PSODEA,PSODAY
 S PSODEA=$P($G(^PSDRUG(DRG,0)),U,3)
 S PSODAY=$P(PSORXN0,U,8)
 I $$DEACHK^PSOUTLA1(PSORXN,PSODEA,PSODAY) D  Q
 . D ERR("This drug has been changed, No refills allowed")
 D CHKDT Q:PSOITNF           ;Quit if not refillable
 ;
 ;ok to process refill
 D EN^PSOR52(.PSOX)
 ;add additional activity log comment to refill just added
 I PSOITF,$D(^PSRX(PSORXN,1,PSOITF,0)) D
 . N AL,DONE,PSOFDA
 . S AL="",DONE=0
 . F  S AL=$O(^PSRX(PSORXN,"A",AL),-1) Q:'AL  D  Q:DONE
 . . Q:$P(^PSRX(PSORXN,"A",AL,0),U,4)'=PSOITF
 . . S PSOFDA(52.34,"+3,"_AL_","_PSORXN_",",.01)="CPRS Auto Refill"
 . . D UPDATE^DIE("","PSOFDA")
 . . S DONE=1
 Q
 ;
CHKRF ;check precription if still refillable
 S X2=-120,X1=DT D C^%DTC S PSODTCUT=X
 D ^PSOBUILD
 I '$G(PSOSD) D  Q
 .  D ERR("This patient has no prescriptions")
 S (PSOX,PSOY,PSOS)="",PSOX("STA")=PSORXNS
 F  S PSOS=$O(PSOSD(PSOS)) Q:PSOS=""  F  S PSOX=$O(PSOSD(PSOS,PSOX)) Q:PSOX']""  D
 . I PSORXN=+PSOSD(PSOS,PSOX) S PSOY=PSOSD(PSOS,PSOX) I $P(PSOY,U,4)]"" D
 . . D ERR("Cannot refill Rx # "_RXN)
 . . S PSOREA=$P(PSOY,U,4),PSOSTAT=PSOX("STA")
 . . I PSOREA["Z" S:PSOSTAT=4 PSOSTAT=1 D  Q
 . . . S PSOA=";"_PSOSTAT,PSOB=$P(^DD(52,100,0),U,3)
 . . . S PSOA=$F(PSOB,PSOA),PSOA=$P($E(PSOB,PSOA,999),";",1)
 . . . D ERR(" Rx is in "_$P(PSOA,":",2)_" status")
 . . . K PSOA,PSOB
 . . I PSOREA["M" D ERR("Drug no longer used by Outpatient Pharmacy") Q
 . . I PSOREA["B" D ERR("Narcotic Drug") Q
 . . I PSOREA["C" D ERR("Non-Renewable Drug") Q
 . . I PSOREA["D" D ERR("Non-Renewable Patient Status") Q
 . . I PSOREA["E" D ERR("Non-Verified Rx") Q
 . . I PSOREA["G",PSOREA'["B" D ERR("No more refills left")
 I PSOY="" D ERR("Cannot refill, Rx is DC/Exp. Later Rx may exist") D
 . S (PSOS,PSOX)="",PSOD=$P(^PSDRUG($P(PSORXN0,U,6),0),U)
 . N ZRX S ZRX=""
 . F  S PSOS=$O(PSOSD(PSOS)) Q:PSOS=""  D
 . . F  S PSOX=$O(PSOSD(PSOS,PSOX)) Q:PSOX=""  D
 . . . I PSOD=PSOX,+PSOSD(PSOS,PSOX) S ZRX=$P($G(^PSRX(+PSOSD(PSOS,PSOX),0)),U)
 . D ERR(ZRX)
 Q
 ;
CHKDT ;check date on this refill request
 N X1,X2
 S PSOX("IRXN")=PSORXN
 S PSOX("MAIL/WINDOW")="M",PSOX("FLD")=2,PSOX("QS")="S"
 S PSOX("FIELD")=0,(PSORX("FILL DATE"),PSOX("FILL DATE"))=DT,PSOX("FLD")=1,X1=DT,X2=-180
 D C^%DTC S PSOX("ISSUE DATE")=X,PSOX("CLERK CODE")=DUZ
 S PSOX("STOP DATE")=$P(PSORXN2,U,6) D NEXT
 I PSOX("FILL DATE")<$P(PSORXN3,U,2) D SUSDATE^PSOUTIL(.PSOX)
 I PSOX("FILL DATE")>PSOX("STOP DATE") D  Q
 . D ERR("Can't refill, Refill Date "_$$DSP(PSOX("FILL DATE")))
 . D ERR("is past Expiration Date "_$$DSP(PSOX("STOP DATE")))
 S PSOX("LAST REFILL DATE")=$P(PSORXN3,U,1)
 I PSOX("LAST REFILL DATE"),PSOX("FILL DATE")=PSOX("LAST REFILL DATE") D  Q
 . D ERR("Can't refill, Fill Date already exists for "_$$DSP(PSOX("FILL DATE")))
 I PSOX("LAST REFILL DATE"),PSOX("FILL DATE")<PSOX("LAST REFILL DATE") D  Q
 . D ERR("Can't refill, later Refill Date already exists for "_$$DSP(PSOX("LAST REFILL DATE")))
 Q
 ;
NEXT ;
 S PSOX1=$P(PSORXN2,U,2)
 I '$O(^PSRX(PSORXN,1,0)) D  Q
 . S $P(PSORXN3,U)=PSOX1,X1=PSOX1
 . S X2=$P(PSORXN0,U,8)-10\1
 . D C^%DTC
 . S:'$P(PSORXN3,U,8) $P(PSORXN3,U,2)=X K X
 S PSOY2=0
 F PSOY=0:0 S PSOY=$O(^PSRX(PSORXN,1,PSOY)) Q:'PSOY  S PSOY1=PSOY,PSOY2=PSOY2+1
 S PSOY=^PSRX(PSORXN,1,PSOY1,0)
 S PSOX2=$P(PSOY,U)
 S $P(PSORXN3,U)=PSOX2,X1=PSOX2
 S X2=$P(PSORXN0,U,8)-10\1
 D C^%DTC S PSOY3=X
 S X1=PSOX1,X2=(PSOY2+1)*$P(PSORXN0,U,8)-10\1
 D C^%DTC S PSOY4=X
 S $P(PSORXN3,U,2)=$S(PSOY3<PSOY4:PSOY4,1:PSOY3)
 K X,X1,X2,PSOX1,PSOX2,PSOY,PSOY1,PSOY2,PSOY3,PSOY4
 Q
 ;
DSP(X) ;
 Q:'X ""
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
ERR(TXT) ;Build error text array
 ;  add TXT to end of last line in array, if will fit, else
 ;     add it as a new last line and indented 3.
 ;  and set error flag
 N II S II=$O(PSOITMG(""),-1) S:'II II=1
 S PSOITNF=1
 I $L($G(PSOITMG(II)))+$L(TXT)>79 D
 . S PSOITMG(II+1)="   "_TXT
 E  D
 . S PSOITMG(II)=$G(PSOITMG(II))_" "_TXT
 Q
 ;
MAILMSG(DFN,RXN,ERRTXT) ;send alert via mailman msg to PSOAUTRF key holders
 N MDUZ,XMDUZ,XMTEXT,XMSUB,PTNAME,PTSSN,DIV,DIVN
 D DEM^VADPT
 S PTNAME=$P(VADM(1),"^"),PTSSN=$P($P(VADM(2),"^",2),"-",3) K VADM
 S DIV=$$RXSITE^PSOBPSUT(RXN,0),DIVN=$P($G(^PS(59,DIV,0)),"^")
 S MDUZ=0
 F  S MDUZ=$O(^XUSEC("PSOAUTRF",MDUZ)) Q:MDUZ'>0  S XMY(MDUZ)=""
 S XMDUZ=.5,XMSUB=DIVN_" CPRS AUTO REFILL - Not Processed List"
 S ERRTXT(.1)="CPRS requested an Outpatient refill, but not allowed for the below reason:"
 S ERRTXT(.2)=""
 S ERRTXT(.3)="   Patient: "_PTNAME_" ("_PTSSN_")"
 S ERRTXT(.4)="      Rx #: "_$$GET1^DIQ(52,RXN,.01)
 S ERRTXT(.5)="      Drug: "_$$GET1^DIQ(52,RXN,6)
 S ERRTXT(.6)=""
 S XMTEXT="ERRTXT(" N DIFROM
 D ^XMD
 Q
