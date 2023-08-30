XPDANLYZ5 ;OAK/RSF- BUILD ANALYZER ;10/28/22
 ;;8.0;KERNEL;**782**;Jul 10, 1995;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
FILEME(ITEM) ;Output some build files
 Q:$G(ITEM)<1
 N XPFNAME,RME,NB S RME("*")="-",NB=$$REPLACE^XLFSTR(XPDBN,.RME)
 I ITEM=1 S XPFNAME1="XPBA_Anal_"_NB_"_"_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)_".TXT",XPFNAME=XPFNAME1
 I ITEM=3 S XPFNAME3="XPBA_Spell_"_NB_"_"_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)_".TXT",XPFNAME=XPFNAME3
 I ITEM=4 S XPFNAME4="XPBA_SQA_"_NB_"_"_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)_".TXT",XPFNAME=XPFNAME4
 N POP
 D OPEN^%ZISH("XPBA",XPPATH,XPFNAME,"W")
 I POP>0 D  Q
 . W:XPDR=3 !,"Could not open "_XPFNAME_". Unable to write to file. " Q
 U IO
 I ITEM=1 D BA I $D(XPBA1) N LL S LL=0 F  S LL=$O(XPBA1(LL)) Q:'LL  W !,XPBA1(LL)
 I ITEM=3 D SPELLST
 I ITEM=4 D SQAMM  N LL S LL=0 F  S LL=$O(XPMM(LL)) Q:'LL  W !,XPMM(LL)   ;D SQALINES
 D CLOSE^%ZISH("XPBA")
 Q
 ;
SPELLST ;
 Q:'$D(XPDMM)
 W !,"Text for Review/Spell Check, Build "_XPDBN_"; "_$$FMTE^XLFDT($$DT^XLFDT,"2D"),!
 N TTT S TTT=0 F  S TTT=$O(XPDMM(TTT)) Q:'TTT  W !,XPDMM(TTT)
 Q
 ;
BA ;SET BA ARRAY
 N TMPT,LNUM Q:'$D(XPDW)
 N RR S RR=0,LNUM=0 F  S RR=$O(XPDW(RR)) Q:'RR  D
 . I $L(XPDW(RR))<80 S LNUM=LNUM+1,XPBA1(LNUM)=XPDW(RR)
 . E  D CUTME(XPDW(RR),1)
 I $D(XPBA1) D
 . S LNUM=LNUM+1,XPBA1(LNUM)=""
 . S LNUM=LNUM+1,XPBA1(LNUM)=""
 . S LNUM=LNUM+1,XPBA1(LNUM)=$TR($J("=",79)," ","=")
 . S LNUM=LNUM+1,XPBA1(LNUM)=""
 . S LNUM=LNUM+1,XPBA1(LNUM)=" This build may include references to components (i.e. Routines,"
 . S LNUM=LNUM+1,XPBA1(LNUM)=" Globals, etc.) outside the build namespace. Review and validate "
 . S LNUM=LNUM+1,XPBA1(LNUM)=" that all appropriate Integration Control Registrations (ICRs) "
 . S LNUM=LNUM+1,XPBA1(LNUM)=" exist for each external reference."
 . S LNUM=LNUM+1,XPBA1(LNUM)=""
 . S LNUM=LNUM+1,XPBA1(LNUM)=$TR($J("=",79)," ","=")
 Q 
CUTME(LTXT,IND) ;5 MAY BE OPEN
 ;get any preliminary spacing
 N RSF,RR S RSF="" F RR=1:1:$L(LTXT) Q:'($E(LTXT,RR)?1" ")  S RSF=RSF_$E(LTXT,RR)
 N T0,T1,T2 S T0=LTXT,T1="",T2=""
 ;REMOVE/SAVE PRELIMINARY SPACING
 I RR>0 S T0=$E(LTXT,RR,99999)
 N AL,LL,I S AL=(80-$L(RSF))  ;THIS IS THE LINE LENGTH ACCOUNTING FOR THE PRELIMINARY SPACES
 S:IND>2 AL=AL-1
A1 ;
 F I=AL:-1:(AL-20) D  Q:T1]""
 . I $E(T0,I)?1P S T1=RSF_$E(T0,1,I),T2=$E(T0,(I+1),9999) Q
 . Q:T1]""
 Q:$L(T1)<2&(T1'?1(1U,1P))
 S:IND=1 LNUM=LNUM+1,XPBA1(LNUM)=T1
 ;W:IND=2 !,T1
 S:IND=3 MCNT=MCNT+1,XPMM(MCNT)=T1
 S:IND=4 TCNT=TCNT+1,XPDKT(NSP,TWOP,TCNT)=T1
 S:IND=5 TCNT=TCNT+1,XPDTRR(NSP,TWOP,TCNT)=T1
 Q:$G(T2)']""
 N T3,E1 S T3=RSF_T2,E1=0
 I IND=1 D  G:E1 A1
 . I $L(T3)<80 S LNUM=LNUM+1,XPBA1(LNUM)=T3 Q
 . I $L(T3)>79 S T0=T2 K T1,T2,T3 S T1="",T2="",E1=1 Q
 I IND=3 D  G:E1 A1
 . ;I $L(T3)+13<79 S MCNT=MCNT+1,XPMM(MCNT)=$J(" ",12)_T3 Q
 . ;I $L(T3)+13>78 S T0=$J(" ",12)_T2 K T1,T2,T3 S T1="",T2="",E1=1 Q
 . I $L(T3)+13<79 S MCNT=MCNT+1,XPMM(MCNT)=$J(" ",ML+1)_T3 Q
 . I $L(T3)+13>78 S T0=$J(" ",ML+1)_T2 K T1,T2,T3 S T1="",T2="",E1=1 Q 
 I IND=4 D  G:E1 A1
 . N PAD S PAD=24 ;($L(ROU)+14)
 . I $L(T3)+PAD<79 S TCNT=TCNT+1,XPDKT(NSP,TWOP,TCNT)=$J(" ",PAD)_T3 Q
 . I $L(T3)+PAD>78 S T0=$J(" ",PAD)_T2 K T1,T2,T3 S T1="",T2="",E1=1 Q
 I IND=5 D  G:E1 A1
 . N PAD S PAD=24
 . I $L(T3)+PAD<79 S TCNT=TCNT+1,XPDTRR(NSP,TWOP,TCNT)=$J(" ",PAD)_T3 Q
 . I $L(T3)+PAD>78 S T0=$J(" ",PAD)_T2 K T1,T2,T3 S T1="",T2="",E1=1 Q
 Q
 ;
FSHOW ; called from menu and deletes Build Analyzer text files
 N XPPATH,XPDEL,J,END S XPPATH=$$PWD^%ZISH(),END=0
 W @IOF S DIR(0)="F",DIR("A",1)="Set the path to find the .TXT files",DIR("A",2)="or accept the standard default."
 S DIR("A",3)="",DIR("A")="PATH",DIR("B")=XPPATH
 S DIR("?",1)="Full path specification where XPBA* files reside. Path up to, but not including,"
 S DIR("?",2)="the filename. This includes any trailing slashes or brackets."
 S DIR("?")=" "
 D ^DIR S:$D(DTOUT) END=1 S:$D(DIRUT) END=1 Q:END
 S XPPATH=Y
 K FILESPEC,XPFILE,XPF S FILESPEC("XPBA*")=""
 S Y=$$LIST^%ZISH("","FILESPEC","XPFILE")
 W !!,"Build Analyzer text files:",! N K,L S K=" ",L=0 F  S K=$O(XPFILE(K)) Q:K']""  S L=L+1,XPF(L)=K,XPDEL(K)="" W !,$J(L,3),". ",K
 I $G(L)<1 W @IOF,"There are no Build Analyzer files to delete.",!!  Q 
 W !! K DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("?")="Respond YES to delete the files listed above."
 S DIR("A")="Delete all the files above"
 D ^DIR Q:$D(DTOUT)  Q:$D(DIRUT)
 I Y=1 D  G:END X1
 . S J=$$DEL^%ZISH("",$NA(XPDEL))
 . I J=1 W !,"Deletions completed." S END=1 Q
 . I J=0 W !,"Unable to complete deletions." S END=1 Q
 W !! K DIR S DIR(0)="L^1:"_L
 S DIR("A")="Select number of file or files to delete"
 D ^DIR G:$D(DTOUT) X1 G:$D(DIRUT) X1
 N DME,DARR S DME="" I Y S DME=$$TRIM^XLFSTR(Y,"R",",") D
 . N PCE,KK F KK=1:1:$L(DME,",") S PCE=$P(DME,",",KK) Q:'$G(PCE)  S DARR(XPF(PCE))=""
 I $D(DARR) N J S J=$$DEL^%ZISH(XPPATH,$NA(DARR))
 I J=1 W !,"Deletions completed."
 I J=0 W !,"Unable to complete deletions."
X1 K FILESPEC,XPFILE,XPF Q
 ;
PB1 ;FOR BUILD
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=""
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=XPDARR("BUILD",XPDBB,"NAME")_" BUILD OVERVIEW"
 S XPDW(XPDCNT)=XPDW(XPDCNT)_$$RJ^XLFSTR($$FMTE^XLFDT($$NOW^XLFDT),79-$L(XPDW(XPDCNT))," ")
 S XPDHR(XPDCNT)="BUILD OVERVIEW"
 S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=$TR($J(" ",79)," ","-")
 N TMPTXT,XPDTX1
 S XPDCS("FILES")="1"
 N XPDTX2 S XPDTX2=" " F  S XPDTX2=$O(XPDCS(XPDTX2)) Q:XPDTX2']""  D
 . S XPDTX1=XPDTX2_$J(" ",(40-$L(XPDTX2)))
 . S TMPTXT="Not Included"
 . I '$D(XPDCAR(XPDCS(XPDTX2),0)) S TMPTXT="Not Included"
 . E  I XPDCAR(XPDCS(XPDTX2),0)]"" S TMPTXT="Included"
 . I XPDTX2="FILES",$D(^XPD(9.6,XPDBB,4,"B"))>1 S TMPTXT="Included"
 . S XPDCNT=XPDCNT+1,XPDW(XPDCNT)=XPDTX1_TMPTXT
 S XPDCNT=XPDCNT+1 ;,XPDW(XPDCNT)=$TR($J(" ",70)," ","-")
 K XPDCS("FILES")
 Q
 ;
SQAMM ;
 N MCNT,ML,MR1 S MCNT=0
 I '$D(XPDSQA) S MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)=" ***  No SQA issues were found in the included routines.  ***" Q
 ;^TMP
 I $D(XPTK) D
 . N TWW,JL S MR1=0,TWW=" " F  S TWW=$O(XPTK(TWW)) Q:TWW']""  D
 .. S JL=$L(XPTK(TWW),"^") N II,SK F II=1:1:JL S:$L($P(XPTK(TWW),"^",II))>MR1 MR1=$L($P(XPTK(TWW),"^",II))
 . S MR1=MR1+2,MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="These ^TMP calls have kill statements within the included routines:" D
 .. N WWW,JK,JL S (WWW,JK)=" ",JL=0 F  S WWW=$O(XPTK(WWW)) Q:WWW']""  D
 ... S MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)=WWW,JL=$L(XPTK(WWW),"^") N II,SK F II=1:1:JL S SK=$P(XPTK(WWW),"^",II),MCNT=MCNT+1,XPMM(MCNT)=$J(" ",10)_$P(SK," ")_$J(" ",(MR1-($L($P(SK," "))+10)))_$P(SK," ",2,99)
 I $D(XPDKT) D
 . N NSP,NSP1 S (NSP,NSP1)=" " F  S NSP=$O(XPDTRR(NSP)) Q:NSP']""   F  S NSP1=$O(XPDTRR(NSP,NSP1)) Q:NSP1']""  K:$D(XPDKT(NSP,NSP1)) XPDTRR(NSP,NSP1)
 . I $D(XPDTRR) D
 .. S MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="These ^TMP calls have no associated kill in this build's included routines:"
 .. N JK,JL S (NSP,JK)=" ",JL=0 F  S NSP=$O(XPDTRR(NSP)) Q:NSP']""  F  S JK=$O(XPDTRR(NSP,JK)) Q:JK']""  F  S JL=$O(XPDTRR(NSP,JK,JL)) Q:'JL  S MCNT=MCNT+1,XPMM(MCNT)=XPDTRR(NSP,JK,JL)
 . I '$D(XPDTRR) S MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="All ^TMP calls have at least one kill statement in this build's routines."
 ;^XTMP
 N RRR,XRRR S RRR=" ",XRRR="" F  S RRR=$O(XPDXRR(RRR)) Q:RRR']""  I '$D(XTMPARR(RRR)) S XRRR=XRRR_"^"_RRR
 I $D(XTMPARR) D
 . S MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="General ^XTMP Notes"
 . S MCNT=MCNT+1,XPMM(MCNT)="These ^XTMP calls have zero nodes defined in this build's included routines:"
 . N WWW,BBB S (WWW,BBB)=" " F  S WWW=$O(XTMPARR(WWW)) Q:WWW']""  F  S BBB=$O(XTMPARR(WWW,BBB)) Q:BBB']""  D
 .. N XLNE S XLNE=$J(" ",5)_"Routine: "_BBB_$J(" ",5)_XTMPARR(WWW,BBB)
 .. I $L(XLNE)<79 S MCNT=MCNT+1,XPMM(MCNT)=XLNE
 .. I $L(XLNE)>78 S ML=$L("Routine: "_BBB_$J(" ",5)) D CUTME(XLNE,3)
 I XRRR]"" S MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="These ^XTMP calls have no zero nodes defined in this build's included routines" D 
 . N LLL F LLL=2:1:$L(XRRR,"^") S MCNT=MCNT+1,XPMM(MCNT)=$J(" ",5)_"Routine: "_XPDXRR($P(XRRR,"^",LLL))_$J(" ",5)_"^XTMP("_$P(XRRR,"^",LLL)
 I XRRR']"" S MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)="ALL ^XTMP calls have zero nodes defined in this build's routines"
 N RT1,RT2,SQAM,SQAM1,JJ,TXTC,TTAG S JJ=0,(RT1,RT2,SQAM1)="",ML=XPTL+3
 F  S RT1=$O(XPDSQA(RT1)) Q:RT1']""  S SQAM=" " F  S SQAM=$O(XPDSQA(RT1,SQAM)) Q:SQAM']""  F  S JJ=$O(XPDSQA(RT1,SQAM,JJ)) Q:'JJ  D
 . S XPDROUT(0)="",TTAG=" ",TTAG=$O(XPDSQA(RT1,SQAM,JJ,TTAG)) Q:TTAG']""  ;S:TTAG["+0" TTAG=TTAG_" "
 . I RT1'=RT2 D
 .. S:RT2]"" MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)=$$CJ^XLFSTR("<><><>",70)
 .. S SQAM1="",MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)=RT1,RT2=RT1
 . S XPDROUT(MCNT)=RT1
 . I SQAM'=SQAM1 S MCNT=MCNT+1,XPMM(MCNT)="",MCNT=MCNT+1,XPMM(MCNT)=" "_SQAM_" "_$TR($J(" ",77-$L(SQAM))," ","."),SQAM1=SQAM
 . ;S TXTC=$J(" ",5)_"LINE #"_$J(JJ,3)_"  "_XPDSQA(RT1,SQAM,JJ)
 . N TABME S TABME=ML-$L(TTAG) S:TTAG["+0" TABME=TABME+1
 . S TXTC=$J(" ",3)_TTAG_$J(" ",TABME)_XPDSQA(RT1,SQAM,JJ,TTAG)
 . I $L(TXTC)<79 S MCNT=MCNT+1,XPMM(MCNT)=TXTC
 . I $L(TXTC)>78 D CUTME(TXTC,3)
 Q
TMPX(XLINE) ;
 N NSP,PX,EXT S EXT=0,PX=$L(XLINE,"^XTMP(") F I=2:1:PX D
 . S NSP=$P($P($P(XLINE,"^XTMP(",I),")"),",") I NSP]"" S XPDXRR(NSP)=ROU I $$NSPACE^XPDANLYZ6($$TRIM^XLFSTR(NSP,"LR",$C(34))) S TCHK=1
 N ZN,JJ,POS,QNUM S JJ=1,ZN="" I XLINE?.E1"S ".E1"^XTMP(".E1",0)=".E1(1"^",1"_U_").E D
 . N XXL S XXL=0 F I=2:1:PX S QNUM=0 D  Q:EXT
 .. S:ZN'[",0)=" JJ=XXL+1,ZN="" S POS=$F(XLINE,"XTMP(",JJ)-6 F XXL=POS:1:$L(XLINE) S:$E(XLINE,XXL)=$C(34) QNUM=QNUM+1 S ZN=ZN_$E(XLINE,XXL) Q:('QNUM#2)&($E(XLINE,XXL)=$C(32))
 . Q:ZN']""
 . I ZN]"" S XTMPARR($P($P(ZN,"(",2),","),ROU)=$P(ZN,"=")_"="_$P(XLINE,",0)=",2)
 Q
TMP(XLINE) ;XPDTRR (all TMP)   XPDKT (kill array)
 N TTAB S TTAB=25 ;S:TAGME["+0" TTAB=26;
 N FMTY,NSP,NSPT,PX,TLINE,T9,FTWP,EXT S PX=$L(XLINE,"^TMP(") F I=2:1:PX D  Q:EXT
 . S EXT=0,NSP="",FMTY=""
 . S T9=$J(" ",2)_ROU_" "_TAGME,T9=T9_$J(" ",(TTAB-$L(T9))),TLINE=T9_XLINE
 . S FMTY=$P($P(XLINE,"^TMP(",I),")"),NSP=$$TRIM^XLFSTR($P(FMTY,","),"LR",$C(34)),NSPT=T9_"^TMP("_FMTY_")"
 . I (NSP']"")!(FMTY']"") Q
 . N TWOP S TWOP=$$TRIM^XLFSTR($P(FMTY,",",2),"LR",$C(34)) S:$G(TWOP)']"" TWOP="0"
 . Q:NSPT'[""  Q:$L(NSPT)<2
 . I XLINE["K ^TMP("_FMTY_")" D
 .. S FTWP="^TMP("_NSP_","_TWOP  S:$D(XPTK(FTWP)) XPTK(FTWP)=XPTK(FTWP)_"^"_ROU_" "_TAGME S:'$D(XPTK(FTWP)) XPTK(FTWP)=ROU_" "_TAGME
 .. I $L(TLINE)<75 S TCNT=TCNT+1,XPDKT(NSP,TWOP,TCNT)=NSPT  ;TLINE
 .. I $L(TLINE)>74 D CUTME(NSPT,4) Q
 . I $P(FMTY,",")="$J" S TCHK=1
 . I $$NSPACE^XPDANLYZ6(NSP)&($P(FMTY,",",2)["$J") S TCHK=1
 . I NSP]"" D
 .. I $L(NSPT)<76 S XPDTRR(NSP,TWOP,TCNT)=NSPT
 .. I $L(NSPT)>74 D CUTME(NSPT,5)
 Q
 ;
KCOLON(XLINE) ;
 N TC1,TCL,J,PP S TCL=$L(XLINE,"K:") F J=2:1:TCL S TC1=$P(XLINE,"K:",J) I TC1]"" D
 . F PP=1:1:$L(TC1) I $E(TC1,PP)=$C(32) Q:$E(TC1,PP+1)'="^"&($E(TC1,PP+1)'="@")  D
 .. I 'XPDIS2,$E(TC1,PP+1)'="@" N TC2 S TC2="K:"_$E(TC1,PP+1,99) Q:$$KCHK(TC2,"K:")'=3
 .. S XPDSQA(ROU,XPD1,K,TAGME)=XLINE S:XPDARRR(XPD1,JJ,0)]"" XPDARRR(XPD1,JJ,0)=XPDARRR(XPD1,JJ,0)_" "_K_"," S:XPDARRR(XPD1,JJ,0)']"" XPDARRR(XPD1,JJ,0)="Lines: "_K_"," Q
 Q
 ;
MSQA(XLINE,SQAT) ;IO, %, $I
 N SL S SL=($L(SQAT)+1)
 S XLINE=" "_XLINE
 N NSP,PX,EXT,END,J,XT,I,AA,BB S (END,XT,J)=0,PX=$L(XLINE,SQAT) F I=1:1:(PX-1) D  Q:END
 . N POS S POS=$F(XLINE,SQAT,J),J=POS,XT=0
 . I SQAT="%" D  Q:XT  Q:END
 .. I $E(XLINE,POS)?1P,$E(XLINE,(POS-SL))?1P S XT=1 Q  ;IF ITEM SURRONDED BY PUNCTUATION (like "%"), SKIP IT
 .. I $E(XLINE,POS)'?1U I $E(XLINE,(POS-SL))="=" S XT=1 Q  ;Q IF SOMETHING = %
 .. I $E(XLINE,POS)="=",$E(XLINE,-SL)?1P S XT=1 Q  ;%= ALLOWED
 .. I 'XT,'END,XLINE[$C(34) N I F I=1:2:($L(XLINE,$C(34))-1) I POS>$F(XLINE,$P(XLINE,$C(34),I)),POS<=$F(XLINE,$P(XLINE,$C(34),I+1)) S XT=1 Q
 .. N PCT S PCT="" F AA=POS:1:$L(XLINE) Q:$E(XLINE,AA)'?1U  S PCT=PCT_$E(XLINE,AA) ;GETS THE LETERS AFTER THE % LIKE %ZIS
 .. I PCT]"" D
 ... I PCT="%ZIS" S XT=1 Q
 ... I "DRZ"[$E(XLINE,POS) S:PCT="DT" XT=1 S:PCT="DTC" XT=1 S:PCT="RCR" XT=1 S:PCT="ZIS" XT=1 S:PCT="ZTLOAD" XT=1 S:PCT="ZOSF" XT=1
 .. S BB="" F AA=(POS-SL):-1:0 S:($E(XLINE,AA)="$")&($E(XLINE,AA-1)="$") XT=1 Q:XT  I $E(XLINE,AA)=$C(32),$E(XLINE,AA-2)=$C(32) S BB=$E(XLINE,(AA-1)) S:"XDI"[BB XT=1 S:"SKNMR"[BB END=1 Q
 . I SQAT="IO" D
 .. I POS-SL=1 S XT=1 Q  ;I $E(XLINE,POS)?1P I "UI"[$E(XLINE,(POS-(SL+1))) S XT=1 Q
 .. I ($E(XLINE,POS)?1U)!($E(XLINE,(POS-SL))?1U) S XT=1 Q
 .. S BB="" F AA=(POS-SL):-1:0 I $E(XLINE,AA)=$C(32),$E(XLINE,AA-2)=$C(32) S BB=$E(XLINE,(AA-1)) S:"UI"[BB XT=1 S:"SKN"[BB END=1 Q
 . I SQAT="$I" N SP1 S SP1=(POS-SL) I ($E(XLINE,SP1,(SL+1))="$$")!($E(XLINE,POS)?1A) S XT=1 Q
 . I SQAT="DIC(0)" D
 .. I $F(XLINE,"FILE^DICN") D  Q:XT
 ... N P1,P2,C1 S P1=$P(XLINE,"FILE^DICN"),P2=$P(XLINE,"FILE^DICN",2),C1=0 N XPDI F XPDI=P1,P2 D
 .... N DO1,D2 S DO1=$F(XPDI,"DO") Q:'$G(DO1)  S D2=(DO1-3),BB="" F AA=D2:-1:0 I $E(XPDI,AA)=$C(32),$E(XPDI,AA-2)=$C(32) S BB=$E(XPDI,(AA-1)) S:"K"[BB C1=C1+1 Q
 ... I C1>1 S XT=1 Q
 ... S END=1
 .. Q:END
 .. I '$F(XLINE,"FILE^DICN") D  Q:XT
 ... N DO1,D1 S D1="",DO1=$F(XLINE,"DIC(0)=") F AA=DO1:1:$L(XLINE) Q:($E(XLINE,AA)=$C(32))!($E(XLINE,AA)=",")  S D1=D1_$E(XLINE,AA)
 ... Q:D1']""  S:D1'["L" XT=1 Q:XT
 ... I D1["L" S:'$F(XLINE,"DLAYGO") END=1 Q:END  N D2 S BB=0,D2=$F(XLINE,"DLAYGO") F AA=D2:1:$L(XLINE) Q:$E(XLINE,AA)=$C(32)  I $E(XLINE,AA)="=" S BB=1
 ... I BB=1 S XT=1 Q
 . Q:XT  Q:END
 . S END=1
 Q END
 ;
KCHK(XLINE,REF) ;
 ;CHECK REF IS K ^ OR K: EXCLUDE K: @
 N XPS,J,T,XPNUM,XPCON,PCON,END,FOP,FCP,TTT S END=0,PCON=""
 S XPS=$L(XLINE,REF) F J=2:1:XPS S XPNUM=$P(XLINE,REF,J) D  Q:END=3
K1 . S XPCON="",(END,FOP)=0,FCP=99 F T=1:1:$L(XPNUM) D  Q:END=1!(END=3)
 .. I $E(XPNUM,T)?1P S TTT=$E(XPNUM,T) D  Q:END=1
 ... I TTT=",",T>FCP S XPCON="^"_$E(XPNUM,1,(T-1)),PCON=$E(XPNUM,(T+2),999),END=1 Q
 ... I $E(XPNUM,T)=")" S FCP=T,XPCON="^"_$E(XPNUM,1,T) I 
 ... I (T>FCP)&(TTT=$C(32)) S END=1 Q
 .. I XPCON']"" S XPCON=XPNUM
 . I XPCON]"" D
 .. I XPCON["^(" S END=1 Q
 .. I (XPCON["^TMP")!(XPCON["^UTILITY") S END=1 Q
 .. N INNER,OUTER,FP S OUTER=$P(XPCON,"("),INNER=$P($P(XPCON,"(",2),")"),FP=$P(INNER,",")
 .. I $L(INNER,",")=1,FP="0" S END=3 Q 
 .. I $F(XPCON,"(")=0 S END=3 Q
 .. Q:+FP<1  ;Q:FP'?.N
 .. Q:$L(INNER,",")>2
 .. I $D(^DIC(FP,0,"GL")),^DIC(FP,0,"GL")=(OUTER_"("_FP_",") I ($L(INNER,",")=1!($P(INNER,",",2)=0)) S END=3 Q
 . Q:END=3
 . I PCON]"" Q:$P(PCON," ")'["^"  S XPNUM=$P(PCON,"^",2),PCON="" D K1
 Q END
 ;
