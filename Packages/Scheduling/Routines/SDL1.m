SDL1 ;BSN/GRR,ALB/LDB - PRE-APPOINTMENT LETTERS ; 7/7/04 10:45am
 ;;5.3;Scheduling;**106,330,340,407,398**;Aug 13, 1993
 ;
 ;******************MODIFICATIONS***********************************
 ;
 ;  DATE        PATCH       DEVELOPER    DESCRIPTION
 ;  ----        -----       ---------    -----------
 ;  12/12/2003  SD*5.3*330  JOHN LUNDEN  FIX FORM FEED LOGIC
 ;
 ;******************************************************************
 ;
 U IO N SDBAD K ^UTILITY($J) S SDLT1=SDLET G:"Pp"'[S1 BC
 I $D(VAUTN) D
 .F C=0:0 S C=$O(VAUTN(C)) Q:'C  S DFN=C D
 ..D BAD Q:SDBAD  D DATE
 D LST Q
DATE F D=SDBD:0 S D=$O(^DPT(C,"S",D)) Q:'D!(D>(SDED+.9999))  I $D(^(D,0)),$P(^(0),"^",2)'["C",$S('$D(^DPT(C,.35)):1,$P(^(.35),"^",1)']"":1,1:0) S A1=C,B1=D,D1=+^DPT(C,"S",D,0) D SET
 Q
APP F J=0:0 S J=$O(^UTILITY($J,L,A,J)) Q:'J  S SDX=J,SDC=^(J),S=^DPT(+A,"S",J,0) D WRAPP^SDLT
 D REST^SDLT Q
BC S U="^" I $D(VAUTC),'VAUTC D CL G LST
ALCL F C=0:0 S C=$O(^SC(C)) Q:'C  I '$D(SDVAUTC(C)),$P(^SC(C,0),U,3)="C",$S('$D(^("I")):1,'+^("I"):1,+^("I")<SDBD&('$P(^("I"),U,2)):0,+^("I")<SDBD&($P(^("I"),U,2)>SDED):0,1:1) D NCHECK I $T D D D:$D(SDD) OVER
LST N SDFIRST S SDFIRST=1       ;SD*5.3*330. Flag to determine first pag
 F L=0:0 S L=$O(^UTILITY($J,L)) Q:'L  D
 .F A=0:0 S A=$O(^UTILITY($J,L,A)) Q:'A  D
 ..S DFN=A D BAD Q:SDBAD
 ..S SDLET=L D ^SDLT,APP
 D NO,END,CLOSE^DGUTQ Q
CL F C=0:0 S C=$O(VAUTC(C)) Q:'C  S:'SDLT1 SDLET=0 D OVER
 Q
OVER Q:'$D(^SC(C,"S"))
 F SDT=SDBD:0 S SDT=$O(^SC(C,"S",SDT)) Q:'SDT!(SDT>(SDED+.9999))  D
 .F K=0:0 S K=$O(^SC(C,"S",SDT,1,K)) Q:'K  D
 ..S DFN=+^(K,0)
 ..I $P(^(0),"^",9)'["C" D BAD Q:SDBAD  D CHECK
 Q
END W ! K %,%H,%I,%Y,%DT,%IS,%ZIS,A,B,C,D,DN,CLIN,CNN,DATE,DATEND,DFN,DIC,DIV,DOW,GDATE,SDHX,I,J,J1,K,L,L0,PDAT,S,S1,SC,SDADD,SDFORM,SDT,SDXX,TIME,X,Y,Z,Z0,Z5 Q
CHECK I $S('$D(^DPT(DFN,.35)):1,$P(^(.35),"^",1)']"":1,1:0),$D(^DPT(DFN,"S",SDT,0)),$P(^(0),"^",2)'["C",'$D(^DPT(DFN,.1)) S A1=DFN,B1=SDT,D1=C D SET
 Q
SET I $D(^SC(D1,"LTR"))!(SDLT1) S:'SDLT1 SDLET=$P(^SC(D1,"LTR"),"^",2) I SDLET S ^UTILITY($J,SDLET,A1,B1)=D1 S:'SDLT1 SDLET=0 K A,A1,B1,D1 Q
 I 'SDLET S ^UTILITY($J,"C",A1,D1)="" K A,A1,B1,D1 Q
 Q
NO I $D(VAUTN),'$O(^UTILITY($J,0)),'$D(^UTILITY($J,"C")) D
 .I SDBAD Q  ;W !,"THIS PATIENT(S) HAS THE BAD ADDRESS INDICATOR SET AND PRE-APPOINTMENT LETTER(S) WILL NOT PRINT." Q
 .W !,"NO ACTIVE APPOINTMENTS FOR THE PATIENT(S) DURING THAT TIME PERIOD!",*7
 I $D(^UTILITY($J,"C")) W @IOF F X=0:0 S X=$O(^UTILITY($J,"C",X)) Q:'X  W !!,$P(^DPT(X,0),"^")," ",$P(^(0),"^",9)," HAS FUTURE APPTS., but" D NOCL
 I $D(^TMP($J,"BADADD")) D BADADD^SDLT K ^TMP($J,"BADADD")
 Q
NOCL F XX=0:0 S XX=$O(^UTILITY($J,"C",X,XX)) Q:'XX  W !,$P(^SC(XX,0),"^")," Clinic is not assigned a PRE-APPOINTMENT LETTER"
 Q
D K SDD I ($P(^SC(C,0),"^",15)=SDV1)!(SDV1=$O(^DG(40.8,0))&($P(^SC(C,0),"^",15)="")) S SDD=1
 Q
NCHECK ;
 N NOC S NOC=$P($G(^SC(C,0)),U,17)
 I SDCONC="B" Q
 I SDCONC="C"&(NOC="N") Q
 I SDCONC="N"&(NOC="Y") Q
 Q
BAD S SDBAD=$$BADADR^DGUTL3(+DFN)
 S:SDBAD ^TMP($J,"BADADD",$P(^DPT(+DFN,0),"^"),+DFN)=""
 Q
