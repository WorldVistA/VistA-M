ONCPCI ;Hines OIFO/GWB - Patient Identification/Cancer Identification screen display ;06/23/10
 ;;2.11;ONCOLOGY;**15,19,24,26,27,28,33,35,36,42,43,44,45,46,47,49,51**;Mar 07, 1995;Build 65
 ;
PI ;Patient Identification
 K DASH S $P(DASH,"-",80)="-"
 N DI,DIC,DR,DA,DIQ,ONC,TM1,TM2,TM3,DOTS1,DOTS2,DOTS3
 S DIC="^ONCO(165.5,"
 S DR=".03;1.2;2;2.1;2.2;2.3;2.4;8;8.1;8.2;9;10;11;16;18;147"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 F I=.03,1.2,2,2.1,2.2,2.3,2.4,8,8.1,8.2,9,10,11,16,18 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 W !," Reporting Facility...........: ",ONC(165.5,D0,.03)
 W !," Marital Status at Dx.........: ",ONC(165.5,D0,11)
 W !," Patient Address at Dx........: ",ONC(165.5,D0,8)
 W !," Patient Address at Dx - Supp.: ",ONC(165.5,D0,8.2)
 W !," City/town at Dx..............: ",ONC(165.5,D0,8.1)
 W !," State at Dx..................: ",ONC(165.5,D0,16)
 W !," Postal Code at Dx............: ",ONC(165.5,D0,9)
 W !," County at Dx.................: ",ONC(165.5,D0,10)
 W !," Census Tract.................: ",ONC(165.5,D0,147)
 I DATEDX>3061231 D
 .W !," Managing Physician...........: ",ONC(165.5,D0,2.2)
 W !," Following Physician..........: ",ONC(165.5,D0,2.1)
 W !," Primary Surgeon..............: ",ONC(165.5,D0,2)
 W !," Physician #3.................: ",ONC(165.5,D0,2.3)
 W !," Physician #4       ..........: ",ONC(165.5,D0,2.4)
 W !," Primary Payer at Dx..........: ",ONC(165.5,D0,18)
 W !," Type of Reporting Source.....: ",ONC(165.5,D0,1.2)
 W !,DASH
 K DASH,I,X
 Q
 ;
CI ;Cancer Identification
 K DASH S $P(DASH,"-",80)="-"
 N DI,DIC,DR,DA,DIQ,ONC,TM1,TM2,TM3,DOTS1,DOTS2,DOTS3
 S DIC="^ONCO(165.5,"
 S DR=".04;6;7;155;3;28;22;22.1;22.3;24;26;25.1;25.2;25.3;83;623;684;120;121;1010;5;171;172;173;21;96;102;156;159;193;194;195;196;24.1;24.2;233;237;238"
 S DA=D0,DIQ="ONC" D EN^DIQ1
 F I=.04,28,24,25.1,25.2,25.3,26,83,120,623,684,1010,5,21,102,159,194,24.1,24.2,233,237,238 S X=ONC(165.5,D0,I) D UCASE S ONC(165.5,D0,I)=X
 S COC=$E($$GET1^DIQ(165.5,D0,.04,"E"),1,2)
 S TM1=$$PRINT^ONCOTM(D0,1)
 K DOTS1 S $P(DOTS1,".",25-$L(TM1))="."
 S TM2=$$PRINT^ONCOTM(D0,2)
 K DOTS2 S $P(DOTS2,".",25-$L(TM2))="."
 S TM3=$$PRINT^ONCOTM(D0,3)
 K DOTS3 S $P(DOTS3,".",25-$L(TM3))="."
 S TXT=ONC(165.5,D0,.04),LEN=48 D TXT
 W !," Class of Case................: ",TXT1 W:TXT2'="" !,?35,TXT2
 I (COC=10)!(COC=11)!(COC=12)!(COC=13)!(COC=14) D
 .W !," Date of First Symptoms.......: ",ONC(165.5,D0,171)
 .W !," Date Workup Ordered/Started..: ",ONC(165.5,D0,172),"  ",ONC(165.5,D0,173)
 S TXT=ONC(165.5,D0,6),LEN=46 D TXT
 W !," Facility referred from.......: ",TXT1 W:TXT2'="" !,?32,TXT2
 S TXT=ONC(165.5,D0,7),LEN=46 D TXT
 W !," Facility referred to.........: ",TXT1 W:TXT2'="" !,?32,TXT2
 W !," Fee Basis....................: ",ONC(165.5,D0,237)
 W !," Date of First Contact........: ",ONC(165.5,D0,155)
 W !," Date Dx......................: ",ONC(165.5,D0,3)
 I DATEDX>3091231 D
 .W !," Inpatient Status.............: ",ONC(165.5,D0,233)
 I DATEDX>3061231 D
 .W !," Ambiguous Terminology Dx.....: ",ONC(165.5,D0,159)
 .W !," Date of Conclusive Dx........: ",ONC(165.5,D0,193)
 S TXT=ONC(165.5,D0,5),LEN=46 D TXT
 W !," Dx Facility..................: ",TXT1 W:TXT2'="" !,?32,TXT2
 W:ONC(165.5,D0,238)'="" !," Outside Slides Reviewed......: ",ONC(165.5,D0,238)
 S HIST=$$HIST^ONCFUNC(D0,.HSTFLD,.HISTNAM)
 S TXT=ONC(165.5,D0,HSTFLD),LEN=46 D TXT
 W !," Histology/Behavior Code......: ",ONC(165.5,D0,22.1)_" "_TXT1 W:TXT2'="" !,?32,TXT2
 W:$G(TOP)=67619 !," Gleason's Score..............: ",ONC(165.5,D0,623)
 W:$G(TOP)=67619 !," PSA..........................: ",ONC(165.5,D0,96)," ",ONC(165.5,D0,684)
 W:$G(TOP)=67619 !," DRE +/-......................: ",ONC(165.5,D0,156)," ",ONC(165.5,D0,102)
 S TXT=ONC(165.5,D0,28),LEN=46 D TXT
 W !," Laterality...................: ",TXT1 W:TXT2'="" !,?32,TXT2
 W !," Grade/Differentiation........: ",ONC(165.5,D0,24)
 I DATEDX>3091231 D
 .W:ONC(165.5,D0,24.1)'="" !," Grade Path System............: ",ONC(165.5,D0,24.1)
 .W:ONC(165.5,D0,24.2)'="" !," Grade Path Value.............: ",ONC(165.5,D0,24.2)
 I DATEDX>3061231 D
 .W !," Mult Tum Rpt as One Prim.....: ",ONC(165.5,D0,194)
 .W !," Date of Multiple Tumors......: ",ONC(165.5,D0,195)
 .W !," Multiplicity Counter.........: ",ONC(165.5,D0,196)
 W !," AFIP submission..............: ",ONC(165.5,D0,83)
 W !," Diagnostic Confirmation......: ",ONC(165.5,D0,26)
 W:($$GET1^DIQ(165.5,D0,.01,"E")="LIVER")!($G(TOP)=67220) !," Hepatitis C..................: ",ONC(165.5,D0,1010)
 ;I DATEDX<3030000 D
 ;.W !," ",TM1,DOTS1,"....: ",ONC(165.5,D0,25.1)
 ;.W !," ",TM2,DOTS2,"....: ",ONC(165.5,D0,25.2)
 ;.W !," ",TM3,DOTS3,"....: ",ONC(165.5,D0,25.3)
 W !," Presentation at Cancer Conf..: ",ONC(165.5,D0,121)," ",ONC(165.5,D0,120)
 W !," Casefinding Source...........: ",ONC(165.5,D0,21)
 W !,DASH
 K DASH,HIST,HSTFLD,HISTNAM,LEN,LOS,NOP,TXT,TXT1,TXT2,X
 Q
 ;
TXT ;Text formatting
 S (TXT1,TXT2)="",LOS=$L(TXT) I LOS<LEN S TXT1=TXT Q
 S NOP=$L($E(TXT,1,LEN)," ")
 S TXT1=$P(TXT," ",1,NOP-1),TXT2=$P(TXT," ",NOP,999)
 Q
 ;
UCASE ;Mixed case to uppercase conversion
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
 ;
CLEANUP ;Cleanup
 K COC,D0,DATEDX,TOP
