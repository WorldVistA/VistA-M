ENSA1 ;(WASH ISC)/DH-MedTester Interface ;12/21/2000
 ;;7.0;ENGINEERING;**9,14,21,45,48,54,67**;Aug 17, 1993
UPLD ;Read from ESU
 K ^ENG("TMP",ENTID)
 W !!,"Enter the device to which the MedTester is connected.",! D ^%ZIS Q:POP
 S ENCTEON=^%ZOSF("EON"),ENCTEOFF=^%ZOSF("EOFF"),ENCTTYPE=^%ZOSF("TYPE-AHEAD"),ENCTOPEN=$G(^%ZIS(2,IOST(0),10)),ENCTCLOS=$G(^%ZIS(2,IOST(0),11))
 U IO D OFF W !,"...OK, use the MedTester 'PALL' function to send the data. Please",!,"be sure that you are connected to a MedTester COMM port and that the",!,"MedTester PRINTER port is OFF."
 D ON R X:60 I '$T D OFF W !!,"Data transmission failure.",*7 D HOLD G EXIT
 S X=$TR(X,$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)) ;strip control chars
 ; next 4 lines will cause routine to ignore blank lines (Open-M) problem
 F  Q:$E(X)'=" "  S X=$E(X,2,245)
 S I=0 I X]"" S I=I+1,^ENG("TMP",ENTID,I)=X
 F  R X:10 Q:'$T  I X]"" S X=$TR(X,$C(10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27)) D  I X]"" S I=I+1,^ENG("TMP",ENTID,I)=X D:'(I#5) MARK
 . F  Q:$E(X)'=" "  S X=$E(X,2,245)
 R %:1 ;clear buffer
 D OFF
 D ^%ZISC
 Q  ;Data upload finished
 ;
MARK I IO=IO(0) D OFF
 U IO(0) W "." U IO
 I IO=IO(0) D ON
 Q
 ;
ON X ENCTOPEN U IO X ENCTEOFF,ENCTTYPE
 Q
 ;
OFF X ENCTCLOS,ENCTEON U IO(0)
 Q
 ;
PROCS ;Process test results
 K ^TMP($J)
 N PMTOT S ENBRANCH="RECNUM^DATE^OPCODE^DEVICE^COMNTS^OTHER"
 S (ENREC,ENEQ,ENLOC,ENEMP,ENTEC,ENSTDT,ENSN,ENMOD,ENWP,ENTIME,ENTEST)="",(ENFAIL,ENFLG,ENPG,ENY)=0 K ENLBL
READ S ENSA1=0 F  S ENSA1=$O(^ENG("TMP",ENTID,ENSA1)) Q:'ENSA1  D MEDCHK
 I $D(ENLBL) D UPDT
 I $D(PMTOT) D ^ENBCPM8
 Q  ;Return control to ENSA
 ;
MEDCHK S X=^ENG("TMP",ENTID,ENSA1) F  Q:$E(X)'=$C(32)  S X=$E(X,2,245)
 I X["MedTester" S X="MedTester  REC #"_$P(X," REC #",2)
 S ENX=X,X1=$S($E(X,1,9)="MedTester":1,$E(X,1,9)="SEQUENCE:":2,$E(X,1,14)="OPERATOR CODE:":3,$E(X,1,8)="OP CODE:":3,$E(X,1,18)="DEVICE INFORMATION":4,$E(X,1,9)="COMMENTS:":5,1:6)
 D @($P(ENBRANCH,U,X1))
 Q
 ;
RECNUM D:$D(ENLBL) UPDT K ENLBL ; post data (if any) from last test
 ; init variables for this test
 K ENSN,ENMOD,ENPMN,ENSTDT,ENPMWO(0)
 S (ENEQ,ENLOC,ENEMP,ENTEC,ENSTDT,ENSN,ENMOD,ENWP,ENTIME,ENTEST)="",(ENFAIL,ENFLG)=0
 S X=$TR($P(ENX,"REC #",2),$C(32))
 S ENREC=X D:ENPAPER LNPRNT^ENSA7
 Q
DATE ;Date of ESA
 N DELYR ;  for Y2K
 S X=^ENG("TMP",ENTID,ENSA1),X=$P(X,"DATE:",2),X1=$P(X,"TIME:",1)
 S X1=$TR(X1,$C(10,32))
 S XM=$P(X1,"/",1),XD=$P(X1,"/",2),XY=$P(X1,"/",3)
 S:$L(XM)<2 XM="0"_XM
 S:$L(XD)<2 XD="0"_XD
 S:$L(XY)<2 XY="0"_XY ; added by *67 for non-y2k compliant Medtesters
 S DELYR=$E(DT,2,3)-XY
 S ENSTDT=$E(DT)+$S(DELYR>79:1,DELYR<-20:-1,1:0)_XY_XM_XD
 I ENSTDT'?7N S ENSTDT="" ; result was an invalid date format
 K XM,XD,XY
 I ENPAPER D LNPRNT^ENSA7
 Q
OPCODE ;Operator
 S (ENTEC,ENEMP)="",X=$TR($P(X,":",2),$C(32))
 I X]"" D
 . I X=+X S ENTEC=X,ENEMP=$S($D(^ENG("EMP",X,0)):$P(^(0),U),1:"") Q
 . I $D(^ENG("EMP","B",X)) S ENEMP=X,ENTEC=$O(^(X,0)) Q
 . S X(1)=$L(X),X(2)=$O(^ENG("EMP","B",X)) I $E(X(2),1,X(1))=X D
 .. I $E($O(^ENG("EMP","B",X(2))),1,X(1))=X Q
 .. S ENTEC=$O(^ENG("EMP","B",X(2),0)),ENEMP=$P(^ENG("EMP",ENTEC,0),U)
 D:ENPAPER LNPRNT^ENSA7
 Q
DEVICE ;Equipment id
 F J=1,2 S ENSA1=$O(^ENG("TMP",ENTID,ENSA1)),X(J)=^ENG("TMP",ENTID,ENSA1)
 S X(3)="",X=$G(^ENG("TMP",ENTID,ENSA1+1)) F  Q:$E(X)'=" "  S X=$E(X,2,30)
 I $E(X,1,7)="CONTROL" D  ; accomodate MedTester 5000C
 . S ENSA1=ENSA1+1,X(3)=$TR($P(X,":",2),$C(10)) F  Q:$E(X(3))'=" "  S X(3)=$E(X(3),2,50)
 . S I=$L(X(3)) F  Q:$E(X(3),I)'=" "!(I<1)  S I=I-1,X(3)=$E(X(3),1,I)
 S X=$P(X(1),"LOC:",2) F J=0:0 Q:$E(X)'=" "  S X=$E(X,2,30)
 S ENLOC=X I $E(ENLOC,1,2)="SP" S ENLOC=$E(ENLOC,3,30)
 I ENLOC["  " S ENLOC=$P(ENLOC,"  ")
 S X=$L(ENLOC) I $E(ENLOC,X)=" " S ENLOC=$E(ENLOC,1,(X-1))
 S X=$P(X(2),":",2)
 S X=$S($E(X,$L(X)-1,$L(X))="SN":$E(X,1,$L(X)-2),$E(X,$L(X)-7,$L(X))="SERIAL #":$E(X,1,$L(X)-8),1:X)
 S X=$TR(X,$C(32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47))
 S ENMOD(0)=$E(X,1,16)
 S X=$P(X(2),":",3)
 S X=$S($E(X,$L(X)-1,$L(X))="CN":$E(X,1,$L(X)-2),$E(X,$L(X)-8,$L(X))="CONTROL #":$E(X,1,$L(X)-9),1:X)
 S X=$TR(X,$C(10,32))
 S ENSN(0)=$E(X,1,16)
 I X(3)]"" S X=X(3)
 E  D
 . S X=$TR($P(X(2),":",4),$C(10)) F  Q:$E(X)'=" "  S X=$E(X,2,30)
 . S I=$L(X) F  Q:$E(X,I)'=" "!(I<1)  S I=I-1,X=$E(X,1,I)
 S ENLBL=X,ENEQ="" D DEVICE^ENSA7
 K X Q
COMNTS ;MedTester comments
 S X=$TR($E(X,11,128),$C(10))
 S ENWP=X_" MedTester" S:$E(X)="#" ENFAIL=1
 I ENPAPER D LNPRNT^ENSA7
 Q
OTHER ;All other, mainly specific test results
 I $E(X,1,10)="USER TIME:" S ENTIME=+$TR($P(X,":",2)," ")
 ;
 ; distinguish between EKG and DEFIB tests and hope that we're not
 ;   missing other flavors of MedTester procedures
 ;
 ; if line has text indicating start of a test results section then
 ;   set ENFLG = 1 (true) so subsequent lines will be checked for
 ;   presence of '#' which indicates a test failure
 ;
 I $E(X,1,12)="LINE VOLTAGE" S ENFLG=1,ENTEST="EKG" ; for esa test
 I $E(X,1,5)="DEFIB" S ENFLG=1,ENTEST="DEFIB" ; for defib test
 ;
 ; if line has text indicating section after test results then
 ;   set ENFLG = 0 (false) so subsequent lines will not be checked for
 ;   presence of '#'
 ;
 I $E(X,1,11)="PERFORMANCE" S ENFLG=0 ; for any test
 ;
 ; if ENFLG true then check for failure unless line starts STEP#
 ;   since defib tests use 'STEP #' as a column header
 ;
 I ENFLG,$E(X,1,4)'="STEP",X["#" S ENFAIL=1
 ;
 I ENPAPER D LNPRNT^ENSA7
 Q
 ;
UPDT ;Update Equipment File
 S ENEQ(0)=1 I ENEQ]"" D UPDATE^ENSA2 D:$D(^ENG(6914,ENEQ,0)) POST^ENSA4
 I ENEQ(0),ENLBL?4N1"-"4N0.1A D PMN^ENSA2 I ENEQ]"",$D(^ENG(6914,ENEQ,0)) D POST^ENSA4
 I ENEQ(0) D NOLBL^ENSA3
 I $D(ENXP("?")) D DEVCK3^ENSA7 K ENXP("?")
 Q
 ;
HOLD W !,"Press <RETURN> to continue..." R X:DTIME
 Q
EXIT G EXIT^ENSA3
 ;ENSA1
