FBAARJP ;AISC/GRR - PRINT REJECTS PENDING ACTION ;4/17/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; ask batch status to report
 S DIR(0)="S^1:CENTRAL FEE ACCEPTED;2:VOUCHERED;3:BOTH"
 S DIR("A")="Select batch status to report"
 S DIR("B")="BOTH"
 D ^DIR K DIR Q:$D(DIRUT)
 S FBSTATL=$S(Y=1:"^F^",Y=2:"^V^",1:"^F^V^")
 S VAR="FBSTATL",VAL="",PGM="START^FBAARJP"
 D ZIS^FBAAUTL G:FBPOP END
START U IO W:$E(IOST,1,2)="C-" @IOF K QQ,B S (Q,UL)="",$P(Q,"=",80)="=",$P(UL,"-",80)="-",(FBAAOUT,CNT,FBINTOT)=0
 D MED:$D(^FBAAC("AH")) G END:FBAAOUT D TRAV:$D(^FBAAC("AG")) G END:FBAAOUT D PHARM:$D(^FBAA(162.1,"AF")) G END:FBAAOUT D CHNH:$D(^FBAAI("AH")) G END:FBAAOUT
 I 'CNT W !!,*7,"No Rejects Pending!"
END K FBTYPE,FBVDUZ,FBVD,FBPV,CNT,D,I,PGM,Q,UL,VAL,VAR,Y,Z,A1,A2,A3,B,FBAACPT,FBIN,FBNUM,FBRR,FBINTOT,CPTDESC,FBAAOUT,FBVP,J,K,T,X,L,M,N,S,V,VID,XY,ZS,POP,A,B2,FBINOLD
 K FBAC,FBAP,FBDX,FBK,FBL,FBPDT,FBPROC,FBSC,FBTD,FBFD,FBSTATL
 D CLOSE^FBAAUTL Q
MED F B=0:0 S B=$O(^FBAAC("AH",B)) Q:B'>0!(FBAAOUT)  I $D(^FBAA(161.7,B,0)),FBSTATL[(U_^("ST")_U) S B(0)=^(0),FBTYPE=$P(B(0),"^",3),FBNUM=$P(B(0),"^",1),FBVD=$P(B(0),"^",12),FBVDUZ=$P(B(0),"^",16) D MORE
 Q
MORE D HED,HED^FBAACCB,HEDB
 F J=0:0 S J=$O(^FBAAC("AH",B,J)) Q:J'>0!(FBAAOUT)  F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0!(FBAAOUT)  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0!(FBAAOUT)  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0!(FBAAOUT)  D SET^FBAACCB,WRITM
 Q:FBAAOUT  W !,UL,! D ASKH^FBAACCB0:$E(IOST,1,2)["C-"&('$G(FBNNP)) Q:FBAAOUT  W:'$G(FBNNP) @IOF
 Q
HEDB W !,"Batch Number: ",FBNUM,?21,"Voucher Date: ",$$DATX^FBAAUTL(FBVD),?44,"Voucherer: ",$S(FBVDUZ="":"",$D(^VA(200,FBVDUZ,0)):$P(^(0),"^",1),1:"Unknown"),!
 Q
WRITM Q:FBAAOUT  S CNT=CNT+1
 N FBL,FBTXT
 D REJTXT(162.03,M_","_L_","_K_","_J_",",.FBTXT)
 S FBL=0 F  S FBL=$O(FBTXT(FBL)) Q:'FBL  D
 . I $Y+3>IOSL D ASKH^FBAACCB0:$E(IOST,1,2)["C-" Q:FBAAOUT  W @IOF D HED^FBAACCB
 . W !,FBTXT(FBL)
 Q
TRAV F B=0:0 S B=$O(^FBAAC("AG",B)) Q:B'>0!(FBAAOUT)  I $D(^FBAA(161.7,B,0)),FBSTATL[(U_^("ST")_U) S B(0)=^(0),FBTYPE=$P(B(0),"^",3),FBNUM=$P(B(0),"^",1),FBVD=$P(B(0),"^",12),FBVDUZ=$P(B(0),"^",16) D TMORE
 Q
TMORE D HED,HEDP^FBAACCB0,HEDB
 F J=0:0 S J=$O(^FBAAC("AG",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AG",B,J,K)) Q:K'>0  S Y(0)=^FBAAC(J,3,K,0) D SETT^FBAACCB0,WRITT
 Q:FBAAOUT  W !,UL,! D ASKH^FBAACCB0:$E(IOST,1,2)["C-"&('$G(FBNNP)) Q:FBAAOUT  W:'$G(FBNNP) @IOF
 Q
WRITT S CNT=CNT+1
 N FBL,FBTXT
 D REJTXT(162.04,K_","_J_",",.FBTXT)
 S FBL=0 F  S FBL=$O(FBTXT(FBL)) Q:'FBL  D
 . I $Y+3>IOSL D ASKH^FBAACCB0:$E(IOST,1,2)["C-" Q:FBAAOUT  W @IOF D HEDP^FBAACCB0
 . W !,FBTXT(FBL)
 Q
PHARM F B=0:0 S B=$O(^FBAA(162.1,"AF",B)) Q:B'>0!(FBAAOUT)  I $D(^FBAA(161.7,B,0)),FBSTATL[(U_^("ST")_U) S B(0)=^(0),FBTYPE=$P(B(0),"^",3),FBNUM=$P(B(0),"^",1),FBVD=$P(B(0),"^",12),FBVDUZ=$P(B(0),"^",16) D PMORE
 Q
PMORE D HED,HED^FBAACCB,HEDB
 F A=0:0 S A=$O(^FBAA(162.1,"AF",B,A)) Q:A'>0!(FBAAOUT)  S FBIN=A D SETV^FBAACCB0 F B2=0:0 S B2=$O(^FBAA(162.1,"AF",B,A,B2)) Q:B2'>0!(FBAAOUT)  I $D(^FBAA(162.1,A,"RX",B2,0)) S Z(0)=^(0) D MORE^FBAACCB1,WRITP
 Q:FBAAOUT  W !,UL,! D ASKH^FBAACCB0:$E(IOST,1,2)="C-"&('$G(FBNNP)) Q:FBAAOUT  W:'$G(FBNNP) @IOF
 Q
WRITP S CNT=CNT+1
 N FBL,FBTXT
 D REJTXT(162.11,B2_","_A_",",.FBTXT)
 S FBL=0 F  S FBL=$O(FBTXT(FBL)) Q:'FBL  D
 . I $Y+3>IOSL D ASKH^FBAACCB0:$E(IOST,1,2)["C-" Q:FBAAOUT  W @IOF D HED^FBAACCB
 . W !,FBTXT(FBL)
 Q
CHNH F B=0:0 S B=$O(^FBAAI("AH",B)) Q:B'>0!(FBAAOUT)  I $D(^FBAA(161.7,B,0)),FBSTATL[(U_^("ST")_U) S B(0)=^(0),FBTYPE=$P(B(0),"^",3),FBNUM=$P(B(0),"^",1),FBVD=$P(B(0),"^",12),FBVDUZ=$P(B(0),"^",16) D CMORE
 Q
CMORE D HED,HEDC^FBAACCB1,HEDB
 F I=0:0 S I=$O(^FBAAI("AH",B,I)) Q:I'>0!(FBAAOUT)  I $D(^FBAAI(I,0)) S Z(0)=^(0) D CMORE^FBAACCB1,WRITC
 Q:FBAAOUT  W !,UL,! D ASKH^FBAACCB0:$E(IOST,1,2)="C-"&('$G(FBNNP)) Q:FBAAOUT  W:'$G(FBNNP) @IOF
 Q
WRITC Q:FBAAOUT  S CNT=CNT+1
 N FBL,FBTXT
 D REJTXT(162.5,I_",",.FBTXT)
 S FBL=0 F  S FBL=$O(FBTXT(FBL)) Q:'FBL  D
 . I $Y+3>IOSL D ASKH^FBAACCB0:$E(IOST,1,2)["C-" Q:FBAAOUT  W @IOF D HEDC^FBAACCB1
 . W !,FBTXT(FBL)
 Q
 ;
HED ;write header for report if sent to printer
 Q:$E(IOST,1,2)="C-"
 W !?31,"REJECTS PENDING ACTION",!?30,$E(Q,1,24),!
 Q
 ;
REJTXT(FBFILE,FBIENS,FBTXT) ; get reject text for line item
 ; input
 ;   FBFILE - (required) Sub-File (162.03, 162.04, 162.1, or 162.5)
 ;   FBIENS - (required) IENS of line item, FileMan DBS format
 ;   FBTXT  - array passed by reference, will be initialzed
 ; output
 ;   FBTXT  - array of text with format
 ;            FBTXT(0)=count of lines
 ;            FBTXT(#)=line of text
 ;             where # is sequential number starting at 1
 ;
 N FBC,FBD,FBFIELDS,FBLST,FBRIENS
 K FBTXT
 S (FBC,FBTXT(0))=0
 ; check inputs
 Q:"^162.03^162.04^162.11^162.5^"'[("^"_$G(FBFILE)_"^")
 Q:$G(FBIENS)=""
 ;
 ; determine field numbers based on file
 ; FBFIELDS will contain the numbers of the following fields/sub-file
 ;   piece 1 = batch number
 ;   piece 2 = amount paid
 ;   piece 3 = reject status
 ;   piece 4 = reject reason
 ;   piece 5 = old batch number
 ;   piece 6 = interface reject
 ;   piece 7 = reject code
 ;   piece 8 = reject code sub-file number
 I FBFILE="162.03" S FBFIELDS="7^2^19^20^21^21.3^21.6^162.031"
 I FBFILE="162.04" S FBFIELDS="1^2^4^5^6^6.3^6.6^162.041"
 I FBFILE="162.11" S FBFIELDS="13^6.5^17^18^19^19.3^19.6^162.111"
 I FBFILE="162.5" S FBFIELDS="20^8^13^14^15^15.3^15.6^162.515"
 ;
 S FBD(5)=$$GET1^DIQ(FBFILE,FBIENS,$P(FBFIELDS,"^",5)) ; old batch
 Q:FBD(5)=""  ; line is not rejected
 S FBD(6)=$$GET1^DIQ(FBFILE,FBIENS,$P(FBFIELDS,"^",6),"I") ; inter. rej.
 ;
 ; 1st line
 S FBC=FBC+1
 S FBTXT(FBC)=$$LJ^XLFSTR($S(FBD(6):"Central Fee",1:"Local")_" Reject",20)_"Old Batch #: "_FBD(5)
 ;
 ; line for reject reason (if any)
 S FBD(4)=$$GET1^DIQ(FBFILE,FBIENS,$P(FBFIELDS,"^",4)) ; reject reason
 I FBD(4)]"" S FBC=FBC+1,FBTXT(FBC)="Reject Reason: "_FBD(4)
 ;
 ; lines for reject codes (if any)
 ; get list of entries in REJECT CODE multiple
 D GETS^DIQ(FBFILE,FBIENS,$P(FBFIELDS,"^",7)_"*","","FBLST")
 ;
 ; loop thru REJECT CODE entries
 S FBRIENS=""
 F  S FBRIENS=$O(FBLST($P(FBFIELDS,"^",8),FBRIENS)) Q:FBRIENS=""  D
 . N FBARR,FBRC,FBLI
 . S FBRC=FBLST($P(FBFIELDS,"^",8),FBRIENS,.01) ; REJECT CODE
 . Q:FBRC=""
 . ; get description of code from file 161.99
 . D RCDES(FBRC,,.FBARR)
 . ;
 . ; add code and first line of description to output array
 . S FBC=FBC+1
 . S FBTXT(FBC)=$$LJ^XLFSTR("Rej Code: "_FBRC,16)
 . I $D(FBARR(1,0)) S FBTXT(FBC)=FBTXT(FBC)_FBARR(1,0)
 . ;
 . ; loop thru remaining description lines
 . S FBLI=1 F  S FBLI=$O(FBARR(FBLI)) Q:'FBLI  D
 . . Q:'$D(FBARR(FBLI,0))
 . . ; add description line to output array
 . . S FBC=FBC+1
 . . S FBTXT(FBC)="                "_FBARR(FBLI,0)
 ;
 S FBTXT(0)=FBC
 Q
 ;
RCDES(FBRC,FBRM,FBARR) ; Reject Code Description
 ; input
 ;   FBRC  - reject code external value
 ;   FBRM  - (optional) right margin, default 60
 ;   FBARR - array, passed by reference, not FBWP, will be initialized
 ; output
 ;   FBARR - array contained formatted description
 ;           where
 ;             FBARR(0)=line count
 ;             FBARR(1,0)=1st line of description
 ;             FBARR(2,0)=2nd line of description
 ;
 ; note: some variables newed because DIWP call is stepping on I
 N A,B,DIWL,DIWR,DIWF,FBI,FBRCI,FBWP,FBX,I,J,K,L,M
 ;
 S FBRM=$G(FBRM,60)
 K FBARR
 Q:$G(FBRC)=""
 ;
 ; find IEN of code
 S FBRCI=$$FIND1^DIC(161.99,,"X",FBRC)
 ;
 ; if entry found then load description from file
 S:FBRCI FBX=$$GET1^DIQ(161.99,FBRCI_",",1,"","FBWP")
 ; if entry not found use default description
 S:'FBRCI FBWP(1)="Reject reason code is not currently defined in list."
 ;
 ; reformat description
 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=FBRM,DIWF=""
 S FBI=0 F  S FBI=$O(FBWP(FBI)) Q:'FBI  S X=FBWP(FBI) D ^DIWP
 ;
 ; move description into output array
 M FBARR=^UTILITY($J,"W",DIWL)
 ;
 K ^UTILITY($J,"W")
 Q
