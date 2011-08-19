DVBHT1 ;ISC-ALBANY/PKE/PHH - HINQ alert parser ; 3/23/06 8:04am
 ;;4.0;HINQ;**12,15,20,43,49,57**;03/25/92
 ;
 ;  cn  foldloc   sc diag   comb%   chk   a&a     hb  pension disablity
 ; .313,.312/.314,.3731/2.05,.302,.36295,.36205,.36215,.36235,.3025
 Q
 ;S DVBDATAT(+Y)="",DVBDATA=DVBDATA_"^"_Y
MSG S DVBDATA(+Y)="",DVBDATA=$S($L(DVBDATA)>100:DVBDATA,$P(DVBDATA,"^",16):DVBDATA,1:DVBDATA_"^"_Y) Q
 ;
 ;check on return from HINQUP processing
ACHK S DVBNOALR=""
 ;called from batch or direct
EN Q:'$D(DFN)  Q:'DFN
 N X,Y,I,M,N,P
 S DVBDATA="^^^^^^^^^"
EDT ; DX,DIQ,AA,ENTIT,COMB,CN,FOLD,CHECK
 ;
 D DX,DIQ,AA,ENTIT,COMB,CN,FOLD,CHECK
 I DVBDATA'="^^^^^^^^^" DO
 .I '$D(DVBNOALR) D ALERT^DVBHT Q
 .S (I,Y)=0 F  S Y=$O(DVBDATA(Y)) Q:'Y  DO
 ..S $P(DVBDATA,"^",I+1)=Y,I=I+1
 .K DVBNOALR
 K DVBENT,DVBSCONN
 Q
 ;
DX Q:'$D(DVBDX)  Q:'$D(DVBDXNO)
 S (DVBDXNO,I)=0 F  S I=$O(DVBDX(I)) Q:I=""  S DVBDXNO=DVBDXNO+1
 K M F I=1:1:DVBDXNO D
 .S M(I)=$P(DVBDX(I),U,2,3)
 .I M(I)["X0" S $P(M(I),U,2)="100"
 .S $P(M(I),U,2)=+$P(M(I),U,2)
 .S $P(M(I),U,3)=1
 .I $P(DVBDX(I),U,4)]"" S $P(M(I),U,4)=$P(DVBDX(I),U,4)
 .I $P(DVBDX(I),U,5)]"" S $P(M(I),U,5)=$$HL7TFM^XLFDT($E($P(DVBDX(I),U,5),5,8)_$E($P(DVBDX(I),U,5),1,4))
 .I $P(DVBDX(I),U,6)]"" S $P(M(I),U,6)=$$HL7TFM^XLFDT($E($P(DVBDX(I),U,6),5,8)_$E($P(DVBDX(I),U,6),1,4))
 .I '$D(DVBSCONN) S DVBSCONN=$P(M(I),"^",2) Q
 .I DVBSCONN<$P(M(I),U,2) S DVBSCONN=$P(M(I),U,2)
 S (N,P)=0
 F  S N=$O(^DPT(DFN,.372,N)) Q:'N  I $D(^(N,0)) DO
 .S M=0
 .F  S M=$O(M(M)) Q:'M  I M(M)=^(0) K M(M) Q  ;tag dx+6
 .I M Q  ;sc match
 .I $P(^(0),U,3) S P=P+1 ;  tag dx+6,naked ref to ^dpt(dfn,.372,n,0)
 I P S Y="3-SC Disabilities" D VER
 I $D(M)>9 S Y="3+SC Disabilities" D VER
 K I,M,N,P Q
 ;
VER ;with DVB*4*49 no BIRLS only records & Dx, Verified not sent
 D MSG Q
 ;
DIQ ;K DVBDIQ(2)
 F LP2=.361,.302,.3025,.312,.313,.314,.36205,.36215,.36235,.36295 S X="DVBDIQ(2,"_DFN_","_LP2_")" K @X
 S DR=".302;.3025;.312;.313;.314;.361;.36205;.36215;.36235;.36295"
DIQDR S DIC="^DPT(",DA=DFN,DIQ(0)="E",DIQ="DVBDIQ(" D EN^DIQ1 Q
 ;
 ; I V=0 HBa/oA&A term    V=1 Hospitlize pay HB, A&A entitled
 ; I V=2 A&A    V=3 HB    V=" " HB a/o A&A not granted
AA I $D(DVBAAHB) S V1=DVBAAHB S V=V1 S:V1>3&(V1<8) V=V1-4
 I '$D(DVBAAHB) S V=9
 I $D(DVBBAS(1)),$P(DVBBAS(1),"^",6)="E" S V=0 ;terminated pending purge
 I DVBDIQ(2,DFN,.36205,"E")="YES","0 9"[V S Y="5-A&A" D MSG
 I DVBDIQ(2,DFN,.36205,"E")'="YES","12"[V S Y="5+A&A" D MSG
 ;
 I DVBDIQ(2,DFN,.36215,"E")="YES","0 9"[V S Y="5-HB" D MSG
 I DVBDIQ(2,DFN,.36215,"E")'="YES","13"[V S Y="5+HB" D MSG
 Q
 ;
 ;compensation, pension
ENTIT S DVBENT=" " I $D(DVBP(1)) S T1=$P(DVBP(1),U,4) D
 . I T1'="" S DVBENT=$S(T1="01":"Compensation",T1="0L":"Pension",1:" ")
 S Y=0
 I DVBDIQ(2,DFN,.36235,"E")="YES" DO
 .;terminated pending purge
 .I $G(DVBCHECK)'>0,$G(DVBDXNO)>0 S DVBENT=" "
 .;all record types now "A", so had to check if no VA Check and has 
 .;SC disabilities instead of checking for type "E" record - DVB*4*49
 .I DVBENT["Pension" Q
 .S Y="5-Pension"
 E  I DVBENT["Pension" S Y="5+Pension"
 I Y D MSG
 ;
 S Y=0
 I DVBDIQ(2,DFN,.3025,"E")="YES" DO
 .I DVBENT["ompensation" Q
 .I DVBENT["Disability" Q
 .S Y="5-Compensation"
 E  I DVBENT'=" " DO
 .I DVBENT["ompensation"!(DVBENT["Disability") S Y="5+Compensation"
 I Y D MSG
 Q
 ;DVBSCONN is biggest SC disability
COMB I '$D(DVBSCONN) S Y=""
 E  DO
 .S Y=DVBSCONN
 .I $D(DVBCAP) Q  ;birls
 .I DVBENT["Pension" Q
 .S Y=$S($D(DVBDXPCT):$S(+DVBDXPCT?1N.N:+DVBDXPCT,1:DVBSCONN))
 .S DVBSCONN=Y
 I +DVBDIQ(2,DFN,.302,"E")=+Y S Y=0
 E  DO
 .S Y=0
 .;c&p
 .I '$D(DVBSCONN)!(DVBENT["ompensation")!(DVBENT["Disability") DO  Q
 . .S Y="5?SC Combined %"
 .;birls,pension
 .I DVBDIQ(2,DFN,.361,"E")["SERVICE CONNECTED",DVBSCONN>49 Q
 .I DVBDIQ(2,DFN,.361,"E")["SC LESS THAN",DVBSCONN<50 Q
 .S Y="5?SC Combined %"
 I Y D MSG
 K DVBALERT,DVBSCONN
 Q
 ;
CN I +DVBDIQ(2,DFN,.313,"E")=$S($D(DVBCN):+DVBCN,1:0)
 E  S Y="2?Claim #" D MSG
 Q
 ;  --check in xman
FOLD Q:'$D(DVBFL)  S Y=0
 I $G(DVBFL)="  " S DVBFL=""
 I '$D(DVBDIQ(2,DFN,.314,"E")) DO
 .I +DVBDIQ(2,DFN,.312,"E")=$S($D(DVBFL):+DVBFL,1:0) Q
 .S Y="2?Folder Location"
 E  DO  ;pims v5.3  y => abc_ro, 323, or ""
 .S Y=$S($D(DVBFL):$S($P(DVBFL,"- ",2)]"":$P(DVBFL,"- ",2),1:DVBFL),1:"")
 .I DVBDIQ(2,DFN,.314,"E")=Y Q
 .S Y="2?Folder Location"
 I Y D MSG
 Q
 ;
CHECK S Y=0
 I $D(DVBDIQ(2,DFN,.36295,"E")) DO  ;pims v5.3
 .I $D(DVBBAS(1)),$L($P(DVBBAS(1),"^",20)) S Y=$P(DVBBAS(1),"^",20)
 .I +DVBDIQ(2,DFN,.36295,"E")=+$S(Y:Y*12,$D(DVBCHECK):DVBCHECK*12,1:"") S Y=0 Q
 .S Y="5?VA Check/Net Award"
 I Y D MSG
 Q
