PRCFFM1M ;WISC/SJG-ROUTINE TO PROCESS AMENDMENT OBLIGATIONS CON'T ;4/26/94  16:40
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NEWVAR ; Refresh variables from 442
 K DIC
 S DIC("S")="I +^(0)=PRC(""SITE"")"
 S DIC=442,DIC(0)="NZ",X=PRCFA("PODA")
 D ^DIC K DIC G:+Y<0 OUT1
 S PO(0)=Y(0),PO=Y
 S PRCFA("REF")=$P(PO(0),U)
 ; the following line was commented out in PRC*5*179
 ; S PRCFA("SFC")=$P(PO(0),U,19)
 S PRCFA("MP")=$P(PO(0),U,2)
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(+PO)
 D GENDIQ^PRCFFU7(442,+PO,".1;.07;.03;17","IEN","")
 ;
EDIT ; Check fund/year table to determine fields required for FMS
 D EDIT^PRCFFU ; sets up PRCFMO array for req'd fields
 ;
 ; if amendment requires re-establishing the FMS document
 I $D(PRCFA("CANCEL")),PRCFA("CANCEL")]"" S PRCFA("MOD")="E^0^Original Entry (Amended)"
 I PRCFA("TT")="AR",$D(PRCFA("CANCEL")),PRCFA("CANCEL")]"",XRBLD'=2 D
 . S PRCFA("TT")="SO"
 . D STACK ; set up the SO first
 . S PRCFA("TT")="AR"
 . S X1=PRCFA("OBLDATE"),X2=1
 . D C^%DTC
 . S PRCFA("OBLDATE")=X ; SO must be on FMS 1st, thus AR needs future date
 . S %DT="FX",X="T+1"
 . D ^%DT
 . I $P(Y,".",1)>PRCFA("OBLDATE") S PRCFA("OBLDATE")=$P(Y,".",1)
 D STACK ; build the appropriate FMS transaction
 ;
 D  ;adj fcp committed/obligated balance
 . ; the next several lines were omitted by patch 172
 . ; N TRDA,Z,AMT,DEL,X,TIME,DA
 . ; S TRDA=$P(^PRC(442,PRCFA("PODA"),0),"^",12),AMT=$P(^(0),"^",$P(PRCFMO,"^",12)="N"+15),DEL=$P(^(0),"^",10)
 . ; D NOW^%DTC S TIME=X
 . ; I TRDA="" D  QUIT
 . ; . N A
 . ; . S A=$$DATE^PRC0C($P(PRCOAMT,"^",3),"I"),$P(PRCOAMT,"^",3,4)=$E(A,3,4)_"^"_$P(A,"^",2)
 . ; . D EBAL^PRCSEZ(PRCOAMT,"C"),EBAL^PRCSEZ(PRCOAMT,"O")
 . ; . ;S A=$P($G(^PRC(442,PRCFA("PODA"),1)),"^",15) QUIT:A=""
 . ; . QUIT:PRC("RBDT")  S A=$$DATE^PRC0C(PRC("RBDT"),"I")
 . ; . S A=+PO(0)_"^"_$P(PO(0),"^",3)_"^"_$E(A,3,4)_"^"_$P(A,"^",2)_"^"_AMT
 . ; . D EBAL^PRCSEZ(A,"C"),EBAL^PRCSEZ(A,"O")
 . ; . QUIT
 . N TRDA,DEL,DA,MESSAGE
 . S TRDA=$P(^PRC(442,PRCFA("PODA"),0),"^",12),DEL=$P(^(0),"^",10)
 . I TRDA="" Q
 . I '$D(^PRCS(410,TRDA,4)) Q
 . S DA=TRDA,$P(^PRCS(410,TRDA,9),"^",2)=DEL
 . D REMOVE^PRCSC2(DA),ENCODE^PRCSC2(DA,DUZ,.MESSAGE)
 . QUIT
 ;
FISCST ; Post to Fiscal Status of Funds Tracker
 I $P(PRC("PARAM"),U,17)["Y" D FISC^PRCFFU4
 ;
PRINT ; Print out copy of Purchase Order Amendment
 G:'FLG OUT1
 S PRCHQ="^PRCHPAM"
 S PRCHQ("DEST")="S8"
 S D0=PRCFA("PODA")
 S D1=PRCFA("AMEND#")
 D ^PRCHQUE
 ;
OUT1 K FLG,%,%Y,DIC,I,J,K,P,PRCFAA,PRCFPODA,X,Y,Z
 K BBFY,SUB,TAG,PRCFMO,PRCCCC,PRCCSCC
 K PO,PAT,PARAM1,NEW,LOOPVAL,LOOP,LOOP1,LOOP2,LOOP3,LOOP4,GECSFMS
 K OLD,OLDVAL,FMSMOD,FMSNO,FMSVENID,PODATE,NUMB,MOD,ERFLAG,STR2
 W !!
 Q
 ;
STACK ; Create entry in GECS Stack File
 D STACK^PRCFFU(1) ; pass 1 to force batch generation, set up CTL,BAT,DOC
 ;
SEGS ; Create entry into TMP($J for remaining segments
 K ^TMP($J,"PRCMO")
 N FMSINT S FMSINT=+PO
 S FMSMOD=$P(PRCFA("MOD"),U,1)
 D NEW^PRCFFU1(FMSINT,PRCFA("TT"),FMSMOD)
 ;
TRANSF ; Transfer nodes from TMP($J, into GECS Stack File
 N LOOP S LOOP=0 F  S LOOP=$O(^TMP($J,"PRCMO",GECSFMS("DA"),LOOP)) Q:'LOOP  D SETCS^GECSSTAA(GECSFMS("DA"),^(LOOP))
 K ^TMP($J,"PRCMO")
 ;
TRANSM ; Mark the document as queued for transmission
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 N P2 S P2=+PO_"/"_PRCFA("AMEND#"),$P(P2,"/",5)=$P($G(PRCFA("ACCPD")),U),$P(P2,"/",6)=PRCFA("OBLDATE")
 D SETPARAM^GECSSDCT(GECSFMS("DA"),P2)
 ;
POBAL ; Enter Obligation Data into Purchase Order Record
 I '$D(POESIG) I $D(PRCFA("PODA")),+PRCFA("PODA")>0 S POESIG=1
 N FMSDOCT S FMSDOCT=$P(PRCFA("REF"),"-",2)
 D EN7^PRCFFU41(PRCFA("TT"),FMSMOD,PRCFA("OBLDATE"),FMSDOCT) ; txn log
