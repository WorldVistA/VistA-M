PRCFDE1 ;WISC@ALTOONA/CTB-CONTINUATION OF PRCFDE ;12/2/10  16:13
V ;;5.1;IFCAP;**154**;Oct 20, 2000;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 K DIC S DIE="^PRCF(421.5,",DA=PRCF("CIDA")
 K %DT S X="T" D ^%DT S PRCFD("TODAY")=Y
 S DR="[PRCF CI VOUCHER AUDIT]" D ^DIE ;Q:$D(PRCFD("PAY"))
 D ENTER^PRCFDCIP
 K PRCF("VENDA"),PRCFD("DOI"),PRCFD("PODA"),PRCFD("DOP"),PRCFD("DIR")
 K PRCFD("INV TYPE"),PRCF("PTR"),PRCF("DAYS"),PRCF("NAME"),PRCF("X")
 K PRCF("PT"),PRCFD("DOD"),ZX
 I $D(Y) S X=$S($D(PRCFD("LOGIN")):10,1:0) D STATUS,NA G VEX
 D  I %<0 D NA S PRCFD("^")="" G VEX
 . S %A="Accept invoice for further processing",%B="",%=1 D ^PRCFYN
 . Q:%'=2  S %A="Return invoice to vendor",%B="",%=2 D ^PRCFYN
 . Q:%<0  S:%=1 %=3
 . Q
 I %=2 S X=$S($D(PRCFD("LOGIN")):10,1:0) D STATUS,NA G VEX
 I %=3 D  G VEX
 . S DR=25 D ^DIE I X D
 . . S DR="24//TODAY;23" D ^DIE,PRCFCHK^PRCFDCI,^PRCFDSUS
 . . Q
 . S X=3 D STATUS
 . Q
 G:$D(PRCFD("LOGIN"))&'$D(PRCFD("RECERT")) VEX
 I '$P(^PRCF(421.5,PRCF("CIDA"),0),"^",27) G PAYMENT
 S %A="Do you wish to forward this invoice for signature at this time",%B="",%=1 D ^PRCFYN
 I %'=1 S X=0,PRCF("%")=% D STATUS S X=" <No further action taken.>*" D MSG^PRCFQ S %=PRCF("%") K PRCF("%") S:%<0 PRCFD("^")="" G VEX
 S DIE="^PRCF(421.5,",DA=PRCF("CIDA"),DR="[PRCF CI BORROWER]" D ^DIE
 I $D(Y) S X=0 D STATUS,NA S PRCFD("^")="" G VEX
 S X="Please forward actual invoice to service for signature.*"
 D MSG^PRCFQ S X=5 D STATUS
VEX Q
 ;
PAYMENT S %A="Do you wish to process this item for payment now",%B="",%=1
 N PRCYESNO
 D ^PRCFYN S PRCYESNO=%
 I PRCYESNO=1,$$VIOLATE^PRCFDSOD(PRCF("CIDA"),DUZ) S X=10 D STATUS,NA G PAYX
 I PRCYESNO'=1 S X=10 S:%<0 PRCFD("^")="" D STATUS,NA G PAYX
 D DIE^PRCFDCI
PAYX Q
STATUS N X1,X2,DA,DIE,DR S X2=X
 S X1=$S($D(^PRCF(421.5,PRCF("CIDA"),2))#2:$P(^(2),"^"),1:"")
 I X1="" D ST S X="Status is set to '"_Y_"'.*" D MSG^PRCFQ G STATUSX
 I X=X1 D ST S X="Status of '"_Y_"' has not been changed.*" D MSG^PRCFQ Q
 S X=X1 D ST S $P(X1,"^",2)=Y,X=X2 D ST S $P(X2,"^",2)=Y
 S X="Status has been changed from '"_$P(X1,"^",2)_"'*" D MSG^PRCFQ
 S X="                          to '"_$P(X2,"^",2)_"'.*" D MSG^PRCFQ
 I $G(PRCNOPAT)=1 K PRCNOPAT W ?3,"This invoice needs a valid purchase order number.",!!
STATUSX S DA=PRCF("CIDA"),DR="50////^S X=+X2",DIE=421.5 D ^DIE
 Q
ST N DD,F S DD=421.5,F=50 D ^PRCFU1 Q
NA S X="  <No action taken.>*" D MSG^PRCFQ Q
OUT ;EXIT LINE
 D OUT^PRCFDE Q
EDIT ;EDIT EXISTING, INCOMPLETE INVOICE
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 S PRCFD("PAY")="",PRCFDX("ED")="",DIC=421.5,DIC(0)="AEMNZ"
 S DIC("S")="I $S('$D(^(2)):1,+^(2)>3:0,1:1),$D(^(1)),$P(^(1),""^"",2)=PRC(""SITE"")"
 D ^DIC K DIC I Y<0 K PRCFDX("ED") D OUT Q
 S PRCF("CIDA")=+Y D PAT^PRCFDE I $D(PRCFD("^")) D OUT Q
 S %A="Do you wish to edit another incomplete invoice",%B="",%=2
 D ^PRCFYN G EDIT:%=1 D OUT
 Q
 ;
 ;
PO ;INPUT TRANSFORM FOR FIELD 4.5 FILE 421.5
 ;I '$D(PRC("SITE")) S PRCFX=X,PRCF("X")="AS" D ^PRCFSITE S X=PRCFX K PRCFX Q:'%
 I X["." S X=$P(X,".")
 N DIC,%A,%B S DIC=442,DIC(0)="EM" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT)) K DTOUT,DUOUT,X Q
 I Y>0 S ZY=Y,X=$P($G(^PRC(442,+Y,7)),U,2) I X<10!(X>43) G:X=45 CANC D QUES,^PRCFYN S Y=ZY K ZY I %'=1 K X Q
 I $G(PRCF("CIDA"))="" S PRCF("CIDA")=$G(DA)
 I Y>0 S X=$P(Y,"^",2),$P(^PRCF(421.5,PRCF("CIDA"),0),"^",7)=+Y,^PRCF(421.5,"E",+Y,PRCF("CIDA"))="" Q
 I Y<0,X="" K X Q
 S X=$S(X["-":PRC("SITE")_"-"_$P(X,"-",2),1:PRC("SITE")_"-"_X)
 S %A=$S(X]"":"PAT Reference Number "_X_" is not in Purchase Order File.",1:"No PAT number selected"),%A(0)="*!",%A(1)="OK to Continue",%B="",%=2 D ^PRCFYN I %'=1 K X Q
 I %=1 S PRCNOPAT=1
 N PZ
 S PZ=$P(^PRCF(421.5,PRCF("CIDA"),0),"^",7),$P(^(0),"^",7)=""
 I PZ]"" K ^PRCF(421.5,"E",PZ,PRCF("CIDA")) Q
 Q
QUES S X=+$G(^PRC(442,+Y,7))
 S X=$S(X="":"UNKNOWN",'$D(^PRCD(442.3,X,0)):"UNKNOWN",1:$P(^(0),"^"))
 S %A="Current Status on this PAT number is '"_X_"'.  OK to Continue"
 S %A(0)="*",%B="",%=2
 Q
CANC W !,$C(7),"Purchase Order status is: CANCELED ORDER.  Cannot proceed." S Y=ZY,%=-1 K ZY,X Q
