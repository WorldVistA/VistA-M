LR7OB3 ;DALOI/DCM/JAH - Build message, backdoor from Lab order # ;8/10/04
 ;;5.2;LAB SERVICE;**121,187,272,291**;Sep 27, 1994
69 K ^TMP("LRX",$J)
 D 69^LR7OB69(ODT,SN) Q:'$D(^TMP("LRX",$J,69))  G OUT:'$D(DFN) D:LRFIRST FIRST^LR7OB0 S LRFIRST=0
SNEAK ;
 N Y,Y9,Y10,Y11,GRP,L1,L2,L3,END
 S IFN=0 F  S IFN=$O(^TMP("LRX",$J,69,IFN)) Q:IFN<1  S (COBR,COBX)=0 D
 . I $O(^TMP("LRX",$J,69,IFN,68,0)) S Z=^TMP("LRX",$J,69,IFN,68) D  Q
 .. S IFN1=0 F  S IFN1=$O(^TMP("LRX",$J,69,IFN,68,IFN1)) Q:IFN1<1  S Z1=^TMP("LRX",$J,69,IFN,68,IFN1) D
 ... S (Y9,Y10,Y11)="" I $P($G(^LAB(60,+Z1,64)),"^") S Y9=$P(^(64),"^"),Y10=$P(^LAM(Y9,0),"^"),Y9=$P(^(0),"^",2),Y11="99NLT"
 ... S X1=$$UVID^LR7OU0($P(Z1,"^"),$P(^TMP("LRX",$J,69),"^",10),Y9,Y11,Y10,.MSG,$G(SS))
 ... S X2=$$HL7DT^LR7OU0($P(Z,"^",4)) ;Obs Start date
 ... S X3=$$ACTCODE^LR7OU0($P(^TMP("LRX",$J,69),"^",4)) ;Specimen Act Code
 ... S X4=$$HL7DT^LR7OU0($P(Z,"^",5)) ;Specimen Received D/T
 ... S X5=$$SAMP^LR7OU0($P(^TMP("LRX",$J,69),"^",3),$P(^TMP("LRX",$J,69),"^",10)) ;Specimen Source
 ... S X6=$P(Z,"^",3) ;Filler Fld 1 (Accession)
 ... S X7=$$HL7DT^LR7OU0($P(Z,"^",6)) ;Results rpt/Sts Change D/T
 ... S (GRP,END)=0
 ... I '$G(CORRECT),$P(Z,"^",6) S GRP=1
 ... S X8=$S($G(CORRECT):"C",$P(Z,"^",6):$S(GRP:"F",1:"I"),$P(Z,"^",5):"I",1:"O") ;Result Status
 ... D AX8
 ... S X10=$P(^TMP("LRX",$J,69),"^",7),$P(@MSG@(3),"|",4)=X10 ;Routing Location
 ... S X9="^^^^^"_$$URG^LR7OU0($P(^TMP("LRX",$J,69,IFN),"^",2))
 ... I $O(LINK(0)) S CTR=CTR+1 D NTE^LR7OU01(2,"L","LINK(",CTR) K LINK
 ... I $O(^TMP("LRX",$J,69,IFN,"NC",0)) S CTR=CTR+1 D NTE^LR7OU01("","L","^TMP(""LRX"",$J,69,"_IFN_",""NC"",",CTR)
 ... I CONTROL'="SN" S CTR=CTR+1 D NTE^LR7OU01("","P","^TMP(""LRX"",$J,69,"_IFN_",""N"",",CTR)
 ... I CONTROL'="SN" S CTR=CTR+1 D NTE^LR7OU01("","P","^TMP(""LRX"",$J,69,""N"",",CTR)
 ... S CTR=CTR+1,COBR=COBR+1,OBRMSG=CTR D OBR^LR7OU01(CTR)
 ... S CTR=CTR+1 D SDG1^LRBEBA2(IFN,.CTR,.MSG)
 ... I CONTROL="SN" S CTR=CTR+1 D NTE^LR7OU01("","P","^TMP(""LRX"",$J,69,"_IFN_",""N"",",CTR)
 ... I CONTROL="SN" S CTR=CTR+1 D NTE^LR7OU01("","P","^TMP(""LRX"",$J,69,""N"",",CTR)
 .. S IFN1=0 F  S IFN1=$O(^TMP("LRX",$J,69,IFN,63,IFN1)) Q:IFN1<1  S Z1=^TMP("LRX",$J,69,IFN,63,IFN1) D
 ... S X1=$S($L($P(Z1,"^",8)):$P(Z1,"^",8),1:"ST") ;Value type
 ... S X2=$$UVID^LR7OU0($P(Z1,"^"),$P(^TMP("LRX",$J,69),"^",10),$P(Z1,"^",9),$P(Z1,"^",11),$P(Z1,"^",10),.MSG,$G(SS))
 ... S X3=$P(Z1,"^",7) ;Obs SubID
 ... S X4=$P(Z1,"^",2) S:$L($P(Z1,"^",9))&(MSG["LRAP") X4=$P(Z1,"^",9)_"^"_$P(Z1,"^",2)_"^"_$P(Z1,"^",10) ;Value
 ... S X5=$P(Z1,"^",4) ;Units
 ... S X6=$P(Z1,"^",5) ;Ref Ranges
 ... S X7=$$FLAG^LR7OU0($P(Z1,"^",3)) ;Flag
 ... S (GRP,END)=0
 ... I '$G(CORRECT),$P(Z1,"^",6)="F"!($P(Z,"^",6)) S GRP=1
 ... S X8=$S($G(CORRECT):"C",$P(Z1,"^",6)="F"!($P(Z,"^",6)):$S(GRP:"F",1:"I"),$L($P(Z1,"^",6)):$S($P(Z1,"^",6)'="F":$P(Z1,"^",6),1:"R"),1:"R")
 ... S $P(@MSG@(OBRMSG),"|",26)=X8 ;Result Status
 ... I @MSG@(OBRMSG)'?.E1"|",$O(@MSG@(OBRMSG,0))]"" S @MSG@(OBRMSG)=@MSG@(OBRMSG)_"|" ;RLM
 ... D AX8
 ... I $L($P(Z1,"^",18)) S X=$P(@MSG@(ORCMSG),"|",4),Y=$P(X,"^",2),X=$P(X,"^")_$P(Z1,"^",18) S $P(@MSG@(ORCMSG),"|",4)=X_"^"_Y ;Append 63 ptr to placer ID
 ... S X10=$P(Z1,"^",14) ;Theraputic flag
 ... S X11=$P(Z1,"^",12) ;Verified by
 ... S CTR=CTR+1,COBX=COBX+1 D OBX^LR7OU01(CTR)
 .. I $O(^TMP("LRX",$J,69,IFN,63,0)),$O(^("N",0)) S CTR=CTR+1 D NTE^LR7OU01("","L","^TMP(""LRX"",$J,69,"_IFN_",63,""N"",",CTR)
 . S Z=$G(^TMP("LRX",$J,69,IFN))
 . S (Y9,Y10,Y11)="" I $P($G(^LAB(60,+Z,64)),"^") S Y9=$P(^(64),"^"),Y10=$P(^LAM(Y9,0),"^"),Y9=$P(^(0),"^",2),Y11="99NLT"
 . S X1=$$UVID^LR7OU0($P(Z,"^"),$P(^TMP("LRX",$J,69),"^",10),Y9,Y11,Y10,.MSG,$G(SS))
 . S X2="" ;Obs Start date
 . S X3=$$ACTCODE^LR7OU0($P(^TMP("LRX",$J,69),"^",4)) ;Specimen Action Code
 . S X4="" ;Specimen Received D/T
 . S X5=$$SAMP^LR7OU0($P(^TMP("LRX",$J,69),"^",3),$P(^TMP("LRX",$J,69),"^",10)) ;Specimen Source
 . S X6="" ;Filler Fld 1 (Accession)
 . S X7="" ;Results rpt/Sts change D/T
 . S X8="O"
 . I $G(CONTROL)="RE",$P(Z,"^",8) S X8=$S($G(CORRECT):"C",1:"F"),$P(@MSG@(ORCMSG),"|",6)="CM" ;Status
 . S X10=$P(^TMP("LRX",$J,69),"^",7),$P(@MSG@(3),"|",4)=X10 ;Routing Location
 . S X9="^^^^^"_$$URG^LR7OU0($P($G(^TMP("LRX",$J,69,IFN)),"^",2))
 . I $O(LINK(0)) S CTR=CTR+1 D NTE^LR7OU01(2,"L","LINK(",CTR) K LINK
 . I $O(^TMP("LRX",$J,69,IFN,"NC",0)) S CTR=CTR+1 D NTE^LR7OU01("","L","^TMP(""LRX"",$J,69,"_IFN_",""NC"",",CTR)
 . I CONTROL'="SN" S CTR=CTR+1 D NTE^LR7OU01("","P","^TMP(""LRX"",$J,69,"_IFN_",""N"",",CTR)
 . I CONTROL'="SN" S CTR=CTR+1 D NTE^LR7OU01("","P","^TMP(""LRX"",$J,69,""N"",",CTR)
 . S CTR=CTR+1,COBR=COBR+1,OBRMSG=CTR D OBR^LR7OU01(CTR)
 . S CTR=CTR+1 D SDG1^LRBEBA2(IFN,.CTR,.MSG)
 . I CONTROL="SN" S CTR=CTR+1 D NTE^LR7OU01("","P","^TMP(""LRX"",$J,69,""N"",",CTR)
 . I CONTROL="SN" S CTR=CTR+1 D NTE^LR7OU01("","P","^TMP(""LRX"",$J,69,"_IFN_",""N"",",CTR)
OUT ;Exit here
 K ^TMP("LRX",$J)
 Q
AX8 ;Modify order status based on result status
 I X8="F"!(X8="C")!($G(LRSTATI)=2) S $P(@MSG@(ORCMSG),"|",6)="CM" Q  ;Order Status
 I X8="I" S $P(@MSG@(ORCMSG),"|",6)="SC"
 Q
