PRCFFERU ;WISC/SJG/DL-OBLIGATION ERROR PROCESSING CON'T ;2/2/98  1330
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT
 ; No top level entry
NUM S PONUM=$G(GECSDATA(2100.1,GECSDATA,.01,"E"))
 S PONUM=$P(PONUM,"-",2)
 S PATNUM=$E(PONUM,4,9)
 S SITE=$E(PONUM,1,3)
 S PONUM=SITE_"-"_PATNUM
 S PONUM=$$STRIP(PONUM)
 Q
GET(DIC,X) ; Get P.O. information for review
 K Y
 S DIC(0)="MNZ"
 D ^DIC
 K DIC
 Q
STRIP(X) ; Strip trailing spaces
 N LOOP
 F LOOP=$L(X):-1:1 Q:$E(X,LOOP)'=" "
 S VAR=$E(X,1,LOOP)
 Q VAR
PAUSE ; Pause screen when data is displayed
 W !!,"Press 'RETURN' to continue"
 R X:DTIME
 I $D(IOF) W @IOF
 Q
PAUSE1 ; Pause screen when data is displayed
 W !!,"Press 'RETURN' to start the display"
 R X:DTIME
 I $D(IOF) W @IOF
 Q
REVIEW(X) ; Prompt user to review obligation document
 S DIR(0)="Y"
 S DIR("B")="YES"
 S DIR("A")="Do you wish to display the source document"
 S DIR("?")="Enter 'NO' or 'N' or '^' if the display is not necessary."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to display the source document."
 D ^DIR
 K DIR
 S RESP=Y
 I $D(Y(0)) S $P(RESP,U,2)=Y(0)
 I $D(DIRUT) S $P(RESP,U,3)=DIRUT
 Q RESP
RETRANS(X) ; Prompt user to rebuild FMS doc from source doc and retransmit
 S DIR(0)="Y"
 S DIR("B")="YES"
 S DIR("A")="Do you wish to rebuild and retransmit this FMS document"
 S DIR("?")="Enter 'NO' or 'N' or '^' to exit."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to rebuild/retransmit this document."
 D ^DIR K DIR
 S RETRAN=Y
 I $D(Y(0)) S $P(RETRAN,U,2)=Y(0)
 I $D(DIRUT) S $P(RETRAN,U,3)=DIRUT
 Q RETRAN
 ;
 ; OPT = 1 if inquiry, 2 if rebuild/retransmit
STATR1(OPT) ;
 S LABEL=$S(MOP=1:"Purchase Order",MOP=21:"1358 Miscellaneous Obligation",MOP=7:"Imprest Fund",MOP=8:"Requistion",MOP=2:"Certified Invoice",MOP=3:"Payment in Advance",MOP=4:"Guaranteed Delivery",1:"Obligation")
 W !,"The "_LABEL_$S(OPT=1:" will",1:" can")
 W " now be displayed for your review.",!!
 W "Please review the source document very carefully and take",!,"the appropriate corrective action.",!
 I OPT=1 D PAUSE
 I OPT=2 W ! S RESP=$$REVIEW(.RESP)
 Q
 ;
FYQ(Z) ; Get Fiscal Year and Quarter
 N X,A,B,C,D
 S %DT="",X="T" D ^%DT
 S A=$E(Y,2,3)
 S B=$E(Y,4,5)
 S C=$E(100+$S(B>9:A+1,1:A),2,3)
 S D=$S(B<4:2,B<7:3,B<10:4,1:1)
 Q C_"^"_D
