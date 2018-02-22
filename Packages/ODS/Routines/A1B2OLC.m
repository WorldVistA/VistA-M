A1B2OLC ;ALB/MJK - ODS Local Outputs; JAN 13,1991
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
EN D DT^DICRW S X=$T(+1),DIK="^DOPT(""A1B2OLC"","
 G A:$D(^DOPT("A1B2OLC",7))
 S ^DOPT("A1B2OLC",0)="ODS Local Output Options^1N^"
 F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT("A1B2OLC",I,0)=$P(Y,";",3,99)
 D IXALL^DIK
 ;
A W !! S DIC="^DOPT(""A1B2OLC"",",DIC(0)="IQEAM"
 D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;ODS Patient Inquiry
 Q
 ;
2 ;;ODS Inpatient List
 Q
 ;
3 ;;Statistical Summary
 Q
 ;
4 ;;[reserved]
 Q
 ;
5 ;;Admission Date Range List
 W !!,"ODS Admission Date Range Listing",!!
 S L=0,DIC="^A1B2(11500.2,",A1B2FL=11500.2 D DIS^A1B2UTL
 S (FLDS,BY)="[A1B2 OLC ADMIT]",FR=",?",TO=",?"
 D EN1^DIP
Q K %DT,POP,DIS,FLDS,BY,FR,TO,L,DIC,A1B2FL Q
 ;
6 ;;Discharge Date Range List
 W !!,"ODS Discharge Date Range Listing",!!
 S L=0,DIC="^A1B2(11500.2,",A1B2FL=11500.2 D DIS^A1B2UTL
 S (FLDS,BY)="[A1B2 OLC DISCH]",FR=",?",TO=",?"
 D EN1^DIP G Q
 ;
7 ;;Displaced Patient List
 W !!,"Displaced Patient Listing",!!
 S L=0,DIC="^A1B2(11500.3,",A1B2FL=11500.3 D DIS^A1B2UTL
 S FLDS="[A1B2 OLC DISPLACED]",FR=",?",TO=",?",BY="@.02:.02,@.01"
 D EN1^DIP G Q
 ;
8 ;;Registrations w/o Admissions
 W !!,"Registrations w/o Admissions Listing",!!
 S L=0,DIC="^A1B2(11500.4,",A1B2FL=11500.4 D DIS^A1B2UTL
 S BY="@.02:.02,@.01",FR=",?",TO=",?",L=0,FLDS="[A1B2 OLC REGIS]"
 D EN1^DIP G Q
 ;
