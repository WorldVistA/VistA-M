PSOCP ;BIR/BAB - Pharmacy CO-PAY Application Utilities for IB ;02/06/92
 ;;7.0;OUTPATIENT PHARMACY;**20,46,71,85,137,157,143,219,239,201,225,303**;DEC 1997;Build 19
 ;
 ;REF/IA - IBARX/125, SDCO22/1579, PS(55/2228, PSDRUG(/221, DGMSTAPI/2716, $$GETSHAD^DGUTL3/4462 
CP ;Check if COPAY-Requires RXP,PSOSITE7
 I '$D(PSOPAR) D ^PSOLSET G CP
 K PSOCP
 S PSOCPN=$P(^PSRX(RXP,0),"^",2) ; Set COPAY dfn PTR TO PATIENT
 S PSOCP=$P($G(^PSRX(RXP,"IB")),"^") ; IB action type
 S PSOSAVE=$S(PSOCP:1,1:"") ; save current copay status
 ; Set x=service^dfn^actiontype^user duz
 I +$G(PSOSITE7)'>0 S PSOSITE7=$P(^PS(59,PSOSITE,"IB"),"^")
 S X=PSOSITE7_"^"_PSOCPN_"^"_PSOCP_"^"_$P(^PSRX(RXP,0),"^",16)
 ;
RX ;Determine Orig or Refill for RX
 N PSOIB,PSOPFS S (PSOIB,PSOREF)=0
 I $G(^PSRX(RXP,1,+$G(YY),0))]"" S PSOREF=YY
 D PFSA^PSOPFSU1(RXP,PSOREF,2) G PFS:+PSOPFS
 ; Check if bill exists
 I 'PSOREF,+$P($G(^PSRX(RXP,"IB")),"^",2)>0 D CHKIB^PSOCP1 I PSOIB G QUIT
 I 'PSOREF,+$P($G(^PSRX(RXP,"IB")),"^",4)>0 G QUIT ; 'POTENTIAL BILL' - ALREADY ATTEMPTED TO BILL, BUT EXCEEDED ANNUAL COPAY CAP
 I PSOREF,+$G(^PSRX(RXP,1,PSOREF,"IB")) D CHKIB^PSOCP1 I PSOIB G QUIT
 I PSOREF,+$P($G(^PSRX(RXP,1,PSOREF,"IB")),"^",2) G QUIT ; POTENTIAL BILL
PFS ;
 S PSOCHG=1 ; set tem var to copay and check exception
 N MAILMSG
 D COPAYREL
 I 'PSOCHG D  D:PSOPFS CHRG^PSOPFSU1(RXP,PSOREF,"CG",PSOPFS) G QUIT
 . I PSOSAVE S PSODA=RXP,PREA="R" D ACTLOG^PSOCPA S $P(^PSRX(RXP,"IB"),"^",1)=""
 I PSOCHG=2 D  I 'PSOCP D:PSOPFS CHRG^PSOPFSU1(RXP,PSOREF,"CG",PSOPFS) G QUIT ; IF 'SC' QUESTION APPLIES, BUT HAS NOT BEEN ANSWERED, SEND MAIL MSG AND KEEP COPAY STATUS AS IT WAS
 . D MAIL2^PSOCPE ; SEND MAIL TO PHARMACIST, PROVIDER, AND HOLDERS OF THE PSO COPAY KEY
 I PSOCHG=1,PSOSAVE="" D  I PSOREF S PSOCOMM="",PSOOLD="No Copay",PSONW="Copay" S PSODA=RXP,PREA="R" D ACTLOG^PSOCPA
 . I '$D(^PSRX(RXP,"IB")),'PSOREF S $P(^PSRX(RXP,"IB"),"^",1)=1 Q
 . S $P(^PSRX(RXP,"IB"),"^",1)=1
 . S PSOCP=1,$P(X,"^",3)=PSOCP
 I PSOCHG'=2 I $G(MAILMSG) D MAIL2^PSOCPE ; SEND MAIL TO PHARM, PROV, AND HOLDERS OF PSO COPAY KEY HOLDERS
 ; Units for COPAY
 S PSOCPUN=$P(($P(^PSRX(RXP,0),"^",8)+29)/30,".",1)
 ; Build softlink for x(n)=softlink^units
 S X(1)="52:"_RXP S:PSOREF>0 X(1)=X(1)_";1:"_PSOREF S X(1)=X(1)_"^"_PSOCPUN
 ; Set correct user duz if refill
 I PSOREF S:+$P(^PSRX(RXP,1,PSOREF,0),"^",7)>0 $P(X,"^",4)=$P(^PSRX(RXP,1,PSOREF,0),"^",7)
 ;
IBNEW ;  Load ^TMP global for IB call
 Q:$G(RXP)'>0
 I PSOPFS D CHRG^PSOPFSU1(RXP,PSOREF,"CG",PSOPFS)
 G QUIT:PSOPFS
 N D0
 G QUIT:'$D(X)
 S XTMP=X,XTMP(1)=X(1)
 ;
 ; Requires x=service^dfn^action type^user duz
 ;   x(n)=softlink^units 
 I $P(X,"^",3)="" S $P(X,"^",3)=$P(^PSRX(RXP,"IB"),"^",1)
 D NEW^IBARX
 ; Returns y=1^total charges for this group or Y=-1^error code
 ;         y(n)=IB number^charge for this Rx^AR bill #^Cap met^Partial or Full charge^Copay Exempt^Number from file 354.71
 ;         Cap met ('1' - If patient has met cap amount or reached cap with this charge or '0' if not)
 ;         Partial or Full ('P' for partial billing, 'F' for full billing, null for no billing)
 ;         Copay Exempt - ('1' for exempt, '0' for non-exempt, '-1' for copay off (manila)),
 ;            ('1' - If patient has met cap amount or reach cap with this charge
 ; Entry from file 354.71 will only be saved for fills that met the annual cap and could not be fully billed
 ;
 G QUIT:+Y=-1
 S XTMP=XTMP_"^"_Y,XTMP(1)=XTMP(1)_"^"_Y(1)
 ;
 ; see if exempt or copay cap was met
 I $P(Y(1),"^",6) D  G QUIT
 . S PREA="R",PSOOLD="Copay",PSONW="No Copay"
 . S PSOCOMM="RX COPAY INCOME EXEMPTION" S PSODA=RXP D ACTLOG^PSOCPA
 . S $P(^PSRX(RXP,"IB"),"^",1)=""
 I $P(Y(1),"^",4) D
 . S PSOCOMM=$S($P(Y(1),"^",5)="F":" FULL BILLING FOR THIS FILL",$P(Y(1),"^",5)="P":" PARTIAL BILLING FOR THIS FILL ",1:" NO BILLING FOR THIS FILL")
 . S PREA="A"
 . S PSODA=RXP D ACTLOG^PSOCPA
 . I $P(Y(1),"^",5)'="F" D
 . . I PSOREF S $P(^PSRX(RXP,1,PSOREF,"IB"),"^",2)=$P(Y(1),"^",7) Q
 . . S $P(^PSRX(RXP,"IB"),"^",4)=$P(Y(1),"^",7)
 I $P(Y(1),"^",1)="" G QUIT
 ;
FILE ;File IB number in ^PSRX
 S PSOCP2=0
 S PSOCP2=+$P(XTMP(1),":",3)
 S:PSOCP2>0 ^PSRX(RXP,1,PSOCP2,"IB")=$P(XTMP(1),U,3) ;  Filing in refill node
 I PSOCP2>0,'$D(^PSRX(RXP,"IB")) S ^PSRX(RXP,"IB")="1^^" ;  If refill "IB" exists, need "IB" entry on original fill node
 S:PSOCP2=0 $P(^PSRX(RXP,"IB"),"^",2)=$P(XTMP(1),U,3) ;Filing in original fill (zero node)
QUIT ;
 K Y,PSOCP1,PSOCP2,QQ,PSOCPN,X,X2,XTMP,PSOCPUN,PSOREF,PSOCHG,PSOSAVE,PSOCOMM,PSOOLD,PSONW,PREA,PSORSN
 Q
EN D ^PSOLSET
EN1 S DIR(0)="NO",DIR("A")="Enter PRESCRIPTION number" D ^DIR K DIR G:$D(DIRUT) EXIT S RXP=X I +$G(^PSRX(RXP,0))'>0!+$P($G(^PSRX(RXP,"IB")),"^",0)>0 W !,?10,"RE-CHECK PRESCRIPTION NUMBER AND RE-ENTER " G EN1
 S PSOSITE7=$P(^PS(59,PSOSITE,"IB"),"^")
 S PSODFN=$P(^PSRX(RXP,0),"^",2)
 D CP G EN1
EXIT K RXP D FINAL^PSOLSET Q
 ;
SC(PSODFN,PSODD) ;sup ref for CPRS, Pre-Copay enhancement
 N PSOSC
 I $$DT^PSOMLLDT S PSOSC="" G SCQ
 I $G(PSODD),($P($G(^PSDRUG(PSODD,0)),"^",3)["S")!($P($G(^(0)),"^",3)["I")!($P($G(^(0)),"^",3)["N") S PSOSC=1 G SCQ
 I $P($G(^PS(55,+$G(PSODFN),"PS")),"^"),$P($G(^PS(53,+$P(^("PS"),"^"),0)),"^",7) S PSOSC=1 G SCQ
 N I,J,X S (X,PSOSC)=""
 S J=0 F  S J=$O(^PS(59,J)) Q:'J  I +$G(^(J,"IB")) S X=+^("IB") Q
 G:'X SCQ
 S X=X_"^"_PSODFN D XTYPE^IBARX
 S J="" F  S J=$O(Y(J)) Q:'J  S I="" F  S I=$O(Y(J,I)) Q:I=""  S:I>0 PSOSC=I
SCQ Q $S($G(PSOSC)=2:0,1:1)
 ;
COPAYREL ; Recheck copay status at release
 ; check Rx patient status
 I $P(^PSRX(RXP,0),"^",3)'="",$P($G(^PS(53,$P(^PSRX(RXP,0),"^",3),0)),"^",7)=1 S PSOCHG=0,PSOCOMM="Rx Patient Status Change",PSOOLD="Copay",PSONW="No Copay" Q
 ; see if drug is nutritional supplement, investigational or supply
 N DRG,DRGTYP,X
 S DRG=+$P(^PSRX(RXP,0),"^",6),DRGTYP=$P($G(^PSDRUG(DRG,0)),"^",3)
 I DRGTYP["I" S PSOCOMM="Investigational Drug",PSOCHG=0,PSOOLD="Copay",PSONW="No Copay",PSOCHG=0
 I DRGTYP["S" S PSOCOMM="Supply Item",PSOCHG=0,PSOOLD="Copay",PSONW="No Copay",PSOCHG=0
 I DRGTYP["N" S PSOCOMM="Nutritional Supplement",PSOCHG=0,PSOOLD="Copay",PSONW="No Copay",PSOCHG=0
 K PSOTG,CHKXTYPE
 I +$G(^PSRX(RXP,"IBQ")) D XTYPE1^PSOCP1
 I $G(^PSRX(RXP,"IBQ"))["1" D  S PSOCHG=0,PSOOLD="Copay",PSONW="No Copay" Q  ; COPAY EXEMPT
 . N EXMT,II,PSOCIBQ
 . S PSOCIBQ=$G(^PSRX(RXP,"IBQ"))
 . F II=1,7,3,4,5,6,2,8 I $P(PSOCIBQ,"^",II)=1 S EXMT=$S(II=1:"SC",II=7:"CV",II=3:"AO",II=4:"IR",II=5:"EC",II=8:"SHAD",II=2:"MST",II=6:"HNC",1:"") D:EXMT'="" SETCOMM Q
 D SCNEW(.PSOTG,PSOCPN,DRG,RXP)
 N EXMT
 I '$D(CHKXTYPE) D XTYPE
 F EXMT="SC","CV","AO","IR","EC","SHAD","MST","HNC" I $D(PSOTG(EXMT)) D  I 'PSOCHG Q
 . I PSOTG(EXMT)=1 S PSOCHG=0 D SETCOMM
 I 'PSOCHG S PSOOLD="Copay",PSONW="No Copay" Q
 ;
 ; If any of the applicable exemption quest have never been answered, send a mail msg with all of the quest
 S EXMT="",MAILMSG=0 F  S EXMT=$O(PSOTG(EXMT)) Q:EXMT=""  I PSOTG(EXMT)="" S MAILMSG=1 Q
 I MAILMSG,$D(PSOTG("SC")) I $G(PSOTG("SC"))="" S PSOCHG=2 ; 'SC' quest not answered, don't reset copay status to 'copay'
 Q
 ;
SCNEW(PSOTG,PSOPT,PSODR,PSORN) ;CPRS supported ref
 I '$$DT^PSOMLLDT Q
 I '$G(PSOPT) Q
 ;I $G(PSODR),($P($G(^PSDRUG(PSODR,0)),"^",3)["S")!($P($G(^(0)),"^",3)["I") Q ;CIDC ALWAYS ASK
 N PSOCIBQ,PSOQMSH,PSOQVEH,PSOQRQD,PSOQHNC,PSOQPGW,DFN,PSOSCA,ZXX
 K PSOANSQ("SC>50")
 S DFN=PSOPT
 D SCP^PSORN52D S:PSOSCP>49&(PSOSCA) PSOANSQ("SC>50")=1
 I $G(PSORN) D
 . S PSOCIBQ=$G(^PSRX(PSORN,"IBQ"))
 . I $TR(PSOCIBQ,"^")="" S ZXX=$G(^PSRX(PSORN,"ICD",1,0)) D ICD:ZXX'=""
 I '$G(PSORN) S PSOCIBQ=""
 ;Rx Patient Status check is not being done here
 N PSOSCMX,Y,I,J,X S (X,PSOSCMX)=""
 S J=0 F  S J=$O(^PS(59,J)) Q:'J  I +$G(^(J,"IB")) S X=+^("IB") Q
 G:'X SKIP
 S X=X_"^"_PSOPT D XTYPE^IBARX
 S J="" F  S J=$O(Y(J)) Q:'J  S I="" F  S I=$O(Y(J,I)) Q:I=""  S:I>0 PSOSCMX=I
SKIP ;
 I $G(PSOSCA)!($G(PSOSCMX)=2) S PSOTG("SC")=$S($P(PSOCIBQ,"^")=1:1,$P(PSOCIBQ,"^")=0:0,$G(PSORN)&($P($G(^PSRX(+$G(PSORN),"IB")),"^")):0,1:"")
 S:$$AO^SDCO22(PSOPT) PSOTG("AO")=$S($P(PSOCIBQ,"^",3)=1:1,$P(PSOCIBQ,"^",3)=0:0,1:"")
 S:$$IR^SDCO22(PSOPT) PSOTG("IR")=$S($P(PSOCIBQ,"^",4)=1:1,$P(PSOCIBQ,"^",4)=0:0,1:"")
 S:$$EC^SDCO22(PSOPT) PSOTG("EC")=$S($P(PSOCIBQ,"^",5)=1:1,$P(PSOCIBQ,"^",5)=0:0,1:"")
 S:$P($$GETSTAT^DGMSTAPI(PSOPT),"^",2)="Y" PSOTG("MST")=$S($P(PSOCIBQ,"^",2)=1:1,$P(PSOCIBQ,"^",2)=0:0,1:"")
 I $T(GETCUR^DGNTAPI)]"" N PSONC,PSONCX S PSONCX=$$GETCUR^DGNTAPI(PSOPT,"PSONC") I $P($G(PSONC("IND")),"^")="Y" S PSOTG("HNC")=$S($P(PSOCIBQ,"^",6)=1:1,$P(PSOCIBQ,"^",6)=0:0,1:"")
 S:$P($$CVEDT^DGCV(PSOPT),"^",3) PSOTG("CV")=$S($P(PSOCIBQ,"^",7)=1:1,$P(PSOCIBQ,"^",7)=0:0,1:"")
 I $L($T(GETSHAD^DGUTL3)) S:$$GETSHAD^DGUTL3(PSOPT)=1 PSOTG("SHAD")=$S($P(PSOCIBQ,"^",8)=1:1,$P(PSOCIBQ,"^",8)=0:0,1:"")
 Q
 ;
ICD ;
 D ICD^PSOCP1
 Q
XTYPE ;
 N PSOCIBQ,PSOSCMX,Y,I,J,X,SAVY,ZXX
 S (X,PSOSCMX,SAVY)=""
 S PSOCIBQ=$G(^PSRX(RXP,"IBQ")) I $TR(PSOCIBQ,"^")="" S ZXX=$G(^PSRX(RXP,"ICD",1,0)) D ICD:ZXX'=""
 I $P(PSOCIBQ,"^",1)'="" S PSOTG("SC")=$P(PSOCIBQ,"^",1)
 I $D(PSOTG("SC")),$P(PSOCIBQ,"^",1)="" S PSOTG("SC")="" ; USE "CURRENT" SETTING AS ANS TO SC QUEST IF IT APPLIES
 S J=0 F  S J=$O(^PS(59,J)) Q:'J  I +$G(^(J,"IB")) S X=+^("IB") Q
 I 'X Q
 S X=X_"^"_PSOCPN D XTYPE^IBARX
 I $G(Y)'=1 Q
 S J="" F  S J=$O(Y(J)) Q:'J  S I="" F  S SAVY=I,I=$O(Y(J,I)) Q:I=""  S:I>0 PSOSCMX=I
 I PSOSCMX="",SAVY=0 S PSOCHG=0 S PSOCOMM="Exempt from copayment" Q  ; INCOME EXEMPT OR SC
 I PSOSCMX=2,'$D(PSOTG("SC")) S PSOTG("SC")=$S(($G(RXP)&($P($G(^PSRX(+$G(RXP),"IB")),"^")))!($P(PSOCIBQ,"^")=0):0,$P(PSOCIBQ,"^")=1:1,1:"") Q
 Q
 ;
SETCOMM ;
 D SETCOMM^PSOCP1
 Q
 ;
