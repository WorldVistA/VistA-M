PSSFILED ;BIR/CML3-VARIOUS FILED UPKEEP ;09/15/97
 ;;1.0;PHARMACY DATA MANAGEMENT;**38,47,172,201**;9/30/97;Build 25
 ;Reference to ^PSGGAO supported by DBIA #2148
 ;Reference to ^PSGSET supported by DBIA #2152
 ;Reference to ^PSGSETU supported by DBIA 2153
 ;Reference to ^PS(57.7 supported by DBIA 2111
 ;Reference to ^PS(59.6 supported by DBIA 2110
 ;Reference to ^PS(57.5 supported by DBIA 2112
 ;Reference to ^PS(53.2 supported by DBIA 2115
 ;
 ;This routine is no longer used, with the exception of the ENMI, ENOMI, OMILE, ENOMIX and
 ;CHKOMI, CHKVAL, ISOMIDUP, EXEHLP, CHKNSY, DELOMI, ISNSYDUP linetags. Quits were inserted at each sub-routine in Patch PSS*1*38. 
DONE ;S X="PSGSETU" X ^%ZOSF("TEST") I  D ENKV^PSGSETU K D0,D1,D2,PSGRBS Q
 Q
 ;
GED ; generic edit
 ;S DA=+Y,DR=".01;1" W ! D ^DIE Q
 Q
 ;
ENAT ; team file
 Q
 ;F  S DIC="^PS(57.7,",DIC(0)="QEAMIL",DLAYGO=57.7,DIC("A")="Select WARD: " W ! D ^DIC K DIC,DLAYGO Q:Y'>0  S DA=+Y,DIE="^PS(57.7,",DR="[PSJUMATE]" D ^DIE
 G DONE
 ;
ENAS ; schedules file - no longer used
 ;F  S DIC="^PS(51.1,",DIC(0)="QEAMIL",DIC("W")="W ""   "",$P(^(0),""^"",2)",DLAYGO=51.1,DIC("DR")="4////PSJ" W ! D ^DIC K DIC,DLAYGO Q:+Y'>0  S DIE="^PS(51.1,",DR="[PSJUADE]",DA=+Y W ! D ^DIE
 Q
 ;
ENMR ; med route file
 Q
 N MRNO,MR K DIE,DIC,DR,Y
 S PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 F  S DIC="^PS(51.2,",DIC(0)="QEAMIL",DLAYGO=51.2 W ! D
 .D ^DIC K DIC,DLAYGO Q:+Y'>0  S MRNO=+Y,MR=$P(Y,U,2),DA=+Y,DIE="^PS(51.2,",DR=".01;1;3;4;S:'$G(PSSOTH) Y=""@1"";4.1;@1"
 .D ^DIE D DF
 K X,MRNO,MR,Y,DA,DR,PSSOTH,DIE
 Q
 ;
ENWG ; ward group file
 Q
 ;F  S DIC="^PS(57.5,",DIC(0)="QEAMIL",DLAYGO=57.5 W ! D ^DIC K DA,DIC,DR Q:+Y'>0  S DA=+Y,DIE="^PS(57.5,",DR="[PSJU WG]" D ^DIE
 G DONE
 ;
CHKNSY(PSSMIFLD) ; -- check Name and Synonym Fields **pss_1_201**
 ; Called by: Name (#.01)and Synonym (#.5) Input Transforms
 ; Input  -- PSSMIFLD Field  -- .01=NAME, .5=SYNONYM
 ;           X        Name (#.01) or Synonym (#.5)
 ;           PSSMIACT Action -- for Lookup=LKUP and Edit=EDIT -- set in ENMI line tag
 ;           PSSMIEN  Medication Instruction file (#51) IEN   -- set in ENMI line tag
 ; Output -- X is killed if duplicate exists
 N PSSMIDA,PSSYNEWF
 ;
 ; -- check for missing variable, exit if not defined
 I $G(PSSMIFLD)']"" Q
 ;
 ; -- convert input to upper case
 S X=$$UP^XLFSTR(X)
 ;
 ; -- check if field value equals X on edit and exit
 I $G(PSSMIACT)="EDIT",$$GETVAL($G(PSSMIFLD),+$G(PSSMIEN))=X Q
 ;
 ; -- initialize message variables
 K PSSMIMSG
 ;
 ; -- check field length and "B" cross-reference, kill X, setup message array to display and exit
 IF $L(X)>9!($L(X)<1)!'(X?.ANP)!($D(^PS(51,"B",X))) K X D:$G(PSSMIACT)="LKUP"  Q
 . S PSSMIMSG=1
 . S PSSMIMSG(1)="     Answer must be 1 to 9 characters in length, and must be unique among all"
 . S PSSMIMSG(2)="     NAME(S), SYNONYM(S), and OLD MED INSTRUCTION NAME(S)."
 . D EN^DDIOL(.PSSMIMSG,"","!") K PSSMIMSG
 ;
 ; -- if new synonym set flag
 S PSSYNEWF=0
 I $G(PSSMIFLD)="SYNONYM",$P($G(^PS(51,+$G(PSSMIEN),0)),"^",3)="" S PSSYNEWF=1
 ;
 ; -- check for duplicates on edit, kill X, setup message array to display in executable help and exit
 I $G(PSSMIACT)="EDIT",$$ISOMIDUP(X,.PSSMIDA),'$G(PSSYNEWF) K X D  Q
 . S PSSMIMSG=1
 . S PSSMIMSG(1)="     A duplicate exists in the OLD MED INSTRUCTION NAME(S) multiple"
 . S PSSMIMSG(2)="     for "_$S($G(PSSMIDA)=+$G(PSSMIEN):"this entry",$G(PSSMIDA)>0:"the entry "_$P($G(^PS(51,PSSMIDA,0)),"^",1)_" ("_PSSMIDA_")",1:"")_"."
 ;
 ; -- check for duplicates, kill X, set up message array to display on lookup or executable help and exit
 I $$ISOMIDUP(X,.PSSMIDA) K X D  Q
 . S PSSMIMSG=1
 . S PSSMIMSG(1)="     Duplicate exists in Old Med Instruction Name multiple for"
 . S PSSMIMSG(2)="     "_$S($G(PSSMIDA)=+$G(PSSMIEN):"this entry.",$G(PSSMIDA)>0:"the entry "_$P($G(^PS(51,PSSMIDA,0)),"^",1)_" ("_PSSMIDA_") in the file.",1:"")_" Please enter a new name."
 . I $G(PSSMIACT)="LKUP" D EN^DDIOL(.PSSMIMSG,"","!") K PSSMIMSG
 Q
 ;
GETVAL(PSSMIFLD,PSSMIEN,PSSMIENO) ; -- get Name or Synonym or Old Medication Instruction Name Field Value **pss_1_201**
 ; Called by: Name (#.01)and Synonym (#.5) Input Transforms
 ; Input  -- PSSMIFLD Field  -- .01=NAME, .5=SYNONYM, 33,.01=OMINAME       
 ;           PSSMIEN  Medication Instruction file (#51) IEN
 ;           PSSMIENO Old Med Instruction Name(s) multiple (#51.33) IEN
 ; Output -- Name (#.01) or Synonym (#.5) or Old Medication Instruction Name Field (#51.33,.01) Value
 N PSSFLDVL
 ;
 ; -- check for missing variable, exit if not defined
 I $G(PSSMIFLD)']"" Q ""
 ; -- initialize variables
 S PSSFLDVL=""
 ; -- if Name, get Name (#.01) and exit
 I PSSMIFLD="NAME",+$G(PSSMIEN)>0 D  Q PSSFLDVL
 . S PSSFLDVL=$P($G(^PS(51,PSSMIEN,0)),"^",1)
 ; -- if Synonym, get Synonym (#.5) and exit
 I PSSMIFLD="SYNONYM",+$G(PSSMIEN)>0 D  Q PSSFLDVL
 . S PSSFLDVL=$P($G(^PS(51,PSSMIEN,0)),"^",3)
 ; -- if Old Medication Instruction Name, get Old Medication Instruction Name Field (#51.33,.01)and exit
 I PSSMIFLD="OMINAME",+$G(PSSMIEN)>0,+$G(PSSMIENO)>0 D  Q PSSFLDVL
 . S PSSFLDVL=$P($G(^PS(51,PSSMIEN,6,PSSMIENO,0)),"^",1)
 Q PSSFLDVL
 ;
ISOMIDUP(X,PSSMIDA) ; -- Is there a duplicate in the Old Med Instruction Name(s) sub-file (#51.33) **pss_1_201**
 ; Input  -- X        Medication Instruction file (#51) Name (#.01) field or Synonym (#.5) field
 ; Output -- 1=Duplicate Found and 0=Unable to Check or No Duplicate Found
 ;           PSSMIDA  Old Med Instruction Name(s) multiple (#51.33) IEN Array
 N PSSDUPF,PSSOMINM
 ; -- check for missing variable, exit if not defined
 I $G(X)']"" Q 0
 ; -- initialize variables
 S PSSOMINM="",PSSDUPF=0
 ; -- loop through "D" cross-reference looking for duplicate
 F  S PSSOMINM=$O(^PS(51,"D",PSSOMINM)) Q:PSSOMINM=""!($G(PSSDUPF))  D
 .I PSSOMINM=X D
 . . ; -- if duplicate found set flag
 . . S PSSDUPF=1
 . . ; -- get IENS for duplicate Old Med Instruction Name
 . . S PSSMIDA=+$O(^PS(51,"D",PSSOMINM,0)),PSSMIDA(1)=+$O(^(PSSMIDA,0))
 Q +$G(PSSDUPF)
 ;
EXEHLP ; -- Name, Synonym and Old Med Instruction Name Fields Executable Help **pss_1_201**
 ; Called by: Name (#.01), Synonym (#.5) and Old Med Instruction Name(s) (#51.33,.01) Executable Help
 ; Input  -- PSSMIMSG Medication Instruction Message Flag and Array  -- set in OMICHK and CHKNSY line tags
 ; Output -- None
 I $G(PSSMIMSG) D EN^DDIOL(.PSSMIMSG,"","!") K PSSMIMSG
 Q
 ;
CHKOMI(PSSMIFLD) ; -- check Old Med Instruction Name Field **pss_1_201** 
 ; Called by: Old Med Instruction Name(s) (#51.33,.01) Input Transform
 ; Input  -- PSSMIFLD Field  -- 33,.01=OMINAME
 ;           X        Old Med Instruction Name(s) multiple (#51.33) Name (#.01) field
 ;           PSSMIACT Action -- for Lookup=LKUP and Edit=EDIT -- set in ENMI line tag
 ;           PSSMIEN  Medication Instruction file (#51) IEN   -- set in ENMI line tag
 ;           PSSMIENO Old Med Instruction Name(s) multiple (#51.33) IEN  -- set in ENOMI line tag
 ; Output -- X is killed if duplicate exists
 N PSSMIDA,PSSMI0
 ;
 ; -- check for missing variable, exit if not defined
 I $G(PSSMIFLD)']"" Q
 ;
 ; -- convert input to upper case
 S X=$$UP^XLFSTR(X)
 ;
 ; -- check if user requested to delete Old Med Instruction subfile entry, delete and exit
 I $G(PSSMIACT)="LKUP",X="@",+$G(PSSMIEN)>0 D  K X Q
 . N PSSOMIDF
 . S PSSOMIDF=$$OMILE(PSSMIEN,.PSSMIENO)
 . I +$G(PSSMIEN)>0,+$G(PSSMIENO)>0 D
 . . D DELOMI(PSSMIEN,PSSMIENO)
 . . ; -- re-set DIC("A") and PSSMIENO if Old Med Instruction subfile entry is deleted on lookup 
 . . S DIC("A")="Select OLD MED INSTRUCTION NAME(S): "_$$OMILE(PSSDA)
 . ELSE  D
 . . D EN^DDIOL("??","","?2")
 ;
 ; -- check if field value equals X on edit and exit
 I $G(PSSMIACT)="EDIT",$$GETVAL($G(PSSMIFLD),+$G(PSSMIEN),+$G(PSSMIENO))=X Q
 ;
 ; -- initialize message variables
 K PSSMIMSG
 ;
 ; -- check field length, kill X, setup message array to display and exit
 IF $L(X)>9!($L(X)<1)!'(X?.ANP) K X D:$G(PSSMIACT)="LKUP"  Q
 . S PSSMIMSG=1
 . S PSSMIMSG(1)="     Answer must be 1 to 9 characters in length, and must be unique among all"
 . S PSSMIMSG(2)="     NAME(S), SYNONYM(S), and OLD MED INSTRUCTION NAME(S)."
 . D EN^DDIOL(.PSSMIMSG,"","!") K PSSMIMSG
 ;
 ; -- check for duplicate Old Med Instruction, kill X, set up message array to display on lookup or executable help and exit
 I $$ISOMIDUP(X,.PSSMIDA) K X D  Q
 . S PSSMIMSG=1
 . S PSSMIMSG(1)="     Duplicate exists in Old Med Instruction Name multiple for"
 . S PSSMIMSG(2)="     "_$S($G(PSSMIDA)=+$G(PSSMIEN):"this entry.",$G(PSSMIDA)>0:"the entry "_$P($G(^PS(51,PSSMIDA,0)),"^",1)_" ("_PSSMIDA_") in the file.",1:"")_$S($G(PSSMIACT)="LKUP":" Please enter a new name.",1:"")
 . I $G(PSSMIACT)="LKUP" D EN^DDIOL(.PSSMIMSG,"","!") K PSSMIMSG
 ;
 ; -- check for duplicate Name or Synonym, set up message array to display on lookup or executable help, kill X and exit
 I $$ISNSYDUP(X,.PSSMIDA),$G(PSSMIDA)>0 D  K X Q
 . ; -- determine which field is the duplicate Name or Synonym
 . S PSSMI0=$G(^PS(51,PSSMIDA,0)) S PSSMIFLD=$S($P(PSSMI0,"^",1)=X:"NAME",$P(PSSMI0,"^",3)=X:"SYNONYM",1:"UNKNOWN")
 . S PSSMIMSG=1
 . S PSSMIMSG(1)="     An OLD MED INSTRUCTION NAME(S) entry cannot be the same as an"
 . S PSSMIMSG(2)="     existing "_$G(PSSMIFLD)_" field."
 . I $G(PSSMIACT)="LKUP" D EN^DDIOL(.PSSMIMSG,"","!") K PSSMIMSG
 Q
 ;
DELOMI(PSSMIEN,PSSMIENO) ; -- delete entry from OLD MED INSTRUCTION NAME(S) multiple #51.33 **pss_1_201**
 ; Input  -- PSSMIEN  Medication Instruction file (#51) IEN
 ;           PSSMIENO Old Med Instruction Name(s) multiple (#51.33) IEN
 ; Output -- None
 N DIR,X,Y
 ; -- check for missing variables, exit if not defined
 I +$G(PSSMIEN)'>0!(+$G(PSSMIENO)'>0) Q
 ; -- ask user if sure want to delete
 S DIR("A")="   SURE YOU WANT TO DELETE"
 S DIR(0)="Y"
 D ^DIR
 I '$G(Y) D  Q
 . D EN^DDIOL("  (No)  <NOTHING DELETED>","","?2")
 ELSE  D
 . D EN^DDIOL("  (Yes)","","?2")
 . N DA,DIK,X
 . ; -- delete entry
 . S DA=PSSMIENO,DA(1)=PSSMIEN
 . S DIK="^PS(51,"_DA(1)_",""6"","
 . D ^DIK
 Q
 ;
ISNSYDUP(X,PSSMIDA) ; -- Is there a duplicate in the Name or Synonym field of the Medication Instruction file (#51) **pss_1_201** 
 ; Input  -- X        Old Med Instruction Name(s) multiple (#51.33) Name (#.01) field
 ; Output -- 1=Duplicate Found and 0=Unable to Check or No Duplicate Found
 ;           PSSMIDA   Medication Instruction file (#51) IEN
 N PSSDUPF,PSSNM
 ; -- check for missing variable, exit if not defined
 I $G(X)']"" Q 0
 ; -- initialize variables
 S PSSNM="",PSSDUPF=0
 ; -- loop throung "B" cross-reference looking for duplicate
 F  S PSSNM=$O(^PS(51,"B",PSSNM)) Q:PSSNM=""!($G(PSSDUPF))  D
 .I PSSNM=X D
 . . ; -- if duplicate found set flag
 . . S PSSDUPF=1
 . . ; -- get IEN for duplicate Medication Instruction Name
 . . S PSSMIDA=+$O(^PS(51,"B",PSSNM,0))
 Q +$G(PSSDUPF)
 ;
ENMI ; medication instruction file **enhancements made in pss_1_201**
 N DD,DIC,DIE,DLAYGO,DA,DO,DR,PSSFINF,PSSMIEN,PSSMINME,PSSMIACT,PSSOTH,Y
 S PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 S DIC="^PS(51,",DIC(0)="EAMIL",DLAYGO=51,PSSMIACT="LKUP" W ! D ^DIC K DIC G ENMIQ:+Y'>0
 S PSSMIEN=+Y,PSSMINME=$P(Y,U,2),PSSFINF=0
 S DIE="^PS(51,",DA=PSSMIEN,DR=".01;.5;1;S:'$G(PSSOTH) Y=""@1"";1.1;@1;9;30;32;32.1;31;S PSSFINF=1",PSSMIACT="EDIT" D ^DIE I +$G(DA)>0,$G(PSSFINF) D ENOMI(PSSMINME,PSSMIEN)
 ; -- re-prompt until user does not select an entry
 G ENMI
ENMIQ Q
 ;
ENOMI(PSSPMI,PSSDA) ; prompt to display interaction for OLD MED INSTRUCTION NAME(S) multiple **enhancements made in pss_1_201**
 Q:$G(PSSPMI)']""!($G(PSSDA)'>0)
 ;
SELOMI ; -- select Old Med Instruction Name
 NEW DD,DIC,DIE,DLAYGO,DA,DO,DR,PSSADDF,PSSMIACT,PSSMIENO,Y
 SET DA(1)=PSSDA,DIC="^PS(51,"_DA(1)_",6,",PSSMIACT="LKUP",DIC(0)="EAMIL",DIC("A")="Select OLD MED INSTRUCTION NAME(S): "_$$OMILE(PSSDA) D ^DIC K DIC G ENOMIQ:+Y'>0
 S PSSMIENO=+Y
 SET DA(1)=PSSDA,DIE="^PS(51,"_DA(1)_",6,",DA=PSSMIENO,DR=".01",PSSMIACT="EDIT" D ^DIE
 ; -- re-prompt until user does not select an entry
 G SELOMI
ENOMIQ Q
 ;
OMILE(PSSDA,PSSLR) ;
 NEW PSSLE SET PSSLE=""
 IF $G(^PS(51,$G(PSSDA),6,0))'="" SET PSSLR=999999 FOR  SET PSSLR=$O(^PS(51,$G(PSSDA),6,PSSLR),-1) S:$G(^PS(51,$G(PSSDA),6,PSSLR,0))'="" PSSLE=$G(^PS(51,$G(PSSDA),6,PSSLR,0))_"// " Q:PSSLR'=""
 Q $G(PSSLE)
 ;
ENOMIX(PSSPMI,PSSDA) ; used by the 'AF' xref for adding an edited NAME (#.01) field's old value in the MEDICATION INSTRUCTION (#51) file to the OLD MED INSTRUCTION NAME(S) multiple **pss_1_201**
 Q:$G(PSSPMI)']""!($G(PSSDA)'>0)
 ;
 NEW PSSMCHK,PSSRCHK,PSSMFL1,PSSMFL2,PSSMFL3
 SET (PSSRCHK,PSSMCHK,PSSMFL1,PSSMFL2,PSSMFL3)=0
 ;
 IF $P(^PS(51,$G(PSSDA),0),U,1)=PSSPMI SET PSSMFL1=1
 FOR  SET PSSMCHK=$O(^PS(51,$G(PSSDA),6,PSSMCHK)) Q:'+PSSMCHK!($G(PSSMFL2))  D
 .IF ^PS(51,$G(PSSDA),6,PSSMCHK,0)=PSSPMI SET PSSMFL2=1
 FOR  SET PSSRCHK=$O(^PS(51,"D",PSSRCHK)) Q:PSSRCHK']""!($G(PSSMFL3))  D
 .IF PSSRCHK=PSSPMI SET PSSMFL3=1
 IF '$G(PSSMFL1),'$G(PSSMFL2),'$G(PSSMFL3),$G(PSSDA) KILL DO SET X=PSSPMI,DA(1)=$G(PSSDA),DIC=DIC_DA(1)_",6,",DIC(0)="L" DO FILE^DICN SET DIC="^PS(51,",DA=PSSDA
 Q
 ;
ENDRG ; standard drug fields
 Q
 D NOW^%DTC S PSGDT=% F  S DIC="^PSDRUG(",DIC(0)="AEIMOQ",DIC("A")="Select DISPENSE DRUG: " W ! D ^DIC K DIC Q:+Y'>0  D DE
 K PSIUA,PSIUDA,PSIUX G DONE
 ;
DE ;
 Q
 I $D(^PSDRUG(+Y,"I")),^("I"),^("I")<PSGDT W $C(7),$C(7),!!?3,"*** WARNING, THIS DRUG IS INACTIVE. ***",!
 ;W ! S DIE="^PSDRUG(",(DA,PSIUDA)=+Y,DR="[PSJ FILED]"
 S PSIUX="U^UNIT DOSE PHARMACY^1" D ^PSSGIU,^DIE:PSIUA'["^" K DA,DIE,DR Q
 ;
ENOSE ; order set enter/edit
 Q
 ;K DIC F  S DLAYGO=53.2,DIC="^PS(53.2,",DIC(0)="QEAML",DIC("A")="Select ORDER SET: " W ! D ^DIC K DIC Q:Y'>0  S DA=+Y S DIE="^PS(53.2,",DR="[PSJUOSE]" D ^DIE K D0,D1,DA,DIE,DR,PSGNEDFD,PSGS0XT,PSGS0Y
 G DONE
 ;
RBCHK ; used to validate room-bed
 Q
 ;F Z0=0:0 S Z0=$O(^PS(57.7,DA(2),1,Z0)) Q:'Z0  I Z0'=DA(1),$D(^(Z0,1,"B",X)) W !?19,X," is already under ",$S('$D(^PS(57.7,DA(2),1,Z0,0)):"another team ("_Z0_")!",$P(^(0),"^")]"":$P(^(0),"^")_"!",1:"another team ("_Z0_")!") Q
 I 'Z0,$D(^DIC(42,DA(2),2,+$O(^DIC(42,DA(2),2,"B",$P(X,"-"),0)),1,"B",$P(X,"-",2))) K Z0 Q
 K X,Z0 Q
 ;
RBQ ; show room-beds for a ward
 Q
 W !,"ANSWER WITH A ROOM-BED FROM THIS WARD ",$S('$D(^DIC(42,DA(1),0)):"",$P(^(0),"^")]"":" ("_$P(^(0),"^")_")",1:"") Q:'$D(^(0))  W !,"DO YOU WANT THE ENTIRE ROOM-BED LIST" S %=0 D YN^DICN Q:%'=1
 W ! S (Z0,Z3)=0 F Z1=0:0 S Z1=$O(^DIC(42,DA(1),2,Z1)) Q:'Z1  I $D(^(Z1,0)) S Z4=$P(^(0),"^") I Z4]"" F Z2=0:0 S Z2=$O(^DIC(42,DA(1),2,Z1,1,Z2)) Q:'Z2  I $D(^(Z2,0)),$P(^(0),"^")]"" S Z0=Z0+1 D:'(Z0#11) RBNP Q:Z3["^"  W ?1,Z4,"-",$P(^(0),"^"),!
 K Z0,Z1,Z2,Z3,Z4 Q
 ;
RBNP ;W """^"" TO STOP: " R Z3:DTIME W:'$T $C(7) S:'$T Z3="^" W *13,"            ",*13 Q
 Q
 ;
ENPPD ; edit pharmacy patient data
 Q
 ; W !!?3,"...This option is still under development...",! Q
 ;D ENCV^PSGSETU I $D(XQUIT) Q
 ;S PSGRETF=1 F  D ENDPT^PSGP Q:PSGP'>0  D ENHEAD^PSGO S DA=PSGP,DR="[PSJUPDE]",DIE="^PS(55," W ! D ^DIE
 ;K PSGRETF G DONE
 ;
ENCPDD ; edit patient's default stop date (wall)
 Q
 ;S X="PSGSETU" X ^%ZOSF("TEST") I  D ENCV^PSGSETU I $D(XQUIT) Q
 ;S X="PSGGAO" X ^%ZOSF("TEST") I  F  D ENAO^PSGGAO Q:PSGP'>0  D
 ;.S WDN=$P($G(^DPT(PSGP,.1)),"^") W:WDN="" !!?2,"The patient is not currently on a ward."
 ;.I WDN]"" S WD=$O(^DIC(42,"B",WDN,0)),WD=$O(^PS(59.6,"B",+WD,0)) I $S('WD:1,1:'$P($G(^PS(59.6,WD,0)),"^",4)) S X="PLEASE NOTE: The 'SAME STOP DATE' parameter for the ward ("_WDN_") is not turned on.  Any date entered here will be ignored "
 ;.I  S X=X_"until the parameter is turned on for this ward." W $C(7),!!?2 F Y=1:1:$L(X," ") S X(1)=$P(X," ",Y) W:$L(X(1))+$X>78 ! W X(1)," "
 ;.S DA=PSGP,DR="62.01T",DIE="^PS(55," W !! D ^DIE
 ;K WD,WDN G DONE
 ;
ENSYS ; edit system file
 Q
 S DIE="^PS(59.7,",DA=1,DR="21;26;26.2" W ! D ^DIE K DIE,DA,DR Q
 ;
ENPLSP ; edit pick list site parameters
 Q
 ;K DIC F Q=0:1 S DIC="^PS(59.4,",DIC(0)="QEAM" S:'Q DIC("B")=PSJSYSW W ! D ^DIC K DIC Q:Y'>0  S DA=+Y,DIE="^PS(59.4,",DR="[PSJUPLSP]" D ^DIE
 ;G DONE
 ;
ENCS ; change current site & parameters
 Q
 I $D(PSJSYSW0)#2 W !!,"Current site: ",$P(PSJSYSW0,"^")
 ;S PSGCSF=1 S X="PSGSET" X ^%ZOSF("TEST") I  D ^PSGSET,ENKV^PSGSETU W:$D(XQUIT) !!?5,"(The Inpatient site you are currently working under has not changed.)" K PSGCSF,PSGORSET,XQUIT Q
 ;
DF ; Add/edit Med route, instruction... to the Dosage form file.
 Q
 S DIR("A")="Would you like to update the Dosage Form file"
 S DIR("?")="If your answer is Yes, you will be able to Add/edit the Med routes, Instructions, Verb, Noun and Preposition that associate with this Dosage form."
 S DIR(0)="Y",DIR("B")="Y" D ^DIR Q:Y'=1
 NEW Y,DFNO K DIE,DIC,DA,DR
 F  S DIC="^PS(50.606,",DIC(0)="QEAMI" D ^DIC Q:+Y'>0  S DFNO=+Y D
 . I $G(MR)]"",'$D(^PS(50.606,DFNO,"MR","B",MRNO)) S DIE="^PS(50.606,",DR="1",DA=DFNO D ^DIE
 . K DIE,DIC,DR,MR S DIE="^PS(50.606,",DR="1;2;3;5;6",DA=DFNO D ^DIE
 Q
ENII ; infusion instruction file
 F  S DIC="^PS(53.47,",DIC(0)="QEAMIL",DLAYGO=53.47 W ! D ^DIC K DIC Q:+Y'>0  D
 .Q:($P(Y,"^",3))
 .S DIE="^PS(53.47,",DA=+Y,DR=".01;1" D ^DIE
 K DIC,DIE,DLAYGO,DA,DR,Y
 Q
