VEXRX    ;MUSKOGEE VAMC/GLD - AUDIOFAX SUBROUTINE - 6-21-94
 ;;7.0;OUTPATIENT PHARMACY;**197,328**;JUN 1994
 ;
 ;Reference to ^ORAREN supported by IA #5498
 ;;PERFORM MUMPS AUDIOFAX REFILLS BY CALLING ^PSOBBC
 ;
 ; THIS IS COPY OF HOP'S VEXRX PLUS MY TWO SETS
 ;  
 ;This routine is for Outpatient version 7 only
         ; Modify History:
         ;  06Jan2004; IHS; @1; Add Renewal Processing
         ;  30Apr2004; IHS; @2; Add N flag for not renewable
         ;  Feb 2004; BFD/PVAMC ; Add RENFLG (used in later chk of global)
                 ;  25Jun2004; BFD/PVAMC ; Add 'pass' of provider parameter & generic user DUZ
                 ;  09July2004; BFD/PVAMC; Add call to send mail message to renewal mail group
                 ;  03Aug2004; BFD/PVAMC ; Add RENFLG=0 to START because no data in global cause crash
                 ;  10Aug 2004; BFD/PVAMC; Add CN1T=0 to START & put in END+1 because mail message not being sent
                 ;  26Aug2004; BFD/PVAMC; Add ktrs for msg to 'mgr' mail group
                 ;  29Aug2004; BFD/PVAMC; Add order prob kt
                 ;  27Jan2006; @3; IHS; Merge Bay Pines changes with Portland Renewal code
                 ;  Feb-May 2006 ; BFD/PVAMC; New checks in VEX3 and VEX4 causes to skip renewal.  Had to add new code to have recognized
                 ;  Apr-May 2006; BFD/PVAMC; New code in VEX3 to have program recognize renewal request and not skip
                 ;  24-July 2006; BFD/PVAMC; Replace APUVEX call with APUVEX1 or APUVEX2, as appropirate.  Had to split APUVEX due to size problem for SACC
                 ;  05Dec 2006; BFD/PVAMC; Replace APUVEX1 call with APUVEX because reports that random requests not being handled correctly
                 ;        HAD TO REPLACE APUVEX1 AND APUVEX2 CALLS BECAUSE OF AN ERROR
                 ;  March, 2009; JLC/VM replace APU calls with call to CPRS API
 ; --------------------------------------------------------------------------------------
START S PSOVEX=1
 ; BFD/PVMAC 2-8-06  Add renewal variable Set (2 lines)
 N PATIEN,PROVP,RENFLG,RESULT,USR,TOTREN,RXNUM,TOTF,EMCNT,INCNT
 S RENFLG=0,CNT1=0,FBKTRDN=0,FBKTR=0,PTERMDN=0,PTERM=0,NPCPDN=0,NPCP=0,UNSKTR=0,INFPKTR=0,INFPDNKTR=0,NRF=0,RFY=0,MMCONT=0,PCONT=0,NRFLG=0,ORDP=0,ORDPDN=0
 S HACT=0,HACTDN=0,NPCPADN=0,NPCPA=0,NDINACT=0,DINACT=0,MMDAT=0,DISDT=0,NDISDT=0
 K ^TMP($J,"ORAREN E"),^TMP($J,"ORAREN OC") S (EMCNT,INCNT)=5,(TOTF,TOTREN)=0
 ;
 K PSOVEXI,PSOISITE,PSOVEXFL
 F PSOVX=0:0 S PSOVX=$O(^PS(59,PSOVX)) Q:'PSOVX  I $P($G(^PS(59,PSOVX,"I")),"^"),DT>$P($G(^("I")),"^") S PSOVEXI(PSOVX)=""
 I $O(PSOVEXI(0)) W !,"Looking for refill requests for inactive Outpatient divisions..." F PSOVIN=0:0 S PSOVIN=$O(^VEXHRX(19080,PSOVIN)) Q:'PSOVIN  S PSOVXLP="" F  S PSOVXLP=$O(^VEXHRX(19080,PSOVIN,PSOVXLP)) Q:PSOVXLP=""  D
 .S PSOISITE=$P($G(^PSRX(+$P(PSOVXLP,"-",2),2)),"^",9) Q:$G(PSOVEXI(+$G(PSOISITE)))
 .I PSOISITE,$D(PSOVEXI(PSOISITE)),$G(^VEXHRX(19080,PSOVIN,PSOVXLP))="" S PSOVEXI(PSOISITE)=1,PSOVEXFL=1
 I '$G(PSOVEXFL),$O(PSOVEXI(0)) W ".none found.",!
 I $G(PSOVEXFL) W !!,"The following Inactive Outpatient sites have refill requests:",! F PSOVX=0:0 S PSOVX=$O(PSOVEXI(PSOVX)) Q:'PSOVX  I $G(PSOVEXI(PSOVX)) W !?5,$P($G(^PS(59,+$G(PSOVX),0)),"^")
 I $G(PSOVEXFL) K DIR W ! S DIR(0)="E",DIR("A")="Press Return to Continue, '^' to exit" D ^DIR W ! I Y'=1 G END
 D:'$D(PSOPAR) ^PSOLSET G:'$D(PSOPAR) END
 W !!!?20,"Division: "_$P(^PS(59,PSOSITE,0),"^"),!!
 S PSOBBC1("FROM")="REFILL",PSOBBC("QFLG")=0,PSOBBC("DFLG")=0
 I '$D(^VEXHRX(19080,PSOINST)) S VEXANS="N" W !!?7,$C(7),"There are no telephone refills to process." G END
 D ASK^PSOBBC W:PSOBBC("QFLG")=1 !?7,$C(7),"No telephone refills were processed." G:PSOBBC("QFLG")=1 END
VEX W ! S DIR("B")="YES",DIR("A")="Process telephone refill requests at this time",DIR(0)="Y" D ^DIR K DIR S VEXANS="N" I $G(DIRUT) S VEXPTRX="" G END
 G:Y=0 END S VEXPTRX="" I Y=1 S VEXANS="Y"
 I VEXANS["Y" S DIR("B")="YES",DIR("A")="Process telephone refills for all divisions",DIR(0)="Y" D ^DIR K DIR S VEXANS2="S" S:Y=1 VEXANS2="M" I $G(DIRUT) S VEXANS="N" G END
 ; @3; Added Portland code to Bay Pines
 S CNT1=10        ; BFD/PVMAC 7-9-04 use to indicate first time through for mail msg build
VEX6 I VEXANS["Y",$G(VEXPTRX) D VEX5 ;MARK PROCESSED NODES
 D VEX3 I $G(VEXANS)="N" D ULK G END
 I $P(X,"-")'=PSOINST W !?7,$C(7),$C(7),$C(7),"Not from this institution.",! D ULK G VEX6
 ; @3; Add Portland code to Bay Pines
 I $L(RENEW) S RENEW="" G VEX6
 S (PSOBBC("IRXN"),PSOBBC("OIRXN"))=$P(X,"-",2)
 I $D(^PSRX(PSOBBC("IRXN"),0))']"" W !,$C(7),"Rx data is not on file!",!  D ULK G VEX6
 I $P($G(^PSRX(PSOBBC("IRXN"),"STA")),"^")=13 W !,$C(7),"Rx has already been deleted." D ULK G VEX6
 I $G(PSOBBC("DONE"))[PSOBBC("IRXN")_"," W !,$C(7),"Rx has already been entered." D ULK G VEX6
 K X,Y D:PSOBBC("QFLG") PROCESSX^PSOBBC
 S PSOSELSE=0 I $G(PSODFN)'=$P(^PSRX(PSOBBC("IRXN"),0),"^",2) S PSOSELSE=1 D PT^PSOBBC I $G(PSOBBC("DFLG")) K PSOSELSE D ULK G VEX6
 I '$G(PSOSELSE) D PTC^PSOBBC I $G(PSOBBC("DFLG")) K PSOSELSE D ULK G VEX6
 K PSOSELSE D PROFILE^PSORX1 S X="PPPPDA1" X ^%ZOSF("TEST") I  S X=$$PDA^PPPPDA1(PSODFN) W !!
 S PSOBBC("DONE")=PSOBBC("IRXN")_"," D REFILL^PSOBBC D ULK G VEX6
 Q
 ; BFD/648 4-27-06  Add VEX3+3 and chk of vex648, VEX4+0 so not skip renewal requests
VEX3 K PSOBBC("IRXN"),VEXXFLAG F  S VEXPTRX=$O(^VEXHRX(19080,PSOINST,VEXPTRX))  D  Q:VEXANS="N"!($G(VEXXFLAG))
 . I VEXPTRX="" S VEXANS="N" Q
 . S VEXREN=0,VEX648=0,VEXREN=$G(^VEXHRX(19080,PSOINST,VEXPTRX)) I VEXREN]"" D BFDRNCHK
 . I '$D(^PSRX(+$P(VEXPTRX,"-",2),0)),VEX648=1 D VEX5 Q  ;SKIPS ERRONEOUS ENTRIES
 . ;I '$D(^PSRX(+$P(VEXPTRX,"-",2),0)),^VEXHRX(19080,PSOINST,VEXPTRX)="" D VEX5,VEX12 Q  ;SKIPS ERRONEOUS ENTRIES
VEX4 .I VEXANS["Y" Q:VEX648=1  S X=PSOINST_"-"_$P(VEXPTRX,"-",2)  ;SKIPS ENTRIES ALREADY PROCESSED AND FORMATS VARIABLE X (BFD/648 LINE)
 .;I VEXANS["Y" Q:^VEXHRX(19080,PSOINST,VEXPTRX)'=""  S X=PSOINST_"-"_$P(VEXPTRX,"-",2)  ;SKIPS ENTRIES ALREADY PROCESSED AND FORMATS VARIABLE X (ORIG LINE)
VEX10 .I VEXANS2["S",$D(^PSRX(+$P(VEXPTRX,"-",2),0)),PSOSITE'=$P($G(^PSRX(+$P(VEXPTRX,"-",2),2)),"^",9) Q
 . ;@3; Check at this point if this is a renewal request
 . D RENEWCHK I RENEW]"" S VEXXFLAG=1 Q
 . S VEXPSORX=+$P($G(VEXPTRX),"-",2) I VEXPSORX D PSOL^PSSLOCK(VEXPSORX) I '$G(PSOMSG) K VEXPSORX,PSOMSG Q
 . K PSOMSG S VEXXFLAG=1
 Q
 ; -----------------------------------------------------------------------------------
 ; @3; Added Portland code to Bay Pines
 ;LINES CALLED TO MARK PROCESSED NODES
 ;LINES CALLED TO MARK PROCESSED NODES
 ;PVMAC/BFD 2/04  Add RENFLG chk, If 1 then renewal & global already set so skip
 ;PVMAC/BFD 8-26-04 Add RFY and NRF ktrs to VEX5 and VEX12
 ;PVMAC/BFD 8-26-04 Add NRFLG 
VEX5 ;
 ; Next statement is used by BFD/648 CHK PROGRESS THRU PROGRAM
 ;W !,"AT VEX5 and VEXXFLAG is "_VEXXFLAG
 I RENFLG=0 S ^VEXHRX(19080,PSOINST,VEXPTRX)=DT D  ;MARKS NODE AS PROCESSED
 . I $G(PSOBBC("DFLG")) D VEX12 ;FLAGS UNSUCCESSFUL ATTEMPTS TO REFILL.
 ; @3
 I NRFLG=0,(RENFLG=0) S RFY=RFY+1
 S NRFLG=0
 Q
VEX12 ;
 ; @3
 S NRF=NRF+1,NRFLG=1
 S $P(^VEXHRX(19080,PSOINST,VEXPTRX),U,2)="NOT FILLED"
 W !!,$C(7),"REFILL WAS NOT PROCESSED!  PLEASE TAKE APPROPRIATE ACTION."
 W ! S DIR("A")="Do you wish to continue processing",DIR(0)="Y" D ^DIR K DIR I Y'=1 S VEXANS="N" Q
 Q
END D PROCESSX^PSOBBC
 ; bfd/648 12-5-06 ; out all APUVEX1 and APUVEX2 calls &  un ; out all APUVEX calls
 ; @3
 ; SMT If VEXANS2="S" then we are only looking at a single division and we add the division to the mail subject.
 K XMY N XMDUZ,XMSUB,XMTEXT,XMT
 S XMDUZ="AUTO,RENEWAL",XMY(DUZ)="",XMY("G.AUTORENEWAL")="",XMSUB=$S($G(VEXANS2)["S":$$GET1^DIQ(59,PSOSITE,.06)_" ",1:"")_"REFILL TOTALS",XMTEXT="XMT("
 S XMT(1,0)="Refills Processed: "_RFY,XMT(2,0)="Refills 'Not Processed': "_NRF
 S XMT(3,0)=" ",XMT(4,0)="Renewals sent to provider: "_TOTREN
 S XMT(5,0)="Renewals not sent to provider: "_TOTF
 D ^XMD
 I $D(^TMP($J)) K XMY N XMDUZ,XMSUB,XMTEXT D
 . S XMY(DUZ)=""
 . I $D(^TMP($J,"ORAREN E")) S XMDUZ="AUTO,RENEWAL",XMY("G.AUTORENEWAL")="",XMSUB=$S($G(VEXANS2)["S":$$GET1^DIQ(59,PSOSITE,.06)_" ",1:"")_"RENEWAL REQUESTS NOT SENT TO PROVIDERS",XMTEXT="^TMP("_$J_",""ORAREN E""," D ^XMD
 . I $D(^TMP($J,"ORAREN OC")) S XMDUZ="AUTO,RENEWAL",XMY("G.AUTORENEWAL")="",XMSUB=$S($G(VEXANS2)["S":$$GET1^DIQ(59,PSOSITE,.06)_" ",1:"")_"RENEWAL REQUESTS WITH ORDER CHECKS",XMTEXT="^TMP("_$J_",""ORAREN OC""," D ^XMD
 K CNT1,GCNT,MAFBFD,ORDP,ORDPDN,HACT,NDINACT,DINACT,MMDAT,NDISDT,DISDT      ; PVMAC/BFD 7-9-04 kill variables used for mail message AUDIORENEWAL, 8-29-04 Add order ktr
 K MAFBKT,FBKTRDN,FBKTR,PTERMDN,PTERM,NPCPDN,NPCP,UNSKTR,INFPKTR,INFPDNKTR,NRF,RFY,MMCONT,PCONT,NRFLG ; PVMAC/BFD 8-26-04 variables used for mail message AUDIOCRMGR
 K HACTDN,NPCPADN,NPCPA,VEX648,VEXREN
 I $P($G(^PS(59,+$G(PSOSITE),"I")),"^"),DT>$P($G(^("I")),"^") D FINAL^PSOLSET W !!,"Your Outpatient Site parameters have been deleted because you selected an",!,"inactive Outpatient Site!",!
 ;VMP OIFO BAY PINES;PSO*7*197
 K DIR,PSOBBC,PSOBBC1,PSOVIN,PSOISITE,PSOVEXFL,PSOVXLP,PSOVEX,PSOVX,PSOVEXI,VEXANS,VEXANS2,VEXPTRX,VEXXFLAG,VEXPSORX,X,Y,PSORX
 Q
VEXALT ;Menu action entry point to alert user
 S VEXCNT=0,VEXPTRN=""
 I '$G(PSOINST) S PSOINST="000" I $D(^DD("SITE",1)) S PSOINST=^(1)
 G:'$D(^VEXHRX(19080,PSOINST)) VEXEND
 F  S VEXPTRN=$O(^VEXHRX(19080,PSOINST,VEXPTRN)) Q:VEXPTRN=""  D
 .I ^VEXHRX(19080,PSOINST,VEXPTRN)="" S VEXCNT=VEXCNT+1
 W:VEXCNT !!,$C(7),VEXCNT_" Telephone Refills To Process"
VEXEND K VEXCNT,VEXPTRN
 Q
ULK ;
 I '$G(VEXPSORX) Q
 D PSOUL^PSSLOCK(VEXPSORX)
 K VEXPSORX
 Q
 ; -----------------------------------------------------------------------------------
RENEWCHK ; Checks ^VEXHRX node for renewal information
 ; Renewal check
 ; @1
 ;PVMAC/BFD 2/04  Add RENFLG (used in later chk of global)
 ;PVMAC/BFD 6-25-04  Add 'pass' of provider parameter & generic user DUZ
 ;PVMAC/BFD 7-9-04 Add changes so can send mail message to renewal mail group
 ;PVMAC/BFD 8-10-04 Remove REN set because changing to 0 every time through
 ;PVMAC/BFD 8-27-04 Set REN because that determines if set DT  (now use CNT1 for mm)
 ;PVMAC/BFD 9-10-04 Adjust CNT1 ktr for either 0 or 1 result so can send mm from APUVEX
 S RENFLG=0
 S RENEW=$P(^VEXHRX(19080,PSOINST,VEXPTRX),"^",5),PROVP=$P(^VEXHRX(19080,PSOINST,VEXPTRX),"^",8),USR=$P(^VEXHRX(19080,PSOINST,VEXPTRX),"^",7)
 ; @2
 I RENEW="U"!(RENEW="I")!(RENEW="N") D
 . N RESULT
 . S RXNUM=+$P(VEXPTRX,"-",2),PATIEN=+$P(VEXPTRX,"-")
 . D RENEW^ORAREN(.RESULT,PATIEN,RXNUM,PROVP,RENEW)
 . S RENFLG=1
 . S $P(^VEXHRX(19080,PSOINST,VEXPTRX),"^")=DT
 . S $P(^VEXHRX(19080,PSOINST,VEXPTRX),"^",6)=RESULT
 . I RESULT=0 S CNT1=CNT1+1
 . I RESULT=1 S CNT1=CNT1+1,TOTREN=TOTREN+1
 . I RESULT'=1 S TOTF=TOTF+1
 . Q
 Q
BFDRNCHK ; 648/BFD 4-27-06 There is data in global - is it date or renewal request
 ; Troubleshooting - put this on next line after =1
 ; W !,"there is no ^ in VEXREN "_VEXREN_" so must just be a date.  Set Vex648 to 0"
 I VEXREN'["^" S VEX648=1
 ; Troubleshooting - put on next line after =1
 ; W !,"VEXREN is "_VEXREN_" this check is for something in piece 1 of ] and sets VEX648=1"
 I VEXREN["^" I $P(VEXREN,"^",1)]"" S VEX648=1
 ; Troubleshooting - put on next line after =0
 ; W !,"VEXREN is "_VEXREN_" this check is for nothing in piece 1 of '] and set VEX648 to 0"
 I VEXREN["^" I $P(VEXREN,"^",1)']"" S VEX648=0
 ;W !,"in BFDRNCHK and set VEX648 = "_VEX648
 ;W !,"if vex648 is 0 then no date but renewal"
 Q
