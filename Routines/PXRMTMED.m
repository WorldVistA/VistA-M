PXRMTMED ; SLC/PKR/PJH - Edit a reminder term. ;04/09/2009
 ;;2.0;CLINICAL REMINDERS;**1,4,6,12**;Feb 04, 2005;Build 73
 ;
 ;=======================================================
 N CS1,CS2,DA,DIC,DLAYGO,DTOUT,DUOUT,Y
GETNAME ;Get the name of the term to edit.
 K DA,DIC,DLAYGO,DTOUT,DUOUT,Y
 S DIC="^PXRMD(811.5,"
 S DIC(0)="AEMQL"
 S DIC("A")="Select Reminder Term: "
 S DLAYGO=811.5
 ;Set the starting place for additions.
 D SETSTART^PXRMCOPY(DIC)
 W !
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 G END
 S DA=$P(Y,U,1)
 S CS1=$$FILE^PXRMEXCS(811.5,DA)
 D EDIT(DIC,DA)
 I $G(DA)="" G GETNAME
 S CS2=$$FILE^PXRMEXCS(811.5,DA)
 I CS2=0 G GETNAME
 I CS2'=CS1 D SEHIST^PXRMUTIL(811.5,DIC,DA)
 G GETNAME
END ;
 Q
 ;
 ;=======================================================
CLASS(DA,DIE) ;
 N DR,RESULT,X,Y
RETRY W !
 S DR="100" D ^DIE I $D(Y) Q
 ;Sponsor
 S DR="101" D ^DIE I $D(Y) Q
 ;Make sure Class and Sponsor Class are in synch.
 S RESULT=$$VSPONSOR^PXRMINTR(X)
 I RESULT=0 S DIE("NO^")="Other value" G RETRY
 I RESULT=1 K DIE("NO^")
 ;Review date, Usage
 S DR="102;1" D ^DIE I $D(Y) Q
 Q
 ;
 ;=======================================================
EDIT(ROOT,DA) ;
 N CLASS,DIC,DIE,DR,DIDEL,PXRMTMD,RESULT,TCONT,Y
 ;PXRMTMD is set by a xref on the .01 as a flag that the entire
 ;entry is being deleted.
 S CLASS=$P($G(^PXRMD(811.5,DA,100)),U,1)
 S DIE=ROOT
 I CLASS'="N"!(($G(PXRMINST)=1)&($G(DUZ(0))="@")) D
 . S DR=".01"
 . D ^DIE
 . I $G(DA)'="" D CLASS(DA,DIE)
 I $G(DA)="" Q
 S TCONT=1
 F  D FINDING(DIE,DA)  Q:TCONT=0
 Q
 ;
 ;=======================================================
FINDING(DIE,DA,LIST) ;
 N CFIEN,GLOB,IEN,LIST,NODE,TERMSTAT,VF,WPIEN
 N DEF,DEF1,DEF2,STATUS
 S DIE("NO^")="OUTOK"
 S STATUS=0
 D DEF^PXRMRUTL("811.52",.DEF,.DEF1,.DEF2)
 S NODE="^PXRMD(811.5)"
 D LIST^PXRMREDT(NODE,DA,.DEF1,.LIST)
 D DSPALL^PXRMREDF("T",NODE,DA,.LIST)
 S DA(1)=DA
 S IEN=DA
 S DIC=DIE_DA(1)_",20,"
 S DIC(0)="QEAL"
 S DIC("A")="Select Finding: "
 D ^DIC I Y=-1 S DTOUT=1,TCONT=0 Q
 S DIE=DIC
 S DA=+Y,GLOB=$P($P(Y,U,2),";",2) Q:GLOB=""
 I GLOB="PXRMD(811.4," S CFIEN=$P($P(Y,U,2),";",1) D
 . I $D(^PXRMD(811.4,CFIEN,1))>0 D
 .. W !!,"Computed Finding Description:" S WPIEN=0
 .. F  S WPIEN=$O(^PXRMD(811.4,CFIEN,1,WPIEN)) Q:+WPIEN'>0  D
 ... W !,$G(^PXRMD(811.4,CFIEN,1,WPIEN,0))
 . E  W !!,"No description defined for this computed finding"
 . W !
 I GLOB="YTT(601.71," D WARN^PXRMMH
 W !,"Editing Finding Number: "_$G(DA)
 ;Finding record fields
 S DR=".01;9;12;17"
 I GLOB="PXRMD(811.4," S DR=DR_";26"
 ;Taxonomy - use inactive problems
 I GLOB="PXD(811.2," D
 .S TERMSTAT=$$TAXNODE^PXRMSTA1($P($P(Y,U,2),";"),"H")
 .I TERMSTAT="P" S DR=DR_";10" Q
 .I TERMSTAT'=0 S DR=DR_";10",STATUS=1
 ;Health Factor - within category rank
 I GLOB="AUTTHF(" S DR=DR_";11"
 ;If V file INCLUDE VISIT DATA
 S VF=$S(GLOB["AUTTEDT":1,GLOB["AUTTEXAM":1,GLOB["AUTTHF":1,GLOB["AUTTIMM":1,GLOB="AUTTSK":1,GLOB["PXD(811.2":1,1:0)
 I VF S DR=DR_";28"
 ;Mental Health - scale
 I GLOB="YTT(601.71," S DR=DR_";13"
 ;Radiology procedure
 I GLOB="RAMIS(71," S STATUS=1
 ;Orderable item
 I GLOB="ORD(101.43," S DR=DR_";27",STATUS=1
 ;Rx Type
 I GLOB="PSDRUG("!(GLOB="PS(50.605,")!(GLOB="PSNDF(50.6,") S DR=DR_";16;27",STATUS=1
 ;Condition
 S DR=DR_";14;15;18"
 ;
 ;Edit finding record
 D ^DIE
 I STATUS=1,$D(DA)>0,$D(Y)=0 D STATUS^PXRMSTA1(.DA,"T")
 S $P(^PXRMD(811.5,IEN,20,0),U,3)=0
 Q
 ;
