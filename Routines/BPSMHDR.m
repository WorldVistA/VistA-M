BPSMHDR ;BHAM ISC/FCS/DRS - MENUS HEADERS ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; XQSAV,XQY0 passed in from various BPS options
HDR ;EP - Screen header
 N BPSMT,BPSPNV,D,DIC,X,Y
 Q:$G(XQY0)=""
 I $D(XQSAV),XQY0'=XQSAV Q
 I '$D(IORVON) S X="IORVON;IORVOFF" D ENDR^%ZISS
 S D="C",DIC="^DIC(9.4,",X="BPS",DIC(0)="" D IX^DIC
 S BPSPNV=+Y
 I $G(BPSPNV) S BPSPNV="V"_$$GET1^DIQ(9.4,BPSPNV,13,1)
 S BPSPNV="Electronic Claims Management Engine (ECME) "_BPSPNV
 S BPSMT=$S($P(XQY0,U)="BPSMENU":"Main Menu",1:$P(XQY0,U,2))
 N A,D,F,L,N,R
 S F=0
 W !
 S A=$X W IORVON,IORVOFF S D=$X S:D>A F=D-A ;compute length of revvideo
 S L=(80-$L(BPSPNV))\2-1,R=L+$L(BPSPNV)+1
 S D=$L(BPSPNV)+2,N=$L(BPSPNV)-1
 W @IOF,!,$$CTR($$REPEAT^XLFSTR("*",D)),!
 W ?L,"*",$$CTR(BPSPNV,N),?R,"*",!
 W ?L,"*",$$CTR($$LOC(),N),?R,"*",!
 W ?L,"*",?(L+(((R-L)-$L(BPSMT))\2)),IORVON,BPSMT,IORVOFF,?R+F,"*",!
 W $$CTR($$REPEAT^XLFSTR("*",D)),!
 Q
 ;
 ;----------
CTR(X,Y) ;EP - Center X in a field Y wide.
 Q $J("",$S($D(Y):Y,1:IOM)-$L(X)\2)_X
 ;----------
 ;EP
LOC() ;EP - Return location name from file 4 based on DUZ(2).
 N LOC
 I '$G(DUZ(2)) Q "DUZ(2) UNDEFINED OR 0"
 S LOC=$$GET1^DIQ(4,DUZ(2),.01,"E")
 I LOC'="" Q LOC
 Q "UNKNOWN"
