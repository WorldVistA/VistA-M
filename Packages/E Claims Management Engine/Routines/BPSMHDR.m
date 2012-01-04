BPSMHDR ;BHAM ISC/FCS/DRS - MENUS HEADERS ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; reference to IX^DIC for PACKAGE file (#9.4) supported by DBIA 10048
 ; reference to $$GET1^DIQ for INSTITUTION file (#4) supported by DBIA 10090
 ; reference to $$SITE^VASITE supported by DBIA 10112
 ; reference to ENDR^%ZISS supported by DBIA 10088
 ;
 ; XQY0 from MenuMan in various BPS options
HDR ;EP - Screen header
 N A,BPSMT,BPSPNV,BPSHDR,D,DIC,F,L,N,W,X,Y
 I '$D(IOM) S IOP="" D ^%ZIS
 I '$D(IORVON) S X="IORVON;IORVOFF" D ENDR^%ZISS
 ; PACKAGE file (#9.4) lookup
 S U="^",D="C",DIC="^DIC(9.4,",X="BPS",DIC(0)="" D IX^DIC
 S F=+Y,BPSPNV=$S(F>0:" v"_$$GET1^DIQ(9.4,F,13,1),1:"")
 ;
 S BPSPNV="Electronic Claims Management Engine (ECME)"_BPSPNV
 S A=$P($G(XQY0),U),BPSMT=$S(A="BPSMENU":"Main Menu",A]"":A,1:"BPS option")
 ; W is the width
 S W=51,BPSHDR(1)=$TR($J("",W)," ","*")  ; row of asterisks
 S L=W-2-$L(BPSPNV)\2,X="*"_$J("",L)_BPSPNV,BPSHDR(2)=X_$J("",W-$L(X)-1)_"*"  ; version
 S A=$$LOC,L=W-2-$L(A)\2,X="*"_$J("",L)_A,BPSHDR(3)=X_$J("",W-$L(X)-1)_"*"  ; location
 S L=W-2-$L(BPSMT)\2,X="*"_$J("",L),L=$L(X)+$L(BPSMT)
 S BPSHDR(4)=X_$G(IORVON)_BPSMT_$G(IORVOFF)_$J("",W-L-1)_"*"  ; menu option
 S L=IOM-W\2 W @IOF,!
 F N=1:1:4,1 W !,$J("",L)_BPSHDR(N)  ; repeat 1st line at end
 W !
 Q
 ;
 ;
LOC() ;EP - Return location name from file 4 based on DUZ(2).
 N LOC S LOC=""
 S:$G(DUZ(2)) LOC=$$GET1^DIQ(4,DUZ(2),.01,"E")
 Q $S(LOC]"":LOC,1:$P($$SITE^VASITE,"^",2))  ; DBIA 10112
 ;
