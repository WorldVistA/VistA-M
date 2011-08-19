QACARCH ;HISC/CEW - Routine to archive selected records ;1/17/95  11:19
 ;;2.0;Patient Representative;**9**;07/25/1995
INFO ;
 W !!?5,"Using this option does not purge the records archived."
 W !?5,"At the device prompt, save the output to a file,"
 W !?5,"capture the output for a word processing package,"
 W !?5,"or send it to a printer for a hard copy report."
 ;
MAIN ;
 S QAQPOP=0
 D DATDIV^QACUTL0 G:QAQPOP EXIT
 K DIC,FLDS,L,BY,FR,TO,DHD
 S L=0,DIC="^QA(745.1,"
 S FLDS="1;S2,.01,2,3,22;C1,21,.01;L65,,25;C1",DHD="@@"
 S DIOBEG="W !!,""Archived Patient Rep Contact Records"",!,QAQ2HED"
 ;
 ; report is not by division
 I +$G(QACDV)'=1 D
 . S BY="1"
 . S FR(1)=QAQNBEG,TO(1)=QAQNEND
 ;
 ; report is by division
 I +$G(QACDV)=1 D
 . S BY="37;S3;C25,1"
 . S FR(1)="@",TO(1)=""
 . I +$G(QAC1DIV) D
 . . S QACDVNAM="" D INST^QACUTL0(QAC1DIV,.QACDVNAM)
 . . S (FR(1),TO(1))=QACDVNAM
 . S FR(2)=QAQNBEG,TO(2)=QAQNEND
 D EN1^DIP
EXIT ;
 K DIC,FLDS,L,BY,FR,TO,DHD,DIP,DIOBEG,QACDV,QAC1DIV,QAQPOP,QACDVNAM
 K QAQNBEG,QAQNEND
 D K^QAQDATE
 Q
