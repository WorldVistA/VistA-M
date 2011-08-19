MCESLIST ;WISC/DCB-This routine will list reports by release status  ;5/2/96  09:58
 ;;2.3;Medicine;;09/13/1996
START ;
 N MCAR,MCARCODE,MCARDE,MCARGDT2,MCARGNAM,MCARGNUM,MCARP,MCBP,MCBS
 N MCEPROC,MCESKEY,MCESON,MCESS,MCESSEC,MCFILE,MCFILE1,MCOUNT
 N MCPATFLD,MCPOSTP,MCPRO,MCPRTRTN,MCROUT,MCSUP,NOPT,MCOPT,PATN,LOC
 N PROC,OPTION,DIR,Y,DTOUT,DIRUT,DIROUT,DUOUT,DHIT,DIOEND,DIROUR
 S OPTION=$P(XQY0,U)
 S MCPRO=$P(OPTION,"MCESSTATUS",2)
 K ^TMP($J,"MC","STATUS")
 D MCPPROC^MCARP1
 I 'MCESON S MCESSEC=$D(^XUSEC(MCESKEY,DUZ)) W !,"Release Control/Elec Signature is turn off"
 I 'MCESSEC W !,"You don't have the required key [",MCESKEY,"]" Q
 D ASK
 I '$D(OUT) D PRINT
 K ^TMP($J,"MC","STATUS"),OUT Q
ASK ;SELECT STATUS
 S DIR(0)="S^1:Release;2:Draft;3:Both"
 S DIR("B")="Both"
 S DIR("A")="Which type of listing do you want see?"
 S DIR("?",1)="1 Release Status - will only release information"
 S DIR("?",2)="2   Draft Status - will only show reports that are in draft status"
 S DIR("?",3)="3           Both - will show all reports"
 S DIR("?")="Help"
 D ^DIR I $D(DTOUT)!$D(DIRUT)!$D(DUOUT)!$D(DIROUR) S OUT="" Q
 S MCOPT=Y
 Q
TEST(REC,OPT,MCFILE) ;Screens out information
 N STATUS,TEST
 S STATUS=$P($G(^MCAR(MCFILE,REC,"ES")),U,7) S:STATUS="" STATUS="D"
 S TEST=OPT+$S(STATUS["D":1,1:0)
 Q $S(STATUS="S":0,OPT=3:1,TEST=1:1,TEST=3:1,1:0)
STAT ;TOTALS OF STATUS
 N STATUS
 S STATUS=$P($G(^MCAR(MCFILE,D0,"ES")),U,7) S:STATUS="" STATUS="NS"
 S ^TMP($J,"MC","STATUS",STATUS)=$G(^TMP($J,"MC","STATUS",STATUS))+1
 Q
PRINT ; Sets up variables for the DIP call
 N DIS,DHD,DA,DIASKHD,PG,L
 S L=""
 S DIC=^DIC(MCFILE,0,"GL")
 S FLDS=".01;""Date/Time"";C1,"_MCPATFLD_";""Patient"";C22;L30,"""";""Status"";C53,1506;""Status"";C53;W;X",BY=".01"
 S DIS(0)="I $$TEST^MCESLIST(D0,MCOPT,MCFILE)"
 S:MCFILE=699 DIS(1)="I $D(^MCAR(697.2,""D"",MCARCODE,+$P(^MCAR(699,+D0,0),U,12)))"
 S DHD=$S(MCOPT=1:"Release Status Report",MCOPT=2:"Draft Status Report",1:"Status Report"),MCDHD=DHD
 S DIOEND="D STATUS^MCESLIST"
 S DHIT="D STAT^MCESLIST"
 D EN1^DIP
 Q
STATUS ; Prints a status count
 N LOOP,STATUS,INFO,COUNT,TOTAL,LINE,DIR,Y,%
 S LINE="" S $P(LINE,"-",80)=""
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR I $D(DTOUT)!$D(DIRUT)!$D(DUOUT)!$D(DIROUR) S OUT="" Q
 W @IOF,MCDHD_" statistics"
 D NOW^%DTC S Y=% D DD^%DT W ?46,$P(Y,"@")_"   "_$P(Y,"@",2)
 W !,LINE,!!
 S STATUS=$S(MCOPT=1:"R",MCOPT=2:"D",1:"")
 F LOOP="D","PD","RV","ROV","RNV","SRV","SROV","NS" D
 .I LOOP="NS"&(STATUS="D") S STATUS=""
 .I STATUS=""!(LOOP[STATUS) D
 ..S COUNT=+$G(^TMP($J,"MC","STATUS",LOOP))
 ..S TOTAL=$G(TOTAL)+COUNT
 ..I LOOP'="NS" S INFO=$$STATUS^MCESEDT(MCFILE,LOOP)
 ..E  S INFO="NO STATUS/DRAFT"
 ..S INFO=$J(INFO,45)_": "
 ..W !,INFO,?50,$J($FN(COUNT,",",0),10)
 W !,?50,$E(LINE,1,10),!,?50,$J($FN(TOTAL,",",0),10),!!
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR
 W @IOF
 Q
