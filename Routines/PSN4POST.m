PSN4POST ;BIR/DMA-post install routine to convert data in file 50 ;23 Jul 98 / 1:27 PM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 ;
 N ROOT,ROOT1,DA,I,J,K,X,Y,A1,A2,B,IN,IN1,LINE
 S ROOT=$NA(@XPDGREF@("LINE")),ROOT1=$NA(@XPDGREF@("CONV")),I=1
 F J=1:1 Q:'$D(@ROOT@(J))  S LINE=^(J) F I=1:1:$L(LINE,"|")-1 S X=$P(LINE,"|",I),@ROOT1@($P(X,"^"),$P(X,"^",2))=$P(X,"^",3)
 S DA=+$P($G(^PS(59.7,1,10)),"^",4) F  S DA=$O(^PSDRUG(DA)) Q:'DA  S X=$G(^(DA,"ND")),A=+X,B=+$P(X,"^",3) I A,B D
 .I $D(@ROOT1@(A,B)) S X=^(B),$P(^PSDRUG(DA,"ND"),"^",3)=X
 .E  S $P(^PSDRUG(DA,"ND"),"^",1,5)="^^^^",X=$P(^("ND"),"^",10),$P(^("ND"),"^",10)="" I X]"" K ^PSDRUG("AQ1",X,DA)
 .S $P(^PS(59.7,1,10),"^",4)=DA
 I $P(^PS(59.7,1,10),"^")'="4.0" S ^PS(50.606,245,0)="AEROSOL,VAG",DIK="^PS(50.606,",DA=245 D IX^DIK
 I $P(^PS(59.7,1,10),"^")'="4.0" S ^PS(50.606,246,0)="CAP/INJ",DIK="^PS(50.606,",DA=246 D IX^DIK
 I $P(^PS(59.7,1,10),"^")'="4.0" S NUM=$O(^PS(51.2," "),-1),NUM=NUM+1,^PS(51.2,NUM,0)="ORAL/SUBCUTANEOUS^^PO SC",DIK="^PS(51.2,",DA=NUM D IX^DIK
 I $P(^PS(59.7,1,10),"^")'="4.0" S NUM=$O(^PS(51.2," "),-1),NUM=NUM+1,^PS(51.2,NUM,0)="INTRAPLEURAL",DIK="^PS(51.2,",DA=NUM D IX^DIK
 S $P(^PS(59.7,1,10),"^",5)=1
 S $P(^PS(59.7,1,10),"^",1)="4.0"
 ;
 ;LOAD AND INDEX NATIONAL INTERACTIONS
 S ROOT=$NA(@XPDGREF@("INTER")),DA=0
 F   S DA=$O(@ROOT@(DA)) Q:'DA  S X=^(DA),^PS(56,DA,0)=X,^PS(56,"B",$E($P(X,"^"),1,30),DA)="",^PS(56,"C",$P(X,"/"),DA)="",^PS(56,"C",$P($P(X,"^"),"/",2),DA)="",A=$P(X,"^",2),B=$P(X,"^",3),^PS(56,"AE",A,B,DA)="",^PS(56,"AE",B,A,DA)=""
 ;NOW TRY TO UPDATE SEVERITIES
 S ROOT=$NA(@XPDGREF@("OLD")),J=0
 F  S J=$O(@ROOT@(J)) Q:'J  S X=^(J),DA=$O(^PS(56,"AE",$P(X,"^",2),$P(X,"^",3),0)) I DA S Y=^PS(56,DA,0) I $P(Y,"^",4)=2,$P(X,"^",4)=1 S $P(^(0),"^",4)=1,^("L")=1
 ;NOW LOAD AND INDEX LOCAL INTERACTIONS
 S ROOT=$NA(@XPDGREF@("LOCAL"))
 F DA=1:1 Q:'$D(@ROOT@(DA))  S X=^(DA),A=$P(X,"^",2),B=$P(X,"^",3),IN1=$O(^PS(56,"AE",A,B,0)) D
 .I 'IN1 S IN=$O(^PS(56," "),-1)+1 S:IN<15000 IN=15000 S ^PS(56,IN,0)=X,^("L")=1,^PS(56,"B",$E($P(X,"^"),1,30),IN)="",A1=$P($P(X,"^"),"/"),A2=$P($P(X,"^"),"/",2) S:A1]"" ^PS(56,"C",A1,IN)="" S:A2]"" ^PS(56,"C",A2,IN)="" D
 ..S ^PS(56,"AE",A,B,IN)="",^PS(56,"AE",B,A,IN)=""
 .I IN1,$P(^PS(56,IN1,0),"^",4)=2,$P(X,"^",4)=1 S $P(^PS(56,IN1,0),"^",4)=1,^("L")=1
 ;
 ;REINDEX "APD"
 S DA=0 F  S DA=$O(^PS(56,DA)) Q:'DA  D ^PSNDDI1
 ;NOW HOUSEKEEPING
 S LAST=$O(^PS(56," "),-1),DA=0 F I=0:1 S DA=$O(^PS(56,DA)) Q:'DA
 S $P(^PS(56,0),"^",3,4)=LAST_"^"_I
 ;
ALERG ;NOW REDO ALLERGIES - SEE DBIA 2545
 N IEN,VPT
 S IEN=0 F  S IEN=$O(^GMR(120.8,IEN)) Q:'IEN  S VPT=$P($G(^(IEN,0)),"^",3) I VPT["PSNDF" S $P(^(0),"^",3)=+VPT_";PSNDF(50.6,"
 ;
 Q
