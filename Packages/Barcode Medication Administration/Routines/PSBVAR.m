PSBVAR ;BIRMINGHAM/EFC-BCMA VARIANCE LOG FUNCTIONS ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;*31*;Mar 2004;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference/IA
 ; ^DPT/10035
 ; ^DIC(42/10039
 ;
EN ;
 Q
 ;
CHKPRN(DFN,PSBMIN,PSBLOG) ;
 Q:PSBMIN=""
 Q:PSBMIN'>$$GET^XPAR("DIV","PSB ADMIN PRN EFFECT")
 D ADD(.RESULTS,DFN,3,PSBMIN,"",PSBLOG)
 Q
 ;
 ;CHECK^PSBVAR() calling point is used to create a new variance entry.  Triggered by Order Administration Variance Field # 14 in the BCMA Medication Log File (#53.79).
 ;
CHECK(DFN,PSBMIN,PSBLOG) ;
 Q:PSBMIN=""
 N RESULTS
 ; Checks the timing from the Med Log Entry X-Ref
 I PSBMIN<0 D:(PSBMIN*-1)>$$GET^XPAR("DIV","PSB ADMIN BEFORE") ADD(.RESULTS,DFN,2,PSBMIN,"",PSBLOG)
 I PSBMIN>0 D:PSBMIN>$$GET^XPAR("DIV","PSB ADMIN AFTER") ADD(.RESULTS,DFN,2,PSBMIN,"",PSBLOG)
 Q
 ;
ADD(RESULTS,DFN,PSBEVNT,PSBMIN,PSBDRUG,PSBLOG) ;
 ;
 ; DFN:      Patient File (#2) Pointer
 ; PSBEVNT:  Event Code (See DD for 53.78)
 ; PSBMIN:   Minutes off of schedule (Optional)
 ; PSBDRUG:  Drug File (#50) Pointer (Optional)
 ; PSBLOG:   BCMA Med Log IEN (Optional)
 ;
 ;Do not create variance for med order with missing dose status.
 I $G(PSBLOG),$P($G(^PSB(53.79,PSBLOG,0)),U,9)="M" Q
 ;
 N PSBDT,PSBRB,PSBWRD,PSBXX
 ;
 D EN^DDIOL("Filing Variance...")
 D NOW^%DTC
 L +(^PSB(53.78,0)):5 E  S RESULTS(0)="-1^Variance Log Locked" Q
 S PSBXX=$O(^PSB(53.78,"A"),-1)+1
 S $P(^PSB(53.78,0),U,3)=PSBXX
 S $P(^PSB(53.78,0),U,4)=$P(^PSB(53.78,0),U,4)+1
 ;
WARD ;Extract the ward and room/bed information.
 ;DFN is pre-defined.
 S PSBRB=$P($G(^DPT(DFN,.101)),U)
 S PSBRB=$S(PSBRB'="":PSBRB,1:"***")
 S PSBWRD=$P($G(^DPT(DFN,.1)),U)
 ;Convert Ward Name to Ward IEN
 I PSBWRD'="" D
 . S PSBDT=%
 . S PSBWRD=$$FIND1^DIC(42,"","X",PSBWRD,"","","ERR")
 . S %=PSBDT ;reset after $$FIND1^DIC fileman call
 S PSBWRD=$S($G(PSBWRD):PSBWRD,1:"***")
 ;
 ; Set Variance Entry
 S ^PSB(53.78,PSBXX,0)=DFN_U_PSBRB_U_DUZ_U_%_U_PSBEVNT_U_$G(PSBMIN)_U_$G(PSBDRUG)_U_$G(PSBLOG)_U_PSBWRD
 ;
 S ^PSB(53.78,"ADT",%,PSBXX)=""
 S ^PSB(53.78,"B",DFN,PSBXX)=""
 L -(^PSB(53.78,0))
 S RESULTS(0)="1^Data Filed"
 Q
 ;
 ; Unable to UPDATE^DIE WHILE IN UPDATE^DIE
 W !,"Filing Variance..."
 D EN^DDIOL("Filing Variance...")
 N PSBVFDA,PSBVMSG,PSBVIEN
 D VAL(.01,"`"_DFN) ; Patient Pointer
 S Y=$G(^DPT(DFN,.1),"Unk Ward")_" "_$G(^DPT(DFN,.101),"Unk Bed")
 D VAL(.02,Y) ; Patient Location
 D VAL(.03,"`"_DUZ) ; New Person Pointer
 D VAL(.04,"NOW") ; DT Entered
 D VAL(.05,PSBEVNT) ; Event Code
 D:$G(PSBMIN) VAL(.06,PSBMIN) ; Minutes Early/Late
 D:$G(PSBDRUG) VAL(.07,"`"_PSBDRUG) ; Drug File Pointer
 D:$G(PSBLOG) VAL(.08,"`"_PSBLOG)
 ; Call UPDATE^DIE and set Results(0)
 D UPDATE^DIE("","PSBVFDA","PSBVIEN","PSBVMSG")  ; PSBVFDA set into file 53.68, BCMA MEDICATION VARIANCE LOG at VAL+3
 I $D(PSBVMSG) S RESULTS(0)="-1^"_PSBVMSG("DIERR",1)_": "_PSBVMSG("DIERR",1,"TEXT",1)
 E  S RESULTS(0)="1^Data Successfully Filed^"_PSBVIEN(1)
 W !,RESULTS(0)
 Q
 ;
VAL(PSBVFLD,PSBVVAL) ;
 N PSBVRET
 K ^TMP("DIERR",$J)
 D VAL^DIE(53.78,"+1,",PSBVFLD,"F",PSBVVAL,.PSBVRET,"PSBVFDA")
 I PSBVRET="^" F X=0:0 S X=$O(^TMP("DIERR",$J,X)) Q:'X  S Y=^TMP("DIERR",$J,X)_": "_$G(^(X,"TEXT",1),"**"),RESULTS($O(RESULTS(""),-1)+1)="Data Validation Error: "_Y
 K ^TMP("DIERR",$J)
 Q
 ;
