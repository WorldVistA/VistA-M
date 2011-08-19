LA7DEDT ;DALOI/PWC/RLM-LA7D EDIT FOREIGN COMPUTER INTERFACE FILE ;02/14/2000
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**53,58**;Sep 27, 1994
 ; Reference to $$FIND1^DIC supported by IA #2051
 ; Reference to LIST^DIC supported by IA #2051
 ; Reference to UPDATE^DIE supported by IA #2053
 ; Reference to ^DIK supported by IA #10013
 ; Reference to ^DIR supported by IA #10026
 ;
 ; This routine will allow the user to enter a foreign computer
 ; system name and the supported ward(s) for each name
 ; (ie. CareVue, Marquette)
 ;
 K ^TMP("DIERR",$J)
 K CNT,DA,DEL,DIERR,DIK,DIR,DIROUT,DIRUT,DONE,DTOUT,DUOUT,FROM
 K I,IEN,IRESULT,J,LA7D,LA7DERR,LA7DERR1,LA7DIEN,LA7DTMP,LAIEN
 K LAIENW,OK,WIEN,WWIEN,X,Y
ADDNEW ;
 K DIR
 S DIR("A")="Do you wish to Add or Edit a Bedside Monitor"
 ;S DIR("?")=""
 S DIR(0)="S^a:ADD;e:EDIT"
 S DIR("B")="E"
 D ^DIR Q:X=""!($D(DIRUT))!($D(DIROUT))
 G:Y="a" ADD
NAME ; input the name of the bedside monitor interface
 D HELPM
 K DIR S DIR("A")="Enter BEDSIDE MONITOR INTERFACE NAME"
 S DIR("?")="Enter Bedside Monitor Name (ie. CareVue, Marquette)"
 S DIR(0)="PO^62.487:LEM"
 K DIR("B") S DLAYGO="62.487"
 D ^DIR K DLAYGO Q:X=""!($D(DIRUT))!($D(DIROUT))
 S IRESULT=$P(Y,"^",2)
 S LA7DIEN=$S($D(IEN(1)):IEN(1),1:+Y)
 S DONE=0
 ;
WARD ; input the ward # associated with the bedside monitor interface
 ;
 D HELPW
 K DIR S DIR("A")="Enter "_IRESULT_" WARD"
 S DIR("?")="Enter wards associated with this bedside monitor"
 S DIR(0)="P^44:EMZ"
 F J=1:1 D  Q:DONE
 . K DIR("B")
 . D ^DIR I X=""!($D(DIRUT))!($D(DIROUT)) S DONE=1 Q
 . S WIEN=+Y
 . I WIEN=0!(WIEN="") W "  Invalid" Q     ; does not exist in file 44
 . K LA7DERR
 . S WWIEN=$$FIND1^DIC(62.4871,","_LA7DIEN_",","AX",$P(Y,"^",2),,,"LA7DERR")
 . ;I $D(LA7DERR) K LA7DERR S WWIEN=$$FIND1^DIC(62.4871,","_LA7DIEN_",","AX",$P(Y,"^",2),,,"LA7DERR")
 . ;I $D(LA7DERR) W !,"There is an error with this entry." Q
 . I WWIEN'=0 W " already on file" D DELETE Q  ; exists in file 62.487
 . K LA7D,LA7DERR,LAIENW             ; does not exist, add to database
 . F CNT=1:1 Q:'$D(^LAB(62.487,LA7DIEN,1,CNT))
 . I CNT=LA7DIEN S CNT=CNT+1
 . S LA7D(62.487,LA7DIEN_",",.01)=IRESULT
 . S LA7D(62.4871,"?+"_CNT_","_LA7DIEN_",",.01)=WIEN
 . D UPDATE^DIE("S","LA7D","LAIENW","LA7DERR")
 . I $D(LA7DERR) W !,$G(LA7DERR("DIERR",1,"TEXT",1))
EXIT ;
 K CNT,DA,DEL,DIERR,DIK,DIR,DIROUT,DIRUT,DONE,DTOUT,DUOUT,FROM
 K I,IEN,IRESULT,J,LA7D,LA7DERR,LA7DERR1,LA7DIEN,LA7DTMP,LAIEN
 K LAIENW,OK,WIEN,WWIEN,X,Y
 K ^TMP("DIERR",$J)
 Q
 ;
HELPW ; A list of available wards will display before the WARD prompt is issued.
 ;
 W !," Current Wards for ",$P(^LAB(62.487,LA7DIEN,0),"^")
 K LA7DTMP,LA7DERR1 S FROM=""
 D LIST^DIC(62.4871,","_LA7DIEN_",",.01,,,FROM,,,,,"LA7DTMP","LA7DERR1")
 F J=1:1 Q:'$D(LA7DTMP("DILIST",1,J))  W !,"   ",LA7DTMP("DILIST",1,J) I '(J#5) K DIR S DIR(0)="E" D ^DIR Q:'Y
 Q
 ;
HELPM ; A list of available Bedside Monitors will display before the BEDSIDE MONITOR prompt is issued.
 ;
 W !," Current Bedside Monitors"
 K LA7DTMP,LA7DERR1 S FROM=""
 D LIST^DIC(62.487,,.01,,,FROM,,,,,"LA7DTMP","LA7DERR1")
 F J=1:1 Q:'$D(LA7DTMP("DILIST",1,J))  W !,"   ",LA7DTMP("DILIST",1,J) I '(J#5) K DIR S DIR(0)="E" D ^DIR Q:'Y
 Q
 ;
ADD ;Add an entry to 62.487
 D HELPM
 K DIR S DIR("A")="Enter the name of the NEW Bedside Monitor"
 S DIR(0)="F^3:30"
 D ^DIR Q:X=""!($D(DIRUT))!($D(DIROUT))
 S Y=$$FIND1^DIC(62.487,,,X,,,"LA7DERRA")
 S IRESULT=X
 I Y!(Y="") W !,X_" exists, please select a new name."
 I Y=0 S DIR("A")=X_" does not exist. Do you wish to add it?" S DIR(0)="Y",DIR("B")="N" D ^DIR G:'Y ADD D
  . K LA7D ;does not exist, add to database
  . S LA7D(62.487,"?+1,",.01)=IRESULT
  . D UPDATE^DIE("ES","LA7D","LAIEN","LA7DERR")
  . ;do the FIND1^DIC again since we don't know the IEN
  . S Y=$$FIND1^DIC(62.487,,,X)
  . S LA7DIEN=LAIEN(1),DONE=0
 G WARD Q
DELETE ; delete entry from ^LAB(62.487
 ;
 W !,"Ward already on File, DELETE (Y/N) [N] " R DEL:DTIME
 S:DEL="" DEL="N" Q:DEL="N"!(DEL="^")
 I DEL'="Y" W $C(7),"  Must enter Y or N" G DELETE
 K DIK,DA S DA(1)=LA7DIEN,DA=WWIEN
 S DIK="^LAB(62.487,"_DA(1)_",1,"
 D ^DIK K DIK,DA
 Q
ZEOR ;LA7DEDT
