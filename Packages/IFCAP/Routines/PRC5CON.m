PRC5CON ;WISC/PLT-IFCAP V5 STATION MERGE/CALM CODE SHEET CONVERSION ; 08/22/95  3:18 PM
V ;;5.0;IFCAP;**27**;4/21/95
 ;QUIT  ; invalid entry
 ;
EN ;start station merge/convert CALM code sheet to FMS
 N PRCIVER,PRCRI,PRCFIXV,PRCOPT,PRC5INST,PRCQ21,PRCDUZ
Q1 D EN^DDIOL(" ") S PRCFIXV="IFCAP"_$P($T(+2^PRCINIT),";",3)
 S PRCIVER=$$IVER("IFCAP",PRCFIXV)
 I +PRCIVER'=5 D EN^DDIOL("Your site must install IFCAP v5 before running this patch routine.") G EXIT
 D EN^DDIOL(" "),EN^DDIOL("If your site has substations and you are not a Conversion III site, run"),EN^DDIOL("     Options 1 & 2 only.")
 D EN^DDIOL("If your site has substations and you are a Conversion III site, run "),EN^DDIOL("     Options 1, 2, 3 & 4.")
  D EN^DDIOL("If your site has no substations and you are a Conversion III site, run"),EN^DDIOL("     Options 3 & 4.")
 D EN^DDIOL("If your site has no substations and you are not a Conversion III site,"),EN^DDIOL("    DO NOT run ANY Options.")
 D EN^DDIOL(" ")
 D SC^PRC0A(.X,.Y,"Select IFCAP V5 option","OM^1:Requests(1996-) Substation ENTER/EDIT;2:Purchase Orders(1996-) Substation ENTER/EDIT;3:Convert PO CALM Code Sheets(1996-) to FMS Documents;4:CALM Code Sheet Conversion Exception List","")
 G:X["^"!(X="") EXIT
 S PRCOPT=X
 I PRCOPT=3 D  G:X["^"!(X="") Q1 S PRCQ21=Y G Q3
 . D YN^PRC0A(.X,.Y,"Submit the File 442 Conversion & Generating FMS Doc. to the TASK MANAGER","O","")
 . QUIT
 I PRCOPT=4 G Q3
 ;
Q2 ;select auto/single
 D SC^PRC0A(.X,.Y,"Select "_$P("REQUESTS^PURCHASE ORDER","^",PRCOPT)_" Substation Option","OM^1:AUTO PROMPT TRANSACTION #;2:MANUAL SELECT TRANSACTION #","")
 G:X["^"!(X="") Q1
 S $P(PRCOPT,"^",2)=X
Q3 D YN^PRC0A(.X,.Y,"Ready to run the selected option(s) '"_$TR(PRCOPT,"^","-")_"'","O","NO")
 G:X["^"!(X="")!(Y<1) Q1
 I +PRCOPT<3,'$O(^PRC(411,"UP","")) D EN^DDIOL("No substations are in file, use substation ENTER/EDIT to add first.") G Q1
 I +PRCOPT<3 D  D EN^PRC5CON1:$P(PRCOPT,"^",2)=1,EN1^PRC5CON1:$P(PRCOPT,"^",2)=2 G Q1
 . S PRCDD=$S(PRCOPT-2:410,1:442)
 . QUIT
 I PRCOPT=4 D EN1 G Q1
 S PRCDUZ=DUZ
 I PRCQ21=1 D  G EXIT
 . D EN^DDIOL("NOTE: Please schedule this task with a date '10/14/95'.")
 . D EN^DDIOL("IFCAP V5 CALM CODE SHEET CONVERSION SUBMITTED TO TASK MANAGER AT "_$$NOW^PRC5A)
 . S A=$$TASK^PRC0B2("EN^PRC5CON2~IFCAP V5 CALM CODE SHEET CONVERSION","PRCDUZ",1)
 . I A D EN^DDIOL("IFCAP V5 CALM CODE SHEET CONVERSION HAS TASK NUMBER "_$P(A,"^"))
 . QUIT
 D:DT>2951013 EN^PRC5CON2
 I DT<2951014 D EN^DDIOL("It is too early to run the CALM code sheet conversion."),EN^DDIOL("Please run after 10/13/95.")
EXIT ;
 QUIT
 ;
EN1 ;calm code sheet conversion exception list
 S PRCRI(420.92)=$O(^PRCU(420.92,"B","PRCCALM","")) D:'PRCRI(420.92)
 I 'PRCRI(420.92) D EN^DDIOL("Nothing in file. You must run this list after Option 3 has completed")
 D
 . N L,DIC,FLDS,BY,FR,TO,DHD
 . S L=0,DIC=420.92,FLDS="4;""""",BY="@NUMBER",FR=PRCRI(420.92),TO=FR
 . S DHD="CALM CODE SHEET CONVERSION EXCEPTION LIST"
 . D EN1^DIP
 . QUIT
 QUIT
 ;
 ;prca=package name .01 in file 9.4, prcb=fix value .01 in file 420.92
IVER(PRCA,PRCB) ;get initial version #
 N A
 S A="",PRCRI(420.92)=$O(^PRCU(420.92,"B",PRCB,0)) I PRCRI(420.92) D
 . S A=$P(^PRCU(420.92,PRCRI(420.92),0),"^",2),A=$P(A,"/",2)
 . QUIT
 I A="" S PRCRI(9.4)=$O(^DIC(9.4,"B",PRCA,0)) I PRCRI(9.4) D
 . S A=$P(^DIC(9.4,PRCRI(9.4),"VERSION"),"^",1)
 . QUIT
 QUIT +A
