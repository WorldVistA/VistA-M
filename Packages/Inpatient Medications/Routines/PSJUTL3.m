PSJUTL3 ;BIR/MLM-MISC. INPATIENT UTILITIES ;29 OCT 01 / 4:29 PM
 ;;5.0;INPATIENT MEDICATIONS;**58,353,426*;16 DEC 97;Build 4
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PSSLOCK is supported by DBIA# 2789.
 ;
EN ;
 Q:$$PATCH^XPDUTL("PSJ*5.0*58")
 S ZTDTH=$H,ZTRTN="QUEIV^PSJUTL3",ZTIO="",ZTDESC="Inpatient medications - Mark IV orders as verified"
 D ^%ZTLOAD
 Q
QUEIV ;
 D XTMP
 NEW DFN,START,PSJX
 D NOW^%DTC S START=%
 F DFN=0:0 S DFN=$O(^PS(55,DFN)) Q:'DFN  D
 . S PSJX=$P($G(^PS(55,DFN,5.1)),U,11)
 . Q:PSJX=3
 . I PSJX=2 D MARKIV(DFN) Q
 . D CNIV^PSJUTL1(DFN)
 D SEND(START)
 Q
XTMP ;
 I '$D(^XTMP("PSJ NEW PERSON",0)) D
 . NEW X1,X2 S X1=DT,X2=30 D C^%DTC
 . S ^XTMP("PSJ NEW PERSON",0)=X_U_DT_U_"Correct changed user names"
 Q
 ;
MARKIV(DFN) ;
 ;Mark the Verifying Pharmacy field for active order created prior
 ; to PSJ*5*58
 NEW ON,ON55,X,PSJPINIT,PSJIDT,PSJNOW,PSIVACT
 Q:'$$L^PSSLOCK(DFN,0)
 D NOW^%DTC S PSJNOW=$E(%,1,12)
 S PSJIDT=$$INSTLDT^PSJUTL1() I PSJIDT="" S PSJIDT=PSJNOW
 S $P(^PS(55,DFN,5.1),U,11)=3
 F ON=0:0 S ON=$O(^PS(55,DFN,"IV",ON)) Q:'ON  D
 . S X=$G(^PS(55,DFN,"IV",ON,2))
 . I +X>PSJIDT Q
 . S PSJPINIT=$P(X,U,11)
 . NEW XX,XX1,PSJIEN
 . F XX=0:0 S XX=$O(^PS(55,DFN,"IV",ON,"A",XX)) Q:'XX  D
 .. NEW PSJX S XX1=$G(^PS(55,DFN,"IV",ON,"A",XX,0))
 .. Q:$P(XX1,U,3)=""
 .. K PSJIEN S PSJX=""
 .. I $P(XX1,U,6)="" D
 ... D NAME^PSJBCMA1($P(XX1,U,3),,,.PSJIEN)
 ... S:PSJIEN>0 $P(^PS(55,DFN,"IV",ON,"A",XX,0),U,6)=PSJIEN,XX1=^(0)
 .. Q:+$P($G(^PS(55,DFN,"IV",ON,4)),U,4)
 .. I $P(XX1,U,2)="F",($P(XX1,U,4)'="FINISHED BY TECHNICIAN") S PSJPINIT=$P(XX1,U,6),PSJX=1
 .. S:$G(PSJIEN)=-1 ^XTMP("PSJ NEW PERSON",1,$P(XX1,U,3),DFN,ON,XX)=PSJX
 . Q:+PSJPINIT'>0
 . Q:+$P($G(^PS(55,DFN,"IV",ON,4)),U,4)
 . D VF(ON,DFN,PSJPINIT,PSJNOW)
 D UL^PSSLOCK(DFN)
 Q
VF(ON,DFN,PSJPINIT,PSJNOW) ; Update verifying pharm and date fields.
 K DA,DIE,DR
 S PSIVACT=""
 S DIE="^PS(55,"_DFN_",""IV"",",DA=ON,DA(1)=DFN
 S DR="140////"_PSJPINIT_";141////"_PSJNOW_";142////1" D ^DIE
 S ON55=ON,PSIVREA="V",PSIVALT=""
 S PSIVAL="AUTO VERIFIED WITH PATCH PSJ*5*58"
 D LOG^PSIVORAL K PSIVAL,PSIVALT,PSIVREA
 Q
SEND(START) ;
 NEW DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,STOP,LINE
 D NOW^%DTC S STOP=%
 S LINE(1)="Marking prior IV orders as verified started: "_$$FMTE^XLFDT(START)
 S LINE(2)="It ran to completion: "_$$FMTE^XLFDT(STOP)
 I $O(^XTMP("PSJ NEW PERSON",0)) D
 . S LINE(3)=""
 . S LINE(4)="Please assign the PSJI ACTIVITY LOG VA200 option to a holder of the"
 . S LINE(5)="PSJI MGR key who is familiar with the Pharmacy users to correct any "
 . S LINE(6)="names that the software was unable to match to the New Person file (#200)."
 S XMSUB="PSJ*5*58 IV Verification",XMTEXT="LINE("
 S XMDUZ="PSJ*5*58"
 S XMY(+DUZ)="" D ^XMD
 Q
 ;
DMACTN ;Entry point for DM hidden action from backdoor LM OE     *353
 N GL,IFN,NXT,NODD,NXTROOT,ROOT,QQ
 D FULL^VALM1
 W #
 S (IFN,NXT,NODD)=0
 I ((NAME["PSJ LM UD")!(NAME["PSJU LM")),$G(PSGDRG) S IFN=+PSGDRG D SHOWDR       ;Unit Dose backdoor New order entry in process Drug ien, but is OI ien when New IV's
 ;all other Unit dose input
 I ((NAME["PSJ LM UD")!(NAME["PSJU LM")!(NAME["PSJ LM PENDING")),'$G(PSGDRG) D   ;Unit Dose DD mult
 . I $G(PSGORD)["P" S PSGOEEWF="^PS(53.1,"_+PSGORD_","
 . I '$G(PSGORD),ON["P" S PSGOEEWF="^PS(53.1,"_+ON_","
 . F QQ=0:0 S ROOT=PSGOEEWF_"1,"_QQ_")" S QQ=$O(@ROOT) Q:'QQ  D
 .. S NODD=NODD+1,NXTROOT=PSGOEEWF_"1,"_QQ_")",NXT=$O(@NXTROOT),GL=$E(NXTROOT,1,$L(ROOT)-1),IFN=+@(GL_",0)")
 .. D SHOWDR
 ;all IV's
 I NAME["PSJ LM IV" D 
 . S:ON["P" PSGOEEWF="^PS(53.1,"_+ON_","
 . S:ON["V" PSGOEEWF="^PS(55,"_DFN_",""IV"","_+ON_","                            ;IV, Chk IV Additives
 . F QQ=0:0 S ROOT=PSGOEEWF_"""AD"","_QQ_")" S QQ=$O(@ROOT) Q:'QQ  D
 .. S NODD=NODD+1,NXTROOT=PSGOEEWF_"""AD"","_QQ_")",NXT=$O(@NXTROOT),GL=$E(NXTROOT,1,$L(ROOT)-1),IFN=+@(GL_",0)") S:IFN IFN=+$P($G(^PS(52.6,IFN,0)),U,2)
 .. D SHOWDR
 I '$G(PSGDRG),'NODD D SHOWDR                                                    ;err, No IFN, No DD, & No IV Ads, display msg 
 D PICKDR
 S VALMBCK="R"
 Q
 ;
PICKDR ;Entry point for Selecting a diff Drug
 N IFN,Y
 W ! K DIC S DIC="^PSDRUG(",DIC(0)="AEQMVTN",DIC("T")="" W "Return to continue or" D ^DIC K DIC I Y<0 Q
 S IFN=+Y
 D SHOWDR
 G PICKDR
 ;
SHOWDR ;Entry point to Display Drug hidden action info (via defaulted IFN)
 N DIR,OIPTR
 I 'IFN W !!,"** NO Dispense Drug entered for this order",! G PICKDR
 I NODD=1,NXT W "** MULTIPLE DISP DRUGS **"
 W !,"DRUG NAME: ",$$GET1^DIQ(50,IFN_",","GENERIC NAME")," (IEN: "_IFN_")"
 S OIPTR=^PSDRUG(IFN,2) S:$P(OIPTR,"^",1)]"" OIPTR=$P(OIPTR,"^",1)
 I OIPTR]"" W !," ORDERABLE ITEM TEXT: ",! D DMOITXT
 W !," MESSAGE: ",$$GET1^DIQ(50,IFN_",","MESSAGE") D FULL
 W !," QTY DISP MESSAGE: ",$$GET1^DIQ(50,IFN_",","QUANTITY DISPENSE MESSAGE"),! D FULL
 K Y
 Q
 ;
DMOITXT ;Get Pharmacy Orderable Item drug text fields
 N DDD,QUIT,TEXT,TEXTPTR,TXT
 I $D(^PS(50.7,OIPTR,1,0)) F TXT=0:0 S TXT=$O(^PS(50.7,OIPTR,1,TXT)) Q:'TXT  D
 . S TEXTPTR=^PS(50.7,OIPTR,1,TXT,0)
 . F DDD=0:0 S DDD=$O(^PS(51.7,TEXTPTR,2,DDD)) Q:'DDD  I '$$INACDATE S TEXT=^PS(51.7,TEXTPTR,2,DDD,0) D FULL Q:$G(QUIT)  W "  ",TEXT,!
 Q
 ;
FULL ;Screen is full, pause
 D:($Y+3)>IOSL&('$G(QUIT)) FSCRN
 Q
 ;
FSCRN ;User Wait as screen if full
 Q:$G(QUIT)  K DIR S DIR(0)="E",DIR("A")="Press Return to continue,'^' to exit" D ^DIR W @IOF S:Y'=1 QUIT=1
 Q
 ;
INACDATE() ;Check Inactive date
 Q $P($G(^PS(51.7,TEXTPTR,0)),"^",2)
 ;
VPACTN  ;Entry point for VP hidden action from PSJ OE-testing bg     *353
 D FULL^VALM1
 N IFN S IFN=+$G(P("6")) I 'IFN S IFN=+$G(PSGPR)
 D SHOWVP
 S VALMBCK="R"
 Q
 ;
PICKVP  ;Entry Point For Selecting a diff provider
 N IFN,Y
 W ! K DIC S DIC="^VA(200,",DIC(0)="AEQMVTN",DIC("T")="" W !,"Return to continue or" D ^DIC K DIC I Y<0 Q
 S IFN=+Y
 ;
SHOWVP  ;Entry point to Display Provider hidden action info (via defaulted IFN)
 N DIR
 I 'IFN W !,"No provider entered for this order",! G PICKVP
 W #,"PROVIDER TITLE:    ",$$GET1^DIQ(200,IFN_",","TITLE")
 W !!,"PROVIDER REMARKS:  ",$$GET1^DIQ(200,IFN_",","REMARKS")
 W !!,"PROVIDER SPECIALTY:  ",$$GET1^DIQ(200,IFN_",","PROVIDER CLASS"),!,"                     "_$$GET1^DIQ(200,IFN_",","SERVICE/SECTION")
 K Y
 G PICKVP
 Q
 ;
DELNV(DFN,ORDER) ; Deletes/Resets Nurse Verification in PHARMACY PATIENT file (#55), used by BCMA
 ;Input: DFN   - Pointer the PATIENT file (#2)
 ;       ORDER - Pointer to ORDER sub-file in file #55 (e.g., "124U", "321V")
 I $P($G(^PS(55,+$G(DFN),$S(ORDER["V":"IV",1:5),+$G(ORDER),4)),"^",10) D
 . S $P(^PS(55,DFN,$S(ORDER["V":"IV",1:5),+ORDER,4),"^",1)=""
 . S $P(^PS(55,DFN,$S(ORDER["V":"IV",1:5),+ORDER,4),"^",2)=""
 . S $P(^PS(55,DFN,$S(ORDER["V":"IV",1:5),+ORDER,4),"^",10)=0
 Q
