TIUPNCV3 ;SLC/DJP ;PNs ==> TIU cnv rtns ;5-7-97
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
ERRORLOG ;Captures information on records that are NOT converted.
 S BADREC=1 I '$D(ERRCTR) S ERRCTR=0
 S ERRCTR=ERRCTR+1 S $P(^TIU(8925.97,1,0),U,7)=ERRCTR
 S ^GMR(121,"ERROR",GMRPIFN)=PROBLEM
 Q
 ;
TITLE ;Defines variables required for Document Definition look-up
 ; PNT=^GMR(121.2,TIU("TITLE")),0)
 ; (1)=TITLE * (2)=TYPE * (3) TYPE NARRATIVE
 ; (4)=INACTIVE * (5) TIU TITLE IEN
 S PNT=$G(^GMR(121.2,TIU("TITLE"),0))
 I PNT="" S PROBLEM="Progress Note - IFN "_GMRPIFN_":  TITLE not defined in ^GMR(121.2 - (broken pointer)." D ERRORLOG K PROBLEM Q
 S PNT(5)=$P($G(^GMR(121.2,TIU("TITLE"),1)),U,3)
 I PNT(5)'>0 S PROBLEM="Progress Note IFN "_GMRPIFN_":  TITLE not defined in ^TIU(8925.1." D ERRORLOG K PROBLEM Q
 S PNT(1)=$P($G(PNT),U,1),PNT(2)=$P($G(PNT),U,2),PNT(4)=$P($G(PNT),U,4)
 I PNT(1)=""!PNT(2)="" S PROBLEM="Progress Note - IFN "_GMRPIFN_":  Incomplete TITLE information in ^GMR(121.2." D ERRORLOG K PROBLEM Q
 S X=PNT(2),DIC=121.1,DIC(0)="X,Z" D ^DIC K DIC
 I +Y<0 S PROBLEM="Progress Note IFN "_GMRPIFN_":  TYPE not defined in ^GMR(121.1 (broken pointer)." D ERRORLOG K PROBLEM Q
 S PNT(3)=$P(Y,U,2)
 I $P($G(^TIU(8925.1,PNT(5),0)),U,4)'="DOC" S PROBLEM="Progress Note Title:  "_PNT(3)_" not defined correctly in ^TIU(8925.1." D ERRORLOG K PROBLEM Q
 I PNT(4)'="" S TIU(1701)=PNT(1),X=PNT(2) D TITLESET Q
 D TITLESET
 Q
 ;
TITLESET ;Sets pointers for Document Definition
 ; .01 DOCUMENT TYPE * .04 PARENT DOCUMENT TYPE
 ; 1506 COSIGNATURE REQUIRED * 1701 SUBJECT (description)
 S TIU(.01)=PNT(5),TIUNM=$P(^TIU(8925.1,PNT(5),0),U,1)
 S TIU(.04)="",TIU(.04)=$O(^TIU(8925.1,"AD",TIU(.01),TIU(.04)))
 K X,Y,DIC
 Q
 ;
STATUS(TIUSTAT) ;Returns DOCUMENT STATUS pointer
 N DIC,X,Y
 I TIU("MHCONV")="Y" S TIUSTAT="COMPLETED"
 S X=TIUSTAT,DIC="^TIU(8925.6,",DIC(0)="X,Z" D ^DIC Q:+Y<1
 Q $P(Y,U,1)
 ;
DXLS(TIUDX) ;Resolves variable DXLS ptr from Final Discharge Note
 S P5=""
 S P1=$P(TIUDX,";",2) ;    Global reference
 S P2=$P(TIUDX,";",1) ;    IEN
 S P3="^"_P1_P2_","_0_")" ;^(0) reference
 S P4="^"_P1_P2_",""D"")" ;^("D") reference
 I P1["ICD9" D  Q P5
 .S P5=$P(@P3,U,3)_"  ("_$P(@P3,U)_")"
 .I P1["YSD" D  Q P5
 ..S P4=$G(@P4) Q:P4']""
 ..S P5=P4
 ..S P3=$P($G(@P3),U)
 ..S:P3]"" P5=P5_"  ("_P3_")"
 .I P1["DIC" D
 ..S P5=$P(@P3,U)_"  ("_$P(@P3,U,2)_")"
 Q P5
 ;
BEDSEC(TIUBS) ;Resolves D/C Bedsection ptr from the Final Discharge Note
 N Y
 S Y=$P(^DIC(42,TIUBS,0),U,1)
 Q Y
 ;
ROLLEM ;Rolls back ^GMR(121 entries in ^TIU(8925
 K DIR W @IOF W !!?16,"****** ROLL BACK ******"
 W !!?5,"This option will delete all progress notes entered"
 W !?5,"into ^TIU(8925 from the GMRPN/TIU Conversion.  The"
 W !?5,"option uses ^DIK to roll back the file.  Run time is"
 W !?5,"dependent upon the number of entries made during the"
 W !?5,"conversion."
 W !! S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="YES"
 S DIR("?")="^D HELP10^TIUPNCV3" D ^DIR I $D(DIRUT)!(Y=0) Q
 W !!?5,"BEGINNING ROLL BACK...",!
 S TST=$P($G(^TIU(8925.97,1,2)),U,1),LST=$P($G(^TIU(8925.97,1,2)),U,2)
 S DIK="^TIU(8925,"
 Q:TST!LST=""
 F DA=TST:1:LST D:$P($G(^TIU(8925,DA,13)),U,3)="C" ^DIK
 W !!,"ROLLBACK COMPLETED",!
 K TST,DIK,LST,DA,TIUDIV
 Q
 ;
HELP10 ;Help text for ROLLBACK prompt
 W !!?5,"Press <ret> to continue with roll back of Progress Notes"
 W !?5,"entered during the conversion.  The rollback will begin and"
 W !?5,"based on rollback fields in ^TIU(8925.97, TIU Conversions."
 W !!?5,"Enter NO or ""^"" to stop this option."
 Q
 ;
