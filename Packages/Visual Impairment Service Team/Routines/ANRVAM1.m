ANRVAM1 ;MUSK/GLD,MFW,HCIOFO/NDH - VIST AMIS CALC ; 11 Apr 89 / 9:20 AM
 ;;4.0; Visual Impairment Service Team ;**2**;12 Jun 98
INTRO W @IOF,"I WILL PRINT THE AMIS REPORT FOR PERIOD SPECIFIED.",!!
 ;ROUTINE TO CALCULATE ALL VIST AMIS DATA IN FILE BY AMIS CODE.
BDATE S %DT="EXTA",%DT("A")="  BEGINNING AMIS DATE:  " D ^%DT Q:Y<0  S ANQBD=Y
EDATE S %DT("A")="     ENDING AMIS DATE:  " D ^%DT Q:Y<0  S ANQED=Y
 I ANQBD>ANQED  D  G INTRO
 .W !!,"  Beginning Date greater than Ending Date"
 .R X:5
ASKMAIL ; Check to see if user wants to email this report
 W !!!,"Do you want to email the AMIS report to the program office?(Y/N)"
 D YN^DICN
 I %=-1 Q
 I %=0 W !,"Answer Y or N" G ASKMAIL
 S ANQSEL=%
 I ANQSEL=2 D DEVICE Q
 F  D  Q:ANRVMHE="^"!(ANRVMHE?1.4N!(ANRVMHE?1.4N1"."1.2N))
 .W !!,"Enter Average Man Hours Expensed by"
 .W !,"VIST Coordinator Per Week or ^ to exit: "
 .R ANRVMHE:30
 .S:'$T ANRVMHE="^"
 .Q:ANRVMHE="^"
 .S:+ANRVMHE<1 ANRVMHE=""
 .I ANRVMHE'?1.4N,ANRVMHE'?1.4N1"."1.2N  D
 ..W !!,"Field 050 - Average Man Hours must be entered"
 ..W !!,"Must be a number between 1 and 9999.99"
 ..W !,"Up to 2 decimal precision is allowed."
 .; Send mail to specified recipients
 .S ANQMAIL=$$GETADDR()
 .I ANQMAIL=""  D
 ..W !,"No address is defined in your VIST SITE PARAMATERS"
 ..W !,"  for the AMIS report.  The AMIS report will not be sent."
 ..W !,"  Please enter the appropriate data or contact"
 ..W !,"  your system administrator.",!!
 ..S ANRVMHE="^"
 D:ANRVMHE'="^" DQ
 Q
DEVICE K IOP S %ZIS="MQ",%ZIS("B")="" D ^%ZIS G:POP CLEAN
 I $D(IO("Q"))  D  G CLEAN
 .K IO("Q")
 .S ZTSAVE("ANQ*")="",ZTDESC="VIST AMIS",ZTRTN="DQ^ANRVAM1"
 .D ^%ZTLOAD
 .K ZTSK
DQ K ANRVBAD F ANQJ=0:1:49 S ^TMP("ANRV",$J,ANQJ)=0
 D FV^ANRVAM2
 S ANRVP=""
 F  S ANRVP=$O(^ANRV(2040,"B",ANRVP)) Q:ANRVP=""  S ANRVIN="" D LOOP2
 S ANRBD=(ANQBD-.01) D ^ANRVAM2 G CLOSE
LOOP2 F  S ANRVIN=$O(^ANRV(2040,"B",ANRVP,ANRVIN)) Q:ANRVIN=""  D CALC
 Q
CALC ;
 S VAL=""
 I '$D(^ANRV(2040,ANRVIN,13)) S ANRVBAD(ANRVIN)="",VAL="" Q
 S VAL=$P(^ANRV(2040,ANRVIN,13),"^",2)
 I VAL="001" S ^TMP("ANRV",$J,1)=^TMP("ANRV",$J,1)+1 S VAL="" G CALC2
 I VAL="002" S ^TMP("ANRV",$J,2)=^TMP("ANRV",$J,2)+1 Q
 I VAL="003" S ^TMP("ANRV",$J,3)=^TMP("ANRV",$J,3)+1 Q
 Q
CALC2 S VAL=""
 I $P(^ANRV(2040,ANRVIN,7),"^",3)'="" S VAL=$P(^ANRV(2040,ANRVIN,7),"^",3)
 I VAL="004" S ^TMP("ANRV",$J,4)=^TMP("ANRV",$J,4)+1 G CALC3
 I VAL="005" S ^TMP("ANRV",$J,5)=^TMP("ANRV",$J,5)+1 G CALC3
 I VAL="006" S ^TMP("ANRV",$J,6)=^TMP("ANRV",$J,6)+1 G CALC3
 I VAL="007" S ^TMP("ANRV",$J,7)=^TMP("ANRV",$J,7)+1 G CALC3
 I VAL="008" S ^TMP("ANRV",$J,8)=^TMP("ANRV",$J,8)+1 G CALC3
CALC3 S VAL=""
 I $P(^ANRV(2040,ANRVIN,7),"^",4)'="" S VAL="",VAL=$P(^ANRV(2040,ANRVIN,7),"^",4)
 I VAL="009" S ^TMP("ANRV",$J,9)=^TMP("ANRV",$J,9)+1 G CALC4
 I VAL="010" S ^TMP("ANRV",$J,10)=^TMP("ANRV",$J,10)+1 G CALC4
 I VAL="011" S ^TMP("ANRV",$J,11)=^TMP("ANRV",$J,11)+1 G CALC4
 I VAL="012" S ^TMP("ANRV",$J,12)=^TMP("ANRV",$J,12)+1 G CALC4
 I VAL="013" S ^TMP("ANRV",$J,13)=^TMP("ANRV",$J,13)+1 G CALC4
 I VAL="014" S ^TMP("ANRV",$J,14)=^TMP("ANRV",$J,14)+1 G CALC4
 I VAL="015" S ^TMP("ANRV",$J,15)=^TMP("ANRV",$J,15)+1 G CALC4
CALC4 S VAL="",DFN=ANRVP
 D ELIG^VADPT S:$D(VAEL(2)) VAL=$P(VAEL(2),"^")
 I VAL=2 S ^TMP("ANRV",$J,16)=^TMP("ANRV",$J,16)+1 G CALC5
 I VAL=4 S ^TMP("ANRV",$J,16)=^TMP("ANRV",$J,16)+1 G CALC5
 I VAL=3 S ^TMP("ANRV",$J,17)=^TMP("ANRV",$J,17)+1 G CALC5
 I VAL=1 S ^TMP("ANRV",$J,18)=^TMP("ANRV",$J,18)+1 G CALC5
 I VAL=7 S ^TMP("ANRV",$J,19)=^TMP("ANRV",$J,19)+1 G CALC5
 I VAL=6 S ^TMP("ANRV",$J,20)=^TMP("ANRV",$J,20)+1 G CALC5
 I VAL=8 S ^TMP("ANRV",$J,20)=^TMP("ANRV",$J,20)+1 G CALC5
 I VAL=9 S ^TMP("ANRV",$J,20)=^TMP("ANRV",$J,20)+1 G CALC5
 I VAL=5 S ^TMP("ANRV",$J,20)=^TMP("ANRV",$J,20)+1 G CALC5
 I VAL=121 S ^TMP("ANRV",$J,20)=^TMP("ANRV",$J,20)+1 G CALC5
 S ^TMP("ANRV",$J,21)=^TMP("ANRV",$J,21)+1 G CALC5
CALC5 S VAL=""
 I $D(^ANRV(2040,ANRVIN,5)),$P(^ANRV(2040,ANRVIN,5),"^",1)'="" S VAL="",VAL=$P(^ANRV(2040,ANRVIN,5),"^",1)
 I VAL="022" S ^TMP("ANRV",$J,22)=^TMP("ANRV",$J,22)+1 G CALC6
 I VAL="023" S ^TMP("ANRV",$J,23)=^TMP("ANRV",$J,23)+1 G CALC6
 I VAL="024" S ^TMP("ANRV",$J,24)=^TMP("ANRV",$J,24)+1 G CALC6
 I VAL="025" S ^TMP("ANRV",$J,25)=^TMP("ANRV",$J,25)+1 G CALC6
CALC6 S VAL="",VAL=$P(^DPT(ANRVP,0),"^",3) G:VAL="" CALC16
 S VAL=$E(DT,1,3)-$E(VAL,1,3)-($E(DT,4,7)<$E(VAL,4,7))
 I VAL<25 S ^TMP("ANRV",$J,26)=^TMP("ANRV",$J,26)+1 Q
 I VAL<35,VAL>24 S ^TMP("ANRV",$J,27)=^TMP("ANRV",$J,27)+1 Q
 I VAL<45,VAL>34 S ^TMP("ANRV",$J,28)=^TMP("ANRV",$J,28)+1 Q
 I VAL<55,VAL>44 S ^TMP("ANRV",$J,29)=^TMP("ANRV",$J,29)+1 Q
 I VAL<65,VAL>54 S ^TMP("ANRV",$J,30)=^TMP("ANRV",$J,30)+1 Q
 I VAL<75,VAL>64 S ^TMP("ANRV",$J,31)=^TMP("ANRV",$J,31)+1 Q
 I VAL<85,VAL>74 S ^TMP("ANRV",$J,32)=^TMP("ANRV",$J,32)+1 Q
 I VAL>84 S ^TMP("ANRV",$J,33)=^TMP("ANRV",$J,33)+1 Q
CALC16 S ^TMP("ANRV",$J,34)=^TMP("ANRV",$J,34)+1 Q
 Q
CLOSE ; Check if user wanted to send mail to DC
 ; and complete report.
 ;
 I ANQSEL=2 D ^ANRVAP D:$O(ANRVBAD(0)) BADDAT
 I $D(ANQMAIL)  D
 .S ANQSUBJ="AMIS Report - "_^DD("SITE")
 .S ANRVIMN=$$SEND(ANQMAIL,ANQSUBJ) ; Send data via email
 .I ANRVIMN<1  D  Q
 ..W !,"There was a problem sending the AMIS data.",!
 .S X=$$SENDCONF(ANQMAIL,ANQSUBJ,ANRVIMN) ; Send confirmation message
 .I X<1  D  Q
 ..W !,"There was a problem sending the Confirmation Message"
 ..W !,"back to your mailbox."
 D ^%ZISC
CLEAN ; Clean
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K ANQBD,ANQED,ANRAS,ANRBD,ANRD,ANRDOD,ANRFVD,ANRND,ANRRD,ANRRFD
 K ANRRN,ANRVBAD,ANRVIN,ANRVP,ANRP,VAL,QFLG,POP,J,I,DFN,ANQJ
 K ANQMAIL,ANQSEL,ANRVDIR,ANRVGLB,ANQSUBJ,ANRVFILE,ARRAY
 K ANRVIMN,ANRVSTR
 K ^TMP("ANRV",$J),^TMP("ANRV","EMAIL",$J),^TMP("ANRV","CONFIRM",$J)
 K VAEL,VAERR,DIRUT,DTOUT,DUOUT
 Q
BADDAT ;
 S X="PATIENTS WITH MISSING AMIS DATA" W @IOF,!,?(IOM\2-($L(X)\2)),X
 W ! F X=1:1:IOM W "="
 W ! S I="" F  S I=$O(ANRVBAD(I)) Q:'I  S X=+^ANRV(2040,I,0) W $P(^DPT(X,0),U),?35,$P(^(0),U,9),!
 Q
SEND(ANQMAIL,ANQSUBJ) ; Send mail from ^TMP("ANRV","EMAIL",$J)
 ; Send mail to defined recipient(s) in ANQMAIL
 S XMSUB=ANQSUBJ,XMCHAN=1,XMDUZ=.5
 D GET^XMA2
 I XMZ<1  D  Q
 .W !,"There was a problem obtaining an Internal Message Number."
 D BUILD
 S X=ANQMAIL,XMY(X)="",XMY(DUZ)=""
 S XMTEXT="^TMP(""ANRV"",""EMAIL"",$J,"
 D ^XMD
 Q XMZ
 ;
SENDCONF(ANQMAIL,ANQSUBJ,ANRVIMN) ; Send Confirmation to User
 ;
 S XMSUB=ANQSUBJ,XMCHAN=1,XMDUZ=.5,XMY(DUZ)=""
 D GET^XMA2
 S X(1)="This is a confirmation that"
 S X(2)="message # "_ANRVIMN_" "_ANQSUBJ
 S X(3)="Has been sent to the Washington, DC"
 S X(4)="distribution list "_$$GETADDR()_"."
 S Y=""
 F  S Y=$O(X(Y)) Q:Y=""  D
 .S ^TMP("ANRV","CONFIRM",$J,Y)=X(Y)
 S XMTEXT="^TMP(""ANRV"",""CONFIRM"",$J,"
 D ^XMD
 Q XMZ
BUILD ; Build AMIS Report to ^TMP("ANRV","EMAIL",$J) to send as email
 ; Build the Excel portion of the email
 S L=1
 S ^TMP("ANRV","EMAIL",$J,L)="~~VA~~",L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=^DD("SITE"),L=L+1
 S X=$O(^ANRV(2041,0))
 S ^TMP("ANRV","EMAIL",$J,L)=$P(^ANRV(2041,X,0),U,2),L=L+1
 S X=$$FMTE^XLFDT(ANQBD),Y=$$FMTE^XLFDT(ANQED)
 S X1=$P(X," "),X2=$P($P(X," ",2),","),X=$P(X,",",2)
 S X=X2_" "_X1_X
 S Y1=$P(Y," "),Y2=$P($P(Y," ",2),","),Y=$P(Y,",",2)
 S Y=Y2_" "_Y1_Y
 S ^TMP("ANRV","EMAIL",$J,L)=X_","_Y,L=L+1
 S (I,X)=""
 S ANRVSTR=$O(^TMP("ANRV",$J,I)),I=ANRVSTR
 F  S I=$O(^TMP("ANRV",$J,I)) Q:I=""  D
 .S X=^TMP("ANRV",$J,I)
 .S ANRVSTR=ANRVSTR_","_X
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",1,5),L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",6,10),L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",11,15),L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",16,20),L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",21,25),L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",26,30),L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",31,35),L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",36,40),L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",41,45),L=L+1
 S ^TMP("ANRV","EMAIL",$J,L)=$P(ANRVSTR,",",46,49)_","_ANRVMHE,L=L+1
 Q
 ;
GETADDR() ; Get addresses for AMIS report from VIST Site Parameters
 ;
 N X
 S X=$O(^ANRV(2041,0))
 S Y=$P($G(^ANRV(2041,X,0)),U,5)
 Q Y
