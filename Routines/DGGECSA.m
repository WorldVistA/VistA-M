DGGECSA ;ALB/RMO - Auto Generate Code Sheets for MAS AMIS(s) ; 13 AUG 90 8:52 am
 ;;5.3;Registration;;Aug 13, 1993
 ;==============================================================
 ;Entry Points:
 ; ASK     -Prompt user to generate AMIS code sheets
 ; QUE     -Queue generation of AMIS code sheet to default printer
 ;==============================================================
ASK ;Prompt user to generate AMIS code sheets
 ; Input  -- None Required
 ; Output -- %=1  user entered 'YES'
 ;           %=2  user entered 'NO'
 ;           %<0  user timeout or entered an '^'
 S %=0,DGCODPRT=$S($D(^DG(43,1,0)):$P(^(0),"^",25),1:"") G Q:DGCODPRT=""
 W !!,"Do you wish to generate code sheets if segments are balanced" S %=2 D YN^DICN G Q:%<0 I '% W !!?3,"Enter 'YES' to generate code sheets, or 'NO' not to." G ASK
 I %=1 W !!?3,"NOTE: AMIS Code Sheets will be queued to print on ",DGCODPRT,"."
Q K DGCODPRT Q
 ;
QUE ;Queue generation of AMIS code sheet to default MAS code sheet printer
 ; Input --  DGSEG   Segment Number ie, 334
 ;           DGDIV   Medical Ctr Div File (#40.8) IFN ie, 1
 ;           DGMYR   Month/Year in internal date format ie, 2900200
 ; Output -- Task is Queued to Generate a Code Sheet
 S ZTRTN="START^DGGECSA",ZTDTH=$H,ZTSAVE("DGTTF")=DGSEG,ZTSAVE("DGDIV")=DGDIV,ZTSAVE("DGMYR")=DGMYR
 S ZTDESC="GENERATE AMIS CODE SHEET"
 S ZTIO=$S($D(^DG(43,1,0)):$P(^(0),"^",25),1:"") D ^%ZTLOAD:ZTIO'=""
 K ZTSK,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTDESC
 Q
 ;
START ;Auto generation of AMIS code sheet
 U IO Q:'$D(DGTTF)!('$D(DGDIV))!('$D(DGMYR))
 S SDABORT=0,DGSTR="",DGSTA=$S('$D(^DG(40.8,+DGDIV,0)):0,$P(^(0),"^",2)'="":$P(^(0),"^",2),$D(^DIC(4,+$P(^(0),"^",7),99)):$P(^(99),"^",1),1:0)
 I DGTTF'>399 D BLD^DGGECS,GEN^DGGECS:'SDABORT
 I DGTTF>399 F I=401:1:420 S DGAMS(I)=""
 I DGTTF>399 D START^DGGECS
 K DGSTA,DGSTR,DGTTF,SDABORT,I,DGAMS
 Q
