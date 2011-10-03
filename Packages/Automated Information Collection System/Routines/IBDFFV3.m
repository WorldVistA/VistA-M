IBDFFV3 ;;ALB/CMR - AICS FORM VALIDATION ; FEB 23, 1996
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
PRINT(FRM,NAME,TYPE,CL,DG) ; -- print validation for each form
 ; -- FRM = ien file 357
 ; -- NAME (optional) name of form
 ; -- TYPE (optional) type of form where:
 ; --    1 = FORM
 ; --    2 = BASIC DEFAULT FORM
 ; --    3 = SUPPLEMENTAL FORM - PATIENT WITH PRIOR VISITS
 ; --    4 = SUPPLEMENTAL FORM - FIRST TIME PATIENT
 ; --    5 = FORM WITH NO PRE-PRINTED PATIENT DATA
 ; --    6 = SUPPLEMENTAL FORM - ALL PATIENTS
 ; --    7 = RESERVED FOR FUTURE USE
 ; --    8 = SUPPLEMENTAL FORM - ALL PATIENTS
 ; --    9 = SUPPLEMENTAL FORM - ALL PATIENTS
 ; -- CL (optional) clinic header
 ; -- DG (optional) group or division header
 N IEN,BUB,NODE,PG,IBDFFVAL,IBID,IBLABEL,PI,CK,CODE,GROUP
 K WRITE
 Q:'FRM!($G(^IBE(357,FRM,0))']"")
 S PG=0
 I $G(NAME)']"" S NAME=$P(^IBE(357,FRM,0),U)
 I '$G(TYPE) S TYPE=1
 S IEN=$P(^IBE(357,FRM,0),U,13) Q:'IEN!('$D(^IBD(357.95,+IEN)))
 W $$CJ^XLFSTR("ENCOUNTER FORM VALIDATION",IOM),!
 I $G(DG)]"" W !,DG
 I $G(CL)]"" W !,CL
 W !,$P($T(TYPE+TYPE),";;",2),"  ",NAME
 K BUB,HP
 ; -- $o through all bubbles
 S BUB=0,GROUP="" F  S BUB=$O(^IBD(357.95,IEN,1,BUB)) Q:'BUB!($G(IBDFOUT))  S NODE=$G(^IBD(357.95,IEN,1,BUB,0)) I NODE]"" D DISP
 K BUB
 S HP=0 F  S HP=$O(^IBD(357.95,IEN,2,HP)) Q:'HP!($G(IBDFOUT))  S NODE=$G(^IBD(357.95,IEN,2,HP,0)) I NODE]"" D DISP
 Q:$G(IBDFOUT)
 D PAGE(100) ;force final page footers
 Q
DISP ; -- display data for each element
 N IBINACT
 N ERR
 ; -- write out group subheader if different from previous
 I GROUP'=$P(NODE,U,5) S GROUP=$P(NODE,U,5) D PAGE(8) Q:$G(IBDFOUT)  I '$G(CK) W !!,GROUP,!
 ; -- determine errors up front
 S PI=$S($D(BUB):$P(NODE,U,3),$D(HP):$P(NODE,U,4),1:"") I 'PI S ERR("PI")=""
 S DQ=$P(NODE,U,10) I 'DQ,$P($G(^IBE(357.6,+PI,0)),U,19) S ERR("DQ")=""
 K IBID,IBLABEL,IBINACT
 I $D(BUB) S X=$P(NODE,U,4) I X,PI X $G(^IBE(357.6,PI,19)) I $G(IBLABEL)']"" S ERR("CODE")=""
 I $G(IBINACT) S ERR("INACT")=""
 D PAGE(5) Q:$G(IBDFOUT)
 ; -- write error flag followed by displayed text
 W ! W:$D(ERR) "*" W ?2,"[ ] ",$S($D(BUB):$P(NODE,U,8),$D(HP):$P(NODE,U,9),1:"") S WRITE=1
 ; -- if bubble is dynamic s code accordingly
 I $D(BUB),($G(IBID)']""),($P(NODE,U,11)) S IBID="DYNAMIC",IBLABEL="Value determined at print time"
 I $D(HP) S IBID="HAND PRINT",IBLABEL="Value determined at scan time"
 ; -- write return values
 I $G(IBID)]"" W !,?6,IBID,?22,$G(IBLABEL)
 ; -- write data qualifiers
 I DQ]"" W !?6,"DATA QUALIFIER",?22,$P($G(^IBD(357.98,DQ,0)),"^")
 I $D(HP),($P(NODE,U,17)) W !?6,"DATA ELEMENT",?22,$P($G(^IBE(359.1,$P(NODE,U,17),0)),U)
 ; -- process errors
 I $D(ERR) D ERROR
 Q
ERROR ;gathers errors to write
 I '$D(ERR) Q
 N CNT
 I $D(ERR("PI")) D ERRORS("*** Package Interface is missing ***")
 I $D(ERR("DQ")) D ERRORS("*** Data Qualifier is missing ***")
 I $D(ERR("CODE")) D ERRORS("*** Invalid "_GROUP_" ***")
 I $D(ERR("INACT")) D ERRORS("*** Inactive "_GROUP_" ***")
 Q
ERRORS(ERR) ; -- writes out errors
 I $G(CNT) W !
 I '$G(CNT) W !?6,"ERRORS" S CNT=1
 W ?22,ERR
 Q
PAGE(PL) ; -- check page length
 ; -- adds two lines to account for footer
 K CK
 I +PL S PL=PL+2
 I '+PL S PL=5
 Q:$Y+PL<IOSL
 S PG=PG+1,CK=1
 W !!,$$CJ^XLFSTR(PG,IOM)
 I $E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR K DIR,DIRUT,DUOUT,DTOUT I 'Y S IBDFOUT=1 Q
 W @IOF
 I +PL<100 D
 .W !,$$CJ^XLFSTR("ENCOUNTER FORM VALIDATION",IOM)
 .W !!,$P($T(TYPE+TYPE),";;",2),"  ",NAME
 .W !!,GROUP,!
 Q
TYPE ; -- list of form types
 ;;FORM:.........................................
 ;;BASIC DEFAULT FORM:  .........................
 ;;SUPPLEMENTAL FORM - PATIENT WITH PRIOR VISITS:
 ;;SUPPLEMENTAL FORM - FIRST TIME PATIENT:  .....
 ;;FORM WITH NO PRE-PRINTED PATIENT DATA:  ......
 ;;SUPPLEMENTAL FORM - ALL PATIENTS:  ...........
 ;;RESERVED FOR FUTURE USE:  ....................
 ;;SUPPLEMENTAL FORM - ALL PATIENTS:.............
 ;;SUPPLEMENTAL FORM - ALL PATIENTS:............. 
