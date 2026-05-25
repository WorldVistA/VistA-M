PSOERPC3 ;BIRM/MFR - All Patients (Patient Centric) Hidden Action - Supporting APIs 2 ;08/12/24
 ;;7.0;OUTPATIENT PHARMACY;**770**;DEC 1997;Build 145
 ;
CRT ; Entry point of PSO ERX ALL PATIENTS CR DEFAULT TEXT EDIT action protocol
 N I,INDEX,CODE,DIR,HLP,HELP,RSONCODE,DESC,WRPHELP,REATXT,PSOQUIT,EXTRCODE,EXTSCODE,REACODE,REASCODE,CODETYPE,FINISH
 N NPLEN,DWLW,DWPK,DIWESUB,REASTXT,FDARSNTXT,X,TMPCHNGE,IENS,DIWETXT
 D FULL^VALM1 S VALMBCK="R"
 I '$D(^XUSEC("PSDMGR",DUZ)) D  G REF^PSOERPC0
 . W !!,$G(IOINHI),"You do not have the appropriate key (PSDMGR) to access this option.",!,$G(IOINORM)  D DIRE^PSOERXX1
 ;
 W !!,$G(IOINHI),"Updates will apply for the ",$$GET1^DIQ(59,PSOSITE,.01)," division only.",$G(IOINORM)
 ;
 S IENS=""
 K INDEX S CODE=0 K DIR S DIR(0)="SO^",HLP=0,DIR("?")=" "
 F  S CODE=$O(^PS(52.45,"TYPE","MRC",CODE)) Q:'CODE  D
 . S RSONCODE=$$GET1^DIQ(52.45,CODE,.01)
 . S INDEX(RSONCODE)=CODE
 . S DIR(0)=DIR(0)_RSONCODE_":"_$$GET1^DIQ(52.45,CODE,.02)_";"
 . S HLP=HLP+1,DIR("?",HLP)="    "_RSONCODE_$S($L(RSONCODE)>1:" - ",1:"  - ")
 . K DESC S X=$$GET1^DIQ(52.45,CODE,1,"","DESC") I '$D(DESC) Q
 . S HELP=$G(DESC(1)) F I=2:1 Q:'$D(DESC(I))  S HELP=HELP_" "_DESC(I)
 . K WRPHELP D WRAP^PSOERUT(HELP,70,.WRPHELP)
 . F I=1:1 Q:'$D(WRPHELP(I))  S:I>1 HLP=HLP+1 S $E(DIR("?",HLP),10)=$G(WRPHELP(I,0))
 ;
 S DIR("A")="CHANGE REQUEST CODE" I $G(REACODE) S DIR("B")=$$GET1^DIQ(52.45,REACODE,.01)
 D ^DIR I $D(DIRUT)!$D(DIROUT) G REF^PSOERPC0
 I $G(REACODE)'=+$G(INDEX(Y)) S REASCODE=0,EXTSCODE="" K REATXT
 S REACODE=+$G(INDEX(Y)),EXTRCODE=$$GET1^DIQ(52.45,REACODE,.01)
 W ! I '$D(REATXT) D
 . ;check if the division set a specific change request reason in field 21. Otherwise, display the default text in field 20.
 . I $$CHKDIVRSN(REACODE,.REATXT) Q
 . S X=$$GET1^DIQ(52.45,REACODE,20,,"REATXT")
 ;
 S PSOQUIT=0
 I (" S D U T "[(" "_EXTRCODE_" ")) D  I $G(PSOQUIT) G REF^PSOERPC0
 . K INDEX  K DIR S DIR(0)="SO^",DIR("L",1)="     Select one of the following:",DIR("L",2)=" "
 . S HLP=0,LINE=2,DIR("L")="        "_$S(EXTRCODE="D":"Type '?' for the full list. ",1:"")
 . S DIR("?")="^D HELP^PSOERCR1"
 . S CODETYPE=$S(EXTRCODE="S":"SCR",EXTRCODE="D":"REA",EXTRCODE="T":"TIS",1:"MRSC")
 . F  S CODE=$O(^PS(52.45,"TYPE",CODETYPE,CODE)) Q:'CODE  D
 . . S INDEX($$GET1^DIQ(52.45,CODE,.01))=CODE
 . . S DIR(0)=DIR(0)_$$GET1^DIQ(52.45,CODE,.01)_":"_$$GET1^DIQ(52.45,CODE,.02)_";"
 . . ;
 . . I EXTRCODE="U"!(EXTRCODE="T")!(EXTRCODE="D"&(",DA,DD,HD,LD,MS,TD,AR,DI,DR,ID,UD,PS,SX,TP,"[(","_$$GET1^DIQ(52.45,CODE,.01)_","))) D
 . . . S LINE=LINE+1,DIR("L",LINE)="   "_$S(EXTRCODE="D":"     ",1:"")_$$GET1^DIQ(52.45,CODE,.01)_" - "_$$GET1^DIQ(52.45,CODE,.02)
 . . S HLP=HLP+1,DIR("?",HLP)="   "_$S(EXTRCODE="D":"     ",1:"")_$$GET1^DIQ(52.45,CODE,.01)_" - "_$$GET1^DIQ(52.45,CODE,.02)
 . . ;
 . . I EXTRCODE="S"&(",PRN,UDD,COD,MSD,RIJ,VEF,VLQ,VPQ,AUT,"[(","_$$GET1^DIQ(52.45,CODE,.01)_",")) D  ;script clarification subcodes
 . . . S LINE=LINE+1,DIR("L",LINE)="   "_$S(EXTRCODE="S":"     ",1:"")_$$GET1^DIQ(52.45,CODE,.01)_" - "_$$GET1^DIQ(52.45,CODE,.02)
 . . ;
 . I EXTRCODE="D" S LINE=LINE+1,DIR("L",LINE)=" "
 . S DIR("A")="CHANGE REQUEST SUB-CODE" I $G(REASCODE) S DIR("B")=$$GET1^DIQ(52.45,REASCODE,.01)
 . D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . I $G(REASCODE)'=+$G(INDEX(Y)) K REATXT
 . S REASCODE=+$G(INDEX(Y)),EXTSCODE=$$GET1^DIQ(52.45,REASCODE,.01)
 . W ! I '$D(REATXT) D
 . . ;check if the division set a specific change request reason in field 21. Otherwise, display the default text in field 20.
 . . I $$CHKDIVRSN(REASCODE,.REATXT) Q
 . . S X=$$GET1^DIQ(52.45,REASCODE,20,,"REATXT")
 ;
 K ^TMP("PSOERPC3",$J)
 F I=1:1 Q:'$D(REATXT(I))  S ^TMP("PSOERPC3",$J,I,0)=REATXT(I)
 S (PSOQUIT,TMPCHNGE)=0
 F I=1:1 S FINISH=1 D  I FINISH!PSOQUIT Q
 . S NPLEN=0,DIC="^TMP(""PSOERPC3"""_",$J,"
 . S DWLW=80,DWPK=1,DIWETXT="You are about to edit "_$$GET1^DIQ(52.45,REACODE_",",".02","E")_" "
 . I EXTRCODE'="U" S DIWETXT=DIWETXT_$$GET1^DIQ(52.45,REASCODE_",",".02","E")
 . S DIWETXT=DIWETXT_" Template:"
 . S DIWESUB="DEFAULT NOTE TO PROVIDER" W !,DIWESUB,":"
 . D EN^DIWE I $G(DUOUT) S PSOQUIT=1 Q
 . F I=1:1 Q:'$D(^TMP("PSOERPC3",$J,I))  D  I 'FINISH Q
 . . S X=^TMP("PSOERPC3",$J,I,0)
 . . S NPLEN=NPLEN+$L(X) I NPLEN>(261-$O(^TMP("PSOERPC3",$J,99),-1)) W !!,$G(IOINHI),"The maximum length for this note is 260 characters.",$G(IOINORM),$C(7) S FINISH=0 D PAUSE^PSOSPMU1 Q
 . . I $D(REATXT(I)),X'=REATXT(I) S TMPCHNGE=1
 . . I $D(^TMP("PSOERPC3",$J,I)),'$D(REATXT(I)) S TMPCHNGE=1
 ;
 I +TMPCHNGE<1 W !!,$G(IOINHI),"Nothings change. No Action Taken.",$G(IOINORM),$C(7) D PAUSE^PSOSPMU1 G REF^PSOERPC0
 I PSOQUIT G REF^PSOERPC0
 K REASTXT F I=1:1 Q:'$D(^TMP("PSOERPC3",$J,I))  S REASTXT(I,0)=$G(^TMP("PSOERPC3",$J,I,0))
 K FDARSNTXT
 I +TMPCHNGE>0 D  ;
 . I $G(IENS)="" S IENS="+1,"_$S((" D U S "'[(" "_EXTRCODE_" ")):REACODE,1:REASCODE)_","
 . S FDARSNTXT(52.4521,IENS,.01)=$G(PSOSITE)
 . S FDARSNTXT(52.4521,IENS,1)="REASTXT"
 E  S FDARSNTXT(52.45,REASCODE_",",20)="REASTXT"
 K DIERR D UPDATE^DIE("","FDARSNTXT",,"DIERR")
 I $D(DIERR) W !!,$G(IOINHI),"Error while updating the data: "_$G(DIERR("DIERR",1,"TEXT",1)),$G(IOINORM),$C(7) D PAUSE^PSOSPMU1
 E  W !!,$G(IOINHI),"Update successful for "_$$GET1^DIQ(59,PSOSITE,.01)," division.",$G(IOINORM),$C(7) D PAUSE^PSOSPMU1
 K ^TMP("PSOERPC3",$J)
 G REF^PSOERPC0
 Q
 ;
CHKDIVRSN(RSNIEN,DIVREATXT) ;check if the division set a specific change request reason in field 21. Otherwise, display the default text in field 20.
 ;Input  : RSNIEN - Pointer to ERX SERVICE REASON CODES file (#52.45)
 ;Outputs: CHKDIVRSN - Return 1 if the division set a specific change request reason in field 21. Otherwise,0
 ;         DIVREATXT - Array Containing Division Specific Reason Text
 N IENS,X
 Q:'$G(RSNIEN)!'$G(PSOSITE)
 I $D(^PS(52.45,RSNIEN,21,"B",PSOSITE)) D
 . S IENS=$O(^PS(52.45,RSNIEN,21,"B",PSOSITE,""),-1)_","_RSNIEN_"," ;get the last entry change
 . I $G(IENS) S X=$$GET1^DIQ(52.4521,IENS,1,,"DIVREATXT")
 Q $S($D(DIVREATXT):1,1:0)
