SCCVEGD1 ;ALB/JRP,TMP - DSPLY RSLTS 4 ENCNTR CNVRSN GLBL ESTMTR;15-JAN-96
 ;;5.3;Scheduling;**211**;Aug 13, 1993
DSPGLBL(PTRLOG,OUTARRAY,STARTLN) ;BUILD DISPLAY FOR GLOBAL ESTIMATES
 ;INPUT  : PTRLOG - Pointer to entry in SCHEDULING CONVERSION LOG
 ;                  file (#404.98) that estimation is for
 ;         OUTARRAY - Array to build display into (full global reference)
 ;                      Defaults to ^TMP("SCCVEG",$J,"DISPLAY")
 ;         STARTLN - The line # in the display where this portion starts
 ;                   [optional]
 ;OUTPUT : N - Number of lines in this display
 ;         OUTARRAY will be returned as follows
 ;           OUTARRAY(x,0) = Line x of display
 ;
 N ESTGLBL,GLOBAL,INFO,EQUALS,LINE,HEADER,FOOTER,TMP,DASHES,SD0,TOTAL
 N DIC,X,DA,DR,DIQ,SCBLK,SC207
 ;
 Q:('$D(^SD(404.98,+$G(PTRLOG),0))) 0
 ;
 S:$G(OUTARRAY)="" OUTARRAY="^TMP(""SCCVEG"","_$J_",""DISPLAY"")"
 S LINE=+$G(STARTLN)
 S DASHES="",$P(DASHES,"-",81)="",EQUALS="",$P(EQUALS,"=",81)=""
 ;
 S TMP=$G(^SD(404.98,PTRLOG,2)),SD0=$G(^(0))
 S TOTAL("SCE","NEW")=+$P(TMP,"^",7)
 S TOTAL("SCE","UPD")=$P(TMP,"^",8)-$P(TMP,"^",7)
 S TOTAL("AUPNVSIT")=+$P(TMP,"^",8)
 S TOTAL("AUPNVPRV")=+$P(TMP,"^",9)
 S TOTAL("AUPNVPOV")=+$P(TMP,"^",10)
 S TOTAL("AUPNVCPT")=+$P(TMP,"^",11)
 ;
 ;Get estimated global growths
 S DIC=404.98,DR="207:211",DIQ="ESTGLBL",DIQ(0)="IE",DA=PTRLOG
 D EN^DIQ1
 ;
 S HEADER(1)="+"_$E(EQUALS,1,54)_"+"
 S TMP=$$CENTER^SCCVEGU0("ESTIMATED GLOBAL BLOCK GROWTH",54)
 S HEADER(2)="|"_TMP_"|"
 S TMP=$$CENTER^SCCVEGU0($$FMTE^XLFDT($P(SD0,U,3),"5Z")_" - "_$$FMTE^XLFDT($P(SD0,U,4),"5Z"),54)
 S HEADER(3)="|"_TMP_"|",HEADER(4)="|"_$E(DASHES,1,54)_"|",HEADER(5)="|"
 S HEADER(6)="+"
 F TMP=1:1:5 S HEADER(6)=HEADER(6)_$E(EQUALS,1,10)_"+"
 ;
 S FOOTER(1)="+"
 F TMP=1:1:5 S FOOTER(1)=FOOTER(1)_$E(EQUALS,1,10)_"+"
 ;
 ;Build display for global estimates
 S INFO="|"
 F X=207:1:211 D
 . S INFO=INFO_" "_$J(+$G(ESTGLBL(404.98,PTRLOG,X,"E")),8,0)_" |"
 F X="SCE","AUPNVSIT","AUPNVPRV","AUPNVPOV","AUPNVCPT" D
 . S HEADER(5)=HEADER(5)_$$CENTER^SCCVEGU0(X,10)_"|"
 ;
 ;Put lines into display
 F TMP=1:1 Q:('$D(HEADER(TMP)))  S LINE=LINE+1,@OUTARRAY@(LINE,0)=HEADER(TMP)
 S LINE=LINE+1,@OUTARRAY@(LINE,0)=INFO
 F TMP=1:1 Q:('$D(FOOTER(TMP)))  S LINE=LINE+1,@OUTARRAY@(LINE,0)=FOOTER(TMP)
 ;
 ; ending text
 ;
 S FOOTER="**"_$J("",52)_"**"
 S TMP=" The estimate algorithm factors in global"
 S LINE=LINE+1,@OUTARRAY@(LINE,0)=$$INSERT^SCCVEGU0(TMP,FOOTER,5)
 S TMP=" pointer data and data requirements (including"
 S LINE=LINE+1,@OUTARRAY@(LINE,0)=$$INSERT^SCCVEGU0(TMP,FOOTER,5)
 S TMP=" cross references) at a 70% efficiency level."
 S LINE=LINE+1,@OUTARRAY@(LINE,0)=$$INSERT^SCCVEGU0(TMP,FOOTER,5)
 S SCBLK=$$BLKSIZE^SCCVEGU1()
 S SC207=+$G(ESTGLBL(404.98,PTRLOG,207,"E"))
 S TMP=" Each block represents "_SCBLK_" bytes."
 S LINE=LINE+1,@OUTARRAY@(LINE,0)=$$INSERT^SCCVEGU0(TMP,FOOTER,5)
 S TMP=" SCE Example: "_SC207_" x "_SCBLK_" = "_$FN(SC207*SCBLK,",")_" bytes."
 S LINE=LINE+1,@OUTARRAY@(LINE,0)=$$INSERT^SCCVEGU0(TMP,FOOTER,5)
 S LINE=LINE+1,@OUTARRAY@(LINE,0)="+"_$E(EQUALS,1,54)_"+"
 ;
 Q (LINE-STARTLN)
 ;
