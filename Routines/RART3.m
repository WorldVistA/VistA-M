RART3 ;HISC/GJC,SWM-Reporting Menu (Part 2) ;05/22/09  09:20
 ;;5.0;Radiology/Nuclear Medicine;**8,10,18,27,35,45,75,99**;Mar 16, 1998;Build 5
 ; continue from RART1
 ; last modif by SS for P18
 ; p99 changed the Staff Phys title to Staff Imaging Phys
 ;Supported IA #10103 reference to ^XLFDT
 ;
QRPT ; Queue the report to run
 N X K IOP,%ZIS S %ZIS="Q",%ZIS("B")=""
 S %ZIS("S")="I $E($P($G(^%ZIS(2,+$P($G(^(""SUBTYPE"")),""^""),0)),""^""),1,2)=""P-"""
 W ! D ^%ZIS
 I POP D Q6^RART1 Q
 I $E(IOST,1,2)="P-",('$D(IO("Q"))) D
 . D PRT^RARTR
 . Q
 I $D(IO("Q")) D
 . K RANME,RAPRC,Y S U="^",DT=$S($G(DT)]"":DT,1:$$DT^XLFDT())
 . S ZTDESC="Rad/Nuc Med Abnormal Report Alert",ZTRTN="PRT^RARTR"
 . S:$D(RARTMES) ZTSAVE("RARTMES")=""
 . F I="DT","RARPT","U" S ZTSAVE(I)=""
 . D ^%ZTLOAD W:$D(ZTSK) "   Task # ",ZTSK
 . K IO("Q"),ZTDESC,ZTRTN,ZTSAVE
 . Q
 W ! D ^%ZISC,HOME^%ZIS
 D Q6^RART1,EXIT^RART
 Q
PHYS N RA2ND,R1,R2,RASTR
 S (R1,R2)=0 F  S R2=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",R2)) Q:'R2  S:+$G(^(R2,0)) R1=R1+1,RA2ND("SRR",R1)=+^(0),RA2ND("SRR",R1)=$E($P($G(^VA(200,RA2ND("SRR",R1),0)),"^"),1,20)
 S (R1,R2)=0 F  S R2=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",R2)) Q:'R2  S:+$G(^(R2,0)) R1=R1+1,RA2ND("SSR",R1)=+^(0),RA2ND("SSR",R1)=$E($P($G(^VA(200,RA2ND("SSR",R1),0)),"^"),1,20)
 S R1=$E($P($G(^VA(200,+$P(R3,"^",15),0)),"^"),1,15)
 S RASTR="Staff Imaging Phys: "_R1 S:R1]"" RASTR=RASTR_" (P)"
PHYS1 I '$O(RA2ND("SSR",0)) W !,RASTR G PHYS2
 S R1=0
PHYS11 S R1=$O(RA2ND("SSR",R1)) G:R1="" PHYS19
 I $L(RASTR)+$L(RA2ND("SSR",R1))>79 W !,RASTR,";" S RASTR="   "
 S:RASTR]"   " RASTR=RASTR_"; " S RASTR=RASTR_RA2ND("SSR",R1) G PHYS11
PHYS19 W:RASTR]"" !,RASTR
PHYS2 S R1=$E($P($G(^VA(200,+$P(R3,"^",12),0)),"^"),1,15)
 S RASTR="Residents : "_R1 S:R1]"" RASTR=RASTR_" (P)"
 I '$O(RA2ND("SRR",0)) W !,RASTR Q
 S R1=0
PHYS21 S R1=$O(RA2ND("SRR",R1)) G:R1="" PHYS29
 I $L(RASTR)+$L(RA2ND("SRR",R1))>79 W !,RASTR,";" S RASTR="   "
 S:RASTR]"   " RASTR=RASTR_"; " S RASTR=RASTR_RA2ND("SRR",R1) G PHYS21
PHYS29 W:RASTR]"" !,RASTR
 Q
MODSET ; print modifiers of all cases of print set
 N RACDIS,RALDIS,RACNISAV,RAMEMARR,R1
 D EN2^RAUTL20(.RAMEMARR) Q:'$O(RAMEMARR(0))
 S RACNISAV=RACNI,RACNI=0
 D CDIS^RAPROD S (RAREZON,RACNI)=0
 ;for printsets print the REASON FOR STUDY along with the lead procedure
 ;(avoid duplicate printing of the same data)
 F  S RACNI=$O(RAMEMARR(RACNI)) Q:'RACNI  D  Q:$L($G(X))  I $G(RAXIT) S X="^" Q
 . S R1=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 . D MODS^RAUTL2
 . ; If printing page at a time we need to check the length - RA*5*8
 . I $Y>(IOSL-6),'$D(RARTVERF) S RAP="" D WAIT^RART1 I X="^"!(X="P")!(X="T") Q
 . K X
 . D OUT1 S RAREZON=1
 . S:+$P(R1,"^",28) X=$$RDIO1^RARTUTL1(+$P(R1,"^",28))  Q:$L($G(X))
 . S:+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0)) X=$$PHARM1^RARTUTL(RACNI_","_RADTI_","_RADFN_",")
 . W:$O(RAMEMARR(RACNI)) !
 . Q
 S RACNI=RACNISAV
 W ! K RAREZON
 Q
OUT1 ; print Procedure name, CPT code, Procedure modifier, and CPT Modifiers
 ; $O(RAMEMARR(0)) may be defined, if previously called MODSET^RART3
 ; RALDIS flags long display wanted, comes from certain output options
 ; RACDIS(n) exists if case n is to be displayed
 ; RACDIS(n) not set for dupl proc+pmod+cptmod so don't display
 ; If printset, skip if not long format or case not marked for cond.displ
 I $O(RAMEMARR(0)),'$G(RALDIS),'$D(RACDIS(RACNI)) Q
 N I,J,RACRF S RACRF=1
 N RA18RET S RA18RET=0 ;P18
 S R1=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RASTUDY=$P($G(^RAO(75.1,+$P(R1,U,11),.1)),U) ;Convey 'Reason for Study' P75
 ; Check if cancelled and not part of this report
 I $P(^RA(72,+$P(R1,"^",3),0),"^",3)=0,($P(R1,"^",17)="") Q
 I $P(^RA(72,+$P(R1,"^",3),0),"^",3)=0 D
 .W !,$S($G(RALDIS):"",'$D(RACDIS):"",$G(RACDIS(RACNI))=1:"",1:RACDIS(RACNI)_"x"),?4,$E($P($G(^RAMIS(71,+$P(R1,"^",2),0)),"^"),1,42)_" (cancelled)"
 E  W !,$S($G(RALDIS):"",'$D(RACDIS):"",$G(RACDIS(RACNI))=1:"",1:RACDIS(RACNI)_"x"),?4,$P($G(^RAMIS(71,+$P(R1,"^",2),0)),"^")
 D PRCCPT^RAPROD ;disp proc. abbr, proc type, & CPT
 ;check for contrast media; display if CM data exists (patch 45)
 S RACMDATA=$$CMEDIA^RAUTL8(RADFN,RADTI,RACNI)
 I $L(RACMDATA) D
 .W !?5,"Contrast Media :"
 .F RAIZ=1:1 Q:$P(RACMDATA,", ",RAIZ)=""  D
 ..W ?22,$P(RACMDATA,", ",RAIZ) W:$P(RACMDATA,", ",RAIZ+1)'="" !
 ..I '$D(RARTVERF),$Y>(IOSL-5) S RAXIT=$$EOS^RAUTL5() S:RAXIT RA18RET=-1 Q:RAXIT  W @IOF W !
 ..Q
 .K RAIZ
 .QUIT
 K RACMDATA Q:RA18RET=-1  ;P18
 W:Y'="None" !?5,"Proc Modifiers : ",Y
 W:Y(1)'="None" !?5,"CPT Modifiers  :"
 I Y(1)'="None" S RACRF=0 D
 .F I=1:1 Q:$P(Y(2),", ",I)']""  S J=$P(Y(2),", ",I),J=$$BASICMOD^RACPTMSC(J,DT) W ?22,$P(J,"^",2)," ",$P(J,"^",3) W:$P(Y(2),", ",I+1)]"" ! I '$D(RARTVERF),$Y>(IOSL-5) S RAXIT=$$EOS^RAUTL5() S:RAXIT RA18RET=-1 Q:RAXIT  W @IOF W !
 Q:RA18RET=-1
 I $L(RASTUDY),$G(RAREZON,0)=0 W:RACRF ! S RACRF=0 D DIWP^RAUTL5(5,68,"Reason for Study: "_RASTUDY) ;P75
 K RASTUDY
 ;RATECHCO is defined in OPTION FILE's  ENTRY/EXIT ACTION
 I $D(RATECHCO) W:RACRF ! S RA18RET=$$PUTTCOM^RAUTL11(RADFN,RADTI,RACNI,"     Tech.Comment   : ",22,70,7,0,0,2,0) S:RA18RET=-1 RAXIT=1 Q:RA18RET=-1  ;P18
 Q
