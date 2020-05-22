RCTC364P ;MNTVBB,RGB-Remove TOP date flag that prevented CS billing;12/14/19 3:34 PM
V ;;4.5;Accounts Receivable;**364**;Mar 20, 1995;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;;PRCA*4.5*364 The TOP accounts found should never have been sent to TOP once the Treasury cross-service
 ;;             batch run started with a cutoff date of 08-01-15 (or 02-01-15) for the 3 beta sites.
 Q
EN ;TASK TOP FLIP
 D BMES^XPDUTL("Tasking the search of TOP accounts that should not have")
 D BMES^XPDUTL("been sent to Top after 8-1-15 in a background job.")
 N ZTSK,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE
 S ZTRTN="EN1^RCTC364P",ZTDESC="PRCA*4.5*364 post-init process"
 S ZTSAVE("*")="",ZTDTH=$H,ZTIO="" D ^%ZTLOAD
 Q
EN1 N RCSITE,RCACTDT,RCDEBTOR,RCBILL
 S RCSITE=$E($$SITE^RCMSITE(),1,3),U="^",DT=$$DT^XLFDT
 K ^XTMP("RCTC364P")
 S ^XTMP("RCTC364P",0)=$$FMADD^XLFDT(DT,90)_"^"_DT
 S ^XTMP("RCTC364P",$J,0)="0^0"
 N RCDEBTR0,RCDEBTR1,RCDEBTR3,RCDEBTR7,RCDEBTR8,RCDEMCS,RCTOTAL,RCDFN,RCDEMCS,RCDOB,RCGNDR
 N RCB0,RCB4,RCB6,RCB7,RCB9,RCB12,RCB121,RCB14,RCB15,RCB16,RCB19,RCB20,RCACTION,RCRR,RCCAT,RCRR,RCCTR
 N RCTT,RCTB,RCTB1,RCTD,RCTD1,IEN,CTR,RCIEN
 S (RCDEBTOR,RCTB,RCTB1,RCTD,RCTD1)=0
 S RCACTDT=3150801 ;activation date for all sites except beckley, little rock, upstate ny 
 S:RCSITE=598 RCACTDT=3150201 ;activation date for little rock
 S:RCSITE=517 RCACTDT=3150201 ;activation date for beckley
 S:RCSITE=528 RCACTDT=3150201 ;activation date for upstate ny
RSDEBTOR ;
 F  S RCDEBTOR=$O(^PRCA(430,"C",RCDEBTOR)) Q:RCDEBTOR'?1N.N  D
 . D NOW^%DTC S ^XTMP("RCTC364P",$J,"ZZBDEBTOR")=%_U_RCDEBTOR
 . Q:'$D(^RCD(340,"TOP",RCDEBTOR))
 . Q:^RCD(340,RCDEBTOR,0)'["DPT"
 . I '$D(^RCD(340,RCDEBTOR,0)) S ^XTMP("RCTC364P",$J,"ZZUNDEF",RCDEBTOR)="" Q
 . S RCDEBTR0=^RCD(340,RCDEBTOR,0),RCDEBTR1=$G(^(1)),RCDEBTR3=$G(^(3)),RCDEBTR7=$G(^(7))
 . S RCDEBTR8=$O(^RCD(340,RCDEBTOR,8,"A"),-1) I RCDEBTR8?1.N S RCDEBTR8=$P($G(^RCD(340,RCDEBTOR,8,RCDEBTR8,0)),U)
 . S RCDFN=+RCDEBTR0
 . S RCDEMCS=$$DEM^RCTCSP1(RCDFN)
 . S RCDOB=$P(RCDEMCS,U,2)
 . S RCGNDR=$P(RCDEMCS,U,1) S:"MF"'[RCGNDR RCGNDR="U"
 . S (RCBILL,RCTOTAL)=0
RSBILL . F  S RCBILL=$O(^PRCA(430,"C",RCDEBTOR,RCBILL)) Q:RCBILL'?1N.N  D
 .. I $G(^PRCA(430,RCBILL,14))<RCACTDT Q
 .. D NOW^%DTC S ^XTMP("RCTC364P",$J,"ZZCTRACKER")=%_U_RCDEBTOR_U_RCBILL
 .. S RCB0=$G(^PRCA(430,RCBILL,0)),RCB4=$G(^(4)),RCB6=$G(^(6)),RCB7=$G(^(7)),RCB9=$G(^(9)),RCB12=$G(^(12)),RCB121=$G(^(12.1)),RCB14=$G(^(14)),RCB15=$G(^(15)),RCB16=$G(^(16)),RCB19=$G(^(19)),RCB20=$G(^(20))
 .. S RCCAT=$P($G(^PRCA(430.2,$P(RCB0,U,2),0)),U,7) Q:'RCCAT
 .. Q:'$$RFCHK(RCCAT,"N",1.03,$P(RCB6,U,21))
 .. S RCTOTAL=$P(RCB7,U)+$P(RCB7,U,2)+$P(RCB7,U,3)+$P(RCB7,U,4)+$P(RCB7,U,5)
 .. I $P(RCB0,U,8)'=16 Q
 .. Q:RCB4  ;repayment plan
 .. Q:+$P(RCDEMCS,U,4)  ;deceased patient
 .. Q:'$P(RCB0,U,2)  ;no category
 .. S RCTD=RCTD+RCTOTAL,RCTB=RCTB+1
 .. I RCTOTAL<25 S RCTB1=RCTB1+1,RCTD1=RCTD1+RCTOTAL
 .. S ^XTMP("RCTC364P",$J,2,$P(RCB0,U,2))=RCCAT,^XTMP("RCTC364P",$J,3,($P(RCB6,U,21)\1))="",^XTMP("RCTC364P",$J,4,$P(RCB14,U))=""
 .. S ^XTMP("RCTC364P",$J,1,RCDEBTOR,RCBILL)=$P(RCB0,U)_U_RCTOTAL_U_RCB14_U_($P(RCB6,U,21)\1)_U_$P(RCB0,U,2)_U_RCCAT
 .. K ^PRCA(430,RCBILL,14)
 .. Q
 S $P(^XTMP("RCTC364P",$J,0),U)=RCTB,$P(^XTMP("RCTC364P",$J,0),U,2)=RCTD
 S $P(^XTMP("RCTC364P",$J,0),U,3)=RCTB1,$P(^XTMP("RCTC364P",$J,0),U,4)=RCTD1
 D NOW^%DTC S ^XTMP("RCTC364P",$J,"ZZCOMPLETE")=%
MSG N XMY,XMDUZ,XMSUB,XMTEXT,BMSG,IEN,CTR,RCIEN,DIFROM
 S XMDUZ=.5
 S XMY("G.TCSP")=""
 S XMSUB="****  REROUTED DATED TOP BILLS  ***"
 S BMSG(1)="The following TOP bills have been reversed from TOP as they went after the"
 S BMSG(2)="CS cutover control date of "_RCACTDT
 S BMSG(3)=" "
 S BMSG(4)="REVERSED TOP BILLS TO: "_RCTB_" / "_RCTD_"            BILLS <$25: "_RCTB1_" / "_RCTD1
 S BMSG(5)=" "
 S BMSG(6)="  Bill No.        Total      Act. Date     Top Date     Cat./ien"
 S BMSG(7)=" ===========     =======     =========     =========    ========"
 M ^XTMP("RCTC364P",$J,5)=BMSG
 S RCDEBTOR=0
 S RCCTR=7 F  S RCDEBTOR=$O(^XTMP("RCTC364P",$J,1,RCDEBTOR)),RCIEN=0 Q:'RCDEBTOR  D
 . F  S RCIEN=$O(^XTMP("RCTC364P",$J,1,RCDEBTOR,RCIEN)) Q:'RCIEN  D
 . . S RCRR=^XTMP("RCTC364P",$J,1,RCDEBTOR,RCIEN)
 . . S RCCTR=RCCTR+1,^XTMP("RCTC364P",$J,5,RCCTR)=" "_$P(RCRR,U)_$J($P(RCRR,U,2),12,2)_$J($$FMTE^XLFDT($P(RCRR,U,3),"5Z"),15)_$J($$FMTE^XLFDT($P(RCRR,U,4),"5Z"),14)_$J($P(RCRR,U,6)_"/"_$P(RCRR,U,5),9)
 S XMTEXT="^XTMP(""RCTC364P"","_$J_",5,"
 D ^XMD
MSG2 ;MSG SENT TO TOP GUN
 N XMDUZ,XMSUB,XMTEXT,XMY,XMSG,DIFROM
 S XMSG("MSG",1)="TOP REVERSAL NUMBERS FOR SITE: "_RCSITE_"       PATCH 364 INSTALL:"_$J($$FMTE^XLFDT(DT,"5Z"),10)
 S XMSG("MSG",2)=""
 S XMSG("MSG",3)="REVERSED TOP BILLS/$$:  "_RCTB_" / "_RCTD_"      BILLS <$25: "_RCTB1_" / "_RCTD1
 S XMSUB="TOP REVERSAL NUMBERS ("_RCSITE_")"
 S XMDUZ=.5,XMTEXT="XMSG(""MSG"","
 S XMY("CONNER.DANIEL_J@ASHEVILLE.DOMAIN.EXT")=""
 D ^XMD
EXIT Q
RFCHK(RCXCAT,RCIENFLG,RCXRFCD,RCXDT) ;Check to see if bill can be referred to requested collections program
 ;
 ;Input:
 ;   RCXCAT    - (Required) AR Category to check.
 ;   RCXIENFLG - Is the AR Category an IEN (I) or a number (N).
 ;   RCXRFCD   - (Required) FileMan Field number for the Referral type being checked. 
 ;               1.01 - DMC
 ;               1.02 - TOP
 ;               1.03 - CS
 ;   RCXDT     - (Required) Date of service to be checked.
 ;
 N RCXFLG,RCXCTIEN,RCXSPDT
 ;
 ; Set the initial split date for the TOP and CS referral programs
 S RCXSPDT=3150801
 ; Get the category IEN.
 S RCXCTIEN=RCXCAT  ;Initially assume it is an IEN
 ; Update to IEN if AR Category is the Category Number
 I RCIENFLG="N" S RCXCTIEN=$O(^PRCA(430.2,"AC",RCXCAT,""))
 ; Quit if Category not found
 Q:RCXCTIEN="" 0
 ;
 ; Extract the flag for the category from the AR Category file (430.2), using the field number sent in
 S RCXCTIEN=RCXCTIEN_","
 S RCXFLG=$$GET1^DIQ(430.2,RCXCTIEN,RCXRFCD,"I")
 I RCXFLG<2 Q RCXFLG
 I RCXFLG=2,(RCXDT<RCXSPDT) Q 1
 I RCXFLG=3,(RCXDT'<RCXSPDT) Q 1
 Q 0
