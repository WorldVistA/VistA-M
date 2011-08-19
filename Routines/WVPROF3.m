WVPROF3 ;HCIOFO/FT,JR IHS/ANMC/MWR - DISPLAY PATIENT PROFILE; ;7/30/98  16:39
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  DISPLAY CODE FOR PATIENT PROFILE.  CALLED BY WVPROF1.
 ;
NOMATCH ;EP
 ;---> QUIT IF NO RECORDS MATCH.
 N M
 I '$D(^TMP("WV",$J,1)) D  Q
 .D HEADER2^WVUTL7
 .K WVPRMT,WVPRMT1,WVPRMTQ,DIR
 .W !!?5,"No records match the selected criteria.",!
 .I WVCRT&('$D(IO("S"))) D DIRZ^WVUTL3 W @IOF
 .D ^%ZISC S WVPOP=1
 ;
 ;---> WVD=1:DETAILED DISPLAY, WVD=0:BRIEF DISPLAY.
 I WVD D DISPLAY1 Q
 D DISPLAY2
 Q
 ;
 ;
DISPLAY1 ;EP
 ;---> IF A PROCEDURE IS EDITED ON THE LAST PAGE, GOTO HERE
 ;---> FROM LINELABEL "END" BELOW.
 D HEADER2^WVUTL7
 F  S N=$O(^TMP("WV",$J,2,N)) Q:'N!(WVPOP)  D
 .I $Y+5>IOSL D:WVCRT DIRZ^WVUTL3 Q:WVPOP  D
 ..S WVPAGE=WVPAGE+1
 ..D HEADER2^WVUTL7 S (WVACCP,Z)=0
 .S Y=^TMP("WV",$J,2,N),M=N
 .W !
 .;
 .;---> **********************
 .;---> DISPLAY PROCEDURES
 .;---> IF PIECE 1=1 DISPLAY AS A PROCEDURE.
 .I $P(Y,U)=1 D  Q
 ..W !,"------------------------------< "
 ..W "PROCEDURE: ",$P(Y,U,5)," >"            ;PROCEDURE ABBREVIATION
 ..W $$REPEAT^XLFSTR("-",(6-$L($P(Y,U,5))))
 ..;F I=1:1:(6-$L($P(Y,U,5))) W "-"
 ..W "-----------------------------"
 ..W ! W:WVCRT $J(N,3),")" W ?WVTAB          ;BROWSE SELECTION#
 ..W $P(Y,U,6)                               ;ACCESSION#
 ..W ?17,$P(Y,U,4)                           ;DATE OF PROCEDURE
 ..W ?27,"Res/Diag: ",$P(Y,U,7)              ;RESULTS/DIAGNOSIS
 ..W !?27,"Provider: ",$E($P(Y,U,8),1,14)    ;PROVIDER
 ..W ?62,"Status: ",$P(Y,U,9)                ;STATUS
 ..S WVACCP=$P(Y,U,6)                        ;STORE AS PREVIOUS ACCESS#
 .;
 .;---> **********************
 .;---> DISPLAY NOTIFICATIONS
 .;---> IF PIECE 1=2 DISPLAY AS A NOTIFICATION.
 .I $P(Y,U)=2 D  Q
 ..S WVACC=$P(Y,U,5)
 ..I WVACC'=Z D
 ...W ! W:WVACC["NO ACC#" "-----------------" W ?17
 ...W "-------------< NOTIFICATIONS >---------------------------------"
 ..W ! W:WVCRT $J(N,3),")" W ?WVTAB           ;BROWSE SELECTION#
 ..W:WVACC'=WVACCP!(WVACC["NO ACC#") WVACC    ;ACCESSION#
 ..W ?17,$P(Y,U,4)                            ;DATE OF PROCEDURE
 ..W ?27,$E($P(Y,U,6)_": "_$P(Y,U,7),1,53)    ;TYPE AND PURPOSE
 ..W !?27,"Outcome: ",$E($P(Y,U,8),1,23)      ;OUTCOME OF NOTIFICATION
 ..W ?62,"Status: ",$P(Y,U,9)                 ;STATUS
 ..S (WVACCP,Z)=WVACC                         ;STORE AS PREVIOUS ACC#
 ..;
 ..;---> TWO VARIABLES (WVACCP & Z) USED ABOVE: "Z" SAYS "IF THIS NOTIF
 ..;---> ACC# IS NOT THE SAME AS THE LAST ONE, DISPLAY --<NOT>-- BANNER.
 ..;---> "WVACCP" SAYS "IF THIS NOTIF ACC# MATCHES THE LAST PROCEDURE'S
 ..;---> ACC#, DON'T DISPLAY THE ACCESSION#."
 ..;---> BOTH VARIABLES ARE RESET AFTER A FORMFEED, IN ORDER TO DISPLAY
 ..;---> ON THE NEW PAGE.
 .;
 .;---> **********************
 .;---> DISPLAY PAP REGIMENS
 .;---> IF PIECE 1=3 DISPLAY AS A PAP REGIMEN.
 .I $P(Y,U)=3 D  Q
 ..W !,"------------------------------< PAP REGIMEN CHANGE"
 ..W " >----------------------------"
 ..W !?10,"Began:"
 ..W ?17,$P(Y,U,4)                           ;DATE OF REGIMEN ENTRY
 ..W ?27,"Regimen: ",$P(Y,U,5)               ;PAP REGIMEN
 .;
 .;---> **********************
 .;---> DISPLAY PREGNANCIES
 .;---> IF PIECE 1=4 DISPLAY AS A PREGNANCY.
 .I $P(Y,U)=4 D  Q
 ..W !,"------------------------------< PREGNANCY STATUS"
 ..W " >------------------------------"
 ..W !?8,"Entered:"
 ..W ?17,$P(Y,U,4)                           ;DATE OF PREGNANCY EDIT.
 ..W ?27,$P(Y,U,5)                           ;PREGNANT/NOT
 ..W:$P(Y,U,6)]"" ?50,"EDC: ",$P(Y,U,6)      ;EDC
 ;
END ;EP
 ;---> IF A PROCEDURE HAS BEEN EDITED, SET N=N-5 AND START (GOTO)
 ;---> DISPLAY1 OVER AGAIN FROM 5 RECORDS PREVIOUS.
 I WVCRT&('$D(IO("S")))&('WVPOP) D DIRZ^WVUTL3 I N S N=N-1 G NOMATCH
 D ^%ZISC
 K N,Z
 Q
 ;
 ;
 ;
DISPLAY2 ;EP
 ;---> IF A PROCEDURE IS EDITED ON THE LAST PAGE, GOTO HERE
 ;---> FROM LINELABEL "END" BELOW.
 S WVSUBH="SUBHEAD^WVPROF1"
 D HEADER2^WVUTL7
 F  S N=$O(^TMP("WV",$J,2,N)) Q:'N!(WVPOP)  D
 .I $Y+5>IOSL D:WVCRT DIRZ^WVUTL3 Q:WVPOP  D
 ..S WVPAGE=WVPAGE+1
 ..D HEADER2^WVUTL7 S (WVACCP,Z)=0
 .S Y=^TMP("WV",$J,2,N),M=N
 .;---> QUIT IF NOT A PROCEDURE (PIECE 1'=1).
 .Q:$P(Y,U)'=1
 .W ! W:WVCRT $J(N,3),")" W ?WVTAB          ;BROWSE SELECTION#
 .W $P(Y,U,4)                               ;DATE OF PROCEDURE
 .W ?17,$P(Y,U,5)                           ;PROCEDURE ABBREVIATION
 .W ?27,$P(Y,U,7)                           ;RESULT
 .W ?71,$P(Y,U,9)                           ;STATUS
 .S WVACCP=$P(Y,U,6)                        ;STORE AS PREVIOUS ACCESS#
END2 ;EP
 ;---> IF A PROCEDURE HAS BEEN EDITED, SET N=N-1 AND START (GOTO)
 ;---> DISPLAY2 OVER AGAIN FROM 5 RECORDS PREVIOUS.
 I WVCRT&('$D(IO("S")))&('WVPOP) D DIRZ^WVUTL3 I N S N=N-1 G NOMATCH
 D ^%ZISC
 K N,Z
 Q
