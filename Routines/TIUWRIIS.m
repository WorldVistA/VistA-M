TIUWRIIS ;SLC/AJB,AGP - War Related Illness and Injury Study Center ; 08/18/03
 ;;1.0;TEXT INTEGRATION UTILITIES;**159**;Jun 20, 1997
 ;
 Q
ADDRESS(DFN) ;
 N TIUCNT,TIUI,TIUY,VAPA S TIUI=0
 N TIUCITY,TIUST,TIUZIP
 D ADD^VADPT
 S TIUY=$NA(^TMP("TIUWRIISC",$J))
 F TIUCNT=1:1:3 D
 . Q:VAPA(TIUCNT)=""
 . S TIUI=TIUI+1
 . S @TIUY@(TIUI,0)=VAPA(TIUCNT) I TIUCNT>1 S @TIUY@(TIUI,0)="             "_@TIUY@(TIUI,0)
 S TIUCITY="             "_VAPA(4)
 S TIUST=$$GET1^DIQ(5,+VAPA(5),1)
 S TIUZIP=VAPA(6)
 S @TIUY@(4,0)=TIUCITY_", "_TIUST_"  "_TIUZIP
 Q "~@"_$NA(@TIUY)
LAB2(DFN,TIUTEST,COUNT,TPERIOD,TIUEDT,TIULDT) ; Get Lab Results
 N CNT,DRANGE,INDATE,LABIEN,NUM,OUTPUT,REGDATE,SEQ,SEQ1,SUB,STRING
 N TIULOUT,TIUY,TIUTST,TIUX,TMP1,TMP2
 K ^TMP($J,"TIUWRIIS","LABOUT"),^TMP("LRRR",$J)
 I $G(TPERIOD)="",$G(TIUEDT)="",$G(TIULDT)="" Q "<Invalid Date or Time Period Entered>"
 I ($G(TPERIOD)?1"T-"1N.N) D
 . S TIULDT=$$NOW^XLFDT D DT^DILF("P",TPERIOD,.DRANGE) S TIUEDT=$G(DRANGE)
 I $G(COUNT)="" S COUNT=1
 I $G(TIUTEST)="" Q "LAB NAME NOT FOUND"
 S LABIEN=+$O(^LAB(60,"B",TIUTEST,0))
 I '+$G(LABIEN) Q "INVALID LAB TEST NAME"
 D RR^LR7OR1(DFN,"",$G(TIUEDT),$G(TIULDT),"",LABIEN,"",$G(COUNT),"",0)
 I '$D(^TMP("LRRR",$J)) Q "No Lab Information Found for "_TIUTEST
 S TIULOUT="^TMP($J,""TIUWRIIS"",""LABOUT"")",CNT=1,@TIULOUT@(CNT,0)="Lab Information for "_TIUTEST
 S STRING=$$LJ^XLFSTR("Collection Date/Time",25),STRING=STRING_$$LJ^XLFSTR("Specimen",10)
 S STRING=STRING_$$LJ^XLFSTR("Test",8),STRING=STRING_$$LJ^XLFSTR("Result",12)
 S STRING=STRING_$$LJ^XLFSTR("Range",10),CNT=CNT+1,@TIULOUT@(CNT,0)=STRING
 S SUB="" F  S SUB=$O(^TMP("LRRR",$J,DFN,SUB)) Q:SUB=""  D
 . S INDATE=""  F  S INDATE=$O(^TMP("LRRR",$J,DFN,SUB,INDATE)) Q:+INDATE'>0  D
 . . S SEQ="" F  S SEQ=$O(^TMP("LRRR",$J,DFN,SUB,INDATE,SEQ)) Q:SEQ=""  D
 . . . I SEQ'="N" D
 . . . . S CNT=CNT+1
 . . . . S REGDATE=$$FMTE^XLFDT(9999999-INDATE)
 . . . . S NODE=$G(^TMP("LRRR",$J,DFN,SUB,INDATE,SEQ))
 . . . . S STRING=$$LJ^XLFSTR(REGDATE,25)
 . . . . S STRING=STRING_$$LJ^XLFSTR($$GET1^DIQ(61,$P($G(NODE),U,19)_",",.01),10)
 . . . . S STRING=STRING_$$LJ^XLFSTR($P($G(NODE),U,15),8)
 . . . . S STRING=STRING_$$LJ^XLFSTR($P($G(NODE),U,2)_" "_$P($G(NODE),U,3)_$P($G(NODE),U,4),12)
 . . . . S STRING=STRING_$$LJ^XLFSTR($P($G(NODE),U,5),10)
 . . . . S @TIULOUT@(CNT,0)=STRING
 . . . I SEQ="N" S SEQ1="" F  S SEQ1=$O(^TMP("LRRR",$J,DFN,SUB,INDATE,SEQ,SEQ1)) Q:+SEQ1'>0  D
 . . . . S NODE=$G(^TMP("LRRR",$J,DFN,SUB,INDATE,SEQ,SEQ1))
 . . . . I $G(NODE)["[" D
 . . . . . S NAME=$P($G(NODE),"[",2),NAME=$P($G(NAME),"]",1)
 . . . . . S NAME=$$GET1^DIQ(200,$G(NAME)_",",.01)
 . . . . . S TMP1=$P($G(NODE),"["),TMP2=$P($G(NODE),"]",2)
 . . . . . S NODE=TMP1_" "_NAME_" "_TMP2
 . . . . S CNT=CNT+1,@TIULOUT@(CNT,0)="Comment: "_NODE
 K ^TMP("LRRR",$J)
LABQ Q "~@"_$NA(@TIULOUT)
PNOK(DFN) ;
 N CNT,PNOK,VAOA
 K ^TMP($J,"TIUWRIIS","PNOK")
 D OAD^VADPT
 S CNT=1
 S PNOK="^TMP($J,""TIUWRIIS"",""PNOK"")"
 I $D(VAOA) D
 . S @PNOK@(CNT,0)="Primary Next of Kin Information"
 . S CNT=CNT+1
 . S @PNOK@(CNT,0)=$S($G(VAOA(9))'="":$G(VAOA(9)),1:"No Next of Kin Enter")
 . S CNT=CNT+1
 . S @PNOK@(CNT,0)=$S($G(VAOA(10))'="":"Relationship to Patient: "_VAOA(10),1:"Relationship Unknown")
 . S CNT=CNT+1
 . I $G(VAOA(1))=""&($G(VAOA(2))="")&($G(VAOA(3))="") S @PNOK@(CNT,0)="No Address Information Enter"
 . E  D
 . . S @PNOK@(CNT,0)=$G(VAOA(1))
 . . I $G(VAOA(2))'="" S @PNOK@(CNT,0)=@PNOK@(CNT,0)_" "_VAOA(2)
 . . I $G(VAOA(3))'="" S CNT=CNT+1 S @PNOK@(CNT,0)=VAOA(3)
 . S CNT=CNT+1
 . I $G(VAOA(4))'="" S @PNOK@(CNT,0)=$G(VAOA(4))_", "_$P($G(VAOA(5)),U,2)_" "_$G(VAOA(6))
 . I $G(VAOA(8))'="" S CNT=CNT+1 S @PNOK@(CNT,0)="Home Phone Number: "_VAOA(8)
 E  Q "No Next Kin Information Found"
 Q "~@"_$NA(@PNOK)
 ;
SNOK(DFN) ;
 N CNT,VAOA
 K ^TMP($J,"TIUWRIIS","SNOK")
 S VAOA("A")=3
 D OAD^VADPT
 S CNT=1
 S PNOK="^TMP($J,""TIUWRIIS"",""SNOK"")"
 I $D(VAOA) D
 . S @PNOK@(CNT,0)="Secondary Next of Kin Information"
 . S CNT=CNT+1
 . S @PNOK@(CNT,0)=$S($G(VAOA(9))'="":$G(VAOA(9)),1:"No Next of Kin Enter")
 . S CNT=CNT+1
 . S @PNOK@(CNT,0)=$S($G(VAOA(10))'="":"Relationship to Patient: "_VAOA(10),1:"Relationship Unknown")
 . S CNT=CNT+1
 . I $G(VAOA(1))=""&($G(VAOA(2))="")&($G(VAOA(3))="") S @PNOK@(CNT,0)="No Address Information Enter"
 . E  D
 . . S @PNOK@(CNT,0)=$G(VAOA(1))
 . . I $G(VAOA(2))'="" S @PNOK@(CNT,0)=@PNOK@(CNT,0)_" "_VAOA(2)
 . . I $G(VAOA(3))'="" S CNT=CNT+1 S @PNOK@(CNT,0)=VAOA(3)
 . S CNT=CNT+1
 . I $G(VAOA(4))'="" S @PNOK@(CNT,0)=$G(VAOA(4))_", "_$P($G(VAOA(5)),U,2)_" "_$G(VAOA(6))
 . I $G(VAOA(8))'="" S CNT=CNT+1 S @PNOK@(CNT,0)="Home Phone Number: "_VAOA(8)
 E  Q "No Next Kin Information Found"
 Q "~@"_$NA(@PNOK)
 ;
VITALS(DFN,TEST,COUNT,TPERIOD) ; Return vitals for last 24 hours.
 N %,CNT,DATE,END,GMRVSTR,IEN,INVDATE,NODE,START,TIUVITAL,VITAL,VITALS
 K ^TMP($J,"TIUWRIIS","VITALS")
 K ^UTILITY($J,"GMRVD")
 I ($G(TPERIOD)?1"T-"1N.N) D
 . D NOW^%DTC S END=%
 . D DT^DILF("P",TPERIOD,.DRANGE)
 . S START=$G(DRANGE)_"."_$P(END,".",2)
 E  I $G(TPERIOD)'="" Q "INVALID DATE TIME PERIOD ENTER"
 S CNT=1
 S DATE=0
 S TIUVITAL="^TMP($J,""TIUWRIIS"",""VITALS"")"
 S GMRVSTR=$G(TEST)
 S GMRVSTR(0)=START_U_END_U_COUNT_U_"1"
 D EN1^GMRVUT0
 I '$D(^UTILITY($J,"GMRVD")) S @TIUVITAL@(CNT,0)="No Vitals Were Found" Q "~@"_$NA(@TIUVITAL)
 S INVDATE="" F  S INVDATE=$O(^UTILITY($J,"GMRVD",INVDATE)) Q:+INVDATE=0  D
 . S VITAL="" F  S VITAL=$O(^UTILITY($J,"GMRVD",INVDATE,VITAL)) Q:VITAL=""  D
 . .S IEN="" F  S IEN=$O(^UTILITY($J,"GMRVD",INVDATE,VITAL,IEN)) Q:+IEN=0  D
 . . . S NODE=^UTILITY($J,"GMRVD",INVDATE,VITAL,IEN)
 . . . I DATE'=INVDATE D  Q
 . . . . S @TIUVITAL@(CNT,0)="Vitals Enter at: "_$$FMTE^XLFDT(9999999-INVDATE)
 . . . . S CNT=CNT+1
 . . . . S DATE=INVDATE
 . . . . S @TIUVITAL@(CNT,0)=VITAL_": "_$P($G(NODE),U,8)
 . . . . S CNT=CNT+1
 . . . I DATE=INVDATE D
 . . . . S @TIUVITAL@(CNT,0)=VITAL_": "_$P($G(NODE),U,8)
 . . . . S CNT=CNT+1
 K ^UTILITY($J,"GMRVD")
 Q "~@"_$NA(@TIUVITAL)
PROB(DFN) ; Get total active problem list for a patient
 N CNT,CNT1,ROOT,NODE,STRING,TIUPOUT
 K ^TMP($J,"TIUWRIIS","PROB")
 S TIUPOUT="^TMP($J,""TIUWRIIS"",""PROB"")"
 S CNT1=1
 D LIST^GMPLUTL2(.ROOT,+DFN,"A")
 I '$D(ROOT) Q "No Active Problem Found"
 S @TIUPOUT@(CNT1,0)=$$LJ^XLFSTR("Code",10)_$$LJ^XLFSTR("Description",63) S CNT1=CNT1+1
 S CNT=0 F  S CNT=$O(ROOT(CNT)) Q:'CNT  D
 . S NODE=$G(ROOT(CNT)) Q:$P($G(NODE),U,10)["$"!($P($G(NODE),U,3)="")
 . S STRING=$$LJ^XLFSTR($P($G(NODE),U,4),10)_$P($G(NODE),U,3)
 . S @TIUPOUT@(CNT1,0)=STRING
 . S CNT1=CNT1+1
 Q "~@"_$NA(@TIUPOUT)
