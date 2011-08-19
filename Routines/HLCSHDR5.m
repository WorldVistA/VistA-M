HLCSHDR5 ;OIRMFO/LJA - Make HL7 header for TCP ;1/27/03 15:30
 ;;1.6;HEALTH LEVEL SEVEN;**93**;Oct 13, 1995
 ;
 ; The MSHALL API is not supported!
 ;
MSHALL ; Allows application developer, in test and development environments,
 ; to change almost every field in the MSH segment.  This feature 
 ; allows the testing of the ramifications of MSH field changes, avoiding
 ; the need to edit protocol file (and other file) entries from which
 ; the MSH segment fields are derived.
 ;
 ; Call here ONLY if the full suite of variables used in MSH segment
 ; creation are available!
 ;
 ; Call method:   S HLP("SUBSCRIBER"[,n])="^^^^^MSHALL^HLCSHDR5"
 ;                D GENERATE^HLMA(.....,.HLP)
 ;
 ;                When the above HLP array is passed into the
 ;                GENERATE^HLMA API, the MSHALL subroutine is
 ;                invoked, giving the developer full control over
 ;                most MSH segment fields; even those fields not
 ;                changeable by HL*1.6*93.
 ;
 ;                See HL*1.6*93 for information about the passing
 ;                of HLP("SUBSCRIBER"[,n]) information, and the
 ;                calling of the GENERATE^HLMA API.
 ;
 ; Warning!       No audit trail (in ^HLMA or ^XTMP) is maintained.
 ;                Full responsibility rests with the application
 ;                developer.
 ;                
 ; EC,FS -- req
 ;
 N ACTION,CHANGE,IOINHI,IOINORM,MSHFINAL,MSHLAST,MSHORIG
 N SAVE,PCE,VAL1,VAL2,X
 ;
 D SAVEORIG
 S (MSHFINAL,MSHLAST)=MSHORIG
 ;
MSHCONT ;
 F  D  Q:'CHANGE
 .  S CHANGE=0
 .  D SHOWMSH
 .  D ASKMSH
 .  S MSHFINAL=$$MSH
 .  QUIT:MSHFINAL=MSHLAST  ;->
 .  S CHANGE=1
 .  S MSHLAST=$$MSH
 ;
 I MSHFINAL=MSHORIG W !!,"The MSH segment was not changed..."
 I MSHFINAL'=MSHORIG D
 .  S X="IOINHI;IOINORM" D ENDR^%ZISS
 .  W !!,MSHORIG,!!,"   changed to...",!!
 .  F PCE=1:1:$L(MSHFINAL,FS) D
 .  .  W:PCE'=1 FS
 .  .  S VAL1=$P(MSHORIG,FS,PCE),VAL2=$P(MSHFINAL,FS,PCE)
 .  .  W:VAL1'=VAL2 IOINHI
 .  .  W VAL2
 .  .  W IOINORM
 ;
 S ACTION=$$DOWHAT
 I ACTION="B" D  G MSHCONT ;->
 .  QUIT:MSHFINAL=MSHORIG  ;->
 .  W !!,"You have made some changes to the original MSH segment.  Do you want to"
 .  W !,"""forget"" these changes, and reset the MSH segment to it's original state?"
 .  QUIT:'$$YN("Reset MSH segment","No",1)  ;->
 .  D RESTORE
 .  S (MSHFINAL,MSHLAST)=MSHORIG
 ;
 Q
 ;
YN(PMT,DEF,FF) ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 F I=1:1:$G(FF) W !
 S DIR(0)="Y",DIR("A")=PMT
 S:$G(DEF)]"" DIR("B")=DEF
 D ^DIR
 Q $S(+Y=1:1,1:"")
 ;
DOWHAT() ; Reenter MSH or send message...
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S^B:Back up and change MSH segment;C:Continue on (and send message)"
 S DIR("A")="Enter ACTION",DIR("B")="Continue"
 D ^DIR
 QUIT $S(Y="B":"B",1:"C")
 ;
SHOWMSH ;
 ; MSHORIG -- req
 N C2,C3,C4,DATA,IOINHI,IOINORM,MSH,PCE,REF,TAG,VAL,X,XEC
 ;
 S X=MSHORIG N MSHORIG S MSHORIG=X
 S C2=4,C3=18,C4=40
 I $G(FS)']""!($G(EC)']"") N EC,FS S FS=U,EC="~|\&"
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 W @IOF,!,$$CJ^XLFSTR("MSH Segment Values",IOM)
 W !,$$REPEAT^XLFSTR("-",IOM)
 W !,"#",?C2,"Field",?C3,"Variable",?C4,"Value"
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 F PCE=1:1 S DATA=$T(FLDS+PCE) Q:$E(DATA,1,3)'=" ;;"!(DATA']"")  S DATA=$P(DATA,";;",2,99) D
 .  S REF=$P(DATA,U),XEC=$P(DATA,U,2),TAG=$P(DATA,U,3)
 .  S VAL=REF
 .  I PCE=11 S REF=$TR(REF,"~",U)
 .  I XEC=1,PCE'=12 S VAL=@REF
 .  I XEC=2!(PCE=12) S X="S VAL="_REF X X KILL X
 .  W !,$J(PCE,2),?C2,$$S(TAG,12),?C3,$$S(REF,18)
 .  W ?C4
 .  I XEC=1 W IOINHI
 .  W VAL,IOINORM
 .  W $S(XEC=1:$$CHG(VAL,PCE),1:"")
 ;
 Q
 ;
S(T,C) QUIT:$L(T)<(C+1) T ;->
 QUIT $E(T,1,C-1)_"~"
 ;
CHG(VAL,PCE) ; Has data been changed?
 ; MSHORIG -- req
 N VALORIG
 S VALORIG=$P(MSHORIG,FS,+PCE)
 QUIT:VALORIG=VAL "" ;->
 Q " *"
 ;
ASKMSH ; Ask user to input different field values
 N DATA,DIR,DIRUT,DTOUT,DUOUT,FIELD,PCE,TITLE,VAL,VAR,X,Y
 ;
 W !
 ;
 S DIR="SOA^"
 F PCE=3:1:12,15:1:17 D
 .  S DATA=$P($T(FLDS+PCE),";;",2,999),VAR=$P(DATA,U),TITLE=$P(DATA,U,3)
 .  S DIR=DIR_$S(PCE>3:";",1:"")_PCE_":"_TITLE_" ("_VAR_")"
 S DIR(0)=DIR
 S DIR("A")="Enter FIELD #: "
 D ^DIR
 QUIT:+Y'>0  ;->
 ;
 S FIELD=+Y,VAR=$P($P($T(FLDS+FIELD),";;",2,99),U)
 I FIELD'=12 S VAL=@VAR
 I FIELD=12 S X="S VAL="_VAR X X KILL X
 ;
 W !!,"Current '",VAR,"' value = ",VAL
 W !
 ;
 KILL DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="F",DIR("A")="Field value"
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT))  ;->
 ;
 S ANS=Y
 ;
 I ANS=VAL W "  nothing changed..." QUIT  ;->
 ;
 ; Make the change...
 I FIELD'=12 S @VAR=ANS
 I FIELD=12 S $P(PROT,U,9)=ANS
 W "   changed..."
 ;
 Q
 ;
MSH() ;Build MSH array
 N DATA,MSH,PCE,REF,TAG,XEC
 ;
 S MSH=""
 ;
 F PCE=1:1 S DATA=$T(FLDS+PCE) Q:$E(DATA,1,3)'=" ;;"!(DATA']"")  S DATA=$P(DATA,";;",2,99) D
 .  S REF=$P(DATA,U),XEC=$P(DATA,U,2)
 .  I PCE=11 S REF=$TR(REF,"~",U)
 .  I XEC=0 S VAL=REF
 .  I XEC=1,PCE'=12 S VAL=@REF
 .  I XEC=2!(PCE=12) S X="S VAL="_REF X X KILL X
 .  S MSH=MSH_$S(MSH]"":FS,1:"")_VAL
 ;
 Q MSH
 ;
SAVEORIG ; Save value of original variables...
 KILL SAVE
 ;
 S SAVE("SERAPP")=SERAPP,SAVE("SERFAC")=SERFAC
 S SAVE("CLNTAPP")=CLNTAPP,SAVE("CLNTFAC")=CLNTFAC
 S SAVE("HLDATE")=HLDATE,SAVE("SECURITY")=SECURITY
 S SAVE("MSGTYPE")=MSGTYPE,SAVE("HLID")=HLID
 S SAVE("HLPID")=HLPID,SAVE("ACCACK")=ACCACK
 S SAVE("APPACK")=APPACK,SAVE("CNTRY")=CNTRY
 S SAVE("$P(PROT,U,9)")=$P(PROT,U,9)
 ;
 S MSHORIG=$$MSH
 ;
 Q
 ;
RESTORE ;
 N VAL,VAR
 ;
 ; restore variables...
 S VAR=""
 F  S VAR=$O(SAVE(VAR)) Q:VAR']""  D
 .  QUIT:VAR["$P(PROT,U,9)"  ;->
 .  S @VAR=SAVE(VAR)
 S $P(PROT,U,9)=SAVE("$P(PROT,U,9)")
 ;
 ; Restore beginning MSH...
 S (MSHFINAL,MSHLAST)=MSHORIG
 ;
 Q
 ;
FLDS ; List of fields and their variables in MSH segment...
 ;;MSH^0
 ;;EC^2
 ;;SERAPP^1^SND-APP
 ;;SERFAC^1^SND-FAC
 ;;CLNTAPP^1^REC-APP
 ;;CLNTFAC^1^REC-FAC
 ;;HLDATE^1^D/T
 ;;SECURITY^1^SECURE
 ;;MSGTYPE^1^MSGTYPE
 ;;HLID^1^MSG-ID
 ;;HLPID^1^PID
 ;;$P(PROT,U,9)^1^VERSION
 ;;^0
 ;;^0^CONTINUATION
 ;;ACCACK^1^COMACK
 ;;APPACK^1^APPACK
 ;;CNTRY^1^COUNTRY
 Q
 ;
PRACTICE ; Practice MSH variables...
 S EC="~|\&",FS=U
 S SERAPP="SND-APP",SERFAC=512,CLNTAPP="REC-APP",CLNTFAC=661
 S HLDATE=200301020135,SECURITY="SEC",MSGTYPE="ORU~R01"
 S HLID="543010101",HLPID="P"
 S $P(PROT,U,9)="2.3",TXTP=999
 S ACCACK="AL",APPACK="AL",CNTRY="US"
 Q
 ;
 ;
EOR ;HLCSHDR5 - Make HL7 header for TCP ;1/27/03 15:30
