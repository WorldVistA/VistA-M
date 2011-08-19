ORSRCHOR ;SLC/TC - Search Utility for Order Check Override Reason Report; 09/28/2009 15:00 ;09/16/10  20:05
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,293**;Dec 17, 1997;Build 20
 ;
 ;
ASKUSER(ANS,DIR,ORQUIT) ; Controls prompting of the report utility.
 ;
 I $G(ANS("EXIT"))="YES" Q
 S ANS("EXIT")="NO"
 N DIRUT,POP,X,Y
 S DIR(0)="S^1:DATE/TIME ORDERED & OVERRIDDEN BY;2:DATE/TIME ORDERED & ORDER CHECK;3:DATE/TIME ORDERED & DIVISION;4:DATE/TIME ORDERED & DISPLAY GROUP;5:DATE/TIME ORDERED, DIVISION, & DISPLAY GROUP",DIR("A")=DIR,DIR("B")="1"
 D ^DIR I $D(DIRUT) S ANS("EXIT")="YES" Q
 N ORRSPNSE S ORRSPNSE=Y K DIR
 N %DT,CNT,Y,DUOUT,DTOUT
 S %DT="AE" F CNT=1:1:2 D
 . S %DT("A")=$S(CNT=1:"SEARCH Orders Beginning: ",CNT=2:$J("Thru: ",25)),%DT("B")=$S(CNT=1:"",CNT=2:$P($$HTE^XLFDT($H),"@"))
 . D ^%DT I Y=-1 S CNT=2 Q
 . E  D
 . . I CNT=1 S TMP("STRDT")=$P(Y,".")
 . . I CNT=2 S TMP("ENDDT")=$P(Y,".")_".24"
 I '$D(TMP("STRDT"))!'$D(TMP("ENDDT"))!$D(DTOUT)!$D(DUOUT) S ANS("EXIT")="YES" Q
 I ORRSPNSE=1 D  ; filter search by OVERRIDDEN BY field
 . N DIC,Y,DTOUT,DUOUT S DIC="^VA(200,",DIC(0)="QEAMZ",DIC("A")="SEARCH Order Chks Overridden By: " D ^DIC I (Y=-1)!$D(DTOUT)!$D(DUOUT) S ANS("EXIT")="YES" Q
 . S ANS("SORT")="OVRDNBY",TMP("OVRBYIEN")=+Y,TMP("OVRBY")=Y(0,0)
 I ORRSPNSE=2 D  ; filter search by ORDER CHK
 . N DIC,Y,DTOUT,DUOUT S DIC="^ORD(100.8,",DIC(0)="QEAMZ" D ^DIC I (Y=-1)!$D(DTOUT)!$D(DUOUT) S ANS("EXIT")="YES" Q
 . S ANS("SORT")="ORCHK",TMP("ORCHKIEN")=+Y,TMP("ORCHK")=Y(0,0)
 I ORRSPNSE=3 D  ; filter search by DIUISION
 . N DIC,Y,DTOUT,DUOUT S DIC="^DG(40.8,",DIC(0)="QEAMZ" D ^DIC I (Y=-1)!$D(DTOUT)!$D(DUOUT) S ANS("EXIT")="YES" Q
 . S ANS("SORT")="DIV",TMP("ORDIVIEN")=+Y,TMP("ORDIV")=Y(0,0)
 I ORRSPNSE=4 D  ; filter search by DISPLAY GROUP
 . N DIC,Y,DTOUT,DUOUT S DIC="^ORD(100.98,",DIC(0)="QEAMZ" D ^DIC I (Y=-1)!$D(DTOUT)!$D(DUOUT) S ANS("EXIT")="YES" Q
 . S ANS("SORT")="DSPGRP",TMP("ORDGPIEN")=+Y,TMP("ORDSPGRP")=Y(0,0)
 I ORRSPNSE=5 D  ; filter search by DIVISION & DISPLAY GROUP
 . N DIC,CNT,Y,DTOUT,DUOUT S DIC(0)="QEAMZ",ANS("SORT")="DTORD"
 . F CNT=1:1:2 D
 . . S DIC=$S(CNT=1:"^DG(40.8,",CNT=2:"^ORD(100.98,")
 . . D ^DIC I Y=-1 S CNT=2 Q
 . . E  D
 . . . I CNT=1 S TMP("ORDIVIEN")=+Y,TMP("ORDIV")=Y(0,0)
 . . . I CNT=2 S TMP("ORDGPIEN")=+Y,TMP("ORDSPGRP")=Y(0,0)
 . I '$D(TMP("ORDIVIEN"))!'$D(TMP("ORDGPIEN"))!$D(DTOUT)!$D(DUOUT) S ANS("EXIT")="YES" Q
 I ANS("EXIT")="NO" D
 . N DIR,DIRUT,POP,X,Y S DIR(0)="Y",DIR("A")="Print delimited output only",DIR("B")="NO"
 . S DIR("?",1)="Entering 'YES' will allow the user to specify a delimiter character",DIR("?",2)="and create a delimited report.",DIR("?",3)=""
 . S DIR("?")="Entering 'NO' will create a regular summary report."
 . D ^DIR I $D(DIRUT) S ANS("EXIT")="YES" Q
 . S ANS("DELIMIT")=Y(0) I ANS("DELIMIT")="YES" D
 . . N DIR,DIRUT,X,Y S DIR("A")="Specify REPORT DELIMITER CHARACTER",DIR("B")="U"
 . . S DIR(0)="S^P:Pipe;T:Tilde;U:Up arrow"
 . . D ^DIR I $D(DIRUT) S ANS("EXIT")="YES" Q
 . . S ANS("DELIMITER")=Y K DIR
 . W !,"Searching....." D SRCHBYDT(TMP("STRDT"),TMP("ENDDT"))
 Q
 ;
SRCHBYDT(STRDT,ENDDT) ; Search by Date/Time Ordered and sort by Date/Time Ordered, Division, Display Group, or Order Chk.
 ;
 N AFGLB,ORDNO,ORDACT
 K ^TMP("OROVRRPT",$J) ; Ensures a fresh start
 S AFGLB=$NA(^OR(100,"AF")),TMP=$NA(^TMP("OROVRRPT",$J))
 S (ORDNO,ORDACT)=0
 I (ANS("SORT")="OVRDNBY") S (TMP("ORCHKIEN"),TMP("ORDIVIEN"),TMP("ORDGPIEN"))=""
 I (ANS("SORT")="ORCHK") S (TMP("OVRBYIEN"),TMP("ORDIVIEN"),TMP("ORDGPIEN"))=""
 I (ANS("SORT")="DIV") S (TMP("ORCHKIEN"),TMP("OVRBYIEN"),TMP("ORDGPIEN"))=""
 I (ANS("SORT")="DSPGRP") S (TMP("ORCHKIEN"),TMP("ORDIVIEN"),TMP("OVRBYIEN"))=""
 I (ANS("SORT")="DTORD") S (TMP("ORCHKIEN"),TMP("OVRBYIEN"))=""
 F  S STRDT=$O(@AFGLB@(STRDT)) Q:'+STRDT!(STRDT>ENDDT)  F  S ORDNO=$O(@AFGLB@(STRDT,ORDNO)) Q:'+ORDNO  F  S ORDACT=$O(@AFGLB@(STRDT,ORDNO,ORDACT)) Q:'+ORDACT  D
 . K ^TMP($J,"OROCDATA") D OCAPI^ORCHECK(ORDNO,"OROCDATA")
 . I (ORDACT=1)&($$OCCNT^OROCAPI1(ORDNO))&($L($G(^TMP($J,"OROCDATA",1,"OR REASON")))>0)  D
 . . N ORD0,ORD8,ORD9,ORD91,ORDCHK S ORD0=$G(^OR(100,ORDNO,0)),ORD8=$G(^OR(100,ORDNO,8,1,.1,1,0))
 . . S ORD9=$G(^TMP($J,"OROCDATA",1,"OC NUMBER"))_U_$G(^TMP($J,"OROCDATA",1,"OC LEVEL"))_U_U_$G(^TMP($J,"OROCDATA",1,"OR REASON"))_U_$G(^TMP($J,"OROCDATA",1,"OR PROVIDER"))_U_$G(^TMP($J,"OROCDATA",1,"OR DT"))
 . . S ORD91=$G(^TMP($J,"OROCDATA",1,"OC TEXT",1,0))
 . . S ORDCHK=$G(^ORD(100.8,$P(ORD9,U),0))_": "_ORD91
 . . N PTLOC,DIVIEN,DIVISN,ORDLG,DSPGRIEN,DSPGRP S PTLOC=$P(ORD0,U,10),ORDLG=$P(ORD0,U,5)
 . . I $D(PTLOC)&($P(PTLOC,";",2)="SC(")&($D(^SC(+PTLOC,0)))  S DIVIEN=$P($G(^SC(+PTLOC,0)),U,15),DIVISN=$P($G(^DG(40.8,DIVIEN,0)),U)  ;DBIA #10040
 . . E  S DIVISN="NONE SPECIFIED"
 . . I $D(ORDLG)&($P(ORDLG,";",2)="ORD(101.41,")&($D(^ORD(101.41,+ORDLG,0)))  S DSPGRIEN=$P($G(^ORD(101.41,+ORDLG,0)),U,5),DSPGRP=$P($G(^ORD(100.98,DSPGRIEN,0)),U)
 . . E  S DSPGRP="NONE SPECIFIED"
 . . N ORDCHK1,ORDCHK2 I $L(ORDCHK)>255 S ORDCHK1=$E(ORDCHK,1,255),ORDCHK2=$E(ORDCHK,256,$L(ORDCHK))
 . . I (ANS("SORT")="OVRDNBY")&($P(ORD9,U,5)=TMP("OVRBYIEN"))  D
 . . . I $L(ORDCHK)>255 S @TMP@(STRDT,DIVISN,DSPGRP,ORDCHK1,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_TMP("OVRBY")_U_$P(ORD9,U,6)_U_ORDCHK2
 . . . E  S @TMP@(STRDT,DIVISN,DSPGRP,ORDCHK,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_TMP("OVRBY")_U_$P(ORD9,U,6)
 . . I (ANS("SORT")="ORCHK")&($P(ORD9,U)=TMP("ORCHKIEN"))  D
 . . . N ORCHCK1,ORCHCK2 I $L(ORD91)>255 D
 . . . . S ORCHCK1=$E(ORD91,1,255),ORCHCK2=$E(ORD91,256,$L(ORD91)),@TMP@(ORCHCK1,DIVISN,DSPGRP,STRDT,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_$P(ORD9,U,5)_U_$P(ORD9,U,6)_U_ORCHCK2
 . . . E  S @TMP@(ORD91,DIVISN,DSPGRP,STRDT,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_$P(ORD9,U,5)_U_$P(ORD9,U,6)
 . . I (ANS("SORT")="DIV")&($P($G(^SC(+$P($G(^OR(100,ORDNO,0)),U,10),0)),U,15)=TMP("ORDIVIEN"))  D
 . . . I $L(ORDCHK)>255 S @TMP@(TMP("ORDIV"),DSPGRP,ORDCHK1,STRDT,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_$P(ORD9,U,5)_U_$P(ORD9,U,6)_U_ORDCHK2
 . . . E  S @TMP@(TMP("ORDIV"),DSPGRP,ORDCHK,STRDT,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_$P(ORD9,U,5)_U_$P(ORD9,U,6)
 . . I (ANS("SORT")="DSPGRP")&($P($G(^ORD(101.41,+$P($G(^OR(100,ORDNO,0)),U,5),0)),U,5)=TMP("ORDGPIEN"))  D
 . . . I $L(ORDCHK)>255 S @TMP@(TMP("ORDSPGRP"),DIVISN,ORDCHK1,STRDT,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_$P(ORD9,U,5)_U_$P(ORD9,U,6)_U_ORDCHK2
 . . . E  S @TMP@(TMP("ORDSPGRP"),DIVISN,ORDCHK,STRDT,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_$P(ORD9,U,5)_U_$P(ORD9,U,6)
 . . I (ANS("SORT")="DTORD")&($P($G(^SC(+$P($G(^OR(100,ORDNO,0)),U,10),0)),U,15)=TMP("ORDIVIEN"))&($P($G(^ORD(101.41,+$P($G(^OR(100,ORDNO,0)),U,5),0)),U,5)=TMP("ORDGPIEN"))  D
 . . . I $L(ORDCHK)>255 S @TMP@(STRDT,TMP("ORDIV"),TMP("ORDSPGRP"),ORDCHK1,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_$P(ORD9,U,5)_U_$P(ORD9,U,6)_U_ORDCHK2
 . . . E  S @TMP@(STRDT,TMP("ORDIV"),TMP("ORDSPGRP"),ORDCHK,ORDNO)=ORD8_U_$P(ORD9,U,4)_U_$P(ORD9,U,5)_U_$P(ORD9,U,6)
 K ^TMP($J,"OROCDATA")
 Q
 ;
HEADER ; Prints out the report header
 ;
 N SORT,SRTORD,TITLE,PERTTL,TTLIEN S TITLE="Order Check Override Reason Report",SORT="Sorted in Ascending order by: "
 I ANS("SORT")="OVRDNBY" S SRTORD="Date/Time Ordered, Division, Display Group, Order Chk, & Order#"
 I ANS("SORT")="ORCHK" S SRTORD="Order Chk, Division, Display Group, Date/Time Ordered, & Order#"
 I ANS("SORT")="DTORD" S SRTORD="Date/Time Ordered, Order Chk, & Order#"
 I ANS("SORT")="DIV" S SRTORD="Display Group, Order Chk, Date/Time Ordered, & Order#"
 I ANS("SORT")="DSPGRP" S SRTORD="Division, Order Chk, Date/Time Ordered, & Order#"
 I $D(IO("SPOOL"))!($D(IO("HFSIO"))) S IOM=80
 W @IOF,?(IOM-$L(TITLE))/2,TITLE,!?(IOM-$L(SORT))/2,SORT,!?(IOM-$L(SRTORD))/2,SRTORD
 W !!!,"Current User:  ",$E($$GET1^DIQ(200,+$G(DUZ),.01),1,26),?42,"Current Date:  ",$$HTE^XLFDT($H)
 W !,"Date Range Searched:  ",$$FMTE^XLFDT(TMP("STRDT"),"1D")," - ",$$FMTE^XLFDT(TMP("ENDDT"),"1D"),?54,"WHERE"
 I ANS("SORT")="OVRDNBY" D
 . S TTLIEN=$P($G(^VA(200,TMP("OVRBYIEN"),0)),U,9) I TTLIEN="" S PERTTL="NONE SPECIFIED"
 . E  S PERTTL=$P($G(^DIC(3.1,TTLIEN,0)),U) I PERTTL="" S PERTTL="NONE SPECIFIED"
 . W !,"Order Chks are Overridden By:  ",TMP("OVRBY"),!,"Title:  ",PERTTL,!!
 I ANS("SORT")="ORCHK" W !,"Order Check:  ",TMP("ORCHK"),!!
 I ANS("SORT")="DIV" W !,"Division:  ",TMP("ORDIV"),!!
 I ANS("SORT")="DSPGRP" W !,"Display Group:  ",TMP("ORDSPGRP"),!!
 I ANS("SORT")="DTORD" W !,"Division:  ",TMP("ORDIV"),!,"Display Group:  ",TMP("ORDSPGRP"),!!
 I ANS("DELIMIT")="YES"&($D(^TMP("OROVRRPT",$J))) D
 . S TMP("DLMTR")=$S(ANS("DELIMITER")="P":"|",ANS("DELIMITER")="T":"~",ANS("DELIMITER")="U":"^")
 . I ANS("SORT")="OVRDNBY" W "RECNO"_TMP("DLMTR")_"Date/Time Ordered"_TMP("DLMTR")_"Division"_TMP("DLMTR")_"Display Group"_TMP("DLMTR")_"Order#"_TMP("DLMTR")_"D/T Overridden"
 . I ANS("SORT")="ORCHK" W "RECNO"_TMP("DLMTR")_"Date/Time Ordered"_TMP("DLMTR")_"Division"_TMP("DLMTR")_"Display Group"_TMP("DLMTR")_"Order#"_TMP("DLMTR")_"Overridden by"_TMP("DLMTR")_"D/T Overridden"
 . I ANS("SORT")="DIV" W "RECNO"_TMP("DLMTR")_"Date/Time Ordered"_TMP("DLMTR")_"Display Group"_TMP("DLMTR")_"Order#"_TMP("DLMTR")_"Overridden by"_TMP("DLMTR")_"D/T Overridden"
 . I ANS("SORT")="DSPGRP" W "RECNO"_TMP("DLMTR")_"Date/Time Ordered"_TMP("DLMTR")_"Division"_TMP("DLMTR")_"Order#"_TMP("DLMTR")_"Overridden by"_TMP("DLMTR")_"D/T Overridden"
 . I ANS("SORT")="DTORD" W "RECNO"_TMP("DLMTR")_"Date/Time Ordered"_TMP("DLMTR")_"Order#"_TMP("DLMTR")_"Overridden by"_TMP("DLMTR")_"D/T Overridden"
COLHDR I ANS("DELIMIT")="NO" D
 . I ANS("SORT")="OVRDNBY"!(ANS("SORT")="ORCHK") W "Date/Time Ordered",?21,"Division",?40,"Display Group",?70,"Order#",!,"-----------------",?21,"--------",?40,"-------------",?70,"------"
 . I ANS("SORT")="DIV" W "Date/Time Ordered",?25,"Display Group",?60,"Order#",!,"-----------------",?25,"-------------",?60,"------"
 . I ANS("SORT")="DSPGRP" W "Date/Time Ordered",?25,"Division",?60,"Order#",!,"-----------------",?25,"--------",?60,"------"
 . I ANS("SORT")="DTORD" W "Date/Time Ordered",?45,"Order#",!,"-----------------",?45,"------"
 Q
 ;
