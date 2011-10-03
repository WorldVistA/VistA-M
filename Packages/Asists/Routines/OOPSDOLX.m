OOPSDOLX ;WIOFO/CAH-Extract data for DOL XMIT ;3/15/00
 ;;2.0;ASISTS;**8,11,17**;Jun 03, 2002;Build 2
 ;
 ;Retrieves data from ^OOPS(2260, for CA1/CA2
 ;Variables used
 ;  OOPDA-----IEN of Case
 ;  OOPSAR----Array holding data
 ;  OPL-------Last line number written in message text
 ;  XMZ-------Message Number
 ; Entry
 N ARR,KK,FN,FORM,MESS,NAME,OPC,OPSAR,OPT,OPX,SEG,OOPSAR,FYM,MON
 S RSIZE=0,ARR=0
 S OOPSAR(0)=$$UP^OOPSUTL4($G(^OOPS(2260,OOPDA,0)))
 S OOPSAR("2162A")=$$UP^OOPSUTL4($G(^OOPS(2260,OOPDA,"2162A")))
 S OOPSAR("2162B")=$$UP^OOPSUTL4($G(^OOPS(2260,OOPDA,"2162B")))
 S OOPSAR("2162D")=$$UP^OOPSUTL4($G(^OOPS(2260,OOPDA,"2162D")))
 S OOPSAR("2162ES")=$$UP^OOPSUTL4($G(^OOPS(2260,OOPDA,"2162ES")))
OP01 ; Seg OP01
 K OPX,DTINJ
 S OPX="OP01^"_$TR($P(OOPSAR(0),U),"-")
 ;V2_P15 - name fix to remove spaces and dashes
 S NAME=$$NAMEFIX^OOPSDOLX($P(OOPSAR(0),U,2))
 S OPX=OPX_U_$E($P(NAME,U,1)_","_$P(NAME,U,2)_" "_$P(NAME,U,3),1,35)
 S OPX=OPX_U_$P(OOPSAR(0),U,7)_U_$TR($P(OOPSAR("2162A"),U),"-")
 ; patch 11 - send field 109 if CA1, field 214 if CA2
 ;            left old code, commented below
 S FORM=$$GET1^DIQ(2260,OOPDA,52,"I")
 I FORM=1 D
 . S DTINJ=$$GET1^DIQ(2260,OOPDA,109,"I")
 . S OPX=OPX_U_$$DC^OOPSUTL3($P(DTINJ,"."))
 . S Y=DTINJ D DD^%DT S Y=$P($TR(Y,":",""),"@",2),OPX=OPX_U_Y
 I FORM=2 D
 . S DTINJ=$$GET1^DIQ(2260,OOPDA,214,"I")
 . S OPX=OPX_U_$$DC^OOPSUTL3($P(DTINJ,"."))_U
 K DTINJ
 ;
 ; S OPX=OPX_U_$$DC^OOPSUTL3($P($P(OOPSAR(0),U,5),"."))
 ; I $$GET1^DIQ(2260,OOPDA,52,"I")=1 D
 ; .S Y=$P(OOPSAR(0),U,5) D DD^%DT S Y=$P($TR(Y,":",""),"@",2)
 ; .S OPX=OPX_U_Y
 ; I $$GET1^DIQ(2260,OOPDA,52,"I")=2 S OPX=OPX_U
 S MON=$E($P(OOPSAR(0),U,5),4,5)
 S FYM=$S(MON=10:1,MON=11:2,MON=12:3,MON="01":4,MON="02":5,MON="03":6,MON="04":7,MON="05":8,MON="06":9,MON="07":10,MON="08":11,MON="09":12,1:0)
 S OPX=OPX_U_$E($P(OOPSAR(0),U),1,4)_U_$E("00",$L(FYM)+1,2)_FYM
 ;V2_P15 - name fix to remove spaces and dashes (have name from above)
 S OPX=OPX_U_$P(NAME,U,1)_U_$P(NAME,U,2)_U_$P(NAME,U,3)
 S OPX=OPX_"^^"_$P(OOPSAR("2162A"),U,4)_U_$P(OOPSAR("2162A"),U,5)_U_$$GET1^DIQ(2260,OOPDA,"10:1")_U_$E($P(OOPSAR("2162A"),U,7),1,5)
 S OPX=OPX_U_$TR($P(OOPSAR("2162A"),U,8),"(,)-^*/# ")
 S OPX=OPX_U_$E($$GET1^DIQ(2260,OOPDA,7,"E"))_U_$$DC^OOPSUTL3($P(OOPSAR("2162A"),U,2))
 ; Patch 5 llh - changed next line from "70:.01" to 331
 S OPX=OPX_U_$$GET1^DIQ(2260,OOPDA,331)
 S OPX=OPX_"^^"_$P(OOPSAR("2162A"),U,10)_"^|"
 D STORE
 I $P(OOPSAR(0),U,7)=1 D ^OOPSDOL1
 I $P(OOPSAR(0),U,7)=2 D ^OOPSDOL2
EXIT ; Loads the message and Quits the routine
 I RSIZE+MSIZE>30000 D
 .S END=$P($P(^OOPS(2260,OPAST,0),U),"-",2)
 .D SEND^OOPSDOL,CREATE^OOPSDOL
 .S (START,END)=""
 F I=1:1:ARR I $G(MESS(I))'="" D
 .S OPL=OPL+1,^XMB(3.9,XMZ,2,OPL,0)=MESS(I)
 .I START="" S START=$P($P(OOPSAR(0),U),"-",2)
 S MSIZE=MSIZE+RSIZE
 K ARR,MESS,OPDT,RSIZE
 Q
STORE ;
 S ARR=ARR+1,MESS(ARR)=OPX
 S RSIZE=RSIZE+$L(OPX)+2
 Q
WP ; Word Processing Fields
 K OPX
 N DIWL,DIWR,DIWF,OPGLB,OPNODE,X,OPI,NUM,WPAR,F332,F347
 S NUM=0,OPI=0
 K ^UTILITY($J,"W")
 S DIWL=1,DIWR="",DIWF="|C132"
 ; Patch 5 llh - added logic to concatenate field 332 to WP field (165)
 I OPFLD=165 D
 .S F332=$$GET1^DIQ(2260,OOPDA,"332:1")
 .I $G(F332)'="" S X=F332 D ^DIWP
 .;v2 p11 - concatenate Reason for Dispute to fld 165 in block 36
 .S F347=$$GET1^DIQ(2260,OOPDA,"347:.01")
 .I $G(F347)'="" S X=F347 D ^DIWP
 S OPNODE=$P($$GET1^DID(2260,OPFLD,"","GLOBAL SUBSCRIPT LOCATION"),";")
 S OPI=0 F  S OPI=$O(^OOPS(2260,OOPDA,OPNODE,OPI)) Q:'OPI  S X=$G(^OOPS(2260,OOPDA,OPNODE,OPI,0)) D
 . I $TR(X," ","")="" Q
 . I X]"" D ^DIWP
 S OPT=$G(^UTILITY($J,"W",1))+0
 ; If OPT=0 then no data in ^UTILITY($J,"W") so quit
 I 'OPT Q
 ; Need to set up an array to see if max segments exceeded
 I OPT S OPI=0 F OPC=1:1:OPT S OPI=$O(^UTILITY($J,"W",1,OPI)) Q:'OPI  D
 . S NUM=NUM+1
 . S WPAR(NUM)=SEG_U_OPC_U_OPT_U_$$UP^OOPSUTL4($E(^UTILITY($J,"W",1,OPI,0),1,132))_"^|"
 ; Fileman puts spaces at end of last node - need to strip off.
 S STRP=$P(WPAR(NUM),U,4)
 F K=$L(STRP):-1:1 Q:$E(STRP,K)'=" "  S STRP=$E(STRP,1,(K-1))
 S $P(WPAR(NUM),U,4)=STRP
 K STRP
 I NUM>4 D  ; if max segments exceeded fix here
 . N BEG,END,STR,TMP
 . F I=1:1:NUM S STR(I)=$P(WPAR(I),U,4)
 . F I=1:1:(NUM-1) S TMP=132-$L(STR(I)) I TMP D
 .. S END=$E(STR(I),$L(STR(I))),BEG=$E(STR(I+1))
 .. ; put a blank in if needed
 .. I $A(END)'=32,$A(BEG)'=32 S STR(I)=STR(I)_" ",TMP=TMP-1
 .. S STR(I)=STR(I)_$E(STR(I+1),1,TMP)
 .. S STR(I+1)=$E(STR(I+1),(TMP+1),$L(STR(I+1)))
 .. I $L(STR(I)) S $P(WPAR(I),U,4)=STR(I)
 .. I '$L(STR(I)) K WPAR(I)
 . I '$L(STR(NUM)) K WPAR(NUM)
 ; load temporary array into MESS array to load into Mailman message
 S NSEG=$O(WPAR(""),-1)
 S NUM=0 F  S NUM=$O(WPAR(NUM)) Q:NUM=""  D
 . S OPX=WPAR(NUM),$P(OPX,U,3)=NSEG
 . S ARR=ARR+1,MESS(ARR)=OPX
 . S RSIZE=RSIZE+$L(OPX)+2
 K ^UTILITY($J,"W"),X,OPFLD,NSEG
 Q
NAMEFIX(NAME) ; strips dashes and spaces out of name and returns it in
 ;  the format lastname, firstname middleinitial
 ;
 ;  Input:  Name - name in the format LN, FN MI
 ; Output:  Name - name in the format LN, FN MI with embedded spaces
 ;                 and dashes removed
 I $G(NAME)="" Q ""
 N FN,KK,LN,MI
 S LN=$P($TR(NAME,"- ",""),","),FN=$P($TR(NAME,"-",""),",",2)
 ; remove any leading spaces
 F KK=1:0:1 Q:$E(LN,KK)'=" "  S LN=$E(LN,KK+1,$L(LN))
 F KK=1:0:1 Q:$E(FN,KK)'=" "  S FN=$E(FN,KK+1,$L(FN))
 I $L(FN," ")=1 S MI=""
 I $L(FN," ")=2 D
 .S FN=$P(FN," "),MI=$P(FN," ",2)
 ;how to collaspe first and middle names with extra spaces is
 ;totally arbitary - no way to know which spaces go w/which name
 I $L(FN," ")>2 D
 .S MI=$TR($P(FN," ",3,$L(FN," "))," ","")
 .S FN=$TR($P(FN," ",1,2)," ","")
 Q $E(LN,1,20)_U_$E(FN,1,10)_U_$E(MI,1,10)
