LR7OB3 ;DALOI/DCM/JAH - Build message, backdoor from Lab order #;Sep 27, 2018@10:00:00
 ;;5.2;LAB SERVICE;**121,187,272,291,462,512,541**;Sep 27, 1994;Build 7
69 K ^TMP("LRX",$J)
 D 69^LR7OB69(ODT,SN) Q:'$D(^TMP("LRX",$J,69))  G OUT:'$D(DFN) D:LRFIRST FIRST^LR7OB0 S LRFIRST=0
SNEAK ;
 N Y,Y9,Y10,Y11,GRP,L1,L2,L3,END,LROR100
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
 ... ;CPRS order number:
 ... S LROR100=$P($G(^TMP("LRX",$J,69,IFN)),"^",7)
 ... ;
 ... ;Check to see if the CPRS order number matches the ORC order number
 ... I $P($P(@MSG@(ORCMSG),"|",3),"^")'=LROR100 D
 .... N LRORC
 .... S LRORC=$P(@MSG@(ORCMSG),"|",3)
 .... S $P(LRORC,"^")=LROR100
 .... S $P(@MSG@(ORCMSG),"|",3)=LRORC
 ... S (GRP,END)=0
 ... I '$G(CORRECT),$P(Z,"^",6) S GRP=1
 ... ;LR*5.2*512 change on line below so that status of each panel and/or
 ... ;atomic test is evaluated: added $P(Z1,"^",4):"F"
 ... ;Variables:
 ... ;  Z =  (1) Lab order number ^ (2) LRDFN ^ (3) accession ^ (4) draw time ^ 
 ... ;       (5) lab arrival time ^ (6) date/time results available (i.e. accession complete date)
 ... ;       (7) inverse date (i.e. file 63 subscript corresponding to this accession)
 ... ;
 ... ;  Z1 = (1) test number ^ (2) test urgency ^ (3) technologist ^ (4) complete date/time ^
 ... ;        
 ... S X8=$S($G(CORRECT):"C",$P(Z,"^",6):$S(GRP:"F",1:"I"),$P(Z1,"^",4):"F",$P(Z,"^",5):"I",1:"O") ;Result Status
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
 ... ;LR*5.2*512 commenting out line below
 ... ;because a single result status should not update 
 ... ;the overall order status in the ORC segment
 ... ;LR*5.2*541: invoking line below only if:
 ... ;            (1) not in full edit mode logic (as in LEDI or if user elects not to do full edit)
 ... ;            (2) and if status of a test is preliminary. Any preliminary test should cause an
 ... ;                order to remain at "active" status.
 ... I $D(LREDITTYPE),LREDITTYPE<3 S:X8="P" X8="I" D AX8
 ... I $L($P(Z1,"^",18)) S X=$P(@MSG@(ORCMSG),"|",4),Y=$P(X,"^",2),X=$P(X,"^")_$P(Z1,"^",18) S $P(@MSG@(ORCMSG),"|",4)=X_"^"_Y ;Append 63 ptr to placer ID
 ... I "SPCYEM"[$P($G(X),";",4)&($L($P(X,";",5))) S $P(@MSG@(ORCMSG),"|",4)=X_"^LRAP"  ;;* added to correct result update to CPRS where the package reference was not being updated properly for AP results
 ... ; X=ORD#;LRODT;LRSN;LRSS;LRIDT, indirect set of ^TMP("LRAP",$J
 ... S X10=$P(Z1,"^",14) ;Theraputic flag
 ... S X11=$P(Z1,"^",12) ;Verified by
 ... S CTR=CTR+1,COBX=COBX+1 D OBX^LR7OU01(CTR)
 .. I $O(^TMP("LRX",$J,69,IFN,63,0)),$O(^("N",0)) S CTR=CTR+1 D NTE^LR7OU01("","L","^TMP(""LRX"",$J,69,"_IFN_",63,""N"",",CTR)
 . ;
 . ;Note to anyone researching this routine in the future:
 . ;The lines below are not called because of the quit after the loop at SNEAK+3
 . ;(not deleting them in case the lines are needed in the future.)
 . ;
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
 ;LR*5.2*512 added three lines below for panels
 ;Routine LRVER3A sets ^TMP("LR",$J,"PANEL",order number)=status (final or active)
 I $G(LROR100)]"",$D(^TMP("LR",$J,"PANEL",LROR100)) D  Q
 . Q:$P($P(@MSG@(ORCMSG),"|",3),"^")'=LROR100
 . S $P(@MSG@(ORCMSG),"|",6)=$S($G(^TMP("LR",$J,"PANEL",LROR100)):"CM",1:"SC")
 I X8="F"!(X8="C")!($G(LRSTATI)=2) S $P(@MSG@(ORCMSG),"|",6)="CM" Q  ;Order Status
 I X8="I" S $P(@MSG@(ORCMSG),"|",6)="SC"
 Q
