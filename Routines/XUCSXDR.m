XUCSXDR ;SFISC/HVB - Tabular Summary for 486 SITES ;3/21/96  07:58
 ;;7.3;TOOLKIT;**14**;Dec 15, 1995
A Q:'$$CHKF^XUCSUTL
 S U="^" S:'$D(DT) DT=$$HTFM^XLFDT($H,1) S:'$D(DTIME) DTIME=300
 S XUCSEND=0 D A3^XUCSUTL3 I XUCSEND K MAIL G XIT
 S DIR("A")="Mail report",DIR("B")="NO",DIR(0)="Y" D ^DIR Q:$D(DIRUT)
 I Y K XMY S MAIL=2,IOM=80 G DQ
 S %ZIS="Q" D ^%ZIS I POP G XIT
 I $D(IO("Q")) D  G XIT
 . S ZTSAVE("XUCS*")="",ZTRTN="DQ^XUCSXDR",ZTDESC="MPM TABULAR SUMMARY",ZTIO=ION
 . S %DT="AEFRX",%DT("A")="Queue for what DATE/TIME? ",%DT("B")="NOW",%DT(0)="NOW" D ^%DT K %DT
 . I +Y'<0 S ZTDTH=Y D ^%ZTLOAD,HOME^%ZIS
 . K IO("Q")
 U IO W:$E(IOST)="C" ! G DQ
DR ; Daily Report in mail message - noninteractive
 K XMY S MAIL=1,X=0 F  S X=$O(^XUCS(8987.1,1,2,X)) Q:X]"@"!(X="")  S XMY(^(X,0))=""
 G NOT:'$D(XMY) S U="^",DT=$$HTFM^XLFDT($H,1),X1=DT,X2=-1 D C^%DTC S (XUCSBD,XUCSED)=X,XUCSRT="B"
DQ ; Dequeue entry point
 K CD,RT,ST,^TMP($J,"XUCS") S L=1,HDR(1)=" " F I=1:1:75 S HDR(1)=HDR(1)_"="
 S XUCSUN=$S($D(XUCSUN):XUCSUN,1:"000"),NODE=XUCSUN_"@@@"
 F  S NODE=$O(^XUCS(8987.2,"B",NODE)) Q:NODE=""!(XUCSUN&($E(NODE,1,3)'=XUCSUN))  S X=$O(^(NODE,"")) D
 . S FMDT=XUCSBD F  S FMDT=$O(^XUCS(8987.2,"C",FMDT)) Q:FMDT=""  Q:$D(^(FMDT,X))
 . Q:FMDT=""  S Y=$O(^XUCS(8987.2,"C",FMDT,X,0))-1
 . F  S Y=$O(^XUCS(8987.2,X,1,Y)) Q:Y]"@"!(Y="")  S FMDT=^(Y,0) Q:FMDT>(XUCSED+.24)  D:FMDT>XUCSBD&($D(^(5))>1)
 . . I $E($P(FMDT,".",2),1,2)<12,XUCSRT="P" Q
 . . I $E($P(FMDT,".",2),1,2)>11,XUCSRT="A" Q
 . . F I=1:1:17 S $P(RT(NODE),U,I)=$P($G(RT(NODE)),U,I)+$P(^XUCS(8987.2,X,1,Y,5,I,0),U,3)
 . . S X1=0 F  S X1=$O(^XUCS(8987.2,X,1,Y,6,X1)) Q:+X1<1  S X0=^(+X1,0) D
 . . . S $P(CD(NODE),U,5)=$P($G(CD(NODE)),U,5)+1
 . . . F I=1:1:4 S $P(CD(NODE),U,I)=$P(CD(NODE),U,I)+$P(X0,U,I+1)
 . . S $P(ST(NODE),U,21)=$P($G(ST(NODE)),U,21)+$P(FMDT,U,3)
 . . S $P(ST(NODE),U,22)=$P(ST(NODE),U,22)+$P(FMDT,U,5)
 . . F I=1:1:17 S $P(ST(NODE),U,I)=$P(ST(NODE),U,I)+$P(^XUCS(8987.2,X,1,Y,3,1,0),U,I)
P I '$D(RT) W:'$D(ZTQUEUED) " NO DATA between ",$$FMTE^XLFDT(XUCSBD)," and ",$$FMTE^XLFDT(XUCSED)," for ",$P($G(^DIC(4,XUCSUN,0)),U),"!",! K MAIL G XIT
 S Y=XUCSBD D DD^%DT S BD=Y,Y=XUCSED D DD^%DT S ED=Y D ISTR
 S (NODE,OSITE)="" F  S NODE=$O(ST(NODE)) Q:NODE=""  D
 . S SITE=$E(NODE,1,3) I SITE'=OSITE,OSITE]"" D PRINT
 . S (J,SEET,SUM)=0 F M=0.3,1.4,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5,15,25 S J=J+1,CNT=$P(RT(NODE),U,J),SEET=SEET+(CNT*M),SUM=SUM+CNT S:J=2 CUM=SUM
 . S OSITE=SITE,TY=$E(NODE,4,5),X=ST(NODE),CNT=$P(X,U),SET=$P(X,U,21)
 . S STR(1)=STR(1)_$J(NODE,7),Y=$G(CD(NODE)),S=+Y
 . S STR(2)=STR(2)_$S(S:$J($P(Y,U,2)/S*100,7,0),1:"       ")
 . S STR(3)=STR(3)_$S(S:$J($P(Y,U,3)/S*100,7,0),1:"       ")
 . S STR(4)=STR(4)_$S(TY="CS"&SUM:$J(SEET/SUM,7,2),1:"       ")
 . S STR(5)=STR(5)_$S(TY="CS"&SUM:$J(CUM/SUM*100,7,0),1:"       ")
 . S STR(6)=STR(6)_$S(TY="CS"&SUM:$J(SUM/SET,7,1),1:"       ")
 . S STR(7)=STR(7)_$J($P(X,U,22)/CNT,7,0)
 . S STR(8)=STR(8)_$S($P(X,U,13):$J($P(X,U,13)/SET,7,0),1:"       ")
 . S STR(9)=STR(9)_$S($P(X,U,14):$J($P(X,U,14)/SET,7,0),1:"       ")
 . S STR(10)=STR(10)_$J($P(X,U,16)/SET,7,0)
 . S STR(11)=STR(11)_$J($P(X,U,7)/SET,7,0)
 . S STR(12)=STR(12)_$J($P(X,U,5)+$P(X,U,6)/SET,7,0)
 . S STR(13)=STR(13)_$J($P(X,U,2)/SET,7,0)
 . S STR(14)=STR(14)_$J($P(X,U,3)/SET,7,0)
 . S STR(15)=STR(15)_$S($P(X,U,9):$J($P(X,U,9)-$P(X,U,2)/$P(X,U,9)*100,7,0),1:"       ")
 . S STR(16)=STR(16)_$S($P(X,U,10):$J($P(X,U,10)-$P(X,U,3)/$P(X,U,10)*100,7,0),1:"       ")
 . S STR(17)=STR(17)_$S($P(X,U,11):$J($P(X,U,11)/SET,7,0),1:"       ")
 . S STR(18)=STR(18)_$S($P(X,U,12):$J($P(X,U,12)/SET,7,0),1:"       ")
 . S STR(19)=STR(19)_$S($P(X,U,12):$J($P(X,U,17)/$P(X,U,12)*100,7,0),1:"       ")
 . S STR(20)=STR(20)_$J(CNT,7,0)
PRINT S HDR(2)="  "_$E($P($G(^DIC(4,OSITE,0)),U),1,20) F I=1:1:22-$L(HDR(2)) S HDR(2)=HDR(2)_" "
 S HDR(2)=HDR(2)_" MPM Summary for "_BD_" to "_ED_" ("_$S(XUCSRT="A":"AM)",XUCSRT="P":"PM)",1:"AM&PM)")
 I $D(MAIL) D
 . F I=1,2,1 S ^TMP($J,"XUCS",L)=HDR(I),L=L+1
 . F I=1:1:20 S ^TMP($J,"XUCS",L)=STR(I),L=L+1
 E  D
 . F I=1,2,1 W HDR(I),!
 . F I=1:1:20 W STR(I),!
 . I NODE]"" W @IOF
 G XIT:NODE=""
ISTR S STR(1)=" Node               "
 S STR(2)=" CPU Usage %       "
 S STR(3)=" Disk Usage %      "
 S STR(4)=" Response Time Sec "
 S STR(5)=" RTs<2 Seconds %   "
 S STR(6)=" Responses/S       "
 S STR(7)=" Ave. # Jobs       "
 S STR(8)=" Term InChar/S     "
 S STR(9)=" Term OutChar/S    "
 S STR(10)=" M Commands/S      "
 S STR(11)=" Global Gets/S     "
 S STR(12)=" Global S&Ks/S     "
 S STR(13)=" Disk Reads/S      "
 S STR(14)=" Disk Writes/S     "
 S STR(15)=" Read Cache %      "
 S STR(16)=" Write Cache %     "
 S STR(17)=" DDP Requests/S    "
 S STR(18)=" RVG Requests/S    "
 S STR(19)=" RVG Cache %       "
 S STR(20)=" RTH Sessions      "
 Q
NOT I $G(DUZ)\1 S XQA(DUZ)="",XQAMSG="No local CMP recipients in MSM RTHIST SITE file, no MPM Daily Summary" D SETUP^XQALERT K XQA,XQAMSG,MAIL
XIT I $D(MAIL) S XMDUZ="MPM",XMTEXT="^TMP($J,""XUCS"",",XMSUB=$S(MAIL=1:"MPM Morning Report for "_+$E(XUCSBD,4,5)_"/"_+$E(XUCSBD,6,7)_"/"_$E(XUCSBD,2,3),1:"MPM Summary Report"),XMCHAN=1 D ^XMD
 I $E($G(IOST))'="C",'$D(ZTQUEUED) D ^%ZISC
 K BD,CD,CNT,CUM,DIR,ED,FMDT,HDR,I,J,L,M,MAIL,NODE,OSITE,RT,S,SEET
 K SET,SITE,ST,STR,SUM,TY,X,X0,X1,X2,XMY,XMCHAN,XMDUZ,XMSUB,XMTEXT
 K XUCSBD,XUCSED,XUCSEND,XUCSRT,XUCSUN,Y
 Q
ONE ; One site only
 S U="^",DT=$$HTFM^XLFDT($H,1),DIR("A")="Select MPM Site",DIR(0)="P^4:EMZ" D ^DIR Q:$D(DIRUT)  S XUCSUN=$P(Y,U) G A
