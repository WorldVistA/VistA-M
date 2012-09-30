PRSNCAPE ;WOIFO/DWA - PAID PARAMETER ENTER/EDIT ;07/30/09
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;  Key variables used in this routine:
 ;
 ;     PPI,PPE,PPST = Current pay period internal value, external
 ;                    value and start date
 ;     LPPE,LPST    = Last pay period external value and start date
 ;     NPPE,NPST    = Next pay period external value and start date
 ;
 ;     IENS         = Internal entry number of selected institution
 ;     IENS2        = External value of selected institution
 ;
 ;     PRSFDA       = A name spaced FileMan Data Array
 ;     PAYPD        = External value of selected effective pay period
 ;     PPDI         = Internal entry number of selected effective
 ;                    pay period
 ;
 ;
EN ; Entry point for PAID Application Parameter Edit
 N OUT S OUT=0 D SHODIVAC(.OUT) Q:OUT
 K DIC
 N PPI,PPE,PPST,LPPE,LPST,NPPE,NPST,IENS,IENS2,PRSFDA,PAYPD,PPDI
 N X1,X2,X,Y,ORIGPP,NAM,NAM2
 S PPI=$P($G(^PRST(458,"AD",DT)),"^")
 I 'PPI W !!,"Current Pay Period must be open for testing.  Quitting." Q
 S PPE=$P(^PRST(458,PPI,0),"^")
 S LPPE=$P(^PRST(458,PPI-1,0),"^")
 S NPPE=$E($$NXTPP^PRSAPPU(PPE),3,7)
 S PPST=$P(^PRST(458,PPI,1),"^")
 S LPST=$P(^PRST(458,PPI-1,1),"^")
 S X1=PPST,X2=14 D C^%DTC S NPST=X
 D HDR
 N DIC,X,Y,DUOUT,DTOUT,DLAYGO
 S DIC="^PRST(456,",DIC(0)="ALEQMZ",DLAYGO=456,DIC("A")="Select Institution: "
 D ^DIC
 Q:$D(DUOUT)!$D(DTOUT)!(+Y'>0)
 S IENS=+Y,IENS2=$P(Y,U,2)
PPDS ; Set the effective pay period
 S X=PPST D DTP^PRSAPPU
 W !!!,"C = Current Pay Period beginning "_Y
 S X=LPST D DTP^PRSAPPU
 W !,"L = Last Pay Period beginning "_Y
 S X=NPST D DTP^PRSAPPU
 W !,"N = Next Pay Period beginning "_Y,!
 N DIR,DIRUT,Y,PRSDT
 S DIR(0)="SB^C:Current;N:Next;L:Last",DIR("A")="Select Effective Pay Period; Current, Next, Last"
 D ^DIR K DIR Q:$D(DIRUT)
 W !!
 S PAYPD=$S(Y="C":PPE,Y="N":NPPE,1:LPPE)
 ;
 S PRSDT=$S(Y="C":PPST,Y="N":NPST,1:LPST)
 ;
 S PPDI=$O(^PRST(456,IENS,1,"B",PAYPD,0))
 ;
 S NAM=$$DIVACC^PRSNUT02(PRSDT,IENS2)
 S ORIGPP=$P(NAM,U,2)
 S NAM=$P(NAM,U)
 S NAM2=$S(NAM="N":"T",1:"N")
 ;
 ; If no existing entry, set one up, otherwise Update existing entry
 I PPDI'>0 D
 .  D NA1
 E  D
 . W !!,"The Nurse Access Method for "_$$EXTERNAL^DILFD(456,.01,"",IENS2)_" pay period "_PAYPD_" is currently set to ",!,$$EXTERNAL^DILFD(456.05,1,"",NAM)_".  Do you wish to change it?",!!
 . N DIR,Y,DIRUT
 . S DIR(0)="Y",DIR("B")="Yes" D ^DIR K DIR Q:$D(DIRUT)
 . I Y=0 W "   No changes made, quitting.",!! Q
 . S NAM=NAM2
 . S PRSFDA(456.05,PPDI_","_IENS_",",1)=NAM
 . D FILE^DIE("","PRSFDA",""),MSG^DIALOG()
 . W !!,"The Nurse Access Method for "_$$EXTERNAL^DILFD(456,.01,"",IENS2)_" has been successfully changed to ",!,$$EXTERNAL^DILFD(456.05,1,"",NAM)_" Effective Pay Period "_PAYPD_".",!!
 . Q
 Q
 ;
 ;
NA1 ; Create a new sub-record and set nurse access parameter
 ;
 N STOP,PPDI
 S STOP=0
 N DIR,Y,DIRUT
 I ORIGPP'="" D
 .  W !!,"The Nurse Access Method for "_$$EXTERNAL^DILFD(456,.01,"",IENS2)_" pay period "_PAYPD_" is currently set to ",!,$$EXTERNAL^DILFD(456.05,1,"",NAM)_".  Do you wish to change it?",!! D
 . S DIR(0)="Y",DIR("B")="Yes" D ^DIR K DIR Q:$D(DIRUT)
 . I Y=0 W "   No changes made, quitting.",!! S STOP=1 Q
 . S NAM=NAM2
 E  D
 . S DIR(0)="SB^N:Nurse Location;T:T&L Unit",DIR("A")="Select Nurse Access Method; Nurse Location or T&L Unit" D ^DIR K DIR Q:$D(DIRUT)
 . S NAM=X
 ;
 Q:STOP
 N PRSFDA,PRSIENS,PPDI
 S PRSFDA(456.05,"+2,"_IENS_",",.01)=PAYPD
 D UPDATE^DIE("","PRSFDA","PRSIENS"),MSG^DIALOG()
 S PPDI=PRSIENS(2)
 S PRSFDA(456.05,PPDI_","_IENS_",",1)=NAM
 D FILE^DIE("","PRSFDA",""),MSG^DIALOG()
 W !!,"The Nurse Access Method for "_$$EXTERNAL^DILFD(456,.01,"",IENS2)_" has been successfully set to ",!,$$EXTERNAL^DILFD(456.05,1,"",NAM)_" Effective Pay Period "_PAYPD_".",!!
 Q
 ;
 ;
 ;
HDR ;
 N L1,L2
 I $E(IOST,1,2)="C-" W @IOF
 S L1="VA TIME & ATTENDANCE SYSTEM",L2="PAID PARAMETERS ENTER/EDIT"
 W ?((80-$L(L1))/2),L1,!,?((80-$L(L2))/2),L2,!!!!
 Q
 ;
SHODIVAC(OUT) ; DISPLAY POC ACCESS (T&L/NURSE LOCATION) FOR ALL DIVISIONS
 ;
 N DIR,X,Y,DIRUT S DIR(0)="Y",DIR("A")="Show history" D ^DIR
 Q:$D(DIRUT)
 W @IOF
 N HIST,CNT,DIVI
 S HIST=Y
 D SDHDR
 S (CNT,DIVI)=0
 F  S DIVI=$O(^PRST(456,"B",DIVI)) Q:DIVI'>0!OUT  D
 .  S CNT=CNT+1
 .  I CNT>1,HIST D SDHDR
 .  S X=$P($$DIVACC^PRSNUT02(DT,DIVI),U)
 .  W !
 .  W $$EXTERNAL^DILFD(456,.01,"",DIVI)
 .  N FIELDS,STATNUM
 .  D GETS^DIQ(4,DIVI_",","99","E","FIELDS(",,)
 .  S STATNUM=FIELDS(4,DIVI_",",99,"E")
 .  W " (",STATNUM,")"
 .  W ?32,$S(X="N":"Nurse Location",X="T":"T&L Unit",1:"None")
 .  W ?55,"(Current)"
 .  I HIST D ACCHIST(DIVI) W !!! S OUT=$$ASK^PRSLIB00()
 I 'HIST W !!! S OUT=$$ASK^PRSLIB00()
 Q
ACCHIST(DIVI) ; SHOW HISTORY OF POC ACCESS (T&L/NURSE LOC) FOR A DIVISION
 ;
 N DPI,PPE,AP,PPE
 S DPI=$O(^PRST(456,"B",DIVI,0))
 Q:DPI'>0
 S PPE=""
 F  S PPE=$O(^PRST(456,DPI,1,"C",PPE)) Q:PPE=""  D
 .  S AP=$O(^PRST(456,DPI,1,"C",PPE,""))
 .  W !?32,$S(AP="N":"Nurse Location",1:"T&L Unit")
 .  W ?57,PPE
 Q
SDHDR ; SHOW DIVISION HEADER
 W @IOF,!!!
 W !?30,"DATA ENTRY/APPROVAL",?55,"EFFECTIVE"
 W !,"   DIVISION",?30,"ACCESS TO NURSE VIA",?55,"PAY PERIOD"
 W !,"===============",?29,"======================",?54,"============"
 Q
 ;
