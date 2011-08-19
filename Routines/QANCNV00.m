QANCNV00 ;HISC/GJC-Conversion of data from V1.01 to V2.0 ;10/7/92
 ;;2.0;Incident Reporting;**1,2**;08/07/1992
 ;
EN0 ;Check file 513.73 for the existance of data.
 ; *** Variable list ***
 ; EXIST   ---> Boolean, does incident data exist in global 513.72?
 ; QAFLG   ---> Boolean, do we wish to purge converted records?
 ; QAFOUND ---> Boolean, do converted records exist?
 ;
 S QAFOUND=0
 I '$D(^PRMQ(513.72,"E")),('$D(^PRMQ(513.72,"INC"))) S EXIST=0
 E  S EXIST=1
 D:'EXIST DELETE ;Check for converted records, if found, ask to delete.
 I 'EXIST,(QAFOUND),($D(QAFLG)),(QAFLG) D PURGE ;If data does not exist,
 ;and converted records are found, and we wish to purge, do the purge.
 I 'EXIST W !?5,$S(+$G(QAFLG):"Converted records were deleted.",1:"No data to be converted, no action taken.") D EXIT Q  ;With no data to convert, kill variables and quit.
 ;
 ;We know we have data, "E" and "INC" are xrefs on the same field.
 ;Both exist or neither exist.
 ;
 D EXIT S QAFOUND=0,EXIST=1 D DELETE ;Check if old converted records xist.
 Q:$D(DIRUT)!($D(DIROUT))
 I 'QAFOUND D CONVERT,EXIT Q
 I QAFOUND,($D(QAFLG)),(QAFLG) D PURGE,^QANCNV0
 I QAFOUND,($D(QAFLG)),('QAFLG) D DELUTL
EXIT ;Kill and quit.
 K DA,DIK,DIR,EXIST,QA,QACONV,QAFLG,QAFOUND,QB,QC,X,Y
 Q
CONVERT ;Ask for a first time conversion.
 K DIR S DIR(0)="Y",DIR("B")="No",DIR("?")="Enter 'N' for no, 'Y' for yes."
 S DIR("A")="Do you wish to convert old Incident Reporting data"
 D ^DIR K DIR S QACONV=+Y Q:$D(DIRUT)!($D(DIROUT))
 W ! D:'QACONV DELUTL D:QACONV ^QANCNV0
 Q
DELETE ;Check if any converted records exist.
 S QA=""
 F  S QA=$O(^QA(742.4,"B",QA)) Q:QA=""!(QAFOUND)  D
 . S QA("FIRST")=$P(QA,".") Q:QA("FIRST")']""
 . I $E(QA("FIRST"),$L(QA("FIRST")))?1A S QAFOUND=1 D
 .. K DIR S DIR(0)="Y"
 .. S DIR("A")="Do you wish to delete converted data"_$S(EXIST:" and reconvert",1:"")
 .. S DIR("B")="No",DIR("?")="Enter 'N' for no, 'Y' for yes." D ^DIR
 .. K DIR S QAFLG=+Y W !
 .. Q
 . Q
 Q
DELUTL ;Delete utility for IR data in '^PRMQ(513.72'.
 K DIR
 S DIR(0)="Y",DIR("B")="No",DIR("?")="Enter 'N' for no, 'Y' for yes."
 S DIR("A",1)="Are you sure about your decision to delete Incident Reporting"
 S DIR("A")="data from the '^PRMQ(513.72' global" D ^DIR K DIR W !
 Q:+Y'>0
 F QA=0:0 S QA=$O(^PRMQ(513.72,"E",QA)) Q:QA'>0  D
 . F QB=0:0 S QA=$O(^PRMQ(513.72,"E",QA,QB)) Q:QB'>0  D
 .. W !?5,"Deleting data global: ^PRMQ(513.72,"_QB_",0)"
 .. K DA,DIK S DA=QB,DIK="^PRMQ(513.72," D ^DIK K DA,DIK
 .. Q
 . Q
 Q
PURGE ;Delete converted records form files: 742 and 742.4.
 K QA,QB,QC S QA=""
 F  S QA=$O(^QA(742.4,"B",QA)) Q:QA=""  D
 . S QA("FIRST")=$P(QA,".") Q:QA("FIRST")']""
 . Q:$E(QA("FIRST"),$L(QA("FIRST")))'?1A  ;Quit if not converted.
 . F QB=0:0 S QB=$O(^QA(742.4,"B",QA,QB)) Q:QB'>0  D
 .. N QA F QC=0:0 S QC=$O(^QA(742,"BCS",QB,QC)) Q:QC'>0  D
 ... W !!,"Killing data global ^QA(742,"_QC_",0)"
 ... K DA,DIK S DA=QC,DIK="^QA(742," D ^DIK K DA,DIK
 ... W !,"Killing data global ^QA(742.4,"_QB_",0)"
 ... K DA,DIK S DA=QB,DIK="^QA(742.4," D ^DIK K DA,DIK
 ... K:$D(^QA(742.4,"ACN",QC,QB)) ^QA(742.4,"ACN",QC,QB)
 ... I $D(^QA(740.5,"AA",742,QC))\10 S DA=+$O(^QA(740.5,"AA",742,QC,0))
 ... I  S DIK="^QA(740.5," W:DA>0 !,"Deleting the QA Audit file entry: ^QA(740.5,"_DA_",0)" D:DA>0 ^DIK K DA,DIK
 ... I $D(^QA(740.5,"AA",742.4,QB))\10 S DA=+$O(^QA(740.5,"AA",742.4,QB,0))
 ... I  S DIK="^QA(740.5," W:DA>0 !,"Deleting the QA Audit file entry: ^QA(740.5,"_DA_",0)" D:DA>0 ^DIK K DA,DIK
 ... Q
 .. Q
 . Q
 Q
